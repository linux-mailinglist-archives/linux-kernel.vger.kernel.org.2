Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF4392A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhE0JTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbhE0JSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10A8C06138E;
        Thu, 27 May 2021 02:17:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f8so108052pjh.0;
        Thu, 27 May 2021 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDudRqbN4KMiYnUlaC27vKXaZtzg154lgxgDYGq9+eA=;
        b=LFO36YKIyXwrUd4aJ7XRacUUZegsf0PpI03rA9TjWIT02VoUU89ldLbXk0jdC8o2LV
         PL+lHLGVcFFj2PBpyH51DkLWwJSrv0xiODNkSVK31uJ5Yzx3Woi432JqIFFZqq39MHwm
         fTCGxdZcV4MLT00Mlg2QkQDpVjt7oyNbyVeecx63ANGtTQiIInl659kp/Z7tIVE85CHK
         zFYvbf8p8PM9xyachv7+ItWBSEANqi0N6p6TyIx4xl4klFygjhqduBNc0O1Lo2PXJZy1
         wmkGTY44VcJ+qVKDAZSSBIbanA3r1YjpheIMV2GYhPDwdwAHFVGUO12uviQe2kx1UDTg
         +uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDudRqbN4KMiYnUlaC27vKXaZtzg154lgxgDYGq9+eA=;
        b=AJUAkVY9rwVaMrp7x+Lw5n8xHFeqvgRm9ol7cCBmDNGiwfkV3GWTQ9SaHWMbUbOjZA
         W3qMUKTCQkGVC45CNgohIlT0eTUKQspV6PYDWNs/71hPS747dOhErbEuRNKj0ZzyRmGB
         YkbRZaj3Ay4YC1EirCnHh/IOTo/UZtcsbKDtu4y7abJs+7v8ZfMizjOIBHnqAEp3k9T7
         qQ0wTfbZesIj4J7jYfGOo32RQYWJ3iK13F/TzEkQx4SS3BMzZb5KzlqwOnfrrKXQ/gO6
         xMgFlgfjqEfrnUYe5I9CnmYANIUw/OZaJo6tsNI9io85+e9NlhL+Lda66kTEJ9yLTs3r
         Nqww==
X-Gm-Message-State: AOAM530RzoMLoxGHEoAvV1WHkydJkTc13KrmA5lSBZUubo7089/vU2/c
        UOsDlsVP4pIjQclAZbtgsbQ=
X-Google-Smtp-Source: ABdhPJxh7Dzd751PQjWDoOZzyJKsB2rm/j3gLzdNlHKREuL5SrLsLG1OzsEMIYVzeQqmfpgEVwnJLQ==
X-Received: by 2002:a17:90a:5142:: with SMTP id k2mr2381927pjm.5.1622107024483;
        Thu, 27 May 2021 02:17:04 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:17:04 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 08/13] docs: path-lookup: update i_op->put_link and cookie description
Date:   Thu, 27 May 2021 17:16:13 +0800
Message-Id: <20210527091618.287093-9-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No inode->put_link operation anymore. We use delayed_call to
deal with link destruction. Cookie has been replaced with
struct delayed_call.

Related commit: commit fceef393a538 ("switch ->get_link() to
delayed_call, kill ->put_link()")

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 30 ++++++-----------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 4650c6427963..3855809784cf 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1066,34 +1066,20 @@ method. This is called both in RCU-walk and REF-walk. In RCU-walk the
 RCU-walk.  Much like the ``i_op->permission()`` method we
 looked at previously, ``->get_link()`` would need to be careful that
 all the data structures it references are safe to be accessed while
-holding no counted reference, only the RCU lock.  Though getting a
-reference with ``->follow_link()`` is not yet done in RCU-walk mode, the
-code is ready to release the reference when that does happen.
-
-This need to drop the reference to a symlink adds significant
-complexity.  It requires a reference to the inode so that the
-``i_op->put_link()`` inode operation can be called.  In REF-walk, that
-reference is kept implicitly through a reference to the dentry, so
-keeping the ``struct path`` of the symlink is easiest.  For RCU-walk,
-the pointer to the inode is kept separately.  To allow switching from
-RCU-walk back to REF-walk in the middle of processing nested symlinks
-we also need the seq number for the dentry so we can confirm that
-switching back was safe.
-
-Finally, when providing a reference to a symlink, the filesystem also
-provides an opaque "cookie" that must be passed to ``->put_link()`` so that it
-knows what to free.  This might be the allocated memory area, or a
-pointer to the ``struct page`` in the page cache, or something else
-completely.  Only the filesystem knows what it is.
+holding no counted reference, only the RCU lock. A callback
+``struct delayed_called`` will be passed to ``->get_link()``:
+file systems can set their own put_link function and argument through
+``set_delayed_call()``. Later on, when VFS wants to put link, it will call
+``do_delayed_call()`` to invoke that callback function with the argument.
 
 In order for the reference to each symlink to be dropped when the walk completes,
 whether in RCU-walk or REF-walk, the symlink stack needs to contain,
 along with the path remnants:
 
-- the ``struct path`` to provide a reference to the inode in REF-walk
-- the ``struct inode *`` to provide a reference to the inode in RCU-walk
+- the ``struct path`` to provide a reference to the previous path
+- the ``const char *`` to provide a reference to the to previous name
 - the ``seq`` to allow the path to be safely switched from RCU-walk to REF-walk
-- the ``cookie`` that tells ``->put_path()`` what to put.
+- the ``struct delayed_call`` for later invocation.
 
 This means that each entry in the symlink stack needs to hold five
 pointers and an integer instead of just one pointer (the path
-- 
2.31.1

