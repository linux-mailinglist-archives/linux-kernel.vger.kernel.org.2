Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3164A3329D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhCIPJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhCIPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:09:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D48C06174A;
        Tue,  9 Mar 2021 07:09:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k9so27550787lfo.12;
        Tue, 09 Mar 2021 07:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TUQhvaU9d4t+JJ2B1fTqa8wT4gGWtbR4DZ3I65SQook=;
        b=BG0Y41OmCahz8FVvt/xON9bIgFGI4E1G0jqU0KpwZNFSqZae14V05yCr2Cv2DWPeFy
         csZku7mUvlmtGSujGXhr7E/8tcSiBimoPTbwq1bUkHMm2F8CnoLW25Vfa3EZ4qusJpc4
         0gJ7w34caJ0miO2IFvUO8Z0iRMtBpoMh8bIVSTIeihXcNFPr4dM8Usk4oytWPf076RA5
         BFoL3L1q0ng4Gx2G2S2y+JxG+rji5Vm3UzvX5IHJqZ8qc62/XIotDbg4f5l2m3TLV0cS
         ESR7VKfXCIA3Wute82tBDDNO394TRql1CT9d3T8BP1h1uJ+p4NA1vwF3CqL5kXXwOPa7
         7Ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TUQhvaU9d4t+JJ2B1fTqa8wT4gGWtbR4DZ3I65SQook=;
        b=Bz2nPcoXTGBWsq1FjtWF/9X5ENqU8XpKOXo/ygGcB1gVzr34vorV+vQpdoRvVnye84
         5Y8bngMaL7WMZkEcFKlWYkLYMrx//47JDYJg+3ARaJ5vNI0O0qcVUWTqwJe7whtBdUX9
         AkaXjta4FXC+HoF7GC70rah+t0mx0QAX8eIabm+W6jts4jgoPi25Dt2NHKh09TipN80M
         7F3rH3oXyiHHkCc0oaPPAyh2bT1mLeLd8VedTRu6oZXi3AfD+IvL3i3ZYIa20gsJa2t+
         42talqYfN+FJd9gR9saZdxzsnXnj8SkDfRcpxKAQHDhSgPx5nX/UM8PFLmh8XpDyOB56
         VSzg==
X-Gm-Message-State: AOAM533eCwrEc1upxVMaWCQbmYEUfHILXJXKMskPFgwx/LqEPWW2kXk2
        3IGsHGFDPulQjqu0HZy1HLFyH91RD0c=
X-Google-Smtp-Source: ABdhPJyLX0nz+vqDQsi0xdKUwj4gaiVnPRY7a17X8XDkNKZS2Ypidm//Izw+VAxgolplIOl5SCvNEQ==
X-Received: by 2002:a05:6512:1106:: with SMTP id l6mr17128196lfg.204.1615302550490;
        Tue, 09 Mar 2021 07:09:10 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id x26sm1865405lfe.16.2021.03.09.07.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 07:09:09 -0800 (PST)
Subject: Re: [PATCH] usb: host: ehci-tegra: fix Kconfig depencies
To:     Arnd Bergmann <arnd@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210125113248.2268952-1-arnd@kernel.org>
 <20210125162230.GA145777@rowland.harvard.edu>
 <CAK8P3a3YkgW2fk9=YDgcVXgA6WHR9WfRdEPOyMeA1sc_Ck7AOw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8e07fae2-7d31-4943-d4dc-cfccde73e651@gmail.com>
