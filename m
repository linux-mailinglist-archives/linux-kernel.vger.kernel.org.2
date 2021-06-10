Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3223A22A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJDQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 23:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229911AbhFJDQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 23:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623294785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AaHF8TleW9y2yJFtUkdVSK3jH8Hx5NwN6hAUVAUFzZY=;
        b=HafUCfxIZRhMpbyiKxaQGp+nzGk+XR6MEeQPAJv12rXxm7/Cw0k2zGPBVitqht5qdx1Sy5
        b7i/CWD7O3GXrPVPAU9QNQmtr2/BiIxn8bxZ6gICWiULPxeQrW38F2FYIXfxQBmJS9t9Ol
        1X1OMbmYGg2B1dOPf4DxmgUoPrAnG/o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-hi_eC09MPVeU4KjbdeQczg-1; Wed, 09 Jun 2021 23:13:04 -0400
X-MC-Unique: hi_eC09MPVeU4KjbdeQczg-1
Received: by mail-pg1-f198.google.com with SMTP id f6-20020a6310060000b0290221a634c769so2262967pgl.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 20:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AaHF8TleW9y2yJFtUkdVSK3jH8Hx5NwN6hAUVAUFzZY=;
        b=LdLYYMOrB4UH3cYQVt49LZLZYTnKJiB2hg55VdDk0YsaPSFaDOCFSHdbftR+UdU3ws
         yFBl05ebgHMa9q2lOB4Wrn55j/u61EPtyZslvpcsyRYBIpBVgiT6J2GtRLAbJZytYhld
         f4L2eYEISd+Gp60RN6yyx+ipDQNZsYJ7sZxabhN6yclYhVx1hyQ9MteGV2y5PnukAVlG
         w/coK9d4qA3T26leMBbC2B8qLS+CTqYZuOzHg4B1G3ipre6FtAxVfi0xzmFkz4IDBmhg
         NkfJekT0FVLvSqZJFQfOZAbKVQCuMoEi36myhhph8aq9CLw3gAflIsk/VOHB5QrzWKUp
         l08Q==
X-Gm-Message-State: AOAM530IbDvxMNstaDoSKIECngIQaOitCJgHvQfDkyn3+aRF6+tikyd7
        AESvT2Lv7P8Kgkin1KcGKK+Mk3BfP9Vys5q4czCwMjxjWT7MQlvWtiDC7yukqlU06NV9MvwToSp
        yEKG4j7oirw4c1GN7avXuqg90
X-Received: by 2002:a05:6a00:ac9:b029:2de:a06d:a52f with SMTP id c9-20020a056a000ac9b02902dea06da52fmr921567pfl.4.1623294783018;
        Wed, 09 Jun 2021 20:13:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/pAIMyn/a062PTQnxMgMFen4R6oZntNzUJIuTOG/VZwhA+MB6v0irLu8mJOnFgruZrZj5dw==
X-Received: by 2002:a05:6a00:ac9:b029:2de:a06d:a52f with SMTP id c9-20020a056a000ac9b02902dea06da52fmr921554pfl.4.1623294782797;
        Wed, 09 Jun 2021 20:13:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o16sm767460pfu.75.2021.06.09.20.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 20:13:02 -0700 (PDT)
Subject: Re: [PATCH 0/7] Do not read from descriptor ring
To:     Andy Lutomirski <luto@kernel.org>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
        stefanha@redhat.com, file@sect.tu-berlin.de, ashish.kalra@amd.com,
        konrad.wilk@oracle.com, kvm@vger.kernel.org, hch@infradead.org,
        ak@linux.intel.com
References: <20210604055350.58753-1-jasowang@redhat.com>
 <1c079daa-f73d-cb1a-15ef-d8f57f9813b8@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <633377e3-98d2-2917-3111-2c9c08b5da4f@redhat.com>
Date:   Thu, 10 Jun 2021 11:12:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1c079daa-f73d-cb1a-15ef-d8f57f9813b8@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/9 上午12:24, Andy Lutomirski 写道:
> On 6/3/21 10:53 PM, Jason Wang wrote:
>> Hi:
>>
>> The virtio driver should not trust the device. This beame more urgent
>> for the case of encrtpyed VM or VDUSE[1]. In both cases, technology
>> like swiotlb/IOMMU is used to prevent the poking/mangling of memory
>> from the device. But this is not sufficient since current virtio
>> driver may trust what is stored in the descriptor table (coherent
>> mapping) for performing the DMA operations like unmap and bounce so
>> the device may choose to utilize the behaviour of swiotlb to perform
>> attacks[2].
> Based on a quick skim, this looks entirely reasonable to me.
>
> (I'm not a virtio maintainer or expert.  I got my hands very dirty with
> virtio once dealing with the DMA mess, but that's about it.)
>
> --Andy


Good to know that :)

Thanks

