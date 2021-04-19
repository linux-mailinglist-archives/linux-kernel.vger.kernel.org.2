Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099083638FE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbhDSBK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:10:27 -0400
Received: from mail-eopbgr1410055.outbound.protection.outlook.com ([40.107.141.55]:6735
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233117AbhDSBK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLzTx963KUXvAtiNIm34enw0sTniwWKSfkkDYTuvL04SI7YbXuM2UiLw/A25v/ytTUUreWOnNUaq/3mnEDxgOl/0yl1yFVkJB3qWRUXuPmGfKxLH1pHRycOja6b9HYN8zYz6orcP5K8pbiIFYL4FPEh9RAMkmprLiVmgPdipaUaObrF5ZuqrPC0pWn3rZTAk06bHu2s443IKWiCv8PtCvTyeOlOJF1NGru31Fb+BXvYarEJEzCwI81sdoJ/IJbz5v7HVGfELUEVIpNDtxPo3+fn13YM+QQw5LqvVFS8VS1M5TgzCMyiZLk3s0Znbb+jmo7hpHR8QAzp6ZQur+j5cSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z3I/+uF3B+mOEGghcahxryF45+sEEfJNDycfolBCQs=;
 b=B2RGO9LaZ/L/YMQL/XCizG42KV5EGBuJOdEbRII+dJqS1ES+A+MJBbW/xv+3S3uSoY129fKUe0Vzp3qsMc4bqRpum+S0NoKwwlATNAVX9q67gJILXVNe02mBOwElhgkhnqWehflzTU5NX6SPGy1PWasCTB8vMVcllBdK6C2MnJFgsZueW7yDQzz2kvVYB7dLt62yPohTXzRXZzixdYlOmrjjxh8A5ufupVWEJRDYsA+33N1pJRb0sWBPWTk+7mEfrNx4RhuELfnrM2TpC/lWdXeOFiaYdWSp5TNZSsvC4yYdwMRi/NM6Cl/r+5LwbIsnp2k36K5qess7P5bTI5gvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z3I/+uF3B+mOEGghcahxryF45+sEEfJNDycfolBCQs=;
 b=Bfls5X3OvFp9r9T/YQWK2fVdiu36I7hcdIV9T4xJyRVT8mg0yeNIdWV4QMvACX1J8sXJfYSBUmXWQmQj2WyCIg/wX86RfenbMQz5BSGOcYEdg6iKk5IrO/aO+DH+WqBzlAEbxhhKvVBAec8MkeTd4hxyJq2BP/si+eXDa2hetQk=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB2479.jpnprd01.prod.outlook.com (2603:1096:404:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Mon, 19 Apr
 2021 01:09:56 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 01:09:55 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Topic: [PATCH v1 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Index: AQHXM007F8gsmjotRU26y7BjHIslbKq7CtCA
Date:   Mon, 19 Apr 2021 01:09:55 +0000
Message-ID: <20210419010955.GA17180@hori.linux.bs1.fc.nec.co.jp>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
 <20210417134751.0bee9e73@alex-virtual-machine>
In-Reply-To: <20210417134751.0bee9e73@alex-virtual-machine>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kingsoft.com; dkim=none (message not signed)
 header.d=none;kingsoft.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ec63a9a-76bb-40b5-0f94-08d902cfd84b
x-ms-traffictypediagnostic: TYAPR01MB2479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2479EFA53446F2F64B486FD9E7499@TYAPR01MB2479.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JXxKb4y03QhbaKzYwNZ5ko9gd3OpNiNZmi+9r+VJmIf56D20ey17T1DJTniYX4FaSZbOzVeJ90/gs53vyUiELGGCU0BvawmmvXXZwd3N+tTk71E6DrYjrSoMU5U7bFajZBf1xMUCMJVDMaR/XdzeYi+IMqlennIIZAtstuR5Zbn16SSHQrzVsg682n2yzKmpAfPkCurr767C6CtlIX/RXBTysyRq9wxxesl23r8q4BhvVqzHKOMBy2mpmLhbg+huxU/PuQ4RGpIxzED2rQsvj6HoecE7RfkRrqMH8kIhWPacHqo/0/WCJDx4WyrKjROr/iQ6alTsmrFo+S3P0ZQW9ZCGFGngHdP5q8q3n+wcLcSMSQnN2O5GdcOjRUCFuQQwMiMNIsdfzs/zrO/taLQPUksl22hKZXMnoFxFVLtiuPSMDAy+20q6KHiUGRYjkUL3HuDy5FJNa/wdTfx0qcatgSl+WGinGzu+qcfZ1YP7AxDgX7PquGbWj8n2tIzfAUWA6etlosuhIRZt+PIsNzbdFTjc6vvJrNkNXwuWAL4pS0gmMmOaY/rnfP84sEKHegfmy2JDUeKrtvwpx535XsezZlmU3hc7FqMNHtzUbIukX5FNJM8PmG8lUDsqC7clLB+xWogIo0Sd6zopmsvib6NYZto8o5s+bSLy1KUFytJ278fLrasK34utBkZiK/8nK1IX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(1076003)(478600001)(86362001)(64756008)(83380400001)(54906003)(66476007)(2906002)(33656002)(66556008)(76116006)(316002)(4326008)(66446008)(66946007)(38100700002)(7416002)(186003)(6916009)(8676002)(8936002)(6486002)(26005)(5660300002)(55236004)(71200400001)(122000001)(9686003)(85182001)(966005)(6512007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bDJWd2RJWGVEbVFuT1RDRjdIaXIxcGJySmZuM3MzN0htZmd4bWxzSFNLNU9R?=
 =?utf-8?B?MFRDa2gxWm8wZU1ibVVpZ2o3WllDNXh0b1JuSG9uU3c5TmthclRSZXFxdWdI?=
 =?utf-8?B?Z3dLZldvOUs2YksvNEhkck5BajBvdjVzZ3ViVFRJTnN4d1Y3SkdPZU1jaS81?=
 =?utf-8?B?elRaWUw4NHQ4cW51R0g5dUhXdUIvTXRZQzQrTWdaM1hOOGJFeWcxck9ZN3VW?=
 =?utf-8?B?TnRNdzM1TEJ1eUE3c3BsbnphTmdBY2pGNnZoKytaenpQRXRMeWtzUFpTNWcw?=
 =?utf-8?B?QnlxUFNwYlNPNXE4R3JiSnRLRG13ZGsyTERwR1M5dGVjR1VQNTZobWJtcVlD?=
 =?utf-8?B?WmZKN3F5ODhpbzIzNHZZZVNtcGY3QzN6cTk2WldhYkQveVhhczNWRUpEY3p2?=
 =?utf-8?B?L01kSUFrZnhOMnpaY3Nia2JsMVFiMU1LZFhsSHFKaHFwMWZqK3p3aWhoa3lT?=
 =?utf-8?B?Zk1NY0V6VHJIR1c2ZlI2V1p4K2NQZ3R0cW1TZXRFV1Y2Nk10bm9tL2hnWFN4?=
 =?utf-8?B?TzhKRU1mcFlqektWQzE2WXZENWRSWUgzeHFPeFp2ZkZCZ2RHUVY0R1c3ejVL?=
 =?utf-8?B?QW9SRHhKbnNON3JuQTRHVTg3SlF2bzllb1JWK0dtblpMQkVjOHhub2ZuTUxx?=
 =?utf-8?B?S3NhdVVUVFErSW5WSk5ESlEyMDFuc0cwYzA0cExaZVZIMzVaK3FxQ3NjTmY4?=
 =?utf-8?B?T3lsL1V2TVdIOG5GbkVTVEVNZ1J2Slhvd3RGRVB0MlhvZnE4THZvbGJaVjZU?=
 =?utf-8?B?c0I3SmdKQ09SQllIUlVta256U3BSUzlwaFh1SmlHbE9qUEVOd0JYdTdtazYx?=
 =?utf-8?B?eG5yZXBHUTIyQm1SM3piMzVyUm9DTWR0RFFLYjFmcWxvcXNobmZxalZUdlgx?=
 =?utf-8?B?SE5tU1BTYjJhMGlhczVtdXJxRkM0VHdHY0htQ3Q4Z3RyZjZhWlR3QmNWcU5I?=
 =?utf-8?B?bEZVN2QrNURFVFdML294NmxwMFp5VkhZbHZnT2ZVSUV1K2pNNTZISUIvV0g5?=
 =?utf-8?B?VnJuaTBHM0xIaDRpOTl4cEJ3ZS9vekQ1UnkyNk45c1VVbXFFS0dxTnlkV1dn?=
 =?utf-8?B?MjYydFlJcVNPVjd3Q0lObDlBNStQQ0xlZDZmNHA2UDQ4Y2tXelE3ZDQwWTN5?=
 =?utf-8?B?OHhIVEdoTkRxYzFjK21KdEJ6Y1dCblBja1JqMHlIdCszUlZOc29rWTA1bjlv?=
 =?utf-8?B?KzVTWXhrSnQ5S3JuMlZCWHB5MFR5ajdLWmc4aFc1ak1DT3UwZkxOZzlCWE8y?=
 =?utf-8?B?MVJqeGg4UWxRNDA1MUpibFhWUUJBSkVnOVBITk0rQXBPSW1VMm90TER3Y0RO?=
 =?utf-8?B?WHg1dFZSazdoVHNhRmVSUlh2OEJwaHRxWWdqSzN1THhrLzVaOXNmRWxYY3d5?=
 =?utf-8?B?RmxmOTBES2hRQ2hKUVJlZmN6NUJ4MzNOVk1BMm51Y2JHRThmZ2pTMGRhS1lX?=
 =?utf-8?B?QVpsbHFVNDl3bXpESUpGMnQ2YWFaUG1ZTmUxZVBabnBndXJDS2twN2IvMURk?=
 =?utf-8?B?VVVCNmJpUDk1WGowUXVsNmwyL25IR3FkYWs0MDFqSXliNTA0UjErQzZJeTNz?=
 =?utf-8?B?YnN1aEhmNlEzRzhKdTRIaGhIVGt4d05MUEN0VWxjbE11ekVzMldnRHRqaDVv?=
 =?utf-8?B?a25wVU44ekZBRXBsZzd0RklIN20wZGhFMVhuSVpQSDJYa2FWRnZueERwQi91?=
 =?utf-8?B?enNRbnljRWR0dW03bHVnZ0FDVTZkOHkvT0JiVjVEeGc3SWRxa3U5b20wc0tl?=
 =?utf-8?B?YlhBODVPZTIrY09rOHdBSVZ0a0ttSXN6M2Z3d2dzSjU0a0NQK0J2RDg2R2xF?=
 =?utf-8?B?VG5NZFZ5STBKZEN5S2RYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CC27B7745E21A41BBEDECABEC1D21C5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec63a9a-76bb-40b5-0f94-08d902cfd84b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 01:09:55.8830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iB8mBAC4evetO8KuJepN8I86oXCS9TL4uDFUeRrh3uLI1UgHFCyCFOftWMQjWgDNDcx1iDvMVr7KTvXUfefBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2479
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBBcHIgMTcsIDIwMjEgYXQgMDE6NDc6NTFQTSArMDgwMCwgQWlsaSBZYW8gd3JvdGU6
DQo+IE9uIFR1ZSwgMTMgQXByIDIwMjEgMDc6NDM6MTcgKzA5MDANCj4gTmFveWEgSG9yaWd1Y2hp
IDxuYW8uaG9yaWd1Y2hpQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhpLA0KPiA+IA0KPiA+
IEkgd3JvdGUgdGhpcyBwYXRjaHNldCB0byBtYXRlcmlhbGl6ZSB3aGF0IEkgdGhpbmsgaXMgdGhl
IGN1cnJlbnQNCj4gPiBhbGxvd2FibGUgc29sdXRpb24gbWVudGlvbmVkIGJ5IHRoZSBwcmV2aW91
cyBkaXNjdXNzaW9uIFsxXS4NCj4gPiBJIHNpbXBseSBib3Jyb3dlZCBUb255J3MgbXV0ZXggcGF0
Y2ggYW5kIEFpbGkncyByZXR1cm4gY29kZSBwYXRjaCwNCj4gPiB0aGVuIEkgcXVldWVkIGFub3Ro
ZXIgb25lIHRvIGZpbmQgZXJyb3IgdmlydHVhbCBhZGRyZXNzIGluIHRoZSBiZXN0DQo+ID4gZWZm
b3J0IG1hbm5lci4gIEkga25vdyB0aGF0IHRoaXMgaXMgbm90IGEgcGVyZmVjdCBzb2x1dGlvbiwg
YnV0DQo+ID4gc2hvdWxkIHdvcmsgZm9yIHNvbWUgdHlwaWNhbCBjYXNlLg0KPiA+IA0KPiA+IE15
IHNpbXBsZSB0ZXN0aW5nIHNob3dlZCB0aGlzIHBhdGNoc2V0IHNlZW1zIHRvIHdvcmsgYXMgaW50
ZW5kZWQsDQo+ID4gYnV0IGlmIHlvdSBoYXZlIHRoZSByZWxhdGVkIHRlc3RjYXNlcywgY291bGQg
eW91IHBsZWFzZSB0ZXN0IGFuZA0KPiA+IGxldCBtZSBoYXZlIHNvbWUgZmVlZGJhY2s/DQo+ID4g
DQo+ID4gVGhhbmtzLA0KPiA+IE5hb3lhIEhvcmlndWNoaQ0KPiA+IA0KPiA+IFsxXTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyMTAzMzExOTI1NDAuMjE0MTA1MmZAYWxleC12
aXJ0dWFsLW1hY2hpbmUvDQo+ID4gLS0tDQo+ID4gU3VtbWFyeToNCj4gPiANCj4gPiBBaWxpIFlh
byAoMSk6DQo+ID4gICAgICAgbW0saHdwb2lzb246IHJldHVybiAtRUhXUE9JU09OIHdoZW4gcGFn
ZSBhbHJlYWR5DQo+ID4gDQo+ID4gTmFveWEgSG9yaWd1Y2hpICgxKToNCj4gPiAgICAgICBtbSxo
d3BvaXNvbjogYWRkIGtpbGxfYWNjZXNzaW5nX3Byb2Nlc3MoKSB0byBmaW5kIGVycm9yIHZpcnR1
YWwgYWRkcmVzcw0KPiA+IA0KPiA+IFRvbnkgTHVjayAoMSk6DQo+ID4gICAgICAgbW0vbWVtb3J5
LWZhaWx1cmU6IFVzZSBhIG11dGV4IHRvIGF2b2lkIG1lbW9yeV9mYWlsdXJlKCkgcmFjZXMNCj4g
PiANCj4gPiAgYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIHwgIDEzICsrKy0NCj4gPiAg
aW5jbHVkZS9saW51eC9zd2Fwb3BzLmggICAgICAgIHwgICA1ICsrDQo+ID4gIG1tL21lbW9yeS1m
YWlsdXJlLmMgICAgICAgICAgICB8IDE2NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE3OCBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiANCj4gSGkgTmFveWEsDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gg
YW5kIGNvbXBsZXRlIGZpeCBmb3IgdGhpcyByYWNlIGlzc3VlLg0KPiANCj4gSSB0ZXN0IHlvdXIg
cGF0Y2hlcywgbWFpbmx5IGl0IHdvcmtlZCBhcyBleHBlY3RlZCwgYnV0IGluIHNvbWUgY2FzZXMg
aXQgZmFpbGVkLCBJIGNoZWNrZWQgIGl0DQo+IGFuZCBmaW5kIHNvbWUgZG91YnQgcGxhY2VzLCBj
b3VsZCB5b3UgaGVscCBjb25maXJtIGl0Pw0KPiANCj4gMS4gdGhlcmUgaXMgYSBjb21waWxlIHdh
cm5pbmc6DQo+IHN0YXRpYyBpbnQgaHdwb2lzb25fcHRlX3JhbmdlKHBtZF90ICpwbWRwLCB1bnNp
Z25lZCBsb25nIGFkZHIsDQo+IAkJCSAgICAgIHVuc2lnbmVkIGxvbmcgZW5kLCBzdHJ1Y3QgbW1f
d2FsayAqd2FsaykNCj4gew0KPiAJc3RydWN0IGh3cF93YWxrICpod3AgPSAoc3RydWN0IGh3cF93
YWxrICopd2Fsay0+cHJpdmF0ZTsNCj4gCWludCByZXQ7ICAgIC0tLS0gaGVyZQ0KPiANCj4gSXQg
c2VlbXMgdGhpcyByZXQgbWF5IG5vdCBiZSBpbml0aWFsaXplZCwgYW5kIHNvbWUgdGltZSByZXQg
bWF5IGJlIGVycm9yIHJldHJ1bmVkPw0KDQpZZXMsIEknbGwgaW5pdGlhbGl6ZSB3aXRoIDAuDQoN
Cj4gDQo+IGFuZCBmb3IgdGhpczoNCj4gc3RhdGljIGludCBjaGVja19od3BvaXNvbmVkX2VudHJ5
KHB0ZV90IHB0ZSwgdW5zaWduZWQgbG9uZyBhZGRyLCBzaG9ydCBzaGlmdCwNCj4gCQkJCXVuc2ln
bmVkIGxvbmcgcG9pc29uZWRfcGZuLCBzdHJ1Y3QgdG9fa2lsbCAqdGspDQo+IHsNCj4gCXVuc2ln
bmVkIGxvbmcgcGZuOw0KPiANCj4gSSB0aGluayBpdCBiZXR0ZXIgdG8gYmUgaW5pdGlhbGl6ZWQg
dG9vLg0KDQpPSy4NCg0KPiANCj4gMi4gSW4gdGhlIGZ1bmN0aW9uIGh3cG9pc29uX3B0ZV9yYW5n
ZSgpOg0KPiBpZiAocGZuIDw9IGh3cC0+cGZuICYmIGh3cC0+cGZuIDwgcGZuICsgUE1EX1NJWkUp
IHRoaXMgY2hlY2sgc2VlbSB3ZSBzaG91bGQgdXNlIFBNRF9TSVpFL1BBR0VfU0laRSBvciBzb21l
IG1hY3JvIGxpa2UgdGhpcz8NCg0KVGhhbmtzLCB0aGF0J3MgcmlnaHQuICBIUEFHRV9QTURfTlIg
c2VlbXMgdG8gZml0IGhlcmUuDQpXZSBhbHNvIG5lZWQgIiNpZmRlZiBDT05GSUdfVFJBTlNQQVJF
TlRfSFVHRVBBR0UiIHRvIHVzZSBpdC4NCg0KPiANCj4gMy4gdW5zaWduZWQgbG9uZyBod3BvaXNv
bl92YWRkciA9IGFkZHIgKyAoaHdwLT5wZm4gPDwgUEFHRV9TSElGVCAmIH5QTURfTUFTSyk7IHRo
aXMgc2VlbXMgbm90IGV4YWN0IGFjY3VyYXRlPw0KDQpBcyBvcGVyYXRvcnMgcHJlY2VkZW5jZSBy
dWxlLCB3ZSBldmFsdWF0ZSB0aGlzIGluIHRoZSBmb2xsb3dpbmcgb3JkZXI6DQogIDEuIH4gKGJp
dHdpc2UgTk9UKSwNCiAgMi4gPDwgKGJpdHdpc2UgbGVmdCBzaGlmdCksIGFuZA0KICAzLiAmIChi
aXR3aXNlIEFORCkuDQoNClNvIHRoaXMgcGFydCBhcmUgZXF1aXZhbGVudCB3aXRoICgoaHdwLT5w
Zm4gPDwgUEFHRV9TSElGVCkgJiAoflBNRF9NQVNLKSksDQp3aGljaCBzaG91bGQgcHJvcGVybHkg
Y2FsY3VsYXRlIGFuIGFkZHJlc3Mgb2Zmc2V0IHdpdGhpbiBhIHBtZC4NCg0KPiANCj4gNC4gc3Rh
dGljIGludCBzZXRfdG9fa2lsbChzdHJ1Y3QgdG9fa2lsbCAqdGssIHVuc2lnbmVkIGxvbmcgYWRk
ciwgc2hvcnQgc2hpZnQpDQo+IHsNCj4gCWlmICh0ay0+YWRkcikgeyAgICAtLS0gSSBhbSBub3Qg
c3VyZSBhYm91dCB0aGlzIGNoZWNrIGFuZCBpZiBpdCB3aWxsIGxlYWQgZmFpbHVyZS4NCj4gCQly
ZXR1cm4gMTsNCj4gCX0NCj4gSW4gbXkgdGVzdCwgaXQgc2VlbXMgc29tZXRpbWVzIGl0IHdpbGwg
aGl0IHRoaXMgYnJhbmNoLCBJIGRvbid0IGtub3cgaXQncyBtdWx0aSBlbnRyeSBpc3N1ZSBvciBt
dWx0aSBwb3Npb24gaXNzdWUuDQo+IHdoZW4gaSBnZXQgdG8gdGhpcyBmYWlsLCB0aGVyZSBpcyBu
b3QgZW5vdWdoIGxvZyBmb3IgdGhpcywgYnV0IGkgY2FuJ3QgcmVwcm9kdWNlIGl0IGFmdGVyIHRo
YXQuDQoNCkFzIHlvdSBjb21tZW50ZWQgYWJvdmUsIHRoaXMgdmVyc2lvbiBpcyBidWdneSwgYW5k
IHRoYXQgbWlnaHQNCm1ha2UgeW91IHNlZSB0aGUgcmFuZG9tIGZhaWx1cmUuIFNvcnJ5IGFib3V0
IHRoYXQuDQoNCj4gDQo+IHdvbHVkIHlvdSBoZWxwIGNvbmZpcm0gdGhpcyBhbmQgaWYgYW55IGNo
YW5nZXMsIHBsZWFzZSBwb3N0IGFnYWluIGFuZCBJIHdpbGwgZG8gdGhlIHRlc3QgYWdhaW4uDQoN
CkknbGwgc2VuZCB0aGUgZml4ZWQgb25lIGZvciBwYXRjaCAzLzMgc29vbiBsYXRlci4NCg0KVGhh
bmtzLA0KTmFveWEgSG9yaWd1Y2hp
