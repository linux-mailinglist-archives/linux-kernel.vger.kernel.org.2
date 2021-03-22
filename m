Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9611B344923
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCVPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:22:18 -0400
Received: from mail-eopbgr1400119.outbound.protection.outlook.com ([40.107.140.119]:11440
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231516AbhCVPWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:22:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksLyaqoCzrX+bJVPriYwIGTctZaECxYndzQENkyThq4sZ9jqPdX6jg3omd5pG83AQIBIlbj3KNdr9ZueomCtlywNSMIhwrKaWJs/L7BRDGcKYme+98j92l8jj2RTgADcWDPQyGwskxCawqKUxJKGD1x9f+X7kWt4LxYfVtaPidTePsqUSvPSkob+/s+6/yEoUoMkeNC2TkMPy2KL76HgMiNyKpmTgCvz6Gi/Bs6pmOViI3ldvVcGsapHwx3/WRJGBjJtdgudWikQkoE+HcOHOeFzfU0t4RwK7DZLiuT6GlhH+LCGiNDVsZDgxlu0T7a3yblntUmFzUfAGogqHGqbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYUOnWcJZleQa/CqUmOeH35j7Hjj/NDooZ45rBxOZf0=;
 b=hzHHjp7i9WRQTqXHuMpNx7flPXVxvyPjSG4v3UufbC7qe2fONbHOjnBE4B0eY+hXGlDDNmyMB0lTdZ2PwBllWgHp4UjPzxCrVA1HW1F6DEyuGWKjar5NlgElffAbjdAz9ROO8ZbC/egtdptNEgnJP+qOWS5jiiA0kYek/QNY5XlH5ERinSh5BtIhwKhQkomgLeGFRqSM7l6UC2Gmt8ipFKJv/87grjoPQ6BP6ePO63KjbO7ealD2xKNPIFfqXUK6kTOX9/KJEkqvx4EtlnPXIDS+m44x+NUabnVZEdGMjZc9/NQr5Cxw7Sn4dgKVFKKcj1MCHEmtL35oR6O+9JIzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYUOnWcJZleQa/CqUmOeH35j7Hjj/NDooZ45rBxOZf0=;
 b=eojalV9f4Wy5AeEdVAZsSZwaTOrMbvNs2zyr37Af/ppDmG8VHr2Gezz1m/KNnj9PWfvIxUQ8BOjqNklM5fNolmyD5bYeCrLb5FzzNcpS/iWATvHB+0ydUm1zJPc0HKjBbdF6bSyJxq1UpK4DqODcKovx28YegxF0V7ypszkPlfE=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB2643.jpnprd01.prod.outlook.com (2603:1096:603:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 15:22:01 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 15:22:00 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXHaHa74VwN/FjdkmaampQXlqTRKqQHbmAgAADg8A=
Date:   Mon, 22 Mar 2021 15:22:00 +0000
Message-ID: <OSBPR01MB4773618A38B6797EDDE2E5B9BA659@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1616254985-28920-1-git-send-email-min.li.xe@renesas.com>
 <20210322150319.GZ2916463@dell>
In-Reply-To: <20210322150319.GZ2916463@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75202794-5cc6-4e98-c1e4-08d8ed463d86
x-ms-traffictypediagnostic: OSAPR01MB2643:
x-microsoft-antispam-prvs: <OSAPR01MB2643137C2233F8F03D639F9BBA659@OSAPR01MB2643.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y2n+p6P7prA0jBUn/VHbstciTKHt6qs+FW5t3uOJXS8Rlx7/fdnr5JQurgd/sDhwQ+vev1UmzkdSgdDmaVKf54f09y5qjLiWVOpRCLxmp3q6A7p3RH7gZlVLu1ypWyH2J7wFuWgnRjbi5ZB9+LDcF6kX47qOKQ87L9es+NWtM/7Y51zUdL8jQfhaWm7iT7bnsTMdmWCGoxr0jpFyojwqv6xR8mC8oFO2Gy6jc7DQkQGiYVNrd4Pq75r+jouWgK/SNz4wKLritB31n0aI1j6Thy5r5ZG3kLF/ZowyOiPAjtnFViMPy1+Z+wqezHVlxJL0ScW8Q86CuafcesgVQDa2hymATriKtXzs2NqO5dfBq9AOQrvmiwJE+qd7PhLfNa0WsTO29gpZPLmTcXlhzyubrdgT8RsqoPXexh3iAauB047oEZadkZIP6LST1T3WEnswh2M45R6WZU/tQjDZX/pMzuWSVIU2AGmA42kFijnYQBsziAYrUe1Cf/Ane37mvPPoAeftsH0iGhIO3CM6AOJ2vVvNegBzNuuxf21dRJ3O49FHFgD3vLeedaggLb+Y69QbD94OnJD13dCAC9uzctyNYbJKulXtea7nmOw7gZmgMncKVW9X+IxJwaS428ttOZzFr6V/0qNDddfmZpRQWORfomjVTb5EDT2Akd84jrob9uFTaEe6kYvk9SdT/Sn/ocaRapPOqg+N67kyQIdxUk3OTA0Snk684OiDC2pvIeumWcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39850400004)(66476007)(66556008)(52536014)(54906003)(71200400001)(64756008)(76116006)(66446008)(186003)(86362001)(478600001)(4744005)(5660300002)(316002)(33656002)(66946007)(8936002)(26005)(6916009)(8676002)(6506007)(55016002)(4326008)(9686003)(7696005)(38100700001)(2906002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VldTZEc3Qk1PelFXeFBlV1FRYVVCK3VaNUQwdWhvZWRwMDdyMGJPTWZQUzdp?=
 =?utf-8?B?YlQ0YS8wbVdtYmJHRFU2VTBHYWFDblFRaTJ3b2xZeDhGWHJjNTZScGdpRFdN?=
 =?utf-8?B?a25EMVpPMFc3N0JmOElvZjBDaGFBZks1ek5aaUUxWTBVa2pRZU1BdVQvNEF6?=
 =?utf-8?B?cFNOT3dUZ3g5M3laSHZpZkNZYUZYNW1FYmk2eWZ3amJ3Zjhzc2Z1WTNWM3BY?=
 =?utf-8?B?TDhIQkY5MmtQQWlFMTZJd3BqTGVZV01WTjRlbW9PLy9oTFhFdFYrbDVNVWsw?=
 =?utf-8?B?cDgwUU5nNmVocElITFFNU21aV2RVMHZBdlRUakVDMGFtS0lnbldvbnBxR2c3?=
 =?utf-8?B?UXpkbHlvejB5ZjgzUzF5U1J2azlQbVQreDgxYTlFb1NIY0gwUnNKQStqMHZN?=
 =?utf-8?B?YzlrMzZHaEN3bjE5cXBwYjJwS0E5aGhPMFNSRkpZY2tZQ2oxZ213Z2xNYmxX?=
 =?utf-8?B?eVMxald5NlFoY0UwRmMrTjUvSnlSaytDUGx0SVlRclIwN256UHR6ZU1lTDkr?=
 =?utf-8?B?ckpzWlBCOTcwMHZsUnVrakJNNExFZExwNzducmEyWTg0RDZJZHkzM1lQam4z?=
 =?utf-8?B?R3FxVjZubzZlNlZ4SzVCV1FiVjE1Y1EyNlFNdlllQnZGMGNEV1ZwUEExWXJm?=
 =?utf-8?B?WW5PbkpQVUxRTFBqTVV6M3hCb3Jwbk43dlZGenNibGxWZW9FU2lVWTJlRUFl?=
 =?utf-8?B?Rm5SMmsxR0Jnc3lkTWcvbTZrLzJRMHZIKzBUWXpkRDg5WCtQVjZUZmhpYUly?=
 =?utf-8?B?aW8rdVM4WFE1d3E3Q2RhTi8vazNZanBpbWVWNnVLTmJDVWVzYXpTSHhJSnlm?=
 =?utf-8?B?Z1hpUks3UnJReThyMHB3Z0N4ZURnMFd4M1ZyNE15dUFZTytldlR1aWk2Tzgy?=
 =?utf-8?B?TGlYOUZTMlUzSjBVeDEwM281REJORkFQaTNkYUNSZkVtNzZGQ2w1SERqSDhv?=
 =?utf-8?B?TmFqSDN0QzhPZk1XWnUveitzM1FhMnJhTzJadVNIcFlLcGVuVlhNUnBRTlVV?=
 =?utf-8?B?RG0yYnkyd0pUUWgyNUYzWU5sQjJiK3dSQmZSMVQ0NmhjSVBSMWhpVG5zSi9I?=
 =?utf-8?B?dTgvNGlscG8zL3dvdVdOdjdCbHVYWCtIMkY4MWUwMnVJeDN6NTlrRWp0U3lO?=
 =?utf-8?B?NEsyTU5xM0Y4SmRZS2dyY3p1MDVrS3hINkZ2SGtXL0o2eVhlaU1UK1J1cXcv?=
 =?utf-8?B?Y0UwNlFwR1grc2dmZERsek1TME1hNVhHanlzQmd3NmlZS0lncjdjenE5OXVI?=
 =?utf-8?B?KzhrckFYLzZxdUprSlMzU3h3SEN0ck5Zd3prZ3RMTkVXSTdXUmlOLzV3Tisz?=
 =?utf-8?B?UHNTVDFoV2wwZjN2bXZHUE1uT01ISTI4cG5QRU1mWkhCbTlKSStZMDhONG1l?=
 =?utf-8?B?cW9YclR0cHZ0OWg1NUNLMnRzYlR3aEJuQkxsc0VvMDQ3QnVkUElVMzcvbXJT?=
 =?utf-8?B?S3RRbDJjOXlxSG5uWXYyMm5KV1p5eWJPalJaZXMyTEVVcUQvZVowQnczcGZ1?=
 =?utf-8?B?U0xZWnZKZUN2NVREQnRYSEpGaCtJVUhqNkhzcEZFZEVKejE4b2drZGpPdnRI?=
 =?utf-8?B?aS9qa0k3cjJWR0d6QW9SS0V0TWZWN0VLUjlsRXNUTmJQN2dsMjRVbkwxK1NN?=
 =?utf-8?B?a2FrYk40UDdmQ3Q5Ky9Ia0NKNXFleXBEbFFTTC8wYkUxRTV0Mnp3a2l5Ukla?=
 =?utf-8?B?NmRYZS9kN0dLYXVFTy9WTVdTM1d6b1RUMFFrU05yWm9qYWI1MXE3NEJRSCtS?=
 =?utf-8?Q?m4Ph/6gdSlSJqfkOzZXFh6vHXlynhWRxTvXl8KL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75202794-5cc6-4e98-c1e4-08d8ed463d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 15:22:00.7681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BwXQBaFb6WaAxJzkW/OzRuRa+x+XuoXHhn4hNiQR3CkrRUEVzJf4tc3OHSgM/LmEQ9l0akC1gBwyNhb8mN1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2643
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSSdtIHByZXR0eSBjb25mdXNlZC4gIFRoaXMgaGFzIGJlZW4gc2VudCB+NiB0aW1lcyBh
bHJlYWR5LiAgV2hhdCBpcyB0aGUgdjEgb2Y/DQo+IElzIHRoaXMgYSBkaWZmZXJlbnQgZHJpdmVy
PyAgSWYgc28sIHdoeSBkb2VzIGl0IGhhdmUgdGhlIHNhbWUgJFNVQkpFQ1QgbGluZT8NCj4gDQo+
IElmIHRoaXMgaXMgbm90IGFjdHVhbGx5IHYxLiAgUGxlYXNlIHByb3ZpZGUgYSBjaGFuZ2UtbG9n
Lg0KPiANCg0KDQpIaSBMZWUNCg0KU29ycnkgZm9yIGNvbmZ1c2lvbi4gVGhpcyBpcyBubyB2ZXJz
aW9uIGJlZm9yZSB2MS4gVGhlIHJlYXNvbiB5b3Ugc2F3IGl0IG11bHRpcGxlIHRpbWVzIGlzIGJl
Y2F1c2UgDQpJIHdhcyBiYXNpbmcgdGhlIGNoYW5nZSBpbiB0aGUgd3JvbmcgdHJlZSBhbmQgSSBu
b3cgSSBzd2l0Y2hlZCBpdCB0bw0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9sZWUvbWZkLmdpdC8NCg0KSSBhbSB3b25kZXJpbmcgaWYgdGhpcyBpcyB0
aGUgY29ycmVjdCB0cmVlIHRvIHN1Ym1pdCB0aGUgcGF0Y2ggZm9yIE1GRD8NCg0KU28gdG8gc3Vt
IGl0IHVwLCB0aGUgbGF0ZXN0IHBhdGNoIGlzIG15IGZpcnN0IHZlcnNpb24gdG8gdGhpcyB0cmVl
Lg0KDQpNaW4NCg==
