Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6591B3AFA78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhFVBNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVBNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:13:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15182C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 18:11:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g4so11149287pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 18:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QDFRynUWgDFuSFsbEOyUdhrPVzqf1u42a7SEJs6LUYE=;
        b=Kn4diDanBV0wkOpttiAXI5LwGkEZjNs0P8fG+9Qvajn3DHd3jgvCXP4/Y1p84EXjY3
         HJWUu0XW62S/vZ44gfXC5yNzNMnBd5MoJYhmAMhss7RgfvKYsNJiLCzowNS6YHLXeMSX
         CmH4mfxFPSpUqpYcllm3nd9x+KDqpmcNQhKuah0uWUd+mvr0xG1b6MezBFocQdqdUmzG
         Fda1uFzHsUUCD7evyJkPL/07GqHqxoLjmc4IZEnbRw+PJHSF1ALIvtX7zyQzcxMzT7td
         miOIT/suwz7UG5O90vUlPcXEGw9l7MFdiRelwdpv1S/V/VYkXakl5dktyQu+ite7UWPo
         VgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QDFRynUWgDFuSFsbEOyUdhrPVzqf1u42a7SEJs6LUYE=;
        b=bTK95Jxjorwhz1mtOGgzdOZWIaNh7o/W5knGDqHgGXBIByyPeZCLkorZ3O5C/lhavO
         qR3r4ga0jfBloE717MUgIcHRXCfL/O3J0mU8gmxQnRIPKV0Sd7p7hp1ZD2wuQ5p7rdco
         jMfnKOhsPQDlnw0o1390eOcymb7JXB45Sw0roUwBYi4CbLkoEuPI79wEINaSmKnR+LVf
         ICGD+mDGZLx0Ql134HCpisLTI7OoNUjCn/yjTf0q8t48JA+wwjN5bSXQspoh8fjyvq/V
         cMFsHmL7VAuAUyB1/lL4bfoExNdb/+9kPVkw5POcEkFuiSgAsheY5wkQCgbLMdDwNfrt
         xwQw==
X-Gm-Message-State: AOAM533TCA5uTzcWzE+kMI4a7f8DYZW1Geo/rprnEIJjeCIeDPwoi2ww
        CElXWwxUdT/DlBuyf4cbAJk=
X-Google-Smtp-Source: ABdhPJz/oPgidd4i7kOopdb8TfavVs1IHcGdHGA5T8ZOdeftmsbPDdrgdrAUffqRiN50bqhvoceeuw==
X-Received: by 2002:a17:902:d2c5:b029:120:1c82:bd9f with SMTP id n5-20020a170902d2c5b02901201c82bd9fmr20426851plc.8.1624324298415;
        Mon, 21 Jun 2021 18:11:38 -0700 (PDT)
Received: from ?IPv6:2406:e003:5d3:3501:3d3d:3281:80e:9b6f? ([2406:e003:5d3:3501:3d3d:3281:80e:9b6f])
        by smtp.gmail.com with ESMTPSA id j79sm7652937pfd.172.2021.06.21.18.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 18:11:37 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>
To:     lkml <linux-kernel@vger.kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.12 is released
Message-ID: <b2e3cd3e-96ca-61d9-9f27-a22cc3ba5c6a@gmail.com>
Date:   Tue, 22 Jun 2021 13:11:31 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

Alex Colomar and I are proud to announce:

    man-pages-5.12 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from around 40 contributors. The release includes
around 300 commits that changed approximately 180 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.12

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2021/06/man-pages-512-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

You are receiving this message either because:

a) You contributed to the content of this release.

b) You are subscribed to linux-man@vger.kernel.org or
libc-alpha@sourceware.org.

c) I have information (possibly inaccurate) that you are the maintainer
of a translation of the manual pages, or are the maintainer of the
manual pages set in a particular distribution, or have expressed
interest in helping with man-pages maintenance, or have otherwise
expressed interest in being notified about man-pages releases.
If you don't want to receive such messages from me, or you know of
some other translator or maintainer who may want to receive such
notifications, send me a message.

Cheers,

Michael

