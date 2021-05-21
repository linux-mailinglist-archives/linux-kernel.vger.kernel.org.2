Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71E38C94B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhEUOhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:37:55 -0400
Received: from mail-eopbgr1410127.outbound.protection.outlook.com ([40.107.141.127]:30176
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231756AbhEUOht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/f+S3ybS56dFqObhavMXzJlB5uYMTb2k4UL66HfKGOqtHWF4jtjPMPrXCf3PN49FrQtqy+gTFrLin7sJT52CUAkWY0jVg4LsCVUbNP/hP6YuXmhHq2hYGy66lMwpGuBRAhgZdVxuJLiWkG/V6Eir9Ev6IFxxJ9Dv2belJdLzbE6Fw5SaPRdoSekMRUGAJGt/lnR4wJK08Zo+JOststg36lDNKSXqCJyD6adRtzlwxjAA8s8yeL7bz0qt+hITGPO72rwLh+nEpj0jpEbyrpOMhVD9ARbEBjeOD2FF8hmtYh4s8JWLw8kpCDOCjfK+qgCP7jUQJ2h6dCW/RSO11uJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOvLR2Zb4csnH2C1km4+QzQ1HMHveLF6R34CQ6SrT1Y=;
 b=njMKGe4P7kigS0luTJxHZN6LZaYY2djZIUKLRtlDjPwid+JPaWb/Mdaolttuxe/vwa1pRv524H4Y4Uzyer5O1auInkkz9Gk+rJqEtJd2XxT1D+KDqGn/2WDd1ATTOc4T9ngqoqYYhq3mAOm2s2f5nAz9j3Q9Qwd7Ew3VGQV5Y1R2hlG2QYqG4bbjhhw2TmX3jqglDHYocluLSQlZqTK74hZkhG2AM2Yt34jEhr7Doh6j7Yog+Mo9U6XgcFeITCqLyGEyVjm893b0Wx8W6mVH05OFhF2We8kERWWCSfiFCf6/PTBGxcfErq39F8vqAbErHlmhXFKYeJ93O0wOXw25sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOvLR2Zb4csnH2C1km4+QzQ1HMHveLF6R34CQ6SrT1Y=;
 b=LNkSC5gX9+MkCbVPPrgBL63Ro3vqv+mLDi186DpELft87rvcGiUvoAwUME7r2jz4xw13jYF6pMlF0Nx/4rFcgcg+B2UTDRYi7H96gvN1Kf9+Dse5Shiv7WUq1YeGHZkXhmpBdNwmcypnXgAuawcE4YDB1OrHiJFf/bMg6ezDZlg=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSAPR01MB1556.jpnprd01.prod.outlook.com (2603:1096:603:31::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 14:36:23 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2%7]) with mapi id 15.20.4150.025; Fri, 21 May 2021
 14:36:23 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXOtSPoxM3P4fkKEmDrY8StfrCU6rqloqAgAONlTA=
