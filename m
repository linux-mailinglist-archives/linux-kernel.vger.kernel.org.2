Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F433689B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCKA2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCKA2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:28:10 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DE3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:28:10 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id 18so86045qty.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z3YKt4+akWhMshxfqPj2vK5QRPyAtX0nM+/P8ZuJzWI=;
        b=kQhtmvIuopCDkiD0BrNpbYQWaqlyX9kPT1SkJiwKsAHPqXaEoOclDK4//zisHVBpaR
         0RLcCC5s98ZVJcd8PswziLh/32dormacZQDWfNeszwexNBmNbXJF7pNQHHKkPB53t4K3
         ayLIVAnbQowJ1GQrjyNvZ1cs2veHOHWV8rTSFIaxWjkCH03RHSm91YUvNRp4LMLuIe/p
         DqbCuO/XSMeOcvGdNE+RgZ73LPwsXVuUX6ONyxAoP9zTXxpTYc6FR5n7tkWCXQfBafpc
         5Bpd+f/qLd3nUNE+dymOxq4r+Tk3I2pC185Wt6UQ/uLKt//8RQLrF+sRmn6MQBU9+snM
         9Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z3YKt4+akWhMshxfqPj2vK5QRPyAtX0nM+/P8ZuJzWI=;
        b=bpHdo17V5mg3tUd5XL51IrwObumminypzgrvleiodIV6lTsiXvHmuTzyN2uHFtkiKs
         eNGTb28xoWaNUiptZf/L6mD7ybwQQTuSwCbCpS2oz2ipcTIqy2QXSMml0zkNLOn55Woi
         ziRzxXr/koh9T+cunyhWG0OAbLhcCVI8TKWsVcq6Xl4Ud9McmQregxddemh5sW+COUBI
         0/4OOjGnKLuECfbckbexEDDaL53ek5edNhppoYnNOCUblZxGtmFpn5rVgqZ+ZwJ37j1W
         eOnUvtUz/RqWRQc9VrRrIwbeYx3K3LUasvFE/0EvT7icaOo/LN+8Guc329Q3q1mT0ZDe
         7MYg==
X-Gm-Message-State: AOAM533iTFQGXLyacxfrZfNlCYxfvG6Kynd6y0+Y6kYme9oDdXNZsy2j
        TyQe4Hcij12qvJ94ijjrBQ6BOb9NqDCIjw==
X-Google-Smtp-Source: ABdhPJyWW591/HyiVr02S5RNoD/FHv7m+kcsWBCJy1T5O7ymTxyaq33JmAa84+pjUz1+Izm8JQlEVw==
X-Received: by 2002:ac8:6059:: with SMTP id k25mr5338430qtm.251.1615422489207;
        Wed, 10 Mar 2021 16:28:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id l65sm728774qkf.113.2021.03.10.16.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:28:08 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lK9BP-00Aywe-Ve; Wed, 10 Mar 2021 20:28:07 -0400
Date:   Wed, 10 Mar 2021 20:28:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Ben Gardon <bgardon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Subject: Re: [PATCH] mm/oom_kill: Ensure MMU notifier range_end() is paired
 with range_start()
Message-ID: <20210311002807.GQ444867@ziepe.ca>
References: <20210310213117.1444147-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310213117.1444147-1-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 01:31:17PM -0800, Sean Christopherson wrote:
> Invoke the MMU notifier's .invalidate_range_end() callbacks even if one
> of the .invalidate_range_start() callbacks failed.  If there are multiple
> notifiers, the notifier that did not fail may have performed actions in
> its ...start() that it expects to unwind via ...end().  Per the
> mmu_notifier_ops documentation, ...start() and ...end() must be paired.

No this is not OK, if invalidate_start returns EBUSY invalidate_end
should *not* be called.

As you observed:
 
> The only in-kernel usage that is fatally broken is the SGI UV GRU driver,
> which effectively blocks and sleeps fault handlers during ...start(), and
> unblocks/wakes the handlers during ...end().  But, the only users that
> can fail ...start() are the i915 and Nouveau drivers, which are unlikely
> to collide with the SGI driver.

It used to be worse but I've since moved most of the other problematic
users to the itree notifier which doesn't have the problem.

> KVM is the only other user of ...end(), and while KVM also blocks fault
> handlers in ...start(), the fault handlers do not sleep and originate in

KVM will have its mmu_notifier_count become imbalanced:

static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
                                        const struct mmu_notifier_range *range)
{
        kvm->mmu_notifier_count++;

static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
                                        const struct mmu_notifier_range *range)
{
        kvm->mmu_notifier_count--;

Which I believe is fatal to kvm? These notifiers certainly do not only
happen at process exit.

So, both of the remaining _end users become corrupted with this patch!

I've tried to fix this before, the only thing that seems like it will
work is to sort the hlist and only call ends that have succeeded their
starts by comparing pointers with <.

This is because the hlist can have items removed concurrently under
SRCU so there is no easy way to compute the subset that succeeded in
calling start.

I had a prior effort to just ban more than 1 hlist notifier with end,
but it turns out kvm on ARM uses two all the time (IIRC)

> Found by inspection.  Verified by adding a second notifier in KVM
> that

AFAIK it is a non-problem in real life because kvm is not mixed with
notifier_start's that fail (and GRU is dead?). Everything else was
fixed by moving to itree.

Jason
