Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CD539F057
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhFHIDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:03:34 -0400
Received: from mail-eopbgr1400041.outbound.protection.outlook.com ([40.107.140.41]:15540
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231192AbhFHIDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:03:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na7mKgotpR4W07GiVqIlcMyKT1eWKHnyYfI7Egx/ImcouHoK4YSVKTEIS8f4aS/CDgi9iGfyDBifYBZDcz42CEocHwjyKA55p7Krg+PZn6jbvwGEKH5023XSqN0Ft8jveY9t70gtVvj//r4YlBYOdOUQX0pD06wmFsHUAqk5qVbN2DGpwtQV0nGhUh3p3buVhnygZ44HpqS6ml/hK7oy6uDBThw0mWmVZaZAAO1GNHXgLtctdDO7vzLfwjVba6YwvWNF3bS+ImVFdza03JzVdiU50Xwp2BE0HcAI1kflYuH4ziCOyzuz5Pr0HLiAG6/+qfF6JNS38tnfFGLz+JHxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqxdxvu7xkObiR8bQx2WOaBduZ4rqvrgois49h/Ofpk=;
 b=fYpveiyUuLCabh4dA1KLKlLT6VAIJNNSlgbxKzwYg4sYWpj3EffkarVo6nJIAew1Jbg69nfPp0m7szE+XgxxA+GvgopVVFWB7aI2RWIfimrQRNOiTMchjz/XraerqPIjTct7U/C4sH2t/rfZ7wSTmSKjtKxBekng7o9GvqMmRAmLRSGATXigP8G7atPXrfCu6uyViQbhb0f3DG7bAyLbEAmc25wTz/oIdzuVufFd/g1ucQFpOA56cIrjGsd4YPKzAYysehVg5t6l1lrSc0VKhJrS7ihDQj4ld8x6PlY+nImWQvHq950xh4+B64LHjzG1SvzYeoICsksqBVAaf1EFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqxdxvu7xkObiR8bQx2WOaBduZ4rqvrgois49h/Ofpk=;
 b=Wm+4WT6xEdVUgDPoL2pFVYiYFwwKhWmpZD8D5Hf6hfFmFZi7sEKOwT+ufY8vZIxgVdenXs6tp51qrGtoERloqz6vbkPysHACGW3/hOGIZciWuGf6k2mfeQ0khCUv8vMziIVrDHaneV17Rf6Fxvv5YulhiEzZse4WPh/S4ACcHxY=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYBPR01MB5342.jpnprd01.prod.outlook.com (2603:1096:404:802e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 08:01:12 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 08:01:12 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     wangbin <wangbin224@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wuxu.wu@huawei.com" <wuxu.wu@huawei.com>
Subject: Re: [PATCH] mm: hugetlbfs: add hwcrp_hugepages to record memory
 failure on hugetlbfs
Thread-Topic: [PATCH] mm: hugetlbfs: add hwcrp_hugepages to record memory
 failure on hugetlbfs
Thread-Index: AQHXXDxy7t5aqp8X6kC1NTTFfcsDJw==
Date:   Tue, 8 Jun 2021 08:01:12 +0000
Message-ID: <20210608080112.GA942548@hori.linux.bs1.fc.nec.co.jp>
References: <20210607141623.1971-1-wangbin224@huawei.com>
 <b4a6c7ee-5b0c-2390-35c5-3a5255d77f5d@oracle.com>
In-Reply-To: <b4a6c7ee-5b0c-2390-35c5-3a5255d77f5d@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36f45bae-197c-4829-7e24-08d92a539577
x-ms-traffictypediagnostic: TYBPR01MB5342:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB5342260E861524FD3C3F7C8BE7379@TYBPR01MB5342.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B0KZTX2tE4a0f8TvOn2cgEcWpzaDCqHVlgH5ceEoJ+B7GCN563dpP6tok0cmgKGrcKfiY3hVe4tYO5Q/nrQRZho2SPaLMhUn2bIwa15AKPFjL4muf+0QW6DdiBmeUvkG0bl3TKCLIIeRYFKIE3VOkxbBJUyIt2mxRkxbhIQ57KiQ7MbGgfPR6DukXM76Rxa5xhciX0A7KSJ3pUzycIWCab8n6Qf8n+7CwhpRsFV7DwMvaXx3kGlyFwxgp+nBp24MdBYp6THkYHCRWZGwdMh7epf6v/DF1hWLvIDF7VHRtOfbgFaW1LD7EUTQ/nKRNQScxRDXMRhjOYAGvArhZib2Pe8R8Dz+6YwpVipOF6DfubBkTD1iC3Vl9U9FungxqpgYzz/V8m0Er62MWaEslxrQPhNDUU1qe4B/kUA+ioFka9KwdSYQXFVXXcaRhgqQMcJJULuCGZpaYHVBkUXsqSBqRgVbvTTz6fZANi+618gJllRrG4C31nS3uPc/DIReDaFT/S2CJxonD2QJ26aFumaadHpcCKw9vXpxn5ii5YsCkwgkOj1GgoMRnzf59vYfvdt/3zFGhcz84SfUS7saceoLep6qM0joUNxu7dNdcFkob3M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(66446008)(66556008)(64756008)(66946007)(66476007)(8676002)(71200400001)(54906003)(33656002)(26005)(53546011)(1076003)(5660300002)(6506007)(86362001)(83380400001)(110136005)(8936002)(55236004)(6486002)(186003)(316002)(122000001)(4326008)(6512007)(9686003)(478600001)(76116006)(2906002)(38100700002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NUsyYlAwZGkrZ1RYTEJocjZNSWpvNFBNQlN1Rmc2aVk4MWwxRFA1MFMyd0FO?=
 =?utf-8?B?L1JIYkdUUDVZbWUzajM3S3RBTXQxanZha0dxN2c2SnNJb0pDWG9JMXRnZXBy?=
 =?utf-8?B?NVp3b1VydGo0WUhTN3cvS0IvSVlJMXo0WGRKZEVXVGtzd0x2QWtWRzZ6amJy?=
 =?utf-8?B?YUNlR3UzKzJucE1xUndUODdaa3NQTC9xZXNjeXd5Z0R1Wi9pSjZyWEVqQUdh?=
 =?utf-8?B?RjNsaHlJV0tEdVh4SEwxc1l3RlRoRlpaRkZpZEptSXZRMUNyVmg2eWg3M2xT?=
 =?utf-8?B?YUl6Wkdac05iRS9jN3hXeGJUUFYvUmZoRTlxaE1sVHdpYS9CVWdIc3U0bW8z?=
 =?utf-8?B?UmhEQ3J4RkllTStVTmNKVmltdVBHUTlhQTJMSUhUU1M5bXRPOUxuZEs1dUNk?=
 =?utf-8?B?UUNRcmJsZ1pMZ3ZWR01peWY5UjFDcXhrWk13d2wxUVh5MHg3SkR6T2Y0c0lq?=
 =?utf-8?B?MTUwd0NlZDFVWkxGd08xWElaeW5VcXJNL3NwaHdqZXNyOSswbHNKRk5jVVAv?=
 =?utf-8?B?VjcvRnNCNjlJK1MwNHZzQlNmRlNwUGtnM05lQlhSNWlrQVVrekR5Z2hTU3Bv?=
 =?utf-8?B?SlRKTG5lVDdXVWYwQkdMSExZWlZmWWJ1d29NcE1FNVpNb1F0Z1BtaGQxU2xl?=
 =?utf-8?B?NVA2dVJ6VE04TWZIVFlBRlNLTWxBNzh1Vm52UnpNZlJMV21TaGhLTmpJdUo0?=
 =?utf-8?B?TmN1Qy8vUW5DVVJEU0wvd3JqdXEwOTJoTEZvbXJEOVFLUTRkY2t5Rzk5c3Va?=
 =?utf-8?B?MW9UQUFpYUIvUmVoTFNBQWNPem1EQjJFNVZ6eHVxQVk5SzRaMnM1akpjaXVs?=
 =?utf-8?B?RGczdnJhdExjOG9YSXRvYUhDM3JMNGV1WkdlRkhpQUhibDRBbkdSU3gzYlJL?=
 =?utf-8?B?WUQ4YUgzZmNkRVE5aGNjbjlIREhCRDlENTh6MndoNDVGQ3lJU09oRUxYSCta?=
 =?utf-8?B?ODlsQkRCdVE5OWlxWkV6ellHbUt1Q2lxQnNGWmJXeHBpTjN4eGY3citYWjh3?=
 =?utf-8?B?U2NZRml3dld0WjZBV09qclQzQmpEbmlVYzF4cVVuU0JLOVl2ODlobzZvaXU2?=
 =?utf-8?B?WFp4UUtIRm5WcmxtcXNWWEZ6ZWtQdkg3VDJ2REZDZjd4ellDcVBTWVB4b1E1?=
 =?utf-8?B?WlFRSHZBN3FDZE5BdWhUcnZIRmo5V2h5cE5IZEZuQ3lJNmFXbmdiNk5lMmJa?=
 =?utf-8?B?bXJkSThxaDJONGZTZ0E5MzNkQUZ4eTQ5SjFURS9mcDlUa3hzNXFYM1Y2WnEx?=
 =?utf-8?B?czlpOXpwYUhYSjN6SGM3VkNNZFF0SEx0N1ZSQ1RjOHZIMm1nODRQcXRGdEY3?=
 =?utf-8?B?QW9WYUN3ZnFzRjNMa1F3WCthWk1HSUcvYzRvc0NoNDdseFIzdXNYV1ZxZ3R6?=
 =?utf-8?B?REVOVCsvc2lCNkN6UzJaWHlmYUcrZnVDSUo4M1Q5bVZZVzl4RG0xZk5VMUZi?=
 =?utf-8?B?SGxjQTBrY3RPbjhVQVhjbklXTkRjZnRGZHh3elllSWt2NUFjQ0ttRnhtT3cz?=
 =?utf-8?B?Rkk1UVNLYlByQW1RWW92NStOeTNEQTNNN3pXOExLTzR2N0hKNEdrSFZYWjM5?=
 =?utf-8?B?SWJTMnJqTWFEZUFwLzU1OU40Snh5SnFBT3o1Qlp1V0RZeVNOdzhzaDN3cWN1?=
 =?utf-8?B?WjZjVVk4K2hnd2VzTEtrSTJBdjVQSXBoazMwR0VCQUc5ZURFWVJCRmQ3WWdT?=
 =?utf-8?B?S1VDWXZnWFEzaG9ZZUUrYzhJanlGV2lHMzhad3hsUGxPRDJXN3RWV3Ixd3FC?=
 =?utf-8?Q?po1GwHF0JxQpcVAjAglNK9mgTsqowQj+tuSudPw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EC1E13375BED449A5B1CA8893C887DB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f45bae-197c-4829-7e24-08d92a539577
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 08:01:12.7340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3lx+nFka9CC++QAqkS5HbPFNQEkMEEb38aGx2O+fmm0ztrRY+6jN7wMV4pvNWdKabxxEyG1f4IVVX5+sIEORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBmb3J3YXJkaW5nIHRoZSBtZXNzYWdlLCBNaWtlLg0KDQpPbiBNb24sIEp1biAw
NywgMjAyMSBhdCAxMjoxMzowM1BNIC0wNzAwLCBNaWtlIEtyYXZldHogd3JvdGU6DQo+IFJlc2Vu
ZCB3aXRoIG5ldyBlLW1haWwgZm9yIE5hb3lhDQo+IA0KPiBPbiA2LzcvMjEgNzoxNiBBTSwgd2Fu
Z2JpbiB3cm90ZToNCj4gPiBGcm9tOiBCaW4gV2FuZyA8d2FuZ2JpbjIyNEBodWF3ZWkuY29tPg0K
PiA+IA0KPiA+IEluIHRoZSBjdXJyZW50IGh1Z2V0bGJmcyBtZW1vcnkgZmFpbHVyZSBoYW5kbGVy
LCByZXNlcnZlZCBodWdlIHBhZ2UNCj4gPiBjb3VudHMgYXJlIHVzZWQgdG8gcmVjb3JkIHRoZSBu
dW1iZXIgb2YgaHVnZSBwYWdlcyB3aXRoIGh3cG9zaW9uLg0KPiANCj4gSSBkbyBub3QgYmVsaWV2
ZSB0aGlzIGlzIGFuIGFjY3VyYXRlIHN0YXRlbWVudC4gIE5hb3lhIGlzIHRoZSBtZW1vcnkNCj4g
ZXJyb3IgZXhwZXJ0IGFuZCBtYXkgZGlzYWdyZWUsIGJ1dCBJIGRvIG5vdCBzZWUgYW55d2hlcmUg
d2hlcmUgcmVzZXJ2ZQ0KPiBjb3VudHMgYXJlIGJlaW5nIHVzZWQgdG8gdHJhY2sgaHVnZSBwYWdl
cyB3aXRoIG1lbW9yeSBlcnJvcnMuDQoNCkFuZCBNaWtlIGlzIHJpZ2h0LCBodWdldGxiJ3MgcmVz
ZXJ2YXRpb24gY291bnQgaXMgbm90IGxpbmtlZA0KdG8gYWNjb3VudGluZyBvZiBod3BvaXNvbmVk
IHBhZ2VzLg0KDQo+IA0KPiBJSVVDLCB0aGUgcm91dGluZSBodWdldGxiZnNfZXJyb3JfcmVtb3Zl
X3BhZ2UgaXMgY2FsbGVkIGFmdGVyDQo+IHVubWFwcGluZyB0aGUgcGFnZSBmcm9tIGFsbCB1c2Vy
IG1hcHBpbmdzLiAgVGhlIHJvdXRpbmUgd2lsbCBzaW1wbHksDQo+IHJlbW92ZSB0aGUgcGFnZSBm
cm9tIHRoZSBjYWNoZS4gIFRoaXMgZWZmZWN0aXZlbHkgcmVtb3ZlcyB0aGUgcGFnZQ0KPiBmcm9t
IHRoZSBmaWxlIGFzIGh1Z2V0bGJmcyBpcyBhIG1lbW9yeSBvbmx5IGZpbGVzeXN0ZW0uICBUaGUg
c3Vic2VxdWVudA0KPiBjYWxsIHRvIGh1Z2V0bGJfdW5yZXNlcnZlX3BhZ2VzIGNsZWFucyB1cCBh
bnkgcmVzZXJ2ZSBtYXAgZW50cmllcw0KPiBhc3NvY2lhdGVkIHdpdGggdGhlIHBhZ2UgYW5kIGFk
anVzdHMgdGhlIHJlc2VydmUgY291bnQgaWYgbmVjZXNzYXJ5Lg0KPiBUaGUgcmVzZXJ2ZSBjb3Vu
dCBhZGp1c3RtZW50IGlzIGJhc2VkIG9uIHJlbW92aW5nIHRoZSBwYWdlIGZyb20gdGhlDQo+IGZp
bGUsIHJhdGhlciB0aGFuIHRoZSBtZW1vcnkgZXJyb3IuICBUaGUgc2FtZSBhZGp1c3RtZW50IHdv
dWxkIGJlIG1hZGUNCj4gaWYgdGhlIHBhZ2Ugd2FzIGhvbGUgcHVuY2hlZCBmcm9tIHRoZSBmaWxl
Lg0KDQpUaGlzIGxvZ2ljIHRvdGFsbHkgbWFrZXMgc2Vuc2UgdG8gbWUuDQoNClVubWFwcGluZyBk
b25lIGluIG1lbW9yeV9mYWlsdXJlKCkgbWlnaHQgaW5jcmVtZW50IHRoZSByZXNlcnZlIGNvdW50
LA0KYnV0IHRoYXQncyB0aGUgY2FuY2VsIG9mIHRoZSBjb25zdW1lZCByZXNlcnZhdGlvbiBieSB1
bm1hcHBpbmcuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlnY3VoaQ==
