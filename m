Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C0A38FFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhEYLP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:15:29 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:60798 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230239AbhEYLPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:15:22 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 14PBDeeH004244;
        Tue, 25 May 2021 14:13:40 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 4195763A1B; Tue, 25 May 2021 14:13:47 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v4] tpm2: add longer timeout for verify signature command
Date:   Tue, 25 May 2021 14:13:25 +0300
Message-Id: <20210525111325.158790-2-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20210525111325.158790-1-amirmizi6@gmail.com>
References: <20210525111325.158790-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

While running a TPM2_CC_VERIFY_SIGNATURE operation with RSA 3072-bit
keys the TPM driver fails with the following error:

"kernel: [ 2416.187522] tpm tpm0: Operation Timed out"

Since the TPM PC Client specification does not specify a number for
verify signature operation timeout, and the duration of
TPM2_CC_VERIFY_SIGNATURE with RSA 3072-bit keys exceeds the current timeout
of TPM_LONG (2 seconds), it is preferable to pick the longest timeout
possible.

Therefore, set the duration for TPM2_CC_VERIFY_SIGNATUE to TPM_LONG_LONG
(5 minutes).

Link: https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 7603295..e71154b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -87,7 +87,7 @@ static u8 tpm2_ordinal_duration_index(u32 ordinal)
 		return TPM_MEDIUM;
 
 	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
-		return TPM_LONG;
+		return TPM_LONG_LONG;
 
 	case TPM2_CC_PCR_EXTEND:              /* 182 */
 		return TPM_MEDIUM;
-- 
2.7.4

