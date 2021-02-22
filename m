Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F10D32133D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBVJjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:39:06 -0500
Received: from mail-bn8nam08on2086.outbound.protection.outlook.com ([40.107.100.86]:51425
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230122AbhBVJiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:38:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXe+HDMUa+zljU7Qk7Y9gHs0U/EeTn1NJuUX5r7ndiLFuvi26eaTkLAU7RUkVjP0dTBEpn0uf2e8Dw6Dv+tjwtFAEBtZEU4cO++N7wVZa9sfCGUeYNXyesg0zkfkjuWOgxv3zkUjL6nYVPUND1oiHwlhIzP0sz3t43vdwu1iG8YKaJSpgXeRHx0vsFfKII0AjykSrsFSEYaX8s2CYJ1zraiZvCgShsCTxvRigW/JOeozsfH7l2cVv5jRAbVh5yAyAlvoKP6GNI//VrJmBWScDlR5GuLGO0mXN4FhABtivUPanSDshL3c/E1n37nVx9e8tNbvVrV4688ejfe/5uS1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/vZGFosfiBI25GG9YF+O6T4GOgBsIn0Ih23cISsr+o=;
 b=kA74gYKZ5ayKp7MPNLjsqqIJ5rZtCOvevgWMhAZL1ZjlGPFEwOG/+vIJB2wmqwAIaSVOTSmZgvSgTUoOaM2zA2vViyPwA7FaeM6ifdk+ooC/qGoVHIwKuFf63we7MSedmVWHyEKlZyWyCup+i7a2a0s1ASCXRelnPNYse+pjI9Zp4bNBM7OKEEY4s+emG2SPcEPLV5N08dl+xgc8Z+U/GTALHVg0jjFIzrAHdXyHgFkw/olF767WVU3AeL5f3kgYGtcl91SvEgexkm3hYNklfDZabGIDXIys2KzFvVT2wLRy4WZAdFCsoSRys/ZNaumZi5wSRlktDV9eW79KavcGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/vZGFosfiBI25GG9YF+O6T4GOgBsIn0Ih23cISsr+o=;
 b=f3yqDSIqG1uFDJxa/d1DfuY8orkexzQBUKfVLLow8Kck+AczkdjJSFJKhmgWcbr5BBgGNGISfm0QbCDTO/DTp5wcIPOTNMo2RikqI07Erj6zaN+W6uWbpNCZK0+f6cX6xUXCssCbM01BAI3idJMpgA0Qutr0t8kORVd0iQYqauc=
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MWHPR11MB1422.namprd11.prod.outlook.com (2603:10b6:300:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Mon, 22 Feb
 2021 09:37:57 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b%4]) with mapi id 15.20.3846.038; Mon, 22 Feb 2021
 09:37:57 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>, Marc Zyngier <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: RE: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Thread-Topic: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Thread-Index: AQHW6uDlVrPMRNLctkuz9Bvou6uZzqpjw5uQgABcSgCAAAJ7AIAABI6A
Date:   Mon, 22 Feb 2021 09:37:57 +0000
Message-ID: <CO1PR11MB48499549EB56C7EE119E175DF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
References: <20210115015050.26657-1-meng.li@windriver.com>
 <CO1PR11MB48497CB7B11EDA65A3941FDCF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
 <36cc2d810d90237947ad953ebd6b9fb7@kernel.org> <20210222092114.GE376568@dell>
