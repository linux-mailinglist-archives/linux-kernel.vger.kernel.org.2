Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7293956A7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhEaIJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:09:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:55429 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhEaIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622448461; x=1653984461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=11d8R0DXGRYacTUllmn9aKW8JZ04Lo2UKUhQcsw4dSM=;
  b=oUKxfOIEIAurdkNqxk0edtP5rD5krqB9zx6SxYJex2zuMZ/sZSM2dtLc
   4x10ER3TuE21Fv6dPevZwGi3XKHoAAG9iF7sgCzjk/QMlhzaG3iVBMFFr
   miHCy1Aq//ugFs/NsZazQy+W/bNtC0zYgqJbb5dKyEuRJu7TDMipCC5Hw
   FJ1YwpVJOecKbwNCFLFMgM+u48qXWOzbZRsJy/kbiFTFbOy1Wx/oTiK7V
   xkPodJeddoucJHy2LjvMzgLtHAF4gjMsaJW8oDD1SAGahbUg0RF3h1Rnc
   9r7H4Laun7Kn9oM8l/oB7mbIIw702HTDhhdwcfb/s/rpjm8FLNeOADtno
   w==;
IronPort-SDR: F24GrdsKhZ2tC4e+HPvd3wSGeMWIbr3knbTgr8t2j6bSAsuI/nmH/U9AtW9lKiH9Vuc6RLeQgN
 EDLW9x40eLWEZErBxKQ/VCtA3AiNX5E7MoApvrt0tj7eaMpSx4Vu3jE08kr0hYd/B5w9eSSy5G
 IW9gA1rgjGweFL7r4+uVUCl1+Ea/btHV5weOLYgz7RD7ifkT9483lXKarX3fnyaZ11grk8KncS
 5ifNRQsbA9vQWiJq4Eqmopb4LTp+bkfZpUkhtVVy7sEe70Mlyy9qTsg7Tn7OvaG3txOcRU4BiJ
 Kww=
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="119693398"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2021 01:07:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 01:07:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 31 May 2021 01:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTINDm5BEXx5PgKW8Vc15UzWNWhlqs24WTXH3X0n7VbGbv8PBl05nqa8iCTFbLk3l3VJLzVvhOmxqUeTD34JwN6X/sEVGZdaShdXP5IrEjNIOPICpp3ItkutnI/sOYlXVCmdG9KXl+mvbdtylS5WcML9ucVMfMePTMPQTin9nvJMZF0e6GHTxx8eeJM1JobEYEcBtw/gDzBxPXo06nz6G0VdhnYMp9a+DouV2oKuCQRR06ZOafyT50bmKKSm+eYkOE/TFqwIhOnM1LVekMzIU+euizesX6MgrbvOglO9mrcVN+ndUtI2IWzDUWQCJnIgCiSCMQ4Gyr0vuAhX4OsJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11d8R0DXGRYacTUllmn9aKW8JZ04Lo2UKUhQcsw4dSM=;
 b=ffVm8IS5XO9f/jxVKW9Tl2odtpuvgztCg+QH2Kog7PZQ/Jh73VX50rHYIrJA7IOiWcoIhK6jUsKr/CA7KRGis+EHnKmJtJjMsQp3TybfO3xwSk2DvVJdRxGq4ulu9XvsKCVhBcF5w68wpuNXt6TNev7fn76h1WTIdAv5589u4Wy6Ys+f32V6qqk6f08DZHjlfBYTk6fkseDf/bUUcWQD2j+ZMYKHSzYMOMHZLOyH9k2EiQWvzrSOb6Ip2T8CdTkWOb0UwzjKUBpawLha7Pjh951IfjhznKSzyntcxft3ocBF0u9inVVgrGEkzm2IjqcqXuTOnK5Osil9mpvVwMFtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11d8R0DXGRYacTUllmn9aKW8JZ04Lo2UKUhQcsw4dSM=;
 b=hW3fqECC8GYNsWQodO8lVg+adXEeGaC7MKPRygQioMHbcgzThaDZwNJBEgO37Q3CWVZM7jZe4FiagLX81tPAUNfSb5093uDXPkNDQuAwtU6CdegxM/4RwYG149gJZ0GXBM7P9pobmQ3DG/uJzL07/5GNAoMGxvBQaVodaZzuRpQ=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 08:07:31 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4173.029; Mon, 31 May 2021
 08:07:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: otp: fix access to security
 registers in 4 byte mode
Thread-Topic: [PATCH v3 1/3] mtd: spi-nor: otp: fix access to security
 registers in 4 byte mode
