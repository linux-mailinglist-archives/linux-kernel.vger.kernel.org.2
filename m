Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27258326AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 01:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhB0AQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 19:16:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35176 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhB0AQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 19:16:25 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lFnGZ-0004dU-Sc; Sat, 27 Feb 2021 00:15:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Wai Yew CHAY <wychay@ctl.creative.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ctxfi: cthw20k2: fix mask on conf to allow 4 bits
Date:   Sat, 27 Feb 2021 00:15:27 +0000
Message-Id: <20210227001527.1077484-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the mask operation on variable conf is just 3 bits so
the switch statement case value of 8 is unreachable dead code.
The function daio_mgr_dao_init can be passed a 4 bit value,
function dao_rsc_init calls it with conf set to:

     conf = (desc->msr & 0x7) | (desc->passthru << 3);

so clearly when desc->passthru is set to 1 then conf can be
at least 8.

Fix this by changing the mask to 0xf.

Fixes: 8cc72361481f ("ALSA: SB X-Fi driver merge")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/ctxfi/cthw20k2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index a855fb8c58bd..55af8ef29838 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -991,7 +991,7 @@ static int daio_mgr_dao_init(void *blk, unsigned int idx, unsigned int conf)
 
 	if (idx < 4) {
 		/* S/PDIF output */
-		switch ((conf & 0x7)) {
+		switch ((conf & 0xf)) {
 		case 1:
 			set_field(&ctl->txctl[idx], ATXCTL_NUC, 0);
 			break;
-- 
2.30.0

