Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A084358084
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhDHKYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:24:39 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:23234 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHKYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617877466; x=1649413466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WyPHO5jjnvgALtGxkZn8PvZjmsrNzRFcAfMs5C+oNPY=;
  b=V8/3ivpKrI7WL/uESGWmuIq4TswkxfJN7daOtIFmqqyFRlXXDUV9dnS8
   2Aw6tBrxlGa0joQdTJtIZA9CHPGyWJJRkYfPfpGbFtHSSnrd38+YEh6rb
   x9VAqXudvMbZJamqltNCEsLN3REGuN6wgBcg1WcH1MA7MbqYOVVE/m+vE
   583NU2fPCaNfURPQGeNMXESSdf4F+i+tG3HyCsOzMvQD5e+/dPp47Mw8E
   bq2NF5T844JY7qt8Vpyf85gQ/VP+4B4dSfy8PnbPfm/BjVkF46Sezi3Z9
   KqPS86Iw2ouT5NIWaWOThjaQn0M20kkGW6eJUz/vydgxGl/UkaO8riyZw
   Q==;
IronPort-SDR: 1AYfJAW4NZyVEA/7tAwGf3DRCHsVNMmjg9eN1GntqREueP1/r2QiN6GmgQDClqjz4lai+vmor7
 uAKhThxMuC0Yl34WGIo2TjkWVb3q/2s1neefM67zfkRyvn2IU5TtbGJSR9KXK4YwDmAm28RqDE
 7c/eVAhIg9jFdC94ARKull1f5/x+xkEBCg7GY5flGWvKk3lgqW1fCx17WLuJ69T+CdD+6GzA0L
 qFw5+rtLjD0x8lHu+ueq2t8NI+P2rRoRNfjD5Rfm4bOvwkP3vu5wUUdtEJk7F8YZRHmuga49wa
 XMU=
X-IronPort-AV: E=Sophos;i="5.82,206,1613458800"; 
   d="scan'208";a="122254573"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2021 03:24:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 03:24:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Thu, 8 Apr 2021 03:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIceXf8u9frJvwPiTCLfnVPsndiwghiiA1Z3hTLTd2NZD14cY/XKQ7tFup7MD8YIWW8L+r5HpI+0HrQu4kDZrJG154TH+IFo+D/yFm+BUjvUAEVYg8UUr+yPjWQUiTCqL9uuvniL/92P3wG0xPyDQ8xItqk2o+MLLODpT9lpTnPvIzA9K6jOdK9ZyYm3cUjyoSrVUEuAk5QYG5UTbWPs7w/m65R78SEgnCputI9kdUmTDgQQxtgBoldEHEtsBrPXexKOJtR17QuHq4ugxJNiXyUKkJbQxX4SgpItbk/zja+cZVPh+lF8f1jzTCSRX2EQ3X5QA2Ui6FFeOStWHi9GNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyPHO5jjnvgALtGxkZn8PvZjmsrNzRFcAfMs5C+oNPY=;
 b=HgMx/MzpEs+uOXijIOoXnPewhbllNXb2fJkG0d5UNKprRT5+ISOsG/uDXJ8t7XOP+8XYZrkE/wt/NxOMiX++9AKIMvuFeptlv3eV6owAnHfe0+VFpwhrgoVCNnTQxsH9dE0oiBXv6IFVZIy5cfzhkc8fwflCJ5Bq23xkrxCenMz4EO1ZRUP0jifaI85bRE8hprRm3wX1VJj4eqvCAn1dDPe8NGZwFiNLOt+zIUahl4zflKGIhhxYi4Rn3z+fd+PJ8BfYKsDus8BKDlNLcgM/pMZlq7Lh7eK7sK26tN9sD/qgnVBsGGO9CSMF3lsSt0xOM168cdND+fV2xr0+4Er3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyPHO5jjnvgALtGxkZn8PvZjmsrNzRFcAfMs5C+oNPY=;
 b=f3Plkd0rDauN1huoAWUMgfmZixu9RC85kMtwJlwXeGkCb6eXgMCehyx6hG/8DwhFvkTnmGZlzCa4Bplqj2ehG85KSEMUwB/owlxk2W78yBEfM5gdX8YYtjwL7+Ufa0qJn7SnPhh0QWclquu3vXRM3bev04s/yEPKHVo6HJk7paM=
