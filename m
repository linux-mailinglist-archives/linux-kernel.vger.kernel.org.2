Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB61361877
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 05:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbhDPD6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 23:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238379AbhDPD6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:58:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ADDC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 20:58:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h20so13270976plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 20:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=xa3dF3mWjOGHQTSXewzVQttORbJ1MeBGLJ4z7sU7nWs=;
        b=hDsbccfiO4QBRFKF7p2mclaEkEBZEAoFUo18DDp+TCGeURUfZa0ym1aJy3MucPH+gS
         uen2f6p0XPtPHyfAcBkTuRKVmq4GXMSBCYDwaPoOxVMyJUdrQHbBUxXeOHqvLys0LcK5
         2o1pqA0P0dIsr5My/0NEXgMl7+bQGL9273w6/ZMFJ3xeabmzw0Mx6sTFBc8kX86QUd2v
         lVXHJcaU7BdudghOpMsNfbstOZcniHpoBzTTpYOT3tPdVvC3560GsaWb9iXHLeQE3Zci
         VzxVvmSi3hP+geT0pT5Zkx0cSGNODArs7AebotLMZtqlqSRseEkeiFylRkqDlLZcSOnV
         L+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=xa3dF3mWjOGHQTSXewzVQttORbJ1MeBGLJ4z7sU7nWs=;
        b=oWJFUJbO2a7AEh4MoeNpSYvOpDCHg3tFFsOmP2z/EKnWDXbsx+ef+CaxBjNH8XmxDD
         ZukiOZhQ3SlI8XN6Vb3vNcRHZs4Ey30Yc/PzqLUSjhej/z9P917SuDa08JfAsAY/7Ybh
         gYOeoLQLarKzY70ZFSegCFQD7nExl5UVD1+KfTg1NzDCEGQE1IJ8oyeRA7sdGN8ZKrEr
         PMHFeiG5HR1GCFUK3PzDBdvoexlo0tcEFnvw8+PZZKEKXuckXTBfFaQOsWcQa98Dpocb
         BnyAm75ZVTFLmmWi5vXS726Dty/GS3BjEAhyweqzjp893KlCJXFrRcAnKCrp0HyHWhnD
         APHQ==
X-Gm-Message-State: AOAM5325j1RkRCTqpW9nmIlJT3v+RKkMm4TTJnYalS4bEdOXbW+mgBnD
        5PWnROqgDIG2apN+z5JM02T66eaoKv6fww==
X-Google-Smtp-Source: ABdhPJyBCVgFDJt7lAZEwyqfQoG1JyoAPvR7ALiEabt1kcJvgo/pe9JbzJg5U4pl+r07xssEt+7e8g==
X-Received: by 2002:a17:90b:ed8:: with SMTP id gz24mr7209234pjb.98.1618545484393;
        Thu, 15 Apr 2021 20:58:04 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id i9sm4328017pjh.9.2021.04.15.20.58.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:58:04 -0700 (PDT)
Message-ID: <1ca5474a5c6fea59bf13cdf84f7bd17f0b20f562.camel@areca.com.tw>
Subject: [PATCH 2/2] scsi: arcmsr: update driver version to
 v1.50.00.04-20210414
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Apr 2021 11:58:02 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

Update driver version to v1.50.00.04-20210414.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 0f6abd2..eb0ef73 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -49,7 +49,7 @@ struct device_attribute;
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
 #define ARCMSR_MIN_OUTSTANDING_CMD	32
-#define ARCMSR_DRIVER_VERSION		"v1.50.00.02-20200819"
+#define ARCMSR_DRIVER_VERSION		"v1.50.00.04-20210414"
 #define ARCMSR_SCSI_INITIATOR_ID	255
 #define ARCMSR_MAX_XFER_SECTORS		512
 #define ARCMSR_MAX_XFER_SECTORS_B	4096

