Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D0143C508
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbhJ0I2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:28:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40496 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbhJ0I2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:28:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EB7672195E;
        Wed, 27 Oct 2021 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635323174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lqxo+EjDn5bKx1T8Ew7F30FEa32NiHZv+Phf/jFObIc=;
        b=Q6aRDwKFHTylT0/YntdBzdOTHpyeoLztAmEzSH4i4oKDs0A7FRl5igo/Jgs7FhRbP+fxjF
        XItgh9R0S4eDs6DHldPCn8BkX5a85UWRvxmyaw5K9mfFmV8nqktfUezHMczc1Zl7YcaYS1
        mB/fMQpAb43nPEYdmZBacWK6ifSCZlo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6F92AA3B81;
        Wed, 27 Oct 2021 08:26:14 +0000 (UTC)
Date:   Wed, 27 Oct 2021 10:26:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: have kswapd only reclaiming use min protection
 on memcg
Message-ID: <YXkNJjD4axYlmqQ5@dhcp22.suse.cz>
References: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com>
 <YXj9w+8Bwlkz5PRy@dhcp22.suse.cz>
 <CAGWkznHVHVBrQEiO32p2uX_5BDUMc1fE64KuV34WJfpwC_23Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHVHVBrQEiO32p2uX_5BDUMc1fE64KuV34WJfpwC_23Pw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-10-21 15:46:19, Zhaoyang Huang wrote:
> On Wed, Oct 27, 2021 at 3:20 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 27-10-21 15:01:50, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > For the kswapd only reclaiming, there is no chance to try again on
> > > this group while direct reclaim has. fix it by judging gfp flag.
> >
> > There is no problem description (same as in your last submissions. Have
> > you looked at the patch submission documentation as recommended
> > previously?).
> >
> > Also this patch doesn't make any sense. Both direct reclaim and kswapd
> > use a gfp mask which contains __GFP_DIRECT_RECLAIM (see balance_pgdat
> > for the kswapd part)..
> ok, but how does the reclaiming try with memcg's min protection on the
> alloc without __GFP_DIRECT_RECLAIM?

I do not follow. There is no need to protect memcg if the allocation
request doesn't have __GFP_DIRECT_RECLAIM because that would fail the
charge if a hard limit is reached, see try_charge_memcg and
gfpflags_allow_blocking check.

Background reclaim, on the other hand never breaches reclaim protection.

What is the actual problem you want to solve?

-- 
Michal Hocko
SUSE Labs
