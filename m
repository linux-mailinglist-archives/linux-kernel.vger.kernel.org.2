Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C4397837
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhFAQlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:41:40 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:42849
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhFAQlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:41:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Po5ER2DrfCLH0Nw79/eKVK+aYX/E/InhMpXFmiVGLgUm8u8pDzTgeiONvIf0k79oQc54IGfXnCt6VhX8OLDzgPhPE5/jSn6z3b/7lTGAWP/i4kF3jMAp9f3KZqheIXDK9lXnC3A6loq4e659aHar/KNga6H+Z3A1oZM4KdukUk9BO2tf042qzMkG6gevemBBUogPh/zc1Z38ZQwpp4KaWFcjSrPk74IgB8IfmO+yWzeT7K12vLbkVGTYS7AzrjBeEvzpaMxwabfpTnwWDMOrZUADWQ/9hnzt4xYrOqXQZUasLMGKoz0vFZ5lDbe/LzFYseBFWAPUfJlObgCPGcN3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJB0J7dFueuL2cPFnLjhiJ3Yslpyd7d5zj9OqLSso6M=;
 b=jIA3tzIxJ91GqRIL12SySLzvnhAdfCp7nfEkstJmI7rzZXPAJ0Yb0sKgtoZp5XXxWP75rV2slABWdt/pJLSZCWBUNqnBSLUhiqR7vLk9vxcSjtk5mLnQiHvCAPRKQy/kz4kGMvU28vBWEhublA4Uez+sicrEn1NkponYTqHN7+zdvM1j3ETJpxSZeZR4rMMXuTlrMXYmrj85+SCubcilRQS11vV2w+fpJJpljUEaNo47Dhbjei6xc3Kl+0M9er/YExff2nQCtSc8jScqmkZGZcOsGGl9OspaxSWEOvLI2VA3hcmacdJhyyBl7/p9QAHsP7jH3S9ckEGBYcY20B93gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJB0J7dFueuL2cPFnLjhiJ3Yslpyd7d5zj9OqLSso6M=;
 b=xeS91eOO1QWy6KBaUyGSNTtZTd1Ar5ntuAcqEPaIXVcyD99vvZa5X83y78uCLuSPV11YkYHJu7ar+z1mpoBqjdIKY5boelsLlA8EBYBZ1hzK9LXHc9XB5bSF1RVjRCF49SkK+WRweYZDfmyRud1pjrh5nHEkTgHiywifHZQru/4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB4645.namprd05.prod.outlook.com (2603:10b6:a03:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.12; Tue, 1 Jun
 2021 16:39:54 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd%3]) with mapi id 15.20.4195.018; Tue, 1 Jun 2021
 16:39:54 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] iommu/amd: Do not sync on page size changes
Thread-Topic: [PATCH 3/4] iommu/amd: Do not sync on page size changes
Thread-Index: AQHXVv8h/VT5hYiBaUmB/VN59+xv0ar/W4EA
Date:   Tue, 1 Jun 2021 16:39:54 +0000
Message-ID: <F5D25BE7-FA34-4017-AA22-DDAB24F634BC@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
 <20210502070001.1559127-5-namit@vmware.com>
 <f00bd0ce-e4a7-93c6-39ae-db19779b9331@arm.com>
