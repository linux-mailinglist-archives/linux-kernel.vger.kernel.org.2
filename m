Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC641D481
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348751AbhI3H2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348577AbhI3H2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632986827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qy9WRhHp+DckeiCl72dOjoCeu3Wb9LP/kki0BngYX9Y=;
        b=TgV+sSxECn4smGs5UMVxr8AYfvorUztPR72jtRzLI4jiO9af/0hyQb75AXM/RTIe2oI8zx
        mq6Q5/R5qrvC8DaI8rQH7ZFyts6hoOysrLno2QtPMbVzXzaW9JTq6+wY6UiNICsSPjwa/L
        RSuMTs4iDRHlvsMfVO8xAQefU6V1o4c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-HW9aZCUwM9KQWf4veOjqAg-1; Thu, 30 Sep 2021 03:27:06 -0400
X-MC-Unique: HW9aZCUwM9KQWf4veOjqAg-1
Received: by mail-wm1-f70.google.com with SMTP id j21-20020a05600c1c1500b0030ccce95837so1630761wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 00:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Qy9WRhHp+DckeiCl72dOjoCeu3Wb9LP/kki0BngYX9Y=;
        b=oX4ZrL8AGvm0W9ZuGRLN+RC9as2e+XR3jzuaGb4dX/YeY2m/UYGPFMMq9gt7s94f5c
         5m3fUEjNT++k6G0tsbY3Glhsmo+1UsC5oT5XEBMfSpIj514nAtd2Im3V0qqqEbU+pk0P
         Bv1aMFQuQ/LDm/FHdlmmLz2OsO5AT3rld2ZveFUQk+Da7f/0IMfejPBbkngPp4k9KmRK
         QrF+GgGGXjbRkueQ/zcVf8vI6uXHaT/cbFWEUBiZTc2ji3IMF4hiUplHEKKopXwHaUv0
         upCggGRMBm8ZKl4XDtcQyrQDh+gds358uH4jlYyEfdJsYiDefEbGFBeVC73KgpGqTISU
         73Og==
X-Gm-Message-State: AOAM533cMiOg2MXvfAwZLcr/PtNNxIr6Z5ZBohSoK7Vm7EeUGOn0iZgb
        RQ2aEVTFqC67lhj0uA8ivMiRfyhuAVKGgk1C28huSpUxQbFrbYj4oSd5n4Y1LaQNK5zb/c6lUUD
        pP5hpEfnrflJL6uW9iBHca9dI
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr4498885wrs.362.1632986825511;
        Thu, 30 Sep 2021 00:27:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIDBiNNvN8SUl6rxuTL+jFXSZtDp5YR0avYG79v2If5x+IxDM4AS3UDfBBgfFDz0fitXteUA==
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr4498858wrs.362.1632986825273;
        Thu, 30 Sep 2021 00:27:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64bb.dip0.t-ipconnect.de. [91.12.100.187])
        by smtp.gmail.com with ESMTPSA id v23sm1494302wmj.4.2021.09.30.00.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 00:27:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Alex Bee <knaerzche@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20210930013039.11260-1-rppt@kernel.org>
 <20210930013039.11260-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8824cc96-3e7c-b65f-9631-c1acfbd1ed56@redhat.com>
Date:   Thu, 30 Sep 2021 09:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210930013039.11260-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.21 03:30, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
> However, pfn_valid() only checks for availability of the memory map for a
> PFN but it does not ensure that the PFN is actually backed by RAM.
> 
> As dma_map_resource() is the only method in DMA mapping APIs that has this
> check, simply drop the pfn_valid() test from dma_map_resource().
> 
> Link: https://lore.kernel.org/all/20210824173741.GC623@arm.com/
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

