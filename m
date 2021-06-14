Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51B73A71F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 00:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhFNWdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 18:33:42 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:54256 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhFNWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:33:41 -0400
Received: by mail-pj1-f53.google.com with SMTP id ei4so10618253pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=70OFgrz/CgZYU63H5upJDLWkyC7MeK33Rz+09jwywK4=;
        b=q0DGUYEBsR1Wd7MyTCOUMhEO/pYWZKf8S3lBCgsCHWEOJGuiiV0CAYBRXS/F9X7T3/
         qVYgl/rmYI7oYLzyAV8o/CtU/Oqt4mC/Vzme5RWIJQDWayLlm/atSkprAoZrLOLoHcFH
         LtB2fCu7O6l5kmWA/HOEfiWto8OvHbopWHsnbwV2TX/0XQzY8/qDx/+WY/bKdLHy3unR
         yaGaTnfQYGvcFWZsQZTrHfe55DWm9KKPTnFZ5JduTEfbq25t1hZbo2+8i0YORpYi9Rbp
         rTmVuXj2MyyoNoCVXaecdUmzMvqO+qNcAjtYD9ftQaHQHgv6BU3xPXpAwzLJydUBmqJm
         tcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=70OFgrz/CgZYU63H5upJDLWkyC7MeK33Rz+09jwywK4=;
        b=JQZv00Ncd6joszIJc6BzKhW8TYBCd0+3KW422gfurkC4t3ZGSzsfk3DtWAgmkHdK0H
         uNzrfphpNJyJ4riNxfKv+sqzHh+EJfKUq5x5T2syGh/w7QGQ6Pnkp3LuLHME3vvzKCnw
         vTyiBlQmnDDG66BOgQq084wO/fxoXuKEIiwvThHZPXqg7Bj/zHngiXjItr/DDA075VDt
         GctwtdofFoj2cMz5XSlw0ExkVN6yRjmGULtuD8zFfiQPbLcJBqiDureZHdPpdct2M6uM
         d8THEbE4CWNhUci6Ah3dovWkcOL+IaoWqlU0ZsV/oPlytMVpPiX2EyiPqLH5fiEH57ce
         LFQw==
X-Gm-Message-State: AOAM530Ozy6Gt1hKolQow8y2DZbmcDUOszhU4F/4XUcg8dfrf8y7QsEG
        wKyXSKP1gYtZz0cw2asfby/ryA==
X-Google-Smtp-Source: ABdhPJwGGoYzguT8I9l/jIiDPz+FK0UawrWbYcIw8QuXkcT/GKcbrs0gkwY4fqmlIzmr5c7vITO2Zw==
X-Received: by 2002:a17:90b:1810:: with SMTP id lw16mr20990555pjb.203.1623709823827;
        Mon, 14 Jun 2021 15:30:23 -0700 (PDT)
Received: from localhost ([2601:602:9200:1465:3130:f4da:b90:8ba2])
        by smtp.gmail.com with ESMTPSA id 25sm491336pgp.51.2021.06.14.15.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 15:30:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build
 as a module
In-Reply-To: <87r1hwwier.wl-maz@kernel.org>
References: <20201020072532.949137-1-narmstrong@baylibre.com>
 <20201020072532.949137-2-narmstrong@baylibre.com>
 <7hsga8kb8z.fsf@baylibre.com>
 <CAF2Aj3g6c8FEZb3e1by6sd8LpKLaeN5hsKrrQkZUvh8hosiW9A@mail.gmail.com>
 <87r1hwwier.wl-maz@kernel.org>
Date:   Mon, 14 Jun 2021 15:30:22 -0700
Message-ID: <7h7diwgjup.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:

> On Fri, 21 May 2021 10:47:48 +0100,
> Lee Jones <lee.jones@linaro.org> wrote:
>> 
>> [1  <text/plain; UTF-8 (quoted-printable)>]
>> On Tue, 20 Oct 2020 at 19:23, Kevin Hilman <khilman@baylibre.com> wrote:
>> 
>> > Neil Armstrong <narmstrong@baylibre.com> writes:
>> >
>> > > In order to reduce the kernel Image size on multi-platform distributions,
>> > > make it possible to build the Amlogic GPIO IRQ controller as a module
>> > > by switching it to a platform driver.
>> > >
>> > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> >
>> > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>> > Tested-by: Kevin Hilman <khilman@baylibre.com>
>> >
>> > Tested as a module on meson-sm1-khadas-vim3l where the wired networking
>> > uses GPIO IRQs.
>> >
>> 
>> Good morning Neil, Kevin,
>> 
>> What happened to this set in the end?  I still don't see it in Mainline.
>
> Last time I tried this patch, it broke my test setup in non-obvious
> ways. Has someone checked that the issue I reported back then has been
> resolved now that fw_devlink is more usable?

