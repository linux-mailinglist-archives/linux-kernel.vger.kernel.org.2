Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3C6340631
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhCRM4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:56:49 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:40094 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231269AbhCRM4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:56:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0USS3ezc_1616072180;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0USS3ezc_1616072180)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Mar 2021 20:56:21 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH v4 1/3] mm/slub: Introduce two counters for partial
 objects
To:     Vlastimil Babka <vbabka@suse.cz>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Christoph Lameter <cl@linux.com>,
        Christoph Lameter <cl@gentwo.de>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>
References: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
 <1615967692-80524-2-git-send-email-xlpang@linux.alibaba.com>
 <42b5dba7-f89f-ae43-3b93-f6e4868e1573@suse.cz>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <34a07677-3afe-465c-933e-dc9503e9634d@linux.alibaba.com>
Date:   Thu, 18 Mar 2021 20:56:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <42b5dba7-f89f-ae43-3b93-f6e4868e1573@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/21 8:18 PM, Vlastimil Babka wrote:
> On 3/17/21 8:54 AM, Xunlei Pang wrote:
>> The node list_lock in count_partial() spends long time iterating
>> in case of large amount of partial page lists, which can cause
>> thunder herd effect to the list_lock contention.
>>
>> We have HSF RT(High-speed Service Framework Response-Time) monitors,
>> the RT figures fluctuated randomly, then we deployed a tool detecting
>> "irq off" and "preempt off" to dump the culprit's calltrace, capturing
>> the list_lock cost nearly 100ms with irq off issued by "ss", this also
>> caused network timeouts.
> 
> I forgot to ask, how does "ss" come into this? It displays network connections
> AFAIK. Does it read any SLUB counters or slabinfo?
> 

ss may access /proc/slabinfo to acquire network related slab statistics.
