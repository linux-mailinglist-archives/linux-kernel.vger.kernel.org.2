Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5734D8C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhC2UE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC2UD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:03:57 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBA0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 13:03:57 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i144so15028987ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+SVnf+eZNzV5BnrsHjXuTPhUW9NQDOxp0HhmQNkvME=;
        b=T1+5NkN80jgzut/IEEWJL6Sjns6vfZJ4/CUm0fJotNLiYdFyLaKO8nqtx4bPuBwueJ
         NMNHPk6+HTKHAq6V+OtXgZgMojOMH5lLuDwA2gIH90EzgLhA7Cbjao/ToWgrR/Kwlhg8
         KtZrsRoE28Cplq4R8xfZD6m1sPX6ES9jFAIEphgleU1ga9hQOSiQZMvZDdRDCCagFZWt
         Uiz9OYOmA/6oDlnBsumL+S/oO/rm1pGtTaHEjCLY22XIunwTQMrKJLJkEyymFbCJXFAC
         J2iozu1tlR+kj443NTOv55qIzGhncAEJ4hzzk/VXSdjoymrwJrqEZw+R0NOSvkREMD0E
         4OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+SVnf+eZNzV5BnrsHjXuTPhUW9NQDOxp0HhmQNkvME=;
        b=j5cHDda5uSqs9egv+qkguFwNX9PFiReittOhZOs3XIN4D/nBHnJCPtAnDJQHCVFTEB
         1qAfMpc7dkrhjIXSlgngs3sodHmm7DcIm7OIXynchXR6YX9HXMVMU7IFoAesdzsSIoCZ
         M3LYog1IHiP4bDI5UhZVjtQkxNTWMkB2meizZzCT9H46f7l3sRfUauK5EjTXMSRJERF5
         fDTCwv0/eDvWtjFv1HTmX1UexABMVLqUqi4y6C0t2T2E9SDHDyM+hRKv0ii7T/fzSgkm
         DHBnqgWqnkrPwUVnHS2WAciENPF5LU+dPdvQDgAB6ySLiN/WFmi7rtNrNbbGcIFJSLjx
         8VpQ==
X-Gm-Message-State: AOAM532JIx0GCmaQw6qEVTNliXw1ghBkmAXVAl39j4rJKsNhi4GgdQjo
        TXchCjJG7Kcg2v8tEPxvOj1D+oEFl9C8tifdGFzdtg==
X-Google-Smtp-Source: ABdhPJwhFMfjrq3D9ur5h5lAawAYkP9YVyiZiWKYWVXENhjEzDFg6lHzfsFuCMc3FRS4PIUdm0hoYxSYiFcGeAQveYg=
X-Received: by 2002:a25:dc4c:: with SMTP id y73mr38871511ybe.346.1617048236369;
 Mon, 29 Mar 2021 13:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210316215123.GA3712408@robh.at.kernel.org> <20210318210318.144961-1-sebastian.reichel@collabora.com>
 <20210326012720.GA2113788@robh.at.kernel.org> <CAGETcx9JmtbwAq_fpU5KfUzjcTw-uHPqKo3gAGjQwht=wxY8yg@mail.gmail.com>
 <20210326095212.22ty5ueowiq36y6b@earth.universe>
