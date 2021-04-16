Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E01D361B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbhDPISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233959AbhDPISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618561088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0QRBbcT35Iu6clJTmp1UTgyC8yDllQoeXk4UU4Rwtk=;
        b=FemDYcvbcfME/IHHd3DoxIvg5rt1OTTE1otC/dfZFoOWQtHDco8pOSjJu9g6EThoLEABoA
        djW6lk/kDpAn4VYJS+mffFxn4mOTlDnsbImxeETVunmsdVa74tGnJa2bQXNBBe+WltOPv6
        bd74wifttITSMzlJxCfsE2P2IBwTn1k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-IxxbcHyyMHONl2uyk2jsMw-1; Fri, 16 Apr 2021 04:18:06 -0400
X-MC-Unique: IxxbcHyyMHONl2uyk2jsMw-1
Received: by mail-ej1-f71.google.com with SMTP id lf6-20020a1709071746b029037cee5e31c4so1771262ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f0QRBbcT35Iu6clJTmp1UTgyC8yDllQoeXk4UU4Rwtk=;
        b=pXQtJV2EUV3GC366aEmQ3LKU7cP95HGZ9KkKF+p3k/if+No58Bon277ZuNDwvyyH91
         y7KMcenaTZrw2LugIHM1NE30P6tZem0YkbehhAX5ZYGai2YBI36nBa31aauJVYNjeVcq
         ZoGQjKthVT3PsFmqg2zpKDo+oxRTeMEPAYYyBHpNmboTpwmTKDGy91PeTTPyDq0TompB
         WpZCm7HeD1bZ6FfWve9KpSupbw2bknfjHm9AOWCUFL1/unzDEBAaI7UqIjNv2kWP3T21
         +u5LmzKIZ63nT8de9tTt4YgHxef+3B9Pzuvv2mXQsKohxTS57FIrj2vx+tDXGmJZeIco
         rjWQ==
X-Gm-Message-State: AOAM533+5uzNTpVLicAAZ2QcUcx+jdwErzB34uvJkWZ7+z8AeV7IPLfU
        A1qXpnQoIUcNLVilQLYntCBTQkvvl+EoViYAf+KH45u5+CYqA8ekLSsZiL5TEEBWmEOBZGmL0Mv
        eOF1ZotD0YruBeusWDIDEKuV/
X-Received: by 2002:a17:906:e97:: with SMTP id p23mr5988029ejf.5.1618561085130;
        Fri, 16 Apr 2021 01:18:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEQDToFFHUEEo2opm0jLJTUBGGtvwpNBdE1Z7VGt/QRix5QRi/0Ktdw6vxZXSpOFAw3WghAg==
X-Received: by 2002:a17:906:e97:: with SMTP id p23mr5988008ejf.5.1618561084875;
        Fri, 16 Apr 2021 01:18:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fb.dip0.t-ipconnect.de. [91.12.100.251])
        by smtp.gmail.com with ESMTPSA id ho19sm3592014ejc.57.2021.04.16.01.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:18:03 -0700 (PDT)
Subject: Re: [PATCH v4] kernel/resource: Fix locking in
 request_free_mem_region
To:     Dan Williams <dan.j.williams@intel.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Muchun Song <smuchun@gmail.com>,
        kernel test robot <oliver.sang@intel.com>
References: <20210416025745.8698-1-apopple@nvidia.com>
 <CAPcyv4grDqR09QWv68sJY=AXMDom5MSj40nOHaE+nKP9d9qc+g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <147cc510-9c00-1ffe-bd02-60042fccf2c7@redhat.com>
Date:   Fri, 16 Apr 2021 10:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4grDqR09QWv68sJY=AXMDom5MSj40nOHaE+nKP9d9qc+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.21 06:19, Dan Williams wrote:
> On Thu, Apr 15, 2021 at 7:58 PM Alistair Popple <apopple@nvidia.com> wrote:
>>
>> request_free_mem_region() is used to find an empty range of physical
>> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
>> over the range of possible addresses using region_intersects() to see if
>> the range is free.
>>
>> region_intersects() obtains a read lock before walking the resource tree
>> to protect against concurrent changes. However it drops the lock prior
>> to returning. This means by the time request_mem_region() is called in
>> request_free_mem_region() another thread may have already reserved the
>> requested region resulting in unexpected failures and a message in the
>> kernel log from hitting this condition:
>>
>>          /*
>>           * mm/hmm.c reserves physical addresses which then
>>           * become unavailable to other users.  Conflicts are
>>           * not expected.  Warn to aid debugging if encountered.
>>           */
>>          if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
>>                  pr_warn("Unaddressable device %s %pR conflicts with %pR",
>>                          conflict->name, conflict, res);
>>
>> To fix this create versions of region_intersects() and
>> request_mem_region() that allow the caller to take the appropriate lock
>> such that it may be held over the required calls.
>>
>> Instead of creating another version of devm_request_mem_region() that
>> doesn't take the lock open-code it to allow the caller to pre-allocate
>> the required memory prior to taking the lock.
>>
>> On some architectures and kernel configurations revoke_iomem() also
>> calls resource code so cannot be called with the resource lock held.
>> Therefore call it only after dropping the lock.
> 
> The patch is difficult to read because too many things are being
> changed at once, and the changelog seems to confirm that. Can you try
> breaking this down into a set of incremental changes? Not only will
> this ease review it will distribute any regressions over multiple
> bisection targets.
> 
> Something like:
> 
> * Refactor region_intersects() to allow external locking
> * Refactor __request_region() to allow external locking
> * Push revoke_iomem() down into...
> * Fix resource_lock usage in [devm_]request_free_mem_region()

+1


-- 
Thanks,

David / dhildenb

