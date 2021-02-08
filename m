Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6E312CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBHJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:10:36 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:59475 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhBHIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612774469; x=1644310469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N047vM7DJ3HqJKTtm6ELNLrQCVFEfvjZQRZUrBsUvoE=;
  b=yOqG4qyyBCvC+xCOszwQdXDoQ0X68dAjY4WWQdYGHww5/uRKabJRYByz
   RDPZxka5h/fz27Ut1YklWF6RU8yESnhERN0+YhPucHl9ExyHtaHMxqEc5
   zWI9T7Fm7swqWkG9fgNoZmSaTqUpMFGYa7nWAkN/izIebpIaX0SiLNXL+
   a+7TiNBaIEEBgZui1y6l4E1bUryg9NxTobgqYc00Y7hjYJX6ModCGVbZr
   DtIZJbvY0hmdmVySKeMnM/haIynxx3ytQZ3fgRk7oE2msP2txdRqGgE3L
   eoDvVFXVBZuNM+XwCuK0n30WkqK15EGr9Myfvb86MUEP0QDWTFRi5uz0J
   g==;
IronPort-SDR: BTFkdjZmWOj1rIeqjXPxPufl1Z+2ntGfKypfKv+m+eSxFaghlvSly6SkhH+uz0Zm7cssSM0R4d
 aYbW5HS7SUcDpPxqFiD1yCLi6pPsn0WNosbUv5VW60wYbdSj0z3LixgQovTiU7pmOOsWAYPc/c
 nhmT9OvJatvgvrnet+PYES1CJlG83e/UzyQn115J1m8V5art95hrzIB/LFpibQppWWytFt2s8W
 YP8AhkAflJEBCUDPTzcLxy+marA7QnG3CxanpEOOOZ9g/pdsOJPsMLWFb86PsKvNgpJ5O/JrxE
 QDs=
X-IronPort-AV: E=Sophos;i="5.81,161,1610434800"; 
   d="scan'208";a="108373588"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2021 01:53:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 01:53:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 8 Feb 2021 01:53:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXmXeYuCqp0QbvQ9/gIBaJw9T7TjVwH7/UevnomaNGoSVnR/d8mgFDdO2/njII/7LZCQ5eChLAPqyXKP+kuH8whEyAPVvyt05Jd25p+un7/JuB2hrQIANpLpdOcrHKQuG32AqUMNA9zNRwAKRai4upzp4pavCmQswBLfp5rTtT4iXlvjlN2mGe5fUaricLn+W6QbS/acmP78zOfpNOeOuXnv2bjx7S6vA+kq3xdAIUC5+SxMjERGph0/8xLVipmnCFHRzK+tEkwVbvh1hlQKBswULy7U2I6b8WF9Rq7CkdT1Fr9NzyqDpoxqkMydusMyYxI/ktluACQHyKBpnUcR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N047vM7DJ3HqJKTtm6ELNLrQCVFEfvjZQRZUrBsUvoE=;
 b=Qqd3hnEmS7XCxe7aO4SYSbCAmwj6PQSO58F4asDkTEYovhVgvqj7vgjXCSd2T4SYrWYwYK27WrXrFY0EokSdaIBxrntkkOToM428cRYHZVfl+ygnikkb72ke0aionJClRIoYYZo1qa76IpZocZ/Ir3fvaTNn0RMRJb/TreOQQnDI2qm5sfvhngmBpNLD6dgDi4a7CkYoCw1iNH0QBd/p2602mzuqJvxKWDKao1aVdxoOEmCKamZcqpsfynSygBPbSzN90cZeSzt5Hh7OkiZQUF0y9pGImwiDYh01RJgAyZCBd3s5Sejg+0yyqoYkDfzbF3bsVi8LlupXYJknFoSPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N047vM7DJ3HqJKTtm6ELNLrQCVFEfvjZQRZUrBsUvoE=;
 b=seCF0X+ZnaHNMB+Vb3fLWIOvlyzXYad/sn17z3QXOjJah2B6TMd5WvWHZa3ZdN08sITHTdaFMjFuXmuLelh0FxcGY9KUQwh2qk65Q0jsGyXsWctBgDZIwI95arM5ppDW4LvhV78EErHf3Y5mWmtcHhQyQ4EIvW+DYvaDijRKMMM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3197.namprd11.prod.outlook.com (2603:10b6:805:c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Mon, 8 Feb
 2021 08:53:10 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%4]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 08:53:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: configs: sama5_defconfig: add QSPI driver
