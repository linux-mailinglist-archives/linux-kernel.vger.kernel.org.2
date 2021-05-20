Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF831389FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhETIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:35:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58421 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhETIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:35:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lje8P-00027g-0B; Thu, 20 May 2021 08:34:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: firewire-lib: Fix uninitialized variable err issue
Date:   Thu, 20 May 2021 09:34:24 +0100
Message-Id: <20210520083424.6685-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently in the case where the payload_length is less than the
cip_header_size the error return variable err is not being set
and function parse_ir_ctx_header can return an uninitialized
error return value. Fix this by setting err to zero.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: c09010eeb373 ("ALSA: firewire-lib: handle the case that empty isochronous packet payload for CIP")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/firewire/amdtp-stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index af5c3629f1ac..242b1147d768 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -663,6 +663,7 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 		} else {
 			// Handle the cycle so that empty packet arrives.
 			cip_header = NULL;
+			err = 0;
 			*data_blocks = 0;
 			*syt = 0;
 		}
-- 
2.31.1

