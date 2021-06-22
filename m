Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7503AF9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 02:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFVADD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 20:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhFVADB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 20:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624320046;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+Eaq1+5rsLNiK5tsAB1Wl7ySzk9v73rKnCIUBnt7h8=;
        b=CTsPoOEKHs9/0QqeDBuAujs6rJzPoHmybVeKJ/oNMC5hJZOYtrHoRnD+7/3OS5V0VLShXx
        NITXA3d8UgwxyemGR2RIMxFBlG/6g9cbsSlX7fQSpfJ1CB7mCV8yM4FpY5ulKTH7lpL5qA
        wS9adcbznOo3WE+kVxjDYdtGMX1fTQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-eO2x0zK1PoOpbNP_hnsmyw-1; Mon, 21 Jun 2021 20:00:45 -0400
X-MC-Unique: eO2x0zK1PoOpbNP_hnsmyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC617362F9;
        Tue, 22 Jun 2021 00:00:43 +0000 (UTC)
Received: from [10.64.54.84] (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14B1A179B3;
        Tue, 22 Jun 2021 00:00:36 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 0/3] mm/page_reporting: Make page reporting work on arm64
 with 64KB page size
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
References: <20210621051152.305224-1-gshan@redhat.com>
 <CAKgT0Uf3UwhdFX93YrkiB8yk6v3syqUrdbu720ECqv1ak_H_FA@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <80423104-23ca-17dc-9449-ec5e168e4088@redhat.com>
Date:   Tue, 22 Jun 2021 12:01:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf3UwhdFX93YrkiB8yk6v3syqUrdbu720ECqv1ak_H_FA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/21 12:02 AM, Alexander Duyck wrote:
> So the question I would have is what is the use case for this? It
> seems like you don't have to deal with the guest native page size
> issues since you are willing to break up what would otherwise be THP
> pages on the guest, and the fact that you are willing to go down to
> 2MB pages which happens to align with the host THP page size for x86
> makes me wonder if that is actually the environment you are running
> in.
> 
> Rather than having the guest control this it might make sense to look
> at adding an interface so that the page_reporting_register function
> and the page_reporting_dev_info struct could be used to report and
> configure the minimum page size that the host can support for the page
> reporting. With that the host could then guarantee that it isn't going
> to hurt performance by splitting pages on the host and risk hurting
> the virtualization performance.
> 
> Also you would benefit by looking into the callers of
> page_reporting_register as there are more than just the virtio balloon
> that are consuming it. Odds are HyperV won't care about an ARM64
> architecture, but your change would essentially disable it outright
> which is why I think this might be better to address via the consumers
> of page reporting rather than trying to address it in page reporting
> itself.
> 

Alex, the issue was initially found on guest with 64KB base page size
when memory balloon is used. The same issue isn't found on guest with
4KB base page size. Both guests can be running on host with 4KB or
64KB base page size. Besides, the code changes are specific to ARM64,
meaning they don't affect other architectures.

(1) If we have the combination of guest.64KB and host.4KB, the 2MB page
     reporting order is still avoid splitting the THP on host.
(2) If we have the combination of guest.64KB and host.64KB, the THP splitting
     can't be avoided.

After thinking about it, I agree to reuse page_report_register() and
"struct page_reporting_dev_info" to have the page reporting order. In
this way, the PAGE_REPORTING_CAPACITY can be provided by consumer in
future either. I will have these updates in v2 patches.

Thanks,
Gavin

> 
> On Sun, Jun 20, 2021 at 8:11 PM Gavin Shan <gshan@redhat.com> wrote:
>>
>> The page reporting threshold is currently equal to @pageblock_order, which
>> is 13 and 512MB on arm64 with 64KB base page size selected. The page
>> reporting won't be triggered if the freeing page can't come up with a free
>> area like that huge. The condition is hard to be met, especially when the
>> system memory becomes fragmented.
>>
>> This series intends to solve the issue by having page reporting threshold
>> as 5 (2MB) on arm64 with 64KB base page size. The patches are organized as:
>>
>>     PATCH[1/3] introduces variable (@page_reporting_order) to replace original
>>                macro (PAGE_REPORTING_MIN_ORDER). It's also exported so that it
>>                can be adjusted at runtime.
>>     PATCH[2/3] renames PAGE_REPORTING_MIN_ORDER with PAGE_REPORTING_ORDER and
>>                allows architecture to specify its own version.
>>     PATCH[3/3] defines PAGE_REPORTING_ORDER to 5, corresponding to 2MB in size,
>>                on arm64 when 64KB base page size is selected. It's still same
>>                as to @pageblock_order for other architectures and cases.
>>
>> Gavin Shan (3):
>>    mm/page_reporting: Allow to set reporting order
>>    mm/page_reporting: Allow architecture to select reporting order
>>    arm64: mm: Specify smaller page reporting order
>>
>>   Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>>   arch/arm64/include/asm/page.h                   | 13 +++++++++++++
>>   mm/page_reporting.c                             |  8 ++++++--
>>   mm/page_reporting.h                             | 10 +++++++---
>>   4 files changed, 32 insertions(+), 5 deletions(-)
>>
>> --
>> 2.23.0
>>
> 

