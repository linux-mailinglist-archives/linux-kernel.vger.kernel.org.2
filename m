Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA3E447F97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbhKHMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:45:12 -0500
Received: from mail-eopbgr1320043.outbound.protection.outlook.com ([40.107.132.43]:59256
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239585AbhKHMpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:45:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehi7tvbcdkkjvy4iQxwJ+uW8rf3pGHYbGuIPHaDL08qu+tqqlcc96u1PcmBt42TPHEuoGOH4+nvA+6JPEqNjJJRWwy3vhj34aH/bxXQmFuXhgGKnEc4vvtOpU0gXZ0tbB8uhZS5Phz+Z5liQaxIq2WUay2LHUvODeUS3BJXiMzVAma+iM3D8hXmESGlJqGORYsbWRxOtsx4+LBkgaOVbb3EqCDXazN4CRV6D3/HiTO676Q+v/F4f62rzusxo0r9bw589sbMbIGDK0yW/ai52FA8SRM1rCoYxxOkQV/XEth+XZ0WDU3H2zF/dV7SIO8y7wys4kbjq6gS5b8Vh2vf6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNwrde134SShN7XfOnnWu1QIu7dBZlwTVqUO3SGs1j0=;
 b=AKOfEc+H1Zn5ACipWsTLrCYpY6q0MuE1tmFv/noI8NwRXVpncDS4ROBaUrNrv7bumkrG5RKnqEAL5jzu9f4ajq9bxoqsMgEK5OE3ylkfirrwrRTMhFbbPPT+qGFK5oFXLbTGXk2oxy4GkkFrv03QDayfHozGjLlycPubUtt29YT9jWO8FPXbJzTeh2jHXZ2Q7XKtj+hXPYO8CpeoGIS9vzKq/2LEh+tkB0mnlvxkhxQj/1BXF4+keYBjhpw9ouCEvUiQjSgYBo4718j9o6wEw90yZg0lirV5RFUt9SYwGeXCav7Xf7W8qXrplDcx9rPxabjdIKrC/hEpS1ttoNsx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNwrde134SShN7XfOnnWu1QIu7dBZlwTVqUO3SGs1j0=;
 b=tCPyWdpGOiPsCJmtYuhXdMJxsAfiWHaQF6UOxxL7YMHD1n3yhipUaat5c48WF7ntdC/MnACjA3bIumG98gbaIRV+9mdcTgx5t8x4xh3GTFW1+S7mV+tJOjhwXUZKKk/TiQ7uWIQgzHZIF8hMQMgkaqTVMyj7XEWsQpU3C5CKVC8=
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com (2603:1096:802:22::12)
 by KL1PR02MB4833.apcprd02.prod.outlook.com (2603:1096:820:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 12:42:24 +0000
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8]) by KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 12:42:24 +0000
From:   =?gb2312?B?uvrG9Lq9KE5pY2sgSHUp?= <huqihang@oppo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: gadget: composite: Fix null pointer exception
Thread-Topic: [PATCH v2] usb: gadget: composite: Fix null pointer exception
Thread-Index: AQHX0jK4VLpQhw8UMEatV/SgvUblXKv04WCAgAS0XLA=
Date:   Mon, 8 Nov 2021 12:42:24 +0000
Message-ID: <KU1PR02MB253627CFDBE573DE95F3A09EB0919@KU1PR02MB2536.apcprd02.prod.outlook.com>
References: <20211105104840.159533-1-huqihang@oppo.com>
 <YYUnM0/82FwS5OUE@kroah.com>
