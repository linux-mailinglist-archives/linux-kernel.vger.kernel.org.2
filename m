Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7266E39DDD4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFGNlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:41:15 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:44901 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFGNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:41:14 -0400
Received: by mail-ed1-f47.google.com with SMTP id u24so20376370edy.11;
        Mon, 07 Jun 2021 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oGFBlgBLyzhRt0x9A/yUTSQ7KPpouVWWWPkzxriHNTE=;
        b=A/E/yimhVnbc1uUYCbaeLg0ecA/qAyFuYjFBJ1ZEXy7XYnZTXJdhcyC0bP9th1Rb6f
         5Ds5M+91RdnLCDhBVVGzHskwarMMhlFucQ6L+fGt+J/y/WEpNnTWX4vszKR69m/jktAo
         nJ2Ktoac/pCqFrWLZrRAYkP0/0+oCIZKNm65zVyxZEROBAAhQqKOs8Hm6tVCLENmjVg/
         nK+ZNmRo5Scrw+i85YeJHKMJIGQ6I2H6/GLwsYgHUbX++wZFS4pOJAHry2L+M2bsAG8X
         EEad3KztdPZombtI5QN2y0g9ZW4SmeT29eyDIPqxbkGd+aFBIa1EyRpHQ2jVCPgrseqo
         1c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oGFBlgBLyzhRt0x9A/yUTSQ7KPpouVWWWPkzxriHNTE=;
        b=ExwwHD6ModQAH5RKlqy4OmiXZdfiZR5o9PCwUtpztnO9fRhb1Tja5s8mKpQVurMGfQ
         xTYBm2xfJxZard13GLNDrdoE5YIKXQGdc7847XxKlaSzEN/HVztoIB2sUdLGt4j9w7Cv
         h8PNGzij7vfIkC7u4F2BlCQGIJHseYYT2Pw1J1/Ssj8hPUSKtmNbs7kRb+02tkeyTZnt
         o0LoS8lAmYyw3ftxdm0qwtJd3yU5fG4qnPnlFDZy50wfOfdfOW+08E/4J+PcM2Hxwho3
         G5T/bMDtDjpt9gYmC4U95WzjX9MKYTfWOpF/5zJiXnLWElorKjgv96YDFeuM9SmMWggX
         wTcw==
X-Gm-Message-State: AOAM532NGPta9fDu/gsc+cbn7K3BtAdi5gF+JIhhVdCDBVtzD8Q/yL2L
        4icfyHe1L3ifOi2asb7vT8hR8fLzfktTJg==
X-Google-Smtp-Source: ABdhPJxO0xm6ZNPBn+B1ByLwe5VVdM+n8YQh/IbYgE+i1X+odT456LvWSWJ2iRa0NVOa3HxwH1Ax8A==
X-Received: by 2002:aa7:db90:: with SMTP id u16mr19836591edt.106.1623073092593;
        Mon, 07 Jun 2021 06:38:12 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r29sm995173edc.52.2021.06.07.06.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 06:38:12 -0700 (PDT)
Subject: Re: [PATCH v7 1/5] dt-bindings: phy: rename phy nodename in
 phy-rockchip-inno-usb2.yaml
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        linux-phy@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210601164800.7670-1-jbx6244@gmail.com>
 <20210601164800.7670-2-jbx6244@gmail.com> <YLhukPL7jSx3+dBj@vkoul-mobl>
 <3601774.Dhsi8hcfAM@diego>
 <CAL_Jsq+xE7UfXcr-RTkxB8gZej8M52Fk-yM3yYA3KA7mMn50ng@mail.gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <e7e09072-9cac-413e-dca2-e2a668c1807e@gmail.com>
Date:   Mon, 7 Jun 2021 15:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+xE7UfXcr-RTkxB8gZej8M52Fk-yM3yYA3KA7mMn50ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 3:16 PM, Rob Herring wrote:
> On Thu, Jun 3, 2021 at 3:58 AM Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Hi Vinod,
>>
>> Am Donnerstag, 3. Juni 2021, 07:54:24 CEST schrieb Vinod Koul:
>>> On 01-06-21, 18:47, Johan Jonker wrote:
>>>> The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
>>>> in phy-provider.yaml has required "#phy-cells" for phy nodes.
>>>> The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
>>>> Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
>>>> notifications. Remove unneeded "#phy-cells" from parent node.
>>>> Also sort example.
>>>>
>>>> make ARCH=arm dtbs_check
>>>> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
>>>> phy/phy-provider.yaml
>>>>
>>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml       | 11 +++--------
>>>>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml       |  4 ++--
>>>
>>> I dont have grf.yaml, I guess it would be easier to split this into two
>>> or apply this thru rockchip tree. If you prefer latter:
>>>
>>> Acked-By: Vinod Koul <vkoul@kernel.org>
>>
>> before we do any more rounds, I'll just do that with your Ack, thanks :-)
> 
> This is generating warnings on linux-next now:
> 
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.example.dt.yaml:
> syscon@ff770000: usb2phy@e450: '#phy-cells' does not match any of the
> regexes: 'pinctrl-[0-9]+'
> From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.example.dt.yaml:
> usb2phy@e450: '#phy-cells' does not match any of the regexes:
> 'pinctrl-[0-9]+'
> From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> 
> Rob
> 

Hi Rob, Heiko,

Sorry...
That '#phy-cells' in the grf.yaml example also needs to go.

Is that something Heiko can fix in his git tree or
do I have to resubmit the complete patch or just a fix?
Please advise.

Kind regards,

Johan

===
> 
> examples:
>   - |
>     #include <dt-bindings/clock/rk3399-cru.h>
>     #include <dt-bindings/interrupt-controller/arm-gic.h>
>     #include <dt-bindings/power/rk3399-power.h>
>     grf: syscon@ff770000 {
>       compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
>       reg = <0xff770000 0x10000>;
>       #address-cells = <1>;
>       #size-cells = <1>;
> 
>       mipi_dphy_rx0: mipi-dphy-rx0 {
>         compatible = "rockchip,rk3399-mipi-dphy-rx0";
>         clocks = <&cru SCLK_MIPIDPHY_REF>,
>                  <&cru SCLK_DPHY_RX0_CFG>,
>                  <&cru PCLK_VIO_GRF>;
>         clock-names = "dphy-ref", "dphy-cfg", "grf";
>         power-domains = <&power RK3399_PD_VIO>;
>         #phy-cells = <0>;
>       };
> 
>       u2phy0: usb2phy@e450 {
>         compatible = "rockchip,rk3399-usb2phy";
>         reg = <0xe450 0x10>;
>         clocks = <&cru SCLK_USB2PHY0_REF>;
>         clock-names = "phyclk";
>         #clock-cells = <0>;
>         clock-output-names = "clk_usbphy0_480m";

>         #phy-cells = <0>;

Remove

> 
>         u2phy0_host: host-port {
>           #phy-cells = <0>;
>           interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>;
>           interrupt-names = "linestate";
>          };
> 
>         u2phy0_otg: otg-port {
>           #phy-cells = <0>;
>           interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>,
>                        <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH 0>,
>                        <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>;
>           interrupt-names = "otg-bvalid", "otg-id",
>                             "linestate";
>         };
>       };
>     };



