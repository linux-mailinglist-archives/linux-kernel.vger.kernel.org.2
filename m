Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD37C375BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhEFTjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235249AbhEFTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620329922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mD9rk0OEj0XYhxeQH5IDJPNbrX+PSqo6PoFdlh4Fuj4=;
        b=XImLsgWo+QKlmyFO/XlEDIt+Ur0g+yEHU0vNvIGZicLxOMFTDhm1SMaHO6kHyvo+R96HLJ
        n8OuKEvm76zWoLN1ebZLdUs0FWjwaxGFUmckZConLy9xqNBdCPnXixRPsDjCcUVmbTzaR/
        j4eieEbJSRhovwhXNb5AA0XnCwnN1kY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-1l_AaHJ3OQm0ocxUNv9pvA-1; Thu, 06 May 2021 15:38:40 -0400
X-MC-Unique: 1l_AaHJ3OQm0ocxUNv9pvA-1
Received: by mail-wm1-f72.google.com with SMTP id g199-20020a1c9dd00000b02901355dd71edaso3026069wme.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mD9rk0OEj0XYhxeQH5IDJPNbrX+PSqo6PoFdlh4Fuj4=;
        b=ND5FbGFxc503hkTwE5xDE6k3H1J37X5p0TyltfBBp5jxdU5eADmNRUk8qSc2tPFjIz
         Zy6R/4kIIaUIpNRX2DY4hl4ptiKCfIn74XjbbRUqGUxmQ7C1EjjbVjf0FrVfofIAsRcR
         TVkRNRKATCLxg9wU94q/HuZUExo2ghggt+VsaR4HxaTih0nEeU2eepAV6F8g4zo3V5fr
         5kOi77US4S8C24J4u1zoxs3HIFYXwqB0zCC1Qx7l4HQeP5gznLqxdmn0wBl59QwkYfkF
         JWxpFBYMin3pUUhrc2InBjPvQ9YuyRzgNVc1wEO/ak3OXIMN6PZ13w5NWzbbqgqj8o98
         D9Dw==
X-Gm-Message-State: AOAM533ipcpEpoQBKl0KK1MIyU5edXgPuj4vagEEqCFrrfy6ulICtp7w
        E9lnyHZ41khaWbp9yiKVkLEUcj0w2GBzngbZtIdnoTlmMluKmG86IC/7HmuOgwUg1zeXb6dj3B6
        EfC4oGzsqD8w+jrJENGVbQClz
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr7392209wrv.69.1620329919136;
        Thu, 06 May 2021 12:38:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOC06i3MicUKjMNEqxEnGDL/rTRmiJEviad77ONpxe7ogE7ETHVYywYhvhoyD41LPb0MdTmQ==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr7392182wrv.69.1620329918917;
        Thu, 06 May 2021 12:38:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id q10sm4494733wmc.31.2021.05.06.12.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 12:38:38 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Memory hotplug/hotremove at subsection size
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
References: <20210506152623.178731-1-zi.yan@sent.com>
 <fb60eabd-f8ef-2cb1-7338-7725efe3c286@redhat.com>
 <9D7FD316-988E-4B11-AC1C-64FF790BA79E@nvidia.com>
 <3a51f564-f3d1-c21f-93b5-1b91639523ec@redhat.com>
 <16962E62-7D1E-4E06-B832-EC91F54CC359@nvidia.com>
 <f3a2152c-685b-2141-3e33-b2bcab8b6010@redhat.com>
 <3A6D54CF-76F4-4401-A434-84BEB813A65A@nvidia.com>
 <0e850dcb-c69a-188b-7ab9-09e6644af3ab@redhat.com>
 <20210506193026.GE388843@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d2e3c89d-a1fe-e7bc-c2ec-586df2073951@redhat.com>
Date:   Thu, 6 May 2021 21:38:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506193026.GE388843@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 21:30, Matthew Wilcox wrote:
> On Thu, May 06, 2021 at 09:10:52PM +0200, David Hildenbrand wrote:
>> I have to admit that I am not really a friend of that. I still think our
>> target goal should be to have gigantic THP *in addition to* ordinary THP.
>> Use gigantic THP where enabled and possible, and just use ordinary THP
>> everywhere else. Having one pageblock granularity is a real limitation IMHO
>> and requires us to hack the system to support it to some degree.
> 
> You're thinking too small with only two THP sizes ;-)  I'm aiming to

Well, I raised in my other mail that we will have multiple different use 
cases, including multiple different THP e.g., on aarch64 ;)

> support arbitrary power-of-two memory allocations.  I think there's a
> fruitful discussion to be had about how that works for anonymous memory --
> with page cache, we have readahead to tell us when our predictions of use
> are actually fulfilled.  It doesn't tell us what percentage of the pages

Right, and I think we have to think about a better approach than just 
increasing the pageblock_order.

> allocated were actually used, but it's a hint.  It's a big lift to go from
> 2MB all the way to 1GB ... if you can look back to see that the previous
> 1GB was basically fully populated, then maybe jump up from allocating
> 2MB folios to allocating a 1GB folio, but wow, that's a big step.
> 
> This goal really does mean that we want to allocate from the page
> allocator, and so we do want to grow MAX_ORDER.  I suppose we could
> do somethig ugly like
> 
> 	if (order <= MAX_ORDER)
> 		alloc_page()
> 	else
> 		alloc_really_big_page()
> 
> but that feels like unnecessary hardship to place on the user.

I had something similar for the sort term in mind, relying on 
alloc_contig_pages() (and maybe ZONE_MOVABLE to make allocations more 
likely to succeed). Devil's in the details (page migration, ...).


-- 
Thanks,

David / dhildenb