Received: from PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 10:24:24 +0000
Received: from PH0PR11MB4887.namprd11.prod.outlook.com
 ([fe80::415e:cf64:ee76:58a8]) by PH0PR11MB4887.namprd11.prod.outlook.com
 ([fe80::415e:cf64:ee76:58a8%5]) with mapi id 15.20.4020.016; Thu, 8 Apr 2021
 10:24:24 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Ludovic.Desroches@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 3/3] ARM: at91: Kconfig: select PLL, generic clock and
 utmi support
Thread-Topic: [PATCH 3/3] ARM: at91: Kconfig: select PLL, generic clock and
 utmi support
Thread-Index: AQHXK8+5iSn4etmOL02km60zipBtP6qpSwGAgAEgDgA=
Date:   Thu, 8 Apr 2021 10:24:24 +0000
Message-ID: <7efa1037-eef4-0b34-1ad3-7ee0c61afadf@microchip.com>
References: <20210407170053.298056-1-eugen.hristev@microchip.com>
 <20210407170053.298056-3-eugen.hristev@microchip.com>
 <YG3oM6DhTwKfPrAG@piout.net>
In-Reply-To: <YG3oM6DhTwKfPrAG@piout.net>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.121.125.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac4fb5ba-6bfd-45f9-1a0c-08d8fa787b72
x-ms-traffictypediagnostic: PH0PR11MB5142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5142BDEDEAEBA619C3A81258E8749@PH0PR11MB5142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjvCD8Kx+3rhExCUbPgfbs3slVeuYAxCoYXJWip2HD8hP0xEB4INoKg8+ihDPcvgq/2524HLDpsT3EC5yKH+iMo3Kq67Sc9z8z04YfJLjEEhnhMmvAeH/b3DfmhG9d2xTWWzth2EXij/VfBO5eLRCDdEOiPwMTnzhU38d++qIOe1W1b791zPbjSiQnfXOOh25a+O6KU77R7tZdWtLWa4tDQQWB7Ms+Bjxt+gZ3pw8FjciN4ZxnvcEhVNYQ5Qf9FDM7dZMus2vN8g1NanK0V9hYZr58ARoWxQ7s7NRaV8pf/zd+QhUTPr7qROFv6JzhVyGSZkZfQaMCIhGtpRfvGrfEZ3+ByxOpn8NwSygaCaf3I4x2K10KPJCXrietbwAfAVZBzfsvK0dQyveTvui7TKJQER672Fqzkc7JzZYS/FmMcm3bjaSlLtUwJIrjYeFddaKb9pvc/LwKGgxXCO8ktjKGd77pjqBghRcZnsVF9v7hVHWPjD3Rw2r77I5yjbC+f5DwRYb0qLWXzJybqWDjCvd8zhI5lmMYmvxxNgj7Iudj4v4E/ornzxFmS7W3a92y16epDXWSLbkVGBBZ/fgvTqqxcLso96IkagFfkySUZYwFHizsbogXwP25QOJ3+ykgWxY1hOPovE38+QFcOeV2CywHuTErPQ/XYKOp5vjsPUPhXMrwFJq0zG8b2iV27bejNyHHNEp2N/Wt08RbJi1oj/bWAXtCV+EPHx+PtFS1RpqyatUKKjtZDnkKy0yO6cEaR1MEBB5dKHVLhngXxSSxllo8RU40McckIaUo/cOT+XUKgjOqUlDKQF1WWQRmwLrs9QWDUpsWWtdWyTL/3yLeeEJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4887.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(39860400002)(376002)(396003)(8676002)(8936002)(83380400001)(31696002)(86362001)(2906002)(38100700001)(26005)(2616005)(186003)(66446008)(66946007)(66556008)(66476007)(64756008)(91956017)(76116006)(6916009)(6512007)(36756003)(478600001)(966005)(71200400001)(54906003)(316002)(31686004)(6506007)(53546011)(6486002)(5660300002)(4326008)(107886003)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VUtjcHZkQ1hhbGpIRGdBVmM1UDJoLy9YV2QwTEVSUDJKa3l3WTJCdjMveXY0?=
 =?utf-8?B?MlNDV2kzWWRJbVFXV3lSK1E4QUdBd2pFbG1RZ1VrOHlqWFkrY1A5dG8zcDB6?=
 =?utf-8?B?eGo5MkNONmVud2cyQWMrUTRUK1lJK1RrK0o4eFZFR04xSG1RbzZrQlpUK21T?=
 =?utf-8?B?UUNKbGRTYi9oVWFSRXFSNG5GUlBLaDVwcnZMYTkwQVY1T0RuL3NtaUJLYk5k?=
 =?utf-8?B?TnJVZ1FhcVdFbzFwaGpEM0RDRW5MWkpITXBlQzR4dmVNMGMrYWVSbGlZQjZs?=
 =?utf-8?B?NFhVWXgzcEJ6czVrK3YxYkwyYVJOS2lqZzFNd1VKTk9qais0c01SeHFwcVJ1?=
 =?utf-8?B?cksvQUVwOFR2bHFBTkdUcmthSmNFMWpXZnFLR1FTeUhGWDBCNExRNDFOV3lM?=
 =?utf-8?B?b0ZjdXNSWnM3Z01YTzR2N0Y0UnMyQWtRUjhKVnBKbHIyZWQ4WFJoYzRiUzRk?=
 =?utf-8?B?ajk2MncwZXh1MkpDZG85WEhVN2RoQzlEWU9Od2Rhb2FJK0VzV1BDYUZYeS95?=
 =?utf-8?B?RVMvZmRBNjdWMVFxS2dWcHk5QVBTbWdiVlJZaGNRZHB2NWJIdlpFeXI2TWxV?=
 =?utf-8?B?SW8yRlpGMDQ5V0VYdVByZm9NRStLQWQwbmRQWVJZYjJXaGRpUHE0RnN2NFhR?=
 =?utf-8?B?dzl3aFZta01DTUJCWjFuTjhyZXJhbmZ6Q1NRcnk2NGlEQ3duLzRoS0YxN0Fk?=
 =?utf-8?B?N1Q5aFZyMEhvdk1vTDBHZjdpU1k3cFNGYXM3Q3VkY2o4Z1k3ZEswTjU3YTRz?=
 =?utf-8?B?WUwxRThTUmdqeXBZTWRiaVArYnpmbkIvODdhTmRRSUlpVExsMlJUUVVpSENC?=
 =?utf-8?B?djBrenRubzFwMEFjK2FmQ0VTRnpBZ09VcFFJQ1FvZ3VvV0pPLzE5K09xRG42?=
 =?utf-8?B?MUJBQXhpSmVMZE84QTZ1am1LTi9OQmVmOSswcWlzMDYwYzNmcDc5bXBndm9p?=
 =?utf-8?B?cFJ0MXR6KytSdW5Tc3JPYUx2QjNndENsNG9SNHFMMGdQck1LWFIwcmhScGt4?=
 =?utf-8?B?eTMrUlQ3bkwrMytmTU1nV3E1bVU2NWg0T0VKVmFlTFBYVGlKVlBLYzdmWDk0?=
 =?utf-8?B?dk1nbDgxSTA1RWFYYk9xNzFDTHdYdTROODhFcExYRkt4Z1Nad0NyT2xRNWkx?=
 =?utf-8?B?elF1eVo3Q3ovdVBOMzNjZ3BsQmRWOTh5NGYyaDEvUnJmeENCZE1SQnpEeGJW?=
 =?utf-8?B?WGVqRzZ3dWRDSHVzS2wvKzBnZ09wK2dnU2pGakdlLzlFMkpINk53MCtJbFh6?=
 =?utf-8?B?ZjU4TDZHSnVCZGY2UDFRNUFudytCYjJWazhnRlczSXpKbmNYeDFNVlI0Y2RZ?=
 =?utf-8?B?TWRsYUtnRXNwQUxsMTZvYjJpRVBBMUZKcXpmY2JPTG1oajJkMnQ5aUF2OXcy?=
 =?utf-8?B?WHZsQVA0eHhyOURjWCtPM2JISkFCZjlnTlA2R3pheE9ybzl4Q3FUenRTSjlC?=
 =?utf-8?B?bW0wMGFBS09FZWZrRThLOW41MmFHL1pQaUdXbG8vall4cTA1b0JRRXVmdFor?=
 =?utf-8?B?OHdHRmxJTWVSWTdrbmdzNGNPemFaUGNEMGlPcUUzZ2Z3THZaTklsSjNuV2lz?=
 =?utf-8?B?d1J4MHhjeVc1VmU4MG5BbmpGeWtIdWxRTE5nemtpRmhsSTQ1R2w5Mms4ZEVK?=
 =?utf-8?B?SHk1Y0V6UjgxSEY5cWsvcnFqaU1jMDdqZ1FJTzdadWlwTTNsZEZucnVFL2RN?=
 =?utf-8?B?eEhZeXlDU3czSFBKNkt1UFgxeXlWZzlmM3JqVGpBMmU2SlBmSkZqOUVQU2Jk?=
 =?utf-8?Q?NsTBik8NPOeiESzkKPa0tX45gPprdWP3wDlCGLI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EC52342C303234188270B67F19C647C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4887.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4fb5ba-6bfd-45f9-1a0c-08d8fa787b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 10:24:24.5337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvWCgJYlKBl9YE8n4Qh47enp/U7ZF2IN0QOeP01AJ56eDYbFsldo8Mc9qvo3jRnrJHcnjWaNON7twxJZbohO7izOw09P9gqIjw4sms2xq5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC83LzIxIDg6MTMgUE0sIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IE9uIDA3LzA0LzIwMjEgMjA6MDA6NTMrMDMwMCwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4+IEZy
