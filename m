Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47B8392CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhE0L1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhE0L1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:27:46 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA6C061574;
        Thu, 27 May 2021 04:26:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o18so156365ybc.8;
        Thu, 27 May 2021 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzv6SpunBfg3gxxbotwT4IYWTA04kO5trsea2ypbug4=;
        b=QK+c/PTwQNCAYIeeq4Z4xkUMO7VLjtt3m3LwNF/E9tovCA+z1cHjIrurHZ/+x2qtoE
         6In75i9+WLoSs64PRFYrtwha9WXTAKiqg8jxxsGlE4/XumP61NVY2DZlHOOHKxd/3vhY
         X5D/7ufK5LSOfTVmL33Hemtd334MRVjVObLwY7bwISGkcGuCsnRIpgM4j27tXI4OTnwZ
         p7Nhy0xguLiicomFST6H8lzgogsDkPbMFr3OZJvmt/YXIlUUFcxRvo+C4DF+EdIgIM6/
         euS1jbFEbexN5Fdk+Wx3n3mcL7vCiEuSDNytAY3jxZbwjeFyEVVfNwXifm3IbNvX2Pfk
         6b3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzv6SpunBfg3gxxbotwT4IYWTA04kO5trsea2ypbug4=;
        b=Mf3Nd772lpNI8CZ8V3EbQy+1kwPHl6kT5e3swMVvMxOTKM20mVyDTAHyuzZROY7WiD
         XPjlRfuAKpUMz9YexlEoPGhWq3DhdQ+68A4xvyMlE13CHjhbdt0Lv23ZqWbu2ufLDOqK
         zciBn3amR7Ly0frtTuU7RbvobbBEOVD9AsU8/z5nxC9CxS61g9e3/mSqgX4l+iooRiEy
         RA56N+QBTnH0oIBkrTvQpw9uXnHEqdIElPeqejcpK2vrbupIMWrYg3IwHRg2Siqmj3rt
         oeHLPe9COr/Svj40g+2H9aW9GTJvBlxkGExvdLosjj17+7Et6TtF8RHqAtHIVq48cc+C
         em4Q==
X-Gm-Message-State: AOAM5309oBQFhQWbkIIZbeyDXWI6y7sCxps+oFhxkw3rkOi3YOv4ffLO
        7WYr6EmM0UfwZ5RWekc6S5jmGdeMAhgd3DPJr3c=
X-Google-Smtp-Source: ABdhPJzxecgBgZoRTo7GaYY515d78DbH0s23vxK0Ib0+iASmwacntd5adDNCI5BhPTAxqMhJGGnfGqH2iHu9McCGFGg=
X-Received: by 2002:a25:9982:: with SMTP id p2mr4272245ybo.174.1622114772118;
 Thu, 27 May 2021 04:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210526162342.GA20@8bbba9ba63a4> <CAMdYzYpZoKs3P62j02RW-+5BEpqC9JL3apjucTWLWmvNFrOrCg@mail.gmail.com>
 <20210527105943.GA441@7698f5da3a10>
