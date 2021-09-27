Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8F419DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhI0SJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhI0SJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:09:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15285C061714
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:07:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l6so12322063plh.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tDOkVE0ODQlIfy+svH+8qmYmMfJw/SIE05I5QEmJTc0=;
        b=H4dtikHlIIRNu9x+nUBJ94yto7vmTPkWR8JrJ3hOvt1/U8BGZ1N+m4tQCt4tF9CT6s
         KpBUabpeYdk1Chi60PLSpsc4rxh7sfO9oGE7bCVcww60FrgVvM3lqnRYX/BB1vMyaS8P
         RH2fGw80AQ/rrLC9fW8ALjrP/aLT93HUL5bQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDOkVE0ODQlIfy+svH+8qmYmMfJw/SIE05I5QEmJTc0=;
        b=kLHOTELYXpreC3JknkOwsUyooMffIANnH2ZIPGanjC8ko8Hu89+3WhYFZNHZEy+5P6
         68V4WDliydtJmS2RPvlSzzoRXiVC9iWUyj1kCsWtShT8BvjS1iAorjHNzweXsh+Jm3Sf
         +0a1kieS1bvvqS9OTHd6YsRXA2GgqgTB+MyI6QO6BSbp5zoBXJoy41rbOV5fxAQzXk1A
         o6l3K101igqJQAPXAbhm/LZYc0D8iU4jL2QKmhSarzE9wIsgJHpLH56q3XCKDfez02Qo
         2SvghO1YPhs6xMBYToGNDJCcXUDx7g2YTlLKzExX/z/5pO6Hlx+Gh3vl3KYyzrN3ukR2
         YRLg==
X-Gm-Message-State: AOAM531W7u9qAjE6oz5GBIb8vnLXXpcqbpRxv+goIf2l8xtP4/y0CmPa
        yZU+JlB+XEYm/jjzTfKAcJrlfw==
X-Google-Smtp-Source: ABdhPJxpWsl+grzENU9fNTzNpe31Dtx/ov/zifR29rSBBH3z6+gdu1F8hPw0pBn+jIG/phol5XJ2GA==
X-Received: by 2002:a17:90a:1944:: with SMTP id 4mr497852pjh.62.1632766049496;
        Mon, 27 Sep 2021 11:07:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z62sm115624pjj.53.2021.09.27.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:07:28 -0700 (PDT)
Date:   Mon, 27 Sep 2021 11:07:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Vito Caputo <vcaputo@pengaru.com>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
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
Message-ID: <202109271103.4E15FC0@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927090337.GB1131@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:03:51AM +0100, Mark Rutland wrote:
> On Fri, Sep 24, 2021 at 07:26:22AM -0700, Kees Cook wrote:
> > On Fri, Sep 24, 2021 at 02:54:24PM +0100, Mark Rutland wrote:
> > > On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > > > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > > > entrypoint address in the current task struct for get_wchan() to
> > > > > access, whenever userspace enters the kernel?
> > > > 
> > > > wchan is supposed to show where the kernel is at the instant the
> > > > get_wchan() happens. (i.e. recording it at syscall entry would just
> > > > always show syscall entry.)
> > > 
> > > It's supposed to show where a blocked task is blocked; the "wait
> > > channel".
> > > 
> > > I'd wanted to remove get_wchan since it requires cross-task stack
> > > walking, which is generally painful.
> > 
> > Right -- this is the "fragile" part I'm worried about.

I'd like to clarify this concern first -- is the proposed fix actually
fragile? Because I think we'd be better off just restoring behavior than
trying to invent new behavior...

i.e. Josh, Jann, do you see any issues with Qi Zheng's fix here:
https://lore.kernel.org/all/20210924062006.231699-4-keescook@chromium.org/

-Kees

-- 
Kees Cook
