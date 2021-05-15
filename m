Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6919C38154D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 04:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhEOC7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 22:59:39 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53826 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234068AbhEOC7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 22:59:37 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5FBFBC0AAF;
        Sat, 15 May 2021 02:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1621047505; bh=rBJzVIBpsN39H4GQaowPUFH1Fj5wnBxMBOlq4cBXRhY=;
        h=From:To:CC:Subject:Date:From;
        b=aJqZHqin4OScBATsLwvn0czLoEuseNypGDPPDmYcg9nbw5yaCNx7d4cwicDr8ODDJ
         aIeQhO8Ddrbx74MN8/Akmx6yICSPdl821WWeJ460OvjenzFowVyY6glrrw1Wvh8jWz
         PYg58tvJ8SyaMsAUFp4nV562U50AhTG8pL3yg0OOHrRKB7wvY4GPfAHYxNcNrdaCTj
         uodo9TsF10TJE+0SA0zlNhSmIBoHzRr+eTFopvCZhxiOftjfETN4XwpcbMxRJ0108Z
         W737yoDMO310NuZzRLVjn73qQRBla98eVsS1v2rpwNxM71n1f0aAEa1Qg5ZzU7prAD
         CJ6yOas0osi7g==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A0B80A0071;
        Sat, 15 May 2021 02:58:21 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B1B5E800C3;
        Sat, 15 May 2021 02:58:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="rLsVlPkI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X15yydaob+PZpsPErBlYE9E5TL0IGKlwabdHYUoLut04GY0WeE8i5YQGnrsFVOIEzemNvBajTB/OrNtcizJd8LZY+q1DGIiDCYksnGDh58LCD2hD2bc+R4Jlh0KOEPGeeCLh82J8BwD9yUpQwlSRfgpknwGHEPEuA36rAzvKpu4FQ17+YHb8YiGl+G6ZZ/CfGHjg1PGxkrh362GwFBh8aHi0OtdutfmprXlnE2yJ6UKFqjHHfvdx7cTNV3mmYPB3a9Mqijdcai5kvpMZG1XUMXB7Ezp7/sUW5TWD9npixcdWUF6dKV3q35oWKML3h1ViuVuE7WZyefhtlcXF+neWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBJzVIBpsN39H4GQaowPUFH1Fj5wnBxMBOlq4cBXRhY=;
 b=h33GNtt2cO5+ARc3JJDwx83t/HeFCqP7drf56hISJABJ/lXBnyNkQYpR3y58YFJzTFPzzKP32/CK9vGxjXrEGXBlBTgJi9Nk9RcHbV5u93soZRzRpToKaXuJ8ZXEFcEldbdcUOfqIT8O0Yf+oiWNet5enA4ktO7HcTQEjLns0eA8edNGvITZ5jUkqebmS/AI+Skrx26aL6UcZuUGyTf+hy7sOLfk/eQho2fNXO3LmzQ5juJFulNJ0ewNM328wOkJ3MDwBKf85sQbIlN3usNte09PQk+HzSydlRjIdmkoDWzafUNPZLF4CYaAfJt1dQRGy1O6orEnZw+VPJSk9TW0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBJzVIBpsN39H4GQaowPUFH1Fj5wnBxMBOlq4cBXRhY=;
 b=rLsVlPkI73jS8m8om+TnsaTH/7IDZ8fVf1FJnuf+7UiczycLoIbuVQeWuU5BgQ2NRdo3fTWrQ3D1ukKWji5myV6VlLJUIGFV9SG7DE8TyNmkOhLKWYyDS/TwCcmm1Wl2safVs+sQ9gGJkjm11qaXW2z9SgZRJuq3ex7RfSeXCSo=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Sat, 15 May
 2021 02:58:18 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4108.036; Sat, 15 May 2021
 02:58:17 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>
