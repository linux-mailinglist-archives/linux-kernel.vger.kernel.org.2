Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01834E2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhC3H6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbhC3H6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617091124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHycToD1Mf7hFAxeW6WBmmMHgJcTRe0/4cO3FJSif84=;
        b=e/0Rc2mCBZSLyTEK8uOWGpcbl/9fa9vDYJh78Ly4DEu75ET6IM5X96euvGkVqMqx5bQsGG
        6bbBsDG0jgDzFCmjJA36U+Q7phbSoB/DBpkkjYUny8HxdSUnYd8toBvuqd14ajXXlS4BO6
        IIDK7uH8W+KOAFsSD1luPQtdxajPc/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-mJQ-MeRpML6rufcRb-jMoQ-1; Tue, 30 Mar 2021 03:58:41 -0400
X-MC-Unique: mJQ-MeRpML6rufcRb-jMoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDD53801814;
        Tue, 30 Mar 2021 07:58:39 +0000 (UTC)
Received: from [10.36.114.210] (ovpn-114-210.ams2.redhat.com [10.36.114.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3815C239;
        Tue, 30 Mar 2021 07:58:38 +0000 (UTC)
Subject: Re: [PATCH] mm: change size_t to unsigned int for cma_alloc
To:     Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210329182553.3129234-1-minchan@kernel.org>
 <20210329184431.GJ351017@casper.infradead.org> <YGI0sThJjsshpPIR@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6d305211-c956-ad80-5908-703d07fca441@redhat.com>
Date:   Tue, 30 Mar 2021 09:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGI0sThJjsshpPIR@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.21 22:12, Minchan Kim wrote:
> On Mon, Mar 29, 2021 at 07:44:31PM +0100, Matthew Wilcox wrote:
>> On Mon, Mar 29, 2021 at 11:25:53AM -0700, Minchan Kim wrote:
>>> size_t in cma_alloc is confusing since it makes people think
>>> it's byte count, not pages. Fix it.
>>
>> i think it has to be unsigned long.
>>
>> 67a2e213e7e937c41c52ab5bc46bf3f4de469f6e

Right.

Fortunately, we don't have such large allocations yet via 
CMA/alloc_contig_range

> 
> Thanks for the pinter. I wanted to have the smallest change.
> The commit leads me to change cma_release, trace_cma_alloc,
> cma_clear_bitmap and front_contig_range as well.(Not sure
> we have more. Will check).
> 
> Ccing david@redhat.com for upcoming changing free_contig_range.

While at it, we might want to convert free_contig_range() to eat
"unsigned long start, unsigned long end" like alloc_contig_range(), 
instead of "unsigned long pfn, unsigned int nr_pages" like 
alloc_contig_pages() ...

-- 
Thanks,

David / dhildenb

