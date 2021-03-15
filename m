Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B11433AB77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCOGL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:11:56 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30114 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhCOGLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:11:30 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F68VGc023461;
        Sun, 14 Mar 2021 23:11:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=yZ4adnyAJd0hqEFyWIzJytf0LmnCTht/nX88ASEDZQE=;
 b=ccertb5wVH7cXVjMzBAw9dK+9mx68pKPmVKrzctXBuatzvTFjXDtdINsvr4Y1UkYn0SQ
 fwhHtq67BGyzJY7mwqs6JmFYxt0BDjG4BkX+2HHGJNrd8Gc0AcIMdA2WZsKZgvLh4meF
 9PZJx+VUqQeTXZNVqCGbX5t4DcpQSLE7eSRVRbid+Stta49D8+6gw1lCBgfJQlf0iHc2
 Crxog7veRJMEcqudXLESQsNHJvWnUzBjtuqKjNV1FiIutAwks2IvNTecWxJEl/8iC4eB
 mvzSDbJt+DLkoxoLML7UXoLH73sahYAwGOvSGIlMCFF6fDB9N86oI7m0tVVkGtjF2Zw+ yw== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2050.outbound.protection.outlook.com [104.47.38.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 378tu1vfj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 23:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9zR8m48u5p0iy2pd+npAJbxpzeruMXYD1hC/fYCc0/wJUN9YPXjQOFbXNPI7+92IL/U+Aajd9CZWjoUGJvOJehDcMaS+VRMugqSjMFV+WaLi+v5ssMEaB7slrXCLxdnUxrv5BkQkggAfcR6jfjth17BA6SBKTdokySwazH6d6bEgNYjC08DYEgBYZFLjj9VKCuRrQpomVmGXmTLx/J8ca+rYeogs7kvS4yEJS6xyOlYYnEznpv8P0I8FvTNgEdwS5PA3twU2deqMW3bv8rG6LG791cgXSOOmvJll5VcsBssf9NCCIt5jslxhQejgemLnG7MYr7htriPYJHslHytyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ4adnyAJd0hqEFyWIzJytf0LmnCTht/nX88ASEDZQE=;
 b=VVUGBIAqwxx33ulPwByxCZEJAr4s2oXHobetqPC6/vuNTAaKDNgIcvn7I98oTl7/6pQ8oB5MpYd7hIQnztOmW5aqMY8sUSfD1vC4YfOUGCHbgdMKZRMf+3gq8J/2BdfVuWKXMmqn7aCi5UgmvRLY0Z3gpVcdhnL3+sSvK42HCb1CgyL/FBJPZpsq9Hb+BR3f6UsOtoYp2HqkFe5gwQhaRUyb1Xavdjqu8NdSSCL9a1M71zPDx7NnRFSvdG0k/7alkhaBjOtSM141lBMnmDsAz9KmGvTnHdmChRRurv+CKFyYzmfYvNUZD8tGsAGoUslKPNQSN3AfLZma/ZyvHOvsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ4adnyAJd0hqEFyWIzJytf0LmnCTht/nX88ASEDZQE=;
 b=Rjt0vcGh/ItWQ82YS7nxWW/VMHs0TZAjzLqDJ9yV693Rew0SFrCxlS4OwEwyMltx3NZebWoCRAcbxTsm/pV8y5UVuwVze8lnr2FDYEjAeUhZ1gVx/xnbOyVqV5SKHel5onz+lCHU2qsYhQw9H26qbh1hCqPKsphSpR5UrFqN3us=
Received: from BY5PR07MB8119.namprd07.prod.outlook.com (2603:10b6:a03:1d4::15)
 by BY5PR07MB8103.namprd07.prod.outlook.com (2603:10b6:a03:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 06:11:23 +0000
Received: from BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759]) by BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759%8]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 06:11:23 +0000
From:   Sanket Parmar <sparmar@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH 1/2] usb: cdns3: Use dma_pool_* api to alloc trb pool
Thread-Topic: [PATCH 1/2] usb: cdns3: Use dma_pool_* api to alloc trb pool
Thread-Index: AQHXFKPdvzUNZxNPcEW/PcjrzJru26qC0CCAgAHHqUA=
Date:   Mon, 15 Mar 2021 06:11:23 +0000
Message-ID: <BY5PR07MB81199768C118889EF73BA563B06C9@BY5PR07MB8119.namprd07.prod.outlook.com>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
 <20210314024951.GD17526@b29397-desktop>
