Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540CC31C3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 23:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBOV7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 16:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBOV67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 16:58:59 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6120C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 13:57:50 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so13673620ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 13:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wZJvIiq3Ed1jabdaDHfcdY3De/LneLLvMaYX01zmAAg=;
        b=vDM1O1mTMdZuKB3Fp7Vvkb8srDgTqgkArUaHOmqlpF8yhpkD1qNvfDQ3W4CVzgvgZs
         wNTGPTUUu0aCQ337Si+Ois2wh+Fxk6J43IUkQzE+tJgY/uZ3bTSNlN1Abvc9FnV0vp9y
         mAoT3QlUIz5AgoICh/2ehI0pYR9n6LQBnaUMmN6Xj7ikPcy+PXY8UjxqcOnHkXshl963
         XpBBUMbnbv5UaqJv2+McxUR/tz5ynGSfC137aSl8W7Nnf9caZTnU/JI5e/Qp44j3BtGY
         Wfejbo6EXBCn+YMmYLzwOPrBs4XegDgFFSOHWY5xYyTm4pCVwZdip9HBK1xB+rc4A4TV
         MPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wZJvIiq3Ed1jabdaDHfcdY3De/LneLLvMaYX01zmAAg=;
        b=J6WLSTwNBHthEzTj8Q85xSBVvZPY/QGVr7rObtyZ1NPOqOCMzYe4i8+ITJKs280FgV
         EdKhDKTb1O93oVo/qEwCr0FChGxnemikBac7E95Sy3RCvqUqc+3nVYRXUWI994KxuHKp
         eVvsLIi1k2rfYxak7MskWOIGx2KLrTWd5M2yIFNnhKrgcPWBZrOOS/fAwA0UZvRuoqiY
         S+E23g1gxduyOyiKZZAkI/qR8dV8z2GO4UiLD81TgOAGrZvFvJ+6z7cJuelx2AnN52TC
         qqll2UQNJFRb0b/GD3UujKuCtFoQeLICkUgC95R9km7X1e79DhdqjPw4fAvkZ2wrG5s6
         5xag==
X-Gm-Message-State: AOAM530OuIXyHJ/LYE/4/QEaA47uUNaT8E7e2DoZN40i0sVD9SpH5UEd
        /0KAl+XdtqkAGklbhEErXUqfV0RJyE7HoOgzHdsW
X-Google-Smtp-Source: ABdhPJxilRQvUaZKed8QSlP5ewVgT0/coAnH9EKex1Mf+tJHJSqmzycPvKi002dEwuYsJzFjkqar40LXkZ/99vbAaZY=
X-Received: by 2002:a17:906:8890:: with SMTP id ak16mr11761146ejc.398.1613426269419;
 Mon, 15 Feb 2021 13:57:49 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Feb 2021 16:57:38 -0500
Message-ID: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We've got a good handful of patches for SELinux this time around; with
everything passing the selinux-testsuite and applying cleanly to your
tree as of a few minutes ago.  The highlights are below:

- Add support for labeling anonymous inodes, and extend this new
support to userfaultfd.

- Fallback to SELinux genfs file labeling if the filesystem does not
have xattr support.  This is useful for virtiofs which can vary in its
xattr support depending on the backing filesystem.

- Classify and handle MPTCP the same as TCP in SELinux.

- Ensure consistent behavior between inode_getxattr and
inode_listsecurity when the SELinux policy is not loaded.  This fixes
a known problem with overlayfs.

- A couple of patches to prune some unused variables from the SELinux
code, mark private variables as static, and mark other variables as
__ro_after_init or __read_mostly.

Thanks,
-Paul

--
The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

 Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210215

for you to fetch changes up to 365982aba1f264dba26f0908700d62bfa046918c:

 fs: anon_inodes: rephrase to appropriate kernel-doc
   (2021-01-15 12:17:25 -0500)

----------------------------------------------------------------
selinux/stable-5.12 PR 20210215

----------------------------------------------------------------
Amir Goldstein (1):
     selinux: fix inconsistency between inode_getxattr and inode_listsecurity

Daniel Colascione (3):
     fs: add LSM-supporting anon-inode interface
     selinux: teach SELinux about anonymous inodes
     userfaultfd: use secure anon inodes for userfaultfd

Lokesh Gidra (1):
     security: add inode_init_security_anon() LSM hook

Lukas Bulwahn (1):
     fs: anon_inodes: rephrase to appropriate kernel-doc

Ondrej Mosnacek (6):
     selinux: remove unused global variables
     selinux: drop the unnecessary aurule_callback variable
     selinux: make selinuxfs_mount static
     selinux: mark some global variables __ro_after_init
     selinux: mark selinux_xfrm_refcount as __read_mostly
     selinux: fall back to SECURITY_FS_USE_GENFS if no xattr support

Paolo Abeni (1):
     selinux: handle MPTCP consistently with TCP

fs/anon_inodes.c                    | 157 +++++++++++++++++++++++++--------
fs/libfs.c                          |   5 --
fs/userfaultfd.c                    |  19 ++---
include/linux/anon_inodes.h         |   5 ++
include/linux/lsm_hook_defs.h       |   2 +
include/linux/lsm_hooks.h           |   9 +++
include/linux/security.h            |  10 +++
security/security.c                 |   8 ++
security/selinux/avc.c              |  10 +--
security/selinux/hooks.c            | 141 ++++++++++++++++++++++++-----
security/selinux/ibpkey.c           |   1 -
security/selinux/include/classmap.h |   2 +
security/selinux/include/security.h |   1 -
security/selinux/netif.c            |   1 -
security/selinux/netlink.c          |   2 +-
security/selinux/netnode.c          |   1 -
security/selinux/netport.c          |   1 -
security/selinux/selinuxfs.c        |   4 +-
security/selinux/ss/avtab.c         |   4 +-
security/selinux/ss/ebitmap.c       |   2 +-
security/selinux/ss/hashtab.c       |   2 +-
security/selinux/ss/services.c      |  10 +--
security/selinux/xfrm.c             |   2 +-
23 files changed, 294 insertions(+), 105 deletions(-)

-- 
paul moore
www.paul-moore.com
