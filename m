Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6849F39B052
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFDCWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhFDCWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622773258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDGv4Dsoaj8jObcKvFWN7acvR7gAGphvCAjFAd+6RyQ=;
        b=FJp6REi/xSKMatkDREO+fVptMGxcIVHeMcNLaPk1SzwPs38HVuhQgc1oqKT4YWTeKnFSs7
        4R82mkvZyxO8df5RTXVGR51hbdBJvLhj41JFJP1bGfvFFKea73r8sJeHAUhVsE1Rth3QiJ
        vfynEMbHz+VAP+kFHM/+h3cFMRQU1xQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-ISyaB5nUNAmzV2FyKnWNNQ-1; Thu, 03 Jun 2021 22:20:57 -0400
X-MC-Unique: ISyaB5nUNAmzV2FyKnWNNQ-1
Received: by mail-pf1-f197.google.com with SMTP id g144-20020a6252960000b029023d959faca6so4508286pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 19:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sDGv4Dsoaj8jObcKvFWN7acvR7gAGphvCAjFAd+6RyQ=;
        b=FKKC9pDOpVWFWG60EE0mB/RcT7yglaRVlhdHaGMmKWyw9tU+IAWztGFk3nHakJ2b++
         OUhZUT7toLD9gMC0IaXIseLTeU9Kcf/+fISfIeBP71XXWQfHcCE8swtLv69cXe/a2811
         SmNDCw7CkjeQlOchRdxIBHME6C7dp0G10wq1fyC8Mcw9g4EBbUCWbUw3fYoQynFJZt1V
         KraDzw6CIReL4P+lWXw6hV2/b8eDRz+y6qx2vU98g0YNP0Hjw91OAJ1ahXAW0iwsUYnS
         i0HMP21ZQSJ5JCPf0pv134TSRCwRQpwLGugPREoYS1YhcBHoRlOhU+ounPt7UhasSgMQ
         U32w==
X-Gm-Message-State: AOAM532M1SvbekUWWf+N7ZIm0J6sXC9QYixxxft2EjHkk2jMhr+33ADx
        ian84hQjLrQLFROptE2SbmMune+n+Y5i99valiiT6nBT5yRGz6dguIqvDEvWoRbrLzqGbls6g58
        fZ4gxq8NGLR6+CGrmyGkO1w44gnWkhhrLUd/iToolZGvTlFT1zYWLV/ZABINzFSLhQHZYbnSRt4
        oo
X-Received: by 2002:aa7:838b:0:b029:2ea:3332:dd8a with SMTP id u11-20020aa7838b0000b02902ea3332dd8amr2148791pfm.74.1622773256509;
        Thu, 03 Jun 2021 19:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjTyiNdr0vKw5aLMjZR3pSm0SArLP4gxhX2YoZbSOpAlakHJNckWN9VSGFZvB4i3+IOypGbA==
X-Received: by 2002:aa7:838b:0:b029:2ea:3332:dd8a with SMTP id u11-20020aa7838b0000b02902ea3332dd8amr2148764pfm.74.1622773256185;
        Thu, 03 Jun 2021 19:20:56 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y4sm294909pfg.112.2021.06.03.19.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 19:20:55 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <80df3032-3775-b2c1-f3e6-91eb459df620@redhat.com>
Date:   Fri, 4 Jun 2021 10:20:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/4 上午1:33, Andy Lutomirski 写道:
> On 6/2/21 5:41 PM, Andi Kleen wrote:
>> Only allow split mode when in a protected guest. Followon
>> patches harden the split mode code paths, and we don't want
>> an malicious host to force anything else. Also disallow
>> indirect mode for similar reasons.
> I read this as "the virtio driver is buggy.  Let's disable most of the
> buggy code in one special case in which we need a driver without bugs.
> In all the other cases (e.g. hardware virtio device connected over
> USB-C), driver bugs are still allowed."
>
> Can we just fix the driver without special cases?


I think we can, this is what this series tries to do:

https://www.spinics.net/lists/kvm/msg241825.html

It tries to fix without a special caring for any specific features.

Thanks



>
> --Andy
>

