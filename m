Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF135444DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 04:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhKDDcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 23:32:51 -0400
Received: from mail-eopbgr1310122.outbound.protection.outlook.com ([40.107.131.122]:55328
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229893AbhKDDct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:32:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOR/LGrnWn2pNFjOZCWw6kI9omFTWhygN7F9y4AoKok+8uvc453q+JqYKm4Yr553oSnav3KCBl68ZKXWLn575N/eHRMLSJ4NRZJ6FDrcFLmvHXQUBJhIIlJFxQRYaWuLsIQb2WLBw7UiMN+wDzz/riZ3Zxfn/CNJtOb314FUuNGiFxgpapyIy7sDL32CX4AlsOxx27K5RKFG5zWp7wT55mvMfsJN0M7QlEgIV11wl45AsUStWNqUXd6c26Wk4hwH6CfbtdC08HOEB41BZGzzLuaM0xpa3dvtj4YEuJjurpNvElP6/TVA7kSYYnOwOrMtU1+91vKCy/r7meF+nckoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw59Wo1s2v6xaM4tDQySnqZ9sYyREEILKDaEGzsjO1U=;
 b=AWjc6T98MIlz4wFhlSEzvAl/rwm5745cT9c97aT390KkVXBPZi95sARfdPc4H/INOsKiQYR0SxtTZO/gbmGUaPU5TVDJ7pruyr8DYRCobuvpyTB5+mC79IZjpZBKXMzV/GpUOkT26k0HklZJEOsxgvzhGIpzDaVkhIFmupPitxi6FJMGleuW0jXpkzPcNKxChzCJLhJi8n3bLuyuAWUrhAoWosxNYEB1byhFTfAz8QtKUl0R/5QJRiRLfdDS2D4WRf9uPsJ/6EFCf6dt1IceniSb0yRKXv0Mm56gnWVPiGUPBHdcEbNBKKqiIpAotllt99PaiJkpA8g6Tn02N9ajQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw59Wo1s2v6xaM4tDQySnqZ9sYyREEILKDaEGzsjO1U=;
 b=JOxlRLyyOPoCC1kKchdtStfrh99Pwahqzlb4rRX9P4XOCAQXshOaU78xsb3Vzt5Y/MbN6I7WpKOtCPEQCOKcC5gMlR1uprimdsfYnpWB0qFnku+d5yAmqL4toqcxCSjFRCa5wMrsVHgSMW/e9DkFcGpVY8VR0uZhh7QnjxYD6wg=
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com (2603:1096:203:df::11)
 by HK0PR04MB2900.apcprd04.prod.outlook.com (2603:1096:203:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 03:30:08 +0000
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::bc14:ea40:ec:43af]) by HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::bc14:ea40:ec:43af%3]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 03:30:08 +0000
From:   =?big5?B?SG93YXJkIENoaXUgKKr0q2G6zSk=?= <Howard.Chiu@quantatw.com>
To:     Patrick Williams <patrick@stwcx.xyz>,
        Howard Chiu <howard10703049@gmail.com>
CC:     "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Topic: [PATCH v1] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Index: AQHX0L4GVObJRPhBBkedf8m4Kd5flKvyqs2w
Date:   Thu, 4 Nov 2021 03:30:08 +0000
Message-ID: <HKAPR04MB40039608E14195D859DE7EC5968D9@HKAPR04MB4003.apcprd04.prod.outlook.com>
References: <20211103071417.388388-1-howard.chiu@quantatw.com>
 <YYKatBCCroiYxLew@heinlein>
In-Reply-To: <YYKatBCCroiYxLew@heinlein>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: stwcx.xyz; dkim=none (message not signed)
 header.d=none;stwcx.xyz; dmarc=none action=none header.from=quantatw.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcd667d1-027a-449d-19be-08d99f4366d8
