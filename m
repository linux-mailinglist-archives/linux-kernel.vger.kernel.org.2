Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB9F3956F3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhEaI3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:29:12 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:55400 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhEaI26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622449639; x=1653985639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VqHs4GSFTlVYa5ivbMgrKwxz983QYY1pIiKLjevueI4=;
  b=T9ASEoH2DMRYabKyzatimNqiL6cVXhD3/tX0oTax/AP6J/RowYQLlAHc
   QeKQfR9NBhy3ZvGRp0efSrlX/KEvbETnw7KCnUbddjBjAHeTPENcNfc04
   NtgNcYpmG2uhETHSWlCY5wH334YnCbUS/Ddle8SZbmuLOtdfvMOQ5rQ8o
   DaJd0kP1gX0rf63e0t1XRmOGlCQWdbrnOyKgoG4NmMBuytoDGH9rDmXQR
   F8Aa2CKUr44v3DUSYwzzPmHG+i5JmhjofCxlw7nZf+fmq4YZGvEBwkDMJ
   J+vgCHYcPeMLxZsWdMZ8zXg29NYfCAMEqJIWKKcLw/bFSzUSG/UwhWj3t
   A==;
IronPort-SDR: xgX5/yHOdjTjaTS/+UiQzsxg/z3Ta5vOEaw0ClgZTE0l6POls1IdX4r06gnKJ1l0HVnFkF3u64
 e09rBNzGLNJX6W/fXkE+8r4h9Muyjc8wSxLoVx7W2coSZjb4Yda5O0HATZ2OZHyDGxN+cubFoP
 F+n42MsqEZubXTXDcv9d3pPg+OtH2B429+ZOFMgy83Mrya15k9ryQBQ7x5wm+yQ4hLcGUPJRsm
 FgIR4XFG2F79I5vT+5WdYKu6PQGcnsHF/rOzsB8lSJMHe1OBQexAhbdiiau5/49OhAV9w62zLe
 FSM=
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="117125931"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2021 01:27:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 01:27:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 31 May 2021 01:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOAO17bGyQE5ET3bMleg/0sJgGudqWqoehA9Dktbhe7l8TVFP35ukVOC5gQoIVJVrV6Mj4sm07CKS93i3Vk0jWKpJrB+T4O5bwAn3L4Joyl32t2t/17Jozu2c/EdWij2lLxlF0p4Qmhl4NRpo+YB4z9YY3CM0CDMZZGE1XtKRuLhcvmaO5r5vZVHW9nK9QbqJ1+Cbeo5vGVxsyMMhXuHvJYyO6siLKBd70Qv6sYmyDN/xhWUpro9RdVPFCLbcM0KJtOvxoBcgpFrbbpXsW6VVaHILyapzL3MkE3nrU68cJ4hY84apJbeUKO6GJrI0qCNwk0aKrb0XgBnGjhvpoKzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqHs4GSFTlVYa5ivbMgrKwxz983QYY1pIiKLjevueI4=;
 b=dKYY4ZAACLttmUBgwsst/L+xOng1EL5dtDLgwf1Os4I9Sis/OQ5z6J1n2kA4YU0uDvXG4er4s4Wl98b504PhUU+rUmDas94tjc2LRCRWRdR8YBmihNpigVvdrWfJc5yqZ0xrsb/qkMivmNKwABUweIjPwlFYHbzqVRCHUNaiSNFEZh29o3YyhDaB5uUATCU6uqXs4sMyaTu4OfrXCRimxjMCdG8Dp3/vipefWB6Tuo6UUwbJs6RKv56LHxDVppkIqaE2HDL0k4SD52KHjLdtzT42k90lpSdylAI86CXR4UibTXgH3J4RLqdm5JsQybO4d78ioZl/5G0JjUHNhUd8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqHs4GSFTlVYa5ivbMgrKwxz983QYY1pIiKLjevueI4=;
 b=Bz8K63GQ9VmnCN7OHyI/Ma0/TKdQJV0cgYtOvCLmXX282L6eN+3BIdHge1lwc3whHvM8UOdumy7mwkDn7m5nR8nlWupxTSr/xMv/2vlLGwBImdkLUWKJI4vbTCmFVjNtONPnYQ5KnT3uHS2YeG379+QM59bXCg5jA1folpnLrFk=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MW3PR11MB4571.namprd11.prod.outlook.com (2603:10b6:303:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 08:27:15 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4173.029; Mon, 31 May 2021
 08:27:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v4 1/4] mtd: spi-nor: otp: fix access to security
 registers in 4 byte mode
