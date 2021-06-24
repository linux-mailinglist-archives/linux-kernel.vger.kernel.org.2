Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82FE3B388C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhFXVYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhFXVYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:24:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9BE26124C;
        Thu, 24 Jun 2021 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624569715;
        bh=MwO9BW7F8u85dyg2TGOKlZ7UI2TnjRUjqM503pSN/24=;
        h=From:To:Cc:Subject:Date:From;
        b=iLKW7DKEl64x9Qf5HTpK0uOhrMreIq66X1U0KB1JW5RidFei/4dBZDlUgPODgLyCv
         yuAu85JVo+Lj8EvJFKYegTScQaTVnNwDGYjP4V4k8Wj1lgRmQYyliDlU34iucl9TEw
         4LhLZi0/lDh4JpKSX6k71QTt+s58rsNj623KCUfhuyvmDGc2auEMfk8DaiDAalEVav
         Hj3EjnhsmGiFkhhOmnVjgDH2NHtAJxLzaegeZNHuuxXEn1GF4itnXQAksVgnfePILf
         UiP4LmGXYALrcd6akuhhQWxbd9Fey9WX9f2w5TDC2c88z/1bJo4eDJ0rtGO1+Uas9M
         ac7xjlOKQ2oxg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] ALSA: usb-audio: scarlett2: Fix for loop increment in scarlett2_usb_get_config
Date:   Thu, 24 Jun 2021 14:20:48 -0700
Message-Id: <20210624212048.1356136-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

sound/usb/mixer_scarlett_gen2.c:1189:32: warning: expression result
unused [-Wunused-value]
                        for (i = 0; i < count; i++, (u16 *)buf++)
                                                    ^      ~~~~~
1 warning generated.

It appears the intention was to cast the void pointer to a u16 pointer
so that the data could be iterated through like an array of u16 values.
However, the cast happens after the increment because a cast is an
rvalue, whereas the post-increment operator only works on lvalues, so
the loop does not iterate as expected.

Replace the post-increment shorthand with the full expression so the
cast can be added in the right place and the look works as expected.

Fixes: ac34df733d2d ("ALSA: usb-audio: scarlett2: Update get_config to do endian conversion")
Link: https://github.com/ClangBuiltLinux/linux/issues/1408
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index fcba682cd422..c20c7f1ddc50 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1186,7 +1186,7 @@ static int scarlett2_usb_get_config(
 		if (err < 0)
 			return err;
 		if (size == 2)
-			for (i = 0; i < count; i++, (u16 *)buf++)
+			for (i = 0; i < count; i++, buf = (u16 *)buf + 1)
 				*(u16 *)buf = le16_to_cpu(*(__le16 *)buf);
 		return 0;
 	}

base-commit: 5c89c2c7fbfa9124dd521c375b9c82b9ed75bc28
-- 
2.32.0.93.g670b81a890