x-ms-traffictypediagnostic: HK0PR04MB2900:
x-microsoft-antispam-prvs: <HK0PR04MB29001A7178D67E5274D9E2B4968D9@HK0PR04MB2900.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSOGgkZ+0raVwAX5SZF5t2JdWc5WlrYMWwTM2NCpTR7x5AvhLJAYB2DUYsMyFlT8kXbSYQwZb6Pr/n7aHZa23yc8UVABjjO6IG+tc68hkav2eHmNnV6MCLVWv4Bpy9dGn2r1D/kM36w/6gAm4x+eh27ng8hm8+lzu2NKTKb26iF9TuS4nDtqqVNLTbR6FfzibcOtVvWgGgGz84NHbTa64mx8OwhJk6c+xXL221gxUsIieKQ6WlopPRBhf1BFl306oWUDwTwrvGVA13jQbbKMfE16caSlcPJvFGxKNlvPY9MswY+34M0uh1G6bOLppN6Nh86dbbi4wKDv60tzCPtI1eEZ95TGP/NaCcHSts8g1i1QKDFYZwDvw1d3BTAAvB60NZEph+hgN3fzfqyOceOjy6ixBpb4RQT3PLlr82ZBDV7v6xBPqJXT64WnmmTB7qMmbi4L3/xeSrePhLwcsq0uT3cuqHonHo6+pNjcfM2fmLCg9/1q8MbLheQ/oNIBVEh73Gn2V1T5d8GMv8GHS2DdpCU7sBcjiiKcBlSMgIhIOVPhc+V3blbhgshmCOzr1UEbtUtijX+ETC7wTYbXWiE+aZxInBXXbSdA1yWPvv7L4on+yri16HfcI3wthXO9MRqpTFrOwxBs+3/3PgJILG4vcBQliBPEuRoPd+OCU8N8bpFfe6+7z1beM0OHgYMY7qsEJUX7BWHZ+zopG8MUAggHhhvWjt74DFV1lHEr0yeyPdGVwNtHbTm7wfilRbYaVmJZ4+CgqZ5ZUMFkB33/a0rl8qjaZzI0w5MeNammYM7xALk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR04MB4003.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47680400002)(71200400001)(122000001)(8936002)(7696005)(8676002)(316002)(54906003)(33656002)(86362001)(7416002)(508600001)(966005)(85182001)(66556008)(66476007)(186003)(64756008)(66446008)(38070700005)(110136005)(52536014)(38100700002)(66946007)(9686003)(55016002)(26005)(2906002)(5660300002)(6506007)(83380400001)(76116006)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?WkRTbjJNT2FlbXlDUmVSS1hQS2ZoWG9NWWtEeXNnbTN4UDlBbThqQk10VWM0aHUz?=
 =?big5?B?bDJHUklCK003a3pxcEVVQVNPTjh0dFdWK0FsMG5rNFlsbzBqTnBYY0RCc1plSHIv?=
 =?big5?B?cncreHJHYlAyTzhXQS8weHdEa2VZRDVTNGRYdVowc3Y5ZXpxYWpwRnc0bWVOSkZQ?=
 =?big5?B?czg3ZUM2Z1l6NmlncldsSDdDSkVPM2ZRQ2tlRlh6Q05xdzZmVWNxa3VXazNSREND?=
 =?big5?B?b05DcTA5SCtWZHJyTVVOeS9VcllUbG1ucHppRFd4ZUVUU0l5cjloMHRCWTZqRDhi?=
 =?big5?B?K1o0WGJMTGlrOEU3aXNRWjdzVGozaFJHenVnMjJORVdmbUd4STBRRjBHRFR6aVlj?=
 =?big5?B?NFMwazVkLzV4MEVNVVNWSER5M1dtNEU0Q1BBeXM0NG1sNi9HRkFiaGVkZXh1QmdX?=
 =?big5?B?SCtkTDc0VGp5aTIzeEw4SFN5ZzBybkNXeEZBc2pGaWlSRHFqSkdmYnYwc2crQUx2?=
 =?big5?B?NHNMK1NCTFlUVnluMW9wYlRJZDYzVk9jWHcrZDlwSDRqV1NMY0JyUTl1QkYraVhY?=
 =?big5?B?UkZFMjBFS1BteG1EUEdvdVdMUVE2M05xRHVnR3RzMHZmZVd4RU5wYU1NWFdRVGZK?=
 =?big5?B?NjNVV1N2bTF4VllWdkVHTVlGVWYrd0x0b1VqdTl6SmtGQnRxVHdOclliMXoyQjJ1?=
 =?big5?B?N3psTzFCclhBaktxYjNLNndVSHp1amNOd1ZPdlRoRkEzSkp5UnJ2ejZKMmVsLzF2?=
 =?big5?B?QzM1ZElSRHhyQ2VQWS9NSzBYejlGMHloWXdiWDB5d2VKOGQySzQweXJ2bnY5ZXJO?=
 =?big5?B?QTMyd1prcnM5aGM0SFBYcjVkdXpVL1g3eXJobFJPaTJEdy9tM3pHeUQyeU1NR0Uy?=
 =?big5?B?RWlOOVBOV2l3dmZUdXZmL1ZsQklVQjczSnZYRTJGbGVTRHZ1bE9wL1R2WVlWYXA1?=
 =?big5?B?aXBZMk9PQ3lpNEpaVldzR21ERWtGR2k2VFVHYXhHT3VJSlZYUFhSSGk1N1llUjdQ?=
 =?big5?B?S3NWaXVmcG9TV1BWUHlKak9kbTZta1NaZWRmR1hETGFhN09GUlBpajFRdW5JbnRE?=
 =?big5?B?b3RKQUkwOHNjV0dtWmNEWGYrVjZmTkVMc1Mwb1I5aERERCtyakNmdEtSM2NPQUtC?=
 =?big5?B?RjBVMDJTUWZzOFlZMEJ6Vkx4RHd6dnErQnBQZUNFcUs1UmFBMTVNVnZFNG1FWGtn?=
 =?big5?B?NmVqeWR3SDRmYjdWZU52RmtsVnBBVVpzUndRVVI1SFZkWXBkbUtZR0JrRkE4NFhZ?=
 =?big5?B?U0cyd2ZMVTFHbG5XdDdQVFl3a0lOczk5cFBsemgxV0RhbTNiU0dIYVdzcmZCTEhs?=
 =?big5?B?SzU0NnYrcmhDQW53Y3VqWlJyNmtNVlR5dnpaaWJVV2tVYlVjam1jUkYrVHp2cHQ1?=
 =?big5?B?SEpPRU91UG5jRGUrZGlOWFNNRTZROXUvcUV2MGpLT0dFQk0vdTIydE1CWFhrM1FP?=
 =?big5?B?VUFJek85KzNqZW0rditId3I5VHpmVlZ1Yno0SVVjd0xVYnVJRzBCWFhuMFRlVzRi?=
 =?big5?B?aTB0K3Z4czdPNytLb1NjbGRCOXByRG5MRzBYNHR3Y3d5SDVSSndjTjlqVHdid0Nj?=
 =?big5?B?d3dtaklWeEdyNWlmano4em91MXJ1THV3eTVBNjZtMHRLY3RCSm1tbTJJc3BVV3lw?=
 =?big5?B?cERXclk0YlZiZjF6bjFneUpzY0Fka1hmM2dHb09ZUVB4T284TldtSVlBbEJLUGg0?=
 =?big5?B?ZitMWXEybVlhTjFDUXBhc29rTElkbXFPdGVLUy9GYTF4clpVZGR4cXVuRXFQSEI0?=
 =?big5?B?azNkZTRFdWxZM2hBTCsvSm81RWtKcDZBZmkrTHhEaHZBTEZWVmd0MXpxOHRCdWlB?=
 =?big5?B?VXFXakZHSzVldGZPQVlKMXFIRU02N09QQU44QkxyOVNhTGpMaGFiQnlZTFVkQ1FJ?=
 =?big5?B?Z1RNbkZoTUpjY3hCQUk5TjFCUDNnM21xS0oweWplMFJXL0RoK1QzcWRBVklhcXkx?=
 =?big5?B?ZFZaR3k2dlg3bUZaakJsVEFYajI2ZE13VjNSNkVZazFEY3R1YmlDVzMybWM1T0JI?=
 =?big5?B?QzRTTE4rR2ZLcGZRWW1uc3l3NUt3YjU1alltTTlTWkVUL3RWSUNMZFp3Ykd6REdS?=
 =?big5?B?TDJTNFFhUGVaOWtlNHZNK0htTy9yTEhzQlZ4aDhlYStjby9Sem9qeGt0RXAvL1hX?=
 =?big5?B?TWp3d0ErL0R1cXZKUVhYOG5tQmVXemZkOXRuWlEzbUFkaStZSjhEWlNUMGthQTB1?=
 =?big5?B?WTJaa09BPT0=?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR04MB4003.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd667d1-027a-449d-19be-08d99f4366d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 03:30:08.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2+j+HTOsJiQjX6rmFW+V7xCFjaIvvAm3OlvF+FlybkKxrJKqJhyv27iLNHASndtPI/DTkLb8PggRGiTVNYdsv0WLLba+X7vE8PdA5ypgoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF0cmljaw0KDQo+IEhlbGxvIEhvd2FyZCwNCj4gDQo+IFRoYW5rcyBmb3Igc3VwcGx5aW5n
