Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848B0369B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243807AbhDWT5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhDWT5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:57:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6F2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:56:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s14so18809936pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8GuX4Z8MuruzrMbLkQS7cSCk79x3cd4uTb8g9nIPerA=;
        b=UiO7OJ1czPbBTAt5TyRCbjKQxq+hZWnKkpXQBgfRnVAi8ezgCOESWbeizdW+o4+nVD
         52YCBowJTUq4+paEVRsGjt0vVadKxLQaoMDAhhgBeYzMGVrE9bNgXDc9FrDY8tGMbqxZ
         rzBnpBKfiQYPtJ6WxyAAt3JjWyPoXJeFrweZbdyY0cJEkgDT/xxL42c+KnPnDAg4QSiL
         oNznvqQZnfk5gNqdxkHYkB9EEQ2rrhMVtyRHcdvvkT44f4y5kWzBeY2vLiu3Sbc175iz
         z37Hx1OdNAFxenDrHTdeDkzTxdO/mO9awtN75lG344GUq64D1cjkx1ln6hzCi/drsOB/
         ilCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8GuX4Z8MuruzrMbLkQS7cSCk79x3cd4uTb8g9nIPerA=;
        b=DpBpuDZA+mqSyD6LqMRDQa1iFDnH5x64u8FIva27PB1/fh6I5gRL3QTTdfyZYy3R6L
         2Vnpdn5pvE5yJk6+dBfx3dRpvz0z8o6MDR5VzwDaPk6c4bZB+o9mz1zfBeKKlgvPFWSD
         O3AS0SN6jI3wLawkzQ76S82ktd1wDT7tdDdZCdO9Fb4LOSo4ItxXcYPl2pAEGYxYS6vD
         KOaYizXHts3UB/HYpwH3adurFLcaO4UyaPvm2lHpFY8RfgsLC/D9gE0vAghUh4pRI2vk
         IwN0vRLjaxO4wP0WHpC+BgpNpxDoCiXweV+49VFX2Ckw7S9iP+F7eJtfcZec/fbNADZl
         b/pw==
X-Gm-Message-State: AOAM532zlFitd9K1WZTOXH0LfnPofFWFJAKJ6qWXTqLTMNqDPwAWXEUr
        fpNWoFIgsx5thax31MlnAqFnQw==
X-Google-Smtp-Source: ABdhPJwqqZ+pGlpvK53FAjVOPAtbs5sEYP2BTvKy/DTSdODRRdWQvHqgVcSmp/iAv5K7AbjtWolOog==
X-Received: by 2002:a17:902:eb53:b029:ec:ce7d:62c8 with SMTP id i19-20020a170902eb53b02900ecce7d62c8mr5328640pli.8.1619207816250;
        Fri, 23 Apr 2021 12:56:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x22sm5875395pgx.19.2021.04.23.12.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 12:56:55 -0700 (PDT)
Date:   Fri, 23 Apr 2021 12:56:55 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Apr 2021 12:56:54 PDT (-0700)
Subject:     Re: [PATCH v4 0/5] Add Microchip PolarFire Soc Support
In-Reply-To: <CAOnJCUL5tLzk73GJNVXMmJmBKo_kVcAQ7OYwpi9bjKgTbabhyg@mail.gmail.com>
CC:     Conor.Dooley@microchip.com,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Daire.McNamara@microchip.com, Ivan.Griffin@microchip.com,
        Lewis.Hanly@microchip.com, aou@eecs.berkeley.edu, bjorn@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-ded61de3-071d-4c2d-a0db-122765968c90@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2021 05:31:22 PDT (-0700), atishp@atishpatra.org wrote:
