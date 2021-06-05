Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F6C39C631
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFEGYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbhFEGYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622874152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvsAQtJxlvGYxKy6a0thmzjRiqSNuCzh2tI1IIgfJ74=;
        b=KYrtfsjnBqB3FVMPJmzOegQoRkF5boDhkxr7p/VfDd6mvz976+PQQJdrKuumFv9mwyAdzb
        ulCuqdN96BG8aw3VZdizbDPHsGohSfoGQoKxjoAXkj96xZvSexfBQuqpa4xYzghJVKgFgt
        v+lIhz8P6Esaae5kEuvV26Nw8LhNH8I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-2VN1RdJyMVWrgMrEanzdqg-1; Sat, 05 Jun 2021 02:22:30 -0400
X-MC-Unique: 2VN1RdJyMVWrgMrEanzdqg-1
Received: by mail-ed1-f69.google.com with SMTP id f12-20020a056402150cb029038fdcfb6ea2so6321095edw.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 23:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvsAQtJxlvGYxKy6a0thmzjRiqSNuCzh2tI1IIgfJ74=;
        b=QWqwiS3PTNiiGNVpzsxSfWdZ3OY2OF6qOQtdWTm5bp8tsnwYyCGJ5Q8ckltivJZpIa
         r5JoXff8qwE+LMbaq5ZeBmyPhK7YCE7IEl2Jjp5N06+X4+VJBbGZsylhpwZePz+mwBtJ
         LMZKHKUSJEk1oJS8pX7jYsNl/BjvP4RPe6TLCWiZA41Gr9irx7uAoRsZNHC2SUgirI0N
         SUuV0NFAi0H1FQ3++Fs70GwO0mHT+v8jEWEpFflZoe7HTYIidDbZI1QOczLHQ+woK7ns
         QUyvdlHdxopPK3tyj8s4Adca+szID/A1DdCXf2bws+jFBR+rqvGtwZxLxfB2oYOHz6Dq
         WeIg==
X-Gm-Message-State: AOAM5337V+scNWhucuqNUqN9pyCDJn9xNgOAWGZXw3OkboGrCZX9csWg
        tfH9GvSoqzpwCr2/+s8/iW0w4wKyyemw+x71JOZ/RgbVV+yuQ78Ta74HHoUYnM6ougj0EEhmcNg
        d55JM3VSmKS8sM5obdDfYVGTV
X-Received: by 2002:a05:6402:2317:: with SMTP id l23mr8829084eda.265.1622874149500;
        Fri, 04 Jun 2021 23:22:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK49j50iCoLz8VXH//DU+8dprCuzL/LFKrh/1Hkw7FIj9PlE8uSbie4kS68iqbJU9lm7EMQg==
X-Received: by 2002:a05:6402:2317:: with SMTP id l23mr8829061eda.265.1622874149296;
        Fri, 04 Jun 2021 23:22:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id cx7sm4246774edb.65.2021.06.04.23.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 23:22:28 -0700 (PDT)
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
References: <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
Date:   Sat, 5 Jun 2021 08:22:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604172207.GT1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/21 19:22, Jason Gunthorpe wrote:
>   4) The KVM interface is the very simple enable/disable WBINVD.
>      Possessing a FD that can do IOMMU_EXECUTE_WBINVD is required
>      to enable WBINVD at KVM.

The KVM interface is the same kvm-vfio device that exists already.  The 
userspace API does not need to change at all: adding one VFIO file 
descriptor with WBINVD enabled to the kvm-vfio device lets the VM use 
WBINVD functionality (see kvm_vfio_update_coherency).

Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of ioctls. 
But it seems useless complication compared to just using what we have 
now, at least while VMs only use IOASIDs via VFIO.

Either way, there should be no policy attached to the add/delete 
operations.  KVM users want to add the VFIO (or IOASID) file descriptors 
to the device independent of WBINVD.  If userspace wants/needs to apply 
its own policy on whether to enable WBINVD or not, they can do it on the 
VFIO/IOASID side:

>  1) When the device is attached to the IOASID via VFIO_ATTACH_IOASID
>     it communicates its no-snoop configuration:
>      - 0 enable, allow WBINVD
>      - 1 automatic disable, block WBINVD if the platform
>        IOMMU can police it (what we do today)
>      - 2 force disable, do not allow BINVD ever

Though, like Alex, it's also not clear to me whether force-disable is 
useful.  Instead userspace can query the IOMMU or the device to ensure 
it's not enabled.

Paolo