OK, after much anticipation (and much delay due to me forgetting about
this), I just gave this series a spin again on top of v5.13-rc6, and it
seems to work fine with `fw_devlink=on`

I started with your config[1] and accepting all the defaults of any new
configs.  IOW, I ran: yes '' | make oldconfig after copying your config
to .config.

With that it seems to be working fine for me.

Right after boot (and before network probes) I see module loaded, but no
users yet in /proc/interrupts:

/ # uname -a
Linux buildroot 5.13.0-rc6-00002-g679c8e852942 #5 SMP PREEMPT Mon Jun 14 15:08:40 PDT 2021 aarch64 GNU/Linux
/ # lsmod |grep gpio
irq_meson_gpio         20480  0
leds_gpio              16384  0
/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  9:          0          0          0          0     GICv2  25 Level     vgic
 11:          0          0          0          0     GICv2  30 Level     kvm guest ptimer
 12:          0          0          0          0     GICv2  27 Level     kvm guest vtimer
 13:       1416        916        534       1421     GICv2  26 Level     arch_timer
 15:          5          0          0          0     GICv2  89 Edge      dw_hdmi_top_irq, ff600000.hdmi-tx
 22:         38          0          0          0     GICv2 225 Edge      ttyAML0
 23:         20          0          0          0     GICv2 227 Edge      ff805000.i2c
 25:          2          0          0          0     GICv2 232 Edge      ff809000.adc
 28:        322          0          0          0     GICv2  35 Edge      meson
 31:          0          0          0          0     GICv2 222 Edge      ffe05000.sd
 32:        787          0          0          0     GICv2 223 Edge      ffe07000.mmc
 34:          0          0          0          0     GICv2 194 Level     panfrost-job
 35:          0          0          0          0     GICv2 193 Level     panfrost-mmu
 36:          3          0          0          0     GICv2 192 Level     panfrost-gpu
 39:          0          0          0          0     GICv2  63 Level     ff400000.usb, ff400000.usb
 40:         32          0          0          0     GICv2  62 Level     xhci-hcd:usb1
IPI0:       425        544        664        925       Rescheduling interrupts
IPI1:        86        166        269        136       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrupts
Err:          0

So then I init the network interface and PHY works, DHCP works etc.

/ # udhcpc
udhcpc: started, v1.31.1
[  102.250449] meson8b-dwmac ff3f0000.ethernet eth0: PHY [0.0:00] driver [RTL8211F Gigabit Ethernet] (irq=37)
[  102.256413] meson8b-dwmac ff3f0000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
[  102.269433] meson8b-dwmac ff3f0000.ethernet eth0: No Safety Features support found
[  102.271357] meson8b-dwmac ff3f0000.ethernet eth0: PTP not supported by HW
[  102.278493] meson8b-dwmac ff3f0000.ethernet eth0: configuring for phy/rgmii link mode
udhcpc: sending discover
[  104.743301] meson8b-dwmac ff3f0000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[  104.746470] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
udhcpc: sending discover
udhcpc: sending select for 192.168.0.122
udhcpc: lease of 192.168.0.122 obtained, lease time 600
deleting routers
adding dns 192.168.0.254
adding dns 192.168.0.254
/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  9:          0          0          0          0     GICv2  25 Level     vgic
 11:          0          0          0          0     GICv2  30 Level     kvm guest ptimer
 12:          0          0          0          0     GICv2  27 Level     kvm guest vtimer
 13:       1575       1018        604       1588     GICv2  26 Level     arch_timer
 14:          8          0          0          0     GICv2  40 Level     eth0
 15:          5          0          0          0     GICv2  89 Edge      dw_hdmi_top_irq, ff600000.hdmi-tx
 22:        132          0          0          0     GICv2 225 Edge      ttyAML0
 23:         20          0          0          0     GICv2 227 Edge      ff805000.i2c
 25:          2          0          0          0     GICv2 232 Edge      ff809000.adc
 28:        322          0          0          0     GICv2  35 Edge      meson
 31:          0          0          0          0     GICv2 222 Edge      ffe05000.sd
 32:        787          0          0          0     GICv2 223 Edge      ffe07000.mmc
 34:          0          0          0          0     GICv2 194 Level     panfrost-job
 35:          0          0          0          0     GICv2 193 Level     panfrost-mmu
 36:          3          0          0          0     GICv2 192 Level     panfrost-gpu
 37:          2          0          0          0  meson-gpio-irqchip  26 Level     0.0:00
 39:          0          0          0          0     GICv2  63 Level     ff400000.usb, ff400000.usb
 40:         32          0          0          0     GICv2  62 Level     xhci-hcd:usb1
IPI0:       476        567        720        956       Rescheduling interrupts
IPI1:        93        166        270        137       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrupts
Err:          0
/ #


Kevin


[1] http://www.loen.fr/tmp/Config.full-arm64



