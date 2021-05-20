Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8FB389EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhETHPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhETHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:15:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:13:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 29so106917pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=/FZogyMJylWtzS0eidX0k1eno6muyKoInIXOv6M+ByM=;
        b=DrJ/o5Y6r98D7LiHaOQqQdgv67bnQTekP2Lz8uwmnHCnoXeikFHS1UWXdH3YZIFjE5
         0sJ10LbC0IgJG1d89ZZsnHMB4AjQdArcFPPOdbUaHPQJjKpu8xmYZZTtaIqtFaiBWCA8
         SquxN/7ElfbtCN2b227sxwT6BgXj/xL4x3RKFBJ8dnKJEJg09HZB6vG8mKGNYHwT2RB6
         /vfn5l2EXFK3D0dTZL/8P/stsfwURB/VpkkcVSXg/w7l9t2A/V/x4OCjEZn2TRnOsE4d
         CzMVqpxDQEbAQItql7tImECh7dFLYCnWlLgurSBmTPcaqQa6LbJxHByqyGKtybbERX9A
         FiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=/FZogyMJylWtzS0eidX0k1eno6muyKoInIXOv6M+ByM=;
        b=QcqPY5qPtohJDc/jTuLB3mFWTrZQO53sq2YzNHCxsm7XxCaGe8cl1sLOcQqYKv2Gll
         hUXZtuVv4h0o48s5ZhMyl389y0xx2xFxq4gonsqX6hf6mQOpDj/cqqLVcC1ChVay3eyP
         mRFIraT495QBBIZ/ytWkr3a2aCLjKilKXrA11BFiWJ10rQuX0LrUEoVf/rw2AkfMIQgq
         dZr7uhVchTmroiS3Aq/PhdwHKEdSB3djVQJH36GILKxBSqQdOa3JTDzWJ3ub5DiMZ+EV
         BSoNfzhxq6yJ1eqQsPWav8gSdtBOMHBPPkQYFljqeiuRjXAL/s/tuiX8stNAIKlAnphx
         6MRA==
X-Gm-Message-State: AOAM532K39us3ngz2M8TbCWe4owg0/RlEfKKWDHUOEQw+I/bb5gxSCNk
        DJ6NOnFVl3IU8gGYWHAeCzWfbw==
X-Google-Smtp-Source: ABdhPJxk1iqei3q6Z+wifKmSwxkuDpy5mFlZdNY6CV5wI8PgPuHlhNIUiWve/ymmfsA557xD7C5Iog==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr3081613pgt.111.1621494829559;
        Thu, 20 May 2021 00:13:49 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id o3sm1220688pgh.22.2021.05.20.00.13.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 00:13:49 -0700 (PDT)
Message-ID: <d0c6dc6431f0e46db6583dc0d04d7983b420d4da.camel@areca.com.tw>
Subject: [PATCH 2/2] scsi: arcmsr: update driver version to
 v1.50.00.05-20210429
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 20 May 2021 15:13:49 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

Update driver version to v1.50.00.05-20210429.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index eb0ef73..6ce57f0 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -49,7 +49,7 @@ struct device_attribute;
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
 #define ARCMSR_MIN_OUTSTANDING_CMD	32
-#define ARCMSR_DRIVER_VERSION		"v1.50.00.04-20210414"
+#define ARCMSR_DRIVER_VERSION		"v1.50.00.05-20210429"
 #define ARCMSR_SCSI_INITIATOR_ID	255
 #define ARCMSR_MAX_XFER_SECTORS		512
 #define ARCMSR_MAX_XFER_SECTORS_B	4096

