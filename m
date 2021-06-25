Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF723B3BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhFYElj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 00:41:39 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41826 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229458AbhFYEli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:41:38 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15P4Xpor031067;
        Thu, 24 Jun 2021 21:39:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=JKQRZ1TX6EqOwqJSqQaJW7W/93QtFnQrLd3VULJwuZ0=;
 b=kf647/LH8rj8VGXShdaGAhjTdk2ncETKoGShHH8dTcFw4/DZZh7X28R9zGSY+XkymB2u
 0y7CmQVK9frpFByKQ4iahheJ8z8kTlTSudYioF1MGDQEw0GQf0gHDS0ya/yqFzaKiShO
 kZmAYrFf5OQrgxUk1Q/bEdem5MYJzZVNLKRy89Z8gwavQUV6UkZFLOezvpINS+vZ/P8/
 AXmmq7qftcCe34ldSLDkwMVqpMpfOudHyH7Np1ehS6uHxfxdtDQzvzyPue/3pln+pVy8
 x8kbHNQFzj60KS9TuP3KNJKGwcH8K8yDiuEYG6jC5its8aOe7nuFDrtdhIr78OSb/FJS fQ== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 39d23c1ew0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 21:39:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtSfXssBURikQDyBMtxA29dtS7RR+cuwWmncP9WZ1ZoTfe1eDHxH+aLuMw9Mq36M4eBn21b/am16HLGRV5parnFaI2zbq99C+x90PH1JCOg1tCTzsdRxALw3yCSB25oJpKmSxNSDG3wNvJQjH9NogRhCSJHcWCKvTnHrboa8WlQOcA6PpXXMas5fHd+uYJHbPFVmLB35PFw1aVKPW+Eev1W3hxMDDR3Oyaexj9YsZwBpg6m46Ggt5iTboFQz8zHtvpZISiLpb90CR3mfTXO8k9ya77VF7FPgOGJMRpMZpxe96aqjL7TCo7v+X/yhlB73nMozjiNiAKMM08rihTNnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKQRZ1TX6EqOwqJSqQaJW7W/93QtFnQrLd3VULJwuZ0=;
 b=Ze7sx7XFZsZFcGaaXx7jjNzHZEsv03+2MUir8GWo+CcEDkV3H30zTYAATy1toY4kORB/FUPVJlbyG2Qa6VPAgJkS/SvS1mo1J6ijiblXO7LP1h6dcxVMMSOs/M8zdnvmyp3jFXx8vOkaO/RCiPIJsPto3Hk7XjzyVaeaxI6WUKQH/cnQUguMDV1NzM2I9dBRqfWY2V/Ivh/ym4AvHJDyG5YabdBbGRIyXkcTvPYYGmoMtc5ZPJIg+p1h8KFOo6dNb4Kzpd+ZP85ynXJEHVA3uuRealIKWqIdFsoFN/9It61Wk989IKZCu2b6OcvCsp6S2Um/uYIrSHfrnMckmVe2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKQRZ1TX6EqOwqJSqQaJW7W/93QtFnQrLd3VULJwuZ0=;
 b=OxcUvRiXews3avL6E3NS7CTYqb3w2XiVOmG4R5e7O/dlwQMI4QSuyA+jJocJG0kU90nXH+aqB2/K+Uj+vljLKvg17N10N0XDpXKjIZV77fzfqDzOf19ZENNBKYcH6Yur03qH6C7ESgvP2+HVC9RLtW57JdgTsjszjq+OSEaRLIc=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by SJ0PR07MB8726.namprd07.prod.outlook.com (2603:10b6:a03:377::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 04:39:13 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::21a3:4648:fcda:e438]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::21a3:4648:fcda:e438%4]) with mapi id 15.20.4242.025; Fri, 25 Jun 2021
 04:39:13 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix the IMAN_IE_SET and IMAN_IE_CLEAR macro.
Thread-Topic: [PATCH] usb: cdnsp: Fix the IMAN_IE_SET and IMAN_IE_CLEAR macro.
Thread-Index: AQHXZ54aqs4YpaHOu0aHRPbIczk5K6skH+swgAAIeDA=
Date:   Fri, 25 Jun 2021 04:39:13 +0000
Message-ID: <BYAPR07MB53812DBF7D5860FD4DEFD485DD069@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <d12bfcc9cbffb89e27b120668821b3c4f09b6755.1624390584.git.christophe.jaillet@wanadoo.fr>
 <BYAPR07MB538179F3E10205B43C52DB19DD069@BYAPR07MB5381.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB538179F3E10205B43C52DB19DD069@BYAPR07MB5381.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDg2NDhhNDQtZDU2Zi0xMWViLTg3OTEtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDQ4NjQ4YTQ2LWQ1NmYtMTFlYi04NzkxLWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMjAzNSIgdD0iMTMyNjkwNjk1NTA3NzM2NjE1IiBoPSJDekkyZGQzQmRjYmxiTmlhTUx2UGFjSUFpWkE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa7c0255-cac4-4c2f-50b0-08d937932ec2
