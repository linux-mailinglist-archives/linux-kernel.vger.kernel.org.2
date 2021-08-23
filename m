Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD33F4DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhHWPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:51:08 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:14641
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231246AbhHWPvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:51:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoboYsxUKN/B1+qbu0zuBbKSHZO/xHXCYYfJXt2kAGfjgfmzf3Ji4khFp+mquC/hW/VzmeENYlwZyQLTntsEMx+QZLDzt77rztQWrJLym4BWN01Pt4Jgv8LtWCmiLp/3vFS8jf+z8BWPSpJcaCGHsGLBQdSlxCEuJpExizH++bxL2r6JvzrgZHOVDxYu8ONI3XtwIiN5AyoUCCq7NeKvtEIb1SGnoSCW5TMY9DCOfYRMHd+wEdKEvNi3NRLXXI5SfcJGLIoaTNaFdiWe13InzsevPItF3JX588GDireoroy0n1mNV0M4xM4+buGxSnpLGBmzEcp/GMYeah2NCbQbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEWwcS8/bSjO8PUd3JffRbN9GK3JzClvym6tthdFZhE=;
 b=IGFXeKwnNUuRCojeXL6TX6Novsvj+HKTGg9/inOnG1/eUIRdVprxtCrKRz0kgPAHNaxunSh7idv/spm+ZhLvY9x55J21O/NyyzTWIOzBM+B80cUk+WQRDO9kYGuM5OeaVAEr2ptSAIQLmsJya1pxz+MRnTMIePRS1CCs3y8nktkrfqnIqjejsf9nUTzggeqJM5hrgr5/9qxLPxuMsqe3DLX/osRS+88NgWcXk6Y5MQQkX1opqKZ4Jup5kD556gyBkG42+jKDTRaH1uWSzsaCTifEWK+YDJG5qfXJ++PvltjduOXCDs73qSfA+UfMBGysmnGQGeb7iQywCMUYm5BULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEWwcS8/bSjO8PUd3JffRbN9GK3JzClvym6tthdFZhE=;
 b=pJbEvuC6VR/X+XMsevI7IFRu6ulp1HcZlJUio0PnTJ91Fv14rV1qg9NcDhdnZqlwWVVRzx4ATcYVrhW2io3tad4esS8SRqfh80Y8dn2DqHCjANL6yFvZQHQgPcmuo8LXiVKIYO/sdXORONWIcIW0Y5SDs6a6O98oOTG1L0epaxQ=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB5941.namprd05.prod.outlook.com (2603:10b6:a03:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9; Mon, 23 Aug
 2021 15:50:23 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::481a:71e6:ac78:eb05]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::481a:71e6:ac78:eb05%9]) with mapi id 15.20.4457.017; Mon, 23 Aug 2021
 15:50:23 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 20/20] mm/rmap: avoid potential races
Thread-Topic: [RFC 20/20] mm/rmap: avoid potential races
Thread-Index: AQHXl/Wp2CF81BqPgUSvmHuUE1EgiquBPT0A
Date:   Mon, 23 Aug 2021 15:50:22 +0000
Message-ID: <3F1EF02A-6FD4-42BE-BD07-1C5AC97A515B@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-21-namit@vmware.com>
 <87zgt8y4aj.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87zgt8y4aj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b82fcb51-c16f-4533-4a54-08d9664db7b7
