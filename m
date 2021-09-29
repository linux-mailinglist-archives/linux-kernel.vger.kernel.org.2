Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FED41CDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 23:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbhI2VMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 17:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346355AbhI2VMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 17:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632949830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wIkb/A/ZJJji8jbTcCnkjRo12VXeXRq0QRKfxt1FsB0=;
        b=HapCW9uaayQK6EL1OhRm8lKbwfmH7r8URVkAHHd7z6zLYuQtI/C9siyeSXIhSiWnVM6Blw
        p+GHuoeiXsHwInbqX3UKgXAfuePd5FG8ti5PkycGltOvcOAo8MU/Y8uNnLb3UtQVJdUg0i
        eeazlJwiX6N+eEbBmTdyqcbXB2/+IYI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-DL5MsEY0NY2-yFdCZiDoJg-1; Wed, 29 Sep 2021 17:10:29 -0400
X-MC-Unique: DL5MsEY0NY2-yFdCZiDoJg-1
Received: by mail-qk1-f200.google.com with SMTP id r5-20020a05620a298500b0045dac5fb940so11087808qkp.17
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIkb/A/ZJJji8jbTcCnkjRo12VXeXRq0QRKfxt1FsB0=;
        b=xEZzKHHnWFyUjlA83l1seaNoSL6ucGkFio9Fb4HVxRej7vk3nMUdr0U4z0JQNYM5Df
         O+0FBmzIHQyS9d+ou1hE9sWA9c0Sx5FFaph4dKX3KvRCDK+M/LeOd5WB+FeC2l1pkiqF
         NCzJSZp5uPnmRMbE8l+FMhIxfH8uBqCx/YBJkZ3D6SO86WLBHfqQ84v0F1kW7cwS/Mmg
         v6/dhZc222JmfNim1uaitaPK2jq1sLIbpv0+Q8gqQVSTbtbHihRqbIcgpzeT0abH24et
         3hFoG4ya60+kZW/B4uHrObrpkOB6UZsw7idPH1LEdWaJKsFCMmiIhtOgLkLetkUicp6t
         wkEQ==
X-Gm-Message-State: AOAM530SqzJ3nVWzYkLMXEPeDmMpb8N2dKXcZsJUASSnYPDsHndoJ8CY
        xEv0zcScbTIifirKkL+2yDOfMp+cvTA2gcPFLTkGM9ZOBsGYCfmW4oFXfEHiWGhO/WGnMJw5rmM
        nQ5jbS4W8qmPYDHyR2jiqCn+m
X-Received: by 2002:a05:620a:22e:: with SMTP id u14mr1806749qkm.101.1632949829289;
        Wed, 29 Sep 2021 14:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcgVEpWdM29SW/CX8zRJPEzIxUJPnsb1Fm0pAA0XRfwrFWVYuJzcONjT5C6NUoEyRfY0MPcw==
X-Received: by 2002:a05:620a:22e:: with SMTP id u14mr1806721qkm.101.1632949829055;
        Wed, 29 Sep 2021 14:10:29 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id x10sm569784qtq.45.2021.09.29.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 14:10:28 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:10:23 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20210929211023.runlsoqfto7hrl36@treble>
References: <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
 <202109271103.4E15FC0@keescook>
 <20210927205056.jjdlkof5w6fs5wzw@treble>
 <202109291152.681444A135@keescook>
 <20210929194026.GA4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210929194026.GA4323@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:40:26PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 29, 2021 at 11:54:55AM -0700, Kees Cook wrote:
> 
> > > > > > > It's supposed to show where a blocked task is blocked; the "wait
> > > > > > > channel".
> 
> > Since I think we're considering get_wchan() to be slow-path, can we just
> > lock the runqueue and use arch_stack_walk_reliable()?
> 
> Funny thing, when a task is blocked it isn't on the runqueue :-)
> 
> So if all we want to do is capture a blocked task and fail otherwise we
> don't need the rq->lock at all.
> 
> Something like:
> 
> 	unsigned long ip = 0;
> 
> 	raw_spin_lock_irq(&p->pi_lock);
> 	state = READ_ONCE(p->__state);
> 	smp_rmb(); /* see try_to_wake_up() */
> 	if (state == TASK_RUNNING || state == TASK_WAKING || p->on_rq)
> 		goto unlock;
> 
> 	ip = /* do actual stack walk on a blocked task */
> unlock:
> 	raw_spin_unlock_irq(&p->pi_lock);
> 
> 	return ip;

Ah, cool :-)

I'd also add that I don't see any reason to use the "reliable" unwinding
variant.  AFAIK, just basic stack_trace_save_tsk() should be sufficient.

-- 
Josh

