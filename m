Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA83AED1A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhFUQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:09:02 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com ([40.107.243.109]:3104
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230059AbhFUQI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:08:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwb6iJuvrr0gZM15hyAeHIqQRU7Fw84Ljj0u5ebQGi0oTg/InJRYwf+XE7jm0P9rvWugRYlmUWKJwJhVie95WRRSCqXRdv+XRg4GsB0a2Yk9oZ6m9BJnp1UG8LKXEo/RInCTbTs746bRa8OrCVrsGZLQ3KAeS+gWzB+UAyyrHdNrJl6i36sOWxe59cxoQ/7Qqr1MFNioMFG0fw/z8Cs3ZWx9InHEQp4YA/bh82irZDA2hygbflmW6XQh86KmaHEScG9/PDpXu2719Nff0AOVGZ9CCBqyeoY+EnTKMWd53RGFbnd5H4h4klY72ozuBnDYOoW1ONXEVjd2LOZcCMmU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmntYMQMoaEI/u+MVnSmWgqK089jW5MQjFDh2nl9SWw=;
 b=UvvsnCO0nyme44EnX+EgYKQblqBsjZXZVBo6D1M3SjuS22Y9M6l0Be3trZdXTXyjbl6LoOZGKVZLQxC2Z93vH/a6PA9m0RrBMW2f6yhF/8JUD3Rc5VWn1uxZHQTXO0hj3V7bJFOwnDkm79jU2SOWbclw0SDfc0Dcx0dli3TITu8WzZ3nk3SqmjMOTRrSJyRtCDjTwk9xxuusA9uHto/FIxAzRhccaiCRq3uSj4zOlWw00ryn5U5ePppiBiLqnzuir4aPtH3bJfID2RV0Zi0I727swsvSkaE+l+Ais3sOcU8eC+qA1F3W5/iiWFoK3mUcKS7suRB880KEbpvWuOKjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmntYMQMoaEI/u+MVnSmWgqK089jW5MQjFDh2nl9SWw=;
 b=Xg4flyMOUbeP/cpvNGIiAcb2NUHtX96ddoEM+P6leK++WUmhfpMqcHYciSbgm22tCJja9akCwTaiyG7UT3kczDqVn2GCrFaRywej3/Cp/KgXqP/zsVyMGciJ3gCgxCGmchmAOKLIo86P2KVFOqz0cbg67o2ELikHsCqLs3uZHdI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1034.namprd21.prod.outlook.com (2603:10b6:302:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.3; Mon, 21 Jun
 2021 16:06:41 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b838:6cc7:4c40:fe99]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b838:6cc7:4c40:fe99%7]) with mapi id 15.20.4287.005; Mon, 21 Jun 2021
 16:06:41 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Gavin Shan <gshan@redhat.com>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "shan.gavin@gmail.com" <shan.gavin@gmail.com>
Subject: RE: [PATCH 0/3] mm/page_reporting: Make page reporting work on arm64
 with 64KB page size
Thread-Topic: [PATCH 0/3] mm/page_reporting: Make page reporting work on arm64
 with 64KB page size
Thread-Index: AQHXZkskG+q4TwQHi0iUImK73E7zBKsef24AgAAh7KA=
Date:   Mon, 21 Jun 2021 16:06:41 +0000
Message-ID: <MWHPR21MB159394F6D8804DCF4C969212D70A9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210621051152.305224-1-gshan@redhat.com>
 <CAKgT0Uf3UwhdFX93YrkiB8yk6v3syqUrdbu720ECqv1ak_H_FA@mail.gmail.com>
