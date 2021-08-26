Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85363F8869
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbhHZNKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:10:48 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:48912 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242671AbhHZNKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:10:46 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6C75046745;
        Thu, 26 Aug 2021 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1629983398; bh=1C9o89oOgmtjHJ1kHE4ygAyOUq/a4fosQv5UJU1oZcU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KB0HDbhavYfp4VJLV71MyxpxG+z7ZJU39XbFR1jSoZUCmEMICiydR0l7vG8Owf1XA
         64tdmHitixZB7Hbh9Slzivn4RisyscCwcdOpnVLMMG8nzR4ZP9ijSdw5n8eiTqvcSB
         oR5/9GUshxyjX1E6f7aJ0msrI/GlzGSkdXnxrayMW1XIAmyU+82k0wXDQbVzZxPydB
         R+VP5ygeRcKp6CKWIesAemgas/KF5M3EfKNcz0/s6FWpuahlVhk40Fa3pnEXBXJ2nW
         gwbVcIz4lLuggVv73E67AxHDoSnlF+DABbU/VGtUxns8uvj9pDepN0JFr3VLkgHKrP
         cjNmw0xxRPVEA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CF1ACA0071;
        Thu, 26 Aug 2021 13:09:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0429B40131;
        Thu, 26 Aug 2021 13:09:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="BicuHMco";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+MEmVTymjUIEBGezFgaMRR5ThRBZszm2Ctp/kXBDq7tXk5eHnn6PAqIfI/enAN2tDF8V+LyoLQpCGCYLKM7qIvJLY6EJlPaWzX2ugIASul7sNtekTWmUm3aneKTXYPtk3FvZk+u2CBuWDj89zHnyMkSaivrrWb9yi1xb/OfjgemMchhIIKEOQusJdULyJGvcuUNbuDuJNji+KLhtfsH1iMe1L/D3KcEEnY8J/Tvi736xaduiuQaAENWCztmaqfx9ssnvf6kggb9SLSL6M0lCa7m5oI0D8Qi+cVhD0ICo+yx71ErHzu8L9uI6O8eoNDaAZCJbdHcVyw5Oi5cOBCJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C9o89oOgmtjHJ1kHE4ygAyOUq/a4fosQv5UJU1oZcU=;
 b=hXh1b9UVhbep/uuBVSlDTuUB3Z+HpiYqBsyM4/WMeYHsrrupsKI7uZFmorBDBTaLyR/UoRRnznsS6uuZjI3ZWStTqXl7KMgV8cQmgkcNuhsHymuquavhFM1z3zH2Bz1Xd2VjX3xCUxjDdXMzQnz0Z6VVjSIOrp/fzfbNKAYBggtZRRchQCAAwXnWTS8fhscULhQtb4IbiyscUuqxCzhrvYvSq04Y8InyTAS0XrgQtj/POB8J87SoQOQW7nR78gyEE1N1FPJVVwbtUrIGkcyMgns8iFcSTmotUBXfcd6CyO3PyYVcMTg7fLp8yoTrwPy2h0mWCGR4xxnBZefIR4n7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C9o89oOgmtjHJ1kHE4ygAyOUq/a4fosQv5UJU1oZcU=;
 b=BicuHMco4OHj65ZwMapQ4B/1Fpt92+9kTF99jx2cB3Sp8/csHR5QEdKieAo4b5akgW/l4PG+RFdTc52cBbssVwmm2nVu26HSraykUz5QQisCQJdr/Fpn1hP3tiPVFmg0fBlaGkRDqRb6W527g0Yszlu8fBcCjRPx60OTOApHVpk=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 13:09:55 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::c91a:f6fc:9847:4dcd]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::c91a:f6fc:9847:4dcd%7]) with mapi id 15.20.4457.017; Thu, 26 Aug 2021
 13:09:55 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Fix spelling mistake "was't" -> "wasn't"
