Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC27431DD93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhBQQpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:45:17 -0500
Received: from z11.mailgun.us ([104.130.96.11]:23047 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233694AbhBQQpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:45:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613580292; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6r4IImVOl7JARGGICLwyYe0bDR0yIu1YrLOqz/hgxJM=; b=iZUuG8ZyaZrbU+tflX8i2ZaviwZo5A9BzbApTzLOaD/Y8jz/JxnLyG4HQHF2ahc+4gd/okm8
 5DqdiYnmETHRcSKrV1y7eMU8p1fBE9x0trY0/tkQXUzEUIKJdp6wORzqgpR+m6WCqpYCM/Y2
 a8983zfg8xt0A6OJApSr5JXOSPg=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 602d47e11e797edad8fcec63 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 16:44:17
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E3F6C43462; Wed, 17 Feb 2021 16:44:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0403FC433CA;
        Wed, 17 Feb 2021 16:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0403FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     catalin.marinas@arm.com, will@kernel.org,
        saiprakash.ranjan@codeaurora.org, robh@kernel.org,
        konrad.dybcio@somainline.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] arm64: Add part number for Arm Cortex-A78
Date:   Wed, 17 Feb 2021 22:14:11 +0530
Message-Id: <1613580251-12694-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MIDR part number info for the Arm Cortex-A78.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index ef5b040..3aced88 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -72,6 +72,7 @@
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
 #define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_CORTEX_A78		0xD41
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -109,6 +110,7 @@
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

