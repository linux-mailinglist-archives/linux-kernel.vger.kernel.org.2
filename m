Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19324324C10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhBYI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:28:55 -0500
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:48075
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235794AbhBYI2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:28:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuoWQOKLyQBJLXQqcY/H16h4q/ad5UCQp9rlUIAATwv/J0H6z0rrMl7F7YBukKRDK4T8lpByenX3YV+KWtyTQO8u6WjXQX6n59BA7/q6kwTFFhDJxKSsQA39cIaeFUc5h1A0bEr0fgSi+XKqZbIrDH2C4AzxEOEEGiIEZ8j8hfRCuvySClfb7cjP8dUaIa43WgaGl2aGQh2i1B33hj9MhV+nGgyc9EQjtGj41KobCoX1y7UySKQ9/mgHi5mGDA2hdLjXHbiCUKygZJ2M5/V6WSEzDMBDGGnhdopvu8x/xPsow1KxtxlJiysqARy/2fwBvkZiM+HsRxOAdGjMe8u+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ynp7vXfP76pDbFwH/GwGrGUOCaKRRjfm4s5f1Kfz8R8=;
 b=lc9ycwDlFHobB4DbHbmr5LO2+1gAndUM6jZtElSpPSzH1vV32tS6Fozei0MoesNrARniOaN9E9cTVF8+1eCgJ4vjAbMJCz5btLlxDJUPyUR/bwYsmrH6V+eRs4czKExLI9uzNWwt6Tkx31SOk42KcSd4zZy0HzyZ8ah3cEcN6PvAKGeEQII4pc20NcZs2UdfgMfT6nihz+29hyxxD1qneyRObPWmQGPUgNJiRVeVaD3mEr9Dpwc0bdDX7IZS6EF+fbBgrfQGCInAIT9YIxU5nTsQdNrmipSlmmOu5ZFThhKpyFYd33a9WdrkfSObK/0rOJXSXJvEI1J7OLqtnHE1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ynp7vXfP76pDbFwH/GwGrGUOCaKRRjfm4s5f1Kfz8R8=;
 b=cNcNAMaG42OkGB0MXJqCry7/KRdzak/7MMvdxaDxOyHaocw4l6NCnptq0Gyu+6DOUiLJe1hND2OWWzJRieU7lNu+Euo2c5huwbBCd0Mv2Mvz0iRlxpNhRPcU2xGrllTLT/PwUDnJSQp7Vkd24Yig7uHxcGV0Zgn5YcAk4gCB0m0=
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 08:27:49 +0000
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::d4c5:ce2e:d24d:ac92]) by DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::d4c5:ce2e:d24d:ac92%6]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 08:27:49 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <dongas86@gmail.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: RE: [PATCH v5 10/14] clk: imx: Add generic blk-ctl driver
Thread-Topic: [PATCH v5 10/14] clk: imx: Add generic blk-ctl driver
Thread-Index: AQHWsdMtW7/mWMYbfES8MUsWPsLRJ6nCsiuAgAnLmQCAnL2OgIAAADtg
Date:   Thu, 25 Feb 2021 08:27:49 +0000
Message-ID: <DBBPR04MB7930D839D5595BB692CB26DA879E9@DBBPR04MB7930.eurprd04.prod.outlook.com>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
 <1604402306-5348-11-git-send-email-abel.vesa@nxp.com>
 <CAA+hA=TfyW6Ya9adcQFd1=-sJyoCgMyaENmGumtV1ZYar1Ud2g@mail.gmail.com>
 <20201117144828.omlwhu5y7cwsf5ci@fsr-ub1664-175>
 <6ecf593d-bee6-b0c1-718f-edcee90650ad@kontron.de>
In-Reply-To: <6ecf593d-bee6-b0c1-718f-edcee90650ad@kontron.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kontron.de; dkim=none (message not signed)
 header.d=none;kontron.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44ba7e53-169c-43d0-0965-08d8d9673c87
