Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE68310360
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBEDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:13:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12464 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhBEDM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:12:59 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DX0mf3pmMzjK9y;
        Fri,  5 Feb 2021 11:10:58 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 11:12:13 +0800
Subject: Re: [PATCH] mm/rmap: Correct obsolete comment of page_get_anon_vma()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210203093215.31990-1-linmiaohe@huawei.com>
 <20210204123807.GE308988@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <27b33f18-7c5e-8b0a-abea-f4eef01e6285@huawei.com>
Date:   Fri, 5 Feb 2021 11:11:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204123807.GE308988@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/4 20:38, Matthew Wilcox wrote:
> On Wed, Feb 03, 2021 at 04:32:15AM -0500, Miaohe Lin wrote:
>>   * Since there is no serialization what so ever against page_remove_rmap()
>> - * the best this function can do is return a locked anon_vma that might
>> - * have been relevant to this page.
>> + * the best this function can do is return a refcount increased anon_vma
>> + * that might have been relevant to this page.
> 
> Just s/a locked/an/

Many thanks for your review and reply.

> there's no need to mention again that the refcount> is increased.

I think it's ok to mention again that the refcount is increased although I didn't find
out where this is first mentioned.
Thanks again.

> .
> 
