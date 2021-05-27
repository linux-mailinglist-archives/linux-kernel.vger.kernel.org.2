Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FC9392A79
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhE0JSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbhE0JS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A3EC061574;
        Thu, 27 May 2021 02:16:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q25so123390pfn.1;
        Thu, 27 May 2021 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BMErcT3/v1nq01VnwMgx0Uydy0/71XuGDRPJXuVrAo=;
        b=Sj8mWO1ZU5OR/lQCX8ihGfd8pi4a8ZWcnWJlU5gMAkJ49kHw+BSJrc30I3Bng9RQep
         ++6/aFlfNg0wVGMnBF0pPF0FPKr0xt5KW74/wJbnmAvrGnmdeOr9TG2rWO55OEuORXhw
         NTrryTBMWu5Y15U2iWwxnvsBspbBA3Z/82oeMUgahMz6jb6RCl8GSm1T7RkdfOZ+6zG4
         2xU4g80MwNEwWxnjXdBg4OCq8B/OJ8ZFqr3mc3AJlqU6Hdlw3PYkKQgyZh6vwt6jT++3
         QA0TPmu+h8HdLscLSRyuIYT7VrTJM2y0sF7ZpS+u0wJOKeWsnqDprafwGRYTrCLP9av5
         grtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BMErcT3/v1nq01VnwMgx0Uydy0/71XuGDRPJXuVrAo=;
        b=jBKj0EHf94i4rjTEoVL/362shsLmn4wNxXPkMkN58IInsL3hNs8P0qUtEeWdFwTODA
         ctEnu0KGvHTg5nzMaVvfwPDDXxlYV12by4HpAp0ZmdQm8vUf+wit0wWAtKMUm2LIddYW
         Znjfu4H0ZyU1lBHMKU1RxcvOLsBxjkee5MS5Qwp1mB/2xgs9xdmhISQUQRL/YYgpONPl
         9Fp9Rhy9KlJgXp1SXjdaaByrbRIiooWBcQO23L5GZNJJO3XOHN+yOzFDWswjg0uoa64Q
         VZxghNKJ0Bx66qqwVmKsgkdTR4IjGqDj/wcjNcqYU/W0G3JYbEOoGnhVYKl3rX6wYRUd
         7fPw==
X-Gm-Message-State: AOAM533+NgekQwVtzsTdv0ux7+E9vVyKffHZNAoITNTRPk63G8eRVuQq
        F9jY8X3G7GzNCHWf1Y7sWi8=
X-Google-Smtp-Source: ABdhPJxajZu2dqyzeBRecSwX5yS25Wqv3Jf/uo4q7kga/Y9lcXO7g2rAxP8mkLgLLPStHXvsER3kSQ==
X-Received: by 2002:aa7:9001:0:b029:2d4:9408:9998 with SMTP id m1-20020aa790010000b02902d494089998mr2805504pfo.9.1622107015606;
        Thu, 27 May 2021 02:16:55 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:16:55 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 02/13] docs: path-lookup: update path_to_nameidata() part
Date:   Thu, 27 May 2021 17:16:07 +0800
Message-Id: <20210527091618.287093-3-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No path_to_namei() anymore, step_into() will be called.
Related commit: commit c99687a03a78 ("fold path_to_nameidata()
into its only remaining caller")

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 751082d469e8..6ea0880fb982 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -453,11 +453,12 @@ to find a definitive answer.
 As the last step of ``walk_component()``, ``step_into()`` will be called either
 directly from walk_component() or from handle_dots().  It calls
 ``handle_mounts()``, to check and handle mount points, in which a new
-``struct path`` containing a counted reference to the new dentry and a
-reference to the new ``vfsmount`` which is only counted if it is
-different from the previous ``vfsmount``.  It then calls
-``path_to_nameidata()`` to install the new ``struct path`` in the
-``struct nameidata`` and drop the unneeded references.
+``struct path`` is created containing a counted reference to the new dentry and
+a reference to the new ``vfsmount`` which is only counted if it is
+different from the previous ``vfsmount``. Then if there is
+a symbolic link, ``step_into()`` calls ``pick_link()`` to deal with it,
+otherwise it installs the new ``struct path`` in the ``struct nameidata``, and
+drops the unneeded references.
 
 This "hand-over-hand" sequencing of getting a reference to the new
 dentry before dropping the reference to the previous dentry may
-- 
2.31.1

