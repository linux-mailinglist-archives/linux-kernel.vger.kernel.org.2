Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1163DF8CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 02:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhHDAP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 20:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhHDAPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:15:25 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3853C061757;
        Tue,  3 Aug 2021 17:15:13 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4GfXLl0vqkzQkBP;
        Wed,  4 Aug 2021 02:15:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1628036106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osrq7GUdFnMqBqCWbVCjowh5IkYaeAyzwUW1YGisEHQ=;
        b=TY3qFzNOTrXdQKtOHJkQwORhOmi/BKFazb2TJQ2t1DOCvYpWYaYM7GQb3JSaFjiOQgvHej
        HXfE6JHQdDt+KWZ8D/UUY/P2k3rwr2E7YxnGzg8hfQhr1kCUzdI0UDy4zS+dyv0ZALgCrO
        QLcV3VGMfacR7EMNe0EVk2seDCEftOi3cGlYgEjMdFhqWRI+2VrdCjtPBQvR0gaontrM2y
        X+l0nap3R8J+j80isbJBN1T4Rx8ZdR0nncCkynXq7V12zT9kTqIjpitzIWesNvx0IzW6kv
        4VkNvNGKieC1aqEUyllBLCqSZ/0bblPzzbpjM8mVTKtCYziRFRd+6RaR1x1QRA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id IUKY_tgvliXS; Wed,  4 Aug 2021 02:15:05 +0200 (CEST)
Subject: Re: Aw: [PATCH 0/2] Add MUSB for MT7623
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
From:   Sungbo Eo <mans0n@gorani.run>
Message-ID: <f3607979-ea50-fc1c-0afe-a55881aa24f0@gorani.run>
Date:   Wed, 4 Aug 2021 09:14:55 +0900
MIME-Version: 1.0
In-Reply-To: <trinity-0f9449b8-5114-46e5-9a4f-00b62155a938-1628010948338@3c-app-gmx-bs54>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A1035183B
X-Rspamd-UID: 235c2f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On 2021-08-04 02:15, Frank Wunderlich wrote:
> Hi,
> 
>> Gesendet: Dienstag, 03. August 2021 um 17:13 Uhr
>> Von: "Sungbo Eo" <mans0n@gorani.run>
>> An: linux-mediatek@lists.infradead.org
>> Cc: "Chunfeng Yun" <chunfeng.yun@mediatek.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rob Herring" <robh+dt@kernel.org>, "Matthias Brugger" <matthias.bgg@gmail.com>, "Min Guo" <min.guo@mediatek.com>, "Frank Wunderlich" <frank-w@public-files.de>, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Sungbo Eo" <mans0n@gorani.run>
>> Betreff: [PATCH 0/2] Add MUSB for MT7623
>>
>> These patches add support for the MUSB controller on Mediatek MT7623.
>> Tested on Mercury RUSH-318AC Wi-Fi router.
>>
>> I got to know this from a BPI-R2 forum post [1], and managed to make it work on OpenWrt snapshot.
>> I'd like to know if this also works on BPI-R2, I can happily share the details if needed.
>> And I've just copy & pasted nodes from mt2701, please let me know if I missed some big differences between SoCs...
>>
>> [1] http://forum.banana-pi.org/t/bpi-r2-otg-port/10551
> 
> thanks for working on it. do both otg-roles (host/client) work on your device?

Yes, I tested it with host mode and device mode.
I also tried manual role-switch via sysfs and it worked with some prior setup.
Note that my device has a USB Type-A connector and not micro B, so I can't help with id pin stuff...

> 
> unfortunately at least host-mode does not work (do not know how to test client mode). i guess because iddig and vusb nodes are missing.
> 
> i took your Patchset and enabled the usb-node for bpi-r2.
> 
> +&usb3 {
> +       status = "okay";
> +};
> 
> and added these config-symbols:
> 
> +CONFIG_USB_CONN_GPIO=y
> +CONFIG_USB_MUSB_HDRC=y
> +CONFIG_USB_MUSB_MEDIATEK=y
> +CONFIG_NOP_USB_XCEIV=y
> +CONFIG_USB_CONFIGFS=y
> +#CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> +#CONFIG_PHY_MTK_TPHY=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_MUSB_DUAL_ROLE=y
> +CONFIG_USB_INVENTRA_DMA=y
> 
> btw. imho otg-node should be named usb0 as other dts (kernel 4.4) also use usb0, else i think it's confusing.

