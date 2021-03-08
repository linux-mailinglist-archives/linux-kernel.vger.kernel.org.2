Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045FC331349
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhCHQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:22:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:36556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhCHQVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:21:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615220508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zmNh9XTFyds75r57idvI9IbPhvrQ/MrJNdhnTPn5J+g=;
        b=l16WpMgy1aCH2nY1Eh/uNbTgDBMvegb8xG2+5G1tx/NkwOX/b1Hiri3vpEFBNjSAx269P2
        Ca62/brNi8VVLouYVPnxyaT4Di+dzVZ6zP7T8e30t97evwV/g+xHfyVAcaoD6ukNh4FIXh
        UTDkL2616zTigPQCi9r4xOyk/LUdz5g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22112ADE3;
        Mon,  8 Mar 2021 16:21:48 +0000 (UTC)
Date:   Mon, 8 Mar 2021 17:21:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEZPG+9ql2j8O9QS@dhcp22.suse.cz>
References: <YEEUq8ZRn4WyYWVx@google.com>
 <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
 <YEEi1+TREGBElE5H@google.com>
 <YEEle5xBAc7FUDNI@google.com>
 <YEYdR8azcawau9Rl@dhcp22.suse.cz>
 <c1461e51-7ad0-7fb5-9dc2-7f7c5cdf128f@redhat.com>
 <YEYwdjvYGiZ4crMt@dhcp22.suse.cz>
 <9f7b4b8a-5317-e382-7f21-01667e017982@redhat.com>
 <YEZF81vXGR8TX8sE@dhcp22.suse.cz>
 <YEZJk8YpUypT7q/j@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEZJk8YpUypT7q/j@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-03-21 07:58:11, Minchan Kim wrote:
[...]
> It's the dynamic debugging facility
> to enable only when admin want to use it. Otherwise, it's nop
> unless is't not enabled. Furthermore, it doesn't need to invent
> custom dump_page implementation(including dump_page_owner) by
> chaning pr_debug.
> Could you clarify your requirement?
> 
> https://lore.kernel.org/linux-mm/YEEUq8ZRn4WyYWVx@google.com/

I am not really sure this is the right way to enable dynamic logging.
Maybe it is. I thought we can go with something as simple as pr_debug.
You are right that we do not have dump_page with the kernel log level.
This is rather annoying but a) do we need a full dump_page functionality
and b) can we make it log level aware with the dynamic debug
infrastructure preserved? If not then then an explicit handling is
probably the only way and this should be reviewed by people who are more
familiar with that framework than me.
-- 
Michal Hocko
SUSE Labs
