Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28036670B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhDUIdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:33:52 -0400
Received: from mail-eopbgr1410059.outbound.protection.outlook.com ([40.107.141.59]:55552
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235179AbhDUIdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:33:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+lhG6GbIhG7kzXoeoAf3+0t9LQ1LYRJS9QljvchmGE0kWaVffMHvzAwy51VwlgUHrMr4o2Tp+HifzXHGiM+qBjXpIvoIUL0S+Rfohxl5iFkdSVCgc7exjG1i73fJFgS3Mcnp0D+X13lguoEBJaDHzDhArDzbCjJ7GFnKsv666x78kMKt0TKU5ueYzfCAcID0/YFGd4ksAL1Zmznjo8mBMj/EeiOLdUm/LE+RJQp31svJjkXI55qCCU0vaIVvuOiNCKgvIFE2GPw99BrJSXBx73Q6KFNNwLR+Q7J23fE7e9hgUPLiljLba4GhCYFxZ7/TFgL+qAk16onpwasN0Korg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKI2fONRJnwbrVp/2uzQafmu3U3tscPFy/Owwq2c9+g=;
 b=knM8oMIepWKhqr/N71VgrwE1/5lJmLY/sxfn+kIuq9bDomIvAv0/eFmN3jkXcSyhlfAByBqusgvBNJJfrjPFLMRJKDnTAkIMWG79nIzmIR9Y1XwY5ymDBP7Z8CNpFVsJeNKxuZEBJ4GFdIE9OLPXOpikp5tPYgXwOZs8a/M+gyrN4lr0QjuFOezIgERmStWIkf/RpUGnbhVONjphBbR/tGZmieQ3hb0HRQr0fXUWXQ7FanvV8T+uPl0V8s/A83clIpZSAJyoXgjSMgQSPXbiGobRHprvcuyM18qxWeNsnI9BfAZsYwxE8JHauMm83ga/hgFJroH/dGiKlwU9CbG3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKI2fONRJnwbrVp/2uzQafmu3U3tscPFy/Owwq2c9+g=;
 b=m99TfznJsREANi65Ep9u/YkKCeliYpfmkjj+WsIwuP2YH+0oa1l/Muam7HrNfI4PWDUZ98oxbKYGe4Ab5CzNS8J7+5cchAhQxtdELpt2mT3Ib098VQwlXVC0r8itHtShpbxQdRg3v4wZh10f9J61N1unO7FTr3IUdFfHeSi/mS0=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5596.jpnprd01.prod.outlook.com (2603:1096:404:8054::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 08:33:16 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 08:33:16 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Thread-Topic: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Thread-Index: AQHXNoTZ/dsTmwNUxkyFM7XUqHdaa6q+pOiA
Date:   Wed, 21 Apr 2021 08:33:16 +0000
Message-ID: <20210421083315.GA7552@hori.linux.bs1.fc.nec.co.jp>
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
In-Reply-To: <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09cd7bfb-d26c-4cdf-2b7b-08d904a01c2a
x-ms-traffictypediagnostic: TYAPR01MB5596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB55963AE82FF252FA789A7888E7479@TYAPR01MB5596.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N5lPMB8KrlcQdXlgBw3wclv4MUSIZ1z7h86JLOxvKG3ilTLEBnEmaQAzDctPwFyzhYLqUSCZaGEsnxrbSc3F/nrtWIz7QuWBF7fB7iPN5+NHD628mxPdjerDAVQYxKEphyXo0vaewYclL6RqRm98sGtBwrAfKbf7EvvhVH0hpM9XjTVbEIuzgv98/TpsP4jYelQO+D0p2u5x2aV4HW95DFtF6Wp8oxSvCpihsK+OgH1zN29l6otefzPvjByd7vXgx6pKwpGPUe3hO6XFqEDpFNqeZ1JF5LCrpl6OdEdopvsgpAqB2nq3M/htA6ryU/gnnPFo1dnR3G3jNr14btGuWOGa3RvPSg2K1NPoaTNcUPDJcDOpox34vG8bZYg0TqQEzYOKUC1TseA6lijLeVIYxp1NcPAiFgOWB7TJXQ7knmxOrCLKeMg3f9KnudogVc0q1fRPFO9sVTbbUsdyQXvFwrG4At3A4gHnFM5b/1yI4XgMJYAt7LICmMOqd8SbwVzzsYpr3oqXiuvI6JvvrkAFenN7zxTU9Xk/7dGFYGRfBjXb7aC5bAVZywk5NaqgWPzKpjbYqJ267Zzv+AWg1VSjvYpaAvywFF+jfUVXMIDIeR4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(2906002)(1076003)(38100700002)(26005)(64756008)(6506007)(83380400001)(66946007)(122000001)(76116006)(33656002)(66446008)(6486002)(54906003)(55236004)(478600001)(9686003)(316002)(5660300002)(66476007)(8936002)(8676002)(186003)(86362001)(71200400001)(4326008)(85182001)(6916009)(66556008)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d09xcUpGaWJKZVZrTUhYbS9HaEdnYmlzZy9za090V1VISlEzY3RJVG5GZllo?=
 =?utf-8?B?NWIyV2lIcUd0eGJGUkdKK3JSdUhPSU1Ed1M0Qzh5alFyaWJieXE3M3ZoQm5M?=
 =?utf-8?B?bDhSZDBXTXV0TGNvRnJsRlBmRHluRnViQnZwMlc0NkJlRUE3T0lwcWhPditX?=
 =?utf-8?B?YktGQWxkNDlWemw3SE5Kdi8wcG1xRkJla2RkTFBPb0dpaGNsMVZwNU1PQ3o1?=
 =?utf-8?B?WjROWVZxM1BERXpTR0VoQ0pIY3J5c2lyYWpDMDhMU3cycTRqdC9QK2drYUlW?=
 =?utf-8?B?cU1UVDFIMWtydzFURHlsbWNwMm0rdzgvbkkxdythUWU4MkRNQ0hoVVFlSTlM?=
 =?utf-8?B?aHg4cFpkYlpMWlNGQnJicFM5TFB1Ujh4L2FkZ1NZNDZvVUtGcllvNDVLQk5J?=
 =?utf-8?B?M3R6MUowajNiMEJsZlNPdzFPRWhXV0pqSDRCSElvUVgva0tQcVBYOG1FWWRZ?=
 =?utf-8?B?SmtNMlNlWUlFUEpzeVlwb294NmdUa1I2L3FnNUJVdHRrZVhDd0VyUkEvRXZT?=
 =?utf-8?B?L3A0emZsQmtySjZhTzNhcEZvVDd0WmlqV3dMSzNqQWRsME9hZ0puRVJjU0tv?=
 =?utf-8?B?aG9lWXlpYytwcG1HNUhaK3NvRkJEdjE2ejZUdDNTTVpSV0JpempLNk5JR3BY?=
 =?utf-8?B?SzVqY0RRNElxc05vZkkrcGdlNnNybG5IaDdsbERvaURDMnhBS09vRlo0OGF2?=
 =?utf-8?B?UHJTc0lxL2ROS2daR0xzN1J2ZEZXdjlTMGN4MHM0bERSQTUvWTJiVU0waThm?=
 =?utf-8?B?enltRUs5bWRGQTF5UjBnRUNYY0JHM2ZaMFRaUTFReVF5N0ZUNUlyTmVLR3Ur?=
 =?utf-8?B?dE8vL3U3R1Zwb2Q0Y2dNRmVwVjR4ZFFoRjEyaERaSzJxMFY0d0k0RUZNVk1O?=
 =?utf-8?B?SmZlMmZPVGR0aHRSSUdzd3A5VHZ0SkZaS0YxWXh3Mkp6ZjFiYkVqZ0t3dTVm?=
 =?utf-8?B?dUEzQjQyc21HRHpvaDg3WDVaNmVOdkwzbTBPVCtvZEx4ZDNtN0FNaHJDN3Zj?=
 =?utf-8?B?RTVwcE42NVZtRXJieCtHY2FmcnJ0VjJ2Y0xBYXpJRDRmRDViN0R0QW40L1Ny?=
 =?utf-8?B?N2U3MXRaQUlEcU83Zndnbzg5a0VNdU1GQTNORUR5SUo4QVVReGFDaGR5aVlJ?=
 =?utf-8?B?a1VCYU9vMUdMeTNBanl0Z1hENlBmZEtCOVRLUHh2bWNLaHZZRHJzdTdjS3Zp?=
 =?utf-8?B?TzB6WWIxQ3piMFVncEUxYjZJem8rUnVvdVdqVWdmMHZlQU11RVpjVG5iVk53?=
 =?utf-8?B?aHZlNWxBd2lPTU4zUXZsQ3l3dEg2NUw3RStuYkJrVzEwYktQNVBybEpicVVJ?=
 =?utf-8?B?OFZSeTN6clpEcWhBdk13UllJeWFHTWpGYmFzZDdWaTVDSjB5WlNFN1RxMFlZ?=
 =?utf-8?B?dmU0UkhSQmtOOE41VUZUVjRuOWdxWVZTUThjZGI5MllUc1dCTVVLTFBQYm5p?=
 =?utf-8?B?S1pzZTJNeHFHYnQwYy9FcThrOW1aSWVrWU01aUE4RmdtMXFwSEsxKzIrNERK?=
 =?utf-8?B?elJPR251aHExb2FDZEtNN2Iyb0M5cEM2T3BZaXF1UVB6K3h6M09ZLzRDNUlr?=
 =?utf-8?B?NU5yaElDQnJObmhmMFNNZFcvZFQzQzFtdG02ejZWc1NJeS9CcVFJVzIrSmQy?=
 =?utf-8?B?Skk1ZlVTOHF6Qnh5YWpnWVVrenVtdzBsNU1PYVdJTDNuQllaUlluLzJkWEFH?=
 =?utf-8?B?U0xhQUFLQWhLRUMyVHdIQlhZMU4ySUJ4enZsWGpNbUE1RTBQK0hmczNCZ0xy?=
 =?utf-8?Q?DpOTvtA9D+udlOkxKrBvbcjNmAr+AIQjCdo6RTO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DCCF41F02107D4DB87A33C4AF050078@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cd7bfb-d26c-4cdf-2b7b-08d904a01c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 08:33:16.2540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5JoZzCXEVRUObg/OaDmWv7GySBBBoI4IylIe1LYJrITf/V2lVBAg60M9V/rJLy9svq3XS96yOBxnzCNdJOUSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5596
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMjEsIDIwMjEgYXQgMTA6MDM6MzRBTSArMDIwMCwgTWljaGFsIEhvY2tvIHdy
b3RlOg0KPiBbQ2MgTmFveWFdDQo+IA0KPiBPbiBXZWQgMjEtMDQtMjEgMTQ6MDI6NTksIE11Y2h1
biBTb25nIHdyb3RlOg0KPiA+IFRoZSBwb3NzaWJsZSBiYWQgc2NlbmFyaW86DQo+ID4gDQo+ID4g
Q1BVMDogICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxOg0KPiA+IA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZ2F0aGVyX3N1cnBsdXNfcGFnZXMoKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlID0gYWxsb2Nfc3VycGx1c19odWdlX3Bh
Z2UoKQ0KPiA+IG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKQ0KPiA+ICAgZ2V0X2h3cG9pc29uX3Bh
Z2UocGFnZSkNCj4gPiAgICAgX19nZXRfaHdwb2lzb25fcGFnZShwYWdlKQ0KPiA+ICAgICAgIGdl
dF9wYWdlX3VubGVzc196ZXJvKHBhZ2UpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHplcm8gPSBwdXRfcGFnZV90ZXN0emVybyhwYWdlKQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBWTV9CVUdfT05fUEFHRSghemVybywgcGFnZSkNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5xdWV1ZV9odWdlX3BhZ2UoaCwgcGFnZSkN
Cj4gPiAgIHB1dF9wYWdlKHBhZ2UpDQo+ID4gDQo+ID4gVGhlIHJlZmNvdW50IGNhbiBwb3NzaWJs
eSBiZSBpbmNyZWFzZWQgYnkgbWVtb3J5LWZhaWx1cmUgb3Igc29mdF9vZmZsaW5lDQo+ID4gaGFu
ZGxlcnMsIHdlIGNhbiB0cmlnZ2VyIFZNX0JVR19PTl9QQUdFIGFuZCB3cm9uZ2x5IGFkZCB0aGUg
cGFnZSB0byB0aGUNCj4gPiBodWdldGxiIHBvb2wgbGlzdC4NCj4gDQo+IFRoZSBod3BvaXNvbiBz
aWRlIG9mIHRoaXMgbG9va3MgcmVhbGx5IHN1c3BpY2lvdXMgdG8gbWUuIEl0IHNob3VsZG4ndA0K
PiByZWFsbHkgdG91Y2ggdGhlIHJlZmVyZW5jZSBjb3VudCBvZiBodWdldGxiIHBhZ2VzIHdpdGhv
dXQgYmVpbmcgdmVyeQ0KPiBjYXJlZnVsIChhbmQgaGF2aW5nIGh1Z2V0bGJfbG9jayBoZWxkKS4N
Cg0KSSBoYXZlIHRoZSBzYW1lIGZlZWxpbmcsIHRoZXJlIGlzIGEgd2luZG93IHdoZXJlIGEgaHVn
ZXBhZ2UgaXMgcmVmY291bnRlZA0KZHVyaW5nIGNvbnZlcnRpbmcgZnJvbSBidWRkeSBmcmVlIHBh
Z2VzIGludG8gZnJlZSBodWdlcGFnZSwgc28gcmVmY291bnQNCmFsb25lIGlzIG5vdCBlbm91Z2gg
dG8gcHJldmVudCB0aGUgcmFjZS4gIGh1Z2V0bGJfbG9jayBpcyByZXRha2VuIGFmdGVyDQphbGxv
Y19zdXJwbHVzX2h1Z2VfcGFnZSByZXR1cm5zLCBzbyBzaW1wbHkgaG9sZGluZyBodWdldGxiX2xv
Y2sgaW4NCmdldF9od3BvaXNvbl9wYWdlKCkgc2VlbXMgbm90IHdvcmsuICBJcyB0aGVyZSBhbnkg
c3RhdHVzIGJpdCB0byBzaG93IHRoYXQgYQ0KaHVnZXBhZ2UgaXMganVzdCBiZWluZyBpbml0aWFs
aXplZCAobm90IGluIGZyZWUgaHVnZXBhZ2UgcG9vbCBvciBpbiB1c2UpPw0KDQo+IFdoYXQgd291
bGQgaGFwcGVuIGlmIHRoZQ0KPiByZWZlcmVuY2UgY291bnQgd2FzIGluY3JlYXNlZCBhZnRlciB0
aGUgcGFnZSBoYXMgYmVlbiBlbnF1ZWVkIGludG8gdGhlDQo+IHBvb2w/IFRoaXMgY2FuIGp1c3Qg
YmxvdyB1cCBsYXRlci4NCg0KWWVzLCB0aGlzIGlzIGFub3RoZXIgY29uY2Vybi4NCg0KVGhhbmtz
LA0KTmFveWEgSG9yaWd1Y2hp
