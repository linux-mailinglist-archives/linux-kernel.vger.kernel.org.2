Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31698343E42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhCVKpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhCVKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:45:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3796C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:45:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso3087270wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/EtraXdwG48MIpUcGsZ+NjwlfYtF1SBdDR9l0xnE0GI=;
        b=Q4tneEFGJZw9lnTVj414k5BX8j6B8y94VXLFae4Pq/nfEldoOY54mq9YKeF87DGuhS
         BOgYurDv6oyIulLKarIWuPKMBjVYLh99sYF0sdEosx+riXE8IL9q5U54gyMgdXwY5MZz
         rSR1SxuPS2jTR73ZhWShYgoeS7DvOHTDCS27HVgsXx6AvgnMUxeDw6p5iaaKKpD/x4Sr
         AFHSkn5NSbEmS4rjn9zHonT6ySlnWAYiaicTeEL9ONN6RopJQwehBQg+crSjLO0CodVp
         VtLj4p6aQ2qUck7DSFljed5fv9tfGHh8hjmmcwKN2SFHmxeXtDcSi3GbYUEyOvaHuWGO
         +wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/EtraXdwG48MIpUcGsZ+NjwlfYtF1SBdDR9l0xnE0GI=;
        b=LY+4/OzuLOgZnmJJFWMhtD4nDDBKGIxE4rf80Q/5ILE1FcN6Z/IA4ez2lLhafFnQS0
         jUkQw6Yg+LwJDqu655pvsn3nMF2dY0a9Z4gir0Y4IfiPiEp98qYWn91yIYbX4Mi5Nc/n
         yCibpHBjEqhRxBHgrLxJThxqGWwWzSoQVIgpCDfKs2vuHOosqWOhpDa7b23l1NWRW4Ll
         JQ0uW5Q+C35ebdCgMqMgzM743B6eavnKvC7/oMxLvllpyxPRX0MdlYKFZmPd7TsmreCk
         cAq3/4lxczgdkP97k9nl52Sc8MFuF1hva558j26pcw1dVKgn9kL8A+iMA8wdBxwI51Li
         oM8g==
X-Gm-Message-State: AOAM533xb1ZPOrR0dN1fKgV8Hus+cSh//Ikso9JkNM2W7j5Ai/j7Gt5s
        NX8mtT8N8mDccXynXlYaJ5o=
X-Google-Smtp-Source: ABdhPJyDthC1yIPoZmBTKUernh/ebXRsTi3DkKM4dQA5Q2elljn9C0M/egzyw+0NNLy4kyapO8ZVUw==
X-Received: by 2002:a1c:3d8a:: with SMTP id k132mr15043074wma.71.1616409908368;
        Mon, 22 Mar 2021 03:45:08 -0700 (PDT)
Received: from ?IPv6:2001:a61:2553:a401:cfc6:2039:a9ec:21ff? ([2001:a61:2553:a401:cfc6:2039:a9ec:21ff])
        by smtp.gmail.com with ESMTPSA id h62sm18063026wmf.37.2021.03.22.03.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 03:45:07 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>
To:     lkml <linux-kernel@vger.kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.11 released
Message-ID: <ab6fdc6d-0b27-d6df-58f8-3b7fb14bf15d@gmail.com>
Date:   Mon, 22 Mar 2021 11:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

Alex Colomar and I are proud to announce:

    man-pages-5.11 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from around 40 contributors. The release includes
around 480 commits that changed 950 (about 90% of the) pages.
With a 50k diff, this is one of the largest man-pages releases
in quite a long time.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.11

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2021/03/man-pages-511-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.11 ====================

Released: 2021-03-21, Munich


New and rewritten pages
-----------------------

close_range.2
    Stephen Kitt, Michael Kerrisk  [Christian Brauner]
        New page documenting close_range(2)

process_madvise.2
    Suren Baghdasaryan, Minchan Kim  [Michal Hocko, Alejandro Colomar,
    Michael Kerrisk]
        Document process_madvise(2)

fileno.3
    Michael Kerrisk
        Split fileno(3) content out of ferror(3) into new page
            fileno(3) differs from the other functions in various ways.
            For example, it is governed by different standards,
            and can set 'errno'. Conversely, the other functions
            are about examining the status of a stream, while
            fileno(3) simply obtains the underlying file descriptor.
            Furthermore, splitting this function out allows
            for some cleaner upcoming changes in ferror(3).


Newly documented interfaces in existing pages
---------------------------------------------

epoll_wait.2
    Willem de Bruijn  [Dmitry V. Levin]
        Add documentation of epoll_pwait2()
            Expand the epoll_wait() page with epoll_pwait2(), an epoll_wait()
            variant that takes a struct timespec to enable nanosecond
            resolution timeout.

