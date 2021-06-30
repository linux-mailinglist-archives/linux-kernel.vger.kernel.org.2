Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4F3B886E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhF3Sa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:30:56 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:36438 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhF3Sav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625077702; x=1656613702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YlmdkyBpWXaNG6Ya0JXPcKr/ZJfzfh/9bAkZB7yXTgc=;
  b=sIJAkDZDfiARuGYF4AqDQLuS2B4b0SUPpCGVFT1xez8dgB7m5fjKGCDU
   FJlEUyOJS/wI5hfP9G/UQr+2Tgp+TuGoRpGso7Ab//TibeOclNcICVxP5
   u27/xZGHRqG2c6RDrSTrbMn6H/UV29r/hY0+eS9aRCBwwA3+zgCTql00/
   nTP83mteNYaFYhpjP/eaUhSp/rhOKc1p4+UbCifYDIZ6/R1srmpcHm8gD
   Sks8dCnuvjmX5UuHbbRu0CO/qYfAnQgIK140Itc+Z9ihOjYLccK5i+T52
   MamK9YGuO4cYeIwzncUCbJeL9ibYhEppz26Iv04p+c2c647ztm3a+iLet
   A==;
IronPort-SDR: QaBu1z1G8vT96OiY6lmfS8wxTWiHIjSXFTLghz9p3Dfu7OmOhHkWBxJhQ8ZOlIKAvnV++Onh6m
 pRscxtrQnlXf+4PwFw2XTWqntR4oxnKf26ibAf2NfNXyTGK1QtSxcm164Ob+kGEYOSiVUmpNDD
 UDbZR33uo422kU/yQn3coyI9WGVLlpBpMsaFZuMNq6F0F10kUq5AAOIFPJkbdEJChj7mkxZ9Vg
 7qly2bT2CtJno3Z60SisXichBJo3dc7B6xvLnQinFF1KamZLAeB+OeHl0m1xX0acE2+z7iVgRq
 qJ4=
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="123101132"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2021 11:28:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 11:28:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 30 Jun 2021 11:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrScfAq6SnCqCvGitFZPSEZEGzaWIQ3pEdLr1v1YquErVCHMMXvyDC22VYajJSxpzv14+t8eBUPR8TRfgcXsYU4sSSo4+zFBYDh2dkQguioFJeMsRY9GRl7H5Z2wRTvIl4emwPqHVFQjztExFNgU5znb1rLyYr3eO+8rNPCRrDMDwBmEcyQB3uwlt2Mx5689X2Ify5l7M2BNdMz4uL6lpmbrpIQpCEtWMUv2d2X3S4yV0H3fZAQ/j2lx+M76p+t0N71/2F3qCSE6zM6afw5Orl0NCPC5vqqtFkLCeeQ+spwAvFQWNhMSqGQ8kTAT7xqb0nGYTFPwpCTjnW+ggPPTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlmdkyBpWXaNG6Ya0JXPcKr/ZJfzfh/9bAkZB7yXTgc=;
 b=XyFtOj+LID9eNN5hsxrpKCqr9yeXHav6bKx35Kw7z89Jatjl0koo2vgbE+TJeW6A1btOArr/UDYtmbz26T+Re8NbsioT1R5VtIjPUyeVoOMbDn92eCYRrZiwbj6/plTWX5oY+pSvS2eH+Xqz4i4pT6CHa3tvRUvmZL+7Fp0hs4HJytin+g9cqsnWX2dI+F1y6192w/C++FnwaOgDZ91Y24iJflTBoV5zKaxs0545X/chtZRLPwPBjb1aCkBvs0UW3s6QXn8tvdNJClskTEFXaUUmZW7xabcRUqn29hvv6R5QW0rYmAMxdFqrdMRjTnY6DVyGuLZXuwabNQ+59Ab8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlmdkyBpWXaNG6Ya0JXPcKr/ZJfzfh/9bAkZB7yXTgc=;
 b=UFG/ptlyhyTwPyv7wodB6dM0ehBi3Es3Qjxzfe7kjZ/VWzHxX8zz6Xz3Kw6/OSCLLuMKJZDG9qAFO78dF+WkmROoZVcRdUU2XR6SC/v4kZ3gl151GTzVZRBZEBDHDKkLj1oX/KrU5C+Av2me5Wta2B/OBGHYY1jTfh1s/3Yn37E=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 30 Jun
 2021 18:28:16 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 18:28:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <code@reto-schneider.ch>, <linux-mtd@lists.infradead.org>,
        <sr@denx.de>, <reto.schneider@husqvarnagroup.com>,
        <miquel.raynal@bootlin.com>, <p.yadav@ti.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
