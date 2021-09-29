Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80D741BE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 07:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244096AbhI2FSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 01:18:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:2955 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242445AbhI2FSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 01:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632892616; x=1664428616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EciSwQ43KV0lJbgFx2YhMZVYQv8il55zzYzbdVilw3U=;
  b=lBEry0z6Jfj9oIrdWaec6BFI2FOvYnKwiy95aJHSQCtg1QoyS9+NjkDv
   aPAqzWPy8/HS+WYSMtNw68YJ3FNdwvYBc4RImyxcELNYGNS5FjfsbImp6
   y9uEhrbw9Pd4swKtYo03ijoVE9UKTjQypZv5F0KiUgxv/IuVoYE7EEO0w
   cFtDc0Zn526fRAf9e6KcavLH5Y9jkEkKUwIb91lD8UcqsvYkkC57F364M
   6jjkio+PdshYmryWxmnsYEsmj0E9SDDBCcYBxZGRQIa4dakgzUIHD9yG0
   hABvopUbYX+hundKiSalcQUSX4IQ1Jq+JqWV7eBMkCu9O2M9WVgA8C66b
   w==;
IronPort-SDR: zQ+of54i3TtczunI7ZiDshwiJTN/W0YayyAL6MqFfNJKnp90zb/BoyG3U5KEpA0I0bfVGoYPag
 RoZu3XVMfxocgdMHf+eGp23Qh5mHqjk2t9V2yr1RObadXGlyU9qlehwHu5tZnaCQBLqWuqf3/4
 +m7niOa+Jx2r5lnHuR92sECaEhPQEm9QnsB8fTBdEDZsiWaEtVt5bsUnQgQnSwEZ1X1H4XvuyT
 p5SqayUUzuxRistFKgPeg4Vcrub0yiKQ+7SrqG3xNFzqLisNHCc81MlyLAROzZiHJAINu/f1Cg
 gsadNjSXxyDwHHLrQdLnCyjN
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="137770422"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2021 22:16:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 28 Sep 2021 22:16:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Tue, 28 Sep 2021 22:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7yzZakrspvxlYspVK5kqiy1VNGXtAFBJwilYlARflUcuZVJycpkzXxYkMH2G1+RB+5338qDrkvS0nK5MqHiTXkvgGlAhzU4WBfypFe+aycXrGA23fo+SxN5lgoYLkhhl3GMOWFWw0yUtRSifSc8TIY9aTwkL0xcaimzqkiW36smnHojzz5SbaERlONN8GKF9PiEShgF07hDmEhGW/s7qubvSLwGjqkN4vk2edwQkw/kPDEMhN5i0iZAZ9dBdlNYCjhijn8GZPd2zsiiozZecS6CC6Jf6Xbt7XI0SmmXOxdzAcCMLRyJUs6uMMtWZkZ+Y2YdLWWpxDdQmZ4fHbxTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EciSwQ43KV0lJbgFx2YhMZVYQv8il55zzYzbdVilw3U=;
 b=fPgLBA78ezA5t0yzU7lTcEm8EbRzixwv8J46FIAu7aIc4mIb4cqhHDT6h3YdTJ7HNg5AuGLqdNRUbfqECwqdazfyy4QB2iDdlou5j1NMN9M8dqyPm6VrUd7yMMO3k9njs+SjNS0QNmXPJ8AXYdYapExdO32uHzcnUPB52vJxmTRewUH4rMwB0Y/g3EWfT406hM3Rgxne5B619yTN0JbmaAe9h4RdT0DdBMR7UiDZthcZxVnxlOHWDmL8rNXEwLARsvYdFhT2etgWd/NmcyT3r1ep6fA8ykrD7EAUq9jpYIkN7Tjj2X+tjo5Ob0WChkuTkCCySAmW9cpr45cENvpJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EciSwQ43KV0lJbgFx2YhMZVYQv8il55zzYzbdVilw3U=;
 b=oGFsZRUEaFYqDWRVR2OP+4ebwywqJjyl9LXcT4i0QEcs/njRKsuK1PzV3I4ZR2e9Lr8zIGh50XgWCE56V7fcQRAfmBrOx+wd8mPc+231CpVbOEo10+g7lC3VN14rPsAzpAL6BwQV5dkxGDlQF0jaClZujaUQEs5DZknOPl1jFEs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3246.namprd11.prod.outlook.com (2603:10b6:805:c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 05:16:52 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213%9]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 05:16:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <daniel@0x0f.com>
