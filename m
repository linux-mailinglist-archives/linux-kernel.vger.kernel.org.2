Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1199B32F704
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhCEX7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:59:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhCEX6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:58:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF3DE601FE;
        Fri,  5 Mar 2021 23:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614988721;
        bh=HbZT0bF1MsVnxN6BmosWjrgrZCSm028Kpqvom+zo5rA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kP9fQL0oxzF4MeLAIlf9r2mjWb0IXmPVbfnY/LAipr6zyaplBjZKHIYvNDiD/vksT
         MxPzAQpWPcorsIEn0ivLCcIPgk2TU4tCLSY39d/t9fwKXPcwKtiMabmvhE/xlPzKwD
         Xlb3wWSDeMKoqkni3RpbOJg3TVMfltCCYWcH8+AU=
Date:   Fri, 5 Mar 2021 15:58:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-Id: <20210305155840.4bb6dea4fb473d9ffbe49c99@linux-foundation.org>
In-Reply-To: <YEIblNv0BMITFzYO@dhcp22.suse.cz>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
        <20210304074053.65527-3-zhouguanghui1@huawei.com>
        <YEIblNv0BMITFzYO@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 12:52:52 +0100 Michal Hocko <mhocko@suse.com> wrote:

> On Thu 04-03-21 07:40:53, Zhou Guanghui wrote:
> > As described in the split_page function comment, for the non-compound
> > high order page, the sub-pages must be freed individually. If the
> > memcg of the fisrt page is valid, the tail pages cannot be uncharged
> > when be freed.
> > 
> > For example, when alloc_pages_exact is used to allocate 1MB continuous
> > physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> > set). When make_alloc_exact free the unused 1MB and free_pages_exact
> > free the applied 1MB, actually, only 4KB(one page) is uncharged.
> > 
> > Therefore, the memcg of the tail page needs to be set when split page.
> > 
> 
> As already mentioned there are at least two explicit users of
> __GFP_ACCOUNT with alloc_exact_pages added recently. It would be good to
> mention that explicitly and maybe even mention 7efe8ef274024 resp.
> c419621873713 so that it is clear this is not just a theoretical issue.

I added

: Michel:
: 
: There are at least two explicit users of __GFP_ACCOUNT with
: alloc_exact_pages added recently.  See 7efe8ef274024 ("KVM: arm64:
: Allocate stage-2 pgd pages with GFP_KERNEL_ACCOUNT") and c419621873713
: ("KVM: s390: Add memcg accounting to KVM allocations"), so this is not
: just a theoretical issue.

And should we cc:stable on this one?
