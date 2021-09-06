Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE9401684
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 08:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbhIFGmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 02:42:21 -0400
Received: from mail-eopbgr90074.outbound.protection.outlook.com ([40.107.9.74]:20576
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239633AbhIFGmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 02:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ4jrCgbtHQc4cJgAlPBaTVr/lSF7SPsvbbGxyto7y8aYF39YBbB2VrTZSYQId+SzVk/PnF5RQNBNk4bAX7CrnbiMZALtWVybqnBZ8txKz2xxWHiTTXP7XJygPO/2onuqbQpwLLw53LNrpTfImlNT3N4vZZksRWSjO4B2lKnFjKdRjcBOMFgGmzZl6u7XUz/h6VIDxprtcbO5Y71eMXD4iigtK1PeOY7n4TZr/xpHe8PVTwLEciVZU5Sey79Ayg4uy1CgKN2Mh3IPRlhiMfSrpjRjzPGFJGLshElWsefs8nEB16yTs7MyHsEMlQxUwVFIpeLaVcUnhdspGhvIj41lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pQs6xohGN2XxN+vOVA6rzjemAsE9vj5sMRYaIGnXjRY=;
 b=GafhOJeWWuFIgESulqJdR353exGv0z8Sf4sfs5sem5oU2IG1Bed0CDgQZ6lKjlkC1L5leMXRAxW2JCH25iPpPsJ3fbicv3yQ6kW8nVCSBCND6y4fo6/cgh8qC2Hi3NXutTq01q83hYGyC0hgSSPnLmyOTIYDi/eaJiA+xFgbO8KlB7CQkGYzaTdegLUJahUadUZnCcLW90sB5KBjYZ7AuPOrWhp1bdqLdbaTc9eT8iqhs4hipIFrGAyjMtKtuq7JwHC+JN9EH6Wb8XX570jFxrzygSuJDM0UZRFjxbd2P+KCn0tTvCeGmEXjo44Fcs6xbnKE5/9yPEXwMqOoNEFV+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=csgroupeu.onmicrosoft.com; s=selector1-csgroupeu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQs6xohGN2XxN+vOVA6rzjemAsE9vj5sMRYaIGnXjRY=;
 b=FOYIcv9rsGi/YsJlZ3Bpwe7Y8EK4JQebJc1LaKYiphb6l/mC6QSiB/M3/Iz6/LXlBEeTUu6upUOQiC6VWB8upFIbJ1r6MRsh167cFHwZ5qHV7bT5D47Qh4C+ufBKTCMWa7M5RX7s63NR8u8sNaqSyitGcQzWteBLLLpISBamqTXJpI4JTe+w3RLjS0A5UEZL0YQpfJvJV3bIA1qUzx/yACU4WaC1cV6AulLK9ZeM0nxHXf7CiSKLnzs5qnYusAgek7djDjDrZ23tZVHzyN+dxV4yb4UTzjFdxbTJFo7nJHCxnqjVtg9yCaEod0FTxcYRHLSNg58pCrMWwbcHeP8sJA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2713.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Mon, 6 Sep
 2021 06:41:12 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a96f:bd29:7b7f:62d3]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a96f:bd29:7b7f:62d3%9]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 06:41:12 +0000
From:   LEROY Christophe <christophe.leroy@csgroup.eu>
To:     Paul Moore <paul@paul-moore.com>
CC:     Eric Paris <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>
Subject: Re: [PATCH] audit: Fix build failure by renaming struct node to
 struct audit_node
Thread-Topic: [PATCH] audit: Fix build failure by renaming struct node to
 struct audit_node
Thread-Index: AQHXoOYJu5NjYci2nk+PZvN19Oo7p6uWkpCA
Date:   Mon, 6 Sep 2021 06:41:11 +0000
Message-ID: <2057e2ab-b303-8ec6-9c43-2c2614591925@csgroup.eu>
References: <4e2370a9022495c49f3108fe34c5a2b2f4b28dfa.1630684009.git.christophe.leroy@csgroup.eu>
 <CAHC9VhS4Q8U6ZVPoSaVuDawMLS6VOtwZZVNMT1QeFAJUeQHj-Q@mail.gmail.com>
