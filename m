Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F230E39EB3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhFHBMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230382AbhFHBMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623114654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ble1OdVWSdUFgnj3SJybSz6FbcPfrGdp/yR5UPi1dnM=;
        b=AGe7Fw91N1N6Q9oa+tcu78UcGYNg4ht+CpaAlYW6REyw25JrB4NW5BROsVqDwwDz/9IJOz
        yLyftKoO3r/Egxi1AP0jiqPYh7Y/1kQ4//ag0tQ2BFNXKn+Hq13IYaZD7Fi/IL3W1BNF+A
        UaCtiVFLanXtrmgMoPLhqrFYl8Cfe7E=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-FAMCA4hUPH6SbZuCiEyXzg-1; Mon, 07 Jun 2021 21:10:53 -0400
X-MC-Unique: FAMCA4hUPH6SbZuCiEyXzg-1
Received: by mail-pf1-f197.google.com with SMTP id g144-20020a6252960000b029023d959faca6so8613014pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 18:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ble1OdVWSdUFgnj3SJybSz6FbcPfrGdp/yR5UPi1dnM=;
        b=sf4/CDCmZsMsfBZUyTnUmF30ITIdKfx16eK2DQ7CT3XuJDQgcP6rH266TD9b0Qx88V
         tliPUROCj9pLrTboTrUsKI+DJ7hq73CTb5tMaRjzaY/stFj7tdgucQd3b257x4L4ZZ2q
         Js3MxCNhqVEE06gk/NMlqnMfIp5OjzsWl0sbV3Mu9d3HFhwRiZE/RWFTnDmDm0bah1Fu
         bWaVJVVApPQ/3kfUwus3lJXCmlb6oPCzo2M6fgtLFpM1tY2wwwr6cbDxbCMsNZAWTpy/
         +5RgCNR+fVE25k+phyoM2CIcmNhoPFu36A16dBMH7uS1PL+yCLwXMB0b396aE0HVwUis
         XOLg==
X-Gm-Message-State: AOAM5339qhW5KKm5B+87Nt9zhq8NYsg4/bbjP6qyj57VTYxTcHpQ6/ty
        UM5s8y9LQ+RmXVzplVRvm3qXkHXk59YyrLKy9CkuYppPuOr8ttZUfhen9HCwFfFoS63jof1npk0
        SJsZ4DUpPel59/I4nQpNHkU1i
X-Received: by 2002:a17:90b:318:: with SMTP id ay24mr23612459pjb.175.1623114652570;
        Mon, 07 Jun 2021 18:10:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx253KrivISywGLROa5WGmZPzIUrrh3/ViJVkQze+aUvfxcfFXPOZCDpYA7zhgges937Rhj+Q==
X-Received: by 2002:a17:90b:318:: with SMTP id ay24mr23612437pjb.175.1623114652306;
        Mon, 07 Jun 2021 18:10:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c5sm6947662pfn.144.2021.06.07.18.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 18:10:51 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Liu Yi L <yi.l.liu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Alex Williamson (alex.williamson@redhat.com)\"\"" 
        <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>
References: <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
 <20210602172154.GC1002214@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c84787ec-9d8f-3198-e800-fe0dc8eb53c7@redhat.com>
Date:   Tue, 8 Jun 2021 09:10:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210602172154.GC1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 上午1:21, Jason Gunthorpe 写道:
> On Wed, Jun 02, 2021 at 04:54:26PM +0800, Jason Wang wrote:
>> 在 2021/6/2 上午1:31, Jason Gunthorpe 写道:
>>> On Tue, Jun 01, 2021 at 04:47:15PM +0800, Jason Wang wrote:
>>>> We can open up to ~0U file descriptors, I don't see why we need to restrict
>>>> it in uAPI.
>>> There are significant problems with such large file descriptor
>>> tables. High FD numbers man things like select don't work at all
>>> anymore and IIRC there are more complications.
>>
>> I don't see how much difference for IOASID and other type of fds. People can
>> choose to use poll or epoll.
> Not really, once one thing in an applicate uses a large number FDs the
> entire application is effected. If any open() can return 'very big
> number' then nothing in the process is allowed to ever use select.
>
> It is not a trivial thing to ask for
>
>> And with the current proposal, (assuming there's a N:1 ioasid to ioasid). I
>> wonder how select can work for the specific ioasid.
> pagefault events are one thing that comes to mind. Bundling them all
> together into a single ring buffer is going to be necessary. Multifds
> just complicate this too
>
> Jason


Well, this sounds like a re-invention of io_uring which has already 
worked for multifds.

Thanks


