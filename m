Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A183392DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhCLQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:15:54 -0500
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:4864
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231601AbhCLQP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:15:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RINdz9qaZAhHn6WZeB1A0JtgcDf2+shr/ir2XSixqqTxbpQLeJ10OeX/SDLT9fAzTUIfEgsHYIZU4VjbwpWQjlnnGo5iU+Vdrt6vbVRDB0d+I14TzJVzgb3MXqcDEv8Twk5dD8cslQC5QWvYL+EefVi/8GYhp1+iVpe2N9P5zhwL3Qpx5qGBd63IEKbuQROz3EbCaHCCZXerC/QMV5YQaAyZnscDitaQmlqrCY7S5xPvZVrHv61qGIWj2pasQTJiN580eqBJB/zEnZ7VV/3IGrGAYfrlmTMp945csGBfHjTdlt0hmNW2BQmHyCsnsB11t/jwHCPabWyIwwX1ikZGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxuNZWt9B/Ay/6WZJ3lFq/pGmlamDaXCIZul24icwZk=;
 b=XrFfRrMr+GjTBBLGW9M3J43v4mXeCZKEYpyoTvBUf6MwG8GKeKbB5KMnHmLz9Car2VvRDrjsZ9bR904qvPVY474sLBipS/TeAqNqZRuCuXNm/VkfOaEcHAnh9FZXYyPz9O7RX4XL3bAeeVarbpbF2sbSX16ImGwG95xccmVLBuCfEpEqe3Y0JQQLt5yHM45AGADhhHI9y46i+rAxvb9pDLNdM6YzYn6+Eqh2JPC3D1E1gHIOXg/G9U1Nax+n5bJfIvl5to9iQeKusgghwJgamJMMT8lR3ClyDXeQ+BTPxZ4VNDOPke+G68vu6S/X8Ej+lXOi0A8SktRhaFszVo8Iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxuNZWt9B/Ay/6WZJ3lFq/pGmlamDaXCIZul24icwZk=;
 b=Hc6jroiXxI44WPrOFScHazkhppuN5BWEI0u39BUSYG0uf7RJ1SL39YQp23WRi1OPo8oEkHaibLtoXzyQ+4wIrYzrOREeaClXfxw73ma/IWZ5tE/3q9BAs2wQelHOcnCxqzUM9URF1PiDJ/jCWqF+5QDCPuGZMo97ZW1jR4mKO8c=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 16:15:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 16:15:25 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liang, Liang (Leo)" <Liang.Liang@amd.com>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
Subject: RE: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Topic: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Index: AdcWgujrowoM8ON/Tmy0Tmhi9senVQABLLQAADBH9CAAADxQgAACUAfQAAEOAgAAANA2IA==
Date:   Fri, 12 Mar 2021 16:15:25 +0000
Message-ID: <MN2PR12MB4488C3956E0B99CD360B0A27F76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
 <2f7c20ea-888f-65b6-6607-c86aab65acce@redhat.com>
 <MN2PR12MB44886034D18F900F4FE45D8DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <15faeb97-d031-f70a-adab-f2966e0b1221@redhat.com>
 <MN2PR12MB44884289499B6B16A0E9017DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <b5faa9b9-6f40-f8e4-cf7c-795b429e02a8@redhat.com>
