Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153C138E0B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhEXFk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:40:59 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41380 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229633AbhEXFk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:40:57 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14O5Yuga005664;
        Sun, 23 May 2021 22:39:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=cBcR0UFEEP/aLpd7s30h9bStyTxBGSkTMXK1FSr41dQ=;
 b=SizbZ7rw3nMgkOXoXQoJxckXr1+ekza8DcCbcQbjY45M1gI/WWzEMHCQW2iiXLLP3RAx
 57ciVLlT7GQfM2wNa88rGW9/15lzK54GR1eiGNAYnV43y7ziU9rRFkN9EvPJd9j1rjkq
 HsrUJc8rXCX5ZzouZqMQRZXeoYnwuPExtOz2cQdNBvN6oOpvKPCnTEzIdR04rzvhVugD
 4W4hVvHes/1eImKPPJ4RfFP0d4uEhLeawGBweDPFWczn+gROqHcdA3NQPRNS04iShkhL
 zHMrQbqJKHm/skx32S4iG6K+tRBBIanzCQ9honelOKcfNBW4UYwAJ1K/ciDvofVxeNRT 7w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-0014ca01.pphosted.com with ESMTP id 38qp349sgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 May 2021 22:39:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra5ICZxMaAPblbMcqMEkScUP7OvZ4feOCdzTAAam22oShnSbodzsWrfhsbdd3NHvMcI3Sej/6sAHYN5K9eTYxcMXE9z3br2xTiDUmh7DRHA6i+MDsN3EwPTBYnUNzkznGINo7ZjDUiVssbz5eAJogyqtnXBLj1jz0WvKQnNbSNvdNMN0sbBK1RKj7vLIxJ2dmDXbgUsfbZAdhSAZ0dOdfn34vs/kPNwRInx9/1kvDlbHKluFQT2Pjvt6MsJEVE99k/JNMXg6aocsdE20VBtW8uHrKRLA5PFwsOzbxWO8vdFoCfR+rnXjh2H1qCTrwJnn6V6x5W7wO7FAYrvsGtge4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBcR0UFEEP/aLpd7s30h9bStyTxBGSkTMXK1FSr41dQ=;
 b=mJZ3Nq9JxNGj1N664uOYQjG+lGF9ne/xhNMpZplHtMRtK76ZRFUq9i6WMHrN627vTzYJFzBdKj1HmBNLDxrXjxfMVO82ij/Ya7rrc14LSG9y064voGT8yIrEhp4Q/FIQfQgaJnvZYZPLxy54sltkeb72ryu3k8NFhzHPyvdCs21mZRREStvIRQt8NqG7Lh87uiFFyzgtpuPq4+wMxaeOLwYzxJPYw3bvEn0Z1loTCuex8DWFMM2+tgTxRyifW4gEMyl2WfJqWll5t/FJMUX6zgHCsgPOq849rREfojx4VEF4HFRApev2ghSTBLZWdf2Frgiq52kUzs826yLI84W/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBcR0UFEEP/aLpd7s30h9bStyTxBGSkTMXK1FSr41dQ=;
 b=oLl+IdbwpG0Gtr2X0PktbPQtyFIB81fmpEERPusPArHnSPfxQYj+vR1RD6HU1cyMLKCumoaUwt0nT1QTS2nAa2WdVuvCWrHwxUKNhoNHki32isTgaLji9K5HI2ly7mM/kSlH++4UUw4YsIxAkU1ugtFlAnFIPBy4af1AlOUJOCY=
Received: from BY5PR07MB8119.namprd07.prod.outlook.com (2603:10b6:a03:1d4::15)
 by BYAPR07MB4856.namprd07.prod.outlook.com (2603:10b6:a02:fd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 24 May
 2021 05:39:22 +0000
Received: from BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::997a:e699:1548:e9da]) by BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::997a:e699:1548:e9da%3]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 05:39:22 +0000
From:   Sanket Parmar <sparmar@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>
CC:     "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH] usb: cdns3: Enable TDL_CHK only for OUT ep
Thread-Topic: [PATCH] usb: cdns3: Enable TDL_CHK only for OUT ep
Thread-Index: AQHXSy488vN61g59eEq3SQd4c6aFyqrvTquAgALMHDA=
Date:   Mon, 24 May 2021 05:39:22 +0000
Message-ID: <BY5PR07MB81192669816D2F08D4AEAD1EB0269@BY5PR07MB8119.namprd07.prod.outlook.com>
References: <1621263912-13175-1-git-send-email-sparmar@cadence.com>
 <20210522100913.GB12415@b29397-desktop>
