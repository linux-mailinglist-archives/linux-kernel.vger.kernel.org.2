Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDA38AF37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbhETMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbhETMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F7C069174
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i17so17405690wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQxeVP/YPfwPDmoVdUI9QY51IOpHdTucNN69rQ23ZoU=;
        b=BB2z/a7soZkZglZEGxZJrm9s0Rk4y6yPcnQhkxsnSg7k986jCjPPZ9q3cW28aABSFm
         aqOMgyXcB0jFMg6a/5gWx+h6HTFovSDVNG1ghkIgEmYukpWgzASDQ/wqBjxnTWrnmDMB
         IAsvZPdZc1y9CfVzxBXws9mJIzcLDTUymlDGhtg4JTLebuXeT38N2jeXCeP2+PuBazVb
         v/SpFC0FYq5PsyntjhqvxmfifoRVhkEiF+6ncH66I6TyZUzMIl56yvvulbvEcEY5L2Vx
         M7Rwlego5jtRcU/yyBgJJ5p1d6TU8kM5ZRRecxVp3jSCA+z9GPDSQLd1MBVXt8d8PUbP
         blNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQxeVP/YPfwPDmoVdUI9QY51IOpHdTucNN69rQ23ZoU=;
        b=C3lYWqmeuRLg76zIej6IctOLIl/K8eCbu69k8hgwShg8jnvF7Lb0oDx4AlSSI5/sTD
         6UY2NVeeXgJ6IAsOBPZ3yY2DYaEi3uRTOLpptq2x6kAJwGYJw7rYaxshHLJNruqlnSDq
         T8X0m5ikuxtNKMv0SilAxSMOkES3o/ABPdT4xrG8m97kYgUYC97F/Z1OgrtoaGmtxmhw
         G2ai+PSL87OODooOOpmz6540h7QCv/rWYdijGoPKMd/zq2c+KLDLtO932p2OKf1mJ8Pe
         JVlGcF3dCPC1JYiWdgoqJ7yqBauLwa997T7wrOxqlas3VzYBQ6cMQyAWw4h3XGPM+cT3
         R3SQ==
X-Gm-Message-State: AOAM532r7d2B7hBLEyjyT1q4d2vtnVAJFqOGgkExRfps8Up+ekirgmIr
        nB7/2TltHMX4XyTb0BDqldo3Jw==
X-Google-Smtp-Source: ABdhPJwyx22/mLe5y5spSEV/LwEWte193Cc++nFZrm1PhYkbQADCWmlSNgrHqgZ46C0I6X8i19+Zsw==
X-Received: by 2002:a5d:6701:: with SMTP id o1mr4106251wru.390.1621512854660;
        Thu, 20 May 2021 05:14:14 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Kanoj Sarcar <kanoj@sgi.com>
Subject: [PATCH 16/16] char: mem: Provide local prototype for non-static function
Date:   Thu, 20 May 2021 13:13:47 +0100
Message-Id: <20210520121347.3467794-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/mem.c:95:29: warning: no previous prototype for ‘unxlate_dev_mem_ptr’ [-Wmissing-prototypes]
 drivers/char/mem.c:96:13: note: in expansion of macro ‘unxlate_dev_mem_ptr’

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
Cc: Kanoj Sarcar <kanoj@sgi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 95741f93a6cd0..7969ac85491df 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -40,6 +40,8 @@
 #define DEVMEM_MINOR	1
 #define DEVPORT_MINOR	4
 
+void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
+
 static inline unsigned long size_inside_page(unsigned long start,
 					     unsigned long size)
 {
-- 
2.31.1

