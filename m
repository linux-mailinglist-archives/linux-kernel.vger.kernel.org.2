Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6520E34F94A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhCaGxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:53:47 -0400
Received: from mail-eopbgr1410070.outbound.protection.outlook.com ([40.107.141.70]:6560
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233869AbhCaGxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHjyc4oVmJFEHqiTiNhtf75B5PLxZLy2Ott/Q/8h1vljL1xxuIQu7sgl70/yx05oI4X5G8yVMCuLqE25BHD2F8oEqyE5vDeVomSBSHd6a4ONiHy2CKpkK0WOaCKwkxklCcoFcxZ5/a98GD1lG6R4SWYpqg/M+pa2aREwngxSAKuijqRDxtBfTZRpMqMaYH2TOWAlm8yZx7Dzg9QCyjic4iYR7Nn8Dh4cwoTIC7y0qVSZdkC3krft55SfGI6+hOQrX+SLL3s6YIz66pcrGH0SW0Q72b6bR8YQ2jpi6U32EboCOfc2BuO479GcSSF9MYnhPiy1AR3F9Os/wi7o0mH1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNnoJtggRg63yktDSaX5R1PrideMRGCiby9RxFZ6IxU=;
 b=dxtEZUdy1bhD3oTG5lI3G/KNSD5meTc1jXRNrUZho1Dps9DyjanzJbnknXLjr3rZ52WfxtRnURPkUT5n2XOTl0HN2MEOYbZZ/73BvQWMkqysQc9WQTjnOk86ruUQTbuA/1aRykKVLyU/XcYCMAAN85eOCzRdm2QQlvywhTndK8HynXwHdhj+2hjIo2BX6yHROpNF88l3aAk7dW9R8Fh4XylswXlvjT8uqcziQfp2g/wnfiprsmXaCOENgrNb/9ugHCVI+NLkGcSMlUCrr5gXNbW5/DDCLxRXnU6jY8YAaxpzVyhEJpfG2R0229+4OxehGJ6vP7SB0nxYRgxpxRT5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNnoJtggRg63yktDSaX5R1PrideMRGCiby9RxFZ6IxU=;
 b=F6MGHdN9bq325norRO/0uCnemztpf8jlzKRzr1uIUPnpVZB2E/USsUGE9EwcERW97a2URelBlQ0LxF6yNgVu6a9eMxHG7kcCCwHF2+C96+aTyIunz+fUexOdc+zEUJv8QbGe9F5pWSRongDgRedLaodIdP+UZlOK3vTirLjbTj8=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5628.jpnprd01.prod.outlook.com (2603:1096:404:8059::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 06:53:41 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 06:53:41 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v5] mm/gup: check page hwposion status for coredump.
Thread-Topic: [PATCH v5] mm/gup: check page hwposion status for coredump.
Thread-Index: AQHXHw8vRUeoHQvqlEOeQuw9KlA/bqqWVRoAgAADxoCABwonAIAARyiAgAAM3YA=
Date:   Wed, 31 Mar 2021 06:53:41 +0000
Message-ID: <20210331065341.GA28793@hori.linux.bs1.fc.nec.co.jp>
References: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
 <20210318133412.12078eb7@alex-virtual-machine>
 <20210319104437.6f30e80d@alex-virtual-machine>
 <20210320003516.GC3420@casper.infradead.org>
 <20210322193318.377c9ce9@alex-virtual-machine>
 <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
 <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
 <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
 <20210331060739.GW351017@casper.infradead.org>
In-Reply-To: <20210331060739.GW351017@casper.infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb4727d8-7465-4b0c-be09-08d8f411b85c
x-ms-traffictypediagnostic: TYAPR01MB5628:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5628D934A208C1DEA3F794EEE77C9@TYAPR01MB5628.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZLX75XFGEMjHdAmCqTVkMPn640XxCRGywfoZLgQdi1/U0GUsqC7lcKrbYcMYecawZJAsxqRP2ciz1yqfRf2UDjAbf/iAZuI4UBf2Ib12cGcCJIQMqvtEqPBfrSKm4yy1fPQNH/6bCeQg0WEZd+DLrVrFEESoo6T5nkJsvu3N+wwkfIVoqfvqeZShT8zoVRwKTXaQq/fFaxJmZjP7TIGpLbk8yTkcbRvhm55HouNX1qhEAvpJEJIfRvZqTdPY9rUWSEp9bjMBYwll+nLk1t0zsloM18hmBKJqkl61eJmWOoq4iScPOxLobMtSrkJF0n8kcWUo7fIFIPnv3EXGDO6w3lZiezeSXf2pSKFBg3XpCk8ujPIIWrys34e8TekBAPIFO3v7aIyUQmhoChjKVWDp8Hu+7QKSshb00jOUZWh2k0KR1o06A6cDYIXhf7iHh+Ssp19c+zSIb33b1LtaSF5Q11zWzmQ5v4s0bg33CjG/thJBMWA8Db+wn3n5RnBlZjjBPhBVRi0XV3LRj41thMjvcLeL7HGLeNCXhSrFWOZwLjpdCcm/i0i8LNYKplEe8VAcEYX70uGNXUtfKfKdNoeaZJz/J79xzYMJpZM1tHVw6NFlGwkIFlZkpgJ+0PJiW1CktSRA95WMGW8Cdphe9SxSAL+ZLqEoP9EfmlxFQcOM6g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(7416002)(66476007)(33656002)(66446008)(66946007)(76116006)(186003)(478600001)(6506007)(8676002)(64756008)(55236004)(8936002)(71200400001)(2906002)(54906003)(66556008)(86362001)(316002)(6486002)(85182001)(5660300002)(6916009)(4744005)(4326008)(38100700001)(26005)(83380400001)(1076003)(9686003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OFF3NmM5MjVkODhsb2FabTIzRmVHVUZScTVZekg4Vnp6Skg0blhnU2NuZE1Q?=
 =?utf-8?B?VzFqNElkZWFLd3cyYnBFRVEyNjhmUmUzRWNGb1JueGltaWw5RGdVamFjaHlJ?=
 =?utf-8?B?ZURpbktIMHpPSEhTNkcyLzAreURSTmlZRzl2NkpXNlRHeGdnbXVRczhBMVBD?=
 =?utf-8?B?MDlsbUM0c21aWWpVcmJZMWRqVVVlUFRoZE5tTGRqbEhxV1ZVVkhGVkg2M2ho?=
 =?utf-8?B?QzI0SWZ1V2hmb1NONVV5ZDBRQmlQbXhWdzBVYnNJaVRteEFPTCtrT1F3R1hR?=
 =?utf-8?B?NnBWczdaMmF2ZTlhRnBvNFdndEZWRGZyVEd2ck9HV2ZEbkEveUdJZ094VGVw?=
 =?utf-8?B?TWp3T3NNWXJ5UFJLUjFVZnd3N2thYnFMRnJuL0phVkpjNmtjMXdTUFJXQ2sz?=
 =?utf-8?B?NUc4NHdMN3VTczRvNmQvL0xSV21zS29FQXdSaklHRGg2NlpwcDByc0l0RUp1?=
 =?utf-8?B?bmptY2VScDFpcGNnUWNjaThqdFYxVFRyejBIbU9UcGlyMFE0aDBsUnEwWHlT?=
 =?utf-8?B?aEJ3WUJPQkROalFmK0pZeFJuWGJKc0FqVEsvN3EyclFRdHNnZmNhTFdBSmQ4?=
 =?utf-8?B?NE1lY1ppLzRyVVA3MTU5VURRT09MM1ViYTRvV0syclBEU2dibTZHZjg4b1BN?=
 =?utf-8?B?alk0UVdITllVNm9vZkhKQW9KblE1TlNtY1ZPdjZSRVR3ZHd1ZnBONTRWTGxm?=
 =?utf-8?B?cHlEelB2ZDlLcXhvVVJ1T1dPSllTS28wZlM5UExSVFZWVndGQ3d6citDdERF?=
 =?utf-8?B?elllWlk5L24wUXluZGJvUW5XTU5BR2gybTZEWkhUdzBScUJHQVFuTHUvMy9j?=
 =?utf-8?B?UFNCNlVTTGFsSTQwdmE4b1g2LzVNQ1cya0VITGpEYm05dHdndFZZK0ZCYmxD?=
 =?utf-8?B?TDBWWDM5VzY1RDhvankzVDRkZkU3SEZYYUZIaEhNWFl6cUhXTGVVbys0eTlF?=
 =?utf-8?B?RytKSi9kU2JHeXdzdHAyd3kzYlZVVkRTSTlndlA1SE9vQlNiWE1pbEdhZUZF?=
 =?utf-8?B?b0VWNkhFWnVSbWhVZmZ3M25Wd29TYm1BM2c3TkxXd0tpeGd2VnhHMlVIcHgy?=
 =?utf-8?B?OEVpZk42N0JLMXlyek5HcU9wbEU3SzVocHpoZGhLK3JzL3ZzYXlCYUVtTWJ0?=
 =?utf-8?B?UE1qVDRUeWQ3WDNRRytDNGdYTE9JbjhMeUFoUSt0U3FyM1FFNElTUnZXbjgw?=
 =?utf-8?B?Tm43ak5IeDBIRjFOeEZ2UTFrSjU2SnVDYWJ0YVVhWWxOYWo2SWhYNTNSTmdx?=
 =?utf-8?B?bWVCNVRYMGE0bHBqeXlMWC8zckNQdjM1YlU3ZzAxNU9wUlU1clhWTWNMcXpJ?=
 =?utf-8?B?QU1vQlRYbTE2NGpyZ091YjM5UmFHWkVXR1Z6My84UVFiWEgxK09QK3Vwc2Zx?=
 =?utf-8?B?T2sxbHcydU5IQmpudS9VTkF2UVl2ODFDTmRuZ1dFczlLQ01NWVJaUXpOUHJT?=
 =?utf-8?B?cEhTblRaL1k3SWwrS3cyTUl5VWRsVjEycXVlVU9PZEVpbU51YUxGbGNHanJ1?=
 =?utf-8?B?T1hUVWo4VHFRWThoK2NwcllkK29oL1ozN2lJRVkxRU5xS0MwN09EZis3QVlT?=
 =?utf-8?B?QjRMaVJxa2JjNWFKbzFPcHZkUjF5QVdEbVRGVGkwRkR0VXFCU0hWRWthaHlC?=
 =?utf-8?B?RVZrZTJDSTRwL0dQUkxUK3pZVi9NcE51bDVtanUwMUE2ZHpPUG5Fa1BnQ05j?=
 =?utf-8?B?Y1ZPVjJMeXJEZ0hZR0VYaDZqT3liTW5HWWFTSlF3cjRYVTFHaUFXSWhScUcy?=
 =?utf-8?Q?wB1uwD0Pr7n+iZbi5mgiEwLzBGnlulJQBn48z5g?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00E90AA0444D4845B9835C1AD80FE372@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4727d8-7465-4b0c-be09-08d8f411b85c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 06:53:41.7192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6VSD8LJylk14cnhk4yjiF6foF9YJeNInOgc1sxOj/N5fMA67pWvHUKGNZWzlwT7RLQG0PT68xpRAmY8aAL7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5628
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMzEsIDIwMjEgYXQgMDc6MDc6MzlBTSArMDEwMCwgTWF0dGhldyBXaWxjb3gg
d3JvdGU6DQo+IE9uIFdlZCwgTWFyIDMxLCAyMDIxIGF0IDAxOjUyOjU5QU0gKzAwMDAsIEhPUklH
VUNISSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3cm90ZToNCj4gPiBJZiB3ZSBzdWNjZXNzZnVsbHkg
dW5tYXBwZWQgYnV0IGZhaWxlZCBpbiB0cnVuY2F0ZV9lcnJvcl9wYWdlKCkgZm9yIGV4YW1wbGUs
DQo+ID4gdGhlIHByb2Nlc3NlcyBtYXBwaW5nIHRoZSBwYWdlIHdvdWxkIGdldCAtRUZBVUxUIGFz
IGV4cGVjdGVkLiAgQnV0IGV2ZW4gaW4NCj4gPiB0aGlzIGNhc2UsIG90aGVyIHByb2Nlc3NlcyBj
b3VsZCByZWFjaCB0aGUgZXJyb3IgcGFnZSB2aWEgcGFnZSBjYWNoZSBhbmQNCj4gPiBfX2dldF91
c2VyX3BhZ2VzX2xvY2tlZCgpIGZvciB0aGVtIGNvdWxkIHJldHVybiB0aGUgaHdwb2lzb25lZCBw
YWdlLg0KPiANCj4gSG93IHdvdWxkIHRoYXQgaGFwcGVuPyAgV2UgY2hlY2sgUGFnZUhXUG9pc29u
IGJlZm9yZSBpbnNlcnRpbmcgYSBwYWdlDQo+IGludG8gdGhlIHBhZ2UgdGFibGVzLiAgU2VlLCBl
ZywgZmlsZW1hcF9tYXBfcGFnZXMoKSBhbmQgX19kb19mYXVsdCgpLg0KDQpBaCwgeW91J3JlIHJp
Z2h0LCB0aGF0IG5ldmVyIGhhcHBlbnMuIEkgbWlzcmVhZCB0aGUgY29kZS4NClRoYW5rcyBmb3Ig
Y29ycmVjdGluZyBtZS4=
