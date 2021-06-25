Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DFA3B483E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFYRdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:33:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C292C061574;
        Fri, 25 Jun 2021 10:30:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p9so8294169pgb.1;
        Fri, 25 Jun 2021 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AEVXAtzRdBnXjTYBUkXKyLLq/QP8vZTU+6eBNnFCfNY=;
        b=JsNQ1EOdCmRHmdIUMwk7W+3dSlif5ZBdGuIrCU8FRyUfISBFd88dg511IEs/lMsHdL
         LV9N0ecJcHXNEXDQfGQkEGsfuJjznIUkVg+8s+omlLDP3TxJ6A5yMAIE+CZQBjJyIEVz
         Rz9/drioEC6VrGur/BAVgAjVXvPI67EKYTP5d/jXaLn952AjsxZdMsWVI1Mpr5KJaN4z
         68wrlMzUIS7LmmgVj5IfkfOuTLDSRCqB9SuTV+kZif8MzkFwQD7WvGx610ND2q966zcW
         WYqQRK1QWoog9mca9wdW1eP93dN4aGk5DFi8kdrS78VttsAP7Y5lVigkE7uRfxFQuysm
         SAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AEVXAtzRdBnXjTYBUkXKyLLq/QP8vZTU+6eBNnFCfNY=;
        b=I4nbjTYREcCtsRoDHsd1op2TgKjJZyhMpfA1Kr5f5zxM+2xGRHcseVKjOuPMV13r+j
         x1qCdP9ixJTwuUQOkgmUe6PpUk1wt05mUqqzu0xe5dGPMwlI12oxyz6WE3+VmgqRnPIB
         djW1/fiRK6/zlR2rJ5LONqBus+H3LN3nVMdz8DHlDt4rJhFRd5LZHVFAweU2DR4BH2FE
         wgjeDu+LPHeCfPyN9M5WMd1369XuNDPbcLDeCoawqdEWF0ER7pRG2o8Jcalmt1+BbvMW
         kgxJZtTTG9n0R1XZFjQujianSCrd7eIMqQQbKi9ZfLvP+sSfS2WSl10tohqngPgSsBNz
         ql6g==
X-Gm-Message-State: AOAM5326TwwVaz7g6l1Maz7IdAr+xgHAF6Fb8MC0+zJH0H7aLe7ksBhC
        keulOouQHwKN6yXVvFQyTsg=
X-Google-Smtp-Source: ABdhPJzluJfbq3Os5qaSBw+XQr/q4Y3cVOkWhKV4j4z/zfh1dpyOtoQhTFB7QOgto30AvTYLOOyS1Q==
X-Received: by 2002:a63:fc51:: with SMTP id r17mr8472427pgk.403.1624642250621;
        Fri, 25 Jun 2021 10:30:50 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s13sm6216158pgi.36.2021.06.25.10.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 10:30:49 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] ARM: dts: NSP: Add DT files for Meraki MX64 series
To:     Matthew Hagan <mnhagan88@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20210625095000.3358973-1-mnhagan88@gmail.com>
 <20210625095000.3358973-3-mnhagan88@gmail.com>
 <CAK8P3a3NAOgBa1j+Zsm6FwSm2ux49rFcnTEYJJsmSF8TggRnYA@mail.gmail.com>
 <bbf38c31-ed75-69d2-39ed-94f324b1f220@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <21e895e9-0211-0c97-5e9e-781e6d2fe6dd@gmail.com>
Date:   Fri, 25 Jun 2021 10:30:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <bbf38c31-ed75-69d2-39ed-94f324b1f220@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 10:26 AM, Matthew Hagan wrote:
> On 25/06/2021 10:59, Arnd Bergmann wrote:
> 
>> On Fri, Jun 25, 2021 at 11:52 AM Matthew Hagan <mnhagan88@gmail.com> wrote:
>>> MX64 & MX64W Hardware info:
>>>   - CPU: Broadcom BCM58625 Cortex A9 @ 1200Mhz
>>>   - RAM: 2 GB (4 x 4Gb SK Hynix H5TC4G83CFR)
>>>   - Storage: 1 GB (Micron MT29F8G08ABACA)
>>>   - Networking: BCM58625 internal switch (5x 1GbE ports)
>>>   - USB: 1x USB2.0
>>>   - Serial: Internal header
>>>   - WLAN(MX64W only): 2x Broadcom BCM43520KMLG on the PCI bus
>>>
>>> This patch adds the Meraki MX64 series-specific bindings. Since some
>>> devices make use of the older A0 SoC, changes need to be made to
>>> accommodate this case, including removal of coherency options and
>>> modification to the secondary-boot-reg.
>>>
>>> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
>> Removing the dma-coherent flags in the dts file seemed really odd until
>> I read the text above. It would seem more logical to me to have a .dtsi file
>> that has all the a0 revision specific changes, and include that from the
>> dts file.
> 
> How about having separate bcm-nsp-ax and bcm-nsp-bx dtsi files with the
> appropriate secondary-boot-reg and dma-coherent (or lack of)
> properties, which then include bcm-nsp.dtsi. Thus we can also avoid use
> of /delete-property/. Would this be preferable?

Is there any way that the Ax platforms could use a small shim between
the boot loader and the kernel which could all of the necessary DT
adaptation so the kernel only contains a single Device Tree source?

Using something like this:

https://github.com/zonque/pxa-impedance-matcher/

could be useful.

> 
>>
>> On the other hand, the /chosen, /aliases and  /memory nodes that you have
>> in the .dtsi file should probably get moved into the .dts files, as these tend
>> to be board specific settings, even if the examples you have are all
>> the same.
> 
> I did not come across any convention regarding this, though there are
> plenty of cases where the /chosen, /aliases and /memory nodes are
> defined in a .dtsi file and used by multiple similar boards. Also note
> in this case /aliases is defined in bcm-nsp.dtsi, not by me. Would we
> not prefer to avoid having 6x duplication?
> 
>>        Arnd
>>
> Matthew
> 


-- 
Florian