b206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+
IFNlbGVjdCBQTEwsIGdlbmVyaWMgY2xvY2sgYW5kIFVUTUkgc3VwcG9ydCBmb3IgU0FNQTdHNS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWlj
cm9jaGlwLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0
ZXZAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL2FybS9tYWNoLWF0OTEvS2NvbmZp
ZyB8IDMgKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1hdDkxL0tjb25maWcgYi9hcmNoL2FybS9tYWNoLWF0
OTEvS2NvbmZpZw0KPj4gaW5kZXggNWViMmE5MjA2ZjQyLi5mNTJiNDZiY2NkODUgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvS2NvbmZpZw0KPj4gKysrIGIvYXJjaC9hcm0vbWFj
aC1hdDkxL0tjb25maWcNCj4+IEBAIC02MCw2ICs2MCw5IEBAIGNvbmZpZyBTT0NfU0FNQTVENA0K
Pj4gICBjb25maWcgU09DX1NBTUE3RzUNCj4+ICAgICAgICBib29sICJTQU1BN0c1IGZhbWlseSIN
Cj4+ICAgICAgICBkZXBlbmRzIG9uIEFSQ0hfTVVMVElfVjcNCj4+ICsgICAgIHNlbGVjdCBIQVZF
X0FUOTFfR0VORVJBVEVEX0NMSw0KPj4gKyAgICAgc2VsZWN0IEhBVkVfQVQ5MV9TQU05WDYwX1BM
TA0KPj4gKyAgICAgc2VsZWN0IEhBVkVfQVQ5MV9VVE1JDQo+IA0KPiBTaG91bGRuJ3QgdGhhdCBi
ZSBzcXVhc2hlZCBpbiAxLzM/DQoNCkkga2VwdCB0aGUgb3JpZ2luYWwgY29udHJpYnV0aW9ucyBv
ZiBlYWNoIGF1dGhvci4gSSBjYW4gc3F1YXNoIGl0IGludG8gYSANCnNpbmdsZSBwYXRjaCBpZiBp
dCdzIGNsZWFuZXIuDQoNCkV1Z2VuDQo+IA0KPj4gICAgICAgIHNlbGVjdCBTT0NfU0FNQTcNCj4+
ICAgICAgICBoZWxwDQo+PiAgICAgICAgICBTZWxlY3QgdGhpcyBpZiB5b3UgYXJlIHVzaW5nIG9u
ZSBvZiBNaWNyb2NoaXAncyBTQU1BN0c1IGZhbWlseSBTb0MuDQo+PiAtLQ0KPj4gMi4yNS4xDQo+
Pg0KPiANCj4gLS0NCj4gQWxleGFuZHJlIEJlbGxvbmksIGNvLW93bmVyIGFuZCBDT08sIEJvb3Rs
aW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL2Jv
b3RsaW4uY29tDQo+IA0KDQo=
