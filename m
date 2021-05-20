Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEAD38AE96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbhETMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbhETMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6147C0611E2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q5so17374684wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RmIzqZ1vxn50jmDhJrSjkM4TUNU/Mv1FO2GF43pfOTE=;
        b=kBQBqlR/7lraonsM2N+Fyep4B8UizGXLVJeo5rraP6VR4DqJskq7f0dXZd2KnogYnN
         aJMh/LdYRwOKUO6gZ/Jc1jLg6mNN7yYCONybr5KKVFN0BYj+uBBtVkTQArvGPLMQbSZ8
         lxIZ1qgq+ztZ2SwijJiWyuvI5MDNVC5XF0toY24agdbW9WoJjAxxUygDflPbEcLTwGlT
         4N5/40ouNruiNN+j46JZ+BssRfuhnk2niHjXUcLYeUFUo3/jyPSGZkubA91vEepZgHaO
         NXpHg2mPyyNwHXcxGLJRyNCgnloL/vlZqdrTZhRmIy4YJ/NVHDKto7yCThVNP8UD6HR9
         5c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RmIzqZ1vxn50jmDhJrSjkM4TUNU/Mv1FO2GF43pfOTE=;
        b=fIOqmfVwA2KZ7ht1LQmQHYDGn55r7beVf8Pn71w6+dLJkYhDu9OZH9N5hOxSPLtiFU
         Bd32HyPb7QKN3cEoQMtNZyGYdQpqGGEJIb1xOSaVj5Xc/nYK2Nzxi9raKM3K1eMrU02+
         +bNWW1Z+acd8Bw2PTLg1MtZh054ARSFo/D+cAttMYbDkfTSiJ3jiybYMYeqcYpzOiJUj
         uLYjOCJwquxyQBod6OTorR8p7wh3anEkpOUFKn50oDYJdsN8H7saVX+HAYvkqbnAMMap
         AB5R25rcZwpFh+kWz49n9098PQzCLfrUgfGoeEn6gI2L5b+0ztsKxD8a0jBeqZ3DOKi9
         154Q==
X-Gm-Message-State: AOAM531MR+CuELb8+KqmQP2zkwR+ZxzR5uelMstWIQ/zKVZaR1M408VF
        LUMkawYnSdrE8DA5CaIn2lrhQ8dmCwA5tA==
X-Google-Smtp-Source: ABdhPJxeShEtHbO3i7XfshSUArsOOf9UFESQ8PBmRmFbaClKPJz3v9p3bh6bnyWkmc5vs3OKqgzc4A==
X-Received: by 2002:adf:d081:: with SMTP id y1mr3844589wrh.179.1621512048447;
        Thu, 20 May 2021 05:00:48 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 03/15] fs: ntfs: namei: Demote non-conformant kernel-doc headers
Date:   Thu, 20 May 2021 13:00:31 +0100
Message-Id: <20210520120043.3462759-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/namei.c:263: warning: wrong kernel-doc identifier on line:
 fs/ntfs/namei.c:368: warning: wrong kernel-doc identifier on line:

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 4e6a44bc654ce..ab44f2db533be 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -259,7 +259,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
    }
 }
 
-/**
+/*
  * Inode operations for directories.
  */
 const struct inode_operations ntfs_dir_inode_ops = {
@@ -364,7 +364,7 @@ static struct dentry *ntfs_fh_to_parent(struct super_block *sb, struct fid *fid,
 				    ntfs_nfs_get_inode);
 }
 
-/**
+/*
  * Export operations allowing NFS exporting of mounted NTFS partitions.
  *
  * We use the default ->encode_fh() for now.  Note that they
-- 
2.31.1