You certainly have a point. I'll follow your suggestion. Thanks!

> 
> in my last attempt i had these below usb-node in boards devicetree:
> 
> +       usb_vbus: regulator@0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&pio 237 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       connector{
> +               compatible = "gpio-usb-b-connector", "usb-b-connector";
> +               type = "micro";
> +               id-gpios = <&pio 44 GPIO_ACTIVE_HIGH>;
> +               vbus-supply = <&usb_vbus>;
> +       };
> 
> after adding these i see the connection of otg-cable with usb-stick in dmesg:
> 
> [   53.656304] usb-conn-gpio 11200000.usb:connector: repeated rot
> [   53.696324] usb-conn-gpio 11200000.usb:connector: repeated role: host
> 
> but usb-stick is not powered (led of the stick is off) and of course i see no mass-storage device.

I observed the same symptom (but different error log).

[    2.722253] musb-hdrc musb-hdrc.1.auto: VBUS_ERROR in a_idle (80, <SessEnd), retry #0, port1 00000104

In my case adding `regulator-always-on;` in the regulator node solved the problem temporarily.
But after that I switched to relying on pinctrl.

+&pio {
+       musb_pins: musb {
+               pins-musb {
+                       pinmux = <MT7623_PIN_237_EXT_SDIO2_FUNC_DRV_VBUS>;
+               };
+       };
+};
+
+&usb3 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&musb_pins>;
+       status = "okay";
+
+       dr_mode = "host";
+
+       connector {
+               compatible = "usb-a-connector";
+       };
+};

root@OpenWrt:~# lsusb -t
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=, Driver=usb-storage, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-mtk/1p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-mtk/1p, 480M

I tested device mode with legacy CDC composite device module.
You can also take more complicated configfs approach, though.
https://elinux.org/images/e/ef/USB_Gadget_Configfs_API_0.pdf

+       dr_mode = "host";
-       dr_mode = "peripheral";

root@OpenWrt:/# insmod g_cdc
[   64.565254] using random self ethernet address
[   64.569711] using random host ethernet address
[   64.575966] usb0: HOST MAC 26:36:2d:e5:8f:6f
[   64.580501] usb0: MAC 92:d7:f9:c7:88:01
[   64.584409] g_cdc gadget: CDC Composite Gadget, version: King Kamehameha Day 2008
[   64.592454] g_cdc gadget: g_cdc ready

I also tried usb-role-switch,

-       dr_mode = "host";
+       usb-role-switch;

After boot the initial mode of musb is "none", and it did not turn vbus on even if I set it to host mode.
Later I found out that I need to load any gadget driver before setting it to host mode.

# echo peripheral > /sys/devices/platform/11200000.usb/musb-hdrc.1.auto/mode
# insmod g_cdc
# echo host > /sys/devices/platform/11200000.usb/musb-hdrc.1.auto/mode

That's all I know. Please let me know if I skipped some details.
Thanks.

> 
> and now i'm back on the traceback on power down i've reported Author of musb driver some time ago
> 
> [  156.785185] WARNING: CPU: 0 PID: 1 at drivers/power/reset/mt6323-poweroff.c:4
> [  156.795156] Unable to power off system
> 
> [  156.884496] [<c0cca1ec>] (warn_slowpath_fmt) from [<c090562c>] (mt6323_do_pw)
> [  156.893203]  r8:c3296d40 r7:00000024 r6:0ccccb60 r5:c10fe3d8 r4:00000000
> [  156.900030] [<c09054b0>] (mt6323_do_pwroff) from [<c010ba68>] (machine_power)
> [  156.908558]  r8:fee1dead r7:c1312590 r6:92f61d00 r5:00000000 r4:4321fedc
> [  156.915385] [<c010ba34>] (machine_power_off) from [<c01524bc>] (kernel_power)
> 
> i guess it's related to the usb_vbus.
> 
> regards Frank
> 
