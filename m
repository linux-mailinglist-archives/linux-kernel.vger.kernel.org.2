Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71B41905F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhI0IH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 04:07:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42921 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhI0IH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 04:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632729949; x=1664265949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fwTEGIKTS/6Ox+82FNSGt3Nul1O4rUH0ACC+L85ve1Y=;
  b=aKExXG73jive3c+gobfj2R8bBWxRHz/vZHrG2F1SmwTxFLArdn+al/nw
   r90+8zppAVDyAS53TT9N21AuUNWsrzr4iDnl9W/e5LRYpzm1p1OmD/5r5
   T6wJXaLygxNLS0EdsIz44BsP/Ejr+Fh6jshZx4xT8pL9sQU55LwCWZs5U
   +inIp7G99fMqIvesIzIZ5zNeIg6LggLbQuARTuu1hCidRaNokGD6VWR0T
   WHxhGXFQwiABU6UIkXcwzG1AukFEMzQ3oXJkTNMdReUA4tqp2ofAns68J
   Fbp2Zsm2ZNr02JJ/HnmtNo97b5ZBvlajTP2RdFrSZBW+9Yppct/aPO67s
   A==;
IronPort-SDR: eQN4ScN+ej05R5vseHxxaPbl9Lh/bhUoUx1p6qF3WKqHpzInk8I9FpputNMlTHrNv1bGtZsONz
 33HaMt53a5HmWqCLRxavBZOwK/0Vf0HISNZOqqVgKRrx4eJ/7sXRNGODpE6ANGFye3Kj2qYuAg
 drmK7+ywWiTUKYgO+AGWeYjyR+/tfUR9IEXwV5eyjX6oVvwQFKe4wmT4m2HxkRc4ad8GF16UIn
 EFYUX5PMb6mGfCbdp5GiT08vJSJdJcV2G2Zcrf6eOSifzAIV1X73PXC/1+AKJgjkP+Fq6eNjrK
 Bl5Y1ZF0GDp8rD8L2UycyujX
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="145728234"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2021 01:05:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 27 Sep 2021 01:05:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 27 Sep 2021 01:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTJ2F3cvtsDN0ikpxAebb6d6Va/eSrnlGquJdn0Q+YrymnAiFTMP9gPwpw3jvgEV85ju+qBcMnLOAUsoqS70muKL3vBprQlOtszcZW9IJSVK5hvTwexdMUBgDpGT2UYwkPZAPPOofieplpvkRNUDyFDMNUAQ1QBrtSmVbfaKYrwRMTzC92n6IEWOn1NZ36jkoMbCaEu/ZUIYTEzE5tHm9reCsiQoBzpidn52CvsY9ALfkngsfRaxR+Ga//vp7pkH21wXZDoG6q6irMoPF8NHkRnTZ5dTyPUypubZdhirPn2ijc9AYAZXGeTTELHCl0dsg67QT64jwakNsaSrsF25/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fwTEGIKTS/6Ox+82FNSGt3Nul1O4rUH0ACC+L85ve1Y=;
 b=X256AueBn++XI2feYS4WJtTiQb7cEakLXiCtVkt9b+ThYWe2z1CINpJtobX9iqMPxncUnFpRiLAsPWbfUXDvjsiu4yJoGT/Qs63ma/I9RB2/N19Hp7B2cD+cI17MrifaSxiBFTk0LECAD255l1nn4xq9BUOmbD5tIepLUvvcxJk29TlFW9KqJJ8Mm7HaUA35PGxWf8Jwudwe0UOBYvIAQ0UUNauntPfPznfO1qwF9glX9hUF/U2brAdsGhcaGL+QPsvsiQgrm20Sl0h9kTMrNpJxByKckV10bNJNcVtHteg5dsi0uOQTewQOa7xkYcUWe68q4rUi/xFB8m7STm1MiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwTEGIKTS/6Ox+82FNSGt3Nul1O4rUH0ACC+L85ve1Y=;
 b=Ff8lnMqHhZHx3UxUSULREklHM0ilwqWVq83qZOoLS7gNCjv5vGJZSsIDhTP5tMvSwLPRyfLjxK7jH9JZjEI9hyyNwsmCic/sh3/qtcZfUXSm4wkXPF44MVl5WAkAu6Vt7/bixpcjxyAmAa566Orml4UTruN+RHjzJIr2k0vGl/M=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 08:05:43 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::c929:4928:894d:8b5a]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::c929:4928:894d:8b5a%6]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 08:05:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <maz@kernel.org>
