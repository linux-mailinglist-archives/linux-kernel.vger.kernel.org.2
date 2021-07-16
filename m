Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122223CB098
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhGPB4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:56:32 -0400
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:60017
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232276AbhGPB4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:56:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7XUJeFmrbvhmWzr/PjxwgI7nYk+CQvglhvGBUx19SJhZ72YN0WG2KlBqzIH7ZFTK2o3ytvl19UNZpeAY56+F54GXG9Zpe91COgBLlJnsGaNOjh8cw3CMfwJjgJRC1tFEw3Aawqz527+3t3g9DmyuQmnklueXTRORkGVH6CsqztOZN3DNklSy9mT08o9azkOHm1mXqWHPATib8D+cliu8/ze99I4B6xSXLut36OqUMBfQ9z3vdLK1l6C+jj5E2j22MwMO0s/+mTgGES5ow9y66QbhpRR2M2SPHXY5Ixmo95PsY0jwH7XgrIYINStMD7O4XOrqIFoMjKswVmrW3eTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy/8tOuzSOrDt5a6aVFEAKfTZdON01CKh+zm85kySrs=;
 b=NQHtfFQTdhG8MSzuUeTKNe3YHihghKNEeltYaj7YtCJQJ7Dp4XwgnkclwW81P/Zg2eHTcEDfI66bLj7Pvb1LwTG/0cR8omxwbEkyrVPgsCFjKPyAZpbSZ3qKo9XgWihS1rA5qeS+OOCBm/kHJuTwkKAq9whUTfy7SEn+irSj+YThtmkoMGONc+7HK0UcXLSMBGjG1XlKuBF5uHInwTolBNP1mCSunhfjNSG89xArGJFmqajUynSgmjwczvFHLk+y7vrwdxHvpCA5N+aYBK7WU5h84tyZ5njxlub+8NeDQz8zmZLra8NKHguq2zv07VM2cB7ZPiEGLlZ3qCTGXkzVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy/8tOuzSOrDt5a6aVFEAKfTZdON01CKh+zm85kySrs=;
 b=d3lQEq9mj/sTjkzaQ9o+OIoAy95Y8oEpLeADtocFZXh3d5cWRzjBrtpGE7P4obsK6i6Bx5ulPDP8utGak9PFY9GWPTCIOP+0uFD51Fsb2eJRqTBBaFYSH7MZEKvsXtfv2x/wdZqlY3ztfO3qeg0yxzkUS8XERc/h7GFmyHrqsZc=
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM5PR0401MB2483.eurprd04.prod.outlook.com (2603:10a6:203:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.27; Fri, 16 Jul
 2021 01:53:33 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 01:53:32 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] i3c: master: svc: add support for slave to stop
 returning data
Thread-Topic: [PATCH 3/4] i3c: master: svc: add support for slave to stop
 returning data
Thread-Index: AQHXeVKlvkpTszQEl0CFjbmwTxIx16tEpnkAgAAwJIA=
Date:   Fri, 16 Jul 2021 01:53:32 +0000
Message-ID: <AM6PR04MB5623000C198520DACEB839E8F3119@AM6PR04MB5623.eurprd04.prod.outlook.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
        <20210715082413.3042149-4-xiaoning.wang@nxp.com>
 <20210716005552.6078c7eb@xps13>
