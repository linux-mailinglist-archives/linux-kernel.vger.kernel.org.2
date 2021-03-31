Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5838B35078F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhCaTlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:41:53 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:15533 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbhCaTlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617219679; x=1648755679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9bd2R2SSm1hcptPDwabchIHhSMUNsobJtRpS7y6D02M=;
  b=RTSfu01iz1ei/6r0FAvf9nEl4l9I4fJrxYWUbhlA5sVeCkwfa3ZLeLNZ
   Xp4gRXdRQVbkZdw8dgw5YcaND0jRS/LPbWj8cCWpkDioLawxYuyIpKyOG
   caSgD40Y9UXcplRUkLyKZTuWkJcJSKUqRJQ4COypRGz66fGiAIhoSxOCR
   hEdBDlQdv+76Wt65v9/7MBXbV9dDOccAxrR38WgCmESkjrlZb0glv7sXP
   E6qddPQmm1tytAIfaFAjFntzUbxBhOj6BPjs7uLQGSWY5Axw3ys9hj/m+
   VeHJKMMbhHjh8Vye6LHjrVR3IWJpxMOnW5lZjTDKUj8cF1bn2ths4iW+l
   g==;
IronPort-SDR: hAOlkm2MazdspDraw1B7DTLl4GdQjU7wDB0O0mavUdKTAUTUg8bKWZfnnVnGOsyZCWM7hc6ogo
 R9NFiJ7xbUF9JXtb0J89UZ7weNpggM8e0mAKJmnpkZVk0vBmnQQuN9RlnfItYHIi0Va5C2xRLz
 kwbH0TfrtRs7qnuNTCffpdsDSTDHa67dCJF3rXP7R4BqS4gOW+BGh49rTrBvysli4HaKKm7fV8
 V77Ngz7jcVd5DUFRcFZ2HpXgEVQjDwXY3GIizvqKTOc7hqOnbphxymKF6QHeTCSRpEVOwTcN15
 Sng=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="49593739"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 12:41:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 12:41:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 31 Mar 2021 12:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE4QEUxOe7Dq/jFBF28si6x+sqj9Qtu/1NKCK39CSRU94NWtjLaE7QQkuXhKBLmyanpZhINLnZezb76tiF8obOMtD3SFtQiCdUg1c/7L7A75DqBuhDY5bXo6T5pwpDmf1qlu93KZBAxncso5x9hX0WoK64eZOr8fgHav3XS4kGPo4eEH7VM6EC1Gitgp1cbQIWJMyeuIJywGBF+wLhFVjxVkE3Txgbe4WpqGgzCqtYE5TqoJl8TE/zKqgfYNlAFg8z1/WW+XgmflhfDvshdBhsGpwQT4TdqPY1lfZMzy8Rz5sRwhnFMNHQTO/Rv0TSPQR5A0SuSpF6TghTGiPYeQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bd2R2SSm1hcptPDwabchIHhSMUNsobJtRpS7y6D02M=;
 b=L8pfWCB+hE2BkZ2W9pO5sb870JVzoRnoq2W46s1hp0ctlc9nTwgyiwPPggQVtTZ4hMSxZPasq4CI2V7FIGmDF4N0VLWEgEeZHk9KAAfHP2aQg8M38lhHeob1dWfxPO6+oTgp8Xiwx6zR/TejFlvDgYd9g0sLGdb+fbqD8tONNezTS7HHgGljyztn9pDocgdkdcD4LKZ25JbqwjRFPpnU9iBHI8rQT7OUH7Uk3D0o2p+tPi2wq52PP0C937y4HCfB9/g9HlXU/7vDjdtfEYQ1w4gJrPPwnFZZgLWEXw9W7V4O46pxuw91KhB+hZLjV18l/XVnlVFGNW8dUv8+sKguUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bd2R2SSm1hcptPDwabchIHhSMUNsobJtRpS7y6D02M=;
 b=SznRzRgdkYEtU0lK0675V3ZC1QACNsQrmHNGiZbVAqAUBvOiSesW0ugeitm9VdKYKrzNdo1vUfys62xeLoVjl0Hun+4j1JiNL1WgcPp+ikeJdZX4fnx5/uR5/YTxqyyOto3ffTZdNe2WSyaRH1rUpF7iaEq7cFezUizfYdxjiSU=
