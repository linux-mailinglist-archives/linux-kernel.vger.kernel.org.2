Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7078A33108C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCHOOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhCHONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615212823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgbBup6Vj344vbeikJWoQwoH+WZLtLaIQQ1FS0zc2MA=;
        b=EW3wo2cnnyqRZZ2MWzMMfJXuX/hHM6NTj4R9pd76QVI61bYzgsApY9bJscaA2kW6RwAtct
        rCOBpwPARtG2RcmQ9WJEUkp8k5fILxnCtENFRKKHERyjI26xwlK40emQrjJnDa77lOK/fm
        iN/F8uIBUEDWK5A2uGqMao6y9LxdYz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-NGWhpdnuNfq0M1wOFgsz6g-1; Mon, 08 Mar 2021 09:13:39 -0500
X-MC-Unique: NGWhpdnuNfq0M1wOFgsz6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09EC9108BD12;
        Mon,  8 Mar 2021 14:13:38 +0000 (UTC)
Received: from [10.36.113.123] (ovpn-113-123.ams2.redhat.com [10.36.113.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0C4A60C6E;
        Mon,  8 Mar 2021 14:13:36 +0000 (UTC)
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
To:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
References: <YEEES/K8cNi8qOJe@google.com>
 <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
 <YEEJf0itS/8vn8Iy@google.com>
 <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
 <YEEUq8ZRn4WyYWVx@google.com>
 <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
 <YEEi1+TREGBElE5H@google.com> <YEEle5xBAc7FUDNI@google.com>
 <YEYdR8azcawau9Rl@dhcp22.suse.cz>
 <c1461e51-7ad0-7fb5-9dc2-7f7c5cdf128f@redhat.com>
 <YEYwdjvYGiZ4crMt@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9f7b4b8a-5317-e382-7f21-01667e017982@redhat.com>
Date:   Mon, 8 Mar 2021 15:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEYwdjvYGiZ4crMt@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.21 15:11, Michal Hocko wrote:
> On Mon 08-03-21 14:22:12, David Hildenbrand wrote:
>> On 08.03.21 13:49, Michal Hocko wrote:
> [...]
>>> Earlier in the discussion I have suggested dynamic debugging facility.
>>> Documentation/admin-guide/dynamic-debug-howto.rst. Have you tried to
>>> look into that direction?
>>
>> Did you see the previous mail this is based on:
>>
>> https://lkml.kernel.org/r/YEEUq8ZRn4WyYWVx@google.com
>>
>> I agree that "nofail" is misleading. Rather something like
>> "dump_on_failure", just a better name :)
> 
> Yeah, I have read through the email thread. I just do not get why we
> cannot make it pr_debug() and add -DDYNAMIC_DEBUG_MODULE for
> page_alloc.c (I haven't checked whether that is possible for built in
> compile units, maybe it is not but from a quick seems it should).
> 
> I really do not like this to be a part of the API. alloc_contig_range is

Which API? It does not affect alloc_contig_range() itself, it's used 
internally only. Sure, we could simply pr_debug() for each and every 
migration failure. As long as it's default-disabled, sure.

I do agree that we should look into properly including this into the 
dynamic debugging ifrastructure.

-- 
Thanks,

David / dhildenb

