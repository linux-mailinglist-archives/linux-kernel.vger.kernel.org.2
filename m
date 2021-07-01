Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988513B8D64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhGAF2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 01:28:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:62394 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhGAF2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 01:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625117153; x=1656653153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0em5fEjrQkoVIF5DhNlq+Gw7kzOqERAuseGi3qTIiZU=;
  b=vju5RFgCtabnysx5SHWlnevWtM0EnoOPYP4nu2JT6L/dvt3jp1BjSzfy
   S2P2cbazqcjhEX3U39hCEtasD+VXjho82KVoqqFtU8VN2/XtMoHIrXvbL
   L5L5rbH+720WiiSV2kMp0BR62ssFmtZ9r/2wqyABez6/hbBw3KHBJivPn
   jl5TmKhjiUmSNg6U9jicxv7txgQPfGLDqPL9O0j0y/Ca5vQxJ9I8ylHqU
   iWZvXPM4hy1zECeYOvwX1NdjlmFULtGpMlOQbLf7LcUbMuMpNefsY687N
   mQXGbCXN8HqwQXKPmnyqw60DzPSsn9AHEG7ktP5rHCG5OZiwvng03Y3B7
   Q==;
IronPort-SDR: qCdAXDpi5npuvd2Oa2qK9XtdUX+yAilKlgtaI16PmYnFYM2sYRmwDlUBzBBDxc/LyxOwsZ6FoR
 N1IVhCrZL3lyErM6OqKZwTndFYV6EEh+N6oBJCDlC1nWED+rVWapkY1sKKkb5rG4R7UuEIkppG
 26Xc2Gmo/86e5tbnegSNe+Pv1f1K2Dh8w/soo8V6xDMuojdcbRsffEDuuF5KyRtx0hCCMAHc0L
 ipQk1rpiLsyVDorR4RjxI3AdMVfNasH/FgbJQmAMXxYy8p1Fxqyys+NXqhqOnBNepccTy/ArD9
 Mrw=
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="127291014"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2021 22:25:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 22:25:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 30 Jun 2021 22:25:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ix/gFnNuNef3NMoo5Hp7yYnh3ZeXvZ5xu0lZeR4Vdm3cJHUJ0b/2mGnLw06YTxJ7FsN4TMYjTVmzBCbVqQP+6duLd1cjr3Pj3p7meJKNSDg0jJkw/g2vPCR/VvxKxA5LsPCFVLlykLQWKdQhbynnFfKzJWOxIvS8AfeHQNA5cLkxLQbDHINLXwWB2NRv8itUHZWy7tug/kbgA2uxxz4q32HIYxNnETkMtDr5WpmtOSMLO84XAiDizvDGnFLNmOPS+csku+9QZXMszZLZd70uuFvNTY1vZM+P8TYtUbrJkEVJUFmoKLdK0xC6c9Sft+UZMF2/nI2BqJf8YbxczqHMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0em5fEjrQkoVIF5DhNlq+Gw7kzOqERAuseGi3qTIiZU=;
 b=TZlj/W8L05qH0TTZVzzKk7Ac/VWPJB6yHxbgvIT5E/pw/dRFX7uw4YIDopszgv3kfXn9cS//z04c3vr+KPAN1RO2rv/8xeUth0CkdUgC06Asqu87P6EkA0xUaJIeVriOEWax3SDKXy/1Gh95wM15FsgVDELdmx9iBIK4fXcjJRa3OCq5Dq5HfValnML40LSxk9gAmDC0lKB7k+3BiLKNyCmlH+aKYBeLRoAnct1AyWGBI9xWM1hhCSDJehRQOB+DpF316dxVTHnF6ZPxtOMawYJbsb8anlZpsoUHCnCpUqYw3zdEW/yeSmkYMXrsdZCd2qDoc3DF3ecsi+J8WsJqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0em5fEjrQkoVIF5DhNlq+Gw7kzOqERAuseGi3qTIiZU=;
 b=X3LDrm3HnFtclz/0zn1arMa4ufbbHzOY0VV3yL5jeqk8Qidlwun7r/U4C5EN87KetA3z7s7tsshNFDXGQrlbKbqSfib/s56KF159rUv+RWkUFLtbDk3OPENpeCNeBJdOhBAk++Eq3TnKBljF8lUiH6mZzwm0Mk1sCU7NeYZgE+A=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB4823.namprd11.prod.outlook.com (2603:10b6:510:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Thu, 1 Jul
 2021 05:25:52 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%9]) with mapi id 15.20.4264.028; Thu, 1 Jul 2021
 05:25:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <code@reto-schneider.ch>, <linux-mtd@lists.infradead.org>,
        <sr@denx.de>, <reto.schneider@husqvarnagroup.com>,
        <miquel.raynal@bootlin.com>, <p.yadav@ti.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
