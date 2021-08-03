Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8103DF1AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhHCPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:40:43 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49700 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236937AbhHCPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:40:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UhtdjCl_1628005228;
Received: from 30.39.225.192(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UhtdjCl_1628005228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Aug 2021 23:40:29 +0800
Subject: Re: [PATCH] mm/swap: Remove the unused get_kernel_page()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <a6137b871658cdbd0cde9fbeecf2168bc8ec87e9.1628002955.git.baolin.wang@linux.alibaba.com>
 <YQlhBRi7dWSwpcFs@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <23d3d3a5-5938-b2a0-716e-0413217362b4@linux.alibaba.com>
Date:   Tue, 3 Aug 2021 23:40:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQlhBRi7dWSwpcFs@casper.infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Tue, Aug 03, 2021 at 11:07:04PM +0800, Baolin Wang wrote:
>> Now there are no users of the get_kernel_page() function,
>> thus remove it.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Perhaps you should just send a Reviewed-by: for John Hubbard's patch
> on July 29th instead?

Ah, I missed that patch before. Please ignore this patch, sorry for noise.
