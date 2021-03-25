Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638653496B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhCYQUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbhCYQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616689232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUaI0jPAJHBsBAO60IzxWqFDvl762DqvoYKPg8yydHk=;
        b=GuXJOw46kZdaEjeUhusiSRnRVjoQTs3AFLbCAC2esPVQCCYtCjZHgU8flDNJ6NUD19lJzW
        4+ilIVLpWs8n0o9K57CSNTYQmCWcEodKrI53EiZZN1SRBO+eh3WqppcQFLIL1EvLrZdxaD
        ouSLeXruO2jWUedRcp8DakGPGDcjrik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-Pj8XVcylP5aLUVpJlF9LtQ-1; Thu, 25 Mar 2021 12:20:28 -0400
X-MC-Unique: Pj8XVcylP5aLUVpJlF9LtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF61E108BD0B;
        Thu, 25 Mar 2021 16:20:26 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18E2B5D736;
        Thu, 25 Mar 2021 16:20:24 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
 <YFyDhKPqS15HdO0Y@dhcp22.suse.cz>
 <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
 <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
 <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
 <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz> <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
Date:   Thu, 25 Mar 2021 17:20:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 17:07, Michal Hocko wrote:
> On Thu 25-03-21 16:35:58, Michal Hocko wrote:
> [...]
>> So there is indeed a difference. One way around that would be to mark
>> vmemmap pages (e.g. PageReserved && magic value stored somewhere in the
>> struct page - resembling bootmem vmemmaps) or mark section fully backing
>> vmemmaps as online (ugly).
> 
> I am not yet ready to give up on this. Here is a quick stab at the
> pfn_to_online_page approach. It is not great but it is not really
> terrible either. I think we can do better and skip

We both seem to have a different taste, to phrase it in a nice way :) ; 
but well, you seem to have set your mind (just like I seem to have set 
mine when trying to find a nice and somewhat-clean way to handle this 
when discussing it in the past).

I expressed my opinion, shared my findings and expressed my concerns; 
the series has my RB and the discussion here is around something I 
consider in no way better than what we have right now. I'll let Oscar 
handle discussing this topic further (sorry Oscar! :) ), but I'll 
happily review what the outcome of that will be.

-- 
Thanks,

David / dhildenb

