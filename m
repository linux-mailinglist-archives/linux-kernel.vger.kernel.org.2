Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A488734D9BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhC2VxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhC2VxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:53:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C0C061574;
        Mon, 29 Mar 2021 14:53:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1FBC41F454FB
Received: by earth.universe (Postfix, from userid 1000)
        id 974053C0C96; Mon, 29 Mar 2021 23:53:00 +0200 (CEST)
Date:   Mon, 29 Mar 2021 23:53:00 +0200
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
Message-ID: <20210329215300.4qnhmm4utmdectk5@earth.universe>
References: <20210316215123.GA3712408@robh.at.kernel.org>
 <20210318210318.144961-1-sebastian.reichel@collabora.com>
 <20210326012720.GA2113788@robh.at.kernel.org>
 <CAGETcx9JmtbwAq_fpU5KfUzjcTw-uHPqKo3gAGjQwht=wxY8yg@mail.gmail.com>
 <20210326095212.22ty5ueowiq36y6b@earth.universe>
 <CAGETcx81=GwChE0eZtKKAk4kDeq2S0ijS8X7FsMnk5HhzAcOhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkhbavartwpths7y"
Content-Disposition: inline
In-Reply-To: <CAGETcx81=GwChE0eZtKKAk4kDeq2S0ijS8X7FsMnk5HhzAcOhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkhbavartwpths7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 29, 2021 at 01:03:20PM -0700, Saravana Kannan wrote:
> On Fri, Mar 26, 2021 at 2:52 AM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > On Thu, Mar 25, 2021 at 06:55:52PM -0700, Saravana Kannan wrote:
> > > On Thu, Mar 25, 2021 at 6:27 PM Rob Herring <robh@kernel.org> wrote:
> > > > On Thu, Mar 18, 2021 at 10:03:18PM +0100, Sebastian Reichel wrote:
> > > > > On Congatec's QMX6 system on module one of the i.MX6 fixed clocks
> > > > > is provided by an I2C RTC. Specifying this properly results in a
> > > > > circular dependency, since the I2C RTC (and thus its clock) cannot
> > > > > be initialized without the i.MX6 clock controller being initializ=
ed.
> > > > >
> > > > > With current code the following path is executed when i.MX6 clock
> > > > > controller is probed (and ckil clock is specified to be the I2C R=
TC
> > > > > via DT):
> > > > >
> > > > > 1. imx6q_obtain_fixed_clk_hw(ccm_node, "ckil", 0);
> > > > > 2. of_clk_get_by_name(ccm_node, "ckil");
> > > > > 3. __of_clk_get(ccm_node, 0, ccm_node->full_name, "ckil");
> > > > > 4. of_clk_get_hw(ccm_node, 0, "ckil")
> > > > > 5. spec =3D of_parse_clkspec(ccm_node, 0, "ckil"); // get phandle
> > > > > 6. of_clk_get_hw_from_clkspec(&spec); // returns -EPROBE_DEFER
> > > > > 7. error is propagated back, i.MX6q clock controller is probe def=
erred
> > > > > 8. I2C controller is never initialized without clock controller
> > > > >    I2C RTC is never initialized without I2C controller
> > > > >    CKIL clock is never initialized without I2C RTC
> > > > >    clock controller is never initialized without CKIL
> > > > >
> > > > > To fix the circular dependency this registers a dummy clock when
> > > > > the RTC clock is tried to be acquired. The dummy clock will later
> > > > > be unregistered when the proper clock is registered for the RTC
> > > > > DT node. IIUIC clk_core_reparent_orphans() will take care of
> > > > > fixing up the clock tree.
> > > > >
> > > > > NOTE: For now the patch is compile tested only. If this approach
> > > > > is the correct one I will do some testing and properly submit thi=
s.
> > > > > You can find all the details about the hardware in the following
> > > > > patchset:
> > > > >
> > > > > https://lore.kernel.org/linux-devicetree/20210222171247.97609-1-s=
ebastian.reichel@collabora.com/
> > > > >
> > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > > ---
> > > > >  .../bindings/clock/clock-bindings.txt         |   7 +
> > > > >  drivers/clk/clk.c                             | 146 ++++++++++++=
++++++
> > > > >  2 files changed, 153 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/clock/clock-bindin=
gs.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > > index f2ea53832ac6..66d67ff4aa0f 100644
> > > > > --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > > +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > > @@ -32,6 +32,13 @@ clock-output-names: Recommended to be a list o=
f strings of clock output signal
> > > > >                   Clock consumer nodes must never directly refere=
nce
> > > > >                   the provider's clock-output-names property.
> > > > >
> > > > > +boot-clock-frequencies: This property is used to specify that a =
clock is enabled
> > > > > +                     by default with the provided frequency at b=
oot time. This
> > > > > +                     is required to break circular clock depende=
ncies. For clock
> > > > > +                     providers with #clock-cells =3D 0 this is a=
 single u32