In-Reply-To: <b5faa9b9-6f40-f8e4-cf7c-795b429e02a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T16:15:22Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e7c7ada3-0af5-4a9f-81aa-122fe58df066;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 993ed946-eaf4-4ab9-f4c6-08d8e5720b64
x-ms-traffictypediagnostic: MN2PR12MB4487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB448746BDAF519620F3CA4493F76F9@MN2PR12MB4487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZoPlXUURRTXSx36rokiLWQbx19KYgVeW7D2cUA9N86bV6+cV0/Er1YL+aBgdDW4U/4k64gD5xgJONlSQDFyQVbs1koUUeEYAGZQwSml0kmnoo+JPNdrjcb9jEAdPLLsxzDsHDJBOjxK68JVa6+0geRmKsUFQv5/xcJxk9nquQg4pX+I3PLbMlWcVfRB04pSHSSkNwq87N/WNssbO5LqqPs4PWVy+Y3n4oU0Q6Pn29tdLjTTTYINkdFNKkjhemwiPjF84D5+LSlrhiM37kWNkJOcqGIooYMKF9l9KpSI5DrI+jodGn1QsD9nFgKumP9rHg2Zso9RaNjs/zJkhIbXMuT4gIwA4q4I7BfMgsfNN1rqsSklsRIJQcB2JgIGeL31Ume5FzxaRfIYxPKo0UuYuSwxPJusyqM2Lir+hgMZgwRJ5mNHkt+v6errWarqLs6ptkcXRLYNGhGSo6+kZUl/dWBgPrNi/+Rz3mWP30p3V5QoLU8c9Ze9tw/U79qrRafPb66yz5KSRT9q5VCEfRkArZ4WYQnt0rxA5BZp/0padPTQmMKX5uuMV2tNIKbuQHZH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(110136005)(316002)(71200400001)(54906003)(33656002)(8676002)(478600001)(8936002)(86362001)(186003)(26005)(6506007)(5660300002)(2906002)(76116006)(6636002)(9686003)(83380400001)(66476007)(55016002)(7696005)(66946007)(66446008)(4326008)(64756008)(66556008)(52536014)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YmpDWG13ZjUxRno5bjNmVGlkTVc5bDYwWmN1VEx5TzRwSjVydVNkUHRyaEph?=
 =?utf-8?B?TEdCd0pOMW1DTlJCbkF3TVVCMytnRzdsRVlNOUQxZUY3aVdnSFBDYldjNUR3?=
 =?utf-8?B?V0EwRVJ0RnNiZ3pUbm1ZYytsTVpNdGJZaHJ0RzlsY0xjVVQ1UjV5VXZyRVVz?=
 =?utf-8?B?aXJReVhVbkQ4ODNydWhSeENyODRyTjVhMDc3VzFhSVlqRXV0Qy80MkhoM3FG?=
 =?utf-8?B?RkYrSkJqWmNCWC95M3RLMFNiTW8wUmMyK3pLd1R5K2RMYjU2SVNaM2U1ZHFi?=
 =?utf-8?B?ZjV1bmRxd2J3M3ZLTSswdHh4bXU2OTNHR0swZlgrbHV3RXhtVWwzbnMzRUZ3?=
 =?utf-8?B?OHlDZC93MTJBM2sxSFo2UVZ2eTg3eThkc1dPd3NwOTB4TFV5THg1dDFJa0N3?=
 =?utf-8?B?bnM4Vk1pclJXN0NmODFJd2ErMXRaVjkvbVA3M1VUUHJyWElhZXhsN1JxQVhq?=
 =?utf-8?B?ZW0remlwR3lmbS9oclkxWGNPVFY0ME5kVHZORXlBeG9wZ1VaMFZwN1FFU2xZ?=
 =?utf-8?B?NjhvdFJmY2ZDL01sV0ttNnR5c01nVXVNaENicTVxbGpXeXh4WFhoOGU5ZzNp?=
 =?utf-8?B?VHZkSEs3TEhGY0dpbTRDNEczNWdEZUwxY0ZKNmJRZTZBNTVZMXZycXhmQ256?=
 =?utf-8?B?NzFMMS8yMXVLcW04elR6VFZ1Z3RVUHVmMGxJaXR5OEFYRjFXdFRvZ1ppYUZv?=
 =?utf-8?B?d0I1N1Fod2R6blpBcVdKNkU1QTBSRU03UHFHS1hsRmNpTzd5RDZOSGlrRjNK?=
 =?utf-8?B?RWQ5M21yTlY0ZkswV3pKazQ2WFFDZ0Z0emdlYWR6QnZFaElkUVl1Nlpnenlj?=
 =?utf-8?B?WUU2UEcwZm1HOTFST1ZpL0lQbzYxdlBHQkhndnlrWWJiUXpXT0Z1QkdjSVMy?=
 =?utf-8?B?S2pYZ29DWHpyOG9zY0JIK1VJOERYYlcyYXdyM1ZIWERRTjZoUHRiUlppWmY3?=
 =?utf-8?B?cHN6RTQyV2RKcmVUQ2RXOXRnVkhNQU9wYXlkZS9FeEx6UG5CU3JzSE82dkdt?=
 =?utf-8?B?U1ZvVDJOaGtNYlo2aCtpWGN6TVlLdVB4MnhCVDZvR1FvRUFBSmRjcVdvamZV?=
 =?utf-8?B?YzVtQ1dmMkYwVXZJaWp5WmpENHYxRXUzZEY0MUNtK0JXQ2lZRlBSWnFLaE05?=
 =?utf-8?B?KzBYQ2g5OHlndFNSb2RQQWhIanErbjhDdWp4bmY0OEZjYVkyWkwwT0xETkZQ?=
 =?utf-8?B?YnNaZVZoaEFvK0RjbUtuSzRSb0tlZ0lZZHg1bDdFMkdRTUc5R04yRDBIRCsy?=
 =?utf-8?B?SkVWYmd4SDZXRjlUbUhZSVlQcFFobkFST25pVElSc3VGa05uTlpzb2tHV0Jt?=
 =?utf-8?B?VHZjN3pSYUdJREJDZGtQTmFrZjUzVGxnYTdZVDZVcHFleG51NFFMWWpqS0VU?=
 =?utf-8?B?YUZCVDVveVNVN2pDMmUrQVkrUXRrWFRIUFJNZTkyM2xvV0YrcUJicDZMRWp2?=
 =?utf-8?B?OVZiU21md0lrdjc4VjJBTmRXSTRJaDVJTjVDL1orVXEzcFRheTVya2JXQW43?=
 =?utf-8?B?Y0ozbFU2UTBjbnFBay9aZVE3bWo3aGZhdi90SjNVZU4vbWpJZGxDM01FUDZQ?=
 =?utf-8?B?OHNBZ0E0TnNBZzZhcjI5K2VGNVMrYUVFS0hjY0ZRSithVGhNd0ZLS2EzRDI1?=
 =?utf-8?B?VXk4VVdJaHZYLy8wcEhTR3RTUi9JRGx2SGZDNlgvUWw4MEtYT1Z6UUNpVVZi?=
 =?utf-8?B?a2dCNTZ4NmJaRjk0VEltemJXcUZ1N01mL0o2eEFERnQvcDNKMkJ1MFhTOWJn?=
 =?utf-8?Q?BAQ6Gy/CO5G+OBCdNQIcGJBWJ/3io8kZQA4CEGt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993ed946-eaf4-4ab9-f4c6-08d8e5720b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 16:15:25.1908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqxOh4wu+1cMbZXjjWsmHPys5lC2u0MNc+Arv8uNIrc2XUDOaqoiuaXjourez7WjpQv4DNHphWYtoKMGlGxbOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBQdWJsaWMgVXNlXQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXksIE1h
