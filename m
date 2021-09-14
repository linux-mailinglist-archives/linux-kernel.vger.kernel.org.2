Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCD240B2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhINPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:14:56 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:43294 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234399AbhINPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:14:48 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 18EFAihW031441;
        Tue, 14 Sep 2021 18:10:44 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 35E6463A19; Tue, 14 Sep 2021 18:10:55 +0300 (IDT)
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
Subject: [PATCH v15 1/6] tpm_tis: Fix expected bit handling and send all bytes in one shot without last byte in exception
Date:   Tue, 14 Sep 2021 18:10:27 +0300
Message-Id: <20210914151032.216122-2-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20210914151032.216122-1-amirmizi6@gmail.com>
References: <20210914151032.216122-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Detected an incorrect implementation of the send command.
Currently, the driver polls the TPM_STS.stsValid field until TRUE; then it
reads TPM_STS register again to verify only that TPM_STS.expect field is
FALSE (i.e., it ignores TPM_STS.stsValid).
Since TPM_STS.stsValid represents the TPM_STS.expect validity, both fields
fields should be checked in the same TPM_STS register read value.

Modify the signature of 'wait_for_tpm_stat()', add an additional
"mask_result" parameter to its call and rename it to
'tpm_tis_wait_for_stat()' for better alignment with other naming.
'tpm_tis_wait_for_stat()' is now polling the TPM_STS with a mask and waits
for the value in mask_result. Add the ability to check if certain TPM_STS
bits have been cleared.

In addition, the send command was changed to comply with
TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf as follows:
- send all command bytes in one loop
- remove special handling of the last byte

Suggested-by: Benoit Houyere <benoit.houyere@st.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 68 +++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 43 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 69579ef..7d5854b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -44,9 +44,9 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 	return false;
 }
 
-static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
-		unsigned long timeout, wait_queue_head_t *queue,
-		bool check_cancel)
+static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, u8 stat,
+				 unsigned long timeout,
+				 wait_queue_head_t *queue, bool check_cancel)
 {
 	unsigned long stop;
 	long rc;
@@ -55,7 +55,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 
 	/* check current status */
 	status = chip->ops->status(chip);
-	if ((status & mask) == mask)
+	if ((status & mask) == stat)
 		return 0;
 
 	stop = jiffies + timeout;
@@ -83,7 +83,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 			usleep_range(TPM_TIMEOUT_USECS_MIN,
 				     TPM_TIMEOUT_USECS_MAX);
 			status = chip->ops->status(chip);
-			if ((status & mask) == mask)
+			if ((status & mask) == stat)
 				return 0;
 		} while (time_before(jiffies, stop));
 	}
@@ -260,9 +260,10 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 
 	while (size < count) {
 		rc = wait_for_tpm_stat(chip,
-				 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-				 chip->timeout_c,
-				 &priv->read_queue, true);
+					   TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+					   TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+					   chip->timeout_c, &priv->read_queue,
+					   true);
 		if (rc < 0)
 			return rc;
 		burstcnt = get_burstcount(chip);
@@ -315,8 +316,9 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-				&priv->int_queue, false) < 0) {
+	if (wait_for_tpm_stat(chip, TPM_STS_VALID, TPM_STS_VALID,
+				  chip->timeout_c, &priv->int_queue,
+				  false) < 0) {
 		size = -ETIME;
 		goto out;
 	}
@@ -342,61 +344,40 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc, status, burstcnt;
 	size_t count = 0;
-	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
 
 	status = tpm_tis_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
 		tpm_tis_ready(chip);
-		if (wait_for_tpm_stat
-		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
-		     &priv->int_queue, false) < 0) {
+		if (wait_for_tpm_stat(chip, TPM_STS_COMMAND_READY,
+					  TPM_STS_COMMAND_READY,
+					  chip->timeout_b, &priv->int_queue,
+					  false) < 0) {
 			rc = -ETIME;
 			goto out_err;
 		}
 	}
 
-	while (count < len - 1) {
+	while (count < len) {
 		burstcnt = get_burstcount(chip);
 		if (burstcnt < 0) {
 			dev_err(&chip->dev, "Unable to read burstcount\n");
 			rc = burstcnt;
 			goto out_err;
 		}
-		burstcnt = min_t(int, burstcnt, len - count - 1);
+		burstcnt = min_t(int, burstcnt, len - count);
 		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
 					 burstcnt, buf + count);
 		if (rc < 0)
 			goto out_err;
 
 		count += burstcnt;
-
-		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-					&priv->int_queue, false) < 0) {
-			rc = -ETIME;
-			goto out_err;
-		}
-		status = tpm_tis_status(chip);
-		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
-			rc = -EIO;
-			goto out_err;
-		}
 	}
-
-	/* write last byte */
-	rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality), buf[count]);
-	if (rc < 0)
-		goto out_err;
-
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-				&priv->int_queue, false) < 0) {
+	if (wait_for_tpm_stat(chip, TPM_STS_VALID | TPM_STS_DATA_EXPECT,
+				  TPM_STS_VALID, chip->timeout_a,
+				  &priv->int_queue, false) < 0) {
 		rc = -ETIME;
 		goto out_err;
 	}
-	status = tpm_tis_status(chip);
-	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
-		rc = -EIO;
-		goto out_err;
-	}
 
 	return 0;
 
@@ -451,9 +432,10 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 
 		dur = tpm_calc_ordinal_duration(chip, ordinal);
-		if (wait_for_tpm_stat
-		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
-		     &priv->read_queue, false) < 0) {
+		if (wait_for_tpm_stat(chip,
+					  TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+					  TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+					  dur, &priv->read_queue, false) < 0) {
 			rc = -ETIME;
 			goto out_err;
 		}
-- 
2.7.4