> > > > > +                     with the frequency in Hz. Otherwise it's a =
list of
> > > > > +                     clock cell specifier + frequency in Hz.
> > > >
> > > > Seems alright to me. I hadn't thought about the aspect of needing to
> > > > know the frequency. Other cases probably don't as you only need the
> > > > clocks once both components have registered.
> > > >
> > > > Note this could be lost being threaded in the other series.
> > >
> > > I read this thread and tried to understand it. But my head isn't right
> > > today (lack of sleep) so I couldn't wrap my head around it. I'll look
> > > at it again after the weekend. In the meantime, Sebastian can you
> > > please point me to the DT file and the specific device nodes (names or
> > > line number) where this cycle is present?
> >
> > I have not yet sent an updated DT file, but if you look at this
> > submission:
> >
> > https://lore.kernel.org/linux-devicetree/20210222171247.97609-7-sebasti=
an.reichel@collabora.com/
> >
> > There is a node
> >
> > rtc: m41t62@68 { compatible =3D "st,m41t62"; };
> >
> > That is an I2C RTC, which provides a 32.768 kHz clock by default
> > (i.e. after power loss). This clock signal is used to provide the
> > i.MX6 CKIL:
> >
> > ------------------------------------
> > &clks {
> >     clocks =3D <&rtc>;
> >     clock-names =3D "ckil";
> > };
> > ------------------------------------
> >
> > > Keeping a clock on until all its consumers probe is part of my TODO
> > > list (next item after fw_devlink=3Don lands). I already have it worki=
ng
> > > in AOSP, but need to clean it up for upstream. fw_devlink can also
> > > break *some* cycles (not all). So I'm wondering if the kernel will
> > > solve this automatically soon(ish). If it can solve it automatically,
> > > I'd rather not add new DT bindings because it'll make it more work for
> > > fw_devlink.
> >
> > As written above on Congatec QMX6 an I2C RTC provides one of the
> > SoC's input frequencies. The SoC basically expects that frequency
> > to be always enabled and this is what it works like before clock
> > support had been added to the RTC driver.
>=20
> Thanks. I skimmed through the RTC driver code and
> imx6q_obtain_fixed_clk_hw() and the DT files.
>=20
> >
> > With the link properly being described the Kernel tries to probe
> > the SoC's clock controller during early boot. Then it tries to get a
> > reference to the linked clock, using imx6q_obtain_fixed_clk_hw()
> > and that returns -EPROBE_DEFER (because the RTC driver has not
> > yet been probed).
>=20
> But the RTC (which is a proper I2C device) will never probe before
> CLK_OF_DECLARE() initializes the core clock controller. So, it's not
> clear how "protected-clocks" helps here since it doesn't change
> whether you get -EPROBE_DEFER from imx6q_obtain_fixed_clk_hw() (which
> is called from the CLK_OF_DECLARE() callback). Oof... I see what you
> are doing with of_clk_register_boot_clk(). You are having the consumer
> register its own clock and then use it. Kinda beats the whole point of
> describing the link in the first place.

I agree, that it does not make sense from a code point of view for
this platform. All of this is just to make the DT look correct.
=46rom a platform point of view the most logical way is to handle the
RTC clock as do-not-touch always enabled fixed-clock.

> > Without the clock controller basically none of
> > the i.MX6 SoC drivers can probe including the I2C driver. Without
> > the I2C bus being registered, the RTC driver never probes and the
> > boot process is stuck.
> >
> > I'm not sure how fw_devlink can help here.
>=20
> I'll explain how it'd help. Let's assume "fsl,imx6q-ccm" was
> implemented as an actual platform device driver and not using
> CLK_OF_DECLARE() to initialize ALL the clocks. I'll get to this
> assumption later.
>=20
> In that case, fw_devlink will notice this cycle:
> syntax: consumer -(reason)-> supplier
> clks -(clocks property)-> rtc -(parent)-> i2c3  -(clocks property)-> clks.
>=20
> It'll then reason that it doesn't make sense for a device (clks) to
> have a supplier (rtc) whose parent (i2c3) in turn depends on the
> device (clks). It'll then drop the clks -> rtc dependency because
> that's the most illogical one in terms of probing.
>=20
> So all you'd need to do is delete any -EPROBE defer you might do in
> "fsl,imx6q-ccm" driver for "ckil". For cases where there's no cycle,
> fw_devlink will make sure the supplier of ckil has probed first. For
> cases where there's a cycle like this, it'll be smart enough to drop
> this dependency during probe ordering.