In-Reply-To: <YYUnM0/82FwS5OUE@kroah.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70a95b52-75f9-4b98-45d1-08d9a2b5370f
x-ms-traffictypediagnostic: KL1PR02MB4833:
x-microsoft-antispam-prvs: <KL1PR02MB4833D25BF7A04DB2B41B941CB0919@KL1PR02MB4833.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iKJpGZpYEBSTAPgiVWxQB4JBkuNJlWo88JY5anWrcm6sbX+KuyOdeT5nDY2gPTQaQxxU578QGjQpz/C96n3ocvBu08bsneI+CXD/yAyJuCO50O27S7TxW/DrwTiOUZlK6Ls05ww7vTUI2RoBS9H20sjwq7cSZ2vzT2IDTjhPRpw/tNV0/T9SMKnv9b8n7tPQqGBMhvxCGnTeBPkOtyKf23AIL6VSfE6FYCduGQ0H/tueXAGkFjJmwy228qVzt7fhE/6nh0Zqwhl/MlttLfg4S0VmGSWwMSxkVlayKD8guRB0KzecbUg/UkkOjHe/3zDjVLUc6xnLrw7Z0NYVqfaxx+CL3JO02fcem+3cQ2HDEK2rUq4ruy5JC97M3TcNXV9vDKQKw+vuAQf0EmONQArnWs8SK2y3+2fD+dC2nvhN0F4pLBiaZPgXmd6Qc+NJR20U1FWG3AUXMWCZNOFEZ0Me6NQWVg3y6ADH7jZPeCbDgkuQ5Of8PCj+ap+qzXmGPSv90XQTsGCppa36dQqULD+vX8fdkVroRxO3jU1f0l6NbXSGLZeQQhul+kR6CafAZZdolmc5FXyA0AGfIMAp8FCnJF8PbiG3GliuPsa66NEHetjo4WbiNbYgQQGzRNqU2BGtIzlPOWXCAqol1sNxhn5xnG3wk2ohj3WcRPsoPqJhuoCjUj5pQ1qWbOaTNrsDkuH3n+BX6dYTDk3XGmjq745GXht0ehnR0qB++lJF5hzBVLY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1PR02MB2536.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(55016002)(316002)(53546011)(83380400001)(508600001)(8936002)(9686003)(5660300002)(85182001)(8676002)(7696005)(86362001)(6506007)(54906003)(2906002)(6916009)(33656002)(52536014)(26005)(122000001)(186003)(66946007)(66446008)(66556008)(66476007)(76116006)(64756008)(71200400001)(38070700005)(38100700002)(11606007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SDI3L1dMYVZ1NG84TGFyNWdkOHdjbjdxem1rTU9HcDNsR1cwcXYvR2ZUaW04?=
 =?gb2312?B?Ky9wNzdTYU9JNkRRUFhpWUUza1d2dG1ra0hpK0VIL3dSMXhhR01LdzRjQUtk?=
 =?gb2312?B?bGZ6ejYwQW1QUTAvM2M0NTVYc21ZWXlzZTk5ZmNTNy9pQSt0RFJrc1VYN2dG?=
 =?gb2312?B?R1pDZ3hsbEVmazZETmNUc0ExL1graEFZRGsvWXRTWXp2OGRIMC9VMnlwZG90?=
 =?gb2312?B?a3JKSXd4enR1ZkpsQkdiRGpTVGQwckJETkxSakR3Z29rMEd3VmZNWkwxRXI4?=
 =?gb2312?B?Z0RuV0V4NjNEZ3R1K1VyUFRRQ0FMRHFCR1Rjd1hKamM0cGxheEMrSXd4RUVa?=
 =?gb2312?B?RENYRVg2Wlc0V3RiaE53b01pUG4yc2xheXBXVlNoNzRaSFlKdDl2SEVkSSt3?=
 =?gb2312?B?c1FvaWRQOExzMklnOXRlRmc2TjZFZTBqZnphYlhpdk1nS1FqUUI4OE5PeDFL?=
 =?gb2312?B?dmFuWUV2aGRJSmZ2cUtoZHFYaVBrR0ppMmI2dnFhMGZ5L2ZwY0gySVVTMlpP?=
 =?gb2312?B?b0lGYStBUGVHdVV3aVpscEJFNHVtL0dFZEJ3MVNBRGpCakdGNEdwNGV3T3Z4?=
 =?gb2312?B?VXR2MWVxbURvLzlkcHJua1ovUEtRYnBvZTBiU1hyOVpmK3Fic3VPMVc5aVdw?=
 =?gb2312?B?ZVpwZGlnM1RreGFPbXJUY2t5dWZYUzN6ckJiWVliaVgwbHdId3N5eDRUMEg1?=
 =?gb2312?B?dkU0Y055aWRrbVAvUTBucHhlS0xXUGdxRWpJRGdkSWRCMmVIUkVnZ0VyaEN1?=
 =?gb2312?B?YnJUTXBrL0l3a1p1M2N6TXJGRmx0YUhlRHE5L3JqUGoyK1RXOFJJR3VXUWZC?=
 =?gb2312?B?ajdTbitQYWVJVVRWMFZEUk00Q3hCd1ZnRHlYVGZBeUlseVRFa3FpamJDLzFk?=
 =?gb2312?B?cEJ3U2FzblRENmFvU0t6aUwwSkpvRVdKVmI2bU9qaEZHVkZQQmZvZnErcUZE?=
 =?gb2312?B?a1NWNlhLU3VFekZjeHZhUlZCWVNtVXBlVkgwT2kvaUllMTQ3a1FVVTE0bkhD?=
 =?gb2312?B?QWhxQnZpQVJiUWNCV2N3VC9zTURURER1RStRSWZqZFlvWERBcyt0MnVKMkZk?=
 =?gb2312?B?dU1LZzhUTDQwV3FaTmZUMDhXMTBvcTdScW84UjdSbWJud1phOUIxZnpmM29O?=
 =?gb2312?B?b0d0WUN2dHNoaEFTeU1udXpyZlpFTkNFNmlySlR2U3F1T3k2d0p0eWl6UEZZ?=
 =?gb2312?B?OU1yV3N0ci91WVVra2NubDNQc0h6SHBQY3lpVmV3UHVNajAwaUMvdlN5UHFK?=
 =?gb2312?B?VWE0ekpZR3Vrdmh4YXI4Y1ZRM2xETVVOd2VYOFFIUitaK1lNc0VTWTVJZXlO?=
 =?gb2312?B?Z1hmbUMrWVFLTVZrVkdTTWNUMFRRRlI0akVMcW5qbzZhbXBtZDRMKytGVXNm?=
 =?gb2312?B?QVFrQkNqTkd1ZUl1dFBRald4YVFxNWtkZVV1bmV5TXBueHFTRTF1ZHdCYm1Y?=
 =?gb2312?B?bWxZSFovdEdINjR2QVhWMktyYXcvOC81NldnSU5mS3FDUjdOdEQveGRjcy9R?=
 =?gb2312?B?VnBFNS8zRy8rZU8vRE01dm1FNk4zMXVVWVdNL0RQZnN2S25nRjdCNkNFbmU0?=
 =?gb2312?B?QVhpT2hrSzdxYm9ObjhHN1JJajYwMTQ0M0ErWGNuR3B4c2VWTUc2Q2l1Mngv?=
 =?gb2312?B?TlllZUxSNUlRYlpka3o3Qit3T3IxRFBJY3hCcHJ1MkdkSk82dEc5NmZLbEor?=
 =?gb2312?B?ZC9uMHdBbCtFc2g2eGFzMXRTUEFhQ1p1RjJ4THR5MkdDa2ZZZmdlZUg4b3Ni?=
 =?gb2312?B?dXJuWFdON2ZHUXIyU2ZkR216NnVsdzI0ZXYzWEZMMnpwc3pjYkJ6SlF4TnZv?=
 =?gb2312?B?b2pzU3IwZ0NqRDErWWVObzdMMlJwWWxvYVJ6VGNRaGdCOER2RUtGM1E5VjJE?=
 =?gb2312?B?OEU4bUVRMXJsRThzek40blpZMmVhS2VBWTNJRlpMWWwvRUMzY0tuMExycmxU?=
 =?gb2312?B?NFRIRnJWMWRrWERQMTc2VkdvWit2YjcyblBSODRqaU9meGR4OFFVVjArQTFa?=
 =?gb2312?B?RDhWTnFSRnEzdHZsVUFUZUY2R3RvUDRCZTZuMWcrK0hNTDJDcnRuMDR5eUFy?=
 =?gb2312?B?Mi84ekhsT2RJNGE1TVVXUTc5M2xrOUpmajZzdmpVZlJIMVF4UzllUHlCcHRo?=
 =?gb2312?B?V1ptU3l3QjRuV1FQYWdEWjgyUUMvTWtpdzlhNjN0MG5VNzlrSUFVckNlSzVJ?=
 =?gb2312?B?Ync9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1PR02MB2536.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a95b52-75f9-4b98-45d1-08d9a2b5370f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 12:42:24.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7btodZMPdCIjrTk1bjGyTorbFRKWWuw6DBxYl5xDvJSR/cVn7A+DV1sQ03LXItS0KWCCZcxwRhQEc77xWVRcJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4833
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciA1LCAyMDIxIDg6NDUg
UE0NCj4gVG86ILr6xvS6vShOaWNrIEh1KSA8aHVxaWhhbmdAb3Bwby5jb20+DQo+IENjOiBiYWxi
aUBrZXJuZWwub3JnOyBwZXRlci5jaGVuQGtlcm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0gdXNiOiBnYWRnZXQ6IGNvbXBvc2l0ZTogRml4IG51bGwgcG9pbnRlciBleGNlcHRp
b24NCj4gDQo+IE9uIEZyaSwgTm92IDA1LCAyMDIxIGF0IDA2OjQ4OjQwUE0gKzA4MDAsIFFpaGFu
ZyBIdSB3cm90ZToNCj4gPiBJbiB0aGUgY29uZmlnX2VwX2J5X3NwZWVkX2FuZF9hbHQgZnVuY3Rp
b24sIHNlbGVjdCB0aGUgY29ycmVzcG9uZGluZw0KPiA+IGRlc2NyaXB0b3IgdGhyb3VnaCBnLT5z
cGVlZCwgYnV0IHRoZSBmdW5jdGlvbiBkcml2ZXIgbWF5IG5vdA0KPiA+IHN1cHBvcnQgdGhlIGNv
cnJlc3BvbmRpbmcgc3BlZWQuIFNvLCB3ZSBuZWVkIHRvIGNoZWNrIHdoZXRoZXIgdGhlDQo+ID4g
ZnVuY3Rpb24gZHJpdmVyIHByb3ZpZGVzIHRoZSBjb3JyZXNwb25kaW5nIHNwZWVkIGRlc2NyaXB0
b3Igd2hlbg0KPiA+IHNlbGVjdGluZyB0aGUgZGVzY3JpcHRvci4NCj4gPg0KPiA+IFsgIDIzNy43
MDgxNDZdICBhbmRyb2lkX3dvcms6IHNlbnQgdWV2ZW50IFVTQl9TVEFURT1DT05ORUNURUQNCj4g
PiBbICAyMzcuNzEyNDY0XSAga2NvbmZpZ2ZzLWdhZGdldCBnYWRnZXQ6IHN1cGVyLXNwZWVkIGNv
bmZpZyAjMTogYg0KPiA+IFsgIDIzNy43MTI0ODddICBrVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0DQo+IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAw
MDAwMDAwDQo+IA0KPiBTbyB0aGlzIGlzIGFuIGludmFsaWQgZHJpdmVyIGNhdXNpbmcgdGhpcyBw
cm9ibGVtPyAgT3IgY2FuIHRoaXMgYmUNCj4gdHJpZ2dlcmVkIGJ5IHVzZXJzcGFjZT8NCg0KWWVz
LCBpZiB0aGUga2VybmVsIGlzIGxvYWRlZCB3aXRoIGFuIGludGVyZmFjZSBkcml2ZXIgdGhhdCBk
b2VzIG5vdCBzdXBwb3J0IGFsbA0Kc3BlZWRzLCB0aGlzIHByb2JsZW0gY2FuIGJlIHRyaWdnZXJl
ZCBpbiB1c2Vyc3BhY2UuDQoNCj4gDQo+ID4gWyAgMjM3LjcxMjQ5M10gIGtNZW0gYWJvcnQgaW5m
bzoNCj4gPiBbICAyMzcuNzEyNDk4XSAgayAgRVNSID0gMHg5NjAwMDAwNg0KPiA+IFsgIDIzNy43
MTI1MDRdICBrICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMNCj4g
PiBbICAyMzcuNzEyNTEwXSAgayAgU0VUID0gMCwgRm5WID0gMA0KPiA+IFsgIDIzNy43MTI1MTVd
ICBrICBFQSA9IDAsIFMxUFRXID0gMA0KPiA+IFsgIDIzNy43MTI1MjBdICBrRGF0YSBhYm9ydCBp
bmZvOg0KPiA+IFsgIDIzNy43MTI1MjVdICBrICBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDA2DQo+
ID4gWyAgMjM3LjcxMjUzMF0gIGsgIENNID0gMCwgV25SID0gMA0KPiA+IFsgIDIzNy43MTI1MzZd
ICBrdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgMzktYml0IFZBcywNCj4gcGdkcD0wMDAwMDAwMjBl
ZjI5MDAwDQo+ID4gWyAgMjM3LjcxMjU0MV0gIGtbMDAwMDAwMDAwMDAwMDAwMF0gcGdkPTAwMDAw
MDAyMGVmMmEwMDMsDQo+IHB1ZD0wMDAwMDAwMjBlZjJhMDAzLCBwbWQ9MDAwMDAwMDAwMDAwMDAw
MA0KPiA+IFsgIDIzNy43MTI1NTRdICBrSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDk2MDAwMDA2IFsj
MV0gUFJFRU1QVCBTTVANCj4gPiBbICAyMzcuNzIyMDY3XSAga1NraXAgbWQgZnRyYWNlIGJ1ZmZl
ciBkdW1wIGZvcjogMHgxNjA5ZTANCj4gPiBbICAyMzcuNzg3MDM3XSAga1dvcmtxdWV1ZTogZHdj
X3dxIGR3YzNfYmhfd29yay5jZmlfanQNCj4gPiBbICAyMzcuODU0OTIyXSAga3BzdGF0ZTogNjBj
MDAwODUgKG5aQ3YgZGFJZiArUEFOICtVQU8pDQo+ID4gWyAgMjM3Ljg2MzE2NV0gIGtwYyA6IGNv
bmZpZ19lcF9ieV9zcGVlZF9hbmRfYWx0KzB4OTAvMHgzMDgNCj4gPiBbICAyMzcuODcxNzY2XSAg
a2xyIDogYXVkaW9fc2V0X2FsdCsweDU0LzB4NzgNCj4gPiBbICAyMzcuODc5MTA4XSAga3NwIDog
ZmZmZmZmYzAxMDQ4MzllMA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUWloYW5nIEh1IDxodXFp
aGFuZ0BvcHBvLmNvbT4NCj4gDQo+IFdoYXQgY29tbWl0IGlkIGRvZXMgdGhpcyBmaXg/DQoNCkkg
aGF2ZSBub3Qgc3VibWl0dGVkIGEgQlVHLg0KSSB3aWxsIHN0dWR5IGFuZCBzdWJtaXQgYSBCVUcg
YXMgc29vbiBhcyBwb3NzaWJsZS4NCg0KPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0K
PiA+IC1BZGQgd2FybmluZyBtZXNzYWdlDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2dhZGdl
dC9jb21wb3NpdGUuYyB8IDQwICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiA+IGluZGV4IDcyYTk3OTdkYmJhZS4uNzQ2YjM0
Y2YwMzEwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiA+IEBAIC0xNjAsNiAr
MTYwLDkgQEAgaW50IGNvbmZpZ19lcF9ieV9zcGVlZF9hbmRfYWx0KHN0cnVjdCB1c2JfZ2FkZ2V0
DQo+ICpnLA0KPiA+DQo+ID4gIAlzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICoqZF9zcGQ7
IC8qIGN1cnNvciBmb3Igc3BlZWQgZGVzYyAqLw0KPiA+DQo+IA0KPiBXaHkgdGhlIGJsYW5rIGxp
bmUgaGVyZT8NCj4gDQo+ID4gKwlzdHJ1Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXY7DQo+ID4g
KwlpbnQgaW5jb21wbGV0ZV9kZXNjID0gMDsNCj4gDQo+IFNob3VsZG4ndCB0aGlzIGJlIGEgYm9v
bD8NCj4gDQoNClRoZSBib29sIHZhcmlhYmxlIHNob3VsZCBpbmRlZWQgYmUgdXNlZCwgSSB3aWxs
IGZpeCB0aGlzIHByb2JsZW0gaW4gVjMNCg0KVGhhbmtzDQo=
