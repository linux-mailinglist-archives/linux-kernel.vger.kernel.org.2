Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780D03FA141
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhH0VqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 17:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhH0VqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:46:23 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F6FC0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 14:45:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so6986208pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 14:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=THd4GECwsu9YSndkCUb5P9tLsH3805gL0R5q0qHaVUE=;
        b=ulW+3y2aaOKoeTsCJ3dzAaDHmwmEsbVbPPSglJq+a1bL1L2QhZ3UCCFchk0x/nk7u9
         fQP7Y+StkXLagQHdb8Wo5UJW1sKwdAuSO7M3jzOxg0TPbaVDKrJvR9ZwBI6AXkaTn3rP
         ciOCVmzvL/Jx/6f91UuKVhb0LsF3ht/UCITXfymyjdIgsnqqvmX99HlFONDG4Vl5PyVS
         S1tp3rsZVJX8WHDjV5BDdF51A8+WHo3ohgSX1CN6iMrSI6fTNAG9hI0/cmxfMdnLGcn3
         eyGlyCty8TieE3nbHGbFDNL9juNMBLfOUZ4nlobzwCpdUxQSRD5BffWoW+xZDkBLQ7/s
         NQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=THd4GECwsu9YSndkCUb5P9tLsH3805gL0R5q0qHaVUE=;
        b=XvQ9UNswZz6aHJ3HNMTSpt6kOD0uE+/AvhHOKDJPLh9B+RdKqOHpT2ARGy0dozu1ZD
         TFD0eHR+/VSrXQT4hVpfS/LLaUOmttH7L/jLf3a72TlMEXO8ognUIzQHofbPFsbg12W7
         j1M4Hm42AJ8gNP+KzLPjJtr+eOIfkAsnxh7IgxWOQxOEulCCtElQZyyJ0D0VqNhgWQgl
         mlN2WiiCkKjtDBMI7o8Gu645Uoc51gh01/lJwXVWpO0lFVeWSisssSPuY6VvtPNYeyB4
         a6EhvUA4EYqiOlTbKyqu1SIvW2lfMCZruaYV/LSncubCNp7ofoAJ4yVOz/1A3S0jYL7Y
         5JEw==
X-Gm-Message-State: AOAM533QAVJqgJ+tzOssvZ/tCSRz/28CIrnUKZQFEBNCKQ5yMfXb+YyJ
        80jSNsNNpjwtisJPnbUeaqIDWQCjtRM=
X-Google-Smtp-Source: ABdhPJydp76ftTnQkcw9DOB/A3RVED+d/wIJFCLSJdCnR5Y8AJE18oldOd3TsSFpQMFMzRrWxN0m7w==
X-Received: by 2002:a05:6a00:230e:b029:3c4:24ff:969d with SMTP id h14-20020a056a00230eb02903c424ff969dmr11110849pfh.44.1630100733315;
        Fri, 27 Aug 2021 14:45:33 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id n11sm13869894pjh.23.2021.08.27.14.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 14:45:32 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>
To:     lkml <linux-kernel@vger.kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.13 is released
Message-ID: <11ec92df-0b4c-16f2-a3bc-f55a59ad01ab@gmail.com>
Date:   Fri, 27 Aug 2021 23:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

Alex Colomar and I are proud to announce:

    man-pages-5.13 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from 40 contributors. The release includes
around 200 commits that changed approximately 120 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.13

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2021/08/man-pages-513-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.13 ====================

Released: 2021-08-27, Christchurch


New and rewritten pages
-----------------------

mount_setattr.2
    Christian Brauner  [Alejandro Colomar, Michael Kerrisk]
        New manual page documenting the mount_setattr() system call


Newly documented interfaces in existing pages
---------------------------------------------

futex.2
    Kurt Kanzenbach  [Alejandro Colomar, Thomas Gleixner, Michael Kerrisk]
        Document FUTEX_LOCK_PI2

ioctl_tty.2
    Pali Rohár  [Alejandro Colomar, Michael kerrisk]
        Document ioctls: TCGETS2, TCSETS2, TCSETSW2, TCSETSF2

pidfd_open.2
    Michael Kerrisk
        Document PIDFD_NONBLOCK

seccomp_unotify.2
    Rodrigo Campos  [Alejandro Colomar]
        Document SECCOMP_ADDFD_FLAG_SEND

sigaction.2
    Peter Collingbourne  [Alejandro Colomar, Michael Kerrisk]
        Document SA_EXPOSE_TAGBITS and the flag support detection protocol

statx.2
    NeilBrown
        Document STATX_MNT_ID

capabilities.7
user_namespaces.7
    Michael Kerrisk, Kir Kolyshkin  [Alejandro Colomar]
        Describe CAP_SETFCAP for mapping UID 0

mount_namespaces.7
    Michael Kerrisk  [Christian Brauner, Eric W. Biederman]
        More clearly explain the notion of locked mounts
            For a long time, this manual page has had a brief discussion of
            "locked" mounts, without clearly saying what this concept is, or
            why it exists. Expand the discussion with an explanation of what
            locked mounts are, why mounts are locked, and some examples of the
            effect of locking.

user_namespaces.7
    Michael Kerrisk
        Document /proc/PID/projid_map

ld.so.8
    Michael Kerrisk
        Document --list-tunables option added in glibc 2.33


Global changes
--------------

Various pages
    Michael Kerrisk
        Fix EBADF error description
            Make the description of the EBADF error for invalid 'dirfd' more
            uniform. In particular, note that the error only occurs when the
            pathname is relative, and that it occurs when the 'dirfd' is
            neither valid *nor* has the value AT_FDCWD.

Various pages
    Michael Kerrisk
        Terminology clean-up: "mount point" ==> "mount"
            Many times, these pages use the terminology "mount point", where
            "mount" would be better. A "mount point" is the location at which
            a mount is attached. A "mount" is an association between a
            filesystem and a mount point.


Changes to individual pages
---------------------------

mount.2
    Michael Kerrisk
        ERRORS: add EPERM error for case where a mount is locked
            Refer the reader to mount_namespaces(7) for details.

open.2
    Michael Kerrisk
        Explicitly describe the EBADF error that can occur with openat()
            In particular, specifying an invalid file descriptor number
            in 'dirfd' can be used as a check that 'pathname' is absolute.
    Michael Kerrisk
        Clarify that openat()'s dirfd must be opened with O_RDONLY or O_PATH

seccomp.2
    Eric W. Biederman  [Kees Cook]
        Clarify that bad system calls kill the thread (not the process)

syscalls.2
    Michael Kerrisk
        Add quotactl_fd(); remove quotactl_path()
            quotactl_path() was never wired up in Linux 5.13.
            It was replaced instead by quotactl_fd(),
    Michael Kerrisk
        Add system calls that are new in 5.13

wait.2
    Michael Kerrisk
        ERRORS: document EAGAIN for waitid() on a PID file descriptor

termios.3
    Pali Rohár  [Alejandro Colomar]
        SPARC architecture has 4 different Bnnn constants
    Pali Rohár  [Alejandro Colomar]
        Add information how to set baud rate to any other value
    Pali Rohár  [Alejandro Colomar]
        Use bold style for Bnn and EXTn macro constants
    Pali Rohár  [Alejandro Colomar]
        Document missing baud-rate constants

vdso.7
    Michael Kerrisk  [Christophe Leroy]
        Update CLOCK_REALTIME_COARSE + CLOCK_MONOTONIC_COARSE info for powerpc
    Alejandro Colomar  [Christophe Leroy]
        Add y2038 compliant gettime for ppc/32

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
