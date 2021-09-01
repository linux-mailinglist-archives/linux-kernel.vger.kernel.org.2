Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818CB3FD75D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhIAKKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhIAKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:10:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B2C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 03:09:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id me10so5374932ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TrVtx3U2QpvsgE0FsR57CyQeiezj6FJ6Rth9MaRCEts=;
        b=uAWAUjmcKXmZTpm8DxapCzUspI/qDjymaCV9CWEUyzZcNtk6saBZlBADwwYiyRzqa6
         r2EK6c02bWa8XaTAt9B5qft591wxYQId0Lzjp+DifmqDrn0tHLRvOx5zE+GYEhafzXfS
         JQ2RViiZuzKBy2pQG7BFKV13ymhBOZ53hlExEftMjIRCdwtC9ffVkWtx5SAFSivEG8VX
         VNd6rUN9fSWbk4Vv33m/jMYzKurpA7lb0IO1p8aurT4j/fR1cvxQdCb5TwHKR99IfzBh
         +bnj7UnYxlyYglMPNTCmVfwSTy4megUESOuwyE6kpqdix0Kt85k3Fh9DlwutHX+3pXCH
         /Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TrVtx3U2QpvsgE0FsR57CyQeiezj6FJ6Rth9MaRCEts=;
        b=AGzNh+YmIxo1lTXqsHaIkMZiIqyg1sVaLxJn4T7ey66eHsMfhyoE0MPe4AALrmZ3wn
         FlDWvDVg+jkL8AdlJncqO7sr1zzCpCEya7+z7dF/EtuyBYPOFtHWzXckiDKWF3bDrXPa
         +Y4yKJu6cTmpX6ieuq+DEl9kaB4HxhQ9SeT+Sn+sjvui8Fq+dSXn32WGq2Q0Jajjdids
         9k1nwVrmbdoo1AH2R/S+ksLS4sdolOEFtYuXe9/CoD1UFKo9h3wXMhA15eo3wSnPsi5N
         0mF0LPOWudEgo2QJymZfJrMl7vojqLBQAHAuu22ebbVQ3kObSPftDmqcI3hsN0UeefG/
         FYuA==
X-Gm-Message-State: AOAM531qOzqnbZ+uo17HT32gun30WcwoX2RE/8vfRlS2+g5JS/4MVCHd
        ecfo73TrRaK9PXwCpelMTbSsuFxujHMdF+imlJ7TFEg33VhED1W3
X-Google-Smtp-Source: ABdhPJzA3IjbHbXxcr1K2sV888cVO5o3JligdUX1Fqj1LpsSkVcqyR8Ya0CGbqlHeFyLfUT91sjvUnDJUlrN/WHd4z4=
X-Received: by 2002:a17:906:36d6:: with SMTP id b22mr36572958ejc.387.1630490975520;
 Wed, 01 Sep 2021 03:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
In-Reply-To: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 1 Sep 2021 10:09:24 +0800
Message-ID: <CAGsJ_4xtsaQL47D2D6PyW3vAr3+EwJqv-G-1V4-4GAYd2LnT3Q@mail.gmail.com>
Subject: Re: Is it possible to implement the per-node page cache for programs/libraries?
To:     Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Barry Song <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Wang <zwang@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 11:09 AM Shijie Huang
<shijie@amperemail.onmicrosoft.com> wrote:
>
> Hi Everyone,
>
>      In the NUMA, we only have one page cache for each file. For the
> program/shared libraries, the
>
> remote-access delays longer then the  local-access.
>
> So, is it possible to implement the per-node page cache for
> programs/libraries?

as far as i know, this is an very interesting topic, we do have some
"solutions" on this.
MIPS kernel supports kernel TEXT replication:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/mips/sgi-ip27/Kconfig
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/mips/sgi-ip27/ip27-klnuma.c

config REPLICATE_KTEXT
bool "Kernel text replication support"
depends on SGI_IP27
select MAPPED_KERNEL
help
 Say Y here to enable replicating the kernel text across multiple
 nodes in a NUMA cluster.  This trades memory for speed.

for x86, RedHawk Linux=EF=BC=88https://www.concurrent-rt.com/solutions/linu=
x/=EF=BC=89supports
kernel text replication.
here are some benchmark:
https://www.concurrent-rt.com/wp-content/uploads/2016/11/kernel-page-replic=
ation.pdf

For userspace, dplace from SGI can help replicate text:
https://www.spec.org/cpu2006/flags/SGI-platform.html

-r bl: specifies that text should be replicated on the NUMA node or
nodes where the process is running.
'b' indicates that binary (a.out) text should be replicated;
'l' indicates that library text should be replicated.

but all of the above except mips ktext replication are out of tree.

Please count me in if you have any solution and any pending patch.
I am interested in this topic.

>
>
>     We can do it like this:
>
>          1.) Add a new system call to control specific files to
> NUMA-aware, such as:
>
>                     set_numa_aware("/usr/lib/libc.so", enable);
>
>              After the system call, the page cache of libc.so has the
> flags "NUMA_ENABLED"
>
>
>          2.) When A new process tries to setup the MMU page table for
> libc.so, it will check
>
>               if NUMA_ENABLED is set. If it set, the kernel will give a
> page which is bind to the process's NUMA node.
>
>               By this way, we can eliminate the remote-access for
> programs/shared library.
>
>
> Is this proposal ok?  Or do you have a better idea?
>
>
> Thanks
>
> Huang Shijie

Thanks
barry
