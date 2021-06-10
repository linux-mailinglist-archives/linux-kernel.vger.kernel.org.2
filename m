Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776E13A230B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 06:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhFJEF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 00:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhFJEF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 00:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623297840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19S4V0oFIhYTEmjCi3wnOG6CCDqJn4GFX2fH4afLaKA=;
        b=P7OmA0kTxagkieW5Zt9yOQsoDKq2Z7bhg5HmpZgCxhtJrbAUVNhPnWQW7B191ray7uxKQe
        beb6aY6du44gIJYFxQhHUZ5vfTCfUqLVD15758itaL+pC7RBkk6w3raxyo8QzX+njunR4c
        1z1O/m3kt/hGBCIp37wpyKO1128d2ls=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-vSZknIcUOviRhEESFySbWg-1; Thu, 10 Jun 2021 00:03:58 -0400
X-MC-Unique: vSZknIcUOviRhEESFySbWg-1
Received: by mail-pg1-f198.google.com with SMTP id a26-20020a631a5a0000b02902205085fa58so4389514pgm.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 21:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=19S4V0oFIhYTEmjCi3wnOG6CCDqJn4GFX2fH4afLaKA=;
        b=Pzf5nr771/KupNGDsZLgzzyVOxQNAfeDBPeoa+giKIVXesLEw3LmqqEcIpwnpnuZ/z
         45PWdwLeuel4R1DYY+uXV/6K9InFNJ/56SnZazzjRxq3JND/s+IeXDUwAVjlYOcNhY3b
         bP2qcxCkw0KMEcJwkawBz8AqH8ahxKGMCIljJR7XG/6lOMcReu22xhI3tdAldCGoh8L/
         NZ216iozjznT+qWj2Lp/u2WOohM3UE8p6tUHIdp6PNUa035I/Wip+AInSIEtLO6F/jHq
         gWccaOSfnL1W505P8zHTJzqI5Jlf0sSs99mW7dqHzFlJOstTnCdUeRobnQPDvhTPWjrT
         skVQ==
X-Gm-Message-State: AOAM5327lf0BINYmvM/7AueXANDbE/kFQpCxbRCSktndz7XpcGtjE6oN
        9wliqQTAmzMzxfgfI5S/q+BB0XnF652CPdLtf/nWl2+o4HLOo9K/HJIy4CGPGGlc2pVcEEdQcVv
        JJDrJRK32A9bVRCzg223QwItY
X-Received: by 2002:a63:3fc6:: with SMTP id m189mr2985876pga.239.1623297837852;
        Wed, 09 Jun 2021 21:03:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVMH4GRlTNZgCb4SGiAzZbg0vm86YmdxLIXUVjkXzrgfxl13LW9u+XyYW03LglmHfkfEaonA==
X-Received: by 2002:a63:3fc6:: with SMTP id m189mr2985870pga.239.1623297837705;
        Wed, 09 Jun 2021 21:03:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j16sm1136234pgh.69.2021.06.09.21.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 21:03:57 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
From:   Jason Wang <jasowang@redhat.com>
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
References: <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
 <20210602172154.GC1002214@nvidia.com>
 <c84787ec-9d8f-3198-e800-fe0dc8eb53c7@redhat.com>
 <20210608132039.GG1002214@nvidia.com>
 <f4d70f28-4bd6-5315-d7c7-0a509e4f1d1d@redhat.com>
Message-ID: <3af22408-f0f1-7e04-48ab-852619d28ef6@redhat.com>
Date:   Thu, 10 Jun 2021 12:03:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f4d70f28-4bd6-5315-d7c7-0a509e4f1d1d@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/10 上午10:00, Jason Wang 写道:
>
> 在 2021/6/8 下午9:20, Jason Gunthorpe 写道:
>> On Tue, Jun 08, 2021 at 09:10:42AM +0800, Jason Wang wrote:
>>
>>> Well, this sounds like a re-invention of io_uring which has already 
>>> worked
>>> for multifds.
>> How so? io_uring is about sending work to the kernel, not getting
>> structued events back?
>
>
> Actually it can. Userspace can poll multiple fds via preparing 
> multiple sqes with IORING_OP_ADD flag.


IORING_OP_POLL_ADD actually.

Thanks


>
>
>>
>> It is more like one of the perf rings
>
>
> This means another ring and we need introduce ioctl() to add or remove 
> ioasids from the poll. And it still need a kind of fallback like a 
> list if the ring is full.
>
> Thanks
>
>
>>
>> Jason
>>

