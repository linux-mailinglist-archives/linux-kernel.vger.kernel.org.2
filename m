Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FBF43C397
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhJ0HOt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Oct 2021 03:14:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13980 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhJ0HOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:14:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HfKb01nR2zZcLl;
        Wed, 27 Oct 2021 15:10:20 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 15:12:08 +0800
Received: from dggpeml500026.china.huawei.com (7.185.36.106) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 15:12:06 +0800
Received: from dggpeml500026.china.huawei.com ([7.185.36.106]) by
 dggpeml500026.china.huawei.com ([7.185.36.106]) with mapi id 15.01.2308.015;
 Wed, 27 Oct 2021 15:12:06 +0800
From:   songyuanzheng <songyuanzheng@huawei.com>
To:     Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@gentwo.de>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] mm/percpu: fix data-race with
 pcpu_nr_empty_pop_pages
Thread-Topic: [PATCH -next] mm/percpu: fix data-race with
 pcpu_nr_empty_pop_pages
Thread-Index: AQHXyXUG8JGkGq6nOUaljbOjl/I/yqvkDQiAgAJjj4A=
Date:   Wed, 27 Oct 2021 07:12:06 +0000
Message-ID: <4be3bce19c1d44c4a04bb411dfa26182@huawei.com>
References: <20211025070015.553813-1-songyuanzheng@huawei.com>
 <alpine.DEB.2.22.394.2110250943310.2528@gentwo.de> <YXdq7+PJqGLCu4nH@fedora>
In-Reply-To: <YXdq7+PJqGLCu4nH@fedora>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.110]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the advice, Dennis Zhou and Christoph Lameter. 
I really appreciate it.
I edited this patch by changing the pcpu_nr_empty_pop_pages to atomic_t variable.

Here is the v2 patch: https://patchwork.kernel.org/project/linux-mm/patch/20211026084312.2138852-1-songyuanzheng@huawei.com/.
Would you mind reviewing it again?

Thanks,
Yuanzheng Song

-----Original Message-----
From: Dennis Zhou [mailto:dennis@kernel.org] 
Sent: Tuesday, October 26, 2021 10:42 AM
To: Christoph Lameter <cl@gentwo.de>
Cc: songyuanzheng <songyuanzheng@huawei.com>; dennis@kernel.org; tj@kernel.org; akpm@linux-foundation.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/percpu: fix data-race with pcpu_nr_empty_pop_pages

Hello,

On Mon, Oct 25, 2021 at 09:50:48AM +0200, Christoph Lameter wrote:
> On Mon, 25 Oct 2021, Yuanzheng Song wrote:
> 
> > When reading the pcpu_nr_empty_pop_pages in pcpu_alloc() and writing 
> > the pcpu_nr_empty_pop_pages in
> > pcpu_update_empty_pages() at the same time, the data-race occurs.
> 
> Looks like a use case for the atomic RMV instructions.
> 

Yeah. I see 2 options. Switch the variable over to an atomic or we can move the read behind pcpu_lock. All the writes are already behind it othewise that would actually be problematic. In this particular case, reading a wrong # of empty pages isn't a big deal as eventually the background work will get scheduled.

Thanks,
Dennis

> > To fix this issue, use READ_ONCE() and WRITE_ONCE() to read and 
> > write the pcpu_nr_empty_pop_pages.
> 
> Never thought that READ_ONCE and WRITE_ONCE can fix races like this. 
> Really?
> 
> > diff --git a/mm/percpu.c b/mm/percpu.c index 
> > 293009cc03ef..e8ef92e698ab 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -574,7 +574,9 @@ static void pcpu_isolate_chunk(struct pcpu_chunk 
> > *chunk)
> >
> >  	if (!chunk->isolated) {
> >  		chunk->isolated = true;
> > -		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
> > +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> > +			   READ_ONCE(pcpu_nr_empty_pop_pages) -
> > +			   chunk->nr_empty_pop_pages);
> 
> atomic_sub()?
> 
> >  	}
> >  	list_move(&chunk->list, 
> > &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
> >  }
> > @@ -585,7 +587,9 @@ static void pcpu_reintegrate_chunk(struct 
> > pcpu_chunk *chunk)
> >
> >  	if (chunk->isolated) {
> >  		chunk->isolated = false;
> > -		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
> > +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> > +			   READ_ONCE(pcpu_nr_empty_pop_pages) +
> > +			   chunk->nr_empty_pop_pages);
> 
> atomic_add()?
> 
