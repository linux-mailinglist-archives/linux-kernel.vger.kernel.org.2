Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F763778AA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhEIV1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 17:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhEIV1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 17:27:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66324C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 14:26:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x20so20424951lfu.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XnuIGDHz+vWuMXJWxtX9N5UENBs226CX5hzP3bDj+NE=;
        b=YtCpBUB7I9innRiRVY6qqANz4wGuCSq3nS1d16rPHtz7iPxjzWbk76l4mllNaivafB
         SBNlBiWz98s2pMCqOBCDO9U0Jr/MidaotwWuafuu20L7ywZSrx9dGB+TBqaaRlv+3zN+
         zkjKQFA2jNL14hwI8w6b5VEB0Wlq+uMBscZvuE3foEthKmlMLJoGRfls65OyOWSnVwxJ
         UwbRX86Qo++axUGRLjLfVehSqvszOM6/kWrZ4onyeJe+irq9qLzlpCrXhgiWf4YU2ZR7
         LD0VVxACoF1M2CkhtMjG7Uo1LBWlLYsw/W3ZvbQCErvAhx6d1KxTq1OPk/Fy7HycvHSb
         1P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XnuIGDHz+vWuMXJWxtX9N5UENBs226CX5hzP3bDj+NE=;
        b=ALmq8wkWAyr9dUT4o9UV5PMG9/Mgvjmfy/mcu4aWChXYFD8CtTF4l2rTOn3kykNG5R
         f6sOr1ACklR5AZUlr3VR/3d+J/QFP2CGY3A/LrysLPzeBiXlBVSdqV4pEqhQqICEPp7i
         34kTBcZBgMKeQ8/V6hzJuYoP8jukL1Yjg7Pvi5DjRn30x1LJ/HqzG2qntHrw3VKgJkEI
         aEnXY9WdnXmNb/V1OpXHEUDFBg8AKIDpvoAnPdz9+WY6HOz9KU5Yhj2hl+MrtI92Ap5b
         L2Pfi50Y1yHCIh+ydScDtkCDijwOBteJCj83sAb9kbN5dtBD9g7g1yodW5/93H0V5Y9J
         G5fA==
X-Gm-Message-State: AOAM533/ajJ6E2dWxjzTsmrBCSrKCQ7fKoPGzjy6LR/tWXOIYNABauym
        gRamRj1069LtXzyfZ/lVZh8qLc0RH0c=
X-Google-Smtp-Source: ABdhPJwRMr947DzuupSIRzSqQlbwxhpXzwE8XuPrSB3NgTjdSx/m6FxyYhl99GiFfU0NkPnDemFp9g==
X-Received: by 2002:ac2:4ed9:: with SMTP id p25mr14223916lfr.576.1620595603784;
        Sun, 09 May 2021 14:26:43 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id j16sm1984029lfe.152.2021.05.09.14.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 14:26:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sun, 9 May 2021 23:26:41 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on
 failure
Message-ID: <20210509212641.GA3220@pc638.lan>
References: <20210509193844.2562-1-urezki@gmail.com>
 <20210509193844.2562-2-urezki@gmail.com>
 <YJg8QO2JXm0+8UH6@casper.infradead.org>
 <20210509200519.GA3016@pc638.lan>
 <YJhDpkpdUKiNEAnt@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJhDpkpdUKiNEAnt@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 09:18:46PM +0100, Matthew Wilcox wrote:
> On Sun, May 09, 2021 at 10:05:19PM +0200, Uladzislau Rezki wrote:
> > On Sun, May 09, 2021 at 08:47:12PM +0100, Matthew Wilcox wrote:
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > >  	}
> > > >  
> > > >  	if (!area->pages) {
> > > > -		free_vm_area(area);
> > > >  		warn_alloc(gfp_mask, NULL,
> > > >  			   "vmalloc size %lu allocation failure: "
> > > >  			   "page array size %lu allocation failed",
> > > >  			   nr_small_pages * PAGE_SIZE, array_size);
> > > > +		free_vm_area(area);
> > > >  		return NULL;
> > > >  	}
> > > 
> > > I think this is a bad idea.  We're clearly low on memory (a memory
> > > allocation just failed).  We should free the memory we have allocated
> > > to improve the chances of the warning message making it out.
> > Not sure if i fully follow you here. We do free the memory. The intention
> > was to print a warning message first because, if, potentially, the
> > free_vm_area(area) also does some prints it would be a bit messy from the
> > point what has been broken first.
> > 
> > So, could you please clarify what was your concern?
> 
> We may need to allocate memory in order to emit the error message.
>
> Your commit message didn't mention the potential confusion, and I think
> that is worth adding for a v4.
I agree that the commit message should be updated in regard of potential
confusion, because it was the main intention of this patch.

I will upload a v4 tomorrow.

--
Vlad Rezki
