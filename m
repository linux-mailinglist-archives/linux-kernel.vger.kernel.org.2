Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA873CCB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 01:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhGRXGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 19:06:24 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43872 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhGRXGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 19:06:23 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 29927C0B61;
        Sun, 18 Jul 2021 23:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1626649404; bh=afNyAYhIInhT0PrMhmEeoqRky6G2JRjKMp66NgH1/fM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J492rTBX72ftZuz8xJP2IGM6sotXYGHVz4b5T9ZYoDQyICq/7Ht6Ierc1BcRHrKDe
         LYbZeaGufLTxLmLqT8iI1aOu0g0WEs1+rm36JLxb953cdF9pUppqAR0kH7xbx4SzlH
         yAumy/q8e55RwDzPAN8+M57kvQPfY2FaE17+xHQC467XPQ+0qJWdmUH2XWWjcuLwht
         naB8G7CvxewsfvMIJtU6MpS4dD8SC7KlWe+On9Z/MHxGX+OyoMmev7a70N9aAOeYP2
         8ckMiuFOb85p1o+5bN4+h0omBqN9IeOaa13z/dGKW0YWYnwu7ASuvPDA3lS1N9RyQP
         kQtJIYfNzK5gw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C74B7A0077;
        Sun, 18 Jul 2021 23:03:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1569180024;
        Sun, 18 Jul 2021 23:03:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="J3lU+TKL";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRUZBHPN/NgWeJwX53RNFmh7RxjtLtdO2x5C0nr9jSZYQrmILY5BPf+TIu3/atRC9R1uma5YHndOqBqayN9cU694KYhz2ZfHdSWp1iC2+zWP5CX+eexfro2el0jcRvjA5Su3kIyG+PNeUGlGgnz7fU/Wd37iBnY7ynQr3BelUmZ1a7YLJYynxfi9oOxL+YpYNn40oLj5Cbvv2Vm2IkZ4IjzWUWNdWaBKx/T+PYwLb+p99e1VZKMTOVaWePxsGHSenaHA7rM9RPYfbS/+6jWehaa/Pmhzga9KKpFNNoqICCi9WiBCebUQnrNY81T1yLZqjmsKBRenoWFBcH3a1xKBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afNyAYhIInhT0PrMhmEeoqRky6G2JRjKMp66NgH1/fM=;
 b=AlSyywT0N5rSuiKCnj/2gw7YNBe4W4rb0Qvy/tozIQCZdMPt6YoJgx/6QaBO/iCbvy0Elzqa8LqYKtlHjyKepHBJhX98AXlLyHPgzBEPGkSE5OdPQaKM3rQ53KAgyiFNbrDV3mGRF2IRpZO+8LDHeQ9vY5Sv2dg8I1ODQZnxyVMujotP5pJtxo0WFrOs3DejCPywZEj83HkUd885LaX/wDpQpOh41ZYn5Q2efl5edSP2htg+Cjc594LkjXAQBsvLrHvKw5TKJXKAYqgje8vE6RPO6HocmUVik6d69lx7vwNqfO82HyzD0JerMDsbsWla4hJi5kv/1t1gWOnuh9ZMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afNyAYhIInhT0PrMhmEeoqRky6G2JRjKMp66NgH1/fM=;
 b=J3lU+TKL0fkpNYPvpVu0P50+ntD1mBzWtSPZuCEGlpb6Ob0czTQXHDFwfTRAST0YpeDC2NmZSoHHy1hhgqT/YEQocQPRX8QXrsMBvIY6AWSpNGATMT2o/Ra0B1SMNZloEN2c1ayhPboKjaS1+Ni+5/l5qtGT/8ilcSv0auRmddg=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2951.namprd12.prod.outlook.com (2603:10b6:a03:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Sun, 18 Jul
 2021 23:03:16 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee%3]) with mapi id 15.20.4331.032; Sun, 18 Jul 2021
 23:03:16 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] arc: rename arc_timer's TIMER_CTRL_IE to avoid
 redefinition
Thread-Topic: [PATCH] arc: rename arc_timer's TIMER_CTRL_IE to avoid
 redefinition
