Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD358392A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhE0JSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbhE0JSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94714C061763;
        Thu, 27 May 2021 02:16:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ot16so78446pjb.3;
        Thu, 27 May 2021 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lhuk1HzCv1aHHpmPD9iduddkzycxFFQI7rn75qJWbWc=;
        b=LfiA/cgv4nzDZWhqdtlLgfDxz6Ov72MeHUA2ip4l/0eqO4tWeeevNadiTxxNyq8bZ7
         LOiBpCtQ6J/Q117/Qhl5kLR85wZnydmeD1wavLkmD/Pi+vQbHubKOTRXdETZsk06SN/W
         2F0RJal/xPwTYfiE/aGMI4unVbxSHVj9m5RO09TC90uxa+MqyYNuDcK7vOddsfnCUzQz
         li6JwbIXPartj3D8HTvWa5YqqZi+td8axZ5U8nTOEUPWi2R7MJlfPs5bjIDbbPbrpjSf
         unrTpB1P66osEofr5uWEiqPTxk6zPN5zFxci6Av/6QjuDpOuIgoRvU4klRlYzcxHa3bP
         x9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lhuk1HzCv1aHHpmPD9iduddkzycxFFQI7rn75qJWbWc=;
        b=hrFrAX9c7Gd1YlXmqjF9dXrcuWilFcrlfGGKOzXJKBToBdCxri08+AzRqOJle/bwXw
         dBvXjkfwp+AOSdl29wuNboaLpVElBN6S73D+g0jlvNj3loe7ZtMLt9YXm/VPP9ZiH9pL
         jYaKckgBkHRQTdwGUiZ6Hr+1FiH8KoEXVp6pt5empbYhpvIkqP491iuRCflhP9zOel6f
         e+F40wSfoaI8cHv9/5icwssltbGfyzbBMo9J3OW/PoJZ1dq2Lc+MOYHiCTCr5m2lsY/w
         0YObSiTKHLYFJASyyKfepQJDlj/ANvYqsmkIvwY0L5gSohEFFB4Was0V0VCx1rgrkjrX
         QRUg==
X-Gm-Message-State: AOAM530KS3sKxHCHNtm0JQsAagoOGAzM9rwRuIqLx+/JdRSVt28oEatF
        tqQoelboUq6igCJk3nclXZI=
X-Google-Smtp-Source: ABdhPJwlO/ihzBkBruManeWYRdMAM7kWgeloK7ojqGQ/Qt5hEgprRLgTdAAgw0yFd14IRXg/Jj5YKA==
X-Received: by 2002:a17:90a:5649:: with SMTP id d9mr2698581pji.163.1622107017042;
        Thu, 27 May 2021 02:16:57 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:16:56 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 03/13] docs: path-lookup: update path_mountpoint() part
Date:   Thu, 27 May 2021 17:16:08 +0800
Message-Id: <20210527091618.287093-4-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

path_mountpoint() doesn't exist anymore. Have been folded
into path_lookup_at when flag is set with LOOKUP_MOUNTPOINT.
Check commit: commit 161aff1d93abf0e ("LOOKUP_MOUNTPOINT: fold
path_mountpointat() into path_lookupat()")

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 6ea0880fb982..652d3284f178 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -472,7 +472,7 @@ Handling the final component
 ``nd->last_type`` to refer to the final component of the path.  It does
 not call ``walk_component()`` that last time.  Handling that final
 component remains for the caller to sort out. Those callers are
-``path_lookupat()``, ``path_parentat()``, ``path_mountpoint()`` and
+``path_lookupat()``, ``path_parentat()`` and
 ``path_openat()`` each of which handles the differing requirements of
 different system calls.
 
@@ -488,12 +488,10 @@ perform their operation.
 object is wanted such as by ``stat()`` or ``chmod()``.  It essentially just
 calls ``walk_component()`` on the final component through a call to
 ``lookup_last()``.  ``path_lookupat()`` returns just the final dentry.
-
-``path_mountpoint()`` handles the special case of unmounting which must
-not try to revalidate the mounted filesystem.  It effectively
-contains, through a call to ``mountpoint_last()``, an alternate
-implementation of ``lookup_slow()`` which skips that step.  This is
-important when unmounting a filesystem that is inaccessible, such as
+It is worth noting that when flag ``LOOKUP_MOUNTPOINT`` is set,
+``path_lookupat()`` will unset LOOKUP_JUMPED in nameidata so that in the
+subsequent path traversal ``d_weak_revalidate()`` won't be called.
+This is important when unmounting a filesystem that is inaccessible, such as
 one provided by a dead NFS server.
 
 Finally ``path_openat()`` is used for the ``open()`` system call; it
-- 
2.31.1

