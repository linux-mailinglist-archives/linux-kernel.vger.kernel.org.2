Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03649392A80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhE0JSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhE0JSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:32 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E45C061761;
        Thu, 27 May 2021 02:16:59 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m190so3244594pga.2;
        Thu, 27 May 2021 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pl1MUOKmyHKv9H0x7bDDoRYW/L3rmWuoyjqpHT96rrA=;
        b=bZOww6I94JEmwXuMn21MLM8rKOqIR+A29HVrkmzgXsi8IOarpjIBExzFmJXno33QFv
         XES11DyfV06XzqBom3+gP+hM/EGFomu7z5o6zI8NMk5O9dW2o9NnlLcs2ub9PrxOg3AJ
         rH3rKT0hajbyAV6L8965HvU3nX4J0AebTxtunJriw5/e+rKhn6FnWNhj1iIMuJSW1SvJ
         aknNxpuL6T9UJ+fe5xa5zKU3J8cSwoLk3mjnziufEJus0EFuDras8DSGCMkPLvXDhyE5
         DoN2OpH0XIMdLHkWAjrqM23Di3NpLk1JYqUQ5feBqPAyf30vg4nmfOnRuaI1uvSzBZo0
         1CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pl1MUOKmyHKv9H0x7bDDoRYW/L3rmWuoyjqpHT96rrA=;
        b=qkoiZSAlEC+Bim340L/8ukinZI+VXenEHDnJoimXE2M0iAV2PzV2ddI5j3RnQaUfrS
         A2GSYJURERn6FscrwwV1pyOiZLHP+lMa7yyGKnWDKn8gHW+K6brIZnFyQvA7F7eF8/o0
         lEgvczPL7QDLeo6AwXh5j6UIgQ9vwZLamWY6HZTdfyiOIpvfyFZlO7NLgDggyi610pzr
         FB2XTYjLVj8ZF4UQZuqo9YZI3TF8iWOu0KRpjhTi/nrWpPzqUc0khymJstgXt5m85yDA
         tWA05U57VIw/M5Q4JEt7oDO+ZEBrqV7ALcnvmkcMO58jb8BMYCDSBV1CRGg9uHVODRO8
         ClOg==
X-Gm-Message-State: AOAM533hcWohkLums7TLpDa6dm+72ThKuqK69BhTgfCfrz0JRW5pX6DP
        cEtH0YObkA3olgRfw3x2Jdw=
X-Google-Smtp-Source: ABdhPJy75NEo/iDbRDIGtVTy1oUE/mP/SwVCeO3H4V22JI5DAc/fpry1VjFiuwhV8cxiglC89GW5vA==
X-Received: by 2002:aa7:8686:0:b029:2db:7eea:8fb4 with SMTP id d6-20020aa786860000b02902db7eea8fb4mr2451317pfo.34.1622107018448;
        Thu, 27 May 2021 02:16:58 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:16:57 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 04/13] docs: path-lookup: update do_last() part
Date:   Thu, 27 May 2021 17:16:09 +0800
Message-Id: <20210527091618.287093-5-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
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
 Documentation/filesystems/path-lookup.rst | 47 +++++++++++------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 652d3284f178..2b0b33168067 100644
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
@@ -1196,29 +1196,26 @@ potentially need to call ``link_path_walk()`` again and again on
 successive symlinks until one is found that doesn't point to another
 symlink.
 
-This case is handled by the relevant caller of ``link_path_walk()``, such as
-``path_lookupat()`` using a loop that calls ``link_path_walk()``, and then
-handles the final component.  If the final component is a symlink
-that needs to be followed, then ``trailing_symlink()`` is called to set
-things up properly and the loop repeats, calling ``link_path_walk()``
-again.  This could loop as many as 40 times if the last component of
-each symlink is another symlink.
-
-The various functions that examine the final component and possibly
-report that it is a symlink are ``lookup_last()``, ``mountpoint_last()``
-and ``do_last()``, each of which use the same convention as
-``walk_component()`` of returning ``1`` if a symlink was found that needs
-to be followed.
-
-Of these, ``do_last()`` is the most interesting as it is used for
-opening a file.  Part of ``do_last()`` runs with ``i_rwsem`` held and this
-part is in a separate function: ``lookup_open()``.
-
-Explaining ``do_last()`` completely is beyond the scope of this article,
-but a few highlights should help those interested in exploring the
-code.
-
-1. Rather than just finding the target file, ``do_last()`` needs to open
+This case is handled by relevant callers of ``link_path_walk()``, such as
+``path_lookupat()``, ``path_openat()`` using a loop that calls ``link_path_walk()``,
+and then handles the final component by calling ``open_last_lookups()`` or
+``lookup_last()``. If it is a symlink that needs to be followed,
+``open_last_lookups()`` or ``lookup_last()`` will set things up properly and
+return the path so that the loop repeats, calling
+``link_path_walk()`` again.  This could loop as many as 40 times if the last
+component of each symlink is another symlink.
+
+Of the various functions that examine the final component, 
+``open_last_lookups()`` is the most interesting as it works in tandem
+with ``do_open()`` for opening a file.  Part of ``open_last_lookups()`` runs
+with ``i_rwsem`` held and this part is in a separate function: ``lookup_open()``.
+
+Explaining ``open_last_lookups()`` and ``do_open()`` completely is beyond the scope
+of this article, but a few highlights should help those interested in exploring
+the code.
+
+1. Rather than just finding the target file, ``do_open()`` is used after
+   ``open_last_lookup()`` to open
    it.  If the file was found in the dcache, then ``vfs_open()`` is used for
    this.  If not, then ``lookup_open()`` will either call ``atomic_open()`` (if
    the filesystem provides it) to combine the final lookup with the open, or
-- 
2.31.1

