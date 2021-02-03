Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8303530DC65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhBCONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:13:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231936AbhBCONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612361539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4H8QwsmVhRse/MHW6XyL15Amm7fwPxllon0PusjMy0=;
        b=TerdKgvvZQ/dFepReMZedcC3AYNJk8RLZT2Dhuu2+pDLzJF0K32Hvr+/qgYQSru0f8CvF7
        wVXv7XVZrcKZFbYgKmHo2SKH1LezUVi8P8tHn1qzqEAGYPbChsftflWDbwxwAWvOKzGZG7
        QvMMzMOGdElGaiPK4lQmECGpHaDUNG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-fB7sa8X1OhGlTzBcYzEIGg-1; Wed, 03 Feb 2021 09:12:12 -0500
X-MC-Unique: fB7sa8X1OhGlTzBcYzEIGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F04B100C660;
        Wed,  3 Feb 2021 14:12:09 +0000 (UTC)
Received: from [10.36.112.222] (ovpn-112-222.ams2.redhat.com [10.36.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C887760C71;
        Wed,  3 Feb 2021 14:12:06 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] x86/vmemmap: Drop handling of 1GB vmemmap ranges
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210203104750.23405-1-osalvador@suse.de>
 <20210203104750.23405-3-osalvador@suse.de>
 <ec2f6a46-b2a8-8131-a2ac-48a02a1ea201@redhat.com>
 <20210203141038.GA26693@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a503f51d-42fe-3cd1-aa7c-66af33f1b3f8@redhat.com>
Date:   Wed, 3 Feb 2021 15:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210203141038.GA26693@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.21 15:10, Oscar Salvador wrote:
> On Wed, Feb 03, 2021 at 02:33:56PM +0100, David Hildenbrand wrote:
>> One problem I see with existing code / this change making more obvious is
>> that when trying to remove in other granularity than we added (e.g., unplug
>> a 128MB DIMM avaialble during boot), we remove the direct map of unrelated
>> DIMMs.
> 
> So, let me see if I understand your concern.
> 
> We have a range that was mapped with 1GB page, and we try to remove
> a 128MB chunk from it.
> Yes, in that case we would clear the pud, and that is bad, so we should
> keep the PAGE_ALIGNED checks.
> 
> Now, let us assume that scenario.
> If you have a 1GB mapped range and you remove it in smaller chunks bit by bit
> (e.g: 128M), the direct mapping of that range will never be cleared unless

No, that's exactly what's happening. Good thing is that it barely ever 
happens, so I assume leaving behind some direct mapping / page tables is 
not that bad.

-- 
Thanks,

David / dhildenb

