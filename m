Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C36F4373F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhJVIx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232180AbhJVIxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634892668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3GDoQi/Q+cCcrsFFJcqOFTH6DISD5ySztmRn3je5dI=;
        b=Gf86SJ38vTQjRYf2hINHMPQXGxnRVNCDVO/FElDnJkWmJ3wD3+NQH8mPbbk1xwa8cA3gLG
        W43R1ot/jSUqTB7Zp2+QGMFslJC8nYqCQ9jHSGM2QI3uvYw91Zre+l8BULv0Q4f4PrpGpg
        p03vyYsYncly49CZqdapmKPNkWJqtYw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-J0u5mCSYPfijuUe8pqu1cQ-1; Fri, 22 Oct 2021 04:51:04 -0400
X-MC-Unique: J0u5mCSYPfijuUe8pqu1cQ-1
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso2986258edj.20
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z3GDoQi/Q+cCcrsFFJcqOFTH6DISD5ySztmRn3je5dI=;
        b=0QEdOo3xBoOsz+5wVg44g/BtXAsSoYFAR5VhnqOyKTAw0jlYLQRv0MXFwvCOxgs9G6
         ZiWAm2R6/B8uN7uJYLIQ45cQDNd+vPULTr3PnmgFoTi7CYfo+ftEbnojNpaNIM0IhHV8
         PsWcTYKrBQo3uv6bzJF7HUBTlZF6a62KsMGW02Et42xFi+ejo86N9LX1mkLtN/UMqi4s
         EE84aizjM96KbeWvrfpmOL/pP1JZPLSp5JaGdTY1tP8htMSm2RXROJIf9vxeARJFBgIj
         vIEMIDZCjpXtQYBp8k29K5RNzTnLHJkkXy7t9m+7bcdtQDGlCEagZVKwG5YKGy2cTxzq
         yMug==
X-Gm-Message-State: AOAM532ZEJO3ZC9eqmab19OUAcPVPCPMZLplkYR9CZ0ZUsf/AEWCBzTx
        7LpyeAi3KOvf8axWhw/X817iR/shbdkFABxmk1EFb9/xkzW4tC8QqzYN695rdqjJffI2sqx6Zpl
        CqTJwvjJVNX1RWvY4liEermBP
X-Received: by 2002:a17:906:2994:: with SMTP id x20mr9178880eje.417.1634892663398;
        Fri, 22 Oct 2021 01:51:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3LUNk/pzJ4zatQIis3+ekWdBtpMTEdQF4NYGkiWx1h1Yulqz7pxaNeNkg4hdsaeDrorPvMg==
X-Received: by 2002:a17:906:2994:: with SMTP id x20mr9178857eje.417.1634892663161;
        Fri, 22 Oct 2021 01:51:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m15sm4048298edv.45.2021.10.22.01.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 01:51:02 -0700 (PDT)
Message-ID: <ff8b1f12-5123-324d-a8dd-2161c04cafad@redhat.com>
Date:   Fri, 22 Oct 2021 10:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] platform/x86: amd-pmc: Store the pci_dev instance
 inside struct amd_pmc_dev
Content-Language: en-US
To:     "Goswami, Sanket" <Sanket.Goswami@amd.com>,
        Shyam-sundar.S-k@amd.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211021092938.196933-1-Sanket.Goswami@amd.com>
 <f903b9d5-0477-1618-6596-b6039b56a5af@redhat.com>
 <7714d522-36b4-47bd-332c-c4ff5eeb1237@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <7714d522-36b4-47bd-332c-c4ff5eeb1237@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sanket,

On 10/22/21 08:55, Goswami, Sanket wrote:
> Hi Hans,
> 
> On 21-Oct-21 23:48, Hans de Goede wrote:
>> [CAUTION: External Email]
>>
>> Hi,
>>
>> On 10/21/21 11:29, Sanket Goswami wrote:
>>> Store the root port information in amd_pmc_probe() so that the
>>> information can be used across multiple routines.
>>>
>>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>>> ---
>>> Changes in v2:
>>> - Store the rdev info in amd_pmc_probe() as suggested by Hans.
>>
>> Thank you, but there are still some issues, see below.
>>
>>
>>>  drivers/platform/x86/amd-pmc.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
>>> index 55f14bdfdbfd..502f37eaba1f 100644
>>> --- a/drivers/platform/x86/amd-pmc.c
>>> +++ b/drivers/platform/x86/amd-pmc.c
>>> @@ -119,6 +119,7 @@ struct amd_pmc_dev {
>>>       u16 minor;
>>>       u16 rev;
>>>       struct device *dev;
>>> +     struct pci_dev *rdev;
>>>       struct mutex lock; /* generic mutex lock */
>>>  #if IS_ENABLED(CONFIG_DEBUG_FS)
>>>       struct dentry *dbgfs_dir;
>>> @@ -482,6 +483,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
>>>               return -ENODEV;
>>>       }
>>>
>>> +     dev->rdev = rdev;
>>>       dev->cpu_id = rdev->device;
>>>       err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_LO);
>>>       if (err) {
>>> @@ -512,7 +514,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
>>>       }
>>>
>>>       base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
>>> -     pci_dev_put(dev->rdev);
>>
>> The current code here actually reads:
>>
>>         pci_dev_put(rdev);
>>
>> Note (rdev) not (dev->rdev). I don't know what you based this on, this is weird.
> 
> rdev is already retrieved before doing this:
> 	     pci_dev_put(dev->rdev);
> 
> i.e.
> in amd_pmc_probe()
> 
> rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> 	if (!rdev || !pci_match_id(pmc_pci_ids, rdev)) {
> 		pci_dev_put(rdev);
> 		return -ENODEV;
> 	}
> 
> after this I am storing rdev in "dev->rdev"
> i.e.
> dev->rdev = rdev;
> 
> after this I am using "dev->rdev" at places where "rdev" was getting used earlier.
> Do you see any problem?

What I was trying to say is that the patch does not apply, because it is
trying to remove the pci_put_dev() line from a block of code like this:

	base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
	pci_dev_put(dev->rdev);
	base_addr = ((u64)base_addr_hi << 32 | base_addr_lo);

But the actual code in platform-drivers-x86/review-hans (and for-next too) has:

	base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
	pci_dev_put(rdev);
	base_addr = ((u64)base_addr_hi << 32 | base_addr_lo);



After your patch using dev->rdev instead of just rdev is fine
(but please be consistent, which would mean use just rdev everywhere).

But your patch is removing a line which does not exist in that form,
IOW it is based on some intermediate version of amd-pmc.c and not
on the HEAD of platform-drivers-x86/review-hans.

Regards,

Hans






> 
>>
>> Also there are a bunch of error-exits from amd_pmc_probe() which not all
>> need a "pci_dev_put(rdev)" added to them before there "return ERROR;"
>> statement.
>>
>> It would be best to add:
>>
>> err_pci_dev_put:
>>         pci_dev_put(rdev);
>>         return err;
>>
>> Add the end off the function (after the return 0;) and replace all
>> "return FOO" error-exits with:
>>
>>                 err = <FOO>;
>>                 goto err_pci_dev_put;
>>         }
>>
> Thank you, will take it as a separate patch in v3.
> 
> 
> Thanks,
> Sanket
> 

