Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB639F80C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhFHNq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233045AbhFHNqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623159870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5paOCX7lF4w7/DDN73q8qlAZey0BD12yaLQLY3fG8Y=;
        b=OgVbcMjuLZxP/Q38FMVw8iDIel+vGOS38pVWmZMGt+1MJb3d1iopbsogUv9k3ONEXYJGpP
        sI0LdfqG1BRchVtJGFx7uVUg0qpvINw/dKVYUdYhAczJ/eJHx1CvyVxM0c9dU/DVmnr1zX
        op8V94r4MJfsKp3+wOHeZdauVboqBSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-vfFkY067MX2hnr8s37ctSw-1; Tue, 08 Jun 2021 09:44:29 -0400
X-MC-Unique: vfFkY067MX2hnr8s37ctSw-1
Received: by mail-wm1-f71.google.com with SMTP id 128-20020a1c04860000b0290196f3c0a927so1269587wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 06:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5paOCX7lF4w7/DDN73q8qlAZey0BD12yaLQLY3fG8Y=;
        b=IDb3xgEzf74odj5fdAcv4aeyeEUND1VctyKCcfzbOBJLJsZgOKQnArOsvzyzKLC+fB
         hADoGVlizj5eE4k9nW0Hsc/IQXH2zKRKYYL/ZJ/edvBKVuNoXBuHevu0qU4N2sb+1etL
         DChKhp50igjkM+T2S0zZU/0ODT/OqP8VVqfEQLsg3Vii2eiroiZ4jGew8KQB6H8PeE2C
         R1/qPtCNhDegryHl0uoNxlKIFJZc6dPnIZNVt4yUYNj1Jr8C/XVv6Y7DJUAhChF2AGyE
         EP2lMf9oie2IV09hJIKlh/FoPTyubV2QCEHJuOEh4hGnlubq/rdvjkmo1j4pyndnC8LG
         KqqQ==
X-Gm-Message-State: AOAM531XpGHQaVIBhERzYUW1hUROCy1uypEw7v8MAA7VKlucvVY8s5Qe
        ltno8mU/N4Yhe+/0qh/sX5YBOekMdBaXt0nlUDalGc5pm/soiDJrGa0xMCGufoGHeyD3V09NUgB
        Mk5IpZPA3xpqh8N3Mm7T/IW7w
X-Received: by 2002:a1c:770b:: with SMTP id t11mr4365983wmi.79.1623159868318;
        Tue, 08 Jun 2021 06:44:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ4k7LKRkmCCY0f1XvUXyPaQaBTTeWBOUxIheggqPU28l8+khIBLNZhCQK0mJgXqCT2XApuw==
X-Received: by 2002:a1c:770b:: with SMTP id t11mr4365974wmi.79.1623159868149;
        Tue, 08 Jun 2021 06:44:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o17sm19012181wrp.47.2021.06.08.06.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 06:44:27 -0700 (PDT)
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
References: <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
Date:   Tue, 8 Jun 2021 15:44:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210608131547.GE1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/21 15:15, Jason Gunthorpe wrote:
> On Tue, Jun 08, 2021 at 09:56:09AM +0200, Paolo Bonzini wrote:
> 
>>>> Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of ioctls. But it
>>>> seems useless complication compared to just using what we have now, at least
>>>> while VMs only use IOASIDs via VFIO.
>>>
>>> The simplest is KVM_ENABLE_WBINVD(<fd security proof>) and be done
>>> with it.
>>
>> The simplest one is KVM_DEV_VFIO_GROUP_ADD/DEL, that already exists and also
>> covers hot-unplug.  The second simplest one is KVM_DEV_IOASID_ADD/DEL.
> 
> This isn't the same thing, this is back to trying to have the kernel
> set policy for userspace.

If you want a userspace policy then there would be three states:

* WBINVD enabled because a WBINVD-enabled VFIO device is attached.

* WBINVD potentially enabled but no WBINVD-enabled VFIO device attached

* WBINVD forcefully disabled

KVM_DEV_VFIO_GROUP_ADD/DEL can still be used to distinguish the first 
two.  Due to backwards compatibility, those two describe the default 
behavior; disabling wbinvd can be done easily with a new sub-ioctl of 
KVM_ENABLE_CAP and doesn't require any security proof.

The meaning of WBINVD-enabled is "won't return -ENXIO for the wbinvd 
ioctl", nothing more nothing less.  If all VFIO devices are going to be 
WBINVD-enabled, then that will reflect on KVM as well, and I won't have 
anything to object if there's consensus on the device assignment side of 
things that the wbinvd ioctl won't ever fail.

Paolo

