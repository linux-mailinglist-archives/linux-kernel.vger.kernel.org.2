Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2563B3B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhFYEZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 00:25:43 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:7414 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhFYEZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:25:37 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15P46mpn009673;
        Thu, 24 Jun 2021 21:23:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=8b7vwy6koBzZFcslHpN1km4JEY56oKLuuq3l7DW4XBI=;
 b=QzI34kvoS3V0vnXl+TERIzcYt22peAFnW1yedJxfiqR7qR+8MSC2AhfrkH1hyN22LKKy
 FeO5MuLEMbyWt0x2dllSl7KHErLdzPl/9LeDFmWBaP9bpirjLhEviYSn0S5szL9MqVGE
 otZ14vkQ4gGlizj396bMRRfT/kyJ3XvfPGo4vLWc7ROSNm+r0f4BvA/vdFMKzAen9FRV
 t/yu9Im1ZRy7GaoToJBjVjbOONEIsllobZwmZpxRr5j0Kl9VCb//zU7OtH2lqnDv7nPY
 Bx0HIVTNiAO0rFpvDJVH4q2FNRpjMvwYfNbegwg9GXLafVhrFg1UCLiGSVHZ9iJuN5oG Yw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 39d22x1bwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 21:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0FdBStUdERbr8mOLcxEDPNtdo3ljg2MMHb4nIKo1IXdpKXiPWuIl/p1vvtFE78Wz3O44pWOSBUXKphgutCiMwe1iR6haxEgEuURGizzZj7tlsdafXZn7szL1Cod6IUbZJtz9ofAYUYXLv5MqgvxyJcRuC5uYwWYE0dhsbnEMw1gqGh/bEavtxLmYyW1kpYDZ7wrn7CWKk8bES75DLfMjWWcGNjXkPJyun8734KkjhmTvfGlLPJOhZl7tlaOU1m55gjZQs0/ckFs3R99a88jwHg2fq5jOWHpw7vmKEABNT7jq1kHyzu8c6hWbaZq+/pDkBSKA/oOJcwqatGGgdfdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b7vwy6koBzZFcslHpN1km4JEY56oKLuuq3l7DW4XBI=;
 b=DLIMXE+9ElZNtYoXe3z89UGwcCZW9wF418o5HqDnaU4+100jq9e9Y8IpDhHG5r3NukOIWhiQvMzh8QBbkBSv3nEdAZkSj8MOgKLq1UDG6ITku21/0Vg18q8Bn78hGs0H+fk6Xquf37dXFDLG3Cd0hjXY4+DMqsqXSx6oKJLM0cknjvhq4jYnV0Zc4EXDek6m2rSFvS0me6tqLYLMJS2Ql3v8Tm8jkCQo0anneeRYV+p2i8ZrJcSQvGFPHtsRw66mgGO86xvAzfRzj86SlquOMHHUQii62WfbeNS/fK+9VcsOzWpQISgr+CIzt8VHsxeOAB1cKtUFEODg7lN7ixq6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b7vwy6koBzZFcslHpN1km4JEY56oKLuuq3l7DW4XBI=;
 b=kZty8uoQ9KXNbsnL/d2bmymJcz/9q9u2c/JNEGWm2U3ETp+WmXyc6wuxN3YYEgNhmgedsqmY9l9sWDzT5qYGlkQnB/b5J1/rbTLv4m5tEyyO17Pviw4sbXB8JGTMOv2dkOxn/JFhDuEAuUDGdbA7fJae69vWvXrSQLh5YBeo9io=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by SJ0PR07MB8662.namprd07.prod.outlook.com (2603:10b6:a03:374::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 04:23:09 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::21a3:4648:fcda:e438]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::21a3:4648:fcda:e438%4]) with mapi id 15.20.4242.025; Fri, 25 Jun 2021
 04:23:08 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix the IMAN_IE_SET and IMAN_IE_CLEAR macro.