x-ms-traffictypediagnostic: DB8PR04MB7177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7177853FBE2412FB91983C01879E9@DB8PR04MB7177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGfzWTGivm6h3iwZ+RoD62+6jpLZHJfCVGqrpD7ROw+p+lUILOdom96OPZxvkK0D33ARBjM5HgkYGUp3ZSHI3Nw8Ew1t9U9RJ6hG6p5QqtQ3moW6IICi61T7SYXY3zgSBoTroA5a3F306CpwTyanlJYRrGCPa6arz58ueFeaOeb8qsEXHSSzhwQns6bkyi0XDKD72RuuC9q09E+RgII9wz/+CmMhcFAPk11yev+P/+i0H9Xg5HNKQeusSpK7S7HxbpIFdqiXKP2ETf4GlOMaE2PEBuYwGwE1dNGHFqe588elO4glxuZ7SAROTGCpxPIACNSqRDLmslC+J+aKBBYfuOmkW+yNEJ8ukddtQYdQlBtTjGC1TlZAUNjbxsJPLTmyFE4MCU9BMnS7MwMEGUDrxDNKvvoLpB4nrCqhatWDU910nd3/bQwf/wiAUawvQBIvmND07LDcuazCoNhY5bvKhaJM00ss/rvxqJwpcqCPqwwxvClVhxOitkvidN1ZzAGt7XivuZIz6FkDHRPdRIQj3htly7iRhlQHwW8BA/GQegIm1Re7qHcLcoEMDBIzNwwt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7930.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(66556008)(7416002)(52536014)(66476007)(5660300002)(186003)(86362001)(76116006)(110136005)(66946007)(2906002)(64756008)(316002)(478600001)(66446008)(54906003)(7696005)(71200400001)(9686003)(33656002)(8676002)(4326008)(83380400001)(53546011)(55016002)(26005)(6506007)(8936002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YlA5dmh5RFlNWUdUNWFFQXkwZHJWSzFLV0NydTE1T3pNTWV3SmQrZjRWWTQ4?=
 =?utf-8?B?dUpvdjJqclVxcE9MRUdsMjMyanl2eGE2ZE9wcVRUVXZ0dGlCNVJNdnNNOUtC?=
 =?utf-8?B?WEZFVFI3M3VxZThvRzJ4Q3JOcXU5RUxWdWsyeHNockpSQ2daQ0lFZ2pzRWJ0?=
 =?utf-8?B?cXJ1OTZRYmErZ0JZcVlXMm5NUlpiVjk1WlU3b0sycEpQQXI1VVNuVGdBN3VD?=
 =?utf-8?B?UWp1QmJleFVYYmxZbElKTTRPZWYxYnBOTms4QkxHWmpwZVU5RlJDR0xiMG5N?=
 =?utf-8?B?VGxRa2cxVERzY2MyYXNIRGk4c2JaTTZJSngrQlZGZ2dNS2QvVmFCYkpaZ2lq?=
 =?utf-8?B?SEFKZ3h4emhPUUZZTkUxVGpNUmJwRXFLdDNGUUpycEplUVlJUld5RXIzVkZk?=
 =?utf-8?B?ODNWTzRxYVp6bEIvOUR1UEFIVzhCY3poWGpoeUlUNWdhdmpRZWdnWHNCbU1Q?=
 =?utf-8?B?RnZibTBjbGpNb3RlMWY3Z1F4cndQSU8rMFNLZmlibnpaK0ZIVEcyWUFGOElp?=
 =?utf-8?B?S2lVTVlHc05KU09pcW0zT282R3YxaksyelFqK0trcGlUS0lPZUwxS2FHQjRx?=
 =?utf-8?B?cWh4MkJyaEFjeElsL09NSm9ncUF2U25XejZVMXZzMFFHRXdJek4xWVdycmo2?=
 =?utf-8?B?Uk80V2x1aDQ1UVlMbnJ1MFk4Nk12eDFSY0hWbll3U283WTRFMGZQTkFROVhB?=
 =?utf-8?B?Vkl0em1NSG5MVE0wVngxc2tQaEpQdjJEUFJ2SWgzQmxVdmZDOFozelFOL0FE?=
 =?utf-8?B?czFhQThieFZ5NVp6SStmM28vdGdkLzlnakVnMGtNaGdCbmM0eHU0UCtLUEg1?=
 =?utf-8?B?Vm1Pb25uZGRoT1dMejcxTUdyUzhYVmNiU1VIUU0rMm91b0twVlcyVWlQcVZo?=
 =?utf-8?B?bUVIMi9JczV0QjJzd2tqSnR5NXora0NGTGRlL0w2RnBVdlJZVjRjZjFhYlFv?=
 =?utf-8?B?Y085M2ZxYmhiQzlWeHc4TCtVcGZEcFFPdmh5MVR4bUtUTHIyemxRbjhDbXB5?=
 =?utf-8?B?UzJ1eDh1YWxTdVRLYkVkZmtvdHVUVXJkdEhOeTd0RHlBS2YvL0cwdWltK0lJ?=
 =?utf-8?B?b1lXTkNvVWNxNS81aHJHc0lhU1gzZUYydEhGaU1mOWxGSThNUkg4cGlUS1FY?=
 =?utf-8?B?VytyaGl5TGFpcVBEUk9Pakd3Y240Wm1VV2FzQ2VSU09rSzU5TW1Ld3JzVSs0?=
 =?utf-8?B?S3VIUSs5ZVltZkk4bGhkS1BRZy9tYjQwUkZTR1BEVStrcDhkaEVSRzE2MUdi?=
 =?utf-8?B?SmYzSlVSTE5KS2ZRSTNkN2poNE1uQUo2Q0pWS1draHE3WW83ZExlbHRnWGo0?=
 =?utf-8?B?TDh6M2tBUXBoa0pjYjRtZDZzSmJneFFHaXVhQ1NsbThXa1VKb0NCOGRKL3ky?=
 =?utf-8?B?aVpxNHhJSUV0UUtKQmFQcjNRMmtJRVQ5VllTbVN5VXdLUlJkakF2R20yclBx?=
 =?utf-8?B?TU01T2w0UGk5NzhWcjlSL1ZjWTBRRGFnUkEzY1pKR0U4bW83OVhTYXRqN2pk?=
 =?utf-8?B?eHF5V0tMelVOSmwwUzRpV0hNVjd0WUkzalhLL0lJcXlEUWtYcCtUT1NWR01Z?=
 =?utf-8?B?UjNDcko5dTkyNXRlUDEvZXlaTmNKemNPM3BBNVVLN1FKTkdwdE8ybHVTMm9L?=
 =?utf-8?B?cVZIcGtFbFN5bWhDQTZGazFRa3N1LzB0Mmt5bXhRWU9qdWcwSXkvdUdGczNX?=
 =?utf-8?B?dUc0aXhNemlGVFBWdkZSUk5VVVBGcHM2Q2ZlQmt4Y25JWmcyM0ZwTlovU3Z1?=
 =?utf-8?Q?5k3g0qQA69FljWp77aNrsB1Zjzg3PQUNoOnCnbF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7930.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ba7e53-169c-43d0-0965-08d8d9673c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 08:27:49.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pjaw4qqKK4EiUIrxP8AiVLicu/0ZX9UHNH/pAQ3Dto7TKX1ugRO8OZ1o69r7Tcz4R+SNgYQs4XUmQVSFk+rP7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJpZWRlciBTY2hyZW1w
ZiBbbWFpbHRvOmZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZV0NCj4gU2VudDogVGh1cnNkYXks
IEZlYnJ1YXJ5IDI1LCAyMDIxIDQ6MjMgUE0NCj4gVG86IEFiZWwgVmVzYSA8YWJlbC52ZXNhQG54
cC5jb20+OyBEb25nIEFpc2hlbmcgPGRvbmdhczg2QGdtYWlsLmNvbT4NCj4gQ2M6IEFpc2hlbmcg
RG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PjsNCj4gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBKYWNreSBCYWkgPHBpbmcuYmFpQG54
cC5jb20+OyBBbnNvbiBIdWFuZw0KPiA8YW5zb24uaHVhbmdAbnhwLmNvbT47IGRldmljZXRyZWUg
PGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsNCj4gU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJu
ZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsNCj4gTWlrZSBUdXJxdWV0
dGUgPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0K
PiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1
dEBnbWFpbC5jb20+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgU2FzY2hh
IEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBGYWJpbyBFc3RldmFtIDxmYWJpby5l
c3RldmFtQG54cC5jb20+OyBQaGlsaXBwIFphYmVsDQo+IDxwLnphYmVsQHBlbmd1dHJvbml4LmRl
PjsgQWRhbSBGb3JkIDxhZm9yZDE3M0BnbWFpbC5jb20+OyBsaW51eC1jbGsNCj4gPGxpbnV4LWNs
a0B2Z2VyLmtlcm5lbC5vcmc+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1Y
Qw0KPiBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+OyBMdWNhcyBTdGFjaA0KPiA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NSAxMC8xNF0gY2xrOiBpbXg6IEFkZCBnZW5lcmljIGJsay1jdGwgZHJpdmVy
DQo+IA0KPiBIaSBBYmVsLA0KPiANCj4gT24gMTcuMTEuMjAgMTU6NDgsIEFiZWwgVmVzYSB3cm90
ZToNCj4gPiBPbiAyMC0xMS0xMSAxNzoxMzoyNSwgRG9uZyBBaXNoZW5nIHdyb3RlOg0KPiA+PiBP
biBUdWUsIE5vdiAzLCAyMDIwIGF0IDc6MjIgUE0gQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNv
bT4gd3JvdGU6DQo+ID4+IC4uLg0KPiA+Pj4gK3N0YXRpYyBpbnQgaW14X2Jsa19jdGxfcmVzZXRf
c2V0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBpZCwgYm9vbCBhc3NlcnQpIHsN
Cj4gPj4+ICsgICAgICAgc3RydWN0IGlteF9ibGtfY3RsX2RydmRhdGEgKmRydmRhdGEgPSBjb250
YWluZXJfb2YocmNkZXYsDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW14
X2Jsa19jdGxfZHJ2ZGF0YSwgcmNkZXYpOw0KPiA+Pj4gKyAgICAgICB1bnNpZ25lZCBpbnQgb2Zm
c2V0ID0gZHJ2ZGF0YS0+cnN0X2h3c1tpZF0ub2Zmc2V0Ow0KPiA+Pj4gKyAgICAgICB1bnNpZ25l
ZCBpbnQgc2hpZnQgPSBkcnZkYXRhLT5yc3RfaHdzW2lkXS5zaGlmdDsNCj4gPj4+ICsgICAgICAg
dW5zaWduZWQgaW50IG1hc2sgPSBkcnZkYXRhLT5yc3RfaHdzW2lkXS5tYXNrOw0KPiA+Pj4gKyAg
ICAgICB2b2lkIF9faW9tZW0gKnJlZ19hZGRyID0gZHJ2ZGF0YS0+YmFzZSArIG9mZnNldDsNCj4g
Pj4+ICsgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPj4+ICsgICAgICAgdTMyIHJlZzsN
Cj4gPj4+ICsNCj4gPj4+ICsgICAgICAgaWYgKCFhc3NlcnQgJiYgIXRlc3RfYml0KDEsICZkcnZk
YXRhLT5yc3RfaHdzW2lkXS5hc3NlcnRlZCkpDQo+ID4+PiArICAgICAgICAgICAgICAgcmV0dXJu
IC1FTk9ERVY7DQo+ID4+DQo+ID4+IFdoYXQgaWYgY29uc3VtZXJzIGNhbGwgZGVhc3NlcnQgZmly
c3QgaW4gcHJvYmUgd2hpY2ggc2VlbXMgY29tbW9uIGluDQo+IGtlcm5lbD8NCj4gPj4gSXQgc2Vl
bXMgd2lsbCBmYWlsLg0KPiA+PiBlLmcuDQo+ID4+IHByb2JlKCkgew0KPiA+PiAgICAgIHJlc2V0
X2NvbnRyb2xfZ2V0KCkNCj4gPj4gICAgICByZXNldF9jb250cm9sX2RlYXNzZXJ0KCkNCj4gPj4g
fQ0KPiA+Pg0KPiA+PiBSZWdhcmRzDQo+ID4+IEFpc2hlbmcNCj4gPj4NCj4gPg0KPiA+IE9LLCBJ
J20gdHJ5aW5nIHRvIGV4cGxhaW4gaGVyZSBob3cgSSBrbm93IHRoZSByZXNldHMgYXJlIHN1cHBv
c2VkIHRvDQo+ID4gYmUgd29ya2luZyBhbmQgaG93IHRoZSBCTEtfQ1RMIElQIGlzIHdvcmtpbmcu
DQo+ID4NCj4gPg0KPiA+IEZpcnN0IG9mLCB0aGUgQkxLX0NUTCBiaXRzIChyZXNldHMgYW5kIGNs
b2NrcykgYWxsIGhhdmUgdGhlIEhXIGluaXQNCj4gPiAoZGVmYXVsdCkgdmFsdWVzIGFzIDAuIEJh
c2ljYWxseSwgYWZ0ZXIgdGhlIGJsa19jdGwgUEQgaXMgcG93ZXJlZCBvbiwNCj4gPiB0aGUgcmVz
ZXRzIGFyZSBkZWFzc2VydGVkIGFuZCBjbG9ja3MgYXJlIGdhdGVkIGJ5IGRlZmF1bHQuIFNpbmNl
IHRoZQ0KPiA+IGJsa19jdGwgaXMgbm90IHRoZSBwYXJlbnQgb2YgYW55IG9mIHRoZSBjb25zdW1l
cnMgaW4gZGV2aWNldHJlZSAodGhlDQo+ID4gcmVnIG1hcHMgYXJlIGVudGlyZWx5IGRpZmZlcmVu
dCBhbnl3YXkpLCB0aGVyZSBpcyBubyB3YXkgb2Ygb3JkZXJpbmcNCj4gPiB0aGUgcnVudGltZSBj
YWxsYmFja3MgYmV0d2VlbiB0aGUgY29uc3VtZXIgYW5kIHRoZSBibGtfY3RsLiBTbyB3ZQ0KPiA+
IG1pZ2h0IGVuZCB1cCBoYXZpbmcgdGhlIHJ1bnRpbWUgcmVzdW1lIGNhbGxiYWNrIGFmdGVyIHRo
ZSBvbmUgZnJvbQ0KPiA+IEVBUkMgKGNvbnN1bWVyKSwgZm9yIGV4YW1wbGUsIHdoaWNoIHdpbGwg
YmFzaWNhbGx5IG92ZXJ3cml0ZSB0aGUgdmFsdWUNCj4gd3JpdHRlbiBieSBFQVJDIGRyaXZlciB3
aXRoIHdoYXRldmVyIHdhcyBzYXZlZCBvbiBzdXNwZW5kLg0KPiA+DQo+ID4gTm93LCBhYm91dCB0
aGUgdXNhZ2Ugb2YgdGhlIHJlc2V0IGJpdHMuIEFGQUlDVCwgaXQgd291bGQgbWFrZSBtb3JlDQo+
ID4gc2Vuc2UgdG8gYXNzZXJ0IHRoZSByZXNldCwgdGhlbiBlbmFibGUgdGhlIGNsb2NrLCB0aGVu
IGRlYXNzZXJ0LiBUaGlzDQo+ID4gd2F5LCB5b3UncmUga2VlcGluZyB0aGUgRUFSQyAoY29uc3Vt
ZXIpIGluIHJlc2V0ICh3aXRoIHRoZSBjbG9ja3Mgb24pDQo+ID4gdW50aWwgeW91IGV2ZW50dWFs
bHkgcmVsZWFzZSBpdCBvdXQgb2YgcmVzZXQgYnkgZGVhc3NlcnRpbmcuIFRoaXMgaXMNCj4gPiBo
b3cgdGhlIHJ1bnRpbWUgcmVzdW1lIHNob3VsZCBkZWFsIHdpdGggdGhlIHJlc2V0IGFuZCB0aGUg
Y2xvY2suIEFzDQo+ID4gZm9yIHRoZSBydW50aW1lIHN1c3BlbmQsIHRoZSByZXNldCBjYW4gYmUg
ZW50aXJlbHkgaWdub3JlZCBhcyBsb25nIGFzIHlvdSdyZQ0KPiBkaXNhYmxpbmcgdGhlIGNsb2Nr
Lg0KPiA+DQo+ID4gVGhpcyBsYXN0IHBhcnQgd2lsbCBhbGxvdyB0aGUgYmxrX2N0bCB0byBtYWtl
IHRoZSBmb2xsb3dpbmcgYXNzdW1wdGlvbjoNCj4gPiBpZiBhbGwgdGhlIGNsb2NrcyBhcmUgZGlz
YWJsZWQgYW5kIG5vbmUgb2YgdGhlIHJlc2V0IGJpdHMgYXJlIGFzc2VydGVkLCBJIGNhbg0KPiBw
b3dlciBvZmYuDQo+ID4NCj4gPiBOb3csIEkga25vdyB0aGVyZSBhcmUgZHJpdmVycyBvdXR0aGVy
ZSB0aGF0IGRvIGFzc2VydCBvbiBzdXNwZW5kLCBidXQNCj4gPiBhcyBsb25nIGFzIHRoZSBjbG9j
a3MgYXJlIGRpc2FibGVkLCB0aGUgYXNzZXJ0IHdpbGwgaGF2ZSBubyBpbXBhY3QuDQo+ID4gQnV0
IG1heWJlIGluIHRoZWlyIGNhc2UgdGhlIHJlc2V0IGNvbnRyb2xsZXIgY2Fubm90IHBvd2VyIGRv
d24gaXRzZWxmLg0KPiA+DQo+ID4gQXMgZm9yIHRoZSBzYWZla2VlcGluZyBvZiB0aGUgcmVnaXN0
ZXIsIEknbGwganVzdCBkcm9wIGl0IGR1ZSB0byB0aGUgZm9sbG93aW5nDQo+IGFyZ3VtZW50czoN
Cj4gPiAxLiBhbGwgdGhlIGNsb2NrcyBhcmUgZ2F0ZWQgYnkgZGVmYXVsdCAyLiBhbGwgcmVzZXRz
IGFyZSBkZWFzc2VydGVkIGJ5DQo+ID4gZGVmYXVsdCAzLiB3aGVuIGJsa19jdGwgZ29lcyBkb3du
LCBhbGwgdGhlIGNvbnN1bWVycyBnbyBkb3duLiAoYWxsDQo+ID4gaGF2ZSB0aGUgc2FtZSBQRCkN
Cj4gPg0KPiA+ICBGcm9tIDEgYW5kIDIgcmVzdWx0cyB0aGUgSVAgd2lsbCBub3QgYmUgcnVubmlu
ZyBhbmQgZnJvbSAzIHJlc3VsdHMNCj4gPiB0aGUgSFcgc3RhdGUgb2YgZXZlcnkgSVAgYmVjb21l
cyBIVyBpbml0IHN0YXRlLg0KPiANCj4gQXJlIHRoZXJlIGFueSBwbGFucyB0byBjb250aW51ZSB0
aGlzIHdvcms/IEFzIEJMSy1DVEwgaXQgaXMgbm90IG9ubHkgcmVsZXZhbnQNCj4gZm9yIHRoZSBp
Lk1YOE1QLCBidXQgYWxzbyBmb3IgaS5NWDhNTSBhbmQgaS5NWDhNTiwgaXQgd291bGQgYmUgbmlj
ZSB0byBnZXQNCj4gdGhpcyByZWFkeSBpbiBvcmRlciB0byBwcmVwYXJlIGZvciBwcm9wZXIgZ3Jh
cGhpY3MvZGlzcGxheSBzdXBwb3J0Lg0KPiANCg0KQmVmb3JlIGNvbnRpbnVpbmcgdGhpcyB3b3Jr
LCB3ZSBuZWVkIHRvIGZpbmQgb3V0IGEgd2F5IHRvIHJlc29sdmUgdGhlIGN5Y2xpbmcgZGVwZW5k
ZW5jeSBpc3N1ZSBiZXR3ZWVuIHBvd2VyIGRvbWFpbiBhbmQgYmxrLWN0cmwuDQppdCBpcyBpbmRl
ZWQgaW50cm9kdWNlZCBzb21lIHRyb3VibGVzIGluIE5YUCBsYXRlc3QgaW50ZXJuYWwgcmVsZWFz
ZSB3aGVuIHRoZSBibGstY3RybCBkcml2ZXIgaXMgYWRkZWQuDQoNCkJSDQpKYWNreSBCYWkNCg0K
PiBUaGFua3MNCj4gRnJpZWRlcg0K