Thread-Topic: [PATCH v4 1/4] mtd: spi-nor: otp: fix access to security
 registers in 4 byte mode
Thread-Index: AQHXVfbCLa22TCLAAk20AqtTmXFiQg==
Date:   Mon, 31 May 2021 08:27:15 +0000
Message-ID: <49f5172a-be2a-607e-16a7-0ea30f8a0fe7@microchip.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-2-michael@walle.cc>
In-Reply-To: <20210521194034.15249-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa75d189-04b2-4e54-5454-08d9240de57c
x-ms-traffictypediagnostic: MW3PR11MB4571:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4571057F87E54D024C1F1D8BF03F9@MW3PR11MB4571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djdRjDEHDoEserM2UKDdecf7NO/BPZNZhRJefvG4lzttTqnK6dbqOCqWwEADwAzjDFbhiJPWACZhnv+hzKun0+hV7tMTTLSLOtUytsZevM2OjJlVLgoIm8CHsI4RzW44r0VJ3e423JnIxA/VQroAubXi5mPXSb17dQ5/zgJEYNjGcO3/0houSSkT6v0j6Skr36ZSYa9bXoPO9gGf6sAIDAO7qsUC0ksdiUiuQjuufBmujAv6nJevyKyoVEq0kx6opiGLhdJsAA5rFdO2edp9b83udceZ5mudC+2dOlS/Bi8cg3PsHRfTqqFbMA8DN10Jt5fZLjbn8mXx1ZhCtczisHNn8Z+5PYDdcpl4ZXV22TVKpWKXy4CQL19a32nQzRedSuZdl241QfAZyL2uRmIdvhTAwSiNqAZ0omK9oU0NbI1XdYy+5RHQKKlHKx/huCPOA0ho5W7tapviXS9AzeC7bjN3++NPFIusQG7YwvvMp4d1oRc+e8LE46GP0Y/KwfEJrLJvnzhmiOCDX/Ve2s5INgNwdO2KJMGWz/VbxMKf5tXlyq1HTZGJw/KrweMUqiu1QYMr+uUL2xDNbm0m1ZbwmhnMQG7mCxY1OrdDxlWcgvM56rr6dTRXgeJOf3yg6w5HByzndobTx/s7cvx7jvyUucv81Ej4W2w31O8AbCqS8Y3nF0NknABY1x2h5gCa7y7u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(2906002)(6506007)(6486002)(478600001)(316002)(38100700002)(83380400001)(71200400001)(110136005)(54906003)(122000001)(15650500001)(26005)(86362001)(36756003)(53546011)(186003)(8676002)(5660300002)(64756008)(66446008)(66476007)(66556008)(66946007)(8936002)(4326008)(31686004)(2616005)(91956017)(6512007)(76116006)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bHJZcFdySkdJd0g3R1M5YUY2YlBZSmErdk1lL2VBdkhyd2JnL0RjSFJFL1NE?=
 =?utf-8?B?aEtFaEt1cFRIMitZQnpSUHY0S1ZjRjFPaEhNNmFCUVM5T0ZydUlRWkNsUnox?=
 =?utf-8?B?UnVyMUdGcG9RMmgxOXhPMUxmM2Z1YlRVTHJsYVhteUJ2UUFzdGxMbDQzS1dG?=
 =?utf-8?B?OUhFdmk5RDM1eVFpUmN5aHVESms3MlE3cHNDNEhmZ1RZdXMyK1Y2TFpXSjVt?=
 =?utf-8?B?UEdPL1NxT0ZFcUs5RVJIaS90S3libmNZa1RyQmZDMStBUlBwcEVkbldpeFAx?=
 =?utf-8?B?czJDTlpvWm5XK1ZidkE5eTdmN3ZlWGxveGt6QUF4Nzh1WG90MzAvSk00Y3FF?=
 =?utf-8?B?YzQ1TVBnSEN1RzY5VVJaekxJMFJTaExzSHlvaml2MkpyRkFEWUR5SGFSR2VI?=
 =?utf-8?B?a09EbWI1Ri9FRGJGUGxaSlM0NkI0UkdHMDdrOFpBOVh3SXM4djFvOUJZWURV?=
 =?utf-8?B?ME96eWRUWEt0MGNNVTJmVEh3T1Q5UmgwZXBOV0JwMmpkMUVtVlZxQktINmRT?=
 =?utf-8?B?Mm9OWjVyekxOUmdTY1p5aHNSV2dkdXBFaTFKRlo5RWtEOW84eTFoeURISmdm?=
 =?utf-8?B?bG9TKzNsbXhMNXV2QzJrWVpFQzR0YkNXaWR5eVp5bkVDemlPNUtjczFteVNk?=
 =?utf-8?B?cW51OFlWYjBmNWtpR1pzTWt2VStORzZvazVwR1hWM29LMXljdDZQa3BkWDhJ?=
 =?utf-8?B?UzI3NWhBaVNPZ1BsMWdCVnhEaDhiVzhnWVptQ01rTjB1cTI5QlBIbGJSOHZX?=
 =?utf-8?B?YWpuMTdWUll1d01pQ3RHd2UyS0s1K0x6Mk1jMnl2bjJkc3Z4eGxnei9oZTlX?=
 =?utf-8?B?TzdsZE01VUUyMld1LytPQTdWV2ZzVS9SMjlHSnJLQitsSnh6NUFiYjVlcGFz?=
 =?utf-8?B?RmxQMllIVlgwc0Eyb1E0UnhqMVJRd3FHT3BzaUFLb1craGMzRzQ4LzlLOXE0?=
 =?utf-8?B?RzBqanNicCt4bWl6OFlDdllISDc2cFBseUtGcnF1VnJTSnE3d3VUMThMTERE?=
 =?utf-8?B?YVozODZRaGFTNFR2RmlEL0JmNm4vMXliZHhMcStSaFVCRVd2NHk2QUNyL3Zr?=
 =?utf-8?B?bGRqWGlLQWVOMkwwSHBUSHpaT0ZWOVFlRTcxamJhK0EzeDNZVEt0eTRlNXJy?=
 =?utf-8?B?Z3liMGpta3JiaS94SWVkZWh2RWZ1cW50cndVa1YzaGwxbkhoeGxjT1p6Z21k?=
 =?utf-8?B?QUhvaWpPRDJpMDZsZnk0bDlPMC9xTlBETktXV2V1cS9FQURkU3RueHEwQTF2?=
 =?utf-8?B?OTE4UTBzQzM1bE9xUHlOd0VZVHFjbHAvVWd2aWhnemFKeVdsRWNKM0FKTU1s?=
 =?utf-8?B?QmwyYnFkS2ZMOEJLUnM2eFVkOVNCYVR4SU9SZjJUTk9RUHdIOUYrUFNsRExj?=
 =?utf-8?B?c2Z1aU9FVUpZb2labXNzeXNyc3M1MjNPemJNNjFDcWZYYnZsaFYwQXYxVVA5?=
 =?utf-8?B?Ym95ZDQ3RDhiTEdaK0M4YmZHVFYrSXF5ZFV4SkxseG1wanNieXhIYTlNaFNC?=
 =?utf-8?B?TGg5Uzh6eXcrWURYb2JQdzRFT0dURmxad2JzZ1RsL0hNZ1ZoUlFtRFRZM0ph?=
 =?utf-8?B?ZmJTbmdtSE9zaHBhYTFISXZzQ3RTcFVHNkhwNGNkclUySURLTnB0SnNSb3pU?=
 =?utf-8?B?bm9OTnhMbFM4aUltSFVFdFc4REQ5R1N3Qnl5YlBGUXJieGZpSytFdUxXK3Bu?=
 =?utf-8?B?NDF6c2E2ZmNEd1RmSldkOGpHZFNBdWdPSkZlTmYwbU9lWDl0aEJMbmVGdW94?=
 =?utf-8?Q?p4zOIEOO2gSaFofJp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87CA27B3748049499DC75C924B029FB8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa75d189-04b2-4e54-5454-08d9240de57c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 08:27:15.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLJVaanTJu3Lbvakf1W9ZheBYhtBFNyOONzYmgZPzQ/VhzUOz8k2oBo42i/UJYPA1g37rYOtdqNSwqWrXa2jgrLLy1qxEsEGVNyhHGa/mXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4571
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMS8yMSAxMDo0MCBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgc2VjdXJpdHkgcmVnaXN0ZXJzIGVpdGhl
ciB0YWtlIGEgMyBieXRlIG9yIGEgNCBieXRlIGFkZHJlc3Mgb2Zmc2V0LA0KPiBkZXBlbmRpbmcg
b24gdGhlIGFkZHJlc3MgbW9kZSBvZiB0aGUgZmxhc2guIFRodXMganVzdCBsZWF2ZSB0aGUNCj4g
bm9yLT5hZGRyX3dpZHRoIGFzIGlzLg0KPiANCj4gRml4ZXM6IGNhZDMxOTNmZTlkMSAoIm10ZDog
c3BpLW5vcjogaW1wbGVtZW50IE9UUCBzdXBwb3J0IGZvciBXaW5ib25kIGFuZCBzaW1pbGFyIGZs
YXNoZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNj
Pg0KPiBBY2tlZC1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KDQpSZXZpZXdl
ZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0t
LQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9vdHAuYyB8IDIgLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
b3RwLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL290cC5jDQo+IGluZGV4IDYxMDM2YzcxNmFiYi4u
OTFhNGM1MTBlZDUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL290cC5jDQo+
ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivb3RwLmMNCj4gQEAgLTQwLDcgKzQwLDYgQEAgaW50
IHNwaV9ub3Jfb3RwX3JlYWRfc2VjcihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3QgYWRkciwg
c2l6ZV90IGxlbiwgdTggKmJ1ZikNCj4gICAgICAgICByZGVzYyA9IG5vci0+ZGlybWFwLnJkZXNj
Ow0KPiANCj4gICAgICAgICBub3ItPnJlYWRfb3Bjb2RlID0gU1BJTk9SX09QX1JTRUNSOw0KPiAt
ICAgICAgIG5vci0+YWRkcl93aWR0aCA9IDM7DQo+ICAgICAgICAgbm9yLT5yZWFkX2R1bW15ID0g
ODsNCj4gICAgICAgICBub3ItPnJlYWRfcHJvdG8gPSBTTk9SX1BST1RPXzFfMV8xOw0KPiAgICAg
ICAgIG5vci0+ZGlybWFwLnJkZXNjID0gTlVMTDsNCj4gQEAgLTg0LDcgKzgzLDYgQEAgaW50IHNw
aV9ub3Jfb3RwX3dyaXRlX3NlY3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IGFkZHIsIHNp
emVfdCBsZW4sDQo+ICAgICAgICAgd2Rlc2MgPSBub3ItPmRpcm1hcC53ZGVzYzsNCj4gDQo+ICAg
ICAgICAgbm9yLT5wcm9ncmFtX29wY29kZSA9IFNQSU5PUl9PUF9QU0VDUjsNCj4gLSAgICAgICBu
b3ItPmFkZHJfd2lkdGggPSAzOw0KPiAgICAgICAgIG5vci0+d3JpdGVfcHJvdG8gPSBTTk9SX1BS
T1RPXzFfMV8xOw0KPiAgICAgICAgIG5vci0+ZGlybWFwLndkZXNjID0gTlVMTDsNCj4gDQo+IC0t
DQo+IDIuMjAuMQ0KPiANCg0K
