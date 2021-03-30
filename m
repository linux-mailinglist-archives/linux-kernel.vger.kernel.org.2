Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFD34EE67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhC3Qqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhC3Qpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8114CC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so8780815wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWvMlJ4d3x+qcU64iGhAUZtLWgwVA57wA+kzMEuS0dg=;
        b=A9XKsy6fAAlpc7iXke5cEpg8HOEA3HY1t3o/IPI6VfYYZq9VIwF78tWdSOI2ptx2Yk
         2j2Kzyeqqu4cpPRYCKN+oRDFHy1tYubuwbcOnoyGFaviGxGcB6OHnMtkbCBlRGJc85wn
         c0hEF5VseI2qTDCOw56Qspnm6LUx/vuAJNcAmIoAr+5qtkFtUKQ+fevewrGge94/0fWo
         qaSg4yGnaYqRPweAm8uX9ZwxcRoGfg2E7N/TQW4w7If95nabFx0FbC8E0SuntL7gCQ7+
         XR2QBpT7qCQ3yqiqqtmoaBAAXcidqNbCJrrXxPDmmmDcYDfgVsHRplc2t8Lw2QaGix6D
         SsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWvMlJ4d3x+qcU64iGhAUZtLWgwVA57wA+kzMEuS0dg=;
        b=OELeJLm6u9XKhSEzshCBRIxKeaIREThKjppHopMmBTldvj7ahuq1yEj8jBFUHXlq0u
         Ix/CIqwYXv6D39kgSscFVG17F0HWY4T9p8Z/hb3elgGjam7r8cx8v3yRYr+jznpCfBbh
         05zNB0FPjc/13pac5hLZ/wOvFoLgsJ6yK1aB+a3/BR8K08q/pTXw67GaIIMjre/whmJ/
         w8CXbo1qT9TYEEaDrAXmJqg+8r0nFTSSSf4M+MC1Laq4e57twb2wEkuAHqqXG/rObbWU
         F1j8lwO4TBojkOESzedWrMHKWJr6cB5JMheZrJu2MdJnaL04YTU2KU8rnKWTg/1C1EeN
         SCnw==
X-Gm-Message-State: AOAM533RgwboI4/kP4PdgBhHP2uXyYFa8qr83AEpowLthrl/aSmXaNf3
        VcLAUiOE3d8je/I+jMapAhVK6gKxddhQ6Q==
X-Google-Smtp-Source: ABdhPJxywJr+TWZStdY4BUSeEGsoEd5Iz7ypRVRZ8uAz9QIVFl7Qb0TNIpKcDNW3zsBxbamNoPD1uw==
X-Received: by 2002:a05:600c:2145:: with SMTP id v5mr5034761wml.65.1617122729271;
        Tue, 30 Mar 2021 09:45:29 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        Eric Biggers <ebiggers@google.com>,
        "Michael A. Halcrow" <mahalcro@us.ibm.com>,
        "Michael C. Thompson" <mcthomps@us.ibm.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 28/31] fs: ecryptfs: crypto: Supply some missing param descriptions and demote abuses
Date:   Tue, 30 Mar 2021 17:44:55 +0100
Message-Id: <20210330164458.1625478-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/crypto.c:29: warning: expecting prototype for eCryptfs(). Prototype was for DECRYPT() instead
 fs/ecryptfs/crypto.c:360: warning: Function parameter or member 'crypt_stat' not described in 'lower_offset_for_page'
 fs/ecryptfs/crypto.c:360: warning: Function parameter or member 'page' not described in 'lower_offset_for_page'
 fs/ecryptfs/crypto.c:637: warning: Function parameter or member 'crypt_stat' not described in 'ecryptfs_compute_root_iv'
 fs/ecryptfs/crypto.c:1386: warning: Function parameter or member 'ecryptfs_dentry' not described in 'ecryptfs_read_metadata'
 fs/ecryptfs/crypto.c:1463: warning: Function parameter or member 'filename' not described in 'ecryptfs_encrypt_filename'
 fs/ecryptfs/crypto.c:1463: warning: Function parameter or member 'mount_crypt_stat' not described in 'ecryptfs_encrypt_filename'
 fs/ecryptfs/crypto.c:1897: warning: Function parameter or member 'encoded_name_size' not described in 'ecryptfs_encrypt_and_encode_filename'
 fs/ecryptfs/crypto.c:1897: warning: Function parameter or member 'mount_crypt_stat' not described in 'ecryptfs_encrypt_and_encode_filename'
 fs/ecryptfs/crypto.c:1897: warning: Function parameter or member 'name_size' not described in 'ecryptfs_encrypt_and_encode_filename'
 fs/ecryptfs/crypto.c:1897: warning: Excess function parameter 'crypt_stat' description in 'ecryptfs_encrypt_and_encode_filename'
 fs/ecryptfs/crypto.c:1897: warning: Excess function parameter 'length' description in 'ecryptfs_encrypt_and_encode_filename'
 fs/ecryptfs/crypto.c:2006: warning: Function parameter or member 'sb' not described in 'ecryptfs_decode_and_decrypt_filename'
 fs/ecryptfs/crypto.c:2006: warning: Excess function parameter 'ecryptfs_dir_dentry' description in 'ecryptfs_decode_and_decrypt_filename'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: "Michael C. Thompson" <mcthomps@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/crypto.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 7671412b8f0b4..cdcbcf7b5b6c7 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2004 Erez Zadok
@@ -350,7 +350,7 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 	return rc;
 }
 
-/**
+/*
  * lower_offset_for_page
  *
  * Convert an eCryptfs page index into a lower byte offset
@@ -627,9 +627,8 @@ void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stat *crypt_stat)
 	}
 }
 
-/**
+/*
  * ecryptfs_compute_root_iv
- * @crypt_stats
  *
  * On error, sets the root IV to all 0's.
  */
@@ -1370,7 +1369,7 @@ int ecryptfs_read_and_validate_xattr_region(struct dentry *dentry,
 	return rc;
 }
 
-/**
+/*
  * ecryptfs_read_metadata
  *
  * Common entry point for reading file metadata. From here, we could
@@ -1448,7 +1447,7 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
 	return rc;
 }
 
-/**
+/*
  * ecryptfs_encrypt_filename - encrypt filename
  *
  * CBC-encrypts the filename. We do not want to encrypt the same
@@ -1876,10 +1875,11 @@ ecryptfs_decode_from_filename(unsigned char *dst, size_t *dst_size,
 
 /**
  * ecryptfs_encrypt_and_encode_filename - converts a plaintext file name to cipher text
- * @crypt_stat: The crypt_stat struct associated with the file anem to encode
+ * @encoded_name: The encrypted name
+ * @encoded_name_size: Length of the encrypted name
+ * @mount_crypt_stat: The crypt_stat struct associated with the file anem to encode
  * @name: The plaintext name
- * @length: The length of the plaintext
- * @encoded_name: The encypted name
+ * @name_size: The length of the plaintext name
  *
  * Encrypts and encodes a filename into something that constitutes a
  * valid filename for a filesystem, with printable characters.
@@ -1991,7 +1991,7 @@ static bool is_dot_dotdot(const char *name, size_t name_size)
  * ecryptfs_decode_and_decrypt_filename - converts the encoded cipher text name to decoded plaintext
  * @plaintext_name: The plaintext name
  * @plaintext_name_size: The plaintext name size
- * @ecryptfs_dir_dentry: eCryptfs directory dentry
+ * @sb: Ecryptfs's super_block
  * @name: The filename in cipher text
  * @name_size: The cipher text name size
  *
-- 
2.27.0