cmNoIDEyLCAyMDIxIDEwOjQ4IEFNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgYW1k
LWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47DQo+IEFuZHJldyBNb3J0
b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBMaWFuZywgTGlhbmcgKExlbykNCj4gPExp
YW5nLkxpYW5nQGFtZC5jb20+DQo+IENjOiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47
IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBNaWtlIFJh
cG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+Ow0KPiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+OyBHZW9yZ2UgS2VubmVkeQ0KPiA8Z2VvcmdlLmtlbm5lZHlAb3JhY2xlLmNv
bT4NCj4gU3ViamVjdDogUmU6IHNsb3cgYm9vdCB3aXRoIDdmZWY0MzFiZTljOSAoIm1tL3BhZ2Vf
YWxsb2M6IHBsYWNlIHBhZ2VzIHRvDQo+IHRhaWwgaW4gX19mcmVlX3BhZ2VzX2NvcmUoKSIpDQo+
IA0KPiA+IDhHICh3aXRoIHNvbWUgY2FydmUgb3V0IGZvciB0aGUgaW50ZWdyYXRlZCBHUFUpLg0K
PiA+IFsgICAgMC4wNDQxODFdIE1lbW9yeTogNjg1ODY4OEsvNzIwMDMwNEsgYXZhaWxhYmxlICgx
NDM0NUsga2VybmVsIGNvZGUsDQo+IDk2NTlLIHJ3ZGF0YSwgNDk4MEsgcm9kYXRhLCAyNDg0SyBp
bml0LCAxMjI5MksgYnNzLCAzNDEzNjBLIHJlc2VydmVkLCAwSw0KPiBjbWEtcmVzZXJ2ZWQpDQo+
ID4NCj4gPiBOb3RoaW5nIHBhcnRpY3VsYXJseSBzcGVjaWFsIGFib3V0IHRoZXNlIHN5c3RlbXMg
dGhhdCBJIGFtIGF3YXJlIG9mLiAgSSdsbCBzZWUNCj4gaWYgd2UgY2FuIHJlcHJvIHRoaXMgaXNz
dWUgb24gYW55IG90aGVyIHBsYXRmb3JtcywgYnV0IHNvIGZhciwgbm90IG9uZSBoYXMNCj4gbm90
aWNlZCBhbnkgcHJvYmxlbXMuDQo+ID4NCj4gPj4NCj4gPj4gSW5jcmVhc2luZyB0aGUgYm9vdCB0
aW1lIGZyb20gYSBmZXcgc2Vjb25kcyB0byAyLTMgbWludXRlcyBkb2VzIG5vdA0KPiA+PiBzbWVs
bCBsaWtlIHNvbWUgY29ybmVyIGNhc2UgY2FjaGUgZWZmZWN0cyB3ZSBtaWdodCBiZSBoaXR0aW5n
IGluIHRoaXMNCj4gPj4gcGFydGljdWxhciBpbnN0YW5jZSAtIHRoZXJlIGhhdmUgYmVlbiBtaW5v
ciByZXBvcnRzIHRoYXQgaXQgZWl0aGVyDQo+ID4+IHNsaWdodGx5IGluY3JlYXNlZCBvciBzbGln
aHRseSBkZWNyZWFzZXMgaW5pdGlhbCBzeXN0ZW0gcGVyZm9ybWFuY2UsIGJ1dCB0aGF0DQo+IHdh
cyBhYm91dCBpdC4NCj4gPj4NCj4gPj4gRWl0aGVyLCB5ZXQgYW5vdGhlciBsYXRlbnQgQlVHIChi
dXQgd2h5PyB3aHkgc2hvdWxkIG1lbW9yeSBhY2Nlc3MNCj4gPj4gc3VkZGVubHkgYmUgdGhhdCBz
bG93PyBJIGNvdWxkIG9ubHkgZ3Vlc3MgdGhhdCB3ZSBhcmUgbm93IG1ha2luZw0KPiA+PiBzb29u
ZXIgdXNlIG9mIHZlcnkgc2xvdyBtZW1vcnkpLCBvciB0aGVyZSBpcyByZWFsbHkgc29tZXRoaW5n
IGVsc2Ugd2VpcmQNCj4gZ29pbmcgb24uDQo+ID4NCj4gPiBMb29rcyBsaWtlIHByZXR0eSBtdWNo
IGV2ZXJ5dGhpbmcgaXMgc2xvd2VyIGJhc2VkIG9uIHRoZSB0aW1lc3RhbXBzIGluIHRoZQ0KPiBk
bWVzZyBvdXRwdXQuICBUaGVyZSBpcyBhIGJpZyBqdW1wIGhlcmU6DQo+IA0KPiBJZiB3ZSdyZSBy
ZWFsbHkgZGVhbGluZyB3aXRoIHNvbWUgc3BlY2lmaWMgc2xvdyBtZW1vcnkgcmVnaW9ucyBhbmQg
dGhhdA0KPiBtZW1vcnkgZ2V0cyBhbGxvY2F0ZWQgZm9yIHNvbWV0aGluZyB0aGF0IGdldHMgdXNl
ZCByZWd1bGFybHksIHRoZW4gd2UgbWlnaHQNCj4gZ2V0IGEgZ2VuZXJhbCBzbG93ZG93bi4gSGFy
ZCB0byBpZGVudGlmeSwgdGhvdWdoIDopDQo+IA0KPiA+DQo+ID4+IFsgICAgMy43NTg1OTZdIEFD
UEk6IEFkZGVkIF9PU0koTGludXgtTGVub3ZvLU5WLUhETUktQXVkaW8pDQo+ID4+IFsgICAgMy43
NTkzNzJdIEFDUEk6IEFkZGVkIF9PU0koTGludXgtSFBJLUh5YnJpZC1HcmFwaGljcykNCj4gPj4g
WyAgIDE2LjE3Nzk4M10gQUNQSTogMTMgQUNQSSBBTUwgdGFibGVzIHN1Y2Nlc3NmdWxseSBhY3F1
aXJlZCBhbmQgbG9hZGVkDQo+ID4+IFsgICAxNy4wOTkzMTZdIEFDUEk6IFtGaXJtd2FyZSBCdWdd
OiBCSU9TIF9PU0koTGludXgpIHF1ZXJ5IGlnbm9yZWQNCj4gPj4gWyAgIDE4Ljk2OTk1OV0gQUNQ
STogRUM6IEVDIHN0YXJ0ZWQNCj4gPg0KPiA+IEFuZCBoZXJlOg0KPiA+DQo+ID4+IFsgICAzNi41
NjY2MDhdIFBDSTogQ0xTIDY0IGJ5dGVzLCBkZWZhdWx0IDY0DQo+ID4+IFsgICAzNi41NzUzODNd
IFRyeWluZyB0byB1bnBhY2sgcm9vdGZzIGltYWdlIGFzIGluaXRyYW1mcy4uLg0KPiA+PiBbICAg
NDQuNTk0MzQ4XSBJbml0cmFtZnMgdW5wYWNraW5nIGZhaWxlZDogRGVjb2RpbmcgZmFpbGVkDQo+
ID4+IFsgICA0NC43NjUxNDFdIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogNDYzNDhLDQo+ID4NCj4g
PiBBbHNvIHNlZWluZyBzb2Z0IGxvY2t1cHM6DQo+ID4+IFsgIDEyNC41ODg2MzRdIHdhdGNoZG9n
OiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzEgc3R1Y2sgZm9yIDIzcyENCj4gPj4gW3N3YXBwZXIv
MTowXQ0KPiANCj4gWWVzLCBJIG5vdGljZWQgdGhhdCAtLSB0aGVyZSBpcyBhIGhlYXZ5IHNsb3dk
b3duIHNvbWV3aGVyZS4NCj4gDQo+IEFzIHRoYXQgcGF0Y2ggaXMgdjUuMTAgYWxyZWFkeSAoYW5k
IHdlJ3JlIGNsb3NlIHRvIHY1LjEyKSBJIGFzc3VtZSBzb21ldGhpbmcNCj4gaXMgcGFydGljdWxh
cmx5IHdlaXJkIGFib3V0IHRoZSBwbGF0Zm9ybSB5b3UgYXJlIHJ1bm5pbmcgb24gLSBiZWNhdXNl
IHRoaXMgaXMNCj4gdGhlIGZpcnN0IHRpbWUgSSBzZWUgYSByZXBvcnQgbGlrZSB0aGF0Lg0KDQpX
ZWxsLCB0aGlzIHBsYXRmb3JtIGlzIG5vdCB5ZXQgd2lkZWx5IGF2YWlsYWJsZSBvdXRzaWRlIG9m
IEFNRCBzbyBpdCdzIG5vdCBsaWtlbHkgdG8gaGF2ZSBiZWVuIHNlZW4gYnkgYW55b25lIGVsc2Us
IGJ1dCB0aGVyZSBpcyBub3RoaW5nIHNwZWNpYWwgYWJvdXQgaXQgY29tcGFyZWQgdG8gYW55IG90
aGVyIEFNRCBwbGF0Zm9ybXMgYmV5b25kIHRoYXQgdGhhdCBJIGFtIGF3YXJlIG9mLg0KDQpBbGV4
DQoNCg==
