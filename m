Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64FA43AFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhJZKRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:17:03 -0400
Received: from mail-eopbgr1400128.outbound.protection.outlook.com ([40.107.140.128]:2683
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231354AbhJZKRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:17:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKUjjxCZqsBJI904vjxKaA5UBZElnvrK5y95hv7gM5F5b/Eob/Ie4RTWi5bpvZsbUEN3znzOq3EoqWIdx1DWFWzi42acxYmiwfHuJ1014LoJlWOdqy1abSITFmdHYM55PkuOUfrdAaqOYBf0ZZciJlf3JqBC9I/dmB2t3Vi3GkgAgRBOeNlvPsiAPexAkyI1E+BzY6D3JtOiXYJImJsihogEdPbFXp6Vt5PoK+z7CkEtsLS0BrjjWGtRIFio/591S743r4eAgK6yVQf1Xhv0uJI1BU3vRn9gfKRDvPPCohx9HsrWCTXmgfnIX9rahVHMlKB0eHRINMNBg35NJW6MnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjDC8fbZtUGqVyVUe71xoJCwWpQv360selPbCBTHStA=;
 b=KmLPfX79cuK17HSg+Zu/kDu0DgvPA7Or5I9NkQaT+mreP8nbVVq1H1h/OzY0QdoC0gJGuRS34/b1SWfTQMD1oTeDmWgGYXGTp0LdXJJ8lT0IUW1aqsJj6ScIyrT6VRyOg6gyVyda3CIT27gMDK+Hlks7Dui0zy3YMeiY6c3RY82nzkN32BBuzRiVyNfenCWAWrBQQJ6/CcMCTkbhHY9wMF8k4qB3Z0iPhBMtOTjDha22M0XwQ7XbZ1O1oJ+xO1D4U05FYuXzUnRhzzCCgqHiDENx8dO8m2UwPV9fnM1aBhWmaZBt01rzbdegi2Nfjc8Ff9mlVXEmclcnZj7WGkPYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjDC8fbZtUGqVyVUe71xoJCwWpQv360selPbCBTHStA=;
 b=zU7Nrmh80x/9fQDmv8rtLUY5VR4eGD5d3McwlguRLs92uKcrEufHtKh8itPW++3k8Z9BQWi2p7bK0miHitkIByBNpt7Eo7j5U0cfAvvZuc9VbdFVyOQIRCubd9fvIMrYnVuJAWDDlBDEd8VmpBs0MQJpgk4YEE1fjz0zyS0M9YY=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYAP286MB0873.JPNP286.PROD.OUTLOOK.COM (2603:1096:402:3a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Tue, 26 Oct 2021 10:14:35 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 10:14:35 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGRyaXZlci9hdGE6IGZpeCBwb3RlbnRpYWwgbnVs?=
 =?utf-8?Q?l_pointer_dereference_on_pointer_last=5Fsge?=
Thread-Topic: [PATCH] driver/ata: fix potential null pointer dereference on
 pointer last_sge
Thread-Index: AQHXyaIQml2db3PSfEiAc9XccIavRavkq1WAgABledA=
Date:   Tue, 26 Oct 2021 10:14:35 +0000
Message-ID: <TYCP286MB118819CA099EC7AFEA8B5B908A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <20211025131304.17226-1-cyeaa@connect.ust.hk>
 <81a99dd1-0ef6-9bd0-31c0-b0934023746b@opensource.wdc.com>
In-Reply-To: <81a99dd1-0ef6-9bd0-31c0-b0934023746b@opensource.wdc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: opensource.wdc.com; dkim=none (message not signed)
 header.d=none;opensource.wdc.com; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3123d32a-9d7a-470a-e9f9-08d998696942
x-ms-traffictypediagnostic: TYAP286MB0873:
x-microsoft-antispam-prvs: <TYAP286MB08730EEBD4B8C6B0F3E0E9D78A849@TYAP286MB0873.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yltVoAeK6xUJ9fknORscyfT+1teuggM39t85ySeWduoqfWp+IHW4BLnz8cn/yhVGyY7GOJZKj8U8bHhm+RnOAPFvOBrStu1Z46KZ8gup4rg50pLZoclqYCVWF7yW1Wdi2auYJXJZUYsRQ+gG9AcZB+O6pfFi4k1nc+3gF/dvOV7PvgY4kfN0koDekgbW77NWIrMhfZU7x+ZTRnlCg7RtgWvY5FDSW3LVg7+iN1G5X2X3wKMjfRaZMEduW2dF/5ZFKn1Lg7fz9IbU/l203vSTfTki5tsTWDvyhO+N/Z1uxFvzArNE6mh4mKAS7OhrwnJeDQXr4x6dVWyPejR2pWzIJHJp3WqCVPOqSrjQJ13Gu22PofmUdaniljf4c2m6xHAYNebWkYpRJ9AgNEMXbJYEqLfPEN+LUgyr/NwKB7C2DMnb60vB4QVaqz+b+flUfR4MPSSbMtgJ2X7+6nkOZjG1sv0SwKxOGt7OQU3mAiz/4cZ6XOchs//nKR3y2nmOh4vZNsvWMVSryBRRxnktxjLUJTWPzp4rUvZJTkJjqeeLp8Ctz3sR9q/0spL4uyu8rkspgJD+YeddlRln6ZMo1A+BK9zxodXhgu1Zs9rRL0PCmR3IRn9io3YL0rFHCE+5y8H+aY5nNaocVzoE9fOSu70JX3UNsMpcQDPSIc3pNyWKrzDeoEpVSLbFk24gagwmffLbQuL7RlJGlrpvcL3O4yi/hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(38100700002)(33656002)(55016002)(86362001)(26005)(66556008)(52536014)(2906002)(9686003)(38070700005)(64756008)(6916009)(508600001)(4326008)(786003)(224303003)(7696005)(316002)(186003)(53546011)(5660300002)(8936002)(71200400001)(66946007)(76116006)(66446008)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjYvaFNYcVEwd2FDaGVXVmJhWW4yM2ZMWFBGNWhheEFqcS9XbHRDWUZsaEJ6?=
 =?utf-8?B?TFdqcFpOVGRQMU1Gdi9MSC91bG1jR24wck9mOXorQ3ppZmo2d0lWL2ZmdDZ6?=
 =?utf-8?B?MlVFTGNhTWZPUktrVTZKM0Z0by9zYXlacGczaUc5ZkdRY1lwaXliYnhGYVdX?=
 =?utf-8?B?VmozV1NPRHRLbnpsRFk1SVRxaG1xdDZTZTJvUHJsbG1mWnluUDhWN25jNTlw?=
 =?utf-8?B?QkJnS1FXQnlvcFVmRmx0WUJSRTZGVmVIQk5BR0JUeDFSOTlnbC9VejFOU3lE?=
 =?utf-8?B?ZncwSDdkcjVyckdMcVhHZUh3Nkp6N3hZQ0VkTi9aQUJOL0lkRWR5TGhXYnR3?=
 =?utf-8?B?N3VqekxEWDI2L09FQlFzNm1qQ3JtempKSUhZaU5tQnF5WnZFTXRBV2FuNVA1?=
 =?utf-8?B?L3JCTnU5WTZBU3BuUEorRzBpY0xCazBrbnlOSkx6YXYyOHdDOGxnUGtLeWpF?=
 =?utf-8?B?TXk1a1lBUmM1UzZDK1lrdkJ0VmVmZXhuN1BMenF5bW5aNmhJNThjZnptNkNl?=
 =?utf-8?B?TElKajcwMEhtYndpNUNJUHFBNEdVQ21mK2lGcXpxWXdvRW42MHVreUdQdjUv?=
 =?utf-8?B?WlNlc1RaSmJqakRIQnIxTkZLcGUrcGpoVDREOG1zVTlLL1lzcitrODZvRTJP?=
 =?utf-8?B?Sm51cEtjWkRHRW44Y1NSaExZUm5mcFF0dTlDUUFKRWVvQXpmYkJKL1EzZnox?=
 =?utf-8?B?aGdod1lFekRUdElkc21YV0wwSU5UZ2VWcXJ1YTdpMG1qdWFUOE0raDhIM1N6?=
 =?utf-8?B?UTk0NW9LZFpNdDBrRmltamMvdkZtMWRKdlJ2bEs3YVhyeVFYWlYycmUwd3lI?=
 =?utf-8?B?WFFtR2d2c1VuRFNxOUd0V0xoWVArVmZKaU1wdXAzTExnTEVPZGxhcnNlckRD?=
 =?utf-8?B?cnlSSWR2NVNCMWlUYUp0dUhuVWxacXRjR2VkTUk0cW1oU2RDbVcxZkJqOTM4?=
 =?utf-8?B?MDY0OHpMMkx1UlFtZjB1K3ExZUVQRFdqZFRoL1ZPMnFsQzJPR0czT2ZiMU4y?=
 =?utf-8?B?cDZ0YzFFNkZjUk5qd3kvM3VzWDBIcGZiWVBrblBMb2dqNFhIZE1zR2w4VnJW?=
 =?utf-8?B?N3YwWjAwRmU3WE04SlZseUNHRFF5S3Y0Yll3cGI3YytyeEQyYkpHbjYwTEh6?=
 =?utf-8?B?WUxjeTlERXQ1S0tEUVgvekdsMVl5KzI2T1oyajRnazhSNHR5NHRjbkhVOWgy?=
 =?utf-8?B?dXlIbmtyQXFXOG5JUTRyTDd6K3E4VWJxK09kMWxIM2tod2txMHZqbWxCallS?=
 =?utf-8?B?K0o5dm1RZ2xTaEZkMDRkVExVS2xndml2amlXQUlQakM1K2J6YjJ5bDdJYy94?=
 =?utf-8?B?Y3lqalc3VTJNczBhRlRFNFhpVG4xZ1lVcEdacllSQ21BbDRGelU1TnhqL3VD?=
 =?utf-8?B?cW9MRk80NWtyR3pLcmp3eXdJWlpLeFlMZ0YrV3NBUW9IRUdBcXlVRUI3bTAw?=
 =?utf-8?B?ZXlnVFVubzNLSHgrSTB2VXBIaktTZ3ZqN2pwbXpxaWs0VFNvd3JOdzExSDU3?=
 =?utf-8?B?cWVWa0JZSnhVcDdHMWhDUHlFYlJ4Y0dYNldGaWhlZWliZFJTS25oTlpFc1o5?=
 =?utf-8?B?dkVRTG5temVaYXVnSVpuTTZJVjdVR0RvQy80VDdWelp5Z3V0OElhVElKRmIz?=
 =?utf-8?B?Z3NVY2tFMDlHZWtYcXV6aTF4MnhaL1RLSTFsaVdYM29kc1M2aVdsQUhQT3Ax?=
 =?utf-8?B?ZDgwWndJYTA0QXFoODBneDBHWVJWNXdXVnZkRHhWcFZxSm5mcVF3V0hjUjQ4?=
 =?utf-8?B?SDg0K1gxOEh6U3Q3a2hnb1d6RU5VUHhUM21XS2xCY09aaTY0dnE5UUIrYklL?=
 =?utf-8?B?VTFVRUFETDVWUXFHRlRaS1p3SzJHQTJWK3duanNmaThrTm1TSi9tWWRPb0Zm?=
 =?utf-8?B?dGZHUmVoUGdKWjNyc0VnL3A3bTM4amNTdFpDMTlib21qUjFldXFLa2lCd3Ez?=
 =?utf-8?B?RmJXR0NvaDNrU0RNQzB5YWs5VjRTUUlmVEc1UE1CK0ZLT0Q0MDA2eHhZUUox?=
 =?utf-8?B?Rk9nZkpSNEdLMjg1cGJrRzg1ZjVKYWI3em41VUFaVFppa3FtZDQyclVPcDBV?=
 =?utf-8?B?T1c1NlJybEJ6OW4vN2w4Q2FsaS9TQnE3TEpaaXVveVJSNFFOTElRblY1WUQ4?=
 =?utf-8?B?VklVZ0VxV3FoUXIzanAwOXdpL3JNanQybzFTUWhhenAvc2NuaXMrZ3Y2Tk1K?=
 =?utf-8?Q?RcMhMGucbhD5KkcsfdsHCxg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3123d32a-9d7a-470a-e9f9-08d998696942
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 10:14:35.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Qk9/wpv3TZK4yRRx9HkI6BrzpE5yp5as80ossOSL0HShNm9/DAs6wXDN5kSJ8ftNYi17ptoaJE93xAY+zdTfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAP286MB0873
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R290IGl0LiBUaGFua3MgZm9yIHlvdXIgcmVwbHkgaW4gc3VjaCBkZXRhaWwuDQoNCkJlc3QgUmVn
YXJkcywNCkNoZW5nZmVuZw0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IERh
bWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbT4gDQrlj5HpgIHm
l7bpl7Q6IDIwMjHlubQxMOaciDI25pelIDEyOjEwDQrmlLbku7bkuro6IFlFIENoZW5nZmVuZyA8
Y3llYWFAY29ubmVjdC51c3QuaGs+DQrmioTpgIE6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCuS4u+mimDogUmU6IFtQQVRDSF0gZHJpdmVyL2F0YTogZml4IHBvdGVudGlhbCBudWxsIHBv
aW50ZXIgZGVyZWZlcmVuY2Ugb24gcG9pbnRlciBsYXN0X3NnZQ0KDQpPbiAyMDIxLzEwLzI1IDIy
OjEzLCBDaGVuZ2ZlbmcgWWUgd3JvdGU6DQo+IFRoZSBwb2ludGVyIGNzX2Rlc2MgY291bGQgYmUg
bnVsbCBpZiB0aGUgbG9vcCBpcyBub3QgZXhlY3V0ZWQsIHNvIA0KPiB0aGVyZSBpcyBhIHBvdGVu
dGlhbCBOVUxMLVBUUiBkZXJlZmVyZW5jZSBpc3N1ZS4gRml4IHRoaXMgYnkgYWRkaW5nIGEgDQo+
IG51bGwgY2hlY2sgYmVmb3JlIGRlcmVmZXJlbmNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hl
bmdmZW5nIFllIDxjeWVhYUBjb25uZWN0LnVzdC5oaz4NCj4gLS0tDQo+ICBkcml2ZXJzL2F0YS9z
YXRhX3NpbDI0LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvc2F0YV9zaWwyNC5jIGIvZHJpdmVycy9hdGEv
c2F0YV9zaWwyNC5jIGluZGV4IA0KPiAwNmExZTI3YzRmODQuLjJiZDU5NWRhNzk5ZiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9hdGEvc2F0YV9zaWwyNC5jDQo+ICsrKyBiL2RyaXZlcnMvYXRhL3Nh
dGFfc2lsMjQuYw0KPiBAQCAtNzg1LDYgKzc4NSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBzaWwy
NF9maWxsX3NnKHN0cnVjdCBhdGFfcXVldWVkX2NtZCAqcWMsDQo+ICAJCXNnZSsrOw0KPiAgCX0N
Cj4gIA0KPiArCWlmICghbGFzdF9zZ2UpDQo+ICsJCXJldHVybjsNCj4gIAlsYXN0X3NnZS0+Zmxh
Z3MgPSBjcHVfdG9fbGUzMihTR0VfVFJNKTsgIH0NCg0KSSBkbyBub3QgdGhpbmsgdGhhdCB0aGlz
IGZpeCBpcyBuZWNlc3Nhcnk6IHNpbDI0X2ZpbGxfc2coKSBpcyBjYWxsZWQgb25seSBpZiB0aGUg
cWMgaGFzIEFUQV9RQ0ZMQUdfRE1BTUFQIHNldCAoc2VlIHNpbDI0X3FjX3ByZXAoKSkgYW5kIHRo
YXQgaW4gdHVybiBpcyBvbmx5IHNldCBpZiBhdGFfc2dfc2V0dXAoKSBzZWVzIGF0IGxlYXN0IG9u
ZSBzZyBlbnRyeS4gU28gdGhlIGxvb3AgaW4gc2lsMjRfZmlsbF9zZygpIHdpbGwgYWx3YXlzIGJl
IGV4ZWN1dGVkIGZvciBxYyBtYXJrZWQgd2l0aCBBVEFfUUNGTEFHX0RNQU1BUCBhbmQgc28gbGFz
dF9zZyBjYW5ub3QgYmUgTlVMTC4NCg0KLS0NCkRhbWllbiBMZSBNb2FsDQpXZXN0ZXJuIERpZ2l0
YWwgUmVzZWFyY2gNCg==
