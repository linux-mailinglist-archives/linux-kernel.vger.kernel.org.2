Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3939BC5D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFDP7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231285AbhFDP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622822244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VeXpVaVm3Sgm4ExODkCf4+TTdsJEk4SxRvRR3xCWPQ=;
        b=UYQ9C9jupD4UXP/KA1trOe4ynHhNVxkTynCMl+wIZmtmhKGG1N8jWSdPU5cJY/EYWaf/IY
        lAvL4kv0922yMaKRo9PeIjiK5EkCTdvFbCcazo3sPgS7lXKbsfFsOxC3LKJhRC+Qz12F/T
        xsESKvHOR21vSu7LshFh9csRDCv+tU8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-qAffpp37NlCntqb5QNxiEw-1; Fri, 04 Jun 2021 11:57:23 -0400
X-MC-Unique: qAffpp37NlCntqb5QNxiEw-1
Received: by mail-ed1-f70.google.com with SMTP id df3-20020a05640230a3b029039179c0f290so3509805edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4VeXpVaVm3Sgm4ExODkCf4+TTdsJEk4SxRvRR3xCWPQ=;
        b=RQtr2vMl3XeA3F7E0Vv/var0APUwCs5ZZo0fEVmBGPjeBuEkj2P0mvRWOYjYkLhbIM
         mvtTct8jRCi+bpOJiQyPu3uHJvoMheOoDWBAjiJ2EopFa3i0+79qK+qvtfa2z1DNkcsr
         YiHh3qVWR0tVdMwtZfB2YdpvJG8w8jH70fDH74FoREuYZ9TW/onvGGoHFMWDddhMM/XI
         Yvd564pc0ykDpWbBdXN6zbFadVKPr4JhqrDInQcnfa+sDe6d0bcieWV+53z1ADEwRYR7
         HIzlMMyN8Fn0mwVGbLS1lEAU1wKIitRCNDB3lDREIFlx7EcJjP56sifSgaVpk0i7hQUj
         8aiw==
X-Gm-Message-State: AOAM5317paoGQEgGgHiKtPvGeA57JUFnY7W798ivSgaCFKfNGVUuWbOB
        D3hiz3ehjAj9MZFJ+i13RU8H7BAn/1tPsf3BK86bVSVjz9LHlK/jQXVfM33bHVGDQhSMwWAc2en
        NWXNldNf/ddFM0wP0l2Szjbm/
X-Received: by 2002:a17:907:1b11:: with SMTP id mp17mr4825430ejc.1.1622822242027;
        Fri, 04 Jun 2021 08:57:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPRjcRc6XoOVz7KqxGJ8Jr4Ru7H/KBEWYfYYsX/zRmiAg3G+v0VaBWdVmTVXEoxLZyb0lcDw==
X-Received: by 2002:a17:907:1b11:: with SMTP id mp17mr4825416ejc.1.1622822241873;
        Fri, 04 Jun 2021 08:57:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p13sm2917846ejr.87.2021.06.04.08.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 08:57:21 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
References: <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <20210603123401.GT1002214@nvidia.com>
 <20210603140146.5ce4f08a.alex.williamson@redhat.com>
 <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
Date:   Fri, 4 Jun 2021 17:57:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604155016.GR1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/21 17:50, Jason Gunthorpe wrote:
>> Extending the scenarios where WBINVD is not a nop is not a problem for me.
>> If possible I wouldn't mind keeping the existing kvm-vfio connection via the
>> device, if only because then the decision remains in the VFIO camp (whose
>> judgment I trust more than mine on this kind of issue).
> Really the question to answer is what "security proof" do you want
> before the wbinvd can be enabled

I don't want a security proof myself; I want to trust VFIO to make the 
right judgment and I'm happy to defer to it (via the KVM-VFIO device).

Given how KVM is just a device driver inside Linux, VMs should be a 
slightly more roundabout way to do stuff that is accessible to bare 
metal; not a way to gain extra privilege.

Paolo

>   1) User has access to a device that can issue no-snoop TLPS
>   2) User has access to an IOMMU that can not block no-snoop (today)
>   3) Require CAP_SYS_RAW_IO
>   4) Anyone
> 
> #1 is an improvement because it allows userspace to enable wbinvd and
> no-snoop optimizations based on user choice
> 
> #2 is where we are today and wbinvd effectively becomes a fixed
> platform choice. Userspace has no say
> 
> #3 is "there is a problem, but not so serious, root is powerful
>     enough to override"

