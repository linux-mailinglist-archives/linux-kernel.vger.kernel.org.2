Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6B3757A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhEFPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235176AbhEFPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620315532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UoFaFG5meAOT76aQgHG0SVdbeZvG8CD4G86zVOp7u+4=;
        b=XPk0BKgCIahN1QBJEcNgPMZ2MRClvLJcA0sR8BhJ/QvNcHonmDDlRgM3QdBcJd1Ph5Oy/W
        IfaIGDs2Bgmh1ZV82W6SgsEk6NNvGvzxgEUc4Evw9jgV67GstkMhE5TqqMd9yGjViX+2by
        9N+81qgIGyBXuOnXxsuD6pUnZmRe6Ho=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-lyD-wgJJM7qUPY5vsOcyPA-1; Thu, 06 May 2021 11:38:51 -0400
X-MC-Unique: lyD-wgJJM7qUPY5vsOcyPA-1
Received: by mail-ed1-f71.google.com with SMTP id f8-20020a0564020688b029038840895df2so2861340edy.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UoFaFG5meAOT76aQgHG0SVdbeZvG8CD4G86zVOp7u+4=;
        b=PQtq3D2Y6ABCDPoDlwQR+f0Mj2JAdt5/yJvgdmX/lqZ9Oanym1Rwx0CpVdvLPBN5O8
         q7+vG7PCzH97Z1c+YC2yUv/4EJUAnpkYEVmDfmojl+4WExoogAMwdqRB1Co+JUnB4Gm9
         9dF8ViwvcOartvX/SF8pzqt3RYmJoT7J6/W1PFv6wvAsq3oWBA0gv7DfyZIMOu7OZA/m
         xm96bJZHD5ESHv7sIJclSP6meNF2yT03h985cjDyPoOkmoAOOeDJuRqnopCedGONIxh9
         M5r1/W4F4LrCjxfxWvMrUVbDxosHPRllE5s4wSa/pfZ0n3xuVQrFQsl9oqnR2y4AbQj2
         YsWw==
X-Gm-Message-State: AOAM533mFPt5mkv1mKM4Al7/sOVeFXDtCotuBQC8sfKPa8M08BKqiraL
        OCv5s7m4Js5BS06nBmFbjgnGvbX96StnlEDMzSpaSmvQDmRa+cQgpKVD+Cph9Vl05hsdxbBsJQz
        yKBkMtuxyV6kPmzBkrBeleAfD
X-Received: by 2002:aa7:cf07:: with SMTP id a7mr5980732edy.261.1620315530220;
        Thu, 06 May 2021 08:38:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL2Szhl+Ueqawj9kuZ34daMTIBv79xuFgvY8BkgWo+1XkwBijQ+2hXlcRNb5PMiMs9QZDJBg==
X-Received: by 2002:aa7:cf07:: with SMTP id a7mr5980704edy.261.1620315529996;
        Thu, 06 May 2021 08:38:49 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id v23sm1986761eda.8.2021.05.06.08.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 08:38:49 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Memory hotplug/hotremove at subsection size
From:   David Hildenbrand <david@redhat.com>
To:     Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
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
Organization: Red Hat
Message-ID: <596173b0-310f-7719-d432-11a13e325eab@redhat.com>
Date:   Thu, 6 May 2021 17:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fb60eabd-f8ef-2cb1-7338-7725efe3c286@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 17:31, David Hildenbrand wrote:
> On 06.05.21 17:26, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset tries to remove the restriction on memory hotplug/hotremove
>> granularity, which is always greater or equal to memory section size[1].
>> With the patchset, kernel is able to online/offline memory at a size independent
>> of memory section size, as small as 2MB (the subsection size).
> 
> ... which doesn't make any sense as we can only online/offline whole
> memory block devices.
> 
>>
>> The motivation is to increase MAX_ORDER of the buddy allocator and pageblock
>> size without increasing memory hotplug/hotremove granularity at the same time,
> 
> Gah, no. Please no. No.
> 
>> so that the kernel can allocator 1GB pages using buddy allocator and utilizes
>> existing pageblock based anti-fragmentation, paving the road for 1GB THP
>> support[2].
> 
> Not like this, please no.
> 
>>
>> The patchset utilizes the existing subsection support[3] and changes the
>> section size alignment checks to subsection size alignment checks. There are
>> also changes to pageblock code to support partial pageblocks, when pageblock
>> size is increased along with MAX_ORDER. Increasing pageblock size can enable
>> kernel to utilize existing anti-fragmentation mechanism for gigantic page
>> allocations.
> 
> Please not like this.
> 
>>
>> The last patch increases SECTION_SIZE_BITS to demonstrate the use of memory
>> hotplug/hotremove subsection, but is not intended to be merged as is. It is
>> there in case one wants to try this out and will be removed during the final
>> submission.
>>
>> Feel free to give suggestions and comments. I am looking forward to your
>> feedback.
> 
> Please not like this.
> 

And just to be clear (I think I mentioned this already to you?): Nack to 
increasing the section size. Nack to increasing the pageblock order. 
Please find different ways to group on gigantic-pages level. There are 
alternative ideas floating around.

Semi-nack to increasing MAX_ORDER. I first want to see 
alloc_contig_range() be able to fully and cleanly handle allocations < 
MAX_ORDER in all cases (especially !CMA and !ZONE_MOVABLE) before we go 
down that path.

-- 
Thanks,

David / dhildenb

