Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4479B34A4F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCZJw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhCZJwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:52:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B1C0613AA;
        Fri, 26 Mar 2021 02:52:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 88E681F46C28
Received: by earth.universe (Postfix, from userid 1000)
        id 575153C0C96; Fri, 26 Mar 2021 10:52:12 +0100 (CET)
Date:   Fri, 26 Mar 2021 10:52:12 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [RFC] clk: add boot clock support
Message-ID: <20210326095212.22ty5ueowiq36y6b@earth.universe>
References: <20210316215123.GA3712408@robh.at.kernel.org>
 <20210318210318.144961-1-sebastian.reichel@collabora.com>
 <20210326012720.GA2113788@robh.at.kernel.org>
 <CAGETcx9JmtbwAq_fpU5KfUzjcTw-uHPqKo3gAGjQwht=wxY8yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yuqc3nyfosvvvnh3"
Content-Disposition: inline
In-Reply-To: <CAGETcx9JmtbwAq_fpU5KfUzjcTw-uHPqKo3gAGjQwht=wxY8yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yuqc3nyfosvvvnh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Thu, Mar 25, 2021 at 06:55:52PM -0700, Saravana Kannan wrote:
> On Thu, Mar 25, 2021 at 6:27 PM Rob Herring <robh@kernel.org> wrote:
> >
> > +Saravana
> >
> > On Thu, Mar 18, 2021 at 10:03:18PM +0100, Sebastian Reichel wrote:
> > > On Congatec's QMX6 system on module one of the i.MX6 fixed clocks
> > > is provided by an I2C RTC. Specifying this properly results in a
> > > circular dependency, since the I2C RTC (and thus its clock) cannot
> > > be initialized without the i.MX6 clock controller being initialized.
> > >
> > > With current code the following path is executed when i.MX6 clock
> > > controller is probed (and ckil clock is specified to be the I2C RTC
> > > via DT):
> > >
> > > 1. imx6q_obtain_fixed_clk_hw(ccm_node, "ckil", 0);
> > > 2. of_clk_get_by_name(ccm_node, "ckil");
> > > 3. __of_clk_get(ccm_node, 0, ccm_node->full_name, "ckil");
> > > 4. of_clk_get_hw(ccm_node, 0, "ckil")
> > > 5. spec =3D of_parse_clkspec(ccm_node, 0, "ckil"); // get phandle
> > > 6. of_clk_get_hw_from_clkspec(&spec); // returns -EPROBE_DEFER
> > > 7. error is propagated back, i.MX6q clock controller is probe deferred
> > > 8. I2C controller is never initialized without clock controller
> > >    I2C RTC is never initialized without I2C controller
> > >    CKIL clock is never initialized without I2C RTC
> > >    clock controller is never initialized without CKIL
> > >
> > > To fix the circular dependency this registers a dummy clock when
> > > the RTC clock is tried to be acquired. The dummy clock will later
> > > be unregistered when the proper clock is registered for the RTC
> > > DT node. IIUIC clk_core_reparent_orphans() will take care of
> > > fixing up the clock tree.
> > >
> > > NOTE: For now the patch is compile tested only. If this approach
> > > is the correct one I will do some testing and properly submit this.
> > > You can find all the details about the hardware in the following
> > > patchset:
> > >
> > > https://lore.kernel.org/linux-devicetree/20210222171247.97609-1-sebas=
tian.reichel@collabora.com/
> > >
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  .../bindings/clock/clock-bindings.txt         |   7 +
> > >  drivers/clk/clk.c                             | 146 ++++++++++++++++=
++
> > >  2 files changed, 153 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.t=
xt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > index f2ea53832ac6..66d67ff4aa0f 100644
> > > --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > @@ -32,6 +32,13 @@ clock-output-names: Recommended to be a list of st=
rings of clock output signal
> > >                   Clock consumer nodes must never directly reference
> > >                   the provider's clock-output-names property.
> > >
> > > +boot-clock-frequencies: This property is used to specify that a cloc=
k is enabled
> > > +                     by default with the provided frequency at boot =
time. This
> > > +                     is required to break circular clock dependencie=
s. For clock
> > > +                     providers with #clock-cells =3D 0 this is a sin=
gle u32
> > > +                     with the frequency in Hz. Otherwise it's a list=
 of
