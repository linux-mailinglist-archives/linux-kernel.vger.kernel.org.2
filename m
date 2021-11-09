Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4510844B2B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbhKISax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231396AbhKISat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636482482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtUoKBqasSeW6Qre3YuNfMu7Ws6mBm3uCqCwPLcQgzo=;
        b=OjrxGRexXWU4hcZtgKVQUToVERJvi5B7W3TJXhNUbXL+o4BN585979HVk3o4OAzDHk7rHi
        AnSDTXXaRbxOR1GiYzbhKjJ9Jjc3Hcx0My+NU8FEf19aV7GvTuxZ8Mv3Ft3Sl8fJD4Adav
        fu7hZ09wwczMT3cKS/ZElbPs8lXnG4c=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-8eIaWMMQNbiQXS8SgATANQ-1; Tue, 09 Nov 2021 13:28:01 -0500
X-MC-Unique: 8eIaWMMQNbiQXS8SgATANQ-1
Received: by mail-ot1-f72.google.com with SMTP id m23-20020a05683023b700b0055c8a2dcca0so789ots.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rtUoKBqasSeW6Qre3YuNfMu7Ws6mBm3uCqCwPLcQgzo=;
        b=hmlytHfGKUeBeenz676X0DXXR0S7hkUGsKRc7yXUofdECK5TGUEvH4x8BqqsbSG1RN
         gs3wlsCJbeYzUKLboNcKOq9utyBmHLF2wxkX18V0MBKtHfjlP/Up8uoOCvgiGklECzob
         cjkVRb0FtFp89j1zv6tfV38nULfsQe/FSJg8YPSVU2xUzUHnRBCw4ifT5o5E9No0Gysk
         52P3u1f3+IkOSXFAQDUuoake0a5HWyqre9UNBZuNrTEzC+xUSHL8PN1WEH8W86G8cuAU
         WYbj3X40FBCFd65cyC/dXPjuO+KgGP32qN4TEiYJXR33v9FZwy85xyR9q/1J1C1z5MpR
         VohQ==
X-Gm-Message-State: AOAM530DlTrnYXMUAZ0iEPZbYAVx4Yw7BTpzorrVFYi5Pf6z14CQy+2G
        lqnSandO/3G4etSgYWt85/L3NXrg3bftTLZuCSIQdZDJtcQ4C9IMX2f4oZ9Y1OBAuA27J7ilzGi
        xDVQzhlQUShsvgEdHUCON8NMp
X-Received: by 2002:aca:d956:: with SMTP id q83mr7548460oig.165.1636482480721;
        Tue, 09 Nov 2021 10:28:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbTJpzBL7XSS42NEtwyUl4DhJ9VlLaX9+7VZV4Hpia5d1DnpyjnzhwPpK5Eu9G8lqfn/zBTQ==
X-Received: by 2002:aca:d956:: with SMTP id q83mr7548445oig.165.1636482480585;
        Tue, 09 Nov 2021 10:28:00 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q5sm7795022otg.1.2021.11.09.10.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 10:28:00 -0800 (PST)
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
 <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
Date:   Tue, 9 Nov 2021 10:27:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/21 10:05 AM, Andy Shevchenko wrote:
> On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
>> On 11/9/21 7:41 AM, Andy Shevchenko wrote:
>>> Currently the find_dfls_by_vsec() opens code pci_find_vsec_capability().
>>> Refactor the former to use the latter. No functional change intended.
> Thanks for review, my answers below.
>
> ...
>
>>> +	u16 voff;
>> The later use of voff in pci_read_config_dword is of type 'int', it may be
>> better to keep voff as an int.
> I don't think so. The rule of thumb that the types should match the value they
> got in the first place. In this case it's u16. Compiler will implicitly cast it
> to whatever is needed as long as the type is good for integer promotion.
>
> ...
>
>>> +	voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);
>> This may be a weakness in the origin code, but intel isn't the exclusive
>> user of DFL.
> This does not change the original code. If you think so, this can be extended
> later on.

I would rather see this fixed now or explained why this isn't a problem.

Tom

>
>>>    	if (!voff) {
>>>    		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
>>>    		return -ENODEV;

