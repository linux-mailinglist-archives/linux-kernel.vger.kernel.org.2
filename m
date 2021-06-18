Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF23AD10E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhFRRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:20:49 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56964 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233592AbhFRRUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:20:48 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3B8DC40F2C;
        Fri, 18 Jun 2021 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1624036718; bh=xMN8wK9yLGPUXdsOVnJLlefzdFZaX66tAMGh34bn3+I=;
        h=From:To:CC:Subject:Date:From;
        b=O26KBoTKLi/qzv2kG+IuX+j4sx1QtHd+h0KZMRrSnXuKitjQmODqjQ13LmARXp0Ed
         yIF8d9s/mu8uJmMrw7gFS0ou4myWntiZRoxGIXBoHHg6ske6RKuq9sibAu1yoOCbOv
         MVCDlhJvFqWpCDraKFGeG18lw96gCvhshIlk9sgbyn8h1pdIIActY9u2oOIiXj8Fr7
         F3c0k/QQ07RxL6aVfAALUb0SCWyw+tmVW1VgOSInAn5QIBsjDOx3oC8jyamVE78o8o
         s329lUm/zSf2D7eSjdk5o/cLXLaH4EmJjkx87eCD2CmN1IKX0Jn+ounstf/xH/0Knx
         ZgJr/XL+K5FPw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CA4FCA0079;
        Fri, 18 Jun 2021 17:18:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DB9AD801B3;
        Fri, 18 Jun 2021 17:18:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="U+s6Fo0E";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9sxLhQVrPinCggtwfWI1H/8h/LTPK497CpSeR+t+oPDhGf8kVnP7AeosvoMHaPf1JiP5iGtB67CzS7Pa54Xk6QEKcfMNW2NfQLFdFgMK9/PHTC6B51wKcOlELtjfUyRJV0XZu6nOD6SxLw1Fx2R18v5fztIlC3kHwYw8iY46q/swFmRFjQc4PShznuy7dVyif03vkV4kCc+8/3bh+586dk60+1zPcjD3YSpBybt088C6gyZwKtLQ/oRWwT4iRIFwyW9+wBlJO8+iiqCWqMpTgsphIjzEZDJRwenrgACCXpxul1OzFXhZOh6goMdli1dHy3EymC3vVV7QE5OqEDHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMN8wK9yLGPUXdsOVnJLlefzdFZaX66tAMGh34bn3+I=;
 b=OtqsliYvKAVTzsmYTFSMAHAyiaUclURzmsgDJ1Rm5zSkTjApvWoARUh68exyRIxQGGFEhsWPbl1m8GdD9ClBGKwVitTRai1Kr7iyv/xTy7g68cfwBZSVscV9AEzX+qR0AJWSarMXycfQQOoK8ZSQ753kGIhqDnhOX7iSJG+ayLoS0ODVh4msEE7z3Kogq5BDhBAOYMvbVTfSn2O0v6/jbzssHEHMC4MNp/VbuwYpJy7He8l113n33lx0KKqZsLrR/MLgGrCUGhF00fKWjtukoQ9AOr2BqOp3f6mqhScqaXzQ0IkRhaO1GQzTTDwzBVSLzypSEMXwWxlRyiZETecGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMN8wK9yLGPUXdsOVnJLlefzdFZaX66tAMGh34bn3+I=;
 b=U+s6Fo0Ew6uxzQRjOL4VmXs4ilZ45IAyeSZkcS0s2nV+JmhnV6N1q3C3Pi9+21M9cUlnpQb9J1lOEYEg8kCGwnjI6mQrSuaWJtL5qmrUyN19By6Fzp/+MotVVfD3EzbRvD4ExNYGVCbsX9aezD76CV955fOstJZuY9gaXWTphic=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 17:18:30 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 17:18:30 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ARC fixes for 5.13-rc7
