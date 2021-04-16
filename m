Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4F36185B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 05:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbhDPDwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 23:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhDPDwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:52:30 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45DCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 20:52:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p12so18328109pgj.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 20:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=xa3dF3mWjOGHQTSXewzVQttORbJ1MeBGLJ4z7sU7nWs=;
        b=H8Gy/Fb5XMHP3uA3YY/JTZVRZJQYbZ8rhPUUvF8++jKCop+8uh0i+e7VLFdLxkwUa9
         1ELHfXzFoOl356/lx5OpqKHCK67oAaO8P76Ts2xFC/DBD99LxzeC+RHh48DL03S52nZV
         1lr5RZ/YbDAUmbIWFCeJKyiUF0TzM+Y33miYkmT95PM8aNLbDSYP+hx/lSX0AjYkR0tE
         o2fv7saWCVNRt8e2/5gTHEkHALFo/Pf+qVN164hrHFjdi3lIhDBo2eQaWjey01b4ifhh
         eytK70rTOBKUgPZ7dcHcbyJEfWTp7sPvEAhMSNEOUMVL6h0gfZZwy61Cw71DUcSLRVfR
         0Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=xa3dF3mWjOGHQTSXewzVQttORbJ1MeBGLJ4z7sU7nWs=;
        b=SC6srIMnTHJxo27ukPVc7ISp99UDEVLbKaHM2mu1coA6NTjwYYWB/sovykT6COZSei
         vqbC/5TN+a/ge+Vnzu3bXIGiya5l2CRIqU/xNZffs5R2LGtPab34PLbGVz8s2sLp7In0
         ZbYmJoV7tQyaNNgWw6BV/PJnywWMF9wf3YRZ1zgjatI1wYdaaAAU05K4H/tCiRN7W5y8
         Z3nuHDpcfLRAwhVXWjFubIhDBRhCU6eLv5keRDifUS0NYwu1oGSjfCcFdp4sZBW881UV
         U/401+AKpT3ZYC1y/h3YsuPYwdaYk7KcDKy4YaF7uQgdpAq9REBE7yEfRM1s+lXelTol
         g+KA==
X-Gm-Message-State: AOAM531fwZEph8EA+fr1hF5bTfpx+fUZYuOxPm3U4QsW03nc9SnbQQd7
        MVMEQoMCwSF+FHuPnJWMtWhbZH5DT5T9kQ==
X-Google-Smtp-Source: ABdhPJxEEFy28l5SGUuxFlvC3roQ4r/ScQbK4MIl3JpYg3srilQ1v/nNZbfinScmy5WvTXNg7thMdw==
X-Received: by 2002:a63:6ec5:: with SMTP id j188mr6133824pgc.394.1618545125170;
        Thu, 15 Apr 2021 20:52:05 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id g24sm3771557pgn.18.2021.04.15.20.52.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:04 -0700 (PDT)
Message-ID: <3a7f39b4f8d3a3a2400556e6ce410810f0508829.camel@areca.com.tw>
Subject: [PATH 2/2] scsi: arcmsr: update driver version to
 v1.50.00.04-20210414
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Apr 2021 11:52:03 +0800
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

