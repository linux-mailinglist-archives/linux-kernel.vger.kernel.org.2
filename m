Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FB33B0BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhFVRpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231726AbhFVRpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624383781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Li6M8eB7WFoY4AUKWeE2vP5iJVKbyiAFbNV5HezuJLI=;
        b=cdCM9zmjyEgRgHbbd7PuCO0S5nzI07EifNr+g0fL1wo+pFtmuwEQmZf+IdqloAXwEDCETy
        oPx4FWbJfYQMUgIz2mO3n+Ygg8KLIXCGEJyUSqbee+/Kt1sLjoFckIGdal8tsEJ0RDMGGK
        4ACwWTuNSJ3KmppVC4STc1n92uLRipY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-8d0j3GcTNg-b1n2SO9CYgA-1; Tue, 22 Jun 2021 13:43:00 -0400
X-MC-Unique: 8d0j3GcTNg-b1n2SO9CYgA-1
Received: by mail-wr1-f72.google.com with SMTP id d8-20020adfef880000b029011a9391927aso3726859wro.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Li6M8eB7WFoY4AUKWeE2vP5iJVKbyiAFbNV5HezuJLI=;
        b=SHVOWwrVH4u/EcLEjA+RPxIMJnyttOukxSLjBN2m15ggbmeC2TBfDvY4g9wW5tGopX
         fWnBR4Z3g6/wUr8O+X4g+OwN856rM81vJWSFno658uE0DM2JInXu5HQy+uCvirIrwegW
         LVt+/3qHEvO69Z7crkhcPJiLi/ml0kyah5cNgMsXCbxSOvwNGsQg4aSSBVwVgQxxf/09
         JrVPK4etvbl+fS5AGkoTKuhb8ik/ImSWVfqwrF/TvzMm/LivgYEG80K2BFXQAXHCNln2
         +pU7CqMDjjTptn2HjsWt4AzPiazBVpgC3vtG3f88WO7YImAxvDIn25ja7rFmWNlOtEOU
         5Lsw==
X-Gm-Message-State: AOAM532USuui+sE5cDjQBkipLNPhrjti4UOUDs+gj1Qunui3UvBc0A3K
        noM+kDP5dIfAlVdC3riumPP7ZF1rRZVPm8DzmM69t/FAqWditeAsNs+U/hSpaT/+h6Psvva68yf
        oV1HaUDZjUHmsXzOgcK8GSmZ8
X-Received: by 2002:a1c:ed14:: with SMTP id l20mr5850609wmh.20.1624383778945;
        Tue, 22 Jun 2021 10:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbRc0bStZfinicCTWvb1Utq2odV+ee26gaS8OLQrldd250i3h7Tfqzr6WyZCM+YumzDFhIsA==
X-Received: by 2002:a1c:ed14:: with SMTP id l20mr5850596wmh.20.1624383778839;
        Tue, 22 Jun 2021 10:42:58 -0700 (PDT)
Received: from krava ([5.171.242.79])
        by smtp.gmail.com with ESMTPSA id e15sm32960wrm.60.2021.06.22.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 10:42:58 -0700 (PDT)
Date:   Tue, 22 Jun 2021 19:42:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC 2/2] timers: Make sure irq_work is handled when no pending
 timers
Message-ID: <YNIhHmAekp2sUBCN@krava>
References: <20210610125945.558872-1-nsaenzju@redhat.com>
 <20210610125945.558872-2-nsaenzju@redhat.com>
 <87mtrmeqon.ffs@nanos.tec.linutronix.de>
 <YNHpN1h5hEZdt+Au@hirez.programming.kicks-ass.net>
 <YNIe38WaY0lOTEAZ@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIe38WaY0lOTEAZ@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 07:33:23PM +0200, Jiri Olsa wrote:
> On Tue, Jun 22, 2021 at 03:44:23PM +0200, Peter Zijlstra wrote:
> > On Sat, Jun 19, 2021 at 12:47:04AM +0200, Thomas Gleixner wrote:
> > > There are two solutions:
> > > 
> > >   1) Create a IRQ_WORK softirq and raise that
> > > 
> > >   2) Simply delegate it to a workqueue
> > 
> > IIRC someone was looking to stick the whole thing in a kthread_worker.
> > Jiri, was that you?
> > 
> 
> yep, I still plan on doing that

hum, IIRC that was actually perf specific change we discussed some
time ago I should have read the whole thread before answering

I'll check what was my plan to do and get back ;-)

jirka

