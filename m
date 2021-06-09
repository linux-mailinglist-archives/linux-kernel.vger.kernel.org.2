Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F183A14C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhFIMsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231152AbhFIMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623242772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aV8lGXCf4JWxP5wrUtMX1uPufd4NWDA47LRUUqM3gO4=;
        b=FHlXed8RHbqcxJN1v0fYPtruwFTGVJJvT5xHBf0qR1ipKYVlQxvaWld3NEinU7jTiCUvUX
        Fa21bMAxgnadgLt7X6hLclZuTb5EzMc3REoxa7RTNRcvaUGA5EFJPdUP7pxjDWerynmKud
        r+ZT5Lcd38mkjaPAXNMgjkcMRYPOo08=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-9l3-IoFvNGmTZFvWcVTahw-1; Wed, 09 Jun 2021 08:46:11 -0400
X-MC-Unique: 9l3-IoFvNGmTZFvWcVTahw-1
Received: by mail-wr1-f71.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso10735910wrh.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 05:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aV8lGXCf4JWxP5wrUtMX1uPufd4NWDA47LRUUqM3gO4=;
        b=EvE7o6F7Af6b798OFxLEmd/ws5zLCpe5icbXPqDtBisV8RltbIB0cJd5OwT/Z4sdWb
         Jf3OSAhig0f/adY27cBH90IcR/aGt4nHmTOWJRHy+ctmLeFaDazItHYdUnmmBTlJevFz
         oyU+MZUUy6UyB6yQ6j7/NitylF8C8tACQfpyl3rKZtSazulO6vmy+rR+V3uAVcNrNS22
         a6YB6/EbdDPzg20KRrW0VnffKsmAX8+9GRGP0ciUuT/htJr5vlinuvDMOgfqrDDYiyIz
         z8YObKO/LiVL/KRR2B3FueLndjpvj5zLPonmklVW7oOB2DVr9w3q5xZOTu1ExuDQY6Hi
         R6GA==
X-Gm-Message-State: AOAM5335NQITiUiWDCZ1attcRHC8M96d8eD1UIP/UNolNGn6L5v8LgPm
        SJWk4lhUxKVpmu5zzq2i9UFC5Z6zAs/YL7tDCCGmEY+Zn82+t9UV6xzQfc/c45LewftsX6bsh2N
        BodURqxPnSCJNwWijid0QjF6B
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr8076534wmq.131.1623242770297;
        Wed, 09 Jun 2021 05:46:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzssGJ2TKM/C2YsruUldvJ4psZlR+tiJSwiHUOX3ataMRoMzZVYUZnHCu+koyMrOPAZjrC5IA==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr8076509wmq.131.1623242770063;
        Wed, 09 Jun 2021 05:46:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k12sm6167589wmr.2.2021.06.09.05.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 05:46:09 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
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
References: <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
 <MWHPR11MB18861A89FE6620921E7A7CAC8C369@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210609115759.GY1002214@nvidia.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <086ca28f-42e5-a432-8bef-ac47a0a6df45@redhat.com>
Date:   Wed, 9 Jun 2021 14:46:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609115759.GY1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/21 13:57, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 02:49:32AM +0000, Tian, Kevin wrote:
> 
>> Last unclosed open. Jason, you dislike symbol_get in this contract per
>> earlier comment. As Alex explained, looks it's more about module
>> dependency which is orthogonal to how this contract is designed. What
>> is your opinion now?
> 
> Generally when you see symbol_get like this it suggests something is
> wrong in the layering..
> 
> Why shouldn't kvm have a normal module dependency on drivers/iommu?

It allows KVM to load even if there's an "install /bin/false" for vfio 
(typically used together with the blacklist directive) in modprobe.conf. 
  This rationale should apply to iommu as well.

Paolo

