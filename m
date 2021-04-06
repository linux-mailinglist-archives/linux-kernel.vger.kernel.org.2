Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6173355A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244833AbhDFRiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:38:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:35990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235017AbhDFRiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:38:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617730686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hy/Puw7wiOKdv1e6aYeo233WDpteGQ9X9GmvSUq6v3w=;
        b=TUncJgY8eCNs4Qon31BmnDC2PCjF7DFjDHQVavlTA2Ni989pUXMc4JCW0AphcSi37Y/V4E
        qSlwsTZAiCf7LpFYU5Mt9t7i75aYnEvQhaj57/jj5fSvL0FkJXlYe6HVTyIVDNoOls+GWQ
        kwWaiRHiY2wXu2JdVwmfhH7L/X0eL1s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED03DB262;
        Tue,  6 Apr 2021 17:38:05 +0000 (UTC)
Date:   Tue, 6 Apr 2021 19:38:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Neil Sun <neilsun@yunify.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: drop_slab_node with task's memcg
Message-ID: <YGycedyGoUTcvX09@dhcp22.suse.cz>
References: <1617359934-7812-1-git-send-email-neilsun@yunify.com>
 <YGwMD3DOymOFJ7O5@dhcp22.suse.cz>
 <4dba277d-e497-5c34-0e68-fd2283585de2@yunify.com>
 <YGxIVDXw7wtBytIg@dhcp22.suse.cz>
 <d21f3b10-0c39-211f-dc45-e81c8da5dd9d@yunify.com>
 <YGxyojApNhi5DjFc@dhcp22.suse.cz>
 <cc6bdbbd-bf9d-fa1b-ef53-933e877cf189@yunify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc6bdbbd-bf9d-fa1b-ef53-933e877cf189@yunify.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-04-21 23:12:34, Neil Sun wrote:
> 
> 
> On 2021/4/6 22:39, Michal Hocko wrote:
> > 
> > Have you considered using high limit for the pro-active memory reclaim?
> 
> Thanks, Michal, do you mean the procfs interfaces?
> We have set vm.vfs_cache_pressure=1000 and so on.
> would you please take an example?

No, I've meant high memory limit available in the memcg v2 interface:
Documentation/admin-guide/cgroup-v2.rst.
-- 
Michal Hocko
SUSE Labs