In-Reply-To: <20210716005552.6078c7eb@xps13>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac449f6f-b797-48fe-e74b-08d947fc8479
x-ms-traffictypediagnostic: AM5PR0401MB2483:
x-microsoft-antispam-prvs: <AM5PR0401MB2483A49D8B0313A2D0D76169F3119@AM5PR0401MB2483.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /IgvXcUpBkqqwsbvXm4d8KUDoL7Cz0jyRaQsYKZDHLOuDFKrsuUHhZ7ExY1cywBboi916ySoz0Gho2GAixoL5/JRKEtXhn3GxHf5IoQ5tiJ5HBMUy3a3ZmNYgQvF2cspN9fJbOjrwao5caKz3O6R2udv8ANe5rLfA5sEr9g6MI4G1AFa8G2vf707FF75RAyw7ARMheOSrwSVnBBwyH8k49PItiF7z35dwVlSFAhpn+K2YBFliFvFkyHTQGkKSyHAzvlrqektpemYGP4w7DNRcmmWp+hd8fBov5+8NBskQmBBFP4Rugd24z0sFDDKfYRE2gEs6/z4NGITSgU5WOnhcNqCZWGo5f1K+9Cn+4oUI/D4OGQQaTPRrrareRjgHORL+tbQ4/fAAApmShOy+DuLWyFGypBmukT8infNB/AtSiiuCKIaHSRABx9WkfBDTxTlFoVBaoY/RKgtzCgq7lTBYfbLMj1Or81lu+pwZzYqQYnj2tvuJemOpQaWFSkfWzN9FC+mniVgpqW4QaYyiehFAXcxslxsvc9en0cZCZKkVksjE9UvF9E84R6xAL/4z/6ZQq4bN277jHbNSejpVGfdoiQWNrLKMsd4ykriM/Dt3N860kPzTM41z3AJp79qvXwSnhj8jCc2e6zjLfWStaFApPWUpcDw9vR5xIwnyqPmdyYoFraCAzfpP+A5xo6f0HsTc6OzIqDNmfw5SmfkcsiJ4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39850400004)(366004)(66446008)(64756008)(66574015)(55016002)(71200400001)(186003)(52536014)(7696005)(86362001)(5660300002)(33656002)(83380400001)(54906003)(66616009)(66476007)(66556008)(66946007)(76116006)(6916009)(99936003)(8676002)(316002)(4326008)(38100700002)(26005)(122000001)(9686003)(2906002)(478600001)(53546011)(6506007)(8936002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXIwSE04SlErNGZLWHBqUDhyMEFsRlpFQVlEMWZGMVRJUjVFaC9DMWNRWnN2?=
 =?utf-8?B?ZjdVRzh5OVloTWoyYm1WbFVVZ1J1RFFEbXMzMHlwa29xQTFJcHJSQ2pHQ2NG?=
 =?utf-8?B?TVVGUmJGLzQzSTMyblpDamdYSDBiQ0tJUXhodWRxdjhBNFlhaDBOdnk4QXpS?=
 =?utf-8?B?L0hhWmFBOXZIUk8yNFNsN0hEYncrWmpJUnpuKzBGa2V4c2tqZjZQU3NjWXVj?=
 =?utf-8?B?SmNyTlhJNFI0SnFoQVBsTllmNm5nUi81b0VsYnVYNVRxTVNmekJvTGZZVGJu?=
 =?utf-8?B?RWZPdjJoSDQ5aHdvdmEvUkV0R1pMdTA1MkFZN2Q0TUZ5bjdSRENUeDljU0tx?=
 =?utf-8?B?UXpuS2FLRnA1cDlGUDRhd1cwV3ZvWUJ4Z1c2djlMZ2FaSlBoRkJqajVUS0FP?=
 =?utf-8?B?Tm9qQWtCdE1DNnVSb3VPUzhWS3ZVendhWEd3RUhHK2xsT1N2UzlLZkxzNzJs?=
 =?utf-8?B?bC9BWWx3ZDZJRG1xdUhOK3BTYUZ6UWFaKzJGUkZ6L2Q2U0R6NnErSHVLTWlx?=
 =?utf-8?B?K1EzR1F3eEhNdGNnUTNBSWtVNGFtODZsOHdmdk52LzFmeXZGQ3VsdHBQWkZu?=
 =?utf-8?B?RVUxZE95NFVvSWY0UmVMYmMveG10bityMkpwb2JKeUNnRGg3N1haVis4NHNl?=
 =?utf-8?B?eFRPamVTWTFhL0l3VGdZQy94SjRZMmx5Ky9QZ2hxSjM5L3VrQ3hjbi8vcWpS?=
 =?utf-8?B?clpvdjErTGhnZ0pXUk13NXVGcG8xVHB0aHhnRG1WTTRpOVhsTXFhNjJ4aktr?=
 =?utf-8?B?aFEva2xUejdHZUEzQStFMU5nbllpTW5XK29UQXJ3dDM2cFVBR1JUQklickRt?=
 =?utf-8?B?QlVoMDIvUHB5dURIRGtaa2Q2SkQrdy9JNnJwL2xwZ2g3WlFaYTVxK1NkY1pY?=
 =?utf-8?B?YWlkdnRNcUpNeGkvcGRxekROMElZbmFRMDVJYlFTemxjMEN4bWk4VXdoTmo1?=
 =?utf-8?B?UlZmcnlpYklRa1hvS1N3YVJmR245cmllcmljelBJTWRwb2NWbCsvN3pGcDgr?=
 =?utf-8?B?N3lLZWVISGFRdWdqck52YUVVcVhsdmNCVkx0OWhSdEJERUxrT0xwN3RyYVA4?=
 =?utf-8?B?TGY0ZlRzOTRSc3E0OTh4cUZydS9vd0tCVWhZK3RwYWI4NUFKam8yTkQ1QXhy?=
 =?utf-8?B?RXlKYm5sWXp2TVZnZFBrODhYNXZKRHlMNUhOR29EQ3gyOXI3Tm9tL1VDbnpn?=
 =?utf-8?B?N2owRHAxRFR4U0VydGd0N3dSRVN0YkJHZjNYbGMzMnR5UFNPVVF0UXhvN2lN?=
 =?utf-8?B?bk5aaTl2NmFLb2I5LzV0ZzQ5M01UeWFMeVp4cE5VYzhrcHh6N1pKRVVVMHVU?=
 =?utf-8?B?bkUvclV0dExPLy9KN3JlSnl3cWVnUU42OHIySDdRWWkvMFdLYlRIMXU3dStl?=
 =?utf-8?B?bjdmQ3cvRkZmV0xUNng5eUFzZTNCdmIza1dERElPVmNyODFMWVdIdXlyS2R6?=
 =?utf-8?B?S1lXWU9yWVFiZ0hpMWNOY0lyb0tyRm9wSlp3Zkk2VEtRN1A0RlM0UWUxVzhy?=
 =?utf-8?B?SmdmK280blhvMFNnUGxXNU42MTNtakE2aGhJcEZKbk56dkNqbWRVbUZRMUph?=
 =?utf-8?B?OEROWm82Snp6aDRpNXpiWTFSVk5qa0VzRlVnajN6d21sNExWdUZSVXQ0TWRu?=
 =?utf-8?B?eXptMytTU29LZHkxOG9oMDBiU0RmSHF1UHdCM08yRVljM0QvajVCSGVjS1BH?=
 =?utf-8?B?RWR6MzU4OTlSRmZMcjgzSXkyaEwzSGFxYXovbTJ3WUcrbE5ob2lYdkNXeFlu?=
 =?utf-8?Q?tPvANutPLNfo+x/NgA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_010B_01D77A28.6DEBCF10"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac449f6f-b797-48fe-e74b-08d947fc8479
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 01:53:32.8928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYboI3S+9JwlPRVw5PP2P8QDYEkQFjxCN2BzsPWpXOqALevofWwCHnYB21zhWXrno2o2K/o0No1D8HGIL0d7XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2483
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_010B_01D77A28.6DEBCF10
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Thanks for your review!

> -----Original Message-----
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> Sent: Friday, July 16, 2021 6:56
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: conor.culhane@silvaco.com; alexandre.belloni@bootlin.com;
> vitor.soares@synopsys.com; boris.brezillon@bootlin.com; linux-
> i3c@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/4] i3c: master: svc: add support for slave to =
stop
> returning data
>=20
> Hi Clark,
>=20
> Clark Wang <xiaoning.wang@nxp.com> wrote on Thu, 15 Jul 2021 16:24:12
> +0800:
>=20
> > When i3c controller reads data from slave device, slave device can
> > stop returning data with an ACK after any byte.
> > Add this support for svc i3c controller. Otherwise, it will go =
TIMEOUT
> > error path when the slave device ends the read operation early.
>=20
> Is this part of the I3C specification? I am not aware about it.

