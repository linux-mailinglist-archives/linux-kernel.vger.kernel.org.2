Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400AB33AD64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhCOI0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:26:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61384 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhCOI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615796774; x=1647332774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9815Q8LbPoetogWBLa2orlOpc0ZGgLAY6meaZiA3SwY=;
  b=a9RbCIi50WyuPZwyWoUB8SE9y8kw6kobIuJ9Sr1UbGeUzRmMgEnP/Q91
   IxbwJnIdLBa1SQCCxJwuEOa4NzBnDzuAVwjyK+LjpuroqQpAOTX92RDuT
   tglP5Lq60vn2jJ8RLaZqTSyxbbUufx5E6T5hftoyOh/hDb11tTFQ7NXAq
   4HswLNIulwD00gLzZIEzCyl341SL3qnWWhf9ZzuGsIF+INnBpztvgJs3w
   Q/CcYbxaPrnv6EKfBCVTXiM+Stl7A0xM6klh49NOd/nFSArtmG7XQULNu
   avezL3jG8FOyoKwFY5jFjX+Nmn21s9wVppgAu2oedFmw7CZNpEDfEB66Y
   g==;
IronPort-SDR: DJdvTZwzY7ukHVOtU81DSgYgr0Y8+exvvGXqUKoKQ5GMo+NIUjZN5qNxwVhq+BAEuziAEczPoW
 ti2tNhb2N9MCjMSAcQkPVzGRnwtvDUD97PSjvlIwB5vAaDMpBIr83znnpbpvIp8qPMHnwPS4f0
 HXQHaSWyGB+OBU6bTRL8wnShQTyA6M1J8yvffKMzPqBAJXdJPFoEqSjpQie55j/WP0jDbF3unp
 emeSq+xJLkL3Ir0wjP3D7uWs9ltS75FKHgrN+ZgwlXiykLnjsoNK9dqpESqo2S6Vg6pLO1zdN6
 2tg=
X-IronPort-AV: E=Sophos;i="5.81,249,1610434800"; 
   d="scan'208";a="47523649"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Mar 2021 01:26:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 01:26:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 15 Mar 2021 01:26:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2gQGrGoKYA+1ml6GgUnOHSJU1z1Fn7S10W2rx4nspZ9DCXNXQjabSYMPSua5OlZPY3uT1T9bczvVLDZrBqbTUfUQl85ChU6MgRe2Iz3k4eVh0/YhEK5DAE9M1CJIy1kNYs+cb9bBz9a1etVHjkhhKx2sdWu3xIWOBHkceT7QqcW1maB1qmySoORjlf3+FOypSQpTsjhZJFofYrEZdk4Ssi26OGVsBRjLNhVNObEWrCtOZ9gyx/dqjvJ/Tiy7sTZjRlBOyoUr8JL1RL4nMNxaYnw5ztBSItt0Msc4ua2/ndLLP8yIqc2x7b5tnHa2MWKL2oBwtHPrSsn2lM7sc04cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9815Q8LbPoetogWBLa2orlOpc0ZGgLAY6meaZiA3SwY=;
 b=j/Hr1HGVN52lLN6A6yTiTk0+htudKJTyAP19hpQeBQHpUvT4trVS60n2V8AiStypj1KA2ccvjUOrypcPrUFKRelX4LyU5PE2u2o+27T2QigSJqNb+SkM8wFhpjy4g6iEXS8vwDqRuScWyOSApTHkFFXdSRNeHUh8X1M02x46ROlmSFaCTmWXLcelTU83dmM9I+YP/xzz5KmFaOQM9BvpL4rN0sLUnnTwgXuQ6NRPhJF8UddVyEcF3cQdLOIxEcFH6oC8OtYFJQ6yArTY6ea9SDKZayfBgcT3/jiIX68u1bOw8S85pZdMJGXZJ2gd0vIJLe8ou3LCXaJMCdGWv3FkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9815Q8LbPoetogWBLa2orlOpc0ZGgLAY6meaZiA3SwY=;
 b=Xq/c6eCYeBf7qZaqJYUhFZnNG7uS7DRETkBtKCBH03wFDRGk3steCjGSJdrupaoJbWILMyGCqEE+OUXbKdCII62AI7P19j5BiDxUaBHfFdEA5ja/CiKXnVc+Lp0RIEGCw1VN2YAfDHOThVBAzygiErpmL+UfEM6VJwMR4rPZDEc=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4905.namprd11.prod.outlook.com (2603:10b6:806:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 08:26:11 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 08:26:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/4] mtd: spi-nor: winbond: add OTP support to
 w25q32fw/jw
