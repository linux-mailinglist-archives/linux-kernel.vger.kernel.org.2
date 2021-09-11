Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE64079D1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhIKRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIKRZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 13:25:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC39C061574;
        Sat, 11 Sep 2021 10:24:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h1so8812172ljl.9;
        Sat, 11 Sep 2021 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6xpGk4Gbf6iEiJncDeOfs3mRIeJ5ZCtSjHdlk5wXhVw=;
        b=jvh2Ud8nL9BOf4JcBTQqCVjHTcoHz8B6b2a14o9WsgIE2ROqsrXbq9UaG5qEzM138H
         E/wAKPhDZep6JuYErrJgaFKqD9vuG1NtD9Ktv89tcodJfb48dnFmp2WQZbjuB4us0U+I
         vPNsWE/HFAAUqAHKQ6oLwhtPkyV/6IbyqhSZAV5rX9qPyiRo/rKiBaPYKPoV3Yw4fg6j
         r48KcW/Kh2G7tuCpi/bi1PFF2d6Qx4ZnGxIRx8Sk31SHk+NPbtEdYGef+1VEzOXU5jZT
         4UHGOfctdGl2gFoRt2EsZmBuEJlWAZkbFqLlWjW+3dXhAnGAu/fZv4kXgtVhiU9IJZdf
         uXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6xpGk4Gbf6iEiJncDeOfs3mRIeJ5ZCtSjHdlk5wXhVw=;
        b=3yo1B6yLtC8XDtSL0JzhhdFXCD/+dJjJ65EU4eQgGEGs3tfCdHhTfOz02ZwW3FJ9aX
         5BlKLjKfcS9AzbZwictbTXoGynK+nDWJMQlwGAQQ9CiyeGTOhu1AYkbFgm+2rwAShXKX
         VqgkD4Z2dEX+7Xx0pS3GG9A75uE+1dGv5v8u56WHxmqm5vOKa5F/IgsyNzOuYrsu1uZQ
         VisqqTYgNlkvFfk1f084Bm9pj3Z+owaUzI572adlHTucR78PsAbGTnH4sz4wEn+ATgk7
         lVsnI1fUbclznMKVrF6O/TcpZ97fbBPMPviFWu2QQ3zl0phOehh8mFs2T3oFdRuRoSsX
         WnBw==
X-Gm-Message-State: AOAM5325KwrLPYoNhYuQK8O8FLK7z1JP7yO2S+yeA6/EA1MoNaoIy6rj
        Flz0NLv7lYLPqEau/Jfwv8qLb9WQaiPjxZd0KxhVqJhK81I=
X-Google-Smtp-Source: ABdhPJwx7LhhYBFzaZWTJJ5sZZCfE3gEQ8RhYRRGHsAWuBZrvPj98FzDN5PCr6ubWpV24njitXHMJEZLt9IQXoVlGa0=
X-Received: by 2002:a05:651c:33b:: with SMTP id b27mr2927218ljp.314.1631381044935;
 Sat, 11 Sep 2021 10:24:04 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 11 Sep 2021 12:23:54 -0500
Message-ID: <CAH2r5ms8Tbj+Jwo6pgM--fGtOBW3vyaSkU==959G=-HtoT5EzQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
9c849ce86e0fa93a218614eac562ace44053d7ce:

  Merge tag '5.15-rc-smb3-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2021-08-31 09:22:37 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-cifs-part2

for you to fetch changes up to 9351590f51cdda49d0265932a37f099950998504:

  cifs: properly invalidate cached root handle when closing it
(2021-09-09 17:34:38 -0500)

