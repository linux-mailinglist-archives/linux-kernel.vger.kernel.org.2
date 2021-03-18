Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22678340043
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCRH3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:29:35 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:64134
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229540AbhCRH3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:29:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M52uAzZrfZC6fg8Ypp0+4NgqhCaMm/U1M+YSi06fsblz6gIxse4X2KME+ZFzs8m4PA8zVpX0P5kZAiTnEXjok3ZJEqspyQwgpZM6o+ZvdNQ0TpabPH+zx02s69L0yW8jT5ZJS91fL32tjuEzP5hVwz3NK8M2PgPggUim93h8qzSrBxox7U7lgmdseAxZ+DMuZOa5+6G1WBBx4e5rCIycnggYSMwPK+B5s53EZf+z7XeFOMuOpqz/jf0ebDa3unaMlhAbnE8VnBHVMT5JPyXiBsg3HiuNbDf96DqluUjEl7U7dL3caQS8LolTR5yeLMCvPYGRGzx/6U60emRsd3UtXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNn6tRBRJEZD/TyifBM01V6VgSpHK2sR+ygDlzdJq0U=;
 b=UCRs3Jte4N8trnXbCa7Cg89gJTU3hxSN2o7UH7WcSWie6f/0fqzQxKVr6yTg4yNKH+IomgnADIE6nAMoyaZOAtFKuWany9I2mG7cK5VrsMVp3Rhr5KGRnrgZEgSIFC7T7/Ul0KsIc4T6GswYJMKkAAJHeYkjEfh0pCWYcNvePyi+s5dtFm4TOjD1SICrZ6Xp82XX/JPR90LfbS8Ii/yfnTTrWygJcghcRtmkgYeVEAWlyVQ8mStVZ7zw7QbzEQDT8PzTrh50EgPwDCz7+KyHCPHwGfQvffAkEXAHqOZTUJQb7Iw9fdACEkNiEjY572OFkG0X2tJEtHFOoclH40+Alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNn6tRBRJEZD/TyifBM01V6VgSpHK2sR+ygDlzdJq0U=;
 b=ZbyXtnS5JW+IniiugWNtR7z5qYMOTureuCcuocZCZFEDnxBif6EOemgxbKwW4K6M4/M12/gx5u1+cshPWfbZjMpv843LRlEToOqypy7SNVtU6wz/Hgc/JfZ/k6Jn35R4jol6a09hVoljWntAAB9Zc9IikJqt26+M07Gi1OsBPMo=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AS8PR04MB8167.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 07:29:31 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::b4f2:d00e:93a1:8685]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::b4f2:d00e:93a1:8685%3]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 07:29:31 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] optee: enable apci support
Thread-Topic: [PATCH] optee: enable apci support
Thread-Index: AQHXFxnYXTe1sDRwj02IbFElWYAqQqqH2isAgAAG5YCAAX5yYA==
Date:   Thu, 18 Mar 2021 07:29:31 +0000
Message-ID: <AM6PR04MB54133297642949378521C6A9F1699@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20210312083653.38780-1-ran.wang_1@nxp.com>
 <20210317080442.GA3018337@jade>
 <CAMj1kXFg1a5ezoVBvrZ7xc7oM2zH-Phu1eNoXv+YZ+Yda1k7SQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFg1a5ezoVBvrZ7xc7oM2zH-Phu1eNoXv+YZ+Yda1k7SQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9cf9c44a-f3cf-4051-9e11-08d8e9df9249
