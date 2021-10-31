Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A68A441184
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 00:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhJaX4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 19:56:21 -0400
Received: from mail-eopbgr1400048.outbound.protection.outlook.com ([40.107.140.48]:19594
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230222AbhJaX4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 19:56:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9xAb7YGV0Z7st1RGP7tNAvjqqhW9zfHgV3+VePMBmkMazQUhGS56ilyV43GMWJ3PowSDUDf1MS4vvRcJeWziGOdmOEyjpyEH7GVxyOkuf3Dx6UaElfNXQZVi8nUTkegLCPbL3Nrs7jhCkXfp3mD1jV5F5dUbn4Ft8BYOKK4EedF1ZhKAFkZFJwesbxfGn7uGKvDRVhN+onBMygCu8jhjhPxSyQBIdEmvTDLKfCUuSORgYKg8ZBAhJy0v579cl7gvKozZmWiJxGmecE8BohZ2BUTwItKqosO96wHFwRLzVp2XLtGb/NDi1sRm7QeOowaOSWi4n7EhehaDPwSBFZpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDrhEIolfcbE38fkwf3VqFfAHT/bSiDlveVQ6tqdv0U=;
 b=YXkmD+Ap2rCtrHxNagMAeiBcbNg0q0eKsDtZ3pFzUFGnMRRo68gXemvJ9u1kDSo6USG+v31yKzX3YDxP98xYh2IGUcAegjsK2W8WYR3fXcV076rRNT9U6ILU6nXUd7lI1G+xn4aU77ltORwsjj9azVgECbRnCeGGfXmj+62mbwpsPAZ7ZBzYeuEHeAbf96KLysP1CNzMwPR+Ha7x6rfIZmRk+Mbf9pL4wULkrAgO0xKoLQz9+3InHat4hYRftSGHetF+3rl06rJgWXFwYPexiorFSuW0hUIEfVuj008y6mQuFg+sXCHMzBlPHhl2YOBKr9IEYOuJN9P1EqNgbelV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDrhEIolfcbE38fkwf3VqFfAHT/bSiDlveVQ6tqdv0U=;
 b=l37yrkdiWcuWSu3O9hRLtI8eMKYFOhuDJwrSRb1tVndQhNEM2jwfQYCkt5CbOzc16u3V377WvylDpUYuZ9tF3FqI5Oc0wEdrR6qXBt7X6U30XXJ3Dw60yfLpOM1RmXsa9oLZbF64KaiuUfFpDJNUfv/+GGhcySyS1q+yp31Jsl0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB8463.jpnprd01.prod.outlook.com (2603:1096:400:174::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 31 Oct
 2021 23:53:46 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::d4ca:f5df:36df:47fd]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::d4ca:f5df:36df:47fd%3]) with mapi id 15.20.4649.015; Sun, 31 Oct 2021
 23:53:46 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Quanfa Fu <fuqf0919@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] writeback: Fix some comment errors
