Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58A440C1D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 00:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhJ3W0S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Oct 2021 18:26:18 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45747 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJ3W0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 18:26:17 -0400
Received: by mail-ed1-f51.google.com with SMTP id m17so49688768edc.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 15:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=6drv69/pM7yrcbQ7IO1p79Cg3RwPJZH2L/nzdEToZh0=;
        b=odYrFeIdINEZtFBEwEiQfUvtidcvv2CzPYsV9uKh68QF6eMQp9L58KVOm11MA+L/0D
         ysjflXiTyTqjb4RDhz11Pn2MNs6iIV+FUleDYU1LL4dxM3ZfopN/+wtbKdjjpj5Y8tzA
         z45MCQwkZ0yUpx1ksuH6ODp6MLTXCnaPL8RrmP3opLE7aJbPpqKrU5Z+/CmSXudrtaHy
         1dHKw7N8wCvuVOmUIgJl31jHLWZxyd9t4rk03wVOkzfB0oEMpL2fzTpQlTX5uzwjX+LO
         HKqTcn8By1zVZt8LZk+IeGHA8swGyy5dP+Ii4AMWyPhRp51CFuz7Y/9EezjZV1Kr87wf
         I3AQ==
X-Gm-Message-State: AOAM530eeJSueE6unJKV9KGdl9pNuj8SgXDjofxtysryuZt02reK9Xbn
        aTlaWEotkrJRWEdPrGyAXjDajX0q5iRudvrlplM=
X-Google-Smtp-Source: ABdhPJz1xSmLbbAAcEpLH+xnvpMtOgvtMfJxk8+wZGBqdO8IArlbu6GxdRxJsJUQJRUh842UnIDux7YPcD8WCzJ8yqM=
X-Received: by 2002:a17:907:6e04:: with SMTP id sd4mr24343841ejc.40.1635632625633;
 Sat, 30 Oct 2021 15:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211030213131.140429-1-alx.manpages@gmail.com>
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sat, 30 Oct 2021 15:23:34 -0700
Message-ID: <CAPc5daWURksnU02wWZzBsx+6nsw82Lgd1K+rBRnmnqA1SJ0UBQ@mail.gmail.com>
Subject: Re: [PATCH 00/22] man2: Add [[deprecated]] attribute
To:     Alejandro Colomar <alx.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[jc: moved everybody else to bcc]

Please do not spam the git mailing list with these manual page update
patches. We may be interested in the final contents of the manual
pages, we appreciate the work done by the linux-man project, but we
already have our share of patch traffic on this list that people are
swamped with.


2021年10月30日(土) 14:32 Alejandro Colomar <alx.manpages@gmail.com>:
>
> Hello Michael,
>
> I added the C2X [[deprecated]] attribute to the prototypes of some
> system calls.  All of the cases where I added that were already
> marked as deprecated or obsolete somewhere in the manual page,
> so this is just about uniformity and visual effect rather than
> a new deprecation notice.
>
> There are cases where the syscalls have been simply removed, and
> so they are obviously not to be used any more.
>
> There are cases where some implementation (not necessarily Linux)
> is dangerous.
>
> In some other cases, the functions have been obsoleted by POSIX,
> but are still there in Linux without any deprecation notices.
> In these cases, if there's no clear replacement, or if the
> replacement is not a straight drop-in, or if the replacement adds
> more complexity, I didn't add the [[deprecated]] attribute.
>
> A list of the system calls that I skipped in this patch set:
>
> - utime(2)
>         Many filesystems have 1 second resolution, so it makes
>         sense to use it in those cases.  git(1) for example uses
>         utime(2) consistently.  Although deprecated by POSIX, it
>         is still part of POSIX; if it ever removes it, we can
>         reconsider.
>
> - setpgrp(2) (the POSIX/SysV version)
>         POSIX deprecated it (not yet removed), but the manual page
>         doesn't mention any replacement.
>
> Cheers,
>
> Alex
>
>
> ---
>
> Alejandro Colomar (22):
>   bdflush.2: SYNOPSIS: Mark as [[deprecated]]
>   create_module.2: SYNOPSIS: Mark as [[deprecated]]
>   get_kernel_syms.2: SYNOPSIS: Mark as [[deprecated]]
>   getunwind.2: SYNOPSIS: Mark as [[deprecated]]
>   iopl.2: SYNOPSIS: Mark as [[deprecated]]
>   query_module.2: SYNOPSIS: Mark as [[deprecated]]
>   remap_file_pages.2: SYNOPSIS: Mark as [[deprecated]]
>   sigprocmask.2: SYNOPSIS: Mark the legacy system call as [[deprecated]]
>   statfs.2: SYNOPSIS: Mark as [[deprecated]]
>   stime.2: SYNOPSIS: Mark as [[deprecated]]
>   ustat.2: SYNOPSIS: Mark as [[deprecated]]
>   pthread_mutex_consistent.3: Mark *_np() old function as [[deprecated]]
>   sysctl.2: SYNOPSIS: Mark as [[deprecated]]
>   vfork.2: SYNOPSIS: Mark as [[deprecated]]
>   tkill.2: SYNOPSIS: Mark tkill() as [[deprecated]]
>   sgetmask.2: SYNOPSIS: Mark as [[deprecated]]
>   getitimer.2: SYNOPSIS: Mark as [[deprecated]]
>   futimesat.2: SYNOPSIS: Mark as [[deprecated]]
>   gettimeofday.2: SYNOPSIS: Mark as [[deprecated]]
>   setpgid.2: SYNOPSIS: Mark BSD versions of getpgrp() and setpgrp() as
>     [[deprecated]]
>   sysfs.2: SYNOPSIS: Mark as [[deprecated]]
>   uselib.2: SYNOPSIS: Mark as [[deprecated]]
>
>  man2/bdflush.2                  |  4 ++--
>  man2/create_module.2            |  2 +-
>  man2/futimesat.2                |  4 ++--
>  man2/get_kernel_syms.2          |  2 +-
>  man2/getitimer.2                |  7 ++++---
>  man2/gettimeofday.2             |  8 ++++----
>  man2/getunwind.2                |  3 ++-
>  man2/iopl.2                     |  2 +-
>  man2/query_module.2             |  5 +++--
>  man2/remap_file_pages.2         |  5 +++--
>  man2/setpgid.2                  |  8 ++++----
>  man2/sgetmask.2                 |  4 ++--
>  man2/sigprocmask.2              | 12 +++++++-----
>  man2/statfs.2                   |  4 ++--
>  man2/stime.2                    |  2 +-
>  man2/sysctl.2                   |  2 +-
>  man2/sysfs.2                    |  6 +++---
>  man2/tkill.2                    |  2 +-
>  man2/uselib.2                   |  2 +-
>  man2/ustat.2                    |  2 +-
>  man2/vfork.2                    |  2 +-
>  man3/pthread_mutex_consistent.3 |  1 +
>  22 files changed, 48 insertions(+), 41 deletions(-)
>
> --
> 2.33.1
>
