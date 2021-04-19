Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC4436499C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbhDSSGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:06:11 -0400
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:55754 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240024AbhDSSGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:06:10 -0400
X-Greylist: delayed 633 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 14:06:09 EDT
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JHplT4027867;
        Mon, 19 Apr 2021 13:54:54 -0400
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2056.outbound.protection.outlook.com [104.47.61.56])
        by mx0c-0054df01.pphosted.com with ESMTP id 37ytsyhapx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 13:54:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcDnqJxWRxGsMnyq3tZ3p+AxYVPv0vmRvsaG1QZsDAANEkYCGTfKpXZPrEW9gEW8F6Qu+SOzGgKkvM42qNlZnAKFAF4aAXXXzvPjkUV2Q8Bqa28Pn3eA4XfjCMhnbvnUsvq1qXCEQnwQvUbpB4Rq+3SDd/3eApqrWt0bkEi82iiesn3bo9Po9cNhwV95imM8yqfg1JQV1wmifLyZsa/fqXrUO8HRPTSUayeeTfNfMD30je7ssF/k0ofwd6EtiinC1uUbgVS2+ZNINHa22giqnS2C7cTMRS/ml2FVV/0wJompMMHhBLYfTy4m06Pf/cmVYLRkP/kpec4bHANm+YzwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8Aco9ZaIwV+dfTlbPGKo1hK+WH8c1tdGS4YopxN3H4=;
 b=G8TMQMiX6T1LlJkS29srGEzq9SIBkVRb2GGIgD7iSRAJpHIZY8JptPP7aIFxBrYRnfEG1C4jgPXuvsJfVTYFxJUlYQ5FjyT+7+yZ0XgNG8pGpyGKIIf/ISG01Ig6KLZmEw43Ke7RK1bzE6K7oB+9g1yzXc8URg4xrnxsythcN8nS/KZ8jZCc7rVbsWCTKk9/CNjT/1YoarnSRmqIWQO2b5rusf6JrqPDMH8ZoY/+uYoXc6mHkmSBWfY+nk9b8GhiKU4TtSuJmA0GJnqF3//J+vwpEr3Ef8wycX7ik6XloGe0RuLaiX/b8G0zwpYJJ32R4IRXR6gFHUO+Qfqav7nPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8Aco9ZaIwV+dfTlbPGKo1hK+WH8c1tdGS4YopxN3H4=;
 b=5F4JfsAUCdtKFesnVe60Gplc3bHTVU8T1TAd9/qcxopoFCpKUG1/hy7sXq0rWuWjqUAl3IUWBtHISC1PuBF9VTfZsmLi0A5b9wQWG9dpovp1cDFZaRzLuT4oqZL9cwfFHV1oQe6a4R3hmTqpJMCj14s8KDXsi3aoZ6On5iF+7Lc=
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f::20)
 by YT1PR01MB2988.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Mon, 19 Apr
 2021 17:54:52 +0000
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb]) by YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb%7]) with mapi id 15.20.3999.038; Mon, 19 Apr 2021
 17:54:52 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "anirudh@xilinx.com" <anirudh@xilinx.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/xilinx: Expose Kconfig option
Thread-Topic: [PATCH] irqchip/xilinx: Expose Kconfig option
Thread-Index: AQHXMk+1X72b4VVgvka/cnIJ9aoOvqq3J68AgAAobACAAB4bgIAABeYAgAREAQCAAG10gA==
Date:   Mon, 19 Apr 2021 17:54:52 +0000
Message-ID: <ffaabf53f66a35a7fff1b1e2014318d8e1416396.camel@calian.com>
References: <20210415233250.4071772-1-robert.hancock@calian.com>
         <87zgxys5xn.wl-maz@kernel.org>
         <2834595e6552c81441592a57dc41146d46484143.camel@calian.com>
         <877dl22k0y.wl-maz@kernel.org>
         <87916c069789a91a5bb0856c6ff9d72c36a59dd5.camel@calian.com>
         <c3cdcb8a-9d32-3bf1-b69e-86e4942861cc@xilinx.com>
