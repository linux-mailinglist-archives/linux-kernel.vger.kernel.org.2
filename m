Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD74185CC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhIZDDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 23:03:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:1814 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhIZDDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 23:03:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="285321780"
X-IronPort-AV: E=Sophos;i="5.85,322,1624345200"; 
   d="scan'208";a="285321780"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2021 20:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,322,1624345200"; 
   d="scan'208";a="519701025"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 25 Sep 2021 20:01:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 25 Sep 2021 20:01:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sat, 25 Sep 2021 20:01:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sat, 25 Sep 2021 20:01:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8S/rwYjxBoifoW2VLkVXS3Xxd4DgvqnwZy0Y9sdf8L55M50qz4pKceNpZchor02easr1wlvKPJlEEku3Eq+PBMXVMF8KK7mZ7hVM0oxZu0mu/kaW+4BsuxC2J+RUseIyksAqdbupBJDsJlAWCJLyboTQiiAk5HnBINgnM/CNO9vYTfmEnxpXw6zkZh1ENKLhIEDYGbwwtYHz0YF/7K7LhsYFtdRwZifOFr70vhiZ0LZox5788Moxh1eGVolNUYclXEFk9Ts7W/utRwQofZ7aRwkjFfQhW6VC/Oby9sXbEzhzXoIWAeb6aXK9IywPu234AVhJeH25Z+uZVhhD4ks2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9WNoB5B4BwcM38r3vHQgCLS6IX9JDsAlPJAHYDatKys=;
 b=nfABUpdJowYqpnLHf137cvyyu6r7+xINDA8O2vaFYgXt5nMd+pvckUrLHaq+uI77+wXGDv5aF93FbM9+qLqj7Jg20GL5KWjQzy91Cvi7FYwVbvaVz8+9UPfz8AR70k4dCkMwYdPAkQ98pHabDHmYnEJ9O2DTfP9L7wV62H+TIxAcqjPBf20I8/Bt3p6XrGW+SFWIIaObWKu0Jbxg21zCJDN5zkdtORCTxpkdqM8PQb4+CPt0Y10u4rlcVbHqYGdVtwAo8ORXEkpQtxMh1zoPi+iYfMAfL82KwOQ2nuu1IHLI5dkkUa8Q9OD5faRW8HZPngdPu2ju953vdrcev7A0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WNoB5B4BwcM38r3vHQgCLS6IX9JDsAlPJAHYDatKys=;
 b=x6j8mrElNtwQzCyNB6yW2jhpzYMpOeRqllJ/C+K1XPcz1clPnGkOeQ1A91CyaSvzlHsaaSINT5nX+cH66gnI5jStMAAlqGKxRfiHt7bdKwMGd4V20cxM5JXfdmmWKTU2W4ldGujFb+lrqXa454bv2xnax5EW1gzi1nTIhUd3ttw=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN8PR11MB3700.namprd11.prod.outlook.com (2603:10b6:408:89::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Sun, 26 Sep
 2021 03:01:37 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Sun, 26 Sep 2021
 03:01:37 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Use second level for GPA->HPA translation
Thread-Topic: [PATCH 1/1] iommu/vt-d: Use second level for GPA->HPA
 translation
Thread-Index: AQHXsOyCAYyPfoq/mkGWmB+Da+Ps0quygFqAgAMeSoCAAANbgA==
Date:   Sun, 26 Sep 2021 03:01:37 +0000
Message-ID: <BN9PR11MB54335B5DCEDD89CD159A3BCD8CA69@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210924022931.780963-1-baolu.lu@linux.intel.com>
 <BN9PR11MB54338F4F946F5E9BD3D4D5388CA49@BN9PR11MB5433.namprd11.prod.outlook.com>
 <047dec82-4530-ab93-d8f1-a21405a1d955@linux.intel.com>
In-Reply-To: <047dec82-4530-ab93-d8f1-a21405a1d955@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8129aeff-3d4a-4445-2e4b-08d98099f4ab
x-ms-traffictypediagnostic: BN8PR11MB3700:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB37006004BE3BBE34AA7FFA078CA69@BN8PR11MB3700.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wnt4tyFPsLk/4PCEE6S8DIyAvMKrf3XCUeW2YYq2XO7RtX5TASAkCCjftBAcLFbjuCeTbTlYq3FIWjWwVBiU+gDmqLs7BjfPVubhacpCQJF6986C7QLW1s5v80dvlVF4l/Dhdxfa9aivjDXSYvat5H1mKmpFGDnMOk04yGCBtpx19YYhTiWg5/LoT3NhBCC0XLfMvGW8OCFdPH0XsfcOsGZLdgt6ke6rWtSqzaceNnxraa8DQW9jp3TtKNlgopFl57qGE6j/vVMOfl32XKtbm9LyKnZqbRroCBlp3sb6AXtHLbUiqMuEeyuA0lGOqJJ2OxjS6CFe/MyNT/emiengSDwlctiPmdu71XrU/0PPhbvmanEqfTdGD8yberduJ+B97Cl97pllqLZnbQ8YsZ4g9LStdnZn0BuDPN+bicRVfD+tF5wmJzM4tOaj8wgjXMK/pfVPX989date+lH6rXceDa2GkxWVr5qajAKoY7MIyKcS2TZgB6sI/tv/EOogYP3524aQqETr9pzKpnJepuENnVlvbiPehILMbihnmWW/DpwjCm3YUU7gK5qdiRjR3KRqzEwdqstWmDasmGFndGJC5zV7BTVAvqrjYxGo+PCmehuiFHnsWk4M8ERvNvsd9tje9g6hbd/WKD8GccV4OykUKsyZL+iSgbTbyDyzCLnhY89jFbAap3KVSoVy3NlgXWrI2nMFluzugODQ3d0v4RGhYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5433.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(122000001)(8676002)(55016002)(38070700005)(110136005)(186003)(83380400001)(6506007)(8936002)(38100700002)(316002)(2906002)(54906003)(9686003)(7696005)(71200400001)(53546011)(4326008)(26005)(76116006)(508600001)(52536014)(33656002)(66476007)(86362001)(66556008)(64756008)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXpTZEEvOUUyS3h6RHNTVFk2eUZNRXA2M2JXbTBabzlBbE1BTUw0UU9pc0ZH?=
 =?utf-8?B?SEpFQWtrL05lRW1WTGV5RGUwRU0vYWhGekxJQUFXL3dkdHlNR3V1cDllOW54?=
 =?utf-8?B?dGNwK1c4TTFjV0Iwc2U5NmNFbHorQXRwSWRhc3g1eVVWOG1ZR214cUpDZlo5?=
 =?utf-8?B?bFhpM1VZUklyU3dXZndtQ3Q0cmxxeFNyZW9DV1pTVHpyTTRzUCtBU1RRR2ht?=
 =?utf-8?B?ZlVBaW9UQXY5b1JmcU5BYlBLK3hyVTZZcWRhRjdqUkdRMlZteGc2cTRZcldS?=
 =?utf-8?B?Wkd3b3RCanEvNGQxN3hGbzU4UTNyc3daeVFTNFlEWGRnZ0FGWnFma2hjOHVi?=
 =?utf-8?B?a010WWNSQ0ptK0hlWGFJM1l5R1RUM1E1aXNzQU5RbHpqQS96em9LdHRYWjFw?=
 =?utf-8?B?NVhKWCszcTU4K3NZcEtpNzNXTERYMDVETmhjalNqNDNzY280RkFFU3ZwNFRv?=
 =?utf-8?B?THNxdVNwL1NtUjh2aUFUUFV6cEhETmNOZE9wQUdhbjFpR3FURlgwVGo2QnBJ?=
 =?utf-8?B?aDRkVGx3MEg2R3pKZk5TYUJkOFNhMW85aDlQcTVIQmNuRmY1ZVJjMWtBN01E?=
 =?utf-8?B?QzhaK0N5bDVXT1JZMEhzSm5oNStnblkzdGJQbS9PTlI4YkNrV3pvRjV0aHRF?=
 =?utf-8?B?aVdEVjVTcWM3Um9mL2RFUEZDZ29BODdud1ZxT1ltZHQ1NHVrc00rbDRwMXBW?=
 =?utf-8?B?ZlpTRnhmaTIwVVR6ampnV0Q0cGRIU205RkpEQlNWSjBHWUR1WFdBbm5EMXdl?=
 =?utf-8?B?MEsycFJXcVh4VC9jRk9UREg4SWlZbEc0MzhjMFVIS0M2VVJQQ1k2dkFpbGJu?=
 =?utf-8?B?RFBxcmdmVWFtM2U3YVdKRldPaWIzeVhpcmc5bTF5VlRXempqVUtGYTZOMzNp?=
 =?utf-8?B?QlBKUCtNTnl1dHN2cTVlcTFVMVkwSW5ub2loeUNtM1R3ZlU5cmlIakJmMnRl?=
 =?utf-8?B?aEh3TkVsZXV0M3V6Yi9pSWk4MjJyNEZQS1dVL2dEdGczS3Z1ditMWlZqYkJv?=
 =?utf-8?B?NGFNVzdMeHQ4RXlZZTR5V1MzREtmVUFmRVZNSTE1NE0xc0dvV2ExbEVlUFNC?=
 =?utf-8?B?aGlEVHpYUzlCQlMwZU9reUkxMUZlUzNpNGh4YTJpamZuczArK0g5d1BwNEFX?=
 =?utf-8?B?WnRSTlQ4TEdLUFBEcW5LOFVNTlZHUUdSTDJnSWdJZ0Z6RVljeXJVTkx2cXJt?=
 =?utf-8?B?bjlRaHAxTzJCVEVsZzE0cjhIL0pWTnE4STlnYnh4ZXJZRFE1UzF2c3VzVldJ?=
 =?utf-8?B?WDhzS3ZJNnIxbnRhSXdzbVl6aHJiRitjRGcvNWFEZ1ozNlh0cFNVQVczeUtk?=
 =?utf-8?B?Y0RjMHZHZEhSMW1QMmd4Y2xFY0F4T1BTSHV1TDlXK0NBckdPQzZVdHNIWk5B?=
 =?utf-8?B?eFBMRnc5aEdDY1J4alNpR3l1b08rMHNuOUhxOWNPZEduN3ZLR29hNTFMR05D?=
 =?utf-8?B?U21VVFRmUnpaTTRBem1EbTRTV0JyRzdNQW9yOXJtaTBlczlOblIyTVF1bzBW?=
 =?utf-8?B?Z1hMQlVvQVB0WXV3RDYxSFJJelB5ZXFyWEtWenlvZ3lPTGxyczlSTlpkK1cr?=
 =?utf-8?B?OUVtOXExaDRvUjl1dzRDZXFQOUJVcGYrOTYzeEFNUHdQNHB3RWRYZnJadEJU?=
 =?utf-8?B?SklxWVBiM1ZmbitYR21OUlhxOXNWeHRHQlplK1RHdm1pNjNaZk4vSFMwS3Jj?=
 =?utf-8?B?OEtlRkJ1clVXRFNoTHZSTEc2SlZFYmRKOHgvT3RycmxtVURjWkxjUGU3ZnE0?=
 =?utf-8?Q?TpC10ZOs6ga/ShKrQW1YuvAMwYT1t8qIyzdN5lJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8129aeff-3d4a-4445-2e4b-08d98099f4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2021 03:01:37.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQErT2PG9muIaP3MIH0yWr0i3yqHFbjnIRmNSzoiJyH0fBFlIHfDJt1K46JyJR39H2BdAgkPaDWgEkLUchQOrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3700
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIFNlcHRlbWJlciAyNiwgMjAyMSAxMDo0MyBBTQ0KPiANCj4gSGkgS2V2aW4sDQo+IA0KPiBU
aGFua3MgZm9yIHJldmlld2luZyBteSBwYXRjaC4NCj4gDQo+IE9uIDkvMjQvMjEgMTE6MTYgQU0s
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyNCwgMjAyMSAxMDozMCBB
TQ0KPiA+Pg0KPiA+PiBUaGUgSU9NTVUgVlQtZCBpbXBsZW1lbnRhdGlvbiB1c2VzIHRoZSBmaXJz
dCBsZXZlbCBmb3IgR1BBLT5IUEENCj4gPj4gdHJhbnNsYXRpb24NCj4gPj4gYnkgZGVmYXVsdC4g
QWx0aG91Z2ggYm90aCB0aGUgZmlyc3QgbGV2ZWwgYW5kIHRoZSBzZWNvbmQgbGV2ZWwgY291bGQg
aGFuZGxlDQo+ID4+IHRoZSBETUEgdHJhbnNsYXRpb24sIHRoZXkgYXJlIGRpZmZlcmVudCBpbiBz
b21lIHdheS4gRm9yIGV4YW1wbGUsIHRoZQ0KPiA+PiBzZWNvbmQNCj4gPj4gbGV2ZWwgdHJhbnNs
YXRpb24gaGFzIHNlcGFyYXRlIGNvbnRyb2xzIGZvciB0aGUgQWNjZXNzL0RpcnR5IHBhZ2UgdHJh
Y2tpbmcNCj4gPj4gYW5kIHRoZSBwYWdlLWxldmVsIGZvcmNpbmcgc25vb3AuIFdpdGggZmlyc3Qg
bGV2ZWwgdHJhbnNsYXRpb24sIHRoZXJlJ3JlDQo+ID4+IG5vIHN1Y2ggY29udHJvbHMuIFRoaXMg
dXNlcyB0aGUgc2Vjb25kIGxldmVsIGZvciBHUEEtPkhQQSB0cmFuc2xhdGlvbiBzbw0KPiA+DQo+
ID4gZmlyc3QtbGV2ZWwgaGFzIG5vIHBhZ2UtZ3JhbnVsYXIgc25vb3AgY29udHJvbCwgYnV0IGhh
cyBhIGdsb2JhbCBjb250cm9sDQo+ID4gaW4gcGFzaWQgZW50cnkuDQo+IA0KPiBBZ3JlZWQuIFdp
bGwgYWRkIHRoaXMuDQo+IA0KPiA+DQo+ID4+IHRoYXQgaXQgY291bGQgcHJvdmlkZSBhIGNvbnNp
c3RlbnQgaGFyZHdhcmUgaW50ZXJmYWNlIGZvciB1c2UgY2FzZXMgbGlrZQ0KPiA+PiBkaXJ0eSBw
YWdlIHRyYWNraW5nIGR1cmluZyB0aGUgVk0gbGl2ZSBtaWdyYXRpb24uDQo+ID4+DQo+ID4+IFNp
Z25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4+IC0t
LQ0KPiA+PiAgIGluY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaCB8ICA3ICsrLS0tLS0NCj4gPj4g
ICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCAyMSArKysrKysrKysrKysrLS0tLS0tLS0N
Cj4gPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygt
KQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oIGIv
aW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oDQo+ID4+IGluZGV4IDA1YTY1ZWIxNTVmNy4uYTVm
YjIwNzAyMjAxIDEwMDY0NA0KPiA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgN
Cj4gPj4gKysrIGIvaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oDQo+ID4+IEBAIC01MTcsMjIg
KzUxNywxOSBAQCBzdHJ1Y3QgY29udGV4dF9lbnRyeSB7DQo+ID4+ICAgCXU2NCBoaTsNCj4gPj4g
ICB9Ow0KPiA+Pg0KPiA+PiAtLyogc2lfZG9tYWluIGNvbnRhaW5zIG11bGl0cGxlIGRldmljZXMg
Ki8NCj4gPj4gLSNkZWZpbmUgRE9NQUlOX0ZMQUdfU1RBVElDX0lERU5USVRZCQlCSVQoMCkNCj4g
Pg0KPiA+IHRoaXMgaXMgYSBzZXBhcmF0ZSBjbGVhbnVwLiBiZXR0ZXIgbWVudGlvbiBpdCBpbiB0
aGUgY29tbWl0IG1zZyBvcg0KPiA+IHB1dCBpbiBhbm90aGVyIHBhdGNoLg0KPiANCj4gU3VyZS4N
Cj4gDQo+ID4NCj4gPj4gLQ0KPiA+PiAgIC8qDQo+ID4+ICAgICogV2hlbiBWVC1kIHdvcmtzIGlu
IHRoZSBzY2FsYWJsZSBtb2RlLCBpdCBhbGxvd3MgRE1BIHRyYW5zbGF0aW9uIHRvDQo+ID4+ICAg
ICogaGFwcGVuIHRocm91Z2ggZWl0aGVyIGZpcnN0IGxldmVsIG9yIHNlY29uZCBsZXZlbCBwYWdl
IHRhYmxlLiBUaGlzDQo+ID4+ICAgICogYml0IG1hcmtzIHRoYXQgdGhlIERNQSB0cmFuc2xhdGlv
biBmb3IgdGhlIGRvbWFpbiBnb2VzIHRocm91Z2ggdGhlDQo+ID4+ICAgICogZmlyc3QgbGV2ZWwg
cGFnZSB0YWJsZSwgb3RoZXJ3aXNlLCBpdCBnb2VzIHRocm91Z2ggdGhlIHNlY29uZCBsZXZlbC4N
Cj4gPj4gICAgKi8NCj4gPj4gLSNkZWZpbmUgRE9NQUlOX0ZMQUdfVVNFX0ZJUlNUX0xFVkVMCQlC
SVQoMSkNCj4gPj4gKyNkZWZpbmUgRE9NQUlOX0ZMQUdfVVNFX0ZJUlNUX0xFVkVMCQlCSVQoMCkN
Cj4gPj4NCj4gPj4gICAvKg0KPiA+PiAgICAqIERvbWFpbiByZXByZXNlbnRzIGEgdmlydHVhbCBt
YWNoaW5lIHdoaWNoIGRlbWFuZHMgaW9tbXUgbmVzdGVkDQo+ID4+ICAgICogdHJhbnNsYXRpb24g
bW9kZSBzdXBwb3J0Lg0KPiA+PiAgICAqLw0KPiA+PiAtI2RlZmluZSBET01BSU5fRkxBR19ORVNU
SU5HX01PREUJCUJJVCgyKQ0KPiA+PiArI2RlZmluZSBET01BSU5fRkxBR19ORVNUSU5HX01PREUJ
CUJJVCgxKQ0KPiA+Pg0KPiA+PiAgIHN0cnVjdCBkbWFyX2RvbWFpbiB7DQo+ID4+ICAgCWludAlu
aWQ7CQkJLyogbm9kZSBpZCAqLw0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4+IGluZGV4IGQ3NWY1
OWFlMjhlNi4uYzgxNGZlYTA1MjJlIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lu
dGVsL2lvbW11LmMNCj4gPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4+
IEBAIC01MjIsNyArNTIyLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGZyZWVfZGV2aW5mb19tZW0o
dm9pZCAqdmFkZHIpDQo+ID4+DQo+ID4+ICAgc3RhdGljIGlubGluZSBpbnQgZG9tYWluX3R5cGVf
aXNfc2koc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4pDQo+ID4+ICAgew0KPiA+PiAtCXJldHVy
biBkb21haW4tPmZsYWdzICYgRE9NQUlOX0ZMQUdfU1RBVElDX0lERU5USVRZOw0KPiA+PiArCXJl
dHVybiBkb21haW4tPmRvbWFpbi50eXBlID09IElPTU1VX0RPTUFJTl9JREVOVElUWTsNCj4gPj4g
ICB9DQo+ID4+DQo+ID4+ICAgc3RhdGljIGlubGluZSBib29sIGRvbWFpbl91c2VfZmlyc3RfbGV2
ZWwoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4pDQo+ID4+IEBAIC0xODc0LDEyICsxODc0LDE4
IEBAIHN0YXRpYyB2b2lkIGZyZWVfZG1hcl9pb21tdShzdHJ1Y3QNCj4gPj4gaW50ZWxfaW9tbXUg
KmlvbW11KQ0KPiA+PiAgICAqIENoZWNrIGFuZCByZXR1cm4gd2hldGhlciBmaXJzdCBsZXZlbCBp
cyB1c2VkIGJ5IGRlZmF1bHQgZm9yDQo+ID4+ICAgICogRE1BIHRyYW5zbGF0aW9uLg0KPiA+PiAg
ICAqLw0KPiA+PiAtc3RhdGljIGJvb2wgZmlyc3RfbGV2ZWxfYnlfZGVmYXVsdCh2b2lkKQ0KPiA+
PiArc3RhdGljIGJvb2wgZmlyc3RfbGV2ZWxfYnlfZGVmYXVsdCh1bnNpZ25lZCBpbnQgdHlwZSkN
Cj4gPj4gICB7DQo+ID4+IC0JcmV0dXJuIHNjYWxhYmxlX21vZGVfc3VwcG9ydCgpICYmIGludGVs
X2NhcF9mbHRzX3Nhbml0eSgpOw0KPiA+PiArCWlmICh0eXBlID09IElPTU1VX0RPTUFJTl9VTk1B
TkFHRUQpDQo+ID4+ICsJCXJldHVybiBmYWxzZTsNCj4gPj4gKw0KPiA+DQo+ID4gSSB0aGluayB0
aGUgb3JkZXIgaXMgbm90IGNvcnJlY3QuIHdoYXQgYWJvdXQgMm5kIGxldmVsIGlzIGV2ZW4gbm90
DQo+ID4gcHJlc2VudD8NCj4gDQo+IEZhaXIgZW5vdWdoLiBIb3cgYWJvdXQNCj4gDQo+ICMxKSBo
YXJkd2FyZSBvbmx5IGNhcGFibGUgb2YgZmlyc3QgbGV2ZWwsIHJldHVybiB0cnVlDQo+ICMyKSBo
YXJkd2FyZSBvbmx5IGNhcGFibGUgb2Ygc2Vjb25kIGxldmVsLCByZXR1cm4gZmFsc2UNCj4gDQo+
ICh3ZSBmYWlsIGlvbW11IGluaXRpYWxpemF0aW9uIGlmIG5laXRoZXIgRkwgbm9yIFNMKQ0KPiBU
aGVuLCBib3RoIEZMIGFuZCBTTCBhcmUgc3VwcG9ydGVkLg0KPiANCj4gIzMpIGRvbWFpbiBpcyB0
eXBlIG9mIFVOTUFOQUdFRCwgcmV0dXJuIGZhbHNlDQo+ICM0KSBvdGhlcndpc2UsIHJldHVybiB0
cnVlLg0KPiANCj4gRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/DQoNCnNvdW5kcyBnb29kLg0KDQo+IA0K
PiA+DQo+ID4NCj4gPj4gKwlpZiAoIXNjYWxhYmxlX21vZGVfc3VwcG9ydCgpIHx8ICFpbnRlbF9j
YXBfZmx0c19zYW5pdHkoKSkNCj4gPj4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+PiArDQo+ID4+ICsJ
cmV0dXJuIHRydWU7DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+PiAtc3RhdGljIHN0cnVjdCBkbWFyX2Rv
bWFpbiAqYWxsb2NfZG9tYWluKGludCBmbGFncykNCj4gPj4gK3N0YXRpYyBzdHJ1Y3QgZG1hcl9k
b21haW4gKmFsbG9jX2RvbWFpbih1bnNpZ25lZCBpbnQgdHlwZSkNCj4gPj4gICB7DQo+ID4+ICAg
CXN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluOw0KPiA+Pg0KPiA+PiBAQCAtMTg4OSw4ICsxODk1
LDcgQEAgc3RhdGljIHN0cnVjdCBkbWFyX2RvbWFpbiAqYWxsb2NfZG9tYWluKGludA0KPiBmbGFn
cykNCj4gPj4NCj4gPj4gICAJbWVtc2V0KGRvbWFpbiwgMCwgc2l6ZW9mKCpkb21haW4pKTsNCj4g
Pj4gICAJZG9tYWluLT5uaWQgPSBOVU1BX05PX05PREU7DQo+ID4+IC0JZG9tYWluLT5mbGFncyA9
IGZsYWdzOw0KPiA+PiAtCWlmIChmaXJzdF9sZXZlbF9ieV9kZWZhdWx0KCkpDQo+ID4+ICsJaWYg
KGZpcnN0X2xldmVsX2J5X2RlZmF1bHQodHlwZSkpDQo+ID4+ICAgCQlkb21haW4tPmZsYWdzIHw9
IERPTUFJTl9GTEFHX1VTRV9GSVJTVF9MRVZFTDsNCj4gPj4gICAJZG9tYWluLT5oYXNfaW90bGJf
ZGV2aWNlID0gZmFsc2U7DQo+ID4+ICAgCUlOSVRfTElTVF9IRUFEKCZkb21haW4tPmRldmljZXMp
Ow0KPiA+PiBAQCAtMjcwOCw3ICsyNzEzLDcgQEAgc3RhdGljIGludCBfX2luaXQgc2lfZG9tYWlu
X2luaXQoaW50IGh3KQ0KPiA+PiAgIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4+ICAgCWludCBp
LCBuaWQsIHJldDsNCj4gPj4NCj4gPj4gLQlzaV9kb21haW4gPSBhbGxvY19kb21haW4oRE9NQUlO
X0ZMQUdfU1RBVElDX0lERU5USVRZKTsNCj4gPj4gKwlzaV9kb21haW4gPSBhbGxvY19kb21haW4o
SU9NTVVfRE9NQUlOX0lERU5USVRZKTsNCj4gPj4gICAJaWYgKCFzaV9kb21haW4pDQo+ID4+ICAg
CQlyZXR1cm4gLUVGQVVMVDsNCj4gPj4NCj4gPj4gQEAgLTQ1MTcsNyArNDUyMiw3IEBAIHN0YXRp
YyBzdHJ1Y3QgaW9tbXVfZG9tYWluDQo+ID4+ICppbnRlbF9pb21tdV9kb21haW5fYWxsb2ModW5z
aWduZWQgdHlwZSkNCj4gPj4gICAJY2FzZSBJT01NVV9ET01BSU5fRE1BOg0KPiA+PiAgIAljYXNl
IElPTU1VX0RPTUFJTl9ETUFfRlE6DQo+ID4+ICAgCWNhc2UgSU9NTVVfRE9NQUlOX1VOTUFOQUdF
RDoNCj4gPj4gLQkJZG1hcl9kb21haW4gPSBhbGxvY19kb21haW4oMCk7DQo+ID4+ICsJCWRtYXJf
ZG9tYWluID0gYWxsb2NfZG9tYWluKHR5cGUpOw0KPiA+PiAgIAkJaWYgKCFkbWFyX2RvbWFpbikg
ew0KPiA+PiAgIAkJCXByX2VycigiQ2FuJ3QgYWxsb2NhdGUgZG1hcl9kb21haW5cbiIpOw0KPiA+
PiAgIAkJCXJldHVybiBOVUxMOw0KPiA+PiAtLQ0KPiA+PiAyLjI1LjENCj4gPg0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBiYW9sdQ0K
