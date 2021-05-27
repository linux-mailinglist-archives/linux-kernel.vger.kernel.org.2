Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76A392A94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhE0JT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbhE0JSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C306C0613CE;
        Thu, 27 May 2021 02:17:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y15so78902pfn.13;
        Thu, 27 May 2021 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1+1FqXq8ODa3C2JtLguU7XlZkbtOWoUVwxH6nm0OaM=;
        b=nD1a+XOjJb+8Rf741FwA55Co2oYO0t3e1Dlb2leqwIHciAHi5+5QduDNB3li2FvVyo
         IIemFeF37griuxIBAwnC7TY5ri9/oayyXtPglOj0a/4diM+MoZEkVFS+q+SX/cZukgUI
         ZoNYUJfljXNVwgM7GfE1vKngF7dt3s4gRrkRpY2VmYfFdH/XIuJ60e9jF+hgsBSMXC0M
         wsfu00rsGEx5WRR/wX8174SFWi/7G6SU/vKbOidCWPqGKhGM+xUEYN465AJ+Dq3iutBT
         5r+FLf5/4rISAF18rkN8TuSWt055XXXbSMWi5ZyiO5evny7gBwWlsjNohbqTOyM9xV1Z
         cgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1+1FqXq8ODa3C2JtLguU7XlZkbtOWoUVwxH6nm0OaM=;
        b=Q9XKul9BNcNEHgTOLksGjkAmksRww966Zbz8PvH7bavCeiIjHncCkmpKFH0VmC/s0n
         vjxUiGf6TT18UhI+Vb1Xu5h2xzRaMjaOyOBd2ypt5JZnpJ6CU1j/ML4+7pcS8vZZQdgY
         5vZWHh4sIOTqrr+zmkbW2kJ85IeyYF3E8biIHfelMAwyBX7vNpJGxPh81onDvAht+fkO
         pK08u90kVZKf+TuV25sKR2XHe4/sd+s3AttSzPXJNNUYXeGMFaU2SULHRXKfrksJCtyl
         Z0p2pZO2J/HAlHjj0EiImdxs4REo1I0WMVrzvIG0Oll7BI1EBAq8ckk0Rd6D6WDJQUKj
         6Bsw==
X-Gm-Message-State: AOAM530s4WfZK4H3kg9wzSgJHytuCzW2h5tOI4hCNXOqN5PL1uR+DgPc
        JsJ4pjGxSxPJX0OvUOlgYKA=
X-Google-Smtp-Source: ABdhPJzMbhMos/ABkfyWECP2JJuDa3pNltfFFyEgkPLyRTyX1i2LVvQ1nnWio3XI/CvP0iCFE17g0g==
X-Received: by 2002:a62:2e81:0:b029:2db:1e53:678a with SMTP id u123-20020a622e810000b02902db1e53678amr2738314pfu.36.1622107031956;
        Thu, 27 May 2021 02:17:11 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:17:11 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 13/13] docs: path-lookup: use bare function() rather than literals
Date:   Thu, 27 May 2021 17:16:18 +0800
Message-Id: <20210527091618.287093-14-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Matthew Wilcox and Jonathan Corbet, drop ``...``
literals around function names of this patchset.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 70 +++++++++++------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 9ac742530e46..33d58fca662a 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -450,13 +450,13 @@ If that doesn't get a good result, it calls "``lookup_slow()``" which
 takes ``i_rwsem``, rechecks the cache, and then asks the filesystem
 to find a definitive answer.
 
-As the last step of ``walk_component()``, ``step_into()`` will be called either
+As the last step of walk_component(), step_into() will be called either
 directly from walk_component() or from handle_dots().  It calls
-``handle_mounts()``, to check and handle mount points, in which a new
+handle_mounts(), to check and handle mount points, in which a new
 ``struct path`` is created containing a counted reference to the new dentry and
 a reference to the new ``vfsmount`` which is only counted if it is
 different from the previous ``vfsmount``. Then if there is
-a symbolic link, ``step_into()`` calls ``pick_link()`` to deal with it,
+a symbolic link, step_into() calls pick_link() to deal with it,
 otherwise it installs the new ``struct path`` in the ``struct nameidata``, and
 drops the unneeded references.
 
@@ -472,8 +472,8 @@ Handling the final component
 ``nd->last_type`` to refer to the final component of the path.  It does
 not call ``walk_component()`` that last time.  Handling that final
 component remains for the caller to sort out. Those callers are
