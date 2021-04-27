Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08AD36C79F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhD0OSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:18:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhD0OSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:18:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619533060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPnBVd7Xw8yqyfq/ePcZua6Sq04c0XSFOx7Aw4QUk+A=;
        b=RFrBUn2qDwg7NGZHQeD0zUMFTeNwsyqboz9VhGTQjBlC8pRpDAhcxtAclArMasQjDUm+dJ
        jKgJ80gR6aJer81ujhwyEpfaHxMy2HjfyzYA2O1x4i6G8K2DOcz+4aMNWUEs2M+2f/i5kZ
        k1wjtkL1QgsHW9cumO2cNHqHcQFIREE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1909CB1B0;
        Tue, 27 Apr 2021 14:17:40 +0000 (UTC)
Date:   Tue, 27 Apr 2021 16:17:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Sosna <alexander@sosna.de>
Cc:     Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM casualties by enforcing memcg limits
Message-ID: <YIgc1G496grYBbSH@dhcp22.suse.cz>
References: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
 <YIdWMC/iAdanDjLh@chrisdown.name>
 <410a58ba-d746-4ed6-a660-98b5f99258c3@sosna.de>
 <YIfGbd4wupW4mdHy@dhcp22.suse.cz>
 <c7e0a2f9-0b83-2d9b-8ec1-8141d5dca554@sosna.de>
 <YIf/bOhWIKPuwIzg@dhcp22.suse.cz>
 <93fcbc37-8c8c-a752-a191-ff8e3dc02eb1@sosna.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93fcbc37-8c8c-a752-a191-ff8e3dc02eb1@sosna.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-04-21 15:43:25, Alexander Sosna wrote:
> 
> On 27.04.21 14:11, Michal Hocko wrote:
[...]
> > Well, I am afraid that a reliable and easy solutions would be extremely
> > hard to find. A memcg aware overcommit policy is certainly possible but
> > as I've said it would require an additional accounting, it would be
> > quite unreliable - especially with small limits where the mapped (and
> > accounted) address space is not predominant. A lack of background
> > reclaim (kswapd in the global case) would result in ENOMEM reported even
> > though there is reclaimable memory to satisfy the reserved address space
> > etc.
> 
> Thank you very much for this information.  Would you share the opinion
> that it would be too hacky to define an arbitrary memory threshold here?
>  One could say that below a used memory of X the memory cgroup limit is
> not enforced by denying a malloc().  So that the status quo behavior is
> only altered when the memory usage is above X.  This would mitigate the
> problem with small limits and does not introduce new risks or surprises,
> because in this edge case it will behaves identical to the current kernel.

It will not. Please read again about the memory reclaim concern. There
is no background reclaim so (and I believe Chris has mentioned that in
other email) the only way to balance memory consumption (e.g. caches)
would be memory allocations which are excluded from the virtual memory
accounting. That can lead to a hard to predict behavior.

> >> Could
> >> you elaborate on where you see "a lot of fallouts"?  overcommit_memory 2
> >> is only set when needed for the desired workload.
> > 
> > My above comment was more general to the approach Linux is embracing
> > overcommit and relies on oom killer to handle fallouts. This to change
> > would lead to lot of fallouts. E.g. many syscalls returning unexpected
> > and unhandled ENOMEM etc.
> 
> We are talking about a special use case here.  Do you see a problem in
> the domain where and how overcommit_memory=2 is used today?

yes I do. I believe I have already provided some real challenges. All
that being said, a virtual memory overcommit control could be
implemented but I am not sure this is worth the additional complexity
and overhead introduced by the additional accounting.
-- 
Michal Hocko
SUSE Labs