In-Reply-To: <20210527105943.GA441@7698f5da3a10>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 27 May 2021 07:26:01 -0400
Message-ID: <CAMdYzYq8c4=D6_LxG2jPfbtPkOp5tN8oRA0zKt_OM6HLbnfFTw@mail.gmail.com>
Subject: Re: [PATCH] regulator: fan53555: add back tcs4526
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, chenjh@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 6:59 AM Rudi Heitbaum <rudi@heitbaum.com> wrote:
>
> On Wed, May 26, 2021 at 02:41:00PM -0400, Peter Geis wrote:
> > On Wed, May 26, 2021 at 12:23 PM Rudi Heitbaum <rudi@heitbaum.com> wrote:
> > >
> > >
> > > For rk3399pro boards the tcs4526 regulator supports the vdd_gpu
> > > regulator. The tcs4526 regulator has a chip id of <0>.
> > > Add the compatibile tcs,tcs4526
> > >
> > > without this patch, the dmesg output is:
> > >   fan53555-regulator 0-0010: Chip ID 0 not supported!
> > >   fan53555-regulator 0-0010: Failed to setup device!
> > >   fan53555-regulator: probe of 0-0010 failed with error -22
> > > with this patch, the dmesg output is:
> > >   vdd_gpu: supplied by vcc5v0_sys
> > >
> > > The regulators are described as:
> > > - Dedicated power management IC TCS4525
> > > - Lithium battery protection chip TCS4526
> > >
> > > This has been tested with a Radxa Rock Pi N10.
> > >
> > > Fixes: f9028dcdf589 ("regulator: fan53555: only bind tcs4525 to correct chip id")
> > > Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> >
> > Considering the TCS4525 wasn't supported prior to its recent addition,
> > and the TCS4526 wasn't supported by the driver at all, this isn't a
> > fix but a feature addition.
> > Binding only to the correct device ID exists for this reason, to
> > prevent unsafe voltage setting.
>
> Hi Peter, thanks for the detailed feedback. You are quite right (I had
> started using the tcs4525 patch as a tcs452x patch. I'll update that in
> the resubmission.
>
> > I also don't see the TCS4525/TCS4526 regulators in the current
> > linux-next device tree for the N10.
>
> I have a working rk3399pro-vmarc-som.dtsi that I intend to submit, but
> wanted to get clarity on the tcs452x first. I have included it at the
> bottom of this email.
>
> > > ---
> > >  drivers/regulator/fan53555.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
> > > index 2695be617373..ddab9359ea20 100644
> > > --- a/drivers/regulator/fan53555.c
> > > +++ b/drivers/regulator/fan53555.c
> > > @@ -90,6 +90,7 @@ enum {
> > >  };
> > >
> > >  enum {
> > > +       TCS4525_CHIP_ID_00 = 0,
> > >         TCS4525_CHIP_ID_12 = 12,
> >
> > This isn't a TCS4525, but a TCS4526.
>
> I'll update this to TCS4526_CHIP_ID_00
>
> > >  };
> > >
> > > @@ -373,6 +374,7 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
> > >  static int fan53526_voltages_setup_tcs(struct fan53555_device_info *di)
> > >  {
> > >         switch (di->chip_id) {
> > > +       case TCS4525_CHIP_ID_00:
> > >         case TCS4525_CHIP_ID_12:
> > >                 di->slew_reg = TCS4525_TIME;
> > >                 di->slew_mask = TCS_SLEW_MASK;
> > > @@ -564,6 +566,9 @@ static const struct of_device_id __maybe_unused fan53555_dt_ids[] = {
> > >         }, {
> > >                 .compatible = "tcs,tcs4525",
> > >                 .data = (void *)FAN53526_VENDOR_TCS
> > > +       }, {
> > > +               .compatible = "tcs,tcs4526",
> > > +               .data = (void *)FAN53526_VENDOR_TCS
> >
> > Since you aren't adding any functional code, is there a particular
> > reason you can't just add the chip id and simply use the tcs4525
> > compatible?
> > This will prevent you from needing to modify the dt-bindings as well.
>
> In and earlier commit to the BSP kernel the proposal was to rename to
> tcs452x. ref:
> https://github.com/CK-LINUX/kernel/commit/b3bbe8018c56362feed1e49c8d243a8dbcdcc07b
>
> I chose to follow the example of silergy,syr827 and silergy,syr828 for
> tcs4526 (given I made the mistake in assuming that support for tcs4525
> meant support for tcs4525.) This would maintain consistency of naming of
> tcs4526 throughout the source. Is that ok?

It's fine to have both compatibles (and avoids confusion in
device-trees), just remember to update the dt-bindings as well.
It's funny to see drivers with both schemes, so we really have to
decide which path we want to go down.
Considering the syr827/syr828 as convention, we should probably just
go down that route for consistency within the driver.

>
> > >         },
> > >         { }
> > >  };
> > > @@ -672,6 +677,9 @@ static const struct i2c_device_id fan53555_id[] = {
> > >         }, {
> > >                 .name = "tcs4525",
> > >                 .driver_data = FAN53526_VENDOR_TCS
> > > +       }, {
> > > +               .name = "tcs4526",
> > > +               .driver_data = FAN53526_VENDOR_TCS
> > >         },
> > >         { },
> > >  };
> > > --
> > > 2.29.2
> > >
>
> Below is the draft patch for the dtsi includeing the 2 missing regulators and
> to enable the GPU on the Radxa Rock Pi N10 which utilises the VMARC RK3399Pro SoM.
>
> This will be submitted seperately to the "tcs4526 regulator" patch.
>
> --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi     2021-05-08 09:11:59.000000000 +0000
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi     2021-05-08 09:11:59.000000000 +0000
> @@ -57,6 +57,22 @@
>         pinctrl-0 = <&hdmi_cec>;
>  };
>
> +&hdmi_sound {
> +       status = "okay";
> +};
> +
> +&gpu {
> +       mali-supply = <&vdd_gpu>;
> +       assigned-clocks = <&cru ACLK_GPU>;
> +       assigned-clock-rates = <200000000>;
> +       status = "okay";
> +       /delete-property/ operating-points-v2;

Removal of the operating points kind of makes the gpu regulator moot,
don't you think?

> +};
> +
> +&vopl {
> +       status = "disabled";
> +};
> +
>  &i2c0 {
>         clock-frequency = <400000>;
>         i2c-scl-falling-time-ns = <30>;
> @@ -289,6 +288,50 @@
>                         };
>                 };
>         };
> +
> +       vdd_cpu_b: tcs4525@1c {
> +               compatible = "tcs,tcs4525";
> +               reg = <0x1c>;
> +               vin-supply = <&vcc5v0_sys>;
> +               regulator-compatible = "fan53555-reg";
> +               pinctrl-0 = <&vsel1_gpio>;
> +               vsel-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> +               regulator-name = "vdd_cpu_b";
> +               regulator-min-microvolt = <712500>;
> +               regulator-max-microvolt = <1500000>;
> +               regulator-ramp-delay = <2300>;
> +               fcs,suspend-voltage-selector = <1>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-initial-state = <3>;
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +
> +       vdd_gpu: tcs4526@10 {
> +               compatible = "tcs,tcs4526";
> +               reg = <0x10>;
> +               vin-supply = <&vcc5v0_sys>;
> +               regulator-compatible = "fan53555-reg";
> +               pinctrl-0 = <&vsel2_gpio>;
> +               vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
> +               regulator-name = "vdd_gpu";
> +               regulator-min-microvolt = <735000>;
> +               regulator-max-microvolt = <1400000>;
> +               regulator-ramp-delay = <1000>;
> +               fcs,suspend-voltage-selector = <1>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-initial-state = <3>;
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
>  };
> +
> +&i2s2 {
> +       status = "okay";
> +};
>
>  &i2c1 {
> @@ -381,6 +380,29 @@
>                 pmic_int_l: pmic-int-l {
>                         rockchip,pins = <1 RK_PC2 0 &pcfg_pull_up>;
>                 };
> +               vsel1_gpio: vsel1-gpio {
> +                       rockchip,pins =
> +                               <1 RK_PC1 0 &pcfg_pull_down>;
> +               };
> +               vsel2_gpio: vsel2-gpio {
> +                       rockchip,pins =
> +                               <1 RK_PB6 0 &pcfg_pull_down>;
> +               };
> +
> +               soc_slppin_gpio: soc-slppin-gpio {
> +                       rockchip,pins =
> +                               <1 RK_PA5 0 &pcfg_output_low>;
> +               };
> +
> +               soc_slppin_slp: soc-slppin-slp {
> +                       rockchip,pins =
> +                               <1 RK_PA5 1 &pcfg_pull_down>;
> +               };
> +
> +               soc_slppin_rst: soc-slppin-rst {
> +                       rockchip,pins =
> +                               <1 RK_PA5 2 &pcfg_pull_none>;
> +               };
>         };
>
>         sdio-pwrseq {