Thread-Topic: [PATCH v4 3/4] mtd: spi-nor: winbond: add OTP support to
 w25q32fw/jw
Thread-Index: AQHXGXTasCA5v1Asb0eWrA7CFF4dWw==
Date:   Mon, 15 Mar 2021 08:26:11 +0000
Message-ID: <8e7147bb-a9ba-2b4b-abea-69e72ddd82f4@microchip.com>
References: <20210306000535.9890-1-michael@walle.cc>
 <20210306000535.9890-4-michael@walle.cc>
In-Reply-To: <20210306000535.9890-4-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 373edc2f-78e0-47c2-28f2-08d8e78bfd7e
x-ms-traffictypediagnostic: SA2PR11MB4905:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB490563515EFD4D66F2B455C3F06C9@SA2PR11MB4905.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFQnls850rAsPzJ2KGOjJoQdoFuCDLbcykrh45D1qsnqRfK1FW9Qeqsfm4kZrsuQBpgLM/sKLiuOKVHZI+dhueixclXLFfFADP2OehL5w7QxFXqVMm1PJTJi6kHrZXUt12Oqit2uL1dsoQCVY89iDUxZ6skO7AmYLCPsoVuomWSxgDhtqUTNyy+7uFYBw/gv0Clr+i2uIjqJUNltnb3Kpjt2NuXcVkJC1LfWXn6DQUEdpTpXO5DLd5XpY2sd1Yk0ukkyvGFYF5gpxiF5RpWBlEjZnRwMq8x7+xk3J2Z6qKxj0m4xnlMOqPUoys0C/l9d8z/ja0b6yZh0pY9ots5VapDpf/s/7TvqRMmEUvvETwlK2u1Gez/pmq0VbvxNNHR311tSrT812uQBV/RpHvSgj4TRKFn+7XPtN4HpJzPNfj6IfQ5KjW+wu6vVOME82j/9dsP9NSKrlGLI3CrI/v4zm8O+U2IuiC148RXcG5TyGo69ekYWmqnvdiO7BdbioW39XMFfkO7bvIlq64ihZlvf92de5Lmjf6hXoizGlhjqBgZkHnWsa0n7X9jxXoiMVYVRQA5KADvynnWQCQlSHV5g6Av4OZIGlHcU12Ll0SnEgXrufxrfccpZBMYoPGznL8wZCXm9l7T+pqWtsXNN18GDBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(376002)(396003)(136003)(316002)(53546011)(2906002)(5660300002)(6506007)(66946007)(71200400001)(64756008)(31686004)(36756003)(76116006)(91956017)(186003)(26005)(6486002)(86362001)(4326008)(2616005)(110136005)(8676002)(8936002)(66556008)(66476007)(478600001)(66446008)(83380400001)(54906003)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?KzdNSEd2N0tVY2cyRlVFazNJZnJ4Z1J5c0FNUW5WTFpXTys0WUtxK3RSQ204?=
 =?utf-8?B?OVdPUW9uTWFndmNhWlV4Ky83RkJGUzZxWWdzbmhoVmZqZC95VFlkc3NyODlB?=
 =?utf-8?B?Nm0rSkdZd3hWQlZGVE03VzJBc2E1Q0ZRYVBWai9HS2doRVJ6akNKSVhsUGt5?=
 =?utf-8?B?UmV6QjJWQ3BraVN4ODVjWDgyUjFrU2ZndlBqYXl0SHdCTmJoVEw0SXptNjhZ?=
 =?utf-8?B?OVZHc1UvcG83L25Oa2d3UWFtbVV4T0FFenE1UUhNMGE3cEh6RlJVZE5aZVFG?=
 =?utf-8?B?NVNWazBZdWJ0U29iTFdJbmwxR3dtZHZIc2NkVEZKaGhSd2tGaGNKaElHUlgz?=
 =?utf-8?B?OEw3Q2J2Y3p4aGhZSDY1RndoelJzODAzallEVDQxbnJnaTBQNW5vL1ptbjdz?=
 =?utf-8?B?UFB2SWJhNUNJKzNCR055Y1JXYzh0SjVGRkJqR0VmcVdKUGV0THlKV2MwOFpH?=
 =?utf-8?B?OGRnd05xTE91RVNLS1BHNS9sbWIzamZUbjR1NnJIaG9VbjRmQUxqNitFQStB?=
 =?utf-8?B?REl3MWJReE8vclh0OHJGUXN4Z1pseGJVUVVqaHluNUtPcHBIdkt0YTRjNnVR?=
 =?utf-8?B?TzRZaHJhcHBmTmpXdTV6V1dOYkZsNFFZU1hDNW0zY2l1MlRFK1l5NWlKWHdF?=
 =?utf-8?B?TURlN3YySmptUzhkeTJpdTRVMzRLYmtOWXRkY3lTWHhPbXFJQjQ2M1EyUWwr?=
 =?utf-8?B?NDVPY2szSE9kZzkrZHo1cUdRSjRaTjhtU2ZXSjFjcDNXZzZpV3FGZUUwb2xt?=
 =?utf-8?B?djg3V0VRQ2Q4V1B0VzRYWHpDYnVRT0JoeEFjWnFKWTY0RS85eDBIZFJtSlhG?=
 =?utf-8?B?aFJhRkxBRzZEczQxaFdnNStzRkNOekhlTUpFa3B5VmV3cW91aG0wVENuWFhl?=
 =?utf-8?B?WkorTGp2L3Z2NyszUmhqaVVab0prbHdMZWcrYTk2SEhYSlRKdG1Sblc5YjlB?=
 =?utf-8?B?dlRsNmJIQkdKcnJpU29ZTCt3TnMwck1NVHo5amszS1dpQTZUc1d5TUlmN1M2?=
 =?utf-8?B?aGsyQjhYUEdFZHZiT2JHcE4xMnZLck5GUW1IckVmZ1pGME8rVUpOczMwRUFY?=
 =?utf-8?B?YlVXME53aStSajNnZ0lRTCtrSEkvUWpqUFlQQWtwbVB4dXAyOGtPbnUvcXdm?=
 =?utf-8?B?dmJld2JORS9pSGg4QlloUnh6Y2J1Snp3SEJXbVJmYUkrbGZuN21wZEJHZUxR?=
 =?utf-8?B?czRoUkREaDlLTFFsUUEvZW5RTFd5elhJdGtyWUNJNm1aaGliU3A1UkhsVk9v?=
 =?utf-8?B?MFI5UnREV3VoMG5WVVRVUVdYeVMvN2xYYkwrbW16T2JlQVp3L296RkIwNkRS?=
 =?utf-8?B?SmdKQjEvcDBoVWFTc0hTc2xtWGdpWDd1TS9KbFZaVTF6djNDd09rV0ZsRXdn?=
 =?utf-8?B?Znlka0IvU2hCVFVsRzJ0YmtvSG5BcEx5dXdmSThuZlRwa29HTHc5cllVbDlx?=
 =?utf-8?B?d292T0dJaDNHbnVzb0tRWUhrTlNTaHBIMkxIelFjUHRKOUo1WmFSckJlNk8v?=
 =?utf-8?B?Ly9jVE9BWlhmSkNvWk9SNVlOMWFoRTdJalNtMkF4Q014Ykd3YmV4WGF0RnQ5?=
 =?utf-8?B?b0VlYUx1QnBqZXgyd3cybjgyT3BSYW5nT3JiY1JJaHdaUzhEdEZOV3VRdDZL?=
 =?utf-8?B?OSs0UTlDNm84TkJKVGUyZWs0UUR0cXM0enV3dWJ2UW9Ra0dSV2F6VlRIYTE1?=
 =?utf-8?B?YmIrdWx3bklzd1M3bjFpQ1NtNjVNR0JsZk41dExqdjhCejRQb1NCR0pKZ3pI?=
 =?utf-8?Q?BukyDLBypxxoHQP3dE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <460FE0EE404C8240B39A7E652DF21A1F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373edc2f-78e0-47c2-28f2-08d8e78bfd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 08:26:11.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzmr1vxMIQJrhYUJKGKOTANM+ioNZwiuJKY0mfB+zbs8RifW8mqzHcS/uy3nyfkjqiflsHo5NqW3fao1IUlPRQH1JveLJ/Dub4zyPvqQChg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4905
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy82LzIxIDI6MDUgQU0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gV2l0aCBhbGwgdGhlIGhlbHBlciBmdW5jdGlvbnMg
aW4gcGxhY2UsIGFkZCBPVFAgc3VwcG9ydCBmb3IgdGhlIFdpbmJvbmQNCj4gVzI1UTMySlcgYW5k
IFcyNVEzMkZXLg0KPiANCj4gQm90aCB3ZXJlIHRlc3RlZCBvbiBhIExTMTAyOEEgU29DIHdpdGgg
YSBOWFAgRlNQSSBjb250cm9sbGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxs
ZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3dpbmJv
bmQuYyB8IDE3ICsrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9z
cGktbm9yL3dpbmJvbmQuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jDQo+IGluZGV4
IGU1ZGZhNzg2ZjE5MC4uOWEzZjhmZjAwN2ZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL3dpbmJvbmQuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0K
PiBAQCAtNTUsMTQgKzU1LDE4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyB3aW5i
b25kX3BhcnRzW10gPSB7DQo+ICAgICAgICAgeyAidzI1cTMyIiwgSU5GTygweGVmNDAxNiwgMCwg
NjQgKiAxMDI0LCAgNjQsIFNFQ1RfNEspIH0sDQo+ICAgICAgICAgeyAidzI1cTMyZHciLCBJTkZP
KDB4ZWY2MDE2LCAwLCA2NCAqIDEwMjQsICA2NCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQgfA0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX0hBU19MT0NLIHwgU1BJX05PUl9IQVNf
VEIpIH0sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfSEFTX0xPQ0sgfCBT
UElfTk9SX0hBU19UQikNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgT1RQX0lORk8oMjU2
LCAzLCAweDEwMDAsIDB4MTAwMCkNCj4gKyAgICAgICB9LA0KPiArDQo+ICAgICAgICAgeyAidzI1
cTMyanYiLCBJTkZPKDB4ZWY3MDE2LCAwLCA2NCAqIDEwMjQsICA2NCwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFE
X1JFQUQgfA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX0hBU19MT0NLIHwg
U1BJX05PUl9IQVNfVEIpDQo+ICAgICAgICAgfSwNCj4gICAgICAgICB7ICJ3MjVxMzJqd20iLCBJ
TkZPKDB4ZWY4MDE2LCAwLCA2NCAqIDEwMjQsICA2NCwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9S
X0hBU19UQikgfSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfSEFTX0xP
Q0sgfCBTUElfTk9SX0hBU19UQikNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIE9UUF9J
TkZPKDI1NiwgMywgMHgxMDAwLCAweDEwMDApIH0sDQo+ICAgICAgICAgeyAidzI1cTY0andtIiwg
SU5GTygweGVmODAxNywgMCwgNjQgKiAxMDI0LCAxMjgsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCB8
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX0hBU19MT0NLIHwgU1BJX05P
Ul9IQVNfVEIpIH0sDQo+IEBAIC0xMzEsOSArMTM1LDE4IEBAIHN0YXRpYyBpbnQgd2luYm9uZF9z
ZXRfNGJ5dGVfYWRkcl9tb2RlKHN0cnVjdCBzcGlfbm9yICpub3IsIGJvb2wgZW5hYmxlKQ0KPiAg
ICAgICAgIHJldHVybiBzcGlfbm9yX3dyaXRlX2Rpc2FibGUobm9yKTsNCj4gIH0NCj4gDQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IHNwaV9ub3Jfb3RwX29wcyB3aW5ib25kX290cF9vcHMgPSB7DQo+
ICsgICAgICAgLnJlYWQgPSBzcGlfbm9yX290cF9yZWFkX3NlY3IsDQo+ICsgICAgICAgLndyaXRl
ID0gc3BpX25vcl9vdHBfd3JpdGVfc2VjciwNCj4gKyAgICAgICAubG9jayA9IHNwaV9ub3Jfb3Rw
X2xvY2tfc3IyLA0KPiArICAgICAgIC5pc19sb2NrZWQgPSBzcGlfbm9yX290cF9pc19sb2NrZWRf
c3IyLA0KPiArfTsNCg0KU2hvdWxkIHdlIGhhdmUgdGhpcyBpbiBvdHAuYz8gSXQgY2FuIGJlIHNo
YXJlZCB3aXRoIGdpZ2FkZXZpY2UgYXMgd2VsbA0KYXMgZmFyIGFzIEkgdW5kZXJzdG9vZC4NCg0K
Q2hlZXJzLA0KdGENCg0KPiArDQo+ICBzdGF0aWMgdm9pZCB3aW5ib25kX2RlZmF1bHRfaW5pdChz
dHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgew0KPiAgICAgICAgIG5vci0+cGFyYW1zLT5zZXRfNGJ5
dGVfYWRkcl9tb2RlID0gd2luYm9uZF9zZXRfNGJ5dGVfYWRkcl9tb2RlOw0KPiArICAgICAgIGlm
IChub3ItPnBhcmFtcy0+b3RwLm9yZy0+bl9yZWdpb25zKQ0KPiArICAgICAgICAgICAgICAgbm9y
LT5wYXJhbXMtPm90cC5vcHMgPSAmd2luYm9uZF9vdHBfb3BzOw0KPiAgfQ0KPiANCj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgd2luYm9uZF9maXh1cHMgPSB7DQo+IC0tDQo+
IDIuMjAuMQ0KPiANCg0K