-``path_lookupat()``, ``path_parentat()`` and
-``path_openat()`` each of which handles the differing requirements of
+path_lookupat(), path_parentat() and
+path_openat() each of which handles the differing requirements of
 different system calls.
 
 ``path_parentat()`` is clearly the simplest - it just wraps a little bit
@@ -489,17 +489,17 @@ object is wanted such as by ``stat()`` or ``chmod()``.  It essentially just
 calls ``walk_component()`` on the final component through a call to
 ``lookup_last()``.  ``path_lookupat()`` returns just the final dentry.
 It is worth noting that when flag ``LOOKUP_MOUNTPOINT`` is set,
-``path_lookupat()`` will unset LOOKUP_JUMPED in nameidata so that in the
-subsequent path traversal ``d_weak_revalidate()`` won't be called.
+path_lookupat() will unset LOOKUP_JUMPED in nameidata so that in the
+subsequent path traversal d_weak_revalidate() won't be called.
 This is important when unmounting a filesystem that is inaccessible, such as
 one provided by a dead NFS server.
 
 Finally ``path_openat()`` is used for the ``open()`` system call; it
-contains, in support functions starting with "``open_last_lookups()``", all the
+contains, in support functions starting with "open_last_lookups()", all the
 complexity needed to handle the different subtleties of O_CREAT (with
 or without O_EXCL), final "``/``" characters, and trailing symbolic
 links.  We will revisit this in the final part of this series, which
-focuses on those symbolic links.  "``open_last_lookups()``" will sometimes, but
+focuses on those symbolic links.  "open_last_lookups()" will sometimes, but
 not always, take ``i_rwsem``, depending on what it finds.
 
 Each of these, or the functions which call them, need to be alert to
@@ -651,9 +651,9 @@ RCU-walk finds it cannot stop gracefully, it simply gives up and
 restarts from the top with REF-walk.
 
 This pattern of "try RCU-walk, if that fails try REF-walk" can be
-clearly seen in functions like ``filename_lookup()``,
-``filename_parentat()``,
-``do_filp_open()``, and ``do_file_open_root()``.  These four
+clearly seen in functions like filename_lookup(),
+filename_parentat(),
+do_filp_open(), and do_file_open_root().  These four
 correspond roughly to the three ``path_*()`` functions we met earlier,
 each of which calls ``link_path_walk()``.  The ``path_*()`` functions are
 called using different mode flags until a mode is found which works.
@@ -1069,8 +1069,8 @@ all the data structures it references are safe to be accessed while
 holding no counted reference, only the RCU lock. A callback
 ``struct delayed_called`` will be passed to ``->get_link()``:
 file systems can set their own put_link function and argument through
-``set_delayed_call()``. Later on, when VFS wants to put link, it will call
-``do_delayed_call()`` to invoke that callback function with the argument.
+set_delayed_call(). Later on, when VFS wants to put link, it will call
+do_delayed_call() to invoke that callback function with the argument.
 
 In order for the reference to each symlink to be dropped when the walk completes,
 whether in RCU-walk or REF-walk, the symlink stack needs to contain,
@@ -1103,7 +1103,7 @@ doesn't need to notice.  Getting this ``name`` variable on and off the
 stack is very straightforward; pushing and popping the references is
 a little more complex.
 
-When a symlink is found, ``walk_component()`` calls ``pick_link()`` via ``step_into()``
+When a symlink is found, walk_component() calls pick_link() via step_into()
 which returns the link from the filesystem.
 Providing that operation is successful, the old path ``name`` is placed on the
 stack, and the new value is used as the ``name`` for a while.  When the end of
@@ -1136,10 +1136,10 @@ Symlinks with no final component
 
 A pair of special-case symlinks deserve a little further explanation.
 Both result in a new ``struct path`` (with mount and dentry) being set
-up in the ``nameidata``, and result in ``pick_link()`` returning ``NULL``.
+up in the ``nameidata``, and result in pick_link() returning ``NULL``.
 
 The more obvious case is a symlink to "``/``".  All symlinks starting
-with "``/``" are detected in ``pick_link()`` which resets the ``nameidata``
+with "``/``" are detected in pick_link() which resets the ``nameidata``
 to point to the effective filesystem root.  If the symlink only
 contains "``/``" then there is nothing more to do, no components at all,
 so ``NULL`` is returned to indicate that the symlink can be released and
