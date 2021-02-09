Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA038315A39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 00:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhBIXqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 18:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhBIUd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:33:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB3CC061D7C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 12:02:13 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1l9ZCz-0002oH-VN; Tue, 09 Feb 2021 21:02:01 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1l9ZCy-0002PZ-SO; Tue, 09 Feb 2021 21:02:00 +0100
Date:   Tue, 9 Feb 2021 21:02:00 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>, git <git@xilinx.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Message-ID: <20210209200200.GE8982@pengutronix.de>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
 <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
 <20210118134223.GE12316@pengutronix.de>
 <20210122080846.GI12316@pengutronix.de>
 <BYAPR02MB589689FC1EAE48B5D2213E96C1A09@BYAPR02MB5896.namprd02.prod.outlook.com>
 <20210122133452.GK12316@pengutronix.de>
 <20210127233607.GG19259@pengutronix.de>
 <20210208235606.GA8982@pengutronix.de>
 <BYAPR02MB58965858F51B613965B83192C18E9@BYAPR02MB5896.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <BYAPR02MB58965858F51B613965B83192C18E9@BYAPR02MB5896.namprd02.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 21:00:20 up 69 days,  8:27, 97 users,  load average: 0.63, 0.24,
 0.18
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manish,

On Tue, Feb 09, 2021 at 06:01:58AM +0000, Manish Narani wrote:
>Hi Michael,
>
>> -----Original Message-----
>> From: Michael Grzeschik <mgr@pengutronix.de>
>> Sent: Tuesday, February 9, 2021 5:26 AM
>> To: Manish Narani <MNARANI@xilinx.com>
>> Cc: devicetree@vger.kernel.org; p.zabel@pengutronix.de; balbi@kernel.org;
>> gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-
>> kernel@vger.kernel.org; robh+dt@kernel.org; Michal Simek
>> <michals@xilinx.com>; git <git@xilinx.com>; kernel@pengutronix.de; linux-
>> arm-kernel@lists.infradead.org
>> Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx
>> platforms
>>
>> Hi Manish!
>>
>> On Thu, Jan 28, 2021 at 12:36:07AM +0100, Michael Grzeschik wrote:
>> >On Fri, Jan 22, 2021 at 02:34:52PM +0100, Michael Grzeschik wrote:
>> >>On Fri, Jan 22, 2021 at 01:06:22PM +0000, Manish Narani wrote:
>> >>>Hi Michael,
>> >>>
>> >>>>-----Original Message-----
>> >>>>From: Michael Grzeschik <mgr@pengutronix.de>
>> >>>>Sent: Friday, January 22, 2021 1:39 PM
>> >>>>To: Manish Narani <MNARANI@xilinx.com>
>> >>>>Cc: devicetree@vger.kernel.org; kernel@pengutronix.de;
>> balbi@kernel.org;
>> >>>>gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; Michal Simek
>> >>>><michals@xilinx.com>; linux-kernel@vger.kernel.org;
>> robh+dt@kernel.org;
>> >>>>git <git@xilinx.com>; p.zabel@pengutronix.de; linux-arm-
>> >>>>kernel@lists.infradead.org
>> >>>>Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx
>> >>>>platforms
>> >>>>
>> >>>>Hello!
>> >>>>
>> >>>>On Mon, Jan 18, 2021 at 02:42:24PM +0100, Michael Grzeschik wrote:
>> >>>>>Hi!
>> >>>>>
>> >>>>>On Tue, Dec 15, 2020 at 12:24:51PM +0530, Manish Narani wrote:
>> >>>>>>Add a new driver for supporting Xilinx platforms. This driver is u=
sed
>> >>>>>>for some sequence of operations required for Xilinx USB controller=
s.
>> >>>>>>This driver is also used to choose between PIPE clock coming from
>> SerDes
>> >>>>>>and the Suspend Clock. Before the controller is out of reset, the =
clock
>> >>>>>>selection should be changed to PIPE clock in order to make the USB
>> >>>>>>controller work. There is a register added in Xilinx USB controller
>> >>>>>>register space for the same.
>> >>>>>
>> >>>>>I tried out this driver with the vanilla kernel on an zynqmp. Witho=
ut
>> >>>>>this patch the USB-Gadget is already acting buggy. In the gadget mo=
de,
>> >>>>>some iterations of plug/unplug results to an stalled gadget which w=
ill
>> >>>>>never come back without a reboot.
>> >>>>>
>> >>>>>With the corresponding code of this driver (reset assert, clk modif=
y,
>> >>>>>reset deassert) in the downstream kernels phy driver we found out i=
t is
>> >>>>>totaly stable. But using this exact glue driver which should do the=
 same