In-Reply-To: <20210326095212.22ty5ueowiq36y6b@earth.universe>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 29 Mar 2021 13:03:20 -0700
Message-ID: <CAGETcx81=GwChE0eZtKKAk4kDeq2S0ijS8X7FsMnk5HhzAcOhA@mail.gmail.com>
Subject: Re: [RFC] clk: add boot clock support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 2:52 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi Saravana,
>
> On Thu, Mar 25, 2021 at 06:55:52PM -0700, Saravana Kannan wrote:
> > On Thu, Mar 25, 2021 at 6:27 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > +Saravana
> > >
> > > On Thu, Mar 18, 2021 at 10:03:18PM +0100, Sebastian Reichel wrote:
> > > > On Congatec's QMX6 system on module one of the i.MX6 fixed clocks
> > > > is provided by an I2C RTC. Specifying this properly results in a
> > > > circular dependency, since the I2C RTC (and thus its clock) cannot
> > > > be initialized without the i.MX6 clock controller being initialized.
> > > >
> > > > With current code the following path is executed when i.MX6 clock
> > > > controller is probed (and ckil clock is specified to be the I2C RTC
> > > > via DT):
> > > >
> > > > 1. imx6q_obtain_fixed_clk_hw(ccm_node, "ckil", 0);
> > > > 2. of_clk_get_by_name(ccm_node, "ckil");
> > > > 3. __of_clk_get(ccm_node, 0, ccm_node->full_name, "ckil");
> > > > 4. of_clk_get_hw(ccm_node, 0, "ckil")
> > > > 5. spec = of_parse_clkspec(ccm_node, 0, "ckil"); // get phandle
> > > > 6. of_clk_get_hw_from_clkspec(&spec); // returns -EPROBE_DEFER
> > > > 7. error is propagated back, i.MX6q clock controller is probe deferred
> > > > 8. I2C controller is never initialized without clock controller
> > > >    I2C RTC is never initialized without I2C controller
> > > >    CKIL clock is never initialized without I2C RTC
> > > >    clock controller is never initialized without CKIL
> > > >
> > > > To fix the circular dependency this registers a dummy clock when
> > > > the RTC clock is tried to be acquired. The dummy clock will later
> > > > be unregistered when the proper clock is registered for the RTC
> > > > DT node. IIUIC clk_core_reparent_orphans() will take care of
> > > > fixing up the clock tree.
> > > >
> > > > NOTE: For now the patch is compile tested only. If this approach
> > > > is the correct one I will do some testing and properly submit this.
> > > > You can find all the details about the hardware in the following
> > > > patchset:
> > > >
> > > > https://lore.kernel.org/linux-devicetree/20210222171247.97609-1-sebastian.reichel@collabora.com/
> > > >
> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > ---
> > > >  .../bindings/clock/clock-bindings.txt         |   7 +
> > > >  drivers/clk/clk.c                             | 146 ++++++++++++++++++
> > > >  2 files changed, 153 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > index f2ea53832ac6..66d67ff4aa0f 100644
> > > > --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > @@ -32,6 +32,13 @@ clock-output-names: Recommended to be a list of strings of clock output signal
> > > >                   Clock consumer nodes must never directly reference
> > > >                   the provider's clock-output-names property.
> > > >
> > > > +boot-clock-frequencies: This property is used to specify that a clock is enabled
> > > > +                     by default with the provided frequency at boot time. This
> > > > +                     is required to break circular clock dependencies. For clock
> > > > +                     providers with #clock-cells = 0 this is a single u32
> > > > +                     with the frequency in Hz. Otherwise it's a list of
> > > > +                     clock cell specifier + frequency in Hz.
> > >
> > > Seems alright to me. I hadn't thought about the aspect of needing to
> > > know the frequency. Other cases probably don't as you only need the
> > > clocks once both components have registered.
> > >
> > > Note this could be lost being threaded in the other series.
> >
> > I read this thread and tried to understand it. But my head isn't right
> > today (lack of sleep) so I couldn't wrap my head around it. I'll look
> > at it again after the weekend. In the meantime, Sebastian can you
> > please point me to the DT file and the specific device nodes (names or
> > line number) where this cycle is present?
>
> I have not yet sent an updated DT file, but if you look at this
> submission:
>
> https://lore.kernel.org/linux-devicetree/20210222171247.97609-7-sebastian.reichel@collabora.com/
>
> There is a node
>
> rtc: m41t62@68 { compatible = "st,m41t62"; };
>
> That is an I2C RTC, which provides a 32.768 kHz clock by default
> (i.e. after power loss). This clock signal is used to provide the
> i.MX6 CKIL:
>
> ------------------------------------
> &clks {
>     clocks = <&rtc>;
>     clock-names = "ckil";
> };
> ------------------------------------
>
> > Keeping a clock on until all its consumers probe is part of my TODO
> > list (next item after fw_devlink=on lands). I already have it working
> > in AOSP, but need to clean it up for upstream. fw_devlink can also
> > break *some* cycles (not all). So I'm wondering if the kernel will
> > solve this automatically soon(ish). If it can solve it automatically,
> > I'd rather not add new DT bindings because it'll make it more work for
> > fw_devlink.
>
> As written above on Congatec QMX6 an I2C RTC provides one of the
> SoC's input frequencies. The SoC basically expects that frequency
> to be always enabled and this is what it works like before clock
> support had been added to the RTC driver.

