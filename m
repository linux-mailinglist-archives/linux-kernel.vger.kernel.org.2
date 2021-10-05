Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4601423114
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhJETyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 15:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbhJETyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:54:07 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D5C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 12:52:17 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so173702pgi.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GYjYv2lfViakCsNns4R+hOdMsK5mYgMHQz2UmonsX7M=;
        b=PKz1dvFaJD2xCDaBdwJfFiZi8oyGPOIKssYrKOpxNITyFzraZ1WYs2xvsYUFTw1e8r
         Xy1bsAW0ffhZtlmysuIIT9PxZw5lkr7g52epTgKZrddJfsGYP+XW9OiVlIetOqKpQXTr
         7uiS+2XzBQwWEN0NSOf6vjNiYYLY0jPKC+26y3c/cRFXf8uCnoGDS1A6Z+KkaRStw9T/
         lk9xM7WIAzM2C0VTEgx4ifnEbad3fHd5XD/enn9BhwTzJ4eLieC1R2WE1zjL1UJuuHV6
         /cvJ9igeUz8SAMQlvYFEplGPxhY+jmm/1KoQ5kFUJzvzH0w5k/doo9wFfKwczL+/M5AA
         0knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GYjYv2lfViakCsNns4R+hOdMsK5mYgMHQz2UmonsX7M=;
        b=UCmlDXkSTxuidCv71ct7depYnp7p2wjN3bw0p5oVHiyapyEzafh9KiZ55pwIHvMRHy
         7pjmveXdzB2DIPs8LIWg3wrXMdhSlA8YmS5PjSG7Iwy7Q8zvxGbz4+gkliPMfM87bAiH
         GKkwv4IbJ6yPRmnTSbCf18Ja4ffvRcrxhjpgMXHVKgEnXu2t7P2UkxXJjQZ6SXzlQc0d
         ezqXbBhXVlQq4n/IygtybFytZw69c7Dp8EVqPXlud+qoD0Pip3deT3EZb66QWJCKoUDu
         FX0mBn9mq/wSZ38yWRE/+JrolwoMrs0teYbRR75bYiaTxp8IlbVuRPjaK5fxoc91m3mG
         pQ3A==
X-Gm-Message-State: AOAM533dkUlnIcdofzceyOSDyxsf61OHZ17plFj6a/qOequYwe22doxd
        pCEzcLgE02MFO8brcVt4x3bYPnE820k=
X-Google-Smtp-Source: ABdhPJyrR9Hxve8OLbSqYgFTqbgqERpjWe3edUJF1XZdKQtwmUzRab2fiP4NQrKcojdkvyjTo3aEAGlNVwE=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:b603:db5:e90f:74aa])
 (user=pgonda job=sendgmr) by 2002:a17:902:6f01:b0:138:9aca:efda with SMTP id
 w1-20020a1709026f0100b001389acaefdamr7064594plk.19.1633463536550; Tue, 05 Oct
 2021 12:52:16 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:52:13 -0700
Message-Id: <20211005195213.2905030-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] crypto: ccp - Consolidate sev INIT logic
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Rientjes <rientjes@google.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds new helper function sev_init_if_required() for use in sev_ioctl().
The function calls __sev_platform_init_locked() if the command requires
the PSP's internal state be at least SEV_STATE_INIT. This consolidates
many checks scattered through out the ioctl delegation functions.

