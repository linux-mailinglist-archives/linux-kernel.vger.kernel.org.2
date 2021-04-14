Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A6635FA96
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352938AbhDNSOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352467AbhDNSMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44267C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f8so24820251edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AbvipOBdj1fS79gt/BVri7gSSSf64nN6WvRK9WjmasA=;
        b=tr4qJHvkYmiP/Nh59JAk+KfHZsduv2K5R2CMIBEFqPxAZEk37r3oad0kXphTXhaD5h
         afvWTEvB0Udn7BqPmeD021FssYxUnuaYmJ75qNjzm5bMCrS6YYK1O9Fvi9vS36mEzhUn
         2EIDunirwih2seUD6FzVftp7GiQGzBD6VRHMwVgX8Nto0e4zG8kcVHLw5mQlpOutSU69
         LlNB/BUyJTm//xK4csSQhVmPTCMDrzesww/KIFXALw2DS/0G06NZTVbyeCFSaq319S3/
         wNJnQeYNt85nrau53CBVesYsTm/LvgzHhahJC0Ih7QHU5IXwE/77QUwldoxP3rcAqLGz
         6vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbvipOBdj1fS79gt/BVri7gSSSf64nN6WvRK9WjmasA=;
        b=UHCMEEFfzbwnn+PPudkIE+GLpwbMxbN6gBT5sxluRxpVXks3zpXvygUoYpW7+jIt5l
         U0WbHdfpPart3Rh7dMrJ8b1qBbh91ZM7dPwmZ5wyQp3O8NqRhJPTR4mm6w9b1tqf/pwe
         8KKp0z6pOqU4UBHqwcXasyc9P9ZUqLTBbyHq3T8h8hVHVCBcvTXaNQ8ezHQc8EroQeV9
         YqI6PQtMHDiFLYnWXfOwJxXGsUywn1n3lRPMDt/MKv39AJxhoL6Li13475UeSkuuj/uL
         LAG0czT7dQRAb5nz/l06kPrddVRO3grZBJUoXBLiP+wMe82JX/QqagINZDnoS4MtK8Ch
         6ptQ==
X-Gm-Message-State: AOAM532skMrqHNktwkcjPLsyWzFzlWAilL9CHqaZDoRnRsPOU2Z4syCd
        5XZst3kqE2bnQC5TZ20Ss6zFIA==
X-Google-Smtp-Source: ABdhPJyVuf0KAEN1KRQkxMp9ZUndl7p+vuxDlvKE6jrftSd+XRYn2BnUt3A0IqefD1lWrVIwczHfpA==
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr201587edb.204.1618423931050;
        Wed, 14 Apr 2021 11:12:11 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        linux-staging@lists.linux.dev
Subject: [PATCH 35/57] staging: most: dim2: hal: Demote non-conformant kernel-doc headers
Date:   Wed, 14 Apr 2021 19:11:07 +0100
Message-Id: <20210414181129.1628598-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/most/dim2/hal.c:99: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/staging/most/dim2/hal.c:788: warning: Function parameter or member 'buf_size' not described in 'dim_norm_isoc_buffer_size'
 drivers/staging/most/dim2/hal.c:788: warning: Function parameter or member 'packet_length' not described in 'dim_norm_isoc_buffer_size'
 drivers/staging/most/dim2/hal.c:788: warning: expecting prototype for Retrieves maximal possible correct buffer size for isochronous data type(). Prototype was for dim_norm_isoc_buffer_size() instead
 drivers/staging/most/dim2/hal.c:802: warning: Function parameter or member 'buf_size' not described in 'dim_norm_sync_buffer_size'
 drivers/staging/most/dim2/hal.c:802: warning: Function parameter or member 'bytes_per_frame' not described in 'dim_norm_sync_buffer_size'
 drivers/staging/most/dim2/hal.c:802: warning: expecting prototype for Retrieves maximal possible correct buffer size for synchronous data type(). Prototype was for dim_norm_sync_buffer_size() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Shvetsov <andrey.shvetsov@k2l.de>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/most/dim2/hal.c  | 4 ++--
 drivers/staging/qlge/qlge_main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
index 30112413f20a0..65282c2768628 100644
--- a/drivers/staging/most/dim2/hal.c
+++ b/drivers/staging/most/dim2/hal.c
@@ -96,9 +96,9 @@ static int dbr_get_mask_size(u16 size)
 }
 
 /**
- * Allocates DBR memory.
+ * alloc_dbr() - Allocates DBR memory.
  * @size: Allocating memory size.
- * @return Offset in DBR memory by success or DBR_SIZE if out of memory.
+ * Returns: Offset in DBR memory by success or DBR_SIZE if out of memory.
  */
 static int alloc_dbr(u16 size)
 {
diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index c9dc6a852af4a..55a04ca9307c1 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -1389,7 +1389,7 @@ static void qlge_categorize_rx_err(struct qlge_adapter *qdev, u8 rx_err,
 	}
 }
 
-/**
+/*
  * qlge_update_mac_hdr_len - helper routine to update the mac header length
  * based on vlan tags if present
  */
@@ -2235,7 +2235,7 @@ static void qlge_vlan_mode(struct net_device *ndev, netdev_features_t features)
 	}
 }
 
-/**
+/*
  * qlge_update_hw_vlan_features - helper routine to reinitialize the adapter
  * based on the features to enable/disable hardware vlan accel
  */
-- 
2.27.0