Thanks. I skimmed through the RTC driver code and
imx6q_obtain_fixed_clk_hw() and the DT files.

>
> With the link properly being described the Kernel tries to probe
> the SoC's clock controller during early boot. Then it tries to get a
> reference to the linked clock, using imx6q_obtain_fixed_clk_hw()
> and that returns -EPROBE_DEFER (because the RTC driver has not
> yet been probed).

But the RTC (which is a proper I2C device) will never probe before
CLK_OF_DECLARE() initializes the core clock controller. So, it's not
clear how "protected-clocks" helps here since it doesn't change
whether you get -EPROBE_DEFER from imx6q_obtain_fixed_clk_hw() (which
is called from the CLK_OF_DECLARE() callback). Oof... I see what you
are doing with of_clk_register_boot_clk(). You are having the consumer
register its own clock and then use it. Kinda beats the whole point of
describing the link in the first place.

> Without the clock controller basically none of
> the i.MX6 SoC drivers can probe including the I2C driver. Without
> the I2C bus being registered, the RTC driver never probes and the
> boot process is stuck.
>
> I'm not sure how fw_devlink can help here.

I'll explain how it'd help. Let's assume "fsl,imx6q-ccm" was
implemented as an actual platform device driver and not using
CLK_OF_DECLARE() to initialize ALL the clocks. I'll get to this
assumption later.

In that case, fw_devlink will notice this cycle:
syntax: consumer -(reason)-> supplier
clks -(clocks property)-> rtc -(parent)-> i2c3  -(clocks property)-> clks.

It'll then reason that it doesn't make sense for a device (clks) to
have a supplier (rtc) whose parent (i2c3) in turn depends on the
device (clks). It'll then drop the clks -> rtc dependency because
that's the most illogical one in terms of probing.

So all you'd need to do is delete any -EPROBE defer you might do in
"fsl,imx6q-ccm" driver for "ckil". For cases where there's no cycle,
fw_devlink will make sure the supplier of ckil has probed first. For
cases where there's a cycle like this, it'll be smart enough to drop
this dependency during probe ordering.

I don't know enough about the clocks in imx6q to comment if you can
get away without using CLK_OF_DECLARE() at all. The only clock that
really needs to use CLK_OF_DECLARE() is any clock that's needed for
the scheduler timer. Other than that, everything else can be
initialized by a normal driver. Including UART clocks. I can get into
more specifics if you go down this path.

So, that's how fw_devlink could help here if you massage
drivers/clk/imx/clk-imx6q.c to be a proper platform driver. You'll
have to set fw_devlink=on in the kernel commandline though (it's work
in progress to set this by default). There are some additional details
here about keeping clocks on, but we can discuss the solution for that
if it becomes an issue.

> I see exactly two
> options to solve this:
>
> a) do not describe the link and keep RTC clock enabled somehow.
>    (my initial patchset)
> b) describe the link, but ignore it during boot.
>    (what I'm trying to do here)
>

Even if you completely ignore fw_devlink, why not just model this
clock as a fixed-clock in DT for this specific machine? It's clearly
expecting the clock to be an always on fixed clock. This will also
remove the need for adding "boot-clock-frequencies" binding.
"fixed-clocks" devices are initialized very early on (they use
CLK_OF_DECLARE too) even without their parents probing (not sure I
agree with this, but this is how it works now).

Something like:

rtc: m41t62@68 {
compatible = "st,m41t62";
reg = <0x68>;

    clock-ckil {
                    compatible = "fixed-clock";
                    #clock-cells = <0>;
                    clock-frequency = <32768>;
            };
};

I hope this helps.

-Saravana