Thread-Topic: [GIT PULL] ARC fixes for 5.13-rc7
Thread-Index: AQHXZGX1UHtGTBqmUk2TiS+yTS/Z+g==
Date:   Fri, 18 Jun 2021 17:18:30 +0000
Message-ID: <f29fc4e4-77ca-f026-eb1b-c82fab8bb30b@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 704c08b5-17bf-47e2-68fd-08d9327d17d1
x-ms-traffictypediagnostic: BY5PR12MB4116:
x-microsoft-antispam-prvs: <BY5PR12MB411669FFB88D95B73FD14F91B60D9@BY5PR12MB4116.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkOW5AjvoJKdXST3MWodIfTxn4MZUzG6AJ2ROKuXiNo9invaVcFyC8+3RT3/kTKsKayHG/dhnrs6jKxd91k/WbtaUb4w3oI5YPmfygc5Ps0lvuVdVoUctrbP4YHCXepqo1rTgo+ZnFnaj2GRXbpjvEDi2KAZp/NbbrIuGHoxodQQFrGmykaEni5CUzGoQxB1Y/og+QHS3uAzUkLo+uMZocC+iyQjX1NIiu1vQ/+tIgJX3i8J4FrApBg50k/NNYZxhVlUMDs5bG+SHNv+lpZQJfOArWKuTXNQwlvEjlpPruIQxIfylQyCObgzxiZ7MaD9psRW+z0Gp8LUlrZdQFZ2zajOlC8A3b/1dhVbFPcpMP5Ct3fQade7LtRxyHfkiaWLB6FAa1tIOjLSgcSkvKpa4AAog9nwJnuRhPZihls7JtXJiUS/UZg5r3idh7XLmyimK3VxgSvWTMvQQVZ6avGNQpdKNcDILuHT4076yifwyhVgPEAXaMnovPXCYuOkM+t+M4rIkXdyzCwroeYozcWwAGmlMj/gQ4/fb803DvkNvEBr98C9Fau7M1jfouvxdDqUyOHPMhzaXj96yfBvUR9wV0hEsSZHDDbnCBAidw7IDr113WW3R8CEbdWLeHg+xEb3dDsB7G1qrxA4m2xEtJkBIA+6I4OjyMsT/3tF24DxruklsyGrEXUkyN3LdHBxxG0V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(136003)(376002)(366004)(396003)(86362001)(38100700002)(31696002)(66476007)(2616005)(122000001)(4326008)(36756003)(66946007)(64756008)(66446008)(66556008)(6512007)(6916009)(83380400001)(186003)(26005)(2906002)(5660300002)(6506007)(31686004)(316002)(478600001)(8676002)(54906003)(6486002)(8936002)(71200400001)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M241a1J0VEpPMUxJZUErdjZ0RWtqejV3c0lqbUV3T3NBcnowdnVTKzBHak8x?=
 =?utf-8?B?cEd4VjMxQlJaTnhKSm8rdkJZeVJIWkh2YlZ0VzNuNkpva1BKRlVZa2xmaG5H?=
 =?utf-8?B?dXYvVnV6VC9SYmUwNlc1c3Ywc3RpSkNmSEh0TjVFekxnWUJQbTdPTGp3dGJT?=
 =?utf-8?B?aHUyRHpBaklwbW1JRXRCNEJyUmFGUFBPZWVqUm5mYWxzT2lpbFN6Lzk0cFMx?=
 =?utf-8?B?MTBUYXFhNlowbEIzRy91YzcvbmFjRGxuZlhvV0hYQXBhd1NMbE82SFArOTRI?=
 =?utf-8?B?SzlsTnlTVFUwYk1FU1BsaUJSVm4wYW91NEhZRE9nRlErM093eXFSc2VqNVhV?=
 =?utf-8?B?RzNEbG5hODM1WUdvV2YzQnlXM29GbXZYbld6YldSU1NZQ2dpVEZicm5qeXJV?=
 =?utf-8?B?V0FoQkhjMVhsUjB2c1lRZ05LV1BWSGgyZWVJS3c1K0g2VHFETVE2T28zVTNu?=
 =?utf-8?B?Sm5hZjZGdURUWjJUWjl5WEt6dFlCR2YxRE5KRHN0aDJGMEJYSzRVVDYzWWI0?=
 =?utf-8?B?WkFmanVSQkZhaExBa3M5NVMvaENjd2FUU1BzZkZqOHRqOER5d2FkUFNKem5u?=
 =?utf-8?B?TGszODhnNWc3QjBzZGFUdm9zR1EvTnozc2xjNkJhWFFJRndMTTRMTzl6eWFU?=
 =?utf-8?B?U2JiMVhBN3FHdy9vYmp0UE1Kc1FLVnVWcE8wQkxHSHpWWXBlRjZvWldESytQ?=
 =?utf-8?B?dThuVURKVGRNYmE2djk4ZnNxUHdnOG5oUHRubzdyUjk2MFE0WHlQVUJ2NGJ0?=
 =?utf-8?B?UFZ5c0h6UzgwUk5MQVVhUlBtMDdnWHdqTXVMU05nbVlyazUxY3VNbUxUSGVO?=
 =?utf-8?B?MEhTQzNiOGlmakR0RW1kd012eDBzb29LMitNUXkrT1JGY1huL1FZMUJLakJ3?=
 =?utf-8?B?R2gyMXlwRXFMT2JEVjdCUzQvTklObVhrYXRTbG54b0FjZXZGendmaDZnbHR6?=
 =?utf-8?B?L21idVRUTEtzbmhkcWVTdC91WTJQc3Yzem1FUXNPWUxsd0RqOTl0Q09pbWxK?=
 =?utf-8?B?Q1c3NEtDc0UySngvUGN6RUxlUjZ6K1IvR2lpMmJrU1RpSm5EaEhMdGl1V2lX?=
 =?utf-8?B?QVpMU1pCc3h2amdkMXlVSEdiMFQ0MVhTZVFGajBLVkxMVkl6cUR1a2V4QnYz?=
 =?utf-8?B?ZlE2N2Y1Zm9obll5SnNrV3JoSWpnbVJuZ04yZjBmdzBuNmRwa09jQy8vWkpC?=
 =?utf-8?B?WnBBOXl2c0JVbjE5Wjd3QTdzRVAyZWovaEZibGJIdDhiOVB1ODd6bEhPd2s2?=
 =?utf-8?B?NVBQZlNTVjkyeTRncFVDZzdYNWduTHNyOFpNbmJ4aXMvdGJocFpwSjB5ZkRl?=
 =?utf-8?B?MFFPdmpuWXpHRmlmUW5yejRZdk82U0J1SUcyZkt3YnZqRWJOZXhMQng1cCtG?=
 =?utf-8?B?Wm83eGlvdTJBMXlvWVdxbndKZDVzUFFUSUw4ZVFIalMxZmREdmtublM4eUdH?=
 =?utf-8?B?QU5jVHZkNXg0cDVXQm1FbWhDVGNhQyswczhLbDl6Q0poR2x6VkJxaHA3VDRr?=
 =?utf-8?B?a1ovVTJ3NWpMS2t1M0ZNU25velZBWm4vZmVvbXFyVHZUbGRNVExiWlg0ZWZx?=
 =?utf-8?B?UE93UWpsUGNVb1lTZk91WTV5by8zSitjN3JjRGt1UG9pY3h6SjB6M2N2Qmsx?=
 =?utf-8?B?anNHNng5R3c4ZHI4bDBKTGh0b2VZYUF1L21Fc1VuRzBxSlByQTBaRU5FSFQ0?=
 =?utf-8?B?WU9ocmJQV3U1eThCRm1Qby83ZzljMHBNMUtGcCtXRWIxbVZIWjBLQzBnVE95?=
 =?utf-8?Q?ICAPFi4N7qkCQKDKsI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA595BAAEFDF3844854A726068CBA107@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704c08b5-17bf-47e2-68fd-08d9327d17d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 17:18:30.0537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dv9XnIBBRxv29+jQ0wWwzfnqx5yXbdyQlztbVRBncQVbseFnCalVx3oJc4D5Inz/OduiRola/am5wev2Z4e7DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkNvdXBsZSBvZiBmaXhlcyBmb3IgQVJDIHdoaWNoIGNhbiBnbyBpbiBub3cu
