Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823F239AF9C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhFDBYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFDBYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622769773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiiEtVElMgCs593JVIVumZLvj+RIl3xZvMt3+bseh5s=;
        b=UZGEFjujhD+8cDGF19bMTsF/waadFYiEjwgtsGSKPtckBOOpbrYkHGHFoCfn6S1efBEcs0
        icscgBcfccfQZsTL3MZ4+TcFZNwSh8Jsc8DNZew4QF0qbgUflUkHKan7Co/ifJ5gDqPuiP
        QzcpsIU/yGKZLNbVVjyeMZkF3CJYJY4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-Xd7xZOJRPOugNkXryYETRg-1; Thu, 03 Jun 2021 21:22:52 -0400
X-MC-Unique: Xd7xZOJRPOugNkXryYETRg-1
Received: by mail-pf1-f197.google.com with SMTP id g144-20020a6252960000b029023d959faca6so4429409pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 18:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AiiEtVElMgCs593JVIVumZLvj+RIl3xZvMt3+bseh5s=;
        b=AFbWF3/wumpxoT3+WB44XTc1eKS4Bd45xSxEjRjlrs4cyKAoutII4nG5p9pbGMnbFf
         bB61MdoU45aFA4GmTcIalaAb4So6/iWR9BSv2wNfMUZtyYKtCvMEVBLkrIuwJeg/H5tD
         k5xkEehaRAVu3+FumqtwGa7zLJcllA4E08tFqq6A2LvQX7ed6kDC4+vJouR2HFqfjzT5
         JXZrrsVwuhzItdI5pBZCoOdTTk0n0Ow8zgb0m36A7t/HknOVQA7taSMw7FXXJMIMi/DN
         n5ugei3kZBYD2J0Wv+wOiaVcb/CNI12zrmXp53eORiJjOnCBgyFzzsLCgaUQbWzmkRLB
         bc+w==
X-Gm-Message-State: AOAM532HdCkUd0FqoG/gTFVbB7DLCDWzeoG+wRrLf8CiF8OIYXHUnd11
        4yjy1yzuDl6Sx3rx9oyqPm7o/7Jjm2Dkb5c9PhxIYESaIBUrTWQumyLO1+wH7qYfLqhygwht6LY
        /HRoXsA/t/bfixFyBwb7VT9EaBpzU5aF1pECRJMK3UUtHs+4AB9Hm2b6R1JvQojyw2vinwoWVJg
        Nl
X-Received: by 2002:aa7:8a5a:0:b029:2ec:7134:7540 with SMTP id n26-20020aa78a5a0000b02902ec71347540mr2069655pfa.66.1622769771440;
        Thu, 03 Jun 2021 18:22:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8I13DZmKGfIc2huzbd5KLYaSyAe/mhYmV3rOnMwUy40nEmTkBCn9htxKDX0fkN/UX8S97Dg==
X-Received: by 2002:aa7:8a5a:0:b029:2ec:7134:7540 with SMTP id n26-20020aa78a5a0000b02902ec71347540mr2069623pfa.66.1622769771073;
        Thu, 03 Jun 2021 18:22:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k17sm232575pff.66.2021.06.03.18.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 18:22:50 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9e842353-fec7-667e-8b76-61dbb092f0d8@redhat.com>
Date:   Fri, 4 Jun 2021 09:22:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/4 上午3:31, Andy Lutomirski 写道:
>
> On Thu, Jun 3, 2021, at 11:00 AM, Andi Kleen wrote:
>> On 6/3/2021 10:33 AM, Andy Lutomirski wrote:
>>> On 6/2/21 5:41 PM, Andi Kleen wrote:
>>>> Only allow split mode when in a protected guest. Followon
>>>> patches harden the split mode code paths, and we don't want
>>>> an malicious host to force anything else. Also disallow
>>>> indirect mode for similar reasons.
>>> I read this as "the virtio driver is buggy.  Let's disable most of the
>>> buggy code in one special case in which we need a driver without bugs.
>>> In all the other cases (e.g. hardware virtio device connected over
>>> USB-C), driver bugs are still allowed."
>> My understanding is most of the other modes (except for split with
>> separate descriptors) are obsolete and just there for compatibility. As
>> long as they're deprecated they won't harm anyone.
>>
>>
> Tell that to every crypto downgrade attack ever.
>
> I see two credible solutions:
>
> 1. Actually harden the virtio driver.
>
> 2. Have a new virtio-modern driver and use it for modern use cases. Maybe rename the old driver virtio-legacy or virtio-insecure.  They can share code.


Note that we had already split legacy driver out which can be turned off 
via Kconfig.


>
> Another snag you may hit: virtio’s heuristic for whether to use proper DMA ops or to bypass them is a giant kludge. I’m very slightly optimistic that getting the heuristic wrong will make the driver fail to operate but won’t allow the host to take over the guest, but I’m not really convinced. And I wrote that code!  A virtio-modern mode probably should not have a heuristic, and the various iommu-bypassing modes should be fixed to work at the bus level, not the device level.


I remember there's a very long discussion about this and probably 
without any conclusion. Fortunately, the management layer has been 
taught to enforce VIRTIO_F_ACCESS_PLATFORM for encrypted guests.

A possible way to fix this is without any conflicts is to mandate the 
VIRTIO_F_ACCESS_PLATFORM in version 1.2.

Thanks


>

