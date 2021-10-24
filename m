Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B2438ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 18:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhJXQyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 12:54:46 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:46220 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230435AbhJXQym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 12:54:42 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 19OGn5k2004309;
        Sun, 24 Oct 2021 19:49:05 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 875DA63A1E; Sun, 24 Oct 2021 19:49:16 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v17 2/6] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
Date:   Sun, 24 Oct 2021 19:48:51 +0300
Message-Id: <20211024164855.250362-3-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20211024164855.250362-1-amirmizi6@gmail.com>
References: <20211024164855.250362-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

tpm_tis_req_canceled() function is used to check if the caller requested
to abort the current operation. It was found that in some cases
tpm_tis_req_canceled() wrongly returned true.
Since a cancel request sets the TPM_STS.commandReady field to TRUE, the
tpm_tis_req_canceled() function should check only the TPM_STS.commandReady
field value.
The case for TPM_VID_WINBOND is wrong and was therefore removed.

Also, the default comparison is wrong. Only cmdReady bit needs to be
compared instead of the full lower status register byte.

Fixes: 1f866057291f ("tpm: Fix cancellation of TPM commands (polling mode)")
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 98de2fd..e1c4a5a 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -661,13 +661,11 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	switch (priv->manufacturer_id) {
-	case TPM_VID_WINBOND:
-		return ((status == TPM_STS_VALID) ||
-			(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
 	case TPM_VID_STM:
 		return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
 	default:
-		return (status == TPM_STS_COMMAND_READY);
+		return ((status & TPM_STS_COMMAND_READY) ==
+			TPM_STS_COMMAND_READY);
 	}
 }
 
-- 
2.7.4

