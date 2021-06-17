Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F43AB36D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhFQMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:22:43 -0400
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:40449
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231361AbhFQMWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:22:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYMLUC62W4AX/BiRuXvDzAOxRk1isAU3+Dek5lf7l6JeoGuSvpXlv72EcwsHkmsF80bbcFWPtW8kma2wvYX19UhnKIA8iuhXsgO72q85kl9009svwrxgyl5ZHLxl2o7pLY1hNw2HneT7tObdoqHa0m4Fdi4sFtmJeQleqXPKx8gjHyHQNbUd3DfFBlzCsNRCqy21IHTdM0+zEoN31QhuMCslEQIaJDRqCbjaTopT7E2wRfvyV6Q5FLLKdDAUH9OO2xVczzeZo9rfDzzM3FOfPo/lcq/Qz2YqX0jMrbGJeRnjgoN/7rFiX9Vz2HVxfZAfPTbaNndrtAKdZDQl3Spz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9C87C+fss4aRATu/nZ9jjp6GEa3d3Y+N7OyIUklQLY=;
 b=cNv0HmyXZmPBW4OyDGHuHd0xExJUdkCokAaS8qBtK0UvHSVye2FmtfLO1QCWYeD8g1KVtMhtCjZzgMYmOzL9a6YFHeg4tXvz4/elDppuUMdSa+D1L+NItR4xVQap7fhWUxc/fHX/mVJ0PAEHrDIRxbi0k7yQP1X6aP/TeeHxEBLXrWKY5j4ByHkSdDJ1uUSuPjr/fPx60VpPulps0X+3Iy29tpdbCYSzw2/pHXVn7xbTnqvN72Y1LuOzY1/EiDj/Ri8PXk9+Pc3LKSENnppCeKDM/zxvKfMlA8szaXQGFVsqHoRXTKu0gctICSe0tvsxuHA3aVHlaxlLe1rMB8DxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9C87C+fss4aRATu/nZ9jjp6GEa3d3Y+N7OyIUklQLY=;
 b=XJ9Imbmh3+SbBUkM+oV01+CTKwCWT7hdKS/mSTajoga+G5WonQcl3p3wjpANDWKtMffijzpuZGfVgw8kwx/XIWupLC3OUS5iSY1oPrtcB/6y4sRPtt9EebMhkBwuXXe0cRr3IToRBBH7aRyBNwDxCFA+llKE8Ndo30m6DVrtvLE=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8870.eurprd04.prod.outlook.com (2603:10a6:10:2e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 12:20:32 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2%9]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 12:20:31 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH -next v2 2/2] ARM: imx: add missing
 clk_disable_unprepare()
Thread-Topic: [PATCH -next v2 2/2] ARM: imx: add missing
 clk_disable_unprepare()
Thread-Index: AQHXYeTKYxp6tiFzQ02dO9f2asFiLasYImrw
Date:   Thu, 17 Jun 2021 12:20:31 +0000
Message-ID: <DB9PR04MB847797F192398A62DE8D59CE800E9@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20210615125239.1348845-1-yangyingliang@huawei.com>
 <20210615125239.1348845-3-yangyingliang@huawei.com>