==================== Changes in man-pages-5.12 ====================

Released: 2021-06-20, Christchurch


New and rewritten pages
-----------------------

seccomp_unotify.2
    Michael Kerrisk  [Tycho Andersen, Jann Horn, Kees Cook, Christian Brauner
                      Sargun Dhillon]
        New page documenting the seccomp user-space notification mechanism

MAX.3
    Alejandro Colomar
        New page to document MAX() and MIN()


Newly documented interfaces in existing pages
---------------------------------------------

seccomp.2
    Tycho Andersen  [MichaelKerrisk]
        Document SECCOMP_GET_NOTIF_SIZES
    Tycho Andersen
        Document SECCOMP_FILTER_FLAG_NEW_LISTENER   [Michael Kerrisk]
    Tycho Andersen
        Document SECCOMP_RET_USER_NOTIF  [Michael Kerrisk]

set_mempolicy.2
    Huang Ying  [Alejandro Colomar, "Huang, Ying"]
        Add mode flag MPOL_F_NUMA_BALANCING

userfaultfd.2
    Peter Xu  [Alejandro Colomar, Mike Rapoport]
        Add UFFD_FEATURE_THREAD_ID docs
    Peter Xu  [Alejandro Colomar, Mike Rapoport]
        Add write-protect mode docs

proc.5
    Michael Kerrisk
        Document /proc/sys/vm/sysctl_hugetlb_shm_group

system_data_types.7
    Alejandro Colomar
        Add 'blksize_t'
    Alejandro Colomar
        Add 'blkcnt_t'
    Alejandro Colomar
        Add 'mode_t'
    Alejandro Colomar
        Add 'struct sockaddr'
    Alejandro Colomar
        Add 'cc_t'
    Alejandro Colomar
        Add 'socklen_t'


Global changes
--------------

Many pages
    Alejandro Colomar
        SYNOPSIS: Use syscall(SYS_...); for system calls without a wrapper

Many pages
    Alejandro Colomar
        SYNOPSIS: Document why each header is required


Changes to individual pages
---------------------------

dup.2
    Michael Kerrisk
        Rewrite the description of dup() somewhat
            As can be seen by any number of StackOverflow questions, people
            persistently misunderstand what dup() does, and the existing manual
            page text, which talks of "copying" a file descriptor doesn't help.
            Rewrite the text a little to try to prevent some of these
            misunderstandings, in particular noting at the start that dup()
            allocates a new file descriptor.
    Michael Kerrisk
        Clarify what silent closing means

_exit.2
    Michael Kerrisk
        Add a little more detail on the raw _exit() system cal

flock.2
    Aurelien Aptel  [Alejandro Colomar]
        Add CIFS details
            CIFS flock() locks behave differently than the standard.
            Give an overview of those differences.

memfd_create.2
mmap.2
shmget.2
    Michael Kerrisk  [Yang Xu]
        Document the EPERM error for huge page allocations
            This error can occur if the caller is does not have CAP_IPC_LOCK
            and is not a member of the sysctl_hugetlb_shm_group.

mmap.2
    Bruce Merry
        Clarify that MAP_POPULATE is best-effort

mount.2
    Topi Miettinen
        Document SELinux use of MS_NOSUID mount flag

open.2
    Alejandro Colomar  [Walter Harms]
        Fix bug in linkat(2) call example
            AT_EMPTY_PATH works with empty strings (""), but not with NULL
            (or at least it's not obvious).

perfmonctl.2
    Michael Kerrisk
        This system call was removed in Linux 5.10

select.2
    Michael Kerrisk
        Strengthen the warning regarding the low value of FD_SETSIZE
            All modern code should avoid select(2) in favor of poll(2)
            or epoll(7).

capabilities.7
    Michael Kerrisk
        CAP_IPC_LOCK also governs memory allocation using huge pages

signal.7
    Michael Kerrisk
        Add reference to seccomp_unotify(2)
            The seccomp user-space notification feature can cause changes in
            the semantics of SA_RESTART with respect to system calls that
            would never normally be restarted. Point the reader to the page
            that provide further details.

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
