Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4900F337991
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCKQik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhCKQic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615480711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fci0/BzKEQh4UUxidlo0WYyjv3Nja7ctTNoMztoj/DA=;
        b=Xk41aVibZXdTthy0rMbklH9ThtC92DMueWCf2yuz6IPE7tXQt+4JG6txRArRqnqBhpFvYQ
        4K9slOUloSCCAk1qq/9EmwosPQ6sZFNe87gaR/J/H0fzAuorvI0H8yJVLFLrqWH4fO2wFq
        eb2rG/aMBL3nA0xx0FDUixJLAyberbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-Q1UE_uVTP2-2CrzB_g3K5g-1; Thu, 11 Mar 2021 11:38:27 -0500
X-MC-Unique: Q1UE_uVTP2-2CrzB_g3K5g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBDFB100C61B;
        Thu, 11 Mar 2021 16:38:24 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71F3210013D6;
        Thu, 11 Mar 2021 16:38:22 +0000 (UTC)
Subject: Re: [PATCH v5 3/4] x86/vmemmap: Handle unpopulated sub-pmd ranges
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
References: <20210309174113.5597-1-osalvador@suse.de>
 <20210309174113.5597-4-osalvador@suse.de>
 <3471fe0e-d8f4-c8fe-2096-8d9c8b1ab5bc@redhat.com>
 <20210310174953.GA16289@linux>
 <1814c21c-b822-0ec6-c16d-92424d00663a@redhat.com>
 <YElA+cMxS4NZHFAV@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8191d221-d307-83b1-165f-2fbb5f7149da@redhat.com>
Date:   Thu, 11 Mar 2021 17:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YElA+cMxS4NZHFAV@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.21 22:58, Oscar Salvador wrote:
> On Wed, Mar 10, 2021 at 06:58:26PM +0100, David Hildenbrand wrote:
>> Thinking again, I guess it might be a good idea to factor out the core
>> functions into common code. For the optimization part, it might make sense
>> too pass some "state" structure that contains e.g., "unused_pmd_start".
> 
> Yeah, that really sounds like a good thing to do.
> 
>>
>> Then we don't have diverging implementations of essentially the same thing.
>>
>> Of course, we can do that on top of this series - unifying both
>> implementations.
> 
> I would rather do it on top of this series, not because I am lazy, but
> rather fairly busy and I will not be able to spend much time on it
> anytime soon.
> 
> Once this series gets merged, I commit to have a look into that.
> 

Sure, makes sense - thanks!


-- 
Thanks,

David / dhildenb

