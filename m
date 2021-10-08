Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B01426E85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhJHQTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhJHQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633709845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8CaDxS3ZxSSQU+iGhFbf89kwNPmHoSD1YG/GilwFS8=;
        b=MPJCIuBfRJFxdEeSKix14lm8blSJ1fkUKXjPbImU3zJQ/LOSzh4PkcXMmTrbEfLdvKMPm5
        ZeCZQV4k76CBZG6vXAZmw+JrDj039m9TDvAlKJ9rau0rqWSeUxTlgfX933R+Qyn4wi2bsg
        c1dTUUX789bt86HuspIGIpYD5a3Ln3c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-mfVdrCHMMbCg9ui-ovEBxg-1; Fri, 08 Oct 2021 12:17:14 -0400
X-MC-Unique: mfVdrCHMMbCg9ui-ovEBxg-1
Received: by mail-qk1-f198.google.com with SMTP id i16-20020a05620a249000b004558dcb5663so8622050qkn.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 09:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F8CaDxS3ZxSSQU+iGhFbf89kwNPmHoSD1YG/GilwFS8=;
        b=b9KGrPNggQ4WkbrX2+/zXQnrcG7T9eoF+9HQok3Y033QBkW0bEa6lAJS76WITksJk6
         1evBddnigjFGWK+qSiIaxoMIkRwj+UvXdgoRyv5bqXIg5hv5AwYT5QT73WyqNmMjW9ZQ
         Vsl7IckAmryQiXbTvxEBJltq39p92L7gBlyYeUh73dBmiZMiQp1s+hnDw+2IOB17uO/j
         /n3RmOGowL8Mwq6gN6EPqf65vIKYEsBBSyaVtJaspSjQpExrL9TitT0xCyUOCG+pvZmF
         AazsigM8XAcwO6PmU64n6qwUkmnG2RAxOabWW4PyfEKfR/t/OALfV+8XRyzff/U2VnY8
         2ugA==
X-Gm-Message-State: AOAM532fC9s5FcxTeFa92UPapBYI9fDELRr/j196W1PfAnCDEsK7iGgm
        x0lcDkYZ5gii36MCOoqVmm7rb0+aVa3Y1020WdLvxvBLan5YLj9RPeUEBMvwoYu1Yq4d5noBshr
        4TnULMLY2txkfXWJ8XNIBDQYJ
X-Received: by 2002:a05:6214:294:: with SMTP id l20mr9523303qvv.30.1633709834203;
        Fri, 08 Oct 2021 09:17:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6ExCuEMbasm/gLwW//wQY0/4UCLYUOl4ssvLqUvFOcMjFiAJy1vmJaiafPCJcjnPk3KtghQ==
X-Received: by 2002:a05:6214:294:: with SMTP id l20mr9523255qvv.30.1633709834017;
        Fri, 08 Oct 2021 09:17:14 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id p19sm2730266qtk.20.2021.10.08.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:17:13 -0700 (PDT)
Date:   Fri, 8 Oct 2021 09:17:07 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, keescook@chromium.org,
        jannh@google.com, linux-kernel@vger.kernel.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, vgupta@kernel.org,
        linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, jonas@southpole.se, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, hca@linux.ibm.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, chris@zankel.net
Subject: Re: [PATCH 6/7] arch: __get_wchan || STACKTRACE_SUPPORT
Message-ID: <20211008161707.i3cwz6qukgcf4frj@treble>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
 <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 03:45:59PM +0200, Peter Zijlstra wrote:
> > stack_trace_save_tsk() *shouldn't* skip anything unless we've explicitly
> > told it to via skipnr, because I'd expect that
> 
> It's what most archs happen to do today and is what
> stack_trace_save_tsk() as implemented using arch_stack_walk() does.
> Which is I think the closest to canonical we have.

It *is* confusing though.  Even if 'nosched' may be the normally
desired behavior, stack_trace_save_tsk() should probably be named
stack_trace_save_tsk_nosched().

-- 
Josh