>> >>>>>as the downstream code, the gadget still was buggy the way described
>> >>>>>above.
>> >>>>>
>> >>>>>I suspect the difference lays in the different order of operations.
>> >>>>>While the downstream code is runing the resets inside the phy driver
>> >>>>>which is powered and initialized in the dwc3-core itself. With this=
 glue
>> >>>>>layser approach of this patch the whole phy init is done before even
>> >>>>>touching dwc3-core in any way. It seems not to have the same effect,
>> >>>>>though.
>> >>>>>
>> >>>>>If really the order of operations is limiting us, we probably need
>> >>>>>another solution than this glue layer. Any Ideas?
>> >>>>
>> >>>>I found out what the difference between the Downstream and this
>> >>>>Glue is. When using vanilla with this Glue code we may not set
>> >>>>the following bit:
>> >>>>
>> >>>>https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-
>> >>>>ultrascale-registers.html#usb3_regs___fpd_power_prsnt.html
>> >>>>
>> >>>>>>+	/* Set PIPE Power Present signal in FPD Power Present
>> Register*/
>> >>>>>>+	writel(PIPE_POWER_ON, priv_data->regs +
>> >>>>XLNX_USB_FPD_POWER_PRSNT);
>> >>>>
>> >>>>When I comment this out, the link stays stable. This is different in
>> >>>>the Downstream Xilinx Kernel, where the bit is also set but has no
>> >>>>negativ effect.
>> >>>>
>> >>>>Manish, can you give me a pointer what to look for?
>> >>>>So setting this will also work with mainline?
>> >>>I am looking further on this but from what I see here is that,
>> >>>In order to make USB function properly, there are some dt changes
>> needed in mainline for
>> >>>USB node which include defining clocks coming from serdes.
>> >>>The DT changes are pending to be sent to mainline.
>> >>
>> >>Can you push that state somewhere, so I could test it?
>> >>Or is in the downstream kernel some things to copy?
>> >>
>> >>>Can you share the DT settings for USB node on your side?
>> >>
>> >>Here is my current configuration for the device node at usb0:
>> >>
>> >>zynqmp.dtsi
>> >>
>> >>zynqmp_reset: reset-controller {
>> >>	compatible =3D "xlnx,zynqmp-reset";
>> >>	#reset-cells =3D <1>;
>> >>};
>> >>
>> >>usb0: usb@ff9d0000 {
>> >>	#address-cells =3D <2>;
>> >>	#size-cells =3D <2>;
>> >>	status =3D "disabled";
>> >>	compatible =3D "xlnx,zynqmp-dwc3";
>> >>	reg =3D <0x0 0xff9d0000 0x0 0x100>;
>> >>	clock-names =3D "bus_clk", "ref_clk";
>> >>	power-domains =3D <&zynqmp_firmware PD_USB_0>;
>> >>	ranges;
>> >>	resets =3D <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
>> >>		<&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
>> >>		<&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
>> >>	reset-names =3D "usb_crst", "usb_hibrst", "usb_apbrst";
>> >>	phy-names =3D "usb3-phy";
>> >>	phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
>> >>
>> >>	usb0_dwc3: dwc3@fe200000 {
>> >>		compatible =3D "snps,dwc3";
>> >>		interrupt-parent =3D <&gic>;
>> >>		interrupts =3D <0 65 4>;
>> >>		clock-names =3D "ref", "bus_early", "suspend";
>> >>		reg =3D <0x0 0xfe200000 0x0 0x40000>;
>> >>	};
>> >>};
>> >>
>> >>platform.dts
>> >>
>> >>&usb0 {
>> >>	status =3D "okay";
>> >>	phy-names =3D "usb3-phy";
>> >>	phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
>> >>};
>> >>
>> >>&usb0_dwc3 {
>> >>	dr_mode =3D "peripheral";
>> >>
>> >>	/* The following quirks are required, since the bInterval is 1 and we
>> >>	 * handle steady ISOC streaming. See Usecase 3 in commit
>> 729dcffd1ed3
>> >>	 * ("usb: dwc3: gadget: Add support for disabling U1 and U2
>> entries").
>> >>	 */
>> >>	snps,dis-u1-entry-quirk;
>> >>	snps,dis-u2-entry-quirk;
>> >>};
>> >>
>> >>
>> >>>Meanwhile I will keep updating on the same.
>> >>
>> >>Thanks, that sounds great!
>> >
>> >I have more feedback regarding this issues. As we saw new uncommon
>> >effects, when using the glue. Regarding to get the plug/unplug behaviour
>> >stable, we sticked with leaving out the setting of PIPE_POWER_ON in that
>> >driver. Unfortunately, with that change, the dwc3 is not only not
>> >sending any Erratic Errors any more, but also is lacking to send
>> >disconnect interrupts.
>> >
>> >Double checking with downstream shows that disconnects are working
>> >completely fine in your downstream stack.
>> >
>> >I think we should really need to know why PIPE_POWER_ON is making
>> >a difference before we can say the dwc3 is stable with that glue.
>>
>> After bisecting your v5.4 and mainline we found out that this all is
>> working fine, when setting "snps,dis_u3_susphy_quirk" in the zynqmp.dtsi
>> dwc3 node.
>>
>> The code handling this quirk was introduced after v5.4, so this was
>> never an issue with your downstream stack.
>>
>> "9ba3aca8 usb: dwc3: Disable phy suspend after power-on reset"
>>
>> We need to know if adding snps,dis_u3_susphy_quirk to the dwc nodes
>> is generally necessary for zynqmp, so we can fix for everyone.
>
>Yes, it is necessary for DWC3 on ZynqMP platform. This property should be
>added to the DT node.

