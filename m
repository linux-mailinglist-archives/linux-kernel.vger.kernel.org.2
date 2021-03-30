Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C134EE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhC3Qql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhC3QpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED4BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g25so8781279wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkr02fIos+BCsK3RgzBT7aSuKROcaktgmpSBdimzS1M=;
        b=VWcBvaoAORiaKYvByYrKKYgwvojCN4ipFsr6mXmf3Qc0STR6bNnImA5BkwCszBfuMW
         U9TLS3tkf08g/ZMcdrlA1jFxbSRDo9Ql5W7J32Of3Y5WFJjkm19vyGaloIkiXTClKKCY
         4VhSbS8lBXvmautV4+CXN7Ng65BY9EnG0CD4k63FC5PaQXje2pRKuCvl5jQ8z7AWDer5
         zibafa6e+eJPiGmAXZ8uhIizuHPRKmUooBqvmyIKAuVeBaWRFWbFNW9XFMb6jj/gfTjJ
         x4B8NHRxMuF4f12Tzbv5rA1QwX3hcJLyCAXVP936nkwx9ZWsinDeBwv6BUvx7ea1Lwho
         F2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkr02fIos+BCsK3RgzBT7aSuKROcaktgmpSBdimzS1M=;
        b=oHnYEPxLwA9FCCwI8tDhbRIYME2sb2parMgGAkk8ooQnMjyJtzVW3b01rtbWNs6C+Y
         oa728OZssIRj3j3xUm8hIHrdPOZ82SiKZLTp1pDL86mC5M6DCOnBaCdkerJTsygVwJoe
         N8phI3Yi4h9E+jqJ3sdj3HfWvwvZxAluByNX3J7dxv4iMAJrivhYFHoACVrQz0VMSSGf
         C1MZ+zbEERwVE2iCnYjlMuHXXdKEcg183BN1G+lD5GopKDygRD3xt8b4PweyTe7jwmZo
         bIQkkBtd8TMKApGbXfoUQ2rlcAMffXfLFJuOi/JxMS8ErLd2JifkPDrRYQfTKFi9gEJZ
         LJ0g==
X-Gm-Message-State: AOAM531FnWTWoToAlWBvxUeW+3yV4wyXh0QvY1sLlqNE5K+lZ5p6n7v8
        N7wHkQoFt6xeC0eh52Xk2uY/1A==
X-Google-Smtp-Source: ABdhPJyKMCb7RXJhMGMwXdnWpYFDdj2UGA1u07QzJZZvftGfPD2wOVuLbq6k52xirMZTD1HC2oDJLA==
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr4988732wmj.21.1617122719997;
        Tue, 30 Mar 2021 09:45:19 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        "Michael A. Halcrow" <mahalcro@us.ibm.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 19/31] fs: ecryptfs: read_write: File headers do not make good candidates for kernel-doc
Date:   Tue, 30 Mar 2021 17:44:46 +0100
Message-Id: <20210330164458.1625478-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide missing param description for 'page_index' too.

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/read_write.c:16: warning: Incorrect use of kernel-doc format:  * ecryptfs_write_lower
 fs/ecryptfs/read_write.c:29: warning: Function parameter or member 'ecryptfs_inode' not described in 'ecryptfs_write_lower'
 fs/ecryptfs/read_write.c:29: warning: Function parameter or member 'data' not described in 'ecryptfs_write_lower'
 fs/ecryptfs/read_write.c:29: warning: Function parameter or member 'offset' not described in 'ecryptfs_write_lower'
 fs/ecryptfs/read_write.c:29: warning: Function parameter or member 'size' not described in 'ecryptfs_write_lower'
 fs/ecryptfs/read_write.c:29: warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_write_lower() instead
 fs/ecryptfs/read_write.c:248: warning: Function parameter or member 'page_index' not described in 'ecryptfs_read_lower_page_segment'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/read_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 0438997ac9d87..60bdcaddcbe57 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2007 International Business Machines Corp.
@@ -230,6 +230,8 @@ int ecryptfs_read_lower(char *data, loff_t offset, size_t size,
  * ecryptfs_read_lower_page_segment
  * @page_for_ecryptfs: The page into which data for eCryptfs will be
  *                     written
+ * @page_index: Page index in @page_for_ecryptfs from which to start
+ *		writing
  * @offset_in_page: Offset in @page_for_ecryptfs from which to start
  *                  writing
  * @size: The number of bytes to write into @page_for_ecryptfs
-- 
2.27.0