Thread-Topic: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
Thread-Index: AQHXa9nZhBHIVrQioUm7jO1Sivr3QA==
Date:   Wed, 30 Jun 2021 18:28:16 +0000
Message-ID: <a5877032-ab30-a85d-cd42-93b75a84ab49@microchip.com>
References: <20210613121248.1529292-1-code@reto-schneider.ch>
 <1ba367f93650cb65122acd32fb4a4159@walle.cc>
 <0328347c-572d-b636-5542-99cb36e9efa9@microchip.com>
 <064317e561f1ad20282efe778f633723@walle.cc>
In-Reply-To: <064317e561f1ad20282efe778f633723@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19843072-d0ee-4b4c-9543-08d93bf4d421
x-ms-traffictypediagnostic: PH0PR11MB5064:
x-microsoft-antispam-prvs: <PH0PR11MB506442F837A6DB82E11863A8F0019@PH0PR11MB5064.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ULfqDtpelXBMRerobqpuQFm0n63E25fotT+R3IponVSgoXJRvNNzxQoh7l9sHhgTvh0wQYHErdT5r4UtZ1dGwdAzvkzFelXcalgFILXALrT1bS1Q3ZLD6KHu1AfZGVckyTvMBBMZu6k3+9w5ntRzkejDANGR3dx58Q2HxLi2sK4wZ9cz7SLJRR8VUTUpqxqnXz970KP8OT7HAAz0Z5biJNhTRaDk3ydGfefRPNsIOxx9EziIeH6VsVCzTy0sFPOWmrxQDuKcF2YnkuNtragUATOayXr+i3Z4P+QjWxXbC+I2ujQ2YcVnZbH03FafuZL9mBrLu8z6K7/SO08swanfFZe+VorKhbv8Y/PlY7PdUkv4G376TkzM+lsfn/1WJCYfGYukmdCYMZyTbLCVcbLGETzw0gWiQFZPW2abnNGW18+F19xKeJC0q5D0VrHjUnqP1apWU1n1FY7SHE7cyXWwwGhWF7VwcI3hH8W3zMnUKED8UDiXENq4pyRcCNNq2ZxRmD5zz34qkLOKhDoxe6gX20v4uZbZV1v2OlGSEAVw/qWoRTfo9BoqG/TZGgET33R9wm62bZANxOOIYB6M0HtgH7fS0vZhZFFyUw9TABLziiFVQN8gj0G+tUjzHtYfUyOS0Zu2j+c6q+DbK0QalZvZ0DYvGKwosN1aSlg4H3L2WPPcdgLqUY4TxyeLo1YGMS573kzAUNdkcxUBzI+nOMoSrG5OsdikdYQmSOMVGv6/gWKLE2hpzFDDFkicQ/+zLhV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(366004)(346002)(6512007)(2906002)(8936002)(4326008)(6506007)(53546011)(31686004)(26005)(316002)(54906003)(6916009)(66476007)(122000001)(38100700002)(36756003)(66446008)(5660300002)(2616005)(86362001)(186003)(91956017)(64756008)(71200400001)(66556008)(31696002)(478600001)(6486002)(7416002)(8676002)(83380400001)(76116006)(66946007)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTBpenQ2YWdEZkl4dUZwY0tkWjJPN0N6VTJBd2hBV1VJQVdPN1RHa01EQlE2?=
 =?utf-8?B?NTk5WndJZmNtbG5hYkhOaE9zeXNReFdHelQyZ3hjYUg5aGdRM2kyd3NBdjMw?=
 =?utf-8?B?dGdNUlhQUHBRNW4yaFRBTXhvZWZSaVZoQXgzLzhrVGxSTlNIdjhMNWZJTTB6?=
 =?utf-8?B?bHZraE04UTlURzAwOVRHRjU1dVR3TVVtdGtPeXYyby85R1kyK0tkb3VqREtQ?=
 =?utf-8?B?WGd5ZXBrYTZMOFZGVk1WaUNabVFxa0dIdnBiWmY2bXRjWE51RFZIb3lhL0FE?=
 =?utf-8?B?YzIrSVNoTGdrQy9vS3ZuZ0M5U2xRMzJMRDV2Vnd4Qy9KL2pHTFNTcEtDdnhE?=
 =?utf-8?B?Q3VWOTBNbHNaK0g0OGFHTnk4ZHFuR0tURGE1OURBRGU4akJVNld6RUNFN21t?=
 =?utf-8?B?aStNZi96eFhzaGpBV24yOU0raTV2Y1Z5U0phU096OHZGUGl3SFVMSENPdTRX?=
 =?utf-8?B?SVplaFY3L3lZdzYzeWUrS3NjbUx0eGRNUUNyd1Mzc0lHUCtrVE9OclN0UEZ3?=
 =?utf-8?B?VmlGQmdmNG9tU0F5QmFjb2xjam9zclQ4bXdMZzdEYjFXamNtVkk4MkYxcmsr?=
 =?utf-8?B?UHgxWEY1b3F3TmF2aGkyd3FWTSszQ2dhRHJudWNRcGVGN2lvK3hZZUpwWXZk?=
 =?utf-8?B?VW1hK1FaeEdWM2dqaHhrNUhWSmNCS1UxL3NPdVZ0TjdwMGx0aE5rWXFjZVZy?=
 =?utf-8?B?c1dvbzZJUWlrUG9JQkZFVHIvZjJtRnB6L2xuK3dOU3JWOUlpMHlqektYaWdQ?=
 =?utf-8?B?MUl4R2FpR3d0b1B1SnVNQWsvQVBNRmtzKzg0VXk4d3BZRmloS0JGZ1FiK2Fs?=
 =?utf-8?B?cTEweW8xTDg5YkpJbHlHZG1CM2tCNzVyM0N6UW5LQjJWamgwV2NMNWg0K1pR?=
 =?utf-8?B?RnZQUVkvR3hEUTZZRktPWEVRQVNqZzBueFFTQ2RweklQbkdFdFRySUk4SFFD?=
 =?utf-8?B?UTBLNVVUZm4yTmV4WWYvYnVOT3Z1M1pRUVRyZXVpOU9ocUNYUWJCYkJZMm4w?=
 =?utf-8?B?STQvQ0twVFNuTXhwK0xkbnh5ajFWTzI3YTViY3Z1eVU3OC9xUXF6MXBSZUdI?=
 =?utf-8?B?VHdJNnlPR3hxbTZJUElVYk9SN3Y5WVpvOHEvaStReThnb1ZQNUIzKzFNWkQ3?=
 =?utf-8?B?YU4vWWl2RFpQVjVjY3czRnZwRmo0RWpITXVtTHhjeGEvcWlPR0t6TUc2dnhu?=
 =?utf-8?B?aVh5SDJ1dU13Z0ZvMXFQM2Mxd2g4dnBjUk1xZmdaNmFsTWg2YTNDQTN5MFI2?=
 =?utf-8?B?cnNCeTlDdE5BS0V2Nm1pazhqRXlYaTlhWGJBSnphcHRJQmNlSUJyOFJaQVhG?=
 =?utf-8?B?cngvUWdnSXBWcDY1clRlc0Q0MEJPNnN4LzVUMDZ6V25ocHhoZUpJdU9yaHBQ?=
 =?utf-8?B?bjRwdHRWSTNXY1hWeTFIaTBUSERWcHZDWFFreW1xRmJIZFMvOG9ZU2hnTkRr?=
 =?utf-8?B?QkRialFmcW1TU05aSkhZY0hDYXFZc0poUXpjOE1oOUFFSFJVSktVNzV5d3VM?=
 =?utf-8?B?ZmQvZjlhNXNSc2ZqVmwwbkVES3Robys1Tk0ySFdDN1NEQXAzZmRrS25tRk9D?=
 =?utf-8?B?N0l0emZJYXhiNFpJMmEyV2g3Ym5TSlpwQ1lxQ2Z6VENoYXp5akg1VzhvczZj?=
 =?utf-8?B?bnRaY013K09IR2g3d0l4RXlURWZWSHUvdnhVNE1rNnBWd2oreHFESWVBRWh1?=
 =?utf-8?B?Y0drKzlZcFpuSW5BWGhQVDhFKzZrM2FpQUoybDM5QTdteEJ4aExJdndjYkVl?=
 =?utf-8?Q?JHCEoL5byXD2pbZxdk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4887B3FF27E00843BDAF58B589F5E441@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19843072-d0ee-4b4c-9543-08d93bf4d421
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 18:28:16.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zWNdBs2Pr41MCuSnwEhTGYgAKTrA8BLzmtLml89EADBPXwd8na/3KXwc8Lj1q5vWWPbievO3fpofhVB5i3bjfKdm5AeLPb+KUslZ7TS7tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8zMC8yMSA1OjE1IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4NCj4+IENhbiB0aGUg
U0ZEUCBkdW1wIGZpdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2hlbiBpbnRyb2R1Y2luZyBhIG5l
dw0KPj4gZmxhc2ggSUQ/DQo+IA0KPiBBcyBBU0NJSSBoZXggZHVtcD8gSSdkIGd1ZXNzIHdlIG5l
ZWQgc29tZSBpbnN0cnVjdGlvbnMgaG93IHRvIGRvDQo+IHRoYXQuIDRrIHdvdWxkIGJlIDI1NiBs
aW5lcyB3aXRoIDE2IGJ5dGUgcGVyIGxpbmUuDQo+IA0KPiBCdXQgeWVzLCBJIGhhZCB0aGUgc2Ft
ZSB0aG91Z2h0Lg0KDQpIb3cgYWJvdXQgYXNraW5nIGZvciB0aGUgU0ZEUCBkYXRhIGluIHRoZSBj
b3ZlciBsYXRlciBlYWNoIHRpbWUgYQ0KbmV3IGZsYXNoIGFkZGl0aW9uIGlzIHByb3Bvc2VkPw0K
