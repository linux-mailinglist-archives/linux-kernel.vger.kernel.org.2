Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B697340FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhCRVbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhCRVbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:31:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDFDC06174A;
        Thu, 18 Mar 2021 14:31:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k4so1949967plk.5;
        Thu, 18 Mar 2021 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=urs31C1oCCeprVuwl2xS/PR4GaFAJl/+dTB9iEb63mU=;
        b=KZbC1ubJfdJSCMLlYSsz53FpXhle0Z79REbw0h4uYlS+NaKZD+4i06PhYx8XcW3OEm
         S24OKPOUpysAb9kFqBIh4omlHLsQ4K5+3GWlbW1LDCjNASBOzZbDcugMWxGt718SO2aF
         bvh+g72bGJSm89bwqurmoPeSF+7QMLcyvSE+otVFWljC2/jgyAzz5H8L6D1EMSA0BypU
         /q9TLEuSCO6ecJSoPnnq9IZfbVdHX8KWf6R+pP+i3oS5qjo0QtxTMQeeVVH19WYZ/Ml+
         C+X7WLD3lMfI7KfY3yLzro7oLvlcWVCv2JDrk9EktIzaOwgXbeFibEbeuCDFJ43HWImo
         Drcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=urs31C1oCCeprVuwl2xS/PR4GaFAJl/+dTB9iEb63mU=;
        b=P0jGeDYMfQ41p5xTNQylXcQRncmkhzmnWj4ITlNUQFQskXBrPznARnvoOwaIIGM5zv
         dLimhuwomVWcrVMSDWR3G9/c8neP+HNnbmjkUIb7gaUW28FWNTeKoCh7WIqoxu/IWOR+
         gS3ghdGOsqbwd97kypu/C+jPztP5HA61sr1XWi2MnmPZQ/MwlH01/HEBnKGOp6wPXPKz
         kILAUBoED0iU5THCg4BTSGRwD/QCaRlqTu9ugZFjCPGcroTMeyefcDCj3T0n6ehPWJFT
         YgqpgQxoPV2uLxCGLvrSD6F5yq3FCBRXMc1R1PCbKmg5v57LPTWUh+aHc57F3O+yJzXm
         IQNw==
X-Gm-Message-State: AOAM530ILfj43fvxB4DKmkacrLgWVfF7a5YSDr+K3+mBkry9ijWc/Pxk
        SMyrqtwQxRzAOvu4jqpXYt0=
X-Google-Smtp-Source: ABdhPJwZynkHFeh94Ggvq5VKM7xZxZxokfdCvK0mYjOVVb3AS6xB6y2N36hJoyMG2e42huOSBG8I5g==
X-Received: by 2002:a17:90a:bf04:: with SMTP id c4mr6268131pjs.170.1616103079707;
        Thu, 18 Mar 2021 14:31:19 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j35sm3220312pgj.45.2021.03.18.14.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 14:31:19 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, opendmb@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
 <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
 <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
 <16d1c66f-5451-2515-af73-a6b44d996e92@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a8a05321-3fd0-d1c4-9d76-ec2e79e310ec@gmail.com>
Date:   Thu, 18 Mar 2021 14:31:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <16d1c66f-5451-2515-af73-a6b44d996e92@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2021 12:53 PM, Robin Murphy wrote:
> On 2021-03-18 19:43, Florian Fainelli wrote:
>>
>>
>> On 3/18/2021 12:34 PM, Robin Murphy wrote:
>>> On 2021-03-18 19:22, Florian Fainelli wrote:
>>>>
>>>>
>>>> On 3/18/2021 12:18 PM, Florian Fainelli wrote:
>>>>> It may be useful to disable the SWIOTLB completely for testing or
>>>>> when a
>>>>> platform is known not to have any DRAM addressing limitations what so
>>>>> ever.
>>>
>>> Isn't that what "swiotlb=noforce" is for? If you're confident that we've
>>> really ironed out *all* the awkward corners that used to blow up if
>>> various internal bits were left uninitialised, then it would make sense
>>> to just tweak the implementation of what we already have.
>>
>> swiotlb=noforce does prevent dma_direct_map_page() from resorting to the
>> swiotlb, however what I am also after is reclaiming these 64MB of
>> default SWIOTLB bounce buffering memory because my systems run with
>> large amounts of reserved memory into ZONE_MOVABLE and everything in
>> ZONE_NORMAL is precious at that point.
> 
> It also forces io_tlb_nslabs to the minimum, so it should be claiming
> considerably less than 64MB. IIRC the original proposal *did* skip
> initialisation completely, but that turned up the aforementioned issues.

AFAICT in that case we will have iotlb_n_slabs will set to 1, which will
still make us allocate io_tlb_n_slabs << IO_TLB_SHIFT bytes in
swiotlb_init(), which still gives us 64MB.

> 
>>> I wouldn't necessarily disagree with adding "off" as an additional alias
>>> for "noforce", though, since it does come across as a bit wacky for
>>> general use.
>>>
>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>
>>>> Christoph, in addition to this change, how would you feel if we
>>>> qualified the swiotlb_init() in arch/arm/mm/init.c with a:
>>>>
>>>>
>>>> if (memblock_end_of_DRAM() >= SZ_4G)
>>>>      swiotlb_init(1)
>>>
>>> Modulo "swiotlb=force", of course ;)
>>
>> Indeed, we would need to handle that case as well. Does it sound
>> reasonable to do that to you as well?
> 
> I wouldn't like it done to me personally, but for arm64, observe what
> mem_init() in arch/arm64/mm/init.c already does.
> 
> Robin.

-- 
Florian
