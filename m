Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A025933CD86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhCPFry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhCPFrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:47:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C0CC06174A;
        Mon, 15 Mar 2021 22:47:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y13so8089069pfr.0;
        Mon, 15 Mar 2021 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdfNXUR2nGRoqtEfb9aHhNleHa9jupSGIQeUUdFEew0=;
        b=P9jrJsT04yAYKWF0oyEZfa1e8LzChfeYMRYCQYH7IQm6pKficuog+aVw3LJ4BC/cNj
         XcrXNvtGkLyVgR7Wm8dBPdpKmqEW1ZjWVaQrgcPmL0UbxfmhRcYMe7K97LthKzcM4Jhj
         cX2NdXEGar8yFlzASn8FtdB3BlOs5vjaqXgkg8VM3kDGLGO/YB6rrr9kFFAKLmQ9rABS
         iHE4CyG1PJX+VUOSly3m81et63P6XKrvnZzRs5vtaa9vt792C4Nc5+ngfpzt1Y3d8+WV
         SJ2lF4oU2qARBHaFqSQaHvJo+OeoXrMLQfrbL+IjNuJMi3XGr7er/f/uGMcc2B6+jj/O
         wJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdfNXUR2nGRoqtEfb9aHhNleHa9jupSGIQeUUdFEew0=;
        b=CBfJ1FSwCb5ijrFZaNwvlCtcqO87emBhMjwunglFPVZFHraYpVpXNxHZIWYzPX5Xnx
         bEsd2nSi7A1V+TWMDMaV0AWonEZzhhsQstrzUb+k6HMk/7LOHVhnCX/wfLnUbaNpoElF
         yLcHIYOOAY5r04zsI1TAncyWDj3Y3Swoki/MeNNtI6/7BiYTld/uqFnbD5MhFmXuZ4DH
         XeXiiYKeH2EInbav4+vCHNPQwcwe5f/BC6+FnaLYIBjLDR5tXHu7kgO1ASjv2zi0onht
         9MNWY6xRFfDn/s4j3UF/xDDWdwZaxD2DGWNFF2QNVNW43DlxbUkHytS69/YheunlmCv0
         7SuQ==
X-Gm-Message-State: AOAM532WY5LdA+iqpljDOD1IuJZsvJE5Y+WI99fsDJSUc3dP9Q5LjeYp
        ir6bOpkpMb+o/S4klc/MvLSq2XWIPAD9TpbLFrs=
X-Google-Smtp-Source: ABdhPJw9i6lb9AixyvsBf2+c9EQqY4EhrN1gk67Ar4EuM7uRgKtverysdegB1w/GSBf9Z5P00otzpg==
X-Received: by 2002:a63:460e:: with SMTP id t14mr2400241pga.230.1615873668091;
        Mon, 15 Mar 2021 22:47:48 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:47:47 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 01/12] docs: path-lookup: update follow_managed() part
Date:   Tue, 16 Mar 2021 13:47:16 +0800
Message-Id: <20210316054727.25655-2-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No follow_managed() anymore, handle_mounts(),
traverse_mounts(), will do the job.
see commit 9deed3ebca24 ("new helper: traverse_mounts()")

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index c482e1619e77..d07766375e13 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -448,10 +448,11 @@ described.  If it finds a ``LAST_NORM`` component it first calls
 filesystem to revalidate the result if it is that sort of filesystem.
 If that doesn't get a good result, it calls "``lookup_slow()``" which
 takes ``i_rwsem``, rechecks the cache, and then asks the filesystem
-to find a definitive answer.  Each of these will call
-``follow_managed()`` (as described below) to handle any mount points.
+to find a definitive answer.
 
-In the absence of symbolic links, ``walk_component()`` creates a new
+As the last step of ``walk_component()``, ``step_into()`` will be called either
+directly from walk_component() or from handle_dots().  It calls
+``handle_mount()``, to check and handle mount points, in which a new
 ``struct path`` containing a counted reference to the new dentry and a
 reference to the new ``vfsmount`` which is only counted if it is
 different from the previous ``vfsmount``.  It then calls
@@ -535,8 +536,7 @@ covered in greater detail in autofs.txt in the Linux documentation
 tree, but a few notes specifically related to path lookup are in order
 here.
 
-The Linux VFS has a concept of "managed" dentries which is reflected
-in function names such as "``follow_managed()``".  There are three
+The Linux VFS has a concept of "managed" dentries.  There are three
 potentially interesting things about these dentries corresponding
 to three different flags that might be set in ``dentry->d_flags``:
 
-- 
2.30.2

