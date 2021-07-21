Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550883D0B24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhGUIUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbhGUIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:07:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C86C061766
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 01:47:58 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id i16so1209168pgi.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FQYxugu8t7vqF745nuDd0P6UH3tWWI/YKaDa8xctYR4=;
        b=XU4l682naheW6tuKnH+MytrNWxbdp9Yxn32GC8utg8SR/VPsrXfeSXRbqRr2ldZE4B
         agGAumGKQbhn9UkIWNjFal/Uww+gAiAZu8Z3sjcQXOJaizdwTd05HLwGTXLiYmvvKoEM
         khZ1dzPT0dikZFlNKTmeXUrCafw53Wxs2a5eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQYxugu8t7vqF745nuDd0P6UH3tWWI/YKaDa8xctYR4=;
        b=pOmWM4xk7HWWvwF23L/gXsXNg4jyxEEwsMTkayF/zBmrINx7wQ9MwEmwlx+NNp4XVx
         +niPLWeF7zh+ag/pAl6iiIusoXUWQXFhrFbfYKAqIQrJP6AsXcMQTIDUkTeJRU1WOGhg
         6cphXK3eucncVkc8fmflgDoWFd8QgFfvxXE54ljDqrP9qYxXdogfP3yhfSl5RSx3qwD4
         NHfVuvua0LYHrAoO7qZQ68pIxYQhmS8u4nLtXtM1z8puVSaMIG99qMIYn6Ntx+sRPrAk
         GWIHQbWsPacQ36wc/AbwGbcQsLBsHx+W+F/n6Sr4MKg70FS8rpLIz/TDzLk3dhmP7yRW
         KYVA==
X-Gm-Message-State: AOAM532kxO7cacUWES3vYUdZ1E/sgFy2UgjCQEqU8EChKKL88c4dfUVL
        9k9XM9QdVF9hO+nAW+iCnut+vw==
X-Google-Smtp-Source: ABdhPJx2D4LSvi7V3G0rkeLs5yU/EesBkZYFpPqRMSteyEvOP3OhnjDDojnYkSbfYTT48DGn/kEOHg==
X-Received: by 2002:a63:4f21:: with SMTP id d33mr3274287pgb.144.1626857278147;
        Wed, 21 Jul 2021 01:47:58 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:f1b2:269f:996b:b71a])
        by smtp.gmail.com with ESMTPSA id b10sm25785133pfi.122.2021.07.21.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 01:47:57 -0700 (PDT)
Date:   Wed, 21 Jul 2021 17:47:52 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCHv2 2/4] arm64: add guest pvstate support
Message-ID: <YPffONafHdke/O3l@google.com>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-3-senozhatsky@chromium.org>
 <877dhv35ea.wl-maz@kernel.org>
 <YPeA5ReGSwBvWGSa@google.com>
 <87im142i0b.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im142i0b.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/21 09:22), Marc Zyngier wrote:
> On Wed, 21 Jul 2021 03:05:25 +0100,
> Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > 
> > On (21/07/12 16:42), Marc Zyngier wrote:
> > > > 
> > > > PV-vcpu-state is a per-CPU struct, which, for the time being,
> > > > holds boolean `preempted' vCPU state. During the startup,
> > > > given that host supports PV-state, each guest vCPU sends
> > > > a pointer to its per-CPU variable to the host as a payload
> > > 
> > > What is the expected memory type for this memory region? What is its
> > > life cycle? Where is it allocated from?
> > 
> > Guest per-CPU area, which physical addresses is shared with the
> > host.
> 
> Again: what are the memory types you expect this to be used with?

I heard your questions, I'm trying to figure out the answers now.

As of memory type - I presume you are talking about coherent vs
non-coherent memory. Can guest per-CPU memory be non-coherent? Guest
never writes anything to the region of memory it shares with the host,
it only reads what the host writes to it. All reads and writes are
done from CPU (no devices DMA access, etc).

Do we need any cache flushes/syncs in this case?

> When will the hypervisor ever stop accessing this?

KVM always access it for the vcpus that are getting scheduled out or
scheduled in on the host side.

> How does it work across reset?

I need to figure out what happens during reset/migration in the first
place.

> I'm sorry to be that pressing, but these are the gory details that
> actually matter if you want this thing to be maintainable.

Sure, no problem.