Date:   Tue, 9 Mar 2021 18:09:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3YkgW2fk9=YDgcVXgA6WHR9WfRdEPOyMeA1sc_Ck7AOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.01.2021 00:10, Arnd Bergmann пишет:
> On Mon, Jan 25, 2021 at 5:22 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>> On Mon, Jan 25, 2021 at 12:32:30PM +0100, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Selecting the chipidea driver from the old Kconfig symbol
>>> can lead to a missing dependency:
>>
>> Arnd:
>>
>> I found this whole patch a little confusing.  For example, in the
>> sentence above, what does "the old Kconfig symbol" refer to?
>>
>> Comparing the various Kconfig files, I see what the problem is.  The
>> commit which this one fixes made CONFIG_EHCI_TEGRA select
>> CONFIG_USB_CHIPIDEA, but it didn't make EHCI_TEGRA depend on the things
>> that USB_CHIPIDEA depends on.  Can you please state this more explicitly
>> in the patch description?
> 
> Sure, I'll resend in a bit.
> 
>>> WARNING: unmet direct dependencies detected for USB_CHIPIDEA
>>>   Depends on [m]: USB_SUPPORT [=y] && (USB_EHCI_HCD [=y] && USB_GADGET [=m] || USB_EHCI_HCD [=y] && !USB_GADGET [=m] || !USB_EHCI_HCD [=y] && USB_GADGET [=m]) && HAS_DMA [=y]
>>>   Selected by [y]:
>>>   - USB_EHCI_TEGRA [=y] && USB_SUPPORT [=y] && USB [=y] && USB_EHCI_HCD [=y] && ARCH_TEGRA [=y]
>>> aarch64-linux-ld: drivers/usb/chipidea/otg.o: in function `ci_handle_vbus_change':
>>> otg.c:(.text+0x3c8): undefined reference to `usb_gadget_vbus_connect'
>>> aarch64-linux-ld: otg.c:(.text+0x42c): undefined reference to `usb_gadget_vbus_disconnect'
>>> aarch64-linux-ld: drivers/usb/chipidea/otg.o: in function `ci_otg_work':
>>> otg.c:(.text+0x5d4): undefined reference to `usb_gadget_vbus_disconnect'
>>> ...
>>>
>>> Duplicate the dependency to ensure that this driver can
>>> only be a loadable module if one of its dependencies is.
>>>
>>> Fixes: c3590c7656fb ("usb: host: ehci-tegra: Remove the driver")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/usb/host/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>>> index 160e5d3927e2..66b01b619ecd 100644
>>> --- a/drivers/usb/host/Kconfig
>>> +++ b/drivers/usb/host/Kconfig
>>> @@ -269,6 +269,7 @@ config USB_EHCI_HCD_AT91
>>>  config USB_EHCI_TEGRA
>>>       tristate "NVIDIA Tegra HCD support"
>>>       depends on ARCH_TEGRA
>>> +     depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
>>>       select USB_CHIPIDEA
>>>       select USB_CHIPIDEA_HOST
>>>       select USB_CHIPIDEA_TEGRA
>>
>> Isn't there at least one other missing dependency?  This entry selects
>> USB_CHIPIDEA_TEGRA, which depends on OF.  So shouldn't this entry also
>> depend on OF?  Or does the Kconfig system detect that for us?
> 
> Yes, there is a hard dependency on ARCH_TEGRA, which implies OF.
> 
>> Also, while I'm no expert on the Kconfig language, it seems that the new
>> "depends" line could be a lot easier to understand if it was refactored
>> with some comments added.  Yes, I realize you just copied the existing
>> dependency from the USB_CHIPIDEA entry -- that one could stand to be
>> cleaned up as well.
>>
>> For instance, how about putting the HAS_DMA part into a separate line,
>> since it's unrelated to the other stuff?
> 
> Actually it's probably best to just drop the HAS_DMA here, as it is also
> implied by ARCH_TEGRA.
> 
>>  And the rest looks like it
>> could be changed to:
>>
>>         depends on USB_EHCI_HCD || USB_GADGET
>>
>> although that probably isn't quite valid.  Still, can't it be changed to
>> something simpler than
>>
>>         (USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) ||
>>                         (!USB_EHCI_HCD && USB_GADGET)
> 
> The problem is that if either USB_EHCI_HCD or USB_GADGET are loadable
> modules, then USB_CHIPIDEA must not be built-in, but if one of the two is
> disabled, we must still have a dependency on the other. I guess it could be
> rewritten into
> 
>       depends on USB_EHCI_HCD || USB_GADGET  # needs at least one of the two
>       depends on m ||  USB_EHCI_HCD!=m # must be =m if USB_EHCI_HCD=m
>       depends on m ||  USB_GADGET!=m # must be =m if USB_GADGET=m
> 
> I see that USB_EHCI_TEGRA already depends on USB_EHCI_HCD,
> so I think this collapses into a much simpler
> 
>       depends on USB_GADGET || USB_GADGET=n # for USB_CHIPIDEA
> 
>          Arnd
> 

It looks like the Chipidea's Kconfig is the problem here because it
unconditionally compiles otg.c which uses usb_gadget_* API, but the
Kconfig doesn't select nor depend on the USB_GADGET properly.