Thread-Topic: [PATCH] usb: cdnsp: Fix the IMAN_IE_SET and IMAN_IE_CLEAR macro.
Thread-Index: AQHXZ54aqs4YpaHOu0aHRPbIczk5K6skH+sw
Date:   Fri, 25 Jun 2021 04:23:08 +0000
Message-ID: <BYAPR07MB538179F3E10205B43C52DB19DD069@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <d12bfcc9cbffb89e27b120668821b3c4f09b6755.1624390584.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d12bfcc9cbffb89e27b120668821b3c4f09b6755.1624390584.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMDk3NzQwNWYtZDU2ZC0xMWViLTg3OTEtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDA5Nzc0MDYwLWQ1NmQtMTFlYi04NzkxLWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTkyMCIgdD0iMTMyNjkwNjg1ODYyMzgyNTQyIiBoPSI2ZDJoUzRNZnl1VkVUMHNOS3JvSEN1MFNyV1k9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 183398e8-18dc-4108-d2cd-08d93790efe7
x-ms-traffictypediagnostic: SJ0PR07MB8662:
x-microsoft-antispam-prvs: <SJ0PR07MB8662C4F4828A0FF68AC0EE78DD069@SJ0PR07MB8662.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UIweJEsd9R2r02DXm9SRAjKP3/RJTCVmm0TSunDfPsfnB7U7JWB6dE01ia5opnTUqHywSQLc6a9Yir951ZHF8srweeR3IpgGTlCJRbOUbnLNxqaxPchmSeDR0g9idf+OfwarGDrPrMFz9FNeiOpV8qVILvKNQ9ieIfZZHY9DuXnJTT9YFD2GxgvKCvWlhPkveBDJpJx5msqz9O7owQSaophWSe0NICBCi1rSfZ5i7EqlnKjp1YSK1xE/2bVJlreCdG7y4YO0UFjTK3S1fIvO8dhtFQigdk5S6iyyoR9zEEZaeaEhFetehTIxgo7h1HS5IxyBtnXoAjQy1/fZHuGyQU76wsDkcPoAUiQVaHvyEFj0PoZETr0M5WPpkrj3g7bf2beJ+1lBfy675baCzXnsEiv4kCg5MLQXXhA/NHpr7ECEAsp0PlN3WPEuUHb44yF7CPvXmP3XRbp9JFyI7gRZB4s1nFjUsQIbJTc8BP3qjgXF8SDxjto4GFYdZFyvC8uESfdCfcsXaN+QcYYQmTPqQWeLsdoPYePLXnANiOWQGXJ+iRlnm7faGjN66DB9SPx9e2tVHEmD8EmUdWvmjlzpyg65onyms8If9KKxGj170kQChtkTFm+iFKIU8W2ZgCHW4h8PaAP2O9l9X0/ioM2HBrGM1iELA5aiRIijmJlty8q0BUuTA97GSuVY/Sf2OY7KkLcgWOLS5A3NJgAPW5hBOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(36092001)(6506007)(8936002)(7696005)(55016002)(478600001)(9686003)(66446008)(83380400001)(76116006)(52536014)(66476007)(66556008)(66946007)(64756008)(8676002)(5660300002)(122000001)(38100700002)(71200400001)(110136005)(33656002)(186003)(26005)(4326008)(54906003)(316002)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jmPeXUe4yH/VUXGnoI+Y/W9I2ESdZQVynCDS0rmgpCKO55dYWwcrV87XJWck?=
 =?us-ascii?Q?nHR9Bj8LRGB29V5mQe9FDzujqHxLLzclIrVgsJlF0ZYMpjsxic5qMqLwgAeg?=
 =?us-ascii?Q?x4FMQ0k557J4DTm1rvj/mfbE8REH8LFstHV5edfZoBzj9rFDOfJl3Zgyegtr?=
 =?us-ascii?Q?B0/ulGG2JlOxttazr/AUnABy4Vy061hDCb1dR8SkPK4R7s+RQK6veo8tePCE?=
 =?us-ascii?Q?21eFOWbsFZnCFcrAjt1JCfIPBykrfmuwNU6FQHnLPOglcfuhYm9YsQ+ObwUX?=
 =?us-ascii?Q?smM3js7hGDEoNCwKHx/tgro9JwKk/6cCqqRb6tJG0jNxVXLaM7om+aj9ijXD?=
 =?us-ascii?Q?933okY2JLgOfATJSFoJu0Hr9xyPH9xHURexMaTTKKKM7au/bStQY2HUei5H4?=
 =?us-ascii?Q?PMIXin3nvjhJv3h8Z/IgtMbsp0HRhC6yBHptU0RxSXKWCAZ7NJOIMOm6woF/?=
 =?us-ascii?Q?tMIQRE0j5jB4eWmhCIqIpz4OrP4x5l8NPMnJUvuqsGjc2JCh/s6Mlq+ExWjC?=
 =?us-ascii?Q?r01t2V3G3CvCKMO3d27BtdMOxBtdFWNfvFgAv2ipc4YjVQvfmIM1Bc+XX97i?=
 =?us-ascii?Q?OWO9Pe0emX4M/shIgZkNuWIO5Amz8SZtQL3kR0bGLLvxLSrIjGxVAQInGoJO?=
 =?us-ascii?Q?BJyidAKpIktDnNLfH+pXZ2mCR277tksHmd4ss7xbBKnDHvdJOoL2ye+FlBBQ?=
 =?us-ascii?Q?lmSUdwXJ4vPVzxND5lCoN0g8MAI78LeTY0LJfdyUnT5KfHQF8Q7a92zYl8rF?=
 =?us-ascii?Q?Yw8xwqvueN0GhMDRcGIbA3BygTqd20y0AteXGdsgnSCnCQi/HoOyNqriTNTb?=
 =?us-ascii?Q?KSyCgfPeO2bXuuTr8gfrfWw6mZK9eyM3jQdwbZnlB+nZu9OQhrfmvPdlPlEk?=
 =?us-ascii?Q?Mv2ai9pG4i9xKkyPO+ouK+lGcXDvT/6GaWGjxwYA4AorSQA4H6sgsYKtJ0eP?=
 =?us-ascii?Q?fpr6+sEyQeMpv2G1AFxI+gS/Y/Biq6DJcmgvJUaBKEprObWKiDpdZjHPyVj7?=
 =?us-ascii?Q?4aUE2n7vLLLZLHREdg/WWdZ8VGWif4vbYddGq9CEV1T3RhIeUJoA/U7Qb+zN?=
 =?us-ascii?Q?43GAlqzsOnVHVSay7wsBHesZGf9yQB4WDfT2wtSTkaQ4wMFSvzPsiExtaVZi?=
 =?us-ascii?Q?72A283vFP8MLPsWIxisJMxR6f6dfPanHZ7+SnNipTtsh0eKY/vQag00T5Uft?=
 =?us-ascii?Q?PUMk5QF8H9f6I31eV9BCszSoDHs7yJM/DuGz2uMCqVgrabgjPU6lNMtIFrJv?=
 =?us-ascii?Q?oOxwrV7vaunYGRJssoEQaOyYYkX0ON1l/m/ysqSx8M47b503jQzimILGC82e?=
 =?us-ascii?Q?JyQeglaHeJXj5GF7fj7xKu9/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183398e8-18dc-4108-d2cd-08d93790efe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 04:23:08.7522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQ6XlUyG9coNe3ycgNzBX2cJM+EF/SR/HjS5cyGV7JII+mmx2RvBAqeCYEQXz1zbo1UWzSngvHrGGUfPUmwg8psaz/uRpCZoSGaX9aGySJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8662
