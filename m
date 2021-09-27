Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1D541A097
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbhI0Uwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236414AbhI0Uwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632775864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JD0mT4ckkienFPXQ/dMglnBNojQj5rBrrYdubpyF/sM=;
        b=EszcsdKysQidHQio2YCBSpXbHzLy4CgLxETOBQgIw+ks/+0ZaZp2e8Fa0PPFssHFnjIks0
        KENruiYBwRmdcf5rTmUyZ3Yt4tbnO3ccqvoucL3Ed34uABFnST8tgV5V3VA8icgVPknSsU
        uEV/K35NRtGBfONCuNxK6pYPJXOqwBQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-7LFQhSIEN2OIpfIuJtsKzA-1; Mon, 27 Sep 2021 16:51:02 -0400
X-MC-Unique: 7LFQhSIEN2OIpfIuJtsKzA-1
Received: by mail-qk1-f199.google.com with SMTP id t2-20020a05620a450200b0045e34e4f9c7so11687460qkp.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JD0mT4ckkienFPXQ/dMglnBNojQj5rBrrYdubpyF/sM=;
        b=qRmRl7Gfn9HaTU/WJa9iLwQ+CSDMAG3kRrAbu1Y4kaJbMSS3w9v7QJlvyUBemLFOZD
         39cfVXOA8jTYM3V5DWdoRk/Ve/sEWrp3HnUTSSm3d7/X3cjRA750cueC32uYzgtd7o79
         xgO3tKOMalBVssOWwYSnGg64OWpxB1bOwbO0l8U7nLy7X8tcrq6cjquFULLg/u+/Hwgl
         W9uK/kYkd7HCSZNn5A8ButaUyak4jzWiKJFjYylhyqTFjdgEOiFiJTC+y9Zwfcs9Pe48
         fA/2y1JkTcj9pGhx9VBV53lgbww4AfqwaildFb9RGUmHePZ4LuEdeW0EOmA2h+GJIGKf
         vsqw==
X-Gm-Message-State: AOAM53029ZQw1CVUaQ5mYO0rGOmRQ8h1qmhVyPsET0Mf4x6/eqk8L11b
        H05AUJu8NiPxgjqeGiUhwBRgSLscL7I6kJ/WlZJOjvvWlESICFDPcu9pYNIaAJaFpuNavakaWq8
        GBN0xmUlo9sxIWRBN3XW/c9pT
X-Received: by 2002:ac8:5a4a:: with SMTP id o10mr1965121qta.61.1632775862132;
        Mon, 27 Sep 2021 13:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTRBkkAbh0TQhbT5DxVcLFqQZvP8ZJBSTBJtCeQmJMCWaVvaksY4R32FfJrYe6wg6cp394wQ==
X-Received: by 2002:ac8:5a4a:: with SMTP id o10mr1965099qta.61.1632775861872;
        Mon, 27 Sep 2021 13:51:01 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id h17sm1019186qtp.13.2021.09.27.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:51:01 -0700 (PDT)
Date:   Mon, 27 Sep 2021 13:50:56 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <20210927205056.jjdlkof5w6fs5wzw@treble>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
 <202109271103.4E15FC0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202109271103.4E15FC0@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:07:27AM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 10:03:51AM +0100, Mark Rutland wrote:
> > On Fri, Sep 24, 2021 at 07:26:22AM -0700, Kees Cook wrote:
> > > On Fri, Sep 24, 2021 at 02:54:24PM +0100, Mark Rutland wrote:
> > > > On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > > > > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > > > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > > > > entrypoint address in the current task struct for get_wchan() to
> > > > > > access, whenever userspace enters the kernel?
> > > > > 
> > > > > wchan is supposed to show where the kernel is at the instant the
> > > > > get_wchan() happens. (i.e. recording it at syscall entry would just
> > > > > always show syscall entry.)
> > > > 
> > > > It's supposed to show where a blocked task is blocked; the "wait
> > > > channel".
> > > > 
> > > > I'd wanted to remove get_wchan since it requires cross-task stack
> > > > walking, which is generally painful.
> > > 
> > > Right -- this is the "fragile" part I'm worried about.
> 
> I'd like to clarify this concern first -- is the proposed fix actually
> fragile? Because I think we'd be better off just restoring behavior than
> trying to invent new behavior...
> 
> i.e. Josh, Jann, do you see any issues with Qi Zheng's fix here:
> https://lore.kernel.org/all/20210924062006.231699-4-keescook@chromium.org/

Even with that patch, it doesn't lock the task's runqueue before reading
the stack, so there's still the possibility of the task running on
another CPU and the unwinder going off the rails a bit, which might be
used by an attacker in creative ways similar to the /proc/<pid>/stack
vulnerability Jann mentioned earlier.

-- 
Josh

