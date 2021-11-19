Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0860A4567D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 03:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhKSCHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 21:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230151AbhKSCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 21:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637287473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGSOSbx9KHQS8zqvecKfdTvOeLPt7uvQMecFRR7horI=;
        b=bbDWT5e+tycB/WXU9BvRrHLSmmBrPl/Tle9hZjZ3uZ7ZyXg/1+kiZuOS8OGGBcEgCKrLU7
        8wDn6QmKU6DbzGoEL9WQhpZ48wSDEo7vRHEUPCA2Bp3UNtPmBObOtvOj4mA2XDLJIyhCVX
        O9Cn2MLG+1j38eqlJV2w7yLv4Q4Kssw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-dmLNkaz8ObGOt0xtRLQagA-1; Thu, 18 Nov 2021 21:04:32 -0500
X-MC-Unique: dmLNkaz8ObGOt0xtRLQagA-1
Received: by mail-qv1-f70.google.com with SMTP id q9-20020ad45749000000b003bdeb0612c5so7643818qvx.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 18:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AGSOSbx9KHQS8zqvecKfdTvOeLPt7uvQMecFRR7horI=;
        b=NKVmXcw74gyYC+NFTl+tfH/x0d76GAHqv1LjxoQ+Ef6ixYHFF30JuDzSu1BCuSCnEQ
         7pV0nidcseq74pCNeyyJvSxmuGGxSoH8Yz57bgOgiMOVFlRwbD05y2/16jRm3dDan2Nb
         5oUrivpEIEsI7V4x9k+m9EYGVFgjsP4nQFyB/SMq/cOaPR6flhp0ubn2VLXABEyfp4YI
         uTG2Xn8+T8qhggakFxd5nJN5G5QTT1PGmvxKPQbKbfw/Lx6kTcDKau4vePuHzPuO3Wxk
         RzVJAmpAJbJKlDpfGJ/EB+DUoydVNjMpzAUtnB4ZnLLNZq6JzcmhPziExLWk27s7rSrr
         wL2g==
X-Gm-Message-State: AOAM5326YG+AmYutIcM1MJkiR9gy4MGIF7Y0fnpuj7iqMj5cc8IY7HBK
        /TOVjiSVW16oS4+YjFzohxpRiZsxwhux9RajzxCAYVCnnMqIemGpopr2UQlM4x1Xdpjkl07p+A+
        8K+c/u0tTCCjL84am25tdX5I5
X-Received: by 2002:a05:620a:bd6:: with SMTP id s22mr25531291qki.306.1637287471823;
        Thu, 18 Nov 2021 18:04:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuCUqQL54jg/D75F3PqUIH6vspq7qRyOaik1SrsMas8wVNJJ8wVqJFn1+vXReR5poHB6M+1g==
X-Received: by 2002:a05:620a:bd6:: with SMTP id s22mr25531253qki.306.1637287471523;
        Thu, 18 Nov 2021 18:04:31 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id 139sm841883qkn.37.2021.11.18.18.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 18:04:30 -0800 (PST)
Date:   Thu, 18 Nov 2021 18:04:27 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/923] 5.15.3-rc3 review
Message-ID: <20211119020427.2y5esq2czquwmvwc@treble>
References: <20211117101657.463560063@linuxfoundation.org>
 <YZV02RCRVHIa144u@fedora64.linuxtx.org>
 <55c7b316-e03d-9e91-d74c-fea63c469b3b@applied-asynchrony.com>
 <CAHk-=wjHbKfck1Ws4Y0pUZ7bxdjU9eh2WK0EFsv65utfeVkT9Q@mail.gmail.com>
 <20211118080627.GH174703@worktop.programming.kicks-ass.net>
 <20211118081852.GM174730@worktop.programming.kicks-ass.net>
 <YZYfYOcqNqOyZ8Yo@hirez.programming.kicks-ass.net>
 <YZZC3Shc0XA/gHK9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZZC3Shc0XA/gHK9@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 01:11:09PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 18, 2021 at 10:39:44AM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 18, 2021 at 09:18:52AM +0100, Peter Zijlstra wrote:
> > > On Thu, Nov 18, 2021 at 09:06:27AM +0100, Peter Zijlstra wrote:
> > > > On Wed, Nov 17, 2021 at 03:50:17PM -0800, Linus Torvalds wrote:
> > > > 
> > > > > I really don't think the WCHAN code should use unwinders at all. It's
> > > > > too damn fragile, and it's too easily triggered from user space.
> > > > 
> > > > On x86, esp. with ORC, it pretty much has to. The thing is, the ORC
> > > > unwinder has been very stable so far. I'm guessing there's some really
> > > > stupid thing going on, like for example trying to unwind a freed stack.
> > > > 
> > > > I *just* managed to reproduce, so let me go have a poke.
> > > 
> > > Confirmed, with the below it no longer reproduces. Now, let me go undo
> > > that and fix the unwinder to not explode while trying to unwind nothing.
> > 
> > OK, so the bug is firmly with 5d1ceb3969b6 ("x86: Fix __get_wchan() for
> > !STACKTRACE") which lost the try_get_task_stack() that stack_trace_*()
> > does.
> > 
> > We can ofc trivially re-instate that, but I'm now running with the
> > below which I suppose is a better fix, hmm?
> > 
> > (obv I still need to look a the other two unwinders)
> 
> I now have the below, the only thing missing is that there's a
> user_mode() call on a stack based regs. Now on x86_64 we can
> __get_kernel_nofault() regs->cs and call it a day, but on i386 we have
> to also fetch regs->flags.
> 
> Is this really the way to go?

Please no.  Can we just add a check in unwind_start() to ensure the
caller did try_get_task_stack()?

-- 
Josh

