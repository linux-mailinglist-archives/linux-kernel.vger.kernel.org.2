Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C7306B25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhA1CiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:38:16 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:55010
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbhA1CiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:38:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goVRXgLOzuB7DzLBerabycYQl1GtzY2ax2sPJCKFBufpW1TbpaA1C0vSqUN4gK/KiRWnWRlJ6QoC4dw2NJMhunD8xY/+ZloqsFURFAne2GAduitCRw9yHMszok14v4tnDXMq4PIxY7ZuBA36wCbL5618d3vbi7ut6rgdADbfCRsFsplur8XGapaPhbjyowJQYsdFgdwoehBBBr2YTmsblbgWX9TfIusNvSVSt0ZKyTQZUr1vnvg57nKy17Ej1MNojI82ztBY7rxv7RopwBfgAGWbfvmsF2beNeb/8YwmbhtKzSQlwg+Y1Qet2hw/RqS1GuZgbZaIIuh3rFkdhlm9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvqTvNdUv7D3n2D3vesnEuBc1O25/+Q5UyswFi/QsB4=;
 b=V6U6afXVfXV8ZWK4XZ+0KI+Dyibz0Cr4tRn8FNH/rWejpcflTnONi3PvXxbpY1ZCiD6Vezm49nSGgv8vRRIzxuG6FpdRXJMyDE/QvyHGY5agr0SULcY58qZgXPu2b3CNV6NpMG4UINyQXHGDVAd5ImMI/aqrOvxhlP62pPZAKotLToYhysE2HYCOhTjUkKuirFMlGIAEHUwLoonNs0SuAA/FaAgQT5NrjeaMK7o2yzRFPZdKZbWHF2RcVWZqWUOz+wmL6axSiAh/gL4174y3KZ9pg3OlmhwmEa3ig/YUcIbrAFCHoMHx4gAu7Z9OeawYsqf4zoWvGxF5w3dz+KR1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvqTvNdUv7D3n2D3vesnEuBc1O25/+Q5UyswFi/QsB4=;
 b=k0Bz1vF60HgM6x3EMFe48FhZLJlekKw8mH1cm/2xc4Mpbr2TwIjXLQCzJYJoxQNk+85r3UH5obN0cb11iCX5qJF09pq71Vp9Lj1TIqqaRlmDtjg7xul6LlX6KIgirxLe9EN+ntbm3mURWo0JQ7ZdqlB8Rqkk7H5qEXhHi2TpcLE=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB6PR0401MB2440.eurprd04.prod.outlook.com (2603:10a6:4:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Thu, 28 Jan
 2021 02:37:22 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::7987:5db5:cd4c:7cd2]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::7987:5db5:cd4c:7cd2%8]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 02:37:22 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Marc Zyngier <maz@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [v2] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to remove
 call trace
Thread-Topic: [v2] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to
 remove call trace
Thread-Index: AQHW9R6ApPrmDACm9UKbj2CoepRiaA==
Date:   Thu, 28 Jan 2021 02:37:21 +0000
Message-ID: <DB6PR0401MB2438851F8196DA9C6EF8C3D48FBA9@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20210127085818.23742-1-biwen.li@oss.nxp.com>
 <a0c0cdaee31d49848525332deec6eb75@kernel.org>
