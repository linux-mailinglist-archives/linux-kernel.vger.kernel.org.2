Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E243979A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhFASCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:02:20 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47484 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhFASCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:02:19 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 61701C09C8;
        Tue,  1 Jun 2021 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1622570437; bh=FjUXKJi+fb57FdbGM+etnjGDaUJOi0T3PM3IlLhEaNo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SA90Y06qaC1dC7fVwqWvCKYCXOuAvVcrQPKBsbubYs3dfsnPPru+0GiGS5YND7D/4
         jmfFzo/zLRJ4x0/IAmTIFwAV5VQm+J7QUgVux6pCLbUCmBgrQFluW9KnM3bfFAUIjY
         qg7WqdaQQk0eJR+d+UTs304HPPgTIN9C2GeQ2VarCANbEBj/kti8YnkpXO4AKut7We
         RVutmFaPSH86S8agm39nPSIPCTW2iRZTKxphXX8Gff0s2FseGDSrgbPKMOCv8MD7GN
         2xQJou/adDv/3TQTayjzbO52gCEgQioCCsBxnrWAMoLBVXcz37aoSDs5KLcFACpqiE
         dUpNnWDe5ALRA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2CF4BA006D;
        Tue,  1 Jun 2021 18:00:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A6E3940145;
        Tue,  1 Jun 2021 18:00:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="E7B71yxk";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO2SsZa0ysD86rBR2NuYwWCgrJ29wLcJhJIBTHrIFEdSwQW7pA6OdQt/1JePY8CS7+uMgBZ+I/fX8So1FqHdYiNpsZYpdi8RmdaA6G7g0dzsiJrpN3FU16YyzyikA+yYptCFdT0eXp2IRo0kxQRZrhjqVJQczJNqwL47aLDpr06bdbzKrHcytGUjufumoBJg4dpO8qb/yO5mdonMRZfNnKjTRSdJzvDS3kQ9o2udI+lJ/rSQRZL+xhcIzkyh4n04+MEjEvmnwigFZHmJV49fJmvQcj6SXvijg4MOCk4eiqULGllNVwp0DKQSAUr+z2XwOHdogPKwKvvVmMWnMK9jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjUXKJi+fb57FdbGM+etnjGDaUJOi0T3PM3IlLhEaNo=;
 b=jyt8dSdwNGT/dtiuczW9B9wPtdojyI/vrPOOrxCJjzZpD1KMFS2cpY/yx24TVYFbKT4H46XRzKVRagIGn6cAYHxDYl5Hi4cMLRCD66ckpNGr4KjVoSgdetDsnyOc46lFkYwB2+PrnSyuKPNH1r8f0vi3CFV0HBaZP3j+zoxuXjMwIKwRdLeLNmwOJqH//Tz19wQQrZwC+jycFj5VS+8n4ZtHYSdsWBBZckmWc+x+z99UpJS8JWLSeZDWKGElnpJpTt5/3h51S9MsFwPzgXBExoHOMOugCLmgmc6OO8seKCM1pfAPu87TfSTbzaNJYchTFgwxDBTbg6NQwHXM1x+3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjUXKJi+fb57FdbGM+etnjGDaUJOi0T3PM3IlLhEaNo=;
 b=E7B71yxkFAeOyARLhsrs3YPyAcmar9h2YR1AwzJWKGJ3hkI6ToeR6yf4n7AySTKwwVgElXVcthF5gAixWT9H0yAWbGX3TRIdUP60nRjaz93vxJaMJyRyeDoXVvoY9kkKqamTpybCnEll1JTbceIDxuWGHE2TJwqE3wR0Wy03NGI=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 18:00:14 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 18:00:14 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 36/39] arc: Bulk conversion to generic_handle_domain_irq()
Thread-Topic: [PATCH 36/39] arc: Bulk conversion to
 generic_handle_domain_irq()
Thread-Index: AQHXTZkxfUQ8wMUbUUusihfLg00H/6r/hL2A
Date:   Tue, 1 Jun 2021 18:00:13 +0000
Message-ID: <eef09045-783b-9a6f-4adb-512a5ef1c847@synopsys.com>
References: <20210520163751.27325-1-maz@kernel.org>
 <20210520163751.27325-37-maz@kernel.org>