In-Reply-To: <CAKgT0Uf3UwhdFX93YrkiB8yk6v3syqUrdbu720ECqv1ak_H_FA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=589ca7d8-70c6-426d-bfeb-d227398a4e2d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-21T16:03:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82e63f45-c90a-4ad5-edd8-08d934ce8ed0
x-ms-traffictypediagnostic: MW2PR2101MB1034:
x-microsoft-antispam-prvs: <MW2PR2101MB1034569521E6DE0420D32957D70A9@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxHhx5afTF5bY2co23lYgN6kDvcMKtjUg2kA02p2yOBdcdaZT36ppb2s54iu39ULmn9z9GU/+6wonrSl6GxYmdb96qaWXpSpYMJaCYUeMAKppiaytfkFB3ITxLAB+Rx7XrP/FkUD8RwIv4bMkRJiReT046cgEyBEvy3MiO4ChUH8SPKQMmREPdN+aHfGrz433WC8AfbxpTrbARhmuqTFj3VMS8AaDdxuQXvgXIFit8swpe4/wfhAK+TnwabR2dMMINgQXjPry3iGY/okSx1b1YktyLE3GhlmdkXnZkzCO7FBXhO3xDr7ZGicLctBFzQsuOcZT+OHpo/If/yWfUv856Ev2PBa8oOnV3mBxz8vp8uiVYIdbA2RXtf+h3AUxvuBcgX5hJTmcKiBnmRTNAJDc6tStfxPMYTXDRxcMWPSQDpUc9zrbITLYNN0Ij9YjabjU6q+5mfd6hBcl/ZAcFTQtzG1a8WjfUtcnogm7XOg5l6oVv1d5JYryMTdeZWkrYoqapMomYOIw16GLBE/mZ2ZPNSv4L9Sqa1lXYNHzMsKFTDSUyQ5gmofqdyYUfblyp/7Wy3QAafTuQRStaS1DBznO8SOt5YDHcbN7UXGNpaMuWamEXwZq8bk7uI00HtiGXuq0bJ/pV9PeK7gXTYI9VmXpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(82950400001)(26005)(10290500003)(64756008)(82960400001)(5660300002)(186003)(86362001)(7696005)(6506007)(7416002)(66476007)(316002)(8990500004)(33656002)(478600001)(83380400001)(66556008)(122000001)(54906003)(71200400001)(9686003)(38100700002)(110136005)(66946007)(8676002)(66446008)(76116006)(2906002)(8936002)(55016002)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWJyTDRNSG1DaTR6L0ZOMnM1eFVHUmZCY3VyMHJzVzV0VGxGcHlZL1ora2t4?=
 =?utf-8?B?YnRvYVY3ZkVRTHhjK1d3aTJRTkVjLzFkSXlxNGpJem1DUmFGQytZQUlXcUdC?=
 =?utf-8?B?YTY1NUpPOHBpd0I3UEtTQldVTW9CV3p6dkx4YjR3SjJ0eDdNd2RSblNMWjFp?=
 =?utf-8?B?SjZDQVlrNXRrUFZUMHgyRUVoc09tZkNqaVRxbDRETU1CK0UwcjhQcmRWa1d3?=
 =?utf-8?B?b2lFZW5MOEtLMVYvb0U0SURnRzBTTGIyTjVPczkzU1gzSVViUjZYME55dFZj?=
 =?utf-8?B?d01zMThkMVZzYmhHSU5YT2N4MlIzSnpkQ3J4TjM2ektxN1V0a2VvdlpmQ1Bp?=
 =?utf-8?B?NXVGTGdTSVZuakFFR0RKRDUzVElZZ05xVUlCbDRSTUlzd21ZMldNUlhYVUpp?=
 =?utf-8?B?ZUx3RDhENkZWSjRWMTFxbU5sMkEyR0JWeCtSYzhaKzZKS0tsVFlLa2JqQkIv?=
 =?utf-8?B?VDNTTEJyNmlPK3Y0cksxeTdWWXdnQUo5WGgzZlJteERSZlhacHI1ZE5DVXYy?=
 =?utf-8?B?cURCMDdZdTJrSFlvcTZ4UDIwQlB5NTJ4eTFCZ2ZHS05MaWdxN1E0SjNYUlJ3?=
 =?utf-8?B?NkVxbUV4ayswWElKOGdhejVOeElzalBYeGQ3bENMQVFYUXVwUGVXQWkzTmsr?=
 =?utf-8?B?c0h0M3JpRERHWWQ2b08zOVVrSzJCWEx3bVp3S2Q2WHFXcGhLL0txYTY4Unp0?=
 =?utf-8?B?QUE0N3NKOWlITnZMYUI3UWczVm1EMFQwa1RCekNLUGQybTUwbVA4b3FkNGd0?=
 =?utf-8?B?eUJIUk5TYlMzQS9BYStEcUZEZ29pU2dNNXpodVpXdDVWdWpHYnlIV0tiQkFF?=
 =?utf-8?B?VVBFZ3R3OStGTVFNM2ptT2dHcVFHUCt5NUh6YmlOVzFXbHlOTldUaC8vQUVZ?=
 =?utf-8?B?T2x3YUtqQ1NMV3pSaEhXWGdiOGV3c2ttWFFxUGY5MVdXUDdveEdqYnJnc01h?=
 =?utf-8?B?dUpJNGFab0U0aUdJQ1ZZd1BsR3pRbVpqYXgrTm02NFJFdlU3WkxDMFl6cDlh?=
 =?utf-8?B?UXd2MFMwVnpqS25yOCtiUFBTT0Z0aXpOU1pDVmV3SURCd3Zzd3JzaWlPenhV?=
 =?utf-8?B?d2ZHRkNXbEE2OGpNeHJBYzl3Ym1hU2pMdW5maE51OWo0T293SWhGNDExSXNE?=
 =?utf-8?B?bWNhUmI5S3NQZk9QWjh0QUFmMWZaUWdaQlA3a2R3WEFGOWgvVFlCZWZQYUFW?=
 =?utf-8?B?YlJzSmxTbytHRU41U21BaVljUnYwM3dDM1RmM05YZ3ZkMlZBYnlxdDBPekh4?=
 =?utf-8?B?SFBoVkZGdTVnMDE2c1IvN3ZDUWVrbStlWFF2elZ1QUlIWDhrVHV2WWZ1N25W?=
 =?utf-8?B?dzFMdXc1MnJuY0lIZlRtQ2VwdjVZc216MUkwSFF3T0VFY3lHMUo5SFdUZndt?=
 =?utf-8?B?VS85TnpTbHkrOHVFMUIranZ4SkVNL2N2UFdOTlhzWElNMlZjUEJQUWRGMmVH?=
 =?utf-8?B?QXN3dHVxU1czZ0tiZmVuVmJzeklpSUlmUExaQm45VmgyRXdzV00yM2htOXUy?=
 =?utf-8?B?K3JJVW9oTHkwSUdzSm05TUd6ZVFNYnUyQSs4bSs3dVpObHBqNEF4WDNQTWtl?=
 =?utf-8?B?VHAxWmRja3ptTW1md3ZTM1NSc0ZESkMrdHJVT0dibnFzUE1FcGNzbWIvZkJT?=
 =?utf-8?B?OHdta1ZzeDJITHZiOUZTQlQvaGZBTm9xTC9TbEdLeTU4WnRESlprVGlsb3pp?=
 =?utf-8?B?UVFIaUFLUlE1TEFYWHhFTXN2SFFRNTExTnJPa2xaYjNVK0ZYT1VRNjBmQVhG?=
 =?utf-8?Q?LG7hN+K2MXOSYWVKHWX+2rI59bwdAU+FTb64nHz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e63f45-c90a-4ad5-edd8-08d934ce8ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 16:06:41.2610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPtBdx+XeupcISEq9x6HknvVPj4j0TIlRe3f8bXVlY0qlrl7uwetR/Xv0byP72B1CGyw8+c+gQNZjCWUNQQinxxA5D48ixpuXnvgGfF1oAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGFuZGVyIER1eWNrIDxhbGV4YW5kZXIuZHV5Y2tAZ21haWwuY29tPiBTZW50OiBN