In-Reply-To: <20210522100913.GB12415@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3Bhcm1hclxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTYyOTA4NGUyLWJjNTItMTFlYi04NTgwLWM4Zjc1MDJlMjExYlxhbWUtdGVzdFw2MjkwODRlMy1iYzUyLTExZWItODU4MC1jOGY3NTAyZTIxMWJib2R5LnR4dCIgc3o9IjIyNzQiIHQ9IjEzMjY2MzA4MzYwMjIxOTc5NCIgaD0iVytYOW9RMXZKTlE2SFMzRDRtRFNaMk5xckhBPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [14.142.6.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d0c5666-fdfd-4711-c58a-08d91e7648e4
x-ms-traffictypediagnostic: BYAPR07MB4856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB4856505F2F78B7DE6669620EB0269@BYAPR07MB4856.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLhx4GDyJbT6OSx9YTYw8772l+7V4ZtvVNkD8zsEIKmd3uIf6msbbEELHdlyH7QXlAbI0j84apaChHC0ohk1kJTUY6jGR3uA8is7X7pEdyA5DI66Pn/hZKrt3ItkhNnxFP3MRWwkNXeohKgQAc8QEiK13Kn2gPxyeL5848ieehE+5IHUSjeb1ta31bsu2/ijVT7obBcOfRiSIapGLmRhM64WNc6WToHVHocLrHuLZfeW8g8sgjwZx757il5i78Yuwwk+BdIG4QL1+r8nOFArlvXRtBNPynvpNN6wjGKYcfu3dfQbWR7FhHH6nppdQKJs7yPlvbtwr3Zuqo2w8iqyJ+bZQFnywJ6GbSKeCqvhozm5KSeakmSL2ZCEsvfl3POELgimUJ18No0gyMklpCIWJXjNa55DCdLw13JCLz3+Vdgx4N758brK1sWBfmlCxz9RgbGK6XNxENQVJ83KEYKcCs9lCDNgPCvzpN5bSoCtFlVa5/7AbdJnNlRK6T45rjG9sJLz1YN0v3WDjSFs48PHUquuGY1sEnVkPBaYNH0BU3J102waCemnbIGRmG9Z3TGCMygg1gXYoz36Kh3V8Dgon9fr0hCozQOWfb+SsFRjP5D7l342+ZiF9Fmzwxq3kTG8slcYzTj645jSYUqfblrfx4fx6fagsXLn6I68+aBadbw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR07MB8119.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(36092001)(86362001)(6636002)(52536014)(186003)(71200400001)(64756008)(33656002)(2906002)(9686003)(66446008)(66556008)(66476007)(4326008)(76116006)(5660300002)(55016002)(66946007)(26005)(478600001)(38100700002)(122000001)(8676002)(110136005)(55236004)(53546011)(6506007)(7696005)(83380400001)(54906003)(8936002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aIrgnLuEW8+C6ucDdtm6l3WjgdUz8iXlegODkujt7hcJxluI1Tt8Jgr0pHml?=
 =?us-ascii?Q?H8Bh1Qi2vKSc2Ejzk92MzQVz2spaHVKHkxIYu78knJwH6Rk8QNv2wjtfbCbw?=
 =?us-ascii?Q?vQ4WhL4W3TbwQAcens+psCS93kYAKR2xxf9aoXZUNxpbmIoQs74pfmZ0CmjE?=
 =?us-ascii?Q?krhcBo4FmOnhSNnm9go+AUoHX9Txmt55pFKuo4hpgmBn/zigBByp02n4OYpH?=
 =?us-ascii?Q?7EUWwpjAhL9rHfo9xjHH8m5X6hlFXDNU81qhA+zzrFgKJWdTTiPffpUoEZKq?=
 =?us-ascii?Q?boSg2D7rPfy+0w1hIthnaW7Y5TjM+QSLQrXMKfNHXKST/HXxldnsKB0Ce3Wu?=
 =?us-ascii?Q?sBrh/W+1nDQ/2AUIDN5nAdzmG6QOm4b2Zrf8JQXYY7Sn3dJy9kFa7tTtkr4B?=
 =?us-ascii?Q?MoXgEJWFdj4bH0tIiPNtEePusT85MeSv0XD57tmbP3CtBk0WPRqFTXaxRV9H?=
 =?us-ascii?Q?kYB5H4LP4JuQfcoC7hz+OeLNUb47Qk2FSs3cRzDiZoVth8Z+vFnQbZeeym94?=
 =?us-ascii?Q?oeg5uaA4owTXNwDWUWYfoHSJYfmwH+WskT43vjpRSVhWzfrG7bT5yErxNsGs?=
 =?us-ascii?Q?qLQL4YE+r+QxWOak3ID9Diya6asSMvgx6jv717KJvPqqIHNCtG0y+CRKEW9d?=
 =?us-ascii?Q?hDYe/zDhThVQx7hhcNEku91tlqlczM4S2T6ykBk5QcdzsN7XvZjo3nskiDrZ?=
 =?us-ascii?Q?ly2BVgN3h+nqiAb4DxuDL5EGRBw9yQ4NAxvn0ymbc+fkCdCcaLNHRtwynKdR?=
 =?us-ascii?Q?dLPS+XtN35w6iApwb1d/vxMyAGoItOXW5EM4Q8bgTuMKcAnwh2DjgoTCji1V?=
 =?us-ascii?Q?yuUNSyvesFLa1AfM6sWStsAMzm7Q+dvTF9UOQv0ONdkZRjQekJQYHNpe3mk8?=
 =?us-ascii?Q?+vMLh4I4+PLPxHqZeNF7kMUT4ayro60jyx8jmVPSfKYsCdpx0W9kXucoFj43?=
 =?us-ascii?Q?JxwKAcGcBNzx6JlkbfpMCMoyf5EtwMppG/pW7wb3hQCRvUydQUwjopPeuhSz?=
 =?us-ascii?Q?lRRHcNqxWL8UmvFCHWFZ/3YVrUVsNBF991KHcHXAi82EPFqWR3bOsnNmeGTB?=
 =?us-ascii?Q?upcTBz4IrRYu7TDisXsOBJ1HEOZgeApDsGTTButGr1cUfDbqudOtnJb9qW/3?=
 =?us-ascii?Q?1seuK/z2z4PERbiWa5H6X4/C/z0mRBd5rhBwipbogKvZs1hQBoiGJK8cT96r?=
 =?us-ascii?Q?ITP/BhD68IiCpF6R+S4QxC8tJ+msJa9AQVUfzI+Un/RwclFNZGZ5Dj3YqDkP?=
 =?us-ascii?Q?1hCqRKCy7OEhOpv3wqqR+KvAJRuqxbQ56oR//qGKQZLJf3fcu5h2n9MtOuoS?=
 =?us-ascii?Q?wj0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR07MB8119.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0c5666-fdfd-4711-c58a-08d91e7648e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 05:39:22.6268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRI9SActBfjUtuQQqQsMM0Zj8SjFmuoihek3TRAcyFK0OkYkBuJh/nEvO3rBFpUvMjxrT7nJeBGwWmfvT++Knj+GWDDSPoobWD0+LlJ2E+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4856
X-Proofpoint-ORIG-GUID: Gw66BYNjdsbvRhPNiGtviHrlCe5TViRp
X-Proofpoint-GUID: Gw66BYNjdsbvRhPNiGtviHrlCe5TViRp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_02:2021-05-20,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 21-05-17 17:05:12, Sanket Parmar wrote:
> > ZLP gets stuck if TDL_CHK bit is set and TDL_FROM_TRB is used
> > as TDL source for IN endpoints. To fix it, TDL_CHK is only
> > enabled for OUT endpoints.
> >
> > Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> > Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> > Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> > ---
> >  drivers/usb/cdns3/cdns3-gadget.c |    8 +++-----
> >  1 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3=
-
> gadget.c
> > index 105855a..f3c0276 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.c
> > +++ b/drivers/usb/cdns3/cdns3-gadget.c
> > @@ -2007,7 +2007,7 @@ static void cdns3_configure_dmult(struct
> cdns3_device *priv_dev,
> >  		else
> >  			mask =3D BIT(priv_ep->num);
> >
> > -		if (priv_ep->type !=3D USB_ENDPOINT_XFER_ISOC) {
> > +		if (priv_ep->type !=3D USB_ENDPOINT_XFER_ISOC  && !priv_ep-
> >dir) {
> >  			cdns3_set_register_bit(&regs->tdl_from_trb, mask);
> >  			cdns3_set_register_bit(&regs->tdl_beh, mask);
> >  			cdns3_set_register_bit(&regs->tdl_beh2, mask);
> > @@ -2046,15 +2046,13 @@ int cdns3_ep_config(struct cdns3_endpoint
> *priv_ep, bool enable)
> >  	case USB_ENDPOINT_XFER_INT:
> >  		ep_cfg =3D EP_CFG_EPTYPE(USB_ENDPOINT_XFER_INT);
> >
> > -		if ((priv_dev->dev_ver =3D=3D DEV_VER_V2 && !priv_ep->dir) ||
> > -		    priv_dev->dev_ver > DEV_VER_V2)
> > +		if (priv_dev->dev_ver >=3D DEV_VER_V2 && !priv_ep->dir)
> >  			ep_cfg |=3D EP_CFG_TDL_CHK;
> >  		break;
> >  	case USB_ENDPOINT_XFER_BULK:
> >  		ep_cfg =3D EP_CFG_EPTYPE(USB_ENDPOINT_XFER_BULK);
> >
> > -		if ((priv_dev->dev_ver =3D=3D DEV_VER_V2  && !priv_ep->dir) ||
> > -		    priv_dev->dev_ver > DEV_VER_V2)
> > +		if (priv_dev->dev_ver >=3D DEV_VER_V2 && !priv_ep->dir)
> >  			ep_cfg |=3D EP_CFG_TDL_CHK;
> >  		break;
> >  	default:
> > --
>=20
> Sanket & Pawel, please confirm this behaviour could apply for DEV_VER_V3,
> that is TDL_CHK can't be used for bulk in for DEV_VER_V3?

Yes, TDL_CHK shouldn't be used for bulk in for DEV_VER_V3.

>=20
> --
>=20
> Thanks,
> Peter Chen