CC:     <linux-mtd@lists.infradead.org>, <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add support for ZB25VQ128
Thread-Topic: [PATCH] mtd: spi-nor: Add support for ZB25VQ128
Thread-Index: AQHXtPE2DU8dZXiESk6XFpKGRejTfg==
Date:   Wed, 29 Sep 2021 05:16:52 +0000
Message-ID: <4a57745e-dd0e-7890-0767-e6eaabeecd63@microchip.com>
References: <20210918072256.3505379-1-daniel@0x0f.com>
 <20210920112625.fnqayim5mg5iggag@ti.com>
 <CAFr9PX=xKoa9fCbYf6Mpn=oudnY7A=6meKBSmzNHYLFad364tw@mail.gmail.com>
 <20210928163403.iufy6rgn7imiebpz@ti.com>
In-Reply-To: <20210928163403.iufy6rgn7imiebpz@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f703c1aa-987e-4845-a89c-08d9830858b2
x-ms-traffictypediagnostic: SN6PR11MB3246:
x-microsoft-antispam-prvs: <SN6PR11MB324699F6C88DA1AEA085F30DF0A99@SN6PR11MB3246.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDBA+t6beBXBfeTEfkcnH/mgSHonoSK5d1m7AFX5ov1LcZFCSDEyLMD4Gj0c6a14Ut9AtrYXTcSHCBBmJeJ1l0IxHA3onF4bRpZNAMJW6Wfq9jcFwIOp+gNuaK4R75LwJ8LFZHw2QYIFklt9h8avj5IhANjkJPe6sIcCv2zSJiK2CBzDuVDCDr+vRrsSxFkCxHXuY6Ek4kDQFW9rn6qFs0aoD4pu6IE5NjRGQhSPjmzrpmeJKJpADg94bdNYv3XmoS6e8f1QyC0x/dYCjAMg2MXmos2D+g7woY0CxmlkG+AxLExaTZfo2/CYDXRDyYYLwefmCk+uAsZtqvkOmPcx3JppI5eTmX/SiciiCBzE5+wCvq6CsAXm7AY2kdTSdybignqV2v44DIgMa2j7AKfZqMSu3F+w9OIbhcZHbkNM37q+vh6QQq/KSMGbDaCv0q1uGFUoxC6HFlwkpob46C42Njieo8uZQqGHIs2iMgub+J8/XSdNnqjBvfpq5f3SGH3AoMtVky/cXKeTVnhDvLWlz1y6KjKgLeyV3xA6TRgXGhd3pv/z9EWf20TJj17NzGsKlvGqXmtcqdoXh5E5rIGOOLH7TWwcZH4AktOMZ+UgkZR1dtq1PJ0l7DxEXXr7S/XeT10PVcYiTU8SGnSp+DZGeiu7OZSw4U/Y/f5hhywPncKV3MHqrreKFt436ReezclsEjuydRIGY0hGx1Fr5WXp/gn+AOjtdbRhrUYIIaVBRr9WzzKOCwOLKRpskOK327xmuymJlJoWYQkfVo51tqcArKCZQsVWpcEkDtI/u0LoNpV66M4fCuCh8+jx0vGhis8Uak7y3qxfbRMvG8A8f7UcQdMn+phZxGOjfre0EJm7FP4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(2906002)(8936002)(38070700005)(83380400001)(966005)(36756003)(38100700002)(8676002)(2616005)(110136005)(31696002)(71200400001)(53546011)(316002)(91956017)(66476007)(66556008)(6506007)(26005)(6486002)(5660300002)(4326008)(6512007)(64756008)(122000001)(76116006)(186003)(31686004)(86362001)(66946007)(54906003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0NtTDJQVy83eUZkM2hIYkZvaWR6ZzFjQ29HYXR0QUVFOG8ySEkza2g3aGkr?=
 =?utf-8?B?YS9YR25qY2ZZWUIwcmczRm1KVEJHQ3N1U0hpU3N6Uy82Qzg0MWVvekc1a0d1?=
 =?utf-8?B?OVlIQlZqWVlxd0UrMmVIYzZrL1pKNm5aZGp1OFN2NmJuTUI0RUx4TnJnNjdI?=
 =?utf-8?B?TFZoMDc4Z1B2WUxiU1UxSEdCaVNUbVFFQlVUSnRDYkJTamNXa2REL2ZCcTJi?=
 =?utf-8?B?OGNqSC9hUm1pSThPSTJTaFV0SHc0ZnJvQ0VoUWdrMVh1Mkdrb0tLRnJhT3lC?=
 =?utf-8?B?Z2tHaVhUc2dzSGJqVTIzUU13SzcxTGh1WVdybGUvOE9LMU82TnhrYTdsbitZ?=
 =?utf-8?B?MnYwdVQ5ZDdqQWJGS1haZHdMcjBjQmpEa3htbDU5RFVqRDU1dVU0RkFISnpp?=
 =?utf-8?B?cFprWVdZWTcwSmR1Y3JtRUVNSXlocGhEa3BEL0dKOW02OWpmSXVFbGZpUWdB?=
 =?utf-8?B?TDhBcGU4Rkp6b0d5ZkczeFB3em1GZFM0Q3V6dlJNdzcvSzM2aHJMSXBmaWRX?=
 =?utf-8?B?WlRKUDJIUFNkVzdCRW95MUNEUzRGRUllZko0cDFQMW5yeC8xRS9XZlJCVG9u?=
 =?utf-8?B?WEx5ekJtalhCVWd0dWFkcGtXRXlacW5VK1Fvd0lldWtOMGxtMkFOMzdncHAx?=
 =?utf-8?B?b3Q5Y004UlFCU0V2d0Q4VnRoMGtZVzRUTHV1Ny8xN1FOd0d6eU1odW5RU0JU?=
 =?utf-8?B?MUV3cWhIYzVzWVRyNjcyNlByaGR2cFphNGFaQ1oxZURIWnB3ai9vb2xmK2V4?=
 =?utf-8?B?eXl2TzBrR3ZCTlk3OGVkUnp4REowMUVrWGNrYU9mZHh5am9CQjk5Nm1zSFFB?=
 =?utf-8?B?RFZwaXBnSS9QTU5NT0RhYnkxbjNVOTZHRXF4eEdOTEF5QnprK2tRUUMrTDU4?=
 =?utf-8?B?YTlzeStDaElHVXAyLzZsME53NjlENU9kT2Ntblo2c3FzZmMrcHlDdG9RR0Fy?=
 =?utf-8?B?OWRuaHdHOE9ZZ2hkd1B1VERucHNWc21KaUZtbk53WHZnM3VVcmtER1lac01v?=
 =?utf-8?B?dFFZUnNqVWp5eEladkNuaHNxalNURldJUkgwR1RqbjZ4ZDZtMXJQd3kvQXNB?=
 =?utf-8?B?bXNLWHQ3MUVEMlJvTDl2T1JnWnY1cXdBQVpLelU4TjhPc3pJU2xyRHVRdDdr?=
 =?utf-8?B?SURsTzBHN1NqUjFZZnhQaXlzekM2Mi9BaFJSRXN2Nmo2a2xiQi81VE13TU1l?=
 =?utf-8?B?VVFmYlpTWmQwbkpkWERLbVhTeDNFSlhZR21qc0N4dEJ6SXVZZ3c0K3RUbkd0?=
 =?utf-8?B?NkQwZ2FJV3RXN09PQldDYlR1K0pQOVVPellKRHJOYTQ5T0c5cnErMFhtTk9T?=
 =?utf-8?B?Z0VnaFhJODV5UHo2YTExQlp5c3ByS0tJUnpmME1qZ2E1b09GVVNJV0dRYWlW?=
 =?utf-8?B?bkhOWTN1TXYyZDl3RENPb2hockhPNm1nclFpVEh5cmswZ1k4N3JpWklkTngv?=
 =?utf-8?B?alBuMW1PV1dqYUhDV0RWSDVhZ3FxMDhjdytTM0dXMUhhbndhOElXTngvVnZG?=
 =?utf-8?B?QnJwYTVkYnE0dEs5c2Y1VTlFazQwRkFXUTg2VDJDaGxQOTQxQjN0ZW5tWG41?=
 =?utf-8?B?NTVaR0hDVEp4WDZCVzFMd2RMVHBGbm9zRXhOajg4UTRnRndPci9iWmtRcjBv?=
 =?utf-8?B?dmUxb1JQYmtkZURWN0FKblNaOVcveEJsdm5HQ3ZnK0ppYmdUNWZFdDhIU0Vj?=
 =?utf-8?B?cWJyRDFxSzRnWnB6dkV4bjcxZDZNYVQycFU0cFA1VVNDSDRIR1BkQklHWSt6?=
 =?utf-8?Q?SnM8Oe1oF34xQBYq0A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D872E1DF88ABAA4184984344A13B581B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f703c1aa-987e-4845-a89c-08d9830858b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 05:16:52.0178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRpdtJud1v0OAERYYJEuBBYyhQ/2pPA3+eqCrbFSxPjx74Az0tJf1BIulIGBeAi/31z9cUuBS4gA4Ytw5RSmyXj3lfXPgTY4PF3/G3l2mak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3246
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yOC8yMSA3OjM0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyOC8wOS8yMSAxMDoxNVBNLCBEYW5pZWwg
UGFsbWVyIHdyb3RlOg0KPj4gSGkgUHJhdHl1c2gsDQo+Pg0KPj4gT24gTW9uLCAyMCBTZXB0IDIw
MjEgYXQgMjA6MjYsIFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4gd3JvdGU6DQo+Pj4N
Cj4+PiBaYml0IHNob3VsZCBiZSBpbiBiYW5rIDEwLCBzbyBpdCBzaG91bGQgYmUgcHJlY2VlZGVk
IGJ5IDkgMHg3ZiBieXRlcywNCj4+PiBjb3JyZWN0PyBJIGRvbid0IHNlZSBhbnkgbG9naWMgdG8g
aGFuZGxlIHRoYXQgaW4gU1BJIE5PUiBjdXJyZW50bHkgc28gSQ0KPj4+IGFzc3VtZSB0aGlzIG1h
bnVmYWN0dXJlciBkb2VzIG5vdCBpbXBsZW1lbnQgdGhlIGNvbnRpbnVhdGlvbiBjb2Rlcy4NCj4+
Pg0KPj4+IEluIHRoYXQgY2FzZSwgaXQgc2hvdWxkIGdvIHRvIHRoZSBtYW51ZmFjdHVyZXIgY29s
bGlzaW9ucyBkcml2ZXINCj4+PiBwcm9wb3NlZCBoZXJlIFswXS4NCj4+Pg0KPj4+IFswXSBodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtbXRkL3BhdGNoLzIwMjEwNzI3
MDQ1MjIyLjkwNTA1Ni02LXR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbS8NCj4+DQo+PiBTb3Jy
eSwgSSdtIG5vdCBzdXJlIHdoYXQgSSBzaG91bGQgZG8gd2l0aCB0aGlzIGluZm9ybWF0aW9uLiBJ
IGRpZG4ndA0KPj4gZXZlbiBrbm93IGFib3V0IHRoZSBjb250aW51YXRpb24gY29kZXMgdGhpbmcg
dW50aWwgbm93Lg0KPj4gSXMgdGhlcmUgc29tZXRoaW5nIEkgbmVlZCB0byBkbyBoZXJlIG9yIGRv
IEkganVzdCBuZWVkIHRvIHdhaXQgZm9yIHRoZQ0KPj4gY29sbGlzaW9uIGhhbmRsaW5nIGNvZGUg
dG8gZ2V0IG1lcmdlZD8NCj4gDQo+IEkgdGhpbmsgdGhhdCBzaG91bGQgYmUgd2hhdCB5b3UgbmVl
ZCB0byBkby4gVHVkb3IsIGFueSBwbGFucyBvbg0KPiByZS1yb2xsaW5nIHRoYXQgcGF0Y2ggc2Vy
aWVzIGluIHRoZSBuZWFyIGZ1dHVyZT8NCj4gDQpIaSwgYWxsLA0KDQpZZXMsIEkgd2FzIG91dCBv
ZiBvZmZpY2UgZm9yIGEgbW9udGgsIHRvZGF5IEkgZ290IGJhY2suIEknbGwgaGFuZGxlIGl0Lg0K
DQpDaGVlcnMsDQp0YQ0K
