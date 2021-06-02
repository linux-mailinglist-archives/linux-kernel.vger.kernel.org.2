Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CC53984C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhFBJAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232993AbhFBJAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622624303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgwV7ft+Ln03MaD+qvV/AkL0B+iArPbUA9ahbhF+wVg=;
        b=QTSJnx4QZANKC2MFrXYT9euhRrVNbgeSmtWvBezvt4xanvqdTbszjudM7O+/7kwlZwQKhu
        ZfF8PrfdX554kqW/3QLQEGWVq+PdH4BWVXPGoqJuKJGvIJsqnmT4qzyfvpsZLuX2peDUEZ
        4Zr2KHhthRE/SX9KmS85ZL9S/H5qtHo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-ZEFxMhADMeiaD56m3t1q9g-1; Wed, 02 Jun 2021 04:58:22 -0400
X-MC-Unique: ZEFxMhADMeiaD56m3t1q9g-1
Received: by mail-pg1-f199.google.com with SMTP id s7-20020a6352470000b029021b9013c124so1255286pgl.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 01:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HgwV7ft+Ln03MaD+qvV/AkL0B+iArPbUA9ahbhF+wVg=;
        b=ZL28Igirf7Vtwfcd5RjJUmYO+HsvDXpU8tHdeB4j9SMckN64sa0jkL9/klrMvVsxZa
         9AdrgaaxJrH1Dsr4XYL5wFFuVGs9OELaXPo1G/DHT8qYGOfzZpAjou8hvsLSSa6zAz8s
         +qfy/zIso1fpqHXz04ihHhycumqdU/DpYK03K+08fi8U9spOsNVcaaA7sUz+xIiIKjsm
         qgfNyVH/vH+oxoyTZQre/VwmNvLyRrm8YWe8MGHnuY/B+Ayf9yzYcXYLOdFWvoJtW9sb
         gkVdoCIy+ydgSvCQuVPf71NltYi6itCxZluvlMRKHeNbYlhAiKRA6CMfKZIjRtKD7oc4
         r1+Q==
X-Gm-Message-State: AOAM532gL6jlUKJvlWC9MjX68akwRagsV9bGP+lODSphinQdFT12zsfb
        jEP/TilgyNVhuBnbKv3EZ3VZbWoku568RFFImemyHAxfMNJoBjzvOpFtx42VTGlLsIoWHhEIFkU
        LpP4fNDYyZDCRc+vYN8gIXe4G
X-Received: by 2002:a63:e642:: with SMTP id p2mr31912919pgj.316.1622624301197;
        Wed, 02 Jun 2021 01:58:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/hC2DUGaHASQJ2eBIgS4POmbF/OU0iTy4EElTI9I8lf554Diw4PoXXYk+RPG+3MuIoH1a7g==
X-Received: by 2002:a63:e642:: with SMTP id p2mr31912901pgj.316.1622624301050;
        Wed, 02 Jun 2021 01:58:21 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m134sm4163818pfd.148.2021.06.02.01.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 01:58:20 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Liu Yi L <yi.l.liu@linux.intel.com>,
        "Alex Williamson (alex.williamson@redhat.com)\"\"" 
        <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <20210601172956.GL1002214@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d8bb795f-8d73-e9a5-a4b1-8d9c563dffbd@redhat.com>
Date:   Wed, 2 Jun 2021 16:58:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601172956.GL1002214@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/2 ÉÏÎç1:29, Jason Gunthorpe Ð´µÀ:
> On Tue, Jun 01, 2021 at 02:07:05PM +0800, Jason Wang wrote:
>
>> For the case of 1M, I would like to know what's the use case for a single
>> process to handle 1M+ address spaces?
> For some scenarios every guest PASID will require a IOASID ID # so
> there is a large enough demand that FDs alone are not a good fit.
>
> Further there are global container wide properties that are hard to
> carry over to a multi-FD model, like the attachment of devices to the
> container at the startup.


So if we implement per fd model. The global "container" properties could 
be done via the parent fd. E.g attaching the parent to the device at the 
startup.


>
>>> So this RFC treats fd as a container of address spaces which is each
>>> tagged by an IOASID.
>> If the container and address space is 1:1 then the container seems useless.
> The examples at the bottom of the document show multiple IOASIDs in
> the container for a parent/child type relationship


This can also be done per fd? A fd parent can have multiple fd childs.

Thanks


>
> Jason
>