CC:     <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Thread-Topic: [PATCH v5 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Thread-Index: AQHXs3Z4obOilqtAi0yNlpMLp8zbfw==
Date:   Mon, 27 Sep 2021 08:05:43 +0000
Message-ID: <25bae5da-db87-79fb-051c-2070ee292ca7@microchip.com>
References: <20210927063657.2157676-1-claudiu.beznea@microchip.com>
 <5284c2db6876e9f6f49f63f8beff766c@kernel.org>
In-Reply-To: <5284c2db6876e9f6f49f63f8beff766c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5d33d4c-71ed-47b8-287e-08d9818d9ae8
x-ms-traffictypediagnostic: MWHPR11MB1789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1789988C2BA2022F9B8DA06487A79@MWHPR11MB1789.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0U2l6fYx/i1uulf7TBZ0M24dwvi0go4hYeAQ/UYeCvBafM2bPwjTBufXVih99PmH0wK91iOnr8woUy1wnjr0EiQkxbDdsvZwAAJLO4sJbinzk+KrFUkEuk+ZRl/e+ENoFuoVpt28GhSub1GXpqmkrahy6QUWmoICGYUUNW03QDZgNJowx80dRcHcx79XTlqx18XQqTkLbpAcSDi7oW5SChcD/EjFqyHlhlulOx8xOWvWnwuYkXjhELURHcpzz2ThGgm/igHWJBd+pfc2zrevgZG8Y+7VmVXaNpkt19YW0OKFDC/daw2pP0jo/DzcYDDsrWPLrqWDl7qFzJSEhg7nJKwTIGPGPlEJWXfX/7dWqIXTtBaPQDsaARzhONOH72g1LlgNo1Jfxw/SYc8sNYUMihJM86MtP30ck8i8WRuHyWvgwSt/nIWcgz4Rnh5eYFYRVpfXFhI9Wf6Vp0UodFMOkHiq+0eMkdtzR5YhLfTfZQVdknBMOmjpjZFAGnY1F79skzD8gDSOYvJNZZusndvmmXRC/jA4cuEIXYCWafmvDXM9tAXOrarQIoLR5qivqAJ9+3nd9jw1O2pmIbYH0Y/nSE//T5387biDhLtBLTu5jrbah9+fAFYg79XuJdJyGj2k1teAiAhLWN6qUxKeesp4w3eFXNxkMhRBdZCGB80A+d1X59Js1WKQaBbjoAQ3IhKWq6TebZevwN1kRK3dJViHqA0cC3hcgbrbMRqso4qeVfTrkBILfRu/UkluzvS+svqve2oWJ55dGqHTd1o/41gdvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(76116006)(91956017)(71200400001)(5660300002)(26005)(316002)(186003)(508600001)(8936002)(54906003)(31696002)(8676002)(6512007)(38100700002)(2616005)(4326008)(66476007)(36756003)(66556008)(31686004)(6486002)(6506007)(64756008)(53546011)(66446008)(122000001)(38070700005)(6916009)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXNOZ3V4SXdCbURSWEJXSmxXWTc4T0ZwMTUyb3FhcFFyZzVvSDlLNjEyZEcx?=
 =?utf-8?B?NThleWs0dXAvbzVyZStvSVRhVFd5SXAxbUpuTElzWGhPMC9ETmpsOE9WMFNK?=
 =?utf-8?B?Q0h2MWRuenBRclZWUlBRSDVMOVNZdmExNk1CU25XOW02YjV4V09TU0psdzds?=
 =?utf-8?B?RFROclAxaU1mR3N6VkwzR3BRdWU3SGZRdFBESGpTS0F0QS8rdzYvWE5OM2RB?=
 =?utf-8?B?MnVReExGemNqeWVWbERuczZvVkxWNmpLZ3M2WXZFSnF1UnEzMi9yc2cwK1Nt?=
 =?utf-8?B?SENRK0RodnIvaFEzNDZvd09MR2xadVFyWWJrUUZ1QXh5ZExaY2JVZGlnMDMw?=
 =?utf-8?B?K05uZldubUZaN05YNi9jVzJQcFNXMm5lOCtYVWRyZzYzcU9adWxzenBpMnQr?=
 =?utf-8?B?bHJxZ2drWk03dklIbmhyUXh6bW1vdGJrdFJCRVFPOE9QR3V6ZjJ1YkQxc1RM?=
 =?utf-8?B?dG5sUXZGVCtRdmp2OFk5QkxsSDRYYnp6RUFIK1hOeG1iSzJhVGkvclcyblU4?=
 =?utf-8?B?bXhTajcxcjRsNXc0ek5ZKzF6TGJuSXVScWUxNkxrdFlRWUJLbkhRRWprY0w1?=
 =?utf-8?B?Q2x3Z2JYT0c2SmoxZVY4SGQ1anZjME5jZFUvMEdSSGhtc0VjQ3JpRWN1cEgy?=
 =?utf-8?B?Q0l2d3lnREtnWTNaN2lPUHpOVG5nekJNTVYwc3FxUlhqSCtxZFc1TUZubm1R?=
 =?utf-8?B?S0Y1Rlk0SEEyZE5qdmQzdHd1ek9YNEhLQldIamtMcGx6Q3V6NzJabEJLQWxQ?=
 =?utf-8?B?Y0ZMVW4rMlFockRaYkk3bkVacFZKUVA4eFY5MUl6bzVHOWF5TCszTUx4SGtl?=
 =?utf-8?B?YXRzZG5yN25BWkkvenYxWklPZVJadFg2MzhwSHVMUmxYNUZ2dU1ZVHFIVUJx?=
 =?utf-8?B?Qk9XV3VuMkNtMnQzWlNNdUpaNkh6WlVEOEtYKzFoRU1PYzhUQzBhdSswUDcv?=
 =?utf-8?B?UUNlclpYQXplakcxVE9ZaG1PZms1eUlSMGNGUVYyMUEwdGRrWEl1S2ZKS0lE?=
 =?utf-8?B?NE1wMUVWYTliTFk1MWx1WVZzL1FoQTVRTzdUVmJkOWlzdys0WmtJM3ZHd3ZK?=
 =?utf-8?B?Ujl2MjNCdElYNkZuaHluSTNpUDgyY1RqYldWQ1pjZDhrZU5lSjZTb29RUjdk?=
 =?utf-8?B?UEZhZ3RFVWZ3QkRxZUNvQ3pOSWJHN1pzNmdIbDhxNFhUeDcwblN2WWxvWEZ2?=
 =?utf-8?B?N0NsTjZPQ1NXbVpaaFV2K1ZCdUk5N3Q1cG0vZFJzMkh0azZOLy8yTzRPL0F0?=
 =?utf-8?B?RkJnOXh5NkZzK0VuN3NFd2lJNE8xQ2krZlhJSDJCU3FMSlVPTS94Rm9oMWZW?=
 =?utf-8?B?WDVYVy9nckV3UFpKc3o2MmJvVjBjTmpQcnFsdnhKa2l4cm9PU2hxVUlnZThI?=
 =?utf-8?B?V1VDZHpHQStQYTB0QnVTMUlKMkVnRWVoakx4UnNreVdHZmFHQkJ5QkhkMGJ6?=
 =?utf-8?B?U3lCN2lGSFd6U25jR00zZktyTFprV1l5TEFSV2d3SERDMXVkREZQRis5S2Zi?=
 =?utf-8?B?R3VBc0JQVnBmdHo3OVh6U2lyZGVzcFNKWUVsNXVYbTFuV0RkUEcwdkRJL2xQ?=
 =?utf-8?B?UEtsQTFNYmhTenQ4Y3VJN3ZrQTdPeVhiUGI2cFdyOEJjdk9mSkhWZ3V5clY0?=
 =?utf-8?B?UWlqWnFwZkZ2NFVDeWJqaGVmNXl6bHpFZkNtekdsVzI0VmV6bkpGd0lOd0cx?=
 =?utf-8?B?NTJZVytpcWEyL2dYejF2Rm5LTUNQZ0pmdXlFR0EzamVKS056OHVIMElrZGp1?=
 =?utf-8?Q?UrDeyOxp7Mc7QaDd5M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <461EF38B0D74D549998581DC34A9D44E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d33d4c-71ed-47b8-287e-08d9818d9ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 08:05:43.7380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQmex5Kiy07BIarIAK/8fbbuTRlwqcAuirOOqFyeabgACQm7lwlBcfx322TAe1EGchV/5MKtl/u5Z4HIfMl7pZJmnrHS1eepwk6DxsyTGEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1789
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcuMDkuMjAyMSAxMDo0NSwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IENsYXVkaXUsDQo+IA0KPiBPbiAyMDIxLTA5
LTI3IDA3OjM2LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IFRoaXMgc2Vy
aWVzIGFkZHMgc3VwcG9ydCBmb3IgTWljcm9jaGlwIEV4dGVybmFsIEludGVycnVwdCBDb250cm9s
bGVyDQo+PiBwcmVzZW50IG9uIFNBTUE3RzUuIFRoZSBjb250cm9sbGVyIHN1cHBvcnRzIGZvciAy
IGV4dGVybmFsIGludGVycnVwdA0KPj4gbGluZXMgYW5kIGlzIGNvbm5lY3RlZCB0byBHSUMgYXMg
Zm9sbG93czoNCj4+DQo+PiBwaW5YwqDCoCArLS0tLS0tKyBFWFRfSVJRMCArLS0tLS0tKyBpbnQg
MTUzIChmb3IgcGluWCkgKy0tLS0tLSsNCj4+IC0tLS0tLT58wqDCoMKgwqDCoCB8LS0tLS0tLS0t
PnzCoMKgwqDCoMKgIHwtLS0tLS0tLS0tLS0tLS0tLS0tPnzCoMKgwqDCoMKgIHwNCj4+IHBpblnC
oMKgIHwgUElPwqAgfCBFWFRfSVJRMSB8IEVJQ8KgIHwgaW50IDE1NCAoZm9yIHBpblkpIHwgR0lD
wqAgfA0KPj4gLS0tLS0tPnzCoMKgwqDCoMKgIHwtLS0tLS0tLS0+fMKgwqDCoMKgwqAgfC0tLS0t
LS0tLS0tLS0tLS0tLS0+fMKgwqDCoMKgwqAgfA0KPj4gwqDCoMKgwqDCoMKgICstLS0tLS0rwqDC
oMKgwqDCoMKgwqDCoMKgICstLS0tLS0rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKy0tLS0tLSsNCj4+DQo+PiB3aGVyZSBQSU8gaXMgdGhlIHBpbiBjb250cm9sbGVyLg0K
Pj4NCj4+IFRoYW5rIHlvdSwNCj4+IENsYXVkaXUgQmV6bmVhDQo+IA0KPiBDYW4geW91IHBsZWFz
ZSByZWR1Y2UgdGhlIHNwYW1taW5nIHJhdGU/IDMgdmVyc2lvbnMgYmFjayB0bw0KPiBiYWNrIGlz
IGp1c3QgY291bnRlciBwcm9kdWN0aXZlIGFuZCBhY3RpdmVseSByZWR1Y2VzIHRoZSBpbmNlbnRp
dmUNCj4gdG8gcmV2aWV3IHRoZSBzZXJpZXMuIFBsZWFzZSBzZWUgWzFdIHdoaWNoIHNheXM6DQo+
IA0KPiA8cXVvdGU+DQo+IFdhaXQgZm9yIGEgbWluaW11bSBvZiBvbmUgd2VlayBiZWZvcmUgcmVz
dWJtaXR0aW5nIG9yIHBpbmdpbmcgcmV2aWV3ZXJzDQo+IDwvcXVvdGU+DQoNClllcywgc29ycnkg
YWJvdXQgdGhhdC4gSSdsbCBrZWVwIGl0IGluIG1pbmQuDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUg
QmV6bmVhDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IMKgwqDCoMKgwqDCoMKgIE0uDQo+IA0KPiBb
MV0gRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QNCj4gLS0gDQo+
IEphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qgc21lbGxzIGZ1bm55Li4uDQoNCg==