> > > +                     clock cell specifier + frequency in Hz.
> >
> > Seems alright to me. I hadn't thought about the aspect of needing to
> > know the frequency. Other cases probably don't as you only need the
> > clocks once both components have registered.
> >
> > Note this could be lost being threaded in the other series.
>=20
> I read this thread and tried to understand it. But my head isn't right
> today (lack of sleep) so I couldn't wrap my head around it. I'll look
> at it again after the weekend. In the meantime, Sebastian can you
> please point me to the DT file and the specific device nodes (names or
> line number) where this cycle is present?

I have not yet sent an updated DT file, but if you look at this
submission:

https://lore.kernel.org/linux-devicetree/20210222171247.97609-7-sebastian.r=
eichel@collabora.com/

There is a node

rtc: m41t62@68 { compatible =3D "st,m41t62"; };

That is an I2C RTC, which provides a 32.768 kHz clock by default
(i.e. after power loss). This clock signal is used to provide the
i.MX6 CKIL:

------------------------------------
&clks {
    clocks =3D <&rtc>;
    clock-names =3D "ckil";
};
------------------------------------

> Keeping a clock on until all its consumers probe is part of my TODO
> list (next item after fw_devlink=3Don lands). I already have it working
> in AOSP, but need to clean it up for upstream. fw_devlink can also
> break *some* cycles (not all). So I'm wondering if the kernel will
> solve this automatically soon(ish). If it can solve it automatically,
> I'd rather not add new DT bindings because it'll make it more work for
> fw_devlink.

As written above on Congatec QMX6 an I2C RTC provides one of the
SoC's input frequencies. The SoC basically expects that frequency
to be always enabled and this is what it works like before clock
support had been added to the RTC driver.

With the link properly being described the Kernel tries to probe=20
the SoC's clock controller during early boot. Then it tries to get a
reference to the linked clock, using imx6q_obtain_fixed_clk_hw()
and that returns -EPROBE_DEFER (because the RTC driver has not
yet been probed). Without the clock controller basically none of
the i.MX6 SoC drivers can probe including the I2C driver. Without
the I2C bus being registered, the RTC driver never probes and the
boot process is stuck.

I'm not sure how fw_devlink can help here. I see exactly two
options to solve this:

a) do not describe the link and keep RTC clock enabled somehow.
   (my initial patchset)
b) describe the link, but ignore it during boot.
   (what I'm trying to do here)

Thanks,

-- Sebastian

--yuqc3nyfosvvvnh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBdrr0ACgkQ2O7X88g7
+pprNQ//ausWttZwADiPqm832XLLkBLS6xCGi1ntEuXqYXQAhNdD7ncGATlceYmE
1UsfVgYstQDQE9aGyM0blkUNeUB4ejW4j5BFUkSG/+ANltZosa17qWMfgn9yS4px
0bNqggfUKX5EHMtZmxkjnjxxZTYyzDB+sRhld7BePV7c5xdyIY91JEtEaEYTl0NX
mX2KKroKOPH6heiXOBKg+qSUeK03Eek2ezmGnSfRBnOoQjsbyUTeYQpSRbDZ2CSF
vp/6/nbKVAmRDfqoThWG+hVZP8Nyg8ukj6icHLUdg4nZyFV6i+Hlm3ebbzF2Li+g
RpDmudDqm6b74R9ZcieIVvRw1N6oKtHcypLSa0nL/a8JICsZ3ykdh0Q3dwHEOGWm
tMWbH0TIyVQgPeIOt7XfN+nPSBecD3sz31WU71iYwRMHxlm2plsdzarOwccTDE/z
pug42JostOKofd7A4gMSJ2NW62Np5HfpGxpyjlIgMzw4Cj1j0I8j7V/tT/QNiA3a
usLxEdS/g65EwewDC1Q7hXPY6ZczZz9ImFWFe9OifBqUldOn7DEruHkAEw8LEdmt
vcF0HQXqhDsJ8pVkqt++ZZCkRECr7m2KmVkmD5dLpCTldMSxznO1mfV9CpLi4wwL
dj24yan7oZ6wkajSdxmJ5QNM1Z7O0JcmEWoxzdI9rg8H4CtWlpw=
=/IHI
-----END PGP SIGNATURE-----

--yuqc3nyfosvvvnh3--
