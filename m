Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BF4366347
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 03:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhDUBEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 21:04:49 -0400
Received: from mail-eopbgr1410080.outbound.protection.outlook.com ([40.107.141.80]:11845
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234538AbhDUBEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 21:04:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr69o/kawpv8okvC6VJndLEwJfRUjx18NnPAN9jBQRPT7C00w7YA5yhrk+9ZL/g8uvUAgPhBdk6Sa0VvsbnyQSvRoP7gWSE1dPWtpt0xEGCtFiB3l+9CPH/83W5gTKn2xlQPl7eq8l8UmemofI4ZP+gMhxGIgdYy+ZdsYwO0/P3plPGLIklSsS9fcU0P4jtw8LMxmwL/lyWsrHfUbTMrPcUU1EYgzh2lLmQDBqahmXq2tVkYnxdXgATZ7+xlWkD3Vd1xPJm1Q9+6ATjIKV+CC0dtCTGrosVZRBLTa1GBAa5gx/BPJCTAd7y/Q0cgG0Nyv5lSEHZj7kHT6HtOjQPlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31WDLrC6wW+fcq931qh4XMQaHQQN4gkvpkGoNQFe1B0=;
 b=FWsG8LgH0jKbDWRW25RjwLxXOSaFl3HslSl433Tf5mNQRY4zHN81iT9Je5dsMFL9eKG92XJSPzpOFVG4hE94yxe6jRiAmwpM/Guss80+YF77tCMTHqAxlftrUlrCDSvbfVNG5tr2FiddXtYa5AQGx9tlpRvtU3IvZD4P4JoekukIn7ag6GiN5diPZuSuMIm1HF7oQmkMciyssZWmn32UmBfjFxn3trgOIHKRs/xdv28+QgFPWy6MUJrEyl7VdSTayepNoOJbXR40P2r+JPxzRdaeNyXS8TDh2j8vpJQrAZuVboEF1ib1YDXm0rjyunEPSifJ5hDlzbhtokugVv4SVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31WDLrC6wW+fcq931qh4XMQaHQQN4gkvpkGoNQFe1B0=;
 b=XOD9ldtPgMxUyFkLR4/3v/ZzY39beZ+jhYhiblYdJ75AmYb35ELyYSHHPaEfSgNXUcaUHtWmdECt8XyMSRw9S6HiRr431F5Jn5yTK8idxat8IeF6bVXzaLn2xJPwHjh0iS7fi1OGE8DwKEAocbFcj3sN7yeLmXx2kGu6Fx578kc=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYXPR01MB1599.jpnprd01.prod.outlook.com (2603:1096:403:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 01:04:14 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 01:04:14 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Jue Wang <juew@google.com>,
        "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "david@redhat.com" <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "yaoaili@kingsoft.com" <yaoaili@kingsoft.com>
Subject: Re: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Topic: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Index: AQHXNYdoX4FIkyH7hUy4oJlfZBfW8aq9jJeAgACc1wA=
Date:   Wed, 21 Apr 2021 01:04:14 +0000
Message-ID: <20210421010414.GA25579@hori.linux.bs1.fc.nec.co.jp>
References: <CAPcxDJ6OAd=qdfxoTQ4cp5vQ6_+phWqX8gJfec48XyAZybBpsw@mail.gmail.com>
 <20210420154253.GA577572@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210420154253.GA577572@agluck-desk2.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb22e8d8-323a-49d3-deb2-08d9046161ac
x-ms-traffictypediagnostic: TYXPR01MB1599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYXPR01MB159963F7739EB19B5D92515EE7479@TYXPR01MB1599.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQaVWkZKmW0xDJpX3Y03oNYVte97bVys41urABgZps9Nb0/r5Lky1YpGY7DL7otcZrgXVGCvKHcX1k62up25XB1sGKyMiD0VmOPydOVmwNktJaG3WlLJzQWSWkEeacd8PQMpD44/t4PGpq7FxxVkfq8u0nLY4at8Z/SfEybnTVwAPxeS/MLt6Bac9g5zq9mF4ArVnOAzO/bThM0BWWz27Mr/vWwMQcl3K2Lqls6M7s8S4uQWDmMwuxvqb6L1d8a+0n9/swbsTEs7OskfsLaQMUqXOiz6IIMMW4P+jlZNzvsTXNtkd41RV7vDslfJIFGM0sMSFZ9AlIO6AmlaG4yC131EHqvz508VIsiWBL49G7mI9ryYGEPq4Ad6pcG48mN07hNyCPVyhgLK4P2A+5V95pNxBJvgGUGn+Fs3T8I39Alv5jon3NaDJkx1lQICZXBCXtmU6u80JDC7scmQbdMVx1EGMJKUVNV5BSSln3IB+lILNbgqd2eyZRS/+ry8s9I1QbhdyCdiuGJnbwhFoyNKlYdgLpqqLLrzBRQOqjN1RffwS6rqiHi026F629OJIBRyQzzNIodno+L3mW2GaA9nf6Ibv+KvQA1EWX67wrh/UHvixKTZFlnQVyjGm1NREvpaiy58TwtGyxlXBEqQjCNJdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(1076003)(7416002)(71200400001)(8676002)(86362001)(64756008)(38100700002)(6916009)(83380400001)(85182001)(2906002)(316002)(66556008)(26005)(33656002)(122000001)(6486002)(8936002)(6506007)(5660300002)(478600001)(66476007)(54906003)(66946007)(66446008)(55236004)(4326008)(9686003)(76116006)(6512007)(186003)(37363001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y0hxbFl5azZ2TGEyMjRzWnhiRkJyMCtHZjVFdFBWVVlKZUh0N0JCNHFVK1U1?=
 =?utf-8?B?Q2FsLzR5TkRhdWpQWTFUdFFuZE12N1BacEJwTzFVVitYdWsvWUdWb0kyRzJQ?=
 =?utf-8?B?QWpyaG5uU25tOGd3c0kyaVYxSDF2dFBaWEJUbGE2YnRFakdlVUh2ckxGbmNv?=
 =?utf-8?B?SHc5YUtDTzR5SGtvWXJMTkpmcnZLSCtXZW9GZE9jY0VnOGQxSHFObG9wWmRR?=
 =?utf-8?B?bVpzSGZhdDZOWnI4T0hCTWNNMG4zaGFRRjRtWFNJdC8rSm1SYmdoWE42b0FI?=
 =?utf-8?B?aDdNUWxiRmlVSUF6bHpIRUtMU3hVV0M4ODBRd0dMY2VSREhXa200VGUwbkxu?=
 =?utf-8?B?amxNQ1VFZDI0dERRcjVjS0JHdlI4RmVTQTRHSDRIY2tobFFLWXlIQjUyZnFz?=
 =?utf-8?B?a2FNdjEwRDVsZWxGS2F2aVRKTGUrdUNWR1JtVy9sd1M3NEd4bXRaWU1QQWM5?=
 =?utf-8?B?TFJJRldIVzA0b1Niei9tanYvZ2RHT0ZTVWVXOHRHb1N0SHJCWllqWmw2THRP?=
 =?utf-8?B?U3NRaGkvL2JOdFN0Wk1wWkNZbTJkc0dhUDRLYjhDbUVFeGhCaFV5cFc4N2ly?=
 =?utf-8?B?eWk4S2VWbndKZ1NpRVBROUsxdDU4bGZIVVVyU0FYUVN5ZzdWWWhLVmhRY1pF?=
 =?utf-8?B?VmpHYi9TWUNnczhRRkpIdC9IYXIxVE05eTFqYTJVMksyamZ4MTFrVFZEOG1j?=
 =?utf-8?B?SFRwK3I2MHV1MEZLK1J5a3BOMG52UTRJZHo2YnJCVVEvaWJSeWswZFJMelFQ?=
 =?utf-8?B?N2U1TWtka082WGpRejVnL0p6eGFHWldNOHJacVlPeUtEQ3RvSytDenkrR1U5?=
 =?utf-8?B?U05uQUdEd3hmMXhqT2tObE1GVW8vRVRwblV2VlMrQkJIVkRPZHVrRXJtOXdF?=
 =?utf-8?B?L0pMSll3WjcwSENkSUQ3dUNpQzhSOGs2bEZ5N2h1S2ZXUFpoT0lCY1FVQU5Z?=
 =?utf-8?B?U2NNVmo0dVd1dnBodGx6cVRkUngvc0wrdnc3eE5lZ1VON2lSZ092Ky9SbzVo?=
 =?utf-8?B?VG0yaUJvZ2Z0Zjg2emM2R0Z3OGhQSUJOekM2YnZpV0FrK1JHZk9FQWE3aSta?=
 =?utf-8?B?aWZYMndGUEJCOWJwVGJ4aFpoWmV1aGNxL0pWR0QrVDRRSkhqM3FNTThBSXMw?=
 =?utf-8?B?VisxbVJjSG9yZk1oSDk2bWt4TDRpTC9GZFlrcE5NdTU1a2NyK2VRS3VBd1Jx?=
 =?utf-8?B?U2hLTjcvMG5NV2lLUmVuY2ZtZnlWTjhyQzdlU1NGUHdYM1g0M2ZSUHMzMnp2?=
 =?utf-8?B?OXRwZG5SRHJuOGFJUDFCeHNlbGx6djJlTzk4UVVrS0diZnVRWTlsc2crWWl0?=
 =?utf-8?B?eU9ZQ1VoazViYlRwdHd1MlB1b3AxRlg5RVNrVytibDNqQmk3T2V5cXpqOGNz?=
 =?utf-8?B?NE1YU0ZtUnNXVmQzaXc2MEJmZWJGS3BlYzQ0TFdtMk1zZzFGYjNsSDdKRkk1?=
 =?utf-8?B?Zm90SDlyMWtTTjhubHRTeVEzTm1iV2srNFQ0ZWQyS0Zkczl6ZjFrbzRianA1?=
 =?utf-8?B?UzFCZ3lVMFR3blNKSHhYVWNDM2l0UThTODVJRXV1YzJWRTBMZExWdzlsYjY1?=
 =?utf-8?B?eVJNOC9LenE2cnhBcmUwUTNCT1MrQTM2a3NwVlVkdFdKckYxMG5DV0tIUlM0?=
 =?utf-8?B?ZFZCREdpSXRSSWoxSWUxS2xnUDlnTDRja0tPZXZaaEtlRmZ2MVJ3OGdJK2hG?=
 =?utf-8?B?MnBLcDlWQUNNSUhqNUR4OEdZamVrbEZqNGFBZkthTXVhVkxlWU5wZEg1N3ds?=
 =?utf-8?B?enNtbE4zcyt5dEl3UmFZRVAxWllJVGpxalYyUVI3V2pvZWRMQWtCMGc1bkN5?=
 =?utf-8?B?RW15azY1cm9PRXJjN2Zzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC1720FD58F5674497BFA7C550D28F9E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb22e8d8-323a-49d3-deb2-08d9046161ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 01:04:14.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vKOB4qHOSlTe+2Ysl9C6mEVXxFQTnk9Uofx7SFEZ2Pk8FSz9NUlYjof9EO66kd14fJZ1f2u930rWdckUVQVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1599
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMjAsIDIwMjEgYXQgMDg6NDI6NTNBTSAtMDcwMCwgTHVjaywgVG9ueSB3cm90
ZToNCj4gT24gTW9uLCBBcHIgMTksIDIwMjEgYXQgMDY6NDk6MTVQTSAtMDcwMCwgSnVlIFdhbmcg
d3JvdGU6DQo+ID4gT24gVHVlLCAxMyBBcHIgMjAyMSAwNzo0MzoyMCArMDkwMCwgTmFveWEgSG9y
aWd1Y2hpIHdyb3RlOg0KPiA+IC4uLg0KPiA+ID4gKyAqIFRoaXMgZnVuY3Rpb24gaXMgaW50ZW5k
ZWQgdG8gaGFuZGxlICJBY3Rpb24gUmVxdWlyZWQiIE1DRXMgb24gYWxyZWFkeQ0KPiA+ID4gKyAq
IGhhcmR3YXJlIHBvaXNvbmVkIHBhZ2VzLiBUaGV5IGNvdWxkIGhhcHBlbiwgZm9yIGV4YW1wbGUs
IHdoZW4NCj4gPiA+ICsgKiBtZW1vcnlfZmFpbHVyZSgpIGZhaWxlZCB0byB1bm1hcCB0aGUgZXJy
b3IgcGFnZSBhdCB0aGUgZmlyc3QgY2FsbCwgb3INCj4gPiA+ICsgKiB3aGVuIG11bHRpcGxlIEFj
dGlvbiBPcHRpb25hbCBNQ0UgZXZlbnRzIHJhY2VzIG9uIGRpZmZlcmVudCBDUFVzIHdpdGgNCj4g
PiA+ICsgKiBMb2NhbCBNQ0UgZW5hYmxlZC4NCj4gPiANCj4gPiArVG9ueSBMdWNrDQo+ID4gDQo+
ID4gSGV5IFRvbnksIEkgdGhvdWdodCBTUkFPIE1DRXMgYXJlIGJyb2FkY2FzdGVkIHRvIGFsbCBj
b3JlcyBpbiB0aGUgc3lzdGVtDQo+ID4gYXMgdGhleSBjb21lIHdpdGhvdXQgYW4gZXhlY3V0aW9u
IGNvbnRleHQsIGlzIGl0IGNvcnJlY3Q/DQo+ID4gDQo+ID4gSWYgWWVzLCBOYW95YSwgSSB0aGlu
ayB3ZSBtaWdodCB3YW50IHRvIHJlbW92ZSB0aGUgY29tbWVudHMgYWJvdXQgdGhlDQo+ID4gIm11
bHRpcGxlIEFjdGlvbiBPcHRpb25hbCBNQ0UgcmFjaW5nIiBwYXJ0Lg0KPiANCj4gSnVlLA0KPiAN
Cj4gQ29ycmVjdC4gU1JBTyBtYWNoaW5lIGNoZWNrcyBhcmUgYnJvYWRjYXN0LiAgQnV0IHJhdGhl
ciB0aGFuIHJlbW92ZSB0aGUNCj4gc2Vjb25kIHBhcnQsIGp1c3QgcmVwbGFjZSB3aXRoICJtdWx0
aXBsZSBsb2NhbCBtYWNoaW5lIGNoZWNrcyBvbiBkaWZmZXJlbnQNCj4gQ1BVcyIuDQoNClRoaXMg
bG9va3MgbW9yZSBwcmVjaXNlLCBzbyBJIHJlcGxhY2VkIGFzIHN1Y2ggaW4gdjMuDQoNClRoYW5r
cywNCk5hb3lhIEhvcmlndWNoaQ==
