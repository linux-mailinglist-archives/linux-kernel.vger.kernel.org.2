Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0277F39EAB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFHAcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230266AbhFHAcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623112238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRFthXhnfNdpVeZQpXUHrCiK/YuVLkK7snUpJsmtFSw=;
        b=AODVBWLIU8SqUOmYeYAWMNjNOHFsJvwnFFIRA7cPz6FN0p97yr181PqFXBU7chp8ReQkk0
        T6n0hAlixA8bpNz6OSA+QcPbhxwr5OwnpWj2dqnvUsiT5Iw2HNrJVvKJfG3bO1iw6lefEW
        8UX/wzxH0JwL7EmF2cspFsK/UcZuvrQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-7u2nkA6POpyVgoyYOmJlQg-1; Mon, 07 Jun 2021 20:30:37 -0400
X-MC-Unique: 7u2nkA6POpyVgoyYOmJlQg-1
Received: by mail-ot1-f69.google.com with SMTP id 10-20020a9d0f0a0000b02903c030760be3so423096ott.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 17:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qRFthXhnfNdpVeZQpXUHrCiK/YuVLkK7snUpJsmtFSw=;
        b=tFItbwlM66VyjUghicuBlklHkVoMxvL7CKRM6gELXcCunyCGX6x038Wk0cnADkmV6K
         UHhps1lfXC/nT3xkGGihPy/ey3GlVhdVy20FWB5vSMmgH+yGgpsX9vZGwLr6x2n5vwsc
         JT7POoE/uPpiFN2jz22AS7+Ngu75vAUYXeS8f3/wuNAlAwcxtwtVnDj9ubnVyT8uwYrF
         3F2onrtp1gZ16ZRR5Oits2g4gYfn+jHIcQ1s6i2KqNY1rBYPqWS3SZmhY0H9odB0i9YB
         5VXOsGX5DL8Zk6frMF/6S9jHH44I85Cm3qhxnj+fxeBciixDOyM6FqEewRymrlPqVjwJ
         wT1Q==
X-Gm-Message-State: AOAM530mskW/reLee85OIl7urbnHNBI9iGsbvyG6bGd99AXNzPm5wvi6
        xClDRP5h3DHQ9nRvZkVQl2rtgSKRQ0w/cu9KoAdLHckxezQgT9Zd9jqbYgGlmIpmov+la7Fumvu
        JbQBSmT+ZDzDMQGjaBD4q0Xaf
X-Received: by 2002:a4a:d4c7:: with SMTP id r7mr15458003oos.85.1623112236845;
        Mon, 07 Jun 2021 17:30:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4eei97hBgAKcdGsumzHAwD9jcuRq8Dyz7XrNXw9xxI85L9wd4TC3u+DkEQiYQaWLvp82kXg==
X-Received: by 2002:a4a:d4c7:: with SMTP id r7mr15457984oos.85.1623112236604;
        Mon, 07 Jun 2021 17:30:36 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id v22sm2561303oic.37.2021.06.07.17.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 17:30:36 -0700 (PDT)
Date:   Mon, 7 Jun 2021 18:30:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210607183034.7665cf02.alex.williamson@redhat.com>
In-Reply-To: <20210607230353.GR1002214@nvidia.com>
References: <20210604160336.GA414156@nvidia.com>
        <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
        <20210604172207.GT1002214@nvidia.com>
        <20210604152918.57d0d369.alex.williamson@redhat.com>
        <20210604230108.GB1002214@nvidia.com>
        <20210607094148.7e2341fc.alex.williamson@redhat.com>
        <20210607181858.GM1002214@nvidia.com>
        <20210607125946.056aafa2.alex.williamson@redhat.com>
        <20210607190802.GO1002214@nvidia.com>
        <20210607134128.58c2ea31.alex.williamson@redhat.com>
        <20210607230353.GR1002214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 20:03:53 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jun 07, 2021 at 01:41:28PM -0600, Alex Williamson wrote:
> 
> > > Compatibility is important, but when I look in the kernel code I see
> > > very few places that call wbinvd(). Basically all DRM for something
> > > relavent to qemu.
> > > 
> > > That tells me that the vast majority of PCI devices do not generate
> > > no-snoop traffic.  
> > 
> > Unfortunately, even just looking at devices across a couple laptops
> > most devices do support and have NoSnoop+ set by default.    
> 
> Yes, mine too, but that doesn't mean the device is issuing nosnoop
> transactions, it just means the OS is allowing it to do so if it wants.
> 
> As I said, without driver support the feature cannot be used, and
> there is no driver support in Linux outside DRM, unless it is
> hidden.. Certainly I've never run into it..
> 
> Even mlx5 is setting the nosnoop bit, but I have a fairly high
> confidence that we don't set the TLP bit for anything Linux does.
> 
> > It's not safe for QEMU to make an assumption that only GPUs will
> > actually make use of it.  
> 
> Not 100% safe, but if you know you are running Linux OS in the VM you
> can look at the drivers the devices need and make a determination.

QEMU doesn't know what guest it's running or what driver the guest is
using.  QEMU can only create safe configurations by default, the same
as done now using vfio.  Anything outside of that scope would require
experimental opt-in support by the user or a guarantee from the device
vendor that the device cannot ever (not just for the existing drivers)
create non-coherent TLPs. Thanks,

Alex

> > Yes, QEMU can reject a hot-unplug event, but then QEMU retains the
> > privilege that the device grants it.  Releasing the device and
> > retaining the privileged gained by it seems wrong.  Thanks,  
> 
> It is not completely ideal, but it is such a simplification, and I
> can't really see a drawback..
> 
> Jason
> 