For now this quirk does solve the issues regarding the pluging
behaviour. But we would like to know why?

Is the phy not properly configured/connected to serve the phy
suspend as intended for the dwc3 stack? Is this a real Hardware issue,
or does this quirk only disable the suspend behaviour even though it
would work properly when configured correctly in software.


The second question is addressing the dwc3 xilinx glue driver
you are trying to mainline. We found that the driver is pulling and
releasing some resets before and after changing the pll frequency
comming from the reference clk lines. After that the undocumented
registers XLNX_USB_FPD_POWER_PRSNT and XLNX_USB_FPD_PIPE_CLK are changed
according to the updated pll frequency. What do these bit change?
Is this an internal configuration every dwc3 user on the zynqmp has
to do or does this differ from user to user?

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmAi6jgACgkQC+njFXoe
LGTznQ/+Id166mvGiPXXcOVRAcg2z5cj/2I0OEOSR+mS0oTUZMNXXRk0oLCoxWS6
IkSpkA7D0GBejMauHLJ+Hmb8M/fuLQUjSwRNi62otX4t5+mABiXxlCXW5JTyrRc9
mHOweD3Vokz1T//n3oGD4wsBqML444doj8vVTXixi7qac9I2jRkYtVpkLn7JSNpf
fAgDS42ndxGWGsk99ZU+wrtBVibVhRGpP0mplvkYaGplgztZ1By072fjBNdGjM9j
us8iavcqB8TC2N6+/QdNb45EhgpjR4FMEVxcFF/CBbMb3UYgK4OKZMOOFiGAqgbO
eWXoLxuQb9obKmCqvuZUC1NrnWEo4n/8VYXZF1h1J5X7GlIyQgvnSXpR1lYI8szr
l5YmPki87DbKzTyMLkfvQ+JG7VhkWOcCGu2YEVKEEwCZAw4Mk19zi2UGEKA47FIm
ztfeIYkbveUpMxMc7XwcA3EkTAIuPQEBKbRLtEq8/wRhJUN9zxzJmtC8RRhxhM3E
MqZaLrcroL74PTN3zRx6MkMOB0U2bUym5hhUQH8j4j42KVgmQuhau1joJNa244jU
UJxiIGYwAvY6N0BHdX6fA0ZQVpvV1crz+M2iMAB0YoGKHPlEP0GWh0v3pHGaTAWY
id5nrY32xl3uDnjK9f4lbKcx+jRp20iaDeGhevbn5mggrhXpMcs=
=jPjB
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