DQoNClRoeCwNCi1WaW5lZXQNCi0tLS0tLS0tLS0tLS0tLT4NClRoZSBmb2xsb3dpbmcgY2hhbmdl
cyBzaW5jZSBjb21taXQgZDA3ZjZjYTkyM2VhMDkyN2ExMDI0ZGZjY2FmYzViNTNiNjFjZmVjYzoN
Cg0KICAgTGludXggNS4xMy1yYzIgKDIwMjEtMDUtMTYgMTU6Mjc6NDQgLTA3MDApDQoNCmFyZSBh
dmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogICBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdmd1cHRhL2FyYy5naXQvIA0KdGFncy9hcmMt
NS4xMy1yYzctZml4ZXMNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDExMGZlYmMw
MTQ4ZjhhYjg2NzM0NDA2MWQ1Y2Y5NWVlMWUxZWJiM2U6DQoNCiAgIEFSQzogZml4IENPTkZJR19I
QVJERU5FRF9VU0VSQ09QWSAoMjAyMS0wNi0xMCAxNzozNzowMCAtMDcwMCkNCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
QVJDIGZpeGVzIGZvciA1LjEzLXJjNw0KDQogIC0gQVJDdjIgdXNlcnNwYWNlIEFCSSBub3QgcG9w
dWxhdGluZyBhIGZldyByZWdpc3RlcnMNCg0KICAtIFVuYm9yayBDT05GSUdfSEFSREVORURfVVNF
UkNPUFkgZm9yIEFSQw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpWaW5lZXQgR3VwdGEgKDIpOg0KICAgICAgIEFSQ3Yy
OiBzYXZlIEFCSSByZWdpc3RlcnMgYWNyb3NzIHNpZ25hbCBoYW5kbGluZw0KICAgICAgIEFSQzog
Zml4IENPTkZJR19IQVJERU5FRF9VU0VSQ09QWQ0KDQogIGFyY2gvYXJjL2luY2x1ZGUvdWFwaS9h
c20vc2lnY29udGV4dC5oIHwgIDEgKw0KICBhcmNoL2FyYy9rZXJuZWwvc2lnbmFsLmMgICAgICAg
ICAgICAgICB8IDQzIA0KKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KICBhcmNo
L2FyYy9rZXJuZWwvdm1saW51eC5sZHMuUyAgICAgICAgICB8ICAyICstDQogIDMgZmlsZXMgY2hh
bmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