In-Reply-To: <20210615125239.1348845-3-yangyingliang@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa3f89da-89cc-4d32-4f1a-08d9318a4ce5
x-ms-traffictypediagnostic: DU2PR04MB8870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DU2PR04MB887041229B5AF8D7F21818A0800E9@DU2PR04MB8870.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CZcisaXkWkXSA/894+6auXlI3t20TTrCuBBGDgT3LDr7kTWb5JkqyXr5J7/CyIFHTqcILBdNsAHEV95Je2RYpc3rkaJ0h0ftVXsF1jKtPr/yHsfcAS57Wj0Iz2SSUJlH3kclgZBtWRsgTYp8LWLjPY0AMvi6aegr2mFFCHzjUJDRWoMxxYdLQMa/KgIemMgG6KJxDYga6c2Q/Wok3kTnUx51ahB3Mtr8U8BZcag3Sfqo89K6VuNN32HCT2T8ZERbDJPSAkfT50yyp/FgegCLix5718J8ScosJX+xvNa4CZtoFm3Q35GVV2Vi41ydmjsz4BSdT2F2KdSjpHv/1POc5WnTadAD387BO8LozuTgbUFwPZ+zCmLOj6bfQRMxUgSvQixP6oJ6/z7dutktg34gNnG5bEWmF5CWHkoXJBtTOY9E/9dVJ8JOplioYzaTucC81G4lMUiiXrgSDhjAQSrHVtrnosvG8Em7zIAs/lYVcdRsICZVx9Bbcye/jWP1fSJ/3Z0Ohd2zZs5WJCIWSPqV0n4rrgVqoa9wnGW7Gfjpp4Ma6IU2GFgGj/al/QZG1EcdZ85Wjl7+2dNdb6XpJjFyIMYTElQv8DoQpTJkTEVR4LM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(66476007)(71200400001)(44832011)(6636002)(66946007)(76116006)(66446008)(64756008)(4326008)(52536014)(478600001)(55016002)(2906002)(9686003)(122000001)(26005)(6506007)(38100700002)(186003)(33656002)(110136005)(8936002)(316002)(83380400001)(8676002)(7696005)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0xWWUlIaVdYdzBqMnp5a3crL2hUSVNJSUZEWEk3K2xhOUdPbStZU2pReUph?=
 =?utf-8?B?TEhBbjZrME1vWkFFZFhFZ0Vvd0VYeUtXY2tlK2hPclRtbGcySlU4NTl3ZVR0?=
 =?utf-8?B?eFBJOG1sWkhGbWhrNFZvcnhOMUhXMkFkT2tJQVFSUCtPbXBtQ2ZGMStRZTNs?=
 =?utf-8?B?ckg5VTZxcXhad1EweWdGN1hKTEZ0L3M3TGViYmZ0dEgyR2llMkQ2a0hiMkUr?=
 =?utf-8?B?S0xRa3h4VWpHQXpLcEZ4K3BlSk5kaUp1K013QWk2QStHamR0RTZCaDg1em1u?=
 =?utf-8?B?T3BpcXRhYmtZcmhNeTI0UlA1OEtpdU9jTE92ejVYS1QvK1BlVDZvbWpKamZL?=
 =?utf-8?B?VzRMTjlPOVNhbHIxcjFTalpqQ0xwUkRNSHZOcjQ4dXJYWFlTVlFjNHIySkNS?=
 =?utf-8?B?dTNvUDBvZzVYUnhBVCs2d28vcHJ6eGN6NElYTWdEYjdqVDB6R3J1SytGTjY5?=
 =?utf-8?B?ZktZcUxiaXMwNVVFNGkyOVhwaEdTaFRhR3c1NlFraVNkTUpmZld1bFpkTk05?=
 =?utf-8?B?d1dyMTUzVnNIenFKTm8ySEVjeHBRODJVd1c1cHhCc0trb3RJaUdEdlNoc283?=
 =?utf-8?B?RFgzZTFKNGxYM3FmcWRKMTRVWWdNVnN3R2J6aE9Ba3hiUDFGK1lxNnd4YkxD?=
 =?utf-8?B?YytJRFcraTE0VWcvMVFOTnJhN01vd1d6SVE0dXYzREtXb2JSRG9aVVd2cnRU?=
 =?utf-8?B?enlTWHFkVk1JQXpFOStlWWVEYkVBc3NZM2psUEZ1TVVIR0E5ZXQra1paQnpl?=
 =?utf-8?B?RHFocTlHVmt2VDZ6byt1WXJMSHZxQUEwTVRTYTU0NjdGOUVJMVpiaW9BN0pH?=
 =?utf-8?B?YkRXc3d0RERNOEJQcEVmUWNtbXJFR0c2OGozRHZaVlJwcFZUZzYzV093K3Vi?=
 =?utf-8?B?WTI2VklWdktaSTRybEVkRjFYcFc1U3V1MlgzSXp1V2RFZWJqaUN5OGR1M0lD?=
 =?utf-8?B?TG1QQ25zNUlZTWlTNVFXWVJTRW1QVTNUVDRicHFWU2xHTEZKZHoxV1ZFdFkr?=
 =?utf-8?B?M1prUlEyK0dUQU5mZWJMbEtkbU9Bb0JrbitkZE9XM0E0WHRyRkxCejdrMUFo?=
 =?utf-8?B?SDIrYlBPTTRzQXptSS9iOGVqaFozaUNMNnFIQm1WUURlVDdudFN5RkhOM1F2?=
 =?utf-8?B?QWxUOE9rWllZT3lydGkzaG1NQjNWQjNsWXZHVXRkWHdhdlBRMU50cEs4bWNW?=
 =?utf-8?B?cEFBUHoxRlFjM0FsYVNCeEpkUFZIc3YwRmxmUzdnSk94SEJDaUppRUtQOEd3?=
 =?utf-8?B?RkF6cS84U3lzZHRta0ErSnVRbjNWWkRONkRJRkdVR2xreGhOSHlhWGFHUGZH?=
 =?utf-8?B?MUV1SFV3eEo4VnlDZlFOODdRdGROR2p0b1d5eERIc2dkVXJSalRsRW5LbEY5?=
 =?utf-8?B?M0p2MWVkSm9mSkJ1dFhEbVZyV0RCNTl1TmRxMTlVTis4SzRFbDhSRHJuemVM?=
 =?utf-8?B?YzYycFlkbHpJUkVrM3ZsR1NwWFlWUjFnV2FEblFnMFRJV013TS9XOHZHaWh5?=
 =?utf-8?B?YkhZNUpGVjVBKzViYXladlg4U1FtR0pIalhzMGpuK0JUYWI2ZldhQXRTLy8x?=
 =?utf-8?B?bk54VUpwclVEektZc09oSWx1RFR1RWNWSnhnK1JRKzhoaVgveE9OaXplQk53?=
 =?utf-8?B?U3NWQ3hPWVpjeStCNWhTRE9ObWtZbmZpeUlvdGhjUnZha2dsWHJUalFBUFJR?=
 =?utf-8?B?VWpXNmM4RmxPRVZTWUZiUDZUWC9CVDNWbE9JdEgwTEZCakhPRXdvOXhVT0Fo?=
 =?utf-8?Q?URZcpKbSmQDEFHdIRWSe/dwEEimouFYJIU4r0uq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3f89da-89cc-4d32-4f1a-08d9318a4ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 12:20:31.4253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlneRmQxiTbKnY5Re4e0clJNuR4chPc6XGcxeQ99ZwZ6gMl+zJlb5PbIR/04yrhWdumpENSDqqDnNz+pfEDy/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8870
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBZYW5nIFlpbmdsaWFuZyA8eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKdW5lIDE1LCAyMDIxIDg6NTMgUE0NCj4gDQo+IGNsb2NrIHNvdXJjZSBpcyBw
cmVwYXJlZCBhbmQgZW5hYmxlZCBieSBjbGtfcHJlcGFyZV9lbmFibGUoKSBpbiBwcm9iZQ0KPiBm
dW5jdGlvbiwgYnV0IG5vIGRpc2FibGUgb3IgdW5wcmVwYXJlIGluIHJlbW92ZSBhbmQgZXJyb3Ig
cGF0aC4NCj4gDQo+IEZpeGVzOiA5NDU0YTBjYWZmNmEgKCJBUk06IGlteDogYWRkIG1tZGMgaXBn
IGNsb2NrIG9wZXJhdGlvbiBmb3IgbW1kYyIpDQo+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxo
dWxrY2lAaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBZaW5nbGlhbmcgPHlhbmd5
aW5nbGlhbmdAaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVu
Zy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAtLS0NCj4gIGFyY2gvYXJt
L21hY2gtaW14L21tZGMuYyB8IDEyICsrKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLWlteC9tbWRjLmMgYi9hcmNoL2FybS9tYWNoLWlteC9tbWRjLmMgaW5kZXgNCj4gOGU1
NzY5MWFhZmUyLi40YTZmMTM1OWUxZTkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL21hY2gtaW14
L21tZGMuYw0KPiArKysgYi9hcmNoL2FybS9tYWNoLWlteC9tbWRjLmMNCj4gQEAgLTEwMyw2ICsx
MDMsNyBAQCBzdHJ1Y3QgbW1kY19wbXUgew0KPiAgCXN0cnVjdCBwZXJmX2V2ZW50ICptbWRjX2V2
ZW50c1tNTURDX05VTV9DT1VOVEVSU107DQo+ICAJc3RydWN0IGhsaXN0X25vZGUgbm9kZTsNCj4g
IAlzdHJ1Y3QgZnNsX21tZGNfZGV2dHlwZV9kYXRhICpkZXZ0eXBlX2RhdGE7DQo+ICsJc3RydWN0
IGNsayAqbW1kY19pcGdfY2xrOw0KPiAgfTsNCj4gDQo+ICAvKg0KPiBAQCAtNDYzLDExICs0NjQs
MTMgQEAgc3RhdGljIGludCBpbXhfbW1kY19yZW1vdmUoc3RydWN0DQo+IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gIAljcHVocF9zdGF0ZV9yZW1vdmVfaW5zdGFuY2Vfbm9jYWxscyhjcHVocF9t
bWRjX3N0YXRlLA0KPiAmcG11X21tZGMtPm5vZGUpOw0KPiAgCXBlcmZfcG11X3VucmVnaXN0ZXIo
JnBtdV9tbWRjLT5wbXUpOw0KPiAgCWlvdW5tYXAocG11X21tZGMtPm1tZGNfYmFzZSk7DQo+ICsJ
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBtdV9tbWRjLT5tbWRjX2lwZ19jbGspOw0KPiAgCWtmcmVl
KHBtdV9tbWRjKTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgaW50IGlteF9t
bWRjX3BlcmZfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCB2b2lkIF9faW9tZW0N
Cj4gKm1tZGNfYmFzZSkNCj4gK3N0YXRpYyBpbnQgaW14X21tZGNfcGVyZl9pbml0KHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHZvaWQgX19pb21lbQ0KPiAqbW1kY19iYXNlLA0KPiArCQkJ
ICAgICAgc3RydWN0IGNsayAqbW1kY19pcGdfY2xrKQ0KPiAgew0KPiAgCXN0cnVjdCBtbWRjX3Bt
dSAqcG11X21tZGM7DQo+ICAJY2hhciAqbmFtZTsNCj4gQEAgLTQ5NSw2ICs0OTgsNyBAQCBzdGF0
aWMgaW50IGlteF9tbWRjX3BlcmZfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2
LCB2b2lkIF9faW9tZW0gKm1tZGNfYg0KPiAgCX0NCj4gDQo+ICAJbW1kY19udW0gPSBtbWRjX3Bt
dV9pbml0KHBtdV9tbWRjLCBtbWRjX2Jhc2UsICZwZGV2LT5kZXYpOw0KPiArCXBtdV9tbWRjLT5t
bWRjX2lwZ19jbGsgPSBtbWRjX2lwZ19jbGs7DQo+ICAJaWYgKG1tZGNfbnVtID09IDApDQo+ICAJ
CW5hbWUgPSAibW1kYyI7DQo+ICAJZWxzZQ0KPiBAQCAtNTY4LDkgKzU3MiwxMSBAQCBzdGF0aWMg
aW50IGlteF9tbWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJ
dmFsICY9IH4oMSA8PCBCUF9NTURDX01BUFNSX1BTRCk7DQo+ICAJd3JpdGVsX3JlbGF4ZWQodmFs
LCByZWcpOw0KPiANCj4gLQllcnIgPSBpbXhfbW1kY19wZXJmX2luaXQocGRldiwgbW1kY19iYXNl
KTsNCj4gLQlpZiAoZXJyKQ0KPiArCWVyciA9IGlteF9tbWRjX3BlcmZfaW5pdChwZGV2LCBtbWRj
X2Jhc2UsIG1tZGNfaXBnX2Nsayk7DQo+ICsJaWYgKGVycikgew0KPiAgCQlpb3VubWFwKG1tZGNf
YmFzZSk7DQo+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShtbWRjX2lwZ19jbGspOw0KPiArCX0N
Cj4gDQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gLS0NCj4gMi4yNS4xDQoNCg==