fanotify_init.2
fanotify.7
    Jan Kara  [Steve Grubb]
        Document FAN_AUDIT flag and FAN_ENABLE_AUDIT

madvise.2
    Michael Kerrisk
        Add descriptions of MADV_COLD and MADV_PAGEOUT
            Taken from process_madvise(2).

openat2.2
    Jens Axboe
        Add RESOLVE_CACHED

prctl.2
    Gabriel Krisman Bertazi
        Document Syscall User Dispatch

mallinfo.3
    Michael Kerrisk
        Document mallinfo2() and note that mallinfo() is deprecated
            Document the mallinfo2() function added in glibc 2.33.
        Update example program to use mallinfo2()

system_data_types.7
    Alejandro Colomar
        Add off64_t to system_data_types(7)

ld.so.8
    Michael Kerrisk
        Document the --argv0 option added in glibc 2.33


Global changes
--------------

Various pages
    Alejandro Colomar
        SYNOPSIS: Use 'restrict' in prototypes
            This change has been completed for *all* relevant pages
            (around 135 pages in total).

Various pages
    Alejandro Colomar  [Zack Weinberg]
        Remove unused <sys/types.h>
            The manual pages are already inconsistent in which headers need
            to be included.  Right now, not all of the types used by a
            function have their required header included in the SYNOPSIS.

            If we were to add the headers required by all of the types used by
            functions, the SYNOPSIS would grow too much.  Not only it would
            grow too much, but the information there would be less precise.

            Having system_data_types(7) document each type with all the
            information about required includes is much more precise, and the
            info is centralized so that it's much easier to maintain.

            So let's document only the include required for the function
            prototype, and also the ones required for the macros needed to
            call the function.

            <sys/types.h> only defines types, not functions or constants, so
            it doesn't belong to man[23] (function) pages at all.

            I ignore if some old systems had headers that required you to
            include <sys/types.h> *before* them (incomplete headers), but if
            so, those implementations would be broken, and those headers
            should probably provide some kind of warning.  I hope this is not
            the case.

            [mtk: Already in 2001, POSIX.1 removed the requirement to
            include <sys/types.h> for many APIs, so this patch seems
            well past due.]

_exit.2
abort.3
err.3
exit.3
pthread_exit.3
setjmp.3
    Alejandro Colomar
        SYNOPSIS: Use 'noreturn' in prototypes
            Use standard C11 'noreturn' in these manual page for
            functions that do not return.


Changes to individual pages
---------------------------

getcpu.2
    Michael Kerrisk  [Alejandro Colomar]
        Rewrite page to describe glibc wrapper function
            Since glibc 2.29, there is a wrapper for getcpu(2).
            The wrapper has only 2 arguments, omitting the unused
            third system call argument. Rework the manual page
            to reflect this.

kcmp.2
    Michael Kerrisk
        Since Linux 5.12, kcmp() availability is unconditional
            kcmp() is no longer dependent on CONFIG_CHECKPOINT_RESTORE.

mmap2.2
    Alejandro Colomar
        Fix prototype parameter types
            There are many slightly different prototypes for this syscall,
            but none of them is like the documented one.
            Of all the different prototypes,
            let's document the asm-generic one.

mount.2
    Michael Kerrisk
        Note that the 'data' argument can be NULL

syscall.2
    Peter H. Froehlich
        Update superh syscall convention

syscalls.2
    Michael Kerrisk
        Add epoll_pwait2()

netdevice.7
    Pali Rohár  [Alejandro Colomar]
        Update documentation for SIOCGIFADDR SIOCSIFADDR SIOCDIFADDR

netlink.7
    Pali Rohár  [Alejandro Colomar]
        Fix minimal Linux version for NETLINK_CAP_ACK
            NETLINK_CAP_ACK option was introduced in commit 0a6a3a23ea6e which first
            appeared in Linux version 4.3 and not 4.2.
    Pali Rohár  [Alejandro Colomar]
        Remove IPv4 from description
            rtnetlink is not only used for IPv4
    Philipp Schuster
        Clarify details of netlink error responses
            Make it clear that netlink error responses (i.e., messages with
            type NLMSG_ERROR (0x2)), can be longer than sizeof(struct
            nlmsgerr). In certain circumstances, the payload can be longer.
sock_diag.7
    Pali Rohár  [Alejandro Colomar]
        Fix recvmsg() usage in the example

tcp.7
    Enke Chen
        Documentation revision for TCP_USER_TIMEOUT

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
