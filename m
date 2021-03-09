Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D33322B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCIKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:12:46 -0500
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:45505
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230156AbhCIKMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:12:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbjaOxf7I5AEBzwsjqZPtZ8aLHDQpKerN5WBznzYnu2hm6/E5wGgjKTynZOygapUDojwflO+h1ou7blbYzcrrklOOb25a1oZk1eWgCMtVpS0QNaZpL89Dpo2W9VmtsSuiFDG7foy/v8oF4sjAUE+VbOx1d57R4HfbN67aJyPGfa+IIL90sEp+Qaer81gHj3DU3cBeu+JqHda8ouLTlcR1dLhiUHal1E5mLIOktO5BivQJ+FMK3Bf/KPkee8OoQAM8NlEuJzh0HTm+DfZ04F4KM7SOCk7Bm/CGvPB9lRWqMogIZciGXJaPJ8KT33QSsUKwKS7wul5srKcSWJhsl4Qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khIfqMKvfxP4iVZZkbLVt6XnXwnh8EneDp0ICuI/QAc=;
 b=Ot+5zQHh3NMCpkQSvL5cq6UXDl57isiJf/R2I3G+q4SLXq4xAdhMNq8NSuV9q2CKZfz7lr60knP1emJkoCneLQqsiHR2jcsnxf3bTWQYWNmasNL3fWHI5pCKb4hkBLbxAIivrHkqxmyoFUvjZb2djQrJosjrjX36C8IxbWomOZo8LKrXfhpaB/9iFyii1o93tRoCMQYSSYr7TNR4X4Zz/xZSPk1LDtn9LEAcCYagjDFnVTtKQUv89slNNGApxNpJNkdbLnpMPG4OepWHzd2iozsPaaJy1raajg41XJ07Y2wnTTqI1BOQkFLQ2bqarqjoYs0itQMbTJbBmjr58FJBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khIfqMKvfxP4iVZZkbLVt6XnXwnh8EneDp0ICuI/QAc=;
 b=S+a5Gl9xIwPWOw8dmLkQ34vFDkvUXqIwaxizXtTfUpSH6HudezJtBXrJXlU4i4C+UcHdcLnfJcR6fMxo6p9vTYt8Hcv0FBBYTP1XsTUlRuizxj6h6IFJF0bsk8hO3255x189FrZ+9v1FiUTEVrts7D8Gxf+KYrikWTV6fc5iJcg=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB6437.namprd02.prod.outlook.com (2603:10b6:a03:120::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 10:12:07 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c4f1:e969:f8d2:20b4]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c4f1:e969:f8d2:20b4%3]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 10:12:07 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Anurag Kumar Vulisha <anuragku@xlnx.xilinx.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] phy: zynqmp: Handle the clock enable/disable properly
Thread-Topic: [PATCH] phy: zynqmp: Handle the clock enable/disable properly
Thread-Index: AQHXFEvB4d6NHo+cvUqVZLp7/AVjoqp6hH+AgADkAlA=
Date:   Tue, 9 Mar 2021 10:12:07 +0000
Message-ID: <BYAPR02MB5896AE05855769536045162FC1929@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1615229356-26237-1-git-send-email-manish.narani@xilinx.com>
 <YEaDzWeakpJv4DaT@pendragon.ideasonboard.com>