Signed-off-by: Peter Gonda <pgonda@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/ccp/sev-dev.c | 63 +++++++++++++++---------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e09925d86bf3..071d57fec4c4 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -386,24 +386,14 @@ static int sev_ioctl_do_platform_status(struct sev_issue_cmd *argp)
 
 static int sev_ioctl_do_pek_pdh_gen(int cmd, struct sev_issue_cmd *argp, bool writable)
 {
-	struct sev_device *sev = psp_master->sev_data;
-	int rc;
-
 	if (!writable)
 		return -EPERM;
 
-	if (sev->state == SEV_STATE_UNINIT) {
-		rc = __sev_platform_init_locked(&argp->error);
-		if (rc)
-			return rc;
-	}
-
 	return __sev_do_cmd_locked(cmd, NULL, &argp->error);
 }
 
 static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
 {
-	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_pek_csr input;
 	struct sev_data_pek_csr data;
 	void __user *input_address;
@@ -435,12 +425,6 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
 	data.len = input.length;
 
 cmd:
-	if (sev->state == SEV_STATE_UNINIT) {
-		ret = __sev_platform_init_locked(&argp->error);
-		if (ret)
-			goto e_free_blob;
-	}
-
 	ret = __sev_do_cmd_locked(SEV_CMD_PEK_CSR, &data, &argp->error);
 
 	 /* If we query the CSR length, FW responded with expected data. */
@@ -586,7 +570,6 @@ static int sev_update_firmware(struct device *dev)
 
 static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
 {
-	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_pek_cert_import input;
 	struct sev_data_pek_cert_import data;
 	void *pek_blob, *oca_blob;
@@ -617,17 +600,10 @@ static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
 	data.oca_cert_address = __psp_pa(oca_blob);
 	data.oca_cert_len = input.oca_cert_len;
 
-	/* If platform is not in INIT state then transition it to INIT */
-	if (sev->state != SEV_STATE_INIT) {
-		ret = __sev_platform_init_locked(&argp->error);
-		if (ret)
-			goto e_free_oca;
-	}
-
 	ret = __sev_do_cmd_locked(SEV_CMD_PEK_CERT_IMPORT, &data, &argp->error);
 
-e_free_oca:
 	kfree(oca_blob);
+
 e_free_pek:
 	kfree(pek_blob);
 	return ret;
@@ -730,7 +706,6 @@ static int sev_ioctl_do_get_id(struct sev_issue_cmd *argp)
 
 static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 {
-	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_pdh_cert_export input;
 	void *pdh_blob = NULL, *cert_blob = NULL;
 	struct sev_data_pdh_cert_export data;
@@ -738,16 +713,6 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 	void __user *input_pdh_cert_address;
 	int ret;
 
-	/* If platform is not in INIT state then transition it to INIT. */
-	if (sev->state != SEV_STATE_INIT) {
-		if (!writable)
-			return -EPERM;
-
-		ret = __sev_platform_init_locked(&argp->error);
-		if (ret)
-			return ret;
-	}
-
 	if (copy_from_user(&input, (void __user *)argp->data, sizeof(input)))
 		return -EFAULT;
 
@@ -819,6 +784,26 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 	return ret;
 }
 
+static int sev_init_if_required(int cmd_id, bool writable,
+				struct sev_issue_cmd *argp)
+{
+	struct sev_device *sev = psp_master->sev_data;
+
+	lockdep_assert_held(&sev_cmd_mutex);
+
+	if (!writable)
+		return -EPERM;
+
+	if (cmd_id == SEV_FACTORY_RESET || cmd_id == SEV_PLATFORM_STATUS ||
+	    cmd_id == SEV_GET_ID || cmd_id == SEV_GET_ID2)
+		return 0;
+
+	if (sev->state == SEV_STATE_UNINIT)
+		return __sev_platform_init_locked(&argp->error);
+
+	return 0;
+}
+
 static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -840,8 +825,11 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 
 	mutex_lock(&sev_cmd_mutex);
 
-	switch (input.cmd) {
+	ret = sev_init_if_required(input.cmd, writable, &input);
+	if (ret)
+		goto copy_out;
 
+	switch (input.cmd) {
 	case SEV_FACTORY_RESET:
 		ret = sev_ioctl_do_reset(&input, writable);
 		break;
@@ -875,6 +863,7 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 		goto out;
 	}
 
+copy_out:
 	if (copy_to_user(argp, &input, sizeof(struct sev_issue_cmd)))
 		ret = -EFAULT;
 out:
-- 
2.33.0.800.g4c38ced690-goog

