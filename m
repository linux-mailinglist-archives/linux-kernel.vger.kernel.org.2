Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05483A4E4F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhFLLWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 07:22:05 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:40407
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229584AbhFLLWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 07:22:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8vuHiH9RoTfs1h7QxOjtdNcOFhePUJ3RLb8QoD6whAivLVcLyfng6I6+du6Pb4Uc1V7opeIMEnRO54NqzjrgMFzzaIcJ1VZ8MfYY9144XxivOBXKSiKjNUcUbw4Mr01gLom+lJLbCtsQU10QTFEYY/xJ+4GVnBljCrKCImHwxriH9eM/k+HeM7ZkjBog04LONNReviBV1bVs0R0z8dKPT4zm3PMKwhpyB5KrncXCTZruVweYI/xOYbQJ/k18CY/XEFqCIok4jswzMrTsnHtNb+G10fRUkogIG+/Fg6VXYSvUq5euwbX4LBT4ntX5ArL1oZLUyfrLuzstML34nAslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GusryHpE+lR/E9M59XsFgiMuklD1IXqabGEKN4PMo7A=;
 b=BiZRcXidyxwe624DI2jypqd8boSiVRMG6YHrgnKthob24cJi8ub1msxjBmpZTUzNGwbKRn2d9kCihhXcL/XNFveYd23IMaZ3x/0a549UGVl0AwnAV9jkjyyDdXpW3CZ/1zwMKXa3uZ3Qx4TDyASE5UF6HeM8NyNZ9mVEhEgiwgeF8K8zywPftfYxB+ujtzYUmWrhrz3jJYyJDwoZvUU2BPkUrBITnNBjPwT+XN2i/X1vYbrDZnPaW9wgPdjq1r+ffW3VhHySFCJlgwCL4PaQwkQ0QxIF8b+JSzWgRl41wPI7hvVW2DNoZ7L81V9BkPeY8dWXZy2GUChOKOdpTg0nzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GusryHpE+lR/E9M59XsFgiMuklD1IXqabGEKN4PMo7A=;
 b=YLLYcH581SLQ6X6nAgzOXpqA/uGvy7oouIEz9NH+E6PTO1c07bmd+GoSqjpNT+O75UG2m/jNPDNfC1YrHDuG1mIYlVzJ29wj3AkT+htIyxINgd6TdtVkEKL2t6lKWGeeWmCwk5G7OtcPMKrnFL8+hbcQIyfqpQ1n6VTUM9DHpe8=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DB9PR04MB8495.eurprd04.prod.outlook.com (2603:10a6:10:2c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Sat, 12 Jun
 2021 11:20:02 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2%7]) with mapi id 15.20.4219.024; Sat, 12 Jun 2021
 11:20:02 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
CC:     linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dong Aisheng <dongas86@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] of: of_reserved_mem: mark nomap memory instead of
 removing
Thread-Topic: [PATCH 2/2] of: of_reserved_mem: mark nomap memory instead of
 removing
Thread-Index: AQHXXsN/DwPm12gbYEeVmhbjjHfun6sPC9wAgAEv6WA=
Date:   Sat, 12 Jun 2021 11:20:02 +0000
Message-ID: <DB9PR04MB8477F7F3E4CF66528CD19FE580339@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20210611131153.3731147-1-aisheng.dong@nxp.com>
 <20210611131153.3731147-2-aisheng.dong@nxp.com>
 <CAL_JsqJMyY4iEcJi1z0o7pZdCASYHjnVjf6+fQDqa_ucb-M-MA@mail.gmail.com>