Thread-Index: AQHXfBSemYvNgsuum0+Xq0qlikoXyKtJWgSA
Date:   Sun, 18 Jul 2021 23:03:16 +0000
Message-ID: <e1abf074-5a94-d045-e5d1-ed70a4b28600@synopsys.com>
References: <20210718203632.3982-1-rdunlap@infradead.org>
In-Reply-To: <20210718203632.3982-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67b14305-c0c3-4097-3d39-08d94a403a2b
x-ms-traffictypediagnostic: BYAPR12MB2951:
x-microsoft-antispam-prvs: <BYAPR12MB29510D4BD923D6A5CE628C84B6E09@BYAPR12MB2951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nh5Q3NIaphtuCAWoZPBVIixbRgAXKV0XZnPoTfXPSEz0/tLfxrWZWAdwbLqxcuBBZtDgB+D5AfgJmVdURXnhJy5YWXQmjvyBJCgEL0GXQrSKT4XH7feYcqZ79gVczmr5ssOV6iG0gKRHnqOTKE2u3CarwRib2f7/4KG7/ZULaP/udAus3cXfD1Xxdqmx7ORrzwyyhIzQy6fygWL+a6xc+TkvMoPJ0TaPgEhfWaw7G2J9l7weBt0ysnass8RpMAdKD6//Zh7sWEW5nvSEYIeigGMRvDUCtAAYpVin2A31KShe5AMGafTA8aWLfcxTnAJ1x7cF/hzi2MlD26vxlHSCmXmJvtVa3Abb7hvFMC1ItEURKoB2HOTCpUJ0Jq4uE3ZJ/XKnaiLlERIUbtHFZdDqnKpXQ0nIjrN4cmO9zlnkdccHkhGkajqI/HNYOE1C516qs57bMq0XDgaShJub0rHqaIIqe3NQ8HpMXT3GsaNjUSOA7ILHG5vox+1R/6twLcoKpyfAuCYIcG++lhdY5zlsdSh9V2rixtIGbw8itAlD1n4dteByyZ0hnxy79MVEMX1co9RwGPOy6oJUUIsBJPpxo9AB8sGLFSNydFvSI9EPb4Uslun5XJPi4/hJKA14bH6jfcO3wFeQ8F9UWNMFn65vF8YUtAd2iC9LO6Og2J5Pv5lfhUpURH6UN6Woc0D9g3IZEp7ZTNlaSLF0nKPDub1/zp9Kw6knDy9m3bHek5fg8NDdKd0LLYljlFVEwikWDafveD7gYPrBlir0wRhE/3VJbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(366004)(39850400004)(31696002)(2906002)(5660300002)(66446008)(64756008)(83380400001)(186003)(8936002)(66556008)(8676002)(478600001)(86362001)(76116006)(36756003)(6486002)(26005)(71200400001)(2616005)(122000001)(38100700002)(53546011)(6506007)(316002)(110136005)(31686004)(66946007)(66476007)(6512007)(4326008)(45980500001)(43740500002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVpZRENUTXFJcHhsWk1Deis0K1YzUm81ZEJqdkhNUUx5UVA5eXBUYVFkSUx2?=
 =?utf-8?B?UURxRDJKVUh1dU9uL2dnQ2FIazV3ZTJuaEdZNGVCeDZ0M3d2eThkMjZlcitX?=
 =?utf-8?B?TlVhM1dRYTJxd05WZ0d4Sk5Mb3g0N1p4bElwV200YXBLQlh4M1YxZEd6aW5H?=
 =?utf-8?B?cEFVVTZqd3NZc09URS9FakxGc25aK2lRc3d0QzQ3SDlrOGRzaS9xd2x4Zisz?=
 =?utf-8?B?eHFtR3JHNng3YUlaNVdiT0FVQUp0YzBuQUZtc3dzTEcxT1pxNFNjSndudS92?=
 =?utf-8?B?NE5CVDVlcEVzUkhMUUhYei9zR3FJbXl5d0NObW5xZFBZQjhaS2Q5aVpxa3d2?=
 =?utf-8?B?ZFU0M3Z5ZXpqYmU3ZVk3N2lPOU1Wb3pQOG85SnVlZTRhRFY5R2tOWE41a2lQ?=
 =?utf-8?B?elA2UVB0RmZzYWkwRmE4K2ZadjNIemFLQ2lWZU9GS1J6NXA1TlVqczlXeG9x?=
 =?utf-8?B?ZTdhSHdEZVJ2R0pkQ0VpNmg3T3BzTkFZait1ekNoRE1IemVnRHJYWVlrbGh3?=
 =?utf-8?B?MHBNMU53eDB0YnRYTVd3ak56OHR6WWpkZkw2NmY5K3QyYVA0c0pHYjI0Q1NI?=
 =?utf-8?B?NUIrbXAwZ2F1M2ZjMEhRaVVBSnBjQVRnc2ZiS3I1OWY5cVhlQlFvdEovaGxt?=
 =?utf-8?B?dzdobm0yMmx0cEd4enNZdUhnT1liSFgxRUpML1FzWGZWSTBxczVqajFsRzRS?=
 =?utf-8?B?LzkwdDdxeDB1c081eFlxUXpaaGZHb2t1WHNob3ZndEdmeGE2UWlXd2VNclNI?=
 =?utf-8?B?T0M5THV6eHNBNFVrT2pHKzYwTStjUy9yTWQ4RGpxNEo4cWRyOU1WYlQ1WGcz?=
 =?utf-8?B?ZUpoR0gwNzJaZTFBblBldnppOXhqSHE1YTEzajlhMUg4SDArUVluVllRd0V3?=
 =?utf-8?B?TEhmMnhycFVzT2VXK29LMjhQNndaVktvQkh6eU9yYnVEVmtiaTVkai81VThX?=
 =?utf-8?B?NUp0T0lhazIrdjRqK0ZvQ0dydStadGxuV2oxTzdUUEx6VU1YS3N1dDNCUlo3?=
 =?utf-8?B?bEJqQnVBTnhleFBMSzg2dVVjSEptdUFmTkFsRU8zMi9JZHV5TWRjRGZnSDRx?=
 =?utf-8?B?QkxucitNeGFjVVhFaUR1ZER3Y0h3d0tjZ1FWQWpTSnllUnNmSklqU3RhM0ps?=
 =?utf-8?B?REF2UjJwNzBnVVFuNzZLRjkvUnJKZ2VOeGVGcHloNk5iK0cyU3NPMjlMY2tk?=
 =?utf-8?B?WjRidjVQTzRDUkFYU1ZTSWJ3OXQ2ZUs3dHUzS1ovc3ljbUlURkhlcE5ManBJ?=
 =?utf-8?B?MjFDbFpnaW55UW9tazdOeEhPU1hHRWFBM3F2N1J5ZkNuZWoyM3J2NklYWkVE?=
 =?utf-8?B?ZnpKd3RUM2llWEo5MGFkWm50WVpJWVFiL3RsVThLVThqUG5UcGZ6MlNhaWtI?=
 =?utf-8?B?SUtOdzh6dWhIc2VnRCsrQ2Q3YTRwRDBzbGphTEVqWUdab3FobHk5d1ZWck5y?=
 =?utf-8?B?WlJUWHZRVkZjc0xFVFNEbTg5SWQyWE1xUWI4RGdrVUxZR25BU01kVUJZRDBz?=
 =?utf-8?B?MC9UUTE1QTFCVWc0MysveUF6SE9PRkpyZ1hsZ01DME05MG9DWkRrSzkxVEpB?=
 =?utf-8?B?eUtBeFFjTUowUWc4RkFJa21CR3hOcTBCb1M4VWRraVZNUG1hS3haVCtNSGRm?=
 =?utf-8?B?Nll4aVp4cFpMRVIyb0FKNnBLSHo5WXN2V3AvcXNoV3ZNb3g0YjJVek1PSlpv?=
 =?utf-8?B?SEVkb0c3VDM5MWNiVmFBSVZqWEZ5SlhXaHBRRGpKTDJnZkdkcldIcU1EQk02?=
 =?utf-8?Q?0/3ni4I5nRmuUCJHaM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B989E7F1CDCEA4298FE90F7585C69F8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b14305-c0c3-4097-3d39-08d94a403a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2021 23:03:16.2281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6nvWEulscyrsf3NDGNYbtMZl5DE2N3vNn8WCfjLwS7IKhWF8zXjZCA4lUd1CzqSUc+T04PyuigLaLZwUaliBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2951
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOC8yMSAxOjM2IFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IFRoZXJlIGFyZSAyIG90
aGVyIGNsb2Nrc291cmNlIGRyaXZlcnMgdGhhdCB1c2UgdGhlIHN5bWJvbA0KPiAobWFjcm8vZGVm
aW5lKSBUSU1FUl9DVFJMX0lFIChpbiAzIGZpbGVzKS4gQ2hhbmdlIHRoZSBBUkMgdGltZXINCj4g
c3ltYm9sICJUSU1FUl9DVFJMX0lFIiB0byAiVElNRVJfQ1RSTF9JRU4iIHRvIHJlc29sdmUgdGhl
IHN5bWJvbA0KPiBjb2xsaXNpb24gKHJlZGVmaW5pdGlvbikuDQo+DQo+IEluIGZpbGUgaW5jbHVk
ZWQgZnJvbSAuLi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWludGVncmF0b3ItYXAuYzoxNzoN
Cj4gLi4vZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1zcC5oOjI1OiB3YXJuaW5nOiAiVElNRVJf
Q1RSTF9JRSIgcmVkZWZpbmVkDQo+ICAgICAyNSB8ICNkZWZpbmUgVElNRVJfQ1RSTF9JRSAgKDEg
PDwgNSkgLyogICBWUiAqLw0KPiAuLi9pbmNsdWRlL3NvYy9hcmMvdGltZXJzLmg6MjA6IG5vdGU6
IHRoaXMgaXMgdGhlIGxvY2F0aW9uIG9mIHRoZSBwcmV2aW91cyBkZWZpbml0aW9uDQo+ICAgICAy
MCB8ICNkZWZpbmUgVElNRVJfQ1RSTF9JRSAgICAgICAgICgxIDw8IDApIC8qIEludGVycnVwdCB3
aGVuIENvdW50IHJlYWNoZXMgbGltaXQgKi8NCj4NCj4gLi4vZHJpdmVycy9jbG9ja3NvdXJjZS9t
cHMyLXRpbWVyLmM6MjU6IHdhcm5pbmc6ICJUSU1FUl9DVFJMX0lFIiByZWRlZmluZWQNCj4gICAg
IDI1IHwgI2RlZmluZSBUSU1FUl9DVFJMX0lFICBCSVQoMykNCj4gLi4vaW5jbHVkZS9zb2MvYXJj
L3RpbWVycy5oOjIwOiBub3RlOiB0aGlzIGlzIHRoZSBsb2NhdGlvbiBvZiB0aGUgcHJldmlvdXMg
ZGVmaW5pdGlvbg0KPiAgICAgMjAgfCAjZGVmaW5lIFRJTUVSX0NUUkxfSUUgICAgICAgICAoMSA8
PCAwKSAvKiBJbnRlcnJ1cHQgd2hlbiBDb3VudCByZWFjaGVzIGxpbWl0ICovDQo+DQo+IEluIGZp
bGUgaW5jbHVkZWQgZnJvbSAuLi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXNwODA0LmM6MjQ6
DQo+IC4uL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItc3AuaDoyNTogd2FybmluZzogIlRJTUVS
X0NUUkxfSUUiIHJlZGVmaW5lZA0KPiAgICAgMjUgfCAjZGVmaW5lIFRJTUVSX0NUUkxfSUUgICgx
IDw8IDUpIC8qICAgVlIgKi8NCj4gLi4vaW5jbHVkZS9zb2MvYXJjL3RpbWVycy5oOjIwOiBub3Rl
OiB0aGlzIGlzIHRoZSBsb2NhdGlvbiBvZiB0aGUgcHJldmlvdXMgZGVmaW5pdGlvbg0KPiAgICAg
MjAgfCAjZGVmaW5lIFRJTUVSX0NUUkxfSUUgICAgICAgICAoMSA8PCAwKSAvKiBJbnRlcnJ1cHQg
d2hlbiBDb3VudCByZWFjaGVzIGxpbWl0ICovDQo+DQo+IEZpeGVzOiBiMjZjMmUzODIzYmEgKCJB
UkM6IGJyZWFrb3V0IHRpbWVyIGluY2x1ZGUgY29kZSBpbnRvIHNlcGFyYXRlIGhlYWRlciIpDQo+
IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBD
YzogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KPiBDYzogbGludXgtc25wcy1h
cmNAbGlzdHMuaW5mcmFkZWFkLm9yZw0KDQpBY2tlZC1ieTogVmluZWV0IEd1cHRhIDx2Z3VwdGFA
c3lub3BzeXMuY29tPg0KDQpUaHgsDQotVmluZWV0DQo=
