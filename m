Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191E33F115E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhHSDRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhHSDRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:17:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48E4C061764;
        Wed, 18 Aug 2021 20:16:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bq25so9547103ejb.11;
        Wed, 18 Aug 2021 20:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuULxqsBES1oBE55HfZGFl348h78G9+Ze8axMVfhIx0=;
        b=kwdwtcD9FORku++R9BuK8KTivvWufibXyoUqDPcsNQXUqNGLVKK+uhkMd1yiLkWJGT
         10mvsGn/+SvxnvGp6/jo6S+EDk5DY9+DoH+nP+C/jLaAMDmR5eMrve53zNGmOpHcBGKh
         39FVyyFtLUGcMUnzgBRW8brOVi186Ji0Gp21zSIBek+SMELFMObrl41j+epCfLNzcEag
         KNGBoKxGtO1q28XqvPbp6ut00gHCSFMFdR3ZIl+F9FOpC6/B/nYRYl5qIENiQwWODO8o
         iVTWuzx3fah1hdi6A/j9+Z4haAa/ElrUZHvD39EaWnjPccVfefZYEcS1FLZgQSeUMc0/
         bbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuULxqsBES1oBE55HfZGFl348h78G9+Ze8axMVfhIx0=;
        b=oFRohAeQkpljI6/+ev4hDGPntrtqqFbLR823oe4eCxx2/SD8lI3Yz9AvHfn/tcjvoD
         Ip6DfkbRzyh3B1qA1AODJMK9s+LNZbQaWlJI9YWv0eNqOkW13roXrzUDjW5WERmyeRdf
         SCFq0XSdsHiwPBnDDXGKEeJZqWP7oPSDDZNiMyezwTlugPa8HF5of/ZKHZZzobc17OHw
         dyoXbgUvvMkzRQEmsnNPJWcO8BmnOor/0OL5t4Sv9mi3dEbB9su2P6M9bp5DGOz/L5rk
         bj8Sp0wrggbVdyGsCb32XP+/l4rhMi/Nrc7G4wjz9ZiDXsr+tJwEuVcbSAjM3jsc/bbZ
         mhtw==
X-Gm-Message-State: AOAM532FBY/yfo447kWYHDmTI11DTIvHhzjOptWP5WvIvWLRFkWKls0Q
        hnX6ig681KppvRmhkUBteBQ=
X-Google-Smtp-Source: ABdhPJyZZW+CBK5s/660ez7FlM0zBuY8N/CXYXUzhZUlfNH1igZAsvywB/cTKVh8H2xaXvAKm/Gcfw==
X-Received: by 2002:a17:906:8245:: with SMTP id f5mr13677500ejx.474.1629342994182;
        Wed, 18 Aug 2021 20:16:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:21b0:9002:7dca:dea6:32ff:fe9d:5ad6])
        by smtp.gmail.com with ESMTPSA id dt2sm629233ejc.51.2021.08.18.20.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 20:16:33 -0700 (PDT)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     corbet@lwn.net
Cc:     jmseyas@dit.upm.es, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, henrybear327@gmail.com
Subject: [PATCH v2] Documentation: Update details of The Linux Kernel Module Programming Guide
Date:   Thu, 19 Aug 2021 03:14:07 +0000
Message-Id: <20210819031407.17044-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, the content and examples of the book "The Linux Kernel Module
Programming Guide" are being actively maintained and added on Github[1].
Currently, the book is being regularly built into webpage and pdf
file using Github static page[2].

[1]: https://github.com/sysprog21/lkmpg
[2]: https://sysprog21.github.io/lkmpg/

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 Documentation/process/kernel-docs.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 22d9ace5df2a..631a3dc04e3e 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -126,15 +126,17 @@ On-line docs
         describes how to write user-mode utilities for communicating with
         Card Services.
 
-    * Title: **Linux Kernel Module Programming Guide**
+    * Title: **The Linux Kernel Module Programming Guide**
 
-      :Author: Ori Pomerantz.
-      :URL: https://tldp.org/LDP/lkmpg/2.6/html/index.html
-      :Date: 2001
+      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
+      Jim Huang.
+      :URL: https://sysprog21.github.io/lkmpg/
+      :Date: 2021
       :Keywords: modules, GPL book, /proc, ioctls, system calls,
         interrupt handlers .
-      :Description: Very nice 92 pages GPL book on the topic of modules
-        programming. Lots of examples.
+      :Description: A very nice 93 pages GPL book on the topic of modules
+        programming. Lots of examples. Currently the new version is being
+        actively maintained at https://github.com/sysprog21/lkmpg.
 
     * Title: **Global spinlock list and usage**
 
-- 
2.25.1