Date:   Fri, 21 May 2021 14:36:23 +0000
Message-ID: <OS3PR01MB6593794BFE3A4A08C62E708BBA299@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <20210519080807.GH805368@dell>
In-Reply-To: <20210519080807.GH805368@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75abf811-caeb-4893-f23a-08d91c65ce98
x-ms-traffictypediagnostic: OSAPR01MB1556:
x-microsoft-antispam-prvs: <OSAPR01MB15566E4A3B46901F3533A666BA299@OSAPR01MB1556.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7cS/oatnQFfrhs6NpH+vIYwkt6DlvVFMs93zZphFFw9FtIk3fykp1m/e5fdt1grQZkwi4M6mZWPx+dhhgv02He7rI8her4vXBoN4cTDlizkU72DP3GyTAukgGR7c25uHVRaAX1D/EO4oWiVwX+ZvMDE1J2zj7/Zf3TzS4JqeGluzQGxrCdQjB9v5p28R3cqB1PsgD2R4ZNqqYZwG5Li1f7+iS96nfBnElNwknXgGqluLhuCX8XzMC26r9P5QiYkd3ikMSnnqZKwxkI5A4Ylizsx22QCvKHvu4BQrg4G65ncVXsIELLnY35q5DEMu9E0yXeQKDNIIHKBHnCMRKQ34iXFognoFcERiReJ/d0uZem1NqZzikbV8uJAf7UGILK0vhoA/57QoTOX8zGVGM7Mt+rxZ1zkQ7/eFKGfoNGcv+XifsoL6mLI72mnrmP/7UWy/cnghNSeZNaGUJXI+3Vpyd9dmYRKEZ2hrb6MzCJQjoX50TYOVi+GXVjusgMeLfKWPNIaIUSpizEprtBrJw3XYYtJv45TFPUCZMoS9I1viFtAFou+vzfrb+AwcmAOKWelOBe4o+Sr2Iscni0PqVr0d7Wn+QRD97kUfTeFLNqOcHuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(316002)(76116006)(66446008)(54906003)(66476007)(66946007)(64756008)(66556008)(5660300002)(186003)(26005)(122000001)(6506007)(33656002)(6916009)(478600001)(71200400001)(4326008)(52536014)(38100700002)(7696005)(55016002)(8676002)(8936002)(4744005)(2906002)(86362001)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TmlsSWljQytXTnluSEZ5dWtxTXZwZklSM2U2Z2hBTGd3cHFIWUxSbThndjlK?=
 =?utf-8?B?OGJBMVZQQ2RPV0Fla0Y3K1lRWkQ2TmZTQ3ZQVTR6eldCS2NRbWJKcVlzUTA0?=
 =?utf-8?B?QlY0L1VDSEVQN3JURWxMa3BTdjFEVTJlbXpsMnRmWVk0UlVyYStRdnpDMUJq?=
 =?utf-8?B?dWpwU3RGSlo3Z2F6SkoyNGphU1JTYWErWnlRYnh3MnpDdjZhZ0JkbnByWFR2?=
 =?utf-8?B?QmRaN2xIeTU4YUdkZEJxd0pPcTJzdzdMUFQzWFpRV0F2Q3dmZXhweS9UQStS?=
 =?utf-8?B?U0pSejIzZk1OYlF2dGhMRlF6UFMxbnBXWWx3ZHgrRHMrTWFwbDlPdURUREtr?=
 =?utf-8?B?NlJOTFl5WFdmVExFeTNONnZTZks1U0VQWHRTaHdSTFNhcGJJRjcwY09yNnB4?=
 =?utf-8?B?VjJsb2JpNXlDYTlRNFBGcWowT0NLWHVQTFR6VFFucnJ0Z0FuRUVxL0VqTTdY?=
 =?utf-8?B?ZFF3Qm1FVWpnWXQzMkpVakdHS2M1RkZnWE9pZFhTMHN2R2g4N1htcXNOUGZl?=
 =?utf-8?B?RHRMZWtyc0lJNWhYS0k1dlRTYTdIVDNqL1gvblpyb1hTUERKTXZlWTJPem81?=
 =?utf-8?B?SlBaNmZMR2xhb3JpOXdueVpIUUVXY2VQRmxWcFlUckxwdzI0RWpseEJ3UWdP?=
 =?utf-8?B?Q1FrSXNrOHl3SEUyMExleDdJQkR3VzczZGhQMEdFYkJlcTI2TDAxcE5vVWRs?=
 =?utf-8?B?bmpQc1FuZjNmdGh5RWpab1Fja1pPamdaR0tTQ3JndSt6RitHbjlwN1VRQUZz?=
 =?utf-8?B?RDEycm9NRUlMbGd3S1JJNjhTT0RnSk9NaVc2cjNwblhFM08vVFlVWWFJbm4x?=
 =?utf-8?B?V0lpVi9xVGtQR3hUVTFNVmRIWHUvSFBtZ3gxbTJ4TEpuajNWL25Vd3JqTEUz?=
 =?utf-8?B?RmJaZktpa2RGWldMUmc5amxhaE1JYnR4Z3lreFp1NUdncnB4NUE2WHB2VmNS?=
 =?utf-8?B?aUxnQjFFNW1KMmpyWDdnUlNlS1pqZzBLR0ZXNG5RWlVFTG9XMmZGVng3eTd1?=
 =?utf-8?B?dnpFWjJmdk94ekR0V0R1M09hYmNBVm0yWS9zTk5ucndpRkM4L2JCOFlXTmZx?=
 =?utf-8?B?ZHV2MzFWUDRtZGNFRlNZU1hEVkVCSHY4b1N0UGRRcCt0WWNiUHBINk9aRW9O?=
 =?utf-8?B?NnlpZzJ6STRKeDZ2dTRwTVhpa0t5UUJ6T2RsaFQrR2d6TUZ3ZjN1alpSM2Vi?=
 =?utf-8?B?R3lMRGxWMTl5N2RaRE1hd0xRWHNENVlKV0V3cWY3bzl4K20xak5jVDRRRGxy?=
 =?utf-8?B?bmNHeFFWbW9QYVNKS1I0TndsUVo0V3JWejJ1d08vdkNNQ1IxcXlmSUxQNzJZ?=
 =?utf-8?B?am5CNitEQVE5N0hBaWg4K1ExZGNTdTV5T0x6TDRRZVFZVGJQalg4SEoyZ1Zl?=
 =?utf-8?B?bXcrcUVFRVNTdmVjaUZEWmR4VU9LUTQrTHdDT1h1cCs0OWtZMklINkM5dnVY?=
 =?utf-8?B?NDkvUWFvR2dYOU1HK0NGSjMrYjdobkRYcXRDcXZ4c2dZQnV6LysvaXlxU0pm?=
 =?utf-8?B?QklVUlg5N1NFeWZTS3JHTTFtNWpiK1c4cUp3NWd4L2JoNndydVlxenJVQzlp?=
 =?utf-8?B?bWEvVWI5SjZDY1JsSVJQRU9oSksrRUM0WXpxTVBLNm8zbURwMVkyUDAyVzZz?=
 =?utf-8?B?ZTMvTFZJRmk2K1dPRk1mbFBSd1YxY1lIL3BMbDVjNWhBbjdiekExMnFPaWxP?=
 =?utf-8?B?RUQ5WXJsUGtVL2IwbmpqUnRXUnFiTS95N2YzOEx1bklXQ3dlR0NiaHNvbnU3?=
 =?utf-8?Q?RqQOP2IHFqfPEcuEEbeKljs0684bKCe0JrajvdB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75abf811-caeb-4893-f23a-08d91c65ce98
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 14:36:23.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qt4FmRb9l2mKlQpY1Tr+R1zk/86qpLSBkHC8jIO6Jc1cZ8UJB3fmm0bkFmSCY3m/B0we+1qzPWJsJEdx76roxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1556
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gK2NvbmZpZyBNRkRfUlNNVV9JMkMNCj4gPiArCXRyaXN0YXRlICJSZW5lc2FzIFN5
bmNocm9uaXphdGlvbiBNYW5hZ2VtZW50IFVuaXQgd2l0aCBJMkMiDQo+ID4gKwlkZXBlbmRzIG9u
IEkyQyAmJiBPRg0KPiA+ICsJZGVwZW5kcyBvbiBNRkRfUlNNVV9TUEk9bg0KPiANCj4gTm90IHN1
cmUgSSd2ZSBzZWVuIGEgcmVsYXRpb25zaGlwIGxpa2UgdGhpcyBiZWZvcmUuDQo+IA0KPiBEZXZp
Y2VzIGNhcGFibGUgb2YgU1BJIGFuZCBJMkMgdXN1YWxseSBoYXZlIGEgY29yZSBkcml2ZXIgd2hp
Y2ggc2VsZWN0cyBvbmUNCj4gb3IgdGhlIG90aGVyLiAgSXQgd2lsbCBhbHNvIHNhdmUgc29tZSBj
b2RlIGR1cGxpY2F0aW9uIHlvdSBoYXZlIGhlcmUuICBQbGVhc2UNCj4gdGFrZSBhIGxvb2sgYXQg
c29tZSBvdGhlciBleGFtcGxlcyBpbiB0aGUgTUZEIHN1YnN5c3RlbS4NCg0KDQpIaSBMZWUNCg0K
VGhhbmtzIGZvciB0YWtpbmcgeW91ciB0aW1lIHRvIHJldmlldyBteSBjb2RlLiBJIHdpbGwgc3Rh
cnQgd29ya2luZyBvbiB0aGUgY29yZSBkcml2ZXIuIEJ1dA0KS2NvbmZpZyBpdGVtcyB3aWxsIHN0
YXkgYXMgTUZEX1JTTVVfSTJDIGFuZCBNRkRfUlNNVV9TUEkgbGlrZSB0aGUgZXhpc3Rpbmcgb25l
cyANCg0KTUZEX01BREVSQV9TUEkNCk1GRF9NQURFUkFfSTJDDQoNCk1GRF9EQTkwNTJfU1BJDQpN
RkRfREE5MDUyX0kyQw0KDQpNRkRfTUMxM1hYWF9TUEkNCk1GRF9NQzEzWFhYX0kyQw0KDQpNaW4N
Cg==