In-Reply-To: <c3cdcb8a-9d32-3bf1-b69e-86e4942861cc@xilinx.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-16.el8) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=calian.com;
x-originating-ip: [204.83.154.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2baa1d8b-41c4-44ee-2166-08d9035c3bc5
x-ms-traffictypediagnostic: YT1PR01MB2988:
x-microsoft-antispam-prvs: <YT1PR01MB29880452AB46364EA3C51C5EEC499@YT1PR01MB2988.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /f1/6zKLjdpJ4rYgJKCAI8WfHLgyWjjlqdIlVOHTbbqhai2UW5rdYIuANQfsrXo2zWiCEG6lIUKQqNG7FMKoaioE3MUO9biHuocpIUOCa4U3Re9OHQ1SFjBBJXB0P8kymsMh912LH4zqh5/iwHDhu3V3oEtt+afCowoOUU30QOAKlF0QBDqdLXkrknGgRNOdLeft93xZZZLC+3VO0G2xHkRrrC799DAKtO3jCyxM5FNsRGWrH9gIos6geac4b4nvkPAfThxmXtj58YfYw45YZFMl40R8jt9QrvrE41NFxqu3xmpMLEXpl2pFUKnrbp++DeOGwEmtoIrlljA3B4gHcrOvmUaNZJQo01HBXircRNuY4SVb0tJyQyoYgqvCTIJy3lo7nUCneTUDeCT1yuEbzPoAy9fDSEyVY55xRXb2klezn4xlz31OBTIhVyZd1ZW7d9O4NzXHw5jppVR1JjYSeVaS97gqhsaygWVmdNiyYXlUIlBfoZ483T9UGXfhVE/ls0mut946KEsjFSedmS4xIwpCSQnoHw54rpGDpU07iLpgKpbintyiGa13orb1KPxpYHbUZpiWGf6QIcfR6ZdJIojnxTkP4h/CKEBbiB3v89Qr2Gu6cxioHoDmyuAa5RGgNLMqBcRbIzlTONes6HmkztmTzjIbNwZm1dZWgpLTVFfq+tP1Vrmm6Tm/lcvlGip+O2BVUaHlvb1KnOf75KYz7jSh08zaPCjcwWlBYSkHORyAFJhJubC1413G9j+2VSTyASoyC9rHk6P3symKnfeSEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39850400004)(376002)(346002)(396003)(478600001)(5660300002)(186003)(6506007)(6512007)(91956017)(8676002)(8936002)(110136005)(4326008)(66556008)(64756008)(26005)(54906003)(66946007)(6486002)(2616005)(66476007)(36756003)(86362001)(76116006)(66446008)(83380400001)(53546011)(15974865002)(38100700002)(71200400001)(122000001)(2906002)(316002)(44832011)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MTQ0QXh0MDM5ckR2bk9saURxbE5TN0hoaW5BMXNxZ0gzWGw1ZlZwdDNEUmFR?=
 =?utf-8?B?WWd0eERPamRDT0xPNW01KytYNGx6Y1plUmRwbDg5T3NIUGRMZUNoR1lYaXUr?=
 =?utf-8?B?anB4cUxUeGllaHprR09GbkJOWDZ2WEdSVHdJV2R2c3RGU1VxeExOTUl4V3VK?=
 =?utf-8?B?QjNmcGFEM2JmYTVIdHcydGNLd3ZPRjBYZ1ViMHBCdFo1QnlRVFVOWUdhRk9T?=
 =?utf-8?B?cDJqZHZaVXRQVDgwcnVHRTFjeFpUQm9pTFZ2NmJySjI2Nmd4WGpTVWRSQ1k0?=
 =?utf-8?B?WGJ2VVdReFR0VUtlSVN5UE9FTS92NUt6VkdvaDh1RjcwQ3VrZk5zLzRMU0dU?=
 =?utf-8?B?cEY3ZTRNUURUOVhSZ0NPWFBraWdDRk1pOTJsdUZaR2xrc1hWaUEranpxSWJF?=
 =?utf-8?B?RjdKdmxTanJKb2NMQnhHOUhUN0lFQmxoQ2hXUFRhWmpYQ2FwTnJZMlpYVy9W?=
 =?utf-8?B?UnlDWnQ1b1NCZ05lYXpoOUlJWlRTelhJN2RKSHNtQTB4Um9FUkUxVTkrNm1x?=
 =?utf-8?B?OGxuMndZdDZKYzMwVWttVVNXVHNyazhjdU1OY09oVSt6SExzWDMrMDZyVUY3?=
 =?utf-8?B?SlBsbStkaTFicHRLUmloYVRNSjJ1Y2VWK3FQa2xxU2hwVkJIMlpDaVdVVFBa?=
 =?utf-8?B?ODQ1cmUxUDNETCtYK2NZc1ZEbUlWRmtlWFJhN2xJc3BPbytrRG5adzh5NnhP?=
 =?utf-8?B?QlVta1l2Y044aGhIUG5hWFJ3aFlIdHkzeWwwQkNCWlFnVWZhZUdia2VKaGpS?=
 =?utf-8?B?VVNuNm40NDBVYVpsSWFSc0cwaHowU1praVppZ283RVc5SnowNjZySThwM2VB?=
 =?utf-8?B?Yk5OUGo3SzI1M09CTGgwMTFtS1lvNWZpMThCOGJXNnFaS1NrSUx5ZkhKdDRF?=
 =?utf-8?B?bkYyZ3A4NlppSjNEeDdLVlNzM3hHMjdBaUJCV0RLMkxFVFpNbjY1OGZsUUpY?=
 =?utf-8?B?MTZlbUpoTkVqb0tuQnUyM1FNUzJVZW1EekVEd2kxZ05Wcmt3c0xkcGZUYVFv?=
 =?utf-8?B?dE5TSHpacE00MVpVcjgxTXU2YW40RFZOQVFCaVFRUjFKOWw3TFJ1UzFHQWF0?=
 =?utf-8?B?R2FPR1ZtbFJrOE04ZHNuWTh3VGFJYmVFU3MxT29wc2UvRG02UTZiZlFMVm8y?=
 =?utf-8?B?ZlZnQWFOS2RXK1BIVG94U1Z2a3pyYit3QVlBS2wyT1l5QUR6K1FWSWZwYml1?=
 =?utf-8?B?cFQvQ3dUc1hFMEN2aFp3dCtYU2h1RjJFTS9GQTd3UFB2ck55SWRINEN5YjV4?=
 =?utf-8?B?Qk85V3p4cFJlNDE5dE5NT3hRVldFK1oxUXg3TlhFK3AzRjhFelFaUllsaXdy?=
 =?utf-8?B?S1VvN2ROTlJ2d25aaFRvSzNuekVPYzhiTnhCRlJrT3FnbW54RWpXZFZ5aExP?=
 =?utf-8?B?Wjd6OHBzSkQ5TW91ekJ6VTBmUHJMbmwrNEZ5SzFkMjVnNTVlRXN3cVduYkds?=
 =?utf-8?B?RG5tR0xsVWtMUXN4ZTVBaU5RZXhuWjhZQnlFNmhmNnRJR2ZkVThOR3hNK2pk?=
 =?utf-8?B?d1J5dEFEL0RFWlZzc2g0UWlJNzBvUFVaTXRleU00TlMxYkNKV1FvSFI0ZkNs?=
 =?utf-8?B?eFRRLzh4VU1yTkZVQTR3aWRscFAvdE11LzdqN2Vua2JBcFQ2elVtT3pRb1k3?=
 =?utf-8?B?d2dycmQ1azRQU1B0cHZaak94b3hWMFVYeFU5QVdMZCtMVUJZWEdWd1lINHRa?=
 =?utf-8?B?bHEza1VrNVI1VG1ZUGVFWno2Z3NWOFJFdlp2VkwydUszSE1mZ01lTkhlc0ZG?=
 =?utf-8?B?aTVuNmo0RythV01IdW80bDk2Q1M2TjdRcm0wNHNJM2Z5MHVvK3JHSXMxOTVM?=
 =?utf-8?B?WnNhdXI1VEwxeDRIQ3BNZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF893947D2B9D349932695C0BE45B78A@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baa1d8b-41c4-44ee-2166-08d9035c3bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 17:54:52.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZepChRwa6/r8//YjbPfQ2Tp6OvIhBWRYriTS6sEy4rSvPjmfU0EY6xiQmvLb92DhOvPR4VUUEkZnOb+SgwPLZb39RmioFRiowPdZvahaZ3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB2988