Thread-Topic: [PATCH] usb: dwc2: Fix spelling mistake "was't" -> "wasn't"
Thread-Index: AQHXmnUJuaBn04yDwkCpwX2md3asu6uFwmeA
Date:   Thu, 26 Aug 2021 13:09:55 +0000
Message-ID: <ed770aab-5ebb-edc7-1273-b0437091e9a2@synopsys.com>
References: <20210826122223.13533-1-colin.king@canonical.com>
In-Reply-To: <20210826122223.13533-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93b8fde5-2599-4db2-bd0d-08d96892cc7a
x-ms-traffictypediagnostic: DM6PR12MB5534:
x-microsoft-antispam-prvs: <DM6PR12MB5534568986C66DCBFD7D43A7A7C79@DM6PR12MB5534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:48;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TbGNJwUuz3ZQ/P7L4j8LMTb5PngndNCRrzWeefMwnCfmfW0xns16LjTFmo5lG72X1+SoyZtn4PTnp5LhYFEt1HYDCqUl6iDxWG6ql2EDX7wXGXVgcRyNvnKRlD/9kYA1RLawk+CWrdzGxQzKw2b2IGDbSDs8hSgdGJyMgWROhVt2ppXZYpV/Vkhz/iDL8ciruDrZWeinRICLZaBzrcYctL6Wd8F8sLxGOzPvKnq6r7SgAzMSXieo9AwembkcTmjwazJKcQLQCS16mTphAhYueacHLBrh9NLrN4EAgZn1aZx/J6VuHlOf0iLc+smJPVhTTX8+ClYdh4IhMY79Lko93j7VnuDcn4RmFC/zwqIzQl96BlPW0KaQnziXKkoj98U4zWMkEeGwaEwwL1MFP893Zo2prV/fHOi2fkJmZ0Fc5pc85UVMtKVKljXoqrtdI7FlgBEl10fheGMMYUgYn9Vvi9xf+s29QL68WDML4FZysE+RNSE/4qZmZyrQaOsWAVQ5tX4Gr6LH+zVzWLmIg/1iZ8ViC7K8Wrsz27Yn6zfNnEZkhloac7F1FQv1eD1Mgw/fdbvGm7bEp6SHLVJiYSUMa8kjuW57/6W/upUpop+lZ/FTVkt+UN4GLikOHcF4cceKQIAPFB/wzgF4+QUpXiy3/5f4bYI50JN+by/VKqUsT4AWWQlaRqVIGKjscdjres5x+vMwzJoDrlZCegJF5n1hbpcTIr9TdJlaupjd5eaaW5ueb656lsKII7FFqmRXygMcGdQNucPCS7FYds2bbgthTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(346002)(366004)(136003)(2906002)(8936002)(4744005)(6512007)(186003)(66446008)(64756008)(66556008)(66476007)(71200400001)(6506007)(53546011)(316002)(83380400001)(36756003)(4326008)(86362001)(6486002)(66946007)(5660300002)(31696002)(478600001)(91956017)(54906003)(110136005)(2616005)(38100700002)(122000001)(38070700005)(26005)(8676002)(31686004)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVQ2ZklLcFNOdzhiOTg5eUl3SG1XTDdrNVhrbjBYWGNlVWc2Vkx3SGR5Q2o1?=
 =?utf-8?B?eitNMElaK3NvSWlmZ2NZTk1Lc2NvVkZPZmlIZTJDK2lmVFNnZ1h5Y0FYK2F3?=
 =?utf-8?B?M09Vd0JKb01yS1JvYmpTMHVYQkh6MlBQbGMvejhISzFmcFJmVUlIZGw4a2FN?=
 =?utf-8?B?RC9ZMUtYSWt1SkVjZkdkUXJad3hkV20yeDFOM3pTVU1TRnJuVUovQUdlWnN0?=
 =?utf-8?B?K01PMlprcTN4MDN6U05VUXFYdEJqTUw5UUZLWHpycjBQVW0rNHNJQUwvS1ZF?=
 =?utf-8?B?bHpIa3laQXJVTmJMaFFxWGNoRGxacTNLSDVHM294RUZLMWhCZFJya2k3cVcr?=
 =?utf-8?B?aXg2MUc0Y05UbDhKWU4zU1pwMjJQOWFzOHNvKzZhYmYrZTk5ZEY1RUNKWkQ1?=
 =?utf-8?B?Qi93d21hdlpGeDR3end5VVd4clpaSlVEOUpseERKeGMyWUd0UUpQZFFwdWNh?=
 =?utf-8?B?ZkZlS3ZqSTdhSE1HbjU2djRiajBVNXlRTnNPNlNlYmtPelVqblgvRXFaRGRi?=
 =?utf-8?B?NzhJdlkxU29Qc1pBdU5GKzEzSERJQXNxNWxjdHZLaUNvRnJRWWZnaUVOcnF4?=
 =?utf-8?B?SUcyVEZ2VTU5SDZlME1YM2g5MmRrUFc1alh0Tmd3R2tzTmhYVEsyVkFKd3po?=
 =?utf-8?B?ekE4MG5FL0MrQkRvaFVtYkhVUUtqK1EvRG5hRnNtSDgwSWxnM0YybnFad1R4?=
 =?utf-8?B?eWRjc21rd2JsK0hrQnVnZXM4aS9TSEwvUmxwc1dnbkpORFVTYUptb3NKdU1x?=
 =?utf-8?B?SG85dnVLMVBXNSs4WnVKOTc3UzNjeURvUDMrR3ZOV01LMjAxSkVDOHdJMlpw?=
 =?utf-8?B?NXVydW41d0ZtZHlyUTFtWUxISks1Njcyak1oR2Nzc1F0eVVBWTJ6OTFxUlRq?=
 =?utf-8?B?dTU2SjBNemlFZWRlT2h2d1JOQnVZVXd2S01IbEZ3UFpOb3RXNVZDTFJoUUVQ?=
 =?utf-8?B?RisyNFBabnlwbVQ4U2Fjdmx2UmFiNXZlZEFrcTFKS3dTSmlMeHF6ZGRVcDZ6?=
 =?utf-8?B?R0FueThCdWlrdThSYk9Ub3FrU1YxNWpPSDNWNmlsamJXcTRPZFhrVWlHUkh6?=
 =?utf-8?B?MXg0VGJjV3lSN1lDVHFjQ2lTUnorNVZNSmlWb3JDU2d5NHBVMUtpVjRGdStJ?=
 =?utf-8?B?V1hzTnoxMWF5Z2RVQlNrdnQzTzlPakJkaExSOXcyQ2xHeXFXUVVBRk1EYkVB?=
 =?utf-8?B?WGtKRlp2MUlrSGtLaElpK3N3UXdHMTlzcDM4V2praXh1NWxFTnZKdXhGRkJ3?=
 =?utf-8?B?RVNSSTFhTHBZSWV6WXcrWGJrMnloZnZCZ0tPRWh5anlVekpFelRqdis4azhK?=
 =?utf-8?B?TjE1YUErTTNKL2tlM09DUG4vTmNoWEVmOFhNYnhJNnNVQ21ZSXB1SE0wanBs?=
 =?utf-8?B?b2ZFVFd0OTExdkpDR3BPZ25Yc0o2TG5FRkV6MUYwbmh0ZHprcXJ0TUc1ZXk4?=
 =?utf-8?B?Wjl6Y3NncHlsdzlHa3hXZUpNdnpNaGJQZDF5VDJUR3g0UzVscVJieFAyZjVx?=
 =?utf-8?B?cU5YeTNwU3ErQ0k4U2o3Q1hpeUpnZEdsSURyWW45TTV2ekZFMUZlajRpVU5O?=
 =?utf-8?B?UG5KRjBMNTBIeTl3QnFmZTZ3ME1SdE1XS2creFBDOU1ON0hQTnBCT2xaaURl?=
 =?utf-8?B?NGlFdVpvWEN4TFV0WG41MGxVOW1HWmFTVmp3cm9ic1FHNmZrMCtNaEdiWStu?=
 =?utf-8?B?WThSR01YSkdzdFZXN1hUaS9zcG9VbVZiTlZ2UlNJYmZ5aVRNYWF5OGJhOFBo?=
 =?utf-8?Q?yHZFQo+O8MkIhuN8cA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C0F80B566A59948A642CC5E6B2C19E5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b8fde5-2599-4db2-bd0d-08d96892cc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 13:09:55.3182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiChfLnSN4cfYer4IFvgriwXYDgbRg027kChuZ1XW7Ns+aHQVsiIvTS7RVf0FeNP6hJTI1XgPhvYCnPu7PHM1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNCk9uIDgvMjYvMjAyMSA0OjIyIFBNLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBG
