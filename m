Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5154036C96B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhD0Q1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbhD0Q02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:26:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E5C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:24:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v20so3902136plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sz9P7MFs8zTLBNG+2+2rZi1XeoWMwNscYNT1QWJ7kT8=;
        b=WB6RYzrV/IWNcQ9HN0129xjN5zWiKD/0ZgO3v4ihzUMKrzT5MlrcMfu96fuRKRXsk6
         WtAqxWOeOTX6Q8CPDkPO5WpgSrMZ7EHnv/vWYVc9lJOCqdJmXpMh4P0da0iG8k37Mhq4
         YPJYzGVDRu+nIgsfo1xvVw7bIBtreFRPPfHTpnOzEHKKTAwTbqGSO1YIXp8RkYIUYd2W
         brSbPpG0ZYPuxqqxdwLxxn8xSlTIlnw/c+GAgKGmOLbpODt3QaECUwcIt4yH/4jnnNHS
         8aSG6C+dnyhbWUmmhr+thix1TIlWyy9WTw7xc8a3q3zbgIJGChSVWDSrvxUYk0j7/0X4
         y/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sz9P7MFs8zTLBNG+2+2rZi1XeoWMwNscYNT1QWJ7kT8=;
        b=kJ2x3fpC4/Gg/jbgLD7hZG/oBiSjuUa2htMOq1zL1Yw9W/7ue/D1TFmTLuIExngDEr
         idjiFUaj2c0lGG+DjT3yLxvz6j2+q4zC53+d+A0WK0C2Kj8lXHyAYkaXr9SN/2gsOkxw
         FqaaLnXDl/oO8n2sZGiV3FIt6C3wWtjrusABrYYuCK6iUG+8ZUSi4FduxtaeapOzMMNv
         0dDdzIVWbk7IQqyitpN2kx71dhmLwSZb98+vaTyiFcG3MeLluFURR4IrOpPNRVSjC7/O
         WsL1ZAvcO3iFfKR3pirJv6BVX59q8Eukf+2vdn1uz4RYPFg43QFoMldYE3eZsA7NoWUN
         lJTw==
X-Gm-Message-State: AOAM531oSOmosaHS8HMYD83EWsJ1sMzqAG5yiHwNUxnrZAxmnnp+MK1e
        H/8YAB4ae/efVvxsg02Mc9E+hMzvcd0=
X-Google-Smtp-Source: ABdhPJwceHSFzjKqBTvxv8EPgfv6Qhp1IgB7Lq4Q62wvHOJC8c9jU16fNPaY7Sq7RQZtGVXs7e+uRw==
X-Received: by 2002:a17:902:d50c:b029:ed:1bda:a029 with SMTP id b12-20020a170902d50cb02900ed1bdaa029mr14321373plg.8.1619540697947;
        Tue, 27 Apr 2021 09:24:57 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id w23sm217583pgi.63.2021.04.27.09.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 09:24:57 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by
 default""
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Saravana Kannan <saravanak@google.com>,
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0887ce92-e9d8-47ec-0077-4c1f2fd46f87@gmail.com>
Date:   Tue, 27 Apr 2021 09:24:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427151042.j7hku7pxqz56uyt6@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2021 8:10 AM, Sudeep Holla wrote:
> On Tue, Apr 27, 2021 at 03:11:16PM +0100, Cristian Marussi wrote:
>> On Tue, Apr 27, 2021 at 09:33:31AM -0400, Jim Quinlan wrote:
> [...]
>>>>
>>> I believe that the brcmstb-mbox node is in our DT for backwards
>>> compatibility with our older Linux only.   Note that  we use the compatible
>>> string '"arm,scmi-smc", "arm,scmi"'; the former chooses SMC transport and
>>> ignores custom  mailboxes such as brcmstb-mbox.
>>>
>>
>> Right..so it is even more wrong that it is waiting for the mailboxes...but
>> looking at the DT:
>>
>> brcm_scmi_mailbox@0 {
>>                 #mbox-cells = <0x01>;
>>                 compatible = "brcm,brcmstb-mbox";
>>                 status = "disabled";
>>                 linux,phandle = <0x04>;
>>                 phandle = <0x04>;
>>         };
>>
>> brcm_scmi@0 {
>>                 compatible = "arm,scmi-smc\0arm,scmi";
>>                 mboxes = <0x04 0x00 0x04 0x01>;
>>                 mbox-names = "tx\0rx";
>>                 shmem = <0x05>;
>>                 status = "disabled";
>>                 arm,smc-id = <0x83000400>;
>>                 interrupt-names = "a2p";
>>                 #address-cells = <0x01>;
>>                 #size-cells = <0x00>;
>>
>> it seems to me that even though you declare an SMC based transport (and in fact
>> you define the smc-id too) you also still define mboxes (as a fallback I suppose)
>> referring to the brcm_scmi_mailbox phandle, and while this is ignored by the SCMI
>> driver (because you have selected a compatible SMC transport) I imagine this dep
>> is picked up by fw_devlink which in fact says:
>>
>>> [    0.300086] platform brcm_scmi@0: Linked as a consumer to brcm_scmi_mailbox@0
>>
>> and stalls waiting for it. (but I'm not really familiar on how fw_devlink
>> internals works really...so I maybe off in these regards)
>>
> 
> I was about to mention/ask the same when I saw Jim's reply. I see you have
> already asked that. Couple of my opinions based on my very limited knowledge
> on fw_devlink and how it works.
> 
> 1. Since we have different compatible for SMC and mailbox, I am not sure
>    if it correct to leave mailbox information in scmi node. Once we have
>    proper yaml scheme, we must flag that error IMO.

This is a self inflicted problem that we have in that the bootloader
provides a Device Tree to the kernel which is massaged in different ways
and intends to stay backwards compatible as much as possible. And indeed
after removing the 'mboxes' property gets us going with fw_devlink=on.

> 
> 2. IIUC, the fw_devlink might use information from DT to establish the
>    dependency and having mailbox information in this context may be
>    considered wrong as there is no dependency if it is using SMC.

Right, unfortunately, short of having some special casing for SCMI and
checking that if we have both an "arm,smc-id" and "mboxes" phandle we
should prefer the former, there is not probably much that can be done
here. Do we want to do that?

Thank you all for looking into this!
-- 
Florian
