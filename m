Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F183E0C1E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 03:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhHEBfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 21:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhHEBfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 21:35:08 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F75C061765;
        Wed,  4 Aug 2021 18:34:55 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4GgB4B36xPzQk2m;
        Thu,  5 Aug 2021 03:34:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1628127286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE+O5cegW+iGebRWUhEH5E4wIAzdvgqgde4doV7RxnQ=;
        b=vTi3Q3bMHhE54KV89e8W4EIYg7qQRDhTc58ZeJ0z1tt+6aDO+XQ6B/FMOvSOpgdS1NrvLi
        UlXbHDDn6yTwNJ8Kxp0Rq4ikcIl35uwBFRBVQuJOEwH3wn9U4VXJO6/nQXhRKGdDkbLgvi
        pDmT0bvrKUWzAkOcyMHdGnc8Y5bypaKdDX9CKkDc5JWyLMAlZemAQuYIj6osPdbQcBe1xD
        sqjNvXTmGAgRrBnP2DxemGDX4mgM+UYNjSP2w6EhUKw+Xb6nNGyonL9R52NdSfnTuItalD
        sKUBkehXbmmMqvcHzmoeEASFCXoced4ojdrp+zMzUn6mxptWLhRnBI6XrCUNWA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id gunOhzsQxFz4; Thu,  5 Aug 2021 03:34:45 +0200 (CEST)
Subject: Re: Aw: Re: [PATCH 0/2] Add MUSB for MT7623
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210803151320.71531-1-mans0n@gorani.run>
 <trinity-0f9449b8-5114-46e5-9a4f-00b62155a938-1628010948338@3c-app-gmx-bs54>
 <f3607979-ea50-fc1c-0afe-a55881aa24f0@gorani.run>
 <trinity-8910c659-6e4e-4979-a6d0-eaf5b8bee213-1628064668849@3c-app-gmx-bap67>
From:   Sungbo Eo <mans0n@gorani.run>
Message-ID: <a6f4d24f-c79b-35e4-43fb-90eb75623dc2@gorani.run>
Date:   Thu, 5 Aug 2021 10:34:35 +0900
MIME-Version: 1.0
In-Reply-To: <trinity-8910c659-6e4e-4979-a6d0-eaf5b8bee213-1628064668849@3c-app-gmx-bap67>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6EE5B1887
X-Rspamd-UID: ce070d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-04 17:11, Frank Wunderlich wrote:
>> Gesendet: Mittwoch, 04. August 2021 um 02:14 Uhr
>> Von: "Sungbo Eo" <mans0n@gorani.run>
> 
>>> thanks for working on it. do both otg-roles (host/client) work on your device?
>>
>> Yes, I tested it with host mode and device mode.
>> I also tried manual role-switch via sysfs and it worked with some prior setup.
>> Note that my device has a USB Type-A connector and not micro B, so I can't help with id pin stuff...
> 
>>> but usb-stick is not powered (led of the stick is off) and of course i see no mass-storage device.
>>
>> I observed the same symptom (but different error log).
>>
>> [    2.722253] musb-hdrc musb-hdrc.1.auto: VBUS_ERROR in a_idle (80, <SessEnd), retry #0, port1 00000104
>>
>> In my case adding `regulator-always-on;` in the regulator node solved the problem temporarily.
>> But after that I switched to relying on pinctrl.
> 
> i've found out that usb-stick is powered if i first connect otg-cable and then the stick to the cable...regulator always on does not change anything for me (only supporess "disabling vusb" message on boot). traceback on poweroff is still there.

I tried to reproduce your usb-conn-gpio message on my machine but I failed.
Probably because my USB port does not have ID pin...

Currently OpenWrt does not enable CONFIG_POWER_RESET_MT6323 so I was not aware of the poweroff error.
After I enabled it I got the same error and I could not resolve it... I'd better disable it for now.

> 
> role switch happen on inserting stick into cable, not before (insert cable into r2) as i expected.
> 
> need to figure out which CONFIG options i need to get USB-Stick as mass storage working.

Do you mean that vbus turns on but your usb stick is not detected?
Does that change if you use `dr_mode = "host"`?

> 
> i wonder why it works on your board without the vusb/connector subnodes

Do you mean vbus subnode in musb or vusb subnode in pmic?
I've never used vusb node, it did not affect me in any way.
When I used usb_vbus regulator node to enable vbus line, it did not turn on the line unless I added `regulator-always-on`...
It seems the connector node is not really required for me.

> 
>> +&pio {
>> +       musb_pins: musb {
>> +               pins-musb {
>> +                       pinmux = <MT7623_PIN_237_EXT_SDIO2_FUNC_DRV_VBUS>;
>> +               };
>> +       };
>> +};
> 
> imho it's the same gpio used for regulator, right? whats the difference?
> i tried this instead of the regulator-node => not powered (cable first, then stick).

I don't really know how it does work, but for me it does turn on vbus in host mode and turn it off in device mode.
I imagined DRV_VBUS setup will make the musb controller itself (and not kernel) control the line as needed, but it's just my guess.

> 
>> +&usb3 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&musb_pins>;
>> +       status = "okay";
>> +
>> +       dr_mode = "host";
>> +
>> +       connector {
>> +               compatible = "usb-a-connector";
>> +       };
>> +};
>>
>> root@OpenWrt:~# lsusb -t
>> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
>>     |__ Port 1: Dev 2, If 0, Class=, Driver=usb-storage, 480M
>> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-mtk/1p, 5000M
>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-mtk/1p, 480M
>>
