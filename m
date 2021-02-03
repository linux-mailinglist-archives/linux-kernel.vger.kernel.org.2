Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ADC30DA44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBCMy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhBCMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:51:45 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30802C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:51:04 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id w11so11527596qvz.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urlXgvdHZ7AdoyDi5Tr/sMAUoN/vP9RgT+B6nvRJ2zE=;
        b=Yn2txxbXodlxuZAbDxuOGWoA9dwl42M7uI4+u06CUV9jEufxCRzyG/2wTAw7NbOw52
         a7/SLoD/I47mklXdOnehEN2fcHzNzp8G8tCZXEC0OYGsxGschUFxCCFrBKuuL3WTZZI2
         bLzcHyvD82VDjZp1lu439Ig9FhYQU4MXpadbr7KdlnOP5S6qbAhx649sWiOPlvoBxcM6
         BoKxlrSQV4/n2qLKF5e/Q6TjSJqH5SIFIj1FgsUWC+vdkchJPzskF2vjSulhnJhqvK0q
         cjgiM/EQvRpxG7PIL+xphAYqzZantmHh0qj7DBRGsspgXuDo6kuwhGUl4Tpqwlg5ZCk6
         LxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urlXgvdHZ7AdoyDi5Tr/sMAUoN/vP9RgT+B6nvRJ2zE=;
        b=TpkKdKE3ScgKI2isU9DAMAtGN8H2KRsysRomTR+Ez7wV3hNA4wJ9WnIYGsdTFVwH9C
         5u2Gw7gWPwb4GfwnmrC0Slf2gSF8S/BBLBIDDvDiUnHkxRdCI2obDWx6lKbvBoQp+wjb
         D1Q0Nwde0+X0yxGK1ftHcuTPxKLcPBMJ9kPr4c+Itqiz+OtAsKE1+VcxYxAY3PKf/euL
         UZNQ+8Guv6eStNXhgtxFkVGU1qrq0wbvtCNfHW8+UgoZOdE70N5BtFuVovbWo5Pzgz4Z
         4pWpqh8a3x/SGtMjXtM0RtzpH+xMHx10LSeTHEd10JbpIAzRGVjEvFHU9xs6/gXwZJgA
         wy/Q==
X-Gm-Message-State: AOAM530MYsVbIFKGEFR/qYFz+G5+cp2JH5zLvHAAGfVsvLcZAHIFC3zc
        0wHWKRbJacLtqX0k3+U6TuEvQU3rDUECbGR7wbNa3w==
X-Google-Smtp-Source: ABdhPJw/PUxPdFP/SwekX/g9mATpsTLw6/Hq/gtawCPPqLL5eLqwbxTmUnop3wu6ToCNY3AhCpfvcY0xs1+jnmLJljo=
X-Received: by 2002:a0c:ab16:: with SMTP id h22mr2578667qvb.44.1612356663133;
 Wed, 03 Feb 2021 04:51:03 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net> <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net> <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
In-Reply-To: <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 3 Feb 2021 13:50:51 +0100
Message-ID: <CACT4Y+Zzp8Ci9D_bvNEDy-Ehb77V5FSbLxtFcS_0awmJq2SJ=g@mail.gmail.com>
Subject: Re: Process-wide watchpoints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 1:49 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Feb 3, 2021 at 1:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Feb 01, 2021 at 09:50:20AM +0100, Dmitry Vyukov wrote:
> > > Or, alternatively would it be reasonable for perf to generate SIGTRAP
> > > directly on watchpoint hit (like ptrace does)? That's what I am
> > > ultimately trying to do by attaching a bpf program.
> >
> > Perf should be able to generate signals, The perf_event_open manpage
> > lists two ways of trigering signals. The second way doesn't work for
> > you, due to it not working on inherited counters, but would the first
> > work?
> >
> > That is, set attr::wakeup_events and fcntl(F_SETSIG).
>
> The problem is that this sends a signal to the fd owner rather than
> the thread that hit the breakpoint. At least that's what happened in
> our tests. We would like to send a signal to the thread that hit the
> breakpoint.

I think that signal also does not carry the address and other info
typically present in SIGTRAP/SIGSEGV.