In-Reply-To: <CAL_JsqJMyY4iEcJi1z0o7pZdCASYHjnVjf6+fQDqa_ucb-M-MA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3fda3ea-c583-488a-c503-08d92d940595
x-ms-traffictypediagnostic: DB9PR04MB8495:
x-microsoft-antispam-prvs: <DB9PR04MB84950A4740B9C729DF3907FD80339@DB9PR04MB8495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S28AUQQinhL/LM5D/CqK3hF2iFVflLMoqnNX7627GnRkOchRBPY72ZA5Dm71G1fe0eSKfL3V9peyUFFXvrFs81MB9cisXpq10XWGBgpCWQWzXo9m+7QxALg8WSIYosdBSep8YGLP3vIx5hnthrsb1GPSClWqHnFnir5QB7rmoXwcGaAJ5d3FCck2TLV9I/o5AQ+GOJtjBjRHsWfqr5KEy8G7nYZphhVs4+CJZ43KAzBInXjdn+sJMljGpt7kA1EiEjBAOF8dbh/orVQLLZJ+Xgu7HzMaEvSCBL60abKeTcXhEMzEtj0T0yCjtJALvfzylTZU34jHE072s4Mp4KrrSrjcIWj4Pd/IlFXO+0bypMl6muOOptBu8KPFOGLxKMD6m+thkOw6mMRp9XyqMvXfXVfMVYe1H6Wz/2+7NhGwgGlxkhGo+6r+aMdi8jbGEVKJMPAVgwK9byW0yp6V3lsmjpiGc8OLht2AMJBwGpCUqxrOr4gSxDLVFRINajmbTStQbQxGw5hiVGX1daYR2/xBg5ZhpApNbzhXTwmxxjcVFgh/+JF3gkvF6Rh/GyZKwKm1jm2bzA/abQeYlaKZYcJQtnYrG0l/wCG1Qohq7XyRTL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(5660300002)(7416002)(52536014)(53546011)(6506007)(4326008)(71200400001)(478600001)(7696005)(33656002)(110136005)(2906002)(44832011)(9686003)(186003)(316002)(66946007)(54906003)(64756008)(26005)(66556008)(66476007)(55016002)(66446008)(38100700002)(8676002)(122000001)(83380400001)(76116006)(8936002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVlVM3h5RFU2cTBZUVVQU2dFSEZzb1E0LzA5cTJLd3hqOEhnbHlac1VDYXNU?=
 =?utf-8?B?UlNDeUFwMzJ3UU0wNnorZmJsSHd0NzVUQi8rZkpONlBRejNzYmNEYWhqdHhQ?=
 =?utf-8?B?NjJoSmJjeDB4OVkwMEwvaU96c1RpVVB0aEYrNkJjaVdwbWVRVGMxUkxkblh0?=
 =?utf-8?B?L2FDY2hFMFVGTi9rb1NIbkV6Q2ZnckRZQUxrcE1LbVBuY05ab0NBL0sybk1z?=
 =?utf-8?B?K2k0Rjc0SXhjN3hVdUI4dkE2bkVEUTRPRGJBd2pEZUVDQTA2VlR3aDZHUHk2?=
 =?utf-8?B?MFUweUVLVmZONTMvQUhrNTNTbVdQTzVvbnFGQmtNbnhNL3RKQXBVY2FDZkM1?=
 =?utf-8?B?RTBmY1NCWWFSaFB0QXFqWnRNckNCVFJJTUtYcVFKK3pVM3BlenpOQ2JMYXhB?=
 =?utf-8?B?S0x4NzJLalVXajBKNGEzWEF6NTdlNDRZUTlCMThVU3pPcVRkTUtmaURYNStl?=
 =?utf-8?B?NkNhakJkZkt5YXUwR2VsWUdPRXFGZ01pdVZtZDBPK0psMkNzaGxmRjhYWllq?=
 =?utf-8?B?L3hjWU03QlhZVmRTenpEUGxxVzdRdzdmdHhDRUR3TTJLekJaeVFqYndXbGE5?=
 =?utf-8?B?NWthdENweG1Mb0ErQ2NGK2o3T0owWWhGZis1aUpyOGpWVlRnZVMxUTQ0N3Fh?=
 =?utf-8?B?ZzhWT0g0VUNtUElDTGx1YUJYS2pYYnk5UmsvTHU1T2ZPVXJuNTZoWGxQN2dx?=
 =?utf-8?B?Q1lGS2t2bm8yaFBycXI2TmpUeXBWKzVRSE1VeEYvYUhNVUtvYnpuSHVuU3da?=
 =?utf-8?B?dTJWY0ZLeU4zSHFQYW4xMnZNRlNsaDV6ei9nQkpUdXhlOXdXZDhmVW5MNzRp?=
 =?utf-8?B?TUFoRHR2UTNkaWV0Y0RnNS9nMW8wU21pTTZaSkhCWXh4Qng4cFo0dHN4MmNW?=
 =?utf-8?B?aUhZUFRBVkx4eEdwOVpJcC8xb0p5T0FkRUFSYlRsY2tGbm12Q0FSNG1ycGFV?=
 =?utf-8?B?MHN4NFdXRzduajZKUXZBUnc4M3FQTlMvYlI4ZFAvNjNqczI2SHU4TVZPSms1?=
 =?utf-8?B?cVZYMk1VbnVJMWdJTWFPblEyNXJuSTErNXhxV21jN3VwLzg5dHpsTFZOVHVB?=
 =?utf-8?B?NEZtVmtzMk9MTWhLamxUSXRld0RyVGhIaWErSzhwNi9jT014dXRuQ1VTVS83?=
 =?utf-8?B?c0ZLcnJkRjI5cHFwc0I3YmpKbWgrV2JVTkw1cEVQYnhpbXZ1QU5ZQVE3SFdv?=
 =?utf-8?B?MlRZVXA3a2pPb2padFc2djQwOWJYd1JWOU5UOExlMzcyc2Rnd3pMNVd0dS9W?=
 =?utf-8?B?ajMxMnhCYUJ4c0wyRGdvOFRONis2UlorWEU3WWhWNGNKWDd0NWJQSnhSNWNn?=
 =?utf-8?B?L3VFVHhMYXdXQ3lucHkwbTA0eGtwUDFCUjljSVZUWndaaFk1WFp6bGlRZUth?=
 =?utf-8?B?aUR3dENkTW1YaklCajRDSEtobEg4bmNaVjNkU1BJdTI1WVpBaXNQQllwWklV?=
 =?utf-8?B?SmRNQWVXM3ZSOWlaSzYwNnFtNXozVnRZa3NETVJxbTVBT3N0ZG9DYm90VFBp?=
 =?utf-8?B?YXRhenVHRkZZU2tHY0VMT1pmeWQzRlNFS1N1L2hIL1hLeDJ5OXNJYStrTDNN?=
 =?utf-8?B?QzNSZWJ4a0toUi9FTjN1V25QdmQxc1RINkZIZWtaejZZYUJhREZnblB0N3Nk?=
 =?utf-8?B?N0FDaEFLenZEblhaUXo4WG0xNVpVRm5qdlVoVVUxK0k0cDZPblNQSVFYQTEv?=
 =?utf-8?B?bkpSb1BvVGo5Umhsd01QRkY2RWU4ekFUVHRGZ3VoVHVYb0llN3VlR0hQKzBM?=
 =?utf-8?Q?mY5CpLiKXyQBvbuVqj8zyetSsF2j75M4e83IHGu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fda3ea-c583-488a-c503-08d92d940595
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2021 11:20:02.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0nTNJS7tv06a+2vDgDQdvG5p9eYrsxnGLhF2YFuOAwTOn5W0W7V4FD9cln3a87Jq1rPG0ZovX/BviVN9ufZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8495
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRh
eSwgSnVuZSAxMiwgMjAyMSAxOjExIEFNDQo+IA0KPiBPbiBGcmksIEp1biAxMSwgMjAyMSBhdCA3
OjEzIEFNIERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+
DQo+ID4gU2luY2UgY29tbWl0IDg2NTg4Mjk2YWNiZiAoImZkdDogUHJvcGVybHkgaGFuZGxlICJu
by1tYXAiIGZpZWxkIGluIHRoZQ0KPiA+IG1lbW9yeSByZWdpb24iKSwgbm9tYXAgbWVtb3J5IGlz
IGNoYW5nZWQgdG8gY2FsbA0KPiBtZW1ibG9ja19tYXJrX25vbWFwKCkNCj4gPiBpbnN0ZWFkIG9m
IG1lbWJsb2NrX3JlbW92ZSgpLiBCdXQgaXQgb25seSBjaGFuZ2VkIHRoZSByZXNlcnZlZCBtZW1v
cnkNCj4gPiB3aXRoIGZpeGVkIGFkZHIgYW5kIHNpemUgY2FzZSBpbiBlYXJseV9pbml0X2R0X3Jl
c2VydmVfbWVtb3J5X2FyY2goKSwNCj4gPiBub3QgaW5jbHVkaW5nIHRoZSBkeW5hbWljYWwgYWxs
b2NhdGlvbiBieSBzaXplIGNhc2UgaW4NCj4gPiBlYXJseV9pbml0X2R0X2FsbG9jX3Jlc2VydmVk
X21lbW9yeV9hcmNoKCkuDQo+ID4NCj4gPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVs
Lm9yZz4NCj4gPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IEdvb2QgcHJh
Y3RpY2UgaXMgdG8gQ2MgdGhlIHBlb3BsZSBpbnZvbHZlZCBpbiByZWZlcmVuY2VkIGNvbW1pdHMu
DQo+IEFkZGluZyB0aGVtIG5vdy4gVGhpcyBjb2RlIGlzIGEgbWluZWZpZWxkIHNvIEknZCBsaWtl
IG90aGVyIGV5ZXMgb24gaXQuDQo+IA0KDQpZZXMsIHlvdSdyZSByaWdodC4gVGhhbmtzIGZvciB0
aGUgZ29vZCBzdWdnZXN0aW9uLg0KTGV0J3Mgd2FpdCBmb3IgdGhlaXIgY29tbWVudHMuDQoNClJl
Z2FyZHMNCkFpc2hlbmcNCg0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVu
Zy5kb25nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvb2Yvb2ZfcmVzZXJ2ZWRfbWVt
LmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL29mL29mX3Jlc2VydmVkX21l
bS5jDQo+ID4gYi9kcml2ZXJzL29mL29mX3Jlc2VydmVkX21lbS5jIGluZGV4IDM2N2YyOThhODNi
Mi4uZWJiYTg4Mzk1YmY4DQo+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvb2Yvb2ZfcmVzZXJ2
ZWRfbWVtLmMNCj4gPiArKysgYi9kcml2ZXJzL29mL29mX3Jlc2VydmVkX21lbS5jDQo+ID4gQEAg
LTQyLDcgKzQyLDcgQEAgc3RhdGljIGludCBfX2luaXQNCj4gPiBlYXJseV9pbml0X2R0X2FsbG9j
X3Jlc2VydmVkX21lbW9yeV9hcmNoKHBoeXNfYWRkcl90IHNpemUsDQo+ID4NCj4gPiAgICAgICAg
ICpyZXNfYmFzZSA9IGJhc2U7DQo+ID4gICAgICAgICBpZiAobm9tYXApDQo+ID4gLSAgICAgICAg
ICAgICAgIHJldHVybiBtZW1ibG9ja19yZW1vdmUoYmFzZSwgc2l6ZSk7DQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiBtZW1ibG9ja19tYXJrX25vbWFwKGJhc2UsIHNpemUpOw0KPiA+DQo+ID4g
ICAgICAgICByZXR1cm4gbWVtYmxvY2tfcmVzZXJ2ZShiYXNlLCBzaXplKTsgIH0gQEAgLTI3Niw3
ICsyNzYsNyBAQA0KPiA+IHZvaWQgX19pbml0IGZkdF9pbml0X3Jlc2VydmVkX21lbSh2b2lkKQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJfaW5mbygibm9kZSAlcyBjb21w
YXRpYmxlIG1hdGNoaW5nDQo+IGZhaWxcbiIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJtZW0tPm5hbWUpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKG5vbWFwKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBtZW1ibG9ja19hZGQocm1lbS0+YmFzZSwNCj4gcm1lbS0+c2l6ZSk7DQo+ID4gKw0K
PiA+ICsgbWVtYmxvY2tfY2xlYXJfbm9tYXAocm1lbS0+YmFzZSwgcm1lbS0+c2l6ZSk7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1lbWJsb2NrX2ZyZWUocm1lbS0+YmFzZSwNCj4gcm1l
bS0+c2l6ZSk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+IC0tDQo+ID4gMi4y
NS4xDQo+ID4NCg==
