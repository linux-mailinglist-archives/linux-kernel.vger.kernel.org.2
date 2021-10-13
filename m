Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED9942B808
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 08:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhJMGzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 02:55:02 -0400
Received: from mail-eopbgr1300122.outbound.protection.outlook.com ([40.107.130.122]:13760
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231638AbhJMGzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:55:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJpNFOjMDXJLyt1pCaIceBYXK/QgEQgVnv0hAUsfRoVK2y5FkZLd8xYcjETbvsgBXd+fzduSEGlYqnxR0bhyNSmpZUouyaQQlJBhIaleg3mw0mjGM09YHACUgcRSh720vdDe4O3dLNP+21SWx45IxCDHLb+oMu+ufYlVaWVb3fBbPR/e8PykiS2B+g1TOhN9Ex8wmRqIGZkZxz9PTsNNXqZWV9tDlW5+FO2Wo2VlURI2bJjFVsZP2GybUoRit2aSRArjr7ns/2hUcNJZT7vFiieDM9OpCnvH6E90/lEb46DhIL0i/WtMbOIgPearKxMmcqaQt5UIsrBt+S9bDl6blQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRx/JNuDfEq7PhLMsMJcbp5GXeGP4bsLmaxJBK0NsTU=;
 b=mhKXUU0YdCjSxjKdIKwJ0hRy/H5BJR8v+6QHbWxLjsvWzGvpmu7ARE0J551Rl5ClPeyIASSyAMT7j3DAp2G4536UKsn+5+yNg+NpXwqh84zMxCeymiLXOXXtPTZ1vxmv5k7zDkQin4t24Ut2AxwQl5tpTFHszXmCd5YjS3yGdHFKW+Svu6bk6wTYqJQJp9CRbPXg/QzrhNH85APMmV+CQFCrHpudY9w0u2ZYVZuPsZHLXRsyCKraZf3bjCAMMwiPHdkSGTJMHEG0t9wt8MAr+0qhhIrz1Nj0hjPxVed7gZPFJ2Pvgw7DC7YS7UDr7hesozi1NiJkTZf8BTrH4TEHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRx/JNuDfEq7PhLMsMJcbp5GXeGP4bsLmaxJBK0NsTU=;
 b=fYke6WypNsOC2gJMjWxCgIOirgAWpP6/vl/d0aHNbWijBC9J1z0r4RBgndfKiNj1aaKUzdKPFe94bfupwD9UDEmvIL0PbULFgycjtjFGcaB5zTsGCXnN03IFw/mPPvdQSsqxhn0DyUnhGYRvVW9jeWOxToiYzvuDJG/fc3FXg/Q=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3164.apcprd06.prod.outlook.com (2603:1096:100:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Wed, 13 Oct
 2021 06:52:54 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 06:52:53 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHVzYjogcmVwbGFjZSBzbnByaW50ZiBpbiBzaG93?=
 =?utf-8?Q?_functions_with_sysfs=5Femit?=
Thread-Topic: [PATCH] usb: replace snprintf in show functions with sysfs_emit
Thread-Index: AQHXv+JPnKXSKI2lR0eaW9uXO5B9G6vQdK2AgAAF7+o=
Date:   Wed, 13 Oct 2021 06:52:53 +0000
Message-ID: <SL2PR06MB3082C1AAF2A11871C10CDA53BDB79@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1634095668-4319-1-git-send-email-wangqing@vivo.com>
 <AA2A8gBxEnrQndzc*evdgarV.9.1634105950804.Hmail.wangqing@vivo.com>
In-Reply-To: <AA2A8gBxEnrQndzc*evdgarV.9.1634105950804.Hmail.wangqing@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 7f57380b-d0e7-6db9-a7c6-158f4e4bd74f
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3e9b4d4-ba78-4c77-004c-08d98e1614c9
x-ms-traffictypediagnostic: SL2PR06MB3164:
x-microsoft-antispam-prvs: <SL2PR06MB316457F419B73CCB275D89E6BDB79@SL2PR06MB3164.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p6i3HMDE/dJwoyxN/WORY1KCK2FEh9ivkkZHvQO08fTvo7dzfuqyTo5Gs9NVN14JsTil9x/E0rGd0ngAJoqvIFbg0DFcbI+8kwecyN/Y+fwYyTqKYmgDNUbC41cYoGQ+pDA+mLb/2KoX2Pxetg/VNLpBvmSuVlovMg+EFHa0ARn6P/GHyVMePJu5IAUdbrIvqlzU8jcEKJtdJFgOeDO2rLk5ngh8kowwMSP02sxVd7g/6l7iqBZPiP//1OA6VgA79/ZGRU+RVltF2B9F0ebAFPC1VrtVmY7S9BfOc0OvI81SmKTOH3Zz+HLzbxAX08/IdwfpwF5Ugb4o/qmWaGz7oT8Ci0jyZdyEpapI2tuSy5GKSiKuHPDSiR4Pt7YhhgOQqHHtpkccfi/XMOGN/bdOYKtUnU3qLhxZ21o9t0Q28ypFu4pfTAnOjo8zMn9WTj1NM4kpQCCGr1quL8sO4x3PTFT1ArKETkNMGWWu59WX7NzuJ/b6TEj/9VmDASeu4P+fGoyAqeiptWJe6pJ3KePXoy0GxdfQxDR+ZfY9xf5UcXG5/z/SBtwC15wrEZrol7XDDta76KEDBIwDRxBLcz1vr47ANsb+iLIWfZK+6WPdeGxvThm/+ZZq8njtGi1SH1ntnACK1uYrHvbzhazMXaMEgyCraQjewVsrn8hDG3H1VTd12M0T1t6Of53dKDB0daz/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(83380400001)(6506007)(54906003)(85182001)(186003)(224303003)(55016002)(71200400001)(26005)(8936002)(38070700005)(6916009)(91956017)(76116006)(66556008)(64756008)(122000001)(5660300002)(38100700002)(33656002)(4326008)(2906002)(86362001)(316002)(66446008)(66476007)(66946007)(52536014)(9686003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWRJL0h1Qm5JcWJHUm4vTzB0U3p4UktwMDlIeVBCWllRTmlNb3dLNHgvZFRz?=
 =?utf-8?B?Vm80SU9QajhpeEQ5YU1MZ0cvNWR5QUpSQk9PRU91RWhqR09Bbkgvb2x6a3Nl?=
 =?utf-8?B?bkZMRWl2VnFySHVOYytnU1poU1VUVnhqKzBIeC9CSnBHOHFITjVtMHhLODhu?=
 =?utf-8?B?cmZVZjJjV09hdnpyMm1UcUZNVWkwc3l3RWozVHZCQm1ZN2NtVHFnYTVQLzZY?=
 =?utf-8?B?NmpYeExVVmZTZUJ4MEM2YVFIMFdLTUZPK3ZRNVA3MENVQjZneUtNZTVrU3Ft?=
 =?utf-8?B?NCtpa1FZUjRoTldMQmw5NXRZazN3WkFSZ2NzNkY4RURTQVN1dFBuTVZ0ZDVn?=
 =?utf-8?B?VEQ5bVFiVWs0ZE5hcWVBMVdMK09LZWJVRVFNK04zcFE5UTgrR2U0eGFXVkVP?=
 =?utf-8?B?aUEwVGl4ZzZSczh2dHhnM29kSFgvMmw2eGtPY2RMZlc2WnFhNDU4ZEtPR2dO?=
 =?utf-8?B?RWNIV3o1bWN3Y1VFb0p3UmU0MHhGM0lOdkZ5eDkxc1ZCS1piUDBGTGlXTU1v?=
 =?utf-8?B?MFFyRWNyS21vTTJpalZjUW44SEppUitlaW1VUTl5T0dSWjVSWFArSllSZ1pC?=
 =?utf-8?B?a3ZIZ3gzSGFDV1dXWGI4QThjbHFvcFJJVkZOOEdxTExTYXk5YnlqMUZmMmo2?=
 =?utf-8?B?SEpRUUJmd1JPN2ZqclR6d2p4NFk5c1BCczY4NVlMUTRsRkd5clNWSmtuNmMr?=
 =?utf-8?B?ZVg2M2RBUmhKbCtBZXZNd1ZKa3B3czhOT3VsL3JkenZPRG5aTkZhOU1KWjJo?=
 =?utf-8?B?VWxTSzczOStvVUU3d3k3RkZtc21uZlhDZWIrZ3RaejFwcjUyY0syaThXMCtD?=
 =?utf-8?B?bHZmV3NMcU9LKy9SZWtQV2hqejFJeU5SbkNmT3kvcDZZYjhKcmQ5R3ZNL0Rt?=
 =?utf-8?B?TitXUFc4QytydXJCZkpYV0pOMTVEMjJxMlh6QlE4aStYNFZPR0xXOFRFNXhW?=
 =?utf-8?B?YjBxSkJjQmVndVdUYWY4Y2pOUStuRXFaZDVqbFNVdFJmckhOb0h4NFdLZU5i?=
 =?utf-8?B?TytLZEh3Y3Z3SWNBZ296b2k2cUQrZmJkajFWZk1TUVQ5UXprNjJZWkpzOFhO?=
 =?utf-8?B?UDFLKzU2N1U2VXBOTGJrQTRSVlhJNEc5bm1TcFFDc0haMXU4NHZyS2RXK2pw?=
 =?utf-8?B?NFBFbFdZZlBuQitzOTVuMmVHanpZSk1mYmtnTUwvNUpvelBScmpMVENWbzZI?=
 =?utf-8?B?Tmhvc212TmFHWWF3YzhOMFhFMk5JRWNHbXhocE5mdTNUZEJpZUljM3dMdUdG?=
 =?utf-8?B?blVZL3JPODAxK2JqM2V6L2hXYkNjZ0RLU3pOS0wydFdEalJjd0dMa0phdnhQ?=
 =?utf-8?B?MTJhS2RmRVNuNm1hZ3RnVnlsNERwdGZUdFdEZUFwU0szb0c1VUozMGE2bkFX?=
 =?utf-8?B?eFRneFJmd2lNZDdQb0hRQ3pYOG5YRWZjSzB1dzgxeU1VQ2N2S3dTSWliVWZk?=
 =?utf-8?B?V3hOdStCR0ovTEl0cGlLcU9ObVNOU2dmdSt0MmFhSzN0RDE4MXRxM3FvYVE4?=
 =?utf-8?B?d09DL2hRRUZtek9HRFNSTlZ6Z0ZhMDlPeHNyd2F2b2d5SVgvdGxkR3MreVZV?=
 =?utf-8?B?ODVtbzZxMzlIMFh3bUlBaFh1T0YxcUVvNWRIcWxta2ZwZHpERWJUZjBzdzJl?=
 =?utf-8?B?bVRBN1NySXljbTdhWkRxaVpuakN4VDNjUFZsaEwvT1k5RzMwS1VhYU5qOE1z?=
 =?utf-8?B?Um9kaEpiNmRsVHJkWEVYR0htSnVMME1idGFMZldiWkJrVk13ckUwc3R2NXNZ?=
 =?utf-8?Q?8esrBelGGTV7JaXwnv1p1aEcAFDOlE4NOJnzjCN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e9b4d4-ba78-4c77-004c-08d98e1614c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 06:52:53.7618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M49IoNF7lw1WGs1eFuYOeFuyg4gYnjF0eBsWZKg+5lYK+QtjCePbbgXtJ+jpHzpsbJhRd1Ov6ZkdQ6+LKbF+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wqAKPj4gT24gVHVlLCBPY3QgMTIsIDIwMjEgYXQgMDg6Mjc6NDdQTSAtMDcwMCwgUWluZyBXYW5n
IHdyb3RlOgo+PiBjb2NjaWNoZWNrIGNvbXBsYWlucyBhYm91dCB0aGUgdXNlIG9mIHNucHJpbnRm
KCkgaW4gc3lzZnMgc2hvdyBmdW5jdGlvbnMuCj4+IAo+PiBGaXggdGhlIGZvbGxvd2luZyBjb2Nj
aWNoZWNrIHdhcm5pbmc6Cj4+IGRyaXZlcnMvdXNiL2NvcmUvc3lzZnMuYzo3MzA6OC0xNjogV0FS
TklORzogdXNlIHNjbnByaW50ZiBvciBzcHJpbnRmLgo+PiBkcml2ZXJzL3VzYi9jb3JlL3N5c2Zz
LmM6OTIxOjgtMTY6IFdBUk5JTkc6IHVzZSBzY25wcmludGYgb3Igc3ByaW50Zi4KPj4gCj4+IFVz
ZSBzeXNmc19lbWl0IGluc3RlYWQgb2Ygc2NucHJpbnRmIG9yIHNwcmludGYgbWFrZXMgbW9yZSBz
ZW5zZS4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFFpbmcgV2FuZyA8d2FuZ3FpbmdAdml2by5jb20+
Cj4+IC0tLQo+PsKgIGRyaXZlcnMvdXNiL2NvcmUvc3lzZnMuYyB8IDQgKystLQo+PsKgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvY29yZS9zeXNmcy5jIGIvZHJpdmVycy91c2IvY29yZS9zeXNmcy5j
Cj4+IGluZGV4IGZhMmU0OWQuLjYzODdjMGQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdXNiL2Nv
cmUvc3lzZnMuYwo+PiArKysgYi9kcml2ZXJzL3VzYi9jb3JlL3N5c2ZzLmMKPj4gQEAgLTcyNyw3
ICs3MjcsNyBAQCBzdGF0aWMgc3NpemVfdCBhdXRob3JpemVkX3Nob3coc3RydWN0IGRldmljZSAq
ZGV2LAo+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQo+PsKg
IHsKPj7CoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdXNiX2RldmljZSAqdXNiX2RldiA9IHRvX3VzYl9k
ZXZpY2UoZGV2KTsKPj4gLcKgwqDCoMKgIHJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwg
IiV1XG4iLCB1c2JfZGV2LT5hdXRob3JpemVkKTsKPj4gK8KgwqDCoMKgIHJldHVybiBzeXNmc19l
bWl0KGJ1ZiwgIiV1XG4iLCB1c2JfZGV2LT5hdXRob3JpemVkKTsKPj7CoCB9Cj4+wqAgCj4+wqAg
LyoKPj4gQEAgLTkxOCw3ICs5MTgsNyBAQCBzdGF0aWMgc3NpemVfdCBhdXRob3JpemVkX2RlZmF1
bHRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+wqDCoMKgwqDCoMKgwqAgc3RydWN0IHVzYl9o
Y2QgKmhjZDsKPj7CoCAKPj7CoMKgwqDCoMKgwqDCoCBoY2QgPSBidXNfdG9faGNkKHVzYl9idXMp
Owo+PiAtwqDCoMKgwqAgcmV0dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJXVcbiIsIGhj
ZC0+ZGV2X3BvbGljeSk7Cj4+ICvCoMKgwqDCoCByZXR1cm4gc3lzZnNfZW1pdChidWYsICIldVxu
IiwgaGNkLT5kZXZfcG9saWN5KTsKPj7CoCB9Cj4+wqAgCj4+wqAgc3RhdGljIHNzaXplX3QgYXV0
aG9yaXplZF9kZWZhdWx0X3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4gLS0gCj4+IDIuNy40
Cj4+IAo+IAo+IElmIHlvdSBhcmUgZ29pbmcgdG8gY2hhbmdlIHRoaXMgZmlsZSwgeW91IHNob3Vs
ZCBkbyB0aGlzIGZvciBhbGwgb2YgdGhlCj4gc3lzZnMgc2hvdyBmdW5jdGlvbnMgaW4gdGhpcyBm
aWxlLCBub3QganVzdCAyIG9mIHRoZW0sIHJpZ2h0P8KgIFBsZWFzZQo+IGNoYW5nZSB0aGlzIHBh
dGNoIHRvIGRvIHRoYXQuCj4KPiB0aGFua3MsCj4gCj4gZ3JlZyBrLWgKCk9ubHkgdGhlc2UgMiBz
bnByaW50ZiBuZWVkIHRvIGJlIG1vZGlmaWVkLCBvdGhlciBzaG93IGZ1bmN0aW9ucwp1c2VkIHNw
cmludGYgZG8gbm90IG5lZWQgdG8gbW9kaWZ5LgoKVGhhbmtzLAoKUWluZw==
