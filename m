Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8533FCAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbhHaP1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:27:45 -0400
Received: from mail-dm3nam07on2075.outbound.protection.outlook.com ([40.107.95.75]:8576
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239120AbhHaP1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:27:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eADNAOFn5SBUDxR2jSLruufpNm7xqDRVXPlebtVvtTnVJjr9zkYtKsH9o2lZT3tvGxaqqhzBIWSyc10gQYyY4TvB//PZvvBf41PtqwLL1fDyzHI/59xyJ6KCzmw/F1tET1hLT7O64C0zl8Z82HAF98/u1ZpKuvV6315DCpo3glqnu46880JcfmVdjOKsAywGxohpuciHvPvj+oaCeEBx1pX+oG98bBFy3zURvY9vjgVJGikEL2LRuHHMw7Gi/+3uaEBzEp/Aw9SJzydN25A9tQBOyq+KtQESMbVm/G6vekIbkMRA2qMl3LRCwtefRtd0ClNXjI5MFZzb3o0xZSD6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtRWtM8+8R22NciXRbEPycfBfEs4dyRx1q8FIyf1PzI=;
 b=bcclV3BaAm1DmOERbjAVpPopkalwFMujjppYnZXgoAuIAstNmzSInQeih2uYBYSar39NoeIelMYqMAUT+Fb3SYQrNxGma4gdh6EfgzvfXoQnDXfSAFn2Je1MRE6Z0gsLz0tO1SCJdf1xuLBuqJyxYVL9LtI88QWOZkCJt57qjAbcgGY3EoHinK9ZT+LMggfE2oAAvtSSMpKm8dAjh9zDogVDnQ/CQdlSiifDjLLUhAGcJU9ob8L+4MmS+J3wwxLIEswtWvT/EKNkjZNcUnJaoSaOJzjR8FetF71KL3DHtdYhoas0Y5MJQh+CPOhy9og4NBEWc33BQfgukVBzaX74MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtRWtM8+8R22NciXRbEPycfBfEs4dyRx1q8FIyf1PzI=;
 b=2e2FgMrNhHUfIV5px8YnpsYeBNwLq/g/WHeCAGBR86zR+v7S2t9YNVtxN9zvqjZi3vg/saKjvDlNbeAjGJl+CskXqkhVxysnaSIl0DXH8/49YXeU8/fbQfF4fTBndHKdYQe4MBn9mqUiFBJxFa+0sa1VyMhrLqMc/OvVs5KSQ74=
Received: from SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33)
 by SN6PR12MB4624.namprd12.prod.outlook.com (2603:10b6:805:e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 15:26:45 +0000
Received: from SN6PR12MB2765.namprd12.prod.outlook.com
 ([fe80::7dbb:89af:779:6e35]) by SN6PR12MB2765.namprd12.prod.outlook.com
 ([fe80::7dbb:89af:779:6e35%3]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 15:26:45 +0000
From:   "Ramakrishnan, Krupa" <Krupa.Ramakrishnan@amd.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kamezawa.hiroyu@jp.fujitsu.com" <kamezawa.hiroyu@jp.fujitsu.com>,
        "lee.schermerhorn@hp.com" <lee.schermerhorn@hp.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "Srinivasan, Sadagopan" <Sadagopan.Srinivasan@amd.com>
Subject: RE: [FIX PATCH 2/2] mm/page_alloc: Use accumulated load when building
 node fallback list
Thread-Topic: [FIX PATCH 2/2] mm/page_alloc: Use accumulated load when
 building node fallback list
Thread-Index: AQHXnZkDXdN2bZ0j/UKAMbTk7Wc8JquNYjeAgABY9RA=
Date:   Tue, 31 Aug 2021 15:26:45 +0000
Message-ID: <SN6PR12MB2765859076BFE5B667A0C4719BCC9@SN6PR12MB2765.namprd12.prod.outlook.com>
References: <20210830121603.1081-1-bharata@amd.com>
 <20210830121603.1081-3-bharata@amd.com>
 <13dab5ac-03a3-e9b3-ff12-f819f7711569@arm.com>
In-Reply-To: <13dab5ac-03a3-e9b3-ff12-f819f7711569@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-31T15:26:42Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=61aace27-b3b7-446a-a25e-ced85eca7f43;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d8fe9fe-d2b0-4b47-849a-08d96c93be0c
x-ms-traffictypediagnostic: SN6PR12MB4624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB4624CC50B365A8D8801630739BCC9@SN6PR12MB4624.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fI3Lx+hCl9TbTDM2cgtxfAlMjSg3RGbomzAR2yb0wOJ3iVCAA6Z8tHxItwMPBjxzbVwDsU96DuLlcxFjywwSiCruwbdlsZynjY1Vd+KzW1tQiPb7UhYuQ8mfgWKnj3wK9TFBJwtvRvq3V4BqRSxaeoZSOBmC1z5U5p/SBb8eXzMyNyhYmNW79dW+2y9bajuo4T+AJgUCVOUqBuSfHkofJnx3LdZM0PiAKTz9oqrEh5SdvpTFmEE8lR9tFwt8Gb3xLC229Mrc5gewPp50j0aBPHkbJyDs9wpMjrYRXHEeIfbQ1QobIUPWRemHzA7qqKcxBsk9wgEnXgC5rseaNIs4M1M0S9z6PqlB+lv+BGn77ck5aUVG+SbDeND5afUHEd7myvh4uSWOXI/H40lIE9TpJK44qEGqRQ03tuc5TMIT8gh86DDSxuwvEIfXZl4rfHykafk65thLVMocbnoMkCYbNk/loUDxu9bKnOnowABK1v7nsOpzIIRMEugMCLfEVMTVQ2d+MYlUJaqGNY4Nbt7jL2yjSncblJ5UmBbgD2eHXCsC+H+4dYxXEjfbrpfX+9Den8PFLghCbBaBz6I+VEde0b0hnUhOv/C+qMnLK7zQ3AtxmvznSVn7AFX/nMBx59aKhrkmkOWSt4rARqYFgEsGnIy6vO5o+mwBnG/sJzZWS7UR0Uq0U2sZm5gsJOznUxzYeYE+fZXamBX1KHv9J4ZWoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(110136005)(86362001)(7696005)(54906003)(66476007)(33656002)(66446008)(8936002)(5660300002)(4326008)(53546011)(71200400001)(64756008)(66556008)(76116006)(66946007)(6506007)(38100700002)(55016002)(316002)(8676002)(9686003)(38070700005)(186003)(478600001)(2906002)(26005)(122000001)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXNLWFZhK216N2lmN21uQndiYVdrZEtMalBwbE9kWHkreUJWb0ZuUTV4WGdt?=
 =?utf-8?B?UkxXVnFZeUxKQWZZaXNtZ3NJdG9XZEhFRWp6TFUrUEVxQUhCelkvOXBIOHpu?=
 =?utf-8?B?Q3BzSm5Wdlo1K0FmRWM0UzlKeVlYU0dnVFA4YWZ5cy83V0NRbFNTc3NKUnNy?=
 =?utf-8?B?MGJqMGRzVGE5Z0xHVmNBMEJRV1N0QWxCNW5zZHMwNDA2MDdiRVFLNDRHQmZT?=
 =?utf-8?B?bnhEOGUralJqSzF4cGEybFlmR2x3N3VUWWRtTEpYVEoveWl3cHliaFEzSG80?=
 =?utf-8?B?alR4a1ZiUnl3TmVmTmVxYWtkZEdRTzBESlloWEkrMXJsL1doTW9QUlZJTmNm?=
 =?utf-8?B?UWd2bmRKSmJMbGo3NWptR0xDdlZhRFhyanVKYytTSWF6cEt0MWV3bisxYXN1?=
 =?utf-8?B?N0pXNlBpNEJPaFZwZkFlL2YrZmI5Zm1DTm9DTXBVTDBPTUlDMFJhL0c1cVho?=
 =?utf-8?B?djBqQ0VtUTVjTTVzRWVXaW5GcEpvSTJQT3YzRDdQdk51c0FmeXg1d0YwTGFH?=
 =?utf-8?B?WGNBY3prTnJiYzVGcUVxU3V4bHJsdHllUmpvYzdYbmtxSUFPMHhGelRpKzRU?=
 =?utf-8?B?cEt1WGJRaURNMEUzSXMzUFZKWkdwWjlodTB3RmZYMXlBMkJuN1lpbkt3N2tu?=
 =?utf-8?B?b2szeXFaWml2VnRKUG9KVGJqZzZkWmtsZWxqQXNnQmhwTnc0T2tBdGpBSE1B?=
 =?utf-8?B?Yzl0WHNMdFdnalZyLzN6ZllsMndqdTZPQU1kSndQVnZiOWtmVkdGbzVLYU05?=
 =?utf-8?B?VjRWTHRBaEhiTmorREtaenpFc3pvbHJ3U254b2dWclNYZk5SekI5Z1AwcHBl?=
 =?utf-8?B?M1VDdTBFUklyRFFkZlN4cnMzeERvLzR5WFgvQWJiU2FjWFUwKzlLcjR3TDF1?=
 =?utf-8?B?aVdlTUg1Q2crbFZMWjlZQTBwZkdFcXVOMnZIVnZ6UkNoUTJKU1ROZHVuRFFI?=
 =?utf-8?B?WkhqSU9uYVkwbVcwWXYrSVVmVkF4bDVhbzB3b01LZ2hNZjFBbFlwRDZXSzVj?=
 =?utf-8?B?Ri9MK1NPeVIxSFhoaXIvc044MzZ3dXczYXZNK0F0TlN2cHRZSmFGbE9nTHhn?=
 =?utf-8?B?NVlWb3JEZWZrQWFWdjZHVW5jUlNGMDU3SnBEK3p2T05ZejUydW1odEY1Q1lE?=
 =?utf-8?B?b1REUnZJU1YwUTNhbG02ckVCT3NNclo3R3ppNDNkbzBGQmVvVnZtNEQ2aDRY?=
 =?utf-8?B?ZGl5VWxoZjFBTm52QXhPcEZqMXU3WWpQcis3dDVKMWtES3FMY0xkNjY0ZHFs?=
 =?utf-8?B?c0hQV1BkazI4MkN2ZFRjdlNZSmgxY283QVJncHBsTU82SHYwQWV2NHByL21Y?=
 =?utf-8?B?VG15Uk5HTVJESDMxdlNzN0Z2OTE0N0k5K0dqR0pUbnRzWHkrQitDQkhGQVRx?=
 =?utf-8?B?ejN3dURIWkFEdmhrNVFsWmtkdFp3U3d6b0o2cVJTRkozTTg3TndUb0hkS1Rl?=
 =?utf-8?B?UnFoa3BFNXRlRXRPUHNFN0k1U1VWdHhJSkhkTjBmNlJmdERKQzdnaDR2Yktv?=
 =?utf-8?B?Q1FRLytYUWxVbFJpcVJlSXJSeVdCL1Z0cEtNWWhqVDJReGpHMFhuYlZkSnND?=
 =?utf-8?B?K2UvdlhualpZQUxMYzdJc3ltQ0NwMy84NytlVGxQOVMyVTNjOFVsaU5jcy82?=
 =?utf-8?B?NEg4cWNyWjNKNzhia1dmbzAwTjNLUjAxSUMvU0Z5YlZkV0duWk9uS0VHeC9Z?=
 =?utf-8?B?WklJeUl6KzRrbHRtNmpXd1kwQUs1SmdKQWtMWnp4V3F4V1pVaXI0clR0RWx5?=
 =?utf-8?Q?o0O8Ti5Q0HS8woZ2RA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8fe9fe-d2b0-4b47-849a-08d96c93be0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 15:26:45.3090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUadWw6q/hVyJvvCVjUu+LA0+fjeAPD9BOv+DKJHZslCGuhyvIDf2g3vLX0AN63cWLBdgrnKdMHzY+Fx49ltDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4624
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhlIGJhbmR3aWR0aCBpcyBsaW1pdGVkIGJ5IHVu
ZGVydXRpbGl6YXRpb24gb2YgY3Jvc3Mgc29ja2V0IGxpbmtzIGFuZCBub3QgdGhlICBsYXRlbmN5
LiBIb3RzcG90dGluZyBvbiAgb25lIG5vZGUgd2lsbCBub3QgZW5nYWdlIGFsbCAgaGFyZHdhcmUg
cmVzb3VyY2VzIGJhc2VkIG9uIG91ciByb3V0aW5nIHByb3RvY29sIHdoaWNoIHJlc3VsdHMgaW4g
dGhlIGxvd2VyIGJhbmR3aWR0aC4gRGlzdHJpYnV0aW5nIGVxdWFsbHkgYWNyb3NzIG5vZGVzIDAg
YW5kIDEgd2lsbCB5aWVsZCB0aGUgYmVzdCByZXN1bHRzIGFzIGl0IHN0cmVzc2VzIHRoZSBmdWxs
IHN5c3RlbSBjYXBhYmlsaXRpZXMuDQoNClRoYW5rcw0KS3J1cGEgUmFtYWtyaXNobmFuDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbnNodW1hbiBLaGFuZHVhbCA8YW5zaHVt
YW4ua2hhbmR1YWxAYXJtLmNvbT4gDQpTZW50OiAzMSBBdWd1c3QsIDIwMjEgNDo1OA0KVG86IFJh
bywgQmhhcmF0YSBCaGFza2VyIDxiaGFyYXRhQGFtZC5jb20+OyBsaW51eC1tbUBrdmFjay5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnOyBrYW1lemF3YS5oaXJveXVAanAuZnVqaXRzdS5jb207IGxlZS5zY2hlcm1lcmhvcm5AaHAu
Y29tOyBtZ29ybWFuQHN1c2UuZGU7IFJhbWFrcmlzaG5hbiwgS3J1cGEgPEtydXBhLlJhbWFrcmlz
aG5hbkBhbWQuY29tPjsgU3Jpbml2YXNhbiwgU2FkYWdvcGFuIDxTYWRhZ29wYW4uU3Jpbml2YXNh
bkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtGSVggUEFUQ0ggMi8yXSBtbS9wYWdlX2FsbG9jOiBV
c2UgYWNjdW11bGF0ZWQgbG9hZCB3aGVuIGJ1aWxkaW5nIG5vZGUgZmFsbGJhY2sgbGlzdA0KDQpb
Q0FVVElPTjogRXh0ZXJuYWwgRW1haWxdDQoNCk9uIDgvMzAvMjEgNTo0NiBQTSwgQmhhcmF0YSBC
IFJhbyB3cm90ZToNCj4gQXMgYW4gZXhhbXBsZSwgY29uc2lkZXIgYSA0IG5vZGUgc3lzdGVtIHdp
dGggdGhlIGZvbGxvd2luZyBkaXN0YW5jZSANCj4gbWF0cml4Lg0KPg0KPiBOb2RlIDAgIDEgIDIg
IDMNCj4gLS0tLS0tLS0tLS0tLS0tLQ0KPiAwICAgIDEwIDEyIDMyIDMyDQo+IDEgICAgMTIgMTAg
MzIgMzINCj4gMiAgICAzMiAzMiAxMCAxMg0KPiAzICAgIDMyIDMyIDEyIDEwDQo+DQo+IEZvciB0
aGlzIGNhc2UsIHRoZSBub2RlIGZhbGxiYWNrIGxpc3QgZ2V0cyBidWlsdCBsaWtlIHRoaXM6DQo+
DQo+IE5vZGUgIEZhbGxiYWNrIGxpc3QNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IDAgICAg
IDAgMSAyIDMNCj4gMSAgICAgMSAwIDMgMg0KPiAyICAgICAyIDMgMCAxDQo+IDMgICAgIDMgMiAw
IDEgPC0tIFVuZXhwZWN0ZWQgZmFsbGJhY2sgb3JkZXINCj4NCj4gSW4gdGhlIGZhbGxiYWNrIGxp
c3QgZm9yIG5vZGVzIDIgYW5kIDMsIHRoZSBub2RlcyAwIGFuZCAxIGFwcGVhciBpbiANCj4gdGhl
IHNhbWUgb3JkZXIgd2hpY2ggcmVzdWx0cyBpbiBtb3JlIGFsbG9jYXRpb25zIGdldHRpbmcgc2F0
aXNmaWVkIA0KPiBmcm9tIG5vZGUgMCBjb21wYXJlZCB0byBub2RlIDEuDQo+DQo+IFRoZSBlZmZl
Y3Qgb2YgdGhpcyBvbiByZW1vdGUgbWVtb3J5IGJhbmR3aWR0aCBhcyBzZWVuIGJ5IHN0cmVhbSAN
Cj4gYmVuY2htYXJrIGlzIHNob3duIGJlbG93Og0KPg0KPiBDYXNlIDE6IEJhbmR3aWR0aCBmcm9t
IGNvcmVzIG9uIG5vZGVzIDIgJiAzIHRvIG1lbW9yeSBvbiBub2RlcyAwICYgMQ0KPiAgICAgICAo
bnVtYWN0bCAtbSAwLDEgLi9zdHJlYW1fbG93T3ZlcmhlYWQgLi4uIC0tY29yZXMgPGZyb20gMiwg
Mz4pIA0KPiBDYXNlIDI6IEJhbmR3aWR0aCBmcm9tIGNvcmVzIG9uIG5vZGVzIDAgJiAxIHRvIG1l
bW9yeSBvbiBub2RlcyAyICYgMw0KPiAgICAgICAobnVtYWN0bCAtbSAyLDMgLi9zdHJlYW1fbG93
T3ZlcmhlYWQgLi4uIC0tY29yZXMgPGZyb20gMCwgMT4pDQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAgICAgICAgICAgICBCQU5EV0lEVEggKE1CL3Mp
DQo+ICAgICBURVNUICAgICAgQ2FzZSAxICAgICAgICAgIENhc2UgMg0KPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgICBDT1BZICAgICAgNTc0NzkuNiAgICAg
ICAgIDExMDc5MS44DQo+ICAgIFNDQUxFICAgICAgNTUzNzIuOSAgICAgICAgIDEwNTY4NS45DQo+
ICAgICAgQUREICAgICAgNTA0NjAuNiAgICAgICAgIDk2NzM0LjINCj4gICBUUklBREQgICAgICA1
MDM5Ny42ICAgICAgICAgOTcxMTkuMQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+DQo+IFRoZSBiYW5kd2lkdGggZHJvcCBpbiBDYXNlIDEgb2NjdXJzIGJlY2F1
c2UgbW9zdCBvZiB0aGUgYWxsb2NhdGlvbnMgDQo+IGdldCBzYXRpc2ZpZWQgYnkgbm9kZSAwIGFz
IGl0IGFwcGVhcnMgZmlyc3QgaW4gdGhlIGZhbGxiYWNrIG9yZGVyIGZvciANCj4gYm90aCBub2Rl
cyAyIGFuZCAzLg0KDQpJIGFtIHdvbmRlcmluZyB3aGF0IGNhdXNlcyB0aGlzIHBlcmZvcm1hbmNl
IGRyb3AgaGVyZSA/IFdvdWxkIG5vdCB0aGUgbWVtb3J5IGFjY2VzcyBsYXRlbmN5IGJlIHNpbWls
YXIgYmV0d2VlbiB7MiwgM30gLS0tPiAgeyAwIH0gYW5kIHsyLCAzfSAtLS0+ICB7IDEgfSwgZ2l2
ZW4gYm90aCB0aGVzZSBub2RlcyB7MCwgMX0gaGF2ZSBzYW1lIGRpc3RhbmNlIGZyb20gezIsIDN9
IGkuZSAzMiBmcm9tIHRoZSBhYm92ZSBkaXN0YW5jZSBtYXRyaXguIEV2ZW4gaWYgdGhlIHByZWZl
cnJlZCBub2RlIG9yZGVyIGNoYW5nZXMgZnJvbSB7IDAgfSB0byB7IDEgfSBmb3IgdGhlIGFjY2Vz
c2luZyBub2RlIHsgMyB9LCBpdCBzaG91bGQgbm90IGNoYW5nZSB0aGUgbGF0ZW5jeSBhcyBzdWNo
Lg0KDQpJcyB0aGUgcGVyZm9ybWFuY2UgZHJvcCBoZXJlLCBpcyBjYXVzZWQgYnkgZXhjZXNzaXZl
IGFsbG9jYXRpb24gb24gbm9kZSB7IDAgfSByZXN1bHRpbmcgZnJvbSBwYWdlIGFsbG9jYXRpb24g
bGF0ZW5jeSBpbnN0ZWFkLg==
