Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDE3F5118
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhHWTPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230332AbhHWTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629746103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbCwTw6xOu3Ht//mhhr4QVYkX1dUGLm9ed7G3TO0npw=;
        b=C46zSB/y7ktDD5z/zzffYItonpqvIUDzj38Rla6xjte2Bst8+LRLn/zvO5x3bDGlKBkLOm
        cxoFaEjtsHiUbAZydakZsbkIM63BzgdTmHB1mYAtepzLoMpAQXqCWkaQ6qAT3W2N2AjWBd
        lQhnMXXwYbxztzw3CSLf8r9zlnLnRb4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-e2SI2gcONv6TkaeVNCG8kw-1; Mon, 23 Aug 2021 15:15:02 -0400
X-MC-Unique: e2SI2gcONv6TkaeVNCG8kw-1
Received: by mail-wr1-f71.google.com with SMTP id n10-20020a5d660a0000b02901551ef5616eso5241902wru.20
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FbCwTw6xOu3Ht//mhhr4QVYkX1dUGLm9ed7G3TO0npw=;
        b=RApSLWXq7UXpsbgIIW8/MMLnjZjXqFONda5dbI0mbU1Fgsm9F01lUjRN6VcNtaIo7L
         nZM4WnSwGgbPw8o7sdzgr5dYSaehrdU+S8HhASOcI9bDJipX3cC4JFkxJeAMEyDCFGiY
         Ej7pMno/9FMkoy5jKJftECIqcZtPKJ0OoupuU1u0DR2bA1NlhH6dibroNk5zfjJtdkcn
         Mj3dKDotxJBdjTyObJKTJaEES/l5waGa9fvZG9qVH+vXB6qV1IZjAK0CsIrmRY9BvYsL
         6djWOJMg6Clu2tmTI3yULQGtSbAFNtzpbw6S9Cd5eDCdz77eSdd3mE6NWPqZGOyNPalO
         0Upw==
X-Gm-Message-State: AOAM5311SXvPf9esLdmcSmV13LweY7OIsnGIu1w14uSkbQQb3AgUEpEY
        iFJX9386MnjUK8ZI2WUVsI+dSKDvBU5KCiPAZdlKUAHklK+V6AQe5m61uEcxBiqtxuHKL+uI+HS
        conGJ4h1LCTHPh68g/UoQyHSc
X-Received: by 2002:a1c:f206:: with SMTP id s6mr123202wmc.102.1629746100816;
        Mon, 23 Aug 2021 12:15:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmHLZ/yRcGZNEKd6Wx/oxzCAOwoEzlfech47KHL+wKEm8l9PACfZJA4BN1gYFB0YEVFyNQig==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr123185wmc.102.1629746100627;
        Mon, 23 Aug 2021 12:15:00 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60c6.dip0.t-ipconnect.de. [91.12.96.198])
        by smtp.gmail.com with ESMTPSA id y15sm2342827wrw.64.2021.08.23.12.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 12:15:00 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] virtio-mem: disallow mapping virtio-mem memory via
 /dev/mem
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
References: <20210816142505.28359-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <aa136104-153c-1c85-54df-f55b953ff36d@redhat.com>
Date:   Mon, 23 Aug 2021 21:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816142505.28359-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 16:25, David Hildenbrand wrote:
> Let's add the basic infrastructure to exclude some physical memory
> regions completely from /dev/mem access, on any architecture and under
> any system configuration (independent of CONFIG_STRICT_DEVMEM and
> independent of "iomem=").
> 
> Use it for virtio-mem, to disallow mapping any virtio-mem memory via
> /dev/mem to user space after the virtio-mem driver was loaded: there is
> no sane use case to access the device-managed memory region via /dev/mem
> once the driver is actively (un)plugging memory within that region and
> we want to make sure that nobody will accidentially access unplugged
> memory in a sane environment.
> 
> Details can be found in patch #1.
> 
> v1 -> v2:
> - "/dev/mem: disallow access to explicitly excluded system RAM regions"
> -- Introduce and use for_each_resource() and next_resource_skip_children()
> -- s/iomem_range_contains_excluded/iomem_range_contains_excluded_devmem/
> - "kernel/resource: cleanup and optimize iomem_is_exclusive()"
> -- Use for_each_resource()
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
> 
> David Hildenbrand (3):
>    /dev/mem: disallow access to explicitly excluded system RAM regions
>    virtio-mem: disallow mapping virtio-mem memory via /dev/mem
>    kernel/resource: cleanup and optimize iomem_is_exclusive()
> 
>   drivers/char/mem.c          | 22 ++++++--------
>   drivers/virtio/virtio_mem.c |  4 ++-
>   include/linux/ioport.h      |  1 +
>   kernel/resource.c           | 60 +++++++++++++++++++++++++++++++++----
>   lib/Kconfig.debug           |  4 ++-
>   5 files changed, 71 insertions(+), 20 deletions(-)
> 
> 
> base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
> 

More review welcome; I'd suggest this should go via the -mm tree, and 
not via the vhost tree.

-- 
Thanks,

David / dhildenb

