Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371923A1F71
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFIVzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:55:50 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:37687 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:55:50 -0400
Received: by mail-lj1-f169.google.com with SMTP id e2so1795424ljk.4;
        Wed, 09 Jun 2021 14:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cn4WXgEYQDhzlifeR1OXF9mGSDchXFcqCqjUIDqHe4g=;
        b=MxrfFHnDhk8BsnSl+CSUJ5TQ/FKIk9eJWhqIG4PjCgbD74vI5QTYVYnZgTVBhODFSS
         KemU4XCCq7b9+RqpgpvvhJkaCp4zzwAkHZbssa1ulXZ4TE1/+LQcKY7VmhYBu91H3w06
         wWv/dpeiPE6NN0MEgDyhJwaZKWU3IgHY2zhaEihIQVeuvEhXL4KW/cggV/MBzvRMNasD
         XeblaxHtO1kqDWHYv9xRTX90SNWvDzoS0Wzd+kITRHh0POQrCt8Zi2FfE1jcOdlMUJyN
         j/GFoYtQxFztcmE415JPYxuKpM6/snPeSrCLgTEC1RWRWqH1bCvT23fRABqrDp113pKe
         3vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cn4WXgEYQDhzlifeR1OXF9mGSDchXFcqCqjUIDqHe4g=;
        b=NdOiVbTOfK8hufwPerlskJ36Fwl8XgwUvl4c7jTSF41dKAAgjdOErq8PHuEvB9cpJ/
         5XNng6rUCOYV4K2/i69P4owGn/cy/jHRVHwg943QFhI/AycfzA3MD3MrzlEK2OjTgeTb
         YJ4RD2dF17KcLMylgwQQfK1Vf5sV30NrFqYVaGdrOKj+2YZ6gmOoDBCIccpeQ5/S4P3o
         iLFPh0olQ77DDiwcmj2RUgSiwu3AMhZfduFv10EAO2ONq8f1y/9ZostOyOtbuF+liXAz
         48kLTeDlsYUweqV8BA+0WxHXjq1JPysdUYQNU2lrp9yVBZwmmvs514u3eVmfCetiEEo3
         RBJA==
X-Gm-Message-State: AOAM531Kx4FvG/kpzNCSxM3weITK+/wzHpPYXiubTQdK7fmt0VCezVnn
        KF6E6kEZ1BFSO7zvCpQN0RA=
X-Google-Smtp-Source: ABdhPJz64BoFB/PL70CNB9/F3rN7GYI2J44vC6SuUkqrntR5Ju/aCcZrRTIPHTzYxb4X12E3zJ43ag==
X-Received: by 2002:a2e:7d0f:: with SMTP id y15mr1379761ljc.388.1623275561355;
        Wed, 09 Jun 2021 14:52:41 -0700 (PDT)
Received: from localhost (public-gprs650102.centertel.pl. [5.184.82.183])
        by smtp.gmail.com with ESMTPSA id m13sm101426lfh.297.2021.06.09.14.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 14:51:42 -0700 (PDT)
From:   Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] doc: Remove references to IBM Calgary
Date:   Wed,  9 Jun 2021 23:51:12 +0200
Message-Id: <1bd2b57dd1db53df09e520b8170ff61418805de4.1623274832.git.hubert.jasudowicz@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calgary IOMMU driver has been removed in 90dc392fc445.
Clean up stale docs that refer to it.

Signed-off-by: Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
---
 Documentation/x86/x86_64/boot-options.rst | 31 +----------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 324cefff92e7..5f62b3b86357 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -247,16 +247,11 @@ Multiple x86-64 PCI-DMA mapping implementations exist, for example:
       Kernel boot message: "PCI-DMA: Using software bounce buffering
       for IO (SWIOTLB)"
 
-   4. <arch/x86_64/pci-calgary.c> : IBM Calgary hardware IOMMU. Used in IBM
-      pSeries and xSeries servers. This hardware IOMMU supports DMA address
-      mapping with memory protection, etc.
-      Kernel boot message: "PCI-DMA: Using Calgary IOMMU"
-
 ::
 
   iommu=[<size>][,noagp][,off][,force][,noforce]
   [,memaper[=<order>]][,merge][,fullflush][,nomerge]
-  [,noaperture][,calgary]
+  [,noaperture]
 
 General iommu options:
 
@@ -295,8 +290,6 @@ iommu options only relevant to the AMD GART hardware IOMMU:
       Don't initialize the AGP driver and use full aperture.
     panic
       Always panic when IOMMU overflows.
-    calgary
-      Use the Calgary IOMMU if it is available
 
 iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
 implementation:
@@ -307,28 +300,6 @@ implementation:
       force
         Force all IO through the software TLB.
 
-Settings for the IBM Calgary hardware IOMMU currently found in IBM
-pSeries and xSeries machines
-
-    calgary=[64k,128k,256k,512k,1M,2M,4M,8M]
-      Set the size of each PCI slot's translation table when using the
-      Calgary IOMMU. This is the size of the translation table itself
-      in main memory. The smallest table, 64k, covers an IO space of
-      32MB; the largest, 8MB table, can cover an IO space of 4GB.
-      Normally the kernel will make the right choice by itself.
-    calgary=[translate_empty_slots]
-      Enable translation even on slots that have no devices attached to
-      them, in case a device will be hotplugged in the future.
-    calgary=[disable=<PCI bus number>]
-      Disable translation on a given PHB. For
-      example, the built-in graphics adapter resides on the first bridge
-      (PCI bus number 0); if translation (isolation) is enabled on this
-      bridge, X servers that access the hardware directly from user
-      space might stop working. Use this option if you have devices that
-      are accessed from userspace directly on some PCI host bridge.
-    panic
-      Always panic when IOMMU overflows
-
 
 Miscellaneous
 =============
-- 
2.32.0