Thread-Index: AQHXVfMWCjsPzVIZekeG1VBfbNM9Zqr9PBoA
Date:   Mon, 31 May 2021 08:07:30 +0000
Message-ID: <5b0a7c0d-734d-2e29-9d71-2230e7748d04@microchip.com>
References: <20210520155854.16547-1-michael@walle.cc>
 <20210520155854.16547-2-michael@walle.cc>
 <0cd72191-e195-eae3-f741-a3c3e38298cc@microchip.com>
In-Reply-To: <0cd72191-e195-eae3-f741-a3c3e38298cc@microchip.com>
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
x-ms-office365-filtering-correlation-id: b9ff6148-552d-48f5-467d-08d9240b239a
x-ms-traffictypediagnostic: CO1PR11MB5108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB51084204609F0FD41790DFF6F03F9@CO1PR11MB5108.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pBw9uSi1qgDjar7xfiAEJ0C1EzRxQ0Uk1dhuMYrUYEOQ9mUfix9yExkkF4MudqBLa5ev/+mk9GgV85o+91PFll4M36TmJHOiXEwfHR2Hy0c/rOnuWJaz37o/0OFMM62u2W3SOjAqhRrkTQLWvwODyGUCJ2XrlHfjecVscQ/8x/tOzJlXesAemWrCmmsAIAtSRyTN0iBLFt5YJWV2GB57onveELq/0x/wI333h/ZFd2Krus2i3nX3k4UkfLNri8LlYnf2KECY9uq/5OAKO2ulD7dxWa2YG/XWP3XQH3BFxAhBxbjFh5EE3S/cVd+ZBZCmEaZGIRfZesUTVQ8knZcCAcCg1aKnxXntLg9vhHMWeQgeKMgpbS19okyEmqunF0sgTdiu94jnDwAwO22k4eAgAEu/h3jjRDsnx1sEzgjN+Ea86jQtmQGGLl/LEfs4bHp1v5tlbWPkWp11rMuShyWDKXX8N7bGyTG3EU7JBvYzh/Rq+XI/bm9k7V1nvUfJXc4CxmMgefEfVczdOc1bk/4lIs3b2eDKITVPqv31cp8t1ODbi/UkojWudpjABXFrRujPHrfSyZndNH1XOyRjWL0H8UxUiwlhmX9FV6kBKUgWqDy5a0rn4/CUcsXc4b0za9BOrNFS5IcvosXE9bhxENkLaiO9EuCWoiVfbKsJfnQgc9Ax4cypueHvfHYDhvWaIOdIzeUZ4Uabwch8ee7xA45N7V+O6/tkxKXI5QlUAnRWPRhMsw6TznsMi/lqkTITiYj9yAsOzkeYWteIF5dw0rjBOdxnRiSaV1mo9S+JFuKbbI0CoWkLu0Od1k0Gmw8+H/kF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(122000001)(15650500001)(38100700002)(110136005)(186003)(66446008)(4326008)(64756008)(966005)(316002)(54906003)(478600001)(66556008)(53546011)(6486002)(2616005)(76116006)(66476007)(66946007)(91956017)(8936002)(6512007)(86362001)(26005)(31696002)(31686004)(2906002)(36756003)(5660300002)(8676002)(83380400001)(71200400001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0dFb1N6dHluZjNubmd2T1BPNzMzSGlRcVJ6aytsQitHb0RXYmxvQ1krVFVn?=
 =?utf-8?B?bE1UNkgwWW9WTFpVWDl0WG5BRURlemVPMm1zRnpYYjZtNkVrMG5JSzJvcVhv?=
 =?utf-8?B?b0dkV25IZ1g5SndEejhnemNlRVkzbTdXQTNjMVhWOEJDRmlieWhNYUY2a2pK?=
 =?utf-8?B?Y3h5UkJaKzhWUkduVS9GMEVpTjkrL1hmdU9rVkRFVXByY3VrT3l5YUdETkVq?=
 =?utf-8?B?Sno1Lzg3OFhYUXNySllsNGRaNWN0MzhLbmxCZzUrOGVId1ZBRmFOam4rT2xk?=
 =?utf-8?B?U1Z2OGUvNUZVVVo5LzRKTjltZ0Nyby9VMUtUZFdRdmJoL3ZOLzhSbzc2ei9u?=
 =?utf-8?B?c0hMV1RKZ2hkQ1ZFVnc3V0RMTEhjS0krcEY3RmVvM0thMEx4bmRSVmhJZlRO?=
 =?utf-8?B?c2VmWDViRUJITkVrVExidDZTYWFxcEQ0WnJoM3l2U1EvT0NOMEs5bk1wQnNE?=
 =?utf-8?B?QmNFTG9OWmxZZ2lnR0FLL3lJR1dmdkE1KzFRckJ2aE5ZcDVaUkJ5bGlqeWND?=
 =?utf-8?B?VFovNloycHIwcTM2SkZjcGluTnRZRVNFOG96Tlk4c3FDbTVaUSs5Q01zdk9V?=
 =?utf-8?B?WjdvcHRvR3FuWU1oTjdBVWNMVGF2S0VKeERRbWhTd1FTT0FjWUoyMlBzK254?=
 =?utf-8?B?ZzB0Q09BVmhvRmdCejRMNnBNOU5rT0FLSVQrOUVWdWFkNFFsZC90Y2lkV3dN?=
 =?utf-8?B?Y2pWUGorTy91cE5pTXR6ZVlaQlZ1UFNSdk9pM3ZCQWZ0elNzWUYwaWI2R3ZC?=
 =?utf-8?B?d1dYbWNmbFZ0Q3h5WnBRUVJJVERHZDJ0NDZ6V3l5ZGN3cFNYc2RxZGptVGgy?=
 =?utf-8?B?cmZSN2NoWU1JeURoUGZ6SjJrMkxYd2lwZnhIMWh1VGVqN1U2NmNOck1MMHR1?=
 =?utf-8?B?OFpZZmlWU2FMWU5sSVlmeWx4VHZqRGZ6c1dhUEZNZnNxZlFHeVFLSURSYzBp?=
 =?utf-8?B?TzRaaHNEdkhKS3FvWXFEcEQ4U25hOXB1cU8xMGdJcmRLekhhUkFWVDArMFVs?=
 =?utf-8?B?SWpKT3F3VHBlWWVpanZqcmo3U2pJYzJQVm85Z0dvV2UvQnRBak1yTiszSDlB?=
 =?utf-8?B?K1BsOCt4a0loMVU2UlU5ODY2MDI3SlYyd0JZRlpLeXAyTVpJTDVlWVpEVGFN?=
 =?utf-8?B?MzFTaWg5dFNDKzk4WS9jczQzMWdPMzMrVmlyYTIxWm1ndFRoZGJBNDhVYTBE?=
 =?utf-8?B?UkxJQXI5eFRic2E4UjhEQmJqcjgwdGg0SzhjeUVla1V3ZlFNeXZodDNyRjdP?=
 =?utf-8?B?bThHSm82T3VJMVNKS1pQdFZYaWZyYnYvRXRDYUQrWVN4YlJQV1Y2cGs4TmJU?=
 =?utf-8?B?cmtEZEdmK2ZEWHdnTkgrWXoxQ3NNV3lldEYvV202eXYrWDh1WTRsbUl4aU5K?=
 =?utf-8?B?T2NFbVdWWjNaMFNCcjlIVExwMlJ6d3dodnN3TGlCUW5nS1hYRjJ0YnVTR3Zk?=
 =?utf-8?B?K2lNRDBVS1lPY2E4aEFZZW14U2swdXVuVW1wWXV1WmhTZ0Z1dU8vWGZnRzJL?=
 =?utf-8?B?bTJxa2I3a1FvWDArNW1SMUFCYTUvRDlTRUdUNFdKdWxBYm9PeFp0N1FMSVNt?=
 =?utf-8?B?S1dYMWJhWkJZMmpIVG8rWmVzTkJmVTA4Z0JJR0h4K0pqellpN2lmY3Q2WnhH?=
 =?utf-8?B?emhUdTh3TFVNbm1NZDBnbEdITTZIaW5vYkhZWmU5OTFYdkxGYU96dUtRQ1NF?=
 =?utf-8?B?YitkWGZqM2YweHVSMHJVR1kxeUlJTU9sb0Vqa0FvdzNVMERlUStwRG05R2px?=
 =?utf-8?Q?VYVjclRgFQwhkFrzio=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11BDEE66E5C0734492A03558FD34D9B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ff6148-552d-48f5-467d-08d9240b239a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 08:07:30.9551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmXolzZabgiNZqamu65aue08CtwJfS0lcya8n4IfALFH9eYQCKReigyNlrK3pdSjxhID9SigGM65rl90SuCkU596fU4C3yefaqpF5f1A6YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zMS8yMSAxMTowMCBBTSwgVHVkb3IgQW1iYXJ1cyAtIE0xODA2NCB3cm90ZToNCj4gT24g
NS8yMC8yMSA2OjU4IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+Pg0KPj4gVGhlIHNlY3VyaXR5IHJlZ2lzdGVycyBlaXRoZXIg
dGFrZSBhIDMgYnl0ZSBvciBhIDQgYnl0ZSBhZGRyZXNzIG9mZnNldCwNCj4+IGRlcGVuZGluZyBv
biB0aGUgYWRkcmVzcyBtb2RlIG9mIHRoZSBmbGFzaC4gVGh1cyBqdXN0IGxlYXZlIHRoZQ0KPj4g
bm9yLT5hZGRyX3dpZHRoIGFzIGlzLg0KPj4NCj4+IEZpeGVzOiBjYWQzMTkzZmU5ZDEgKCJtdGQ6
IHNwaS1ub3I6IGltcGxlbWVudCBPVFAgc3VwcG9ydCBmb3IgV2luYm9uZCBhbmQgc2ltaWxhciBm
bGFzaGVzIikNCj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUu
Y2M+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL290cC5jIHwgMiAtLQ0KPj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL290cC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9vdHAuYw0KPj4gaW5kZXgg
NjEwMzZjNzE2YWJiLi45MWE0YzUxMGVkNTEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL290cC5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL290cC5jDQo+PiBAQCAt
NDAsNyArNDAsNiBAQCBpbnQgc3BpX25vcl9vdHBfcmVhZF9zZWNyKHN0cnVjdCBzcGlfbm9yICpu
b3IsIGxvZmZfdCBhZGRyLCBzaXplX3QgbGVuLCB1OCAqYnVmKQ0KPj4gICAgICAgICByZGVzYyA9
IG5vci0+ZGlybWFwLnJkZXNjOw0KPj4NCj4+ICAgICAgICAgbm9yLT5yZWFkX29wY29kZSA9IFNQ
SU5PUl9PUF9SU0VDUjsNCj4+IC0gICAgICAgbm9yLT5hZGRyX3dpZHRoID0gMzsNCj4+ICAgICAg
ICAgbm9yLT5yZWFkX2R1bW15ID0gODsNCj4+ICAgICAgICAgbm9yLT5yZWFkX3Byb3RvID0gU05P
Ul9QUk9UT18xXzFfMTsNCj4+ICAgICAgICAgbm9yLT5kaXJtYXAucmRlc2MgPSBOVUxMOw0KPj4g
QEAgLTg0LDcgKzgzLDYgQEAgaW50IHNwaV9ub3Jfb3RwX3dyaXRlX3NlY3Ioc3RydWN0IHNwaV9u
b3IgKm5vciwgbG9mZl90IGFkZHIsIHNpemVfdCBsZW4sDQo+PiAgICAgICAgIHdkZXNjID0gbm9y
LT5kaXJtYXAud2Rlc2M7DQo+Pg0KPj4gICAgICAgICBub3ItPnByb2dyYW1fb3Bjb2RlID0gU1BJ
Tk9SX09QX1BTRUNSOw0KPj4gLSAgICAgICBub3ItPmFkZHJfd2lkdGggPSAzOw0KPj4gICAgICAg
ICBub3ItPndyaXRlX3Byb3RvID0gU05PUl9QUk9UT18xXzFfMTsNCj4+ICAgICAgICAgbm9yLT5k
aXJtYXAud2Rlc2MgPSBOVUxMOw0KPj4NCj4gDQo+IEknbSBub3QgY29udmluY2VkIHRoYXQgdGhp
cyBpcyBnb29kLiBJIHNlZSB0aGF0IHdpbmJvbmQgdXNlcyAzIGJ5dGVzIGFkZHIgd2l0aCBmb3Ig
dGhlDQo+IFNQSU5PUl9PUF9SU0VDUiBhbmQgU1BJTk9SX09QX1BTRUNSLCBldmVuIGZvciBiaWdn
ZXIgZmxhc2hlczoNCj4gaHR0cHM6Ly93d3cud2luYm9uZC5jb20vaHEvcHJvZHVjdC9jb2RlLXN0
b3JhZ2UtZmxhc2gtbWVtb3J5L3NlcmlhbC1ub3ItZmxhc2gvP19fbG9jYWxlPWVuJnBhcnRObz1X
MjVRMjU2SlcNCj4gDQo+IE1pY2hlYWwsIGNhbiB5b3UgZG91YmxlIGNoZWNrPw0KPiANCg0KRG91
YmxlZCBjaGVja2VkIHdpdGggTWljaGFlbCwgbG9va3MgZ29vZDoNCg0KUmV2aWV3ZWQtYnk6IFR1
ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KDQo=
