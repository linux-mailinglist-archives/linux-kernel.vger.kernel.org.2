Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A304631486B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBIGC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:02:59 -0500
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:48005
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhBIGCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:02:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0PBpUjXRTOxT5gjS/NZg8w4fDha4PkdS7g2qkrbMM9e9LdRkFI/GKT8CWR7eGXJ3IrMfDZ732VZag6+qjDlOcsbYTlN83rdKficlFTIcWu/J7La7P3xi/QvdoDq8iV5D8TSTufr8E8LWswERBovzvh6Ei5097cs3+5ix7zRzx3E6VRpWyBFQ8TROKE8W0B9ygovJHwlRj8TSS6s6BzWM8jwartUYmjGfVSkstAqrzA3BcQqZ3BOR4lhr29sAGl5L/B75zdXuOYAql88X4G7GSocxLTBsIioADaWvIjtL0e6CWzXNzjp8EXLiB5Zh+i9lIpBu02pT6Qv+UXn/AM9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvdN2Mt0np3mGWBo3EupyhjuA5uPXmf3mqnM/0c2+2s=;
 b=iLpwny6KMMb4NkZJ+B3BhzYFo5ayo64uh51pwD4HKC8oMal3X/R4miMFWc7r0rZingOoHz0j/ArpiJ4Fif4PCunt6ob2LrWpH1y+Vm1o8lvP6JjcP/BuMTXXqbkAT4mK6of1NTC0Baq3wcS14C00pS5bvkhacuku5TU77h4ru5ghxzglVvrLzrDSEqPBU5uO1QpHUnMK6nWbBS61uSf7FGOCntPRLEoY79SFY7fNQGu2B9YVlxju48zvGkeCDt7ueOOb0IMIK0P+LTMTX0X9sgb1cGdUZ9JmSARKLO1VK+x7HbCzFk9+dha/CDcnGk3njNgaR3y9cQPlcP6Ww0M+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvdN2Mt0np3mGWBo3EupyhjuA5uPXmf3mqnM/0c2+2s=;
 b=sNXLZRtFGNkV2tjbFPCqSS5UC2XKRQEWQMJK99GKLvi/h+jf8KnQnjXCJhjYmcjRKz1kEN+CD+UIGPNrmj8wEILHGhUoryCwhEdyioqAIapcxrvlJdaxC0IDMZwM5L8jl9HsaG4FPPLUZ3YiFybjgVQJudjH2oEOZDdXCZj1OXE=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB5975.namprd02.prod.outlook.com (2603:10b6:a03:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 06:01:59 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c4f1:e969:f8d2:20b4]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c4f1:e969:f8d2:20b4%3]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 06:01:58 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Michael Grzeschik <mgr@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Subject: RE: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Topic: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Index: AQHW0q9EwtT3SEPXrk68pgN7S+dn2KotmiIAgAXsHACAAEOYwIAAF4UAgAiDpICAEuGQAIAAXzrA
Date:   Tue, 9 Feb 2021 06:01:58 +0000
Message-ID: <BYAPR02MB58965858F51B613965B83192C18E9@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
 <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
 <20210118134223.GE12316@pengutronix.de>
 <20210122080846.GI12316@pengutronix.de>
 <BYAPR02MB589689FC1EAE48B5D2213E96C1A09@BYAPR02MB5896.namprd02.prod.outlook.com>
 <20210122133452.GK12316@pengutronix.de>
 <20210127233607.GG19259@pengutronix.de>
 <20210208235606.GA8982@pengutronix.de>