X-Proofpoint-ORIG-GUID: zWX339g9tCOL444kWzlaAbXX4lfcYbtd
X-Proofpoint-GUID: zWX339g9tCOL444kWzlaAbXX4lfcYbtd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_01:2021-06-24,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>IMAN_IE is BIT(1), so these macro are respectively equivalent to BIT(1)
>and 0, whatever the value of 'p'.
>
>The purpose was to set and reset a single bit in 'p'.
>Fix these macros to do that correctly.
>
>Fixes: e93e58d27402 ("usb: cdnsp: Device side header file for CDNSP driver=
")
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Pawel Laszczak <pawell@cadence.com>

Currently the bit 1(RW) and bit 0 (W1toClr) are implemented.=20
All other bits are not used and are reserved for future RW implementations.
I was a bit afraid about bit 0 which is "write 1 to clear" but I haven't fo=
und any
issue with this patch during testing so we can simplify these macros=20

Thanks Christophe

>---
>This patch is speculative. It is not tested.
>Please, review with care.
>
>Actually, the usage of these macros is:
>   readl(somewhere)
>   set or reset the IMAN_IE bit
>   write(somewhere)
>So it is likely that we want to preserve the other bits read. Otherwise,
>the code could be much simpler.
>---
> drivers/usb/cdns3/cdnsp-gadget.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-ga=
dget.h
>index 783ca8ffde00..f740fa6089d8 100644
>--- a/drivers/usb/cdns3/cdnsp-gadget.h
>+++ b/drivers/usb/cdns3/cdnsp-gadget.h
>@@ -383,8 +383,8 @@ struct cdnsp_intr_reg {
> #define IMAN_IE			BIT(1)
> #define IMAN_IP			BIT(0)
> /* bits 2:31 need to be preserved */
>-#define IMAN_IE_SET(p)		(((p) & IMAN_IE) | 0x2)
>-#define IMAN_IE_CLEAR(p)	(((p) & IMAN_IE) & ~(0x2))
>+#define IMAN_IE_SET(p)		((p) | IMAN_IE)
>+#define IMAN_IE_CLEAR(p)	((p) & ~IMAN_IE)
>
> /* IMOD - Interrupter Moderation Register - irq_control bitmasks. */
> /*
>--
>2.30.2

--

Regards,
Pawel Laszczak
