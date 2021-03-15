Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A309B33C087
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhCOPvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:51:32 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:50958 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231862AbhCOPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:51:11 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FFd3o6001592;
        Mon, 15 Mar 2021 08:51:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=dXHW5/PDv2HrRZ+o7v0VFJL++eRvvpAqPPgiaxJ2tI0=;
 b=HgA9pZ0AM3cMGDWpseSjTrHP6zIjUzfLhIcdU8qTpYlAVhZNvvJ6eMsSmA6a3D7EYHIs
 nqNxpScFSij0bzGFrg/wqVu7yhu7AKHkdeSnctwSMqAPgsTw9Z94DV6PGc5zLs3XSphz
 A1YBTmeZKJAxTivsckwcgdpZ0bqt1HfQiFVTh831DFqT2Xk/Cqd+uJngR5hIZjNxf+DL
 uFARE5i3bloq0nwKQutj9xuylScFc7txDpRt3iLZTOwGyLkpvtiZ6qzazh2wqdoCVhbd
 2uJcrGnNAC6gktONY9VAtR+6Im9cwGg+/8Alm+T+ZvWoGcGRI+BuV1eKEJgBsmoST4v9 RA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2eeha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 08:51:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISJ6tOT/ifXjEVkqGsXGdmUymdveAmwJgvnXhdEVTkQ0lSwZnJbS6KooG/QIZiKvNujnE2lrMXKqIZkqaKDg8aXlN8EDBjhOLnuAlFlZCpI5zW6W/Bv2GPSIz7rVdXre16cTSzB97CoiqRk9fFUnrPMhO4MTjzQ/zNI6ujyjDnt80PyGIfo1Kh6wNGHTW5eQxB//PbIfTMQXh7u1exKhJD9OEDaAbtqf/q82FBprWTJ6TYF/ItgUImv207ztIJTupjufA7/Jj1OV+JHULtMbG+LtRye3U4CIjrdOSg6YfOoDcmKoGRQztS4S6ZyFn5V2gPIauVoE+4L3jajmtjFrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXHW5/PDv2HrRZ+o7v0VFJL++eRvvpAqPPgiaxJ2tI0=;
 b=BWSjQo8Tp/D93lgDkgGezE5cySU0daPbvi0nDsO1s5+HE7AnD6SYxyVv6Q9wHWy80POdRmThEY30fKzXBnLOpsxGzSE/2Yf0lRS/o/9uEhH/tY3W9q4lVx40cp9V2JjWkGXI9qV+jaZhbpEBY6/x+Iz23jm0/0gEtgyaSD49TvBZbHI1/Qel3XIzwSh1Zm6P8xUoDnFL9PQhT8C/MjJDfKQ6Y9jRtTtozQvAtYRFA1FIde2jovVlJvfLjGvFuBXQxTplKj11OW5MBYVWsSQ1SooC0zC9xAn48j39YZc1ySK5TFH7vYovjjY6cwac38IDHaZWVjBL5fr5+lJhA4HbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXHW5/PDv2HrRZ+o7v0VFJL++eRvvpAqPPgiaxJ2tI0=;
 b=J924JMcC5HbdrfAbDJpZ2lqKrmZbtJUcUkmnJh2OrLfut/M49ac0y6kXQXkhwVUzvAMUEGY85Gec6cSDPzVyL2n/KQvZ584eOKgMlaoR4upD52/smsOKgxQyyZePzvwANUqWarViam61cD9k1VZrWryZQuoQt4WNOEn9M7489Bw=
Received: from BY5PR07MB8119.namprd07.prod.outlook.com (2603:10b6:a03:1d4::15)
 by SJ0PR07MB8568.namprd07.prod.outlook.com (2603:10b6:a03:371::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 15:51:04 +0000
Received: from BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759]) by BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759%8]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 15:51:04 +0000
From:   Sanket Parmar <sparmar@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Thread-Topic: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Thread-Index: AQHXFKPlwE5egmmpm02b66W+ylYqvKqC94IAgAJBL9A=
Date:   Mon, 15 Mar 2021 15:51:04 +0000
Message-ID: <BY5PR07MB81194FB5A32CE9D6B793FF30B06C9@BY5PR07MB8119.namprd07.prod.outlook.com>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
 <1615267180-9289-2-git-send-email-sparmar@cadence.com>
 <20210314051048.GA30122@b29397-desktop>
