Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55213A11CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbhFIK5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:57:19 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:23112 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238435AbhFIK5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:57:07 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2021 06:57:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1623236113; x=1654772113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QH0dYJ7N+cR77HlQc9zYquJnE5+vf4BC9o409VKCd38=;
  b=uWRpUTTVzJfpOt15gaWz2WVs09wryMQ1OjyMNUmwW6DORVLu+DIPl9Iz
   kl5xmdWEI335Y+D4qhNWGTGQ7hfbLmNYvlV92u6EpomB5HWMQL3tuekMb
   1qSH6W+UpFgsf0rXHvFqTJzB3xf3QnYCscl5ZJWtAbFHKBoYARzcHpMa5
   qQwk82C8JQC0PaxmtpHslLQ0PG84/TYmX6p4GMMWGS7S3mMOSj/REyH6F
   /mQuuuCXo2agJNCM1d6nIgc10rw2CEh+HNwQaKZ3XJvzGs0eQ5PHukKKy
   2h5UlklVs1n9f2XeX5/UL4WBrynZj6cMKeyGk2CE9Lj+iFAmQPiv35eqT
   w==;
IronPort-SDR: bl4E4IQkRxiuuqHKofT+nerSjin2mGuD+dJEEZEcdpzV/079oWgeVirrZCFEofhrKEcMq30kEK
 ugyGf/22wHg0ReQlBI+3U+fhunt26TPo69g4X/uqIZIknsM1ONT1txl+qSyGKr8Sz74NnQl1m8
 y5zlE/v6FvMdnrGroyU1BzBSlxtNehxicB7UCcVqrs5Bv0h1ilujs0gStl5hI+Z65tX88RqaPc
 QhE9Ym7UArEjQzFtlikWovDBXv9U4AQ4KAZLBjWnNior4nXPpzNFg1faLiw0FOhl+Lermo9xe5
 Fz0=
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="32566333"
X-IronPort-AV: E=Sophos;i="5.83,260,1616425200"; 
   d="scan'208";a="32566333"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 18:40:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmO2BBRG2f7QE+ChU3bwaWRHPQrU2SW4woR7THqUDDxG8nL9iPRKOiD1SlPMHUHzhlbgybJQY9dIp1kff5ySKJqtwjf7ZjamOqD1pphL0i0Lj4u8vxrfws/WAn5wwtbp0XiDM27AaNSVJk0TJfnA58PDIgzyftnukTTe01Dh88rU1BdHZQLHMunmJprxNIhXNx8qK6bD/Cv/6yysUCFHOuf7OYsxsDJdCxEtyGD/eEMvxDvSFRcFh71Y5A6G7IayfjipRYJiyDkqaz4ynXSVWp9kaDHoOejGmk3qaS3NnhtcDq7sw2oF+YfqBvVu/kfDvKd4Y3g5FZZ+9Wnula8DXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH0dYJ7N+cR77HlQc9zYquJnE5+vf4BC9o409VKCd38=;
 b=c95LFCviyJG1sPbMveva4v9Va1KsB1YbemBHKjRsBNcd80uQosPSaFgP/Xnjt5qb7gf+bj3TgxROs5lkEA/KoCLGvHMSHCiSY12qANZluhurt4RcIeXaM4R7JYs0tE5DAIL/mWUOjZC3pP2mIHgH8DZaLK3sGvi03x+zDlXiFrXH85aCY8BdcwEkHhVKGaCCUXzRL2PHtZL4Qq1bjxeRD90HymtSQg9IyCZ5lmSC7BgnhVA8gtOIFZeA+yFZZHHbxNX6nDUhlbXdeQr+B6+CSpm++gAWF1OzlkeDOmb0PETja5Wfr3/5CRAcClsY4SyNgeeWmu8jECKtRWnUDI4uDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH0dYJ7N+cR77HlQc9zYquJnE5+vf4BC9o409VKCd38=;
 b=kdTi2pYR5b3CrGCwjC+Oq9/lYymqQULattoGCscL6lkiTnXI8U+jMxSIDtAtY7Pa7fcJMXtpZgCe8T93l7sls9opjbprFrqns0jOlH+Rlmb9m6OM/hyY/RshkUG88t4UtRCyNX42YrJnFjy+lLPFIgrEXsuINmsgyxVjTcAgt5g=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OS3PR01MB6807.jpnprd01.prod.outlook.com (2603:1096:604:12a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 9 Jun
 2021 09:40:41 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::551c:359a:332:906a]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::551c:359a:332:906a%5]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 09:40:41 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Borislav Petkov' <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "'hpa@zytor.com'" <hpa@zytor.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Adding A64FX hardware prefetch sysfs interface
