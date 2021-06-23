Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3AA3B1C94
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFWOfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:35:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26105 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWOfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624458799; x=1655994799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DmKD8PadTkKP+v189tqpdpaG/zW/KZxWWAP0vKgH/HI=;
  b=iLqP8sUBREwpmHUJO86HJD3Rf7qCks85MMCrkeeNB/r40/NcvpEL+vry
   14/ChSfzBMfDgTAPEYgR18ZB9zGrYFu3haIZOdG+ecvM+7Q9yy0gBn28D
   k2xNC3z2DlNAZZ2V0gkSwp7Sv7rPIQOyju7qGjcsL3w4GzCvBZdwZug59
   DxFH6NGMqRhn4a0D3M/xC4RIOkQbuCUK2Ln7E+LkOan+QzZUcBsupNEJS
   NwmhxQW+Y7VE9Pju4mTWvgjTvVyn57EZ60NvVs5V9p4hMAUxIVckolIDG
   66qhyEg6ca834pThdkSMHh/e0TW44mo5B/78cPIqGvNO2OJVjSFW7l7w1
   w==;
IronPort-SDR: fVFfYptO/bjUwoNGRhYCJ0wwWnjOkQS89g+K85yngYofkcrF5A/OT48X90P3MN/ugIeCBo04Rg
 Jj5HDVjZs5bMRATKR6+iv2zoTAoR9SlM2/QRxWosimnbPr0jukvs/PZc2Hc7ob1IwHKAxJHUse
 xciyolbx8N19FaHKjeWrIrd/7XywguIKA949wqxmSZyZKUvqkDbRJFWfYm8m1fuLpvvDjLi5yu
 00TOOVbXrUFjAn+LONZZmHoQBFuOZ3cReHmqZ/5OJ7YVLwk3sDTEtmlCvzC/qQBBGzwzEc2mMY
 3Js=
