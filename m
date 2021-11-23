Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2986F459BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhKWFaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:30:10 -0500
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:60161
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229690AbhKWFaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:30:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwmUQW1Y7XqrGtdIJ/D6hDrkCQTtQIo1RzcudHHoK4gWSnVvrcLQon861maBCAdyfmb5/9e3gtHfc3mzwClTPKHqBrghlXEzgT+3doDedj42NVKK5bFxJyoN2yvgdP0u+5BKC78s48GrqE+Qm/36Lv+BmT2HnNDsS4srhpGWhtx0ChL8wmXcaVgH62jH1cdaYkKJ0KSnoceBDi2WzZ4N7830azkOQFPm8OwXFuPoRvlDNjJdwdQD8zrYISG2sM9BHOeHIxjTKsrYTE9OexVhadcQlZiPXnx6f5t2rZjje5lX+pw2Sqqph8U4FrSb0yGXUiuAqgN6/bT5VdOEITLSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSNKhlHTl6IVNsE5R5+TXw+gd+I8V7WyNBEx89B92fI=;
 b=nxN1GuJCYbzKQaYJ/P+tIu8lCs6T6/4tlm403tdoRs/zja2+gtYYtRP+krpR/wkC4TQnDRK6LgGjdRRPXNSSO1fBZ7px84WgSEmbNWspvL1Nz4jH2PKrhUEO2/6bHPsyMh8nOJ7EE0yoqjPKI+D08BR3VBRmb6/9hq1h5MBMvOcEBliO9L6E8CWyFr2/W83OD7KShs1seuq6uoaUAK15OMzL+FgSeU5dPqYgHYpi7LgeJQxP8tHGjnJbpvudoKS2igZvke60DkeRhNCCZ08PRIVAbLogKYXcBdPzvPWaRA2z/w45Xb3wkTpYKTTq5IMLwk+cGA9kw4Urlb30st00cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSNKhlHTl6IVNsE5R5+TXw+gd+I8V7WyNBEx89B92fI=;
 b=UzMiW2+DSZMYMbHqDOskWKKXIWw1tt1/4MMWNADmTnUALc+Hrr5PXmY7iBsodS9cGYBJZJf5dA457sEeiaJojsonequ7GTIOsjdsmASnr/rF63nW1Qgvuej6BpT2kpOGYoe9y+RfqvvqSjTETsZkzVjLrvmC3hgjGOgXNXTRCV8=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2251.eurprd03.prod.outlook.com (2603:10a6:3:24::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Tue, 23 Nov 2021 05:26:56 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 05:26:56 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Topic: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Index: AQHX35CZ2t64bA8wLE2j/heX74SAnqwPaOmAgAAUvoCAAAQ4gIAAUusAgADBigA=
Date:   Tue, 23 Nov 2021 05:26:56 +0000
Message-ID: <9b524543-e868-7b9d-aae7-97c47f41db52@fi.rohmeurope.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com> <20211122175414.GA1588@lapt>
In-Reply-To: <20211122175414.GA1588@lapt>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2dde044-5eb8-47a6-4ebb-08d9ae41dda7
x-ms-traffictypediagnostic: HE1PR0301MB2251:
x-microsoft-antispam-prvs: <HE1PR0301MB2251A005259B23C395FE2968AD609@HE1PR0301MB2251.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9Vr2Ar9KU8/NMmTN2oIwpIviZJydcLpYwMAE3orifTu4QoFsub61m5a7LHG7WSDnhE3rneqd3bwfdtYYkZN+o2wEH2dghdJ8PCwRpSji3h+BTq6Mv8oN18goMyxkBHxMCrj7nK+IcrC95t1f+GF1YqBQTaRB9w8j5/bPFTq7dGQmJ19JovmAChceJC/VX7OXT4OBcaHKANpHc5F06r64eEmFTPpU7R+cJ3HdtXYjHB54FsYZd0/OvIBdXbshMiEwM1CfsRGiaHtUlxAEBUY/yyTfBx1K2iaj7lTTleP7MD7BNek49Z7lrMDllfHPdvVV2l0Em7+nKp1J2HWU8qc1I1qhigxpn+N5txFqjQV/bNUvJCDge3yc5mHNJ2I+uoWFDieHFpsJkTzro0UmpZcC2Zs6cesV/n4tG0t5BKlriLkJ417MDeD3G6p0Qx/yGIAahh2t7PXjX4HNsHhLkLd6kMvxzuDjUnd+rrXZxq5gxj/PjZZAqdXXA+sONaUXfbptqKjhLk9RgJ/dkX0JBLm3stknWbr76XmMuVFb+JNncoTD3zz12/TgL5WbWI5vITGv32r9Jm4n/7tIsISPf9S8lEZ2r6cq4Q7K/mtoY86xzJr1xtjCAeR/onBlja4+PVpeS/FJIYgezYGsQQpklXkpT9iAUPGCrVX7hVC5kr5NfE9S+JuOI/tjVYlNoc5yWx9aMa+aHskMdd+eZxNrWRIQYOBdwxCEJ0Co7Qv41u+YU2CEElloCfw+EjYwv1kEZiAKwvDcxdwvbdcxt0Jq1zGsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(54906003)(76116006)(8936002)(31696002)(2906002)(31686004)(6512007)(66446008)(66946007)(7416002)(38070700005)(66476007)(64756008)(66556008)(6486002)(2616005)(6506007)(4326008)(26005)(38100700002)(5660300002)(71200400001)(122000001)(53546011)(508600001)(8676002)(316002)(86362001)(83380400001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzVYS21xZi9GSTRVTmJpT3l3ZUwwUS9nSzJobGsrZi8wOTBFanZFZUtnS0I1?=
 =?utf-8?B?VkpRTGhuZVJRN0hHNVgwT3ozWTY4cjJuU0NLRVhqN0NlNmMxUVU2RFZqL3Ja?=
 =?utf-8?B?L2tnM28ycWxMK2hSMlp2SktMUEdsVnBwc056c0NTVnhBYWpQOGtybndheGpv?=
 =?utf-8?B?MTFvQlloSXdlYWZYbVRDSE5qVjQ1OHMrTG9MVHFJZ1lKTXJZaTJRMFVPVFJO?=
 =?utf-8?B?N2NYN05DbWx1MUpjcWZtaFRMWXZUS2dtRTFyQ3ZGdEFzdGRqbVZMVm5sYnhY?=
 =?utf-8?B?TGNjUVIwWVhGMEl0alFCQ0NxRXF4d3BVcXl4bkszZjd4cGd2QU1lZkFYa0tX?=
 =?utf-8?B?b25XTXZJTCtNS1VoOTFnZGlEK1A1amZVVDhRZ0sxSEJYcWFiZUpGNEZCQkpq?=
 =?utf-8?B?ajdramxCaTNwSFBIcWJDMGg4ZndvSjNFZlBWcXZYaDg4VW9jVm5vc0d0c3ZR?=
 =?utf-8?B?bkN5eDNPZEgzME5WREJJQm4rTUhwQmd0Q2RVWm5sMyt5V0ZhNG5LeEpFelFa?=
 =?utf-8?B?WlM0VUo0WFRMVHIwbzZYWDBRVVErUDFEVm1JMWFkQkhPL2JUTWhvSU1GL1ha?=
 =?utf-8?B?MlRGN0ZKMzhORmFmU0c2N2E2YU5TNzI4em1DWE5VV2ZlUU9ISDhxcVhldWlm?=
 =?utf-8?B?aHliRjdqSzNnSXpsa1F2K2gzZ1Bxc01id2JCMVpaU2JCSTNaOElPOWtFWkRt?=
 =?utf-8?B?dUIrSHhQazlkZ2cyaUE4OFlkdklleTc5bGhGQU8zajM3TlZEdVluTGdUa1cz?=
 =?utf-8?B?WmV0bFlSYW0xSm0rOG16M1loVG91UDZGc3ZyZHI3WGZVMnFycDZjeXdpNGRF?=
 =?utf-8?B?VlpmVXZ4dkZoZmgyTzhpemFaNmExRlZVSkdSTWdHSURRNHhaakpTWkNUSXJN?=
 =?utf-8?B?TDVWSFRsVUljWTNMMW9XVUx2bDE1OEtTd2h5OXpwQXNZekZKQStTWklHZ0JY?=
 =?utf-8?B?YWN5dGpuczh0bVF6b201SlBYYmk5MVlUYUNJajNzQTd0S2lka1ZEZUtSaENk?=
 =?utf-8?B?U1Btc2Q5TW9nWDhBRTZFSTVBb2d4L0tKMnU0ZTJpSU53Nk56NHFqUTd0WGVG?=
 =?utf-8?B?YnJvTEtRR3FpeEVUQ0Ewek9iQ2N3QVNmRG9mOGVsczg2REMzL0lMUVJVN2o4?=
 =?utf-8?B?bHlSeU9oOFA1OEh3TEhWZUtPVmVwMWNZSW96SmpuRzhjdzFZdG1WVTBjeUdS?=
 =?utf-8?B?MytQVUwrQjdpMEhWZld2S1JDdytjOEN5S2V2ZFBPRG4rV0JVM1ZCNkhsZGtQ?=
 =?utf-8?B?MUd4L2J2eWlWbFFLQWR1V3E1bGdwYVZieVhyVThPWGpvcVlHVkhxb243d0xp?=
 =?utf-8?B?UkNlYUdRUnI0dE1DMjRScXBWanN4L3dsb0ErQVlzSU1QVUU1VzFydFB1ZXJO?=
 =?utf-8?B?YmhCS2JSaUZEdjBvYmVyc2N0TkFnM0l3YmVGalk0d3ZWckFCTGdyT1A1d1dW?=
 =?utf-8?B?cmZyR3Q1c0wzYm1NamNpSmp0clR0NFBuZ21reDIwZGIrR0tCMWhlV3hSZzcy?=
 =?utf-8?B?UVlkbE5JTlVQb1hiZXRsMzRrNWFCeXB2djJrN3kyS0RLMzZrMlI5UW5vMXRm?=
 =?utf-8?B?U2xDaVp5Y3VMdHlZb2RTUllRV1ZJMXlpNVZFcjJ5L1hrR25oMnlGRUY3REps?=
 =?utf-8?B?SWZUNDMwWm15TVFweW0rNFhxRTEzbVF3TFg2RTJLWnVVOXduai81c0lTNk1q?=
 =?utf-8?B?em4zdEVTWksxSXFqdzBOWXZ1cXltTVdoeGt2U3IzR0oyMFQ5MTcwOTEvWUhh?=
 =?utf-8?B?a0JkZjdYNk9ET2g0NXNqeHV4bjFrR1FHN3VrU0hOOTBkOHZldFNSYVAycEpG?=
 =?utf-8?B?YklVc05Kc3ZKOGhkd3h1aDdjN29ueVRpUUxzbVNRVEExZmVCa1NXZzhuc0xx?=
 =?utf-8?B?WlZqdnNzdWQ4T251Z2F1OFQ1TXkzaW9LNFU5WDlyNXJuazY5V2s2OHZSVmlH?=
 =?utf-8?B?TTBhcXNEMVdHdkZpWG05ak44ZXhOblRhR1FVT09JekJ2SUQ1ZDlYdHZjaXB5?=
 =?utf-8?B?UmpnaHc5MWNjZTc0WE40WHEzZElxY2Q5b25hMzNQWmxuVnlncTFiTmF1d25y?=
 =?utf-8?B?TzlxSEZNeCtPWUpKZlI4Z3FLQTFtMHVCYS9yZkxYbStNVXA1RDVGeEpPTzZL?=
 =?utf-8?B?S0RQVWJoUStNc0k4V1ZWcGhaVnV4L2gxSm9LNDRMTW9OMlFLOG91TFcrb1hl?=
 =?utf-8?B?VG9SNEZ2ZktwWStXZzVLSy9xcnVoUFFud0FSN3FURC92YWV1QnVXVUlBWlhB?=
 =?utf-8?B?SkZOdlk2QnkvN1JjQkQ3UUFWaUlGSlFqemp1YWpYbDZScUlOTlRsQzdrL0lp?=
 =?utf-8?Q?Z+mLRNP2jI4WNj+Cxa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07CC13FB0A8B9B4681B35E8EDF01D6FB@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dde044-5eb8-47a6-4ebb-08d9ae41dda7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 05:26:56.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oz+NDvbsDZv+sO5AP8tcUQpn2w+WXWNfeSOusqBSyDdZwEo/w3gdKGIdJbgKOTS+eIsqUJHRko+GnF2JjAsU5fj2+ELdi1w43V1jZj8K6y5yKnMDJIn2KKeEl94a7Qih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2251
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TW9ybmluZyA8cGxlYXNlIGFwcGx5IGxvY2FsIHRpbWV6b25lPiBZdXJ1LCAmIGFsbCwNCg0KT24g
MTEvMjIvMjEgMTk6NTQsIFl1cnkgTm9yb3Ygd3JvdGU6DQo+IE9uIE1vbiwgTm92IDIyLCAyMDIx
IGF0IDAyOjU3OjI3UE0gKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+IE9uIE1vbiwg
Tm92IDIyLCAyMDIxIGF0IDEyOjQyOjIxUE0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6
DQo+Pj4gT24gMTEvMjIvMjEgMTM6MjgsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+Pj4gT24g
TW9uLCBOb3YgMjIsIDIwMjEgYXQgMDE6MDM6MjVQTSArMDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdy
b3RlOg0KPj4+Pj4gVGhlcmUgYXJlIGNhc2VzIHdoZW4gaXQgaXMgdXNlZnVsIHRvIGNoZWNrIGEg
Yml0LW1hc2sgaGFzIG9ubHkgb25lIGJpdA0KPj4+Pj4gc2V0LiBBZGQgYSBnZW5lcmljIGhlbHBl
ciBmb3IgaXQgaW5zdGVhZCBvZiBiYWtpbmcgb3duIG9uZSBmb3IgZWFjaA0KPj4+Pj4gdXNlci4N
Cj4+DQo+Pj4+IFNvLCB5b3UgZGVjaWRlZCB0byByZWludmVudCBoYW1taW5nIHdlaWdodC4uLg0K
Pj4+PiBQbGVhc2UsIGRyb3AgdGhpcyBwYXRjaCBhbmQgdXNlIGNvcnJlc3BvbmRpbmcgaHdlaWdo
dCgpIGNhbGwuDQo+Pg0KPj4+IFRoYW5rcyBBbmR5Lg0KPj4+DQo+Pj4gVGhlcmUgYXJlIGZldyBk
aWZmZXJlbmNlcyB0byBoYW1taW5nIHdlaWdodCBoZXJlLiBXZSBzY2FuIG9ubHkgZ2l2ZW4NCj4+
PiBhbW91bnQgb2YgYml0cyAtIGFuZCB3ZSB3aWxsIGVuZCBzY2FubmluZyBpbW1lZGlhdGVseSB3
aGVuIHdlIGhpdCBzZWNvbmQNCj4+PiBzZXQgYml0LiBPaCwgYW5kIG9idmlvdXNseSB3ZSBvbmx5
IHJldHVybiBpbmZvcm1hdGlvbiB3aGV0aGVyIHRoZXJlIGlzDQo+Pj4gZXhhY3RseSBvbmUgYml0
IHNldC4gU28gbm8sIHRoaXMgaXMgbm90IGhhbW1pbmcgd2VpZ2h0KCkuDQo+Pg0KPj4gV2hhdCBk
byB5b3UgbWVhbiBieSB0aGlzPw0KPj4NCj4+IGh3ZWlnaHQoKSB3aWxsIHJldHVybiB5b3UgdGhl
IG51bWJlciBvZiB0aGUgbm9uLXplcm8gZWxlbWVudHMgaW4gdGhlIHNldC4NCj4+IEluIGFwcGxp
Y2F0aW9uIHRvIGJvb2xlYW4gYmFzZWQgYXJyYXlzIGl0IG1lYW5zIHRoZSBudW1iZXIgb2YgYml0
cyB0aGF0DQo+PiBhcmUgc2V0LiBPYnZpb3VzbHksIHRoZSBjb25kaXRpb24gYGh3ZWlnaHQoKSA9
PSAxYCBpcyB3aGF0IHlvdSBhcmUgbG9va2luZw0KPj4gZm9yLg0KPiANCj4gSGkgQW5keSwNCj4g
DQo+IEkgdGhpbmssIE1hdHRpIG1lYW5zIGVhcmxpZXIgcmV0dXJuIHdoZW4gcGFydCBvZiBiaXRt
YXAgY291bnRzIHNldA0KPiBiaXRzIHRvIGEgZ3JlYXRlciBudWJtZXIsIGFuZCB3ZSBjYW4gc2tp
cCB0aGUgcmVzdC4gUmlnaHQsIE1hdHRpPw0KDQpZZXMuDQoNCj4gQnV0IGluIGdlbmVyYWwsIGl0
IG1pZ2h0IGJlIHVzZWZ1bCBmb3IgbG9uZyBiaXRtYXBzLg0KPiANCj4gVGhlIG1vcmUgY29tcGxl
dGUgd2F5IG9mIGRvaW5nIHRoaXMgd291bGQgYmUgYWRkaW5nIGEgbmV3IHNldCBvZg0KPiBmdW5j
dGlvbnM6IGJpdG1hcF93ZWlnaHRfe2VxLG5lcSxndCxsZX0NCj4gDQo+IEknbSBsb29raW5nIGF0
IGhvdyBiaXRtYXBfd2VpZ2h0IGlzIHVzZWQgaW4gdGhlIGtlcm5lbCBhbmQgc2VlDQo+IHF1aXRl
IGEgbG90IG9mIHBsYWNlcyB3aGVyZSB0aGlzIG9wdGltaXphdGlvbiBtYXkgdGFrZSBwbGFjZS4g
Rm9yDQo+IGV4YW1wbGUgb3R4Ml9yZW1vdmVfZmxvdygpIGluIGRyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2Zsb3dzLmM6DQo+IA0KPiAgICAgICAgICBpZiAo
Yml0bWFwX3dlaWdodCgmZmxvd19jZmctPmRtYWNmbHRfYm1hcCwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZmxvd19jZmctPmRtYWNmbHRfbWF4X2Zsb3dzKSA9PSAxKQ0KPiAgICAgICAg
ICAgICAgICAgIG90eDJfdXBkYXRlX3JlbV9wZm1hYyhwZnZmLCBETUFDX0FERFJfREVMKTsNCj4g
DQo+IG1heSBiZSByZXBsYWNlZCB3aXRoOg0KPiANCj4gICAgICAgICAgaWYgKGJpdG1hcF93ZWln
aHRfZXEoJmZsb3dfY2ZnLT5kbWFjZmx0X2JtYXAsIGZsb3dfY2ZnLT5kbWFjZmx0X21heF9mbG93
cywgMSkNCj4gICAgICAgICAgICAgICAgICBvdHgyX3VwZGF0ZV9yZW1fcGZtYWMocGZ2ZiwgRE1B
Q19BRERSX0RFTCk7DQo+IA0KPiBNb3N0IG9mIHRoYXQgcGxhY2VzIGFyZSBpbiBkcml2ZXJzIGhv
d2V2ZXIsIGFuZCB0aGUgbGVuZ3RoIG9mIGJpdG1hcHMNCj4gdGhlcmUgaXMgdHlwaWNhbGx5IHNt
YWxsLCBzbyB0aGF0IHRoZXJlJ3Mgbm8gY2hhbmNlIHRvIGdldCBhbnkNCj4gbWVhc3VyYWJsZSBw
ZXJmb3JtYW5jZSBpbXByb3ZlbWVudC4NCj4gDQo+IFRoZXJlIGlzIGFsd2F5cyBhIGNoYW5jZSB0
aGF0IHdlIGhhdmUgb3BlbmNvZGVkIGJpdG1hcF93ZWlnaHRfZXEoKQ0KPiBldCBhbGwuIElmIHdl
IGFkZCB0aGVzZSBBUEksIGl0IG1pZ2h0IGhlbHAgcGVvcGxlIHdyaWdodCBiZXR0ZXIgY29kZS4N
Cj4gDQo+IFdoYXQgZG8geW91IHRoaW5rPw0KDQpNeSB1bmVkdWNhdGVkIG9waW5pb24gKGZvciB3
aGF0IGl0IG1hdHRlcnMgOl0pIGlzIHRoZXQgdGhlIGNvc3Qgb2YgDQphZGRpbmcgc3VjaCBmdW5j
dGlvbnMgaXMgbmVnbGlnaWJsZSBzbyBJIGFtIGFsbCBmb3IgYWRkaW5nIHRoZW0gaWYgdGhlcmUg
DQphcmUgZXZlbiBmZXcgdXNlcnMgd2hvIGNhbiBiZW5lZml0IGZyb20gdGhvc2UuDQoNCkJlc3Qg
UmVnYXJkcw0KCS0tTWF0dGkgVmFpdHRpbmVuDQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkg
YXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBk
cml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5r
a2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9m
IGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
