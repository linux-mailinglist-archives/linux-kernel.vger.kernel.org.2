Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03CB3083FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 03:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhA2C4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 21:56:37 -0500
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:7045
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229757AbhA2C4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 21:56:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKnKAd5QhiAAzRm/9Sm4VbHaW43dFJv9KBsz9/UgZ2CUZCLhc/sDvabTZ8ojJXDL6mcTeUX6CIa3UT5+kYv0ZxeNzxwmA2gfD0eq1RvJkfVQWOTuP7WWLgMzIf48/bDeBNmrS2ob+a1yVoH17StXXbQj9Hlo7SqOgWJKVxZI7YN6VG7w3M3eJIwxrbO2B3tHVwPbxSQteTr4VIbzCRlexwJ6SDAOBiA7N2mjKG3KQIG8lqWNLd24UFW0/wEyVRM4EVPINAyjd10MYlVO+IySF779WMZ20aSUZN2mYRTSGq+QsHgbde4h7erL4RqwZ9QZ/kzSnAordy6M1yPSVdeL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HI7ccb0T4bkbvljasa7nZ2knDb0I3V/YKc80WsaAL8=;
 b=U6bRZFyPEEZoqbq3b0KkhA5Qmv5MX6i5Qr3p/S0PrlXNP7jAFwB/cMY1iyx6ogSrtYJZLj6fAkm6G99axSke4z9pNqFhPMMJVpjx3Iu72eAwhYOxgc5rp8FKfG1mzF7BDDHG/6LrhpV3ckqvn9gnPhc1rKGdc3cN8mP/0IIKNwa16OnoxB6NmvrU2Er3Sos37QQfVGycCDoJtxiDYiHaZWcAQZFOkBuwrEoKsFrseICtWrM5PSssj53xthM3lQf/Ibbgx7awtbEfeG+4UPyCKgpPFHSFmliRqGQTIcuCCSHKqaUpoykKdQcQIjyKLP1JDwqzWUj01S4yQdhKD82T5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HI7ccb0T4bkbvljasa7nZ2knDb0I3V/YKc80WsaAL8=;
 b=EQlgsQg2NmwmE72wEjKLzGv62YyA3Dy2rf/ip49ZIeoO5Q7yN8JU0GWZECUhY0pZq8tMIXsZEew40LBW+nqarfV2g54JbELfPzWnHXmhKHIQWRzYdhAXrMbBvUtp97rEGM4ex27k2IGehCOTt0+vbFs4z0MqXU19wD/ddCbgHPo=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 29 Jan
 2021 02:55:41 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::7987:5db5:cd4c:7cd2]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::7987:5db5:cd4c:7cd2%8]) with mapi id 15.20.3805.017; Fri, 29 Jan 2021
 02:55:41 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Marc Zyngier <maz@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [v2] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to remove
 call trace
Thread-Topic: [v2] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to
 remove call trace
Thread-Index: AQHW9R6ApPrmDACm9UKbj2CoepRiaKo8U7+AgABriQCAASuDAA==
Date:   Fri, 29 Jan 2021 02:55:41 +0000
Message-ID: <DB6PR0401MB2438891390D0AAD12B30586B8FB99@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20210127085818.23742-1-biwen.li@oss.nxp.com>
 <a0c0cdaee31d49848525332deec6eb75@kernel.org>
 <DB6PR0401MB2438851F8196DA9C6EF8C3D48FBA9@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <6e20a326ebffdb6768a95c15ac743759@kernel.org>
