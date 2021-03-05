Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7FA32E155
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEFRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:17:01 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:30184 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229465AbhCEFQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:16:29 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12559c9N017395;
        Thu, 4 Mar 2021 21:16:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=sUVbaCoL3qCq0E4H8D2OKlGaoPqi4hvNp+e1j+O6MtU=;
 b=EpAr0b63Z9nZf21lHgavlHEdEtI+d0VKwENzDVxDVxI1h0MgeGU2LDHgjOkPTwpuIesq
 kWuOxlbgkBb8owEvNT4H7WgH/or1kk+9HaNnelxXDCxP2CQmJ7C8iduSu3DpRwakkLRb
 R9Cqhca3iq/vYX6edgBfof4lb5W+jBD06yg3AFxvNjtBOkRCA29aBP5UmJuCD5xvD9il
 u6xHk0xQ6MUYX4IisJXYlfJ5NKU1r0C3vHDRkFquM+iLWYiH/MFriut1HQSMtLxGueYY
 eUQqfh86z4+IgKjZS31QUWDLzRw6yqeHdL8YUfVHAMZE2F24P0dMgaSvVNdHOyRfzgfM 2A== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-0014ca01.pphosted.com with ESMTP id 36yjj2vh37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 21:16:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJUED+FLGwVsdU4xTMLlESq4txou2Kv4fmyaWs2Q0hvLWyB0EHnMbxsRYHlU/BrjsqDbiLoqwxdQBxI4WfSoEtV6myqu2GUMAnwXFykegRoLvu22CpmMGjTIO0LVSoEdNjkcEkk0WWaeiyxD2Be8nGCo2VulvJavH+gKHt7P9FJtMBLKJo4NHIrVI1hhophEMyDLGKbrENmwbWMLTuQRNcU+JI2J32L2pXk6aqYVQwL5C3EBAzMsi3sPmtHKC3HWFwaXgfgCbrSPr6Dd7x1Iffr8aCcUAjnkrgWQ4X4Advf87T0xm9b5n16jtC9RC17C6mjuOLSprxCvAUQgJ9Fclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUVbaCoL3qCq0E4H8D2OKlGaoPqi4hvNp+e1j+O6MtU=;
 b=gFd8upFPcYSJ5Rq+zqzb5WT0bPf3bOYft2BQfJzGTPJBtVGjXLghLI5/SB9TRzKq04Yfo/mDkfLTIi/8UAtaapoiR0jXgni5bBOb1hL2en08V19VLri0h/fvpfab+hSibqy/wbsFvcjKztnoq+fItUXg5IyNBOAcjz5jDKegT8VDqdR1/kAWfFzR0kxmNwADT2ZGGcXe2V2LvsEZLvHXREGGxPtfMXeyXqpZfaEYnkb5KJTYCRy1yjzWzZ7Jg74j+obgQgku9HICoYnMjakDVZdHGD3zBlZA0FVF9YJG4uv8DqbvlwDNvQOpIjgup0H6ij9nUPxZbbAXY7zCnt6wRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUVbaCoL3qCq0E4H8D2OKlGaoPqi4hvNp+e1j+O6MtU=;
 b=SxIY/rfQ2R4yLiyRp9rIceCfRE59fXYyx3j10pH04tFP4lTgQax8kg0H6o6/QYzEV1Obg9oMEYTWlZ7mLjv1eMhX+wFMgq7ImqKUkNQEQwcLPJ6WEW1ZYp3Oq7cAsRg6l0lYcuhUdU4K96leORoWNgtUZ69PyPXx1GCManEalO4=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB7944.namprd07.prod.outlook.com (2603:10b6:a03:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 05:16:13 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3890.033; Fri, 5 Mar 2021
 05:16:13 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH] usb: cdnsp: Fixes incorrect value in ISOC TRB
