Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4772633CD88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhCPFr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhCPFrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:47:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A1C06174A;
        Mon, 15 Mar 2021 22:47:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso830434pjb.4;
        Mon, 15 Mar 2021 22:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3OOWGFDuS1KpijU6u67ageYewW1oT8XP6wyO8n6Q60=;
        b=GvhNWwQ+7s5qjn8oJG3a7feT717vdyi8r9q9/+B3O/2B2YuZVRVcVzdxOTxeaksnlG
         PgQs6EjBg/K/ci1r4t0KVDI1VIoUM9l2oI/gCtgmM8V63A5CNMqoLSN/g2BUW0dnC1wH
         AieMiERdUnZY0CF53XizWSRLp/7KNYtQ5ZqAVxry3lj6WSzmnUBf3URF1m7YYjSdFveZ
         4qUcQ3HoEYQXbeW3yHIP84IZPJxKga6Ky2hOKXljqzAJ0KecrijiX8DvLJL4RGyITnZw
         2CxhK241VW3gEg0blXz1YZNBijdlkWQ2ltnEtYDLnScxl4jYlFi2gmT46+OTud34g9Yh
         RVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3OOWGFDuS1KpijU6u67ageYewW1oT8XP6wyO8n6Q60=;
        b=Y33e1lDxyNltVK3X0ZwNQYQOxBggOxE6Dh5yy4ZJJDll5WkEWuNh9uCaqCdea+H8+M
         6p2MDd4gMDg+eQknslSFIKXd5tsv0YcuAU4ibP9Fu5eZ7xkqtP3y6Max5C9I25k6LqI5
         5q+OSv9rTrPSNPSUgMCSOAki1TZRfWDDvFMdYe48vr2yPEBJCubW5rCAO4Nor8Ez/98z
         2XDTkC42YFRP1KwXkX5vsKr8et5fWJDsGkrZHhFHJaeCT0IdyY85ra1ESdfn2dZavOmS
         xqEFJ5mLolCpfvqll2fwDXbxLQmXiPNMvqxOSrfSZXcu+tfdK8yoY0CBvaaGNplXSx0w
         /2Kg==
X-Gm-Message-State: AOAM533SPZ+zAfa0m9PfShMgv6Iq4pCzxVkWFYcke6JYP62IWPLhr+Pu
        y7zzhfSeCcxgf8Xtj1yagJ8D+Myg4WM33QOYzeM=
X-Google-Smtp-Source: ABdhPJzK6PSqJ+VY/zJz7tUyd2cr/8KAwPDPuClheRohk/T8EalKA1Yp34JXe7NHxSbfzfNAZKiU6A==
X-Received: by 2002:a17:902:e98c:b029:e5:defc:ccf8 with SMTP id f12-20020a170902e98cb02900e5defcccf8mr15278518plb.20.1615873670887;
        Mon, 15 Mar 2021 22:47:50 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:47:50 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 03/12] docs: path-lookup: update path_mountpoint() part
Date:   Tue, 16 Mar 2021 13:47:18 +0800
Message-Id: <20210316054727.25655-4-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
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
index a29d714431a3..b6a301b78121 100644
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
+``path_lookupat()`` will unset LOOKUP_JUMPED in nameidata so that in the further
+path traversal ``d_weak_revalidate()`` won't be called.
+This is important when unmounting a filesystem that is inaccessible, such as
 one provided by a dead NFS server.
 
 Finally ``path_openat()`` is used for the ``open()`` system call; it
-- 
2.30.2

