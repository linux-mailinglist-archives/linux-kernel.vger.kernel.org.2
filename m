Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D985A3C6D87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhGMJfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:35:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45396 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbhGMJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:35:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA65722119;
        Tue, 13 Jul 2021 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626168749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w3Sj149XMB0QShxaoOCWjevBXrahbi07+L3gB+CfwcY=;
        b=ot/bciPDVvOfiixjXDQj8Exwa60bHVBMfYFRPkmjCAiEVydB3+a/oY7lMDr50NPShpqoaD
        5AjG672jzBPfbZWlzKmIsN35BbuWbMUZ9OCy7IcmuYM49Hb9/ejf+jjq7HYlc1WIdgoWzs
        9lHYaH0S1NVQF0ZFYxbk6AsTLMXUDsY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BB9CAA3B9A;
        Tue, 13 Jul 2021 09:32:29 +0000 (UTC)
Date:   Tue, 13 Jul 2021 11:32:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, vbabka@suse.cz,
        axboe@kernel.dk, iamjoonsoo.kim@lge.com, alexs@kernel.org,
        apopple@nvidia.com, willy@infradead.org, minchan@kernel.org,
        david@redhat.com, shli@fb.com, hillf.zj@alibaba-inc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm/vmscan: fix misleading comment in
 isolate_lru_pages()
Message-ID: <YO1drWweAjSz8Oa+@dhcp22.suse.cz>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-6-linmiaohe@huawei.com>
 <YOvvFaYMBhISeGEI@dhcp22.suse.cz>
 <ed30bbc5-8438-d399-a9ef-462eda1b6d4e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed30bbc5-8438-d399-a9ef-462eda1b6d4e@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-07-21 19:16:47, Miaohe Lin wrote:
> On 2021/7/12 15:28, Michal Hocko wrote:
> > On Sat 10-07-21 18:03:29, Miaohe Lin wrote:
> >> We couldn't know whether the page is being freed elsewhere until we failed
> >> to increase the page count.
> > 
> > This is moving a hard to understand comment from one place to another.
> 
> If get_page_unless_zero failed, the page could have been freed elsewhere. I think
> this looks straightforward but doesn't help a lot. Are you preferring to just
> remove this comment ?

Yes the comment in its current form is not really helpful much. Does it
deserve a single liner to drop it? Likely not on its own without more
changes in that area.
-- 
Michal Hocko
SUSE Labs