In-Reply-To: <20210520163751.27325-37-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11610245-d336-41ab-eac3-08d925271b53
x-ms-traffictypediagnostic: BYAPR12MB3525:
x-microsoft-antispam-prvs: <BYAPR12MB3525181A37D9CB6ADACB5BCAB63E9@BYAPR12MB3525.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WrvgMdBRGaKScLiseXQHbNPtfMVnO7Psf0dgNONjP65qdmWXNBKXHE3QswNIyx29orHDfSytGNXYnON3b/S/1W9cS31GWAKVA/w16lai2rmXWFAHjmPJhFtBB5x70WsmXr4vZ9hHXz2pex719o3rC7e3k+mTzEAMooYTp2LMwZJy8P4JCSRt7i7qsu/k/38LhEZX+I10OHiDiMH3EcXF3wopcp6xblTpvpQksOR0R82QOgXIION4Lh7THKG+Qj+mnpyq957/h2M3qgAnnWlog0uzEzuyzsd97TenjLPSRtZRZ/Czo872En6v8jgmatqBtQXMWo7R0HOBI7Toz9RlDVuNYMDidooLS9a9+pT41R4dMs0gaYCaOH2+sqxRwoyyCARgQ4YiIXIV+Q+LjonU7ePSmFw3/z8nAvMiwCggZo7wftWPfRpk1d+nmJriJ8BK7NIg81l4mCibeaVxzfagmfCIB96O56Fp2wev7Jm9eMFB1/aqfQ+MC92PnYIKUd0DzXsbkIHa6M1efnfwL1VHcmd7NOJuD47wTF32GjXEwgG5KCOp7LDs8kUbNasFY+26bvUkPRgH+OzXgXIUXdFFtzmA3sx/V4NoTo8jcp/mSaTVKObiV1OoaXYDvmshE1O9ShCR4wb41O1JodxOUIx0VPT/aM+KxbIINZN1WERr0WDyx6E1BjCdQmD503WcUqZAlpQLHTUTsHFg1SDdtPETLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39850400004)(136003)(346002)(376002)(53546011)(6506007)(316002)(110136005)(54906003)(31686004)(71200400001)(2616005)(2906002)(38100700002)(26005)(76116006)(4326008)(8676002)(7416002)(8936002)(36756003)(6512007)(6486002)(86362001)(122000001)(186003)(31696002)(83380400001)(4744005)(5660300002)(66476007)(66556008)(64756008)(66446008)(478600001)(66946007)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?STVrSExOMU9iZ1BKWElBWGtQdU1aUlUwNmN6NWF2SVB0cG9CU0pWTXVzNVVF?=
 =?utf-8?B?ZVI2NzA2alMwZkk5TC8yOGxNZXFVdFlnd2ZBN1RCaWttWGRNNlBwWnNoMTl5?=
 =?utf-8?B?VkllS0QyMTg4MHFsdjVIRWlqenlwajh3N3dYc3JVUnB0YTRsamdkNUg4Rlky?=
 =?utf-8?B?ZU1aSHVPaHp1Zit0NGNESDczdngxTGwvcEFyM2sreEl2NEd5NXR5M2RNK0Fh?=
 =?utf-8?B?blMwYnRNdnYwN2MvaDJWSEd3K3VkejhlZXRveDJsUzJHUTJCTEl5a1V6cUJB?=
 =?utf-8?B?OUs4ZDRBN1RXaHJYMEh0QUpUeVduZUd2K2NnZVprOUhjMjBaelYrQWVDME1l?=
 =?utf-8?B?NXNHUndGNVFWUnNQeCs1aEdHYUFweWlqdmxNTzl0ZHJOYkNRU01SdkhyR2J1?=
 =?utf-8?B?WVZkc1FVWitlOXliNFNEbjlqWDZDeHpZR1lTeVZ4LzlZWXlLUkJWQy9MZDg1?=
 =?utf-8?B?WlBVSG9sT0ZGT0tZQnAwdlBOK0szUHV2ZTRhRDlJUDVuN250dnp1LzhJZjAy?=
 =?utf-8?B?Z3FrcEdFNEcyaDRKbjNGcEh5SHVWZ29wc1FsMVFVTm1abUMrdDJaYkFYa1Zn?=
 =?utf-8?B?aDIvQXhsN1pKeDUwSnB6QVJOSGxHNko3RElkTzNSMVdUeVNSYXVMb3VmMHl2?=
 =?utf-8?B?NTVnOHZIcHVZZEtpUzRXVFlOUlVXTTdzN3NURTlLK2VRd0txR0hZOGtsRkti?=
 =?utf-8?B?d1pZbGZMZ2p4akw0dEh2SU5laXgwUW1MZ3dJLzR2cW93Q1JOaFZQUm9qVDhJ?=
 =?utf-8?B?bVBIV1U3UWI4bmNrc3pYamZIRWQzbDZ1TnFKWGpWcFNlVHp4R0s2RkZvbFpw?=
 =?utf-8?B?Y0FnYmZUWTlsWmxTazJFVXF6dWVsSW92Vm1rUjZ4YzhvOUhmeks5SlVJRGV2?=
 =?utf-8?B?OEo0andTQXhackJRZW5nenVaeDA3bFpycVZJSkV1ZlBDb0RiVE96WFV4T3Jv?=
 =?utf-8?B?bThJWUVIamg5Q21qdnVQdlR3TW95a3JjenJIZEhYQndNazg4M2V5MTY1T2tH?=
 =?utf-8?B?Rm5zbXJ1cHlXVGdBTmJyUStsL09WT2hqY1RBcTVZYTVtTUhBVCswR2xOcTVW?=
 =?utf-8?B?V1YvVzZCalZqTVAwRGE3UEc3NHNsYzJ3MW9rZUFpSkVGbUJZZ2pxTFdhWUln?=
 =?utf-8?B?VUhVcUhvdGRNMEw0TUxQRmtrVnVsTGVwWlNna21UYUY4ekJ4MTQ5RDR2TEhN?=
 =?utf-8?B?N0F0c3NzQ3F2WFR1dVZNd2VaSG1CRmtsY05Lb3NGUURCcDhQR0k2SE5nTkk1?=
 =?utf-8?B?Q2EwQUh0Yy9xcVRoVDFvT0crYnZNOGdnVHhxeVB5WjYzOVBmS25rcEIycE5L?=
 =?utf-8?B?QlNJOFpINFVBMUhCcmVzbW55WGNDRDQxcFNjRzZ4Mk9GemNCUjBUVEM5WGRz?=
 =?utf-8?B?SVRUbC9XQloxVWUxYmorMVA3UG1MdjNKajhiYXdxTFhyRzlRSWVxdVUvK1hZ?=
 =?utf-8?B?dHVqTFlnQzNuWGF3dTBxSWlvZ1NRcVhKbUh4ZUZkUjhzVkdocERrYUhuV3VH?=
 =?utf-8?B?VisvT3J5Y09nMXNoR3ZxSExXOWZONU1KZXZYYjJCMFZqU1pUS0EzaVBhc1ZH?=
 =?utf-8?B?SlpsQTl6VWlnQ1M3Ni9Ib3ZHbVFHY2FoVk9CUzJNWk9yazZtMk8vNDNPVEZO?=
 =?utf-8?B?VWtZRVJBdFFRVW5LMkhKeHNPZHhkTW5SVTV1S2hWcDlYODZhbit1Q2pneDFr?=
 =?utf-8?B?NS9wc0tRMGhvbzZFS0tJWWxCSnFXYXE1amR2alpaSEpJT0xMYmkzVXVoeXlp?=
 =?utf-8?Q?b/3WJEKTYJ+vqebpHs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0FFDC8466750D46B43F58DA49FD1F31@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11610245-d336-41ab-eac3-08d925271b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 18:00:13.9853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdhYQgLMI702kOTI1i2UIKPkfYqYQY7PM9IB8W6HZ4o1t8vLHKkey2tXOcK21VU9ZoA91ZXLfUTWQ6YUs3a78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMC8yMSA5OjM3IEFNLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+IFdoZXJldmVyIHBvc3Np
