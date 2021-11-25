Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92AF45D29E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352856AbhKYBxD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Nov 2021 20:53:03 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28106 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345693AbhKYBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:51:32 -0500
Received: from dggeml708-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J01172DPDz1DJY9;
        Thu, 25 Nov 2021 09:45:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeml708-chm.china.huawei.com (10.3.17.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 25 Nov 2021 09:48:20 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2308.020;
 Thu, 25 Nov 2021 09:48:20 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>
Subject: Re: [PATCH] trace: Fix a kmemleak noise
Thread-Topic: [PATCH] trace: Fix a kmemleak noise
Thread-Index: AQHX4UY5012gcbVNnkawSmybmmRxiw==
Date:   Thu, 25 Nov 2021 01:48:20 +0000
Message-ID: <c02fa0f22fc94a8d8efb374ceb19e5c2@huawei.com>
References: <20211124140801.87121-1-chenjun102@huawei.com>
 <20211124101616.618ee8f2@gandalf.local.home>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.43]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/11/24 23:16, Steven Rostedt 写道:
Hi

> On Wed, 24 Nov 2021 14:08:01 +0000
> Chen Jun <chenjun102@huawei.com> wrote:
> 
>> The reason is elts->pages[i] is alloced by get_zeroed_page.
>> and kmemleak will not scan the area alloced by get_zeroed_page.
>> The address stored in elts->pages will be regarded as leaked.
> 
> Why doesn't kmemleak scan get_zeroed_page? And if that's the case, how does
> all the other locations in the kernel that call get_zeroed_page handle this?
> I think in most cases, the page do not contain pointers. But I am not 
sure. Maybe we should better ask Catalin.

In block/blk-mq.c
blk_mq_alloc_rqs
.
   page = alloc_pages_node(node,..
.
   p = page_address(page);
   /*$
    * Allow kmemleak to scan these pages as they contain pointers
    * to additional allocations like via ops->init_request().
    */$
   kmemleak_alloc(p, order_to_size(this_order), 1, GFP_NOIO);

In lib/scatterlist.c
static struct scatterlist *sg_kmalloc(unsigned int nents, gfp_t gfp_mask)
{
   if (nents == SG_MAX_SINGLE_ALLOC) {
   /*
    * Kmemleak doesn't track page allocations as they are not
    * commonly used (in a raw form) for kernel data structures.
    * As we chain together a list of pages and then a normal
    * kmalloc (tracked by kmemleak), in order to for that last
    * allocation not to become decoupled (and thus a
    * false-positive) we need to inform kmemleak of all the
    * intermediate allocations.
    */
    void *ptr = (void *) __get_free_page(gfp_mask);
    kmemleak_alloc(ptr, PAGE_SIZE, 1, gfp_mask);
    return ptr;
.

> -- Steve
> 


-- 
Regards
Chen Jun
