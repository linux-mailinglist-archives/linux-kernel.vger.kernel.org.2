Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8543A82AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFOOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:25:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33836 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhFOOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:23:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lt9vt-0003Rp-3k; Tue, 15 Jun 2021 14:20:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: bebob: Fix bit flag quirk constants
Date:   Tue, 15 Jun 2021 15:20:48 +0100
Message-Id: <20210615142048.59900-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The quirking bit-flags are currently set as contiguous integer enum values
and so currently SND_BEBOB_QUIRK_INITIAL_DISCONTINUOUS_DBC is zero and so
he quirking never getting set or tested correctly for this quirk. Fix this
by setting the quirking constants as shifted bit values.

Addresses-Coverity: ("Bitwise-and with zero")
Fixes: 93cd12d6e88a ("ALSA: bebob: code refactoring for model-dependent quirks")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/firewire/bebob/bebob.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index c06579d9380e..4d73ecb30d79 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -76,8 +76,8 @@ struct snd_bebob_spec {
 };
 
 enum snd_bebob_quirk {
-	SND_BEBOB_QUIRK_INITIAL_DISCONTINUOUS_DBC,
-	SND_BEBOB_QUIRK_WRONG_DBC,
+	SND_BEBOB_QUIRK_INITIAL_DISCONTINUOUS_DBC = (1 << 0),
+	SND_BEBOB_QUIRK_WRONG_DBC		  = (1 << 1),
 };
 
 struct snd_bebob {
-- 
2.31.1