In-Reply-To: <20210222092114.GE376568@dell>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 203be17d-e032-4529-f6ab-08d8d71589ae
x-ms-traffictypediagnostic: MWHPR11MB1422:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1422A650DAF854888DA49021F1819@MWHPR11MB1422.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bw7i8o3SJYRX3Y2sazT6KviUz82CFfp4KZ1nQC7Py5IuHXnS3jvq04HvCxjuHw6DJRD6nwC6EAr0Ky4b0hcAdI4sr7xwBrjKxOASt/zEONzcxXsQPz/7JFqSl60YzDY7MZ+cLPAtKgsvJsRwrZz+5S7YAkEpiPdLeDJDHSa7iULRuheRR3ZbznNjcul62lnFZWiONcNRMuknFFQhQk/NaMxDCAOLMgaoR+nc9HZZPmNZNSISYlW06TXDypW3Nbq9FFJBbMgROyEJATL2r93rEwV3xNi8UWe0sKA71gS+KpFpLDo4GrZ0ono5O1mcjpr/c21nY536Jm5S/QSz+W/uq4RIg5oQm6hGRQSp4+H40IUxczSppTcj8zv4M3pMSaXcmOk8DOb/RBQl5JI/19rcnb23mHfbJJZXR4OgYL0hv4fyrf3MmThESe5kYkWnyKTp/RI+A9RxwnBzqMe7lJLNw/xAPcRukPZBskqy0rz1wmzpYNo+DtRnml0hG/IX/kNVGetgQD4dVSxYv51WwoybvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39840400004)(136003)(396003)(346002)(8936002)(5660300002)(478600001)(54906003)(55016002)(7696005)(66946007)(64756008)(66446008)(66556008)(83380400001)(33656002)(66476007)(110136005)(316002)(26005)(71200400001)(186003)(6506007)(4326008)(86362001)(52536014)(76116006)(107886003)(8676002)(9686003)(53546011)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?L0R0cnBiRTlPbVZUWEw3VDBPZFY5K09Oa0F4NUtDMFVSSWtLNkVLek9HaTJv?=
 =?utf-8?B?MlNDZ0YrQXZXeHB2SjNIN1lVSWlQQ1VFVU9mc25YNnVhaVJaU2dkZmdHUXY5?=
 =?utf-8?B?SC9UM1BJOHVWWWdGVCtQTFdnK3VMYVdqT1JuSmtGMEQwRFladEpDOC93MlZP?=
 =?utf-8?B?ekdzUGIydU9VTlQ1NUUxcndwUXlBcW9WOFgwemFNdXRuK2I0VzM0UXNZSUcv?=
 =?utf-8?B?eDVBOW5IdDJkQ3llKzd6aGNiN3FUMTVzdUFBZisxOXRpYllpb0JBbkFoakY0?=
 =?utf-8?B?aGtOVzNmY3BQbVFlejNodlIwZVBYMW9RT1lVT1JKTVVOOTVxa05JZFBjeGZp?=
 =?utf-8?B?RzNlemZDTmViNWdJWGtFRVJEZlNreDBVTmx4NFlMYjRyeVdTaUREZXNMNU1u?=
 =?utf-8?B?UUczdlpxWGs1dFVkbHpCUkJDRE5BTmZnZDI3bmhIM2tZN1MwR01kMjRDcjg2?=
 =?utf-8?B?RnhPWHN0cHh6OXU2eTQyRHB1UXJIeDd4S0R6N2NOMmNRNVVvSG40aFRuUTJN?=
 =?utf-8?B?UDVyTFp5N3UwL0kyUHNZbFRMY2NyRXY5eG9lbGhWazVmWEF3T0xTdGlMam1w?=
 =?utf-8?B?NmlCZ3ZPSklNd1VRWDhQS1ZxcWpwNzFTSFdmR0J1b0xSeEYxcDFJeGFnTFJE?=
 =?utf-8?B?czcvZGxiOGowRFd0eUVhM2ZPYUxpNExlUlF3NDZCc1k3SkpFL3M5SFRLcGhG?=
 =?utf-8?B?UVFyQkE5MWM2dVdMYlNLdUV5ZDNoMHg2K3RXNjdhRzVGNGN0a29oSDMwYThY?=
 =?utf-8?B?UWl4bTdJSTNhNXBTMGwzeitwd3lNWHdzZGdCeisybFhrSjY2S2tuVHlVTjB3?=
 =?utf-8?B?YkZQRkE1cjRrOCtmeFRiVTZzRjhQbTlCT0tqUUczdHVBOStpbXJwamJMS01I?=
 =?utf-8?B?OU1QS0x2b2hBUjJaaGorZmtEUXRiaG9jRC9iUllUbUprSUZiM25tV0N3cC9O?=
 =?utf-8?B?Y0YrbXBRZGZ1YmdwMTk1MVhuUTZCTENvdWpiZjgrU25WQ2g2bWxOVUg2R1lO?=
 =?utf-8?B?dmU5VzRDZzZLN0JWblZEWjFwUm1zMGlTTlordFpSVzUxYjFmWGt1cXh1NjFz?=
 =?utf-8?B?L1U2NHdlc1JBQnB6UGluV0VWTnFwUTlOZkJhUlQwVW5YUkEybTNzQUxOTlZ0?=
 =?utf-8?B?SWUzdFlBTHFqY0JvdFFkOEFZa1lnL2hINjNTT3dNWE85TGlpL3g1WS8zaDc3?=
 =?utf-8?B?WTlYVGViRUZOTnVWMUxORlZ1M1UySzFyM1o3dUIwZDNPRzJIZHFjUEpJWmVD?=
 =?utf-8?B?aHBUdG4wOXYzWE85d21hVVQzcGRsR2R5Sm5Ea3FCbDNTNEhvQnFoRTcyTGhl?=
 =?utf-8?B?SlB3M0lqdkIzTGtvaGYvVk1ham5JbUJVUmpyeVNNcmVXbzRTajh1QXpGNENo?=
 =?utf-8?B?blpTR2NuVmw0QzlUb013Rjl5YkZoZGhHOXVNWXhLZ2Y1ZFZCcnFRejRTUkJZ?=
 =?utf-8?B?eWl1a0hQNERtS0kwZEhhcDdRalVrc3FTUEI1RVNjNVFlU243NlJJT2c0ZFZy?=
 =?utf-8?B?SHk2c1BIWnE4UHFEYURYVjl4NU93SVhPVVBVMEI2U1IyT3gvdk5kdVExcVhT?=
 =?utf-8?B?cHZRUm1CWlNxUEt0Z2U1Tkg3NjIxUHo4Y2E3TzQ2SXZHS1dwbUJZRzNDaGVs?=
 =?utf-8?B?RTJNWGVDMEJBOHFrWERHK1IraURSUVpaOXk0Tk0vVnlXaTdwUHNBS2JMcUhu?=
 =?utf-8?B?VlE5ZDBMZS9lZGJtM0lzRWxjdk5sWUpna0NiZmliYlNVaHlmUXRNZmVDNjdl?=
 =?utf-8?Q?4T/FUpuF0MXq+Lq/VjJuvnQyFlb3RtWs12m/bNH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203be17d-e032-4529-f6ab-08d8d71589ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 09:37:57.6786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBkI+JpzPBLR1sTBGhGubJ8nXjXoHDM4drlh3D4cIXC9qCYWuqR2WY4rtalYGJagNsL2Pnku3A04IZgJo4/oaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1422
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBhbGwgb2YgeW91ciBjb21tZW50cy4NCg0KUmVnYXJkcywNCkxpbWVuZw0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMjIsIDIwMjEgNToyMSBQTQ0K
PiBUbzogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCj4gQ2M6IExpLCBNZW5nIDxNZW5n
LkxpQHdpbmRyaXZlci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBhcm5k
QGFybmRiLmRlOyBIYW8sIEtleGluIDxLZXhpbi5IYW9Ad2luZHJpdmVyLmNvbT4NCj4gU3ViamVj
dDogUmU6IFt2Ml1bUEFUQ0hdIFJldmVydCAibWZkOiBzeXNjb246IERvbid0IGZyZWUgYWxsb2Nh
dGVkIG5hbWUgZm9yDQo+IHJlZ21hcF9jb25maWciDQo+IA0KPiBbUGxlYXNlIG5vdGU6IFRoaXMg
ZS1tYWlsIGlzIGZyb20gYW4gRVhURVJOQUwgZS1tYWlsIGFkZHJlc3NdDQo+IA0KPiBPbiBNb24s
IDIyIEZlYiAyMDIxLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+IA0KPiA+IEhpIExpbWVuZywNCj4g
Pg0KPiA+IE9uIDIwMjEtMDItMjIgMDM6NDUsIExpLCBNZW5nIHdyb3RlOg0KPiA+ID4gSGkgTWFy
YyZMZWUsDQo+ID4gPg0KPiA+ID4gSXMgdGhlcmUgYW55IGNvbW1lbnQgb24gdGhpcyBwYXRjaD8N
Cj4gPiA+IENvdWxkIHlvdSBwbGVhc2UgaGVscCB0byByZXZpZXcgdGhpcyBwYXRjaCBzbyB0aGF0
IEkgY2FuIGltcHJvdmUgaXQNCj4gPiA+IGlmIGl0IHN0aWxsIGhhcyB3ZWFrbmVzcz8NCj4gPg0K
PiA+IElmIHlvdSBhcmUgY29uZmlkZW50IHRoYXQgdGhlIHJvb3QgaXNzdWUgaGFzIGJlZW4gZml4
ZWQsIG5vIG9iamVjdGlvbg0KPiA+IGZyb20gbWUsIGJ1dCBJJ20gbm90IGluIGEgcG9zaXRpb24g
dG8gdGVzdCBpdCBhdCB0aGUgbW9tZW50ICh0aGUgYm9hcmQNCj4gPiBJIGZvdW5kIHRoZSBwcm9i
bGVtIG9uIGlzIGluIGEgYml0IG9mIGEgc3RhdGUpLg0KPiANCj4gSSdtIG5vdCBrZWVuIG9uIGZs
aXAtZmxvcHBpbmcgdGhpcyBwYXRjaCBpbiBhbmQgb3V0IG9mIHRoZSBrZXJuZWwuDQo+IFNvbWVv
bmUgcmVhbGx5IG5lZWRzIHRvIHNwZW5kIHNvbWUgdGltZSB0byBtYXAgb3V0IHRoZSBmdWxsIGxp
ZmUtY3ljbGUgYW5kDQo+IHByb3Bvc2UgYSAocG9zc2libHkgY3Jvc3Mtc3Vic3lzdGVtKSBzb2x1
dGlvbi4NCj4gDQo+IC0tDQo+IExlZSBKb25lcyBb5p2O55C85pavXQ0KPiBTZW5pb3IgVGVjaG5p
Y2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMgTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2UN
Cj4gc29mdHdhcmUgZm9yIEFybSBTb0NzIEZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRl
ciB8IEJsb2cNCg==
