Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6504034A31D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCZISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:18:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15317 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCZISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:18:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6FDq6hbkz9tm1;
        Fri, 26 Mar 2021 16:16:43 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 16:18:38 +0800
Subject: Re: [PATCH -next] mm/page_alloc: remove duplicated include from
 page_alloc.c
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20210326025542.3565329-1-miaoqinglang@huawei.com>
 <20210326034208.GC1719932@casper.infradead.org>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <d3a42312-397d-e7e7-0aa8-819a7b3731db@huawei.com>
Date:   Fri, 26 Mar 2021 16:18:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210326034208.GC1719932@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Matthew

Thanks for your advice towards hulk robot. We'd like to improve the 
capbility of hulk robot whole the time.

This patch is just a small cleanup reported by hulk robot, But the robot 
can do more than this. For example, it finds crucial and useful bugs as 
well.

As for 'Untangle the mass of header includes' you mentioned, could you 
please offer more details? Because I didn't find pagemap.h in 
net/ipv4/tcp.c in -next like what you said.


ÔÚ 2021/3/26 11:42, Matthew Wilcox Ð´µÀ:
> On Fri, Mar 26, 2021 at 10:55:42AM +0800, Qinglang Miao wrote:
>> Remove duplicated include.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> 
> can't you make hulk robot do something useful, like untangle the
> mass of header includes?  For example, in -next, net/ipv4/tcp.c
> has a dependency on pagemap.h.  Why?
> .
> 
