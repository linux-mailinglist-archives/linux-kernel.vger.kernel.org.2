Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5753845A1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhKWLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:45:45 -0500
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:10638
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231150AbhKWLpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:45:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/NJz7MtU+Uzz68y75pvolEmHtR0yrnjDu8zckHWWOkEyRqlQNhWWeW9+lg4/AvfEXyK7hx99Idxyzp659F1EmwXv3BpZbyoQhhAvSdXrtPc4cRgk6T3JWHrxVcwdlNMxEuUdzM/p88AAIRHGAZuEslwB2Zluu3vsLuM7PPO2V1/E363PhhZa+APQ2jOERQtx6BG0tWn7ZDtIebsHV6Ma78N3xQoSwpkB8osJgoNkwYauHWfyUAvl1gDoA62YscqU69sYV5QRMiwDZwSIaq17wVtEgA3F/cdskAeD1AqZ8DzW/oiJ/usk7Q1+AAJtpbArVKck38dEtnDw+qM+DiJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lFI8C2IQR8IqfMzn0g6stLDyGL1ubiTnN0RYZYsRK4=;
 b=dsktM/pn7EeMUguuUjborHYTzM0hsXeId2UrORxTzzxC5PqDqX6ObtnJVV5S0VBrRJBW1WZy0JkJCr8a9NmvbJpi3ntJ4HpmrDkVmUEhX+JWkp8wyXfHcCuNt9xDjV73/KGrUWOdkccwYYoFBX002+xAW+MDSJWrpslU3WcC04x9mlwHtqHNEncLgsLHV4GOWyRofnpZlDdqYpnOGZDXdpyy5TBe7hV9GfE3tv0OxFfadpHEf5W/HSO7t+mkvmmMhf8CPeENp/hbnN+hVKzxY42WrF37LJUbigzb4Y2yhgMCC5HqbEtBC2/q/U9Cq0m6lbhgLi3IOc2+WVBslqZW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lFI8C2IQR8IqfMzn0g6stLDyGL1ubiTnN0RYZYsRK4=;
 b=S7pqdasuHVXELJIWtC/AAnQWC+PlqdT89CACQRE5T7tDFTgHv0CoFx1GfdlfhOIYeavrtPX8Y+ni2niX5J2O/zaVfkzp4cI3xy88YoV+1kIwkMYhsCcDfDRiX3r/A9zbe8bSNwTlOiaD4KS3xHjE2aC6zWaceKDaTZSny8OO1iI=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2812.eurprd03.prod.outlook.com (2603:10a6:3:f6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21; Tue, 23 Nov 2021 11:42:33 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 11:42:33 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Topic: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Index: AQHX35CZ2t64bA8wLE2j/heX74SAnqwPaOmAgAAUvoCAAAQ4gIAABfAAgAFlEYCAABJlAA==
Date:   Tue, 23 Nov 2021 11:42:32 +0000
Message-ID: <c7b488fd-a0a7-2ec7-c711-7a6507fb2731@fi.rohmeurope.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
 <e2675600-7b04-19b0-79ce-28a4e1d1f225@fi.rohmeurope.com>
 <874db8b91ff04001a8958f100a614ed8@AcuMS.aculab.com>
In-Reply-To: <874db8b91ff04001a8958f100a614ed8@AcuMS.aculab.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39804a0e-d4cb-4113-2062-08d9ae76567f
x-ms-traffictypediagnostic: HE1PR0302MB2812:
x-microsoft-antispam-prvs: <HE1PR0302MB281222DA4F04E4B2BB00999DAD609@HE1PR0302MB2812.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qsgBqBjIPFlnqSW+8LRqHhzhQI/oGEK+INd/nPqQGG/Q9bwcyPx55liF/FDnIVZ5TOdsFwX8aw9mKwmbzBFy+CTbTIX2gxU6szHsWs9rZ2ySJ4oYBPTtEvDQ2SAqExJ0tX80epF/7jfyAZVFcvDVPDeVsNv+zzdSihwwgSaX086isBANPSIw+YaJPIJn7v+auzJSOUdrw1nUMO0/TdwptsB2UHVGCVxQ/ezYQjTmuRIZUlN28G0bfkP2dy8aBNtS4MmonWk7L7riVPzZowuSaam6CSfSBXZFmKGmNMrf9nsoHZT9fBLXrT7qWqbYZ3CcwB4YxLSPs6I+QZBb9A15GV5ivtO/aw7ow5vXM3rYpN33tbZV1DtnlTjZJ4I+V/qDlwhRUAxVMNEN5zQQ1WGfj9axWNULNjjaGdj+CcYVpu6pqLqMayY0NnZRpT355mPUWpa6qw7jSecT3MsQ/HyT0TQfC47RBCZQoRp0olg+cy/NODjFhTnpDR4PUUWe3io6nwNV6Nsa39YwSKcVAyB1qW6s5rTKNnJyMn/Lkgyg6ldKStjgvzPnj1bNbYX4tKDrBpItr3iZyL6qUs3vI8W1Xupfl0nK7TYz8eSRxoT4D2n8So2Yo+A3zr+5yIqmoXuzFG1KPlJcC2IwXHDElDn8KnW1bVPGLPBv0/PIhcGB9MMWcm3+GnHAWZeJdTAj8ZY9etc1OH8z0HEs/ER5xl38MqZiVtYfzjgZ3lCtQMQnchrTX281fdjJkP3T0weod1Z2NmNBMyKXASTpWyxShSOouQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(66446008)(2906002)(64756008)(26005)(76116006)(83380400001)(66556008)(53546011)(66476007)(186003)(6506007)(66946007)(6512007)(508600001)(5660300002)(38100700002)(122000001)(316002)(31696002)(7416002)(6486002)(38070700005)(4326008)(2616005)(8936002)(86362001)(8676002)(71200400001)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVFIVmVTMG9LZG5QeVRJbjB1ZEMzd2JhbmZ3bjdwNVVyRGc0N1FtT0xlaUk5?=
 =?utf-8?B?ZU4vWW5kOW1HaiszQ1lLRy9DWThnU0ZwUENhZmZYR3BURzJJZmEycG9SRGdq?=
 =?utf-8?B?UjNaNGhMWmJvVVY3TldieldPMXpaYTA3R2xwTXhGWmpHWldtamtIUWlBeFBL?=
 =?utf-8?B?ZzdmancvR2hJWXIvQjJuS25qODIxZEE2elhMYVpQQU5pQVBiU3IwQndHbFkr?=
 =?utf-8?B?RmUwZW1TTGtPa2JUa0k1SXp6cWMzMkNqT3loQmNxZmpuaGdwVEo4NkRpZmkz?=
 =?utf-8?B?eFpZL042REw4VFkxRjRoZ3lxc3pmcjY2U3o1UWNYRlQ0cUZITjZhb25KK0tL?=
 =?utf-8?B?cWNreU9ORFM2QkJjcVU1WmNrMEI2KzA4a29rMVpiTFNFbHdQZXRtL1lkQ1Bx?=
 =?utf-8?B?UmNKTU9uRHhRcUVrN0FRU1h1d3hvNzNveDRCcXNxQ2J1TklIUU1mTXpQSlZD?=
 =?utf-8?B?R3FhN1NpbW5LVDRNYmhRcmtvL1Z0TE1CaDdQMDlmc2ppcFN3YlZNMytGbUhD?=
 =?utf-8?B?VW5QNW5DV2ZzdzlIeVgxL0s1TEJacngzUDc0YTdFbHJ6THBOYmdrbllweWtZ?=
 =?utf-8?B?bDhtY3pHMlhLZmFzSzRPbTVNMFl2Tzd1cXhNNHliTkU5cisxb2J4VnJ5d0lo?=
 =?utf-8?B?V29rckdWeGtWMTlDR0x6ZXhKWXpWdkJka1VLZGJJcXh0UzZUaWN6VllKa2p4?=
 =?utf-8?B?YlE1Nm1wVklSY0l4STZZRmlrVmZhSkJXeWtaRFVxUjBqM2lIeWFNVlhuZThj?=
 =?utf-8?B?Tk5uSGR0bVI3N0tUNUZFTHZ5ZXJ3SG54K2I3TUxlMFVWN0hkb2REQW5pWGtj?=
 =?utf-8?B?SG5kNGFZUXNDaU1QdEtGNHA4S0lJMVBZR1A5VE8rZk1JcnJ4elMvODB0eks4?=
 =?utf-8?B?WHFjenN5bFdWdHFVY0tma2MrL2ZyeDErUEh3a1hqcnJYclhDcVczcEFXSDFk?=
 =?utf-8?B?Z1JBWEo4Y3JmQVA2YjRER2pVaE5tYXJibUh1ZkdiZVdEUHJFNFlQblcxUS9Q?=
 =?utf-8?B?QkpEaHhJY04weUdhc05qcCtNN09DYWJJcklSUHF0OXlwYmwxUVI5MXZqa0ZE?=
 =?utf-8?B?UThuZzV1NS9nNUJhV3JmbXFzZk5hVTVGN2hqT1FDSFhJUzF2djJ5WTQ5bXFL?=
 =?utf-8?B?eDdacEZ4RFl3cGRXelRDU3NTWVR3a0JNWkhwZXBmNEZQVTlMTmJxcExmMG1H?=
 =?utf-8?B?ZjZvd0tpdFhPOUd6SFpjK2tkNVd3K1cxbGFiaHAvdUdJQ2tybFZoMS9HUWdt?=
 =?utf-8?B?N2hNeWNMMXh0eVVaNXVpUDVwNFJteFRPcW9lWXVpWjQ1QnZId1BJeURTcTcw?=
 =?utf-8?B?Z0I5RGtQbDljN1Y1c2RYQ1U3MSt5WHI0THgwbUovQUZrdHBRUGlwOE9mYnZO?=
 =?utf-8?B?alBIS3V1dFFXM3drcnZTdzZsY01oZ00vclh6MFhySlBmMkZYZjYvWlhXOXQ4?=
 =?utf-8?B?L2NqYk5zaUo1a042UjA4VlFnYXdrSmkzWXB0Nkt1Z1ZYcjM1UitCQ0tHYTRP?=
 =?utf-8?B?V0xQd0ZudXJqSFNqMlVHWGZLOEZQNCtTV0Y2WkpsTldSZ0plbkRWalZCclpD?=
 =?utf-8?B?WlIyUkh5YUc1alFiN3dreUVyeEt4MzBwU3FJZ1RxdDZMWmxnSU85WVFCUmNN?=
 =?utf-8?B?eHUwYkpnNmsrQThONFAzMUc5QmluUzdMSlI1YkNYUmc5Qm1RTndzeDdRRzZv?=
 =?utf-8?B?S0swYTdORU5yU1Zvc2I0ZzlSWkdQZUdtTHo0b1lUQWxJaUo0aXhDbWhIaENE?=
 =?utf-8?B?MlpBay9ZeTYyN2FKLzk0enhEQStQY2hNQmQ4SUl2em5LakFGN3AxTWo4SzRY?=
 =?utf-8?B?WEdwT0l6d2JiY0gvbGVtbS8wSmFJNXE4UkxLR1JETEtoOXhDVjdob0ovMXdy?=
 =?utf-8?B?Q0g5SW9LTXVnMVQxeW1PdHpldTErZWhYUENyWHFWZmJFdUt1YURUangwMUJ2?=
 =?utf-8?B?aW9MU1htOXR4c083U0F3LzBXanNBbi9IWHhBVEpMdE1hN3ZDWTVGTlVaRHNV?=
 =?utf-8?B?empwdTBpNFFkWXVRSXcvbUVqcm1jc1g0UVNPU0o5eVZ2RGs3QllXZUtDeU5C?=
 =?utf-8?B?bkF0M0JkdlFaQThzZ2RUYWNzVHZPWmZ6SG03VFc2QTByQ0JxZlp0Y0NSNi83?=
 =?utf-8?B?NUxiTlY0YmN4NE8vWXBTNU11Q1NCQWZXR0FwU2ZUWHN6Z3BWcjRjbmFXK2ZT?=
 =?utf-8?B?Q3Q4djJocEpUUUlNMVlBYmNsRllvMVNCblFCSVpuM0F2TUsvVjdsM1E2ellz?=
 =?utf-8?B?T0sxQ3o2dHh2WjRVTVo5Zzdpb0k5bm1FenlnUzVNNG1CYUR4eWRlQnN6MFps?=
 =?utf-8?Q?1rI9Gv5F/bCnZLtp3d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F38722F231E10643A2146A36A2F3E6D9@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39804a0e-d4cb-4113-2062-08d9ae76567f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 11:42:32.8552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBg8eo8zGIDvmCZ6Y+3TA8PKgaC3d9aZ5kHPJTY5puYIkmfI65G7ytq6yD/D86sjQ3ukoaF591lI9v/rMqChoNi01AnX2Vo3MTxJin2/rJe7rqtw/A4U56evzj4nXTng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2812
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjMvMjEgMTI6NDIsIERhdmlkIExhaWdodCB3cm90ZToNCj4gRnJvbTogVmFpdHRpbmVu
LCBNYXR0aQ0KPj4gU2VudDogMjIgTm92ZW1iZXIgMjAyMSAxMzoxOQ0KPj4NCj4+IE9uIDExLzIy
LzIxIDE0OjU3LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4gT24gTW9uLCBOb3YgMjIsIDIw
MjEgYXQgMTI6NDI6MjFQTSArMDAwMCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToNCj4+Pj4gT24g
MTEvMjIvMjEgMTM6MjgsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+Pj4+IE9uIE1vbiwgTm92
IDIyLCAyMDIxIGF0IDAxOjAzOjI1UE0gKzAyMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4+
Pg0KPj4+IFdoYXQgZG8geW91IG1lYW4gYnkgdGhpcz8NCj4+Pg0KPj4+IGh3ZWlnaHQoKSB3aWxs
IHJldHVybiB5b3UgdGhlIG51bWJlciBvZiB0aGUgbm9uLXplcm8gZWxlbWVudHMgaW4gdGhlIHNl
dC4NCj4+DQo+PiBFeGFjdGx5LiBUaGUgZnVuY3Rpb24gSSBhZGRlZCBkaWQgb25seSBjaGVjayBp
ZiBnaXZlbiBzZXQgb2YgYml0cyBoYWQNCj4+IG9ubHkgb25lIGJpdCBzZXQuDQo+IA0KPiBDaGVj
a2luZyBmb3IgZXhhY3RseSBvbmUgYml0IGNhbiB1c2UgdGhlICh4ICYgKHggLSAxKSkgY2hlY2sg
b24NCj4gbm9uLXplcm8gdmFsdWVzDQoNClRoYW5rcyEgVGhpcyB3YXMgZWR1Y2F0aW5nLiBJIGFk
bWl0IEkgaGFkIHRvIGxhdW5jaCBhIGNhbGN1bGF0b3Igd2l0aCANCmJpdCBlZGl0b3IgdG8gc2Vl
IHdoZXJlIHRoaXMgd2VudCB0by4gSSBkb3VidCBJIGhhZCBldmVyIG5vdGljZWQgc3VjaCANCnBv
c3NpYmlsaXR5IGlmIEkgZGlkbid0IHNlbmQgdGhlIG9yaWdpbmFsIHBhdGNoLiBJIGd1ZXNzIHRo
aXMgaXMgdGhlIA0KdHJ1ZSBwb3dlciBvZiB0aGUgY29sbGFib3JhdGlvbiA7KQ0KDQpCZXN0IFJl
Z2FyZHMNCi0tTWF0dGkNCg0KLS0gDQpUaGUgTGludXggS2VybmVsIGd1eSBhdCBST0hNIFNlbWlj
b25kdWN0b3JzDQoNCk1hdHRpIFZhaXR0aW5lbiwgTGludXggZGV2aWNlIGRyaXZlcnMNClJPSE0g
U2VtaWNvbmR1Y3RvcnMsIEZpbmxhbmQgU1dEQw0KS2l2aWhhcmp1bmxlbmtraSAxRQ0KOTAyMjAg
T1VMVQ0KRklOTEFORA0KDQp+fiB0aGlzIHllYXIgaXMgdGhlIHllYXIgb2YgYSBzaWduYXR1cmUg
d3JpdGVycyBibG9jayB+fg0K
