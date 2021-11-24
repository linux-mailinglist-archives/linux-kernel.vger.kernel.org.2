Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6830745B274
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 04:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhKXDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 22:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233290AbhKXDND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:13:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D94A460F45;
        Wed, 24 Nov 2021 03:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637723394;
        bh=hkSDUO3WAr7OKWFEwiKr1RyfM5IEN60Adr3gK8QGdMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1kjk3C6WBzNkNCHflx58dqqjB1Sxoip7z9AmUigHe4E7sN8KA1IbbjjKPU+XBO4xu
         mwOGhO8tpuaxlM0Ccy04vP5paD8Pap9s4jd048paTWKpyWE3f5Z8Ge8XOKTFlgoILT
         ln7HKpAqdwQ9xqSnlqZPEcMlU71J0670IoGLT5/0=
Date:   Tue, 23 Nov 2021 19:09:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
Subject: Re: [PATCH v7 0/5] Free the 2nd vmemmap page associated with each
 HugeTLB page
Message-Id: <20211123190952.7d1e0cac2d72acacd2df016c@linux-foundation.org>
In-Reply-To: <CAMZfGtV0JKcjVL0qGoYCQJ-LsXdng7Z2UjBym5hf_WM0LcYi=Q@mail.gmail.com>
References: <20211101031651.75851-1-songmuchun@bytedance.com>
        <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com>
        <35c5217d-eb8f-6f70-544a-a3e8bd009a46@oracle.com>
        <CAMZfGtW=e___8kpe1B5a1rK+SV63bP_Nwucj89QKaX4ZOMUpaw@mail.gmail.com>
        <CAMZfGtV0JKcjVL0qGoYCQJ-LsXdng7Z2UjBym5hf_WM0LcYi=Q@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 12:21:32 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> On Wed, Nov 10, 2021 at 2:18 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Tue, Nov 9, 2021 at 3:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >
> > > On 11/8/21 12:16 AM, Muchun Song wrote:
> > > > On Mon, Nov 1, 2021 at 11:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >>
> > > >> This series can minimize the overhead of struct page for 2MB HugeTLB pages
> > > >> significantly. It further reduces the overhead of struct page by 12.5% for
> > > >> a 2MB HugeTLB compared to the previous approach, which means 2GB per 1TB
> > > >> HugeTLB. It is a nice gain. Comments and reviews are welcome. Thanks.
> > > >>
> > > >
> > > > Hi,
> > > >
> > > > Ping guys. Does anyone have any comments or suggestions
> > > > on this series?
> > > >
> > > > Thanks.
> > > >
> > >
> > > I did look over the series earlier.  I have no issue with the hugetlb and
> > > vmemmap modifications as they are enhancements to the existing
> > > optimizations.  My primary concern is the (small) increased overhead
> > > for the helpers as outlined in your cover letter.  Since these helpers
> > > are not limited to hugetlb and used throughout the kernel, I would
> > > really like to get comments from others with a better understanding of
> > > the potential impact.
> >
> > Thanks Mike. I'd like to hear others' comments about this as well.
> > From my point of view, maybe the (small) overhead is acceptable
> > since it only affects the head page, however Matthew Wilcox's folio
> > series could reduce this situation as well.

I think Mike was inviting you to run some tests to quantify the
overhead ;)

> Ping guys.
> 
> Hi Andrew,
> 
> Do you have any suggestions on this series to move it on?
> 

I tossed it in there for some testing but yes please, additional
reviewing?