----------------------------------------------------------------
4 cifs/smb3 fixes:
- one for DFS reconnect
- one to begin creating common headers for server and client
- the other two to rename the cifs_common directory to smbfs_common to
be more consistent ie change use of the name cifs to smb (smb3 or
smbfs is more accurate, as theThe following changes since commit
9c849ce86e0fa93a218614eac562ace44053d7ce:

  Merge tag '5.15-rc-smb3-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2021-08-31 09:22:37 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-cifs-part2

for you to fetch changes up to 9351590f51cdda49d0265932a37f099950998504:

  cifs: properly invalidate cached root handle when closing it
(2021-09-09 17:34:38 -0500)

----------------------------------------------------------------
4 cifs/smb3 fixes, one for DFS reconnect, and one to begin creating
common headers for server and client and the other two to rename the
cifs_common directory to smbfs_common to be more consistent ie change
use of the name cifs to smb which is more accurate

----------------------------------------------------------------
Enzo Matsumiya (1):
      cifs: properly invalidate cached root handle when closing it

Steve French (3):
      cifs: update FSCTL definitions
      cifs: rename cifs_common to smbfs_common
      cifs: move SMB FSCTL definitions to common code

 fs/Kconfig                                   |  2 +-
 fs/Makefile                                  |  2 +-
 fs/cifs/cifsencrypt.c                        |  2 +-
 fs/cifs/cifspdu.h                            |  2 +-
 fs/cifs/smb2ops.c                            | 20 +++++++++++++-------
 fs/cifs/smbencrypt.c                         |  2 +-
 fs/{cifs_common => smbfs_common}/Makefile    |  4 ++--
 fs/{cifs_common => smbfs_common}/arc4.h      |  0
 fs/{cifs_common => smbfs_common}/cifs_arc4.c |  8 ++++----
 fs/{cifs_common => smbfs_common}/cifs_md4.c  |  0
 fs/{cifs_common => smbfs_common}/md4.h       |  0
 fs/{cifs => smbfs_common}/smbfsctl.h         | 16 +++++++++++++---
 12 files changed, 37 insertions(+), 21 deletions(-)
 rename fs/{cifs_common => smbfs_common}/Makefile (59%)
 rename fs/{cifs_common => smbfs_common}/arc4.h (100%)
 rename fs/{cifs_common => smbfs_common}/cifs_arc4.c (91%)
 rename fs/{cifs_common => smbfs_common}/cifs_md4.c (100%)
 rename fs/{cifs_common => smbfs_common}/md4.h (100%)
 rename fs/{cifs => smbfs_common}/smbfsctl.h (92%)
The following changes since commit 9c849ce86e0fa93a218614eac562ace44053d7ce:

  Merge tag '5.15-rc-smb3-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2021-08-31 09:22:37 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-cifs-part2

for you to fetch changes up to 9351590f51cdda49d0265932a37f099950998504:

  cifs: properly invalidate cached root handle when closing it
(2021-09-09 17:34:38 -0500)

----------------------------------------------------------------
4 cifs/smb3 fixes, one for DFS reconnect, and one to begin creating
common headers for server and client and the other two to rename the
cifs_common directory to smbfs_common to be more consistent ie change
use of the name cifs to smb which is more accurate

----------------------------------------------------------------
Enzo Matsumiya (1):
      cifs: properly invalidate cached root handle when closing it

Steve French (3):
      cifs: update FSCTL definitions
      cifs: rename cifs_common to smbfs_common
      cifs: move SMB FSCTL definitions to common code

 fs/Kconfig                                   |  2 +-
 fs/Makefile                                  |  2 +-
 fs/cifs/cifsencrypt.c                        |  2 +-
 fs/cifs/cifspdu.h                            |  2 +-
 fs/cifs/smb2ops.c                            | 20 +++++++++++++-------
 fs/cifs/smbencrypt.c                         |  2 +-
 fs/{cifs_common => smbfs_common}/Makefile    |  4 ++--
 fs/{cifs_common => smbfs_common}/arc4.h      |  0
 fs/{cifs_common => smbfs_common}/cifs_arc4.c |  8 ++++----
 fs/{cifs_common => smbfs_common}/cifs_md4.c  |  0
 fs/{cifs_common => smbfs_common}/md4.h       |  0
 fs/{cifs => smbfs_common}/smbfsctl.h         | 16 +++++++++++++---
 12 files changed, 37 insertions(+), 21 deletions(-)
 rename fs/{cifs_common => smbfs_common}/Makefile (59%)
 rename fs/{cifs_common => smbfs_common}/arc4.h (100%)
 rename fs/{cifs_common => smbfs_common}/cifs_arc4.c (91%)
 rename fs/{cifs_common => smbfs_common}/cifs_md4.c (100%)
 rename fs/{cifs_common => smbfs_common}/md4.h (100%)
 rename fs/{cifs => smbfs_common}/smbfsctl.h (92%)
The following changes since commit 9c849ce86e0fa93a218614eac562ace44053d7ce:

  Merge tag '5.15-rc-smb3-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2021-08-31 09:22:37 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-cifs-part2

for you to fetch changes up to 9351590f51cdda49d0265932a37f099950998504:

  cifs: properly invalidate cached root handle when closing it
(2021-09-09 17:34:38 -0500)

----------------------------------------------------------------
4 cifs/smb3 fixes, one for DFS reconnect, and one to begin creating
common headers for server and client and the other two to rename the
cifs_common directory to smbfs_common to be more consistent ie change
use of the name cifs to smb which is more accurate

----------------------------------------------------------------
Enzo Matsumiya (1):
      cifs: properly invalidate cached root handle when closing it

Steve French (3):
      cifs: update FSCTL definitions
      cifs: rename cifs_common to smbfs_common
      cifs: move SMB FSCTL definitions to common code

 fs/Kconfig                                   |  2 +-
 fs/Makefile                                  |  2 +-
 fs/cifs/cifsencrypt.c                        |  2 +-
 fs/cifs/cifspdu.h                            |  2 +-
 fs/cifs/smb2ops.c                            | 20 +++++++++++++-------
 fs/cifs/smbencrypt.c                         |  2 +-
 fs/{cifs_common => smbfs_common}/Makefile    |  4 ++--
 fs/{cifs_common => smbfs_common}/arc4.h      |  0
 fs/{cifs_common => smbfs_common}/cifs_arc4.c |  8 ++++----
 fs/{cifs_common => smbfs_common}/cifs_md4.c  |  0
 fs/{cifs_common => smbfs_common}/md4.h       |  0
 fs/{cifs => smbfs_common}/smbfsctl.h         | 16 +++++++++++++---
 12 files changed, 37 insertions(+), 21 deletions(-)
 rename fs/{cifs_common => smbfs_common}/The following changes since
commit 9c849ce86e0fa93a218614eac562ace44053d7ce:

  Merge tag '5.15-rc-smb3-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2021-08-31 09:22:37 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-cifs-part2

for you to fetch changes up to 9351590f51cdda49d0265932a37f099950998504:

  cifs: properly invalidate cached root handle when closing it
(2021-09-09 17:34:38 -0500)

----------------------------------------------------------------
4 cifs/smb3 fixes, one for DFS reconnect, and one to begin creating
common headers for server and client and the other two to rename the
cifs_common directory to smbfs_common to be more consistent ie change
use of the name cifs to smb which is more accurate

----------------------------------------------------------------
Enzo Matsumiya (1):
      cifs: properly invalidate cached root handle when closing it

Steve French (3):
      cifs: update FSCTL definitions
      cifs: rename cifs_common to smbfs_common
      cifs: move SMB FSCTL definitions to common code
The following changes since commit 9c849ce86e0fa93a218614eac562ace44053d7ce:

  Merge tag '5.15-rc-smb3-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2021-08-31 09:22:37 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-cifs-part2

for you to fetch changes up to 9351590f51cdda49d0265932a37f099950998504:

  cifs: properly invalidate cached root handle when closing it
(2021-09-09 17:34:38 -0500)

----------------------------------------------------------------
4 cifs/smb3 fixes, one for DFS reconnect, and one to begin creating
common headers for server and client and the other two to rename the
cifs_common directory to smbfs_common to be more consistent ie change
use of the name cifs to smb which is more accurate

----------------------------------------------------------------
Enzo Matsumiya (1):
      cifs: properly invalidate cached root handle when closing it

Steve French (3):
      cifs: update FSCTL definitions
      cifs: rename cifs_common to smbfs_common
      cifs: move SMB FSCTL definitions to common code

 fs/Kconfig                                   |  2 +-
 fs/Makefile                                  |  2 +-
 fs/cifs/cifsencrypt.c                        |  2 +-
 fs/cifs/cifspdu.h                            |  2 +-
 fs/cifs/smb2ops.c                            | 20 +++++++++++++-------
 fs/cifs/smbencrypt.c                         |  2 +-
 fs/{cifs_common => smbfs_common}/Makefile    |  4 ++--
 fs/{cifs_common => smbfs_common}/arc4.h      |  0
 fs/{cifs_common => smbfs_common}/cifs_arc4.c |  8 ++++----
 fs/{cifs_common => smbfs_common}/cifs_md4.c  |  0
 fs/{cifs_common => smbfs_common}/md4.h       |  0
 fs/{cifs => smbfs_common}/smbfsctl.h         | 16 +++++++++++++---
 12 files changed, 37 insertions(+), 21 deletions(-)
 rename fs/{cifs_common => smbfs_common}/Makefile (59%)
 rename fs/{cifs_common => smbfs_common}/arc4.h (100%)
 rename fs/{cifs_common => smbfs_common}/cifs_arc4.c (91%)
 rename fs/{cifs_common => smbfs_common}/cifs_md4.c (100%)
 rename fs/{cifs_common => smbfs_common}/md4.h (100%)
 rename fs/{cifs => smbfs_common}/smbfsctl.h (92%)

 fs/Kconfig                                   |  2 +-
 fs/Makefile                                  |  2 +-
 fs/cifs/cifsencrypt.c                        |  2 +-
 fs/cifs/cifspdu.h                            |  2 +-
 fs/cifs/smb2ops.c                            | 20 +++++++++++++-------
 fs/cifs/smbencrypt.c                         |  2 +-
 fs/{cifs_common => smbfs_common}/Makefile    |  4 ++--
 fs/{cifs_common => smbfs_common}/arc4.h      |  0
 fs/{cifs_common => smbfs_common}/cifs_arc4.c |  8 ++++----
 fs/{cifs_common => smbfs_common}/cifs_md4.c  |  0
 fs/{cifs_common => smbfs_common}/md4.h       |  0
 fs/{cifs => smbfs_common}/smbfsctl.h         | 16 +++++++++++++---
 12 files changed, 37 insertions(+), 21 deletions(-)
 rename fs/{cifs_common => smbfs_common}/Makefile (59%)
 rename fs/{cifs_common => smbfs_common}/arc4.h (100%)
 rename fs/{cifs_common => smbfs_common}/cifs_arc4.c (91%)
 rename fs/{cifs_common => smbfs_common}/cifs_md4.c (100%)
 rename fs/{cifs_common => smbfs_common}/md4.h (100%)
 rename fs/{cifs => smbfs_common}/smbfsctl.h (92%)
Makefile (59%)
 rename fs/{cifs_common => smbfs_common}/arc4.h (100%)
 rename fs/{cifs_common => smbfs_common}/cifs_arc4.c (91%)
 rename fs/{cifs_common => smbfs_common}/cifs_md4.c (100%)
 rename fs/{cifs_common => smbfs_common}/md4.h (100%)
 rename fs/{cifs => smbfs_common}/smbfsctl.h (92%)
very old cifs dialect has long been superseded by smb3 dialects).

