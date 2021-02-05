Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CCA311392
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhBEV3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhBEV2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:28:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E40C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 13:28:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a16so4218794plh.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 13:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aQuIxt4qvPi4mU+J/H3ohYCdk1Zq8+c6bt8dGfJG8Pw=;
        b=M9KAfYqjvDgDhmLxL0xXu4CVhni6pxxAvxd2v/ELKrGswp12IARwV/uqMEHWiEwctn
         Izw+OFc+zwt+12exGttKFso8ieX4K6alWxxAopLLyM874U+RevfvNJ7utSQcOvxDFuCM
         MOcEoB28MErvU5zMoJetH3EthkYgUxs8jtvQIbsnBkxhUVJoJz9ZMjU/NB5qrIgn1Izg
         A3BHLhozns7v1shEh7o0iFytEA8rbyw5DbiRkLFMaU+iQFOQifHGKy3YPZpn2Wm0lKxx
         fFoV6C8KpgGiBmbHthZppBN1+I5vi/QVPoWQ4BGhs12I6AaqMnQylfZndH2csiUinspA
         vLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aQuIxt4qvPi4mU+J/H3ohYCdk1Zq8+c6bt8dGfJG8Pw=;
        b=AQw8bkgLuc0TnvPnKufUiG8mZSl7TIsIec45OvMl9dyymGIqjTowQtSQO93E4DvPxg
         luvVaRQQ+a5EviaUsSEY90kJU0lUapQCgbFZB9Vg+NBMoBZwJkSCdnkaiCxdZo6D8IHb
         wy04DxI34J7aqyHITRnDEqME/cC6l2921MTJ7I3oUw2axojk5D5h706i/isug222p2o6
         rZ36EVu0KT0JUub21MjGY5VcJnUd08nqIwefvR6tNdmTnbR6Gf6s78OeTdHrADv8cHOP
         LnW3ClCDAFuKzN1APHUnb3eyTak10g29erSG1XR++7jAJ8n+JRxPpEvH32YzXS5Hmxo3
         vTXg==
X-Gm-Message-State: AOAM530YWfGTqbCzqC7aavdOL964V8im3xWTcdn1PrazPZueWue4SpuJ
        2XubrTeT9ijm3a/BqiL9TNQ=
X-Google-Smtp-Source: ABdhPJxWa/XKCsQ50GPbzWeDivRtcPtlEhfVXNu8HGKJCYoRqfZo4ZqWMGJJwtOseHuRLIQJpaVWvQ==
X-Received: by 2002:a17:90b:4ad2:: with SMTP id mh18mr5749448pjb.137.1612560483852;
        Fri, 05 Feb 2021 13:28:03 -0800 (PST)
Received: from google.com ([2620:15c:211:201:708b:34cf:3e70:176d])
        by smtp.gmail.com with ESMTPSA id k31sm12256798pgi.5.2021.02.05.13.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:28:02 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 5 Feb 2021 13:28:01 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YB24YXMJOjwokDb5@google.com>
References: <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
 <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
 <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com>
 <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
 <YB1vIrgI9S/5CDxL@google.com>
 <269689b7-3b6d-55dc-9044-fbf2984089ab@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <269689b7-3b6d-55dc-9044-fbf2984089ab@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:25:52PM -0800, John Hubbard wrote:
> On 2/5/21 8:15 AM, Minchan Kim wrote:
> ...
> > > Yes, approximately. I was wondering if this would suffice at least as a baseline:
> > > 
> > > cma_alloc_success   125
> > > cma_alloc_failure   25
> > 
> > IMO, regardless of the my patch, it would be good to have such statistics
> > in that CMA was born to replace carved out memory with dynamic allocation
> > ideally for memory efficiency ideally so failure should regard critical
> > so admin could notice it how the system is hurt.
> 
> Right. So CMA failures are useful for the admin to see, understood.
> 
> > 
> > Anyway, it's not enough for me and orthgonal with my goal.
> > 
> 
> OK. But...what *is* your goal, and why is this useless (that's what
> orthogonal really means here) for your goal?

As I mentioned, the goal is to monitor the failure from each of CMA
since they have each own purpose.

Let's have an example.

System has 5 CMA area and each CMA is associated with each
user scenario. They have exclusive CMA area to avoid
fragmentation problem.

CMA-1 depends on bluetooh
CMA-2 depends on WIFI
CMA-3 depends on sensor-A
CMA-4 depends on sensor-B
CMA-5 depends on sensor-C

With this, we could catch which module was affected but with global failure,
I couldn't find who was affected.

> 
> Also, would you be willing to try out something simple first,
> such as providing indication that cma is active and it's overall success
> rate, like this:
> 
> /proc/vmstat:
> 
> cma_alloc_success   125
> cma_alloc_failure   25
> 
> ...or is the only way to provide the more detailed items, complete with
> per-CMA details, in a non-debugfs location?
> 
> 
> > > 
> > > ...and then, to see if more is needed, some questions:
> > > 
> > > a)  Do you know of an upper bound on how many cma areas there can be
> > > (I think Matthew also asked that)?
> > 
> > There is no upper bound since it's configurable.
> > 
> 
> OK, thanks,so that pretty much rules out putting per-cma details into
> anything other than a directory or something like it.
> 
> > > 
> > > b) Is tracking the cma area really as valuable as other possibilities? We can put
> > > "a few" to "several" items here, so really want to get your very favorite bits of
> > > information in. If, for example, there can be *lots* of cma areas, then maybe tracking
> > 
> > At this moment, allocation/failure for each CMA area since they have
> > particular own usecase, which makes me easy to keep which module will
> > be affected. I think it is very useful per-CMA statistics as minimum
> > code change so I want to enable it by default under CONFIG_CMA && CONFIG_SYSFS.
> > 
> > > by a range of allocation sizes is better...
> > 
> > I takes your suggestion something like this.
> > 
> > [alloc_range] could be order or range by interval
> > 
> > /sys/kernel/mm/cma/cma-A/[alloc_range]/success
> > /sys/kernel/mm/cma/cma-A/[alloc_range]/fail
> > ..
> > ..
> > /sys/kernel/mm/cma/cma-Z/[alloc_range]/success
> > /sys/kernel/mm/cma/cma-Z/[alloc_range]/fail
> 
> Actually, I meant, "ranges instead of cma areas", like this:
> 
> /<path-to-cma-data/[alloc_range_1]/success
> /<path-to-cma-data/[alloc_range_1]/fail
> /<path-to-cma-data/[alloc_range_2]/success
> /<path-to-cma-data/[alloc_range_2]/fail
> ...
> /<path-to-cma-data/[alloc_range_max]/success
> /<path-to-cma-data/[alloc_range_max]/fail
> 
> The idea is that knowing the allocation sizes that succeeded
> and failed is maybe even more interesting and useful than
> knowing the cma area that contains them.

Understand your point but it would make hard to find who was
affected by the failure. That's why I suggested to have your
suggestion under additional config since per-cma metric with
simple sucess/failure are enough.

> 
> > 
> > I agree it would be also useful but I'd like to enable it under
> > CONFIG_CMA_SYSFS_ALLOC_RANGE as separate patchset.
> > 
> 
> I will stop harassing you very soon, just want to bottom out on
> understanding the real goals first. :)
> 

I hope my example makes the goal more clear for you.