In-Reply-To: <CAHC9VhS4Q8U6ZVPoSaVuDawMLS6VOtwZZVNMT1QeFAJUeQHj-Q@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: paul-moore.com; dkim=none (message not signed)
 header.d=none;paul-moore.com; dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cff6057d-88dc-4aff-adaa-08d971015136
x-ms-traffictypediagnostic: MRZP264MB2713:
x-microsoft-antispam-prvs: <MRZP264MB2713CABA6680D7C4DAE93467EDD29@MRZP264MB2713.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gz20f28/L3yFldbcT7q8kYNoQRntTZ41SKbDpIMlVDPdLRSdLFONOBnJftvrrTo3fjGMtOgSTL8jVEhjmeAqK9XaNNO+eoz/iw/J19cG4MhWtY/JqftFP4tXCxfFVd7/GYFnoxRNo9HJDZ2488mVOG3ec/Qs2etDw8+bwlLcyGH5MZUn0l+Cv9HEzCAfBPyPwm7kT419laZLn6r8m4B/BNPeaM9CleZENxAzc+XUBaL/4SNV3lSlCDdev0+MLtGHk4CtnDtywgaPbW5dyWq17mUCDnuIUfq8OQsfgMzbzENx9hpLBDQZPtvWwt2pL3Si2u7A7KRJUlGybt5T8v8/GhwxDB+UgVeLex5+dFJcEK0HbYF/787Kk+h0NbQbnYQ66UkEla0WLBna6aO+TSEilnKF1k1E/Ve07exz0d0gkgWpxn94RwT4Ffdu7k8SpQwJydulxsGB0S0pJ6bRD9Hp7aLUfUI+VB379xBdCJ//h8DbqH17mJala6Ga+odtoVoavuf2mBHvelLv14RBeOC/DkuN6bSD71yXG6SQBtxoEzZhCjZDnEXuTMrGRbVvKmOl/OaPzrezJwmeYUh4aUPEcSjPbi+3/IaqoE4rBaGHXJ0tcyzi2n8ju5PC/MT//14PQ6mHJkYPHzHAIHetKsPDLyoM6WT1Xy1/nlvKF2CZH9YZIaodviJcLqbAP6L9ceviBl7x6OzdbDEPIvvgJrnfKuWKsJvUcC+Y/OWMC3qjidHbppVJmEa7YXYH+wF6Of+Ke4yWtlu7LfDuoDQ/S7Br6qCkqy6BLv386fIdmUJhaJqUjKp4Ei3llXq27xHStpnA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(39840400004)(396003)(186003)(71200400001)(26005)(2906002)(53546011)(6486002)(478600001)(6506007)(38070700005)(36756003)(6916009)(83380400001)(66574015)(122000001)(4326008)(8936002)(316002)(86362001)(54906003)(31696002)(38100700002)(6512007)(8676002)(66556008)(91956017)(66476007)(64756008)(66446008)(5660300002)(31686004)(66946007)(2616005)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2w4SGRNYjhWNlBCUVRSaWZkRkRMU2ZqKytSNjNtUGhnb3F4VWxNdW9mUGFO?=
 =?utf-8?B?bW5sOUNYeHhPbDNGbTl3YTdDanlLaERPZS80aTAwOVU1Y2dPTFBCeHZHVU5p?=
 =?utf-8?B?ZSt4d1JLK0FKbXRRZklHblQ2Qm5ibGt4UEtzNVo4cnd0Q2hBNmh1M0ZsK2Nx?=
 =?utf-8?B?RWdMNTIva3YyYmM0dXJFYk1UeGVyNFRIWi9YVFhoZmxkUU96Z2xUaTVPdisr?=
 =?utf-8?B?U0NlVVphWHcvNkVkTHlCWDQ0bm9vR05PdVg3K2NpckNVRU9EaUNxVUNJYkp4?=
 =?utf-8?B?REZ0RDExVXUyYkZRYmM1QTJMVUtqeEFqbmFEeUd1TmtHR2U0b3RhVUFqU2FI?=
 =?utf-8?B?WUEzT3R4LzM1NU51c1dQWWRlbEFvejBnRzRtaDZLUnoxYTdBaUJNUUpwZFVQ?=
 =?utf-8?B?dDNsc2VNYzFoYlpxUU1CQk1hSUc0ZEsvMFlJM1hWZ0l1THFpek9OdzM2QU4z?=
 =?utf-8?B?cnZaUTZIKyt4Mm5Nb1RtOHRBSUM3Qm5heWtFY0N4NCt1Q2JDQ2RIMEhkVytt?=
 =?utf-8?B?Mno4VVhvcG4zWE9nTXNQcGU1dG9qV29DRWc0dkhUYlJVRkNHa2tyS2lTeFZ4?=
 =?utf-8?B?aS9VcFUvRFh4bDFNcmRRUnptNmtDUlYvOUpYSXVkMzlpT0QySnhIK3JGR3Yx?=
 =?utf-8?B?NUVqZUNDZjJxK2xWOEp2eEppUGJqRTRITXFJOUJuWmJXN3JUaE5PVVV0QW0r?=
 =?utf-8?B?RTlVV0VvRXJadmNITWxESHVBc1ZvQ1ZaMENSa1ZJMm9HMjllTUw3TjVMdnk5?=
 =?utf-8?B?K2pKUlpzam43MFgzT0p6dEhnWkdwdkZLZ2tMN2dtZWNzR1ltUnV1ZGZVdHNP?=
 =?utf-8?B?cWl4M0tTb1N0YzRYQTdhdCtORzZiS2ZpSTY4K3ppc1NWWlNWRUR4bVY2cHQ4?=
 =?utf-8?B?NUd3eVREU2xSOTA2THZMWU9IbGJxMWJuem9INjIrNjFMK1NZclYvOFo0eity?=
 =?utf-8?B?aUNOYlpGOVlDK0FHNXpSNnp6Q25pTXNBQzhwdGdsd0F3NEt6SForNldXUE1a?=
 =?utf-8?B?aExCT0hMN3N4TnhEbjgzNUxsT0VaeDl2NVVZd0hYUEk4NDBhZ0IrVVc5a2Fy?=
 =?utf-8?B?VUJWc0hRSGVScFJyWDh5Q3JVS1lUN0ZVNUxaa3E5RWxqSDhKMmpBano2L2Iv?=
 =?utf-8?B?SUQwTHRBdGxIRnF3NTVzTmV6Zk91cEVmbU5pbSszZ3hpYVkrdC9wTUJYVWZv?=
 =?utf-8?B?b0FSRGVKNDh6Lzl5b2ltSm9EZmFZZGxCN092SS95V3l1MnFRQmI1aE10cTZx?=
 =?utf-8?B?WHAxY3JQRHh4UEl2amU3Z09JdWNyRjhyM3NNQSsrSytYeTRSVWtqZUZqdVVz?=
 =?utf-8?B?ZU1acUFZcHhVdW9tcjhkdHJxUGNEbm9hMHBWM2JzWGhnK2J2T0JDbThuRmpJ?=
 =?utf-8?B?MjVmdHBWOUpWNTJkZEEvdjYvWWJ6Q3pLNTRmRXB1aStxaHRwRzRyYUp4Y2RN?=
 =?utf-8?B?U0lIRUdZS1dYWFhnWTF1VEFNQ3h2dXcxZFlGa2xGSStwTCt2bUNjZ2xtV3p0?=
 =?utf-8?B?R2Y1L0FuaGJpd1NCOU4rVVErS1F1Q1phazJoeklrcFRFSVAybndRMkViczlV?=
 =?utf-8?B?MzFqMEJvUkN1UnJRSkdOaEd1TnRZV3hHYXp0V2gwMHVwKzFZL1JORXBPOUVS?=
 =?utf-8?B?TG9KOFljVitQY0xhV1gyMXoxYWtsajlmMW96ZVJQOFBSTG0xSFRibUVhdmNr?=
 =?utf-8?Q?rFztwJe64TfmRlM2Ux1b?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <407446281F197941B7A498EC645F9C15@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cff6057d-88dc-4aff-adaa-08d971015136
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 06:41:11.9845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clDsT1hbJF7HSq9gOb5rXeAu0Wfw0bO8aGIjvL/vL16Mo4n4Fq2m7xJbLl+mfZbBU31lbwsjpQrz2dP5dJT4tZ2O+rPTWe28zKPwN+f7Uu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2713
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAzLzA5LzIwMjEgw6AgMTk6MDYsIFBhdWwgTW9vcmUgYSDDqWNyaXTCoDoNCj4gT24g
RnJpLCBTZXAgMywgMjAyMSBhdCAxMTo0OCBBTSBDaHJpc3RvcGhlIExlcm95DQo+IDxjaHJpc3Rv
cGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPj4NCj4+IHN0cnVjdCBub2RlIGRlZmluZWQg
aW4ga2VybmVsL2F1ZGl0X3RyZWUuYyBjb25mbGljdHMgd2l0aA0KPj4gc3RydWN0IG5vZGUgZGVm
aW5lZCBpbiBpbmNsdWRlL2xpbnV4L25vZGUuaA0KPj4NCj4+ICAgICAgICAgICAgQ0MgICAgICBr
ZXJuZWwvYXVkaXRfdHJlZS5vDQo+PiAgICAgICAgICBrZXJuZWwvYXVkaXRfdHJlZS5jOjMzOjk6
IGVycm9yOiByZWRlZmluaXRpb24gb2YgJ3N0cnVjdCBub2RlJw0KPj4gICAgICAgICAgICAgMzMg
fCAgc3RydWN0IG5vZGUgew0KPj4gICAgICAgICAgICAgICAgfCAgICAgICAgIF5+fn4NCj4+ICAg
ICAgICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvY3B1Lmg6MTcsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3N0YXRpY19j
YWxsLmg6MTAyLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICBmcm9tIC4vYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL21hY2hkZXAuaDoxMCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZnJvbSAuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9hcmNocmFuZG9tLmg6NywNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvcmFuZG9tLmg6MTIx
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9uZXQu
aDoxOCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgv
c2tidWZmLmg6MjYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGZyb20ga2VybmVsL2F1
ZGl0Lmg6MTEsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGZyb20ga2VybmVsL2F1ZGl0
X3RyZWUuYzoyOg0KPj4gICAgICAgICAgLi9pbmNsdWRlL2xpbnV4L25vZGUuaDo4NDo4OiBub3Rl
OiBvcmlnaW5hbGx5IGRlZmluZWQgaGVyZQ0KPj4gICAgICAgICAgICAgODQgfCBzdHJ1Y3Qgbm9k
ZSB7DQo+PiAgICAgICAgICAgICAgICB8ICAgICAgICBefn5+DQo+PiAgICAgICAgICBtYWtlWzJd
OiAqKiogW2tlcm5lbC9hdWRpdF90cmVlLm9dIEVycm9yIDENCj4+DQo+PiBSZW5hbWUgaXQgYXVk
aXRfbm9kZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3Rv
cGhlLmxlcm95QGNzZ3JvdXAuZXU+DQo+PiAtLS0NCj4+ICAga2VybmVsL2F1ZGl0X3RyZWUuYyB8
IDIwICsrKysrKysrKystLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IFRoYXQncyBpbnRlcmVzdGluZywgSSB3b25k
ZXIgd2h5IHdlIGRpZG4ndCBzZWUgdGhpcyBwcmlvcj8gIEFsc28gYXMgYW4NCj4gYXNpZGUsIHRo
ZXJlIGFyZSBldmlkZW50bHkgYSBnb29kIGhhbmRmdWwgb2Ygc3ltYm9scyBuYW1lZCAibm9kZSIu
ICBJbg0KPiBmYWN0IEkgZG9uJ3Qgc2VlIHRoaXMgbm93IGluIHRoZSBhdWRpdC9zdGFibGUtNS4x
NSBvciBMaW51cycgdHJlZSBhcw0KPiBvZiBhIHJpZ2h0IG5vdywgYm90aCB1c2luZyBhbiBhbGx5
ZXNjb25maWc6DQo+IA0KPiAlIGdpdCBzaG93LXJlZiBIRUFEDQo+IGE5YzlhNmY3NDFjZGFhMmZh
OWJhMjRhNzkwZGI4ZDA3Mjk1NzYxZTMgcmVmcy9yZW1vdGVzL2xpbnVzL0hFQUQNCj4gJSB0b3Vj
aCBrZXJuZWwvYXVkaXRfdHJlZS5jDQo+ICUgbWFrZSBDPTEga2VybmVsLw0KPiAgIENBTEwgICAg
c2NyaXB0cy9jaGVja3N5c2NhbGxzLnNoDQo+ICAgQ0FMTCAgICBzY3JpcHRzL2F0b21pYy9jaGVj
ay1hdG9taWNzLnNoDQo+ICAgREVTQ0VORCBvYmp0b29sDQo+ICAgQ0hLICAgICBrZXJuZWwva2hl
YWRlcnNfZGF0YS50YXIueHoNCj4gICBDQyAgICAgIGtlcm5lbC9hdWRpdF90cmVlLm8NCj4gICBD
SEVDSyAgIGtlcm5lbC9hdWRpdF90cmVlLmMNCj4gICBBUiAgICAgIGtlcm5lbC9idWlsdC1pbi5h
DQo+IA0KPiBXaGF0IHRyZWUgYW5kIGNvbmZpZyBhcmUgeW91IHVzaW5nIHdoZXJlIHlvdSBzZWUg
dGhpcyBlcnJvcj8gIExvb2tpbmcNCj4gYXQgeW91ciBlcnJvciwgSSdtIGd1ZXNzaW5nIHRoaXMg
aXMgbGltaXRlZCB0byBwcGMgYnVpbGRzLCBhbmQgaWYgSQ0KPiBsb29rIGF0IHRoZSBhcmNoL3Bv
d2VycGMvaW5jbHVkZS9hc20vbWFjaGRlcC5oIGZpbGUgaW4gTGludXMgdHJlZSBJDQo+IGRvbid0
IHNlZSBhIHN0YXRpY19jYWxsLmggaW5jbHVkZSBzbyBJJ20gZ3Vlc3NpbmcgdGhpcyBpcyBhIC1u
ZXh0IHRyZWUNCj4gZm9yIHBwYz8gIFNvbWV0aGluZyBlbHNlPw0KPiANCj4gV2l0aG91dCBrbm93
aW5nIHRoZSBjb250ZXh0LCBpcyBhZGRpbmcgdGhlIHN0YXRpY19jYWxsLmggaW5jbHVkZSBpbg0K
PiBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbWFjaGRlcC5oIGludGVudGlvbmFsIG9yIHNpbXBs
eSBhIGJpdCBvZg0KPiBpbmNsdWRlIGZpbGUgY3JlZXA/DQo+IA0KDQpzdHJ1Y3QgbWFjaGRlcF9j
YWxscyBpbiBhc20vbWFjaGRlcC5oIGlzIGZ1bGwgb2YgZnVuY3Rpb24gcG9pbnRlcnMgYW5kIA0K
SSdtIHdvcmtpbmcgb24gY29udmVydGluZyB0aGF0IHRvIHN0YXRpY19jYWxscyANCihodHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXhwcGMtZGV2L2xpc3QvP3Nlcmllcz0y
NjA4Nzgmc3RhdGU9KikNCg0KU28geWVzLCBhZGRpbmcgc3RhdGljX2NhbGwuaCBpbiBhc20vbWFj
aGRlcC5oIGlzIGludGVudGlvbmFsIGFuZCB0aGUgDQppc3N1ZSB3YXMgZGV0ZWN0ZWQgYnkgQ0kg
YnVpbGQgdGVzdCANCihodHRwOi8va2lzc2tiLmVsbGVybWFuLmlkLmF1L2tpc3NrYi9idWlsZHJl
c3VsdC8xNDYyODEwMC8pDQoNCkkgc3VibWl0dGVkIHRoaXMgY2hhbmdlIHRvIHlvdSBiZWNhdXNl
IGZvciBtZSBpdCBtYWtlIHNlbnNlIHRvIG5vdCANCnJlLXVzZSBnbG9iYWJseSBkZWZpbmVkIHN0
cnVjdCBuYW1lcyBpbiBsb2NhbCBDIGZpbGVzLCBhbmQgYW55Ym9keSBtYXkgDQplbmNvdW50ZXIg
dGhlIHByb2JsZW0gYXMgc29vbiBhcyBsaW51eC9ub2RlLmggZ2V0cyBpbmNsdWRlZCBkaXJlY3Rs
eSBvciANCmluZGlyZWN0bHkuIEJ1dCBpZiB5b3UgcHJlZmVyIEkgZ3Vlc3MgdGhlIGZpeCBtYXkg
YmUgbWVyZ2VkIHRocm91Z2ggDQpwb3dlcnBjIHRyZWUgYXMgcGFydCBvZiB0aGlzIHNlcmllcy4N
Cg0KVGhhbmtzLA0KQ2hyaXN0b3BoZQ==