x-ms-traffictypediagnostic: SJ0PR07MB8726:
x-microsoft-antispam-prvs: <SJ0PR07MB87266CBDB294D9AFAC76B1ADDD069@SJ0PR07MB8726.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYCbcKc988F2pqFWOVn+ZgJsR3qMUJ6/kcDft9RF9SC9bBtVsJFIzbJ+SbNGVNsErB1xNddpCHOfo1VIu28+uJjSyp4n4APpACmDH3pDJGfzBrRn455D3JjlWRhCPQFN7fYrFowG/iAUugRumFLUC2jWeiLheNPdjhInqhlcKv06YbnV02ZuLW8sUQK5rsmQjnhGSl6xsl1SHHaYgxPsr9OdfMzTBzCbRQ8ZX7NuMFqjoiLxGEYPy9Efu0oPFgSaun6efFn2J6gLg0Oj9CWLO6qyiBtUO/Swga+ZdpY+bnIsKUGUuzzBfxbas4bw3fUoFYv50WDeErennrJ5rCVPhFbkrmvRGt8mIlz104aukLBxc3XMLRU/kiyZsbFEO14kg6+TeBzTrHE/Gt2pXxnny3O8UtmXu3HWk+D3d+SGrbcLeY+qxOnq+ea7t7yvF2P1W+LJ2SibnZrjSM9tb8RA1sPlAuXdSiOKunRjVyj63qI2/cX80mAZr/1wvLQY4wG2rVBoLjsQ5wEfglfzuWq9PRynBT7JVqZ6Te2TZC88X9TyzKQ9YvxtSlkRk2WNBDRcea8bpYD8Psv24IqF5UzignjTcL4MrYdd8lg8zYfggp2QxwJ07L0iRrFv2G18Hu+Q+mkyyO6VRjzMttnQFED7aCtD95PVadO9QVFnor0++rG49lYnT73CTY8hYC3oFYrFjhj0P384hXdQEc8zdsQ2UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(36092001)(76116006)(122000001)(38100700002)(4326008)(66556008)(8936002)(64756008)(52536014)(26005)(186003)(7696005)(66946007)(66476007)(8676002)(66446008)(33656002)(316002)(55016002)(9686003)(83380400001)(478600001)(6506007)(54906003)(2906002)(86362001)(5660300002)(71200400001)(110136005)(2940100002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?39WjQeFWSJ+iWjd+ewxP2SwxurTDy61vGVL6YcUQ6hTbOR/kOOBdRY3ZSXLf?=
 =?us-ascii?Q?FvVh2imSph3WXRt13762JUgj0n1E3QBpKji6462igQA1Py/0mHJtMdU74UkF?=
 =?us-ascii?Q?drjq+TKf3M3QZ7axiOdWbnHVRLvpTIptoMhjD4IzKPkhCrsME5yC2bwlHWvP?=
 =?us-ascii?Q?+P/YXPZOBUhsP1ltluq/kBCiZ3I6/v0LXxGD0a2kyP7FACmb+fbSmytbM1Gb?=
 =?us-ascii?Q?rflMQkRDqdW5vsgrECTVjKSj9h89ihq+TAmoa5evlyo25bLYs36hH0glpJh4?=
 =?us-ascii?Q?S04o2G3Drc4+yibNQkWdauGhcvZV1V6wnuOY2zm1P+adVB+7K7/Qma1kgHkF?=
 =?us-ascii?Q?wwagDnnPCzf63T+t/i8VTffZ7jfPFHSL+0TGGIxmY8aM/OOBRO4768UVhrxC?=
 =?us-ascii?Q?uYq6fcB/GanxxMTUPto+cta7PHBAw38jU5MEOzMTnWfFEP18sXEqPaOB/aO0?=
 =?us-ascii?Q?GCXq2PRgkVgSfGxj0YiOPW4snOtJTTQCirftdtrDvwJiAm20JhO3jDF8KGSw?=
 =?us-ascii?Q?iI/82grb6pqkZDPHEUlsudNstb1Y+wLuRGIxlJ6RYxpy7GI4bVNc58mPmPhw?=
 =?us-ascii?Q?BVvfT6wfa8+Rdeop7PG8KCZgIqGRXUTy+vaSIxVvIWHHDm64MKzth1UE7aP3?=
 =?us-ascii?Q?Gb5u4NmkJQt22kaPgIa+PMcXMQYSUzHF8GdS+d/Jxb9qzQ01G9/uWiOQNGi+?=
 =?us-ascii?Q?HnP42+zSPPJ3d+HpEjFzdX2+SsATz2HO9jm7yye+rHWs1USzE4DyzwDWGC43?=
 =?us-ascii?Q?R4zw8+/NHv6cHi+EyPHYODZ56UrQXhBS3Q7GZ2HbkxNjEKALZ0JZ3iA8DmCo?=
 =?us-ascii?Q?AngumE1aBrFU1w37Kp8Uk3BF0kfUOqKD1r8FS4uYQ53byM6ciufpRUXu/liX?=
 =?us-ascii?Q?/0xrdf3FloCA4KVQEtzDPq0M/voSs+Ft4JgsfVWgbcpi95Rsp1Y8LfRrgYvS?=
 =?us-ascii?Q?+yrR/uQ3nOXDhXdVEYiW3o2gv6uB6n9IdabUGOJb08aNdSlobqRqKOyTAr++?=
 =?us-ascii?Q?8OmoYwDUHa/CZFEzjIOhg38Vy/BL5+I0Jk/ZeD6pBLDr219z3Rf6Nruqk7cM?=
 =?us-ascii?Q?EfdmSapdIjkBt8Ht3sFyLRsYUfHiRPOBWL7qtTLkoNC1BOGcccT0akfd+rJ+?=
 =?us-ascii?Q?Bo4U0BPmc9bak2Ybvsg9KQH4XBkeTVBQqfx26dJu0KvK0qxpgN66O3VzUw4T?=
 =?us-ascii?Q?YDPAYaxgpmd4cJlGcd9HG3icPIVB1C3XFFyw61tx6KZ7LVNKAzujwhTDKIWq?=
 =?us-ascii?Q?hBpYmjueX481uOKGyGzgNjnaJX+ZpP1dMvLbmDmL954khcIt+jsHY5uw/hdW?=
 =?us-ascii?Q?17/uU5+V1Uxh0PuL/KC22m7W?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7c0255-cac4-4c2f-50b0-08d937932ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 04:39:13.2113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRJtxwD2qterXgQZcqrTPDerjZMyj5WVuDI/FALHzYu4tiQcbjGzzUUsJA7RhazG4f+mzzZzxjXFgetn7N3BrwrzWZXUw2+OODWk4/Qkcm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8726
X-Proofpoint-GUID: qNHIn7RnD2guMeMh4Dql_gTqlcG9fIPi
X-Proofpoint-ORIG-GUID: qNHIn7RnD2guMeMh4Dql_gTqlcG9fIPi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_01:2021-06-24,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected Peter Chen address - should be peter.chen@kernel.org

>>IMAN_IE is BIT(1), so these macro are respectively equivalent to BIT(1)
>>and 0, whatever the value of 'p'.
>>
>>The purpose was to set and reset a single bit in 'p'.
>>Fix these macros to do that correctly.
>>
>>Fixes: e93e58d27402 ("usb: cdnsp: Device side header file for CDNSP drive=
r")
>>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
>Acked-by: Pawel Laszczak <pawell@cadence.com>
>
>Currently the bit 1(RW) and bit 0 (W1toClr) are implemented.
>All other bits are not used and are reserved for future RW implementations=
.
>I was a bit afraid about bit 0 which is "write 1 to clear" but I haven't f=
ound any
>issue with this patch during testing so we can simplify these macros
>
>Thanks Christophe
>
>>---
>>This patch is speculative. It is not tested.
>>Please, review with care.
>>
>>Actually, the usage of these macros is:
>>   readl(somewhere)
>>   set or reset the IMAN_IE bit
>>   write(somewhere)
>>So it is likely that we want to preserve the other bits read. Otherwise,
>>the code could be much simpler.
>>---
>> drivers/usb/cdns3/cdnsp-gadget.h | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-g=
adget.h
>>index 783ca8ffde00..f740fa6089d8 100644
>>--- a/drivers/usb/cdns3/cdnsp-gadget.h
>>+++ b/drivers/usb/cdns3/cdnsp-gadget.h
>>@@ -383,8 +383,8 @@ struct cdnsp_intr_reg {
>> #define IMAN_IE			BIT(1)
>> #define IMAN_IP			BIT(0)
>> /* bits 2:31 need to be preserved */
>>-#define IMAN_IE_SET(p)		(((p) & IMAN_IE) | 0x2)
>>-#define IMAN_IE_CLEAR(p)	(((p) & IMAN_IE) & ~(0x2))
>>+#define IMAN_IE_SET(p)		((p) | IMAN_IE)
>>+#define IMAN_IE_CLEAR(p)	((p) & ~IMAN_IE)
>>
>> /* IMOD - Interrupter Moderation Register - irq_control bitmasks. */
>> /*
>>--
>>2.30.2
>
>--
>
>Regards,
>Pawel Laszczak