In the future we can rename the fs/cifs directory to fs/smbfs.

This pull request does not include the set of multichannel fixes nor
the two deferred close fixes (they are still being reviewed and
tested).
----------------------------------------------------------------
Enzo Matsumiya (1):
      cifs: properly invalidate cached root handle when closing it

Steve French (3):
      cifs: update FSCTL definitions
      cifs: rename cifs_common to smbfs_common
      cifs: move SMB FSCTL definitions to common code

 fs/Kconfig                                   |  2 +-
 fs/Makefile                                  |  2 +-
 fs/cifs/cifsencrypt.c                        |  2 +-
 fs/cifs/cifspdu.h                            |  2 +-
 fs/cifs/smb2ops.c                            | 20 +++++++++++++-------
 fs/cifs/smbencrypt.c                         |  2 +-
 fs/{cifs_common => smbfs_common}/Makefile    |  4 ++--
 fs/{cifs_common => smbfs_common}/arc4.h      |  0
 fs/{cifs_common => smbfs_common}/cifs_arc4.c |  8 ++++----
 fs/{cifs_common => smbfs_common}/cifs_md4.c  |  0
 fs/{cifs_common => smbfs_common}/md4.h       |  0
 fs/{cifs => smbfs_common}/smbfsctl.h         | 16 +++++++++++++---
 12 files changed, 37 insertions(+), 21 deletions(-)
 rename fs/{cifs_common => smbfs_common}/Makefile (59%)
 rename fs/{cifs_common => smbfs_common}/arc4.h (100%)
 rename fs/{cifs_common => smbfs_common}/cifs_arc4.c (91%)
 rename fs/{cifs_common => smbfs_common}/cifs_md4.c (100%)
 rename fs/{cifs_common => smbfs_common}/md4.h (100%)
 rename fs/{cifs => smbfs_common}/smbfsctl.h (92%)


-- 
Thanks,

Steve
