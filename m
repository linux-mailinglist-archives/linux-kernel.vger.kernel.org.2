Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9F39890B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFBMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhFBMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622635742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nb53P46lpq0QHGo0Ib5PtqvuzN+E2xnIwefsTEFefR4=;
        b=YVEnaN7pz5MIcgoQ42l7Z+rpRf8UdFrdrrg3jJ1zqJixPRRZ26lYgH/4PenyLXL7DFrYi6
        08IiWhTZfuZ/nJcz7oQ35ufsomGxFHmFaw7bdybx5V9Vs0iuuilDajlCd4GdnCzSjFKBw8
        n79S6/fl2UNKYt4l3w7iy06SjE3SCg4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-k0UqJ8hWMFmcqoqd1INekw-1; Wed, 02 Jun 2021 08:09:01 -0400
X-MC-Unique: k0UqJ8hWMFmcqoqd1INekw-1
Received: by mail-wr1-f69.google.com with SMTP id s8-20020adff8080000b0290114e1eeb8c6so904775wrp.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nb53P46lpq0QHGo0Ib5PtqvuzN+E2xnIwefsTEFefR4=;
        b=qDlJ49nPctp/mMrFqQR9agNTc3MXIXnzNEiBwDCSqPKYmvJ3D3K7Lk3nn8sll7EB9O
         IgsB2qHQ+VIcPU+dyOaCkHw/aVAAnSWMPUPRlsGLxjBbtYW9nIx29kZhMQdFTaVnZxug
         TEgZw0BniPZz3MrgbD762Q+9tXM1xQ2Srfl1fPVi7YzSgXHh+GOMNVFj+5OWR5WSJJUB
         Le3fi3LWz4gBv83skPJHmIOpx7c+xGx/ytirPKHW9fn1fM0G7OTPmctGdmGAEIlRP4L3
         PAfjPsU1aB6YoW1qMtUMY0xojq4odpSD5LTAXzT/qNUzEvIy3RsCyXZTlRNCKXRK4duS
         4Fng==
X-Gm-Message-State: AOAM5312IT0eJnEzywvDrCV4s3L2W/nZL47PkSkWsx5/73kY7+KKamos
        6sQjycnOena/sBIRrmeTWbIOTyAZSQBIt1xukxQkNfAGaP3WsJ6KFGCKOaUEm7Y6mNl/GSgOEm7
        DonMroz39BqDDgN3lP0bCmFx9
X-Received: by 2002:adf:d234:: with SMTP id k20mr33218100wrh.82.1622635740030;
        Wed, 02 Jun 2021 05:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw58MA37jWfpzppDICXUB5EciUs4Xfx1MQed0fuQQQTrtlSOtPVp01wAzA/eKdOSmZhmGEK2A==
X-Received: by 2002:adf:d234:: with SMTP id k20mr33218076wrh.82.1622635739813;
        Wed, 02 Jun 2021 05:08:59 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
        by smtp.gmail.com with ESMTPSA id n10sm7466284wre.95.2021.06.02.05.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 05:08:59 -0700 (PDT)
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, dan.j.williams@intel.com,
        logang@deltatee.com, linux-mm@kvack.org, hch@lst.de
Cc:     sagi@grimberg.me, oren@nvidia.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] PCI/P2PMEM: introduce pci_p2pdma_align_size API
Message-ID: <4bbb0934-384a-533f-b964-6b3695719b25@redhat.com>
Date:   Wed, 2 Jun 2021 14:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602111055.10480-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.21 13:10, Max Gurtovoy wrote:
> Hi all,
> In hotplugged memory (from check_pfn_span function):
> "
> Disallow all operations smaller than a sub-section and only
> allow operations smaller than a section for
> SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
> enforces a larger memory_block_size_bytes() granularity for
> memory that will be marked online, so this check should only
> fire for direct arch_{add,remove}_memory() users outside of
> add_memory_resource()
> "
> 
> This restriction will disqualify, for example, large NVMe CMBs that might have
> non power of 2 number of pages (e.g. 32767 pages of 4KB). For these
> devices, the CMB size will be rounded down from 0x7fff000 to 0x7e00000
> but it's better than having un-mapped CMB.

Just some high-level questions:

A CMB is just a PCI BAR used for communicating with the device, to be 
mapped into physical address space, right? I assume the relevant hotplug 
code is:

drivers/pci/p2pdma.c:   addr = devm_memremap_pages(&pdev->dev, pgmap);

correct?


Having a BAR span such weird sizes will most probably never be fully 
supported. But if sub-sections work for you, great.



-- 
Thanks,

David / dhildenb

