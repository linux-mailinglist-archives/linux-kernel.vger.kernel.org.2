Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75342D1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 06:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhJNEwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhJNEwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:52:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84915C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 21:50:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f5so4356003pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 21:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9DetIrTrPrsxfQH/lpQwqKA5J37Ffr1H8IrZdHL7xCE=;
        b=WsrEMkAwp69MeiqP4qdzJS2Cu3sPvWyv5NOCj3NZ+TxrWg4ZQGlJGvg4ZWOakEiT7j
         I+zdKBj69tzsr44ASBFXDKS8bkp6Sx6uu/M6sjMa+W7K4BFRQoOgAwFTufUt7SUG/Ev9
         HjgCQd6g3J/I36Ip2M9329RNpOo0Bqusa86hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9DetIrTrPrsxfQH/lpQwqKA5J37Ffr1H8IrZdHL7xCE=;
        b=7grEzWHi3791hoWefi8sNGs1haJ0g2eND/wNecnJa4qokOU8TzeFytWDW0O8p4yqeO
         RsRhShtJz0pfZcarNfIcOrcny4efCATdgydFbGDYL0aGyP2lzD+WxqvfKOakzEikbzAb
         0ekoRH8ly0ZdFxkcVIDf9Eo7hJqYEXDPid+qCSq7hbM78slIOpNznkyhST9exaQRP0E4
         UvuNyzRUX50Vgn+2PoSePigxBkkSomwRtlStg/8G0tzRTbElIkDiqGUs/k1cDE32s8rs
         FHgNexYTUOgYadGX3t4xzaCW8ntkT8GQ7EY6ZGQShYK3+iSHApiZkILyRLHcV88UYnHM
         VV0g==
X-Gm-Message-State: AOAM532tHpMsCHnZ8tXt5QJOxqrzwG8GWDIdazzg7wLTFlyneIt2YDc9
        pMX1QwpEHMVAy5q95SxRxMTDjw==
X-Google-Smtp-Source: ABdhPJxALx5mT4TuuCD6pTuD5MXLybW8qq/EVMLvrRepZBCZZDhcDd0JwOkjp5Vr5+/8ICpU5zh5Vg==
X-Received: by 2002:a62:cd0f:0:b0:447:b8fe:d6c2 with SMTP id o15-20020a62cd0f000000b00447b8fed6c2mr3426171pfg.70.1634187044668;
        Wed, 13 Oct 2021 21:50:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i13sm1065037pgn.69.2021.10.13.21.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 21:50:44 -0700 (PDT)
Date:   Wed, 13 Oct 2021 21:50:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 2/5] connector: use __get_task_comm in
 proc_comm_connector
Message-ID: <202110132148.523C3EA@keescook>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
 <20211013102346.179642-3-laoar.shao@gmail.com>
 <20211013101921.0843aaf0@gandalf.local.home>
 <CALOAHbCt+rLiPE4_zZO_f5sKybKwYntqupx_L9V_J+yByoFvOw@mail.gmail.com>
 <20211013222418.7ea9727d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013222418.7ea9727d@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:24:18PM -0400, Steven Rostedt wrote:
> On Thu, 14 Oct 2021 09:48:09 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> > > __get_task_comm() uses strncpy() which my understanding is, does not add
> > > the nul terminating byte when truncating. Which changes the functionality
> > > here. As all task comms have a terminating byte, the old method would copy
> > > that and include it. This won't add the terminating byte if the buffer is
> > > smaller than the comm, and that might cause issues.
> > >  
> > 
> > Right, that is a problem.
> > It seems that we should add a new helper get_task_comm_may_truncated().
> 
> Or simply change __get_task_comm() to:
> 
> char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
> {
> 	task_lock(tsk);
> 	strncpy(buf, tsk->comm, buf_size);
> 	/* The copied value is always nul terminated */
> 	buf[buf_size - 1] = '\0';
> 	task_unlock(tsk);
> 	return buf;
> }
> 
> But that should probably be a separate patch.

strscpy_pad() is the right thing here -- it'll retain the NUL-fill
properties of strncpy and terminate correctly.

The use of non-terminating issue with strncpy() wasn't a problem here
because get_task_comm() would always make sure task->comm was
terminated. (It uses strlcpy(), which I think needs to be changed to
strscpy_pad() too...)

-- 
Kees Cook
