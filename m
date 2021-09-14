Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A61E40A233
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 02:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhINAxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 20:53:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:39140 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhINAxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:53:51 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 65F42404C8;
        Tue, 14 Sep 2021 00:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1631580754; bh=+Qjas9Cectg9CTjqVJwxvt2FNs7tlErdb4At8yviv5A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DnMJHncWSftqvp+wlGhHPFmJHWu6bSDNUqRPJdWILGXkQ6QRaAmz+P65HOXpv5IXn
         LgegwCPf7d2JVjQ3DXlTcth0TR4jOBXdchXt1DwHTruYNQojLG29hM4pDqpYJoX3+h
         3k+zBiOpAQSqeffFIFjJRl+e7XwDvyhAv82tmkbSMXpxBkpZhK3cSubdZAmi0AxOhK
         rCd9cw24pNu2rwr99gwiQhVtUNEwQ8tQtE/oURq2d00ULN9wBmkA5bczdfVcWfvQnT
         A6iCrBRmUkJxJeWvTehJS8RpcP3dLVztvEFriULZlr9xQR+pLj+jU5/gD5RHKQmEB3
         wPDYbvrQEUoig==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D92BCA0096;
        Tue, 14 Sep 2021 00:52:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BEF2B40134;
        Tue, 14 Sep 2021 00:52:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="L4wxBODE";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLZ18va0l1GAxaEcblXGAJGP3jM+4KddXQeJTq8VfKVNIm7ngPi30xw5wmt4dgD8v/WRpw8eZfY2Hc9CUgK/XXPiOFL+Fmh3HRo5TI47A5g9wBa/v4UXIc+D9GrcxhD/rNHLlUHuwS1TWAshULIMLEqfrekbuExLRhsiLCmi19l3222BtRpxA4SUXG+7FAJgTNtYMWip8V0D41FCND6ebdcIuB+4VYJrzyECQLTrlTGy/lrkjzvGiAx4QnfEInCibJEO2ou5JgpSPMHUAB7L9U9fAFEb1CZzjGWcpiqa352TtKIszOSwMS92o/pn+Gi1XPZtsArXKu3PeK7B7gOYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+Qjas9Cectg9CTjqVJwxvt2FNs7tlErdb4At8yviv5A=;
 b=QPoueqxW5CxiiZ4F767XoH+rcbZaVmqNRn6QwIht9j7sGTjooqS36lK5AFCj35lf2lOrO5uA6y1+Lr2XGG8F88mt63GtlUXlI0XosZofzRXLdeh1hHrxIvuizKnKeEbaHrQOVrwkEOLWroTHKd4J/1x2rzPIiTwA6vU3sfO7LqXa/TD/TMyZWaS9+RbUMWXJMOUXLJZOlChKAqh6vbfzvZIDFcw9lDT37+Vy85rx4WpbLvXRfDXhilqW6gdfY1RWKEBGru6dATqp3HaY6BLEqdG3I6uiW0+iail0N+voq66lvEUaElCqyNglkAToE3MeUl8wEehWu0BxaEC033oa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Qjas9Cectg9CTjqVJwxvt2FNs7tlErdb4At8yviv5A=;
 b=L4wxBODEiF3Ru4h2TYdRNtej2ri8ShYNCLzTl4peBk6YgDZa1YC5KGZ8X1vdTLaD9M794vkHmOHeDr0Do1kyg1iLPcAncgFg1fu5IU6IRp617KWwCh7zR4UXkPuujmOl9WhMIKHFJpxmalxFXpeBDsoITSze0cr/wYAdFzOeqso=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB3681.namprd12.prod.outlook.com (2603:10b6:a03:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Tue, 14 Sep
 2021 00:52:30 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e%4]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 00:52:30 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Shantur Rathore <i@shantur.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: fix endpoint direction when inputs are more
 than outputs
Thread-Topic: [PATCH] usb: dwc3: fix endpoint direction when inputs are more
 than outputs
Thread-Index: AQHXoxf7R3wBqqczlkKmtu+9UCfOnaucYsoAgAJy2ACAA+nDgA==
Date:   Tue, 14 Sep 2021 00:52:30 +0000
Message-ID: <4ce1f8fa-d26d-cf15-b19b-aaa8e81e9a00@synopsys.com>
References: <20210906120836.4596-1-i@shantur.com>
 <6305c1ef-12e6-781e-3235-cd206d5b2b62@synopsys.com>
 <CABEcMwXdot0yCKt3+Azr4dehA3bP+8dm2azTgzJwT-Xv7tbCQg@mail.gmail.com>
In-Reply-To: <CABEcMwXdot0yCKt3+Azr4dehA3bP+8dm2azTgzJwT-Xv7tbCQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: shantur.com; dkim=none (message not signed)
 header.d=none;shantur.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa36999f-97ec-4699-66be-08d97719ee6d
