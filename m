Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3734F804
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 06:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhCaEcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 00:32:55 -0400
Received: from mail-eopbgr1300071.outbound.protection.outlook.com ([40.107.130.71]:24171
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230309AbhCaEci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 00:32:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmlDgxfjwZ/46QzHeuB2p5frDKMKOCC9mqeMrbRlw4E14x1YtKM5yPoQsYnPFb6Q0/dsYQyhHCswG8wfRBFgo9jZQ8RNU4Ks0DGEjVaw9oWwGbY+e/db6tak3txdGCWNGsNU1tC606ea4t12sNPZNM2RFJDrlwyox/dosK8DRGzVz9yuRxvSb95HU/zF5bdX4N3i7kQIRGN3KgdGgOvKJWNL5JrkLGtbdCiE8MwF1kwDBxFX9eIjjbEJTGDAbX3fEY879ZybaqYZKikygLnoxjPqr8QnGkDzORKtgWyJF+RQsD2PLlgqJWc4CSr+nHfM6F++4Tlks1rxQmATQ2QWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI0Z6sayOxi+UdORawHeja8IBm5MWPs4XsB6ueDwGUo=;
 b=c0xhx8xvCK+KjHz/pUlR2EM72piHjzBQ2o2U9zyb4nScDugZPrt/AYhgVMzN3Qa6mrCb6ZilMlWDW7PbX1nLs+wrA5dWKDyOvIyDH5ndAdRR5xDiOYy1fwESsKftvYtSnM54zN8OVvcQO8mHvAWJ/7U3Und7Rht0OKruNrSuc97fU9X5YU9A+jKCbkwC+pBVae/+eaTHrlh/zWX2D1i03jkDFqYc70QouwMayXmJoNeS/Z76I/3I+TbIDItfkZWjs27X7GZNEvRCKLJwkuwpz+82tjSnhQekkEro4CE+TxsgwSXy5oXhx8fT9mSkpp5Qz1kPSEWOnxusOYggHgb+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI0Z6sayOxi+UdORawHeja8IBm5MWPs4XsB6ueDwGUo=;
 b=gSxCKIRXZ1XwrYGkJHjiv+2tmbn4qpWIDtVytL4EeaJYNKsCS1MoO6AsJ8lMsH7sy1OlKiQpXUkkcnZwHBYVkwJWo0Xq3b09V2ag871vdBXiMlvuW+Gbi/Wjj+tmx3evzz8VMIb0zsAZged0tVcZujpm4LXay3dgtKKm8IMFl6E=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB4969.jpnprd01.prod.outlook.com (2603:1096:404:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 31 Mar
 2021 04:32:32 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 04:32:32 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v5] mm/gup: check page hwposion status for coredump.
Thread-Topic: [PATCH v5] mm/gup: check page hwposion status for coredump.
Thread-Index: AQHXHw8vRUeoHQvqlEOeQuw9KlA/bqqWVRoAgAADxoCABwonAIAADiYAgAAeboA=
Date:   Wed, 31 Mar 2021 04:32:32 +0000
Message-ID: <20210331043231.GA26013@hori.linux.bs1.fc.nec.co.jp>
References: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
 <20210318133412.12078eb7@alex-virtual-machine>
 <20210319104437.6f30e80d@alex-virtual-machine>
 <20210320003516.GC3420@casper.infradead.org>
 <20210322193318.377c9ce9@alex-virtual-machine>
 <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
 <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
 <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
 <20210331104303.145aea53@alex-virtual-machine>
In-Reply-To: <20210331104303.145aea53@alex-virtual-machine>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kingsoft.com; dkim=none (message not signed)
 header.d=none;kingsoft.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 630a787c-f3b4-4e87-e75d-08d8f3fe0037
x-ms-traffictypediagnostic: TY2PR01MB4969:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB496913114E47A5A770C60F9AE77C9@TY2PR01MB4969.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 17ME9/kJE/W72hX+sM2rai3a2XQkRg5ZananKBT0vBcdmsMYrRMa8vSP/JO3PRKDpKA7txsGaXQWvk2NwnycFNV6ZIRJJCXYCFT7iRe2dkPTeciYOgMaGeg7DWUB/6G5cG+PmsmK5BWwvGxQNP5TOU077y5ZC17eAxfnclsBTL6DffcIsLJ00cuuyRJlyx0USRWvH5pMhMDB+PHgINYFJ10va9zkA9ycqvc7a5sANIu0Qogc0lNpEItXOHCnsE39O5J2oJOS5N0p86Bw0F6Z8BsMAeLsIHGb2aQE+AnKMY6NGlXTJv1Nq72RwdB48RLtCxKt5JlRvICR5xkE7U7HX99nJyCOrl8UytpBsWQVGFGAe37bK0MkZtoHSeMJDZp0NQGZ0G31qBU3LzDBB3gtgW3k5G5BEgvWXZ41EtHf3Zmwn+6U9qZeL0S8frAg23UNyu2cjChwm1RIkOzNiuHADdaOIetqrk7fcct2R5GDVTab7Fo3QXo6AVsh7im1q17XEy/U7aJ9xz6n93d7l/1pxuUvZuWJvxs7/qzfeDPiDu7hc5r5NBmPuhxhHgnjlaexzdwyE3hQGVnLDEAfQvExRP+3E7TX7if0AHUb/THW6Jp1gSzUT1aV5ERpuiDOX731kfO206S55zGH1b5izO1MCGEZzbneZCWwbPq2ClRRRjr2pbSF5t2KzLKA2CMIvrRDFMSk5ZSWHLKlPxLvSDwF2XxTP5Y7SbfBFCPqXMadTPs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(316002)(33656002)(71200400001)(26005)(186003)(6916009)(5660300002)(8936002)(54906003)(38100700001)(8676002)(85182001)(83380400001)(7416002)(4326008)(76116006)(1076003)(6512007)(9686003)(2906002)(66946007)(55236004)(53546011)(6506007)(66446008)(66476007)(64756008)(66556008)(478600001)(6486002)(86362001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bmRMelJ5NFZ2L1IxZExHYkM5Zjc1blByUVlmN3FNN3Z5MGVvb1B5ZGMxRitJ?=
 =?utf-8?B?TVVWQm8zQTFGOTJ1Lzlhb0ptNWlHSzZQZW1WclRqeUM4WmlDVHhjdW1zWlp6?=
 =?utf-8?B?QlhkYlJob2FTSWJUUVlUNC9BK1VmdUc0amxCVXNHMi8wWUE1L0dPRXZjOXJ5?=
 =?utf-8?B?MThhQ0JpSXJqak90NGxPMWdzWlR3eWNjcFlaTDltdlJvRll2c0U3dmxwUGR2?=
 =?utf-8?B?bEtlSDk5ZTljSUxXRTRvYWQ0QjNMbGFCbWJ0NEJkUWVLdzdreE4rRE5haFd6?=
 =?utf-8?B?dHF1cFFrdG1kMHVaZnB2bjcvTzA3c1BxTEFKYVlMS01QVURncHE2U3NscVg5?=
 =?utf-8?B?T2xJRlp5TXJaZEFVLzhsV08xcURsT0ZSMVJiRkp3SDZnTVVaNHc2TUVSdW11?=
 =?utf-8?B?YllZSXVudWU0bCtOd25kTVdNVVdNTGJuYkVVK1h5U05zRTZmUVNJdURGWE4z?=
 =?utf-8?B?RitWQURPcHdwMGFpR1h1M1Z1Vk5MWkUwQWM3czRlNE1MQ0VXZEVVWG00R2lr?=
 =?utf-8?B?WGRHY2NqSGUxQVRTR3NOOTdPZmtIMzVXL2VDYmpPbzlIU0JqamhHeWIzc2pD?=
 =?utf-8?B?eklnZHFIVHZyVHlGVHVTYXppZm9GVVpSNlViMVFWeE1WUEdrc3ZYWmpobzhP?=
 =?utf-8?B?d1UzNVl0OE1ZYldzbnYwQlJkWXJ5TllINERzc1RvQVY3eVRRQy84dFNTb01z?=
 =?utf-8?B?VDZqd3RMdXRxUGQ4OEpjbXZZNENiSXp6b29XR2s0akhmaktQeXdlRGJ5d2Vq?=
 =?utf-8?B?MU43QmhTc0RJTHBZbHZscHNmMDg3TmJmS3Z0WjN0WXFYVU5aVE9lczZLZXpI?=
 =?utf-8?B?Qldaem5rVHdMVStrVzVXRTljcUpZa0Mra25DR2c5ZS9ER3RvR2pyaFRyaHVa?=
 =?utf-8?B?T0s5OGY5QUxVWi92RUphSkpJWGxaM1hNbmhUdUZJQ2N2ZHB5NFAwY2FVaVB4?=
 =?utf-8?B?dWpxQXJQN01scW5MeDVpNzFPQnEvMjE1UHJadFZvY1VpOUpqMXg5U2lneVFM?=
 =?utf-8?B?K1dDRnZaaVpON2JHbDVjZmljUUF1U2VHTm00MnUzUzRpWXRxKy9FTTh3L2k0?=
 =?utf-8?B?RCtUZkxJVERMM0FESzF6aU03SmxmdUNXdnJBOVNVV1F4Nm9wOHVDWTl4VlEy?=
 =?utf-8?B?ODM5L21lQ3Y2d29VZDN6QytISkVaOElwREo0d1BDamV6czBjeHpZbFVHKzFI?=
 =?utf-8?B?OHliOFlvR1RwWW9YR09VeW1Id3hoMSt0d2trSzBJL0lUWThHaXRhZTM5YkpX?=
 =?utf-8?B?YzQ5N2RMNm8yejZNWm5GbDZyU20vQjRDSnlnbmFKaEs3VmpNWmxFS1hsTlhU?=
 =?utf-8?B?dWpwWkhLOVhwSjR3QlV6M0NmSVovWStELzFuT1BRaCtVRXpZQU92ckFQRkNC?=
 =?utf-8?B?QjdiNEtaS1U1MkZGd3daVlZLMWh5NkJIb0M5MDlSYW9jMEZiUXVydXN1YXJp?=
 =?utf-8?B?OUoyOHViajFKaXFJVjFDWW5aY0YrK1lVdkkvd0tmc1pHdUNhVlRZTG1MVU5E?=
 =?utf-8?B?YXpmWWZRaW8vVTRFZW5lZ2pzMVl0YnVwRTR4elZxTXFMWStuTGF1WTVVZncv?=
 =?utf-8?B?L0NqQm90Lzl0RVhIb25vR01vaUNscmNqdEFEOVlPM0FibUJ6K2FCWWcyeDVI?=
 =?utf-8?B?ZGNEMXJlL0ZRY1l2NE53UGI0WUNpVFQvMjZ1VFFrQWJuaGsvZnhZbGVvd0RE?=
 =?utf-8?B?a2JhZFIyOXhBYjRKUk0yUTJuWTBmTFIvczhDTlFYUzNnbTJFa1F3UTNMbGo3?=
 =?utf-8?B?VTZ6NElVQTk3eVBLOEpWMTRvd3d1UVdiRTY2bUVPd3ZqZ3daNGdzcDJQY01P?=
 =?utf-8?B?SUdsclZTd25LVlNmTmxOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6F6DB48A8219844B84A1E5794A00071@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630a787c-f3b4-4e87-e75d-08d8f3fe0037
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 04:32:32.1912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jaa7I1WUkuhBQ5wszY/+xqwXpWsOaFSVSZouqhQZc4l6+2zqJYMam/gDL9OpN1Rwkw9e+gZFviYXq3NevsOWLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4969
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMzEsIDIwMjEgYXQgMTA6NDM6MzZBTSArMDgwMCwgQWlsaSBZYW8gd3JvdGU6
DQo+IE9uIFdlZCwgMzEgTWFyIDIwMjEgMDE6NTI6NTkgKzAwMDAgSE9SSUdVQ0hJIE5BT1lBKOWg
gOWPo+OAgOebtOS5nykgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPiB3cm90ZToNCj4gPiBPbiBG
cmksIE1hciAyNiwgMjAyMSBhdCAwMzoyMjo0OVBNICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3
cm90ZToNCj4gPiA+IE9uIDI2LjAzLjIxIDE1OjA5LCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZTog
IA0KPiA+ID4gPiBPbiAyMi4wMy4yMSAxMjozMywgQWlsaSBZYW8gd3JvdGU6ICANCj4gPiA+ID4g
PiBXaGVuIHdlIGRvIGNvcmVkdW1wIGZvciB1c2VyIHByb2Nlc3Mgc2lnbmFsLCB0aGlzIG1heSBi
ZSBvbmUgU0lHQlVTIHNpZ25hbA0KPiA+ID4gPiA+IHdpdGggQlVTX01DRUVSUl9BUiBvciBCVVNf
TUNFRVJSX0FPIGNvZGUsIHdoaWNoIG1lYW5zIHRoaXMgc2lnbmFsIGlzDQo+ID4gPiA+ID4gcmVz
dWx0ZWQgZnJvbSBFQ0MgbWVtb3J5IGZhaWwgbGlrZSBTUkFSIG9yIFNSQU8sIHdlIGV4cGVjdCB0
aGUgbWVtb3J5DQo+ID4gPiA+ID4gcmVjb3Zlcnkgd29yayBpcyBmaW5pc2hlZCBjb3JyZWN0bHks
IHRoZW4gdGhlIGdldF9kdW1wX3BhZ2UoKSB3aWxsIG5vdA0KPiA+ID4gPiA+IHJldHVybiB0aGUg
ZXJyb3IgcGFnZSBhcyBpdHMgcHJvY2VzcyBwdGUgaXMgc2V0IGludmFsaWQgYnkNCj4gPiA+ID4g
PiBtZW1vcnlfZmFpbHVyZSgpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJ1dCBtZW1vcnlfZmFp
bHVyZSgpIG1heSBmYWlsLCBhbmQgdGhlIHByb2Nlc3MncyByZWxhdGVkIHB0ZSBtYXkgbm90IGJl
DQo+ID4gPiA+ID4gY29ycmVjdGx5IHNldCBpbnZhbGlkLCBmb3IgY3VycmVudCBjb2RlLCB3ZSB3
aWxsIHJldHVybiB0aGUgcG9pc29uIHBhZ2UsDQo+ID4gPiA+ID4gZ2V0IGl0IGR1bXBlZCwgYW5k
IHRoZW4gbGVhZCB0byBzeXN0ZW0gcGFuaWMgYXMgaXRzIGluIGtlcm5lbCBjb2RlLg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IFNvIGNoZWNrIHRoZSBod3BvaXNvbiBzdGF0dXMgaW4gZ2V0X2R1bXBf
cGFnZSgpLCBhbmQgaWYgVFJVRSwgcmV0dXJuIE5VTEwuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
VGhlcmUgbWF5YmUgb3RoZXIgc2NlbmFyaW8gdGhhdCBpcyBhbHNvIGJldHRlciB0byBjaGVjayBo
d3Bvc2lvbiBzdGF0dXMNCj4gPiA+ID4gPiBhbmQgbm90IHRvIHBhbmljLCBzbyBtYWtlIGEgd3Jh
cHBlciBmb3IgdGhpcyBjaGVjaywgVGhhbmtzIHRvIERhdmlkJ3MNCj4gPiA+ID4gPiBzdWdnZXN0
aW9uKDxkYXZpZEByZWRoYXQuY29tPikuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTGluazogaHR0
cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDIxMDMxOTEwNDQzNy42ZjMwZTgwZEBhbGV4LXZpcnR1
YWwtbWFjaGluZQ0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFpbGkgWWFvIDx5YW9haWxpQGtp
bmdzb2Z0LmNvbT4NCj4gPiA+ID4gPiBDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhh
dC5jb20+DQo+ID4gPiA+ID4gQ2M6IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3Jn
Pg0KPiA+ID4gPiA+IENjOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29t
Pg0KPiA+ID4gPiA+IENjOiBPc2NhciBTYWx2YWRvciA8b3NhbHZhZG9yQHN1c2UuZGU+DQo+ID4g
PiA+ID4gQ2M6IE1pa2UgS3JhdmV0eiA8bWlrZS5rcmF2ZXR6QG9yYWNsZS5jb20+DQo+ID4gPiA+
ID4gQ2M6IEFpbGkgWWFvIDx5YW9haWxpQGtpbmdzb2Z0LmNvbT4NCj4gPiA+ID4gPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNb3J0
b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
ICAgbW0vZ3VwLmMgICAgICB8ICA0ICsrKysNCj4gPiA+ID4gPiAgICBtbS9pbnRlcm5hbC5oIHwg
MjAgKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAgICAyIGZpbGVzIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbW0vZ3Vw
LmMgYi9tbS9ndXAuYw0KPiA+ID4gPiA+IGluZGV4IGU0YzIyNGMuLjZmN2UxYWEgMTAwNjQ0DQo+
ID4gPiA+ID4gLS0tIGEvbW0vZ3VwLmMNCj4gPiA+ID4gPiArKysgYi9tbS9ndXAuYw0KPiA+ID4g
PiA+IEBAIC0xNTM2LDYgKzE1MzYsMTAgQEAgc3RydWN0IHBhZ2UgKmdldF9kdW1wX3BhZ2UodW5z
aWduZWQgbG9uZyBhZGRyKQ0KPiA+ID4gPiA+ICAgIAkJCQkgICAgICBGT0xMX0ZPUkNFIHwgRk9M
TF9EVU1QIHwgRk9MTF9HRVQpOw0KPiA+ID4gPiA+ICAgIAlpZiAobG9ja2VkKQ0KPiA+ID4gPiA+
ICAgIAkJbW1hcF9yZWFkX3VubG9jayhtbSk7ICANCj4gPiA+ID4gDQo+ID4gPiA+IFRoaW5raW5n
IGFnYWluLCB3b3VsZG4ndCB3ZSBnZXQgLUVGQVVMVCBmcm9tIF9fZ2V0X3VzZXJfcGFnZXNfbG9j
a2VkKCkNCj4gPiA+ID4gd2hlbiBzdHVtYmxpbmcgb3ZlciBhIGh3cG9pc29uZWQgcGFnZT8NCj4g
PiA+ID4gDQo+ID4gPiA+IFNlZSBfX2dldF91c2VyX3BhZ2VzX2xvY2tlZCgpLT5fX2dldF91c2Vy
X3BhZ2VzKCktPmZhdWx0aW5fcGFnZSgpOg0KPiA+ID4gPiANCj4gPiA+ID4gaGFuZGxlX21tX2Zh
dWx0KCktPnZtX2ZhdWx0X3RvX2Vycm5vKCksIHdoaWNoIHRyYW5zbGF0ZXMNCj4gPiA+ID4gVk1f
RkFVTFRfSFdQT0lTT04gdG8gLUVGQVVMVCwgdW5sZXNzIEZPTExfSFdQT0lTT04gaXMgc2V0ICgt
PiAtRUhXUE9JU09OKQ0KPiA+ID4gPiANCj4gPiA+ID4gPyAgDQo+ID4gDQo+ID4gV2UgY291bGQg
Z2V0IC1FRkFVTFQsIGJ1dCBzb21ldGltZXMgbm90IChkZXBlbmRzIG9uIGhvdyBtZW1vcnlfZmFp
bHVyZSgpIGZhaWxzKS4NCj4gPiANCj4gPiBJZiB3ZSBmYWlsZWQgdG8gdW5tYXAsIHRoZSBwYWdl
IHRhYmxlIGlzIG5vdCBjb252ZXJ0ZWQgdG8gaHdwb2lzb24gZW50cnksDQo+ID4gc28gX19nZXRf
dXNlcl9wYWdlc19sb2NrZWQoKSBnZXQgdGhlIGh3cG9pc29uZWQgcGFnZS4NCj4gPiANCj4gPiBJ
ZiB3ZSBzdWNjZXNzZnVsbHkgdW5tYXBwZWQgYnV0IGZhaWxlZCBpbiB0cnVuY2F0ZV9lcnJvcl9w
YWdlKCkgZm9yIGV4YW1wbGUsDQo+ID4gdGhlIHByb2Nlc3NlcyBtYXBwaW5nIHRoZSBwYWdlIHdv
dWxkIGdldCAtRUZBVUxUIGFzIGV4cGVjdGVkLiAgQnV0IGV2ZW4gaW4NCj4gPiB0aGlzIGNhc2Us
IG90aGVyIHByb2Nlc3NlcyBjb3VsZCByZWFjaCB0aGUgZXJyb3IgcGFnZSB2aWEgcGFnZSBjYWNo
ZSBhbmQNCj4gPiBfX2dldF91c2VyX3BhZ2VzX2xvY2tlZCgpIGZvciB0aGVtIGNvdWxkIHJldHVy
biB0aGUgaHdwb2lzb25lZCBwYWdlLg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBPciBkb2Vzbid0IHRo
YXQgaGFwcGVuIGFzIHlvdSBkZXNjcmliZSAiQnV0IG1lbW9yeV9mYWlsdXJlKCkgbWF5IGZhaWws
IGFuZA0KPiA+ID4gdGhlIHByb2Nlc3MncyByZWxhdGVkIHB0ZSBtYXkgbm90IGJlIGNvcnJlY3Rs
eSBzZXQgaW52YWxpZCIgLS0gYnV0IHdoeSBkb2VzDQo+ID4gPiB0aGF0IGhhcHBlbj8gIA0KPiA+
IA0KPiA+IFNpbXBseSBiZWNhdXNlIG1lbW9yeV9mYWlsdXJlKCkgZG9lc24ndCBoYW5kbGUgc29t
ZSBwYWdlIHR5cGVzIGxpa2Uga3NtIHBhZ2UNCj4gPiBhbmQgemVybyBwYWdlLiBPciBtYXliZSBz
aG1lbSB0aHAgYWxzbyBiZWxvbmdzIHRvIHRoaXMgY2xhc3MuDQo+ID4gDQo+ID4gPiANCj4gPiA+
IE9uIGEgc2ltaWxhciB0aG91Z2h0LCBzaG91bGQgZ2V0X3VzZXJfcGFnZXMoKSBuZXZlciByZXR1
cm4gYSBwYWdlIHRoYXQgaGFzDQo+ID4gPiBIV1BvaXNvbiBzZXQ/IEUuZy4sIGNoZWNrIGFsc28g
Zm9yIGV4aXN0aW5nIFBURXMgaWYgdGhlIHBhZ2UgaXMgaHdwb2lzb25lZD8gIA0KPiA+IA0KPiA+
IE1ha2Ugc2Vuc2UgdG8gbWUuIE1heWJlIGluc2VydGluZyBod3BvaXNvbiBjaGVjayBpbnRvIGZv
bGxvd19wYWdlX3B0ZSgpIGFuZA0KPiA+IGZvbGxvd19odWdlX3BtZCgpIHdvdWxkIHdvcmsgd2Vs
bC4NCj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIHRha2UgbW9yZSBjYXJlIHRvIGJyb2FkY2FzdCB0
aGUgaHdwb2lzb24gY2hlY2sgdG8gb3RoZXIgY2FzZXMsDQo+IFNJR0JVUyBjb3JlZHVtcCBpcyBz
dWNoIGEgY2FzZSB0aGF0IGl0IGlzIHN1cHBvc2VkIHRvIG5vdCB0b3VjaCB0aGUgcG9pc29uIHBh
Z2UsIA0KPiBhbmQgaWYgd2UgcmV0dXJuIE5VTEwgZm9yIHRoaXMsIHRoZSBjb3JlZHVtcCBwcm9j
ZXNzIHdpbGwgZ2V0IGEgc3VjY2Vzc2Z1bCBmaW5pc2guDQo+IA0KPiBPdGhlciBjYXNlcyBtYXkg
YWxzbyBtZWV0IHRoZSByZXF1aXJlbWVudHMgbGlrZSBjb3JlZHVtcCwgYnV0IHdlIG5lZWQgdG8g
aWRlbnRpZnkgaXQsDQo+IHRoYXQncyB0aGUgcG9pc29uIGNoZWNrIHdyYXBwZXIncyBwdXJwb3Nl
LiBJZiBub3QsIHdlIG1heSBicmVhayB0aGUgaW50ZWdyaXR5IG9mIHRoZQ0KPiByZWxhdGVkIGFj
dGlvbiwgd2hpY2ggbWF5IGJlIG5vIGJldHRlciB0aGFuIHBhbmljLg0KDQpJZiB5b3Ugd29ycnkg
YWJvdXQgcmVncmVzc2lvbiBhbmQgd291bGQgbGlrZSB0byBtYWtlIHRoaXMgbmV3IGJlaGF2aW9y
IGNvbmRpdGlvbmFsLA0Kd2UgY291bGQgdXNlIEZPTExfSFdQT0lTT04gdG8gc3BlY2lmeSB0aGF0
IHRoZSBjYWxsZXIgaXMgaHdwb2lzb24tYXdhcmUgc28gdGhhdA0KYW55ICFGT0xMX0hXUE9JU09O
IGNhbGxlciBpZ25vcmVzIHRoZSBod3BvaXNvbiBjaGVjayBhbmQgd29ya3MgYXMgaXQgZG9lcyBu
b3cuDQpUaGlzIGFwcHJvYWNoIGxvb2tzIHRvIG1lIGhlbHBmdWwgYmVjYXVzZSBpdCB3b3VsZCBl
bmNvdXJhZ2UgZGV2ZWxvcGVycyB0b3VjaGluZw0KZ3VwIGNvZGUgdG8gcGF5IGF0dGVudGlvbiB0
byBGT0xMX0hXUE9JU09OIGNvZGUuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
