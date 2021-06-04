Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68F739BA7C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFDOFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:05:08 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42402 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231161AbhFDOFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:05:07 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A430240817;
        Fri,  4 Jun 2021 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1622815401; bh=KDwL29zLAsKcE2t9DtPYVW5u013aC93rRqyEPvsx2+I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LhP8h+B80FuAzrNYKX5dCp/vHGS/K1P8craMrZsMnpBkxVzmUYYRZ/JehGX8f6idJ
         BnLQVbST4gWuwoqNOmiQ13ZDE8ovydiLRg0AuWNvRL1IaZK/ABCn4vf9TbbunYsHRw
         vN/gv09h88iosS3Rk86nAct7BTKiugvla8zO+NPaPqhAlUEyXxGxB0s9xzmThVGFXc
         DCxjXr1jIGCmxTvFtkRW090sVSU7cK8DuBTOzBHALrB0m4pjsBrF4ad/TlGVDgbjhK
         tabHBejDo2p1ShTDBXsnGMmTq09U7hSRDjz0lTHuvlwLWqnk6OJ0AapUwSrYZnODuA
         NvZWa9FlXxOYw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 33C6FA006D;
        Fri,  4 Jun 2021 14:03:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A54C0802D7;
        Fri,  4 Jun 2021 14:03:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="coBvBjF+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7PDnNhmq2e5jvtpEbeS6zFR1dfA4v4WhUm7U7n9G+H0BXqb8mXVvPAFF9DDBJ0Nm4h7rgDxM432GFA3u0WLbJfqjmt9BTb8eOnKLHMrMJykaPgpFXb4IFXe8j8BIEuXo0J7gcnDT5MdklMh8uKbkmRN07xZAQnwW2G6k0DdW0iL4x0IT8chmRl1PkDtD11uD8Dy8nrb7W5E+rWwrJVLg3wsRyOCcbyShbe7cZlQzgNHxK7VsCkFX/pLLrlZa6IMw6D3C+FH3BV2t7afUMAAm+VYZMxfsgLR1T3+EYjyagvGXHje/dYNpz/PYtlQLIwZlRFvBBIA9x7Q3qHbWj+uWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDwL29zLAsKcE2t9DtPYVW5u013aC93rRqyEPvsx2+I=;
 b=DyoqXWYvAyhnCiHF/O+e0ffgJb00eCXn6OJfSBrraPsy0E1al3yoE/sMaeuBtS7+bo4neb+uA3MTtUNLQfgO9KGL4aMSuIj/+LzNHTN9kuLpzHyq0QQUVFEhFGoShFsjzsJyWOjgV9fp+r9G4zhsae8MtjnyXMS8b1d8kxzzgRuZHOE9un/N0CG87G+NmJAb3WcJyrb3R5cMMOHdSm/6WVWyNWRP5vpl3eXXjfdChhgD5fIKsIi3XSNnelommgawYSjA/q2HNOv7tuWwpoJbUcJTDFIvc1FewxT0oQ+TdT+l1Y+yQF2gkjCRr9F5einRyp5ROwjQ/NRQCvtppKWz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDwL29zLAsKcE2t9DtPYVW5u013aC93rRqyEPvsx2+I=;
 b=coBvBjF+sLSx5shka9ZGPTvMUv/hqJ5GTYjIzB8BO8JFAWPUqAdqizsz26EdqP58L++N5wtqE1zeGbJChTwr2ZPdp64qya2hVWk0VnVksBwrWw88Bvqb5a6VJcYHL/psOl5VaudSwkxQF94yzxPcQGPG4+90I1WMn+EmY+7NCVg=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2952.namprd12.prod.outlook.com (2603:10b6:a03:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 14:03:11 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4173.033; Fri, 4 Jun 2021
 14:03:11 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2 02/15] arc: convert to setup_initial_init_mm()
