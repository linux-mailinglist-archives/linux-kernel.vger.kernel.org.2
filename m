Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36AD3E3803
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 04:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhHHC4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 22:56:18 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38633 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhHHC4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 22:56:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UiGbLY0_1628391358;
Received: from 30.39.238.167(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UiGbLY0_1628391358)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Aug 2021 10:55:58 +0800
Subject: Re: [PATCH 5/5] mm: migrate: Remove redundant goto labels
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <d359dcf73a7a868f1b126cb73368fea64aec1f25.1628174413.git.baolin.wang@linux.alibaba.com>
 <CAHbLzkrqwOp0a_6Vzn29h9qwCiwVSLL6QzsMLfOYTWj7mtkNZg@mail.gmail.com>
 <98937827-89ec-2a3b-b389-da28f8493cb1@linux.alibaba.com>
 <CAHbLzko_spW=SPnP3jgQWCNzY=7xn7JDCFfFtY5_9yRfCApLTA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <95b8958c-3887-1267-9cca-d8e12549113b@linux.alibaba.com>
Date:   Sun, 8 Aug 2021 10:56:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzko_spW=SPnP3jgQWCNzY=7xn7JDCFfFtY5_9yRfCApLTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Aug 5, 2021 at 8:19 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Hi Yang,
>>
>>> On Thu, Aug 5, 2021 at 8:06 AM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>> Remove redundant goto labels to simplify the code.
>>>
>>> TBH I don't see too much benefit. The "goto" makes the functions have
>>> a single exit point.
>>
>> Yes, I agree that the 'goto' statement can make things easier when a
>> function exits from multiple locations and some common work such as
>> cleanup has to be done, as well as introducing complexity to reading the
>> code. So per the coding style documentation, "If there is no cleanup
>> needed then just return directly", which can make code more readable I
>> think :)
>>
>> But I have no strong opinion on this, I can drop this patch if you still
>> think this is unnecessary. Thanks for your review and comments.
> 
> Thanks, IMHO I'd like to drop it for now.

OK, will do. Thanks.