> On Fri, Apr 23, 2021 at 1:44 AM <Conor.Dooley@microchip.com> wrote:
>
>> On 23/04/2021 02:37, Palmer Dabbelt wrote:
>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> > the content is safe
>> >
>> > On Thu, 22 Apr 2021 15:33:39 PDT (-0700), atishp@atishpatra.org wrote:
>> >> On Sat, Apr 17, 2021 at 8:26 PM Atish Patra <atishp@atishpatra.org>
>> >> wrote:
>> >>>
>> >>> On Mon, Mar 29, 2021 at 9:17 PM Palmer Dabbelt <palmer@dabbelt.com>
>> >>> wrote:
>> >>> >
>> >>> > On Wed, 03 Mar 2021 12:02:48 PST (-0800), Atish Patra wrote:
>> >>> > > This series adds minimal support for Microchip Polar Fire Soc
>> >>> Icicle kit.
>> >>> > > It is rebased on v5.12-rc1 and depends on clock support.
>> >>> > > Only MMC and ethernet drivers are enabled via this series.
>> >>> > > The idea here is to add the foundational patches so that other
>> >>> drivers
>> >>> > > can be added to on top of this. The device tree may change based on
>> >>> > > feedback on bindings of individual driver support patches.
>> >>> > >
>> >>> > > This series has been tested on Qemu and Polar Fire Soc Icicle kit.
>> >>> > > It depends on the updated clock-series[2] and macb fix[3].
>> >>> > > The series is also tested by Lewis from Microchip.
>> >>> > >
>> >>> > > The series can also be found at.
>> >>> > >
>> >>> https://github.com/atishp04/linux/tree/polarfire_support_upstream_v4
>> >>> > >
>> >>> > > [1]
>> >>> https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
>> >>> > > [2] https://www.spinics.net/lists/linux-clk/msg54579.html
>> >>> > >
>> >>> > > Changes from v3->v4:
>> >>> > > 1. Fixed few DT specific issues.
>> >>> > > 2. Rebased on top of new clock driver.
>> >>> > > 3. SD card functionality is verified.
>> >>> > >
>> >>> > > Changes from v2->v3:
>> >>> > > 1. Fixed a typo in dt binding.
>> >>> > > 2. Included MAINTAINERS entry for PolarFire SoC.
>> >>> > > 3. Improved the dts file by using lowercase clock names and
>> >>> keeping phy
>> >>> > >    details in board specific dts file.
>> >>> > >
>> >>> > > Changes from v1->v2:
>> >>> > > 1. Modified the DT to match the device tree in U-Boot.
>> >>> > > 2. Added both eMMC & SDcard entries in DT. However, SD card is
>> >>> only enabled
>> >>> > >    as it allows larger storage option for linux distros.
>> >>> > >
>> >>> > > Atish Patra (4):
>> >>> > > RISC-V: Add Microchip PolarFire SoC kconfig option
>> >>> > > dt-bindings: riscv: microchip: Add YAML documentation for the
>> >>> > > PolarFire SoC
>> >>> > > RISC-V: Initial DTS for Microchip ICICLE board
>> >>> > > RISC-V: Enable Microchip PolarFire ICICLE SoC
>> >>> > >
>> >>> > > Conor Dooley (1):
>> >>> > > MAINTAINERS: add microchip polarfire soc support
>> >>> > >
>> >>> > > .../devicetree/bindings/riscv/microchip.yaml  |  27 ++
>> >>> > > MAINTAINERS                                   |   8 +
>> >>> > > arch/riscv/Kconfig.socs                       |   7 +
>> >>> > > arch/riscv/boot/dts/Makefile                  |   1 +
>> >>> > > arch/riscv/boot/dts/microchip/Makefile        |   2 +
>> >>> > > .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
>> >>> > > .../boot/dts/microchip/microchip-mpfs.dtsi    | 329
>> >>> ++++++++++++++++++
>> >>> > > arch/riscv/configs/defconfig                  |   4 +
>> >>> > > 8 files changed, 450 insertions(+)
>> >>> > > create mode 100644
>> >>> Documentation/devicetree/bindings/riscv/microchip.yaml
>> >>> > > create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>> >>> > > create mode 100644
>> >>> arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>> >>> > > create mode 100644
>> >>> arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> >>> >
>> >>> > I had this left in my inbox waiting for either some reviews to
>> >>> come in or a v2,
>> >>> > but I don't see any.  Did I miss something?
>> >>> >
>> >>> Sorry for the late reply. I am on vacation until May. I think I saw
>> >>> all the patches have already been reviewed.
>> >>> Let me know if it is not the case.
>> >>>
>> >> I cross checked and all the patches are reviewed-by.
>> >> @palmer: Is it possible to take this series for 5.13 MW ?
>> >
>> > I still don't see any reviews for the mailbox driver, did it just get
>> > lost on the way to me?
>>
>> the mailbox driver has reviewed-by tags on two of the five patches (rob
>> on the dt-binding entries).
>> v6 was set on the 23rd but hasn't got any attention on the other three
>> patches yet
>> however that's not in this patch set, only depends on it
>>
>
> Thanks Conor.
>
> @palmer: This series adds the basic soc support
> for polarfire SoC. With clock driver, we can now boot.
>
> Mailbox driver series provides additional features.  Were you looking for
> reviewed-by tags for the clock driver ?

Ah, sorry.  I get this one mixed up with "Add support for the PolarFire 
SoC system controller", which I also had in my inbox because I wanted to 
make sure it didn't get dropped.  I guess I just didn't read the whole 
title and dropped this v4 because I thought the v6 was a newer version 
of the same patch set.

This is now on for-next.

Thanks!

>
>
>
>> >
>> >>
>> >>> > _______________________________________________
>> >>> > linux-riscv mailing list
>> >>> > linux-riscv@lists.infradead.org
>> >>> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>> >>>
>> >>>
>> >>>
>> >>> --
>> >>> Regards,
>> >>> Atish
>>
>>
>> --
> Regards,
> Atish