Thread-Topic: [PATCH v2 02/15] arc: convert to setup_initial_init_mm()
Thread-Index: AQHXWQ73wirLqHTvdEykgrzS/bG7dasD4paA
Date:   Fri, 4 Jun 2021 14:03:11 +0000
Message-ID: <289ae7eb-7c27-5c08-691f-b607e0584290@synopsys.com>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <20210604070633.32363-3-wangkefeng.wang@huawei.com>
In-Reply-To: <20210604070633.32363-3-wangkefeng.wang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 948e85d7-8484-49f4-75ad-08d927617d15
x-ms-traffictypediagnostic: BYAPR12MB2952:
x-microsoft-antispam-prvs: <BYAPR12MB29523E82F6EF57DBA76C15E4B63B9@BYAPR12MB2952.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:204;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FG+COT6DhsYj+XkwkVfl6tCZVpw+2kM2MVNpC7UF+Y9DgPZDjzdD2tnYVv0PdRfNFFCsDsXb1zjumeOxyrW9LUTwCBbDPmRhguULWZIuDhgYJBqD9I0KWh0fA54UAOSEQCZ0dKzdIlGR7G1zRYmJRctsbcQS83iqvBRx28WkqNspW6FDmSaxR5lrurUlGTQF1Et6NrdvDRsROsxwSummnsJL3ZKdfsGHv0Slz4oiMncFz6u/HjV8t/X4fzxKXVKPsVJ6pSMUJSThn9yZCs9gvTRUHKMCLHpxveEU0CH7I9+3C3jEe9dde+AW18xZ9eJw1WqQfUqbkmaZZYEkg4ZESROF7sp/VfImKUskfi5xYeAt8RsPsvJrEFzB3dEruTfGDIDUE5fvCZLHFKW8IzfEsRQdsBHE1cBidA1RGdtAb0qIerte1OpwkD1465STZ68aDik3SDJZFEYLDz60yJTE83jBt/SNH7+BYU4tYao+gmj7+8KT7Fvj0mlslD/PGgrE7s3VcNWmKJCgWsATtYYULULAq5CSb8FQcIvwLNUFdAZawNGLlHq4ryuAB2zcykjBz8OV92smGhpyrf2BJFeqdCkrJcz9xmmTmNigU3WVybXaIh4GX9DeMtSCXG6qzCOc/lTNN/4zddfZdAaIMm/mbTscr63xgzi+hBWvrq5t3SNZuVreYGfN5hyDuQV5VXoj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(31696002)(31686004)(86362001)(2616005)(4326008)(8936002)(8676002)(186003)(26005)(478600001)(6506007)(53546011)(71200400001)(122000001)(76116006)(6512007)(38100700002)(4744005)(6486002)(66946007)(316002)(66446008)(5660300002)(83380400001)(2906002)(54906003)(64756008)(66556008)(66476007)(36756003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S3JHOXlGM04xYzVUTGZlZ2p0UjZadFk4eTV3dzUva3ZQUVd3ZGgxOWUwNTdW?=
 =?utf-8?B?RGN2T2tRTGZrUEdPSE1FK0dvS3FWWG1Hd3MyUDRKN1FNSSs4Tm5XUjFtV0hF?=
 =?utf-8?B?c3ROVUthbnp2SHNYd251ZEgyODI0aTl6SWZaV2VkamZhS3JEY095MU16Tml2?=
 =?utf-8?B?NDRrbzJkWHlmRDN0RDFOU1FSSXFCcTR0Qm5wNldBcmJpNVR0cEVJT2FLWEZt?=
 =?utf-8?B?aS9IWFk1YW01VjQ0d3JPUmpLSmhjVVZVYytJL1Jua1hJZHg0b1h6c3orNHZO?=
 =?utf-8?B?MkQ5VjRJVGRpZUpjZ2JWZ0tSYnNRcWlQMkFRbnJJdi9FRkhVKzYvakxqeUlT?=
 =?utf-8?B?d3l5cURQQTgzUHBaYkFVK3NJM1c0ODhjNHlIK3czWXNPVG5XWG42S2pKV0hS?=
 =?utf-8?B?cGZYWUFIUENpb21nNEI2QWRCMUJKVzV1Ym5aWHZtY2Z3Yi9TeXozNTZzdUVt?=
 =?utf-8?B?ekIvT1BYV2d6VmllcXpqMi8wQVV0MktUemtrMTExVlVpcTJSZW5LYlMvcWpM?=
 =?utf-8?B?VSs3QnJPWGFDeFpiNld6TVh2ODNoWEhGNi9qTFowcnF2Vm5ZeUhKeTE0VDVU?=
 =?utf-8?B?MFVFaUZhVVZWY2UrZ0hRNkhyM24wdnR2TlNVallPSWNoOWIrQU1XWXdhWUFt?=
 =?utf-8?B?Zkk2RmpLakFNcHh3TXZGdmp0SFVCL2Evc05aZ0pwWi9YNWZKQWJoYXprZEtG?=
 =?utf-8?B?TVRjYWZEWU1lTzBHT2lsc0FZMmVEYU5sQ2J1b2FRNWVpL2UvOXQvZDV5NkVv?=
 =?utf-8?B?cXZiWCsrQWVTWUdGT2tyazVRMXdoaFNRNVVvc0MycytZVVJtQXpFd2pOVkgy?=
 =?utf-8?B?d1Ywbk5KRy9qekRJWUhjblh4eVFyR0ZCWTF0blZGNWFzOTFmUE1hOVBwMkZ4?=
 =?utf-8?B?ZktIaUJQY1FqV2RxM2pWVU90VmxZWWk5MHBFdmJYSnAxdm5MWCtFeHJMTUo2?=
 =?utf-8?B?U1dxVGM1bzV1WnVtcjQ0c2s1S0NTQjB6dmlWTUdvTGpRK21EdmwxT3NHUTFJ?=
 =?utf-8?B?Nkt5UHpBbTI4OVVlTXNrWW9QM1JIdkJveEU4emd2NER4T1BIUm9xSlRzM1dM?=
 =?utf-8?B?WjhOWmQ2OFdYVWFUZDRFc2YxUU1LMlF1ZXZEaTQybU9ZZ3praFB2MGpQeS8y?=
 =?utf-8?B?NVJsbnppOUIzMEVrWG5jWXFLMGVLMnc0ZkdtaU5rQ0VPdHNYRVhaUWJ1aG04?=
 =?utf-8?B?TW5ST1ZMblZmSFBZVnJCb3pzVnZLMFlwbFk2S2Frb0M0eDBJbTdBS0VnV3dh?=
 =?utf-8?B?VUVVWGUyZ1R6YU84amZURlVMa2g5ZDgzc3JmL0NZK0llVkVYanhpSzJ3Q2Mv?=
 =?utf-8?B?ZThCak9QVUpJVXBVRFNSak9vTmNHbEg3ZEdtODVlODZ2NkQ3UUNwT0lSZDVT?=
 =?utf-8?B?Wkl3RVpyekcxOEtYOWsxeDFJZnpDUG9EVGo5Q0JCY3EwUndOT0t0UjBsdFZm?=
 =?utf-8?B?cnA4UXdrOTJDNGN1RWdPWFpVVFQxMmhGNTRvQmxUMWxsNHlDUGowOVBKZDMz?=
 =?utf-8?B?bU95eWt0VlNUOEpTbi9ZS2lnYVhiZ3Q3QmpNbW9sZXF5Y1JlbExnSG5EMUx1?=
 =?utf-8?B?Um9ERVFKSlZkNjlqbGtQYVFrQnNvTTBkd3hkVjZkYktWZ1JlTml4ZTVFOHVV?=
 =?utf-8?B?b0VaT2Qvam5RS3dTWHkyWVhTQ0ZoWGtCTzlvVVlmQ2FXSmxZT2dqbWU1MEhv?=
 =?utf-8?B?WnlDNVZQTGRKZm5XbXExZjBjNWpHdXE1SjRsSitzZXlYMC8zUDNyWTdRbk1n?=
 =?utf-8?Q?5gqnWLMX2b152I2JCk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <66579E1E7090CB4CA919A3D729E7478E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948e85d7-8484-49f4-75ad-08d927617d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 14:03:11.2505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHxhxuCpjGQxL4j7PT4wZKXedjL2wlKOiMNjNFucIhKwNTMLy9BnhLbj+1He+NFn9VXv+u+CRn6rKlnyZtSpDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2952
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi80LzIxIDEyOjA2IEFNLCBLZWZlbmcgV2FuZyB3cm90ZToNCj4gVXNlIHNldHVwX2luaXRp
YWxfaW5pdF9tbSgpIGhlbHBlciB0byBzaW1wbGlmeSBjb2RlLg0KPg0KPiBDYzogVmluZWV0IEd1
cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KPiBDYzogbGludXgtc25wcy1hcmNAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBLZWZlbmcgV2FuZyA8d2FuZ2tlZmVuZy53YW5n
QGh1YXdlaS5jb20+DQoNCkFja2VkLWJ5OiBWaW5lZXQgR3VwdGEgPHZndXB0YUBzeW5vcHN5cy5j
b20+wqDCoCAjYXJjaC9hcmMNCg0KVGh4LA0KLVZpbmVldA0KDQo+IC0tLQ0KPiAgIGFyY2gvYXJj
L21tL2luaXQuYyB8IDUgKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9tbS9pbml0LmMgYi9h
cmNoL2FyYy9tbS9pbml0LmMNCj4gaW5kZXggZTJlZDM1NTQzOGM5Li4zM2I4ZmFiODkwMjIgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvYXJjL21tL2luaXQuYw0KPiArKysgYi9hcmNoL2FyYy9tbS9pbml0
LmMNCj4gQEAgLTk0LDEwICs5NCw3IEBAIHZvaWQgX19pbml0IHNldHVwX2FyY2hfbWVtb3J5KHZv
aWQpDQo+ICAgew0KPiAgIAl1bnNpZ25lZCBsb25nIG1heF96b25lX3BmbltNQVhfTlJfWk9ORVNd
ID0geyAwIH07DQo+ICAgDQo+IC0JaW5pdF9tbS5zdGFydF9jb2RlID0gKHVuc2lnbmVkIGxvbmcp
X3RleHQ7DQo+IC0JaW5pdF9tbS5lbmRfY29kZSA9ICh1bnNpZ25lZCBsb25nKV9ldGV4dDsNCj4g
LQlpbml0X21tLmVuZF9kYXRhID0gKHVuc2lnbmVkIGxvbmcpX2VkYXRhOw0KPiAtCWluaXRfbW0u
YnJrID0gKHVuc2lnbmVkIGxvbmcpX2VuZDsNCj4gKwlzZXR1cF9pbml0aWFsX2luaXRfbW0oX3Rl
eHQsIF9ldGV4dCwgX2VkYXRhLCBfZW5kKTsNCj4gICANCj4gICAJLyogZmlyc3QgcGFnZSBvZiBz
eXN0ZW0gLSBrZXJuZWwgLnZlY3RvciBzdGFydHMgaGVyZSAqLw0KPiAgIAltaW5fbG93X3BmbiA9
IHZpcnRfdG9fcGZuKENPTkZJR19MSU5VWF9SQU1fQkFTRSk7DQoNCg==
