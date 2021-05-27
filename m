Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF6F392A91
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhE0JTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbhE0JSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DFBC061344;
        Thu, 27 May 2021 02:17:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso2004100pjq.3;
        Thu, 27 May 2021 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m47+SByEomOIw6gZ3A/L3DUtO8TJBgUjiYsZGMh3mRI=;
        b=geEfjU2mQdRGh6JJDCUvFRHmv1msIsyaNJuChNsH0dVqHFoBm30P/Sz/n+6G5uEtzG
         mXdRRUevCtlyaYnlT9utZNY1UqnIk/OYvbcm1loj3xnNhK1kORGGhGyCil75sRsORVHx
         2h4icpqpszt/n9Fe122zcItn6iPM8Ywy3gN6TTV/n5DWTKs5iHJUNKPvSIStGhtqZLrt
         VjkOAVo0yUaVvNc2/bSUy7QqgS9bkUXu04Q11Z10Bi889q+/UPvOxHbiIlnArcRaS9p6
         sRkd7rur5RnO1nRHFkegKSLcKKQCIWG6YFPi0GNHzwXg3Z6r8MNq9JNBeUoa/7nfAGKf
         huEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m47+SByEomOIw6gZ3A/L3DUtO8TJBgUjiYsZGMh3mRI=;
        b=Zy0+K7MlIDAVYU0f8BPc80N69Fza0kRRBNr6BMOcGd3sllDpqhZpqC1TLBOAZkzBr2
         JDh2gBNcM3C9t7ABcynT0KHeZtzICTqCulJB7p5B/rOfp+tkvPS5hhsXdcYwsZqH/JgM
         ZtZY3b4ZQp0WckRpPLOk3qmepFG47X1n/FtBFm9ntz1ViRT8zqBULPPVaQ7tfRzp2kOW
         3/39U+zc62ipUFFgV5mDUrqEO4HOEUiIa8H/cfq+p7qOTv7vRUnjsejN9YNsZPnCPb/E
         +ZyLZNaPN1rnXPUl6m/AbxdZllVpV7Cot3dzSSRUe0kq807PIL+IjLPmVYgGoqiSvgSW
         eVuw==
X-Gm-Message-State: AOAM533I+kL9GeSQQr3F2zuyPtNWRb7kd4MBUhb+skrKUzY+ErA6Y0lj
        QxWKLsyQR8rmTEU+d1JhODI=
X-Google-Smtp-Source: ABdhPJynf2ID5R8Rgq9UDcldOYYqz+2uNJsCmUx2L3E60e5Cp1EisN1QL9rKsyoe5b0novt9G7WXLQ==
X-Received: by 2002:a17:902:fe97:b029:ef:9419:b91c with SMTP id x23-20020a170902fe97b02900ef9419b91cmr2489136plm.21.1622107028869;
        Thu, 27 May 2021 02:17:08 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:17:08 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 11/13] docs: path-lookup: update get_link() ->follow_link description
Date:   Thu, 27 May 2021 17:16:16 +0800
Message-Id: <20210527091618.287093-12-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_link() is merged into pick_link(). i_op->follow_link is
replaced with i_op->get_link(). get_link() can return ERR_PTR(0)
which equals NULL.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 08e6306af5b1..3f03fbbc9429 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1136,10 +1136,10 @@ Symlinks with no final component
 
 A pair of special-case symlinks deserve a little further explanation.
 Both result in a new ``struct path`` (with mount and dentry) being set
-up in the ``nameidata``, and result in ``get_link()`` returning ``NULL``.
+up in the ``nameidata``, and result in ``pick_link()`` returning ``NULL``.
 
 The more obvious case is a symlink to "``/``".  All symlinks starting
-with "``/``" are detected in ``get_link()`` which resets the ``nameidata``
+with "``/``" are detected in ``pick_link()`` which resets the ``nameidata``
 to point to the effective filesystem root.  If the symlink only
 contains "``/``" then there is nothing more to do, no components at all,
 so ``NULL`` is returned to indicate that the symlink can be released and
@@ -1156,12 +1156,11 @@ something that looks like a symlink.  It is really a reference to the
 target file, not just the name of it.  When you ``readlink`` these
 objects you get a name that might refer to the same file - unless it
 has been unlinked or mounted over.  When ``walk_component()`` follows
-one of these, the ``->follow_link()`` method in "procfs" doesn't return
+one of these, the ``->get_link()`` method in "procfs" doesn't return
 a string name, but instead calls ``nd_jump_link()`` which updates the
-``nameidata`` in place to point to that target.  ``->follow_link()`` then
-returns ``NULL``.  Again there is no final component and ``get_link()``
-reports this by leaving the ``last_type`` field of ``nameidata`` as
-``LAST_BIND``.
+``nameidata`` in place to point to that target.  ``->get_link()`` then
+returns ``NULL``.  Again there is no final component and ``pick_link()``
+returns ``NULL``.
 
 Following the symlink in the final component
 --------------------------------------------
-- 
2.31.1

