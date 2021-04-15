Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F09035FFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 03:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhDOBda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 21:33:30 -0400
Received: from mail-vi1eur05on2085.outbound.protection.outlook.com ([40.107.21.85]:24183
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhDOBd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 21:33:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2sKqma/l+U/UY86/NysH6Ld/2N8UWuXzuSiafn3N9GE7qT1r9oCvzGneRICMbOopG/8o/eZWaa0jYhvkLu6aDjc4fPAKU7HzTcTsNzA+KsLwPNYTJhO8CHBqQXvApOUHEH0fnSIkwmgPcblGlNDrwvEy3dDFR6ZoD+gDaX3duykd/DKhfnoTqYxpn7nagHGXnaHJywK2/OwO8HTaX9CYdKggmRIbJ6rpzLEwWD8Uio6EswaRwIS4a26DfOBy4yXCpPEouPbRJd/n918YBM2PqgKL5+SO0qseHvQJaqj9wEjSCna0RY4kYeTcII14ZN6mDyu/N8WpXv3Js60bPdbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmbxJuX+TBGX/z12Ab1UWRQbrCSlg+6NGaGc/yfUvt4=;
 b=lXsKagOatFxkun2N00uTXLLPNaq7cYoPXaeOmT6s+foiXbaAeTlrXiz/XQgM++iKSmn+EJXuLVFN1Ke+toGFv0Vp/IkNH/1xCHVDK4t83B2/bz+wnc39gIFQ8GmGuImX3C+1P2DTzHZEtnpeDKjZIrRHN022an1OxdeiXCjvF+EngQ3gGLnzEmxteOVaPC7fw+wfjfkwjzz+moSnTGVdylPyEo1CKUWJH/0d4FQdqwD8DTNMatV8YOWMbbbKQgsaagPmpE3Y2iNrZqDXwGrlwAL5dbLFA/nfKogTJLNfXa/CJo39voummnHB0W9XgN37lxK9PxgxdE/Rph3GKh5PoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmbxJuX+TBGX/z12Ab1UWRQbrCSlg+6NGaGc/yfUvt4=;
 b=M/AJ/p/PMuW5IELUBW0/v95jmff4xu++hB+xCiLYjXCDZQB5LWOE76Qyc4Po9BMBgH7e+sGFh81zPbbIbn2UxT0aZDeWsLR7ySAC+w9J/YKn2QuXETc6S380mxXzyxEdzajdAvE0JFxD9RFUt/NAKyc2EOapvbHNmln/kGpg35Y=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6715.eurprd04.prod.outlook.com (2603:10a6:10:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 15 Apr
 2021 01:33:02 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c57a:6964:f72c:21cf]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c57a:6964:f72c:21cf%11]) with mapi id 15.20.3999.037; Thu, 15 Apr
 2021 01:33:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] regression due to soc_device_match not handling defer (Was:
 [PATCH v4 4/4] soc: imx8m: change to use platform driver)
Thread-Topic: [EXT] regression due to soc_device_match not handling defer
 (Was: [PATCH v4 4/4] soc: imx8m: change to use platform driver)
Thread-Index: AQHXJHswagdgP8ehpke2zJrKT8ygB6qb02GAgBkQygCAAABgAA==
Date:   Thu, 15 Apr 2021 01:33:02 +0000
Message-ID: <DB6PR0402MB27607D28703D8C3E614E2F2A884D9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20201120101112.31819-4-alice.guo@nxp.com>
 <YGGZJjAxA1IO+/VU@atmark-techno.com>
 <AM6PR04MB60536EF0DEEE6EB64CF29390E27D9@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <YHeWnuDQo76rYoz5@atmark-techno.com>
In-Reply-To: <YHeWnuDQo76rYoz5@atmark-techno.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: atmark-techno.com; dkim=none (message not signed)
 header.d=none;atmark-techno.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ad55a0f-0c48-4cfa-e284-08d8ffae6941
