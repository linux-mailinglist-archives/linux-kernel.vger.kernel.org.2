Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF23AA61E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhFPV0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 17:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhFPV0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:26:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C349DC061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 14:24:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x19so1807906pln.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9mDyJNpxbZfKyy7RtdpAqA//mXzySL5siK4qAwgwZIk=;
        b=izOVrfiCFy5yXKYpXtpnr4vn5qUA54GYaW3dFSDuO45uysQJhGevfiWYuKG84AAWHD
         u7sLGbp2cez+EL4jXeOgGXFLvQQlTCrwHJ4/8P+QEXKmnlQpIfnOKCcTJrSTwHZpYWCJ
         WKKiAQWKKBRH94SSqISwtIFIIzndkB9QoNtJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9mDyJNpxbZfKyy7RtdpAqA//mXzySL5siK4qAwgwZIk=;
        b=pCPmj7VAN+Y9PjT0UrVe3FN8BKV56nvoCRjqyEpHC24dLHXviymDmVMCrgtJsZKqXs
         b/vf+2XK+C0Cq1SmwkV82EOSAns8ovKhjaMruWckY4qaZ8LxzKdM9K6ImILYy9cuF0RV
         6b6cCMFRgfSjglVHJZHGONQnLokVSAavU31Fjun0wsRHV+SjRnYleQmNVJ1PMURTmEyJ
         AIQ0yDvrUxgRQBVKKT+c12EIX5n+eIYxUXW5x2i7YI9I7A8PJmf3U8lL1WpqVvYvLdtS
         Ak8yXgKVm6h9LLceOhurFwVZj5QTAsh0/P/JDgKYZkt/wqZQPbXfOkPgocLLP6yb67L6
         Cpng==
X-Gm-Message-State: AOAM532kkQOess9B+4ozV0zNyO4aUTYuLRz3HNmCMzuWORhBl/h/9xgU
        OCha+J8ryzYZXvGD21iR3IgVqA==
X-Google-Smtp-Source: ABdhPJzWgbUO/DROse1VxvCqkTvtvbZSA5ccSz5dS1WbgeocQY9RqQ8kb79LUxQhw4YCtZlFKWDb8Q==
X-Received: by 2002:a17:90a:fa95:: with SMTP id cu21mr13343910pjb.210.1623878670409;
        Wed, 16 Jun 2021 14:24:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u24sm3187435pfm.200.2021.06.16.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 14:24:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        ching Huang <ching2048@areca.com.tw>,
        Lee Jones <lee.jones@linaro.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: arcmsr: Avoid over-read of sense buffer
Date:   Wed, 16 Jun 2021 14:24:28 -0700
Message-Id: <20210616212428.1726958-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=12ed5885832168ac14ef9d3722ea1bd91ad6bb7c; i=2z1//uxp9rUj226I5jPh8KIjFeGXZ/Z/KUn+4dJoIrk=; m=ewGeyeGy7NM7Qc6xwxoHI0OCT1XLIzmKnYd7SQTiTDg=; p=HZI7Hnd35kAuEhHOejcPJrLHn4tX4nSDWqv1THKws+A=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKbAsACgkQiXL039xtwCZlyRAAi1H Tb1C6RfeYcTEMMhBw3GV9qK5v94F64hR+oVRXtTAEYtnrPjbJFVqHd2XLB4PAEv9WxNl+miI7cCoR XiWMvM1GEzBPTGPDrWhR/sf7yELMrxpEmd7AKrLpGWWccvtYPPnLBXtyJpO98Js0ft35/YjIXKpT5 /9dUmOVpXUndSXXHSpag418H1tLkFjk4MM6Irgm0kbeQBfH6vR+uESbgPOc6w0NHwm2otOV2zZm9Y RYhEo4Q09/Lcqu/1xfPhK7jp3lKqnsOwurepulFdMZH1uG0kPOo4W1J1Bm3RnYN9DAt8Bqv55ULVL 0xNIiX1UgydkJ4oXL2rwKmA80MXz6KDWK8JQURJhKH+FuHccmb5ySQM8m9ag5KJbMCgu6oEPzvVQS aB+z8RUvswqxfcQmhyU7W7RBuavPSL3/EtITOcMF2Xu24f9DHCv0IaK6yPAXiTAfG/2kaRm3AYy4J 9vngWMW+05/XvDWg8QCHTXPAMSlS/Nsl9y3bYCI5QzNeEX7s4/ZBv+lKjcbF55Q1eZusrUhFW8yJL P44eb21xy+Y6wW/O5eDjPq7j7SJw6+8gDVa+narBMFTUb6p1Gcc6L1EtogVvItMzR8IToH0N4+0SV DNEqZold6LY2/2cYcSw6WrmUwsJ0sOld/HGksdifTR1sDVZHHoGHPjiafB7rK3po=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally reading across neighboring array fields.

pcmd->sense_buffer is 96 bytes, and was being manually zero-filled.
However, struct SENSE_DATA is 18 bytes, with ccb->arcmsr_cdb.SenseData
only being 15 bytes, resulting in a 3 byte over-read.

Copy only the contents of ccb->arcmsr_cdb.SenseData and zero fill the
remainder, avoiding potential over-reads.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index e5149c9fd4e6..ec1a834c922d 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1323,16 +1323,19 @@ static void arcmsr_ccb_complete(struct CommandControlBlock *ccb)
 
 static void arcmsr_report_sense_info(struct CommandControlBlock *ccb)
 {
-
 	struct scsi_cmnd *pcmd = ccb->pcmd;
-	struct SENSE_DATA *sensebuffer = (struct SENSE_DATA *)pcmd->sense_buffer;
+
 	pcmd->result = (DID_OK << 16) | SAM_STAT_CHECK_CONDITION;
-	if (sensebuffer) {
-		int sense_data_length =
-			sizeof(struct SENSE_DATA) < SCSI_SENSE_BUFFERSIZE
-			? sizeof(struct SENSE_DATA) : SCSI_SENSE_BUFFERSIZE;
-		memset(sensebuffer, 0, SCSI_SENSE_BUFFERSIZE);
-		memcpy(sensebuffer, ccb->arcmsr_cdb.SenseData, sense_data_length);
+	if (pcmd->sense_buffer) {
+		struct SENSE_DATA *sensebuffer;
+
+		memcpy_and_pad(pcmd->sense_buffer,
+			       SCSI_SENSE_BUFFERSIZE,
+			       ccb->arcmsr_cdb.SenseData,
+			       sizeof(ccb->arcmsr_cdb.SenseData),
+			       0);
+
+		sensebuffer = (struct SENSE_DATA *)pcmd->sense_buffer;
 		sensebuffer->ErrorCode = SCSI_SENSE_CURRENT_ERRORS;
 		sensebuffer->Valid = 1;
 	}
-- 
2.25.1