Thread-Topic: [PATCH] usb: cdnsp: Fixes incorrect value in ISOC TRB
Thread-Index: AQHXEXyK1z6qTwgDjEORzPSt+8Yoy6p02Y1w
Date:   Fri, 5 Mar 2021 05:16:13 +0000
Message-ID: <BYAPR07MB53818D48E6D3EBBC05034B96DD969@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210305050028.3329-1-pawell@gli-login.cadence.com>
In-Reply-To: <20210305050028.3329-1-pawell@gli-login.cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZTVlYjdlNzItN2Q3MS0xMWViLTg3ODYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGU1ZWI3ZTc0LTdkNzEtMTFlYi04Nzg2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTc0NCIgdD0iMTMyNTkzOTQ5NzE3NDA1MTk3IiBoPSJZTVRYREVoZ1dnUFJkTVRlYXpYaDl4VmRScDA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0911ca89-98f2-4d0c-34b0-08d8df95cc05
x-ms-traffictypediagnostic: BYAPR07MB7944:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB7944DF8D0D9E7BCFE901A4EADD969@BYAPR07MB7944.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:264;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yh9USyz7Ep4xEnhxEEeM0Mj6muLgKUo5Qqd2osU0aVflFYFJ5XvRHiZidVza3oBihj6ylEb3RiG88JiCG0jOSLQqUCVqqDzoaB5Kl/Z4Wv8EPtD/DotZmOYDc0NpQa8URL73j57DbSciDMb36ASlumiXm+f9WpuKKNRJdF7suolD3vrNTuEMBLLbB+CujgXWP+RRn/XU2hndD0CpMPovYHEkzLPgeev8B4eq13Uwdg7kaoeKRXTvDMr3rg419vK3CLmNQdkbrd7lctEXbHLBFIyR8qW+9gGQyVC0IGiGthguv9Pj++ZIEZgJz4yZbkJDIJB0nxi7K10HIkLZkFMV69+eggjCocS8MXWfBQS/z/+0RI/k1CV+DmUWZBJnj212MGJlcmq46YXz7DOtPu7TGh7Oi5gb9U1JOv7uEw9JkBO9jCSG8sC7oCyzdBqFl0fDstvZ5FqsCoskKkXYPi50r3tZN4SBkUqqEXrgqgPgUKNRRm8/4Iz29gkrEFEVoXxHj1WT55GUetOOFUGiXBqftgJCjVm8e/Vj/irv+jxtwCZVGOHi9xVworZBWU+00MFhAi4Fyky8zI0co424hBfPKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(36092001)(71200400001)(4326008)(9686003)(55016002)(83380400001)(26005)(107886003)(5660300002)(52536014)(64756008)(66556008)(316002)(8936002)(66476007)(54906003)(110136005)(478600001)(33656002)(66946007)(76116006)(8676002)(7696005)(186003)(66446008)(6506007)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kQkcdDA2JIlTBfWROIhGkH9XyFy+phrn21n6WyvAa8XFqPgEzWmGl0oYYw6S?=
 =?us-ascii?Q?iOIld1ThELdtA8Ur7JK17HxJiOkJAoipim69fE4+CxBX45IqzXP4trMkvvgU?=
 =?us-ascii?Q?RHkAYMo2+zVf6ScdWlOmX2OOVM6lxsHK7bynhdl+WxTlzel4xs+TbaPxrDP/?=
 =?us-ascii?Q?Eb9JXcJWpvXhXRfJtBjWTnOsyMp2+gDZKfhI6BRcwr8a0g5qvLqMWOrw33PH?=
 =?us-ascii?Q?TtS+ruWprAH/YGALZh6eVdIY5f5Zs2EoWT/PL9zRrX/FKzHqsn2mwM7LObvB?=
 =?us-ascii?Q?4DhDsbWrAU3jqbLS63ATgcNHr/6qH4jZEGkxJXBcXAqnnn4hoIeQOjyR/c0E?=
 =?us-ascii?Q?CcaY9/yG7hOBCzsrWeI/1rO4UXMHCyJI+5zZfhLaf0+sBMeA2n6ENKSNlnP4?=
 =?us-ascii?Q?z6K2ZCSMGbHUSjQiD94YLdzbDWyAyhLSR/lIC2zm2NjomTY8bRQAaoyGw4q1?=
 =?us-ascii?Q?7JkamnpvDIksmG0KgDCuj43eE7M7LxqihuSYt50w6YOFf1Q9JgObYDEna5S+?=
 =?us-ascii?Q?lvgsUu/0OKyb96KMqIeqYVUHBwukGL668UmataXA3xm7F5t4HJs7NKJfjQVm?=
 =?us-ascii?Q?Jw6en4E99skF1p38lZ3EY5ZzChofForzb1VOx9NUYs3ogl3qR4SVVzH807lc?=
 =?us-ascii?Q?CV8RYeJrizgn5OGcW2whC4+QWLTl3KKeMXedbxAegPK1y7QUlSD90eh9nfTE?=
 =?us-ascii?Q?J8k9PJ6FfYlHzy9CoS9QrlNnl87U0X7j0uG3aBQPlC28a35KbEgm+wm/1I9X?=
 =?us-ascii?Q?PnKZ0NBVpLqUKngQDgF4DF6gH/sfUaMYn34vB/2ctmlGk24Suyu2S+XVLpIn?=
 =?us-ascii?Q?Hoe0BGR/0TlDrVAWE/h8VCelhry4oshXS58ppvLogLn8uUGQb0lhOui+tdAv?=
 =?us-ascii?Q?PZ2EhM98/oMixq/E3BMmOcuhjPcqyjsuHaU5SDnGRD5c0Rh76KmIRx/Jm9CO?=
 =?us-ascii?Q?uSHrFoZgSO8cMewgtskdDsmfixfNToBZypQXOaDTzVa6afBatSq74y3IhzCb?=
 =?us-ascii?Q?d1uF50qGjhWyJJCNHfBsBIH69ZDWvpDwcKQTb0GY8diQ0DiYVqAaFoE/PLq8?=
 =?us-ascii?Q?0SLEUqvGzCaMUwPTfmVYMwORpxi/2GVflZv2jWpxviUFaqXKKDEAqQ76R6gs?=
 =?us-ascii?Q?czHUsHXLMraegn0pAlLQsiNJPfIf4ZOWLDgUzLVI3FYGF+yqNDJn4hOxFLIm?=
 =?us-ascii?Q?dpAlwLOzcom0gAM/NOUbbtpkTh3xK2FPGu3ZXxVYZpim+focb9lJwMY/bS2V?=
 =?us-ascii?Q?7lt3jK7+QZkvMHl+HOVdaRO9J0/gVCdInVUqZC8ddMXqqS+Tblv4/XWWDWT+?=
 =?us-ascii?Q?SZ5Er6rtI3zxiiIoqbuDx6K8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0911ca89-98f2-4d0c-34b0-08d8df95cc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 05:16:13.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va81YvnPXVuFQAS6D5CC0z6nS0AULMOfecZ7GQHLw8L4JjSZg25cxfk8+1MmWNOYoNYHm5dJMcovjFq+cJ6nVzBGzgjpUKlqzGNVeCSXwns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB7944
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_03:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this patch. I put incorrect address to Peter. I have sent aga=
in this patch with correct email address.

