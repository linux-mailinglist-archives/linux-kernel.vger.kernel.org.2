Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9438AE98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhETMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbhETMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5872C0611E8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso5251633wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7j5Jz1TLm5Rclaa9Io/h5T5lIOMB5agFM7VL9F5JV8=;
        b=neqXmRnp+z/d+ko1FGj3gZUAFj+eQmCOAJhcOGdoD2GYkQ/mPtmiMfJfF2ZCKn9g/A
         8DalntTdya/i3xr98TiesiA0nJKNE6n1AHw+t2BZvp3pKhwMEX1wqwp8WFbMQ1cjcu/y
         mOSOeUDY5P5veCUyoDRFIDqqe56p1XK/J/kRPSPXnDZie2ZgSXer+F/zxBnHK/zAkFCb
         HphcVKFkMMk7GFwI1kuyb24HtL/IoXUiN5DTj8s+rF8zt0YjXZY60fzwTucwF1JG7xch
         LdDnuUIs9zJx4mKxM5YyM8X7SB9+Z5ykSe3OdubsENXNgpkC2deNdQlQvBxPXDtGXyZH
         ec8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7j5Jz1TLm5Rclaa9Io/h5T5lIOMB5agFM7VL9F5JV8=;
        b=aXczMr8t8xIi9aJ0agbhvjvOcZpslL3z+FNwu9m908I8LtuwH9Ax6cbecnOMER0hXb
         mD5LRmdKJD427sLdEPeCDjkUrgGsa95vdqNAFw2eygEVNNR6HN+wcAWqjZIfgYFfrLlJ
         emshyz+yKi3f7xWAWpsO0Yn2EWpT3MDq+IFFHA5KOySlzc2m2gOJDe9GGpX+JUXitYPs
         JvSf0svjfleveBYKCvXRC2WHD3WdHfbHA04xiZoWum1fFpj35YsNliRUSHHsX/+yWBNI
         l36S0eh4t69ASgQk3spivlwmFHZQUGYW8alBDJu7zA5/UAwqX0SwfQSTnEjF1M3uLNAO
         Q7pw==
X-Gm-Message-State: AOAM5329myApsUyI9lvWU8UPtfrOvEkaeSz0Gpn9ltA0i7pfJNOXqPG9
        aGT1Qtkfv2UiqBbjCnzEKqFZwLq228JAuQ==
X-Google-Smtp-Source: ABdhPJxErTypmyFCxeAHlikIOyGLPrynMAjCeRS2KHBrnFhjVhQjhAPN4KDhFWM3+w9t7YqZNAW+Og==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr3685078wmb.15.1621512050310;
        Thu, 20 May 2021 05:00:50 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 05/15] fs: ntfs: compress: Demote a few non-conformant kernel-doc headers
Date:   Thu, 20 May 2021 13:00:33 +0100
Message-Id: <20210520120043.3462759-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/compress.c:22: warning: Incorrect use of kernel-doc format:  * ntfs_compression_constants - enum of constants used in the compression code
 fs/ntfs/compress.c:24: warning: cannot understand function prototype: 'typedef enum '
 fs/ntfs/compress.c:47: warning: cannot understand function prototype: 'u8 *ntfs_compression_buffer; '
 fs/ntfs/compress.c:52: warning: Function parameter or member 'ntfs_cb_lock' not described in 'DEFINE_SPINLOCK'
 fs/ntfs/compress.c:52: warning: expecting prototype for ntfs_cb_lock(). Prototype was for DEFINE_SPINLOCK() instead
 fs/ntfs/compress.c:88: warning: Function parameter or member 'page' not described in 'zero_partial_compressed_page'
 fs/ntfs/compress.c:88: warning: Function parameter or member 'initialized_size' not described in 'zero_partial_compressed_page'
 fs/ntfs/compress.c:107: warning: Function parameter or member 'page' not described in 'handle_bounds_compressed_page'
 fs/ntfs/compress.c:107: warning: Function parameter or member 'i_size' not described in 'handle_bounds_compressed_page'
 fs/ntfs/compress.c:107: warning: Function parameter or member 'initialized_size' not described in 'handle_bounds_compressed_page'

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/compress.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index d2f9d6a0ee323..12444ac8f8ec5 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -18,7 +18,7 @@
 #include "debug.h"
 #include "ntfs.h"
 
-/**
+/*
  * ntfs_compression_constants - enum of constants used in the compression code
  */
 typedef enum {
@@ -41,12 +41,12 @@ typedef enum {
 	NTFS_MAX_CB_SIZE	= 64 * 1024,
 } ntfs_compression_constants;
 
-/**
+/*
  * ntfs_compression_buffer - one buffer for the decompression engine
  */
 static u8 *ntfs_compression_buffer;
 
-/**
+/*
  * ntfs_cb_lock - spinlock which protects ntfs_compression_buffer
  */
 static DEFINE_SPINLOCK(ntfs_cb_lock);
@@ -80,7 +80,7 @@ void free_compression_buffers(void)
 	ntfs_compression_buffer = NULL;
 }
 
-/**
+/*
  * zero_partial_compressed_page - zero out of bounds compressed page region
  */
 static void zero_partial_compressed_page(struct page *page,
@@ -99,7 +99,7 @@ static void zero_partial_compressed_page(struct page *page,
 	return;
 }
 
-/**
+/*
  * handle_bounds_compressed_page - test for&handle out of bounds compressed page
  */
 static inline void handle_bounds_compressed_page(struct page *page,
-- 
2.31.1

