Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB4D321526
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhBVLbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:31:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230525AbhBVLab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613993345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebJHLwtJv4Lygejth71y7MrguaqQLtiAIr5JvZWFqY4=;
        b=Dc6B2tuCRBF7bcbn4T8UseU31UYCvcaSM9iET8HD0lOvL2qSGN3HmaE2GF1NxJwqBz0Kyv
        GTKR7hAuUYG2L/JsFNlINMvbXOB0XDJkZbTHCA6yqz/94YouQoI9SZTiAy9JRlnLuA+EWB
        GLtdFwdtBwRQAVPcMbfsQ4TOq0eGsY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-rUQRAMg9PS6tW7bYycHvoQ-1; Mon, 22 Feb 2021 06:29:01 -0500
X-MC-Unique: rUQRAMg9PS6tW7bYycHvoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D181B8030C2;
        Mon, 22 Feb 2021 11:28:59 +0000 (UTC)
Received: from [10.36.115.16] (ovpn-115-16.ams2.redhat.com [10.36.115.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E95CF5B6AA;
        Mon, 22 Feb 2021 11:28:57 +0000 (UTC)
Subject: Re: [PATCH v2 0/7] Allocate memmap from hotadded memory (per device)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210217101851.GA28996@linux> <20210222111506.GA23651@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8b4670fa-583a-b68b-a65f-7eeca184afd3@redhat.com>
Date:   Mon, 22 Feb 2021 12:28:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222111506.GA23651@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.21 12:15, Oscar Salvador wrote:
> On Wed, Feb 17, 2021 at 11:18:59AM +0100, Oscar Salvador wrote:
>> On Tue, Feb 09, 2021 at 02:38:47PM +0100, Oscar Salvador wrote:
>>> Hi,
>>>
>>> here is v2.
>>>
>>> Changes from v1 -> v2
>>>   - Addressed feedback from David
>>>   - Fence off the feature in case struct page size is not
>>>     multiple of PMD size or pageblock alignment cannot be guaranted
>>>   - Tested on x86_64 small and large memory_blocks
>>>   - Tested on arm64 4KB and 64KB page sizes (for some reason I cannot boot
>>>     my VM with 16KB page size).
>>>
>>>   Arm64 with 4KB page size behaves like x86_64 after [1], which made section
>>>   size smaller.
>>>   With 64KB, the feature gets fenced off due to pageblock alignment.
>>>
>>> Changes from RFCv3 -> v1:
>>>   - Addressed feedback from David
>>>   - Re-order patches
>>>
>>> Changes from v2 -> v3 (RFC):
>>>   - Re-order patches (Michal)
>>>   - Fold "mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY" in patch#1
>>>   - Add kernel boot option to enable this feature (Michal)
>>>
>>> Changes from v1 -> v2 (RFC):
>>>   - Addressed feedback provided by David
>>>   - Add a arch_support_memmap_on_memory to be called
>>>     from mhp_supports_memmap_on_memory, as atm,
>>>     only ARM, powerpc and x86_64 have altmat support.
>>>
>>> [1] https://lore.kernel.org/lkml/cover.1611206601.git.sudaraja@codeaurora.org/
>>
>> Let me refloat this one :-)
> 
> Kindly ping :-)

-EBUSY, will try having a look this week!

-- 
Thanks,

David / dhildenb