x-ms-traffictypediagnostic: BYAPR05MB5941:
x-microsoft-antispam-prvs: <BYAPR05MB59416578654DE6FF14E9DBA4D0C49@BYAPR05MB5941.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLX683K/ENsXjwZT+CoSGL35j7xbiyNFXqBolioziSNyoljtO3EXJ291+/nsN52B6vPXNhRI1I6AjyPhxdcDJ3XAlGFba4LET6tVWQ21QhWCl6FHfZds/N0Gno3WHSbdutbISR6aXTIevUR15hdLTJv2VyjnMGySocjwTv0Yg6pYSqp5myFvmZgD4yhzxZDo300fT99i6eLvuxevBNEhyLdW7omkqlEnhz4PCog5wzq3Js4fVClf2P9AUteaVP0i2sxK0PrNIQRl83UF5kDZO8qKUV1ReKjnUJZxxgV/YHW+Y4L+ahsj8+FjfWmKacEJpCVZwe1JRLfZ56ThLTUcNThpx0xOoHr5wxNOF5Hjf5ock9HDUhGP0Ztl7TCGojMAU0kV1xR9msgDHzzBiCjf/rc54uy0g8fpllh7PnIC4q3IbEjqF0reeDdfcV/DmUe1Fg8ww0OB8g5wVe85KUuVA6T0qAptGskg8b9Vl7TxngWx1eEIvW24nJuHPPAhhl4JUwIE1NmanrHvxAaNmSTb9vem4wfSK3Sl2jkNuMABN/8TUc/pPMfkTDLPOzzwlw/YEnsBt8XLyMKm5/VgCetobLLIulrs8EAHdezi89pdnX+otwUHmCXzUmONRBRAhZS06EXzn4b++PxAWfBaZE2fm8xOFo4a3lVOfiIKbYphvEu24LKPl0vL48phQXUn//vIonKJLAHJuQ33z6VO9HHD6UrtH4dRmbH8U1FduQZ6x3msTsUJf5B+RpzB5jTzFWV/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(8676002)(2616005)(26005)(36756003)(4326008)(86362001)(6506007)(53546011)(54906003)(6916009)(33656002)(7416002)(76116006)(6512007)(6486002)(5660300002)(478600001)(8936002)(2906002)(64756008)(38070700005)(122000001)(38100700002)(316002)(66946007)(66446008)(66556008)(83380400001)(66476007)(71200400001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dENtQkkxVG85Z1RweUJ1dXAzM3RGUHpQdzl4clVuMzdLbUFPMndvMTkxVlY1?=
 =?utf-8?B?M1IzRmsrQ1E2VnE0WFNnRjQwUFhyNEtXdVl1b1FESGZNRGpzSTNjN0V2K0pJ?=
 =?utf-8?B?MmJmWTJLbGFPb2ptVlR1WEpYZFhsbFNRc3RXWlZGNVVmVkVDNVcxMW5HcnRm?=
 =?utf-8?B?b1JMU21LTUlndmlqbnMvdFg2L2kvcVB1T2JZaVBhcFc1MldDVW9NdE4rYmhG?=
 =?utf-8?B?aktzUnRzOG5hakc5cE05L2ZUNU83MEIvZmMxUkJ3aERsYVI5S1NkUHFMN05q?=
 =?utf-8?B?bW9iNStkZHIvMDZWelBCd2xTa3lhTkRzN0FSUk8xdUhmMGtrTWlHWkhKTDdj?=
 =?utf-8?B?dThvR1RCS1pjSWZrTFdCMGkwemxmK1FBRmFkcEc1MjkxQUcyZkhmT1h1MzdK?=
 =?utf-8?B?bXZlUko5TGpEU2xHK1hCNGNlbmVVM3AreWJZWkc1R29rY1RLRUNmSURGYXJt?=
 =?utf-8?B?bDg0S0RhbXl2dnhDSDY2TlNkaUluV1RVR0tkQnZVb1dwZ0F0aDdNa1RMVTd3?=
 =?utf-8?B?K1BtbzJDTXRaekVPUWpnMk15cmtjcE1YTU1ycXIvRytpOTZBWlZ0QmJSaStY?=
 =?utf-8?B?VG05YTBZUHlhUmZHbThqNkVFU08xQ3RKYkR3bU1wc29xZ1daM1IvT1JHNW5G?=
 =?utf-8?B?cDhKbjBNcjdITkxoT0UybEtBaTRLWHFKUFM3d2hxMnJ0KzFJTkVsK1QvdDBo?=
 =?utf-8?B?aFBaT3hLSWFmdnE3V1ppSEw1eTZucHN4L2RSd3pxOTArZ0tWYU9kYzVmM05x?=
 =?utf-8?B?d1ZkWWo1TzVDazVYbEFuSDBqUkprbnRFWDlQRUlRT3I5YzdEOVN0ZE9XVWQ5?=
 =?utf-8?B?YVNYci95WEFqMWVjdmpGMnpyWmlyTzRYK3RzMHJvdmtVOXYwR1VxRVFrcWdv?=
 =?utf-8?B?MmM2TWwyNHdjYlhKaFpnMVVDdXJ4VE9NOXFhNVlTTUUzWjBEMkpxTHdCblJl?=
 =?utf-8?B?MWR2WG45U3d6U0dwdnkraDlEYlNqTWRvSlc5RDU0QjVGSXp3cHZOd2VpSXdS?=
 =?utf-8?B?dERvbzhNWVU2TGJ5MWtzb0xYRFRTQlUwUEk5L1dIN0JuVXlpeCtnWVFCNEw1?=
 =?utf-8?B?TEVXOHd5RTZCOUt5c0pqWFhzbEp5czZRT0o0OEEvNHJ3Z21SQ0ZYMnBqNGJM?=
 =?utf-8?B?NWZ2MEoxbnhoakpKWUFwM0hjakhiL05MdnoyRVE5Z0ptMnR1ejVrb3owcUd1?=
 =?utf-8?B?Qlk2amlLb0liY0NYNWozZVRJRmFnbGNzNXBFMnlrbGVZRlo5dk5ueGc4UGFm?=
 =?utf-8?B?amhoVVorOGZ0U1J2SXJ4cXVJdzJGbE1mQlpYRGZydnhVMDFhVkl6Z2YxZzZQ?=
 =?utf-8?B?UHNkVTY4TzBVYms4YWYwZGpKZ2tqMjhaWGJQVVVSOHBEYTcrQWwxc3pWdjVP?=
 =?utf-8?B?YjFFVW9ER3F3eE1VZHpsVkRTZlJSYU0yY0tQU1VDcXRiNUQ3Wjd2RUZTUThm?=
 =?utf-8?B?SFAyRVNzNFRXKzQ5UitvZjMwZXdLWjhkOG5mdTlHbXRYNXNUMjlFRDhiNWVZ?=
 =?utf-8?B?dUNMSWtPd3pLRkZ3S21iWnR2T2Y4TFkrRjhPQVpPaElxc2FsWHYza3ZRVTFF?=
 =?utf-8?B?ZkY4NG4zWXBadHA4OUlSaWlZZFJJRmhMWUhTWi9peVFWZ0k2Qmo1SzRJRTJq?=
 =?utf-8?B?ekE1K2hCdCthcXAvMjRCR3lnSlpiWlZkV0trbC9UYlgzOGl0MnRJSDZWZFZq?=
 =?utf-8?B?UmEyRHUwbHJPdzNBdlN4dHBRL2Mwa0VJMDBIV01laVpuNTcydlVob2k5S2Y0?=
 =?utf-8?Q?io/nqU65vj+hj1v3p1dSXeHTq4+llv36WwQ2Sz3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D28EAAFBE37854288112E51348E8A23@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82fcb51-c16f-4533-4a54-08d9664db7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 15:50:22.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIRSO++jvJbAjoGV7mUjOazRGcbh5aJJwIVytqluceEmlghVBsNKSF4c6scLFZwRLMukM/14zTA46iuPW6RWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDIzLCAyMDIxLCBhdCAxOjA1IEFNLCBIdWFuZywgWWluZyA8eWluZy5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gSGksIE5hZGF2LA0KPiANCj4gTmFkYXYgQW1pdCA8
