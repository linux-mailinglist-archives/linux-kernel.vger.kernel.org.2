Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ACF408887
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbhIMJus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:50:48 -0400
Received: from mail-mw2nam08on2046.outbound.protection.outlook.com ([40.107.101.46]:1697
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234476AbhIMJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:50:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiq5w/pTX1kA5Q4R36uWPQrPFn70/HTRwTxJcIJlQyNOyUHbft1Gzpqvy6IlKIdtYeCjTSuETxa10btQWu8gQkRsKty+l3lwW9Bgf46opbWY07H14ZS7gZS10Etlw1AwYRfXaW+EvazXQ7kJY5jIYY09DrNG0da2w6d6gRA6PZnKdanfy1XscppuyneQJ75EgI6GOfq+y4z4VVoMBKeXaCZIVc5OnHQbROxz6kxQMuAmKNYGoawt8Q8vKAu/jpZsYSgBiA6i0hoq9RUHlt24MhWE4v08+n7dth6GbVfJl4Ee4wpNyNSqGJDX3+kaupiYg6KUm1T6NLhIMmvtLqPDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zDWNjAwnv4YR32UjC7miv1gNN9UT7UkunPTlSR9J5FI=;
 b=XkmQXRPygyZRqv1uBdxXLfaAUzzaOvslyv81mi0Lb5bX5u1xq1TfHcbyiuhOJYkmJOBq4j+TFKIXqeadUCy1W1BjEVkP4XhXUyTTsZg38gKuyIb6680WGUBc5tofvMs5eajb1paQpTOt3OJaTx/+ImkBE76Bm0D1YuXBpS+5EnKS/1i98lehUmIwfLE4S/VnpYamzDphfDP4S8YSG8cIBIbgD5keAF3OtR8j7AQgFDrZIuxSBR1pNpOIFQjwT5Ke8DfUr1UiPYwS7BHysZjXH/5nStFzrryy+gb5zTmiKX8rkuQQ7KsVjfZcntINymcLjyCqiCGxdkjOQr3r3bbCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDWNjAwnv4YR32UjC7miv1gNN9UT7UkunPTlSR9J5FI=;
 b=jBJEGpYL1A/UewCNq5c6SXniryPNq32/GNBzNJYXcsM1Z07ngorNsvKLLB6ADpdfG4nXPTYKAqFlx47pW0gA6T1Ni5EF4CSmdYcXduellxpBZwSqJ/0Ayb9W/bVKq6SeMUHwcLP7grpzOYLjh3XTyoQjLKfyzFC+9cFxF0NuQtY=
Received: from SJ0PR02MB8644.namprd02.prod.outlook.com (2603:10b6:a03:3fe::20)
 by BYAPR02MB5110.namprd02.prod.outlook.com (2603:10b6:a03:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 09:49:24 +0000
Received: from SJ0PR02MB8644.namprd02.prod.outlook.com
 ([fe80::e9bf:7ae:ee0f:dc2e]) by SJ0PR02MB8644.namprd02.prod.outlook.com
 ([fe80::e9bf:7ae:ee0f:dc2e%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 09:49:24 +0000
From:   Piyush Mehta <piyushm@xilinx.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Srinivas Goud <sgoud@xilinx.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH] usb: chipidea: udc: make controller hardware endpoint
 primed
Thread-Topic: [PATCH] usb: chipidea: udc: make controller hardware endpoint
 primed
Thread-Index: AQHXpI2kaPK5rYBjNUWgkOpg+q9kaKugCfqAgAGxjzA=
Date:   Mon, 13 Sep 2021 09:49:24 +0000
Message-ID: <SJ0PR02MB8644CBBA848A0F68323F1AA5D4D99@SJ0PR02MB8644.namprd02.prod.outlook.com>
References: <20210908084321.375662-1-piyush.mehta@xilinx.com>
 <20210912074105.GA4808@Peter>
In-Reply-To: <20210912074105.GA4808@Peter>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e9c5d95-9697-485e-acb8-08d9769bc4fc
x-ms-traffictypediagnostic: BYAPR02MB5110:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB51105B45E1025C5739BBDDE7D4D99@BYAPR02MB5110.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IlFtB+Nrp+q3D9za8fe8wPlO+g/MezUfonPzo356GxizV3cdpYeNoph2UeyNLS/H1xddGN4EAtqz1WLER99l7nhz+rhLLWsA5V1TslE5pW8jLq4bB7vUVc8rsdq4N+Q0iLP618AN7R+ZvEJmrT586JfYUMX/9B7ezWdivRnmec/QK5iolJA6Q3y9hoIwdocgWbTecL4wdRIECGdVbPVaA/ph+jpT0DbpzDfisHhJKg0bB8g2fr6XnruvCL7VqYo7FpuPItEGv2quYsDTf10TomVnm0K0a++Ld23INMH9sNmrOjxSonmwnQ+EAaXanqvLUaG1Qs8/GlDTJ0lDkAkgr4s3ZIktm8CptAVF4Qb1ub1o3mYbDzfmEIkEOk4VSYuY+Fomb+0Bo6XgEU0Mj1DrFSNMhlfn461MSN/TWFYHhmQjrpBOZUdsq7+FP2kRqUsHnkZVruKR2Y91xbWcK6L9XRZd6gU/1n0M9lA58MzPdgSwbmayiVIxIurTRibWj0wppf1r33xIyiQhYa5bvhH4dDuui4qR7USNtz54CRG+Nuh5/s4nO42dp3VF9pUBwkM8AS/uz5o+EPRE7fnIUPnOKQNfnoaNTW/ch9moSIBuR2IIzII2re/WSC+wEQHnBwdWT/dkNnh5knp3+L29c5+oukm7qUt7N4zXgMz11chhKlNx3NEjfYt2lLfzKs2T7CIDq4lzqH8qfDj9yKEQzj0DIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8644.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(83380400001)(107886003)(6916009)(7696005)(8936002)(54906003)(316002)(52536014)(86362001)(26005)(186003)(64756008)(38100700002)(66556008)(66476007)(5660300002)(2906002)(71200400001)(66446008)(66946007)(33656002)(76116006)(38070700005)(55016002)(4326008)(8676002)(122000001)(9686003)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sp+NgidY3A3KhrCwHFie345dalHJ31ATMdPZsXgUUU8hq+SyNL1b9xAVj9iU?=
 =?us-ascii?Q?SCn83L6I7cPW0X2twnwIlF9SdBD5mus+IKCl2Ej2mSuAeiemHcyde457yhTI?=
 =?us-ascii?Q?ofDzwDub7uOrxy6yniPiH080J5bYBGtCY+6enl3D8DcSM2hxcF0LlDeyYExc?=
 =?us-ascii?Q?ZYAWR74bT0v70HwNmXzp7awO+wWZq1yGQnV9h4W6bSTKyw993cnKRF3FBmYD?=
 =?us-ascii?Q?MMjO5/L01qkCZODLGx9WhaZGRB37uLtyC7WfnFW/cWSZWENvcfXpRwBwQNr6?=
 =?us-ascii?Q?Qmv7EYF/9sf/nPg8T5P8Wq7old8wVRJEV+ghHIqhC7Qq5e1H+D9cnY7H78TP?=
 =?us-ascii?Q?tvp11XeNdW/8cIBgEXmAcm+GSuAz0YAbDYkvQOf69WUtkoFkvSdcGEUroJNK?=
 =?us-ascii?Q?oJbf/Kd2rbl/zCZChx8aQ3Ob9tEPvxUcaF8gqE3gMrCgw0Vxz4XEdUDtBtZs?=
 =?us-ascii?Q?plkNWN6ph586RaVY4szRNPAWuKeVHGuGJGgiIMYxiW9SzbkTURKAce7mktPr?=
 =?us-ascii?Q?bj6tvAH5xiyseyJXhMViEQTW3plO/1JkU2u7E2Z8w6nFz4q4yFeMuFUWbLx+?=
 =?us-ascii?Q?Lm6UiQjTum90PMyc8phoE7UawQHoXasbG6AHEhRNcA3I/UZajwcu1xdIWsF6?=
 =?us-ascii?Q?hiI8X7b/jVMvBXFWyRdBkEXFEUY0GMtV315wZb8hZjGL6YwQGYo5Nzs6gXFN?=
 =?us-ascii?Q?Zc8mKRCppMQlYIeMmnVnSJ3cBzN82Z+k+Fr/FyA3IXU4ME5mdPAWzsS6b2Zw?=
 =?us-ascii?Q?H3/mdMn7jxYua/g8GNTX0QRtVZZoJGwclqZyNjoRkGRdVz83pW2469jRKh8c?=
 =?us-ascii?Q?3CZlgMZkyOsMYsPhPlBefkVy0Z6Ty4AX0sEokynlUZR3h+qWTEZo9/EFMGKR?=
 =?us-ascii?Q?i2kgsgj4on1XtyLZkapNMWb7VoP8tETooxfZfA/QnrMozk+Ig5gkaSF8y6R8?=
 =?us-ascii?Q?GoG8a6FLDS8M15GIRB1sDZoyc4S3zF8VhVNlk0PTmanzGYRN+x9GnNbV6OeL?=
 =?us-ascii?Q?BBRiG+ZpmEHEQDCADvbU57YSOqZbMnlK2MNeFJWB/lNL2V897mEcC82ChAZg?=
 =?us-ascii?Q?oZUgC7jshWhbv53a0x7A9SrjiVjNheg/Gazo0hk+lQLNoQO6F9aDSIjUr+73?=
 =?us-ascii?Q?0636YNMqGUljOZfwxnJjsIT85GnAuFdilFTB7E1F+H0lzqaUFZhgylC2FW/o?=
 =?us-ascii?Q?Apo/0Q+WV3TZL77LmXjyAdS+we4VPXs6IfdYLXCAFSv+7mcyRvMIKAfDAl7G?=
 =?us-ascii?Q?DyhuXguR85icyUrSruuG3/PDuaPMF3zZMVt7X1OIvCvLqPoPumLkIOMJW3QP?=
 =?us-ascii?Q?ZpybHPYMiln938EqNZd273zX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8644.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9c5d95-9697-485e-acb8-08d9769bc4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 09:49:24.4606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyO3qu1C6OSfJLUcHLk7poyoh9SZ7ugoiGpL8YcbT267xXdxrBlyrktPx3gCaemK40ZfrmCxru2tr6eaUVI2vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Thanks for the review.
Please find my inline comment with tag [Piyush].

Regards,
Piyush Mehta

-----Original Message-----
From: Peter Chen <peter.chen@kernel.org>=20
Sent: Sunday, September 12, 2021 1:11 PM
To: Piyush Mehta <piyushm@xilinx.com>
Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-kernel@vge=
r.kernel.org; git <git@xilinx.com>; Srinivas Goud <sgoud@xilinx.com>; Micha=
l Simek <michals@xilinx.com>
Subject: Re: [PATCH] usb: chipidea: udc: make controller hardware endpoint =
primed

On 21-09-08 14:13:21, Piyush Mehta wrote:
> Root-cause:
> There is an issue like endpoint is not recognized as primed, when bus=20
> have more pressure and the add dTD tripwire semaphore (ATDTW bit in=20
> USBCMD register) that can cause the controller to ignore a dTD that is=20
> added to a primed endpoint.
> This issue observed with the Windows10 host machine.
>=20
> Workaround:
> The software must implement a periodic cycle, and check for each dTD,=20
> if the endpoint is primed. It can do this by reading the corresponding=20
> bits in the ENDPTPRIME and ENDPTSTAT registers. If these bits are read=20
> at 0, the software needs to re-prime the endpoint by writing 1 to the=20
> corresponding bit in the ENDPTPRIME register.
>=20
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  drivers/usb/chipidea/udc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c=20
> index 8834ca6..d970f45 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -49,6 +49,8 @@ ctrl_endpt_in_desc =3D {
>  	.wMaxPacketSize  =3D cpu_to_le16(CTRL_PAYLOAD_MAX),  };
> =20
> +static int reprime_dtd(struct ci_hdrc *ci, struct ci_hw_ep *hwep,
> +		       struct td_node *node);
>  /**
>   * hw_ep_bit: calculates the bit number
>   * @num: endpoint number
> @@ -599,8 +601,15 @@ static int _hardware_enqueue(struct ci_hw_ep=20
> *hwep, struct ci_hw_req *hwreq)
> =20
>  		prevlastnode->ptr->next =3D cpu_to_le32(next);
>  		wmb();
> +
> +		if (ci->rev =3D=3D CI_REVISION_22) {
> +			if (!hw_read(ci, OP_ENDPTSTAT, BIT(n)))
> +				reprime_dtd(ci, hwep, prevlastnode);
> +		}
> +

Only for version 2.2?
[Piyush]
Yes, Xilinx chip-idea controller support revision 2.20 only.
This solution is validated on revision 2.20 on the zynq7000 platform.

>  		if (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
>  			goto done;
> +

No blank line.

>  		do {
>  			hw_write(ci, OP_USBCMD, USBCMD_ATDTW, USBCMD_ATDTW);
>  			tmp_stat =3D hw_read(ci, OP_ENDPTSTAT, BIT(n));
> --
> 2.7.4
>=20

--=20

Thanks,
Peter Chen