b25kYXksIEp1bmUgMjEsIDIwMjEgNzowMiBBTQ0KPiBUbzogR2F2aW4gU2hhbiA8Z3NoYW5AcmVk
aGF0LmNvbT4NCj4gQ2M6IGxpbnV4LW1tIDxsaW51eC1tbUBrdmFjay5vcmc+OyBMS01MIDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQW5kcmV3DQo+IE1vcnRvbiA8YWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZz47IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPjsNCj4g
QW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFuLmtoYW5kdWFsQGFybS5jb20+OyBDYXRhbGluIE1h
cmluYXMNCj4gPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxAa2Vy
bmVsLm9yZz47IHNoYW4uZ2F2aW5AZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8z
XSBtbS9wYWdlX3JlcG9ydGluZzogTWFrZSBwYWdlIHJlcG9ydGluZyB3b3JrIG9uIGFybTY0IHdp
dGgNCj4gNjRLQiBwYWdlIHNpemUNCj4gDQo+IFNvIHRoZSBxdWVzdGlvbiBJIHdvdWxkIGhhdmUg
aXMgd2hhdCBpcyB0aGUgdXNlIGNhc2UgZm9yIHRoaXM/IEl0DQo+IHNlZW1zIGxpa2UgeW91IGRv
bid0IGhhdmUgdG8gZGVhbCB3aXRoIHRoZSBndWVzdCBuYXRpdmUgcGFnZSBzaXplDQo+IGlzc3Vl
cyBzaW5jZSB5b3UgYXJlIHdpbGxpbmcgdG8gYnJlYWsgdXAgd2hhdCB3b3VsZCBvdGhlcndpc2Ug
YmUgVEhQDQo+IHBhZ2VzIG9uIHRoZSBndWVzdCwgYW5kIHRoZSBmYWN0IHRoYXQgeW91IGFyZSB3
aWxsaW5nIHRvIGdvIGRvd24gdG8NCj4gMk1CIHBhZ2VzIHdoaWNoIGhhcHBlbnMgdG8gYWxpZ24g
d2l0aCB0aGUgaG9zdCBUSFAgcGFnZSBzaXplIGZvciB4ODYNCj4gbWFrZXMgbWUgd29uZGVyIGlm
IHRoYXQgaXMgYWN0dWFsbHkgdGhlIGVudmlyb25tZW50IHlvdSBhcmUgcnVubmluZw0KPiBpbi4N
Cj4gDQo+IFJhdGhlciB0aGFuIGhhdmluZyB0aGUgZ3Vlc3QgY29udHJvbCB0aGlzIGl0IG1pZ2h0
IG1ha2Ugc2Vuc2UgdG8gbG9vaw0KPiBhdCBhZGRpbmcgYW4gaW50ZXJmYWNlIHNvIHRoYXQgdGhl
IHBhZ2VfcmVwb3J0aW5nX3JlZ2lzdGVyIGZ1bmN0aW9uDQo+IGFuZCB0aGUgcGFnZV9yZXBvcnRp
bmdfZGV2X2luZm8gc3RydWN0IGNvdWxkIGJlIHVzZWQgdG8gcmVwb3J0IGFuZA0KPiBjb25maWd1
cmUgdGhlIG1pbmltdW0gcGFnZSBzaXplIHRoYXQgdGhlIGhvc3QgY2FuIHN1cHBvcnQgZm9yIHRo
ZSBwYWdlDQo+IHJlcG9ydGluZy4gV2l0aCB0aGF0IHRoZSBob3N0IGNvdWxkIHRoZW4gZ3VhcmFu
dGVlIHRoYXQgaXQgaXNuJ3QgZ29pbmcNCj4gdG8gaHVydCBwZXJmb3JtYW5jZSBieSBzcGxpdHRp
bmcgcGFnZXMgb24gdGhlIGhvc3QgYW5kIHJpc2sgaHVydGluZw0KPiB0aGUgdmlydHVhbGl6YXRp
b24gcGVyZm9ybWFuY2UuDQo+IA0KPiBBbHNvIHlvdSB3b3VsZCBiZW5lZml0IGJ5IGxvb2tpbmcg
aW50byB0aGUgY2FsbGVycyBvZg0KPiBwYWdlX3JlcG9ydGluZ19yZWdpc3RlciBhcyB0aGVyZSBh
cmUgbW9yZSB0aGFuIGp1c3QgdGhlIHZpcnRpbyBiYWxsb29uDQo+IHRoYXQgYXJlIGNvbnN1bWlu
ZyBpdC4gT2RkcyBhcmUgSHlwZXJWIHdvbid0IGNhcmUgYWJvdXQgYW4gQVJNNjQNCj4gYXJjaGl0
ZWN0dXJlLCANCg0KRldJVywgSHlwZXItViAqZG9lcyogY2FyZSBhYm91dCBBUk02NC4gIEl0J3Mg
YWxyZWFkeSBpbiB1c2UgYnkNCnRoZSBXaW5kb3dzIFN1YnN5c3RlbSBmb3IgTGludXggVk0gdGhh
dCdzIHBhcnQgb2YgV2luZG93cyAxMA0Kb24gQVJNNjQgaGFyZHdhcmUuICBXZSdyZSB3b3JraW5n
IHRvIGdldCB0aGUgY29kZSBhY2NlcHRlZA0KdXBzdHJlYW0uDQoNCk1pY2hhZWwNCg0KPiBidXQg
eW91ciBjaGFuZ2Ugd291bGQgZXNzZW50aWFsbHkgZGlzYWJsZSBpdCBvdXRyaWdodA0KPiB3aGlj
aCBpcyB3aHkgSSB0aGluayB0aGlzIG1pZ2h0IGJlIGJldHRlciB0byBhZGRyZXNzIHZpYSB0aGUg
Y29uc3VtZXJzDQo+IG9mIHBhZ2UgcmVwb3J0aW5nIHJhdGhlciB0aGFuIHRyeWluZyB0byBhZGRy
ZXNzIGl0IGluIHBhZ2UgcmVwb3J0aW5nDQo+IGl0c2VsZi4NCj4gDQo+IFRoYW5rcywNCj4gDQo+
IC0gQWxleA0KPiANCj4gT24gU3VuLCBKdW4gMjAsIDIwMjEgYXQgODoxMSBQTSBHYXZpbiBTaGFu
IDxnc2hhbkByZWRoYXQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBwYWdlIHJlcG9ydGluZyB0
aHJlc2hvbGQgaXMgY3VycmVudGx5IGVxdWFsIHRvIEBwYWdlYmxvY2tfb3JkZXIsIHdoaWNoDQo+
ID4gaXMgMTMgYW5kIDUxMk1CIG9uIGFybTY0IHdpdGggNjRLQiBiYXNlIHBhZ2Ugc2l6ZSBzZWxl
Y3RlZC4gVGhlIHBhZ2UNCj4gPiByZXBvcnRpbmcgd29uJ3QgYmUgdHJpZ2dlcmVkIGlmIHRoZSBm
cmVlaW5nIHBhZ2UgY2FuJ3QgY29tZSB1cCB3aXRoIGEgZnJlZQ0KPiA+IGFyZWEgbGlrZSB0aGF0
IGh1Z2UuIFRoZSBjb25kaXRpb24gaXMgaGFyZCB0byBiZSBtZXQsIGVzcGVjaWFsbHkgd2hlbiB0
aGUNCj4gPiBzeXN0ZW0gbWVtb3J5IGJlY29tZXMgZnJhZ21lbnRlZC4NCj4gPg0KPiA+IFRoaXMg
c2VyaWVzIGludGVuZHMgdG8gc29sdmUgdGhlIGlzc3VlIGJ5IGhhdmluZyBwYWdlIHJlcG9ydGlu
ZyB0aHJlc2hvbGQNCj4gPiBhcyA1ICgyTUIpIG9uIGFybTY0IHdpdGggNjRLQiBiYXNlIHBhZ2Ug
c2l6ZS4gVGhlIHBhdGNoZXMgYXJlIG9yZ2FuaXplZCBhczoNCj4gPg0KPiA+ICAgIFBBVENIWzEv
M10gaW50cm9kdWNlcyB2YXJpYWJsZSAoQHBhZ2VfcmVwb3J0aW5nX29yZGVyKSB0byByZXBsYWNl
IG9yaWdpbmFsDQo+ID4gICAgICAgICAgICAgICBtYWNybyAoUEFHRV9SRVBPUlRJTkdfTUlOX09S
REVSKS4gSXQncyBhbHNvIGV4cG9ydGVkIHNvIHRoYXQgaXQNCj4gPiAgICAgICAgICAgICAgIGNh
biBiZSBhZGp1c3RlZCBhdCBydW50aW1lLg0KPiA+ICAgIFBBVENIWzIvM10gcmVuYW1lcyBQQUdF
X1JFUE9SVElOR19NSU5fT1JERVIgd2l0aCBQQUdFX1JFUE9SVElOR19PUkRFUg0KPiBhbmQNCj4g
PiAgICAgICAgICAgICAgIGFsbG93cyBhcmNoaXRlY3R1cmUgdG8gc3BlY2lmeSBpdHMgb3duIHZl
cnNpb24uDQo+ID4gICAgUEFUQ0hbMy8zXSBkZWZpbmVzIFBBR0VfUkVQT1JUSU5HX09SREVSIHRv
IDUsIGNvcnJlc3BvbmRpbmcgdG8gMk1CIGluIHNpemUsDQo+ID4gICAgICAgICAgICAgICBvbiBh
cm02NCB3aGVuIDY0S0IgYmFzZSBwYWdlIHNpemUgaXMgc2VsZWN0ZWQuIEl0J3Mgc3RpbGwgc2Ft
ZQ0KPiA+ICAgICAgICAgICAgICAgYXMgdG8gQHBhZ2VibG9ja19vcmRlciBmb3Igb3RoZXIgYXJj
aGl0ZWN0dXJlcyBhbmQgY2FzZXMuDQo+ID4NCj4gPiBHYXZpbiBTaGFuICgzKToNCj4gPiAgIG1t
L3BhZ2VfcmVwb3J0aW5nOiBBbGxvdyB0byBzZXQgcmVwb3J0aW5nIG9yZGVyDQo+ID4gICBtbS9w
YWdlX3JlcG9ydGluZzogQWxsb3cgYXJjaGl0ZWN0dXJlIHRvIHNlbGVjdCByZXBvcnRpbmcgb3Jk
ZXINCj4gPiAgIGFybTY0OiBtbTogU3BlY2lmeSBzbWFsbGVyIHBhZ2UgcmVwb3J0aW5nIG9yZGVy
DQo+ID4NCj4gPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50
eHQgfCAgNiArKysrKysNCj4gPiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wYWdlLmggICAgICAg
ICAgICAgICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ID4gIG1tL3BhZ2VfcmVwb3J0aW5nLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrKysrLS0NCj4gPiAgbW0vcGFnZV9y
ZXBvcnRpbmcuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMCArKysrKysrLS0tDQo+
ID4gIDQgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IC0tDQo+ID4gMi4yMy4wDQo+ID4NCg==
