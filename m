Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0E336C9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhD0QsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhD0QsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:48:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976A7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:47:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a11so319229plh.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NmKnwiLGhS7QDsfVN1T99rYUvgc2HjL1BnpzApmJFOg=;
        b=hVhpoueRPHcifeuHTe13QGhNleDkuj2XlfrXdR4Q7dglJgkgeyxgkTxizeRBAG5WH2
         3pBdk+KrizenjFf/Yl1ncrvC9WZEOeSJPu6VxlUA7B8PbHBwJnKGEXBfIo7CVu1tjfHr
         rg6ajV4ePdbI4hLA/LM7PAl/lFjS7p4KWrZOsQVVumwSCN9h43rDZ5nTg73M73VHMpcV
         K8XHUIWNmGdRehvwhtCByhlOrJRxsSlyO9BEhC+ex5oUkp1VR6CpPZKlKq7U9trsKPB0
         uEnUvoFAkS23WbMEYSAoOv9dtM5HJ4rAeAgnv6616IyJ7h1NQ4zrK+A88jN2+bAYk0wv
         DS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmKnwiLGhS7QDsfVN1T99rYUvgc2HjL1BnpzApmJFOg=;
        b=H06jUPJk6+rSr2hlXCSrMPrE7MKGNW0YALF8wvk+FvIcf5DlaKShgG7ym9YQ0MtsPC
         jDloHsYrmtflCgNu2Ru+Be1go8w+3pFBXsxbf7Yzf0DI1MMjOMGUYRapZsmUW4fZSPfk
         XeyYLHhdMVMAyeVeQ/N2ZBxCaBhqh0a5Z2WJSfJDLcA0boKYA8d3OFUNrnpX6r2AzFbC
         udEygYnEnCEYF+21tDJs4J32j6h2vz9Zv12N2hdkV5Ilsett9d5HwhYxZdQYz4oG/Fk0
         c7dJHMxZgyoHQwdm1F4YJDpJ3DWHD+s0T2wipiyl3O0bQycz2lU9OeN8AuGTyx7zCZBP
         cxUA==
X-Gm-Message-State: AOAM5306jGFMUA1HonYSQ9X7XM6ZNIb9lgTMGd5CQ6AhoTVncht+uo3l
        CYr3uDuwOLRiOPGiVTpW74vE5yWq+Ds=
X-Google-Smtp-Source: ABdhPJxb46F8V7PRpZtf0A1cdj0ZhfV6yDFi+rDSIObrppYEG8KguQ9bCsn6o68j7vUj5ZcumFrOWw==
X-Received: by 2002:a17:90a:7e02:: with SMTP id i2mr5724836pjl.58.1619542037659;
        Tue, 27 Apr 2021 09:47:17 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s32sm3062135pfw.2.2021.04.27.09.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 09:47:17 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by
 default""
To:     Saravana Kannan <saravanak@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com>
 <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com>
 <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin> <20210427151042.j7hku7pxqz56uyt6@bogus>
 <CAGETcx8Xt3SNoWS68+DjmAero1kuu8qsg=A9Yt2coXuKSqHMuw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <895035b1-ac05-b193-ec3f-090a767305fc@gmail.com>
