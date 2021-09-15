Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51E440C2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhIOJgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:36:50 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51620 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhIOJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:36:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UoTTP2m_1631698528;
Received: from ashimida.local(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0UoTTP2m_1631698528)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 17:35:30 +0800
Subject: Re: [PATCH] [RFC]arm64:Mark __stack_chk_guard as __ro_after_init
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laura Abbott <labbott@kernel.org>
References: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
 <20210914101709.GA29127@C02TD0UTHF1T.local>
 <f02816a4-5b8e-d1c6-88a2-1db282a7479e@linux.alibaba.com>
 <20210915091943.GA47689@C02TD0UTHF1T.local>
From:   Dan Li <ashimida@linux.alibaba.com>
Message-ID: <39a5c050-986a-62a6-5279-29081882a6f2@linux.alibaba.com>
Date:   Wed, 15 Sep 2021 17:35:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210915091943.GA47689@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fine, I got it, thanks for reply.

On 9/15/21 5:19 PM, Mark Rutland wrote:
> On Wed, Sep 15, 2021 at 09:57:14AM +0800, ashimida wrote:
>> Hi King, Rutland:
>>
>> Thanks for the reply and let me understand the reason here.
>>
>> Then may I first submit a patch to modify the attributes of
>> __stack_chk_guard of the arm/aarch64 platform?
> 
> This patch looks fine as-is (hence the Acked-by). Doing the same for
> arch/arm makes sense, but that should be a separate patch.
> 
> I was suggesting that in future we should probably do the same in more
> places, not that you need to do so now.
> 
> Thanks,
> Mark.
> 
