Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B233CD87
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhCPFrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhCPFru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:47:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08533C06174A;
        Mon, 15 Mar 2021 22:47:50 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w34so20818068pga.8;
        Mon, 15 Mar 2021 22:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaW/5jMWrpRE5/klUKlEr8h3R9mtGHUDhpDZlEVBJMw=;
        b=Ntez148jN98HUoTqpM95H5ylBUaIXdypsXN+2eYrgFQ3G5dHJM2wbPis4gMga+tz2W
         k0lC1zLvYocjDj21m/lhhMKVx7MNkM7ZhE+zUW0hoOdUTB6glnkuJbouRKfHWI/NIa9M
         i1NV9nZxEnT9S6gEL7lEGk9b6W8BBL4T023vrZLB1bgUM0wsX6/shLeznydl0b5ExpDv
         C2iGRH3oxUii96q0h73baCjBUYoJHWF6Y5ZXK/Yys3EdweFdXT4RgZwElMUel6KMAFMV
         RkS7tbFaedDzUFQ6ahI6BFcB4LLxNv9gEScWZaf5e/jQ+t9jtJwzFVwS0HaC7SO29/Hf
         Mqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaW/5jMWrpRE5/klUKlEr8h3R9mtGHUDhpDZlEVBJMw=;
        b=AT7UBPhS/6Nj5d6Pp8eu73pXLDnfz9eY6dU/i8mm9mWHCu7h7/woND8S+s9dTINhCM
         Mz4eJJgE4uMp55z3xBAm/hscMohKUynXE06qm1LvFqP7BfQTZBlkBOyUXv8K7gn+9xd0
         eC0+9XW5yjnLR8nEqMJHL8mkSY6PxQpzulKJj4KboOrlHQc+0jZJlX7FBePg+ZC5ZHXG
         B5kdVA0eN2F06trk6BTr60KfvpBM8lQpICdttzw/Tgfb3c7PWA9DDwSEUAnkS77yvycy
         Wcwn6/f51sX9+eTQJOgczUrzAxvly6Sm//w7LFLCdOYUS3SHUeJST9PL4ZCZnl7o60J+
         4pSA==
X-Gm-Message-State: AOAM533ezoKSaV5Z3G4BsXxgEr/xfdc97zruHtTn6zUoHjG84TdSUaCg
        i9hHRM0CU+MrGEZQqUvWRfw=
X-Google-Smtp-Source: ABdhPJypY3ABjEWkRPANzmzj5T9ecFA1MbpNOkmpBKYYsNqeYBcwZUU5hJq9k6WRwNnXtLhByMer9A==
X-Received: by 2002:a63:d1c:: with SMTP id c28mr2344857pgl.113.1615873669408;
        Mon, 15 Mar 2021 22:47:49 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:47:49 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 02/12] docs: path-lookup: update path_to_nameidata() part
Date:   Tue, 16 Mar 2021 13:47:17 +0800
Message-Id: <20210316054727.25655-3-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
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
 Documentation/filesystems/path-lookup.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index d07766375e13..a29d714431a3 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -455,9 +455,10 @@ directly from walk_component() or from handle_dots().  It calls
 ``handle_mount()``, to check and handle mount points, in which a new
 ``struct path`` containing a counted reference to the new dentry and a
 reference to the new ``vfsmount`` which is only counted if it is
-different from the previous ``vfsmount``.  It then calls
-``path_to_nameidata()`` to install the new ``struct path`` in the
-``struct nameidata`` and drop the unneeded references.
+different from the previous ``vfsmount`` will be created. Then if there is
+symbolic link, ``step_into()`` calls ``pick_link()`` to deal with it, otherwise
+installs the new ``struct path`` in the ``struct nameidata`` and drop the
+unneeded references.
 
 This "hand-over-hand" sequencing of getting a reference to the new
 dentry before dropping the reference to the previous dentry may
-- 
2.30.2