>-----Original Message-----
>From: Pawel Laszczak <pawell@cadence.com>
>Sent: Friday, March 5, 2021 6:00 AM
>To: peter.chen@nxp.com
>Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-kernel@vg=
er.kernel.org; Rahul Kumar <kurahul@cadence.com>;
>Sanket Parmar <sparmar@cadence.com>; Pawel Laszczak <pawell@cadence.com>
>Subject: [PATCH] usb: cdnsp: Fixes incorrect value in ISOC TRB
>
>From: Pawel Laszczak <pawell@cadence.com>
>
>The value "start_cycle ? 0 : 1" in assignment caused
>implicit truncation whole value to 1 byte.
>To fix the issue, an explicit casting has been added.
>
>Fixes: commit 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence US=
BSSP DRD Driver")
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>---
> drivers/usb/cdns3/cdnsp-ring.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring=
.c
>index f9170d177a89..d35bc4490216 100644
>--- a/drivers/usb/cdns3/cdnsp-ring.c
>+++ b/drivers/usb/cdns3/cdnsp-ring.c
>@@ -2197,7 +2197,7 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_device *=
pdev,
> 	 * inverted in the first TDs isoc TRB.
> 	 */
> 	field =3D TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
>-		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
>+		(u32)(start_cycle ? 0 : 1) | TRB_SIA | TRB_TBC(burst_count);
>
> 	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
> 	for (i =3D 0; i < trbs_per_td; i++) {
>--
>2.25.1

Regards,
Pawel Laszczak
