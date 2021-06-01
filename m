Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC79396B72
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhFACib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232625AbhFACia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622515009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/vNKwMKD4yXShKjN11l9IaBWHIc+94yjI5sIegf+Rs=;
        b=OBAwwawgVnJKw6NQa/JNZGM3/zbIzbHi2/mM3viUw8+gSvHW0V9SDsapStzCjpLN0hgVZy
        UMaY8Brxm1w/GzWXP5Gf7Q3VQvighMuGnQNccifpnaqKfxPXsrjmQsm/ZMyr5uJ6kcZ7iV
        /Sb1h5Z6ARLGKjOEg6rqHg1j2Z/dulc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-DYsy1e4kN-axVExRZbhlpA-1; Mon, 31 May 2021 22:36:47 -0400
X-MC-Unique: DYsy1e4kN-axVExRZbhlpA-1
Received: by mail-pj1-f71.google.com with SMTP id f15-20020a17090aa78fb029015c411f061bso1030064pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R/vNKwMKD4yXShKjN11l9IaBWHIc+94yjI5sIegf+Rs=;
        b=S5dyPQPQsghpP+8iRiBxxEzG045FeAd5vpEgYSCFmjii3P72fbIZj7EK3ZboWRJssI
         gtPu5bCGqfNVpEjndKNHuLuN0c+Mrtt3nwJCHxWWP+uxqaKF0a0ks5L9p+BEhoMNEs8p
         zsF9wu4Z4BbtG7TmHw/qSMWPQ6AlQCWQ7UQxnqCPZ8t+XEqq5l4xoozgzDDb7e8c2fCe
         4LA/5TMkAZcco9Ny/Kjbgy6MlvfHoDomDgyvrrExodhpzR0ZLP+NuHfqMor9Cb93ON0b
         vKv1R9hiAaSmFtjMbOXyXLyJ1zprjsj40L1ieLhrZuR2o3L641mtYE6SMC6ppwabDYqE
         IlJA==
X-Gm-Message-State: AOAM532ZnvxEM+tTVuKBR3HF9AucY39gRuZxtqKsnh4uM/kdAiDWWy/T
        nk5Lj3CZEQOMwaJPDWml1uWjeRrKEJ6q6pPYPvKQ1pTKdtHxC1o1VxIaBEoTubemPN7DHFuD81H
        aCjqwcHYAFbp9E1FyIdai0z+G
X-Received: by 2002:a17:90a:588f:: with SMTP id j15mr1033509pji.112.1622515006581;
        Mon, 31 May 2021 19:36:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPDXYinpNeWXLQoK98eNSiwNXoeGiMTG9/9gXFH9CKUekKLqJYBGdJOueFprZDJGgzAlaU8A==
X-Received: by 2002:a17:90a:588f:: with SMTP id j15mr1033494pji.112.1622515006334;
        Mon, 31 May 2021 19:36:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p14sm13530139pgb.2.2021.05.31.19.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 19:36:45 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     Liu Yi L <yi.l.liu@linux.intel.com>
Cc:     yi.l.liu@intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Alex Williamson (alex.williamson@redhat.com)\"" 
        <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
Date:   Tue, 1 Jun 2021 10:36:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531164118.265789ee@yiliu-dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/31 下午4:41, Liu Yi L 写道:
>> I guess VFIO_ATTACH_IOASID will fail if the underlayer doesn't support
>> hardware nesting. Or is there way to detect the capability before?
> I think it could fail in the IOASID_CREATE_NESTING. If the gpa_ioasid
> is not able to support nesting, then should fail it.
>
>> I think GET_INFO only works after the ATTACH.
> yes. After attaching to gpa_ioasid, userspace could GET_INFO on the
> gpa_ioasid and check if nesting is supported or not. right?


Some more questions:

1) Is the handle returned by IOASID_ALLOC an fd?
2) If yes, what's the reason for not simply use the fd opened from 
/dev/ioas. (This is the question that is not answered) and what happens 
if we call GET_INFO for the ioasid_fd?
3) If not, how GET_INFO work?


>
>>> 	/* Bind guest I/O page table  */
>>> 	bind_data = {
>>> 		.ioasid	= giova_ioasid;
>>> 		.addr	= giova_pgtable;
>>> 		// and format information
>>> 	};
>>> 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
>>>
>>> 	/* Invalidate IOTLB when required */
>>> 	inv_data = {
>>> 		.ioasid	= giova_ioasid;
>>> 		// granular information
>>> 	};
>>> 	ioctl(ioasid_fd, IOASID_INVALIDATE_CACHE, &inv_data);
>>>
>>> 	/* See 5.6 for I/O page fault handling */
>>> 	
>>> 5.5. Guest SVA (vSVA)
>>> ++++++++++++++++++
>>>
>>> After boots the guest further create a GVA address spaces (gpasid1) on
>>> dev1. Dev2 is not affected (still attached to giova_ioasid).
>>>
>>> As explained in section 4, user should avoid expose ENQCMD on both
>>> pdev and mdev.
>>>
>>> The sequence applies to all device types (being pdev or mdev), except
>>> one additional step to call KVM for ENQCMD-capable mdev:
>> My understanding is ENQCMD is Intel specific and not a requirement for
>> having vSVA.
> ENQCMD is not really Intel specific although only Intel supports it today.
> The PCIe DMWr capability is the capability for software to enumerate the
> ENQCMD support in device side. yes, it is not a requirement for vSVA. They
> are orthogonal.


Right, then it's better to mention DMWr instead of a vendor specific 
instruction in a general framework like ioasid.

Thanks


>

