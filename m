Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11335331EBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 06:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhCIFj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 00:39:58 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50386 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229475AbhCIFja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:39:30 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1295Vg8I015003;
        Mon, 8 Mar 2021 21:39:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=n2mEBe+tF6uwWgDvF5T3UzZOGy9tZN7KPP0zn1mAgN4=;
 b=NasCI6EDXT62mlW5kLObTm62q+6zjiNbvyeIu1wSMWCN3IPGEZGjNfYwYnY/Xr+ofeN0
 4JqtSS34RQ+bRq0tM2oFRbq4F5HZNU+9Hx+hFjnxQBCUZJrHuGO5U9t1XT6POO6g8Fim
 RhV9lWBcUPn/lcyiFQWkZkg2o//fybMhafwO0OtJM26kosNbo8sa6+YD6crwQCkR3H1R
 1oK/qtLytx6/znvMIAzW/OozaFVNjcueaaTo1A9T16HUZ7Ygtk7X9ohtPsUf6fqCr8j/
 ojirW20wAbYCF920nJ8SjRpdwnE0WxWvYRbXjZJxnPoiisp6i1BgYqsbi3whhbkXq5i1 eA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-0014ca01.pphosted.com with ESMTP id 374762ydcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 21:39:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuOl9heQROKkuu88SahE1t5eu7soeHvrugdgV1qpLEKbMfmUe6SQDxssL3ytCACx64ttFD5BgRECV8hiFo/QhxJf0xt+vxz4EsK5WgQWtco8Yj4GDE3AWb8eTjspr/phtj6dErxOSR7yvpoxjbEOOpI+qCa/cEMzV6OODihLIxMj2U4s1vz5rc0lV1/nv+UzrtojwgdZMLTbdTYI2AgUyKxko0AUQZnaBDP6yjWkSuk1PoKKfhSymYFx+ZonmmwScGFYHHQMFF6511iXbN6NBxsn9dSVwZ5M3z9sb5vsXUK0AJecT6u7NBT3yRRROjnHDnniXYDMA5ox3FO+wS9QUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2mEBe+tF6uwWgDvF5T3UzZOGy9tZN7KPP0zn1mAgN4=;
 b=j8fw6w8dwZLjsVp8Qx43fInQPt5n5E/g02M9Ba3U5V3llgPXJpXoPTngXI7pbOlp/2zD60++RO04NiorWge8SMs52/QVng+BI5a3s3JI7skCKuM+8l7i8JG1keTm+/VORRqojta/GE8jF7+tLjc1fjuDcfeN9Vrzm4bGs0g9shIEF9VnuxrJ6Rtkq97ehqETdgafvPn9YMoroga2UeT3CfGAOcs0xMhUwpRTuGv9rga7Et0n/VjcyZb7FzQ/cK9MmjOsjJVIaJGhX+BpvvvsWNUY4HB6Qo+czGH4gGF/9R8yD4hfdhhtQkEQ2JLCRPz+OpRPtHm8yQiGYMIl1+heCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2mEBe+tF6uwWgDvF5T3UzZOGy9tZN7KPP0zn1mAgN4=;
 b=pC9zIjfjWMu8bWr6iwgbn6PmXFE54AL2HhWbOddNpPf5KfxD2Q2RrA39hqmDJMZvUTU7FGmBeA6nEkfKHYJQSXaHaD2QQi311LpKO0D0m8AceUKYm/vEY3L3fPr7OjcnuRGOs6tOvpBNcjnvH8W42hHlkHagd9auSG4AxQsLbSU=
Received: from BY5PR07MB8119.namprd07.prod.outlook.com (2603:10b6:a03:1d4::15)
 by BYAPR07MB6326.namprd07.prod.outlook.com (2603:10b6:a03:125::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 05:39:21 +0000
Received: from BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759]) by BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759%8]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 05:39:21 +0000
From:   Sanket Parmar <sparmar@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "frank.li@nxp.com" <frank.li@nxp.com>
Subject: RE: [PATCH] usb: cdns3: Coherent memory allocation optimization
Thread-Topic: [PATCH] usb: cdns3: Coherent memory allocation optimization
Thread-Index: AQHXEdjXQil6LfD5FUaM8CnIg7s+s6p2LwYAgAT4IKA=
Date:   Tue, 9 Mar 2021 05:39:20 +0000
Message-ID: <BY5PR07MB8119BDCC597D72B64FCD3A3EB0929@BY5PR07MB8119.namprd07.prod.outlook.com>
References: <1614960071-30367-1-git-send-email-sparmar@cadence.com>
 <20210306013808.GA2399@b29397-desktop>
