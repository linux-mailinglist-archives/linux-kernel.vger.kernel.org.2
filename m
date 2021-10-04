Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B214C420A09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhJDL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:27:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:41150 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhJDL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633346736; x=1664882736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/WxbJ0TW3jwL6GDerdPE+/BpVljQmH2HLNccqob5vbU=;
  b=ntnK4fj4lENSmo4O0DNbO8aU/NUgiqGyT4dhR0aRm+toCQ25mdeC7Dn4
   xb6c18msyxNq6Svxdjx1Sx93Nca1ZwQuBQ5U3BKMZCXYuBZMi9YbvGA4U
   WAB6JdYq7mg8gzGE0iGHFGHeIC5+PZPczNGvYwUP8QvP1wOHjcLDcSzR9
   rRb1gGI6q/BESa+3FC4LfkPb9UCXV9ZLBrP1/VEjsURJpaIRdAhqNb/XY
   lCC6fSfMslqrRFtWpvUirp0X0BYzN7mods9Nb9cSgRpbZCZoPApc29PvX
   AmeGTr8K9P+uO4CPF3OTHsAqLun8UQ7npGyVfxznkSLnEFCF/SRsuybbE
   w==;
IronPort-SDR: DsPrC8LjHRpo38WFbNYqrO1+xnceJJzQcTvsLOs+y/NYO4A0JLibIvtQ6AbyQ8s5Z2y631R6Wa
 a7HE038m+kEOH2lEU1APZONzuC31OPH4DiuA+Btt3v/FF78vABC2DEh829CwoYt1mLH0D/xHNa
 ZfoX7OuX1VdmSF+iUBUfcZNNR3pAqyYLLG3+pv46YckRyb77rpyFfea8glJj1kdrFo/FT6NrK+
 CPYkUyk+WAdxoZSFTgV1rr1Iq1JqREPaetrTDxm7NJjmnhjDm6/2fG6pRPuuJ8IKfDML9MMoUi
 Xnh4l+sGKv+6/bw/U1JQ0oQA
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="134166187"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 04:25:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 04:25:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 4 Oct 2021 04:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d36UiUIvdGMy4Uz85ip9r5e5XgNgCr04bPGYD5BgHBL2vRSgnw3rtzIsgH2VxLRX4dZqJoqoRqiN5SiybaYnRicyXY0zCm4jWfIuyS+xrv9LaLFJq1usQc0WC/pWHBgWpzqxB4Yw+oM6JqluwYzwzBJELMEN6OYzQi9xEbabUuKcYWTa22aLh8vVGZQQa/Zz8Hj/8nJIWLMz/Nd9p3IksS1vVhKBsYtvoV1NWW9rRM3Bw1SDrJyPOVOmlIR2Sy1EaH2FsOpj9NklF+YU8jS1px84MJXW4RX+LNBl83IL9ak15daHbTaQB0AhnpCzuxEpHivjTEmZFZaR63mk+zw02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WxbJ0TW3jwL6GDerdPE+/BpVljQmH2HLNccqob5vbU=;
 b=ZrMqf5j6a/oJR8iUX7/t+0U56i8dECs9gwYY7fzMMxzKNHib7DHhVR3gcM87ugPIkIXprmS3tVSJ9CRDSc4Nh8dFC3MBCIQb4woMiEu3Yx/c59cvidd2iTFN+a6ft+xQf0JcrPzKigkqJtJJN2srEhnb/LvNCvuPEv8P1fXncWZxYCNwpT19GReEFzQPGn2Uh0YEF9x90yv8R58uaL1nrmbXetfsValpFQHA0rpWT4nheDdbrAgKTlI/Dptpn+U9QkjKvQbfxJB4s9JN8sRg3fUGGGrdeiNlHY0wZXhG4ORjaBFgPRPVy0cVXezIxJ++s+J+y7wtIBWS5hesNcwYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WxbJ0TW3jwL6GDerdPE+/BpVljQmH2HLNccqob5vbU=;
 b=fEiCf94c+LRHECVXVst4TebZuEByaUYL/NNAvlCjgZgNl9LRQhzHs1AAytPGiCpgCCZ3nDWKZJVSz9GnQ1fe7LN5LMYFpKEQd4DNnF9GgeFT0Kh0YEqqUmy6Z9IEQso+iA2eUBhQ+/e4gcCDKMoZ+k1JQklB2p8TfIWr1j+8W4c=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3342.namprd11.prod.outlook.com (2603:10b6:805:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Mon, 4 Oct
 2021 11:25:30 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213%9]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 11:25:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Alexander.Stein@tq-systems.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <p.yadav@ti.com>, <michael@walle.cc>
