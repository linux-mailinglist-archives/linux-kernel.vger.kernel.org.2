Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA78368A73
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 03:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbhDWBiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 21:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWBiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 21:38:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:37:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nk8so9121392pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pY+RtdgfTG8Ga9unUypOjnGgrTmTrZHcFsVJpQMU7j8=;
        b=RdWLFoBSnlIyDblw/fEjgMJAUDmc5V0f1F8RNrCd6bfvjMmgfbjWaizeyu5DniDxVQ
         9X2Uuz74Y2MtyFgznRAlT7rG7Xg3TKE8cev3PU4hdxRT9Dbb5g7GmBHuTzAgl/AAOPxp
         URNfiHZ11EYUca+tOJHzPMnqhUE9RngD7eH/Ag4QnA3/NkKkQ+6HHdeIz6QQLjp9PVUl
         V9B8YyvoLQj5XoA9jFFNPsePeuMvFh7S2UfHnPy/hYfkktN8wLhCnhAveNN2dQjeH6mb
         uIeo2etuZubn2L/Uyq+8dhvRhGf/ArSH2TEhcmIsqBCrY3EjPlS1yHt1q0HUCir6m3A0
         a2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pY+RtdgfTG8Ga9unUypOjnGgrTmTrZHcFsVJpQMU7j8=;
        b=V6fvcRxPAvgnxhyxwtWfTQJpTw0SGjp9yzHPYcy4dLnRZQXFmS2ilSOevb44RwC9vP
         F829gO7QELtB/o3k30OPkzAR+A+O9IER+cMputMi1/u4OETjMzLG/6AIbb/w+wNdi7DH
         IeoZSrDrAKkINYyOrCH3CB0CAI1OgoAw1a+nZOWYKu3n4sqF0nFrf5QQ0eQcT0otn7BU
         ACx6guCwmM2TvlATbHbCC/BkBO7ylQUJv4aniMh+AVWu1uRm6HB8knip62BHvm2juTsI
         hOvQdh1Me2srN77Qn2JJeLg5viUEakvPCrku3K5lH4TuhGWHwOmhXyIiqP9T9UrICalD
         zzPQ==
X-Gm-Message-State: AOAM530p4XDjVuGZyHXBdkY6zYd1eP2iLWRWXk7GHV0lK9r0JTp0pL0E
        PyAEIaRkquIdOs/hRZiwBzH4UQ==
X-Google-Smtp-Source: ABdhPJyeO81PpFTswF7HZ4KI8ML/nCiuE9HOmt0WmeZKYgnVJ8QqP3+Yko2ukzP9L0suofBxpJEYHA==
X-Received: by 2002:a17:90a:a789:: with SMTP id f9mr3113040pjq.192.1619141856769;
        Thu, 22 Apr 2021 18:37:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g1sm3351627pgi.64.2021.04.22.18.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:37:36 -0700 (PDT)
Date:   Thu, 22 Apr 2021 18:37:36 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 18:37:34 PDT (-0700)
Subject:     Re: [PATCH v4 0/5] Add Microchip PolarFire Soc Support
In-Reply-To: <CAOnJCUKvyDPO55QtPXDhCMKYBb70WpR01jM1F=ddA=pmFJo5_Q@mail.gmail.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, bjorn@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        Conor.Dooley@microchip.com, daire.mcnamara@microchip.com,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-8a0f200a-fc9e-4e6b-a881-433a024e8b69@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 15:33:39 PDT (-0700), atishp@atishpatra.org wrote:
> On Sat, Apr 17, 2021 at 8:26 PM Atish Patra <atishp@atishpatra.org> wrote:
>>
>> On Mon, Mar 29, 2021 at 9:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >
>> > On Wed, 03 Mar 2021 12:02:48 PST (-0800), Atish Patra wrote:
>> > > This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
>> > > It is rebased on v5.12-rc1 and depends on clock support.
>> > > Only MMC and ethernet drivers are enabled via this series.
>> > > The idea here is to add the foundational patches so that other drivers
>> > > can be added to on top of this. The device tree may change based on
>> > > feedback on bindings of individual driver support patches.
>> > >
>> > > This series has been tested on Qemu and Polar Fire Soc Icicle kit.
>> > > It depends on the updated clock-series[2] and macb fix[3].
>> > > The series is also tested by Lewis from Microchip.
>> > >
>> > > The series can also be found at.
>> > > https://github.com/atishp04/linux/tree/polarfire_support_upstream_v4
>> > >
>> > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
>> > > [2] https://www.spinics.net/lists/linux-clk/msg54579.html
>> > >
>> > > Changes from v3->v4:
>> > > 1. Fixed few DT specific issues.
>> > > 2. Rebased on top of new clock driver.
>> > > 3. SD card functionality is verified.
>> > >
>> > > Changes from v2->v3:
>> > > 1. Fixed a typo in dt binding.
>> > > 2. Included MAINTAINERS entry for PolarFire SoC.
>> > > 3. Improved the dts file by using lowercase clock names and keeping phy
>> > >    details in board specific dts file.
>> > >
>> > > Changes from v1->v2:
>> > > 1. Modified the DT to match the device tree in U-Boot.
>> > > 2. Added both eMMC & SDcard entries in DT. However, SD card is only enabled
>> > >    as it allows larger storage option for linux distros.
>> > >
>> > > Atish Patra (4):
>> > > RISC-V: Add Microchip PolarFire SoC kconfig option
>> > > dt-bindings: riscv: microchip: Add YAML documentation for the
>> > > PolarFire SoC
>> > > RISC-V: Initial DTS for Microchip ICICLE board
>> > > RISC-V: Enable Microchip PolarFire ICICLE SoC
>> > >
>> > > Conor Dooley (1):
>> > > MAINTAINERS: add microchip polarfire soc support
>> > >
>> > > .../devicetree/bindings/riscv/microchip.yaml  |  27 ++
>> > > MAINTAINERS                                   |   8 +
>> > > arch/riscv/Kconfig.socs                       |   7 +
>> > > arch/riscv/boot/dts/Makefile                  |   1 +
>> > > arch/riscv/boot/dts/microchip/Makefile        |   2 +
>> > > .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
>> > > .../boot/dts/microchip/microchip-mpfs.dtsi    | 329 ++++++++++++++++++
>> > > arch/riscv/configs/defconfig                  |   4 +
>> > > 8 files changed, 450 insertions(+)
>> > > create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
>> > > create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>> > > create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>> > > create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> >
>> > I had this left in my inbox waiting for either some reviews to come in or a v2,
>> > but I don't see any.  Did I miss something?
>> >
>> Sorry for the late reply. I am on vacation until May. I think I saw
>> all the patches have already been reviewed.
>> Let me know if it is not the case.
>>
> I cross checked and all the patches are reviewed-by.
> @palmer: Is it possible to take this series for 5.13 MW ?

I still don't see any reviews for the mailbox driver, did it just get 
lost on the way to me?

>
>> > _______________________________________________
>> > linux-riscv mailing list
>> > linux-riscv@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>>
>>
>> --
>> Regards,
>> Atish