x-ms-traffictypediagnostic: BY5PR12MB3681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB36810F1DA45417A8A7F0CBD7AADA9@BY5PR12MB3681.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xr+zNIwUbBM6BAMDns6kVji2p0Yn0HuAcfb79qiW0RfaD8X7mMb10zBv0HMPKUTz74eSw6rZdIe7qv0ikgjFCdQwb1iq9Ux5E1bOyX+Lo43SZ+TY21Nx/gYdvEKqNVnRIJf9VL9oUa/l9SpMJpJ+m9O8eV0VPD6jMv3RflDPnwHh3IOCotSkfNfzJwgls2q1Q23NN0lcrXUoZ8tm+wZoOtnhQpYqQxnSRxiTmzPt56Powrnz1zrTwAeyC+FSQgYyBOOhf0SZeBm9ajm1PXMYEfewvSHLkryy9EVlSlQjtBvOA1JaDLCvJtL4eYioOlvH5OdpMYu1ajR82s/1ZT4vtIiboGstrako8jIZJRrfQz7+XJguX9IudVkHfQlr7mNaLFphuzMN8+hmwYcpOOztaKgYfCoRS8xYRcF7kbdsLlfkhKV+XUygY3iePuOrfXQS0/FrncSb87EDuMZ8DmIWoY1RnJmHKCexV9Frkg/PYtxaP6rzZtus7ZEkRVdpSw0mBaDB9GMkPAb/TVT54DtsmT8jWg5wiKi9SBo4KOAfDFNMCirU+UV5PhOVnZBF/ulZAY1Ijv88oHre7RmjX8+twDXesi3RxsnzGVS8Owt3ySFLqzxNI6D/XIA+YZulyosCoXPDyVyPCDUvIwBxg0preg5a/wmql5D42/nrCntlBa4SNiAtbdVQeUlJtiOe7gdcV0OGtWb0R69kH7eBP5nexssYAC0hN9Y/IZNPRUOfxiD9ZMBORFWchL0yKneeGsvA6Y1+yxXa3/mGAMi/DnF3bhBr8Lk1d148hLtcmN+PhojsG9X1rH+gRv7vEuhje+7zXUA60Jxn7jyIWOOukPcIV2XsKaC4nx+EGlxzoCp+CFwLvzs06401Hb0EmCpL2i0OhF74ekD0RC3Ct6P0uZ+Ou59sAK4of2S9ZduqXct9YbE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(366004)(83380400001)(76116006)(38070700005)(66556008)(66476007)(38100700002)(8676002)(31686004)(4326008)(26005)(36756003)(54906003)(66946007)(64756008)(122000001)(66446008)(86362001)(966005)(6512007)(53546011)(6506007)(478600001)(110136005)(5660300002)(316002)(2616005)(8936002)(186003)(31696002)(6486002)(2906002)(71200400001)(781001)(45980500001)(43740500002)(473944003)(414714003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0RabWJjbHRWVWR2TlJwYTNyeWVYRkNQKytyNVQyS3hHcStLaUNmS2gvN1B5?=
 =?utf-8?B?aHljcVZ6ejBKRVljVVNoWElPdkhza2t1YjFFY043L01jaVVHK0EyVjhZUXVp?=
 =?utf-8?B?cWJ6TXRVVnAvbENrbkdLRGlGajNOd2hTOSszRDVtZ1ZiUlMzeUVRWTlkY21z?=
 =?utf-8?B?UTZVREc1SW9oNHdwRGVtSUlVc2tKT3VhbVorMzdrdG9aQnpSMFpBTkxxRzZK?=
 =?utf-8?B?aDZtQUJpU3J6SUplb3ZpdmIveDJ0S1ZoRVFSRm5HQWFuSGpUWTRyakJtNXM5?=
 =?utf-8?B?aVA4NFVaR0RzV0hidTlTK05aaGFSN0JhRitRTVcxY0pzenZkbVFISUZDYlM1?=
 =?utf-8?B?OVJYQ3pnSXZGTmZkaHJHakEwLzBCdjdpcmNLTWJFcXFRNE1kYlZBNjRYbERx?=
 =?utf-8?B?ZStKemNXTU0zUnYzNzVyaHRvWEFLbmdGMXVnOTF4a2NMZGZFd2JQNFBHN29R?=
 =?utf-8?B?RitXYko4M3JTNEgvTlZqQnIvand1a2hZemxOZGI0UlpnNy9vQ2x2b0VzYTVG?=
 =?utf-8?B?azBNZWplMGVTUCtNNDRzK3BPTTJVQTU5MXNNakQ5ekI3dVB4M25IU0I3bjlK?=
 =?utf-8?B?ejJQd3ZWN1ZpMmMwSXliVUl3UEJFS3pmd2pZN0d0c1pKNGZmT2xoTnRKNFFG?=
 =?utf-8?B?MGtFR1M0T1dEdjhzTGlqdDJzZjdIcGw2TEdLSEVSYks1dDBoazVWZ3ZIYTd5?=
 =?utf-8?B?eXRIanBNT3RySHEyd1RFVnRYdkxndlk3WVdrV0p5bWFzSlJ6M0g3OTBSVita?=
 =?utf-8?B?a3FWL256Qlgza0lxMG5XWjhJcFZzZ0NWNXBLdE5yNHZwMDEycXlGN3BWWWZu?=
 =?utf-8?B?R1JJUGYvZlZpY2VCOFVRQzdZWEl3R0p5Y3ZhYzN1ZHBnNXZVWFF1ZFpCSUhz?=
 =?utf-8?B?UWpCS3dVeVp4ZDlNSGxMTkNtNzJwRytkTk1pakhGd2ZLUHA2eFg5SVk2MEZk?=
 =?utf-8?B?OFBlNTFaNjcwTk41MXduVGxFWUZySGdCajJCL2VlTkdsaEZkUnZYNzluajd5?=
 =?utf-8?B?bXNva3pRZXl2SFBCRVpSZ3RUS2FNTm5rVTRqRGJOVWpyQlB6UUVjNlJmclFh?=
 =?utf-8?B?dllVQXNjY1htZWM0cHpoOW1JMm52L2lSa2ZOT2E0SlNLdHh5NTRTZzZNZVFW?=
 =?utf-8?B?SmxmZHdGcGJDR2VsL0FwTmZGTlFLRG5raVlTWWRBQWpGUU9lSlhoQ1JKVlJI?=
 =?utf-8?B?NGNMUzk2c3pjbHkwZVluSDZzcXEyZDdha1JKZDEvUTZPdzZ5NnRldjNZOHU0?=
 =?utf-8?B?aHBMejVlQ0c2b1pQN1hhZjd4Z29EcE5DUXlhTTFTTnFoVmY5THhFMVRXaG1K?=
 =?utf-8?B?ZS9FWnp0K3pDdmpCNnVuWkk4dkI2VjJHSkFxWjQyejk3YjFmK3FBdEZtUVA4?=
 =?utf-8?B?SUNjSFlYc0tvUHNjYnJmdWxEdGs0UnJiQnAweGExQmUxeTdXY1A3TGxmZTFL?=
 =?utf-8?B?QlRCcW5iK09FbWowOU5tbktobW9rL1NWbHJNZ0RnWWtVS04xMHplcm51UFRP?=
 =?utf-8?B?enRQNlhkM0V4UlBkZUszUnBvUEZWeWlGcGtYNC9XTkhXZHZmYkVuVHp3Wjc1?=
 =?utf-8?B?cnJNT3RHVGJmbTg5YWtlcDNCdWpxaDIzUEREZGpZRVhWclRxTGMrKzh4RS9Y?=
 =?utf-8?B?cFZGMDR1bzBzb1AvVXBvTmw4WDhjNFN5b2g5aWZxWmlJcWRVRzROZm8wdDkx?=
 =?utf-8?B?bFFvWUVBTXo0cGtPbzJkcG1nVnkyZkdNU0kzR0M3ZmVPaTQ0aEVQam5PVFQ4?=
 =?utf-8?Q?pEzkYzsLVofnCvgHyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DADF94E1E6CF8644BDFC597F925A549F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa36999f-97ec-4699-66be-08d97719ee6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 00:52:30.4832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okx0PLIaASz134xSdBUV2EeZbytT9sXRe8NUAffFg3FDgnfGt2qaTGTtlSR7muNYH5hwHVpuWfyNWRKcjr1zIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3681
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2hhbnR1ciBSYXRob3JlIHdyb3RlOg0KPiBIaSBUaGluaCwNCg0KSGkgU2hhbnR1ciwgcGxlYXNl
IGRvbid0IGRvIHRvcC1wb3N0Lg0KDQo+IA0KPiBUaGFua3MgZm9yIHJlcGx5aW5nLg0KPiANCj4g
QXMgcGVyIHRoZSBkb2N1bWVudGF0aW9uIGZvciBSSzMzOTksIGl0IHNheXMNCj4gDQo+IFVTQjMu
MCBEZXZpY2UgRmVhdHVyZXMNCj4gVXAgdG8gNyBJTiBlbmRwb2ludHMsIGluY2x1ZGluZyBjb250
cm9sIGVuZHBvaW50IDANCj4gVXAgdG8gNiBPVVQgZW5kcG9pbnRzLCBpbmNsdWRpbmcgY29udHJv
bCBlbmRwb2ludCAwDQo+IA0KDQpUaGUgc3RhdGVtZW50cyBhYm92ZSBhcmUgbm90IGFjY3VyYXRl
LiBZb3UgY2FuIGhhdmUgbW9yZSBPVVQgZW5kcG9pbnRzLA0KYnV0IGlmIHlvdSBhc3NpZ24gYWxs
IDcgZW5kcG9pbnRzIGFzIElOLCB0aGVuIHlvdSBoYXZlIHVwIHRvIDYgZW5kcG9pbnRzDQpsZWZ0
IGZvciBPVVQuIFRoZSBkd2MzIGNvbnRyb2xsZXIgaXMgZmxleGlibGUgYW5kIHlvdSBjYW4gaGF2
ZSB2YXJpb3VzDQpjb25maWd1cmF0aW9ucy4NCg0KPiBJbiB0aGlzIGNhc2UsIEkgdGhpbmsgdGhl
IGhhcmR3YXJlIGRlZmluZXMgdGhlIGVuZHBvaW50cyBiZWluZyBpbiAvIG91dC4NCj4gSSBhbSBp
biBubyBjYXNlIGEgZHdjMyBleHBlcnQgb3IgaGF2ZSBEV0MzIGRvY3VtZW50YXRpb24gc28gY2Fu
bm90IHNheQ0KPiBmb3IgY2VydGFpbi4NCj4gSXQgaXMgYWxsIGJhc2VkIG9uIFJLMzM5OSBkb2N1
bWVudGF0aW9uLg0KPiANCj4gSSBhbSB0cnlpbmcgdG8gdXNlIGEgY29tcG9zaXRlIGdhZGdldCB3
aXRoDQo+IA0KPiAtIEhJRCBLZXlib2FyZCAtIDEgSU4NCj4gLSBISUQgTW91c2UgLSAxIElODQo+
IC0gTkNNIC0gMiBJTiBhbmQgMSBPVVQNCj4gLSAyIE1hc3MgU3RvcmFnZSBEZXZpY2VzIC0gMiBJ
TiBhbmQgMiBPVVQNCg0KV2h5IGRvIHlvdSBuZWVkIDIgTWFzcyBTdG9yYWdlIGRldmljZXM/IENh
biB5b3UgdXNlIDIgTFVOcyBpbnN0ZWFkPw0KDQo+IA0KPiBUaGF0IGluY2x1ZGluZyBlcDAgdG90
YWxzIHRvIDcgSU4gZW5kcG9pbnRzIGFuZCAzIE91dCBlbmRwb2ludHMuDQo+IA0KPj4gQ3VycmVu
dGx5LCBkd2MzIGRyaXZlciBhc3N1bWVzIHRoYXQgRFdDM19OVU1fSU5fRVBTKHBhcmFtcykgaXMg
YXQgbGVhc3QNCj4+IGhhbGYgb2YgRFdDM19OVU1fRVBTKHBhcm1zKS4gSWYgdGhhdCdzIG5vdCB0
aGUgY2FzZSwgd2UgbWF5IHNlZQ0KPj4gcHJvYmxlbXMuIFRvIGNvdmVyIG1vc3QgYXBwbGljYXRp
b24gc2V0dXAsIHRoZSBkcml2ZXIgdHJpZXMgdG8gc2V0dXANCj4+IG51bWJlciBvZiBPVVQgPSBJ
Ti4NCj4gDQo+IEkgdGhpbmsgSSBhbSBzZWVpbmcgdGhpcyBpc3N1ZSB3aGVuIEkgdHJ5IHRvIHVz
ZSB0aGUgbGFzdCBJTiBlbmRwb2ludC4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGxldCBtZSBrbm93
IHRoZSBkaXJlY3Rpb24gSSBzaG91bGQgdGFrZT8NCj4gDQoNCkF0IHRoZSBtb21lbnQsIEkgZG9u
J3QgaGF2ZSBhIGdvb2QvY2xlYW4gc29sdXRpb24gZm9yIHRoaXMuIGR3YzMgc2V0dXBzDQpoYWxm
IElOIGFuZCBoYWxmIE9VVCBmcm9tIHRoZSB0b3RhbCBudW1iZXIgb2YgZW5kcG9pbnRzIGFoZWFk
IG9mIHRpbWUuDQpXaXRob3V0IHRoZSBmdWxsIGNvbnRleHQgb2YgdGhlIGNvbmZpZ3VyYXRpb24g
ZnJvbSB0aGUgY29tcG9zaXRlIGxheWVyLA0KaXQgY2FuJ3QgYWRqdXN0IGVhc2lseS4NCg0KTWF5
YmUgb3RoZXJzIGhhdmUgc29tZSBpZGVhcy4NCg0KQlIsDQpUaGluaA0KDQo+IA0KPiBPbiBGcmks
IFNlcCAxMCwgMjAyMSBhdCAxMjo0MyBBTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQo+IHdyb3RlOg0KPiANCj4+IFNoYW50dXIgUmF0aG9yZSB3cm90ZToNCj4+PiBJ
biBSSzMzOTkgYXMgcGVyIGRvY3VtZW50YXRpb24gKA0KPj4+DQo+PiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly91c2VybWFudWFsLndpa2kvRG9jdW1lbnQvUm9ja2NoaXBEZXZl
bG9wZXJHdWlkZWxpbnV4NDRVU0IuMzE2MTA4MDZfXzshIUE0RjJSOUdfcGchSnFZcjZVODdTTDNy
WXlsaXJGNlcydndOekMwRnQ4WWlad1RsTVR3V2w3YnBhSEdadWgtSk1mT3ZVYUc3ODFHS1pJQmQk
DQo+Pj4gKSwgdGhlcmUgYXJlIDcgSW5wdXQgRW5kcG9pbnRzIGFuZCA2IE91dHB1dCBlbmRwb2lu
dHMsIGluIHRvdGFsIDEzDQo+Pj4gZW5kcG9pbnRzLg0KPj4+DQo+Pj4gQ3VycmVudGx5IGR3YzMv
Z2FkZ2V0LmMgZHJpdmVyIHVzZXMgdGhlIG51bWJlciBvZiBlbmRwb2ludHMNCj4+PiBhdmFpbGFi
bGUgYW5kIHN0YXJ0cyBzZXR0aW5nIHRoZW0gdXAgd2l0aCBldmVuIGVuZHBvaW50cyBhcyBvdXRw
dXQNCj4+PiBlbmRwb2ludHMgYW5kIG9kZCBudW1iZXJlZCBhcyBldmVuIGVuZHBvaW50cy4gVGhp
cyBsZWFkcyB0byA3IE91dHB1dA0KPj4+IGVuZHBvaW50cyBhbmQgNiBpbnB1dCBlbmRwb2ludHMg
Zm9yIFJLMzM5OS4NCj4+Pg0KPj4+IElmIHlvdSB0cnkgdG8gY3JlYXRlIGEgY29tcG9zaXRlIGdh
ZGdldCB3aGljaCB1c2VzIGFsbCB0aGUgaW5wdXQNCj4+PiBlbmRwb2ludHMsIG9uZSBjYW4gc2Vl
IHRoZSBpc3N1ZS4gWW91IGp1c3QgbmVlZCB0byBjcmVhdGUgZnVuY3Rpb25zIHRvDQo+Pj4gdXNl
IHVwIHRoZSBsYXN0IGlucHV0IGVwIGFuZCBpdCB3b3VsZCBmYWlsIHRvIGNyZWF0ZS4gTm8gbmVl
ZCB0bw0KPj4+IGNvbm5lY3QgaXQgdG8gdGhlIGhvc3QuDQo+Pj4gVGhpcyB3YXMgY29uZmlybWVk
IHdoZW4gcnVubmluZyBhIHJvY2tjaGlwLWxpbnV4IGJzcCBpbWFnZS4NCj4+Pg0KPj4+IFtyb290
QHJvY2twcm8gcm9ja10jIGxzIC9zeXMva2VybmVsL2RlYnVnL3VzYi9mZTgwMDAwMC51c2IvDQo+
Pj4gZXAwaW4gIGVwMG91dCAgZXAxaW4gIGVwMW91dCAgZXAyaW4gIGVwMm91dCAgZXAzaW4gIGVw
M291dCAgZXA0aW4NCj4+PiBlcDRvdXQgIGVwNWluICBlcDVvdXQgIGVwNmluICBsaW5rX3N0YXRl
ICBsc3BfZHVtcCAgbW9kZSAgcmVnZHVtcA0KPj4+IHRlc3Rtb2RlDQo+Pj4NCj4+PiBDdXJyZW50
bHkgaW4gbGludXggbWFpbmxpbmUgaXQgaXMNCj4+Pg0KPj4+IFtyb290QHJvY2twcm8gcm9ja10j
IGxzIC9zeXMva2VybmVsL2RlYnVnL3VzYi9mZTgwMDAwMC51c2IvDQo+Pj4gZXAwaW4gIGVwMG91
dCAgZXAxaW4gIGVwMW91dCAgZXAyaW4gIGVwMm91dCAgZXAzaW4gIGVwM291dCAgZXA0aW4NCj4+
PiBlcDRvdXQgIGVwNWluICBlcDVvdXQgIGVwNm91dCAgbGlua19zdGF0ZSAgbHNwX2R1bXAgIG1v
ZGUgIHJlZ2R1bXANCj4+PiB0ZXN0bW9kZQ0KPj4+DQo+Pj4gZXA2IGJlaW5nIG91dCBpbnN0ZWFk
IG9mIGluIGFzIHBlciB0aGUgaGFyZHdhcmUgc3BlYy4NCj4+Pg0KPj4+IFVwb24gaW52ZXN0aWdh
dGlvbiBvZiByb2NrY2hpcCBic3Aga2VybmVsLA0KPj4+DQo+PiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL3JvY2tjaGlwLWxpbnV4L2tlcm5lbC9fXzshIUE0
RjJSOUdfcGchSnFZcjZVODdTTDNyWXlsaXJGNlcydndOekMwRnQ4WWlad1RsTVR3V2w3YnBhSEda
dWgtSk1mT3ZVYUc3ODhESEpTVUUkDQo+Pj4NCj4+PiBUaGUgaXNzdWUgd2FzIGNsZWFyLCBjdXJy
ZW50bHksIGR3YzMvZ2FkZ2V0IGRyaXZlciBkb2Vzbid0IHRha2UNCj4+PiBEV0MzX05VTV9JTl9F
UFMgaW50byBjb25zaWRlcmF0aW9uIHdoaWxlIGVudW1lcmF0aW5nIHRoZW0uDQo+Pj4NCj4+PiBU
aGUgcGF0Y2ggYmVsb3cgZml4ZXMgdGhlIGlzc3VlIGFuZCBlcDYgaXMgY29ycmVjdGx5IGVudW1l
cmF0ZWQgYXMgaW5wdXQuDQo+Pg0KPj4gTm8gU2lnbmVkLW9mLWJ5Pw0KPj4NCj4+PiAtLS0NCj4+
PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgICB8ICAxICsNCj4+PiAgZHJpdmVycy91c2IvZHdj
My9jb3JlLmggICB8ICAxICsNCj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDQwICsr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4+ICAzIGZpbGVzIGNoYW5n
ZWQsIDI3IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4+
PiBpbmRleCAwMTg2NmRjYjk1M2IuLjI3OWM5YTk3Y2I4YyAxMDA2NDQNCj4+PiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
Pj4gQEAgLTU1NSw2ICs1NTUsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2NvcmVfbnVtX2VwcyhzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPj4+ICAgICAgIHN0cnVjdCBkd2MzX2h3cGFyYW1zICAgICpwYXJtcyA9
ICZkd2MtPmh3cGFyYW1zOw0KPj4+DQo+Pj4gICAgICAgZHdjLT5udW1fZXBzID0gRFdDM19OVU1f
RVBTKHBhcm1zKTsNCj4+PiArICAgICBkd2MtPm51bV9pbl9lcHMgPSBEV0MzX05VTV9JTl9FUFMo
cGFybXMpOw0KPj4+ICB9DQo+Pj4NCj4+PiAgc3RhdGljIHZvaWQgZHdjM19jYWNoZV9od3BhcmFt
cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+Pj4gaW5kZXggNTYxMmJmZGYzN2RhLi44
OWEwOTk4YzYxOGMgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4+
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPj4+IEBAIC0xMjI3LDYgKzEyMjcsNyBA
QCBzdHJ1Y3QgZHdjMyB7DQo+Pj4gICAgICAgdTggICAgICAgICAgICAgICAgICAgICAgc3BlZWQ7
DQo+Pj4NCj4+PiAgICAgICB1OCAgICAgICAgICAgICAgICAgICAgICBudW1fZXBzOw0KPj4+ICsg
ICAgIHU4ICAgICAgICAgICAgICAgICAgICAgIG51bV9pbl9lcHM7DQo+Pj4NCj4+PiAgICAgICBz
dHJ1Y3QgZHdjM19od3BhcmFtcyAgICBod3BhcmFtczsNCj4+PiAgICAgICBzdHJ1Y3QgZGVidWdm
c19yZWdzZXQzMiAqcmVnc2V0Ow0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+IGluZGV4IDgwNGI1MDU0ODE2
My4uZDlkMTlkYzBhMjlmIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4gQEAgLTY5Myw5ICs2
OTMsMTEgQEAgdm9pZCBkd2MzX2dhZGdldF9jbGVhcl90eF9maWZvcyhzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPj4+DQo+Pj4gICAgICAgZHdjLT5sYXN0X2ZpZm9fZGVwdGggPSBmaWZvX2RlcHRoOw0KPj4+
ICAgICAgIC8qIENsZWFyIGV4aXN0aW5nIFRYRklGTyBmb3IgYWxsIElOIGVwcyBleGNlcHQgZXAw
ICovDQo+Pj4gLSAgICAgZm9yIChudW0gPSAzOyBudW0gPCBtaW5fdChpbnQsIGR3Yy0+bnVtX2Vw
cywgRFdDM19FTkRQT0lOVFNfTlVNKTsNCj4+PiAtICAgICAgICAgIG51bSArPSAyKSB7DQo+Pj4g
KyAgICAgZm9yIChudW0gPSAzOyBudW0gPCBEV0MzX0VORFBPSU5UU19OVU07IG51bSArPSAyKSB7
DQo+Pj4gICAgICAgICAgICAgICBkZXAgPSBkd2MtPmVwc1tudW1dOw0KPj4+ICsNCj4+PiArICAg
ICAgICAgICAgIGlmKCFkZXApDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0K
Pj4+ICAgICAgICAgICAgICAgLyogRG9uJ3QgY2hhbmdlIFRYRlJBTU5VTSBvbiB1c2IzMSB2ZXJz
aW9uICovDQo+Pj4gICAgICAgICAgICAgICBzaXplID0gRFdDM19JUF9JUyhEV0MzKSA/IDAgOg0K
Pj4+ICAgICAgICAgICAgICAgICAgICAgICBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVFhG
SUZPU0laKG51bSA+PiAxKSkgJg0KPj4+IEBAIC0yMjU3LDcgKzIyNTksNyBAQCBzdGF0aWMgdm9p
ZCBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVycyhzdHJ1Y3QgZHdjMw0KPj4gKmR3YykNCj4+PiAg
ew0KPj4+ICAgICAgIHUzMiBlcG51bTsNCj4+Pg0KPj4+IC0gICAgIGZvciAoZXBudW0gPSAyOyBl
cG51bSA8IGR3Yy0+bnVtX2VwczsgZXBudW0rKykgew0KPj4+ICsgICAgIGZvciAoZXBudW0gPSAy
OyBlcG51bSA8IERXQzNfRU5EUE9JTlRTX05VTTsgZXBudW0rKykgew0KPj4+ICAgICAgICAgICAg
ICAgc3RydWN0IGR3YzNfZXAgKmRlcDsNCj4+Pg0KPj4+ICAgICAgICAgICAgICAgZGVwID0gZHdj
LT5lcHNbZXBudW1dOw0KPj4+IEBAIC0yOTYwLDEwICsyOTYyLDkgQEAgc3RhdGljIGludCBkd2Mz
X2dhZGdldF9pbml0X291dF9lbmRwb2ludChzdHJ1Y3QNCj4+IGR3YzNfZXAgKmRlcCkNCj4+PiAg
ICAgICByZXR1cm4gZHdjM19hbGxvY190cmJfcG9vbChkZXApOw0KPj4+ICB9DQo+Pj4NCj4+PiAt
c3RhdGljIGludCBkd2MzX2dhZGdldF9pbml0X2VuZHBvaW50KHN0cnVjdCBkd2MzICpkd2MsIHU4
IGVwbnVtKQ0KPj4+ICtzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2luaXRfZW5kcG9pbnQoc3RydWN0
IGR3YzMgKmR3YywgdTggZXBudW0sIGJvb2wNCj4+IGRpcmVjdGlvbikNCj4+PiAgew0KPj4+ICAg
ICAgIHN0cnVjdCBkd2MzX2VwICAgICAgICAgICAgICAgICAgKmRlcDsNCj4+PiAtICAgICBib29s
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpcmVjdGlvbiA9IGVwbnVtICYgMTsNCj4+PiAg
ICAgICBpbnQgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldDsNCj4+PiAgICAgICB1OCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bSA9IGVwbnVtID4+IDE7DQo+Pj4NCj4+PiBA
QCAtMzAxMSwyMSArMzAxMiwzMCBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2luaXRfZW5kcG9p
bnQoc3RydWN0IGR3YzMNCj4+ICpkd2MsIHU4IGVwbnVtKQ0KPj4+ICAgICAgIHJldHVybiAwOw0K
Pj4+ICB9DQo+Pj4NCj4+PiAtc3RhdGljIGludCBkd2MzX2dhZGdldF9pbml0X2VuZHBvaW50cyhz
dHJ1Y3QgZHdjMyAqZHdjLCB1OCB0b3RhbCkNCj4+PiArc3RhdGljIGludCBkd2MzX2dhZGdldF9p
bml0X2VuZHBvaW50cyhzdHJ1Y3QgZHdjMyAqZHdjLCB1OCB0b3RhbCwgdTgNCj4+IG51bV9pbl9l
cHMpDQo+Pj4gIHsNCj4+PiAtICAgICB1OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVw
bnVtOw0KPj4+ICsgICAgIHU4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnVtOw0KPj4+
ICsgICAgIGludCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0Ow0KPj4+DQo+Pj4gICAg
ICAgSU5JVF9MSVNUX0hFQUQoJmR3Yy0+Z2FkZ2V0LT5lcF9saXN0KTsNCj4+Pg0KPj4+IC0gICAg
IGZvciAoZXBudW0gPSAwOyBlcG51bSA8IHRvdGFsOyBlcG51bSsrKSB7DQo+Pj4gLSAgICAgICAg
ICAgICBpbnQgICAgICAgICAgICAgICAgICAgICByZXQ7DQo+Pj4gKyAgICAgLyogaW5pdCBpbnB1
dCBlbmRwb2ludHMgYXMgcmVwb3J0ZWQgYnkgaHcgKi8NCj4+PiArICAgICAgICBmb3IgKG51bSA9
IDA7IG51bSA8IG51bV9pbl9lcHM7IG51bSsrKSB7DQo+Pj4NCj4+PiAtICAgICAgICAgICAgIHJl
dCA9IGR3YzNfZ2FkZ2V0X2luaXRfZW5kcG9pbnQoZHdjLCBlcG51bSk7DQo+Pj4gLSAgICAgICAg
ICAgICBpZiAocmV0KQ0KPj4+IC0gICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4+
IC0gICAgIH0NCj4+PiArICAgICAgICAgICAgICAgIHJldCA9IGR3YzNfZ2FkZ2V0X2luaXRfZW5k
cG9pbnQoZHdjLCAobnVtIDw8IDEpICsgMSwgMSk7DQo+Pj4gKyAgICAgICAgICAgICAgICBpZiAo
cmV0KQ0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4+ICsgICAg
ICAgIH0NCj4+Pg0KPj4+IC0gICAgIHJldHVybiAwOw0KPj4+ICsgICAgICAgIC8qIGluaXQgcmVz
dCBlbmRwb2ludHMgYXMgb3V0cHV0IGVuZHBvaW50cyAqLw0KPj4+ICsgICAgICAgIGZvciAobnVt
ID0gMDsgbnVtIDwgdG90YWwgLSBudW1faW5fZXBzOyBudW0rKykgew0KPj4+ICsNCj4+PiArICAg
ICAgICAgICAgICAgIHJldCA9IGR3YzNfZ2FkZ2V0X2luaXRfZW5kcG9pbnQoZHdjLCBudW0gPDwg
MSwgMCk7DQo+Pj4gKyAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4+ICsgICAgICAgIH0NCj4+PiArDQo+Pj4gKyAgICAg
cmV0dXJuIHJldDsNCj4+PiAgfQ0KPj4+DQo+Pg0KPj4gKiBEV0MzX05VTV9FUFMocGFybXMpIGlz
IHRoZSB0b3RhbCBudW1iZXIgb2YgZW5kcG9pbnRzIGNvbmZpZ3VyZWQgaW4gSFcNCj4+ICogRFdD
M19OVU1fSU5fRVBTKHBhcm1zKSBpcyB0aGUgbWF4IG51bWJlciBvZiBJTiBlbmRwb2ludHMgdGhh
dCBTVyBtYXkNCj4+IGNvbmZpZ3VyZQ0KPj4NCj4+IFRoZSBudW1iZXIgb2YgT1VUIGVuZHBvaW50
cyBkb2VzIG5vdCBtZWFuIERXQzNfTlVNX0VQUyhwYXJtcykgLQ0KPj4gRFdDM19OVU1fSU5fRVBT
KHBhcm1zKS4NCj4+DQo+PiBBcyBsb25nIGFzIHBoeXNpY2FsIGVuZHBvaW50IDAgYW5kIDEgYXJl
IGRlZGljYXRlZCBmb3IgY29udHJvbCBlbmRwb2ludCwNCj4+IG90aGVyIGVuZHBvaW50cyBjYW4g
YmUgYXNzaWduZWQgYXMgSU4gb3IgT1VUIGRpcmVjdGlvbi4gU28sIHlvdSBjYW4gaGF2ZQ0KPj4g
YXMgbWFueSBhcyBEV0MzX05VTV9FUFMocGFybXMpIC0gMSBudW1iZXIgb2YgT1VUIGVuZHBvaW50
cy4NCj4+DQo+PiBDdXJyZW50bHksIGR3YzMgZHJpdmVyIGFzc3VtZXMgdGhhdCBEV0MzX05VTV9J
Tl9FUFMocGFyYW1zKSBpcyBhdCBsZWFzdA0KPj4gaGFsZiBvZiBEV0MzX05VTV9FUFMocGFybXMp
LiBJZiB0aGF0J3Mgbm90IHRoZSBjYXNlLCB3ZSBtYXkgc2VlDQo+PiBwcm9ibGVtcy4gVG8gY292
ZXIgbW9zdCBhcHBsaWNhdGlvbiBzZXR1cCwgdGhlIGRyaXZlciB0cmllcyB0byBzZXR1cA0KPj4g
bnVtYmVyIG9mIE9VVCA9IElOLg0KPj4NCj4+IEZvciB5b3VyIGNhc2UsIGlzIHRoZXJlIGFuIGFw
cGxpY2F0aW9uIHRoYXQgbmVlZHMgYWxsDQo+PiBEV0MzX05VTV9JTl9FUFMocGFyYW1zKT8gSWYg
eW91J3JlIGdvaW5nIHRvIG1ha2UgYSBjaGFuZ2UsIHBsZWFzZSBrZWVwDQo+PiBpbiBtaW5kIG9m
IHRoZSBpbmZvIGFib3ZlIHRvIHByZXZlbnQgcmVncmVzc2lvbi4NCj4+DQo+PiBUaGFua3MsDQo+
PiBUaGluaA0KPj4NCj4gDQoNCg==
