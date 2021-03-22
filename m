Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E794343DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCVKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:32:06 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50992 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230332AbhCVKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:31:12 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MAR8sg019642;
        Mon, 22 Mar 2021 03:31:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=rWZHhJbM/0nb2iPrVU5SHRCHYvSMc/yxRtrDCG04kUg=;
 b=sFYfmkwGSMj5/0qVc0i9IwfwIO//nkVcHd/SqoKwKVUra2ku7/fsLLXGvBWMBMArSRhs
 S16UU2uFMwSGyB81llJ5UjFOcI8yGKC4uDI0XyfHA+FvTzJBAWMD0Tc+V4vDO30gzIn1
 1aad2W+jG8XOXPSwqu5g5B2yttUrnryfjCaNdTkfIe7r4gxrkOVNGHJLhSSLf3nxQYo4
 pTl9n4uyq1lM61sXuXGTfg5F8urT5PiWqIULxgTe7SeysrTSAOBx76Edo6Gh7wTLB4ss
 QqKbsFYwwoh/A0m+m4vj3wxdX7AqSzerVMyPXqwsEb62RyDUh8elsKl+TXMV+qF78bJM 8w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37ddkxcrpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 03:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+QBnjMn0Fndk5ibLKqHIjeOO8p++Tc5wptEn2fgUZpI8GT+K90RlRb/m3xQtDA93kef0x9uKYTA8Ns0NEJ1Y5QdkQrmpXGkmmTK0K1zW/CQLUR1gYEEKe5fDbPQCaZ086b6l57yOIL2YQ4p/8EmdwAZda+edmig/sZUwTxSMVfnnDIVdICA3DKwLUQL1ii/fzmv30OavgIm6O0vjqpR9z/kxER5I5Cc/F368CAqgdXkS3U3F5ai1Xas5G64QhyrtqBAcIqxNVDt6YeBY8AoULRZIProWf6a3HawQcAWG++Ci34Jp6ZmfFjzIxf/6PeZQ6meTWiBM7G3mFEXa6epvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWZHhJbM/0nb2iPrVU5SHRCHYvSMc/yxRtrDCG04kUg=;
 b=gkGmIztYVz9aufytlD7uaRCG0ZSgHZV95x0zXMymMoJbhNYrUX/X2i6yYGD8qgevr9e66a62lJ03MhEGUriAOPQgMWw+McysyfKj3Zl+5iGaSVzLtwQcxsyN4Ytma31/m4vicgWxj+XGRC6pi8NO6drT4ZRhoN2bK4gqn/VN5h3LyCjsIp/nqukxawJMaD4kCKqCuCfahjYRpUJTUf0jZJWRyRgRI0J9fe9xClFDdTjBLQPoldcB91od2so9hely68NxCuVpr6tI1L4i+ffiMZD0OFhE0TbLn20koZdciKsbQYaW0Ffe2Q8V0FYWO8AhcQnBOHwgWaVD/OeGKxeFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWZHhJbM/0nb2iPrVU5SHRCHYvSMc/yxRtrDCG04kUg=;
 b=WhYExKG3Sr7/HqHZaDyPznsWMf1OG1d4E7kSw3Ty8EI1IcK3XHFJhpAYDLybMsA6OMCeA8vX9cSP18mdccfknLwXmNw9n3oMWxK9AGdu0AUkwL2A7Cm9nO8FU4Qv8iCmmYskYizziGhWbkbtFyyKf+H+G36fQFOl4ro9ZFJh8ZM=
Received: from BY5PR07MB8119.namprd07.prod.outlook.com (2603:10b6:a03:1d4::15)
 by BYAPR07MB6327.namprd07.prod.outlook.com (2603:10b6:a03:11e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 10:30:54 +0000
Received: from BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::8417:d6db:ba0c:5e10]) by BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::8417:d6db:ba0c:5e10%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 10:30:54 +0000
From:   Sanket Parmar <sparmar@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH v2] usb: cdns3: Optimize DMA request buffer allocation
Thread-Topic: [PATCH v2] usb: cdns3: Optimize DMA request buffer allocation
Thread-Index: AQHXG2HVTwRhsyf3N0aVH9FwBZjdNqqMmo+AgAM6/uA=
Date:   Mon, 22 Mar 2021 10:30:53 +0000
Message-ID: <BY5PR07MB8119561FE06198D12F1771D0B0659@BY5PR07MB8119.namprd07.prod.outlook.com>
References: <1616008439-15494-1-git-send-email-sparmar@cadence.com>
 <20210320090858.GB28364@b29397-desktop>
