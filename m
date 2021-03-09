Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6CF33208B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhCII24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:28:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:52840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhCII21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:28:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615278506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3x2XIxgfjhorUHBLN/3kYdSw0pyeuC2U9t99e69VR1w=;
        b=jmaB5EvS92fVBGydJx9tEuTD4FFNFj7e1/KPP/oloRMuYh2bIpLMnh9RfULVCVLroGmG3Z
        SEZDDURwZkUKThd6R7QG8bnL1U309iJtXXI2GUdJWlN+/eisoY2CmIN6/Lxt5/UrITScle
        ux1yizLdAs64IycXDmP2S61KfU+JyxI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 617CEAC24;
        Tue,  9 Mar 2021 08:28:26 +0000 (UTC)
Date:   Tue, 9 Mar 2021 09:28:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Singh, Balbir" <bsingharora@gmail.com>
Cc:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to
 split_page_memcg
Message-ID: <YEcxqTUp88sl/cq3@dhcp22.suse.cz>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-2-zhouguanghui1@huawei.com>
 <3ad50842-881f-eb88-a14d-0b6c70ce33d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad50842-881f-eb88-a14d-0b6c70ce33d2@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-03-21 09:37:29, Balbir Singh wrote:
> On 4/3/21 6:40 pm, Zhou Guanghui wrote:
[...]
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  /*
> > - * Because page_memcg(head) is not set on compound tails, set it now.
> > + * Because page_memcg(head) is not set on tails, set it now.
> >   */
> > -void mem_cgroup_split_huge_fixup(struct page *head)
> > +void split_page_memcg(struct page *head, unsigned int nr)
> >  {
> 
> Do we need input validation on nr? Can nr be aribtrary or can we enforce
> 
> VM_BUG_ON(!is_power_of_2(nr));

In practice this will be power of 2 but why should we bother to sanitze
that? 

-- 
Michal Hocko
SUSE Labs