In-Reply-To: <f00bd0ce-e4a7-93c6-39ae-db19779b9331@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab34be68-26fb-4638-6112-08d9251be2cb
x-ms-traffictypediagnostic: BYAPR05MB4645:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB464587D09B8F8F956DD45EDDD03E9@BYAPR05MB4645.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4+X3DFurn7r0GBWyPSp7g6//uEwoZpvaLUJ0COpyDp8sZkXH+42kvP/FKlJTjBJdHNQzKwLrpVS/ESjcV94LHYTa6llZjhx65TAok7hDfSd1m/aYimXV9xoAEWE3JE8JyFvTRTNk9GtkzPPpG3mNn7KpTqtABdIa09d9QMnWMnr9FLqXJBGbBmMe2fEfI7jLrePndfoiG3FfPjCRNqzMKYLQPXT0vB1jJuI5Xfwxul4qnPhweDyjU71jXsbF65ZaGWIPXpD1/QjbM8lf49uNUP7VMbELyC1j7Co0NRp4riXaAa00w9yNZivJsE/r8HbrXYlz2JrNjkx2NV/kJXGE2BjdJ9CLRJVxCtMSWf3uB6HI3F7FBxJ5H9L0y7Ilees1PE9m0YJPsmh/nirI+1s70aFo/ZSluouoSnDbTCfgK2Ey4viAsEvlVlOJIHpDRhqwiLHzbvQw3L5DDH08+lZIsZGBuPmWBbp0dvxKCSnm0YyyC+DDjqDRD2FsuBWF7v012OTwnr+OsDyyHo/7a0J+NW+VCXs/yQDylT7/ofQe9EHhubMKLbTVGFut8PKvZ+2uDr3CG0bDRD5EJZHB2o4bVEQK/+Dx6mf39mmTrY9pTxlg+1R/OU41+PCvLF1faJr2MfsFU3TiH+bLIuxkhZ4obpHIteoduZfvGjvcx207dw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(8676002)(6916009)(316002)(54906003)(86362001)(64756008)(53546011)(76116006)(6506007)(71200400001)(2906002)(66946007)(66556008)(66476007)(6486002)(38100700002)(122000001)(2616005)(66446008)(186003)(6512007)(478600001)(8936002)(26005)(4326008)(36756003)(33656002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UkNYTjNkM3RBVWhFN3FXM3N6VzFpM3NtSmp3Y05UMlIyYmpObHF3MXNMUFM1?=
 =?utf-8?B?N1I5L2NkVGNnNFFVRDBsc3MwMzcwNzdlQWlSMFZnZWRWaDFmcHBCem9RdlVP?=
 =?utf-8?B?Z01TUVlXVlozY1NEMkhmb1MwakxHK1IrdVd4STdLU2ROQmdqK203MXBPZXJz?=
 =?utf-8?B?T1pNZWlLR2pQWG5uZXBnQ3JUcndUbWdGcFpUZnhvQ1MwM01ESzFlY3JiOEVK?=
 =?utf-8?B?RnB1djFtU0R3WnpZRjEvMjZpSFpYWGVqNHNkb1JPdGJRTzIxbFVMeFl2MmJP?=
 =?utf-8?B?cEFYVmhuOXZISVpxQU1Lemo2V0pzNC9LNlYzU01Pd3U2aEEvNVFzVWpSbGYv?=
 =?utf-8?B?R2VFdHdnbzdqcFFvNG1CcEh0M0ZwVG1tMElvZVFoajV6YkVrYWhpdk5kbVQ3?=
 =?utf-8?B?NmwzVyt4U3E2WGYzMjNNS3M0dFp4K3ZlbkFDUEdYQ3BDdXlxd0lWdUtoS2FZ?=
 =?utf-8?B?NVNRY1RlbGxMaTRsUmQwTVcrcUJHMFFsdEpOU0QvZEtDaHJNcW03TzJoRERW?=
 =?utf-8?B?bUdtQ1RsVllRVWg2eDdKNkdhcGhKYmpFLzRQVzk1aXljRWdTM1pyU25FOVdu?=
 =?utf-8?B?NWJCYmt3T0NsejFDYkt3M0tabndVZE9ZeDVHTnlnZVR4cTNvWXNlSDZjY2J0?=
 =?utf-8?B?bTBlOW5mbEZEWnV6Wm5odm5OVDRnOGNHVzVzNXNwT0VSQmtqdEVjN3Z4aFFP?=
 =?utf-8?B?UDVFY3VPTXJrenVrR0RzVDhrNDFjbllITUZ1NlZ4YUVpZTRJWWsxRVliS3Fm?=
 =?utf-8?B?UmkzM085ZjdjVXBsNW9YSzdLdEgwRlE0TC9iU1k1bzE3SU9GNFJhYUYveTZF?=
 =?utf-8?B?NXhvN1VmaDBDV1ZMSGNZZ2tsRTVWa0F5dzFxMWFHRUlPeHpneGM0bzNNaS9v?=
 =?utf-8?B?YWpScUZjWElEbTlyWGtmSjBidmk1UEpoSGdJc2tiWjltN2dPZm55R2NJUm1O?=
 =?utf-8?B?NzQxOWo2b2lZNzY0amRQczZma1FBc3J6S3VUQXU2R0lEUWRDVXZYaFdMZ0V2?=
 =?utf-8?B?SC9lTGxaRUZuOTVqb3JKMWVvM1RGZGc4MXpiWUd0NzBvK3loSGlvOE9Dc243?=
 =?utf-8?B?QzdKbGhYMXYrYzIxand1OFdjWlp5ekNRQ0tybkJqNlN1enBhS1pjU2x4Q0th?=
 =?utf-8?B?S1N3NjF3ekt4cklGRjB1YzVBODBkRW9FbnJaVmlkOFNEVy9BbUpYNUZHVHhC?=
 =?utf-8?B?eEpFZUVkNTRaYVI0ZFN5cnFaM09idkhWWWlMZlZRRzVvd2lVMXhsVFJpOHdX?=
 =?utf-8?B?T3loL2laN3JPUWJiK3hZQ2hETEhKRHlEKzlIQ3F4UFpLYnZJY0tMNDdHaUNJ?=
 =?utf-8?B?aDJaTnZTMitBRXVUZFR6bmkwUWFNWmhrN0xPMjNQMys1K3VJMnZSQ1ZaNkxz?=
 =?utf-8?B?cFNEVTI5S3ZNM2JRcFdoZ0pXU0FtRi9qM1MwWnRhK2xzekhXTThvdmpvYmdC?=
 =?utf-8?B?cTFlbzNNMEI0Z3NHcldVOVc1SHhPOUhGbDJRemxBQjlFKzZZVGhyMy9Ya01C?=
 =?utf-8?B?NEY0YWh2OE5VaXN3ZFloSGR1T0E4WER6UXFJMWt0QlNEZWtjbFczSHRXb1pa?=
 =?utf-8?B?dzR2RFZXVjB3eWRPOHlrUUErVUFIVGd1Q1R0K0hDbDZjYmUxM2JwOThXZy91?=
 =?utf-8?B?MFNETmFSOVZ5OFJON1F0aWZYQmRPcmk1ZXhJTVN4QlVZazdIRSt5MFZ0VDBH?=
 =?utf-8?B?OVROWE9XK3hSVHEvL2RyZzQ4MVI1U3ZWdFQ2b1lReHB6Qm9tQ3plSUxhSHY2?=
 =?utf-8?Q?eQ7yhX7JZvGAn2iclZgpBY4lxHFDj740bt5imGt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F29CCD7F4F92649964AB3EF7662F348@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab34be68-26fb-4638-6112-08d9251be2cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 16:39:54.7705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LsI79HLxQU5FZOG2Gp3SpyknkIg8kAbKMXSgR0Mhp9f7Uj47K86X+ewnq6eOWIfAr8NlQc1gYsU+WqNR4kbN1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4645
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVuIDEsIDIwMjEsIGF0IDg6NTkgQU0sIFJvYmluIE11cnBoeSA8cm9iaW4ubXVy
cGh5QGFybS5jb20+IHdyb3RlOg0KPiANCj4gT24gMjAyMS0wNS0wMiAwNzo1OSwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+IEZyb206IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+PiBTb21l
IElPTU1VIGFyY2hpdGVjdHVyZXMgcGVyZm9ybSBpbnZhbGlkYXRpb25zIHJlZ2FyZGxlc3Mgb2Yg
dGhlIHBhZ2UNCj4+IHNpemUuIEluIHN1Y2ggYXJjaGl0ZWN0dXJlcyB0aGVyZSBpcyBubyBuZWVk
IHRvIHN5bmMgd2hlbiB0aGUgcGFnZSBzaXplDQo+PiBjaGFuZ2VzIG9yIHRvIHJlZ2FyZCBwZ3Np
emUgd2hlbiBtYWtpbmcgaW50ZXJpbSBmbHVzaCBpbg0KPj4gaW9tbXVfaW90bGJfZ2F0aGVyX2Fk
ZF9wYWdlKCkuDQo+PiBBZGQgYSAiaWdub3JlX2dhdGhlcl9wZ3NpemUiIHByb3BlcnR5IGZvciBl
YWNoIElPTU1VLW9wcyB0byBkZWNpZGUNCj4+IHdoZXRoZXIgZ2F0aGVyJ3MgcGdzaXplIGlzIHRy
YWNrZWQgYW5kIHRyaWdnZXJzIGEgZmx1c2guDQo+IA0KPiBJJ3ZlIG9iamVjdGVkIGJlZm9yZVsx
XSwgYW5kIEknbGwgcmVhZGlseSBvYmplY3QgYWdhaW4gOykNCj4gDQo+IEkgc3RpbGwgdGhpbmsg
aXQncyB2ZXJ5IHNpbGx5IHRvIGFkZCBhIGJ1bmNoIG9mIGluZGlyZWN0aW9uIGFsbCBvdmVyIHRo
ZSBwbGFjZSB0byBtYWtlIGEgaGVscGVyIGZ1bmN0aW9uIG5vdCBkbyB0aGUgbWFpbiB0aGluZyBp
dCdzIGludGVuZGVkIHRvIGhlbHAgd2l0aC4gSWYgeW91IG9ubHkgbmVlZCB0cml2aWFsIGFkZHJl
c3MgZ2F0aGVyaW5nIHRoZW4gaXQncyBmYXIgc2ltcGxlciB0byBqdXN0IGltcGxlbWVudCB0cml2
aWFsIGFkZHJlc3MgZ2F0aGVyaW5nLiBJIHN1cHBvc2UgaWYgeW91IHJlYWxseSB3YW50IHRvIHlv
dSBjb3VsZCBmYWN0b3Igb3V0IGFub3RoZXIgaGVscGVyIHRvIHNoYXJlIHRoZSA1IGxpbmVzIG9m
IGNvZGUgd2hpY2ggZW5kZWQgdXAgaW4gbXRrLWlvbW11IChzZWUgY29tbWl0IGYyMWFlM2IxMDA4
NCkuDQoNClRoYW5rcywgUm9iaW4uDQoNCkkgcmVhZCB5b3VyIGNvbW1lbnRzIGJ1dCBJIGNhbm5v
dCBmdWxseSB1bmRlcnN0YW5kIHRoZSBhbHRlcm5hdGl2ZSB0aGF0IHlvdSBwcm9wb3NlLCBhbHRo
b3VnaCBJIGRvIHVuZGVyc3RhbmQgeW91ciBvYmplY3Rpb24gdG8gdGhlIGluZGlyZWN0aW9uIOKA
nGlnbm9yZV9nYXRoZXJfcGdzaXpl4oCdLiBXb3VsZCBpdCBiZSBvayBpZiDigJxpZ25vcmVfZ2F0
aGVyX3Bnc2l6ZSIgd2FzIHByb3ZpZGVkIGFzIGFuIGFyZ3VtZW50IGZvciBpb21tdV9pb3RsYl9n
YXRoZXJfYWRkX3BhZ2UoKT8NCg0KSW4gZ2VuZXJhbCwgSSBjYW4gbGl2ZSB3aXRob3V0IHRoaXMg
cGF0Y2guIEl0IHByb2JhYmx5IHdvdWxkIGhhdmUgbmVnbGlnZW50IGltcGFjdCBvbiBwZXJmb3Jt
YW5jZSBhbnlob3cuDQoNClJlZ2FyZHMsDQpOYWRhdg0KDQoNCg==