@@ -1157,9 +1157,9 @@ target file, not just the name of it.  When you ``readlink`` these
 objects you get a name that might refer to the same file - unless it
 has been unlinked or mounted over.  When ``walk_component()`` follows
 one of these, the ``->get_link()`` method in "procfs" doesn't return
-a string name, but instead calls ``nd_jump_link()`` which updates the
+a string name, but instead calls nd_jump_link() which updates the
 ``nameidata`` in place to point to that target.  ``->get_link()`` then
-returns ``NULL``.  Again there is no final component and ``pick_link()``
+returns ``NULL``.  Again there is no final component and pick_link()
 returns ``NULL``.
 
 Following the symlink in the final component
@@ -1177,35 +1177,35 @@ potentially need to call ``link_path_walk()`` again and again on
 successive symlinks until one is found that doesn't point to another
 symlink.
 
-This case is handled by relevant callers of ``link_path_walk()``, such as
-``path_lookupat()``, ``path_openat()`` using a loop that calls ``link_path_walk()``,
-and then handles the final component by calling ``open_last_lookups()`` or
-``lookup_last()``. If it is a symlink that needs to be followed,
-``open_last_lookups()`` or ``lookup_last()`` will set things up properly and
+This case is handled by relevant callers of link_path_walk(), such as
+path_lookupat(), path_openat() using a loop that calls link_path_walk(),
+and then handles the final component by calling open_last_lookups() or
+lookup_last(). If it is a symlink that needs to be followed,
+open_last_lookups() or lookup_last() will set things up properly and
 return the path so that the loop repeats, calling
-``link_path_walk()`` again.  This could loop as many as 40 times if the last
+link_path_walk() again.  This could loop as many as 40 times if the last
 component of each symlink is another symlink.
 
 Of the various functions that examine the final component, 
-``open_last_lookups()`` is the most interesting as it works in tandem
-with ``do_open()`` for opening a file.  Part of ``open_last_lookups()`` runs
-with ``i_rwsem`` held and this part is in a separate function: ``lookup_open()``.
+open_last_lookups() is the most interesting as it works in tandem
+with do_open() for opening a file.  Part of open_last_lookups() runs
+with ``i_rwsem`` held and this part is in a separate function: lookup_open().
 
-Explaining ``open_last_lookups()`` and ``do_open()`` completely is beyond the scope
+Explaining open_last_lookups() and do_open() completely is beyond the scope
 of this article, but a few highlights should help those interested in exploring
 the code.
 
-1. Rather than just finding the target file, ``do_open()`` is used after
-   ``open_last_lookup()`` to open
+1. Rather than just finding the target file, do_open() is used after
+   open_last_lookup() to open
    it.  If the file was found in the dcache, then ``vfs_open()`` is used for
    this.  If not, then ``lookup_open()`` will either call ``atomic_open()`` (if
    the filesystem provides it) to combine the final lookup with the open, or
    will perform the separate ``i_op->lookup()`` and ``i_op->create()`` steps
    directly.  In the later case the actual "open" of this newly found or
-   created file will be performed by ``vfs_open()``, just as if the name
+   created file will be performed by vfs_open(), just as if the name
    were found in the dcache.
 
-2. ``vfs_open()`` can fail with ``-EOPENSTALE`` if the cached information
+2. vfs_open() can fail with ``-EOPENSTALE`` if the cached information
    wasn't quite current enough.  If it's in RCU-walk ``-ECHILD`` will be returned
    otherwise ``-ESTALE`` is returned.  When ``-ESTALE`` is returned, the caller may
    retry with ``LOOKUP_REVAL`` flag set.
@@ -1218,8 +1218,8 @@ the code.
 
    will create a file called ``/tmp/bar``.  This is not permitted if
    ``O_EXCL`` is set but otherwise is handled for an O_CREAT open much
-   like for a non-creating open: ``lookup_last()`` or ``open_last_lookup()``
-   returns a non ``NULL`` value, and ``link_path_walk()`` gets called and the
+   like for a non-creating open: lookup_last() or open_last_lookup()
+   returns a non ``NULL`` value, and link_path_walk() gets called and the
    open process continues on the symlink that was found.
 
 Updating the access time
-- 
2.31.1