Subject: ARC updates for 5.13-rc2
Thread-Topic: ARC updates for 5.13-rc2
Thread-Index: AQHXSTYnRctHD9Oqnk+1C3I7Co3BWA==
Date:   Sat, 15 May 2021 02:58:17 +0000
Message-ID: <8a78b8b6-9daa-698f-7ff5-613682ff223e@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fcdba8d-cac2-4658-8958-08d9174d4a74
x-ms-traffictypediagnostic: BYAPR12MB3640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB36409E6DDCCAACABDE7EDDD1B62F9@BYAPR12MB3640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:213;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogD+DqjdKNUqp4Hf1jOLFVFTt4Dh9pwAaPVOVGc90ZS0u9IVthWTRyTLY9+OWlq1tAq+FWSMZCL13SYbXG4XitNOkOdgG4L0vE4xO1wPxD7tulITFCZ0hjTdUQdvzZuJ2utV9qDDOLJ1tUzsKr8lJvsDNTf7Yk//YKpwRRr/ykWRXxdUmckwv7FJzo5Y7g19Qhjoyj163oX4IhCsp6kp2/m+JGOGjIHugyL4GGZzny3s95IqwKrKHuKV5OqDkg0um73O+ZY4kAV9rp+L165IulnFFHhPz5ry/cdDGmuMk2Fj9oXWGoB0RwD8qF2nLbAAstR/sHdJSmfjlz2oGZVOs2WbyWnB29HdyWWZXEpKwJnndSzwvaMUIqv9+NCSDSbkdLBVzhzN5F64zJYGXvIF04CaAch8t6yj/bMz7lc1+6bXFcK2GWaw/aIBV5cUqk72b1bJspwJjS002GCpn9mJ8AjJd7ekR8NCzWj6bcBHI1eBlWtT27uLswmuqKh9oa45gcrO4Ad/tDsCy2bpTy6/Lbv+PdwTu4hLdZm5FKsr+8RWdvNTY2UtnCnZQeoPjas5o9XyZUTKO8YAzo8VX2V5zMCcVq+q0iYCH/CxjuBp4pg9yvMn9F3zUSInxt5VsyeE6ijeoiMETr2MPnzps420eIFtI1m1t70KAhPzVhUkx2ql37sZX7RVV6B92KPvHQ+6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39860400002)(396003)(2616005)(5660300002)(6512007)(76116006)(8676002)(15650500001)(66946007)(36756003)(83380400001)(478600001)(64756008)(6486002)(71200400001)(66556008)(8936002)(66476007)(66446008)(86362001)(26005)(38100700002)(107886003)(6506007)(54906003)(6916009)(186003)(2906002)(316002)(122000001)(31686004)(4326008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RXdLeC9MN1cybWVPVzhsUUxEaVJhQ0Y4cityRlVkcHBIVEVhWkFlOTNoNEsw?=
 =?utf-8?B?MDlHYVpNdHV3NWNDU3h5Q0MwREdYQytXdFdvTkdWanFxTkdhREZYTGFBRlMy?=
 =?utf-8?B?UzJIRXZGckxpdERZVmtLVUNSRzJkZy9WdXJOMDBuZHBlZFlmVTIwWURzVUp6?=
 =?utf-8?B?M2xVSHFTekNBVzhtKzNhOEFjb1Z4NU1EYnFMcHZHRDlqcndEMFo2VFVocUVR?=
 =?utf-8?B?cWFvOXk3N2VZbnlvd1JwdWRTZWlkWC93aWpkMmlYSzFVSy9sdkRIUXUxSlVn?=
 =?utf-8?B?bjM1aS81ekZMbGU0MW9SRHM1L1liNW9qYmsvQnFZTFFvdFU5VmozK201bmM0?=
 =?utf-8?B?QnhKK1J4S3dpVndyM1Z3RWhScEp5RkQxazcydXRFU2R5VmJwOHMvbGhqVkQx?=
 =?utf-8?B?a0RDM0FPUExWRXNzdGprZnlUTzJFaVNlR3o4clNTRDNLeWdBMFJmTmFYTWVR?=
 =?utf-8?B?WVN5aTk4OHhDdXZReVVSNWFEWEcwWXAzUThWSENUTlBPRFhuc3o2QjBkdHlT?=
 =?utf-8?B?REVCR2xGY3Q2UGpqZHJ2U1BzaFVKUi9ra2x0ZE1ydU1GYWs1YjYyVFM0Ujlx?=
 =?utf-8?B?ZEk2MExkUDd5SUNtMklxWFZ2MkxKZEI3Mjk4aEVGQ0VtYXFLNmNMN0tTaHRY?=
 =?utf-8?B?aTNPWWlLWnpLZ3JOTWRjZ21mR0JyQUc5bVd0QUxEZ1NLVHlJU2pYRGk3Y1Z1?=
 =?utf-8?B?NkFtNGJZOHNOUEJDa0s4TUxQdHpxKzVLUDFCcCtSTmRzVFpIa3c1dFdHVDhV?=
 =?utf-8?B?cWwrMmZWRUtYUlRuL3B6dm84WWNxWWlIbXptOWQ2c1NJeERYY096cUpnQjg3?=
 =?utf-8?B?dGlraE05VEVocTQvbjN1L2NTY0lGN2VDZE1hVFBuL25Xc2QrU3k1VDN0QTg5?=
 =?utf-8?B?N01VNS9SOGtDdDk1Y2JlN0paY3NTaHo5ckVLOTBzWXByRzhmM1BkZk1WUzFO?=
 =?utf-8?B?OGdYdzdGQnpSSWtpU0c3Ulhia1FCOUVnSVVobHJRMjZsNGZXY29OUzBRL3pC?=
 =?utf-8?B?MWFhYXhMam1uZzdGOEhvSy9hdGRpcm03aDNuUXE0OVIrUE9ja1B6ZnljUllB?=
 =?utf-8?B?aG1XSlpvcTNZa1JQaENoVjlJVENaUUZxQXUwZ0FPRGUySjJNTVpDTE5YQUhn?=
 =?utf-8?B?RC9jVDJ1NEJzZEQ5K211anprT3FZeXUvNFdMcUR5N1lMSjNCMXBndUdUMVFS?=
 =?utf-8?B?V3kvWmZyRVlQd0pCUEI1VVp6c21RQ2VRVGlFZWU0Q0ZZZ3RnNldUZmtsUGlS?=
 =?utf-8?B?NTJPemZGMTFVRzlyMFZ3OXZQOVJZMXRleVg2TXc1ejF0cFF5ZXA3R1k2WUVa?=
 =?utf-8?B?VjVaOStxeFFVVDV3d1R2L2ZpWVBqUGhCYlRqVjZTV0NUZjAxQ0U2dEovbUdK?=
 =?utf-8?B?c24yME0rYkVSYkNVdDdVRGpGd2FSQU40QStzYnVRMHhYREU4K2lwdXp4QXND?=
 =?utf-8?B?OW5GVUFrSWVuUDVXWE1HVFh1eEhHMzczUFBBejJ6cVhmVEhEcW1mc1BCUERV?=
 =?utf-8?B?dlQybEJvMGxGQnhWMm5MWjZha0t1VHVmM3AyeVh4VitWWnBNVTlEZlNpdkMw?=
 =?utf-8?B?SDNFNkJHd25QRzlUeTJ1L0d5Sk9FRFF3NkRYbVpsZHR2UGNsbGV2dDZyY0dt?=
 =?utf-8?B?Ykttd3ViRXlZWmxEVHVNNXV3bTc5a1JacVBjWGZjeVVzVGFkRDV6Qmhoc0Ir?=
 =?utf-8?B?VC95aWpZa0lYMC9TcXE3OG5pWFhxZGNDMERudWxMR2NiTzBRR3g3Y2Yrb1Fn?=
 =?utf-8?Q?XJ7xUUqgFvBPFVmeao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <093AD1F849174646905275ECFB4E67A9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcdba8d-cac2-4658-8958-08d9174d4a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2021 02:58:17.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4pwD292C93J97eIVT54Z9pgTx3mDdBybh91ebsOpoTQMq6wXHma5Ag0zyeNd6eeIqVAIQBtKAR//K7lYtT4QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3640
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkEgYnVuY2ggb2YgZml4ZXMgZm9yIEFSQyBmb3IgNS4xMyBjeWNsZS4NClBs
ZWFzZSBwdWxsICENCg0KVGh4LA0KLVZpbmVldA0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT4N
ClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNmVmYjk0M2I4NjE2ZWM1M2E1ZTQ0
NDE5M2RjY2YxYWY5YWQ2MjdiNToNCg0KICAgTGludXggNS4xMy1yYzEgKDIwMjEtMDUtMDkgMTQ6
MTc6NDQgLTA3MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0K
DQogICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdmd1cHRh
L2FyYy5naXQvIA0KdGFncy9hcmMtNS4xMy1yYzINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2Vz
IHVwIHRvIDFkNWU0NjQwZTVkZjE1MjUyMzk4YzFiNjIxZjZiZDQzMmYyZDdmMTc6DQoNCiAgIEFS
QzogbW06IFVzZSBtYXhfaGlnaF9wZm4gYXMgYSBISUdITUVNIHpvbmUgYm9yZGVyICgyMDIxLTA1
LTEwIA0KMTI6Mzg6NTkgLTA3MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkFSQyB1cGRhdGVzIGZvciA1LjEzLXJj
Mg0KDQogIC0gUEFFIGZpeGVzDQoNCiAgLSBzeXNjYWxsIG51bSBjaGVjayBvZmYtYnktb25lIGJ1
Zw0KDQogIC0gbWlzY2xsIGZpeGVzDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkJoYXNrYXIgQ2hvd2RodXJ5ICgxKToN
CiAgICAgICBhcmM6IEZpeCB0eXBvcy9zcGVsbG9zDQoNClJhbmR5IER1bmxhcCAoMSk6DQogICAg
ICAgQVJDOiBrZ2RiOiBhZGQgJ2ZhbGx0aHJvdWdoJyB0byBwcmV2ZW50IGEgd2FybmluZw0KDQpW
aW5lZXQgR3VwdGEgKDEpOg0KICAgICAgIEFSQzogZW50cnk6IGZpeCBvZmYtYnktb25lIGVycm9y
IGluIHN5c2NhbGwgbnVtYmVyIHZhbGlkYXRpb24NCg0KVmxhZGltaXIgSXNhZXYgKDIpOg0KICAg
ICAgIEFSQzogbW06IFBBRTogdXNlIDQwLWJpdCBwaHlzaWNhbCBwYWdlIG1hc2sNCiAgICAgICBB
UkM6IG1tOiBVc2UgbWF4X2hpZ2hfcGZuIGFzIGEgSElHSE1FTSB6b25lIGJvcmRlcg0KDQogIGFy
Y2gvYXJjL01ha2VmaWxlICAgICAgICAgICAgICAgIHwgIDIgKy0NCiAgYXJjaC9hcmMvaW5jbHVk
ZS9hc20vY21weGNoZy5oICAgfCAgNCArKy0tDQogIGFyY2gvYXJjL2luY2x1ZGUvYXNtL3BhZ2Uu
aCAgICAgIHwgMTIgKysrKysrKysrKysrDQogIGFyY2gvYXJjL2luY2x1ZGUvYXNtL3BndGFibGUu
aCAgIHwgMTIgKysrLS0tLS0tLS0tDQogIGFyY2gvYXJjL2luY2x1ZGUvdWFwaS9hc20vcGFnZS5o
IHwgIDEgLQ0KICBhcmNoL2FyYy9rZXJuZWwvZW50cnkuUyAgICAgICAgICB8ICA0ICsrLS0NCiAg
YXJjaC9hcmMva2VybmVsL2tnZGIuYyAgICAgICAgICAgfCAgMSArDQogIGFyY2gvYXJjL2tlcm5l
bC9wcm9jZXNzLmMgICAgICAgIHwgIDggKysrKy0tLS0NCiAgYXJjaC9hcmMva2VybmVsL3NpZ25h
bC5jICAgICAgICAgfCAgNCArKy0tDQogIGFyY2gvYXJjL21tL2luaXQuYyAgICAgICAgICAgICAg
IHwgMTEgKysrKysrKysrKy0NCiAgYXJjaC9hcmMvbW0vaW9yZW1hcC5jICAgICAgICAgICAgfCAg
NSArKystLQ0KICBhcmNoL2FyYy9tbS90bGIuYyAgICAgICAgICAgICAgICB8ICAyICstDQogIDEy
IGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0K