Thread-Topic: [PATCH] writeback: Fix some comment errors
Thread-Index: AQHXzh0D4wST5QH5Yk69jubRN+9qC6vtxv/w
Date:   Sun, 31 Oct 2021 23:53:46 +0000
Message-ID: <TYWPR01MB8591801586B7D2335BE623EEE7899@TYWPR01MB8591.jpnprd01.prod.outlook.com>
References: <20211031060302.146914-1-fuqf0919@gmail.com>
In-Reply-To: <20211031060302.146914-1-fuqf0919@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10a86da4-bf71-4429-14d3-08d99cc9ad89
x-ms-traffictypediagnostic: TYWPR01MB8463:
x-microsoft-antispam-prvs: <TYWPR01MB8463EFED1098D4E8307F3AB4E7899@TYWPR01MB8463.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epViha+wO1gMRKvfQnpc/xtfOXC3r4Ci6mWz2lf38nVonZc8DJ1qQF6STnHoezOb+WOCcTZXmR/H1ZTgsFypobTArwW+S0Eain7vd1a2tPMFqv9JHWh3/oVzLql0jeqeYHEe/GGt3CEySOBeMMHYlKk4ZBFC1enW0mKQ1X8GIt1g3wrMR6wfoKykOblSimfAyM8CjmWMcY4dz74OAP7PbwVfZv6CQ9fSuZawnJfF2P3hSz9Jvk7VSXJ3W7tvdNUsUulkuILt3CWC3nvebWhSdIyQiq13crhL2NhAG/BKhAxZAjNvb8U+kKtB3qrWQV7mgJEhPywKX8jt+sdC/Q8kOX72rQKs3MdUbV6/+0T3EI70YexUClsv+9NruICkaoFubIA+T4XNLgXh4byVV55BDLJGHaFLVfL4VeTVu4qUDbtgDNVR7ylfkIaWyCP532NUjh4tld5zBNH65G6fhYYk5I6NyUkzIzCTqsGL5ki3EVNK+Ug6VOdOMlFNlHd3M2StCokNLfNgCpIv/GWdEEnLBeTKyJ3IlLOs8p1EFk3Wp2fzmYIkERwBUAOiBt3/nMKT1LkxeFVOFkcIaVyOeOQTTI2qW5Bfn4KatvnKKnVCeTDl6tc4F8Zn4YWlmHbjKuaXWQaYEcet7rFzGQHV0PbXCzyB/TNNshLirf437bc3kLSNoBZ9uP12wKAwWQxQnw1iJLTq3Mn3EmZ6dmCvCnpx1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(8676002)(316002)(76116006)(55016002)(83380400001)(186003)(86362001)(9686003)(5660300002)(71200400001)(7696005)(55236004)(6506007)(82960400001)(38100700002)(110136005)(4326008)(122000001)(4744005)(66556008)(508600001)(54906003)(38070700005)(2906002)(66946007)(66476007)(52536014)(26005)(8936002)(85182001)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUNLUnlwdVR2RUZ0WGdNRmFFNW9ac3hsYmI5a0c0NFJNOUdVYTRYaFh5ZGdi?=
 =?utf-8?B?Q2VXcms3R3BqZExRVTY1LzZIVEZLamQwbUF0ZFpQaWV3TDZ3ZDl3SHBKWW45?=
 =?utf-8?B?alFYaVcyaXpJN0VYVHNxckZtNEtMK1Zya0tTcGNXeXNJb0VodFdING5pVHd5?=
 =?utf-8?B?YUJxdWhQMUsvdUJaSnZoUVdpd2hlQlk2ZzllcjVKeWV4Z2JCcmk3SkpneDVL?=
 =?utf-8?B?c3dpaDZUNGlVaXp2R3ZXb25Xb0F6RlA3VTZPUm1qaGZjVFNielUrUlVLVDFC?=
 =?utf-8?B?OHM0aG9qcktMZUJtZ0pkdmNySEp3ZzdGaTdsMnVVSHY2bDE4QlpZeDB1ekxX?=
 =?utf-8?B?ZkJOamxManpGTWNsTkhYcXF1Q254MG1kV2NvZnNuYjNYTG1CQmk1cFpwbkE3?=
 =?utf-8?B?QWM3RElwMWZ6NkVwV2FNbHN3Qk8xc2RJalFqZWVXc2c0NFFhZFFRZHBibURN?=
 =?utf-8?B?THVmRjJUMUdWYUtzUFowaThHYXlRNWpSR1cwUEVxL2RtVGJxY2RIdUVyQkNs?=
 =?utf-8?B?dVpZcjlYeDBkNzU2SzM0d3VtcXVmTEw0elJaRG5SbXFWeDMyNXBlLzdWbVdQ?=
 =?utf-8?B?MlJpZUQ4bzZmRi9jOWltc3gvdmJFU1RET3RPWEQ5VWZlaFFQRVB4R08rQkp6?=
 =?utf-8?B?bmxoTURLTzVPaTd3RG1rU0llbktzWjBuZWw4ZDdLVTlnTFdTaGYrM040VVVL?=
 =?utf-8?B?N3VYQm51UzJjMk9ZdmI4TUtKbW1xTUJ3bzdhZFZzZXFUT3JTcjRKckx2T2Rp?=
 =?utf-8?B?cEFLbStWRUhBMnU1bU5TK3NWdFViT01wNm92QzhEQWhLaTNUMy95ampoeEZs?=
 =?utf-8?B?TlpGR1dVSE05TTZVM3hLWWQ3Ly9DRWFrMGNvUkRJUXpPT09rZFdITjlhcks4?=
 =?utf-8?B?dFI3ZDRnaTNQdWl2SE5lNHBERHZWemhERGNodzd4bStlRERJRGZUYXpTZllE?=
 =?utf-8?B?TC9yUm9YS2NQRVQzdXJ6YlFKTkw3Z1RKRXNHdVRCc1BYZVFiWW5HeDdiWExP?=
 =?utf-8?B?aDRoWExhemgyNGxnNmU2cUJ4Q2ZSbDkxSE9ydVNWZUtoK2FWT1A5NS9vSm9V?=
 =?utf-8?B?bTdDRXB2UnJudUFjUXI1cFNBR3c3ZzNiWlpsenk5aWFPK3piVzJZUWlQdVFC?=
 =?utf-8?B?VkZoZTdOTk4vcGQ0TnhLYUIwVnRiRk12MkViUFpDay9RcEJtWEdlWXErSDhF?=
 =?utf-8?B?WExQNk9JYTBQQmpFMkorZ2FPZ3ViR01YU3prOEdrV1pUcUlXN3NRNXMvZVc5?=
 =?utf-8?B?S3ZTMC9hR282bFBGM2kycW5FNEVXeFQzUlZXajFJaHJ2RVlzZ05za1ltMWRU?=
 =?utf-8?B?Y09JKzI3bktrWDQ3Q3ZwamQzMFkreHNCMlJ1RlBway9KWHFmeWJZRGY4R3Vv?=
 =?utf-8?B?RGtsR3Jielh5WDFmZWFIRUNoa1h5ZlowVDVmcTFoVjBPNFllZ3BONGJaMXp3?=
 =?utf-8?B?L1pmK2RuUUJRTlZOUit4VXQvSWp4MGd2c0xlbEdPVlJROGcyTVZsbGVvdnEx?=
 =?utf-8?B?bTBVYTExbTVCL1Boak1Sb2VSWnRkTzFJTHRBSWpmb0pENEtnMFVmOXpmYnlC?=
 =?utf-8?B?eG5mUDU4Y3ZtdjFJNVZZMEJjOXJjcGlGT0NDc0dFM09nME8yaWh2NktMWlZS?=
 =?utf-8?B?QTNoVEpWMjRTcUtuU25Gbmk2eXRncjlrZHFNR2wxdXZzeG42VmhDUytueWRZ?=
 =?utf-8?B?YzR2Mm5aYnV0bU1panBuMjYxUXc3TGlpZm51QWlvQ0dCZHJWNGg0dkpqUHNz?=
 =?utf-8?B?OTl2TVJBLzVhbzJqdFIvMUFvWUZJR3FkMjQyblZCSzJlWTlTVjJ0MDdtQURW?=
 =?utf-8?B?L2hYSjVMVjBlNkpueHFaNG83RFdubEd2UHhGNFQvOGJkQ0M2K2dtd1ZHTVox?=
 =?utf-8?B?azVtQ1B4eWEyKy8rbWc4aW5HUlR3VDlWcXJkcUxqNFpzR2JnQm9LTlFjNS9i?=
 =?utf-8?B?ZS9JTmVTRFVaKzRjTm1aQ2NlTWJncWJ6c1pQaElHbkxWSGVUMU44QW5XdStP?=
 =?utf-8?B?MjAzcjVPd2dYcEUxM1ZmVkVEc20ra1BkRUhLdEV4QlZqK0pFTHBkbmEyYTdZ?=
 =?utf-8?B?SGt6WGdDUStGSVdONHoyb0R1b1hQWXNNbWFJMGpBRzJNY0VHL3E5Vk9wWVlI?=
 =?utf-8?B?NEgvUHoxbXVEUjVPaDZKMlRic2ppL3RIS1A2VmNFN3NtblRVMElMKzF0Sm03?=
 =?utf-8?Q?XI3oPYminmWM7IgPQBQInTM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a86da4-bf71-4429-14d3-08d99cc9ad89
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2021 23:53:46.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/Tzl8Tvp04vcRW52Ht5ZuveKiWiIfpYYHjDfgq0yEG7nndQLzTWOzx3xBI/Br9sNnGRk9HNh2fE/Ma5N5SvIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8463
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUXVhbmZhLA0KDQo+IEBAIC0xNjUzLDcgKzE2NTMsNyBAQCBpbnQgbWVtb3J5X2ZhaWx1cmUo
dW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gDQo+ICAJLyoNCj4gIAkgKiBXZSBuZWVk
L2NhbiBkbyBub3RoaW5nIGFib3V0IGNvdW50PTAgcGFnZXMuDQo+IC0JICogMSkgaXQncyBhIGZy
ZWUgcGFnZSwgYW5kIHRoZXJlZm9yZSBpbiBzYWZlIGhhbmQ6DQo+ICsJICogMSkgaXQncyBhIGZy
ZWVkIHBhZ2UsIGFuZCB0aGVyZWZvcmUgaW4gc2FmZSBoYW5kOg0KPiAgCSAqICAgIHByZXBfbmV3
X3BhZ2UoKSB3aWxsIGJlIHRoZSBnYXRlIGtlZXBlci4NCj4gIAkgKiAyKSBpdCdzIHBhcnQgb2Yg
YSBub24tY29tcG91bmQgaGlnaCBvcmRlciBwYWdlLg0KPiAgCSAqICAgIEltcGxpZXMgc29tZSBr
ZXJuZWwgdXNlcjogY2Fubm90IHN0b3AgdGhlbSBmcm9tDQoNCkkgdGhpbmsgdGhhdCB0aGUgd29y
ZCAiZnJlZSBwYWdlIiBpcyBjb21tb24gZW5vdWdoIGFuZCB5b3UgY2FuIGZpbmQgaXQNCmluIG1h
bnkgb3RoZXIgZmlsZXMsIHNvIGl0IG1ha2VzIGxpdHRsZSBzZW5zZSB0byBmaXggaXQgYXMgYSB0
eXBvPw0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGkNCg==