Date:   Tue, 27 Apr 2021 09:47:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx8Xt3SNoWS68+DjmAero1kuu8qsg=A9Yt2coXuKSqHMuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2021 9:24 AM, Saravana Kannan wrote:
> On Tue, Apr 27, 2021 at 8:10 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On Tue, Apr 27, 2021 at 03:11:16PM +0100, Cristian Marussi wrote:
>>> On Tue, Apr 27, 2021 at 09:33:31AM -0400, Jim Quinlan wrote:
>> [...]
>>>>>
>>>> I believe that the brcmstb-mbox node is in our DT for backwards
>>>> compatibility with our older Linux only.   Note that  we use the compatible
>>>> string '"arm,scmi-smc", "arm,scmi"'; the former chooses SMC transport and
>>>> ignores custom  mailboxes such as brcmstb-mbox.
>>>>
>>>
>>> Right..so it is even more wrong that it is waiting for the mailboxes...but
>>> looking at the DT:
>>>
>>> brcm_scmi_mailbox@0 {
>>>                 #mbox-cells = <0x01>;
>>>                 compatible = "brcm,brcmstb-mbox";
>>>                 status = "disabled";
>>>                 linux,phandle = <0x04>;
>>>                 phandle = <0x04>;
>>>         };
>>>
>>> brcm_scmi@0 {
>>>                 compatible = "arm,scmi-smc\0arm,scmi";
>>>                 mboxes = <0x04 0x00 0x04 0x01>;
>>>                 mbox-names = "tx\0rx";
>>>                 shmem = <0x05>;
>>>                 status = "disabled";
>>>                 arm,smc-id = <0x83000400>;
>>>                 interrupt-names = "a2p";
>>>                 #address-cells = <0x01>;
>>>                 #size-cells = <0x00>;
>>>
>>> it seems to me that even though you declare an SMC based transport (and in fact
>>> you define the smc-id too) you also still define mboxes (as a fallback I suppose)
>>> referring to the brcm_scmi_mailbox phandle, and while this is ignored by the SCMI
>>> driver (because you have selected a compatible SMC transport) I imagine this dep
>>> is picked up by fw_devlink which in fact says:
>>>
>>>> [    0.300086] platform brcm_scmi@0: Linked as a consumer to brcm_scmi_mailbox@0
>>>
>>> and stalls waiting for it. (but I'm not really familiar on how fw_devlink
>>> internals works really...so I maybe off in these regards)
> 
> Cristian,
> 
> Great debugging work for not having worked on this before! Your
> comments about the dependencies are right. If you grep the logs for
> "probe deferral", you'll see these lines and more:
> 
> [    0.942998] platform brcm_scmi@0: probe deferral - supplier
> brcm_scmi_mailbox@0 not ready
> [    3.622741] platform 8b20000.pcie: probe deferral - supplier
> brcm_scmi@0 not ready
> [    5.695929] platform 840c000.serial: probe deferral - supplier
> brcm_scmi@0 not ready
> 
> Florian,
> 
> Sorry I wasn't clear in my earlier email. I was asking for the path to
> the board file DT in upstream so I could look at it and the files it
> references. I didn't mean to ask for an "decompiled" DTS attachment.
> The decompiled ones make it a pain to track the phandles.

Our Device Tree sources are not in the kernel since the bootloader
provides a FDT to the kernel which is massaged in different ways to
support a single binary for a multitude of reference boards and chip
variants. That FDT is 90% auto-generated offline from scripts and about
10% runtime patched based on our whim. We should probably still aim for
some visibility into these Device Tree files by the kernel community.

> 
> The part that's confusing to me is that the mbox node is disabled in
> the DT you attached. fw_devlink is smart enough to ignore disabled
> nodes. Is it getting enabled by the bootloader? Can you please try
> deleting the reference to the brcm_scmi_mailbox from the scmi node and
> see if it helps? Or leave it really disabled?

Removing the 'mboxes' phandle works, see my other reply to Sudeep and I
should have captured the DT from the Linux prompt after it has been
finalized and where the mbox node is marked as enabled unfortunately.

> 
> Also, as a separate test of workarounds, can you please add
> deferred_probe_timeout=1 to your commandline and see if it helps? I'm
> assuming you have modules enabled? Otherwise, the existing smarts in
> fw_devlink to ignore devices with no drivers would have kicked in too.

deferred_probe_timeout=1 does help however all of these drivers are
built into the kernel at the moment and so ultimately we reach
user-space with no console driver registered.

> 
>> I was about to mention/ask the same when I saw Jim's reply. I see you have
>> already asked that. Couple of my opinions based on my very limited knowledge
>> on fw_devlink and how it works.
>>
>> 1. Since we have different compatible for SMC and mailbox, I am not sure
>>    if it correct to leave mailbox information in scmi node. Once we have
>>    proper yaml scheme, we must flag that error IMO.
>>
>> 2. IIUC, the fw_devlink might use information from DT to establish the
>>    dependency and having mailbox information in this context may be
>>    considered wrong as there is no dependency if it is using SMC.
> 
> If this mbox reference from scmi is wrong for the current kernel and
> never used, then I'd recommend deleting that.

Yes that seems to be the way forward unless we want to set
fw_devlink=permissive on the command line, either should hopefully be an
option.

Thanks a lot for your response!
-- 
Florian
