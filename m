Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57934055D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhCRMSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:18:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:32916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230513AbhCRMSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:18:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB572AC75;
        Thu, 18 Mar 2021 12:18:14 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] mm/slub: Introduce two counters for partial
 objects
To:     Xunlei Pang <xlpang@linux.alibaba.com>,
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <42b5dba7-f89f-ae43-3b93-f6e4868e1573@suse.cz>
Date:   Thu, 18 Mar 2021 13:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615967692-80524-2-git-send-email-xlpang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 8:54 AM, Xunlei Pang wrote:
> The node list_lock in count_partial() spends long time iterating
> in case of large amount of partial page lists, which can cause
> thunder herd effect to the list_lock contention.
> 
> We have HSF RT(High-speed Service Framework Response-Time) monitors,
> the RT figures fluctuated randomly, then we deployed a tool detecting
> "irq off" and "preempt off" to dump the culprit's calltrace, capturing
> the list_lock cost nearly 100ms with irq off issued by "ss", this also
> caused network timeouts.

I forgot to ask, how does "ss" come into this? It displays network connections
AFAIK. Does it read any SLUB counters or slabinfo?
