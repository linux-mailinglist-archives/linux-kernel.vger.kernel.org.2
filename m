Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB9392A90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhE0JTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhE0JSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0326C061342;
        Thu, 27 May 2021 02:17:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x18so93906pfi.9;
        Thu, 27 May 2021 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ycQuw5lJgMDSiU4pSWrkILR0Fd0fRnytLlB84SZAaLI=;
        b=qGdx17I4au25+431KZdz6Vjr3iaVXl1xA67//rP3gmwUfaBmcBNiWRYqskprcn9LTH
         j84KtsxhdO4H53w3zMnqmuFzRpEg4HTjedVOdxVLec8fEws6wapqUnxUqcwzJaHrLy6z
         z21tO/miwPgyxw56uayrK99PeQcdMo/Aw88v8bR9T2aQtLbm30DQrKeJeoHSPYF1ljBK
         3U3Viz3LtEyj3k/dCWHtJ48tiXLyfDdBx1Ap4PAhpw2qpwZeQiOBMdEDT81nR4arf0DQ
         Cpsp6ejtwWfu86LzGdlg+wJT6WGY8VCtTx5i1Iv6lqNUi3BKEU0UvukQaxvAqY6HBp4o
         9fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycQuw5lJgMDSiU4pSWrkILR0Fd0fRnytLlB84SZAaLI=;
        b=W4m/xshxmuEvpwd8HHaJapl7JylAgfu2PNhvy/IkDrJBMBtgvtEVyQm0PLbUWgOBNg
         mIXhTGWYzDxjkDAgD5/7v3ZLJ+ej1kLSOZ19tbspZqABvrHChHF+yID6koRtAKbSwsQz
         fOg6qBr1UAaUtM6Vv6hnrRPbdyruw6rmIYJfyjqMYsve5mIL7NxoTouRrKv55qHNkOPR
         7S19yDFBKU3jsmfu24IPgoFT8m5/UDCq0BMESQV4m8+6YrXLYJ1nOJyRnMnrylzM9y5l
         /dwLYjktwJvfKAaMHiRqTtP1EJ2qM0oQNVTAwILaFEUmO27XVPX5mJ4TlGWDOPoe1gaG
         JnjQ==
X-Gm-Message-State: AOAM533ugigXPe9LTreR+bDCy2A+Rp45nahYjaQTtZH/wpDrYmNMRVQe
        0nOl2aTH+HUh81Iv/fbEKDA=
X-Google-Smtp-Source: ABdhPJyOPzxugJL9IuWwqhhlfiFxdLTPVEuF8AOImRHz+Zjgyx3JwzpJB0kErexwdD+GdiIdbuytwg==
X-Received: by 2002:aa7:868e:0:b029:2ca:ea6a:71a1 with SMTP id d14-20020aa7868e0000b02902caea6a71a1mr2845368pfo.32.1622107027494;
        Thu, 27 May 2021 02:17:07 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:17:07 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 10/13] docs: path-lookup: update WALK_GET, WALK_PUT desc
Date:   Thu, 27 May 2021 17:16:15 +0800
Message-Id: <20210527091618.287093-11-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WALK_GET is changed to WALK_TRAILING with a different meaning.
Here it should be WALK_NOFOLLOW. WALK_PUT dosn't exist, we have
WALK_MORE.

WALK_PUT == !WALK_MORE

And there is not should_follow_link().

Related commits:
commit 8c4efe22e7c4 ("namei: invert the meaning of WALK_FOLLOW")
commit 1c4ff1a87e46 ("namei: invert WALK_PUT logics")

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 0a125673a8fe..08e6306af5b1 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1123,13 +1123,13 @@ stack in ``walk_component()`` immediately when the symlink is found;
 old symlink as it walks that last component.  So it is quite
 convenient for ``walk_component()`` to release the old symlink and pop
 the references just before pushing the reference information for the
-new symlink.  It is guided in this by two flags; ``WALK_GET``, which
-gives it permission to follow a symlink if it finds one, and
-``WALK_PUT``, which tells it to release the current symlink after it has been
-followed.  ``WALK_PUT`` is tested first, leading to a call to
-``put_link()``.  ``WALK_GET`` is tested subsequently (by
-``should_follow_link()``) leading to a call to ``pick_link()`` which sets
-up the stack frame.
+new symlink.  It is guided in this by three flags: ``WALK_NOFOLLOW`` which
+forbits it from following a symlink if it finds one, ``WALK_MORE``
+which indicates that it is yet too early to release the
+current symlink, and ``WALK_TRAILING`` which predicates that it is on the final
+component of the lookup, so we will check userspace flag ``LOOKUP_FOLLOW`` to
+decide whether follow it when it is a symlink and call ``may_follow_link()`` to
+check if we have privilege to follow it.
 
 Symlinks with no final component
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.31.1

