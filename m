Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31323EF781
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 03:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhHRB1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 21:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234828AbhHRB1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 21:27:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B155E601FD;
        Wed, 18 Aug 2021 01:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629250038;
        bh=J339FJDjO6ozWy303tefLXzSQOWCQo4VyW6f5odI+Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZNMRW0dU7sN3icQ8C0o6MSpwtUgAOiZUHD9yTvjhtrUrJ59qfigEOOc9ZqQDHhzq
         rFJTbRnGuItEla7QiKC7DvNAxukO0VQVfVHwcyaGyJ3Lq+Bc1As4duT48APsb1JR5d
         dpPt1IewyVGMh+NQWOtrdy/VfKBIBT5iv1/zTA7/3ZqNmpOKmSf4Ov3Gq2q3z7/+qB
         vkAFh43nwFu4dni9g3Q532PEzct6HzAYCmBdoKp+GP1QGuYFkjRLA3zt+Y/Vr1Tt/X
         yPT6uDCzLs55x7QCAm5S2n2XubMvHbuQr1OElIRpI4xxtWNMoWl3wzePmwJOGHY8aJ
         KFoblrnK9Q0Mw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/2] ALSA: hda/analog - Sink ad198x_shutup() and shuffle CONFIG_PM guards
Date:   Tue, 17 Aug 2021 18:27:05 -0700
Message-Id: <20210818012705.311963-2-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210818012705.311963-1-nathan@kernel.org>
References: <20210818012705.311963-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM is not set, there is an unused function warning:

sound/pci/hda/patch_analog.c:115:13: warning: unused function
'ad198x_shutup' [-Wunused-function]
static void ad198x_shutup(struct hda_codec *codec)
            ^
1 warning generated.

Sink ad198x_shutup() into ad198x_suspend(), as it is only called in that
one space. Move the CONFIG_PM guards above ad198x_power_eapd_write() as
it is only called in ad198x_power_eapd(), which is in turn only called
in ad198x_power_eapd(). Those two functions are large enough that they
are left alone.

Fixes: 327b34f2a97d ("ALSA: hda: Nuke unused reboot_notify callback")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/pci/hda/patch_analog.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index a356e1662929..8afe6000f7da 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -72,7 +72,7 @@ static int create_beep_ctls(struct hda_codec *codec)
 #define create_beep_ctls(codec)		0
 #endif
 
-
+#ifdef CONFIG_PM
 static void ad198x_power_eapd_write(struct hda_codec *codec, hda_nid_t front,
 				hda_nid_t hp)
 {
@@ -112,16 +112,10 @@ static void ad198x_power_eapd(struct hda_codec *codec)
 	}
 }
 
-static void ad198x_shutup(struct hda_codec *codec)
+static int ad198x_suspend(struct hda_codec *codec)
 {
 	snd_hda_shutup_pins(codec);
 	ad198x_power_eapd(codec);
-}
-
-#ifdef CONFIG_PM
-static int ad198x_suspend(struct hda_codec *codec)
-{
-	ad198x_shutup(codec);
 	return 0;
 }
 #endif
-- 
2.33.0