Yes. I think the spec mentions about this. You can check section =
"5.1.2.3 I3C SDR Data Words" of <mipi_i3c_basic_specification>.
[3. Ninth Bit of SDR Slave Returned (Read) Data as End-of-Data: In I2C, =
the ninth Data bit from
Slave to Master is an ACK by the Master. By contrast, in I3C this bit =
allows the Slave to end a
Read, and allows the Master to Abort a Read. In SDR terms, the ninth bit =
of Read data is referred
to as the T-Bit (for =E2=80=98Transition=E2=80=99) (see Section =
5.1.2.3.4).]

Best Regards,
Clark Wang

>=20
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 28 =
++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > b/drivers/i3c/master/svc-i3c-master.c
> > index 9d80435638ea..892e57fec4b0 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -865,7 +865,7 @@ static int svc_i3c_master_read(struct
> svc_i3c_master *master,
> >  			       u8 *in, unsigned int len)
> >  {
> >  	int offset =3D 0, i, ret;
> > -	u32 mdctrl;
> > +	u32 mdctrl, mstatus;
> >
> >  	while (offset < len) {
> >  		unsigned int count;
> > @@ -874,8 +874,15 @@ static int svc_i3c_master_read(struct
> svc_i3c_master *master,
> >  					 mdctrl,
> >  					 !(mdctrl &
> SVC_I3C_MDATACTRL_RXEMPTY),
> >  					 0, 1000);
> > -		if (ret)
> > -			return ret;
> > +		if (ret) {
> > +			ret =3D readl_poll_timeout(master->regs +
> SVC_I3C_MSTATUS,
> > +				 mstatus,
> SVC_I3C_MSTATUS_COMPLETE(mstatus),
> > +				 0, 1000);
> > +			if (ret)
> > +				return ret;
> > +			else
> > +				return offset;
> > +		}
> >
> >  		count =3D SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
> >  		for (i =3D 0; i < count; i++)
> > @@ -884,7 +891,7 @@ static int svc_i3c_master_read(struct
> svc_i3c_master *master,
> >  		offset +=3D count;
> >  	}
> >
> > -	return 0;
> > +	return offset;
> >  }
> >
> >  static int svc_i3c_master_write(struct svc_i3c_master *master, @@
> > -917,7 +924,7 @@ static int svc_i3c_master_write(struct =
svc_i3c_master
> > *master,  static int svc_i3c_master_xfer(struct svc_i3c_master =
*master,
> >  			       bool rnw, unsigned int xfer_type, u8 addr,
> >  			       u8 *in, const u8 *out, unsigned int xfer_len,
> > -			       unsigned int read_len, bool continued)
> > +			       unsigned int *read_len, bool continued)
> >  {
> >  	u32 reg;
> >  	int ret;
> > @@ -927,7 +934,7 @@ static int svc_i3c_master_xfer(struct =
svc_i3c_master
> *master,
> >  	       SVC_I3C_MCTRL_IBIRESP_NACK |
> >  	       SVC_I3C_MCTRL_DIR(rnw) |
> >  	       SVC_I3C_MCTRL_ADDR(addr) |
> > -	       SVC_I3C_MCTRL_RDTERM(read_len),
> > +	       SVC_I3C_MCTRL_RDTERM(*read_len),
> >  	       master->regs + SVC_I3C_MCTRL);
> >
> >  	ret =3D readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> @@
> > -939,8 +946,10 @@ static int svc_i3c_master_xfer(struct =
svc_i3c_master
> *master,
> >  		ret =3D svc_i3c_master_read(master, in, xfer_len);
> >  	else
> >  		ret =3D svc_i3c_master_write(master, out, xfer_len);
> > -	if (ret)
> > +	if (ret < 0)
> >  		goto emit_stop;
> > +	if (rnw)
> > +		*read_len =3D ret;
> >
> >  	ret =3D readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> >  				 SVC_I3C_MSTATUS_COMPLETE(reg), 0,
> 1000); @@ -1012,7 +1021,7 @@
> > static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master
> > *master)
> >
> >  		ret =3D svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
> >  					  cmd->addr, cmd->in, cmd->out,
> > -					  cmd->len, cmd->read_len,
> > +					  cmd->len, &cmd->read_len,
> >  					  cmd->continued);
> >  		if (ret)
> >  			break;
> > @@ -1141,6 +1150,9 @@ static int
> svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
> >  	if (!wait_for_completion_timeout(&xfer->comp,
> msecs_to_jiffies(1000)))
> >  		svc_i3c_master_dequeue_xfer(master, xfer);
> >
> > +	if (cmd->read_len !=3D xfer_len)
> > +		ccc->dests[0].payload.len =3D cmd->read_len;
> > +
> >  	ret =3D xfer->ret;
> >  	svc_i3c_master_free_xfer(xfer);
> >
>=20
> Thanks,
> Miqu=C3=A8l

------=_NextPart_000_010B_01D77A28.6DEBCF10
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNv
bT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0
aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Js
hi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsG
AQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2Ul
MjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29i
amVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDBHBgNVHREEQDA+oCUGCisG
AQQBgjcUAgOgFwwVeGlhb25pbmcud2FuZ0BueHAuY29tgRV4aWFvbmluZy53YW5nQG54cC5jb20w
DQYJKoZIhvcNAQELBQADggEBAK4JPoIkTbfuhwLtQ9Fm320K9JnOD+UvIk7UY5A58pq540ABcjCz
LggHvY+pE9m6IdsLfPL0lj4rrK660DRFM7k6XQEoJXjOBlZ+FGi7oTGL+VVi4+TYQzwPUMr8Ukg1
EBMzKb84Kh3oA96THluC3OFR3DbU/3NJsMYI6hIpvL4G+MQS0NZiEOf0CW73kreekaWUzCcnDbjr
9c8a1dI966lFSHr+2MAjj1iiNou1MXi3YA0jTy2qW78wdbtk/UbWkFIp11SyqA6Va6i96c7WgohG
zzxofRhw1yf5mb0SSjrbcFvLWRyx5iVZIhapdbztkYGYJiroxzI+ndpbztisjkYwggfxMIIG2aAD
AgECAhMtAABZfNGGA83aLDAMAAAAAFl8MA0GCSqGSIb3DQEBCwUAMIG2MRwwGgYDVQQDDBNOWFAg
RW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcM
CUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTET
MBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwwHhcN
MTkxMDI5MTM1MDU4WhcNMjExMDI4MTM1MDU4WjCBmjETMBEGCgmSJomT8ixkARkWA2NvbTETMBEG
CgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEMMAoGA1UECxMDTlhQMQswCQYD
VQQLEwJDTjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UECxMKRGV2ZWxvcGVyczERMA8G
A1UEAxMIbnhmNDc3NDkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCZY70u6L2tkQw7
9PyXIwnCQZGWP+8gSezFvuegmg10bDVMZux1jQKY48+p9oQeUBOfM9652qP5o4VTqDCR4MBxbtB7
CXxyjzKOdVxraRqx+xibX12lcs4LmCtz3JeEduJkKJ7W+QJtTbqtF6okCUCQRT/vF/BqUyfNyVs6
Mexrp1Lj4Yv841rbsVKC6k3jdt1pqi/0YZscxs7rqP5VsvFcK1der8zrQ/98AbMMjoagsu+nq64x
xPly7BcBfjUMTlw2PsL5viDocyLeVtW22VInObVN2bvFKdtkQEliZtoBKVwevOx1UMYis/yAbqhE
x+7g2Z/59jqDaZSy7SOxigvhAgMBAAGjggQQMIIEDDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3
FQiFgsB+gY70VYbthTiC65lLmpJWP4Xmim6EteF+AgFkAgE6MBMGA1UdJQQMMAoGCCsGAQUFBwME
MA4GA1UdDwEB/wQEAwIFIDAMBgNVHRMBAf8EAjAAMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUH
AwQwgZQGCSqGSIb3DQEJDwSBhjCBgzALBglghkgBZQMEASowCwYJYIZIAWUDBAEtMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEARkwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAKBggqhkiG9w0DBzAH
BgUrDgMCBzAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgIAMB0GA1UdDgQWBBSZJY1p6Y56
X4YAWIozHW4aGPBzZDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDBHBgNVHREEQDA+oCUGCisGAQQBgjcUAgOgFwwVeGlh
b25pbmcud2FuZ0BueHAuY29tgRV4aWFvbmluZy53YW5nQG54cC5jb20wDQYJKoZIhvcNAQELBQAD
ggEBAEH+a5BarGYCUuH4P4sFJkrA7Y1U1aWb2nxNOPDARJLTwdEyMP6pPY0Bm7AyypW60HlI3Z4I
eP6NiMibW55/xz5EEcHxOrbYFmPyLY9twXLluCHnpZYT3NrDCD9dbOhUeZbDB1FXG93zfMJ8zzL4
9njRn5J6mcLiHkUpVRacp9susO1zN3uzp8TXCHy/y483CE6g1qUijUyiTPlAT9gz7xvyxAhTmrhH
8Fue00PWfK0B7zzjd1b0Da2nWFZXk4IsYJeyt+RTWC07VscWFiJ3avbgN0kaCswkvB1f6DVOqDRx
r5hHoNADBEcsMNdQNRVu2ospazEVq8wtXPTB7Ihf564xggTDMIIEvwIBATCBzjCBtjEcMBoGA1UE
AwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIw
EAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZ
FgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYT
Ak5MAhMtAABZfUBCujlfjY1jAAAAAFl9MA0GCWCGSAFlAwQCAQUAoIICxTAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA3MTYwMTUzMjlaMC8GCSqGSIb3DQEJBDEi
BCB91mK9NuZaUr5MV1SmofYdJgTLINsITcTANoekb17uMTCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsGCWCGSAFl
AwQCAjAHBgUrDgMCGjCB3wYJKwYBBAGCNxAEMYHRMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJw
cmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRo
b3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmS
JomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAFl80YYD
zdosMAwAAAAAWXwwgeEGCyqGSIb3DQEJEAILMYHRoIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJw
cmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRo
b3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmS
JomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAFl80YYD
zdosMAwAAAAAWXwwDQYJKoZIhvcNAQEBBQAEggEAhS/CZfGbDi2U7H/SD820BJjhaIqPxVFlk10t
6jATi212hfLO+3mdcQrqxs4Yq2adrWyHC5iAd1TdsAaBzUQ1xMuNwOre4bV2E7TiZK3xrdBoey5O
xW/l1P5pyCvewNllbKfB4UPGY7T25ktIc4+hs5EK2YCkWqOfgkFWD+54vXMMN2OUggj7GfVKxDLn
cH3okWntdRN2a5kDDqXIJ3xhNF2QLcSQ6OrKyW5sAQXHV5k4BztQTMVJxAf0WynB6uYQMdgHL+b5
uHj2irfY7QaC7emakn4qkpMOs+xmIHQ8oRBO+bVw/keiMQGbiRYxdQC1RvcAhUccml5kqvKSL79m
rAAAAAAAAA==

------=_NextPart_000_010B_01D77A28.6DEBCF10--
