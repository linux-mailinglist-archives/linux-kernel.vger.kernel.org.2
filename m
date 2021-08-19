Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050193F0F14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 02:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhHSANt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 20:13:49 -0400
Received: from mail-eopbgr1410053.outbound.protection.outlook.com ([40.107.141.53]:50817
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234119AbhHSANr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:13:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXjFPGLy/hMgUt6xoRScTRqBaz3qntVB7W2TEAYhhRU1aVUagzvWVva7hLdXL3/etPVSHv9Ju4zeOXiKMDC5OFfSdreYQxVhjRFS0j+o0I1Mn2+2tHnrAQHJeu1ImYQ5HmrYnMbhh7QOSCPywHwPDQNPMX9z6v+zp4wYkrG8AG0tCS4txi20n3rnCfP/QnUxGbQF+JoLNmSQgNhzSoz7yRoT+yemY44kCflpoGXamScGjkOR8mbgGV9mhM4yV5QomTgkAjQky2B8E0AuCufzOQoaq2JTp+Aj28mhsQv5I9ezf/Vr0sG+Mb9iCKhve+xFmQcy4xjo0c1Xq1cR7BWGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvPK5mfU4GwpxERiURVi8a3ljNF085nzhkbCBZTImCo=;
 b=Md9Tb627di8ZF0Ew/CB3UBPvWDeVStPixJdODbzGIp9aDmj+8GbW89fdp1ECvcrXt4tZg3urpJqRbJthoZzMrbhGC+nch9RrqBzAhomqLKuU4HohzV6pJa+NAADnFe8bcEGUP0WsEswCSHmW2dVfOyx6oyZgR6bLTMj+g8u5hBzcrI0wBXPW4ilbWBnj34bXs+yD+HuVktS3WBWLPUi/naVmkxt4CldBGHi1zl5Mt5E9e7P2DKOSMHkqH1JsEEpGBguoymoWz7ptMjIafIH04xmeBisKYWat7zyQMqCFkB2WEOLSZjSVxcPZMQRjpPa0vHDk57nWmvi4ZXo8JvtG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvPK5mfU4GwpxERiURVi8a3ljNF085nzhkbCBZTImCo=;
 b=bE0gzZSagas9RkP2YeKYkWua8/mJ4GGC0/mhBhrjXdoBHRI0gcScUOAcyINrm7cXzOWTe8vWu3fKlOQuAV+CdL0bOoXAOcrZB8wVaq4jLmxs3lUKYkxvUEzoa60xhVbFOYXE6tVHXowUbgdjxmYM3LfcKf1qZ5cSrTif2mZCUsw=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3966.jpnprd01.prod.outlook.com (2603:1096:404:c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.20; Thu, 19 Aug
 2021 00:13:10 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:13:10 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm/hwpoison: Retry with shake_page() for unhandlable
 pages
Thread-Topic: [PATCH v1] mm/hwpoison: Retry with shake_page() for unhandlable
 pages
Thread-Index: AQHXkyn3mr3Wy/J8FEG7nZwgKnBMvqt5kY2AgABmGwA=
Date:   Thu, 19 Aug 2021 00:13:10 +0000
Message-ID: <20210819001310.GA535269@hori.linux.bs1.fc.nec.co.jp>
References: <20210817053703.2267588-1-naoya.horiguchi@linux.dev>
 <CAHbLzkrHOHNRQU-TtR6cV9stV-c88jxg+LWbJBbBifh1n74FKw@mail.gmail.com>
In-Reply-To: <CAHbLzkrHOHNRQU-TtR6cV9stV-c88jxg+LWbJBbBifh1n74FKw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e4df1d8-51cc-4c2d-d0b3-08d962a620f7
x-ms-traffictypediagnostic: TYAPR01MB3966:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3966620747488ED66C3DBB77E7C09@TYAPR01MB3966.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LSD02rlI38viyiKvs3k2bKzT38M+y3hvVBCndWJh29Ij+Jh41lTsJ84Fk5Q1VJLlMC4vD/bk2T7YpxqSEDbbQCdW16asfP6v6MUhk2i0Q1SiatxYz79vj5/nhAwbkx7nLkC9ZB+nhyQ3l5bhjiV7YFGE0o9mTZZEZf8MxgFtgBcoiDONQffQLRmDiCZA/2LnHnkL/4035whM99w7GeTKQTUB2U9EZt0KjE4nWfqqRQA6bUNKH1edFEfpN3DDBS5wuK2yIdA2Xmh6J2edXExGznqOwSk6VijYFiq40WkSJddmAUkBSuG4IiE95f1TYb4ooQ4fKBwxPG+8JrHpL6c7GKswgWvyoPoeoIKKmJ9Kg5/YhNdNDj2B2mc9RqtmrP1hh7v6r0u/HrjLB8Yk82aOSbMQsakI72cVEBGPS9RKBwwSz85Jj5Wa6AE32lKo4fTQsvLF3pXYPU36na0xwlSmhObJWORgpw5Gb0k2l0xbgh4d62P6+eMWUamIwGnXI8E2lOCg8KRE1wo3HhrCWtvfp3D4zUZFFaHE7TjFM8wX9dqsaHLLiwluMLoi0HLHBfY9Fkrjqv/8TZrPg8+RR/EXz9JRzHrLqoIi6jqEfW+kTfozuXb10yjn8oQj7kfrBYYvkAU84xcW02cUo4+gwHNbsEMQUFJ+/4RCxvnTCe35ZoiYDqVdlf2Td/9RXc4sBdSsJ1lhjycAQOTz8qEUuxYiSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(66946007)(66476007)(55236004)(66556008)(53546011)(64756008)(66446008)(86362001)(6506007)(6486002)(38070700005)(8676002)(186003)(122000001)(38100700002)(33656002)(76116006)(7416002)(71200400001)(85182001)(83380400001)(5660300002)(478600001)(9686003)(54906003)(6512007)(8936002)(4326008)(316002)(6916009)(1076003)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJBSmdqY2VjSEVzUmJXQzV5SVZyeXZoWkMxdFViK0NCbGZNYjFsYWdOQmtq?=
 =?utf-8?B?eDBvbU4zOFpScGpobEVDTTRRc3pMUTdqNzJiUy8vMk1DT3c0RTIrTis3Nk11?=
 =?utf-8?B?aUF2REptMkplTUZ2Vlk1ckZHYzZES1JUVGNDM0JLOG1vd0QzS0xOaThGczMx?=
 =?utf-8?B?Slhab1JrYWtLdlV6akU1dUtrMTczRHJLdzk2dmNRaEQ2WnAzWTlrT3B5VUNl?=
 =?utf-8?B?WXlLa0JOWm1XdEJBb205MDBPZjNMNGZnY3VIL0t0N2lSendYbllsV0VZNFYy?=
 =?utf-8?B?OUZhU1Z0TGZCcXZBUzU5Tlk1akhyVVlTZkljaG9PS0xCUlRhbVdjejFjUnpQ?=
 =?utf-8?B?OElENlZsbDUxMWhUMnU5V0dueG43VDVYZUtMZHJNejR5by81VldnTGNKZmpT?=
 =?utf-8?B?TEtTT0ZkN0tGY3B3ZGQyREh6Mm9ZQzBvcldDcytFTTZYQmlVWG5SZXBYYStu?=
 =?utf-8?B?TUo0bFQ4WHZMOHNrTDNMVUd4RElmdHR5WlQ4TGlFRmNtaW5xSFNleGNWZFVE?=
 =?utf-8?B?YU5ZS1dmSlh5M0xZMVZmYXZHY25ibDIxRHJwZHQwUGhsaC90U2gzOFJlalFs?=
 =?utf-8?B?ckprZkd1c3ZacmVNWmhuUEVLbmFoU0dTK3Jyb2hjU0xGQmZHSWlPT1NvOU1n?=
 =?utf-8?B?ZG1Pd0ZxS2o3R0ZIcXRHVEMvQUMybXVncDZ0Z29wc09WcGYwTlB0L1NJTTVK?=
 =?utf-8?B?TlNMWWZ5ZklEaDJ3RkpDOEZJT2xrMjNQYjdwZEJlT0FzZUJodVFnaFZtZEVw?=
 =?utf-8?B?OFNIVTd3Rit1Rzl1bVFXT2pNbEo2OVdPYUNZQjdFUER1RzNtUjkyZlpBT2th?=
 =?utf-8?B?TkRlQ2g4QmxSR0tOMmdIMTNtT3lKeTlpM0VQRlRmcUtESklMTDJpdGVPdFdB?=
 =?utf-8?B?VEtWREJCK0dlN0lUdW5Cem1Dd1Rud3oyMmdJMXZZRlFWRU1WYytjbUt3V0Fl?=
 =?utf-8?B?SThUU1RYbUhFa2FVK0poL1lheXhhKzdDbVpNWHBrYnIrTXZUaGhhL3MydFh6?=
 =?utf-8?B?bzQ0dGh2SW50VGFoM1BSL21MQnNpWUYra3pBYTRxTUZPQmlZVFBkTUUvQW1K?=
 =?utf-8?B?d3B0WmxMU2FTbUhhdDNpbVo5Y2E0d0xRcnBsZTJDSzIwM1drOThUMlFyVWhk?=
 =?utf-8?B?R2dhb1ZzaDMva2p3QVdEeGV0enpJYS9lNE12TGxiSXc3WWVyYW5sS3d3QTlV?=
 =?utf-8?B?cDd5eEp6RGlSQXV6aTRLVVFySi9hQk9pVmNrUURObU1aZ2dqelV3aTMrS3Nq?=
 =?utf-8?B?eGsrVFRVNkVRdkFEd3JZbnJRWjJWNUdRWjJ2cUg5bjVESWRxaHdZMlFoZHZt?=
 =?utf-8?B?djBlOFE0b2ppc3Iwc0ttaFJuNHE3cnd2T2hNcUsxd29FVUQzMHRaNXRzMFA4?=
 =?utf-8?B?aEtXcmZ2WGZOOG4yaDVNK1RsRGxhMFUrYll4QTAyRlFSdHdobzZLYUo2djl3?=
 =?utf-8?B?Nm4vRkJ6QUtndm82R0VwNnAreXhIbnFJK3BSMlowc1FUa1ZzdThFd0xobFdF?=
 =?utf-8?B?NFJIQUNDMjR1UFFETU1GWXZhN2s3ekY0QldBdjJsclI4dTlMVEpsZzRrUmIx?=
 =?utf-8?B?REt0ZjJHMDRrdWJ1MUw0RWxmcm1pRzB3MEx6bVk4bzVJaGVPRTBMUG8vWkZR?=
 =?utf-8?B?L0tRMTBlSlNEaVRUamJrUkkyeFM4dTg1bXRoQzc1amRSNnoyM1FlanR0M2pM?=
 =?utf-8?B?NzZzYStrSWVuOWw5RDBzeUVVNVcvZVFLdDQ2ekV6MEhVektnY3JpZXlCcGZp?=
 =?utf-8?B?V2VIUS9HODFoQTNTMmM1OUkvWmhPN3hwRVdqZWhrejN5NGN6RlZzYjh4VUVZ?=
 =?utf-8?B?L0Jmb0U0VVFHeUxENFYwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09144A6541BB1246AFAA2FC6A9053021@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4df1d8-51cc-4c2d-d0b3-08d962a620f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 00:13:10.5851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8i0W2zUWZjGv+t5w2kjFX2V4ZQXl1hyij5doqCYNLD1+IrRFc091wH1bbIys5LGo+miXWE7jvkojEgOwipZFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMTgsIDIwMjEgYXQgMTE6MDc6NDNBTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0IDEwOjM3IFBNIE5hb3lhIEhvcmlndWNoaQ0KPiA8
bmFveWEuaG9yaWd1Y2hpQGxpbnV4LmRldj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBOYW95YSBI
b3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+DQo+ID4gSFdQb2lzb25IYW5k
bGFibGUoKSBzb21ldGltZXMgcmV0dXJucyBmYWxzZSBmb3IgdHlwaWNhbCB1c2VyIHBhZ2VzDQo+
ID4gZHVlIHRvIHJhY2VzIHdpdGggYXZlcmFnZSBtZW1vcnkgZXZlbnRzIGxpa2UgdHJhbnNmZXJz
IG92ZXIgTFJVIGxpc3RzLg0KPiA+IFRoaXMgY2F1c2VzIGZhaWx1cmVzIGluIGh3cG9pc29uIGhh
bmRsaW5nLg0KPiA+DQo+ID4gVGhlcmUncyByZXRyeSBjb2RlIGZvciBzdWNoIGEgY2FzZSBidXQg
ZG9lcyBub3Qgd29yayBiZWNhdXNlIHRoZSByZXRyeQ0KPiA+IGxvb3AgcmVhY2hlcyB0aGUgcmV0
cnkgbGltaXQgdG9vIHF1aWNrbHkgYmVmb3JlIHRoZSBwYWdlIHNldHRsZXMgZG93biB0bw0KPiA+
IGhhbmRsYWJsZSBzdGF0ZS4gTGV0IGdldF9hbnlfcGFnZSgpIGNhbGwgc2hha2VfcGFnZSgpIHRv
IGZpeCBpdC4NCj4gPg0KPiA+IEZpeGVzOiAyNTE4MmYwNWZmZWQgKCJtbSxod3BvaXNvbjogZml4
IHJhY2Ugd2l0aCBodWdldGxiIHBhZ2UgYWxsb2NhdGlvbiIpDQo+ID4gUmVwb3J0ZWQtYnk6IFRv
bnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBI
b3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnICMgNS4xMw0KPiA+IC0tLQ0KPiA+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgMTEg
KysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgdjUuMTQtcmM2L21tL21lbW9yeS1mYWlsdXJl
LmMgdjUuMTQtcmM2X3BhdGNoZWQvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+IGluZGV4IGVlZmQ4
MjNkZWI2Ny4uYWE2NTkyNTQwZjE3IDEwMDY0NA0KPiA+IC0tLSB2NS4xNC1yYzYvbW0vbWVtb3J5
LWZhaWx1cmUuYw0KPiA+ICsrKyB2NS4xNC1yYzZfcGF0Y2hlZC9tbS9tZW1vcnktZmFpbHVyZS5j
DQo+ID4gQEAgLTExNDYsNyArMTE0Niw3IEBAIHN0YXRpYyBpbnQgX19nZXRfaHdwb2lzb25fcGFn
ZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gPiAgICAgICAgICAqIHVuZXhwZWN0ZWQgcmFjZXMgY2F1
c2VkIGJ5IHRha2luZyBhIHBhZ2UgcmVmY291bnQuDQo+ID4gICAgICAgICAgKi8NCj4gPiAgICAg
ICAgIGlmICghSFdQb2lzb25IYW5kbGFibGUoaGVhZCkpDQo+ID4gLSAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+DQo+ID4gICAg
ICAgICBpZiAoUGFnZVRyYW5zSHVnZShoZWFkKSkgew0KPiA+ICAgICAgICAgICAgICAgICAvKg0K
PiA+IEBAIC0xMTk5LDkgKzExOTksMTQgQEAgc3RhdGljIGludCBnZXRfYW55X3BhZ2Uoc3RydWN0
IHBhZ2UgKnAsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICAgICAgICAg
ICAgICAgICB9IGVsc2UgaWYgKHJldCA9PSAtRUJVU1kpIHsNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICAvKiBXZSByYWNlZCB3aXRoIGZyZWVpbmcgaHVnZSBwYWdlIHRvIGJ1ZGR5LCByZXRy
eS4gKi8NCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAocGFzcysrIDwgMykNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAq
IFdlIHJhY2VkIHdpdGggKHBvc3NpYmx5IHRlbXBvcmFyeSkgdW5oYW5kbGFibGUNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgKiBwYWdlLCByZXRyeS4NCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocGFzcysrIDwgMykg
ew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2hha2VfcGFnZShwLCAxKTsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdHJ5X2FnYWluOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gDQo+IEkgdGhpbmsgdGhlIHJldHVybiB2YWx1
ZSBzaG91bGQgYmUgc2V0IHRvIC1FSU8gYmVmb3JlIGp1bXBpbmcgdG8gb3V0Lg0KPiBJJ20gc3Vw
cG9zZWQgLUVJTyBtZWFucyB0aGlzIGlzIHJlYWxseSBvciB2ZXJ5IGxpa2VseSBhbiB1bmhhbmRs
YWJsZQ0KPiBwYWdlLg0KDQpZb3UncmUgcmlnaHQsIEkgaGF2ZSB0aGUgc2FtZSBhc3N1bXB0aW9u
IHRoYXQgLUVCVVNZIG1lYW5zIHRyYW5zaWVudCBlcnJvcg0KYW5kIC1FSU8gbWVhbnMgcGVybWFu
ZW50IG9uZS4gQW5kIHdlIGNvbnNpZGVyIGFuIGVycm9yIGFzIHBlcm1hbmVudCB3aGVuIHRoZQ0K
cmV0cnkgbGltaXQgaXMgcmVhY2hlZC4gSSdsbCB1cGRhdGUgdGhlIHBhdGNoLiBUaGFuayB5b3Ug
Zm9yIHRoZSBjb21tZW50Lg0KDQotIE5hb3lhIEhvcmlndWNoaQ==