X-IronPort-AV: E=Sophos;i="5.83,294,1616482800"; 
   d="scan'208";a="125795804"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2021 07:33:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 07:33:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 23 Jun 2021 07:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxaJuBwubnUr8WHXRxxWBRPq+4RqvL53GXaK2w9DIhomGVNYQ4HesYhS1yYr5q8Q6k3PafBdx/Tj9U265G2gfagjAJ6JJgBFjq9Ka9vNP4t7h+KFIxF0tooXhVHT9bSiG7V6SAJIB4DsitrJzLW9ffq//hj0nNUdmKeGDvjh38riemjKm2MRQE3SqX9Z7c/EgRoyk/kHI8AmOPGZPkZ5Uzi7T/z7NXP5pkvWJZkzi5A9tPheyqT5rh37lSYhrkUo0m1jwUJWlfFtKJhZk8vi7XbIEw2mkvoEG3pSEkzHCgl7Ho2Mc2DeSGd4njVy2u4ZQXGCQDNwHq2rP1M17AIlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmKD8PadTkKP+v189tqpdpaG/zW/KZxWWAP0vKgH/HI=;
 b=AgS8HrMXU8k3PDG+RffuuMDkzCZM5WzGcd9bzxY0LVjEFiyPoppySO6neNnAqfxfTrwV0faJqIufUCCL7jQieEWUMbBd2k6FaxZS73EnGx0wyy4n9t0ihJavFMCyjceEeiAXfgq4bVnBvz5S4J879whHp3Ny7s+LWMZDpZyLRh5TLAwvve7YhaAndYwIYYzN1zMyCyNGjEbb/IGxSJSyl6/ft4kLscf/xwu6GhwB+5jRf3yjfP6CmixrnuVjVe1HXbbAw7WCAzKtMkmYn73NMWKdUJX7zU1EAf9JpKAYtum82/ExeCRrjoI7kYaUVssasyzOtWsS9bsF4RCAiZkQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmKD8PadTkKP+v189tqpdpaG/zW/KZxWWAP0vKgH/HI=;
 b=jhCa0pNtMKF8TtGCxxuH9o49hX0XR8bpfudNrVQScSbqFYK2JbZZ0KmyUE2VWxgE5MqZ2JdugBb5wLS/ep+wszX2BFRLGNj9/6qx/I5AWuwryS5l7rUhhAZaJhA9CQXL2ESIOiRH6wXc82bVXb++ahXqnaC+1ddZRw+dR3RBWNE=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4233.namprd11.prod.outlook.com (2603:10b6:5:14f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.23; Wed, 23 Jun 2021 14:33:14 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 14:33:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Cristian.Birsan@microchip.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Thread-Topic: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Thread-Index: AQHXaC37D+YfoBgtzEKBvdp3Oa3YYg==
Date:   Wed, 23 Jun 2021 14:33:14 +0000
Message-ID: <8bff20a7-8eb8-276a-086e-f1729fbbdbe4@microchip.com>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
 <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
 <20210623141907.GC491169@rowland.harvard.edu>
In-Reply-To: <20210623141907.GC491169@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.78.167.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ac61356-4568-41aa-05db-08d93653d5ab
x-ms-traffictypediagnostic: DM6PR11MB4233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4233E314C7D1E1B9A8010B1B87089@DM6PR11MB4233.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/TeBmv8zERo9uHEYHEINumJrCEFeg40zK9PE2bxXuxabh2YH1i/B9a5s0yPol00Rhcxt2f8wtQpsfj4v/A2RQBN48mJuozjzKBR9Cps7kwJDWCXtYRM/59Nrj+lcRcd3KWCjZJOxIDfo3z9d1ugtAqTNb9q2lOpT11UUOv8GXEyIxrMtnYPNlqF+K8qeeRVJIe7vu7rtwsEK+8yZQOaGJ1/EtWeK4xw3VHJoU2OuHwYs9w7h2EhKlu6i5tzg9CaLw9zgaWzUSHq4aX1ZXVu8NIR0k/gzxIAoOkddxXTcChe80rHXSDEGsGccj3zsAmQw+2ixrkA0S9rPKAkciehF/+nOLo6NEZDF+1AlnvIXfmsfgv6zIbm9TGsd508aionnt0QIs11NyJJTLTeyEF2aY3jn8tjD0vUIFPC7p3k4uh2wIrRZF+B1kuxF5peaQv1wJXhbYrzHqViZATGQDVMuhW5sJOx7cVb+HGBMXv8UeX3zqVsAp14uTWYnO1M42n52vQ1ql1mwFPs7w/ZyOHd6/H3Wa4RstgYm0Q2nJX0fumh+LIlyvnykX8bZuNwrz9bgVvGoSKEUSKGDkMXFYOvl0KcH22X3IWgh/FO4KESIhO0w77p8Sbb6IIuH3RVkAB8Di9LWFVJr6KMBWJReZ9thfo5ibXFlniXv2Q58yqK13XZMF92npi4/Q/fKCIBL/DZnGgrssoRrEBKPS7Izom95/exU3zJEWB8ITAZWSncifbtp9bgYrDyfHdbWQiJkFd+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(366004)(346002)(6512007)(2616005)(6916009)(36756003)(66946007)(66476007)(66556008)(66446008)(64756008)(76116006)(6486002)(91956017)(71200400001)(8936002)(4326008)(478600001)(8676002)(4744005)(2906002)(6506007)(86362001)(53546011)(31686004)(26005)(38100700002)(186003)(15650500001)(5660300002)(316002)(31696002)(122000001)(54906003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFI4TGpFUGJPN0pRN2gyQ3RuQjZwWjJJUWh6azdmTUg4UE5XaGMvdGFrTHFo?=
 =?utf-8?B?VHFWR1poc0E2bUcxemRXaVNSM25RaDFic0F0RGN4ZEQzcWxISkdOcFd6Q3k4?=
 =?utf-8?B?dUh0bmtQRWk1U1NoTjh6c2ZWWUZSOUt5NlhvUis2OTgzc1dVRWgvdmg0aWFj?=
 =?utf-8?B?dzBaQThBZ2VDT0RCcitXcmFyd01oVlUyVVo1V3h3SnZtV3JhWENyZVUrYktO?=
 =?utf-8?B?OGtJckJFVzJUcWpoOUovaXUwc2FPRUxCbThTS0RvMlN2bHU0L1hxaGw5WFB2?=
 =?utf-8?B?SzJHbFJaK2ZCbWZNUUFjVWVvTWQ4aS92cUVmUVhWL1hTZVV6SW1zTXlPSVZG?=
 =?utf-8?B?Tjd2SE5aSUZUTUZGSDJEYnFMYzVIT3ZOUTRaZzNHMGpNL0lNRVRQOHppaWl5?=
 =?utf-8?B?K29acGlEODU0NDF3cWdVYk1sWE9HY1VGT0RPU2hPeVp4VEpsTE01UUI4dTdL?=
 =?utf-8?B?UlYxZ0tpcm9WZ21GNDczalRFeHhFT01hOHZTWHl0RGN3eGhuMW9YSjlnM3Ny?=
 =?utf-8?B?b2VjYzlPWit4NjhYbWNXd0NiWFFHUlo5WTdFQXVHZkFJakhWVFZUcjV6Y1JH?=
 =?utf-8?B?UkZwek01d0xSUFk5NExZb3FXaXpUSjdKalRiVWR2Q3hzRU1YNWc4VDRIUTNN?=
 =?utf-8?B?b0t5OXRHVkFIN2tHUWppbkRvbnhtUmk2QUtXVmhWYWVyUkRGY2pFdDFEVXlo?=
 =?utf-8?B?TVZTTDRJU3k4RFRId21IZmhhbGpqWnRZcnRuT3I2SUJsUHBBWGY5UmtUZE9W?=
 =?utf-8?B?VFF1Zk9yb3lkWVB6SEJ2U0R4c2ZpT29ZbGJVNmxvdWJLam52UWRwd1JLbjZS?=
 =?utf-8?B?NTNGMWszZUViSGZqZzNLYUF1WWJjMUx1bDNhSWI0Z2RVQzF3dG5IMitvWVpD?=
 =?utf-8?B?MTFUU0FoT2dJNE9SZFdFQWZYTmlzb0h6SDBHVHh0Yk9GdDBLZWprTWJlR09T?=
 =?utf-8?B?OHhLVUFVSVNrc2gwZFlYRXM3bmlsNTJ3THdnN1JWTWFZejMremVhcXA1cWJH?=
 =?utf-8?B?bmwwMlVIeTJIcmZvYVZvRCtsUkFIV01yN3hzbFpUYmJwZG1wUjJZR0J2Sm5K?=
 =?utf-8?B?RnY1MHpaSXdIU3hLR1d4aFVFRm93UERKd3QrZ2FtaWd6Y1JXSlBBQUVtdjMz?=
 =?utf-8?B?L08yT1lBT2NtT2NZMzV5STZKdzcremZNUkhFUnZLWkhmZ1lnOVdMN0Z5R2Vn?=
 =?utf-8?B?UnEzV2VJSDd1Wk9sV0xuc0lOL052cDZiR1p1R2ZzamJBZGQ4UHpnQm9HL0lJ?=
 =?utf-8?B?Y0FMMi9YbFNmTWNiVTY4bWNUYTRKK1Vya1VoTUF3MDU4NEVVUVV1d3gyMFZk?=
 =?utf-8?B?MHFqVlZLOFRrZDZDUFVjOHZDRjMvOWMvN1RJSTdPbWVxUFpGeVd6TGNCcjlK?=
 =?utf-8?B?UEpldUgrV1BPRldxK0hSVFR1OVl4N3RDL1hpQ0xhMFV4RWorR0NpbUd6WkZ2?=
 =?utf-8?B?ZTJpaU1kMTNlMWEyUkptc0dGaXMyZ0lFWGpSRzhlbnQrNHcrYUo0dGRROFVl?=
 =?utf-8?B?YUdJakZoa0c4NjU5YXNJU1kycGZtQURoblMybk5wRUtRQkJNaGllRzRGTFVC?=
 =?utf-8?B?QThKWUJGMmJ6QTRDK1ZQVm1kelpLbkYwUWZkM25uRG5LRWNRTlo0RVh4Z2o2?=
 =?utf-8?B?dnVvV2NEenpzTlB4RG9UOVdWdlErMld1SU1sSTVDODd2Q09GWVNsWm9NS1VX?=
 =?utf-8?B?ZnpPc2xHbUxuUlRTWW43VkpSTGkvSnNJTklsUEJHeFdncTQzQXRBci9hcy81?=
 =?utf-8?Q?M1i+TsY8WOvkamwdTk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C50EFA4C97ACEB4B80E2FC22DE5DAD36@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac61356-4568-41aa-05db-08d93653d5ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 14:33:14.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93ZFeT9Vn+xWmWcg/zvzJj/Z4zucACCff+Jd+fuYJjzHv8g2/ZqW9vfS7VqA4xO77B4QppqOU9M8agMfWcMWrH7FnKMs/vrfYHNeCViVkNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4233
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMDYuMjAyMSAxNzoxOSwgQWxhbiBTdGVybiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEp1biAyMywgMjAyMSBhdCAwMjowOTox
NlBNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMjMu
MDYuMjAyMSAxNjo1OSwgQWxhbiBTdGVybiB3cm90ZToNCj4+PiBPbmUgdGhpbmcgeW91IG1pZ2h0
IGNvbnNpZGVyIGNoYW5naW5nOiBUaGUgbmFtZSBvZiB0aGUNCj4+PiBvaGNpX2F0OTFfcG9ydF9z
dXNwZW5kIHJvdXRpbmUgaXMgbWlzbGVhZGluZy4gIEl0IGRvZXNuJ3QgcmVhbGx5DQo+Pj4gaGFu
ZGxlIHN1c3BlbmRpbmcgdGhlIHBvcnQ7IGluc3RlYWQgaXQgaGFuZGxlcyB0aGUgY2xvY2tzIHRo
YXQgZHJpdmUNCj4+PiB0aGUgZW50aXJlIE9IQ0kgY29udHJvbGxlci4gIFJpZ2h0Pw0KPj4NCj4+
IEl0IGRvZXMgYm90aCBhcyBmYXIgYXMgSSBjYW4gdGVsbCBhdCB0aGUgbW9tZW50Lg0KPiANCj4g
QnV0IHRoZSBuYW1lIHN1Z2dlc3RzIHRoYXQgaXQgb25seSBoYW5kbGVzIHN1c3BlbmRpbmcgYSBw
b3J0LiAgVGhhdCdzDQo+IG1pc2xlYWRpbmcuDQo+IA0KPiBBbmQgdGhlIHdheSBpdCBpcyB1c2Vk
IGluIHRoZSBTZXRQb3J0RmVhdHVyZShVU0JfUE9SVF9GRUFUX1NVU1BFTkQpDQo+IGNhc2UgaW4g
b2hjaV9hdDkxX2h1Yl9jb250cm9sIGlzIGp1c3QgcGxhaW4gd3JvbmcuICBJdCB3b24ndCBtZXJl
bHkNCj4gc3VzcGVuZCBhIHNpbmdsZSBwb3J0OyBpdCB3aWxsIGRpc2FibGUgdGhlIGVudGlyZSBP
SENJIGNvbnRyb2xsZXIuDQoNCkFncmVlIHdpdGggYWxsIHRoZSBhYm92ZSENCg0KPiANCj4gQWxh
biBTdGVybg0KPiANCg0K