In-Reply-To: <20210208235606.GA8982@pengutronix.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.83.141.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fca81b4-0f29-4605-86d1-08d8ccc0363e
x-ms-traffictypediagnostic: BYAPR02MB5975:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB597594B29D236CFA970AB2BAC18E9@BYAPR02MB5975.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xdyoDn0X2bYOmfJOkG6FgbDwLKcnmC7e0ZhaXyeMUDbDdc6ZOpMLeKkaSdaroARqGVm8jAD5u7Xrj6r0xRuggMzwgPgoYUc1M1+D2jYQCGWlZ9wiFpr8FCg9WjJUoDwEh0PzaiAqw0+8vmY2Qctv6lw/n3RWQJ5k6Gi2QNyP098VrMPrmVquK24bMzlX3xIHyNUtpUkle8u0b1FP2X0BOfttGvRcxtL+XlV1i7B7RGMyvs6zL2EmUmaqOMMsR5wUNWziZFvetfXLMyJLzq2Q8aQ4kKlpBUin93b7KYGH2cbzVyo4wt7VS+3fLiq2QKA/z+W+WJ0C4iFcsO6zq2yNwg7I7IS0E7QpQVBRvA8Y9FI/RMOfFUGgIiTbdSMyLPRlodWqaZWWF3TkVRXUTewT8xWhz8l1hOKlS0eibkWrjc4s4Nr3GAk7t4SfA04X/gCX9KGjmDMgz1SuEnwcNKyHZor2NBhZANUAZPtgTaucml2ms2R4LtYap+EGW6s8Y2zV96kNAgkfgbQd8oOHGuY4XBRyehdhKTGOaOwjrOiwipk6nJo1jl+2RdtrslEn04iMq4keWYGnqNwZq3uF2hta0phqsOK18YXThLjBqjoHp5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(44832011)(316002)(8676002)(9686003)(55016002)(83380400001)(71200400001)(54906003)(186003)(7416002)(66946007)(26005)(53546011)(6506007)(52536014)(33656002)(5660300002)(478600001)(8936002)(4326008)(2906002)(64756008)(76116006)(6916009)(66446008)(66556008)(66476007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SH5nj82k7xQSSJxYSICRaR3BVy24Cf/YAzzM8MxrwJOZmJ8HZh8Q0AKiqJUy?=
 =?us-ascii?Q?4ifN6tYxt4YkTmRtlwrH76WqtCHstFb907JEmdCVvxHW3e/DxyiIv6VaXXOh?=
 =?us-ascii?Q?F0f6jNNXzDLb/KeyDZPiF94S3likup1xcvXZ+vf1ItmWa5QpwZu8kbN/tjSz?=
 =?us-ascii?Q?HKqufIe6s044EmH0CpIUMuUcpNIuj4/tf3FZXcPUr1NgMv57GSHj1fyLALex?=
 =?us-ascii?Q?9B9Op1vj9Pi4vWk/R3FRXu29draHn1nR6khPTljDyKKNL3lVaKhfO9gw7E/d?=
 =?us-ascii?Q?4m3yEe1R7XKkk5c5LCLt5T+8fZRuMrfKd/q7lVRBjMbvG7+3GhNm96rkLmQ8?=
 =?us-ascii?Q?a9shY4mAhIndOry4Jzf6xrw5ln6A5ptS+pVn9n13t+V0VP/IkDmpi1SRcSd1?=
 =?us-ascii?Q?TyJZnkNJSlNCnMy24O0JFoYbH3PYbvgGx/3K52EldWlUvg62Ztayvq0d8jhZ?=
 =?us-ascii?Q?9+pwROSKgZmVPel6Q/2rRXjH8HWzLisvf4z7/g7WofuT9E9ZoEZ0zLOUn+D+?=
 =?us-ascii?Q?KnaZw6JuXrMalT/ZMy6zRyakjShSQhdMtg1Osz13Sr7lVnRqrcoNQON0qYR2?=
 =?us-ascii?Q?F9wuvezzrbhdEMOvsMw80q+mcILDn7XQ8qn6RN975klxhdBGng/BOtXMBHXN?=
 =?us-ascii?Q?4kIH5B4i13h8xX4Sw5v9DoOpis212iCnngvkNJ2L+nH3rJeAcoPYOwX6O1IG?=
 =?us-ascii?Q?K/CqxRjQLeix86IgiReIfPwJxuYAMYXmucKyXOUEDqhEx4PHkLv69VrRqqfA?=
 =?us-ascii?Q?+urh/r0bYhz0mq3SEvlaqzvzdXzfOBBG6DQwwk/G6WjtZ4xUNaGiyt/kv25C?=
 =?us-ascii?Q?NF1NUcqLQGIgy007Qal/xMMD2G2fO3ySC1PT1TcchAyoUQpp5zRGPBmgtRYs?=
 =?us-ascii?Q?GspSPWGgbORjmbw1EtnV/Bj7SmgKsTHBENdpILYjcBsgn9qlhfLTnIxV0FP8?=
 =?us-ascii?Q?JqCUUAtb/h0j4Tdn9oX+GsssZaglkZgMHl3a8ClcHyNR37jS3jOplxAYFccR?=
 =?us-ascii?Q?itvxu3DDCFF7b3vLN/zX52wUcDxVF3Zuq/EkNzPxeqtgc00hhXaql9lk57VM?=
 =?us-ascii?Q?iYl1MQrN5U2tk30MapX4TtE6AeQlV75DGGfooQDmKndC+n1BaV/aLC5XzYp9?=
 =?us-ascii?Q?KcvEPFLfRmwws4F4hOJjvxJjdPtzUGal5MGWMXvNOV1K/hwygVCvfbbkHVPN?=
 =?us-ascii?Q?JaQoHZ3RWf6dFInHrvR2tjEvBdmpcM1bOuNBDQ6DAW+Ws9/oMYi6JAlNoYlz?=
 =?us-ascii?Q?3Y5DuKVkA4BgkYP9lFuQ4RwXuhTzkjNclxFCjTU84eRmY1SJDIhRpOAC5v7B?=
 =?us-ascii?Q?fgct26BWeOvS3Wt+MZxCcw/e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fca81b4-0f29-4605-86d1-08d8ccc0363e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 06:01:58.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RBf6E06VRW8NAxionhXFq3A3MuTQc8/ZHpS1v/8vogg2M0tsbM4dH3JanKPIOJg8rD61KGqkuN0ON+UJ9igPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5975
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Grzeschik <mgr@pengutronix.de>
> Sent: Tuesday, February 9, 2021 5:26 AM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: devicetree@vger.kernel.org; p.zabel@pengutronix.de; balbi@kernel.org;
> gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; git <git@xilinx.com>; kernel@pengutronix.de; linux-
> arm-kernel@lists.infradead.org
> Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx
> platforms
>=20
> Hi Manish!
>=20
> On Thu, Jan 28, 2021 at 12:36:07AM +0100, Michael Grzeschik wrote:
> >On Fri, Jan 22, 2021 at 02:34:52PM +0100, Michael Grzeschik wrote:
> >>On Fri, Jan 22, 2021 at 01:06:22PM +0000, Manish Narani wrote:
> >>>Hi Michael,
> >>>
> >>>>-----Original Message-----
> >>>>From: Michael Grzeschik <mgr@pengutronix.de>
> >>>>Sent: Friday, January 22, 2021 1:39 PM
> >>>>To: Manish Narani <MNARANI@xilinx.com>
> >>>>Cc: devicetree@vger.kernel.org; kernel@pengutronix.de;
> balbi@kernel.org;
> >>>>gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; Michal Simek
> >>>><michals@xilinx.com>; linux-kernel@vger.kernel.org;
> robh+dt@kernel.org;
> >>>>git <git@xilinx.com>; p.zabel@pengutronix.de; linux-arm-
> >>>>kernel@lists.infradead.org
> >>>>Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx
> >>>>platforms
> >>>>
> >>>>Hello!
> >>>>
> >>>>On Mon, Jan 18, 2021 at 02:42:24PM +0100, Michael Grzeschik wrote:
> >>>>>Hi!
> >>>>>
> >>>>>On Tue, Dec 15, 2020 at 12:24:51PM +0530, Manish Narani wrote:
> >>>>>>Add a new driver for supporting Xilinx platforms. This driver is us=
ed
> >>>>>>for some sequence of operations required for Xilinx USB controllers=
.
> >>>>>>This driver is also used to choose between PIPE clock coming from
> SerDes
> >>>>>>and the Suspend Clock. Before the controller is out of reset, the c=
lock
> >>>>>>selection should be changed to PIPE clock in order to make the USB
> >>>>>>controller work. There is a register added in Xilinx USB controller
> >>>>>>register space for the same.
> >>>>>
> >>>>>I tried out this driver with the vanilla kernel on an zynqmp. Withou=
t
> >>>>>this patch the USB-Gadget is already acting buggy. In the gadget mod=
e,
> >>>>>some iterations of plug/unplug results to an stalled gadget which wi=
ll
> >>>>>never come back without a reboot.
> >>>>>
> >>>>>With the corresponding code of this driver (reset assert, clk modify=
,
> >>>>>reset deassert) in the downstream kernels phy driver we found out it=
 is
> >>>>>totaly stable. But using this exact glue driver which should do the =
same
> >>>>>as the downstream code, the gadget still was buggy the way described
> >>>>>above.
> >>>>>
> >>>>>I suspect the difference lays in the different order of operations.
> >>>>>While the downstream code is runing the resets inside the phy driver
> >>>>>which is powered and initialized in the dwc3-core itself. With this =
glue
> >>>>>layser approach of this patch the whole phy init is done before even
> >>>>>touching dwc3-core in any way. It seems not to have the same effect,
> >>>>>though.
> >>>>>
> >>>>>If really the order of operations is limiting us, we probably need
> >>>>>another solution than this glue layer. Any Ideas?
> >>>>
> >>>>I found out what the difference between the Downstream and this
> >>>>Glue is. When using vanilla with this Glue code we may not set
> >>>>the following bit:
> >>>>
> >>>>https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-
> >>>>ultrascale-registers.html#usb3_regs___fpd_power_prsnt.html
> >>>>
> >>>>>>+	/* Set PIPE Power Present signal in FPD Power Present
> Register*/
> >>>>>>+	writel(PIPE_POWER_ON, priv_data->regs +
> >>>>XLNX_USB_FPD_POWER_PRSNT);
> >>>>
> >>>>When I comment this out, the link stays stable. This is different in
> >>>>the Downstream Xilinx Kernel, where the bit is also set but has no
> >>>>negativ effect.
> >>>>
> >>>>Manish, can you give me a pointer what to look for?
> >>>>So setting this will also work with mainline?
> >>>I am looking further on this but from what I see here is that,
> >>>In order to make USB function properly, there are some dt changes
> needed in mainline for
> >>>USB node which include defining clocks coming from serdes.
> >>>The DT changes are pending to be sent to mainline.
> >>
> >>Can you push that state somewhere, so I could test it?
> >>Or is in the downstream kernel some things to copy?
> >>
> >>>Can you share the DT settings for USB node on your side?
> >>
> >>Here is my current configuration for the device node at usb0:
> >>
> >>zynqmp.dtsi
> >>
> >>zynqmp_reset: reset-controller {
> >>	compatible =3D "xlnx,zynqmp-reset";
> >>	#reset-cells =3D <1>;
> >>};
> >>
> >>usb0: usb@ff9d0000 {
> >>	#address-cells =3D <2>;
> >>	#size-cells =3D <2>;
> >>	status =3D "disabled";
> >>	compatible =3D "xlnx,zynqmp-dwc3";
> >>	reg =3D <0x0 0xff9d0000 0x0 0x100>;
> >>	clock-names =3D "bus_clk", "ref_clk";
> >>	power-domains =3D <&zynqmp_firmware PD_USB_0>;
> >>	ranges;
> >>	resets =3D <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
> >>		<&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
> >>		<&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
> >>	reset-names =3D "usb_crst", "usb_hibrst", "usb_apbrst";
> >>	phy-names =3D "usb3-phy";
> >>	phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
> >>
> >>	usb0_dwc3: dwc3@fe200000 {
> >>		compatible =3D "snps,dwc3";
> >>		interrupt-parent =3D <&gic>;
> >>		interrupts =3D <0 65 4>;
> >>		clock-names =3D "ref", "bus_early", "suspend";
> >>		reg =3D <0x0 0xfe200000 0x0 0x40000>;
> >>	};
> >>};
> >>
> >>platform.dts
> >>
> >>&usb0 {
> >>	status =3D "okay";
> >>	phy-names =3D "usb3-phy";
> >>	phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
> >>};
> >>
> >>&usb0_dwc3 {
> >>	dr_mode =3D "peripheral";
> >>
> >>	/* The following quirks are required, since the bInterval is 1 and we
> >>	 * handle steady ISOC streaming. See Usecase 3 in commit
> 729dcffd1ed3
> >>	 * ("usb: dwc3: gadget: Add support for disabling U1 and U2
> entries").
> >>	 */
> >>	snps,dis-u1-entry-quirk;
> >>	snps,dis-u2-entry-quirk;
> >>};
> >>
> >>
> >>>Meanwhile I will keep updating on the same.
> >>
> >>Thanks, that sounds great!
> >
> >I have more feedback regarding this issues. As we saw new uncommon
> >effects, when using the glue. Regarding to get the plug/unplug behaviour
> >stable, we sticked with leaving out the setting of PIPE_POWER_ON in that
> >driver. Unfortunately, with that change, the dwc3 is not only not
> >sending any Erratic Errors any more, but also is lacking to send
> >disconnect interrupts.
> >
> >Double checking with downstream shows that disconnects are working
> >completely fine in your downstream stack.
> >
> >I think we should really need to know why PIPE_POWER_ON is making
> >a difference before we can say the dwc3 is stable with that glue.
>=20
> After bisecting your v5.4 and mainline we found out that this all is
> working fine, when setting "snps,dis_u3_susphy_quirk" in the zynqmp.dtsi
> dwc3 node.
>=20
> The code handling this quirk was introduced after v5.4, so this was
> never an issue with your downstream stack.
>=20
> "9ba3aca8 usb: dwc3: Disable phy suspend after power-on reset"
>=20
> We need to know if adding snps,dis_u3_susphy_quirk to the dwc nodes
> is generally necessary for zynqmp, so we can fix for everyone.

Yes, it is necessary for DWC3 on ZynqMP platform. This property should be
added to the DT node.

Thanks,
Manish
