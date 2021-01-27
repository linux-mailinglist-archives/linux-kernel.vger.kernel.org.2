Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8405A305869
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhA0K3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:29:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:55922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235924AbhA0K1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:27:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611743208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLSVLQTCpNGXqXoFFf6frdMUy9qm2Kd8XxVyNeqLu+A=;
        b=eCqyU2iwnHa6+g0doP0r7l8In/7+le+zZjIcyMNHJtQLNTmB7wcuvpLwmGhnlJh0V4xfkd
        Bhu6tYTua4BHlrv6I2kmMw4a09mIb5Vya91BsaEJq6ImuwHReWBtIbbORA8QlsnJ2nlttt
        EAtx8mb9Gh3IzsNzfQj9daa7j2+k/xY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EAE72AD57;
        Wed, 27 Jan 2021 10:26:47 +0000 (UTC)
Date:   Wed, 27 Jan 2021 11:26:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/5] hugetlb: use page.private for hugetlb specific
 page flags
Message-ID: <20210127102645.GH827@dhcp22.suse.cz>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122195231.324857-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry forgot one thing.

On Fri 22-01-21 11:52:27, Mike Kravetz wrote:
> + * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
> + *	allocation time.  Cleared when page is fully instantiated.  Free
> + *	routine checks flag to restore a reservation on error paths.

Can we document that the pool is stored in head+1->private here please?

> + */
> +enum hugetlb_page_flags {
> +	HPG_restore_reserve = 0,
> +	__NR_HPAGEFLAGS,
> +};

-- 
Michal Hocko
SUSE Labs