In-Reply-To: <6e20a326ebffdb6768a95c15ac743759@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f819fced-4593-4c73-057f-08d8c4015d69
x-ms-traffictypediagnostic: DB6PR0401MB2438:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2438CFD23CC969DA26BB2915CEB99@DB6PR0401MB2438.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZVQ2AePw8Jhz7QMsHyuqidarbSi551+EHAgGQ9E508xBfiTFilr3K4YGPp56ziQpft3Ik90/qSne+1+AcNb/NBdI9y0qwQZ2wcrpOLAPMN/K7J7ZbgZDQ/ukexmRMS5jVLYcqpl7Rnpu62w3L8w1hBNaVoL+s34DwecPkavRbgvRua1Ql4Ejr8MdCUsep4ski1DIYZJTyAbVnt3vLGB9yUjiT5tpAzdwTTBPzO3XGVjSxx4Yon870eg08tsKWdW7cwM7ttMbr2daALGb7F5sJvw5W7YElnZjSwLEBmd3hASWGH009hnRG4CQ+QmGLp4vvDk9TUK5EeNjmWoCMXNe7dSS6hObFHsDuE/53Sstojocf2r3ND7fnDILctKDNgUALJm6ciah/2vF00dSY6xtWEdheRl7suMeDdX/r8FJ2+KU1oPrkecJroFlqJ8D4qcnBoxsqjH08E5Zv7CivyOL1yS/+8QfRn70UEPJXN5LCp0TBDy0RiAss5o7cKDoWdxzyOZcsjRffJucjc+qZe7MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(86362001)(7696005)(316002)(66476007)(66446008)(64756008)(66556008)(26005)(6506007)(53546011)(66946007)(52536014)(71200400001)(186003)(54906003)(5660300002)(110136005)(478600001)(76116006)(83380400001)(33656002)(4326008)(9686003)(8676002)(55016002)(8936002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Tml4eHhjSWZMRG5oMmpMU08vdTlOSmVOckxSV0JqakN2UXJLaGpRcytRRUVM?=
 =?utf-8?B?MUtDMWFDTXhnaHliT3pUYUdSaFVMWVVLNG10K0xpN05SOUp5azg2ckY0SVJB?=
 =?utf-8?B?cTVBMVlhY0RtQkJacHBWMG1BSGtIa0pnRjk5Y0tEVHlna2hMS2xCc0ZFaFhC?=
 =?utf-8?B?eVcyY0RYUEQ3MFFLVUNhUDJnRitaTXA4RDRtMG9XcC84dzEvaWk3Um1hckdp?=
 =?utf-8?B?bStLMlkvUEdVclpMMWlRNWhPTFIrdXFWMEFsdGZUYjltbm9SM2V6S1pGMGFh?=
 =?utf-8?B?NkVIQ0VhVEFBdEZqenlmNkRveGF0SzRWYUtXcXBSNEZzL0lZaSt3ZGV1S3FN?=
 =?utf-8?B?NGJ0aXRtSDhud01zNjZCWXlmMEM1NDRTQlJWRXpvV1pjNlQ0TkNSdndESXNs?=
 =?utf-8?B?dHhpY1BpUzFiYXJHTWZJTnVlSlFsNzE5ZDNWanVheHFieHBEemhiRW15SHRW?=
 =?utf-8?B?SDZIbDVsOTV1eTZMWjVuOXd6M3hZSFp1QUN3RHE3VUdNb3FYOU5ya3IvSG5r?=
 =?utf-8?B?S2dQTVBDTlZuSnJMRkQ4VWs3aWR5QVcvZjJycHV6SWJZYVM2VUpPUzI0Y2xQ?=
 =?utf-8?B?aUMydFA3aDRicm5yeTRGSnFLMjBYS2VkeGgvRFo3ZG1GUGhtTHZzZHdiT0Rq?=
 =?utf-8?B?NktrdWR6NzNMdW9GUjJrNkpnZFk3eDRxeTRJdG9SRkdlbHhySWpwSmUwZHpn?=
 =?utf-8?B?UmpEbzdua2kycm4vRGhqNm9RWjVhYWlaVjZjWUJwNlZwb1dXcGFRWStFTGU0?=
 =?utf-8?B?Wm9jdEVxME1zMGJHM0Vjc092OU9IakJwY0R0NDZBR1NCa2JJMStTUTgvdS9C?=
 =?utf-8?B?Rnh6bDlpV3hZaEhuUlZJb0ZLTlpXVWtDSkpzSlJldFpPZ3o3THRzUzAyZ3My?=
 =?utf-8?B?TnFKbllXRDAvTGVyT2JoRXFLMitNRjNxa2gxRTIzVTdKdXlMUHdZWkY2KzlO?=
 =?utf-8?B?L0FNelJha1plVGZnLytHOEcwYVRiWktKL1lCczc1Nk5VczA1TnFvVlNwTUZI?=
 =?utf-8?B?VUc4Q1JTV3QvR0h0MmNneS9TT0gyWnBaaFh0YUo5YUhJcVJETEJvd1U0MEwr?=
 =?utf-8?B?RzdmVzN3ZFUvVlhjK1ozeUNFSnZKdWFpSWRmdU10QnpCSzF2VFFHVXFSTDBk?=
 =?utf-8?B?NUF1WFVpUEtwQ21Nb0Q4TlY5SkxKSEpvN1QxV0lhK09rV0JFbUlTSWZRdTh2?=
 =?utf-8?B?Zm45dSttMWFJeWZHbllWQ3FONDlJMm9rR2I0TXFtRnJVYnZkeldvUitXc2VQ?=
 =?utf-8?B?UWlRQmZiZ203NzNGdWN4SHQxbFVSamJjRlFFN2Q5bDFQVkxzcFYzY0phQjJD?=
 =?utf-8?B?VWFmOXowaW44OGlxRTFOMHltak1rc0V0ZGJaVk9Nd1dhb3BsZ291cmVZTGhV?=
 =?utf-8?B?WXc3N1U0L3Q5TS9mVkNwZEYyNGJEVXl1bnJDcEN6NUxLYXE2QWsrcmxOVzIz?=
 =?utf-8?Q?j5zBM5Xl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f819fced-4593-4c73-057f-08d8c4015d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 02:55:41.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhoT3mGDIuH0xq0cCwBcPL8YQfssHu726QG+V57JQQcE4wACgmAm0HuzVYWQJKRmx3UP8W714Y+x3XO7nZTGKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2438
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBaeW5naWVyIDxt
YXpAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyMeW5tDHmnIgyOOaXpSAxNzowMg0KPiBUbzogQml3
ZW4gTGkgKE9TUykgPGJpd2VuLmxpQG9zcy5ueHAuY29tPg0KPiBDYzogbWFyay5ydXRsYW5kQGFy
bS5jb207IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOw0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKaWFmZWkgUGFuIDxqaWFmZWkucGFuQG54
cC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IFJhbiBXYW5n
IDxyYW4ud2FuZ18xQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbdjJdIGlycWNoaXA6IGxzLWV4
dGlycTogYWRkIGZsYWcgSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHRvDQo+IHJlbW92ZSBjYWxsIHRy
YWNlDQo+IA0KPiBPbiAyMDIxLTAxLTI4IDAyOjM3LCBCaXdlbiBMaSAoT1NTKSB3cm90ZToNCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTWFyYyBaeW5naWVyIDxt
YXpAa2VybmVsLm9yZz4NCj4gPj4gU2VudDogMjAyMeW5tDHmnIgyN+aXpSAxOTozOA0KPiA+PiBU
bzogQml3ZW4gTGkgKE9TUykgPGJpd2VuLmxpQG9zcy5ueHAuY29tPg0KPiA+PiBDYzogbWFyay5y
dXRsYW5kQGFybS5jb207IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4gPj4gdGdseEBs
aW51dHJvbml4LmRlOyBqYXNvbkBsYWtlZGFlbW9uLm5ldDsNCj4gPj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgSmlhZmVpIFBhbiA8amlhZmVpLnBhbkBueHAuY29tPjsNCj4gPj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBSYW4gV2FuZyA8cmFuLndhbmdfMUBu
eHAuY29tPjsNCj4gPj4gQml3ZW4gTGkgPGJpd2VuLmxpQG54cC5jb20+DQo+ID4+IFN1YmplY3Q6
IFJlOiBbdjJdIGlycWNoaXA6IGxzLWV4dGlycTogYWRkIGZsYWcgSVJRQ0hJUF9TS0lQX1NFVF9X
QUtFDQo+ID4+IHRvIHJlbW92ZSBjYWxsIHRyYWNlDQo+ID4+DQo+ID4+IE9uIDIwMjEtMDEtMjcg
MDg6NTgsIEJpd2VuIExpIHdyb3RlOg0KPiA+PiA+IEZyb206IEJpd2VuIExpIDxiaXdlbi5saUBu
eHAuY29tPg0KPiA+PiA+DQo+ID4+ID4gQWRkIGZsYWcgSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHRv
IHJlbW92ZSBjYWxsIHRyYWNlIGFzIGZvbGxvdywgLi4uDQo+ID4+ID4gWyAgIDQ1LjYwNTIzOV0g
VW5iYWxhbmNlZCBJUlEgMTIwIHdha2UgZGlzYWJsZQ0KPiA+PiA+IFsgICA0NS42MDk0NDVdIFdB
Uk5JTkc6IENQVTogMCBQSUQ6IDExMjQgYXQga2VybmVsL2lycS9tYW5hZ2UuYzo4MDANCj4gPj4g
PiBpcnFfc2V0X2lycV93YWtlKzB4MTU0LzB4MWEwDQo+ID4+ID4gLi4uDQo+ID4+ID4gWyAgIDQ1
LjY0NTE0MV0gcHN0YXRlOiA2MDAwMDA4NSAoblpDdiBkYUlmIC1QQU4gLVVBTyAtVENPIEJUWVBF
PS0tKQ0KPiA+PiA+IFsgICA0NS42NTExNDRdIHBjIDogaXJxX3NldF9pcnFfd2FrZSsweDE1NC8w
eDFhMA0KPiA+PiA+IFsgICA0NS42NTU0OTddIGxyIDogaXJxX3NldF9pcnFfd2FrZSsweDE1NC8w
eDFhMA0KPiA+PiA+IC4uLg0KPiA+PiA+IFsgICA0NS43NDI4MjVdIENhbGwgdHJhY2U6DQo+ID4+
ID4gWyAgIDQ1Ljc0NTI2OF0gIGlycV9zZXRfaXJxX3dha2UrMHgxNTQvMHgxYTANCj4gPj4gPiBb
ICAgNDUuNzQ5Mjc4XSAgZHMzMjMyX3Jlc3VtZSsweDM4LzB4NTANCj4gPj4gPg0KPiA+PiA+IE9u
IGxzMjA4OGFyZGI6DQo+ID4+ID4gSW4gc3VzcGVuZCBwcm9ncmVzcygjIGVjaG8gbWVtID4gL3N5
cy9wb3dlci9zdGF0ZSksDQo+ID4+ID4NCj4gPj4NCj4gcG1fc3VzcGVuZCgpLT5zdXNwZW5kX2Rl
dmljZXNfYW5kX2VudGVyKCktPmRwbV9zdXNwZW5kKCktPmRldmljZV9zdXNwDQo+ID4+IGUNCj4g
Pj4gPiBuZCgpDQo+ID4+ID4gLT5kczMyMzJfc3VzcGVuZCgpLT5lbmFibGVfaXJxX3dha2UoKS0+
aXJxX3NldF9pcnFfd2FrZSgpDQo+ID4+ID4gLT5zZXRfaXJxX3dha2VfcmVhbCgpLCByZXR1cm4g
LUVOWElPLCB0aGVyZSBnZXQNCj4gPj4gPiAiQ2Fubm90IHNldCB3YWtldXAgc291cmNlIiBpbiBk
czMyMzJfc3VzcGVuZCgpLg0KPiA+PiA+DQo+ID4+ID4gSW4gcmVzdW1lIHByb2dyZXNzKHdha2V1
cCBieSBmbGV4dGltZXIpDQo+ID4+ID4gZHBtX3Jlc3VtZV9lbmQoKS0+ZHBtX3Jlc3VtZSgpDQo+
ID4+ID4gLT5kZXZpY2VfcmVzdW1lKCktPmRzMzIzMl9yZXN1bWUoKQ0KPiA+PiA+IC0+ZGlzYWJs
ZV9pcnFfd2FrZSgpLT5pcnFfc2V0X2lycV93YWtlKCkNCj4gPj4gPiAtPnNldF9pcnFfd2FrZV9y
ZWFsKCksIHRoZXJlIGdldA0KPiA+PiA+IGtlcm5lbCBjYWxsIHRyYWNlKFVuYmFsYW5jZWQgSVJR
IDEyMCB3YWtlDQo+ID4+ID4gZGlzYWJsZSkNCj4gPj4NCj4gPj4gVGhpcyBpcyBhZ2FpbiBwYXJh
cGhyYXNpbmcgdGhlIHN0YWNrIHRyYWNlIGluc3RlYWQgb2YgZXhwbGFpbmluZyB0aGUNCj4gPj4g
cHJvYmxlbSBpdCBmaXhlcy4gSG93IGFib3V0Og0KPiA+Pg0KPiA+PiAiVGhlIGxzLWV4dGlycSBk
cml2ZXIgZG9lc24ndCBpbXBsZW1lbnQgdGhlIGlycV9zZXRfd2FrZSgpDQo+ID4+ICAgY2FsbGJh
Y2ssIHdoaWxlIGJlaW5nIHdha2UtdXAgY2FwYWJsZS4gVGhpcyByZXN1bHRzIGluDQo+ID4+ICAg
dWdseSBiZWhhdmlvdXJzIGFjcm9zcyBzdXNwZW5kL3Jlc3VtZSBjeWNsZXMuDQo+ID4+DQo+ID4+
ICAgQWR2ZXJ0aXNlIHRoaXMgYnkgYWRkaW5nIElSUUNISVBfU0tJUF9TRVRfV0FLRSB0byB0aGUg
aXJxY2hpcA0KPiA+PiAgIGZsYWdzIg0KPiA+Pg0KPiA+PiBUaGUgc3ViamVjdCBsaW5lIHNob3Vs
ZCBiZSBmaXhlZCBhbG9uZyB0aGUgc2FtZSBsaW5lcywgYW5kIGEgRml4ZXM6DQo+ID4+IHRhZyBh
ZGRlZC4NCj4gPiBPa2F5LCBnb3QgaXQuIFRoYW5rcy4gV2lsbCB1cGRhdGUgaW4gdjMuDQo+IA0K
PiAuLi4gYW5kIHYzIHN0aWxsIGRvZXNuJ3QgaGF2ZSBhIEZpeGVzOiB0YWcuDQo+IA0KPiBGcmFu
a2x5LCBpZiB5b3UgY2FuJ3QgYmUgYm90aGVyZWQgdG8gZG8gdGhpcywgd2h5IHNob3VsZCBJIHdv
cnJ5IGFib3V0IHlvdXINCj4gcGxhdGZvcm0gYmVpbmcgYnJva2VuPw0KT2gsIHNvcnJ5LiBEb24n
dCBrbm93IGhvdyB0byBhZGQgYSBmaXhlcz8gQW55IHN1Z2dlc3Rpb25zPyBUaGFua3MuDQo+IA0K
PiAgICAgICAgICBNLg0KPiAtLQ0KPiBKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBm
dW5ueS4uLg0K