bmFkYXYuYW1pdEBnbWFpbC5jb20+IHdyaXRlczoNCj4gDQo+PiBGcm9tOiBOYWRhdiBBbWl0IDxu
YW1pdEB2bXdhcmUuY29tPg0KPj4gDQo+PiBmbHVzaF90bGJfYmF0Y2hlZF9wZW5kaW5nKCkgYXBw
ZWFycyB0byBoYXZlIGEgdGhlb3JldGljYWwgcmFjZToNCj4+IHRsYl9mbHVzaF9iYXRjaGVkIGlz
IGJlaW5nIGNsZWFyZWQgYWZ0ZXIgdGhlIFRMQiBmbHVzaCwgYW5kIGlmIGluDQo+PiBiZXR3ZWVu
IGFub3RoZXIgY29yZSBjYWxscyBzZXRfdGxiX3ViY19mbHVzaF9wZW5kaW5nKCkgYW5kIHNldHMg
dGhlDQo+PiBwZW5kaW5nIFRMQiBmbHVzaCBpbmRpY2F0aW9uLCB0aGlzIGluZGljYXRpb24gbWln
aHQgYmUgbG9zdC4gSG9sZGluZyB0aGUNCj4+IHBhZ2UtdGFibGUgbG9jayB3aGVuIFNQTElUX0xP
Q0sgaXMgc2V0IGNhbm5vdCBlbGltaW5hdGUgdGhpcyByYWNlLg0KPiANCj4gUmVjZW50bHksIHdo
ZW4gSSByZWFkIHRoZSBjb3JyZXNwb25kaW5nIGNvZGUsIEkgZmluZCB0aGUgZXhhY3Qgc2FtZSBy
YWNlDQo+IHRvby4gIERvIHlvdSBzdGlsbCB0aGluayB0aGUgcmFjZSBpcyBwb3NzaWJsZSBhdCBs
ZWFzdCBpbiB0aGVvcnk/ICBJZg0KPiBzbywgd2h5IGhhc24ndCB5b3VyIGZpeCBiZWVuIG1lcmdl
ZD8NCg0KSSB0aGluayB0aGUgcmFjZSBpcyBwb3NzaWJsZS4gSXQgZGlkbuKAmXQgZ2V0IG1lcmdl
ZCwgSUlSQywgZHVlIHRvIHNvbWUNCmFkZHJlc3NhYmxlIGNyaXRpY2lzbSBhbmQgbGFjayBvZiBl
bnRodXNpYXNtIGZyb20gb3RoZXIgcGVvcGxlLCBhbmQNCm15IGxhemluZXNzL2J1c3ktbmVzcy4N
Cg0KPiANCj4+IFRoZSBjdXJyZW50IGJhdGNoZWQgVExCIGludmFsaWRhdGlvbiBzY2hlbWUgdGhl
cmVmb3JlIGRvZXMgbm90IHNlZW0NCj4+IHZpYWJsZSBvciBlYXNpbHkgcmVwYWlyYWJsZS4NCj4g
DQo+IEkgaGF2ZSBzb21lIGlkZWEgdG8gZml4IHRoaXMgd2l0aG91dCB0b28gbXVjaCBjb2RlLiAg
SWYgbmVjZXNzYXJ5LCBJDQo+IHdpbGwgc2VuZCBpdCBvdXQuDQoNCkFyZ3VhYmx5LCBpdCB3b3Vs
ZCBiZSBwcmVmZXJhYmxlIHRvIGhhdmUgYSBzbWFsbCBiYWNrLXBvcnRhYmxlIGZpeCBmb3INCnRo
aXMgaXNzdWUgc3BlY2lmaWNhbGx5LiBKdXN0IHRyeSB0byBlbnN1cmUgdGhhdCB5b3UgZG8gbm90
IGludHJvZHVjZQ0KcGVyZm9ybWFuY2Ugb3ZlcmhlYWRzLiBBbnkgc29sdXRpb24gc2hvdWxkIGJl
IGNsZWFyIGFib3V0IGl0cyBpbXBhY3QNCm9uIGFkZGl0aW9uYWwgVExCIGZsdXNoZXMgb24gdGhl
IHdvcnN0LWNhc2Ugc2NlbmFyaW8gYW5kIHRoZSBudW1iZXINCm9mIGFkZGl0aW9uYWwgYXRvbWlj
IG9wZXJhdGlvbnMgdGhhdCB3b3VsZCBiZSByZXF1aXJlZC4NCg0K
