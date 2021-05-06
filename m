Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA1375733
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhEFPcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235147AbhEFPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620315073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M3gJNK8hV6eVduRJTKvIL/+ipOjUBkl33BLAv9gMTmY=;
        b=VLHTiybD1m6GB1ZwNWwTjlJ0oyYkKuiMxUjGE40ttfEGckY5/TWunHEBi9o8B9wcXWbcgh
        9R2HRTDK+PDgrxJqC3L4SFMmhVzremInl+e95g6a8lVjNZOkQEZeRKx8UjWFZwqMMtzXE8
        sLtEISrzVNLaH7YBS+57yiz8yjiR8Bg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-mYIlnC2iNKiIlslx9l1VgQ-1; Thu, 06 May 2021 11:31:12 -0400
X-MC-Unique: mYIlnC2iNKiIlslx9l1VgQ-1
Received: by mail-wm1-f72.google.com with SMTP id t7-20020a1cc3070000b029014131bbe82eso2794866wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M3gJNK8hV6eVduRJTKvIL/+ipOjUBkl33BLAv9gMTmY=;
        b=Pd9GERnCLmNAfR6iDVCT7HLcFQkEd9epO/As/vOojMK9WczODI+Pj6+YySpBY2+aLT
         gaZPbtVx02aV0wMlqMt27FaFow3Vz/vLsJaTH0yNeBorqkBgVA0/bqZtRikRAmKfBV/d
         nhWEoEJNGdBuep0cTdETh8RTg6haXOgab5y3czgvmjf9/fpxP65mTl5QiMiKagxLyeay
         TFif+PGx/wk2UsZcxSLrCIirlpDMLXnxsjkLemEsgOOM2rWaIyPNSXUVmjKBlPlfSSJk
         G8ePH/IUcf43rokL4yQvaBpu2+Qq/stmNet6WaFbdDwItSbQUuBH14QyWDctNhGUAbFD
         jFOw==
X-Gm-Message-State: AOAM53273nQmcgy8y36cGhXF1NCoqrG8Zr7zoxzWuvtgws7uWGa9fll/
        iupJhdlAKcg+hGn1GPRokkvwgua/YLy9mPHrcatJL94RD3AioZ92l6m3UnzHb0GArOTw/RnrQby
        p8zZL8kXbQsQXTy77BrbWBtSr
X-Received: by 2002:a05:600c:4982:: with SMTP id h2mr4597225wmp.108.1620315071105;
        Thu, 06 May 2021 08:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3M0/nH4wBS9mN36/5FP5OpLaVlIbwQucgba+bN4wivCLyv9VNcf9OZFL+ORcvt4/JggAUXw==
X-Received: by 2002:a05:600c:4982:: with SMTP id h2mr4597190wmp.108.1620315070857;
        Thu, 06 May 2021 08:31:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id q12sm9157467wmj.7.2021.05.06.08.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 08:31:10 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Memory hotplug/hotremove at subsection size
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <fb60eabd-f8ef-2cb1-7338-7725efe3c286@redhat.com>
Date:   Thu, 6 May 2021 17:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506152623.178731-1-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 17:26, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset tries to remove the restriction on memory hotplug/hotremove
> granularity, which is always greater or equal to memory section size[1].
> With the patchset, kernel is able to online/offline memory at a size independent
> of memory section size, as small as 2MB (the subsection size).

... which doesn't make any sense as we can only online/offline whole 
memory block devices.

> 
> The motivation is to increase MAX_ORDER of the buddy allocator and pageblock
> size without increasing memory hotplug/hotremove granularity at the same time,

Gah, no. Please no. No.

> so that the kernel can allocator 1GB pages using buddy allocator and utilizes
> existing pageblock based anti-fragmentation, paving the road for 1GB THP
> support[2].

Not like this, please no.

> 
> The patchset utilizes the existing subsection support[3] and changes the
> section size alignment checks to subsection size alignment checks. There are
> also changes to pageblock code to support partial pageblocks, when pageblock
> size is increased along with MAX_ORDER. Increasing pageblock size can enable
> kernel to utilize existing anti-fragmentation mechanism for gigantic page
> allocations.

Please not like this.

> 
> The last patch increases SECTION_SIZE_BITS to demonstrate the use of memory
> hotplug/hotremove subsection, but is not intended to be merged as is. It is
> there in case one wants to try this out and will be removed during the final
> submission.
> 
> Feel free to give suggestions and comments. I am looking forward to your
> feedback.

Please not like this.

-- 
Thanks,

David / dhildenb

