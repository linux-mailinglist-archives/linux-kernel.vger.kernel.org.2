Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B9394AA8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 07:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhE2FtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 01:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhE2FtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 01:49:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B5AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 22:47:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v12so2606488plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 22:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+6wfairYo2CV28udtUyOfuk12wN9dfgkVcgLBZf4u1Q=;
        b=bp0r4ZR71lSmk7v/awWwkU8KPkovHiIXtln5DoWV/tTXOdfzqIS+MI4amQGOlUG5sV
         Byfa2F0kXUitG1BEYJkHdjZZTtuY8AnV5Lp5hfekK3rx8VHb7GpVV90BH/gYV9QE89FH
         +1/FOZ4/SFk4DGuITBRhnG9H0l7Icw9NO6i+n5A01BNEH4OY6RyzEjXtRLinsLYs8HOw
         waW3/pFzDDYU2AGmHeocCXzSr5UA63OROFLId3/bhby+F22BKoR18G6zvGqyspU3/v/n
         gjfufPkpfD4UfWlcTxxiUlURZzgTieGoD6BME7FynCuu6isQO/qfkkh16cJ0arty4zuV
         Dzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+6wfairYo2CV28udtUyOfuk12wN9dfgkVcgLBZf4u1Q=;
        b=i57pv1YZFswAY4qraBPvyqrfPlrFCBmsekGVwEg8FpUpz/3UWT0ETB4IrI80TlYYpC
         fP7/ZVoPWBqt05IzT7cvl0s8WyWVTZ9Du6/2F9DLSr6NR+4HTZolKl6Y2tr4qU+1aUDC
         MBnzTI1s8NLlF7QgspK1zYT7SjtW9a7NuCSO1S+wn3LwT7eKdPatuLQl6u9ozBkxlpoD
         deEpVK8/SwTn31946+emj24CSDmz3482wEAf0xpzvJm2WKZevZEgLOS1n9IAloZqdCe+
         WstGsSdhn7GMYmaL02IvG4roGDWNgHhnsiowdK09Lck0dlM37rGxB/55X5j1LdWrSLYO
         wZQw==
X-Gm-Message-State: AOAM532MPvgVqTqcfVGkVyBfmVF2zUDCY+y8AY+zPbHdzkBKDZJAz82l
        1V/0I/tknp+Wi7KRlK5g1FrtVtTenp5v+Q==
X-Google-Smtp-Source: ABdhPJx2deDrGnaHDeEYA9kYbXGp9rxsKX+GPPB4bdr+M5IHtpT4J/szzfJbjMMd2lFSPnKyFScDdQ==
X-Received: by 2002:a17:90b:4a4a:: with SMTP id lb10mr8135623pjb.21.1622267251332;
        Fri, 28 May 2021 22:47:31 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id z5sm4167126pfb.114.2021.05.28.22.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 22:47:31 -0700 (PDT)
Date:   Sat, 29 May 2021 14:47:25 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Remove redundant variable ret
Message-ID: <20210529054725.GA99161@hyeyoo>
References: <20210527171449.GA145584@hyeyoo>
 <20210528222257.7c5cb8b9@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528222257.7c5cb8b9@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 10:22:57PM -0400, Steven Rostedt wrote:
> On Fri, 28 May 2021 02:14:49 +0900
> Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> 
> > This variable saves return value of event_hist_trigger_func,
> > but it's never read. So it's redundant.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index c1abd63f1d6c..414f2727d7a7 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -5225,12 +5225,11 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
> >  	struct trace_event_file *file;
> >  	unsigned int i;
> >  	char *cmd;
> > -	int ret;
> >  
> >  	for (i = 0; i < hist_data->n_field_var_hists; i++) {
> >  		file = hist_data->field_var_hists[i]->hist_data->event_file;
> >  		cmd = hist_data->field_var_hists[i]->cmd;
> > -		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
> > +		event_hist_trigger_func(&trigger_hist_cmd, file,
> >  					      "!hist", "hist", cmd);
>
> I wonder if instead we should add:
>
> 		WARN_ON_ONCE(ret < 0);
>

Oh, Seems better to warn, not ignoring.
