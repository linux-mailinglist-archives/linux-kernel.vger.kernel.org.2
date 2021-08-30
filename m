Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4A3FB71B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhH3NmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 09:42:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45344 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhH3NmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 09:42:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F39DB200AB;
        Mon, 30 Aug 2021 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630330880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=109F1UpxBnRDw6BB5dtv3umGWR8nbJ7IetSDHkmh+sY=;
        b=c1374K6ZFzZAeuxLeaVJI0XeyCa9vtN8JjP9Bh1wuCxnEiPRHlJiFmwXLMXl9A5tg6dYR7
        VW7Awb5Q4nXcqZe4GcBbH1IvKe6o/Mq5Oi0ecs8FuiU8fPrQiChf8+A1N28XrcbwO1oLCg
        fYMfdDxyCG1CqxrXU7wu+49dFMajrPQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C3002A3BA1;
        Mon, 30 Aug 2021 13:41:19 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:41:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@kernel.org, Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
Message-ID: <YSzf/3A6b0R3kR5v@dhcp22.suse.cz>
References: <20210826220149.058089c6@imladris.surriel.com>
 <YSzB9q1kVjKce7ly@dhcp22.suse.cz>
 <d77b816458f9df3839345f0ee0144b797ec176be.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77b816458f9df3839345f0ee0144b797ec176be.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-08-21 09:24:22, Rik van Riel wrote:
> On Mon, 2021-08-30 at 13:33 +0200, Michal Hocko wrote:
[...]
> > I must be missing something but how can cgroup_size be ever 0 when it
> > is
> > max(cgroup_size, protection) and protection != 0?
> 
> Going into the condition we use if (low || min), where
> it is possible for low > 0 && min == 0.
> 
> Inside the conditional, we can end up testing against
> min.

Dang, I was looking at the tree without f56ce412a59d7 applied. My bad!
Personally I would consider the following slightly easier to follow
			scan = lruvec_size - lruvec_size * protection /
				max(cgroup_size, 1);

The code is quite tricky already and if you asked me what kind of effect
cgroup_size + 1 have there I would just shrug shoulders...

Anyway your fix will prevent the reported problem and I cannot see any
obvious problem with it either so
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
