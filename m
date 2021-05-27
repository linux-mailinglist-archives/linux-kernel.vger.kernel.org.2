Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D63392A93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhE0JT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbhE0JSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5372C061761;
        Thu, 27 May 2021 02:17:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i5so3272030pgm.0;
        Thu, 27 May 2021 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3Uuv2kp9sJ+ZOYcXrvzzgJCIIWjx7eY+qiNFRbIwBQ=;
        b=KLmPPvTSwdIH53g3w/YliLsW6ycsmg+Ino93L+jOmPcX2dh3WHXAU1nJdVng1OV2ml
         hGGIauUsqzUlm6bOLNjcdX/dR6tcS8wjNb8iL3uasxg0FKiS8vbCpN3AA+lQWZ85/eje
         sNO53+VN0QGdHMMPwei//M4dqxHd8n029QNFsVnpRX7mr37mdyG9r8NkAZd7GtpP123z
         6rPwSqiylCX/gfZoB+b2yp0p2BMeIvlhxPT+9rR6DbmtPSCFodDv+lDbkEzbGPNUSU+s
         mg8BYpOqVlXImhsLqQ4KRrTYIu0ULMaCsWc+YNjE+ymx3WAOVIWZiok93+KrkHWAaMsg
         3HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3Uuv2kp9sJ+ZOYcXrvzzgJCIIWjx7eY+qiNFRbIwBQ=;
        b=NA18M9xH2fbNBUE4pVa6KBga9kl2RAWY6mTFB/ED7MVjYe+m4EeERle0Pi5fRWlti5
         AFgxpI47o9c+WwKMesCTdn0fqKSxgqvZbsVgjGQtJYrDN+zh5TP4GFM6cDzszINqmWx+
         rgGCWwu7UwezrGxxe/V7OyN1LCPDqoT6txH2aTajDPUyfl3XRC5Scr2Jibvl0P4tfqnW
         qK3f+fKLNrSGWhoPhV1qXGvGL9ttYSJZjGFfQmw5mBBZx5Hw5usHXMjNnJBp0lZDbnTg
         8XPbnjXL/W48gggrt26L1PCYjjegEzPpBBKUUiodAi6tx9Lvm/wXjTIUQv5GRJY8wX18
         3cMg==
X-Gm-Message-State: AOAM532K/UKGMHDaJbEQ7P/it07pq8588WzPYiFkmHaJt7KkXjg+EeeD
        n2WavZWZZW+zysoTvHFGEGY=
X-Google-Smtp-Source: ABdhPJxEVjWQ/52lFPX/E/QswjwaS53JeBtoTb7c12KQFJuqcPK1yFeFyXdFQ3Yv2BvQ90QpdXlMRg==
X-Received: by 2002:a62:ac1a:0:b029:2db:7c55:7f4 with SMTP id v26-20020a62ac1a0000b02902db7c5507f4mr2810297pfe.26.1622107030456;
        Thu, 27 May 2021 02:17:10 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:17:09 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 12/13] docs: path-lookup: update symlink description
Date:   Thu, 27 May 2021 17:16:17 +0800
Message-Id: <20210527091618.287093-13-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
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
index 3f03fbbc9429..9ac742530e46 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1200,16 +1200,15 @@ the code.
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
+   wasn't quite current enough.  If it's in RCU-walk ``-ECHILD`` will be returned
+   otherwise ``-ESTALE`` is returned.  When ``-ESTALE`` is returned, the caller may
+   retry with ``LOOKUP_REVAL`` flag set.
 
 3. An open with O_CREAT **does** follow a symlink in the final component,
    unlike other creation system calls (like ``mkdir``).  So the sequence::
@@ -1219,8 +1218,8 @@ the code.
 
    will create a file called ``/tmp/bar``.  This is not permitted if
    ``O_EXCL`` is set but otherwise is handled for an O_CREAT open much
-   like for a non-creating open: ``should_follow_link()`` returns ``1``, and
-   so does ``do_last()`` so that ``trailing_symlink()`` gets called and the
+   like for a non-creating open: ``lookup_last()`` or ``open_last_lookup()``
+   returns a non ``NULL`` value, and ``link_path_walk()`` gets called and the
    open process continues on the symlink that was found.
 
 Updating the access time
-- 
2.31.1