What do you mean drop? Anything using ckil will not be registered?
That will basically kill the system within a few seconds, since the
watchdog hardware uses ckil.

> I don't know enough about the clocks in imx6q to comment if you can
> get away without using CLK_OF_DECLARE() at all. The only clock that
> really needs to use CLK_OF_DECLARE() is any clock that's needed for
> the scheduler timer. Other than that, everything else can be
> initialized by a normal driver. Including UART clocks. I can get into
> more specifics if you go down this path.
>=20
> So, that's how fw_devlink could help here if you massage
> drivers/clk/imx/clk-imx6q.c to be a proper platform driver. You'll
> have to set fw_devlink=3Don in the kernel commandline though (it's work
> in progress to set this by default). There are some additional details
> here about keeping clocks on, but we can discuss the solution for that
> if it becomes an issue.
>=20
> > I see exactly two
> > options to solve this:
> >
> > a) do not describe the link and keep RTC clock enabled somehow.
> >    (my initial patchset)
> > b) describe the link, but ignore it during boot.
> >    (what I'm trying to do here)
> >
>=20
> Even if you completely ignore fw_devlink, why not just model this
> clock as a fixed-clock in DT for this specific machine?
>
> It's clearly expecting the clock to be an always on fixed clock.

Yes. SoC runs unreliably with this. Downstream vendor kernel does
not contain a clock driver for the squarewave pin of the RTC (i.e.
their driver does not yet contain 1373e77b4f10) and just works.
Upstream kernel disables the RTC's squarewave and then goes into
reboot loop because of watchdog going crazy.

> This will also remove the need for adding "boot-clock-frequencies"
> binding.  "fixed-clocks" devices are initialized very early on
> (they use CLK_OF_DECLARE too) even without their parents probing
> (not sure I agree with this, but this is how it works now).
>
> Something like:
>=20
> rtc: m41t62@68 {
> compatible =3D "st,m41t62";
> reg =3D <0x68>;
>=20
>     clock-ckil {
>                     compatible =3D "fixed-clock";
>                     #clock-cells =3D <0>;
>                     clock-frequency =3D <32768>;
>             };
> };
>=20
> I hope this helps.

This looks like a complex way of my initial patchset with
'protected-clocks' property replaced by a fixed-clock
node. RTC driver needs to check if that exists and avoid
registering its own clock.

-- Sebastian

--vkhbavartwpths7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBiTDEACgkQ2O7X88g7
+ppCeg//YS0A2pP5kWYsbjQYCUM9tVw9orRFCW5sTm4YuaTmjX1Jpl5Rb/0azuk1
2Y8twLBPhRnzs/+wqtpOV7qghETyWqXfso/+avfSpoeg3kdh4wPRXpWQwPqZ6Glb
R1wT+fjKovLvYVnhgghVtjOQlMz52wfHWk5vHEspwc7sfQwMNleIyQciuKd9l6NR
5OdkXsU+6Z6K1iOQmCn3KAiRtmLwHqqne7zKE5M+FNHbt0FRP0eyJ+HgWeyEvblA
lN7zlONu8ZRPno40Mfz1ki3pkdy5rZlATfSQl5W1Olf9uInYTvWPSHurcqGhWKW2
q85gcRCIV1O7TDQK/kNi0IBP2K+xn+kuIgxCKrLKVU+34BMJXMjg5kW/bfDCELV2
hVgU8Yxm4m0gwz0wmgjnLYXbMgz0buZRSxKT8gmuwhfMNJ7nTD9U69HinFZRMKtR
+jGUCgnz/q6rF0CL7NG/+bdGkD2jUsl+JsN03r8SiNkZrB1uHiWZ/fu5hdnKExYv
z9KfFSxQpnsl5+fDmuCmuTH4aVABdH3otL0TQq859UhNCdBWr/Sx7eKSlSC2RrlN
LYdwiNLyCx/xeDFMgpS23kxqAF8xway/n3UJXrxm8oJSy680gvd/yk8i45lz77T/
v7B4690sNb3XrJJ4ccf9Tuj99CQCAq15zKE+GelK8eSBkYPDvU4=
=yDed
-----END PGP SIGNATURE-----

--vkhbavartwpths7y--
