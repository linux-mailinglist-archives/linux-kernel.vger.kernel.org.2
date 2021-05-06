Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECDC374FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhEFHDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:03:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:37276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232876AbhEFHDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620284571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5eja9I0EQLqYhrMODxAXlUryd/r1+oYlgXc94+Yz3c=;
        b=K6u7ICpEtgBND/9O5ZdhYg8ZGnPEAe4sn/tzru5Yf5/40/vGOyOrYtcG/o4JSjFC71XAQt
        7switeqQgjviJ7SZgyxCCiSQzVndEumBv/nLrct/ONo1GtsLIoaRh3q7Q1gG3y5f0DU2+O
        TXYr+Ia0X8nf/3Un/P6/vuhTMBOEepA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4010DB1FA;
        Thu,  6 May 2021 07:02:51 +0000 (UTC)
Date:   Thu, 6 May 2021 09:02:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, yaoaili126@gmail.com
Subject: Re: [PATCH] Revert "mm/gup: check page posion status for coredump."
Message-ID: <YJOUmh+HcDXBdyuS@dhcp22.suse.cz>
References: <20210505135407.31590-1-mhocko@kernel.org>
 <20210506134750.17d2f6eb@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506134750.17d2f6eb@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-05-21 13:47:50, Aili Yao wrote:
> On Wed, 5 May 2021 15:54:07 +0200
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > While reviewing http://lkml.kernel.org/r/20210429122519.15183-4-david@redhat.com
> > I have crossed d3378e86d182 ("mm/gup: check page posion status for
> > coredump.") and noticed that this patch is broken in two ways. First it
> > doesn't really prevent hwpoison pages from being dumped because hwpoison
> > pages can be marked asynchornously at any time after the check.
> 
> I rethink this:
> There are two cases for this coredump panic issue.
> One is the scenario that the hwpoison flag is set correctly, and the previous patch
> will make it recoverable and avoid panic.
> 
> Another is the hwpoison flag not valid in the check, maybe race condition. I don't think
> this case is worth and reliazable to be covered. As the SRAR can happen freshly in the dump
> process and thus can't be detected.
> 
> And the previous patch doesn't make the Another case worse and unacceptable. just as it can't be
> covered.
> 
> So here is the patch:
> For most case in this topic, the patch will work. For the case hwpoison flag not valid, it will
> fallback to the original process before this patch --- just panic. 

Please propose a new fix which a) doesn't leak a page reference b)
evaluates how realistic is the scenario c) explain why any other gup
user doesn't really need to care - or in other words is the gup layer
really suitable for this issue?
-- 
Michal Hocko
SUSE Labs