In-Reply-To: <20210306013808.GA2399@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3Bhcm1hclxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWM5NjhiNWUxLTgwOTktMTFlYi04NTc0LWQ4ZjJjYThhNTI5ZlxhbWUtdGVzdFxjOTY4YjVlMi04MDk5LTExZWItODU3NC1kOGYyY2E4YTUyOWZib2R5LnR4dCIgc3o9IjEwNjQ4IiB0PSIxMzI1OTc0MTk1NzI3MDUzMDQiIGg9InBIdUtlN2w2OFc1SU5iUmNJVnloT2t1REg3ST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [192.5.98.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d476472e-be14-415d-0e07-08d8e2bdb081
x-ms-traffictypediagnostic: BYAPR07MB6326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB632621A523F16A8E05E9B68BB0929@BYAPR07MB6326.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kO1PZ4G1Y2SgvWbEp8aZZsDV64QD8hn1djQw8eHA2/1J9ObfVTUvLPuHPEvmpIYDzTx8q52n2YVpl7jHED/AjQTCtwcNjceaD/xnAKg1bSobzkna0elqvK4iBks9kEsC6vsyo0NTDeGLyrd5Uzj55v7VLyWpvnIxKgc3+UOMlVo7It3iM+5edUSZhj5IzD5aYb2YvjjyfnF1wIrpyzMGH+1Wx0vyN28jMgVBcU8jyWYSxsToN8b/6ZVeaXC7NZ6tu2dVJJCtSf6ASdxC1zUJQJwK9s3PlkhUqO69HYDamrl7qmRSeyf8QpKU/eajFRxCw2hlneP2c+mD0+tCOJGJQxd+O9z23Ve6tPiqzYmxLO5fZTPSGlyuEP4aeBm9jzb+AZWU4va64lEU4urBmnkFM7Ns3If4DDXOHcxBjUUSY5Z0o5XKDDVS2DQDWrGEORm8i+hBy7AnwR37KZIbQevNMS4wFVCgJC0pLbvEJgVnnYeHNons77c87nVFG3tq76ziByKYTaIW7aW96/PZdURpcZkt8LUHAL22Vg0eAmsPDZRycLXgCwXXYuYAa2bcyOXIBUQQWeBaZL/qivk+9CNmYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR07MB8119.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(36092001)(76116006)(186003)(66556008)(52536014)(83380400001)(55016002)(2906002)(66946007)(5660300002)(6916009)(478600001)(64756008)(54906003)(26005)(66476007)(9686003)(53546011)(7696005)(6506007)(66446008)(86362001)(4326008)(33656002)(316002)(71200400001)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dHPGZLObYjffRN5XyKtcrFBGbaUs7bYD7+xqqMR+QqMePgZVSeTHL2WILq8V?=
 =?us-ascii?Q?XtztInjVIS3R/DDBsPz7mtfZXuISC6za+rh7tR1vumpw5NjAhai0Io0HkPsq?=
 =?us-ascii?Q?61q7ZK7L76d4N6lij50HofgDcz2aVutPATyYs0DNMxxbOE9fGoIof6F8TCah?=
 =?us-ascii?Q?lYAng6e7xZ/cRLC+pTyB4deZNjkH++XFppE51UBUui+qVRbSl06JzQIlz/Sr?=
 =?us-ascii?Q?26CjOZAQHXqi0hBNt/EAq3qfLDmkM3tz2Zsm9xoNEP1Nfxpk3Ib1oj2whShP?=
 =?us-ascii?Q?Nn0zgE7i7ST9a0KKUMu456sT56QmCWBydnG8nvmbUQA+DOwa+XeIsZdiwl+H?=
 =?us-ascii?Q?YuZfKn90PduYLPPZonFB/n0/pqXRVMcBJV4qh7zB6vSISq3pB2B78V1Y0Q72?=
 =?us-ascii?Q?P830MEgTvcJ+y8ACIVQK5y9vaW+Qu0a4grNOrwWEzIYiQ4z3dReOZw2ni4SZ?=
 =?us-ascii?Q?vuuFm/boIIcBAgGooDZAyt8JV8iKssYqmETSMGTgICZ3mDgRH7MqvvMOFfic?=
 =?us-ascii?Q?4gIp11F6cVxsVoHrALvOrXqNXHCwo7AEbvKII+Ugfscjgnhvt/v5BL1f1Yao?=
 =?us-ascii?Q?x5KspdYluvr3BYXHPfmxhE+b07pwCeR2Y/fIlFjWNR3uUzqgLgWDydY/rJQz?=
 =?us-ascii?Q?HguxDZTQ0xh4bI3kdKC712cOTSskJ78cagEhair/Dd2/z/sX+9eGJkmtberE?=
 =?us-ascii?Q?mCLSO1Qwzx0QUQlJJPfTImXBONEhgQ37hBJnjmRvUqr+05Mtwh2EwJ2MX4EU?=
 =?us-ascii?Q?bKV8Cl1JlYnL32KyI/o1ir03+/I92FzkcRYaAh9GCEtFKUc/RUfH+wmoqUqa?=
 =?us-ascii?Q?qQMTEFU2MazG4NsN2YBDMOPm0IURCAsYtsV4af5DTjAoG6MjguvAR+94thLf?=
 =?us-ascii?Q?GPaCUYOg5fA8+A3xnbJYqD0A48Ec8Dy/ZEDdl7ei0gcQJE/QMijoWWnPdelV?=
 =?us-ascii?Q?9abC5bwGRuSw8Q1Wfr2ijemNZyYOUXRFTWzNZbQx9kBDb8U+g4QyQkQLhxhl?=
 =?us-ascii?Q?BwbE7brls/rb2loQlL/MeHfMx7gll/x7f/hj3Yy8/XiPDc+Tq1lmjvDhYgfP?=
 =?us-ascii?Q?5HdptJviwh5hMX+AaG8BrjmJiQI9D1w3YeQXMt4U45jqKAKtkiXSIrsX/WoX?=
 =?us-ascii?Q?eHJGyKy81+/6tFPX4PUxDegEC387IjyvHJaptPvwj7XnyZTe78TF0WxGY9jR?=
 =?us-ascii?Q?fs+lbDmvy78lkxTtBJXuhD4ednm4dPWoeWKJP3B6pUxpX5vtaF2OclHzQABI?=
 =?us-ascii?Q?NtOlw6JOj57PK0dS4ovDBoczI+cgnwaXc/f42IyBnjhtquDgswSIeAgD3aqc?=
 =?us-ascii?Q?RNI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR07MB8119.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d476472e-be14-415d-0e07-08d8e2bdb081
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 05:39:20.9097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUdqnn5/hcJD4v9Lgqb/X38YMD5WCmYtBLfM5Fgnmi/laLtUMVLLEs7PAs5Y5plYvzB/VIQ3xCZRB7ZQmvtvdLJiRqNCgflN26jDRL217Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6326
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_03:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1011
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103090027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On 21-03-05 17:01:11, Sanket Parmar wrote:
> > Allocation of DMA coherent memory in atomic context using
> > dma_alloc_coherent() might fail on some platform. To fix it,
> > Replaced dma_alloc_coherent() with dma_pool API to allocate a
> > smaller chunk of DMA coherent memory for TRB rings.
> >
> > Also in cdns3_prepare_aligned_request_buf(), replaced
> > dma_alloc_coherent() with kmalloc and dma_map API to allocate
> > aligned request buffer of dynamic length.
> >
>=20
> You do two changes in one commit, would you please split this one as
> two patches?
>=20
> > Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>=20
> "commit" is not needed
>=20
> > Reported by: Aswath Govindraju <a-govindraju@ti.com>
>=20
> Reported-by:
>
I have split the change into two patches.
New patch series has been posted already.
=20
> > Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> > ---
> >  drivers/usb/cdns3/cdns3-gadget.c |  115 ++++++++++++++++++++++--------=
----
> ---
> >  drivers/usb/cdns3/cdns3-gadget.h |    3 +
> >  2 files changed, 71 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3=
-
> gadget.c
> > index 582bfec..5fd6993 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.c
> > +++ b/drivers/usb/cdns3/cdns3-gadget.c
> > @@ -59,6 +59,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/usb/gadget.h>
> >  #include <linux/module.h>
> > +#include <linux/dmapool.h>
> >  #include <linux/iopoll.h>
> >
> >  #include "core.h"
> > @@ -190,29 +191,13 @@ dma_addr_t cdns3_trb_virt_to_dma(struct
> cdns3_endpoint *priv_ep,
> >  	return priv_ep->trb_pool_dma + offset;
> >  }
> >
> > -static int cdns3_ring_size(struct cdns3_endpoint *priv_ep)
> > -{
> > -	switch (priv_ep->type) {
> > -	case USB_ENDPOINT_XFER_ISOC:
> > -		return TRB_ISO_RING_SIZE;
> > -	case USB_ENDPOINT_XFER_CONTROL:
> > -		return TRB_CTRL_RING_SIZE;
> > -	default:
> > -		if (priv_ep->use_streams)
> > -			return TRB_STREAM_RING_SIZE;
> > -		else
> > -			return TRB_RING_SIZE;
> > -	}
> > -}
> > -
> >  static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
> >  {
> >  	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
> >
> >  	if (priv_ep->trb_pool) {
> > -		dma_free_coherent(priv_dev->sysdev,
> > -				  cdns3_ring_size(priv_ep),
> > -				  priv_ep->trb_pool, priv_ep->trb_pool_dma);
> > +		dma_pool_free(priv_dev->eps_dma_pool,
> > +				priv_ep->trb_pool, priv_ep->trb_pool_dma);
> >  		priv_ep->trb_pool =3D NULL;
> >  	}
> >  }
> > @@ -226,7 +211,7 @@ static void cdns3_free_trb_pool(struct
> cdns3_endpoint *priv_ep)
> >  int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
> >  {
> >  	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
> > -	int ring_size =3D cdns3_ring_size(priv_ep);
> > +	int ring_size =3D TRB_RING_SIZE;
>=20
> You will use the same size for TRB ring region for control/bulk/isoc
> endpoint.
>=20
As single DMA pool is used to allocate the ring buffer, different TRB ring
size is not possible for different EP. Hence, TRB_RING_SIZE(600 * 12 B) whi=
ch fits
for all type of EPs is used.

> >  	int num_trbs =3D ring_size / TRB_SIZE;
> >  	struct cdns3_trb *link_trb;
> >
> > @@ -234,10 +219,10 @@ int cdns3_allocate_trb_pool(struct
> cdns3_endpoint *priv_ep)
> >  		cdns3_free_trb_pool(priv_ep);
> >
> >  	if (!priv_ep->trb_pool) {
> > -		priv_ep->trb_pool =3D dma_alloc_coherent(priv_dev->sysdev,
> > -						       ring_size,
> > -						       &priv_ep->trb_pool_dma,
> > -						       GFP_DMA32 |
> GFP_ATOMIC);
> > +		priv_ep->trb_pool =3D dma_pool_alloc(priv_dev-
> >eps_dma_pool,
> > +						GFP_DMA32 | GFP_ATOMIC,
> > +						&priv_ep->trb_pool_dma);
>=20
> dma_pool_alloc also allocates the whole thunk of TRB region. See the
> kernel-doc for dma_pool_create.
>=20
>  * Given one of these pools, dma_pool_alloc()
>  * may be used to allocate memory.  Such memory will all have "consistent=
"

Yes,  dma_pool_alloc allocates the whole chunk of TRB region for enabled EP=
s from the=20
pool. Currently the block size of the DMA pool is 7.2KB. So dma_pool_alloc =
allocates at least
7.2KB for TRB region per enabled EP.

> > +
> >  		if (!priv_ep->trb_pool)
> >  			return -ENOMEM;
> >
> > @@ -833,10 +818,26 @@ void cdns3_gadget_giveback(struct
> cdns3_endpoint *priv_ep,
> >  	usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
> >  					priv_ep->dir);
> >
> > -	if ((priv_req->flags & REQUEST_UNALIGNED) &&
> > -	    priv_ep->dir =3D=3D USB_DIR_OUT && !request->status)
> > -		memcpy(request->buf, priv_req->aligned_buf->buf,
> > -		       request->length);
> > +	if ((priv_req->flags & REQUEST_UNALIGNED) && priv_req-
> >aligned_buf) {
> > +		struct cdns3_aligned_buf *buf;
> > +
> > +		buf =3D priv_req->aligned_buf;
> > +		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
> > +			buf->dir);
> > +		priv_req->flags &=3D ~REQUEST_UNALIGNED;
> > +
> > +		if (priv_ep->dir =3D=3D USB_DIR_OUT && !request->status) {
> > +			memcpy(request->buf, priv_req->aligned_buf->buf,
> > +			       request->length);
> > +		}
> > +
> > +		trace_cdns3_free_aligned_request(priv_req);
> > +		priv_req->aligned_buf->in_use =3D 0;
> > +		queue_work(system_freezable_wq,
> > +			   &priv_dev->aligned_buf_wq);
> > +		priv_req->aligned_buf =3D NULL;
> > +
> > +	}
> >
> >  	priv_req->flags &=3D ~(REQUEST_PENDING | REQUEST_UNALIGNED);
> >  	/* All TRBs have finished, clear the counter */
> > @@ -898,8 +899,7 @@ static void cdns3_free_aligned_request_buf(struct
> work_struct *work)
> >  			 * interrupts.
> >  			 */
> >  			spin_unlock_irqrestore(&priv_dev->lock, flags);
> > -			dma_free_coherent(priv_dev->sysdev, buf->size,
> > -					  buf->buf, buf->dma);
> > +			kfree(buf->buf);
> >  			kfree(buf);
> >  			spin_lock_irqsave(&priv_dev->lock, flags);
> >  		}
> > @@ -925,27 +925,16 @@ static int
> cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
> >  		if (!buf)
> >  			return -ENOMEM;
> >
> > -		buf->size =3D priv_req->request.length;
> > +		buf->size =3D usb_endpoint_dir_out(priv_ep->endpoint.desc) ?
> > +				usb_ep_align(&(priv_ep->endpoint), priv_req-
> >request.length)
> > +				: priv_req->request.length;
> >
> > -		buf->buf =3D dma_alloc_coherent(priv_dev->sysdev,
> > -					      buf->size,
> > -					      &buf->dma,
> > -					      GFP_ATOMIC);
> > +		buf->buf =3D kmalloc(buf->size, GFP_ATOMIC);
> >  		if (!buf->buf) {
> >  			kfree(buf);
> >  			return -ENOMEM;
> >  		}
> >
> > -		if (priv_req->aligned_buf) {
> > -			trace_cdns3_free_aligned_request(priv_req);
> > -			priv_req->aligned_buf->in_use =3D 0;
> > -			queue_work(system_freezable_wq,
> > -				   &priv_dev->aligned_buf_wq);
> > -		}
> > -
> > -		buf->in_use =3D 1;
> > -		priv_req->aligned_buf =3D buf;
> > -
> >  		list_add_tail(&buf->list,
> >  			      &priv_dev->aligned_buf_list);
> >  	}
> > @@ -955,6 +944,27 @@ static int
> cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
> >  		       priv_req->request.length);
> >  	}
> >
> > +	if (priv_req->aligned_buf) {
> > +		trace_cdns3_free_aligned_request(priv_req);
> > +		priv_req->aligned_buf->in_use =3D 0;
> > +		queue_work(system_freezable_wq,
> > +			   &priv_dev->aligned_buf_wq);
> > +	}
> > +
> > +	buf->dir =3D  priv_ep->dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
> > +	buf->in_use =3D 1;
> > +	priv_req->aligned_buf =3D buf;
> > +
> > +	buf->dma =3D dma_map_single(priv_dev->sysdev, buf->buf, buf->size,
> > +				buf->dir);
> > +
> > +	if (dma_mapping_error(priv_dev->sysdev, buf->dma)) {
> > +		dev_err(priv_dev->dev, "Failed to map buffer\n");
> > +		kfree(buf->buf);
> > +		kfree(buf);
> > +		return -EFAULT;
> > +	}
> > +
> >  	priv_req->flags |=3D REQUEST_UNALIGNED;
> >  	trace_cdns3_prepare_aligned_request(priv_req);
> >
> > @@ -3103,16 +3113,17 @@ static void cdns3_gadget_exit(struct cdns
> *cdns)
> >  		struct cdns3_aligned_buf *buf;
> >
> >  		buf =3D cdns3_next_align_buf(&priv_dev->aligned_buf_list);
> > -		dma_free_coherent(priv_dev->sysdev, buf->size,
> > -				  buf->buf,
> > -				  buf->dma);
> > +		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
> > +			buf->dir);
> >
> >  		list_del(&buf->list);
> > +		kfree(buf->buf);
> >  		kfree(buf);
> >  	}
> >
> >  	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
> >  			  priv_dev->setup_dma);
> > +	dma_pool_destroy(priv_dev->eps_dma_pool);
> >
> >  	kfree(priv_dev->zlp_buf);
> >  	usb_put_gadget(&priv_dev->gadget);
> > @@ -3185,6 +3196,14 @@ static int cdns3_gadget_start(struct cdns *cdns)
> >  	/* initialize endpoint container */
> >  	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
> >  	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
> > +	priv_dev->eps_dma_pool =3D dma_pool_create("cdns3_eps_dma_pool",
> > +						priv_dev->sysdev,
> > +						TRB_RING_SIZE, 8, 0);
> > +	if (!priv_dev->eps_dma_pool) {
> > +		dev_err(priv_dev->dev, "Failed to create TRB dma pool\n");
> > +		ret =3D -ENOMEM;
> > +		goto err1;
> > +	}
> >
> >  	ret =3D cdns3_init_eps(priv_dev);
> >  	if (ret) {
> > @@ -3235,6 +3254,8 @@ static int cdns3_gadget_start(struct cdns *cdns)
> >  err2:
> >  	cdns3_free_all_eps(priv_dev);
> >  err1:
> > +	dma_pool_destroy(priv_dev->eps_dma_pool);
> > +
> >  	usb_put_gadget(&priv_dev->gadget);
> >  	cdns->gadget_dev =3D NULL;
> >  	return ret;
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3=
-
> gadget.h
> > index 21fa461..c5660f2 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.h
> > +++ b/drivers/usb/cdns3/cdns3-gadget.h
> > @@ -12,6 +12,7 @@
> >  #ifndef __LINUX_CDNS3_GADGET
> >  #define __LINUX_CDNS3_GADGET
> >  #include <linux/usb/gadget.h>
> > +#include <linux/dma-direction.h>
> >
> >  /*
> >   * USBSS-DEV register interface.
> > @@ -1205,6 +1206,7 @@ struct cdns3_aligned_buf {
> >  	void			*buf;
> >  	dma_addr_t		dma;
> >  	u32			size;
> > +	enum dma_data_direction dir;
> >  	unsigned		in_use:1;
> >  	struct list_head	list;
> >  };
> > @@ -1298,6 +1300,7 @@ struct cdns3_device {
> >
> >  	struct cdns3_usb_regs		__iomem *regs;
> >
> > +	struct dma_pool			*eps_dma_pool;
> >  	struct usb_ctrlrequest		*setup_buf;
> >  	dma_addr_t			setup_dma;
> >  	void				*zlp_buf;
> > --
> > 1.7.1
> >
>=20
> I guess this issue may due to the size for DMA region is too small,
> try to enlarge the it (eg, CMA size).
>=20
> --
>=20
> Thanks,
> Peter Chen

--
Thanks,
Sanket Parmar