Thread-Topic: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
Thread-Index: AQHXa9nZhBHIVrQioUm7jO1Sivr3QKstm2iA
Date:   Thu, 1 Jul 2021 05:25:51 +0000
Message-ID: <45e174c5-fd9f-912d-4315-d6efdb8d7cac@microchip.com>
References: <20210613121248.1529292-1-code@reto-schneider.ch>
 <1ba367f93650cb65122acd32fb4a4159@walle.cc>
 <0328347c-572d-b636-5542-99cb36e9efa9@microchip.com>
 <064317e561f1ad20282efe778f633723@walle.cc>
 <a5877032-ab30-a85d-cd42-93b75a84ab49@microchip.com>
In-Reply-To: <a5877032-ab30-a85d-cd42-93b75a84ab49@microchip.com>
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
x-ms-office365-filtering-correlation-id: 50c86359-7c7a-44a7-e37c-08d93c50b159
x-ms-traffictypediagnostic: PH0PR11MB4823:
x-microsoft-antispam-prvs: <PH0PR11MB4823C0737ADBE1566ECB7EE3F0009@PH0PR11MB4823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqa78fLtNCcX4M5O0hsd2FoWDR2TIx1AbcyCwt8vvYsqkptq6HESNNj5INYmB5RGMvpIxFbW3cW1E7JGpL6+5flUcgyPohKyBt+qqDm6pY9TePGdjtppbMG5I0rGyd33wtKm+dq+/8+QJNbtXzKvbCTp/GV8lWM3snZvZJrGeyoCcTG76t5nbeJE/TEuOtQ1Q0i5OdcY38yLKlvqi3MEpjcNA6e5T3VOc+Bskhu8/3uCgrpWSMPe80vgnQpDJY+QE5zyvAhD1d/nO6FovzkXUzYu3ZhHaNYkETDpBNJZCiyLtdOquU40ZWoJrbGcyT+p4T4EQQscygw0dW9Hu5B12EFKbAC/dwTMFzhqxBfkBZqSDnAQkLLZSQGAhVMJWHN2EKSKveZe/RcmJ0zSSOV0VoC4J6jte6pO13INcIH6RkRGDH/SlZdo5yl8t9hVUG7at0gse25wFurGRmagkaYR4ToDepdY2tDwRteiDUCfFHIUE8ydeDrDC4RxGCqH2ApwyOhLv86SLcF1O5nmgrT6Oegx3NVrTmXdT48rh0LUfucxdhaK9CQmyP0BAiAlmesizyxD4jybdk8U7KN9txKYoAugT79QQ4pbbc6aOm/Tdqcu6j8RitFp7nuotF3GkBmoW4diAsb+VUDNduXx0UCBcX+V0qQNIwbI3LvU6z0q7X9RvpqUZ6lb8kGk5wAKOESo+wkb4FNLcnVSQ82QLmbMar/TWrMYou79C+0BgsTN/a9CnsqvvxZY++jL4IV4YUvk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(346002)(136003)(31686004)(6916009)(6512007)(66946007)(8676002)(64756008)(83380400001)(66476007)(91956017)(8936002)(66446008)(66556008)(76116006)(31696002)(316002)(186003)(2906002)(2616005)(7416002)(54906003)(5660300002)(4326008)(26005)(53546011)(86362001)(4744005)(38100700002)(36756003)(478600001)(71200400001)(6486002)(122000001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3Q1NUhlTjRyWkdKQTJFUTRzVnp0MSthSmxMQ05URytISkx4aUdndE5VZHIz?=
 =?utf-8?B?Unc0NUQ4b2c4OVNodnE5UmRmSjRvZ01TeGh3TkVieHdsNWdDeEZ2aFFyMHZY?=
 =?utf-8?B?amdPQ0dNbzdvRnFwQXBHU2NCZXZHLzJuKzN1TVNaYnVSQmlYL1h1SG9HS3Bm?=
 =?utf-8?B?NmRlbHRzR0tBZmlqSjNnYUExWThsN1l0Z0k2OVN2TFJjMTVhaGtzelJxdnUv?=
 =?utf-8?B?MTFkQW9HVnpEczJCazhDaVpGcVN2SjhnZGFYekZzbEN6UnBhVEs0Rmd1REZR?=
 =?utf-8?B?UFFPVERLbHhlSE1WcytPazhNWm5zVWYyb2k3b0J6cmtlYlpEMjVLOUorREIr?=
 =?utf-8?B?WGdua3BUeWd3V29BcTZXdEJvQlNXc0FCSGRjeHBNSE81aWdmQStjbVR5SnBx?=
 =?utf-8?B?eVYxa0l6dVhRSDE0a3NnaWZPK1kyZi9oNks5VjZiYmZNamhSYkJ1M1BzamQ1?=
 =?utf-8?B?ZmhaaDhzS0hqbll5QlY1YkR6V0RuV3ZzZTRvTDRGbnRxZnhkcTM1NFBGQWhV?=
 =?utf-8?B?WXkwVG1TWmd2WFA3SU1yZXNXdHdnc1RwTjR1MVFTTi82d3ZrTityRW5NNGJy?=
 =?utf-8?B?dGQ3bUhmTllpZmNRRHl0YU93d04rRkhuL1BGRHVqY3V1eENzbVlZbDFPSnlJ?=
 =?utf-8?B?dmM4akJheXk3Z2JVL3JhaVRZZ0ZaM1RXZ3J5ZVdWc0UweUpCaitKM1paL3RE?=
 =?utf-8?B?KytsY2RoUU1vK0VaVDNSNFIrWVoyQ1FiSU53aFYzMmFzVkpkdHRlSjhCemor?=
 =?utf-8?B?eG0zQXlIRXZKTG5hYndOTFdZYnhvQlJmMVpOc1VDS0Z1ZFE1TEpVSG1KU0Zn?=
 =?utf-8?B?T3FnYXI5QUF1UHg1enBVQkpwdDI3MUE2QndRQnRna0R6SXZUMERhU2ZjUzUv?=
 =?utf-8?B?M1o2eHBTRTdZVFVVdi9GTUMzQUcxWTZINHA1ZjlqR1IzSjJyUUxzY2c1NHdG?=
 =?utf-8?B?RUdKZE1vcDFFbEQrRjM5UVJUY2xwNmZ4WTVaQ1orOHhGMXdYa0dCd2NDMXBV?=
 =?utf-8?B?amtnSTRMNlBKbDgwcnd1aVRrQ2tqTU5MRXhyQzdFcXpqZk1ZRGtBcjFWNnlQ?=
 =?utf-8?B?VnZqdXhnbTJCcngwMDZ4MDlobW9yQ2dhcGFIT0FjQ1RtSzBnQ0tFd1d0RVRj?=
 =?utf-8?B?ZWxxaGNYR2Rad3pnMUswWTZ5VnFqNjBleWhMbjJlMVA2OVoxQnp0SlhKNHZo?=
 =?utf-8?B?K1hLd1N3UFd0eWh6UWl6OGhIcDVreGJtbnZvckxHWFhxVUZSa0VnbGxGaEV5?=
 =?utf-8?B?aUxzMnpsZlRDOWV3Z3VMc3F2T3pzeTFFKy9za0o4QkJoYmtNR1d6KzRSQ1Iy?=
 =?utf-8?B?TlAwVCtTYXI0QjRlOHlTZE1LRGp0NXFwMkxpUjFRUjhyU2hCNDdVeW9wMXRo?=
 =?utf-8?B?cnhlTTNQRnhudmp2bVdPekllZnN1MnZ4RGRSdVpscms2MnZscVZzc0RGdEJn?=
 =?utf-8?B?VUJMcmpqUVVUQm0rNnBONFp2Si9PcDl0R2ZVa1lyL1ZlblBoSkFnT2d5UWk4?=
 =?utf-8?B?UnZjTWVOMWxram1JdUN3OWVFeWlzOEk4WWpVek1ONVYvU3J2ZitnaWJpR3FI?=
 =?utf-8?B?VUhIUlp1K2plTmdjQklRYnNYd0hxZmFLMnQzQUVaOHRiMmVOMy8xaWVWd3Zv?=
 =?utf-8?B?aXFEQ3o3eFRhSjRSRStNU0lhcEplT29qb2tPSzRkRUhZcDV4dlZJNVFLRWFO?=
 =?utf-8?B?UHQrT0dSWEFETFVndWZKS2F6ME11a2MyVjlqeDBDcmlRNHRXRDB1Y01OZUha?=
 =?utf-8?Q?va6luC+LkoHv3XQCGA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF607FB09FB41844AD5AA952F07B063C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c86359-7c7a-44a7-e37c-08d93c50b159
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 05:25:51.9198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1olSCQWqQxl9a/sGLplKm3oF1nYIlU2oUWCZCHaMb2LtCVeWggK8fji1a3MxTnO6Rg5fIx+9Hdy8EkOhDfS0ePqC/LGrOg44Rf/D3Kg2oy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4823
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8zMC8yMSA5OjI4IFBNLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gNi8zMC8yMSA1OjE1
IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4+DQo+Pj4gQ2FuIHRoZSBTRkRQIGR1bXAgZml0
IGluIHRoZSBjb21taXQgbWVzc2FnZSB3aGVuIGludHJvZHVjaW5nIGEgbmV3DQo+Pj4gZmxhc2gg
SUQ/DQo+Pg0KPj4gQXMgQVNDSUkgaGV4IGR1bXA/IEknZCBndWVzcyB3ZSBuZWVkIHNvbWUgaW5z
dHJ1Y3Rpb25zIGhvdyB0byBkbw0KPj4gdGhhdC4gNGsgd291bGQgYmUgMjU2IGxpbmVzIHdpdGgg
MTYgYnl0ZSBwZXIgbGluZS4NCj4+DQo+PiBCdXQgeWVzLCBJIGhhZCB0aGUgc2FtZSB0aG91Z2h0
Lg0KPiANCj4gSG93IGFib3V0IGFza2luZyBmb3IgdGhlIFNGRFAgZGF0YSBpbiB0aGUgY292ZXIg
bGF0ZXIgZWFjaCB0aW1lIGENCg0Kcy9sYXRlci9sZXR0ZXINCg0KPiBuZXcgZmxhc2ggYWRkaXRp
b24gaXMgcHJvcG9zZWQ/DQpWZW5kb3JzIHNob3VsZG4ndCBjb21wbGFpbiBpZiB3ZSBwdWJsaXNo
IHRoZSBTRkRQIGRhdGEsIHNpbmNlIGl0IGNhbiBiZSBmcmVlbHkgcmVhZA0KZnJvbSB0aGVpciBm
bGFzaCBwcm9kdWN0cy4gSSdsbCB1cGRhdGUgdGhlIGRvY3VtZW50YXRpb24gYW5kIGFkZCB0aGlz
IHJlcXVpcmVtZW50IGZvcg0KbmV3IGZsYXNoIGFkZGl0aW9ucy4NCg==
