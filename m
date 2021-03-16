Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB433CD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhCPFsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhCPFsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:48:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D5BC06174A;
        Mon, 15 Mar 2021 22:48:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so768075pjq.5;
        Mon, 15 Mar 2021 22:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7JniS282f7kpZ2OXZXS7NrcHTFngjSUBwWhD/gNs5E=;
        b=o8lKTN04BZ94LjuNDIH8DU0oDOV21ta6CbwyNZSvTEdwsvgN9jKLbWAZsuax14aW3c
         /uG5rk9bVeEjoIz0uHjqghio/y1Rx1JTa5eMe8oARTf0T4OY9OCwgoAe8zPk4UBEV2Nf
         IWyQYuKcpG/lrFNkdQ9vc0CnRNPJEwdi9C+WR6sI2FAidUr1cEJLvNpPeCwLSXR2Vi5M
         v//iC/+/uSI4lAUCLyHtOVuWfNHFv/dOIijGF/Di0EXISHHobOW8LMzfBLYatBPuIXbr
         OI7Cxv5TbXe2/MWZqYUTWv/HWjkapxwXtpHapuKHomAKPeoksB1ptwcQdAYydD+fP5lk
         o5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7JniS282f7kpZ2OXZXS7NrcHTFngjSUBwWhD/gNs5E=;
        b=e0f+8lgDEYlMZ9IfbrCfSO0wNaGRFRBCskdkzRabguJW2aKcQKqv/vSyvwhfSxfEV6
         kr96uAue2TYoPXsujo+p8/FXa4aEoSAWvYvMJvGIUizvlM9OyVpKxu7jOBJrCG7Vc00/
         MAWrnz4jV5QVVZg1WrnexXy4of6LUKFNRel5TvtJ1tmeJ9be+bzp04eXIQIUpP4J8YIm
         t+LkHrueBq3B7eiMyCVvqgiUsFLvXQ4NHVuBuXbGmOeIEbz0GNBYXE+7fc0VqtimZ5kb
         WCdF7VQV/9kIv/lKeLgIfDxnVH0RVo7NbyQssevcvZdn6JHSdvUfoHL1u7mQOolUB4WR
         ixng==
X-Gm-Message-State: AOAM533VoOZzXWnaYoGjlM8EbEbs21HglBCIMFUuHr7KHOqE1tEkz7Jn
        VruVFVgaQ4NSmG1ZryxOpoU=
X-Google-Smtp-Source: ABdhPJxYZ5T8F98yoGmG9TtJRtXeO8BYIWlcE2M9uU9K6v/OVqcPfzPph7l58shUAZfDZQTij3Q09Q==
X-Received: by 2002:a17:902:26c:b029:e6:648f:2668 with SMTP id 99-20020a170902026cb02900e6648f2668mr15114228plc.66.1615873682436;
        Mon, 15 Mar 2021 22:48:02 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:48:02 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 12/12] docs: path-lookup: update symlink description
Date:   Tue, 16 Mar 2021 13:47:27 +0800
Message-Id: <20210316054727.25655-13-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

instead of lookup_real()/vfs_create(), i_op->lookup() and
i_op->create() will be called directly.

update vfs_open() logic

should_follow_link is merged into lookup_last() or open_last_lookup()
which returns symlink name instead of an integer.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index eef6e9f68fba..adbc714740c2 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1202,16 +1202,15 @@ the code.
    it.  If the file was found in the dcache, then ``vfs_open()`` is used for
    this.  If not, then ``lookup_open()`` will either call ``atomic_open()`` (if
    the filesystem provides it) to combine the final lookup with the open, or
-   will perform the separate ``lookup_real()`` and ``vfs_create()`` steps
+   will perform the separate ``i_op->lookup()`` and ``i_op->create()`` steps
    directly.  In the later case the actual "open" of this newly found or
    created file will be performed by ``vfs_open()``, just as if the name
    were found in the dcache.
 
 2. ``vfs_open()`` can fail with ``-EOPENSTALE`` if the cached information
-   wasn't quite current enough.  Rather than restarting the lookup from
-   the top with ``LOOKUP_REVAL`` set, ``lookup_open()`` is called instead,
-   giving the filesystem a chance to resolve small inconsistencies.
-   If that doesn't work, only then is the lookup restarted from the top.
+   wasn't quite current enough.  If it's in RCU-walk -ECHILD will be returned
+   otherwise will return -ESTALE.  When -ESTALE is returned, the caller may
+   retry with LOOKUP_REVAL flag set.
 
 3. An open with O_CREAT **does** follow a symlink in the final component,
    unlike other creation system calls (like ``mkdir``).  So the sequence::
@@ -1221,8 +1220,8 @@ the code.
 
    will create a file called ``/tmp/bar``.  This is not permitted if
    ``O_EXCL`` is set but otherwise is handled for an O_CREAT open much
-   like for a non-creating open: ``should_follow_link()`` returns ``1``, and
-   so does ``do_last()`` so that ``trailing_symlink()`` gets called and the
+   like for a non-creating open: ``lookup_last()`` or ``open_last_lookup()``
+   returns a non ``Null`` value, and ``link_path_walk()`` gets called and the
    open process continues on the symlink that was found.
 
 Updating the access time
-- 
2.30.2