IHRoaXMuICBJIGhhdmUgYSBmZXcgY29tbWVudHMgYmVsb3cuDQo+IA0KPiBPbiBXZWQsIE5vdiAw
MywgMjAyMSBhdCAwMzoxNDoxOFBNICswODAwLCBIb3dhcmQgQ2hpdSB3cm90ZToNCj4gPiBJbml0
aWFsIGludHJvZHVjdGlvbiBvZiBGYWNlYm9vayBCbGV0Y2hsZXkgZXF1aXBwZWQgd2l0aA0KPiA+
IEFzcGVlZCAyNjAwIEJNQyBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3dhcmQgQ2hp
dSA8aG93YXJkLmNoaXVAcXVhbnRhdHcuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9ib290
L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgLi4uL2R0cy9h
c3BlZWQtYm1jLWZhY2Vib29rLWJsZXRjaGxleS5kdHMgICAgIHwgMTE2MA0KPiArKysrKysrKysr
KysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDExNjEgaW5zZXJ0aW9ucygrKQ0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQNCj4gYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9v
ay1ibGV0Y2hsZXkuZHRzDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
TWFrZWZpbGUgYi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQ0KPiA+IGluZGV4IDdlMDkzNDE4
MDcyNC4uMmNjMmQ4MDRlNzVhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL01h
a2VmaWxlDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4gPiBAQCAtMTQ3
NCw2ICsxNDc0LDcgQEAgZHRiLSQoQ09ORklHX0FSQ0hfQVNQRUVEKSArPSBcDQo+ID4gIAlhc3Bl
ZWQtYm1jLWZhY2Vib29rLXdlZGdlNDAwLmR0YiBcDQo+ID4gIAlhc3BlZWQtYm1jLWZhY2Vib29r
LXlhbXAuZHRiIFwNCj4gPiAgCWFzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2Mi5kdGIgXA0K
PiA+ICsJYXNwZWVkLWJtYy1mYWNlYm9vay1ibGV0Y2hsZXkuZHRiIFwNCj4gPiAgCWFzcGVlZC1i
bWMtaWJtLWV2ZXJlc3QuZHRiIFwNCj4gPiAgCWFzcGVlZC1ibWMtaWJtLXJhaW5pZXIuZHRiIFwN
Cj4gPiAgCWFzcGVlZC1ibWMtaWJtLXJhaW5pZXItMXM0dS5kdGIgXA0KPiANCj4gSSBiZWxpZXZl
IHRoZSBwcmVmZXJlbmNlIGlzIHRvIGtlZXAgdGhlc2Ugc29ydGVkLg0KV2lsbCBiZSBmaXhlZCBp
biB0aGUgbmV4dCBwYXRjaA0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
YXNwZWVkLWJtYy1mYWNlYm9vay1ibGV0Y2hsZXkuZHRzDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMv
YXNwZWVkLWJtYy1mYWNlYm9vay1ibGV0Y2hsZXkuZHRzDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmFmMzBiZTk1ZmIyMw0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLWJsZXRj
aGxleS5kdHMNCj4gDQo+ID4gKw0KPiA+ICsJY2hvc2VuIHsNCj4gPiArCQlib290YXJncyA9ICJj
b25zb2xlPXR0eVM0LDExNTIwMG44IjsNCj4gPiArCX07DQo+IA0KPiBEbyB3ZSB3YW50IHRoaXMg
dG8gYmUgMTE1MjAwIG9yIDU3NjAwPw0KV2lsbCBiZSBtb2RpZmllZCB0byA1NzYwMCBpbiB0aGUg
bmV4dCBwYXRjaA0KPiANCj4gPiArCQlmYW4xX2VtYmVyIHsNCj4gPiArCQkJcmV0YWluLXN0YXRl
LXNodXRkb3duOw0KPiA+ICsJCQlkZWZhdWx0LXN0YXRlID0gIm9mZiI7DQo+ID4gKwkJCWdwaW9z
ID0gPCZmYW5faW9leHAgMTMgR1BJT19BQ1RJVkVfSElHSD47DQo+IA0KPiBJIHNlZSBhIG51bWJl
ciBvZiByZWZlcmVuY2VzIHRvICdlbWJlcicvJ0VNQkVSJy4gIEkgdGhpbmsgdGhlIGludGVudGlv
biBpcw0KPiAnYW1iZXInLg0KPiANCj4gICAgIGFtYmVyOiBhIGhvbmV5LXllbGxvdyBjb2xvciB0
eXBpY2FsIG9mIGFtYmVyDQo+ICAgICAgICAgICAgb3IgYSB5ZWxsb3cgbGlnaHQgdXNlZCBhcyBh
IGNhdXRpb25hcnkgc2lnbmFsDQo+IA0KPiAgICAgZW1iZXI6IGEgc21hbGwgcGllY2Ugb2YgYnVy
bmluZyBvciBnbG93aW5nIGNvYWwgb3Igd29vZCBpbiBhIGR5aW5nIGZpcmUuDQpXaWxsIGJlIGNo
YW5nZWQgdG8gImFtYmVyIiBpbiB0aGUgbmV4dCBwYXRjaA0KPiANCj4gDQo+ID4gKyZmbWMgew0K
PiA+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICsJZmxhc2hAMCB7DQo+ID4gKwkJc3RhdHVzID0g
Im9rYXkiOw0KPiA+ICsJCW0yNXAsZmFzdC1yZWFkOw0KPiA+ICsJCWxhYmVsID0gImJtYyI7DQo+
ID4gKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8NTAwMDAwMDA+Ow0KPiA+ICsjaW5jbHVkZSAib3Bl
bmJtYy1mbGFzaC1sYXlvdXQtNjQuZHRzaSINCj4gDQo+IElzIHRoaXMgYm9hcmQgdXNpbmcgNjRN
QiBvciAxMjhNQiBtb2R1bGVzPyAgTWFueSBvZiB0aGUgbmV3ZXIgc3lzdGVtcw0KPiBoYXZlIGJl
ZW4NCj4gc3RhcnRpbmcgdG8gdXNlIDEyOE1CLiAgSSBqdXN0IHdhbnQgdG8gY29uZmlybSB0aGlz
IGlzIGNvcnJlY3QuDQoxR2IgU1BJIGZsYXNoLCBNWDY2TDFHNDVHTUktMDhHDQo+IA0KPiA+ICsJ
c2xlZDBfaW9leHA6IHBjYTk1MzlANzYgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAibnhwLHBjYTk1
MzkiOw0KPiA+ICsJCXJlZyA9IDwweDc2PjsNCj4gPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsN
Cj4gPiArCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArCQlncGlvLWNvbnRyb2xsZXI7DQo+ID4g
KwkJI2dwaW8tY2VsbHMgPSA8Mj47DQo+ID4gKw0KPiA+ICsJCWdwaW8tbGluZS1uYW1lcyA9DQo+
ID4gKw0KPiAJIiIsIlNMRUQwX0JNQ19DQ0c1X0lOVCIsIlNMRUQwX0lOQTIzMF9BTEVSVCIsIlNM
RUQwX1AxMlZfU1RCWV8NCj4gQUxFUlQiLA0KPiA+ICsNCj4gCSJTTEVEMF9TU0RfQUxFUlQiLCJT
TEVEMF9NU19ERVRFQ1QiLCJTTEVEMF9NRF9SRUZfUFdNIiwiIiwNCj4gPiArDQo+IAkiU0xFRDBf
TURfU1RCWV9SRVNFVCIsIlNMRUQwX01EX0lPRVhQX0VOX0ZBVUxUIiwiU0xFRDBfTURfRA0KPiBJ
UiIsIlNMRUQwX01EX0RFQ0FZIiwNCj4gPiArDQo+IAkiU0xFRDBfTURfTU9ERTEiLCJTTEVEMF9N
RF9NT0RFMiIsIlNMRUQwX01EX01PREUzIiwiU0xFRA0KPiAwX0FDX1BXUl9FTiI7DQo+IA0KPiBJ
biBnZW5lcmFsLCBpbiBPcGVuQk1DLCB3ZSBoYXZlIGEgcHJlZmVyZW5jZSBmb3IgdGhlIEdQSU9z
IHRvIG5vdCBiZQ0KPiBzY2hlbWF0aWMNCj4gbmFtZXMgYnV0IHRvIGJlIG5hbWVkIGJhc2VkIG9u
IHRoZWlyIFtzb2Z0d2FyZS1vcmllbnRlZF0gZnVuY3Rpb24uICBQbGVhc2UNCj4gdGFrZQ0KPiBh
IGxvb2sgYXQ6DQo+IA0KPiANCj4gaHR0cHM6Ly9naXRodWIuY29tL29wZW5ibWMvZG9jcy9ibG9i
L21hc3Rlci9kZXNpZ25zL2RldmljZS10cmVlLWdwaW8tbmENCj4gbWluZy5tZA0KPiANCj4gQW55
IGZ1bmN0aW9uIHlvdSBzZWUgdGhhdCBpc24ndCBkb2N1bWVudGVkIHRoZXJlIHdlIHNob3VsZCB0
cnkgdG8gZ2V0DQo+IGRvY3VtZW50ZWQNCj4gYmVmb3JlIGZpeGluZyB0aGUgR1BJTyBuYW1lIHRv
IG1hdGNoIGl0Lg0KPiANCkkgaW50ZW5kIHRvIGRlbGV0ZSB0aGVtIGZvciBub3cgaWYgSSBoYXZl
IHRvIGRvY3VtZW50IHRoZW0gZmlyc3QsIGJlY2F1c2UgbW9zdCBvZiB0aGVtIGFyZSBwbGF0Zm9y
bS1zcGVjaWZpYyBHUElPLCBub3QgZm9yIGdlbmVyYWwgcHVycG9zZSBhbmQgYWxzbyBub3Qgc3Vp
dGFibGUgdG8gY3VycmVudCBPcGVuQk1DLg0KRm9yIGV4YW1wbGUsIE9wZW5CTUMgYmVsaWV2ZXMg
dGhlcmUgaXMgb25seSBvbmUgR1BJTyB0byBiZSB1c2VkIHRvIHBvd2VyIG9uIHRoZSBjaGFzc2lz
LCBidXQgQmxldGNobGV5IGhhcyBzaXguDQpJIGRlZmluZSBncGlvLWxpbmUtbmFtZXMgZm9yIGdw
aW9zZXQvZ2Vpb2dldC9waG9zcGhvci1tdWx0aS1ncGlvLW1vbml0b3IgdXNhZ2UsIGFuZCB0aGV5
IGNhbiBiZSByZXBsYWNlZCB3aXRoIGdwaW9jaGlwIG51bWJlciBhbmQgb2Zmc2V0IGluc3RlYWQu
DQpUaGUgZGlzYWR2YW50YWdlIGlzIHRoYXQgdGhleSB3b24ndCBiZSBodW1hbi1mcmllbmRseSB3
aGVuIFRFcyBkZXZlbG9wIHRoZWlyIHRvb2wgdG8gdGVzdCB0aGVzZSBHUElPcy4NCj4gPiArCQln
cGlvLWxpbmUtbmFtZXMgPQ0KPiA+ICsJCSJTTEVEMF9FTUJFUl9MRUQiLCJTTEVEMF9CTFVFX0xF
RCIsIlNMRUQwX1JTVF9JT0VYUCIsIiIsDQo+IA0KPiBUaGUgTEVEcyBhcmUgb25lcyBJIGtub3cg
YXJlIGFscmVhZHkgZG9jdW1lbnRlZCBpbiB0aGUgYWJvdmUgbGlua2VkIGZpbGUuDQpJIGNhbiBk
ZWxldGUgdGhlbSBiZWNhdXNlIGdwaW8tbGluZS1uYW1lcyBpcyBub3QgbmVjZXNzYXJ5IGZvciB1
c2FnZS4NClRoZXkgYXJlIGFkZGVkIGZvciBodW1hbi1mcmllbmRseSB1c2FnZSB3aGVuIHVzaW5n
IEdQSU8gdG9vbHMuDQo+IA0KPiA+ICsmaTJjMTMgew0KPiA+ICsJbXVsdGktbWFzdGVyOw0KPiA+
ICsJYXNwZWVkLGh3LXRpbWVvdXQtbXMgPSA8MTAwMD47DQo+ID4gKwlzdGF0dXMgPSAib2theSI7
DQo+ID4gK307DQo+IA0KPiBXYXMgdGhpcyBpbnRlbnRpb25hbCB0byBoYXZlIGRlZmluZWQgYSBt
dWx0aS1tYXN0ZXIgYnVzIHdpdGggbm90aGluZyBvbiBpdD8NClRoZXJlIGlzIGEgT0NQIGRlYnVn
IGNhcmQgd2hpY2ggaXMgYSBob3QgcGx1Z2dpbmcgZGV2aWNlLg0KV2Ugb25seSBuZWVkIHRvIHNw
ZWNpZnkgdGhpcyBidXMgd2l0aCAibXVsdGktbWF0ZXIiIHByb3BlcnR5IGZvciBJUE1CIHN1cHBv
cnQuDQo+IA0KPiAtLQ0KPiBQYXRyaWNrIFdpbGxpYW1zDQo=