Received: from MWHPR1101MB2288.namprd11.prod.outlook.com
 (2603:10b6:301:53::11) by MWHPR11MB1645.namprd11.prod.outlook.com
 (2603:10b6:301:b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 19:41:16 +0000
Received: from MWHPR1101MB2288.namprd11.prod.outlook.com
 ([fe80::f1c8:bb6e:79a2:1e65]) by MWHPR1101MB2288.namprd11.prod.outlook.com
 ([fe80::f1c8:bb6e:79a2:1e65%12]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 19:41:15 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>,
        <robh+dt@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/2] usb: typec: Add driver for Microchip sama7g5
 tcpc
Thread-Topic: [RFC PATCH v2 0/2] usb: typec: Add driver for Microchip sama7g5
 tcpc
Thread-Index: AQHXJabxGHnGM9FAeUOvdjG3n6OHl6qdoPIAgADfX4A=
Date:   Wed, 31 Mar 2021 19:41:15 +0000
Message-ID: <b42ddee2-1006-7e46-2df8-156c14c3a2e0@microchip.com>
References: <20210330205442.981649-1-cristian.birsan@microchip.com>
 <YGQU+g8J6gZhn13X@kroah.com>
In-Reply-To: <YGQU+g8J6gZhn13X@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [2a02:2f01:5318:7c00::92e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99e9435a-ab97-491d-ff78-08d8f47cf2b8
x-ms-traffictypediagnostic: MWHPR11MB1645:
x-microsoft-antispam-prvs: <MWHPR11MB16458ED330A2E5D80228E647EF7C9@MWHPR11MB1645.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1v6dLaLfXw9iKWF74EoAEMSYpPx/7puB5YrL+qAKK0aA/PojGLogqAKLYpYqry4EbUe/KXf650P1NoIYnGs9uBL3Cu6uoAv/2066myRoFSwPVaz76P2LHVPRO5+0wP/c8T3JbErWXLkhUftOm6QLAvKTpN6/qoaJQRPXbcrQyF7ASoXbJ2j4ovVRyfl3CGdbTseftDWugG4qSUUoFABrk+xXLdY4sQ2dfkL9n3gLC0BqYILGLjmNfA/lqI0qGjFI/093N43JIPRM4wDX6sCCNgtX9d8LLhMbfJ7/iH1IW7a5U+4bcQSOdLLxIPJnkBL7ED6g1WASGT1CP6SEhxQsk3CRKTZaaYb+q8SvO+q1ZLSIRDnUNrT7u29ELXDI4A2FPi4Ob0rhKkdpLu6KldumcTvs1BweY5/e7/wIAlBWax7y7PaFhEbRIiPrkOBFhaEbMmhHKb2SuNP34pyERqdM96QGPjYPRy8coMHIMqZzyJzAr38KQsJkvozyKhLT0vl9RpXsIn22i8f+5IT2zk30FPnTaXdIX46+ZcIXQJY4jXZ7AajEtXOevYZsTDsaGVDmS2J4tfIJgBWUIS7ES1trWtGfYpk/i4jkH6/vr4Mik1qSwfkb40S+q5oRE55QlYJXlX06u2ecXyh+ilrpBFuWVkFbrRvKOuIy8xQjCxOPPukcfLrYxpuiQwtX4w45zlG16ov1uW5dkA3v0+NG5k+BBiyPoiRXrtOnlFBHIiRBYw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2288.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(366004)(136003)(64756008)(8676002)(66556008)(31696002)(66446008)(76116006)(66946007)(186003)(36756003)(6506007)(66476007)(31686004)(2616005)(6512007)(6916009)(478600001)(316002)(4326008)(54906003)(6486002)(83380400001)(86362001)(2906002)(53546011)(71200400001)(91956017)(5660300002)(38100700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SWJvNlVWS0JPVDdqL3dYQXJ4NGxSeFh4TzRRaWg4ZW9BbTJWbXBDeEJHZXY4?=
 =?utf-8?B?emhnZTV3NVBzMDk2NHltazJYcjFWaGZYS1RMMXl5M2M4RHdwN1RXS0w4ZUY0?=
 =?utf-8?B?Y01uMi9uU2xwcms3OEhiL3lvYkgzZi9WZ3VTRUlIWEZHYmh3L1R4eGhyM3ds?=
 =?utf-8?B?YjZESXVYWmxhVS9LbDA3Z3lUZ0dBZmRJQk50aDlhamFXaUh6N2ppMUNkUHFl?=
 =?utf-8?B?bE9WandtZk1xRU0rZkpLRUd3WUpNRlBMaW1wMTcwOG9vekN6WHZNYTZJdE4r?=
 =?utf-8?B?V3RGY1lXL2pSK2hjb1U0eXFyd3FHWllqOXdPQlkwSlg2MVl4Rkh6Yk5zb1o0?=
 =?utf-8?B?N0liUGpld1ZZSXoraDkwOEF5QnNndmRDK1ZYdlA4eklFb3RQSjVmZStTbzFT?=
 =?utf-8?B?UEw1ZkpnQytiSjhLaVV6QVkxVmFBYUlJZjFIVEZkbzdLNzdPQytUVGFVRlNR?=
 =?utf-8?B?RXNDOTJaSE9xU0w1NlBQQXVxcTQ2a0YwSFVqeGE1MFZucFg0bnFoMDhTbWR1?=
 =?utf-8?B?Z3FJWkNGRHEvcng5MStPakh2OEFKSkxLNzFIQUJlMmwyVVZhR1NpeEtkYnBV?=
 =?utf-8?B?UjV0eUJSMncvdE9xQ05ZVWZ6Z2FNWmhXano0VUtNL2h2T0RmQnVVQXczUVly?=
 =?utf-8?B?dFZPWXZwSXh5cU1KUlUxVmF5akVPcDYxN0xtSHE5dWpKZ0l5ZTFqR0NVY0Vy?=
 =?utf-8?B?ZmMydENoY01WRlVQUzJoczRrTTFNSVVqZml4V0hQV1ZrbVpnZWE1ZHpDYWl6?=
 =?utf-8?B?ejJTMStkVHU5Y2loSVdJL04xVVA3anVMaGVXRUtTdm1vekxoV3V1OUpWeUt0?=
 =?utf-8?B?cXViNjVZVERLV2J0WllhVE5QSWRXTVNyK3R1SjNoNkluWk1sV3k1TnlhcU5K?=
 =?utf-8?B?cUx0cVJvL0k0czl1cm1Tdis0QTl6bzBSb3RZNHlzY3RqMUVqTDNrQjFMWTBX?=
 =?utf-8?B?amJ3OVM4bnZSaXBWZHdSTFQxczJkYm5lY3U0aUYxdlVRWGdTZEJmVjZzWk9X?=
 =?utf-8?B?N09sK015R244THRENFUwRkdTYVhDZEtQNHAzMlBTVm1SaFdGME0wMERSRHFt?=
 =?utf-8?B?WklRdmNJOHFNMEFOSWdMaFh3UHdjYnlYeitYL3RsY0ZBSyt0ZUNzVG1ndXN6?=
 =?utf-8?B?Zk5VaTFQWjMyZTFhcEZDWFpybWx3bHFGTlNRTW9HV1hqYWJDMjU0SURsdy90?=
 =?utf-8?B?WlhyRjFmQ0swb09iWEpXUFlpdzFrbkNoUG45dkcybDRaNERBMk4rUkIyTE82?=
 =?utf-8?B?RUM5VHVkMXJQWjhPb0FiYmFTQWtiTE1vRnVHS09NWjFta2t3K1UzUlQ5SjRC?=
 =?utf-8?B?aGVFUlpqMjdIM3N1Rk9TVFRtb1ZUTmo3S21sZFdJNVg4TUJueER0RXZPWUVO?=
 =?utf-8?B?dW5GYzB5SUw2NGVCOHk1azNqVmZtUnJEaHE5a0tBbDVHK1F3ZVZIUWs4UUMx?=
 =?utf-8?B?aWdJS0NrNktLR1I5WEhxaGVXeWhGaDB6YUtraDI3MVNJVmN2bWZiQjlDWW5P?=
 =?utf-8?B?R2Z3UDI4WEh2bnJmallMc3l5cTQ5bWhZRXA0MjhhL1dlLzdEV1hMTXNJOElH?=
 =?utf-8?B?SGNKNXVCcm5hN1UrTG5qN0tpdlhFd1B1Q1ZrYldDZ2FudXhFU0E1YmZZMk9Y?=
 =?utf-8?B?SG4rNmtaaFhEbWhOKzNKYUlwajAyZEdRZ0h2UGRDRDNVSG90eXp6T1R1SzFX?=
 =?utf-8?B?MzBKSTVyayswQmNaWE9DSUlWTTd2SVhxZG5HVlM2WHBGT0FoQ3B3eDNnemJR?=
 =?utf-8?B?bzhTQ1drb0NzS1V3Zm1lWDhBYWRMMUZuRmFxdU1odkJCdkF3dm15bC8wZzdC?=
 =?utf-8?B?aGt2UmNHVnBFcUlsL1dkQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF899984CF71524AAE6A59FD98B5F07F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2288.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e9435a-ab97-491d-ff78-08d8f47cf2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 19:41:15.7128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYc0mudstwLRfTAwsugzdm2RlFWiIijOvTKbtqb5ogCm/4vCS/xYFe3+0+iWQ46XtgXCr+CepKbF2s4s8dEZh+2vhR7XG5hu6Gbx1/wEaQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1645
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMzEvMjEgOToyMSBBTSwgR3JlZyBLSCB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgTWFy
IDMwLCAyMDIxIGF0IDExOjU0OjQwUE0gKzAzMDAsIGNyaXN0aWFuLmJpcnNhbkBtaWNyb2NoaXAu
Y29tIHdyb3RlOg0KPj4gRnJvbTogQ3Jpc3RpYW4gQmlyc2FuIDxjcmlzdGlhbi5iaXJzYW5AbWlj
cm9jaGlwLmNvbT4NCj4+DQo+PiBUaGlzIHBhdGNoIHNldCBhZGRzIGluaXRpYWwgZHJpdmVyIHN1
cHBvcnQgZm9yIE1pY3JvY2hpcCBVU0IgVHlwZS1DIFBvcnQNCj4+IENvbnRyb2xsZXIgKFRDUEMp
IGVtYmVkZGVkIGluIHNhbWE3ZzUgU29DLg0KPj4NCj4+IFRoZSBjb250cm9sbGVyIGRvZXMgbm90
IGltcGxlbWVudCBwb3dlciBkZWxpdmVyeSBhbmQgdGhlIGRyaXZlciB1c2VzIGR1bW15DQo+PiBm
dW5jdGlvbnMgdG8gcmVnaXN0ZXIgdGhlIHBvcnQgd2l0aCBUQ1BNLiBUaGUgY3VycmVudCBzaWxp
Y29uIHZlcnNpb24gaXMNCj4+IG5vdCBhYmxlIHRvIHRyaWdnZXIgaW50ZXJydXB0cyBzbyB0aGUg
ZHJpdmVyIHdpbGwgcG9sbCBmb3IgY2hhbmdlcyBvbg0KPj4gQ0MxL0NDMiBsaW5lcy4NCj4+DQo+
PiBTdXBwb3J0IGZvciBzaW5rIGlzIGltcGxlbWVudGVkIGFuZCB0ZXN0ZWQgd2l0aCBhbiBVU0Ig
ZGV2aWNlLiBUaGUgcGxhbiBpcw0KPj4gdG8gZXh0ZW5kIHRoZSBkcml2ZXIgYW5kIGFkZCBzb3Vy
Y2Ugc3VwcG9ydC4NCj4gDQo+IFdoeSBhcmUgdGhlc2UgbWFya2VkICJSRkMiPw0KDQpJIHNlbnQg
dGhlIHBhdGNoIGFzIFJGQyBiZWNhdXNlIEkgd2FudGVkIHRvIGdhdGhlciBmZWVkYmFjayBvbiBp
dCBhbmQgb24gaG93DQppdCBmaXRzIHVuZGVyIFR5cGUtQy9UQ1BNIHN1YnN5c3RlbS4NCg0KPiAN
Cj4gRG8geW91IHJlYWxseSBub3QgdGhpbmsgdGhleSBzaG91bGQgYmUgYWNjZXB0ZWQ/ICBXaHkg
bm90LCB3aGF0IGlzIGxlZnQNCj4gdG8gZG8gd2l0aCB0aGVtPw0KPiANCg0KSSB0aGluayB0aGUg
ZHJpdmVyIGNhbiBiZSBtZXJnZWQgYWZ0ZXIgSSBhZGRyZXNzIHRoZSByZXZpZXcgcmVjZWl2ZWQg
b24gdGhlDQptYWlsaW5nIGxpc3QuIEF0IHRoZSBzYW1lIHRpbWUsIEkgcGxhbiB0byBlbmhhbmNl
IGl0IHdpdGggdGhlIGZvbGxvd2luZzoNCg0KLSBhZGQgc2luayBkZXRlY3Rpb24gYXQgcG93ZXIg
c291cmNlIGFuZCBjaGVjayBpdCB3aXRoIFVTQiBIb3N0Lg0KDQotIGFkZCBhIHdheSB0byBub3Rp
ZnkgVkJVUyBwcmVzZW5jZSBiYWNrIHRvIFVTQiBnYWRnZXQuICBBcyBUQ1BDIG5lZWRzIHRvDQpk
ZXRlY3QgVkJVUyBhbmQgcmVwb3J0IGl0IHRvIFRDUE0sIEkgbW92ZWQgdGhlIFZCVVMgZGV0ZWN0
aW9uIGdwaW8gZnJvbSB0aGUNClVTQiBnYWRnZXQgZGV2aWNlIHRyZWUgbm9kZSB0byBUQ1BDLiBG
b3Igbm93LCB0aGUgZ2FkZ2V0IGFsd2F5cyBhc3N1bWVzIHRoYXQNClZCVVMgaXMgb24uIEkgc2F3
IHRoYXQgc29tZSBVU0IgUEhZIGRyaXZlcnMgdXNlIGEgbm90aWZpZXIgY2hhaW4uIEkgY2FuDQpp
bXBsZW1lbnQgc29tZXRoaW5nIHNpbWlsYXIuDQogIA0KPiBJIGRvIG5vdCBub3JtYWxseSByZXZp
ZXcgIlJGQyIgcGF0Y2hlcyBhcyB0aGUgYXV0aG9ycyBkbyBub3QgdGhpbmsgdGhleQ0KPiBzaG91
bGQgYmUgbWVyZ2VkLCBhbmQgd2UgaGF2ZSBwbGVudHkgb2YgcGF0Y2hlcyB0aGF0IGFyZSBiZWlu
ZyBhc2tlZCB0bw0KPiBiZSBtZXJnZWQgYWxyZWFkeSA6KQ0KDQpVbnRpbCBub3cgSSByZWNlaXZl
ZCBhIHJldmlldyBmcm9tIEhlaWtraSBLcm9nZXJ1cy4gSSB3aWxsIGxldCB0aGlzIHZlcnNpb24N
Cm9mIHRoZSBwYXRjaCBvbiB0aGUgbWFpbGluZyBsaXN0IGZvciBzb21lIHRpbWUgaW4gY2FzZSB0
aGVyZSBpcyBhZGRpdGlvbmFsDQpmZWVkYmFjay4NCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3Jl
ZyBrLWgNCj4gDQoNClJlZ2FyZHMsDQpDcmlzdGlhbg0K
