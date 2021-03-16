Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B638A33CD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhCPFs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbhCPFrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:47:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A1CC06174A;
        Mon, 15 Mar 2021 22:47:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id o3so3403308pfh.11;
        Mon, 15 Mar 2021 22:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxyyFVinOdnmATR501q3cbcH2hSQV1F8Z0mtVnYBaQo=;
        b=TiPgWgRWyZ3ZoiKMiDvkOVoErbirvwIvZVSG3pWImPUnV5nrW6XZFMUXwet3QQ+is8
         ZC8wfTJYu7LL+l5PX7PYMeSDH/wZ5KlLCrOSKObmiqkGOd+yUDCkUqm+yN+akNVNI1uu
         Yfl75gN/0XjPY9sNXf2lAfRDnbv6kfCKZEGMMvFma2DChoWPPPhe9Jp9yMIf3dpNGXYv
         /a593P84nZPM9z+i8nLGnDcffigmzqnOzd3WZE5w8iq31Dy4tD007ZeKTTdnfa9Hc1E9
         YupcKaNHhOeQHiCqksPB6A3yivIgyVJzwPugvgISWeZjtuP1YV2g1vPKtrccY0rGaQRl
         F8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxyyFVinOdnmATR501q3cbcH2hSQV1F8Z0mtVnYBaQo=;
        b=Q1x5VkEPjPq+paY+vOghagRLmEMu3ZO9WAcTi4WoKFNg1ZqvoWuulBspsyFhqEFCsq
         G71ouEi8+pYxisFJT3oztbmspZzgNp3aS63n1s1kqj7l4tVl+daZ6jx9VMz99re75ptv
         j7jFf7BOIT0IytCsICLEW5x6BFwdZ/rdhtBZgqgRx9+a8QE85C3u/qlVhXNSZKH6k8e9
         xhCNe0MCteNSYQm6JkEwIlA5MH1cbb+90JSAAh37Wx9phJUlMo95RphGdYve6jb0sHO0
         MuL8JFzPZGHhDha3TsjtB512kbOsKCMgjUUvIr8US/GET1B6VrQqrC1f8r2H3GHcexuW
         JaKw==
X-Gm-Message-State: AOAM5311yIhOpl/gjNOofLZzOwAZeKKE93p9ys+LUvWRfxPGqXqKLSGk
        n9YtlrOMiRvJXubUkZkyUsg=
X-Google-Smtp-Source: ABdhPJy/CzYjC7mWEyMZmuf/ctFYq8b9VaqUXwTf1jgwaAT6TVJF+1NjSp7qSQQjCbahEQlDxTxuTw==
X-Received: by 2002:a63:3806:: with SMTP id f6mr2354722pga.239.1615873672201;
        Mon, 15 Mar 2021 22:47:52 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:47:51 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 04/12] docs: path-lookup: update do_last() part
Date:   Tue, 16 Mar 2021 13:47:19 +0800
Message-Id: <20210316054727.25655-5-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

traling_symlink() was merged into lookup_last, do_last().

do_last() has later been split into open_last_lookups()
and do_open().

see related commit: commit c5971b8c6354 ("take post-lookup
part of do_last() out of loop")

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 35 ++++++++++++-----------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index b6a301b78121..a65cb477d524 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -495,11 +495,11 @@ This is important when unmounting a filesystem that is inaccessible, such as
 one provided by a dead NFS server.
 
 Finally ``path_openat()`` is used for the ``open()`` system call; it
-contains, in support functions starting with "``do_last()``", all the
+contains, in support functions starting with "``open_last_lookups()``", all the
 complexity needed to handle the different subtleties of O_CREAT (with
 or without O_EXCL), final "``/``" characters, and trailing symbolic
 links.  We will revisit this in the final part of this series, which
-focuses on those symbolic links.  "``do_last()``" will sometimes, but
+focuses on those symbolic links.  "``open_last_lookups()``" will sometimes, but
 not always, take ``i_rwsem``, depending on what it finds.
 
 Each of these, or the functions which call them, need to be alert to
@@ -1199,26 +1199,27 @@ symlink.
 This case is handled by the relevant caller of ``link_path_walk()``, such as
 ``path_lookupat()`` using a loop that calls ``link_path_walk()``, and then
 handles the final component.  If the final component is a symlink
-that needs to be followed, then ``trailing_symlink()`` is called to set
-things up properly and the loop repeats, calling ``link_path_walk()``
-again.  This could loop as many as 40 times if the last component of
-each symlink is another symlink.
+that needs to be followed, then ``open_last_lookups()`` is
+called to set things up properly and the loop repeats, calling
+``link_path_walk()`` again.  This could loop as many as 40 times if the last
+component of each symlink is another symlink.
 
 The various functions that examine the final component and possibly
-report that it is a symlink are ``lookup_last()``, ``mountpoint_last()``
-and ``do_last()``, each of which use the same convention as
-``walk_component()`` of returning ``1`` if a symlink was found that needs
-to be followed.
+report that it is a symlink are ``lookup_last()``, ``open_last_lookups()``
+, each of which use the same convention as
+``walk_component()`` of returning ``char *name`` if a symlink was found that
+needs to be followed.
 
-Of these, ``do_last()`` is the most interesting as it is used for
-opening a file.  Part of ``do_last()`` runs with ``i_rwsem`` held and this
-part is in a separate function: ``lookup_open()``.
+Of these, ``open_last_lookups()`` is the most interesting as it works in tandem
+with ``do_open()`` for opening a file.  Part of ``open_last_lookups()`` runs
+with ``i_rwsem`` held and this part is in a separate function: ``lookup_open()``.
 
-Explaining ``do_last()`` completely is beyond the scope of this article,
-but a few highlights should help those interested in exploring the
-code.
+Explaining ``open_last_lookups()`` and ``do_open()`` completely is beyond the scope
+of this article, but a few highlights should help those interested in exploring
+the code.
 
-1. Rather than just finding the target file, ``do_last()`` needs to open
+1. Rather than just finding the target file, ``do_open()`` is used after
+   ``open_last_lookup()`` to open
    it.  If the file was found in the dcache, then ``vfs_open()`` is used for
    this.  If not, then ``lookup_open()`` will either call ``atomic_open()`` (if
    the filesystem provides it) to combine the final lookup with the open, or
-- 
2.30.2