In-Reply-To: <20210320090858.GB28364@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3Bhcm1hclxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWFiMDBhZGExLThhZjktMTFlYi04NTc2LWQ4ZjJjYThhNTI5ZlxhbWUtdGVzdFxhYjAwYWRhMy04YWY5LTExZWItODU3Ni1kOGYyY2E4YTUyOWZib2R5LnR4dCIgc3o9IjQ4MjIiIHQ9IjEzMjYwODgyNjQ5NjEwODMwMCIgaD0iejlFejFSYzlVc3NlbDhGVWNqRmpsWUd2M01BPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [14.142.6.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9bfae40-eb5b-4239-1242-08d8ed1d9293
x-ms-traffictypediagnostic: BYAPR07MB6327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB632788B94D2D6A0B2FDDF95EB0659@BYAPR07MB6327.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDP4wEvtA+iF5q9pHcGlUoHsam9Rjzs0eDiK6mc3r3j2KGNGMJm2oLmnkMktjD2OZ9JZYbKJFtDyj2/9o80w8lHShuog1ZUq+fmShI3+0SwdJiAoZAiuFXrYYAufstQaddVuw9fZztQjTW1f+m92t3ZEs72VuIPbtMD097wkEN65HjeD1Z4F/8ycVo4E88b7IUR1yKlugwiD2nnP6rBpSbsL3bF0tFlYU5twdm9Ts+xKeyJeljdyHQHGW0RoqgqDPWmuWfYVCtbJa50rm4JkiP4NQSwdrwEybrxP0uFjjJSciDKoioQvsgoKa2KXLMJ74e6Y2CxWHw1nMI+QvS4VjlPHQXmi+WIiv29hqOHUfvgTE3iRVo4A4BiAKmEXhKgr/3xaaI3NK9OMKEHKfxfJwCPM7XMe/IsNe4guNImDKpvY1pfZe/GzTt1A+tlNuI7h45LBdp6Vj7yoT54UDNUhIO2dNpJIJFnKlEe8RoX1xwQxIKnrtAhrvmsoCSlF9/5J/xrGKHQEFcPXCLj6Mx9jf6qssh3Z4kczqJc6LJwHdI+nMSrbBA4VxDa0whNdzJwENC89SARvy0Z8mVvbccntvNTfuprergsNFECIHbmQ5gLAop+i0z+AippzUItowKFOurExjbvFahGHoVwcoXO8sxwMMIGDp1/o/hUGolN/QOLPU1pRKzpdOmwHX/Mnqw6F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR07MB8119.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(36092001)(478600001)(76116006)(53546011)(6506007)(5660300002)(9686003)(8676002)(55016002)(54906003)(26005)(186003)(6916009)(55236004)(316002)(4326008)(2906002)(66946007)(66446008)(7696005)(66556008)(66476007)(64756008)(33656002)(83380400001)(8936002)(52536014)(71200400001)(38100700001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KRLAnGL+oJvX8W+p15dO6jfJlslp3YZcLKbQSvZrKVeZgnljZkpj4qzNUn3k?=
 =?us-ascii?Q?mung2AZhIVXUAjhUX3fZf5fSwji93iJRFF5oVM1+sO91/oun3/BGMmlUBHkA?=
 =?us-ascii?Q?ckU/a0QTs8XvQKoP48xrK/yyDWRptHqwuu8oXoifgqxOcreTA9h7yhBM7dCs?=
 =?us-ascii?Q?tyYoPKNm+UHZAtJHH1myxFWz5NxYUL+IIbSBI94QCjhE6Nkfw+BX5NNFXpVa?=
 =?us-ascii?Q?hD25nCEntcpgI5LKpR/Qr2aIFM9VHUZULxkko2yBwQvQnUxbfzgskzSw8LgO?=
 =?us-ascii?Q?J09RS+VEEYhkx8kMZ5xtjNos2kMCRKCsGsy4wkjz+RGgYTJu0yRzzDIJgWyF?=
 =?us-ascii?Q?oHsH/lkur/eVFO/BkH3HQbIVFR7s6Rwu+K4YDs5y0G6xLlnM8Mgv1qexKrEW?=
 =?us-ascii?Q?ynkmbbZgRPyCwUN8ziTs9EasmcYHVb4vLLmrmS10q9NnjvqTQpNLI6ptktH0?=
 =?us-ascii?Q?X+ZYQQttmWkOutZQoNh0xCZMk1/sWKLYw2ah1xZIsfbK+ezG2K7WyLyKeF/U?=
 =?us-ascii?Q?VEKTlySY22gGMi5IE3LSl+VDk/J5fKD2m6zYPwtSHTAtGSdV/G1VLFwPR5+r?=
 =?us-ascii?Q?cpLKne6U3RocCYVQRjxBHMOvIF7PvMUoFfmvQP7Z0YPfIzvgWfttWq8CNWmm?=
 =?us-ascii?Q?nv7KfFUGQIO9ux5b1iTyFp+1jIuYq6gFmzCNqI4Dvd9UVtw4hQsFQ/TmNuO4?=
 =?us-ascii?Q?k2n/5v2CU2ozaSTsGq+/IQds9d28gWxS5PlnSn2w4HtK8ryCYJeJRMqCy+Y2?=
 =?us-ascii?Q?WYV4882O5JB52hXhrWJEDo3NDjmawlvE+y0EmujXxIokZNFMYCPhKT+ZGnGS?=
 =?us-ascii?Q?mdK2l9eF0OrgUUQ1ohE5ugUmX7nHa30qdXgK1yc3KyG66KQOZIxPKCHvc3jp?=
 =?us-ascii?Q?MWORDoRaYzd9LQjhAxQpdFljP/XXBBCZoUsAmeqr/9bOrV4LcLyHAQpUgGPk?=
 =?us-ascii?Q?tqYdfILbmQo97x4APJUh44ZC1QnLaeoGU5Tpes5s9WfT/noJCaiA/20K7SVi?=
 =?us-ascii?Q?nficiGJDEETV6Hp8Co7Gs8dF6d9r6igwinSseyRWdgsU3v3cENUlpuCSh5Q8?=
 =?us-ascii?Q?SXhGWM1i4Em8JgY3UZAvuoQ1FOd8ran+eDZawMmjocUZ7sqoOvwLlLACdHVe?=
 =?us-ascii?Q?Y54DNXUVeUtJqqjvS72Qvf5vM4+4G2JF2NkKQAQPrJuHYL8gFcLMbA66OJP/?=
 =?us-ascii?Q?l1yEoF8Z0ksiNVagYvvdk8HpH4MKDQ2ZpXeoSwGpXb3+NxmyOdidVOP2oZOO?=
 =?us-ascii?Q?kMuMRpGaGnWhHQB11GZtJ4RRi5et083Y2e+JmbPJK2JZSC5WuFGrAyHo5n1S?=
 =?us-ascii?Q?XTs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR07MB8119.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bfae40-eb5b-4239-1242-08d8ed1d9293
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 10:30:53.9890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LvQJMu/M2lvfj28dV48HN/6QznTSmtbQb9ercGaJEzkJVUjZrsBCAvfDdSCS8LSMqPQfKKcOVGKeyVHu3HNzWUv5dkKUHUITuKvGtGpR/r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6327
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_04:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 phishscore=0 mlxlogscore=803 clxscore=1015 impostorscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103220074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On 21-03-17 20:13:59, Sanket Parmar wrote:
> > dma_alloc_coherent() might fail on the platform with a small
> > DMA region.
> >
> > To avoid such failure in cdns3_prepare_aligned_request_buf(),
> > dma_alloc_coherent() is replaced with dma_alloc_noncoherent()
> > to allocate aligned request buffer of dynamic length.
> >
> > Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> > Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> > ---
> >
> > Changelog:
> > v2:
> > - used dma_*_noncoherent() APIs
> > - changed the commit log
> >
> >  drivers/usb/cdns3/cdns3-gadget.c | 30 ++++++++++++++++++++++++-----
> -
> >  drivers/usb/cdns3/cdns3-gadget.h |  2 ++
> >  2 files changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3=
-
> gadget.c
> > index 0b892a2..126087b 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.c
> > +++ b/drivers/usb/cdns3/cdns3-gadget.c
> > @@ -819,9 +819,15 @@ void cdns3_gadget_giveback(struct
> cdns3_endpoint *priv_ep,
> >  					priv_ep->dir);
> >
> >  	if ((priv_req->flags & REQUEST_UNALIGNED) &&
> > -	    priv_ep->dir =3D=3D USB_DIR_OUT && !request->status)
> > +	    priv_ep->dir =3D=3D USB_DIR_OUT && !request->status) {
> > +		/* Make DMA buffer CPU accessible */
> > +		dma_sync_single_for_cpu(priv_dev->sysdev,
> > +			priv_req->aligned_buf->dma,
> > +			priv_req->aligned_buf->size,
> > +			priv_req->aligned_buf->dir);
> >  		memcpy(request->buf, priv_req->aligned_buf->buf,
> >  		       request->length);
> > +	}
> >
> >  	priv_req->flags &=3D ~(REQUEST_PENDING | REQUEST_UNALIGNED);
> >  	/* All TRBs have finished, clear the counter */
> > @@ -883,8 +889,8 @@ static void cdns3_free_aligned_request_buf(struct
> work_struct *work)
> >  			 * interrupts.
> >  			 */
> >  			spin_unlock_irqrestore(&priv_dev->lock, flags);
> > -			dma_free_coherent(priv_dev->sysdev, buf->size,
> > -					  buf->buf, buf->dma);
> > +			dma_free_noncoherent(priv_dev->sysdev, buf-
> >size,
> > +					  buf->buf, buf->dma, buf->dir);
> >  			kfree(buf);
> >  			spin_lock_irqsave(&priv_dev->lock, flags);
> >  		}
> > @@ -911,10 +917,13 @@ static int
> cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
> >  			return -ENOMEM;
> >
> >  		buf->size =3D priv_req->request.length;
> > +		buf->dir =3D usb_endpoint_dir_in(priv_ep->endpoint.desc) ?
> > +			DMA_TO_DEVICE : DMA_FROM_DEVICE;
> >
> > -		buf->buf =3D dma_alloc_coherent(priv_dev->sysdev,
> > +		buf->buf =3D dma_alloc_noncoherent(priv_dev->sysdev,
> >  					      buf->size,
> >  					      &buf->dma,
> > +					      buf->dir,
> >  					      GFP_ATOMIC);
> >  		if (!buf->buf) {
> >  			kfree(buf);
> > @@ -936,10 +945,18 @@ static int
> cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
> >  	}
> >
> >  	if (priv_ep->dir =3D=3D USB_DIR_IN) {
> > +		/* Make DMA buffer CPU accessible */
> > +		dma_sync_single_for_cpu(priv_dev->sysdev,
> > +			buf->dma, buf->size, buf->dir);
> >  		memcpy(buf->buf, priv_req->request.buf,
> >  		       priv_req->request.length);
> >  	}
> >
> > +	/* Transfer DMA buffer ownership back to device */
> > +	dma_sync_single_for_device(priv_dev->sysdev,
> > +			buf->dma, buf->size, buf->dir);
> > +
> > +
>=20
> One more blank line.
>=20
> Otherwise, it seems OK for me.

I have remove this blank line. New patch has been posted already.

>=20
> >  	priv_req->flags |=3D REQUEST_UNALIGNED;
> >  	trace_cdns3_prepare_aligned_request(priv_req);
> >
> > @@ -3088,9 +3105,10 @@ static void cdns3_gadget_exit(struct cdns *cdns)
> >  		struct cdns3_aligned_buf *buf;
> >
> >  		buf =3D cdns3_next_align_buf(&priv_dev->aligned_buf_list);
> > -		dma_free_coherent(priv_dev->sysdev, buf->size,
> > +		dma_free_noncoherent(priv_dev->sysdev, buf->size,
> >  				  buf->buf,
> > -				  buf->dma);
> > +				  buf->dma,
> > +				  buf->dir);
> >
> >  		list_del(&buf->list);
> >  		kfree(buf);
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
> > 2.4.5
> >
>=20
> --
>=20
> Thanks,
> Peter Chen

Thanks,
Sanket