In-Reply-To: <20210314024951.GD17526@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3Bhcm1hclxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTQyMTlhYjBiLTg1NTUtMTFlYi04NTc0LWQ4ZjJjYThhNTI5ZlxhbWUtdGVzdFw0MjE5YWIwYy04NTU1LTExZWItODU3NC1kOGYyY2E4YTUyOWZib2R5LnR4dCIgc3o9IjUyMzIiIHQ9IjEzMjYwMjYyMjgwNDMzMDM0MSIgaD0ic09sekRGVktqZlZSMEtaV3ZLVG9nN1NCZWlZPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [14.142.6.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bc5e766-09f9-4278-6b6c-08d8e7792901
x-ms-traffictypediagnostic: BY5PR07MB8103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR07MB8103C2C372EA0660849FEB7BB06C9@BY5PR07MB8103.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPGXDdFuHoGvM3W5nErmZSmKJoDgHMNyb+GmPcJJt8WeSOuyQno7UYyBUyvYBNpGdJ34EmHQTLz1KDc9szrOsclMD05WxQ+92NeID8Bfd4xgOV6x7nzGAvWzzkL2dR+10wKdYDoX5LXiOdDg4ap3Vf+FfmXeDqfU6HSyyzZX9DspTuqSwXsRlU5iKWkMUFP7RsalTkXhDgcX7e1oxZpPYR9+XQtvWGUWNSaVybwrGqIASp6Bm+LZ8lmtgruevqIiT7uGmONt0Wd0VYX+kKAydATLFVOZ8ILyeaBAENv2EzvtTxtQeMQDcV6Vor0B4uBvemXVsAdXzNPzpo24pWQTN+n0bwAjGcV5ApYOvZm9K228lGeMFPSR+XHVTSmo7ETpohOdK6lHxLV2Y0BN93oN/DKNAC2o5zxfu8ZZ8m7gCQUbl5s61iC/KMQU8mCYwWfSmryUmx8lzeXMc/3uNxSOxirl2hOCO24B8tRSvD+WcPm4ezk5QyGvxIwHP/V1lj05DNjE4oEEU0mOj+3+P01YUReZjTiVFTkY5EEpk4W2OIg1h5X7hZ51mLjOqkUIHe4+fOYHVFn1vieOo/wp3YV3zVy4B8nxnRGpc0FhkAsz6o+K8cTQNEcVl0+KQzTX7vVS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR07MB8119.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(36092001)(66556008)(66476007)(6916009)(66946007)(478600001)(64756008)(71200400001)(76116006)(186003)(2906002)(86362001)(5660300002)(4326008)(316002)(54906003)(55236004)(52536014)(7696005)(83380400001)(33656002)(53546011)(26005)(8936002)(66446008)(9686003)(55016002)(6506007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DmtFmb/2nyBaDIVkkI/YrlT+Dmy5WVbx8SGOHYD00qq5BqKEyKr5azCdhsPP?=
 =?us-ascii?Q?SffQrtCRnbmhykeVpq7poCwq2T8LYSWiHAousvKJx3DRt4UmAQ9WF4ZREC27?=
 =?us-ascii?Q?UiSdYYWh/3g2FZAznpqHxIL0ueJFVkDrNyYrSYSVAgPZKYcjxIU0ZXB6PncB?=
 =?us-ascii?Q?LFxbWNwnCMw+GZ5MYTQnuMhByNWxtVV8NQ1KDdQ04VGwAO6VeJ+/sQnI6PE+?=
 =?us-ascii?Q?+yZXT9Ucfivi4REYr4LqpFjd1MIJVaxYJVNiV0hyExUPdtT9jUCPqXYUmxyE?=
 =?us-ascii?Q?YE6YTsEp0kmfmF+PS6hatTTDZ1AVbySXL9StR5E/OL4Fy+4qFrIZQK6Fsucd?=
 =?us-ascii?Q?VXrP9Z+xkGsV7ercNjBYa7jzFbGY1w78uKVEoMQ/JB7YgUjESNjUduWtFOD/?=
 =?us-ascii?Q?tQBkC7WVEzd6XgwB2HMtujGv/Uz75znph8FfF1USRMw9akuqCOknvMmWlpSz?=
 =?us-ascii?Q?LBON6O7JpbW4xPC9qh6v7jfP6P83UIaN6taUDRIb7HNK44vC4UTiC55Q/QLS?=
 =?us-ascii?Q?mqNZwMmfotLlME0vyiiIGdk6NI1WyMq8IriICIOKEHvv3dbN5Hs1TQsirFB0?=
 =?us-ascii?Q?fQFfRUbanrqlSL9dZ9E74tT7z5SLEn8XBcH1b7H6NctSOUZ3t7wo19K0b0P6?=
 =?us-ascii?Q?W7DvX/AJ1RIHJiIgzGRXHmZWbopbZCEQ3IteMq1MfjAY3q5vU4XS6QjXZFz6?=
 =?us-ascii?Q?iyDY1Po7dOXeavBfVnG6iMDZAMqQKzI76hUN9uiBWAI5OrpCbBsNxMADIhds?=
 =?us-ascii?Q?FEyVLt9gwUeTJdUiYOgf1P987kcmuqw5kUQNCY+dQ6qY9cj0rn7Oz/7OdMu9?=
 =?us-ascii?Q?Z5ATC5UsKeQC91r/zFY1/HN4VqNlt4/IOw/xPZTs5CLXh30ppRwifJR8TZJ5?=
 =?us-ascii?Q?ApxJA57eAWwjASs8NWg9YWZStuSOPGjmV++nTZ7zwJIn7bFoEyVL6vgwnmXu?=
 =?us-ascii?Q?qaltLDScckHvJbCXpVxlyGh543a+cqC8stmthSzfVOR34KkZyCdliyevud9w?=
 =?us-ascii?Q?Jz9R+QMcfVYQeeHukBGkPkc9VTob1yZJlJHHCpOJ9xJ/+BLT8cdpgEasLAG5?=
 =?us-ascii?Q?tqg6jfPTXR3brwuhuBX0hK7uGcj4B3Qi1usp0m/DKJiwc1CviNbF/O48W4wJ?=
 =?us-ascii?Q?ixjJnt3l0bUJaT4U2rzn+jXCKaGCboKD3d3hTfn/2d40nhDkt4w1YipP4Luj?=
 =?us-ascii?Q?rA3gjcBbjEf3hp9gncDGUFqgFucHnAr+/D1LuHwRCJHCcqskpk/uqhoTBcaL?=
 =?us-ascii?Q?3kPKMsQYXSVPPL+dRV+OAQeyjKPsKnK6VZTW7UEwiah4dDTzn4o0ZJFtFmDn?=
 =?us-ascii?Q?Euw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR07MB8119.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc5e766-09f9-4278-6b6c-08d8e7792901
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 06:11:23.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5w+nU/GmYum9zGQ6PsLfgNNRMfPZxjf2sMvSsTkws1KNrfzPHigspapipqMv+Pf4RYSVPvB0qij4zLWlXT6Q2i/Qw5HPXWJnG1fCNV2gkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB8103
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
>=20
> On 21-03-09 06:19:39, Sanket Parmar wrote:
> > Allocation of DMA coherent memory in atomic context using
> > dma_alloc_coherent() might fail on platforms with smaller
> > DMA region.
> >
> > To fix it, dma_alloc_coherent() is replaced with dma_pool
> > API to allocate a smaller chunk of DMA coherent memory for
> > TRB rings.
> >
> > Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>=20
> The patch is ok, but I don't think it is a bug-fix, it is an
> improvement for smaller DMA region use case.
>=20
> I will apply it with deletion of above Fixes tag if you have no
> more opinion.
>=20

Please go ahead.

Thanks,
Sanket

> Peter
> > Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> > Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> > ---
> >  drivers/usb/cdns3/cdns3-gadget.c |   42 +++++++++++++++++-------------=
--
> -----
> >  drivers/usb/cdns3/cdns3-gadget.h |    1 +
> >  2 files changed, 20 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3=
-
> gadget.c
> > index 582bfec..5f51215 100644
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
> > -				  priv_ep->trb_pool, priv_ep-
> >trb_pool_dma);
> > +		dma_pool_free(priv_dev->eps_dma_pool,
> > +			      priv_ep->trb_pool, priv_ep->trb_pool_dma);
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
> > -						       &priv_ep-
> >trb_pool_dma,
> > -						       GFP_DMA32 |
> GFP_ATOMIC);
> > +		priv_ep->trb_pool =3D dma_pool_alloc(priv_dev-
> >eps_dma_pool,
> > +						   GFP_DMA32 |
> GFP_ATOMIC,
> > +						   &priv_ep->trb_pool_dma);
> > +
> >  		if (!priv_ep->trb_pool)
> >  			return -ENOMEM;
> >
> > @@ -3113,6 +3098,7 @@ static void cdns3_gadget_exit(struct cdns *cdns)
> >
> >  	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
> >  			  priv_dev->setup_dma);
> > +	dma_pool_destroy(priv_dev->eps_dma_pool);
> >
> >  	kfree(priv_dev->zlp_buf);
> >  	usb_put_gadget(&priv_dev->gadget);
> > @@ -3185,6 +3171,14 @@ static int cdns3_gadget_start(struct cdns *cdns)
> >  	/* initialize endpoint container */
> >  	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
> >  	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
> > +	priv_dev->eps_dma_pool =3D
> dma_pool_create("cdns3_eps_dma_pool",
> > +						 priv_dev->sysdev,
> > +						 TRB_RING_SIZE, 8, 0);
> > +	if (!priv_dev->eps_dma_pool) {
> > +		dev_err(priv_dev->dev, "Failed to create TRB dma pool\n");
> > +		ret =3D -ENOMEM;
> > +		goto err1;
> > +	}
> >
> >  	ret =3D cdns3_init_eps(priv_dev);
> >  	if (ret) {
> > @@ -3235,6 +3229,8 @@ static int cdns3_gadget_start(struct cdns *cdns)
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
> > index 21fa461..ecf9b91 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.h
> > +++ b/drivers/usb/cdns3/cdns3-gadget.h
> > @@ -1298,6 +1298,7 @@ struct cdns3_device {
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
> --
>=20
> Thanks,
> Peter Chen

