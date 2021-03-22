Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D491343DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCVKW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:22:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:47364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCVKWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:22:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B37DAD71;
        Mon, 22 Mar 2021 10:22:44 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] mm/slub: Introduce two counters for partial
 objects
To:     Shu Ming <sming56@gmail.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Christoph Lameter <cl@linux.com>, Christoph Lameter <cl@gentwo.de>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>
References: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
 <1615967692-80524-2-git-send-email-xlpang@linux.alibaba.com>
 <42b5dba7-f89f-ae43-3b93-f6e4868e1573@suse.cz>
 <34a07677-3afe-465c-933e-dc9503e9634d@linux.alibaba.com>
 <CANt8P=vwbshvNntPLAkEQFrRfeSHfd1bkxLUhmRXNS2CD_mO_w@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2ad0539f-2c38-714e-330e-7709bb07ebac@suse.cz>
Date:   Mon, 22 Mar 2021 11:22:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANt8P=vwbshvNntPLAkEQFrRfeSHfd1bkxLUhmRXNS2CD_mO_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 2:46 AM, Shu Ming wrote:
> More precisely, ss will count partial objects like denty objects with
> "/sys/kernel/slab/dentry/partial"   whose number can become huge.

Uh, that's interesting. Would you know what exactly it uses the value for? I can
think of several reasons why it might be misleading.

> On Thu, Mar 18, 2021 at 8:56 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 3/18/21 8:18 PM, Vlastimil Babka wrote:
>> > On 3/17/21 8:54 AM, Xunlei Pang wrote:
>> >> The node list_lock in count_partial() spends long time iterating
>> >> in case of large amount of partial page lists, which can cause
>> >> thunder herd effect to the list_lock contention.
>> >>
>> >> We have HSF RT(High-speed Service Framework Response-Time) monitors,
>> >> the RT figures fluctuated randomly, then we deployed a tool detecting
>> >> "irq off" and "preempt off" to dump the culprit's calltrace, capturing
>> >> the list_lock cost nearly 100ms with irq off issued by "ss", this also
>> >> caused network timeouts.
>> >
>> > I forgot to ask, how does "ss" come into this? It displays network connections
>> > AFAIK. Does it read any SLUB counters or slabinfo?
>> >
>>
>> ss may access /proc/slabinfo to acquire network related slab statistics.
> 

