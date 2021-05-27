Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FD5392A76
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhE0JS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbhE0JS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D47BC061574;
        Thu, 27 May 2021 02:16:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id i5so3271572pgm.0;
        Thu, 27 May 2021 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k5/JR1bzK3xVgmjh2jiCSg7HEym66VRBv7BVnE8Z1sI=;
        b=XQaVCbyNAEXVypGzaFXZQW74uFLJfChXhQECKvDv68HiW5UtJJED92XWmfcN64LKmm
         7YeonkqTQAynXUFSFGjFW02+xXd59/RI4oHGwyRNBi4LWpVBZMqmT8yqmOj7AA12Vblk
         Ppn/Akxd5Ey0ZPh6KRUutLpCOqLMUpiVfoEAUkYUG1QE1BpWiPveDhKa+8TPy05O6FSn
         oUFMGXno9S4xJGWBAThv6Ta/X9MaaepC9D3ljb+eH3m0gPv9MaOGeht9+CrNg2z3/9Uy
         e8ogebiatxt3l0EK9DFCGcXboT+URBL1qVv9Ge5Bc3Xiprx1dNEkRAMhvYQq6Ju07Yaj
         TFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5/JR1bzK3xVgmjh2jiCSg7HEym66VRBv7BVnE8Z1sI=;
        b=qgGnl5ec/pQRknycQEvr1xCwSJuUUj/feWqSMMhcB5SfBn1abg0Qpix+JcF50Qctwk
         jQChVN+NZ+sUFzlpG35iCZCyW1gmbzc2wP2egTCfs5zyz70cmGK6+3OiUlOo/WSSEqhG
         m3I2VvBBXafn5uL16P6KFLZ54hihPE3nV4Y58TGDg1JPIdVyZntR7YMMNSJZ752hLJ5N
         xXoDFOVmV4tMY4Jf572lW2cL22ROgNpP0X15H+T8hH2rhKBXqwOdrGMgeGMXadlsHHJY
         0Ne/EjJ9sF1091rO3NlBDRV44PHbz+fOqSpKOLaGMs0HzemyEX0p13oIaw/mfcf1CkYL
         /1Mg==
X-Gm-Message-State: AOAM532Yg9Gz7+j/CetrGWiYFjBupkK3HAr1vbrYgNm8UkBJO8xJ00QV
        ZrJZSQz79o+ywkseNdlkKFg=
X-Google-Smtp-Source: ABdhPJyfEapy7fpRyc6tz3EkDEI1Kyw5PViUP+x1PqkLo8gn3agP9iD4UE3preIj+a9wjP954PBd0g==
X-Received: by 2002:aa7:8484:0:b029:2d8:a014:a0fc with SMTP id u4-20020aa784840000b02902d8a014a0fcmr2781282pfn.24.1622107014120;
        Thu, 27 May 2021 02:16:54 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:16:53 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 01/13] docs: path-lookup: update follow_managed() part
Date:   Thu, 27 May 2021 17:16:06 +0800
Message-Id: <20210527091618.287093-2-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
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
index c482e1619e77..751082d469e8 100644
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
+``handle_mounts()``, to check and handle mount points, in which a new
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
2.31.1

