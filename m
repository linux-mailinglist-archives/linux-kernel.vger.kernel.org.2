Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016E1336D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCKHyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhCKHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:54:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22860C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 23:54:19 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bt4so3048799pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 23:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PnvVPbZcFGFyCEhF0G1+tIMw3x2kNLtmvdQVPet9ctE=;
        b=foKJExde6LDu1eEM7/Y6kM+pdVI2bNGljjgWTDiR87NXjEjikBHX78pCPLfU/9DMbv
         lrhNo04TBbVwoGfl3VfROa7zhsSdwkhzSuFSdPwoNU5HQWl+AZSCfH/mXJ2Wtus7qQ8l
         41LLgcGtd+HsEzKAhQRtt5hPhcPcNSsuTuUkTk5XSCn0LslBCWTR2s8tV+/ZF3ooOdrF
         oIJ+3XZsYOIYYu2cMWU9TxISwIn4D8Wafz6CvfYIh38zq08nO5HeO8ptkXIMnO/7aFV5
         os5On43XZK5fr6IBfTl8o242rSZq2BruSotbTHS3RfiudzCutrI3l/MBRZMHLyrxl5QU
         Vxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PnvVPbZcFGFyCEhF0G1+tIMw3x2kNLtmvdQVPet9ctE=;
        b=sF6rQ30MmRRR7WrsB9pX6SZ/fNokdZBoC/zwVPzY1UJpxQfAm3vBWEMNtkBk1bC/1X
         S0l10sV3n3ORLlVIFFLskwpS1d6Z+6vjekT0FtTnGkFOJ0UDonUiAtLV5YcO1SwD9wbg
         G0W0iIyjO4+HMPGVyLXfsNOn3SaB8XPVrPWfBJxytuT+Xk2pD/OCD+aQltpG/NB0/HHb
         D4rPSvFMVsFxO1n2uJblmdoouhxL2yPWatCz0mT5ZWb9yEgUTnO0ByVPHYDdE6S1YhdQ
         SBqNgusfcZvnakoqYd1b4xUVSBLFshhJq2zPBLEVthebWWNo6u+uEynYhDs5vvxn4viW
         lRhg==
X-Gm-Message-State: AOAM5300uffIBUKy2p4NVgAUlx1RzT+uRFMXjkQ1JjngRgWVahy21y29
        GpcdzLs8+oDWX2pQG9JF++5X5A==
X-Google-Smtp-Source: ABdhPJwwOJ1rUKugJGDVCTBqPbPUgmENy5fzFWhD2yjASVj0K9sJiXMXKRKSixzRLX109AGDLPgCSg==
X-Received: by 2002:a17:902:d4cc:b029:e4:9cd9:f189 with SMTP id o12-20020a170902d4ccb02900e49cd9f189mr6979567plg.53.1615449258508;
        Wed, 10 Mar 2021 23:54:18 -0800 (PST)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id e83sm1607300pfh.80.2021.03.10.23.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 23:54:18 -0800 (PST)
Subject: Re: [PATCH 8/9] vfio/pci: export nvlink2 support into vendor vfio_pci
 drivers
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>, alex.williamson@redhat.com,
        cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liranl@nvidia.com, oren@nvidia.com,
        tzahio@nvidia.com, leonro@nvidia.com, yarong@nvidia.com,
        aviadye@nvidia.com, shahafs@nvidia.com, artemp@nvidia.com,
        kwankhede@nvidia.com, ACurrid@nvidia.com, cjia@nvidia.com,
        yishaih@nvidia.com, mjrosato@linux.ibm.com, hch@lst.de
References: <20210309083357.65467-1-mgurtovoy@nvidia.com>
 <20210309083357.65467-9-mgurtovoy@nvidia.com>
 <19e73e58-c7a9-03ce-65a7-50f37d52ca15@ozlabs.ru>
 <8941cf42-0c40-776e-6c02-9227146d3d66@nvidia.com>
 <20210310130246.GW2356281@nvidia.com>
 <3b772357-7448-5fa7-9ecc-c13c08df95c3@ozlabs.ru>
 <20210310194002.GD2356281@nvidia.com>
 <7f0310db-a8e3-4045-c83a-11111767a22f@ozlabs.ru>
 <20210311013443.GH2356281@nvidia.com>
 <d862adf9-6fe7-a99e-6c14-8413aae70cd4@ozlabs.ru>
 <20210311020056.GI2356281@nvidia.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <73c99da0-6624-7aa2-2857-ef68092c0d07@ozlabs.ru>
Date:   Thu, 11 Mar 2021 18:54:09 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210311020056.GI2356281@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2021 13:00, Jason Gunthorpe wrote:
> On Thu, Mar 11, 2021 at 12:42:56PM +1100, Alexey Kardashevskiy wrote:
>>>> btw can the id list have only vendor ids and not have device ids?
>>>
>>> The PCI matcher is quite flexable, see the other patch from Max for
>>> the igd
>>   
>> ah cool, do this for NVIDIA GPUs then please, I just discovered another P9
>> system sold with NVIDIA T4s which is not in your list.
> 
> I think it will make things easier down the road if you maintain an
> exact list <shrug>


Then why do not you do the exact list for Intel IGD? The commit log does 
not explain this detail.


>>> But best practice is to be as narrow as possible as I hope this will
>>> eventually impact module autoloading and other details.
>>
>> The amount of device specific knowledge is too little to tie it up to device
>> ids, it is a generic PCI driver with quirks. We do not have a separate
>> drivers for the hardware which requires quirks.
> 
> It provides its own capability structure exposed to userspace, that is
> absolutely not a "quirk"
> 
>> And how do you hope this should impact autoloading?
> 
> I would like to autoload the most specific vfio driver for the target
> hardware.


Is there an idea how it is going to work? For example, the Intel IGD 
driver and vfio-pci-igd - how should the system pick one? If there is no 
MODULE_DEVICE_TABLE in vfio-pci-xxx, is the user supposed to try binding 
all vfio-pci-xxx drivers until some binds?


> If you someday need to support new GPU HW that needs a different VFIO
> driver then you are really stuck because things become indeterminate
> if there are two devices claiming the ID. We don't have the concept of
> "best match", driver core works on exact match.



-- 
Alexey
