Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C8E3EB1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbhHMHph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239456AbhHMHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628840707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Teq8UbagtozxN4Eo3VM2ctv7Q0KnaAQlxa4UWyV9YQ=;
        b=LpLwWa8xuRo2ulFyIH0Hl9TMfl30Xf7EZiVMb0j+9QgSjchTZMAa8hzReLze7cpUW/eGJO
        cdi5vpF6ZdKIuR7sW57cp+V+hLE5LGl2NxD9QcaKLjd7ZhbJtcIJN3+3mI+Xrjeh0NzYjS
        cSRs9sWqJgMUeQQWr9683vfL/XD0FgY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-GYSEM9NjPcuo5P15DuC5Yw-1; Fri, 13 Aug 2021 03:45:05 -0400
X-MC-Unique: GYSEM9NjPcuo5P15DuC5Yw-1
Received: by mail-wr1-f72.google.com with SMTP id a9-20020a0560000509b029015485b95d0cso2654196wrf.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7Teq8UbagtozxN4Eo3VM2ctv7Q0KnaAQlxa4UWyV9YQ=;
        b=b2zO6omtYz23rmz7/ODyOH+jcxARtd55DNpvv607KH0h4tLBGl+6FnZTb67VZpRBmg
         GvmeKuyRM/2EWe3nFdJMrzCujKf+fLpEMWedkw5HD7YYpEKhvYpqz3FwF4Xn7jChBBjs
         xdaY6I8uuWsbjsKkDFTY/ZHUIhR8dnl6BC++lkKyeBcMtN3t9cl9KvZChOcvJuNE0mwd
         O2VtcTsi8CYProLDa78gfmMRQWre6WTrZYv8gNd2DHxyjVI9xCfoWSvrTm5LZvuPeePf
         nGLNDCWMLOu6qzqc8QCzxVv43+0X9X85kHgfNBwg/Ia+yJ9v8fDnIc589eu3e4dzwdq5
         cxsQ==
X-Gm-Message-State: AOAM532I3+T27d3s1UTP2SCXlSIw7TybcJ04e89/SU6RqGWnSbv4G+kt
        WzZmionPpQJ9lJK/16QhPVD5xEdzoxI+3g4SdOUlCPD7iTD1ybA2vXHoTt+m/0qD9Wp2nTVjabO
        56Eccv+QZ8+GBz/ul5Lo1+AXD
X-Received: by 2002:a05:600c:1c28:: with SMTP id j40mr1344995wms.104.1628840704142;
        Fri, 13 Aug 2021 00:45:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSjOWohJfjAJ+7FUzSyKi8N1Le4n6LYsBXwpgNlp369MQ4VMbQeGmfTi+w5r4HJ/tWLnckVA==
X-Received: by 2002:a05:600c:1c28:: with SMTP id j40mr1344978wms.104.1628840703928;
        Fri, 13 Aug 2021 00:45:03 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66ea.dip0.t-ipconnect.de. [91.12.102.234])
        by smtp.gmail.com with ESMTPSA id h16sm742166wre.52.2021.08.13.00.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:45:03 -0700 (PDT)
Subject: Re: An cma optimization patch is used for cma_[alloc|free].
To:     Jichao Zou <zoujc@motorola.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        JianQi Yang <yangj@motorola.com>,
        Yanjune Tian <tianyje@motorola.com>
References: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f5cd9fe6-3b62-eab8-1ff1-d3943d4bb85b@redhat.com>
Date:   Fri, 13 Aug 2021 09:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.21 09:00, Jichao Zou wrote:
> Pre-allocate CMA memory that configured in device
> tree, this greatly improves the CMA memory
> allocation efficiency, cma_[alloc|free] is less
> than 1ms, old way is took a few ms to tens or
> hundreds ms.
> 

Please send patches as proper emails (man git-format-patch; man 
git-send-email).

What you propose is turning cma reservations into something comparable 
to permanent boottime allocations. From the POV of the buddy, the pages 
are always allocated and cannot be repurposed for e.g., movable 
allocations until *actually* allocated via CMA.

I don't think we want this behavior upstream.

-- 
Thanks,

David / dhildenb

