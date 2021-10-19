Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B04339AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJSPI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:08:29 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:20316 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJSPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634655975; x=1666191975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YOqugBjrGNKINf9YHs8xoM1f5/rJiPP2cQDPU1Vulu8=;
  b=sBKcqpdy9ArhUhl+k+8PSqEvMXV805VgMTCJeZSC5YFLi1jv3LfhwyiQ
   f/ld5Ra+wA+XIgBCpMOfTXeGJsa6t+IPWOyEA4srCbnavj359lZhECAaG
   9noIKRbIw5TcleBmTBB6GsZRUWzocvIHNDqJRN9DviBGNVOqFLmVmaaDT
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 Oct 2021 08:06:14 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 08:06:14 -0700
Received: from [10.111.162.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 19 Oct 2021
 08:06:12 -0700
Message-ID: <089478ad-3755-b085-d9aa-c68e9792895c@quicinc.com>
Date:   Tue, 19 Oct 2021 11:06:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@kernel.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211013054756.12177-1-rppt@kernel.org>
 <c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com>
 <YW5bjV128Qk1foIv@kernel.org> <YW6t5tBe/IjSYWn3@arm.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
In-Reply-To: <YW6t5tBe/IjSYWn3@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2021 7:37 AM, Catalin Marinas wrote:
>>> I could help to confirm if it hangs right in the early boot somewhere if needed.
>>
>> The kernel config and a log of working kernel would help to start with.

http://lsbug.org/tmp/

> 
> I don't think there's much in the log other than the EFI stub above.
> 
>>> start_kernel()
>>>   setup_arch()
>>>     paging_init()
>>>       map_mem()
>>>         memblock_mark_nomap(
> 
> Is this actual trace? It would be good to know where exactly it got
> stuck.

No, I did not confirm anything yet. There is going to take a while to
figure out the exactly location that hang since even the early console
was not initialized yet. Any suggestion on how to debug in this case?

> 
>> So we have kmemleak_free_part_phys() here.
> 
> I wonder whether the memblock_mark_nomap() here is too early for
> kmemleak. We don't have the linear map created, though it shouldn't be
> an issue as the kernel sections are mapped. Also I think
> delete_object_part() in kmemleak.c would bail out early as there
> shouldn't be any prior memblock_alloc for this range.
> 