CC:     <alexander.stein@ew.tq-group.com>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: spi-nor: Add output-driver-strength
 property
Thread-Topic: [PATCH 1/2] dt-bindings: mtd: spi-nor: Add
 output-driver-strength property
Thread-Index: AQHXuRKJEfK6sY4eYEy/lIjeBL2qZg==
Date:   Mon, 4 Oct 2021 11:25:29 +0000
Message-ID: <0cf4389f-cb91-44aa-a4be-48878d1221de@microchip.com>
References: <20211004111529.211089-1-Alexander.Stein@tq-systems.com>
In-Reply-To: <20211004111529.211089-1-Alexander.Stein@tq-systems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: tq-systems.com; dkim=none (message not signed)
 header.d=none;tq-systems.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48838256-f9ac-49b0-c251-08d98729ac08
x-ms-traffictypediagnostic: SN6PR11MB3342:
x-microsoft-antispam-prvs: <SN6PR11MB33428CD1E0386BFFEF4A0016F0AE9@SN6PR11MB3342.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qcDilpYpejBdxC0f46is3okD1g+hwLCK+25fSV5wrKTYZE4rQUi47bk8J9dIV0tFD1lPEMYemWu9hT13a8kPbDhZ334BF2drU7HlySNlKfQtYu5h8TR1CsUVBdoseJoYmZmk+XUoozCif5j6h7sONGvrvWaMlsKL1AHfaXOFVcDHhRYEwwwWQwry316qPY/8ti6zrohZu4BzWv9cpZITSYlvpJbbKjhInKcb0mnKv9SZti8ClYnOCkhmOZEImusADWi39FLXXIX9WBpS7ZvMr0Lw6kWurN3mBNanGh5HYDO9lqTaGjve3rD+VpdC5Nt5mGVPQP5Hrk6yuxM5Oe/MSVdqzOf8/MigBuv00jvBSrq2/puWC/YR5IiKA08g4dJy/+wTLzob1eotLB1NV/v5G7ziBoL+3UKcHqtb/lQPf5wYEmonj4cD+2Ay3FCQXDSaxFnpanNqgpjeGzb5GT+tLUz8NthFvrJ9tkUchZ6hIrR2kYAmrdxsGXzWLCGdPAG9aeYOwVqQe+sg+PuIkA8O7L0AVVhob/VeNpCuzgU3BN0WqPk2+i06t8H/j7D9/iIOaJXarbOkOqC+l/3B+CQpta6wEunUECT6VTnd/vNYPxBL6cbYlm326nx69QoIZ9VaxorU0ZZ1TdkkW2xE+TQH5Ce07WOgXKC6Nz4q6pO6Ebr6ZpzS4Nx2p0zq18ltNPCFEC5p+zWuwektEILIvZpw5peiKIbHt/LmInKL4u8pfF+VszpRIw11usoC9PiYoGSK/8K1OSLIaTkuDuH5fK+ia03CoEqGCF4SEP7HfZukmxCRTxgJz+mciJrbnRrxtyQl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(316002)(38070700005)(31686004)(36756003)(86362001)(2906002)(110136005)(31696002)(66946007)(7416002)(53546011)(6506007)(8936002)(38100700002)(54906003)(186003)(122000001)(508600001)(66446008)(64756008)(66556008)(66476007)(76116006)(91956017)(966005)(6486002)(4326008)(5660300002)(8676002)(6512007)(71200400001)(2616005)(45980500001)(43740500002)(10090945008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjhldlhqckpQS1lpNlIwRHdyZU1tM09lZVg1QjBmRGRnYlRnbTdNOXUrY0tS?=
 =?utf-8?B?aTNXaFlFS3hzUUQzMmw4elg3d21vN21RWWFZRUh1NlZGb2M4WHBuM2Y1YTRN?=
 =?utf-8?B?ZjRhZkF2TEpoZlgxNm9iTVJHVFVSY2cvRit6ZEZUdU5xNE1TaVJ6VVFNcTNJ?=
 =?utf-8?B?elNWTmZ3bUxScW9ka0orNjg3K1VaVzZZYUhXUE1uZW81aEpDcFJ3R0gycjhU?=
 =?utf-8?B?QStzK2s1cStIVy9qNkVubmU1dVRVRTl5dFBmSWcwcFFKTFVNUDIvTFJOVndm?=
 =?utf-8?B?OU5ORm9HY3BuT1ZCVWc2QjBsTWxNTGdXeHRRV3JxQUtWWUZhQUZDdlRYUENN?=
 =?utf-8?B?WUtTK3NiMWtvYkpZTFdlN0pFSmNiQnhoTjR2aHM5L295b2pxd0VCWFlPK0g2?=
 =?utf-8?B?K3QzSXlMcEZkMHRNaGxBMjJpVUg3SHM4amRnK3cxYjdKYzRMUzAvWFg4RzJm?=
 =?utf-8?B?U0VFaXJmRmFlZlY5NXp1WG9GcGV1dk5FZUNwMU9vMVJlM0ExMU5VSFhtN2VQ?=
 =?utf-8?B?NFNpSjk3K3hLQXhTSzg5OWc1ajFSTHQxemlFUHRlS1h6UkZxeUFmRGlNMkhP?=
 =?utf-8?B?ajRQb3E4S1htWHh3ejhzYU1hUWlweWlmd0VtRzdoNDVCZ0p3YlBzOW1VZG5G?=
 =?utf-8?B?MGZGbFNOSFlKTTJwMWZ3WlhLcEZmK2FQSXpvN20wOG5XREEzK3dGWVdOdU8v?=
 =?utf-8?B?Z2Z5eVlzRFUrRDJoTWhEQUJSOXZuRGpiZnVoWlZ2cmtQR0VZakJlRDFYNVE1?=
 =?utf-8?B?eGN1M012dWUyUEdwZ05ZbmpRUmdaaE1rK0pmQXovRDU2SUMxRytZVm5vb2tN?=
 =?utf-8?B?WGJpeURBeVp5aUYxd3BRVWRFS0dxcSt3WDI5eVNRaWJWVk1mbWtBeDVkR1Q3?=
 =?utf-8?B?ZEpzbmZzQnBlWnJoamxwM2hNc1FDS1hSMm9BSWswREpEdU80T2FKZ3JScTll?=
 =?utf-8?B?NlYya2luWGJLVDZnYlA5REJBaFlOUUhycFh0WUxhWHl2bHVacFhVbTVWMkoz?=
 =?utf-8?B?WG0zYUZNRENvYmRYaVhvTGhwODFwSi91K2QraDlwL3lxYUFyVG5YOXF3QnA4?=
 =?utf-8?B?MzVpQmRUVWYrLzgwdklNNzhMZ1JGZStGOXlRVkxYb0dqNkpENTA5TXlMSmho?=
 =?utf-8?B?R0dTM244WUZCeU9BVEdnSGZqVmNJV1lwdUFOUUNXZlBRcHBkUGxuYXBhc254?=
 =?utf-8?B?ZXFrdHlpSW03RnhtYjdqVGlVYmVac0VUT2lBVldpL0NLaXVZVG9JZWxQMUps?=
 =?utf-8?B?R2dMc1hXcm50NHlsY1hQR3d1R0VYdHZ2Q3FnTWpxTWMycFB2aFBSRG00VlRS?=
 =?utf-8?B?MmJtMk04cGRlbWVJeWtNNnhYTWZSWUxMNXcxNlNsVEhSdDhjR2Q5bENVbUVP?=
 =?utf-8?B?VU93VkllZVpmZ1Uzd2xVZjhUUDJRSTRxMGx2ejV4aFRqaFFUVjIvM3l5b0Fm?=
 =?utf-8?B?VTc5WGZHQm5rdWFNSlpXdkw2V2hXSzFtQlE3cXcvemZZb3owcm5oSVpqbGlj?=
 =?utf-8?B?bktrdm5RUmgxTFNtNGJSMVdRbFBBQzEyMSt0Rkw1UEh6dkYxcVVPMXF3aWF6?=
 =?utf-8?B?cmVIQ0VrY0lyQUlHNlpTOFhKeG1mYjZBaXNoVGR6bGkweDRPUzNTTTE3Mlpx?=
 =?utf-8?B?Wk1JTXEzZW44elNoTzR2M0IwMDVXL3BDT3RTZU04S016VUhXR2pGNlk5bXha?=
 =?utf-8?B?ck12a0JrUEtWTW9ldDNiQzBhSTduUGllRG9QUEg5V2w5cHBoU2dkQi9qZXht?=
 =?utf-8?Q?l0nWSguefgg3YH1V4A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7860A79DA284F44B69CDADB4922F0C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48838256-f9ac-49b0-c251-08d98729ac08
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 11:25:29.8045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLNDuQuDfKNMPclvmR+nDE9eI/bJMsoLoeOTljxq9OE4z2MX4r1JctSjiqYjAlJmkEEgSEX0YaoLaP7VCuerIJUgfYhSkp8lY0wUFCN14eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNC8yMSAyOjE1IFBNLCBBbGV4YW5kZXIgU3RlaW4gd3JvdGU6DQo+IFtZb3UgZG9uJ3Qg
b2Z0ZW4gZ2V0IGVtYWlsIGZyb20gYWxleGFuZGVyLnN0ZWluQHRxLXN5c3RlbXMuY29tLiBMZWFy
biB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cDovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVy
SWRlbnRpZmljYXRpb24uXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+IA0KPiBGcm9tOiBBbGV4YW5kZXIgU3RlaW4gPGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91
cC5jb20+DQo+IA0KPiBUaGlzIHByb3BlcnR5IGlzIGZvciBvcHRpbWl6aW5nIG91dHB1dCB2b2x0
YWdlIGltcGVkYW5jZSBhbmQgaXMNCj4gc3BlY2lmaWMgdG8gZWFjaCBib2FyZC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdGVpbiA8YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3Vw
LmNvbT4NCj4gLS0tDQo+IEkgY2hlY2tlZCBNaWNyb24gYW5kIE1hY3Jvbml4IGRhdGFzaGVldHMu
IEJvdGggaGF2ZSBzaW1pbGFyIGJ1dCBub3QNCj4gaWRlbnRpY2FsIHN1cHBvcnRlZCB2YWx1ZXMu
IEFsc28gdGhlIHJlZ2lzdGVyIGxvY2F0aW9ucyBhcmUgZGlmZmVyZW50Lg0KPiBGb3IgdGhvc2Ug
cmVhc29ucyBJIGRlY2lkZWQgdG8gc3BlY2lmeSB0aGUgT2htcyB2YWx1ZSBkaXJlY3RseSBhbmQg
bGV0DQo+IHRoZSBkZXZpY2Ugc3BlY2ZpYyBkcml2ZXIgZmlndXJlIG91dCBpZiBpdCBpcyBzdXBw
b3J0ZWQgd2hlcmUgdG8gd3JpdGUNCj4gaXQgdG8uDQo+IEJUVzogQXJlIHRoZSBPaG0gdmFsdWVz
IGFuZCB0aGUgY29ycmVzcG9uZGluZyByZWdpc3RlciBiaXRzIHN0YW5kYXJkaXplZA0KPiBzb21l
d2hlcmU/DQoNClBsZWFzZSBjaGVjayBKRURFQyBTdGFuZGFyZCBOby4gMjE2RC4wMSwgSSBzZWUg
YSBTQ0NSIE1hcCB3aGljaCBkZWZpbmVzIE91dHB1dA0KRHJpdmVyIFN0cmVuZ3RoIHZhbHVlcy4N
Cg0KPiANCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvamVkZWMsc3Bp
LW5vci55YW1sIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRk
L2plZGVjLHNwaS1ub3IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
dGQvamVkZWMsc3BpLW5vci55YW1sDQo+IGluZGV4IGVkNTkwZDdjNmUzNy4uN2Q3ZjIwYTc0MWI1
IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2pl
ZGVjLHNwaS1ub3IueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPiBAQCAtNzIsNiArNzIsMTIgQEAgcHJvcGVydGll
czoNCj4gICAgICAgIGJlIHVzZWQgb24gc3VjaCBzeXN0ZW1zLCB0byBkZW5vdGUgdGhlIGFic2Vu
Y2Ugb2YgYSByZWxpYWJsZSByZXNldA0KPiAgICAgICAgbWVjaGFuaXNtLg0KPiANCj4gKyAgb3V0
cHV0LWRyaXZlci1zdHJlbmd0aDoNCj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy91aW50MzINCj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgIE91dHB1dCBk
cml2ZXIgc3RyZW5ndGggaW4gT2htcyB3aGljaCBvcHRpbWl6ZXMgdGhlIGltcGVkYW5jZSBhdCBW
Y2MvMg0KPiArICAgICAgb3V0cHV0IHZvbHRhZ2UuDQo+ICsNCj4gICAgbGFiZWw6IHRydWUNCj4g
DQo+ICAgIHBhcnRpdGlvbnM6DQo+IC0tDQo+IDIuMjUuMQ0KPiANCg0K
