Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF933CD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhCPFsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbhCPFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:48:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB8EC06174A;
        Mon, 15 Mar 2021 22:48:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c16so16445529ply.0;
        Mon, 15 Mar 2021 22:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAcKCPFkG11DboB2nf9szc28nxZUiI//0Byb5oi70DY=;
        b=Z1EIvGo2Klccv6EAzBLvOz3Wl5iFUbcMkJuO4Zdc6voXh67QzNl7qwF6AjCT7sJPEy
         MhSbvD3rA1b9U6/RBavtp1lIWk6NqXmMUSP69dW+cBEzWpW5o1cNKhxNEOclgYcO4eR7
         tUVgCPRvBGIS6R2AIWRX5E1Dg72eP1dhxLJnq08qb3g+ZRzRrM95IKcq4PGj3AbN4UEi
         ge82UsgXytMkHcwzblAEVkwJuhpTgInD3k+3630ixslWSeCPcVsGs7i65frdJSPu0RzS
         WLqTThIXXURVIxS3/Vsy+1HjIBqAITT30UELepQNvlZf8YAwrcpK4DiyH4Cutizw4zJs
         N0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAcKCPFkG11DboB2nf9szc28nxZUiI//0Byb5oi70DY=;
        b=O1ZDbXUxC+0xRNyNMkrD+aa/ZeUy62h7ZJimRs/jtFrBVyn9E9fGo0Uyeyqra7Qeu1
         PRks3uJ0ahjHWdjEiDlOsIldQuL6y3IVE1RQajiZA6aOLXNccs+U3yQJwEa3P+ytyFyz
         Br+6MCJwCi1gMYjy3fNAQgESCjPnULAiY5h/eS1X1VmGahslZSf6fZmBKhFW8R//tVkF
         4/oFhfgFYCYpeXklJd5pm5mra2Og9tPNpPyvdApTEDHL1txwpQ19Po2lgCHfxCYpKr77
         f/akNFPojy4Y/1HXQfVZ580Xm7PnZWCCjxZRXQDsBJUwFPYgO7oerQeQ4gz2yI6WulZO
         e+CA==
X-Gm-Message-State: AOAM532p8GME1rfOhq0bG96G1sa89V7pQevX23YwyJgHAJog60CUfv6m
        V54g5nI5e9HH3gP6gnRVQiQ=
X-Google-Smtp-Source: ABdhPJzGtjdD1TOMCzEPE5zlWDsQhXZ72D5X0zYgZm7g+x4pucHiRSs6U7vK4jIKjo26GVtq0hodPw==
X-Received: by 2002:a17:90b:100a:: with SMTP id gm10mr3047441pjb.0.1615873681177;
        Mon, 15 Mar 2021 22:48:01 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:48:00 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 11/12] docs: path-lookup: update get_link() ->follow_link description
Date:   Tue, 16 Mar 2021 13:47:26 +0800
Message-Id: <20210316054727.25655-12-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
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
index abd0153e2415..eef6e9f68fba 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1134,10 +1134,10 @@ Symlinks with no final component
 
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
@@ -1154,12 +1154,11 @@ something that looks like a symlink.  It is really a reference to the
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
+returns ``0``.  Again there is no final component and ``pick_link()``
+returns NULL.
 
 Following the symlink in the final component
 --------------------------------------------
-- 
2.30.2