cm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVGhl
cmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIGEgZGViX2RiZyBtZXNzYWdlLiBGaXggaXQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwu
Y29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL2NvcmUuYyB8IDIgKy0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzIvY29yZS5jDQo+
IGluZGV4IDI3MmFlNTcyMmM4Ni4uY2YwYmNkMGRjMzIwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MyL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuYw0KPiBAQCAt
Mjk1LDcgKzI5NSw3IEBAIHZvaWQgZHdjMl9oaWJfcmVzdG9yZV9jb21tb24oc3RydWN0IGR3YzJf
aHNvdGcgKmhzb3RnLCBpbnQgcmVtX3dha2V1cCwNCj4gICAJaWYgKGR3YzJfaHNvdGdfd2FpdF9i
aXRfc2V0KGhzb3RnLCBHSU5UU1RTLCBHSU5UU1RTX1JFU1RPUkVET05FLA0KPiAgIAkJCQkgICAg
MjAwMDApKSB7DQo+ICAgCQlkZXZfZGJnKGhzb3RnLT5kZXYsDQo+IC0JCQkiJXM6IFJlc3RvcmUg
RG9uZSB3YW4ndCBnZW5lcmF0ZWQgaGVyZVxuIiwNCj4gKwkJCSIlczogUmVzdG9yZSBEb25lIHdh
c24ndCBnZW5lcmF0ZWQgaGVyZVxuIiwNCj4gICAJCQlfX2Z1bmNfXyk7DQo+ICAgCX0gZWxzZSB7
DQo+ICAgCQlkZXZfZGJnKGhzb3RnLT5kZXYsICJyZXN0b3JlIGRvbmUgIGdlbmVyYXRlZCBoZXJl
XG4iKTsNCj4gDQoNClBsZWFzZSwgZml4IHlvdXIgY29tbWl0IG1lc3NhZ2UgdHlwbyBmaXJzdC4N
Cg0KTWluYXMNCg==