In-Reply-To: <YEaDzWeakpJv4DaT@pendragon.ideasonboard.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [157.47.78.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0025c493-2d3b-46ac-5d8f-08d8e2e3cbcb
x-ms-traffictypediagnostic: BYAPR02MB6437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB643727A5287A7F0D919A5A54C1929@BYAPR02MB6437.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EibWkzI+sR3KRqwUoipyFJ0r+aW59zTuA5k49bGoLr8lsSZ12c5t/pvj489YGvWrXKbqgRcjpye/cDQ8PKrxC3ov4nIGCmrTv2HYTZS31gJrnl/9Dc1DnZvPUmELclFeUiHs3S/HpiaX014Vvkl23z1r/kJtw/a+OeePG3ub6JHrSdshPE/WgD3XambpuQ6rDdLNCNggDJUTMXh6EKeQvb2xv4XqapR5VipSMqmqJflVkHYOpDhpDiioQulBi27YMiZjIROL/9g2AirthZ8za/1f0ALxagzlD4baQPLO4u5V7UCUdV0SCb16IS/vahAxBDhBloaZWYYoqvE2s8B7hV35n5D3XhM9bJkiZWO92+NSf618yU86Cm37fJACkWuhsEmZWwtYUlgbGK00+WidAVDZiuLmITwbovK5kOlKa/xmxflKcJ+eaVE+eCWC8cw9b/q9UI2i5iCM2Z5Ep/K75+WomAghg4QMLQFAfotbR7mwIvOd1ZGwsCpKJuKWnPLnzqPwyZlxP0Ph52E6Y/1ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(54906003)(76116006)(66476007)(44832011)(71200400001)(55016002)(26005)(186003)(64756008)(4326008)(53546011)(66446008)(6506007)(66556008)(66946007)(8676002)(5660300002)(83380400001)(9686003)(478600001)(2906002)(7696005)(8936002)(33656002)(52536014)(316002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZHZqMUpnTVU0QkxZenhWekMxWmtqMEs0MUFMTWFpekRBelIxNFBFbGx0VTlx?=
 =?utf-8?B?TU9nSXJSS3REd01ZN09RVkk3aElpOEpyWjFGRmxabHpZSjhHcS9nZnI0QVJI?=
 =?utf-8?B?dEVia0l3Z2hKQjllRXhhWmJrM3FZN0lMN3lrSC9qMkFwZHNmdnFEZU50VnRF?=
 =?utf-8?B?N3hjWStEKy9mYWtEbWw4Vkdwc1JUdFZTMVlHSERNMlJ4NEs0b3d0MHJTUFNo?=
 =?utf-8?B?UmtGQktJZEliNDVzZndtRm5Md3puSWg0UFlUamlZTVh6Y29ma3RsRldBbVAz?=
 =?utf-8?B?RE9qZkZ4dUwyQnlyaVZKSTJKMXFXb1lpWmJYL3hpN3BOaklHYWRTVWg5bitu?=
 =?utf-8?B?ZFI5bmlVWWZHK0s0MlBHdEk2Q3NPV2dDcndVcTAvb1pYRUtGaUNZWXAvNjhH?=
 =?utf-8?B?S2xhYkFweE42eURISXA0c1lvMm5QVDZiSU5EeTIwN1pnM1A1aVJCdFFVODc0?=
 =?utf-8?B?WXZLb3ljVXFob2VveUxPUWZNRmNQMnY0OEEvbTVua1BMQ3ZPZG53ak9jOXJ3?=
 =?utf-8?B?bHF2di9BbGRYcHNGeUpTeVVBTjJkTDBSY1hibjkxamlkZVNzb1N0alVCd1Vz?=
 =?utf-8?B?VmlNaWlUUnBDU1hwUkk4WGR6b1FzT0hIVUprYTU5MnZ5eC84TkprcUR2c20y?=
 =?utf-8?B?RGN2dWlmbDlSRGxLZTdsdmNPSUtsK3VENm44aHQ3VG4wcDdrTU9kMXo1d1ZH?=
 =?utf-8?B?ZUJWZWtxaXN1NDQ5clI2ZWpEbWpLakp0SjQ5WTREM1ZFUXJBbDRpR2UvcG40?=
 =?utf-8?B?Rmp2ZVJpczVoeWlpTzRkME1iTldMSDZKbmRCbDk2NHF2d2VtUVlHMnhZc3hX?=
 =?utf-8?B?cnJ2SVQ0R0JsOFBlUnVESWZBNkg1cmo1Umc3ZjBGc2dpVkdhZ3dxV1QvMFFj?=
 =?utf-8?B?YXVCZ0p0QjViNlk2Q0lYMW9Na0RsaFo4WTFMYWkrNzZiYmxGMlRHSUN0aHVB?=
 =?utf-8?B?SnNmK21yVDdHek1oTDFCOG5KUTJsRWwzMGVYNUFZK0pYZWpxT0g4SExxRWV0?=
 =?utf-8?B?STc2Q1FyVEY5UllLdVhSeTZvcEdzQVJKaVVwc2M1dE1KY295K0lPN2s3WVVl?=
 =?utf-8?B?ZWx2RDA0WS84NFZxNjI4N3dsbTRDUEpCS2E5YS90d0h1RWlhM2ljTmtvQ2Zu?=
 =?utf-8?B?enBRU3FKT2t6dWxGbHAyZzc4YXRjRFBOVFpZeWV1WGJKU0llK1VOVk4rdnJx?=
 =?utf-8?B?MTBkVFNHWE5vMmZKSEhGaExqMGdqUmk0Z0ZFWVBTZ2xKRmF0T2p4NkdTREFN?=
 =?utf-8?B?VWttd2Y0K0dnRWtXa1JRQmtRV21wMXA4aE5ZSkJVVDZSWDJvckxZY1BCMkVx?=
 =?utf-8?B?bnl6ZUVRY0RVMlBvWXB6ZndQVVJwWXBYWXRtNkMzL2xUNldKdHFiOUJuTDl6?=
 =?utf-8?B?cDVHQ2RnK3JnbW5kTjFNbHB4dGtWQ05hZU9tQWloRC9HR3YrRm9XV2JjWW9I?=
 =?utf-8?B?LzRuQXJwZ2NhSlhGNE1mU21qYmFhOEc3NklYZlVwM2hKUUVqQ1ZvS3hqa3Zh?=
 =?utf-8?B?T0xUNW1uZTdzNFdLMXNibUlpWDZNUTRkWlkwbXFjbk9OR1NYbWtqNUxvTnNW?=
 =?utf-8?B?b0l3U2NGTStIZEw2NnNPUFdhWDBaQ0V4S1VpT3ZwSnVsRzB0d000ODczZnM5?=
 =?utf-8?B?dG0vSjBGQittUjN5UFI2SjkwcVdrMXVLcEFFUnA2bFVnU3B4NjY5NjlNbHBF?=
 =?utf-8?B?ditvYlNpNjNQOTVyNkw4YlQvV2oxMm5STWEzSng3aTE5cHdKVUIzeThHc0I5?=
 =?utf-8?Q?HGIDe2T8en5WzkEgSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0025c493-2d3b-46ac-5d8f-08d8e2e3cbcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 10:12:07.5822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrbfw3LY+/24WXRTMLYoSY0X37km7K+k4onsEqw12yXUuShZMhC+P+T5iRkwV9yZB/wqvitOBr7l9s/HwLKUzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6437
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hh
cnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggOSwgMjAyMSAxOjM3
IEFNDQo+IFRvOiBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlueC5jb20+DQo+IENjOiBBbnVy
YWcgS3VtYXIgVnVsaXNoYSA8YW51cmFna3VAeGxueC54aWxpbnguY29tPjsga2lzaG9uQHRpLmNv
bTsNCj4gdmtvdWxAa2VybmVsLm9yZzsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBoeTogenlucW1wOiBIYW5k
bGUgdGhlIGNsb2NrIGVuYWJsZS9kaXNhYmxlIHByb3Blcmx5DQo+IA0KPiBIaSBNYW5pc2gsDQo+
IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4gDQo+IE9uIFR1ZSwgTWFyIDA5LCAyMDIx
IGF0IDEyOjE5OjE2QU0gKzA1MzAsIE1hbmlzaCBOYXJhbmkgd3JvdGU6DQo+ID4gVGhlIGN1cnJl
bnQgZHJpdmVyIGlzIG5vdCBoYW5kbGluZyB0aGUgY2xvY2sgZW5hYmxlL2Rpc2FibGUgb3BlcmF0
aW9ucw0KPiA+IHByb3Blcmx5LiBUaGUgY2xvY2tzIG5lZWQgdG8gYmUgaGFuZGxlZCBjb3JyZWN0
bHkgYnkgZW5hYmxpbmcgb3INCj4gPiBkaXNhYmxpbmcgYXQgYXBwcm9wcmlhdGUgcGxhY2VzLiBU
aGlzIHBhdGNoIGFkZHMgY29kZSB0byBoYW5kbGUgdGhlDQo+ID4gc2FtZS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGlsaW54LmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9waHkveGlsaW54L3BoeS16eW5xbXAuYyB8IDQwDQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDM3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9waHkveGlsaW54L3BoeS16eW5xbXAuYyBiL2RyaXZlcnMvcGh5L3hpbGlueC9waHkt
DQo+IHp5bnFtcC5jDQo+ID4gaW5kZXggMmI2NWY4NC4uMGVjNTM0ZSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BoeS94aWxpbngvcGh5LXp5bnFtcC5jDQo+ID4gKysrIGIvZHJpdmVycy9waHkv
eGlsaW54L3BoeS16eW5xbXAuYw0KPiA+IEBAIC0yMTksNiArMjE5LDcgQEAgc3RydWN0IHhwc2d0
cl9kZXYgew0KPiA+ICAJc3RydWN0IG11dGV4IGd0cl9tdXRleDsgLyogbXV0ZXggZm9yIGxvY2tp
bmcgKi8NCj4gPiAgCXN0cnVjdCB4cHNndHJfcGh5IHBoeXNbTlVNX0xBTkVTXTsNCj4gPiAgCWNv
bnN0IHN0cnVjdCB4cHNndHJfc3NjICpyZWZjbGtfc3Njc1tOVU1fTEFORVNdOw0KPiA+ICsJc3Ry
dWN0IGNsayAqY2xrW05VTV9MQU5FU107DQo+ID4gIAlib29sIHR4X3Rlcm1fZml4Ow0KPiA+ICAJ
dW5zaWduZWQgaW50IHNhdmVkX2ljbV9jZmcwOw0KPiA+ICAJdW5zaWduZWQgaW50IHNhdmVkX2lj
bV9jZmcxOw0KPiA+IEBAIC04MTgsMTEgKzgxOSwxNSBAQCBzdGF0aWMgc3RydWN0IHBoeSAqeHBz
Z3RyX3hsYXRlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiAgc3RhdGljIGludCBfX21heWJlX3Vu
dXNlZCB4cHNndHJfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4gPiAgCXN0
cnVjdCB4cHNndHJfZGV2ICpndHJfZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKwlp
bnQgaTsNCj4gDQo+IGkgaXMgbmV2ZXIgbmVnYXRpdmUsIHNvIHlvdSBjYW4gbWFrZSBpdCBhbiB1
bnNpZ25lZCBpbnQuDQoNCk9LLiBXaWxsIHVwZGF0ZSBpbiB2Mi4NCg0KPiANCj4gPg0KPiA+ICAJ
LyogU2F2ZSB0aGUgc25hcHNob3QgSUNNX0NGRyByZWdpc3RlcnMuICovDQo+ID4gIAlndHJfZGV2
LT5zYXZlZF9pY21fY2ZnMCA9IHhwc2d0cl9yZWFkKGd0cl9kZXYsIElDTV9DRkcwKTsNCj4gPiAg
CWd0cl9kZXYtPnNhdmVkX2ljbV9jZmcxID0geHBzZ3RyX3JlYWQoZ3RyX2RldiwgSUNNX0NGRzEp
Ow0KPiA+DQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShndHJfZGV2LT5jbGspOyBp
KyspDQo+ID4gKwkJY2xrX2Rpc2FibGUoZ3RyX2Rldi0+Y2xrW2ldKTsNCj4gDQo+IFdoeSBpcyB0
aGlzIG9ubHkgY2xrX2Rpc2FibGUoKSwgYW5kIG5vdCBjbGtfZGlzYWJsZV91bnByZXBhcmUoKSA/
IFNhbWUNCj4gcXVlc3Rpb24gZm9yIHhwc2d0cl9yZXN1bWUoKS4NCg0KSXQgY2FuIGJlIGNsa19k
aXNhYmxlX3VucHJlcGFyZSgpIGFuZCBjbGtfcHJlcGFyZV9lbmFibGUgaW4gc3VzcGVuZCgpIGFu
ZCByZXN1bWUoKSByZXNwZWN0aXZlbHksIHdpbGwgdXBkYXRlIGluIHYyLg0KDQo+IA0KPiA+ICsN
Cj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtODMyLDYgKzgzNywxMyBAQCBz
dGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIHhwc2d0cl9yZXN1bWUoc3RydWN0DQo+IGRldmljZSAq
ZGV2KQ0KPiA+ICAJdW5zaWduZWQgaW50IGljbV9jZmcwLCBpY21fY2ZnMTsNCj4gPiAgCXVuc2ln
bmVkIGludCBpOw0KPiA+ICAJYm9vbCBza2lwX3BoeV9pbml0Ow0KPiA+ICsJaW50IGVycjsNCj4g
PiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShndHJfZGV2LT5jbGspOyBpKysp
IHsNCj4gPiArCQllcnIgPSBjbGtfZW5hYmxlKGd0cl9kZXYtPmNsa1tpXSk7DQo+ID4gKwkJaWYg
KGVycikNCj4gPiArCQkJcmV0dXJuIGVycjsNCj4gDQo+IEluIGNhc2Ugb2YgZXJyb3Igd2UgbmVl
ZCB0byBkaXNhYmxlIHRoZSBjbG9ja3MgdGhhdCBoYXZlIGJlZW4NCj4gc3VjY2Vzc2Z1bGx5IGVu
YWJsZWQgYWxyZWFkeS4NCg0KVGhhbmtzIGZvciBicmluZ2luZyB0aGlzLiBXaWxsIGJlIHVwZGF0
ZWQgaW4gdjIuDQoNCj4gDQo+ID4gKwl9DQo+ID4NCj4gPiAgCWljbV9jZmcwID0geHBzZ3RyX3Jl
YWQoZ3RyX2RldiwgSUNNX0NGRzApOw0KPiA+ICAJaWNtX2NmZzEgPSB4cHNndHJfcmVhZChndHJf
ZGV2LCBJQ01fQ0ZHMSk7DQo+ID4gQEAgLTg2NSw2ICs4NzcsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGRldl9wbV9vcHMgeHBzZ3RyX3BtX29wcyA9IHsNCj4gPiAgc3RhdGljIGludCB4cHNndHJf
Z2V0X3JlZl9jbG9ja3Moc3RydWN0IHhwc2d0cl9kZXYgKmd0cl9kZXYpDQo+ID4gIHsNCj4gPiAg
CXVuc2lnbmVkIGludCByZWZjbGs7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+DQo+ID4gIAlmb3IgKHJl
ZmNsayA9IDA7IHJlZmNsayA8IEFSUkFZX1NJWkUoZ3RyX2Rldi0+cmVmY2xrX3NzY3MpOyArK3Jl
ZmNsaykgew0KPiA+ICAJCXVuc2lnbmVkIGxvbmcgcmF0ZTsNCj4gPiBAQCAtODgyLDYgKzg5NSwx
MiBAQCBzdGF0aWMgaW50IHhwc2d0cl9nZXRfcmVmX2Nsb2NrcyhzdHJ1Y3QgeHBzZ3RyX2Rldg0K
PiAqZ3RyX2RldikNCj4gDQo+IFRoZXJlJ3MgYW4gZXJyb3IgY2hlY2sgYWJvdmUgdGhhdCBuZWVk
cyB0byBqdW1wIHRvIGVycl9jbGtfcHV0IHRvby4NCj4gDQo+ID4gIAkJaWYgKCFjbGspDQo+ID4g
IAkJCWNvbnRpbnVlOw0KPiA+DQo+ID4gKwkJZ3RyX2Rldi0+Y2xrW3JlZmNsa10gPSBjbGs7DQo+
ID4gKw0KPiA+ICsJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShndHJfZGV2LT5jbGtbcmVmY2xr
XSk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gDQo+IEl0IHdvdWxk
IGJlIG5pY2UgdG8gbW92ZSB0aGUgZHJpdmVyIHRvIHJ1bnRpbWUgUE0gdG8ga2VlcCB0aGUgY2xv
Y2tzDQo+IGRpc2FibGVkIHdoZW4gdGhlIFBIWSBpc24ndCBpbiB1c2UuIEl0IGNhbiBiZSBkb25l
IGluIGEgc2VwYXJhdGUgcGF0Y2guDQoNClN1cmUgdGhhbmtzLiBJIHdpbGwgcGxhbiBmb3IgdGhh
dCBhcyB3ZWxsLg0KDQpUaGFua3MsDQpNYW5pc2gNCg0KPiANCj4gPiArDQo+ID4gIAkJLyoNCj4g
PiAgCQkgKiBHZXQgdGhlIHNwcmVhZCBzcGVjdHJ1bSAoU1NDKSBzZXR0aW5ncyBmb3IgdGhlIHJl
ZmVyZW5jZQ0KPiA+ICAJCSAqIGNsb2NrIHJhdGUuDQo+ID4gQEAgLTg5OSwxMSArOTE4LDE3IEBA
IHN0YXRpYyBpbnQgeHBzZ3RyX2dldF9yZWZfY2xvY2tzKHN0cnVjdCB4cHNndHJfZGV2DQo+ICpn
dHJfZGV2KQ0KPiA+ICAJCQlkZXZfZXJyKGd0cl9kZXYtPmRldiwNCj4gPiAgCQkJCSJJbnZhbGlk
IHJhdGUgJWx1IGZvciByZWZlcmVuY2UgY2xvY2sgJXVcbiIsDQo+ID4gIAkJCQlyYXRlLCByZWZj
bGspOw0KPiA+IC0JCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCQkJZ290byBlcnJfY2xrX3B1dDsN
Cj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4NCj4gPiAgCXJldHVybiAwOw0KPiA+ICsNCj4gPiArZXJy
X2Nsa19wdXQ6DQo+ID4gKwlmb3IgKHJlZmNsayA9IDA7IHJlZmNsayA8IEFSUkFZX1NJWkUoZ3Ry
X2Rldi0+Y2xrKTsgcmVmY2xrKyspDQo+ID4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGd0cl9k
ZXYtPmNsa1tyZWZjbGtdKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gLUVJTlZBTDsNCj4gPiAgfQ0K
PiA+DQo+ID4gIHN0YXRpYyBpbnQgeHBzZ3RyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gQEAgLTkxMyw2ICs5MzgsNyBAQCBzdGF0aWMgaW50IHhwc2d0cl9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJc3RydWN0IHBoeV9wcm92aWRl
ciAqcHJvdmlkZXI7DQo+ID4gIAl1bnNpZ25lZCBpbnQgcG9ydDsNCj4gPiAgCWludCByZXQ7DQo+
ID4gKwlpbnQgaTsNCj4gDQo+IHVuc2lnbmVkIGludCBoZXJlIHRvby4NCj4gDQo+ID4NCj4gPiAg
CWd0cl9kZXYgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpndHJfZGV2KSwgR0ZQ
X0tFUk5FTCk7DQo+ID4gIAlpZiAoIWd0cl9kZXYpDQo+ID4gQEAgLTk1MSw3ICs5NzcsOCBAQCBz
dGF0aWMgaW50IHhwc2d0cl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0K
PiA+ICAJCXBoeSA9IGRldm1fcGh5X2NyZWF0ZSgmcGRldi0+ZGV2LCBucCwgJnhwc2d0cl9waHlv
cHMpOw0KPiA+ICAJCWlmIChJU19FUlIocGh5KSkgew0KPiA+ICAJCQlkZXZfZXJyKCZwZGV2LT5k
ZXYsICJmYWlsZWQgdG8gY3JlYXRlIFBIWVxuIik7DQo+ID4gLQkJCXJldHVybiBQVFJfRVJSKHBo
eSk7DQo+ID4gKwkJCXJldCA9IFBUUl9FUlIocGh5KTsNCj4gPiArCQkJZ290byBlcnJfY2xrX3B1
dDsNCj4gPiAgCQl9DQo+ID4NCj4gPiAgCQlndHJfcGh5LT5waHkgPSBwaHk7DQo+ID4gQEAgLTk2
Miw5ICs5ODksMTYgQEAgc3RhdGljIGludCB4cHNndHJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gPiAgCXByb3ZpZGVyID0gZGV2bV9vZl9waHlfcHJvdmlkZXJfcmVn
aXN0ZXIoJnBkZXYtPmRldiwNCj4geHBzZ3RyX3hsYXRlKTsNCj4gPiAgCWlmIChJU19FUlIocHJv
dmlkZXIpKSB7DQo+ID4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAicmVnaXN0ZXJpbmcgcHJvdmlk
ZXIgZmFpbGVkXG4iKTsNCj4gPiAtCQlyZXR1cm4gUFRSX0VSUihwcm92aWRlcik7DQo+ID4gKwkJ
cmV0ID0gUFRSX0VSUihwcm92aWRlcik7DQo+ID4gKwkJZ290byBlcnJfY2xrX3B1dDsNCj4gPiAg
CX0NCj4gPiAgCXJldHVybiAwOw0KPiA+ICsNCj4gPiArZXJyX2Nsa19wdXQ6DQo+ID4gKwlmb3Ig
KGkgPSAwOyBpIDwgQVJSQVlfU0laRShndHJfZGV2LT5jbGspOyBpKyspDQo+ID4gKwkJY2xrX2Rp
c2FibGVfdW5wcmVwYXJlKGd0cl9kZXYtPmNsa1tpXSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJl
dDsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHhw
c2d0cl9vZl9tYXRjaFtdID0gew0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gDQo+IExhdXJlbnQg
UGluY2hhcnQNCg==