Thread-Topic: [PATCH] ARM: configs: sama5_defconfig: add QSPI driver
Thread-Index: AQHW/ffTb46hStIiS0m2+C2D73BMVw==
Date:   Mon, 8 Feb 2021 08:53:10 +0000
Message-ID: <7feaac11-2642-720e-4c61-702f36e86194@microchip.com>
References: <20210208082140.10995-1-nicolas.ferre@microchip.com>
In-Reply-To: <20210208082140.10995-1-nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [79.115.63.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a177497-a287-4820-d958-08d8cc0ef661
x-ms-traffictypediagnostic: SN6PR11MB3197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3197717FBCCD60B4FB9ED23DF08F9@SN6PR11MB3197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzNMpTQpq8uz4zNZrHOr6xtlKzJKVE9thHpqe1koTkWvDMLbJ4fS8U4FfM8+XXONu2ZKbuj9O0y9d387QnPZCKtUkYdESg0A3y/xyduCK9pYmZgdKlK5b84xkhGOC/T9aS2QXgvUM84cUPQsh2bQM0saHMFxGAVx7EimwDPkbc/d6Maezf/UYWwPMUI8b9WSt7kXvsPerbfIeCnnuCQMo/gXaS/l2W67yjNsje8nhzg3QzQgWFHg2rDyQYh6S2iTieNvV+Q+UFy1NkcYZySUSNN1/0P0ukFTJM04sFbhCEXNzroBFSEwCgh5msNAqoEOCI53+pPn5hgH+DrDVO7ZYYsNu/vEAV7gsjleUB3AKaXkUakcahi3z/qIqP+POgeIb64HXlrSYob0FoE3ANSjUglKMp8w26afqhvUIBEnRvrZr5fI6jWsPbMu/sdZwztBq7WriVcwqr0hDRyq4dwYBdTLUgvubp53hCiVFiLH4WmTsaUg4XSstmAZI/xTZSolx6kKaPh6BXYCl9NIonzJBkKwwDjLy8JvFKH29nw1xCHECnJbPmCUFiS8S7iRThTigR33gNrv6G/B/7emgMQj3Ws9DUYVora2jOA7wxvywZ5rwxBhm7mjCsZshty91RTvCNtADVMfNDs3ql6SFGYoSq/TFsZhnMKZ2SMFqzWx1LcJp+VpSKwm4cJq47Wpf6/F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39860400002)(396003)(316002)(66476007)(2616005)(66946007)(478600001)(66556008)(76116006)(110136005)(91956017)(2906002)(86362001)(966005)(26005)(54906003)(64756008)(31696002)(6486002)(66446008)(31686004)(53546011)(4326008)(6506007)(5660300002)(8676002)(6636002)(186003)(8936002)(36756003)(71200400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RU5NaE9KbG9UbDlCNmFIaE9GclQyQzJXaVVUTTN3dEFaSEFjVjhmdFNkM0VW?=
 =?utf-8?B?TmgzUjVibFV6Qm5nT0Y5cjlMajFLaUxBMGZGVVdRaHYrV0dYRUUwL3g5T2Jz?=
 =?utf-8?B?WnV6SHFBNW5YZHBxcUhEMUZ5ZDg5Tm1Jc2sxZHpYeDY0ekx4RUxzUXJCOHFs?=
 =?utf-8?B?dWVKc1dzQkR1RFRvZ3JFRFZ6MUtIdE1Wd1MrRGlEVkVhOEVxY0NiZ3pqQUQ3?=
 =?utf-8?B?eTFqeVVhWDRINlR5TnppZTNWV09zOTJJRERlMmhRU0UrS3ZOajhHV1RNZ1Z5?=
 =?utf-8?B?bW5VemF6VkF5bnh6QSsrYjVrczZmNC8wcU93ZStFTU4zWHlqQ2hQSkU3N1R2?=
 =?utf-8?B?aVplb3d5RHUzVVBZSndWMVVwZ2t2ck5yMEFMdlhadDQ2VFBmd2pNV0huSE9p?=
 =?utf-8?B?b0JPbHZlclJOZDdKc0Q0alRPMkNOeVZRMjZJUGRoSjVuaHh1bVRGTHBJUDNz?=
 =?utf-8?B?MGFjd3lndTlKNUlzMVNPWm9lTi96RDFmT3BUQU5XeEF6UU16TmxjRTJZbWxE?=
 =?utf-8?B?aWdnZ0JlNDFxQzFyQWxPaWxLbWg4YTFHci9ZSWo1SUpUM1RuekJEN08yYWpZ?=
 =?utf-8?B?U2I4R1VobmNiOWhTd0hMbEJ4MkZQZmhtVlVnbTVSSENLbWRHZCtyYllleUNs?=
 =?utf-8?B?bFNCQnlqUWtRRG1pa0lhUTIrSnU2MXg1MU1taTF2dGFCK1hWY2FhbG9iV2pZ?=
 =?utf-8?B?T2IwbEcwVUpqWjVzSk1HNEw3SnZxVDIyb2Foczk5Q0VkaENuWXR4UHhXYzFh?=
 =?utf-8?B?VGw3eFloZ3c2a0laaTlsNDJFVG1BbVNqNWR4OGZWTC9nQTJsRnM1T29QV1Zl?=
 =?utf-8?B?R0JaU1QvWDdCK0lJZnQxNEJiNStLdmo1cHBPTThpZ0tHSURKUlVqNGc4V0pN?=
 =?utf-8?B?SDhkak9wcXZlMG1wMS8rVzhyaTdQUjlxc0hVQWVZbDRkMVF3STlhL2JSSFZX?=
 =?utf-8?B?SUlmMDlMK2MyS1pVUjRvNFhqRWxOZEtQb0c2TlVWU3RXOU5tNmNuQWNYTTlE?=
 =?utf-8?B?cVdBUUJkdGtIYW1QbVlqK2krMlBwcjZDUWh1cGhUYXUzSGtvRllhMElST25P?=
 =?utf-8?B?MFhQR2piRkRtUlh6NWdQdHo4M1lQelp0SnZhZVZ4UEcwQU1Ualo4V2R5QVdO?=
 =?utf-8?B?ZEN2UWpNNXFJMFc0aE1IR0ZwNU1xaThRYUN2N2tYOEp4dFBuTE1hOGwyNE9w?=
 =?utf-8?B?SC9zYnZLVHp2aTMwRDUvRGdueG1EN0xjcVR6ZUJLaDRBUDdGMThzbDFkNzlE?=
 =?utf-8?B?SldOTjlkZW9ZdTlZb3dlMkVUQ0pqTGlZditzM0JYTzA4U0tEQXBoemVwc0dN?=
 =?utf-8?B?blYzRVdhbmlKTUZjZC9kUlBaaGR1OTJVMFFCdG1rdTUwOTRvYW1SNkZ0c3NN?=
 =?utf-8?B?Z1ZuanVKbDlYMmVWVWhqZzhBeUJwVjYrODZROG13TExuaXdDNitMS0NSMHFh?=
 =?utf-8?B?UnkvNVVpTmREaTBYTklUcWR3elAwNzlkSDVZSExoL05VZ2VvT0E4dUdYdHND?=
 =?utf-8?B?cktOMGNIY2VmVUsxcTNmSm9OL2Zaend2VGR1a3BOdjNSVTdvUmFkM1hoWDJX?=
 =?utf-8?B?VTJkWkRmelJjaEdzeFdsaU9CSWZERzA4MlVpSjQ0MVNFTSs2SE1RbVE5RWo3?=
 =?utf-8?B?bHlEVmJlbXdJNUxieGhiWTRTaVZTdGpOZ2NnYW5uaFlrWHpPMmhTR211VTVK?=
 =?utf-8?B?cmJ5UENNenRjQkN3cVJlVU1nd09CRFBJaFlYTVdBbGhlWW5GZGJ6VDNjNFIx?=
 =?utf-8?Q?RXehzfbzuge7odQsP0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DF9CBB4B34A9B47A12E9965FAC36AAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a177497-a287-4820-d958-08d8cc0ef661
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 08:53:10.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbDVpjmDuX7wj/VKCZkZWYeyTRt0s0Prx15jfZ8V55r7QgV2Y/xvGgg4MpLNRHJLjk7mWIZCJ5ZvI2xEr6lnKo9eW3ZgH2JvFKQ6xZRoxNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3197
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi84LzIxIDEwOjIxIEFNLCBuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTogTmljb2xhcyBG
ZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPiANCj4gQWRkIFF1YWQgU1BJIGRy
aXZlciB0byB0aGUgc2FtYTUgZGVmY29uZmlnLiBUaGlzIGRyaXZlciBpcyBuZWVkZWQgZm9yDQo+
IHNhbWE1ZDIgU29DLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xh
cy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVk
b3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC9hcm0vY29uZmlncy9z
YW1hNV9kZWZjb25maWcgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTVfZGVmY29uZmlnIGIvYXJj
aC9hcm0vY29uZmlncy9zYW1hNV9kZWZjb25maWcNCj4gaW5kZXggYjcyYmQzOGExYzQ1Li5mNGMz
YzA2NTI0MzIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTVfZGVmY29uZmln
DQo+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTVfZGVmY29uZmlnDQo+IEBAIC0xMjEsNiAr
MTIxLDcgQEAgQ09ORklHX0kyQ19BVDkxPXkNCj4gIENPTkZJR19JMkNfR1BJTz15DQo+ICBDT05G
SUdfU1BJPXkNCj4gIENPTkZJR19TUElfQVRNRUw9eQ0KPiArQ09ORklHX1NQSV9BVE1FTF9RVUFE
U1BJPXkNCj4gIENPTkZJR19TUElfR1BJTz15DQo+ICBDT05GSUdfR1BJT19TWVNGUz15DQo+ICBD
T05GSUdfR1BJT19TQU1BNUQyX1BJT0JVPW0NCj4gLS0NCj4gMi4zMC4wDQo+IA0KPiANCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbA0KPiANCg0K
