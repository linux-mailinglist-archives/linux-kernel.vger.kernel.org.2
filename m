Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E441138AE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbhETMmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhETMl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C801CC04FF1E
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso5248742wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDQ+0forDI+XgtxHNWp1Ewtgv/EwMZvwyzCeimdDgZ8=;
        b=UQ8jATvg5qZJZ40FrCfEejT72ibMD+ZoTVHlGUdxS/hsBtRFmXyU9eQ5aVrsgNapC5
         qfPeY7eQd82PqUSXW4tuYQK7j06S+q7YZm1nCQwhNKdRIkrGU2r8QXqHv2yyjkkvCnFU
         gwVj/xz43N8CjyIQqnpywzM/fMFc9KvR0LrsG8j60bq493u2MDyUbZPoL3/3n+P8E7LQ
         G+LHXzn0UPe4fr9I/DGk+w3anuI4iEn+SNqxx7hX0LaMVs54Xsck9eNhbnWwYWfE3ipL
         1ADKPI5HOOUlLHX2EApE9TO7JrA0ynyOAx+fcBH4uDojBo3C0xwsjNjPtfu5k5L+YiPq
         TziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDQ+0forDI+XgtxHNWp1Ewtgv/EwMZvwyzCeimdDgZ8=;
        b=pStJLUWZZaRgoGnPWUa4894M0UpkLWcLXm9oE4iAJ19bjEoOLL2cwYmEgHoPU/SZGa
         qRZMAV134FHIxMmaGc1LTHxlW9y0PIp1Eo7c0hBTvsEJOq3hVV4OBOx0Jl3uhddCFzDS
         ZyLMXX2O4VQL2nipZ1w+nUU1KSW2fljc1ZwJcmF46l0QQ8yVnPpoKKwKlvGoEFFF79aB
         +p+P2yujnRqELuqXNZ9RnK5OE1D8r6C7NbzSY9I6EVCjVVlieMcr1EAPVRH4nOwc1N9V
         8+HzYNRc3EAuJRzecrsUp6kIabgsahcaDiQewy9OpC3S1q8EbqaeM3vbqRyCj/RsuhXz
         ujFA==
X-Gm-Message-State: AOAM532N9kfD16iX1y7/dP2Q8PtkHnrCpkYm4jRg0Qib2GP9B56D4Ukw
        2p96Pgc20g3WlMfpVwJIpuX+lA==
X-Google-Smtp-Source: ABdhPJxDGK6DYgptDfmPmzXFOsIjgnHJ7h9Uu+mHkSB9wKBaMaX21LZP3U6FBoBQuhdLRWDqqVsEkg==
X-Received: by 2002:a05:600c:b58:: with SMTP id k24mr3625260wmr.155.1621512054372;
        Thu, 20 May 2021 05:00:54 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 10/15] fs: ntfs: aops: Demote kernel-doc abuses
Date:   Thu, 20 May 2021 13:00:38 +0100
Message-Id: <20210520120043.3462759-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/aops.c:30: warning: Incorrect use of kernel-doc format:  * ntfs_end_buffer_async_read - async io completion for reading attributes
 fs/ntfs/aops.c:46: warning: Function parameter or member 'bh' not described in 'ntfs_end_buffer_async_read'
 fs/ntfs/aops.c:46: warning: Function parameter or member 'uptodate' not described in 'ntfs_end_buffer_async_read'
 fs/ntfs/aops.c:46: warning: expecting prototype for c(). Prototype was for ntfs_end_buffer_async_read() instead
 fs/ntfs/aops.c:1652: warning: cannot understand function prototype: 'const struct address_space_operations ntfs_normal_aops = '
 fs/ntfs/aops.c:1667: warning: cannot understand function prototype: 'const struct address_space_operations ntfs_compressed_aops = '
 fs/ntfs/aops.c:1682: warning: cannot understand function prototype: 'const struct address_space_operations ntfs_mst_aops = '

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/aops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index bb0a43860ad26..0f2a7dc9f1698 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * aops.c - NTFS kernel address space operations and page cache handling.
  *
  * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
@@ -1643,7 +1643,7 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
 	return block;
 }
 
-/**
+/*
  * ntfs_normal_aops - address space operations for normal inodes and attributes
  *
  * Note these are not used for compressed or mst protected inodes and
@@ -1661,7 +1661,7 @@ const struct address_space_operations ntfs_normal_aops = {
 	.error_remove_page = generic_error_remove_page,
 };
 
-/**
+/*
  * ntfs_compressed_aops - address space operations for compressed inodes
  */
 const struct address_space_operations ntfs_compressed_aops = {
@@ -1675,7 +1675,7 @@ const struct address_space_operations ntfs_compressed_aops = {
 	.error_remove_page = generic_error_remove_page,
 };
 
-/**
+/*
  * ntfs_mst_aops - general address space operations for mst protecteed inodes
  *		   and attributes
  */
-- 
2.31.1

