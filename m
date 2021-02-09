Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A38314612
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBICKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:10:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12601 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBICKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:10:51 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZRBv6Xltz165bN;
        Tue,  9 Feb 2021 10:08:39 +0800 (CST)
Received: from [10.174.179.149] (10.174.179.149) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 10:10:00 +0800
Subject: Re: [PATCH] mm/hugetlb: Remove redundant VM_BUG_ON_PAGE on
 putback_active_hugepage()
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210208083739.33178-1-linmiaohe@huawei.com>
 <7e1cdef7-e3cd-79c1-c30c-5f5e9e9f85ac@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a5a09912-72ab-f494-0f29-5e3b7fb7c5a4@huawei.com>
Date:   Tue, 9 Feb 2021 10:10:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7e1cdef7-e3cd-79c1-c30c-5f5e9e9f85ac@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/9 9:26, Mike Kravetz wrote:
> On 2/8/21 12:37 AM, Miaohe Lin wrote:
>> PageHead(page) is implicitly checked in set_page_huge_active() via the
>> PageHeadHuge(page) check. So remove this explicit one.
> 
> I do not disagree with the code change.  However, this commit message
> is not accurate.  set_page_huge_active() no longer exists in the tree
> you are changing.  It was replaced with SetHPageMigratable.  Also, the
> VM_BUG_ON_PAGE(!PageHeadHuge(page), page) was removed in the process.
> So, there is no redundant check.
> 
> However, a quick audit of calling code reveals that all callers know they
> are operating on a hugetlb head page.
> 

So I should change the commit log like:

	All callers know they are operating on a hugetlb head page. So this VM_BUG_ON_PAGE
	can't catch anything useful.

and send a v2. Right?
