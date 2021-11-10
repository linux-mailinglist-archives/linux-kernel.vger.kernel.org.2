Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F844BB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhKJGLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:11:01 -0500
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:8160
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229493AbhKJGK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:10:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtzJCQEE7SVhzgJEespx+ausI0YErOdNlrRjnztHNNLn9jPihu3aJzLbhjXWidsD8udYBz7uz8/+nYaD4bsYBWXCdk6vLfRgm9otvhkbAZu5dpWj6wI43a9up3LK3Ot554AJfq4toG8vFKmwQnwzs9bkFBot0jT8aWi1WSlZOIskPJ4ol39tvNvJyLp3CSrnAvSMd2rNFfHejYhtn90/c3q/vohEJyVWsHImtPHE3bDh+hTj3JI7zsxPk4Dj7ORIXxiqtRUomPfoOkyCJg1P1U67qcIcU5dNIomtrCr6bc//tG9uxfl7iMAz0wg3pEL8mW4eFYNF0WLuqD01e+ZsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vra60lpgkjabBDPTNKUk6y5LeTiJoOI25sjHSdLyndE=;
 b=K4fYit4A3HJ3b4saqR5xjH5gq1fuUQ6sWnA6z0fioDyklw0UmzmgijsiFRk5Rm9D03v2+q0Aua2jbFa+PDPYWM6PN9ofjCDS1pw2ebM/8TMyt9p/fiFIGcTCBj3J1+bAIG06naOMD7JlPrOmAnG1mpR8SW44q/aPaKgvZAXhrdP8H56nJO4mM1NuH2dZKUgOkuJAOdSez7U+Khhl/QkCCU3MNSPWGXsf2tqdF2upW02/xyI89WRXGGgMZgiKf8qmK6MYp4+gWpe7MkG0uHdKNNWOMg6BUfcfzzlpl826tiwJpFPULPXO1OuN0G9+BJrJFnnBJnlvhBKlTdCFMXONRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vra60lpgkjabBDPTNKUk6y5LeTiJoOI25sjHSdLyndE=;
 b=rtxgHDXGyqyGxT/MBwqL5/AEVyQy6Y6JbExPM1kdtBYZeL5Yl1Fyf8elO5IqgWYi0jMhlX+U72Qoc2EWSBKmRH+SmyuW3ACWkbQ87rYhiDZiGPEONujJx6egDT67dXVSrLlqTpaUCMq7mFhp4JNAyMdeKlSjaQdVxeG6G5LTJ2beXJcJIQMN0gjHm2bkyk8TZz00hyVzJLTZtvDSZAjvyHH/qFH/NrRHQqqLSPoNd5aYmVNwXHbT6oAvavWuD8gr9Iex9+EFs7jpSQBJgddDvSXwHhOX4MU7/2VH2HbpUrHabNyPSIxmLtkR6UEzfXWrduPdjqujWdoxWxltZF4TgQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1391.namprd12.prod.outlook.com (2603:10b6:300:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 06:08:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 06:08:10 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Thread-Topic: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Thread-Index: AQHX0rOsNO2zXTeeGEOQ46qW29Eogav63AQAgAB0p4CAAPyZAA==
Date:   Wed, 10 Nov 2021 06:08:10 +0000
Message-ID: <e37edd78-a390-25a6-874b-8b69d2b80182@nvidia.com>
References: <20211106020858.18625-1-ematsumiya@suse.de>
 <20211109080634.GA28581@lst.de> <20211109150405.uv2he4quk4dlud6p@cyberdelia>
In-Reply-To: <20211109150405.uv2he4quk4dlud6p@cyberdelia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92dc02ff-1f32-48e8-86b4-08d9a41078f6
x-ms-traffictypediagnostic: MWHPR12MB1391:
x-microsoft-antispam-prvs: <MWHPR12MB139164D061C156FC38EEA3B3A3939@MWHPR12MB1391.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +t9deX4+COWNYi0llz1SuWrAW3AeG/rH9VnBWjhf96BJVeX3PqXwGUe1uasqkPotvYfPIPcneTfSo0+wSOtMuKd0GK5L3CMwqZp9Ue3rqmW84XKHYGNvc76mwG2J4M3JY/1kZcmPZYjuiRTbkiDuS362eEXhgcJ4Uyy8x6fIQEvSfkrWn9LpuXUfEYsRnaCfI9T/9RANuElyjhROrtUdp77mCA8wX11ZW+uJCPBqNyPvCSGAjp8ihJIYUuc9zwVXdQDYbDueezR4jOhJgxHaJ41Fde8M+BZ78sGlSeKSylnMnmVaSV5mnM/9x14m29vodddKeEJCitfmwA3A6NCZBXawBZyZ3aB3+byXdZO4zUOXOXyeADN0bN1hYGX25Toqslust6sp4zhfOcibk2sn8e8L7BqC7y16VV2OlLyi/F5lZsnh15BfUF8kEIjBECInMCSO7APCW2kuljKUam1MebntPNdCA9Yl2hFrki+HNrAgD5NHZPvsAKEOJHvhMIMBopLWqeyhAGozxfzn65down+X1hGFRP6FSSJ8DOlZuNry3Y2iWipy+UPHktW9TkVo0NXvrs6yeJjJbhYIZPu/v4BhAjbyzkCH1QSxJyG5k6VPMbLxi7mPoTO/ys4dKLmCoviCGDtHWW74GfyIMl0uPbyWa5pASnU8wgtO9aJoQUn687rsCZeDEcHhpDppqRrONT8/CuAtKtnPwARvL/5B4fB468Nkz0Snqf730v5MZgGUd5AOkemglJkvABoSadUmVGPUyrMcV1Zn1LdLQ1UY2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(6916009)(8936002)(66446008)(71200400001)(64756008)(6486002)(66476007)(66556008)(508600001)(66946007)(38070700005)(36756003)(54906003)(86362001)(5660300002)(316002)(8676002)(122000001)(76116006)(38100700002)(31696002)(6512007)(6506007)(31686004)(83380400001)(2906002)(186003)(2616005)(4326008)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVNsdzZOWG5XQUgyRWFTcUlnQW9Fc21HNzlIdkV1TEs1QXZQa2dNQis1bWN6?=
 =?utf-8?B?UEkvZ0RPUjVpR3VDdW83WFBrV3MwTW0wVXpaWHBxVkluRmpWK2oxQjk1KzRl?=
 =?utf-8?B?VE9NQXdKbWtIOE9LRUVvWUs2NkZ0ZXg3OG03NEpzZmlGL1JmTG9RWTF3NWN2?=
 =?utf-8?B?L3JBWmZ3ODMwdGk3RllEVHowMDF3YVEyeUJhc21ta0pmRmFabktyd01hNXlx?=
 =?utf-8?B?ZWd3enVmaUcrM2tjeDhyeUdMOUdxQ0xtT09Pdm5uMi9abTZFeUxUYy80REtM?=
 =?utf-8?B?NWJoM3lHaHRDV1dsd3B1dVdxUlJvaTYzZklxOHlBWlN1SFYwdXlzTmNBTTlT?=
 =?utf-8?B?Q3BGZjFCdmNFNEdyZEcwRzZQUXBXNGFiTDJUNEFvV3U4azVYaXFFQnk3b3ZK?=
 =?utf-8?B?MWJMOFFJSWY3RXVhclVIRzMvSEVMVktrSCtqQ1FIWUYyOHQ4bDBjNkx1ZjN0?=
 =?utf-8?B?S3BpV1JiT2pyandoR1AvcEV6RTI4c1FJSlZtZFByMHBPQTd0V29NUndUUWw0?=
 =?utf-8?B?T01OZVJSWXFBVXFyc0dyOHdWb05pek1keDlGUk1WSFdVem05TlFaNmxCYll0?=
 =?utf-8?B?cTdlSDdKeXBYbE44THUvS2xKVVFwZmREdFRTUE02NHRiY2NrZjUrbnV6SFNY?=
 =?utf-8?B?TitjeGlvMStxMEN5cGJHaXFGRXVrZ2VFdWpxMzRJdkcxQ2ZrRFN4dm9vQXdn?=
 =?utf-8?B?RHBHWDY5RFBqaFkzazRoN1BVTnAxbUYwTmU5ZDVMWmtVMFVqOXBzV2QrMmVn?=
 =?utf-8?B?ak1vOHZqcFNKbnJqMm03VldCYUJhSXdPZFNzYWxsWnB2ZmM0bVVub2ZtUWlx?=
 =?utf-8?B?bEdFVE5OS0pMV0hhWkdrUDl4d3QyU1VrRW9aV3ppOWxVaWk5TUk1emYwQmlK?=
 =?utf-8?B?TnVYRkZqQmtkbTlodTVmK2liU3ZpYXE1Z0x1VWJVeWNrZEtJbTkveHhWUWtL?=
 =?utf-8?B?czVaN3hqVDdGSUtya2lIbzJzQkgvcTFPWWcxeE5kRWtXVUFqb0tqY1lyYnZY?=
 =?utf-8?B?RGQ5QmdDNUxxY0dXQTdvbm5FVUFSdHZtSjlMajV0YVV6bW9PVHVTR1lNRHYr?=
 =?utf-8?B?Q1NHZURDRmhTYTJsMjUzak5NNXdJMjJVOTZURlpOeXk4cmZHeDdibDNmeVo1?=
 =?utf-8?B?MlhkK2R1cTNNN0RicllNcW4xZ3V0aGIwY3JhaWFTSnFCRzd6UVcyKzhubWlZ?=
 =?utf-8?B?eCsyWjZvYlhLOEVraCtnYzZlWFBaNStLY0liZ1lxTElXUW9rbEdvODJwSHgz?=
 =?utf-8?B?WWN6QzJFeEMyVHJNK0lrQXRDMmhaZkdaTXRkSzNLMFhQSmpDVXpOZXV3RDRV?=
 =?utf-8?B?WXVQNVZJUWtHU0pRNW1NZnpaL3dnb2R0OE5IRzRYZHMwRFhDOFNsSmEwTTZN?=
 =?utf-8?B?T0VvZnRIV1NIc1ptQ2k4Sy9CVzBmRE05QmJrOXlkVkR3cmJxdSszOVVWQU9z?=
 =?utf-8?B?Y2pwOC9raDQrOTRzUDZ3RUkxS1F5eWZYcGY1MVFTWlY1bFg3ZnRmT2V4QWh0?=
 =?utf-8?B?bWJPczEwZU1QVWhuOUFPTjJnU2NsaHlNVGdYd3VkRUIrdnhuQlMrY1VBL2Nm?=
 =?utf-8?B?bXFVaEpabXFPQkllMmxIME5HV1ArbG11VXVobmJyZklrMURrSnQzak4rUUZk?=
 =?utf-8?B?OHMrZEo5Z2FMNExESzBkOXlSRGszYkM4MnpiazdUc3FHR2x4OTFEbXFnY29P?=
 =?utf-8?B?UFExbWVlTzhPRlVDd2lGaWlRTkJpazZJY3haVHZoYWFTQ1ZnRWNuQnA0QThi?=
 =?utf-8?B?MnRVK0JWYmQzcUx1eElDSWx6cThPT0ZzNU5rN2RQcHF4VVFFZ2EreUxJLzBR?=
 =?utf-8?B?VVlPNFpiUUxXVUU4K1RCUjlFK1hhYWpJS1QyVDM5T1V0Mm9VcXhQL2ZlY0RQ?=
 =?utf-8?B?UmtLSWtYa0YxWm91akJwNGlZMVRYUFhwaENkSmxCN0k3UU4vWW9WU0VLdGNh?=
 =?utf-8?B?MnNhN2tmd2JMQ3RjblRQZm1kR1JLblkyUjNvT0tRZDdnWi9MK2FEWXIxQm8y?=
 =?utf-8?B?Yy9xMEppQ1hNWU1uK21idkNpSFlEWEcwSmNqV2luUWJuQ2RCeWphUDQ1d2h5?=
 =?utf-8?B?aStYNmVoYm81ZmVJdDJvM21SZGNuaHczRHZ3SlhxWWZ0U0VYK0FuWHQvbnZ4?=
 =?utf-8?B?YWowb2dWZzlLemlwVFZlK09SZWx6Vmx3WXNsUlVvMDFwUUF0Ykw3c2QxYk1J?=
 =?utf-8?B?RndUclVrejYrMTl3d21yQVY4QkxUS2xFRGZoS2xqSGhMa0tDWHl1cnh1bEhI?=
 =?utf-8?Q?IYJcYkzwWvZvenmODQJlcy6MY8p703Zw9IxGc1ihnI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC13496949A3A84CA3C1DFBDD700F89C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dc02ff-1f32-48e8-86b4-08d9a41078f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 06:08:10.4610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjvFCxR5q4suXOmu8RojUV0daaf1GicEVnsV6v0QyNWxvnRrMH6drK2340987MFmKPKHluy8KS/oNZc3UMcIfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1391
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW56bywNCg0KT24gMTEvOS8yMDIxIDc6MDQgQU0sIEVuem8gTWF0c3VtaXlhIHdyb3RlOg0KPiBP
biAxMS8wOSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBPbiBGcmksIE5vdiAwNSwgMjAy
MSBhdCAxMTowODo1N1BNIC0wMzAwLCBFbnpvIE1hdHN1bWl5YSB3cm90ZToNCj4+PiArwqDCoMKg
IH0sDQo+Pj4gK8KgwqDCoCB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqAgKiBUaGlzIEtpb3hpYSBkZXZpY2UgdGltZXMgb3V0IGFuZCBhYm9ydHMgSS9PIGR1
cmluZyBhbnkgbG9hZCwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGJ1dCBtb3JlIGVhc2lseSBy
ZXByb2R1Y2libGUgd2l0aCBkaXNjYXJkcyAoZnN0cmltKS4NCj4+PiArwqDCoMKgwqDCoMKgwqDC
oCAqDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBEZXZpY2UgaXMgbGVmdCBpbiBhIHN0YXRlIHRo
YXQgaXMgYWxzbyBub3QgcG9zc2libGUgdG8gDQo+Pj4gdXNlICJudm1lIHNldC1mZWF0dXJlIg0K
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdG8gZGlzYWJsZSBBUFNULCBidXQgYm9vdGluZyB3aXRo
IA0KPj4+IG52bWVfY29yZS5kZWZhdWx0X3BzX21heF9sYXRlbmN5PTAgd29ya3MuDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqAgKi8NCj4+DQo+PiBPdmVybHkgbG9uZyBsaW5lcyBoZXJlLCBidXQgSSBj
YW4gZml4IHRoYXQgdXAuDQo+IA0KPiBNaXNzZWQgdGhhdCwgc29ycnkuIFRoYW5rcy4NCj4gDQo+
PiDCoERvIHlvdSBoYXZlIGEgcHJvZHVjdA0KPj4gbmFtZSBmb3IgdGhpcyBkZXZpY2Ugb3IgaXMg
anVzdCBhIG5hbWVsZXNzIE9FTSBjb250cm9sbGVyPw0KPiANCj4gSSBkaWRuJ3QsIGhhZCB0byBn
b29nbGUuIEkgc2VlIGl0IGxpc3RlZCBvbiBLaW94aWEncyB3ZWJzaXRlIGFzDQo+IENENi1WIFNl
cmllcyAoNi40VCBtb2RlbCksIGJ1dCBzaW5jZSBjdXN0b21lciB3YXMgcnVubmluZyBvbiBhbg0K
PiBETDM4MCBHZW4xMCwgSSBzdXNwZWN0IGl0IGNvdWxkIGFsc28gYmUgSFBFIFBFODAzMCAoUE4g
UDE5ODM3LUIyMSkuDQo+DQoNCllvdSBjYW4gZ2V0IG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgdGhp
cyBjb250cm9sbGVyIHVzaW5nIG52bWUtY2xpDQppZC1jdHJsIGNvbW1hbmQuDQoNCg0KPiANCj4g
Q2hlZXJzLA0KPiANCj4gRW56bw0KPiANCg==
