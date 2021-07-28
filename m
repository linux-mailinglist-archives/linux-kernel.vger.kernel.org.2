Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5383D8D46
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhG1Lzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234703AbhG1Lzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627473337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/Q78dC9Pxjp5fkpXVNbsBhMnnXWxmv4V/EO3fwYVy8=;
        b=hiT4tr4Ebpx3Aj2B9EvvEqz6saPYeri9gQ8Kl26OTvw6cRVOPZNLFHsekc+TcQ9TH28vhn
        C4iV6hnhBq1m6Lwh/pXLT0Mh//2L8aAKtlbdwLR76dmG5Yje4CB/HscVbEs0yfOJsCdey6
        W0CBq/0kkooUhQncG8qmyJ/6jCn2oAg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-EqiYNKdfO76IcIUKLLsx8A-1; Wed, 28 Jul 2021 07:55:36 -0400
X-MC-Unique: EqiYNKdfO76IcIUKLLsx8A-1
Received: by mail-wm1-f71.google.com with SMTP id f25-20020a1c6a190000b029024fa863f6b0so1347906wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 04:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=k/Q78dC9Pxjp5fkpXVNbsBhMnnXWxmv4V/EO3fwYVy8=;
        b=hMOwRKJmCEQpY5k/g+Tp5WHOpjbp6HWfw7qyAy44aNZcsiSiQFgtUrxDtd80Khjd0K
         LD34NnE4FCFCq+O5oqXYD8EHFnXSEMMzhC3C4ukCa8PX/MBcNFJe/4WKNRoEEscZTzxq
         yNEXqjWnSh+35OVIaoay7qWNycZAseEP+FfYL39Av+Zqq4p0lVQ7SOyLJDFJhBq8/VOO
         0R6AiA1f081L/Sf9CRgFz4fDmtPCrZj5JV/NjPYiTauwN6Y+JJRa2W+8sWpTGE1aT/Yf
         DZAH5ioqrR5ImFUlrWFnSdxrdvYYvdwCPyAEnWmRW4tugyAV8y9ey5XEsqFSz0QwfWiF
         GUfw==
X-Gm-Message-State: AOAM530OHrYcJiuSEaF6xp29dJVv4eev08b74Tt6M9YW+05tqkUjUwvO
        cw+mUJ7DhnQ30g4wzrOC0A2eXrh/7EqN769Wtab24cp1BoCNU1jI4cfjLHVj/NLGZeYGntFIPGy
        tlJ6B1r+P1dQobf5nlsJ5BQW/
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr9351417wmb.12.1627473334845;
        Wed, 28 Jul 2021 04:55:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsehtXPoZItApK+a7SPi+GFpPFQZH5GhNePkpdi90AaJtsZtLFixxpf0y/0YdG1KivVsiJAw==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr9351408wmb.12.1627473334691;
        Wed, 28 Jul 2021 04:55:34 -0700 (PDT)
Received: from [192.168.1.136] ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id e3sm6672682wrw.51.2021.07.28.04.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 04:55:34 -0700 (PDT)
Message-ID: <e0135b88dad323d0abd1ce05081e0b554421af7c.camel@redhat.com>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
From:   nsaenzju@redhat.com
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 28 Jul 2021 13:55:33 +0200
In-Reply-To: <20210728093707.GA3242@fuller.cnet>
References: <20210727103803.464432924@fuller.cnet>
         <20210727104119.551607458@fuller.cnet>
         <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
         <20210727110050.GA502360@fuller.cnet>
         <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
         <20210727130930.GB283787@lothringen> <20210727145209.GA518735@fuller.cnet>
         <20210727234539.GH283787@lothringen> <20210728093707.GA3242@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Wed, 2021-07-28 at 06:37 -0300, Marcelo Tosatti wrote:
> On Wed, Jul 28, 2021 at 01:45:39AM +0200, Frederic Weisbecker wrote:
> > On Tue, Jul 27, 2021 at 11:52:09AM -0300, Marcelo Tosatti wrote:
> > > The meaning of isolated is specified as follows:
> > > 
> > > Isolation features
> > > ==================
> > > 
> > > - prctl(PR_ISOL_GET, ISOL_SUP_FEATURES, 0, 0, 0) returns the supported
> > > features as a return value.
> > > 
> > > - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
> > > the bitmask.
> > > 
> > > - prctl(PR_ISOL_GET, ISOL_FEATURES, 0, 0, 0) returns the currently
> > > enabled features.
> > 
> > So what are the ISOL_FEATURES here? A mode that we enter such as flush
> > vmstat _everytime_ we resume to userpace after (and including) this prctl() ?
> 
> ISOL_FEATURES is just the "command" type (which you can get and set).
> 
> The bitmask would include ISOL_F_QUIESCE_ON_URET, so:
> 
> - bitmask = ISOL_F_QUIESCE_ON_URET;
> - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
> the bitmask.
> 
> - quiesce_bitmap = prctl(PR_ISOL_GET, PR_ISOL_SUP_QUIESCE_CFG, 0, 0, 0)
>   (1)
> 
>   (returns the supported actions to be quiesced).
> 
> - prctl(PR_ISOL_SET, PR_ISOL_QUIESCE_CFG, quiesce_bitmask, 0, 0) _sets_
> the actions to be quiesced (2)
> 
> If an application does not modify "quiesce_bitmask" between 
> points (1) and (2) above, it will enable quiescing of all
> "features" the kernel supports.

I think this pattern of enabling all by default might be prone to subtly
breaking things.

For example, let's say we introduce ISOL_F_QUIESCE_DEFER_TLB_FLUSH, this will
defer relatively short IPIs on isolated CPUs in exchange for a longer flush
whenever we enter the kernel (syscall, IRQs, NMI, etc...). A latency sensitive
application might be OK with the former but not with the latter.

-- 
Nicolás Sáenz