x-ms-traffictypediagnostic: DB8PR04MB6715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6715305A4AAE629342DD4874884D9@DB8PR04MB6715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8QapueMQ4JNe+4A0WvdCBnaXoJ6PBqdb5uGBffuKaWqtQSYrOFvyh92+q/gwf5M2bQfzKkZ6ezKXR0KCOGBjNY3pKJF8iOFaRodHRuYobWL4LP3anRx8vbH4QIGzx5kXHahYty1l/Q0tUVIsnpT+yK/U3/EaUR3KEcJ0sFkcdIO/LFmQmEr8DI/MrieZVBugZsK37A0srUz8FvWPf6ntZovAVPSnSdzbQbMWKJbW4Sf1JSlbA4zmhiF+Vrxm772Db1rPWytp0Yiy497/YF1oq0ErTh/+1RWcsDRSr5u6KmewUGIsN5W9kx+bfVbaEnZTqWAKxL7hTUAKIhgd/XZtNeR1OtlNiYaJqS1KGOkRQPkkBltb/oZBInbSDq8pg9+3XTIkhh4VNrAYalER9/MvWAs/hteoYbP7PKk53HfTdqPT0nsb1TawOX1Vf1tu0uOSCPsBjCCB9NwJBmfcbxVUsrypOd0rPy15CKfjdFLLEbh5HQm49nhA6N3mODnB57xoax3kLwgzSFlA0Jx81Ov0GRsaY8gfLtWWu5KSI8lFMnaMoyakbRoNxsVDryb+JkyWgS7oEBnRDgUH+P06GZJMPRQLaVXeQOK7uLNe7DStAPpp/G8+FJQvjsl6SNJA0oSPYTWbabpmeb6lXGFGTEi1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39850400004)(366004)(316002)(4326008)(66476007)(186003)(64756008)(478600001)(66446008)(66556008)(66946007)(76116006)(55016002)(2906002)(110136005)(9686003)(26005)(122000001)(6506007)(71200400001)(86362001)(38100700002)(8676002)(54906003)(7696005)(52536014)(33656002)(44832011)(8936002)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VFUxSjRVTDFCT3dMbmhjcUxVdUpxOUlTdTQ1cHFyVHV4S2N0cW9MTjZFZ1VE?=
 =?utf-8?B?MXRFMnplWHVOdzNnTTRNNFhZOVlNUFBqVU9KanJPbU95RERRdlV1ZjJMQWZ3?=
 =?utf-8?B?TXNjdGZaS0M3bE5SaVZZNDJaemdYQVlNNUV3UXRLNHhBRDRFc0NkY1Z0a2dt?=
 =?utf-8?B?bW5obGxSRlhwdkhKQWJTclZnd3hDbE12ekthd25zU000U2lqMmh0UXpmWVJT?=
 =?utf-8?B?MGorSHNRdUYzOVBlcDVmRHFwZGJjWkhsblI0a0ZIdXhFYmtlbDVIK2t4eGMz?=
 =?utf-8?B?ZjRodUowN0NDWTVWTXpyUlRRN0UyNnVaZ0lrVlZtVmNWSklOMXkrTnNKUUx4?=
 =?utf-8?B?RGtsc0l5MmhhUEJCM1FlSG5Uc1RiNW5QMTN1bmw0ZDlQOTdJeHVSd2hwTmFC?=
 =?utf-8?B?V1ZzdlBDbldHNUpaNzhOMGFnb0xrSHZQTzFScG5DWnB6OXBFRnJKbk9pdlJa?=
 =?utf-8?B?L2JBb2MxSGpRaHVJRzMxNlpkd0pEN08xZSthOVRhdThaQWtNUnJRYnIrbVF3?=
 =?utf-8?B?c2thLzJSWjVlVVk4MXhidlhoWWJFUFprNnc5dThlaWtXMUpwZldiZWpQQTlD?=
 =?utf-8?B?NG9qUm1nNDM1bzJWVlRTd08wdjJGNkFmL1RvUHJuQk51WjFnZGxTazFWTzlr?=
 =?utf-8?B?ZzRIVUtNMUU5UXZTR2FkdFBxanRDK3JGOGdoKzcxRVoxZTBkNVRERndqL2ZP?=
 =?utf-8?B?a1hxdG15ZDdhMTA1ZnBiQSt2dk5UcXpmbUMyYkhLR3VOR2orNXd4Vm9TN2Nj?=
 =?utf-8?B?Y3FCSVFNbDRKV3VBeTJGOEdsanROdFp4QXJWU2U5U0JJVVVva2JYa2V4SGt6?=
 =?utf-8?B?d3pEdlBDLzdnd2JTbFpHZ0FVSXlvb09TUWluQVlLNVZiQU5qQVpPMTFaVTk4?=
 =?utf-8?B?eG8yV0Z0SnpjZllJUVZ3bW1DWUsweG5odXNBWEZNSDRIdEFOVjdUUFZUWkty?=
 =?utf-8?B?UGNvUkg2QXF6eXlYNUtWTXU5anZDcGVMenVzOUZLdFVxSy9Xbzc4eGVES0Nw?=
 =?utf-8?B?V0grNVpBTnJUY3ZFVVFncjZJTUZyMnQyVHBvUkZhNGx6V3FGVlpmVTJPeHFB?=
 =?utf-8?B?eUUxOEZZRHhpcTUzZHVPR1RwNWpQS0ZPQWlSQ3dYYUNnVFlJNDJoS2tRdGVz?=
 =?utf-8?B?V3dQeENESTY0U0ZLNE12bE5TSlVjT0VTZDZSM2kvMHZEOGxjVGt1NTVST1lr?=
 =?utf-8?B?b3RYU0xZb2N6Sis2bWxMR2pHZEtNVStGMWpGVFcvRUo3eGdUZU13NnVJTGFz?=
 =?utf-8?B?dnpiN2F5QUpXODhQNFdNVCs1eXI2ZHN3ZmE3WjZwQ2FxQlFYYnNNTit2VTF1?=
 =?utf-8?B?V0ExWWZKb0xiVWEvRklOTFVKWm9zUWREREY0dGtQcEtrZmhNaE5tRlo3V2xL?=
 =?utf-8?B?akxnM1dIT0l2cE1UTFQyZUVHQnU0MDV1TmpCRTB5a3dEc01FYmNudFl1VklY?=
 =?utf-8?B?NVN3MTFQK1BQdW1uZTQxVjVzZTNxb25sMUVGdmJaZmZ3dFA5QVU0cGloT3By?=
 =?utf-8?B?c2h2TTQ3K3Bacm9naEIydUh1dXM4VVpDbi8xRmpobWNwU1U4ZUx3Z21FSkFM?=
 =?utf-8?B?SEdnbCtCL2x6bGorQ0tuTU5PbFA3Wk1jTitDT1ZJcHUzV1NKTDRic2JWSWxT?=
 =?utf-8?B?Qk1tSUx1b3ljcVZaa2hjamxYT3FSR0JCZk5hVzhTOGhxRHZPdzA3dGZrYzJa?=
 =?utf-8?B?c0lMSWkxNXh2TE1BTml0UXNCQ1hqWDVPbno5cWdITy84NU9pOUdiTjBjQWxx?=
 =?utf-8?Q?PFhSp97hgslpfbXOGB0ochHilMgHWvJGsaybLpP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad55a0f-0c48-4cfa-e284-08d8ffae6941
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 01:33:02.6523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVwui+QhnY3W3E7xlpd6rHhIcWYn3zMtFXfE1ugin/0irUbZEaoJ9M+/XJDubmsSd3JfxklgD5MjZYAMHwugQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6715
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAoV2FzOiBbUEFUQ0ggdjQgNC80XSBzb2M6IGlteDhtOiBjaGFuZ2UgdG8gdXNlIHBsYXRmb3Jt
IGRyaXZlcikNCj4gDQo+IEFsaWNlIEd1byAoT1NTKSB3cm90ZSBvbiBUdWUsIE1hciAzMCwgMjAy
MSBhdCAwMjo0MToyM0FNICswMDAwOg0KPiA+IFRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMgaXNz
dWUsIEknbGwgY2hlY2sgYW5kIGFkZCBhIGZpeCB0byBoYW5kbGUgZGVmZXIgcHJvYmUuDQo+IA0K
PiBJIGhhdmVuJ3Qgc2VlbiBhbnkgZm9sbG93IHVwIG9uIHRoaXMsIGhhdmUgeW91IGhhZCBhIGNo
YW5jZSB0byB0YWtlIGEgbG9vaz8NCg0KV2UgYXJlIHRyeWluZyB0byBmaW5kIGEgcHJvcGVyIHNv
bHV0aW9uIGZvciB0aGlzLg0KDQpUaGUgcHJvcGVyIG1ldGhvZCBtaWdodCBiZSBtYWtlIHNvY19k
ZXZpY2VfbWF0Y2ggcmV0dXJuIHByb2JlIGRlZmVyLA0KYW5kIHRha2UgZWFybHkgc29jIGF0dHIg
aW50byBjb25zaWRlcmF0aW9uLCBidXQgSSBhbSBub3Qgc3VyZSB0aGlzIHdvdWxkIHdpbg0KbWFp
bnRhaW5lcidzIHZvdGUuDQoNCj4gSWYgdGhpcyB3b24ndCBtYWtlIGl0IGZvciA1LjEyIChpbiBh
IGNvdXBsZSBvZiB3ZWVrIHByb2JhYmx5Pykgd291bGQgaXQgbWFrZQ0KPiBzZW5zZSB0byByZXZl
cnQgN2Q5ODE0MDVkMGZkICgic29jOiBpbXg4bTogY2hhbmdlIHRvIHVzZSBwbGF0Zm9ybQ0KPiBk
cml2ZXIiKSBmb3Igbm93Pw0KDQpQbGVhc2Ugbm8uIFdlIGFyZSB0YXJnZXRpbmcgYW5kcm9pZCBH
S0ksIG1ha2UgZHJpdmVyIGFzIG1vZHVsZXMuDQpBbmQgcmV2ZXJ0aW5nIHRvIG9yaWdpbmFsIG1l
dGhvZCB3aWxsIGFsc28gYnJlYWsga2V4ZWMuDQoNCkkgYW0gb24gSVJDICNsaW51eC1pbXgsIHdl
IGNvdWxkIHRha2UgbW9yZSBpZiB5b3Ugd291bGQgbGlrZSB0by4NCg0KVGhhbmtzLA0KUGVuZy4N
Cg0KPiANCj4gDQo+IA0KPiBXaGlsZSBsb29raW5nIGF0IHRoZSBjb2RlIGVhcmxpZXIgSSBhbHNv
IGhhdmUgYW4gdW5yZWxhdGVkLCBsYXRlLXJldmlldyBvbiB0aGUNCj4gcGF0Y2ggaXRzZWxmOg0K
PiANCj4gPiArc3RhdGljIHUzMiBfX2luaXQgaW14OG1xX3NvY19yZXZpc2lvbihzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ID4gWy4uLl0NCj4gPiAgQEAgLTE5MSw4ICsyMjMsMTYgQEAgc3RhdGljIGlu
dCBfX2luaXQgaW14OF9zb2NfaW5pdCh2b2lkKQ0KPiA+ICAgICAgICAgZGF0YSA9IGlkLT5kYXRh
Ow0KPiA+ICAgICAgICAgaWYgKGRhdGEpIHsNCj4gPiAgICAgICAgICAgICAgICAgc29jX2Rldl9h
dHRyLT5zb2NfaWQgPSBkYXRhLT5uYW1lOw0KPiA+IC0gICAgICAgICAgICAgICBpZiAoZGF0YS0+
c29jX3JldmlzaW9uKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHNvY19yZXYgPSBkYXRh
LT5zb2NfcmV2aXNpb24oKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGRhdGEtPnNvY19yZXZp
c2lvbikgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChwZGV2KSB7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzb2NfcmV2ID0NCj4gZGF0YS0+c29jX3Jldmlz
aW9uKCZwZGV2LT5kZXYpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gc29jX3JldjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQg
PCAwKQ0KPiANCj4gSSBhcHByZWNpYXRlIGN1cnJlbnQgc29jX3JldmlzaW9uIGFyZSAic21hbGwg
ZW5vdWdoIiAobG9va2luZyBhdA0KPiBpbmNsdWRlL3NvYy9pbXgvcmV2aXNpb24uaCB3ZSdyZSB0
YWxraW5nIDwgMjU2KSBzbyB0aGlzIGFjdHVhbGx5IHdvcmtzLCBidXQNCj4gd291bGQgaXQgbWFr
ZSBzZW5zZSB0byBlaXRoZXIgbWFrZSBzb2NfcmV2IHNpZ25lZCwgb3IgdG8gaGF2ZQ0KPiBzb2Nf
cmV2aXNpb24oKSByZXR1cm4gYSBzNjQsIG9yIGhhdmUgdGhlIHJldmlzaW9uIGZpbGxlZCBpbiBh
bm90aGVyICp1MzINCj4gYXJndW1lbnQgdG8gbWFrZSBzdXJlIHRoZSBlcnJvciBpcyBhbiBlcnJv
ciBhbmQgbm90IGp1c3QgYSBsYXJnZSByZXY/DQo+IA0KPiBUaGlzIGlzIG1vc3QgZGVmaW5pdGVs
eSBmaW5lIGZvciBub3cgYnV0IHRoYXQga2luZCBvZiBjb2RlIHBhdHRlcm5zIGNhbiBsZWFkIHRv
DQo+IHdlaXJkIGVycm9ycyBkb3duIHRoZSByb2FkLg0KPiANCj4gVGhhbmtzLA0KPiAtLQ0KPiBE
b21pbmlxdWUNCg==