Thread-Topic: [RFC] Adding A64FX hardware prefetch sysfs interface
Thread-Index: AddbPDa/0dTuSZ8EQoejgzf2ST6z3wAOHlgAAGbfuFA=
Date:   Wed, 9 Jun 2021 09:40:41 +0000
Message-ID: <OSBPR01MB203795631B6A90121283C1B480369@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2037D114B11153F00F233F8780389@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YL3UpAZ6wZi6GyAx@zn.tnic>
In-Reply-To: <YL3UpAZ6wZi6GyAx@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [208.127.120.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5adf025-bd86-4dcc-1b2b-08d92b2aa596
x-ms-traffictypediagnostic: OS3PR01MB6807:
x-microsoft-antispam-prvs: <OS3PR01MB6807A607B43AED6D1B6B090C80369@OS3PR01MB6807.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TuMCGZ9jyjJGIUin3OehdyXmRW221mgmADFivJYezJIVWmBH1NTZLQe9lTOdc9MiLcAtSgWG2TCtcTw4ni1yAzXXQGzR+bA3Ofkdu+jJv2fDfRzjzyN3NVpKfQnbKz2iHLN2GdFXxe+YG6n97YO75/p1AfEYMjiTT4cs+fjr173ktFeikp30HTqNDVuB+J9OWDHVMOdWvMpKFBT7Fu0dUeODJvPoFxFCED4eWQ1etfc9CmQGYYjowhXvyDVLZz8DJ9lo9ygBJDW8Wr6G4qfHbuptW/ObDd9+Z3nh/nxaXWrass5WFiLeGnZ63PNC1/0h8zTq4q2/qFUu+rQ+W3bUi3ve6U0yDOq37T50zSnb4B5mfGVSgNt2+FHQRKQijDh4o+aDvjJyW/qwwI9WYj4COGpXCEXoSQ+Fcr/ia3VT2LGs5+bk7jd1uteZ2q5SM2OW5Ei4MgLlhuAg3roWkI6Tv07y+PAw28EVJEB9IkCxlXtGP6fKziqSBuiCCVFKQeNOfDeZXpfmsBVdmKanJBogz9I2wtXsw1ODWLPi+rIK29KA+qkNGWjfkj3L1+pslxwKt72QybXtF+gOEx7RmTYR4z/0dm+ernCIA+g9XiRIs0c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(478600001)(66476007)(7696005)(66556008)(186003)(64756008)(4326008)(86362001)(8936002)(122000001)(8676002)(83380400001)(26005)(38100700002)(66446008)(55016002)(9686003)(33656002)(76116006)(66946007)(52536014)(5660300002)(4744005)(2906002)(316002)(110136005)(6506007)(54906003)(71200400001)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dDZtbDFXZ2VtcWIrMWJKaTVleHlTTndDMFBzUkRWRThta2xndGsrRDhtM2Ry?=
 =?utf-8?B?cDRxNFY3R1dMWjluYks1aFg3RXJ6bjhYbmZIOFF1aU5vWmo1UUxVUjJoOThN?=
 =?utf-8?B?WUg3YjdPdDA1aUxVQTkyUllxSTYzbTFGOFdTZkFrM1pDR1puMForMlJHSy9P?=
 =?utf-8?B?Yi95T1ZsaitsYlFFRUMrenhHTkd1bnZrcVpUZ1pVSllGZjdTWllTM0hNZCtD?=
 =?utf-8?B?K2xUQ3VEWWdEbUozWTdKakRGZ0svd0pRekdHMlBSdml1RC9oZXBmaTFYU01q?=
 =?utf-8?B?cGxUYWJhZ2ZrUVBkdmpIV29zNWFIVFZ3bHlSYnR2bjVtWDB3UlU0c1ZlZ2Vo?=
 =?utf-8?B?MHU4Q3VNQXluTFEzWXNqK0pUMlRFYW0wYlRNQVVBdmxMUnpmQTdzMWF4UklY?=
 =?utf-8?B?Q0lBaHVpaUs0cHc0WDd2QmhEZ1RWMnNBQWROZmVpc0M0S0MxSmVkeUtqbFVX?=
 =?utf-8?B?bExMN0hYVktiejVUam8vYmw4ZHUvWk0rMEVZYlJ0TXZVd1phZlBybGY0Y2dz?=
 =?utf-8?B?dmsvemhrN2JpeFhpNGtDUlVSRE8wQ0wzM01xUmlZTjdnc21ZN1RXYVk5N0p1?=
 =?utf-8?B?dWZmUGpmQ1ZkMVV1QnFvRU82cFJNN3ZEeUU1aWw2TlFDdHU2OWNQSERuME8x?=
 =?utf-8?B?NmlyaWdvS0cxWkdzSHFpSldPS2NtVFQrbm1uM3YzWU9mb295Mm5tY2NYc2k2?=
 =?utf-8?B?WHFTdGFYSGhrZGM1QjRaYnJleGdxZTE0R3hIeTh0Z1ZMcE9ZaEZoYzdsMGxF?=
 =?utf-8?B?bzNUOEk2ckh3am9JZTR1aTZLc2ZuWGVYV2dsSlJiQUQxMEgxUkFPZ0c1RXU2?=
 =?utf-8?B?Mm01Qy9sU2Fja05Ld2piZWVtSlB4QStpTGh3QUtNZVRjTTBzSkhBelkrRjFR?=
 =?utf-8?B?QXZTR0NieWVINWNOK1FIUjNiOUIvNHlWYzBXK3FxS0VPTkNOSkhPWHJqR2Rq?=
 =?utf-8?B?bno5MGpPV0hsUlZPbXJrQWJxdnk4RWtxNVlNTHhaZS9Kd1NHMVRmNlhXYkZQ?=
 =?utf-8?B?Y0I0b1R0UnZyT1N6Y3J5Q2UwZFBDT3pqSlJHdXUrcEFjcmdRY3loU3FBa1k3?=
 =?utf-8?B?Z2xKQUh3UWhJa2w0M2NuVFR4UElxY2FEekRNTHVOZnlDdFgxZ3Z0Y0MzK3BG?=
 =?utf-8?B?WUdJbUNlVnE4Sm8yZ2VYMGRXWWVlTnlJQzJKQnZpWUUzYnNGNGxZUDFFNnQ5?=
 =?utf-8?B?a0Y0VHlaV2RVenJWeWt3d0UzempPd09YMVpFRXZjUWhiQTZXNjhRZTFQa1Jt?=
 =?utf-8?B?KzJ3YjNTTDJobFN6UUxEZGF1b2Q1MVZDTkJDZUl6Z3FHeExBQjhhUlF5MEhS?=
 =?utf-8?B?ODdMTTBXRGdvVGszS2Z4MmMvaFZ0MWZnNjdMOUErTCtkV1Z5eTNlbXNySHdN?=
 =?utf-8?B?LzM1YTRNQkJIWUR6VWJHM0lRL0k3NkVqSzM5SjFaVnN6YnVLTVdTdTNET2lI?=
 =?utf-8?B?dGJwWklrdm51ejlYYXN1VE5nTTVpbnMvYmo0Q1J5UVptRk1MOUlSbkxJcEl0?=
 =?utf-8?B?eU90UGhjZVQvaHZCYy9ocUxzSmVwUEw5bkw5cDVrRldLcVhUeU56WGU2YXA3?=
 =?utf-8?B?ZWMvY3U0TGFBWEhZcUtrRFQycGVmbUdOamlCaGwvTHQ0RWRXamEvQjY0RGtm?=
 =?utf-8?B?b0NsalZ0L1ZadnN6ekxrdVFCNTFNY05BR0NVOTNPRkRiR1Q5WFNLTWxoWU9o?=
 =?utf-8?B?ZnNiMjI0bjk3TUtLbm84UWlUTnlCZlZMNnU2b1o1UytRWWhCRTVuQUcxWThZ?=
 =?utf-8?Q?CeE0DMfUkW1J3tfxhg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5adf025-bd86-4dcc-1b2b-08d92b2aa596
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 09:40:41.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NKNrOu1Wr0CsLny6+R9LfinNMeZXvO3QzkdakPG6ckDpsggsgBihgevsECxVEUWSyJZ9DASBLUmEgOacC/vyUyxTXTzpzWPOFVh53Nq52ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6807
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJvcmlzbGF2IGFuZCBBUk0gZm9sa3MuDQoNCj4gRm9yIHRoYXQgd2UgYWxyZWFkeSBoYXZl
IGEgaGllcmFyY2h5Og0KDQpUaGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbi4NCldlIHdvdWxk
IGxpa2UgdG8gc2VlIGhvdyBjcHU8TlVNPi9jYWNoZSBpcyBpbXBsZW1lbnRlZCBvbiB4ODYgZmly
c3QsIHNpbmNlIHdlIGFyZSBub3QgZmFtaWxpYXIgd2l0aCB0aGUgZGVzaWduIG9mIGNwdTxudW0+
L2NhY2hlLg0KDQo+IFJpZ2h0LCB0aGF0IEknZCBkZXNpZ24gZGlmZmVyZW50bHk6DQo+IA0KPiAJ
Li4uL2NhY2hlL3ByZWZldGNoZXIvbDEvDQo+IAkJICAgICAgICAgICAgL2wxL2VuYWJsZQ0KPiAJ
CQkgICAgL2wxL2Rpc3QNCj4gCQkgICAgICAgICAgICAvbDEvcmVsaWFibGUNCj4gCS4uLgkJICAg
IC9sMi8NCj4gCS4uLgkJICAgIC9sMy8NCj4gDQo+IHNvIHRoYXQgeW91IGhhdmUgYSBkaXJlY3Rv
cnkgcGVyIGNhY2hlIGxldmVsIGFuZCBpbiB0aGF0IGRpcmVjdG9yeSB5b3UgaGF2ZSBlYWNoDQo+
IGZpbGUuDQoNCldlIGFncmVlIHRoYXQgaXQgaXMgYmV0dGVyIHRvIHBsYWNlIGhhcmR3YXJlIHBy
ZWZldGNoIGZpbGVzIHVuZGVyIHRoZSBjcHU8bnVtPi9jYWNoZSBkaXJlY3RvcnkuDQoNCj4gQnV0
IGxldCdzIGxvb3AgaW4gQVJNIGZvbGtzIGFzIHRoaXMgaXMgYW4gQVJNIENQVSBhZnRlciBhbGwg
YW5kIHRoZXknZCBjYXJlIGZvcg0KPiB0aGF0IGNvZGUuDQoNClRvIHRoZSBBUk0gZm9sa3M6DQpX
b3VsZCB5b3UgZ2l2ZSBtZSBpbmZvcm1hdGlvbiBhYm91dCB0aGUgY3VycmVudCBzdGF0ZSBvZiBj
cHU8bnVtPi9jYWNoZSBpbXBsZW1lbnRhdGlvbiBpbiBBUk0gYW5kIHRoZSBmdXR1cmUgcGxhbnM/
DQpJZiBpdCBkb2Vzbid0IHlldCBleGlzdCBhcyBhIGZlYXR1cmUsIHdlIHdvdWxkIGxpa2UgdG8g
Y29udHJpYnV0ZSB0byB0aGUgd29yayB0byBlbmFibGUgaXQuDQo=
