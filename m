Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA93F4695
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhHWI1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:27:35 -0400
Received: from mail-eopbgr1400070.outbound.protection.outlook.com ([40.107.140.70]:32736
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235442AbhHWI1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:27:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/H6Z1bE87bAUtagOi4Rg467ktjMAYojwRgSAXLWkFFoLDCMpIZtuvcEoVzjj53Yf4g4tTteNvDuo4PuqAaL/KPN8Yy1gXb5JtClTrwddUGwaZPJwHn++HD1WUw16DS4eDBTh3Q8dJCRlumu9MHRq7a7E49Gk4/vf4wXLOiabjuHIj9UVTFtagHvPan8BSWq5NmmouJNirb3znwnRJh/jWzn8sKUSOxOWr/HFSye/HCd2y7qtMof5+84ar0p7aCqXnNrWpii5+awZE2y7m8SpETOEzrgJ3D1mnXssJ5R9Ejr9W0ymmjtkKNkwbphA3WvX7WSIhhJbEBQuOWqv2zxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJOmFtwnraFT83uxJh1JaUZJJjRxpESWWPdl5e0mw/o=;
 b=PTNq4ovWmwdvkYK3ch8MKn7wV83um1GERMBQnYAxBNiBWmYmHK+ZKGHDIM68EUMWJPayTmumSt0zH/1/SCfnd/sLoCt/M2pryA3e0QTTvGiJtbJaUGupcsuSbm3qhn/HgM3nVzYyGEwz5TkBZ3Yxl/bqSICRnTyXKhPbavRw4+oBzdmiMaMZmFB9DhulHcB7STVNga07ilw9cbShokHyB8cBGwr81FA7WlUHSZYB0CNAwMvU/Oq/GyWqSlOM4QXyYfr2pOSNJ973dAfRkNCqAgF2DtRkbLEhVtZUEGlq2O6WUIxuiEHEMn7RXSKFf9MgE8mEpG9U8xQH/qAZF+qsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJOmFtwnraFT83uxJh1JaUZJJjRxpESWWPdl5e0mw/o=;
 b=RZFkoUhn2g+u6Hlk7Ect5PxEjw78xAGmpHjceBoMB/ooLm0tiTRSjwGxXiauYdGpWoW3sqfraeGw+LvpCQDVYfxdoQQyobbNtIpcRpyo3XsQEBnvtawePBCoaVKBFVZjMgx90NsOmI8IZiYr7I9C/s436znb1VjnLHJm83HSPEY=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB6139.jpnprd01.prod.outlook.com (2603:1096:402:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 08:26:47 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 08:26:47 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "cgoldswo@codeaurora.org" <cgoldswo@codeaurora.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm/memory_hotplug: make HWPoisoned dirty swapcache
 pages unmovable
Thread-Topic: [PATCH 3/3] mm/memory_hotplug: make HWPoisoned dirty swapcache
 pages unmovable
Thread-Index: AQHXlnDvJ78PbWxOk0WV4HcahnTJ/auAxFYA
Date:   Mon, 23 Aug 2021 08:26:47 +0000
Message-ID: <20210823082646.GB1452382@hori.linux.bs1.fc.nec.co.jp>
References: <20210821094246.10149-1-linmiaohe@huawei.com>
 <20210821094246.10149-4-linmiaohe@huawei.com>
In-Reply-To: <20210821094246.10149-4-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc101a99-db0e-43a6-05e1-08d9660fbf78
x-ms-traffictypediagnostic: TYAPR01MB6139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB61394AC62933C9EA935DC545E7C49@TYAPR01MB6139.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZBHAf6rxWfICAsfDKwArhnQW8AfiZqf/SQNtF5wQbzjs1I5Cb2rOP97203Mr5NOamFv4ndIiI0SiUUynHiOfhlc8q3FdUv9CKsJId3PSzYrFj46nW+oLNNCCxJB9Khgcw36z6ez55qbexTLiLIepS46QfL0RU2vch6/JXsqUBxhwlqE7nXje6uAwDGAjq4+7oWoqnTsv56kHNpt4mz1n7325TxrWQd28RUjDKF4AIbkkS+jB/hggph9AZB48H1i0RYUpyjNhLwad+zuE+xBoJylJnHPHB8efAzH6qw292RM0bBIpxwcQD8ERVZxEC5kNoE4jFceCsxvnD7o/cpDbgA9iBD4iM64Mw1OuHRHtFYulRcKotLHWYCJLZFHr/oAxK7v9W5US586P4tITZBxUChia0Z8P0n914MIDZYMyTnPQJosecrrOGQ+i56jY0wSHRwra11RrP9K9vaPwdCoMxf8CQHm4ayTMfXw8TJt7buMaE/5pU5CgcQI0gDI7r6EZR9sFNh92aptTtnQ/JsQFVPO6wggSRL9kPad2GyE8iJYqsSDZcbFhJJyXs7n+frX0ElXEQTfT6A+ypiGm+247oDqOI6pNzhbEs/OOV4JkCTIEiuHAuAcgLNMf2EKHzdUSoG1nAz2YgKvnsbEFiklATCpnL39xI7YCi1VAhda+XaMX08HCCRCl1oymvlgLlIGKsJH9sdJMVLLMhHhSyYqyOwKjKonTVER2Zzd/Z0fkpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66556008)(66446008)(66476007)(38070700005)(54906003)(38100700002)(122000001)(85182001)(66946007)(64756008)(316002)(6506007)(6916009)(1076003)(71200400001)(508600001)(2906002)(55236004)(186003)(33656002)(8676002)(6512007)(9686003)(86362001)(26005)(6486002)(83380400001)(5660300002)(76116006)(8936002)(14143004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3U4SXlLd2pJZmVodG9vUU5CWkE5VnZHVmFvaFd0N1pveXhZY01DQ3ZuQjFE?=
 =?utf-8?B?Wnd5M2dtL3JpRFdMZk14SWU0NFZCVHZ4Nndaa25PdHE2Q1RFbGJKc2t6aW0z?=
 =?utf-8?B?NlRnNHJ3YS8zbUZ5K1phcVp5aVQyWEJiNjAxcHMyTUk3OEFVcjhnQml4NGZr?=
 =?utf-8?B?c09vS2xCYTRvSStTbDFSNkVoVmp6NHY3ZE5MVnVnM2w3TnlyUWpOcnlxNUx3?=
 =?utf-8?B?VkVsRUd2RVI4SVVwMTlpT3VLd0JpT2tsdFlBaUczamI2ZVJBNjQ4Y296QjdY?=
 =?utf-8?B?MW9ZcEFNS1FrUmE0Q0N3akxMNXlEUmdJMkdCUjNtLzJSdll1OHJLaVJ0Wjhx?=
 =?utf-8?B?VUtnc0tPMmY0Zy9CM2JuVVBwNWVVTnNiTTd5WnV5bExjMExhVmZMelpkZnlI?=
 =?utf-8?B?QWhEdGpuZDRUVG05c24rV1I0V1VRbk41Z21RYzNQcDZoWTZsZ1dCTjhjaDNU?=
 =?utf-8?B?cE8yb0pia1FYSjhrZHhwakVZdGprZWVCK1NuMExoNEUrVjR3N3VMQlVCbDM5?=
 =?utf-8?B?ZWFUTnZ2UVY0THJIVU13bUxxelMwdEhuSzl4eS9manV5UDdPSm9VS0FseXlB?=
 =?utf-8?B?NUxDMmhCRndvUll2dnRlbmFTY1FrSS9NdGZLYmtPTzFHK1MrYlNwQ3hoL1NF?=
 =?utf-8?B?NVp1ekZEVnovR09FdFY3RzJpblgzVGlSbGczMGtRZ054ZDVibnd0cnhkZkp2?=
 =?utf-8?B?S3JqNVR0Vzl4UU5aV21Zb3I2T0ErV2cxY3RneWthelR6OTl6NDV4czJHUHFn?=
 =?utf-8?B?bUR5anhzS0pqNmdrV21FN1hRb1l5b1pNKzAraG9DcmEzcGZQbVk5YVNRZDJO?=
 =?utf-8?B?TGkzMnpoRnFRdG9LOXI1RHBzUVIwdXVlMFY0RFFjQ2lodWp3U0w5VGR6TjdM?=
 =?utf-8?B?RkxIVEpaUlBVTTcrcnJGUkJnZGhiZU51UHBkRi9McnNLMnRQUVVhNUcrUGkw?=
 =?utf-8?B?Z0JQczZ1Vk9lTHNFcnVMSGFqMk1CWWRKNzVQOTJVYzZldndBN1c3QkdNanRm?=
 =?utf-8?B?dWIvYVViUmZmRnMwb2cvT2xGRVgrc3VPZENuUUxxcThKc3hhc1BCQWY3OUE2?=
 =?utf-8?B?VS9Oa09WVnU4NFRJQlRTNmhVcTVmOCtuWmRyMG41VE1lNFp4U1JWS2toWjRu?=
 =?utf-8?B?UUh1YzQ1Um12SUdjTmpjVGs3VmRaM1g5R25wdFVqYjQvNEw3b0NUMnN3YXd6?=
 =?utf-8?B?MVZMbldFMUFPN1VOQ01SeGRrd043eTNrMXNxMHUvVXl4UU45NlN0TVlUTWY3?=
 =?utf-8?B?WWpCK2c1Vnlna25NNUxrcitKbi9sMmlTY3M4R2ZvRHk2NTMya0sySU5VRHJ2?=
 =?utf-8?B?OGZWVjJKeVIydW0zNEViaVNtZkhXaE92Z1VZbzVyN05BdXl4MEM1enlZQklq?=
 =?utf-8?B?Nk5nTkdTN1ZGNVc2T3FQWW9Ha1o5L0tXdC9ra21WL1pFTzNsTm1uV01IWWMx?=
 =?utf-8?B?bXJOeDVyWVdsT2p4a2JOQ29tZ05pdm8wSm5XR2tqcTZQZVFkME05dnlSYWVB?=
 =?utf-8?B?QUVFa3hBYjhETXdCWVRqaWlHN3R2VUpxZEVaUTREcTA4S3VhUnZMcGZJOXdW?=
 =?utf-8?B?N3NSbkRiRG9nWG0xMGNsZzgyUUF2STZXdkplSUlmalVJSjFQWVhKUy91b2lH?=
 =?utf-8?B?bWlORVBiT2NFcWZOUXRHdUxXMGhmdVhuZHRiWGtsMk4rSU5VWjJydllIZUFR?=
 =?utf-8?B?emNDUmdocVZyTS8zQ3k2Y0tvdTRSZCs5ZFlKSlA2RGFmYUV6WHY1aThJMk5W?=
 =?utf-8?B?QTZIYjNwVGlTcDZERG83d2U2Y1JxMHNNU1phU3dkVTNCNFk0Q2tiMExhKzky?=
 =?utf-8?B?WXpDK2tXVFFEQVRBbW5Vdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE339913525BDD48AC22F34A20D977FA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc101a99-db0e-43a6-05e1-08d9660fbf78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 08:26:47.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ru0VffUHeDBiPqUcHXA2js8dnXfKAknJyMnK4RlfDqT6S8Y7JZ3g6GzMbtE4Tn9ruml/VxahU2nAPtDscFlzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBBdWcgMjEsIDIwMjEgYXQgMDU6NDI6NDZQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gSFdQb2lzb25lZCBkaXJ0eSBzd2FwY2FjaGUgcGFnZXMgYXJlIGtlcHQgZm9yIGtpbGxp
bmcgb3duZXIgcHJvY2Vzc2VzLg0KPiBXZSBzaG91bGQgbm90IG9mZmxpbmUgdGhlc2UgcGFnZXMg
b3IgZG9fc3dhcF9wYWdlKCkgd291bGQgYWNjZXNzIHRoZQ0KPiBvZmZsaW5lIHBhZ2VzIGFuZCBs
ZWFkIHRvIGJhZCBlbmRpbmcuDQo+IA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXBvcnQuICBJJ20g
bm90IHlldCBzdXJlIG9mIHRoZSB3aG9sZSBwaWN0dXJlIG9mIHRoaXMNCmlzc3VlLiAgZG9fc3dh
cF9wYWdlKCkgaXMgZXhwZWN0ZWQgdG8gcmV0dXJuIHdpdGggZmF1bHQgVk1fRkFVTFRfSFdQT0lT
T04NCndoZW4gY2FsbGVkIHZpYSB0aGUgYWNjZXNzIHRvIHRoZSBlcnJvciBwYWdlLCBzbyBJIHdv
bmRlciB3aHkgdGhpcyBkb2Vzbid0DQp3b3JrIGZvciB5b3VyIHNpdHVhdGlvbi4gIEFuZCB3aGF0
IGlzIHRoZSAiYmFkIGVuZGluZyIgaW4gdGhlIGRlc2NyaXB0aW9uPw0KDQpJIGZlZWwgdGhhdCBh
Ym9ydGluZyBtZW1vcnkgaG90cmVtb3ZlIGR1ZSB0byBhIGh3cG9pc29uZWQgZGlydHkgc3dhcGNh
Y2hlDQptaWdodCBiZSB0b28gaGFyZCwgc28gSSdkIGxpa2UgdG8gZmluZCBhbm90aGVyIHNvbHV0
aW9uIGlmIHdlIGhhdmUuDQojIFlvdSBtYXkgc2VwYXJhdGUgdGhpcyBwYXRjaCBmcm9tIGZvcm1l
ciB0d28gdG8gbWFrZSB0aGVtIG1lcmdlZCB0bw0KIyBtYWlubGluZSBzb29uLg0KDQpUaGFua3Ms
DQpOYW95YSBIb3JpZ3VjaGkNCg0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFv
aGVAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBtbS9tZW1vcnlfaG90cGx1Zy5jIHwgNiArKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9t
bS9tZW1vcnlfaG90cGx1Zy5jIGIvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPiBpbmRleCA5ZmQwYmUz
MmEyODEuLjA0ODhlZWQzMzI3YyAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5X2hvdHBsdWcuYw0K
PiArKysgYi9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+IEBAIC0xNjY0LDYgKzE2NjQsMTIgQEAgc3Rh
dGljIGludCBzY2FuX21vdmFibGVfcGFnZXModW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQg
bG9uZyBlbmQsDQo+ICAJCSAqLw0KPiAgCQlpZiAoUGFnZU9mZmxpbmUocGFnZSkgJiYgcGFnZV9j
b3VudChwYWdlKSkNCj4gIAkJCXJldHVybiAtRUJVU1k7DQo+ICsJCS8qDQo+ICsJCSAqIEhXUG9p
c29uZWQgZGlydHkgc3dhcGNhY2hlIHBhZ2VzIGFyZSBkZWZpbml0ZWx5IHVubW92YWJsZQ0KPiAr
CQkgKiBiZWNhdXNlIHRoZXkgYXJlIGtlcHQgZm9yIGtpbGxpbmcgb3duZXIgcHJvY2Vzc2VzLg0K
PiArCQkgKi8NCj4gKwkJaWYgKFBhZ2VIV1BvaXNvbihwYWdlKSAmJiBQYWdlU3dhcENhY2hlKHBh
Z2UpKQ0KPiArCQkJcmV0dXJuIC1FQlVTWTsNCg==