X-Proofpoint-ORIG-GUID: ByqSCi84CIeGoX-0E-70ujLr0STWO9Sd
X-Proofpoint-GUID: ByqSCi84CIeGoX-0E-70ujLr0STWO9Sd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTE5IGF0IDEzOjIzICswMjAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+
IEhpIE1hcmMgYW5kIFJvYmVydCwgK0FuaXJ1ZGhhDQo+IA0KPiBPbiA0LzE2LzIxIDg6MTQgUE0s
IFJvYmVydCBIYW5jb2NrIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMS0wNC0xNiBhdCAxODo1MyAr
MDEwMCwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiA+ID4gT24gRnJpLCAxNiBBcHIgMjAyMSAxNzow
NTo0OSArMDEwMCwNCj4gPiA+IFJvYmVydCBIYW5jb2NrIDxyb2JlcnQuaGFuY29ja0BjYWxpYW4u
Y29tPiB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCAyMDIxLTA0LTE2IGF0IDE0OjQxICswMTAwLCBN
YXJjIFp5bmdpZXIgd3JvdGU6DQo+ID4gPiA+ID4gT24gRnJpLCAxNiBBcHIgMjAyMSAwMDozMjo1
MCArMDEwMCwNCj4gPiA+ID4gPiBSb2JlcnQgSGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFu
LmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiBQcmV2aW91c2x5IHRoZSBYSUxJTlhfSU5UQyBjb25m
aWcgb3B0aW9uIHdhcyBoaWRkZW4gYW5kIG9ubHkNCj4gPiA+ID4gPiA+IGF1dG8tc2VsZWN0ZWQg
b24gdGhlIE1pY3JvQmxhemUgcGxhdGZvcm0uIEhvd2V2ZXIsIHRoaXMgSVAgY2FuIGFsc28NCj4g
PiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gPiB1c2VkIG9uIG90aGVyIHBsYXRmb3Jtcy4gQWxsb3cg
dGhpcyBvcHRpb24gdG8gYmUgdXNlci1lbmFibGVkLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgSGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNv
bT4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgYSBnb29kIGlk
ZWEuIEluIGdlbmVyYWwsIHBlb3BsZSBoYXZlIG5vIGlkZWENCj4gPiA+ID4gPiB3aGljaCBpbnRl
cnJ1cHQgY29udHJvbGxlciB0aGV5IG5lZWQgdG8gc2VsZWN0LiBTbyB5b3UgZWl0aGVyIGVuZC11
cA0KPiA+ID4gPiA+IHdpdGggYSBtaXNzaW5nIGludGVycnVwdCBjb250cm9sbGVyLCBvciBhIGJ1
bmNoIHlvdSByZWFsbHkgZG9uJ3QNCj4gPiA+ID4gPiBuZWVkLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IFRoaXMgaXMgZXNzZW50aWFsbHkgYSBwbGF0Zm9ybSBjb25zdHJhaW50LCBhbmQgdGhpcyBz
aG91bGQgZGlyZWN0bHkNCj4gPiA+ID4gPiBiZQ0KPiA+ID4gPiA+IHNlbGVjdGVkIGJ5IHRoZSBw
bGF0Zm9ybSBpZiB5b3UgaGF2ZSB0aGlzIElQIGluIHlvdXIgc3lzdGVtLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAJTS4NCj4gPiA+ID4gDQo+
ID4gPiA+IFRoZSBwcm9ibGVtIGlzIGVzc2VudGlhbGx5IHRoYXQgYXQgdGhlIHBsYXRmb3JtIGxl
dmVsLCB3ZSBkb24ndCBrbm93LA0KPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiB0aGFuIGluIHRoZSBN
aWNyb0JsYXplIGNhc2Ugd2hlcmUgd2Uga25vdyBpdCB3aWxsIGJlIHVzZWQgYXMgdGhlDQo+ID4g
PiA+IHBsYXRmb3JtJ3MNCj4gPiA+ID4gcHJpbWFyeSBpbnRlcnJ1cHQgY29udHJvbGxlci4gSW4g
b3VyIGNhc2UsIHdlIGFyZSB1c2luZyB0aGlzIElQIGNvcmUgb24NCj4gPiA+ID4gdGhlDQo+ID4g
PiA+IFp5bnFNUCBwbGF0Zm9ybSBhcyBhIHNlY29uZGFyeSBjYXNjYWRlZCBpbnRlcnJ1cHQgY29u
dHJvbGxlciBpbiB0aGUNCj4gPiA+ID4gRlBHQQ0KPiA+ID4gPiBwb3J0aW9uIG9mIHRoZSBkZXZp
Y2UuDQo+ID4gPiA+IEJ1dCBtYW55IFp5bnFNUCBjb25maWd1cmF0aW9ucyB3b3VsZG4ndCBoYXZl
IHRoaXMgZGV2aWNlIHByZXNlbnQsIGl0DQo+ID4gPiA+IGRlcGVuZHMgb24gd2hhdCB0aGUgdXNl
ciBpbnN0YW50aWF0ZXMgaW4gdGhlIHByb2dyYW1tYWJsZSBsb2dpYy4NCj4gPiA+ID4gQWxzbywg
dGhpcyBjb3JlIGNvdWxkIGp1c3QgYXMgZWFzaWx5IGJlIGluc3RhbnRpYXRlZCBpbiBzdGFuZGFs
b25lDQo+ID4gPiA+IFhpbGlueCBGUEdBcyB3aGljaCBjb3VsZCBiZSBjb25uZWN0ZWQgdG8gbWFu
eSBkaWZmZXJlbnQgcGxhdGZvcm1zDQo+ID4gPiA+IG92ZXIgYSBQQ0llLCBBWEksIGV0Yy4gIGJ1
cy4NCj4gPiA+IA0KPiA+ID4gTm90IGNvbXBpbGluZyBpdCBmb3Igc29tZSB1c2VycyBpcyBncmVh
dCBpZiB5b3UgaGFwcGVuIHRvICprbm93KiB3aGF0DQo+ID4gPiB5b3UgaGF2ZSB0byBzZWxlY3Qs
IHdoaWNoIGlzIHByb2JhYmx5IGEgc2luZ2xlIGRpZ2l0IHBlcmNlbnRhZ2Ugb2YgdGhlDQo+ID4g
PiBwZW9wbGUgdGhhdCBidWlsZCB0aGVpciBvd24ga2VybmVsLiBBdCBsZWFzdCBoYXZpbmcgaXQg
dG8gZGVwZW5kIG9uDQo+ID4gPiBaWU5RTVAgKG9yIHNvbWUgb3RoZXIgRlBHQSBwbGF0Zm9ybSkg
d291bGQgbmFycm93IGl0IGRvd24uDQo+ID4gPiANCj4gPiA+IEFuZCBpZiB5b3UgaGF2ZSBzb21l
IG90aGVyIEhXIGluIHlvdXIgRlBHQSwgeW91IGNhbiBtYWtlIHRoZSBjb25maWcNCj4gPiA+IGZy
YWdtZW50IGZvciB0aGlzIEhXIHNlbGVjdCB0aGUgcmlnaHQgaW50ZXJydXB0IGNvbnRyb2xsZXIu
IEJ1dCBJJ20NCj4gPiA+IGRlZmluaXRlbHkgbm90IGtlZW4gb24gbWFraW5nIHRoaXMgYSB1bml2
ZXJzYWxseSB1c2VyLXNlbGVjdGFibGUNCj4gPiA+IGRyaXZlci4NCj4gPiANCj4gPiBJbiBnZW5l
cmFsIHRoZXJlIGlzIG5vIHNwZWNpZmljIG9yIHVuaXF1ZSBjb25maWcgb3B0aW9uIGZvciB3aGF0
IGlzDQo+ID4gaW5zdGFudGlhdGVkIGluIGFuIEZQR0EsIGl0IGlzIGNvbXBsZXRlbHkgdXAgdG8g
dGhlIHdoaW1zIG9mIHdob2V2ZXIgc2V0IGl0DQo+ID4gdXAuDQo+ID4gWW91IGNhbiBpbnN0YW50
aWF0ZSB3aGF0ZXZlciBsb2dpYyBjb3JlcyB5b3Ugd2FudCBhbmQgdGhlcmUgaXMgbm8gZ3VhcmFu
dGVlDQo+ID4gd2hldGhlciB0aGV5IHdpbGwgb3Igd29uJ3QgZW5kIHVwIHVzaW5nIHRoaXMgaW50
ZXJydXB0IGNvbnRyb2xsZXIgaW4gdGhlDQo+ID4gcGF0aA0KPiA+IHNvbWV3aGVyZSwgc28gaGF2
aW5nIGEgZGVwZW5kZW5jeSB0aGVyZSBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZS4gRm9yIEZQR0EN
Cj4gPiBsb2dpYw0KPiA+IGl0J3MgdWx0aW1hdGVseSB1cCB0byB0aGUgdXNlciB0byBlbnN1cmUg
dGhlIGtlcm5lbCBjb25maWcgdGhleSBhcmUgdXNpbmcNCj4gPiBoYXMNCj4gPiB0aGUgcmlnaHQg
ZHJpdmVycyBlbmFibGVkIGZvciB0aGUgY29yZXMgdGhleSBhcmUgdXNpbmcuIEtjb25maWcgZG9l
c24ndCBhbmQNCj4gPiBjYW4ndCByZWFsbHkgaGVscCBpbiB0aGlzIHJlZ2FyZC4NCj4gPiANCj4g
PiBUaGVyZSdzIHNvbWUgcHJlY2VkZW50IG9uIHRoaXMgaXNzdWUgd2l0aCBkcml2ZXJzIGZvciB2
YXJpb3VzIG90aGVyIEZQR0EtDQo+ID4gYmFzZWQNCj4gPiBJUCBjb3JlcyBmb3IgU1BJLCBJMkMs
IEV0aGVybmV0IGV0Yy4gT2Z0ZW4gdGhleSBzdGFydGVkIG91dCB3aXRoIGFuDQo+ID4gYXJjaGl0
ZWN0dXJlIGNvbnN0cmFpbnQgd2hpY2ggbGltaXRlZCB0aGVtIHRvIHRoZSBwbGF0Zm9ybSB0aGV5
IHdlcmUNCj4gPiBvcmlnaW5hbGx5DQo+ID4gZGV2ZWxvcGVkIHdpdGgsIGJ1dCB3aGljaCB3YXMg
bGF0ZXIgcmVtb3ZlZCBiZWNhdXNlIHRoZSBhYmlsaXR5IHRvIHVzZSB0aGVtDQo+ID4gaW4NCj4g
PiBzdGFuZGFsb25lIEZQR0FzIG1lYW5zIHRoYXQgdGhlIHBsYXRmb3JtcyB0aGV5IGNvdWxkIHBv
dGVudGlhbGx5IGJlIHVzZWQNCj4gPiB3aXRoDQo+ID4gYXJlIGJhc2ljYWxseSB1bmNvbnN0cmFp
bmVkLg0KPiA+IA0KPiA+ID4gPiBTbyBJIGRvbid0IHRoaW5rIGhhdmluZyB0aGlzIGFzIGEgcGxh
dGZvcm0gY29uc3RyYWludCBtYWtlcyBzZW5zZS4NCj4gPiA+IA0KPiA+ID4gSSBkb24ndCB0aGlu
ayBpbXBvc2luZyB0aGlzIG9uICpldmVyeW9uZSosIGFjcm9zcyBhbGwgc3VwcG9ydGVkDQo+ID4g
PiBhcmNoaXRlY3R1cmVzIGFuZCBwbGF0Zm9ybXMgbWFrZXMgYW55IHNlbnNlLiBTdXJlbHksIHBl
b3BsZSB3aG8gYnVpbGQNCj4gPiA+IHRoZWlyIG93biBIVyAoYmVjYXVzZSB0aGF0J3Mgd2hhdCB3
ZSBhcmUgdGFsa2luZyBhYm91dCBoZXJlKSBjYW4gYmUNCj4gPiA+IGJvdGhlcmVkIHRvIGFkZCB0
aGUgc21hbGwgS2NvbmZpZyBmcmFnbWVudCB0aGF0IGlzIHJlcXVpcmVkIHRvIHRoZWlyDQo+ID4g
PiBrZXJuZWwgYnVpbGQuDQo+IA0KPiBUaGUgc2FtZSBpbnRlcnJ1cHQgY29udHJvbGxlciB3YXMg
dXNlZCBieSBwcGM0MDUgYW5kIHBwYzQ0MCB4aWxpbngNCj4gcGxhdGZvcm0gaW4gcGFzdC4gVW5m
b3J0dW5hdGVseSBpdCB3YXMgc2VwYXJhdGUgY29weSBvZiB0aGlzIG1pY3JvYmxhemUNCj4gb25l
IGFuZCBwcGMgY29weSBzaG91bGQgYmUgYWxyZWFkeSByZW1vdmVkIGJ5IHJlbW92aW5nIHN1cHBv
cnQgZm9yIHRoZXNlDQo+IHBsYXRmb3Jtcy4NCj4gDQo+IFRoZSBmaXJzdChkZWZhdWx0KSBjb25m
aWd1cmF0aW9uIHdoaWNoIHdhcyBtZW50aW9uZWQgYWJvdmUgaXMgcHJpbWFyeQ0KPiBpbnRlcnJ1
cHQgY29udHJvbGxlciBmb3IgTWljcm9ibGF6ZS4NCj4gDQo+IFRoYXQgYmVpbmcgc2FpZCB0aGlz
IGNvbnRyb2xsZXIgY2FuIGJlIHVzZWQgYW5kIGFjdHVhbGx5IGlzIHVzZWQgYnkNCj4gWGlsaW54
IFp5bnEoYXJtMzIpIFp5bnFNUChhcm02NCkgYW5kIFZlcnNhbChhcm02NCkgU09DcyBhcyBhIGNh
c2NhdGUNCj4gaW50YyBjb250cm9sbGVyLiBJIGhhdmUgYWxzbyBzZWVuIGNvdXBsZSBvZiBkaWZm
ZXJlbnQgY3B1cyBpbiBQTCB3aGljaA0KPiBjYW4gdXNlIChhbmQgYWN0dWFsbHkgdXNlIGl0KSB0
aGlzIHNvZnQgSVAuIEJ1dCBsaW1pdGluZyBpdCBmb3INCj4gWnlucS9aeW5xTVAgc2hvdWxkIGJl
IGZpbmUuDQo+IA0KPiBSZWNlbnRseSBteSBjb2xsZWFndWUgKEFuaXJ1ZGhhKSBkaWQgc29tZSBl
eHBlcmltZW50cyB3aXRoIGJpbmRpbmcgYW5kDQo+IHVuYmluZGluZyB0aGlzIGRyaXZlciBmb3Ig
Y2FzZXMgd2hlcmUgeW91IGFyZSB1c2luZyBpdCBhcyBjYXNjYWRlDQo+IGludGVycnVwdCBjb250
cm9sbGVyIGluIGEgcHJvZ3JhbW1hYmxlIGxvZ2ljKFBMKSAocHJpbWFyeSBjb250cm9sbGVyIGlz
DQo+IEdJQykgYW5kIHRoZW4geW91IHdhbnQgdG8gZXhjaGFuZ2UgdGhlIHdob2xlIFBMIGJ5IGRp
ZmZlcmVudA0KPiBjb25maWd1cmF0aW9uIHRoYXQgeW91IG5lZWQgdG8gaGF2ZSBvcHRpb24gdG8g
cmVtb3ZlIHRoaXMgY2hpcC4NCg0KSXQgc291bmRzIGxpa2UgbGltaXRpbmcgdG8gTWljcm9ibGF6
ZSwgWnlucSBhbmQgWnlucU1QIGZvciBub3cgaXMgbGVzcw0KY29udHJvdmVyc2lhbCBhbmQgbWVl
dHMgb3VyIGN1cnJlbnQgdXNlIGNhc2UsIHNvIHdpbGwgc3VibWl0IHYyIHdpdGggdGhhdA0KZGVw
ZW5kZW5jeSBpbiBwbGFjZS4NCg0KLS0gDQpSb2JlcnQgSGFuY29jaw0KU2VuaW9yIEhhcmR3YXJl
IERlc2lnbmVyLCBDYWxpYW4gQWR2YW5jZWQgVGVjaG5vbG9naWVzDQp3d3cuY2FsaWFuLmNvbQ0K