x-ms-traffictypediagnostic: AS8PR04MB8167:
x-microsoft-antispam-prvs: <AS8PR04MB81672AB367BE54CB203CB3E9F1699@AS8PR04MB8167.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V5BUFUDoq/paVDBPQZxoRfNDiGImgJnAOmNMjoQUtgLVs82T3LzqsmAg8cuUfnQkENiPlGAaae2W+ImHB6K1tcL0gyNmGv4R6Ci7Rmhk2mEFSiZvyVLhi0NK/GeP6zZgC+2pp0AEvp1IxiQSTUBU0WK06ioQe2C5aSXX6o+Y+Mtpp7twxhHbIy0H9xtNwWa0YOpCmwEETgMDf6+IcXuaYdOIVq2yzeu66FO8nNEYkGDHBJHym3mm4315ughSbyQf1cGT7UD1iJ1F1f30AyGNDYqqotXGIRXDwb1r0qTImWtI7Prw3/MNgKdS/OweZtWXJUvkG0Ts+u16dRLsDz50Fe8YyP5MRiozrni/Mcmz3xPYv6B3yUOG21DpFcDpRePn+SwDRRjMWvEG/jLSidRD0Z22M9zcJSpeuu3baE+X8oCwMw9GxzwEpQrQ9HnVYWW9nJKa+/at0BS8AmSzt6DXli2sscG2wqUR/9LKkStTUbPfTeOwzI/DNJcrmU6twwWa3UnL7ioyhfoPGOjNKJPSkqhlnVnNHNI8rbI91hi3AheB2pHawYFZQEfdmA7zRT93s4je3ZcyoojoxLryE2mexM/Bc/jiowbkKaBdMUV9DD04f20EZTEkfIMgolWaAIY6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(8936002)(38100700001)(55016002)(316002)(8676002)(86362001)(9686003)(4326008)(478600001)(66946007)(71200400001)(66476007)(186003)(26005)(64756008)(66446008)(76116006)(66556008)(2906002)(6916009)(54906003)(6506007)(7696005)(53546011)(52536014)(33656002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TWdER25Za2hDeFVaT2Fsb0c2R0VLN0lXbnVGYi94R0pOVy90Z0pZaXBHbXdN?=
 =?utf-8?B?VytKRm1Ib0tPY0V3NGtBbmh6UWdOS2NwdnVKeStQMm84U0xpVWxhcGIvZjI2?=
 =?utf-8?B?ekMwQU1DaTVlWUUxOVVxZkZwYzBMRUJ6VHhUTlVYYis1eWNMbGd3ZTZhWGYy?=
 =?utf-8?B?OGxLazRtamNrYUY2R1B5NkdJMGRWdWV0NU8vQVhFUlhUSWM0dURXZHNua3kz?=
 =?utf-8?B?MjdwTkh3TlZ3a0JDeDJXWm9BTmxYT3VHSlNUMEhQOEVhbm1kalEwYSsrTEhi?=
 =?utf-8?B?cnc5TXBLOTE4Y2JmUVhaLzFzKzJXbjYrM05kUHNmQnRXUlNTZUFYWGtXT1dN?=
 =?utf-8?B?cGVUaGVOclRaRGNWUDdwQTZKOEJoTEtPWXB0bEFXdzRwSStsZDdpYlBWV3pU?=
 =?utf-8?B?OVhwU0RmUGxkR3FuRk05c0NQSjVOdVo3VXFXL0VvaDJ5MUh5ZkdOUDlOTy9N?=
 =?utf-8?B?Y2JYWnk4ZmNQSmJqNER3aDc1bDZobGg0azhQK2lFU2JBNTFacWQ2ZC9yUXJI?=
 =?utf-8?B?ZmRhalUzL0xtMW1LWWxtUjJJWk5vNTMwK3FrTWFJdjhoZm8xa3l5M0t5cmJY?=
 =?utf-8?B?UUxsY0xTdTl5T3FiWlJUZW1kOHdPY3ljMGw2WWFuYkdDdjRBQWQxcm9yaUNQ?=
 =?utf-8?B?dTNDUVhocTAxckg1NE9HZzU1NEVmZ2lRNUR2dTJzQktZQXoxTFhPcThWNDJ2?=
 =?utf-8?B?bjVzRWIvU3U1TVdFdCttMkdpVVczRm5Ob1VBTmYzWENmU0p2QTlJTkNkcUcw?=
 =?utf-8?B?R05zc3YyRHBpRy80WEROdVpacTJlSW8yVi9sZ2x4eVdybE4wVkRiZkZlOGZt?=
 =?utf-8?B?d2N4TlU5cjExRFFFQ0lOMHB6clRtY2N0ZENTaERNL2E5M1ZLZmM2OVc1dFY2?=
 =?utf-8?B?K0RWUlFEZlpKWFNZbHdTbG9UREErOE1DSDFUeDRWeTZTNWtHTGROY2dMKzVa?=
 =?utf-8?B?YzBsc2JabVNmVE9aU3NOR3dkdm9tdkMwY0lKRW8xUGM0NW9MYXZ5S3d6NG9x?=
 =?utf-8?B?K0c1N1lWNzJDcjhqbW5xUmxQTm04N1NtREQ5cm5DWTFJV25ubUY1anA0MTQ2?=
 =?utf-8?B?UWErTWY1a1A0YUhOWnJIV25NcVh1TXFUZHVLMHZ1TVB6SlNheHRONE95RTV5?=
 =?utf-8?B?QS9OdFVSemJKRGgyV2NncUNEQlVCczVzNCs1RWtRL3hJQk1qWTRHeWhDbzJj?=
 =?utf-8?B?TEJvMWN3V1pHZmxadVdqTXpZRVBzSnF2NmNhdXhLMzVTMEdBSkJjZ05YRlpX?=
 =?utf-8?B?OFdOOFBROXpEMURVYXVWRzZ5RFJOY3BmNTFqenE3b1VLOC9BYW44TE9QUDd6?=
 =?utf-8?B?YXJGbTdUSEY1ZUQzNzQ3MDcydjRBaDF3emlEem1WUDlrWmV0d0lYd3VCVWY5?=
 =?utf-8?B?dnZ4QmczdEdwTDV4eHlEaFo5QkRaY1lOWk1pb1ZoZjlhSi9seG5YY3hCajBY?=
 =?utf-8?B?VGFMTUp2a3Npc1locGFOakFhWUFtR1pROXJIdjhxeUVBL0RWem9HZXlVUGxn?=
 =?utf-8?B?SWk0NW5qQ1VLUit3bGpzV3VYazVObUs2T2gxRWdNVW4xRjdqNjhKc3ZGWWwy?=
 =?utf-8?B?YnNGb2svMngxZ1hUUCsrLyswZU5SLzU2YVdaUmJ3RTc0OUZtSHAyRGowWk1h?=
 =?utf-8?B?bWY0dHE5cUVBSWxCWnhmWHRkYUozaWg5U0c1aUh3VTgzdmZDV1Q4dEQzemRa?=
 =?utf-8?B?SXM2bjJCcS9Mbnpxay9sL1pWaDVUanhlTW5MVlpoSXNLYmozd0wwR3YvaGRm?=
 =?utf-8?Q?7RNEzpqNxlNkW0VnHVOhSGNGRlnweGArP/CQ0Y6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf9c44a-f3cf-4051-9e11-08d8e9df9249
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 07:29:31.3282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6jyCypoKs7rU6A35NaxNWxoqLRbJKuwHI1jBBadZTaMGLbcjbF2xDKFv62WE4ZoVgsUwP4xc09vjK+xH4rhJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8167
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJkLA0KDQoNCk9uIFdlZG5lc2RheSwgTWFyY2ggMTcsIDIwMjEgNDoyOSBQTSwgQXJkIEJp
ZXNoZXV2ZWwgd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDE3IE1hciAyMDIxIGF0IDA5OjA0LCBKZW5z
IFdpa2xhbmRlciA8amVucy53aWtsYW5kZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBP
biBGcmksIE1hciAxMiwgMjAyMSBhdCAwNDozNjo1M1BNICswODAwLCBSYW4gV2FuZyB3cm90ZToN
Cj4gPiA+IFRoaXMgcGF0Y2ggYWRkIEFDUEkgc3VwcG9ydCBmb3Igb3B0ZWUgZHJpdmVyLg0KPiA+
ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJhbiBXYW5nIDxyYW4ud2FuZ18xQG54cC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3RlZS9vcHRlZS9jb3JlLmMgfCAxMCArKysrKysrKysr
DQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvb3B0ZWUvY29yZS5jIGIvZHJpdmVycy90ZWUvb3B0ZWUv
Y29yZS5jDQo+ID4gPiBpbmRleCBjZjQ3MThjNmQzNWQuLjhmYjI2MWY0YjlkYiAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvdGVlL29wdGVlL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy90
ZWUvb3B0ZWUvY29yZS5jDQo+ID4gPiBAQCAtNSw2ICs1LDcgQEANCj4gPiA+DQo+ID4gPiAgI2Rl
ZmluZSBwcl9mbXQoZm10KSBLQlVJTERfTU9ETkFNRSAiOiAiIGZtdA0KPiA+ID4NCj4gPiA+ICsj
aW5jbHVkZSA8bGludXgvYWNwaS5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9hcm0tc21jY2Mu
aD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvZXJybm8uaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGlu
dXgvaW8uaD4NCj4gPiA+IEBAIC03MzUsMTIgKzczNiwyMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZA0KPiA+ID4gb3B0ZWVfZHRfbWF0Y2hbXSA9IHsgIH07ICBNT0RVTEVfREVW
SUNFX1RBQkxFKG9mLCBvcHRlZV9kdF9tYXRjaCk7DQo+ID4gPg0KPiA+ID4gKyNpZmRlZiBDT05G
SUdfQUNQSQ0KPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgb3B0ZWVf
YWNwaV9tYXRjaFtdID0gew0KPiA+ID4gKyAgICAgeyAiT1BURUUwMSIsfSwNCj4gDQo+IFlvdSBj
YW5ub3QganVzdCBpbnZlbnQgQUNQSSBISURzIGxpa2UgdGhhdC4gVGhlIDQgY2hhcmFjdGVyIHBy
ZWZpeCBpcyBhIHZlbmRvciBJRCB0aGF0IGlzIGFzc2lnbmVkIGJ5IHRoZSBVRUZJIGZvcnVtLCB0
aGUgNCBmb2xsb3dpbmcgZGlnaXRzIGFyZQ0KPiB1cCB0byB0aGUgdmVuZG9yIHRvIGFzc2lnbiwN
Cg0KVGhhbmtzIGZvciB0aGlzIGluZm8uIENvdWxkIHlvdSBwbGVhc2Ugc2hvdyBtZSB3aGVyZSBJ
IGNhbiBmaW5kIHRoZSBndWlkZS9leGFtcGxlIGZvciB0aGlzIGFzc2lnbiBwcm9jZXNzPw0KDQo+
ID4gPiArICAgICB7IH0sDQo+ID4gPiArfTsNCj4gPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGFj
cGksIGR3YzNfYWNwaV9tYXRjaCk7DQo+IA0KPiBkd2MzX2FjcGlfbWF0Y2ggPz8gRG9lcyB0aGlz
IGV2ZW4gYnVpbGQ/DQoNCk15IGJhZCwgSSB3YXMgcmVmZXJyaW5nIGR3YzMgY29kZSBhcyBhbiBl
eGFtcGxlLCB3aWxsIGNvcnJlY3QgaXQuDQoNCkJ1dCBsb29rcyB0aGlzIHR5cG8gZGlkbuKAmXQg
dHJpZ2dlciBlcnJvciBpbiBteSB1bml0LXRlc3QuDQogDQo+IA0KPiA+ID4gKyNlbmRpZg0KPiA+
ID4gKw0KPiA+ID4gIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG9wdGVlX2RyaXZlciA9
IHsNCj4gPiA+ICAgICAgIC5wcm9iZSAgPSBvcHRlZV9wcm9iZSwNCj4gPiA+ICAgICAgIC5yZW1v
dmUgPSBvcHRlZV9yZW1vdmUsDQo+ID4gPiAgICAgICAuZHJpdmVyID0gew0KPiA+ID4gICAgICAg
ICAgICAgICAubmFtZSA9ICJvcHRlZSIsDQo+ID4gPiAgICAgICAgICAgICAgIC5vZl9tYXRjaF90
YWJsZSA9IG9wdGVlX2R0X21hdGNoLA0KPiA+ID4gKyAgICAgICAgICAgICAuYWNwaV9tYXRjaF90
YWJsZSA9IEFDUElfUFRSKG9wdGVlX2FjcGlfbWF0Y2gpLA0KPiA+ID4gICAgICAgfSwNCj4gPiA+
ICB9Ow0KPiA+ID4gIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIob3B0ZWVfZHJpdmVyKTsNCj4gPiA+
IC0tDQo+ID4gPiAyLjI1LjENCj4gPiA+DQo+ID4NCj4gPiBUaGlzIGxvb2tzIHNpbXBsZSBlbm91
Z2guIEFyZCwgaXMgdGhpcyB3aGF0IHlvdSBoYWQgaW4gbWluZCBlYXJsaWVyPw0KPiA+DQo+IA0K
PiBOb3QgcmVhbGx5Lg0KPiANCj4gT24gU3luUXVhY2VyLCB3ZSB1c2UNCj4gDQo+ICAgICBEZXZp
Y2UgKFRPUzApIHsNCj4gICAgICAgTmFtZSAoX0hJRCwgIlBSUDAwMDEiKQ0KPiAgICAgICBOYW1l
IChfVUlELCAweDApDQo+ICAgICAgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKCkgew0KPiAgICAgICAg
IFRvVVVJRCgiZGFmZmQ4MTQtNmViYS00ZDhjLThhOTEtYmM5YmJmNGFhMzAxIiksDQo+ICAgICAg
ICAgUGFja2FnZSAoKSB7DQo+ICAgICAgICAgICBQYWNrYWdlICgyKSB7ICJjb21wYXRpYmxlIiwg
ImxpbmFybyxvcHRlZS10eiIgfSwNCj4gICAgICAgICAgIFBhY2thZ2UgKDIpIHsgIm1ldGhvZCIs
ICJzbWMiIH0sDQo+ICAgICAgICAgfQ0KPiAgICAgICB9KQ0KPiAgICAgfQ0KPiANCj4gd2hpY2gg
ZG9lcyBub3QgcmVxdWlyZSBhbnkgY2hhbmdlcyB0byBMaW51eC4gU28gSSBkb24ndCB0aGluayB0
aGlzIHBhdGNoIGlzIG5lZWRlZCBhdCBhbGwgdGJoLg0KDQpUaGFua3MgZm9yIHRoaXMgZXhhbXBs
ZSwgYnV0IGFjdHVhbGx5IEkgZmFpbGVkIHRvIHRyaWdnZXIga2VybmVsIG9wdGVlIHByb2JlIGZ1
bmN0aW9uIGJ5IHVzaW5nDQphYm92ZSBjb2RlIGluIEFDUEkgdGFibGUuDQoNCkFuZCBJIGFtIGN1
cmlvdXMgaG93IHRoaXMgJ2NvbXBhdGlibGUnIHByb3BlcnRpZXMgYmUgcGlja2VkIHVwIGJ5IGtl
cm5lbCB3aGVuIHRyeSB0byBtYXRjaCBkcml2ZXIgaW4gQUNQSSBtb2RlPw0KDQpNeSB1bmRlcnN0
YW5kaW5nIGlzIHRvIGdldCBpdCBkb25lIGJ5IGZlZWRpbmcgLmFjcGlfbWF0Y2hfdGFibGUgd2l0
aCBzb21ldGhpbmcsIHJpZ2h0Pw0KDQpSZWdhcmRzLA0KUmFuDQoNCg==