YmxlLCByZXBsYWNlIGNvbnN0cnVjdHMgdGhhdCBtYXRjaCBlaXRoZXINCj4gZ2VuZXJpY19oYW5k
bGVfaXJxKGlycV9maW5kX21hcHBpbmcoKSkgb3INCj4gZ2VuZXJpY19oYW5kbGVfaXJxKGlycV9s
aW5lYXJfcmV2bWFwKCkpIHRvIGEgc2luZ2xlIGNhbGwgdG8NCj4gZ2VuZXJpY19oYW5kbGVfZG9t
YWluX2lycSgpLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwu
b3JnPg0KDQpUaHggZm9yIGRvaW5nIHRoaXMgTWFyYy4NCg0KQWNrZWQtYnk6IFZpbmVldCBHdXB0
YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4NCg0KLVZpbmVldA0KDQo+IC0tLQ0KPiAgIGFyY2gvYXJj
L2tlcm5lbC9tY2lwLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9rZXJuZWwvbWNpcC5j
IGIvYXJjaC9hcmMva2VybmVsL21jaXAuYw0KPiBpbmRleCBhYmY5Mzk4Y2MzMzMuLmY5ZmRiNTU3
YzI2MyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcmMva2VybmVsL21jaXAuYw0KPiArKysgYi9hcmNo
L2FyYy9rZXJuZWwvbWNpcC5jDQo+IEBAIC0zNTIsNyArMzUyLDcgQEAgc3RhdGljIHZvaWQgaWR1
X2Nhc2NhZGVfaXNyKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4gICAJaXJxX2h3X251bWJlcl90
IGlkdV9od2lycSA9IGNvcmVfaHdpcnEgLSBGSVJTVF9FWFRfSVJROw0KPiAgIA0KPiAgIAljaGFp
bmVkX2lycV9lbnRlcihjb3JlX2NoaXAsIGRlc2MpOw0KPiAtCWdlbmVyaWNfaGFuZGxlX2lycShp
cnFfZmluZF9tYXBwaW5nKGlkdV9kb21haW4sIGlkdV9od2lycSkpOw0KPiArCWdlbmVyaWNfaGFu
ZGxlX2RvbWFpbl9pcnEoaWR1X2RvbWFpbiwgaWR1X2h3aXJxKTsNCj4gICAJY2hhaW5lZF9pcnFf
ZXhpdChjb3JlX2NoaXAsIGRlc2MpOw0KPiAgIH0NCj4gICANCg0K