In-Reply-To: <20210314051048.GA30122@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3Bhcm1hclxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTNlMjJmMzlhLTg1YTYtMTFlYi04NTc0LWQ4ZjJjYThhNTI5ZlxhbWUtdGVzdFwzZTIyZjM5Yi04NWE2LTExZWItODU3NC1kOGYyY2E4YTUyOWZib2R5LnR4dCIgc3o9IjY0OTIiIHQ9IjEzMjYwMjk3MDYyODgyNjc4MSIgaD0iMFYvaGZWUWhYY0NWTFM1c2dISmVHYSswVytnPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [14.142.6.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32548bfa-e3bf-44c2-b364-08d8e7ca23e2
x-ms-traffictypediagnostic: SJ0PR07MB8568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR07MB8568D5B931421EEA19FA8530B06C9@SJ0PR07MB8568.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqiRGRMUpzrW53Sm2/5V0g88qR8Iuokt6XW+P7zG2yHFMgaLplB6q0+i69FEJukvreQKTRE45WLTO7yEtP6jeTsd1vUwiyBosJ5y1rOdNZJWuoEakUFQJeK8Qzc8bVzYxmfbGpJ5z3M4XpvKrLehY+Ji3Vv1BP9XH48D9xtlLPUguKiJZBemB19VwGoF6G6puV8WKG+vLnR+64/iv06zGVVtqXj6am0HHrc6gWxiupml9GuB+Cf/ozMEPmTWIqRH/PTj7YyXA/G3vpiC88uCbldF/qR9zi27CX+m/nGITxbkSAreqzMf/U2l/Zj0fFE4oYdzRxKTKdqiS4gSpxv9filHpYt+KxWlLVOsJQzKNwJ4Bj/dP0kGCdmFXmg3YcUgWHVorRneNEoKUfR1T0vIsH6739LUVhaUusY/ptyzfzb+ku478wqqz75gj3Z8o7SmvQ5OvrdL3DX5tYYsg+baffw7GNKhBYFd74OVRK/IXj9waeXSdBF3xNTp+82ti2kWd9TZXkO13Eto4Nr4pykf+ZtRnojY4fjmTY7GagF3LY+hfuFCyMuiQ2sj9LcpAMVX64nZ4UASVw7+tPOxPgkDmAX9o2OJ4bkwxSy5n+t1Zu0aanPQwo+RPx0NF257YkF5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR07MB8119.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(36092001)(66476007)(66556008)(64756008)(66446008)(4326008)(9686003)(76116006)(83380400001)(6916009)(71200400001)(8676002)(6506007)(8936002)(316002)(54906003)(5660300002)(2906002)(86362001)(7696005)(52536014)(478600001)(26005)(53546011)(55236004)(33656002)(66946007)(55016002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f6t9slUQxf8rxgaBuN1yQwElCtxIg0BSR8UlXBEKkG+bwAMuRnEgPkLwixRs?=
 =?us-ascii?Q?3aPJt/1nMF1SFuNtDmmD31RBfYWi8zI1wnPl2g8R7gy6pXWO94Q3ggzkF+yR?=
 =?us-ascii?Q?gqkofXvWnePoQF8ZVT4OTdCQsJ7MGuYKRftPNxH7i4qf8PgKzbusZa/bYkzK?=
 =?us-ascii?Q?QVolQ52uUwX46x/W7LzYLre/S+5S+rQntHYm3Sg5twrvc9hBmKYSWaonC4tT?=
 =?us-ascii?Q?zJ4IUTu3UtEErF617vH8L7sKjiyKjVRJ0nSQBUJSmwOwZwaKiZosjleQr0u9?=
 =?us-ascii?Q?XXb9FMC6XMguUgzuh4Xgbfywqkzh0z9zf4Rysg4nDXC1FJb6jx3OVrx8SrH7?=
 =?us-ascii?Q?5thlm3g3O/kzhiErIG1aV2HbZPlKd6cEeHqeuP8if4VsR00Fghw5d2iA0uA3?=
 =?us-ascii?Q?mp04XhASWsz4VLKWbJ9ksQVszX8ics1WTV2Oz3VBixetj43GBQJG1BObLF28?=
 =?us-ascii?Q?2X8G1Xra4bE49fPkZlSllAxFtLXZFQHWtaDeHVQKaVfVfwWXDZe91K4t/r3Q?=
 =?us-ascii?Q?xt3yPKvoAh4gWXxAdmZLmWfrBXEMKnQJXaQZckAVTw0V+DYB67KIySPWxmdy?=
 =?us-ascii?Q?xE0Usdx9srKXL6yqNipMX5hLyE8mECM4Tzj57mv5IvpSz6p7zYq1TOUHUQf3?=
 =?us-ascii?Q?YiwDftTMchqLWzd7K1WJtyHvBO5sIoVaI1Rbpg4+T9G80/aDYWmIWjWSNIhc?=
 =?us-ascii?Q?WMuYOd8+tlMMKRfFU9hu5+021JpDo1v86YQod67hi6t1MQBjWHK/Uxu9utrm?=
 =?us-ascii?Q?3P6HCrNAmJyk/71AgB8lOro9dSscteKkOBfY4z3tCBnAvFUqQvL5FxEWKR3l?=
 =?us-ascii?Q?riUNUqJYNn7HpYcDe60CKDmBzj2Tuu34j8Wf7vpAreopG+jMsaouOyn46vrZ?=
 =?us-ascii?Q?I4RebPZnD50bh58/tEhmRrmC54TyWYEo0m7YzcHO93BMe1daDcC9DQzw7tTI?=
 =?us-ascii?Q?KIvK4Jty6k6S8/vVen3i1JXfoo0gJt+Y59VTs3GeXb0Pf4lFywFetBeqrCDD?=
 =?us-ascii?Q?S9ZqNDNEBHd7K2iSrkCHN7A4/XL+rdNjYrcXcXyRb/cFq0Yz9ZPmC2gOQCyU?=
 =?us-ascii?Q?0DyfjCCeftODY/bK3XsIz+BmVl6+QSISCLW5uevlUPaccWb+Cj67u8+wA6UF?=
 =?us-ascii?Q?HqIJOfNbE8opc3Sawe8f1tdzkheGUwsn9fUdbT5xWILUpb5G+ZvMD4c646wr?=
 =?us-ascii?Q?dPBG5eTYHpYkMtD+fWqBfNY7UEwrVI8cqDMWnXBwAPynQI+Um3C9WOYE6NtR?=
 =?us-ascii?Q?m4uMP530i8mDgWZHOVTBUsD1AoMTcct0A6HNqzbii44sffXJfrTLvtKLD18u?=
 =?us-ascii?Q?gzw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR07MB8119.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32548bfa-e3bf-44c2-b364-08d8e7ca23e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 15:51:04.3439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ld2ZufdJsT5aAypJWfc86RpGBMsSVEPPIiemYDuS/IRKsakqJiUMLfXb/3cfgdVl7SlJsMI9Wd0R4ePyFTaMlGqCPIs4YK4jvyz9Q2Vp+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8568
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_08:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=729 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On 21-03-09 06:19:40, Sanket Parmar wrote:
> > dma_alloc_coherent() might fail on the platform with a small DMA region=
.
> >
> > To avoid such failure in cdns3_prepare_aligned_request_buf(),
> > dma_alloc_coherent() is replaced with kmalloc and dma_map API to
> > allocate aligned request buffer of dynamic length.
> >
> > Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>=20
> The comment with the 1st patch, it is not a bug-fix.

I will remove this.=20

>=20
> > Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> > Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> > ---
> >  drivers/usb/cdns3/cdns3-gadget.c |   73 +++++++++++++++++++++++++--
> ----------
> >  drivers/usb/cdns3/cdns3-gadget.h |    2 +
> >  2 files changed, 51 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3=
-
> gadget.c
> > index 5f51215..b4955ce 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.c
> > +++ b/drivers/usb/cdns3/cdns3-gadget.c
> > @@ -818,10 +818,26 @@ void cdns3_gadget_giveback(struct
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
> > @@ -883,8 +899,7 @@ static void cdns3_free_aligned_request_buf(struct
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
> > @@ -910,27 +925,16 @@ static int
> cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
> >  		if (!buf)
> >  			return -ENOMEM;
> >
> > -		buf->size =3D priv_req->request.length;
> > +		buf->size =3D usb_endpoint_dir_out(priv_ep->endpoint.desc)
> ?
> > +				usb_ep_align(&(priv_ep->endpoint),
> priv_req->request.length)
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
> > @@ -940,6 +944,27 @@ static int
> cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
> >  		       priv_req->request.length);
> >  	}
> >
> > +	if (priv_req->aligned_buf) {
> > +		trace_cdns3_free_aligned_request(priv_req);
> > +		priv_req->aligned_buf->in_use =3D 0;
> > +		queue_work(system_freezable_wq,
> > +			   &priv_dev->aligned_buf_wq);
>=20
> @Pawel, do you remember when this condition is met?
>=20
> > +	}
> > +
> > +	buf->dir =3D  priv_ep->dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
> > +	buf->in_use =3D 1;
> > +	priv_req->aligned_buf =3D buf;
> > +
> > +	buf->dma =3D dma_map_single(priv_dev->sysdev, buf->buf, buf-
> >size,
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
> > @@ -3088,11 +3113,11 @@ static void cdns3_gadget_exit(struct cdns
> *cdns)
> >  		struct cdns3_aligned_buf *buf;
> >
> >  		buf =3D cdns3_next_align_buf(&priv_dev->aligned_buf_list);
> > -		dma_free_coherent(priv_dev->sysdev, buf->size,
> > -				  buf->buf,
> > -				  buf->dma);
> > +		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
> > +			buf->dir);
>=20
> It only needs to DMA unmap after DMA has completed, this buf will not be
> used, otherwise, the kfree below will cause issue.

This part is not clear.  Aligned DMA buffer is allocated and mapped in cdns=
3_prepare_aligned_request_buf()
and put into aligned_buf_list. While unloading the gadget, We need to undo =
the same if aligned_buf_list is not
empty.  Am I missing something here?=20

Also, I will post v2 of this patch which uses dma_*_noncoherent APIs sugges=
ted by Christoph Hellwig.
=20
>=20
> >
> >  		list_del(&buf->list);
> > +		kfree(buf->buf);
> >  		kfree(buf);
> >  	}
> >
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3=
-
> gadget.h
> > index ecf9b91..c5660f2 100644
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
> > --
> > 1.7.1
> >
>=20
> --
>=20
> Thanks,
> Peter Chen


Thanks,
Sanket