In-Reply-To: <a0c0cdaee31d49848525332deec6eb75@kernel.org>
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
x-ms-office365-filtering-correlation-id: ec6e7d77-74cd-454e-06fe-08d8c335a3be
x-ms-traffictypediagnostic: DB6PR0401MB2440:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2440E4119A38C483429FCE71CEBA9@DB6PR0401MB2440.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dimcOfQKOWw4J1vKYSJvBCgh+4htNO8B2Bn3rD8b/YzovSSaA9PPmd7sBP9M+qbiJcV67V/VhB30LEhVZnTBiaHUoiY3b9BVvmuh19QOOSZkCha6WfsTO8dEDwH1BpYrXq0Bi3mi3j1mL7JavJhzFeEKJGITWovzCPxo2k6sB1fi+pRGL+gWpeRFauSxHphcTc+0FnIqrozk+n2O+6dVPfDnA4B++1Ao5S8df10o3cXEHT7NMs/2yuCxre0+B18lfxBw3/Iv5bptz8IejjGB7vMcp7sZeGCuqZk/xCZvFP0hNDm1GA2ONcoKYO/NgDmV672qCw6rxlUbAq7H7wsuhT258HCtByQul0ywINhEww8R1GgCKSPL14KEy+5HcWRxx+ZJPQwnES1iMHNVGJymc/QJYTyNdj2KJEllqjc0R261R44A6MoZWQT3PXaBV4mKCVM3zI5uQrb77ZDMkjpJW5xopXoEq0A0cZyUe82/MpPL7LKgWAFz+lTHX58367CVfKypJTDxVsld9xq2gq9IXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(54906003)(66476007)(5660300002)(64756008)(66556008)(66446008)(26005)(55016002)(71200400001)(4326008)(478600001)(2906002)(8676002)(86362001)(110136005)(9686003)(186003)(33656002)(7696005)(83380400001)(52536014)(316002)(76116006)(8936002)(66946007)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?K3E2WExtN0JCbnB0UmY3MkNLem1DQkh6NEcvbU5lNEpQamNLMEcva2NNRnVq?=
 =?gb2312?B?S1ViZnVRMlY0ODh2M1FsMjIwajhGWHdwckdiMHljUTA0My9pM1l1K3h6Qnhk?=
 =?gb2312?B?ODZRMURGaEF1ZE9FUFdzYytCY29tRVRxSVBvTkVGQzlOUkNEUjlaeFVROVdY?=
 =?gb2312?B?U2RLTHRZemxkK05oN0x5dUR3bFpNL2NEMVZxWnZ1R3pVNllDZ0lrQk1ocXNq?=
 =?gb2312?B?WVBub3ovbjZmdkx6cmVlaW5SUXFqVEFhak85YytqaVZ2OE5kVVFrZWt1Z1hJ?=
 =?gb2312?B?a3ZVRHh1M3NvVENMVXpES0ZqVEMyeWtDOXliNlp4TXZXVUVsQ0l6SmZiVnVn?=
 =?gb2312?B?c2w4VGJZTzB1UHRhc2ZFTFI0MUlwVWZxNityM2FQS3FRTnZsRVJ0ODRHZjR5?=
 =?gb2312?B?YVZIY2R3SDVNR2tjV1Q1NlB2bFRvaEpjZnc5VnBSR1hpL3pmTGhNNXZBc1lt?=
 =?gb2312?B?MFZmaXNZQmpWeW5kZzB5VUU5OEhSV0dhL1dqb1N3c256TElyeW1PalVrVGwy?=
 =?gb2312?B?Qk5QOWJsclo4dmdWZmZQZ3pZRytvVS85K3JROGV3QVNNNVpYdWpoeWIrZlYv?=
 =?gb2312?B?SFhKdUQyRU1la1o1d3phQXkyK1J6aWdOTVJyWUJZd2JuYVZlWUpzbDUvL1Zk?=
 =?gb2312?B?SGx3QkJMS0FHcGRoMmNOYk9OdnZhV3B1YVJRZDF3bDlydktsVDA3TnozeTFQ?=
 =?gb2312?B?NjRKbEQyTis4RFJTNDJjTkN0UkNxR3RxdzlFa1ZJeS9Nd2NnTFBvMWMramVI?=
 =?gb2312?B?TjJVQ1NIUWswNU5oUkM0YnZONGdTY3BtZWtXR3FualdqZVY1ZUUrbXdEQ3NX?=
 =?gb2312?B?ZDlNdUVOYnhwbElOZU5qUFFWRm9EQnRlbUhKdGdlMkh0bDBwQ3EvT2FyV3Jp?=
 =?gb2312?B?MDBlQStBb2t6MmEzWUFEYlIyRHRHem1tUHpNY2QwdEVjNkZkQm0zZ1NvMm1w?=
 =?gb2312?B?bFBDU3hBSWhmcGhscFhncTBsSXRaUDA5SkNkYlhKNUkydkdWRTdPYWkrYnl4?=
 =?gb2312?B?SGtEaTBVU0ZSUm45bDBzVmIzMmdTcEdaSzY0RUd1c0Z1bURtMFFYSlNnT2FW?=
 =?gb2312?B?SEhOZGNoY0w4MC9XZXUvdkxFK3IrZXVXMGlxaVY5SGlhcU0wSnEwUlpFeWFK?=
 =?gb2312?B?dTU0K0J0UzFPcG93NzF3aGxIeGZUT05zZ0RFeUZ5ZXZnTEh0RnJKUjJkSkFu?=
 =?gb2312?B?Y0NxSnFVNW5wdEdnY2tYUG5CMVQ2dEZuZXk2QXJkM1o0QlJ5Y2c0Q1Vrb0xZ?=
 =?gb2312?B?aEMyY3FJUkw5ZXh3ekQ5Rzg1ckhpeWFGaXllK0JPY2k5aGVNS2hnYjFVaXB6?=
 =?gb2312?B?enYyY2FTK3hFaEVhOTNKVWxmME5sY3dtbzdJclpjSGZKRHMwUm10RTFSQnNW?=
 =?gb2312?B?Y1oyREF5eTB0dFNQSllWblpydndsWkVITXRsWDlwc2hJK2cyTGgrN1V3L1Nt?=
 =?gb2312?Q?63M9z0AK?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6e7d77-74cd-454e-06fe-08d8c335a3be
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 02:37:21.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8n0KCBJ+q9IpIuDFmtWDQyPihm3aw+ZUiOukHra5N7x5J0SqLH+iUbKUHRBT/a4wM7050xZ1rmdrzMT4dM1qfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2440
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBaeW5naWVyIDxt
YXpAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyMcTqMdTCMjfI1SAxOTozOA0KPiBUbzogQml3ZW4g
TGkgKE9TUykgPGJpd2VuLmxpQG9zcy5ueHAuY29tPg0KPiBDYzogbWFyay5ydXRsYW5kQGFybS5j
b207IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBq
YXNvbkBsYWtlZGFlbW9uLm5ldDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmlhZmVp
IFBhbg0KPiA8amlhZmVpLnBhbkBueHAuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBSYW4gV2FuZw0KPiA8cmFuLndhbmdfMUBueHAuY29tPjsgQml3ZW4gTGkgPGJp
d2VuLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbdjJdIGlycWNoaXA6IGxzLWV4dGlycTog
YWRkIGZsYWcgSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHRvDQo+IHJlbW92ZSBjYWxsIHRyYWNlDQo+
IA0KPiBPbiAyMDIxLTAxLTI3IDA4OjU4LCBCaXdlbiBMaSB3cm90ZToNCj4gPiBGcm9tOiBCaXdl
biBMaSA8Yml3ZW4ubGlAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBmbGFnIElSUUNISVBfU0tJUF9T
RVRfV0FLRSB0byByZW1vdmUgY2FsbCB0cmFjZSBhcyBmb2xsb3csIC4uLg0KPiA+IFsgICA0NS42
MDUyMzldIFVuYmFsYW5jZWQgSVJRIDEyMCB3YWtlIGRpc2FibGUNCj4gPiBbICAgNDUuNjA5NDQ1
XSBXQVJOSU5HOiBDUFU6IDAgUElEOiAxMTI0IGF0IGtlcm5lbC9pcnEvbWFuYWdlLmM6ODAwDQo+
ID4gaXJxX3NldF9pcnFfd2FrZSsweDE1NC8weDFhMA0KPiA+IC4uLg0KPiA+IFsgICA0NS42NDUx
NDFdIHBzdGF0ZTogNjAwMDAwODUgKG5aQ3YgZGFJZiAtUEFOIC1VQU8gLVRDTyBCVFlQRT0tLSkN
Cj4gPiBbICAgNDUuNjUxMTQ0XSBwYyA6IGlycV9zZXRfaXJxX3dha2UrMHgxNTQvMHgxYTANCj4g
PiBbICAgNDUuNjU1NDk3XSBsciA6IGlycV9zZXRfaXJxX3dha2UrMHgxNTQvMHgxYTANCj4gPiAu
Li4NCj4gPiBbICAgNDUuNzQyODI1XSBDYWxsIHRyYWNlOg0KPiA+IFsgICA0NS43NDUyNjhdICBp
cnFfc2V0X2lycV93YWtlKzB4MTU0LzB4MWEwDQo+ID4gWyAgIDQ1Ljc0OTI3OF0gIGRzMzIzMl9y
ZXN1bWUrMHgzOC8weDUwDQo+ID4NCj4gPiBPbiBsczIwODhhcmRiOg0KPiA+IEluIHN1c3BlbmQg
cHJvZ3Jlc3MoIyBlY2hvIG1lbSA+IC9zeXMvcG93ZXIvc3RhdGUpLA0KPiA+DQo+IHBtX3N1c3Bl
bmQoKS0+c3VzcGVuZF9kZXZpY2VzX2FuZF9lbnRlcigpLT5kcG1fc3VzcGVuZCgpLT5kZXZpY2Vf
c3VzcGUNCj4gPiBuZCgpDQo+ID4gLT5kczMyMzJfc3VzcGVuZCgpLT5lbmFibGVfaXJxX3dha2Uo
KS0+aXJxX3NldF9pcnFfd2FrZSgpDQo+ID4gLT5zZXRfaXJxX3dha2VfcmVhbCgpLCByZXR1cm4g
LUVOWElPLCB0aGVyZSBnZXQNCj4gPiAiQ2Fubm90IHNldCB3YWtldXAgc291cmNlIiBpbiBkczMy
MzJfc3VzcGVuZCgpLg0KPiA+DQo+ID4gSW4gcmVzdW1lIHByb2dyZXNzKHdha2V1cCBieSBmbGV4
dGltZXIpDQo+ID4gZHBtX3Jlc3VtZV9lbmQoKS0+ZHBtX3Jlc3VtZSgpDQo+ID4gLT5kZXZpY2Vf
cmVzdW1lKCktPmRzMzIzMl9yZXN1bWUoKQ0KPiA+IC0+ZGlzYWJsZV9pcnFfd2FrZSgpLT5pcnFf
c2V0X2lycV93YWtlKCkNCj4gPiAtPnNldF9pcnFfd2FrZV9yZWFsKCksIHRoZXJlIGdldA0KPiA+
IGtlcm5lbCBjYWxsIHRyYWNlKFVuYmFsYW5jZWQgSVJRIDEyMCB3YWtlDQo+ID4gZGlzYWJsZSkN
Cj4gDQo+IFRoaXMgaXMgYWdhaW4gcGFyYXBocmFzaW5nIHRoZSBzdGFjayB0cmFjZSBpbnN0ZWFk
IG9mIGV4cGxhaW5pbmcgdGhlIHByb2JsZW0gaXQNCj4gZml4ZXMuIEhvdyBhYm91dDoNCj4gDQo+
ICJUaGUgbHMtZXh0aXJxIGRyaXZlciBkb2Vzbid0IGltcGxlbWVudCB0aGUgaXJxX3NldF93YWtl
KCkNCj4gICBjYWxsYmFjaywgd2hpbGUgYmVpbmcgd2FrZS11cCBjYXBhYmxlLiBUaGlzIHJlc3Vs
dHMgaW4NCj4gICB1Z2x5IGJlaGF2aW91cnMgYWNyb3NzIHN1c3BlbmQvcmVzdW1lIGN5Y2xlcy4N
Cj4gDQo+ICAgQWR2ZXJ0aXNlIHRoaXMgYnkgYWRkaW5nIElSUUNISVBfU0tJUF9TRVRfV0FLRSB0
byB0aGUgaXJxY2hpcA0KPiAgIGZsYWdzIg0KPiANCj4gVGhlIHN1YmplY3QgbGluZSBzaG91bGQg
YmUgZml4ZWQgYWxvbmcgdGhlIHNhbWUgbGluZXMsIGFuZCBhIEZpeGVzOiB0YWcgYWRkZWQuDQpP
a2F5LCBnb3QgaXQuIFRoYW5rcy4gV2lsbCB1cGRhdGUgaW4gdjMuDQo+IA0KPiAgICAgICAgICBN
Lg0KPiAtLQ0KPiBKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLg0K
