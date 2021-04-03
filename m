Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18323531D3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhDCBE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235721AbhDCBE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:04:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C70E16117A;
        Sat,  3 Apr 2021 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617411895;
        bh=9V7YVCG5U6KqDgGSJ8GVsJXXF4lwYY+bPLYhy58H9qY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BmpxYynUul8cO41nW9uTTAZmWIon8i+MoJji+1zno4/f9laEEgkGXcydJUqNaYATo
         tgs1Kb11/OQX48uN0fpfLws44lwcQCECRqGG7kNZE372kpab+7n3X+yycm50ut2VzA
         1eiusBpLTEPoOq6YY49Pvw30UBZPNSlt2SmW0ISM=
Date:   Fri, 2 Apr 2021 18:04:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <duanxiongchun@bytedance.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix forget to obtain the ref to objcg
 in split_page_memcg
Message-Id: <20210402180454.c28395d38396b58659c15fcc@linux-foundation.org>
In-Reply-To: <YGU/ZojpKXXK9AnU@carbon.DHCP.thefacebook.com>
References: <20210401030141.37061-1-songmuchun@bytedance.com>
        <5c183fe6-637f-151c-67f0-fe19a0ce3356@huawei.com>
        <YGU/ZojpKXXK9AnU@carbon.DHCP.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 20:35:02 -0700 Roman Gushchin <guro@fb.com> wrote:

> On Thu, Apr 01, 2021 at 11:31:16AM +0800, Miaohe Lin wrote:
> > On 2021/4/1 11:01, Muchun Song wrote:
> > > Christian Borntraeger reported a warning about "percpu ref
> > > (obj_cgroup_release) <= 0 (-1) after switching to atomic".
> > > Because we forgot to obtain the reference to the objcg and
> > > wrongly obtain the reference of memcg.
> > > 
> > > Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > 
> > Thanks for the patch.
> > Is a Fixes tag needed?
> 
> No, as the original patch hasn't been merged into the Linus's tree yet.
> So the fix can be simply squashed.

Help.  Which is "the original patch"?

> Btw, the fix looks good to me.
> 
> Acked-by: Roman Gushchin <guro@fb.com>

