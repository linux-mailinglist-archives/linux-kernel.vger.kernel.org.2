Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A1B396CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhFAFKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhFAFKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622524137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0ge9eI66wPcsIxgT0s5YZb/3xhZpxQFY4I1oaBiwpo=;
        b=A0BPUMnf1QFCOELFyELvHchU4my+82Cy4vm/2ofEYXbVTstnOUOechVbuIIUsqYa35G2Ie
        lCkMppHERXo76f5r51p2BcyLTLHVhNnxolLw2i5szPz5WvqlPiWPS9Rk4o/lfamMOtno/b
        mq8/UF3CJYng9nn7YvkXrBAoORk3Yus=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-nK3I2_TWP-6ooB3_ThfoTg-1; Tue, 01 Jun 2021 01:08:37 -0400
X-MC-Unique: nK3I2_TWP-6ooB3_ThfoTg-1
Received: by mail-pj1-f71.google.com with SMTP id k1-20020a17090a7f01b029015d0d4c2107so6332793pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 22:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T0ge9eI66wPcsIxgT0s5YZb/3xhZpxQFY4I1oaBiwpo=;
        b=RzF2f4yw4i0n0HrU808/dk6v3wwhsGDiDg33wz+uPTK7oRBhlq//q4/F1KvQAt51uL
         Es1DZy9A+sbQEYhCeGHSIoPI0V3xTkiCJnD7rZ8vav/pbDTQduuVVJ3GNIR5jcEz90yF
         XcANuu6NHWod7aKh03FigzgGrBu3aLRpkEkSGLdUqJ/ZP0cNZ9EGhJese2s7dvkjP7ot
         DYlPXCMIzYVni+8ICLBJT7bOfWUQdkZiCx5cuGKnITqSdEZ7obNzkanKlSRndDJ/w6uT
         lTR1JM9THCnTKA/CJt0Cpcd9zUXvcDqr0LRk9SZsYlSZJrsd5KcByep6K46aKdiYBw4d
         PbEg==
X-Gm-Message-State: AOAM531NSZAPNkzhqrZmotNxvBU+s5VQUJzK5tQxcMxxnv/2gWraurps
        aLz8xEO9WstFScRS/VMFXyO71qBTPT+Bh74DZaLDyeyRdNlIWAzcdR5SIvaORLPPg0DL9hvJTZh
        qCqky3QyxikGJZTy0mVEAom2K
X-Received: by 2002:a17:902:6908:b029:f7:cbad:c07a with SMTP id j8-20020a1709026908b02900f7cbadc07amr24232995plk.2.1622524116010;
        Mon, 31 May 2021 22:08:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOw8eLgbeF/Ld10BQ267ECPLF2AMYqOh2mlgGe5FRchSRMetTlx3IsfoCHw/xZOMqR2DD4kg==
X-Received: by 2002:a17:902:6908:b029:f7:cbad:c07a with SMTP id j8-20020a1709026908b02900f7cbadc07amr24232965plk.2.1622524115712;
        Mon, 31 May 2021 22:08:35 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x22sm4713384pfn.10.2021.05.31.22.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 22:08:35 -0700 (PDT)
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
        "Alex Williamson (alex.williamson@redhat.com)\"\"" 
        <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
Date:   Tue, 1 Jun 2021 13:08:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601113152.6d09e47b@yiliu-dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/1 上午11:31, Liu Yi L 写道:
> On Tue, 1 Jun 2021 10:36:36 +0800, Jason Wang wrote:
>
>> 在 2021/5/31 下午4:41, Liu Yi L 写道:
>>>> I guess VFIO_ATTACH_IOASID will fail if the underlayer doesn't support
>>>> hardware nesting. Or is there way to detect the capability before?
>>> I think it could fail in the IOASID_CREATE_NESTING. If the gpa_ioasid
>>> is not able to support nesting, then should fail it.
>>>   
>>>> I think GET_INFO only works after the ATTACH.
>>> yes. After attaching to gpa_ioasid, userspace could GET_INFO on the
>>> gpa_ioasid and check if nesting is supported or not. right?
>>
>> Some more questions:
>>
>> 1) Is the handle returned by IOASID_ALLOC an fd?
> it's an ID so far in this proposal.


Ok.


>
>> 2) If yes, what's the reason for not simply use the fd opened from
>> /dev/ioas. (This is the question that is not answered) and what happens
>> if we call GET_INFO for the ioasid_fd?
>> 3) If not, how GET_INFO work?
> oh, missed this question in prior reply. Personally, no special reason
> yet. But using ID may give us opportunity to customize the management
> of the handle. For one, better lookup efficiency by using xarray to
> store the allocated IDs. For two, could categorize the allocated IDs
> (parent or nested). GET_INFO just works with an input FD and an ID.


I'm not sure I get this, for nesting cases you can still make the child 
an fd.

And a question still, under what case we need to create multiple ioasids 
on a single ioasid fd?

(This case is not demonstrated in your examples).

Thanks


>
>>>   
>>>>> 	/* Bind guest I/O page table  */
>>>>> 	bind_data = {
>>>>> 		.ioasid	= giova_ioasid;
>>>>> 		.addr	= giova_pgtable;
>>>>> 		// and format information
>>>>> 	};
>>>>> 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
>>>>>
>>>>> 	/* Invalidate IOTLB when required */
>>>>> 	inv_data = {
>>>>> 		.ioasid	= giova_ioasid;
>>>>> 		// granular information
>>>>> 	};
>>>>> 	ioctl(ioasid_fd, IOASID_INVALIDATE_CACHE, &inv_data);
>>>>>
>>>>> 	/* See 5.6 for I/O page fault handling */
>>>>> 	
>>>>> 5.5. Guest SVA (vSVA)
>>>>> ++++++++++++++++++
>>>>>
>>>>> After boots the guest further create a GVA address spaces (gpasid1) on
>>>>> dev1. Dev2 is not affected (still attached to giova_ioasid).
>>>>>
>>>>> As explained in section 4, user should avoid expose ENQCMD on both
>>>>> pdev and mdev.
>>>>>
>>>>> The sequence applies to all device types (being pdev or mdev), except
>>>>> one additional step to call KVM for ENQCMD-capable mdev:
>>>> My understanding is ENQCMD is Intel specific and not a requirement for
>>>> having vSVA.
>>> ENQCMD is not really Intel specific although only Intel supports it today.
>>> The PCIe DMWr capability is the capability for software to enumerate the
>>> ENQCMD support in device side. yes, it is not a requirement for vSVA. They
>>> are orthogonal.
>>
>> Right, then it's better to mention DMWr instead of a vendor specific
>> instruction in a general framework like ioasid.
> good suggestion. :)
>

