Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EFD3C9C10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhGOJpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231655AbhGOJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626342149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PdOfMSnG9LJU18W2DtAkqVS77pNiWqr5hxkOihWpm0=;
        b=M03ha2Of0EUT4Jwher8d1HZTBBF1NvuFdZP4x3PAtBe4qXSqqY3aQDADgvzEM/AEa7yhcL
        RBYZF8kCzeSQ5B58BTVmif5p3k+aRbfZCuXzDVz4O5P2TMfeHd6mRsn2FvDVObXcJKbfcy
        4TWqjVQN130byboaPnWtza8pzPzkCQU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-fsuh34bDMnS4W_XuIb_Lxg-1; Thu, 15 Jul 2021 05:42:28 -0400
X-MC-Unique: fsuh34bDMnS4W_XuIb_Lxg-1
Received: by mail-wr1-f72.google.com with SMTP id d8-20020adf9c880000b0290141a87409b5so2221044wre.16
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 02:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4PdOfMSnG9LJU18W2DtAkqVS77pNiWqr5hxkOihWpm0=;
        b=IC/7yphTGqNyQgibOQXLUS6OzSLG/AesXiata4V191xSFIKIbD8AaRPd8iUqTjO8ZO
         sN2UKGQQCTcNhJ17YR3+gz9DvotN4b9MjtNQ4TymB7SBw4zfgoeY+yuiSQlPUx6zzCiK
         li/YwjtpkMXZvN2n6x4n7+LbKdmDzok+AzJPnhMnQwl6vVuTzuAfj4kD7aA0+0rPEuvc
         G9St3DCKMGVek3+WTblLg2AzFhuX4XeJTe6gCEFlEUfvvT7ovoBOwyMxBTBxeVcbG/s9
         nf9GiHnv0eZw4+OG1v4rqcQR9qBZIZUONmJw4vRdot6MTD9W3pMOuKhVQovigaj2LpCd
         jRZA==
X-Gm-Message-State: AOAM533AmAMA7qiH3l7jy8Wudkd4Y8pyCxZw58SPzlYngz2seOBsLgrI
        f24/DQYPUA6RlP0YlPcoIF4DKHavb/QBGhSqroY6aRfFUG2Vz396LOV6zpoCmq/xk1Wa9b8xhcf
        FPlXR1cGqhVLD0tGFSLmgXVa4
X-Received: by 2002:a1c:4e18:: with SMTP id g24mr3536118wmh.175.1626342144027;
        Thu, 15 Jul 2021 02:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAXwE/gJvtgWH3VbzGQK7W3cyGE+l9fkhB4QJqLvhmzLWnJPkHReE1uIFCe9c8tBBrApBQSg==
X-Received: by 2002:a1c:4e18:: with SMTP id g24mr3536099wmh.175.1626342143837;
        Thu, 15 Jul 2021 02:42:23 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bb3.dip0.t-ipconnect.de. [79.242.59.179])
        by smtp.gmail.com with ESMTPSA id q5sm4533504wmc.0.2021.07.15.02.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 02:42:23 -0700 (PDT)
To:     Heiko Carstens <hca@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jia He <justin.he@arm.com>, Joe Perches <joe@perches.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rich Felker <dalias@libc.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210712124052.26491-1-david@redhat.com>
 <20210712124052.26491-2-david@redhat.com> <YO9FWrT9h21e/G8X@osiris>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: use "unsigned long" for PFN in
 zone_for_pfn_range()
Message-ID: <99c59db8-4c3d-6bee-9acc-41a8f76899ef@redhat.com>
Date:   Thu, 15 Jul 2021 11:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO9FWrT9h21e/G8X@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.21 22:13, Heiko Carstens wrote:
> On Mon, Jul 12, 2021 at 02:40:49PM +0200, David Hildenbrand wrote:
>> Checkpatch complained on a follow-up patch that we are using "unsigned"
>> here, which defaults to "unsigned int" and checkpatch is correct.
>>
>> Use "unsigned long" instead, just as we do in other places when handling
>> PFNs. This can bite us once we have physical addresses in the range of
>> multiple TB.
>>
>> Fixes: e5e689302633 ("mm, memory_hotplug: display allowed zones in the preferred ordering")
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/memory_hotplug.h | 4 ++--
>>   mm/memory_hotplug.c            | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> I'd propose to add Cc: <stable@vger.kernel.org> since I actually had
> the fun to try to debug something like this a couple of years ago:
> 6cdb18ad98a4 ("mm/vmstat: fix overflow in mod_zone_page_state()")
> 

Good point, and thinking again what can go wrong, I tend to agree. We 
are trying to keep zones contiguous and it could happen that we end up 
with something like ZONE_DMA here (via default_kernel_zone_for_pfn()) 
and would consequently online something to ZONE_DMA that doesn't belong 
there, resulting in crashes.

@Andrew can you add  Cc: <stable@vger.kernel.org> and

"As we will search for a fitting zone using the wrong pfn, we might end 
up onlining memory to one of the special kernel zones, such as ZONE_DMA, 
which can end badly as the onlined memory does not satisfy properties of 
these zones."

Thanks Heiko!

-- 
Thanks,

David / dhildenb

