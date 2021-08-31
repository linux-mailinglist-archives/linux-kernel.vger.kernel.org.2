Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7803FCB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhHaQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:38:21 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:33702 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhHaQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:38:20 -0400
Received: by mail-pf1-f181.google.com with SMTP id u6so14786169pfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FjfxfLj+fG4rooFHLvP0f8WffL8MrE8x/5JcvPYS7Xo=;
        b=PdyDc/qlEtyCviFGGX9l74k4CV9w5MZfOS9CQZx8EjaSvKTnk2us7NjG+iIQbSUcKn
         PtZjhHBlYUalQNe2AOMJVuhmMa+bxSnrRyGeE+29W/UD2UK0R7ROm25y9MzXEFvT7XiI
         gkIPCFJosczpg0+2OyFUEcoPkoE+PNwbCY7YtcRfH9ER6tjZrXBTrHnmtadyaMhT8Zzq
         G5S+/AoX6YhBljz6cnzs4o3OMAnqrzjq0MZUDA7mdz5HA471Ui19KaJKqmjMaElAkH9b
         OkNaX+AR448CayyAJQ94cgoyCUWmx3CxxXgWsjzIXjVEYRv7bs3IY0Oc+hy7AwYF3+rY
         EWLg==
X-Gm-Message-State: AOAM530u/p/WsL6nTU0Aq8y2be+MbBFR95kIiPIQpkU6K/meVtJ9gW83
        BRczjaRsHvDXgFKefQIsGGE=
X-Google-Smtp-Source: ABdhPJzcDb5dLJUeAkSVNgRk7H+su0RFuBd+hyh6LovS4I/nz5Dr/cezzlRgCu6p16P4RtgSOKv0hg==
X-Received: by 2002:a62:1c96:0:b0:3f5:e01a:e47 with SMTP id c144-20020a621c96000000b003f5e01a0e47mr21105599pfc.76.1630427844913;
        Tue, 31 Aug 2021 09:37:24 -0700 (PDT)
Received: from sultan-box.localdomain (static-198-54-131-119.cust.tzulo.com. [198.54.131.119])
        by smtp.gmail.com with ESMTPSA id 130sm8120059pfy.175.2021.08.31.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:37:24 -0700 (PDT)
Date:   Tue, 31 Aug 2021 09:37:23 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Stuck looping on list_empty(list) in free_pcppages_bulk()
Message-ID: <YS5aw1FL0QxydYy7@sultan-box.localdomain>
References: <YS1l83lmwEYXuQsY@sultan-box.localdomain>
 <20210831124449.GB4128@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831124449.GB4128@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 01:44:49PM +0100, Mel Gorman wrote:
> That's your answer -- the PCP count has been corrupted or misaccounted.
> Given this is a Fedora kernel, check for any patches affecting
> mm/page_alloc.c that could be accounting related or that would affect
> the IRQ disabling or zone lock acquisition for problems. Another
> possibility is memory corruption -- either kernel or the hardware
> itself.

Hmm, I don't see any changes to mm/page_alloc.c from Fedora for this kernel.

What about a memory allocation originating from inside an NMI? I think this
could occur quite easily with an eBPF program registered to a tracepoint, as
some of the eBPF helpers do allocate memory on the fly for certain map types.

> > I tried to find some way that this could happen, but the only thing I could
> > think of was that maybe an allocation had both __GFP_RECLAIMABLE and
> > __GFP_MOVABLE set in its gfp mask, in which case the rmqueue() call in
> > get_page_from_freelist() would pass in a migratetype equal to MIGRATE_PCPTYPES
> > and then pages could be added to an out-of-bounds pcp list while still
> > incrementing the overall pcp count. This seems pretty unlikely though.
> 
> It's unlikely because it would be an outright bug to specify both flags.

Perhaps that VM_WARN_ON should be changed to a VM_BUG_ON?

Thanks,
Sultan
