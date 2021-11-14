Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4AE44F81F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 14:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhKNNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 08:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhKNNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 08:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636897334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vyZi4vDGoobDd8yl1WbAqvKfzAAL2FM4RIahKKRUriw=;
        b=THJ7+MljP7Qm2lnBa9LhXNwrfuwvF2F9mSKKevA7vQG9z2v1u2Jjm74Zd2xnHwtm8ELEnY
        tyKJpU3hcKQQz6H5tQo8Uzjmp3ByXk7UVKKOef/G8gNncZQl/OfXQSYOLJiB4PHCFeONd5
        M29H9j2Ko7H6HRG4ov4+Fh+FEfx7EL0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-byIfUS42PnuZHgVLjuBA-A-1; Sun, 14 Nov 2021 08:42:13 -0500
X-MC-Unique: byIfUS42PnuZHgVLjuBA-A-1
Received: by mail-ed1-f70.google.com with SMTP id q6-20020a056402518600b003e28d92bb85so11820410edd.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 05:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vyZi4vDGoobDd8yl1WbAqvKfzAAL2FM4RIahKKRUriw=;
        b=sQmYdTBAxkydXkKuJZ3KojWuvW79sKjYKm2Lh3g8+Sz1+wMzTrtTAkrzggjwwTN5zi
         VEZyICcrSF2QuvAqcivmT1l8Dn9jGvnhKWkTRqFSBRr6RM24KA2PXLVgNajy+UAbEUQ1
         N0zUYuwSCPHOIXJd0ULaTSeo/2D8vH4Nc9BdWF7yR43qRybhRp+XapEOk+hZKemnA76n
         evCHFVUO6iY+/8SpL5EFFel4HIg6alJq80PAIVVz1E23lL1kxFZm1aluxzFfHv3w7yBP
         +EEdPbvbJLKNch7Pa07IlHuB0yKsKXu5efvR8Hkl8RZgjua8qp9Kcr/s0k6Pm/bV0wG2
         gmKw==
X-Gm-Message-State: AOAM5312BdFXfueTl0eJdNZoqwBp9Ju85pIyGI2ludyNF6oGvtm12U91
        77a4J+5pSJahpoDMLIKrz3/Mm2+Oq/8XpBNkw8H9k4euO3PW6E2FfbfFrtTtHqS/NvJuCFfYVTC
        qigH9UXOfziFremjRoCjufD+Q
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr38229381ejq.567.1636897331787;
        Sun, 14 Nov 2021 05:42:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW1j9b31FtdsWUmRZhsYLzy+nz4/j1cM3akXHPc/FjESQn/Cz+Vse7WxqMn0IqXZ7O0ynSkg==
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr38229358ejq.567.1636897331544;
        Sun, 14 Nov 2021 05:42:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id go10sm5163028ejc.115.2021.11.14.05.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 05:42:11 -0800 (PST)
Message-ID: <07395839-dc14-3ff1-c9a2-81d53f68a042@redhat.com>
Date:   Sun, 14 Nov 2021 14:42:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] usb: dwc3: leave default DMA for PCI devices
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "hch@lst.de" <hch@lst.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211113142959.27191-1-fabioaiuto83@gmail.com>
 <34347fd8-1d67-4d16-b09f-061bc0c0cb5a@www.fastmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <34347fd8-1d67-4d16-b09f-061bc0c0cb5a@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/14/21 12:56, Sven Peter wrote:
> On Sat, Nov 13, 2021, at 15:29, Fabio Aiuto wrote:
>> in case of a PCI dwc3 controller, leave the default DMA
>> mask. Calling of a 64 bit DMA mask breaks the driver on
>> cherrytrail based tablets like Cyberbook T116.
>>
>> Fixes: 45d39448b4d0 ("usb: dwc3: support 64 bit DMA in platform driver")
>> Reported-by: Hans De Goede <hdegoede@redhat.com>
>> Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>
>> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
>> ---
>>  drivers/usb/dwc3/core.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 643239d7d370..f4c09951b517 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1594,9 +1594,11 @@ static int dwc3_probe(struct platform_device *pdev)
>>
>>  	dwc3_get_properties(dwc);
>>
>> -	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
>> -	if (ret)
>> -		return ret;
>> +	if (!dwc->sysdev_is_parent) {
> 
> 
> Are you sure it's the dwc3 controller that limits DMA to 32 bit addresses and
> not the PCI bus itself?

This is unknown, until the commit which added the dma_set_mask call
everything worked fine; and that commit was found with a git-bisect.

But since these SoCs can never have more then 4G RAM it makes sense for
both the bus and the DWC3 to be limited to 32 bit DMA only, since everything
else is just wasted extra silicon.

The dwc3 driver has this somewhat convoluted design where the PCI-driver
instantiates a platform-device and then a platform-driver is used instead of
having some generic core + separate platform and PCI drivers.

Fixing this convoluted design is way out of scope for fixing the *regression* with
DWC3 on Intel Cherry Trail (and likely also Bay Trails) SoCs, since that
requires a lot of refactoring.

So taken this convoluted design as a given, then it is clear that the platform-driver
should not be calling dma_set_mask on the PCI device, generally speaking
for PCI this is taken care of by the PCI subsytem itself; and if this requires
special handling then this special handling for PCI devices belongs in the
drivers/usb/dwc3/dwc3-pci.c code, not in the core code.

Part of the weirdness with the PCI driver instantiating a platform_device
and then using a platform_driver is that that code path (and only that
code path) sets the dwc->sysdev_is_parent flag, so we can simply avoid
the unwanted poking of the dma-mask by only doing so when that flag is
not set.

This way we only poke the dma-mask if we are actually dealing with a real
platform-device; and not when dealing with the PCI-driver instantiated
faux platform-device, fixing the regression.

> I also think the xhci driver will call dma_set_mask_and_coherent again
> later on when dwc3 is used in host mode.

The Intel Cherry Trail SoC has a separate full/normal XHCI controller for
host mode and the DWC3 controller is only used in gadget mode.

Regards,

Hans

