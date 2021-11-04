Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9944520B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 12:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhKDLQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDLQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 07:16:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2872CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 04:14:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g3so8854454ljm.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gazSP5VJTb2U1U3eTPsD+ETyDayZXEeUGRKkEZKjPWw=;
        b=QY7UwZKL9hDZ5a4gFuopExbBhx0n0TS6jLSz5CsjH/5yZmWincT6ktlWqitNqJaLZD
         aexK/1QWlIKPSJh/B9FxLbW/vdkhctrN9GXyAS2VYyEOFc7txUyyyQYY2L/l7RCfXzZD
         XgJrmkw+eQ2lX0yRo+ZXJln+zC5yPZuMaIVLcjvdc+0VjivmX/H0lsvZQjZlXCBrH5gg
         rSntLzKcAODFwnA8q9/zOPbsxOigmdMLjaXKFw1SX9L9G/HMuzbMHi7s98laqM0VDHQl
         xx/I3IGvb0+Z+f7OvzP4dGFiVXSgAqvSAa0+uhZIOZk8MIbbUlwGxQbFb8/PnFU8Yowy
         1RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gazSP5VJTb2U1U3eTPsD+ETyDayZXEeUGRKkEZKjPWw=;
        b=ucIavKp5b2hAhHI+AP3rOsx7h0UsSmKroUvqHWDkC/rPn7eephqr0c4Py0P3b7+Mi3
         qLZ8nE6p05toxplpdXCC2SW9XMsaAD1yFqgbbZT5v1GSOgpe8p7YmAObtTMni29HSy0a
         iUgkUd0j5gPB6ZDerl3yVvgDgdjesPXVrM/ItqFsQYgnSGraDkT70qgdkI+pWvb5DboJ
         bKogDjx09Azt4dz+juGYwrq2L+Fb1a69mQ2DpHF9J3rkBitXGqBianCb6eDzWVTR7msb
         ME3h88uer835ohq9ZQgHiqNQ9O5pSAGpJud+aUh4Y3KgYh4ScpXwa+OaMUu9mY2R608H
         czJQ==
X-Gm-Message-State: AOAM530hHbfbk1ZeNwpsyGkfdiqoZljPJCTjl1xb4sT9zkAY7zz2EkNo
        HIcB5rzrmHB3apKpy6D/ioQ=
X-Google-Smtp-Source: ABdhPJx8rwOslbBqdtPjPOAbq55N+eaLh+SmDfoZIngisU0Caz0pvRpzaTF5MvcLbflNM7n6PB0/Uw==
X-Received: by 2002:a2e:a546:: with SMTP id e6mr30170779ljn.524.1636024456483;
        Thu, 04 Nov 2021 04:14:16 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m8sm489579lfg.140.2021.11.04.04.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:14:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 4 Nov 2021 12:14:14 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [PATCH] mm/vmalloc: Eliminate an extra orig_gfp_mask
Message-ID: <20211104111414.GA1928@pc638.lan>
References: <20211103200703.2265-1-urezki@gmail.com>
 <YYOhBGACLb+p1jl0@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYOhBGACLb+p1jl0@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [Cc Vasily]
> 
> On Wed 03-11-21 21:07:03, Uladzislau Rezki wrote:
> > That extra variable has been introduced just for keeping an original
> > passed gfp_mask because it is updated with __GFP_NOWARN on entry, thus
> > error handling messages were broken.
> 
> I am not sure what you mean by "error handling messages were broken"
> part.
> 
We slightly discussed it in another thread :) There was __GFP_NOWARN added
on entry(unconditionally), what leads to ignoring all our internal error
messages by the warn_alloc(). I have checked the linux-next and saw that
Vasily sent a patch fixing it:

<snip>
Author: Vasily Averin <vvs@virtuozzo.com>
Date:   Thu Oct 21 15:07:26 2021 +1100

    mm/vmalloc: repair warn_alloc()s in __vmalloc_area_node()
    
    Commit f255935b9767 ("mm: cleanup the gfp_mask handling in
    __vmalloc_area_node") added __GFP_NOWARN to gfp_mask unconditionally
    however it disabled all output inside warn_alloc() call.  This patch saves
    original gfp_mask and provides it to all warn_alloc() calls.
<snip>

> It is true that the current Linus tree has a broken allocation failure
> reporting but that is not a fault of orig_gfp_mask. In fact patch which
> is fixing that "mm/vmalloc: repair warn_alloc()s in
> __vmalloc_area_node()" currently in akpm tree is adding the additional
> mask.
>  
> > Instead we can keep an original gfp_mask without modifying it and add
> > an extra __GFP_NOWARN flag together with gfp_mask as a parameter to
> > the vm_area_alloc_pages() function. It will make it less confused.
> 
> I would tend to agree that this is a better approach. There is already
> nested_gfp mask and one more doesn't add to the readbility.
> 
Agree, that is why i decided to send a patch. Because i find that extra
gfp variable as odd one and confusing. I paid an attention on it during
our discussion about __GFP_NOFAIL. But on my tree it was not fixed at all
and after checking the linux-next i saw a fix.

>
> Maybe we should just drop the above patch and just go with one which
> doesn't introduce the intermediate step and an additional gfp mask.
> 
That we can do if all agree on. 

Thanks!

--
Vlad Rezki
