Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0642D3B58A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 07:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhF1FfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:35:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:17858 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhF1FfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624858378; x=1656394378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=er3tUoRAvpifyFydVfMEPkJk0AANhBYjyArdE3f+TSI=;
  b=Hw+5tkfL1gpkli4Sr13f6jCSACmb+Xn6fHzpuE9cwXMSCWBeb5toDPgM
   OpVwMyTgzhVbqz6TrPvGJIMya5C/0CyZ1uykUxhBsSaS7+69nN6jUQwlz
   V+ojKW4qoB7z2F2LWbjlVm3FwJq60z3Y51nFDJaz0qkifO92mg+T7LRUP
   H4ug+Vfzx+Lj/5yT3dz0RJMGtmKfdqeEztFCJEKf1hfB9FC15MnVWDHsI
   E8NYl7pTBdki7vXeDqWvnqpybnTnkd6mY4zkM2gzeBhoTEqXmuM9Ld+VL
   lYSTKE3t55YlVGJdr2jnFU+s3i3mOKxdOM+Ya8QToN0MblVwgwIl7lo+H
   Q==;
IronPort-SDR: gcJxmluK6D1J0LuJgmEV1p7VFFXVF+OSr5mypzh3fh474c8P3Xcf8CYVbCz37BBjDnjm92fshk
 7KtklFgaBNv9FftCR8sK9HgZ1pWXrNsYO1BkWMGMEtLtgwFh7rnBCTsrs6wtjrHTkDGrdLhtvN
 NXNIMOnzvh+z9AlG1QUbLzyMn3NsuE9rt/XgR4D/0Qod7J+iqnSSQqj9sZHDv1FXcst9GIEOFl
 kacV9D0HqUGDXQcr2Ku+bxeeFATCXz/HlUZq98TLQLQdiNuDA1gCyEUTDm7u1iM4+YoOarna/e
 n28=
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="126279648"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2021 22:32:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 27 Jun 2021 22:32:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Sun, 27 Jun 2021 22:32:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWO5b2XPzXYZiWWtjaIx0jDOjstOIcbPpR+BgBR18efvuWLrvu+HhP4QecY5GOFY6W76U9ZYvxAdaagLpFzP2ry0OM6M1/ROFKkDSHRyf84tM7celMs5SthuBA6e9arZxXeDW4YArq6K7zqq2wLUXQ9Ucfi1htzt9Ctqyq6sePndytH0L8eyY7eUXtd9fMQOBgjwz+amY4BYMzteGBV7Nb8ENRqReKakHji5Bibit/kv/9vdiCyJYwfntE9eFWJHb3eWKCN4qxAgbae6A1MbOuLbDSZHN1o1Z5lxKw+ohnA7x7nkEDlSklWVGYKuSH0tBgvvH47YZnLaTmnKpic5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er3tUoRAvpifyFydVfMEPkJk0AANhBYjyArdE3f+TSI=;
 b=kyzoMJ0le7iOlz14CPwE0h8rkQ5G/VIsht3W2kZmk7K8uRFsWimE1MUKcz3khsCPPHRdY304RdzKvQXl3Td+yVVVRjtf4H3YOOk1GWoCXXbhBhSmCPayusEdvXfOD7Se8QPhpBdRJ26hIntAf8MNuUwJ5tlpZ/HasJovIubhmWdqemZV5ZEJkczDKztqx+gG0YGFZV35UqpLZ846P5C7stUHYHX+/pWkKSre9byOCoPxJBehzgmu7k7NvRC1LibCWTLn8fSQ5wNPUPNIqtOFnEZBJVEQetuigKKSsan8e7ZDHz3L7PBVpoGuiDfBwAobvF7RmrUYt0xLUQ5IVXU8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er3tUoRAvpifyFydVfMEPkJk0AANhBYjyArdE3f+TSI=;
 b=CRW/Z1AC4sBcQYqN7B9vUHlee7SavYz1yK1u3yc08394GCMyYtCMbdcX8bXDnymmQE/Oj2/ur/20b+WzMmuTmLxrdWwLG0ucem3dljPodm8goiMFqZb/lF8l8nSTcZJFExh+tk/29xf7GgmRRQXYwYw8vnY66vsGiavBwco2fcM=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 05:32:52 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 05:32:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <code@reto-schneider.ch>
CC:     <linux-mtd@lists.infradead.org>, <sr@denx.de>,
        <reto.schneider@husqvarnagroup.com>, <miquel.raynal@bootlin.com>,
        <p.yadav@ti.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
Thread-Topic: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
Thread-Index: AQHXa98JhBHIVrQioUm7jO1Sivr3QA==
Date:   Mon, 28 Jun 2021 05:32:51 +0000
Message-ID: <e3f4aa39-b70c-4684-a1d4-2f1930d54bb0@microchip.com>
References: <20210613121248.1529292-1-code@reto-schneider.ch>
 <1ba367f93650cb65122acd32fb4a4159@walle.cc>
In-Reply-To: <1ba367f93650cb65122acd32fb4a4159@walle.cc>
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
x-ms-office365-filtering-correlation-id: 40d5b240-d76b-42d4-24ee-08d939f62c83
x-ms-traffictypediagnostic: PH0PR11MB5208:
x-microsoft-antispam-prvs: <PH0PR11MB52087A79D98ACE0B8D82E60EF0039@PH0PR11MB5208.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lknJYQ8Lz/G0gnVTi9QF1WDe+/oWmorP6E2nlcBE7zeIcaqtiRRGz7/ldkiHlVw0VqQYLsRDePXK9z/jT0DTATHCbIlBoimw8QvIXxJbeRuULbmVCz9IViiKKg2HS6Yu/88qVJlNeS4uq2NGd72tms8uhTPwPhMqZLQfHdVp9qSypVGf4o5pve6yjNztE1eMG99m1jn8nNDXIrMyTY4Df55M9IM4I7Whi9Pt9gLoqXOVhbqpIoKTYkjOn1bMzav+B2T4BluGxvI6DapeHElFWqNWbK7dWykpp7D5VDIX5o+n92VmXrR1/gJCOYJOp7TK4k1K2O04F4wLqjTjYEBoxZGMcecHgv9xFA9tebvUse818IfINp2AyPh1F1uMuenkgq0cWb/Dmvc1zRCKcYwkM0IFARVG7uC8B4xXfddIlJmQ3ubE0UrPBm/Qz4dVRXCl1RYKRU1fqMQ+JYrDsjTI1/VFtMgl8t7affKrB7drJW+BOKEQgdMkkm1+o8jAGc4m3Lanb/Kr2bGO4ITBOX6Fqs8LoNYlSAya6N4btMV9DMGc0GkhW0zCJjXTBgfzwJsJ84lTU4tfvcKFLUSmxNhR/WvmnmpKUKspozmY4JRELBREs0XrrvxizgnfgD/b/659td1LfHPI469LkpLp53UQnLPCVw8fy9DDUeVQAap1mKPkVT7bxOO3p5/Q9ppYKb/8P9egll2Qa+MHm0T7jWy7pNks01s+/bBjCsEWrjKzE9LCBp1P65YEUIonxYUEVSsx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(376002)(366004)(346002)(76116006)(91956017)(53546011)(6506007)(186003)(6486002)(38100700002)(6512007)(122000001)(54906003)(66946007)(36756003)(7416002)(8936002)(86362001)(316002)(4744005)(26005)(66556008)(64756008)(83380400001)(66446008)(2906002)(31686004)(110136005)(2616005)(8676002)(5660300002)(4326008)(478600001)(31696002)(66476007)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3Bna3BSWkZVdlI2cVBaem1iSi8ybWovVnNueU5zOEJxOGxuc0lyYi82dFc5?=
 =?utf-8?B?bVZaM1NvV29Gdm1GaUI1WEVGekEvOUNxSldjUE9Ja1FvTndsTTBvbUtrZTlE?=
 =?utf-8?B?L3pMME9PRU9qZ2Z3UWtsV0Z1UHJxOXRvei9pVy9odVh5MXpSQVdMbDVPQU1D?=
 =?utf-8?B?eWgrQktWZ2tCRU5PUTRpT2dSdXBhKy9oNUp5Z0Z4Y2ttREVpcWFmdU5UN1hW?=
 =?utf-8?B?R1plM2NDSlhYUFFxMXRJUnJldXBNOHhNckNZa0l3ZUUzZHNHQ2tDaXBTQSt6?=
 =?utf-8?B?U1NIbGx1blZnMkQxNVUrdm9QNmJKNU5Vd3VYOEZTN0lSQXI3ajZQQTRFYlNy?=
 =?utf-8?B?aXBBekdCOU1WYWFYaUVLdlQvblFVQVdOMlUvWTZVL1dHRDcwMVdHTWFMYVVw?=
 =?utf-8?B?cDY4cURkOHhCQitZQmp0OUZWNjF6cDZFMGdaalRiYXRoME85QTc1Nkx0aENu?=
 =?utf-8?B?UGVlSVpwWTFUR0JNZk8zNmh1Mm9vQ3ZGZXRCZnh2bmE2QlFOUzlTMzVWL1Bi?=
 =?utf-8?B?Rm1RV1BoYlg4bXdpa2NucmVYOUVzcW9XNjFxOVluN25xRTNudVVVVzRnN2ZK?=
 =?utf-8?B?L3M4OTA2akZTeFc5SEJmUk5BeUNvWExHRkZ3dEN3V0JtMXU0Ryt2YjhBWElL?=
 =?utf-8?B?WUwyWjFoNWQ4aFRtRHdwZzVUcVpGR2Qya3JvU1YwaGhwaGNkaFowNGV5MkxW?=
 =?utf-8?B?K0U0eWFpUFc2b2VqZ0EvTnhKWXE0MTlPbjgxeXRLMmFUQ3V6REQ4bW9KYUZ2?=
 =?utf-8?B?VWtsL2lhNVlCenpTeHY4QkJyemNFeENDQXRmLzdCNjl6MlAzRWhhdWxLVE5l?=
 =?utf-8?B?WTlGNkhTcVRsS2ZuTkE3OTZJcVJxbGRhVTRvWk5XUSs2U2hUY3o2QUNOdXdH?=
 =?utf-8?B?clVveVJQUTBqSFc1NXRVL1NrUTNYUXViVWVoUCsxY3paaVgza1FlVUdqajB5?=
 =?utf-8?B?b2Y0UTcvREhHMXdVWHlxYlBHdWQ0akgvTURSM3dIQVdVL3ZsTmN0ckVhUGlx?=
 =?utf-8?B?WU5EUUJNN3VXUThubDhUcjd6VGxCUHBQTUdSRU5XS1VtVGlsQ3psTXplOUw1?=
 =?utf-8?B?N1Bnc3YxU0UrQmw4NnQzSG1BZ2pGa0NuT0ZMSkZvRHJobGl3ZVl4a2wwcmJj?=
 =?utf-8?B?dmJPbkE4VmN2SzRpanlIOXE0R0VocmY4aWdwMG5oK1IxS2xVNkFMRE1Rd1Bx?=
 =?utf-8?B?bFRqaHBCMGZOR2w4R25COC9VZm04aVFUeEdEV0YxbEFtVXFoWXZ0MDllZnBC?=
 =?utf-8?B?R0NENi9PNThuT0NqZWpnZGUvWVZXcHpZaUt4YklOZGQ5amdDeU5LRXdQc3lJ?=
 =?utf-8?B?SnpuMUlBWEJzTU5xRHZLZ0tqeEkwdVhrVmdkSmovSFFaVWZWQU9ESW1pLytC?=
 =?utf-8?B?OVFZK25JVW1DN2JFZ3NtMjdDcjQ1elo1QmlIMzBoK1VTdGR1amhKZkNjUGJs?=
 =?utf-8?B?OXFCTVlHYTQ3R0lTdjNyY0Z0dGNMWS8vMUlIcUFPY2taa3hTNFRsZTViUkE3?=
 =?utf-8?B?YzExWTlBOVBEM1FrRVJVL2IzekFpNGgzeE95N1hKYmFHQk9rL29WbTRtVWNQ?=
 =?utf-8?B?ajE0VEoyak10dm15L0NzRU4zbW92K3N2d2hIb2ljaUFiKzBVRU8zWHhEM3BD?=
 =?utf-8?B?WGlCQ3Z6elRndUdSa3VsUnVpRG93ZERKUWtYdVN5dyt5Z29VQW5BVTZDWm8v?=
 =?utf-8?B?WWZKREU4STFWdVRMVFZ0TmI5bVVzMGx6Zk96aEQ3cC9ud0kxU2dRRjYyQ3NV?=
 =?utf-8?Q?M+2N5rLSH8DaWs3/aY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9482A8769B7CF14F8196EE82A0FC2DF6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d5b240-d76b-42d4-24ee-08d939f62c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 05:32:51.9941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mH1hVgXGwsPOXHqaPmo2GA5bHon0PKO7pcO5cKVEE0xwtHSIKZltCzqWALTh90KFdmutl4zBldxp3dVJt9w+ytijVnO112oXWzBpyERT+UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJldG8sDQoNCk9uIDYvMTQvMjEgOTo1NiBBTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4g
DQo+IE5CLiBYTUMgaWdub3JlcyB0aGUgY29udGludWF0aW9uIGNvZGVzIGFuZCB0aGlzIHBhcnRp
Y3VsYXIgZGV2aWNlIHdpbGwNCj4gY29sbGlkZSB3aXRoIE0yNVBFNjQvTTQ1UEU2NC4gQWx0aG91
Z2ggSSBjb3VsZG4ndCBmaW5kIGFueSBkYXRhc2hlZXQsDQo+IHNvIEkgZG9uJ3Qga25vdyBpZiB0
aGVzZSBkZXZpY2VzIGFjdHVhbGx5IGV4aXN0Lg0KDQpXb3VsZCB5b3UgcGxlYXNlIGR1bXAgbW9y
ZSBieXRlcyBvZiBJRCB3aGVuIHJlYWRpbmcgaXQ/IE1heWJlIHRoZXkgcHV0IHRoZQ0KbWFudWZh
Y3R1cmVyIGNvbnRpbnVhdGlvbiBjb2RlcywgYWZ0ZXIgdGhlIG1hbnVmYWN0dXJlciBJRCBhbmQg
dGhlIGZsYXNoIElELg0KT3IgbWF5YmUgdGhleSBkZWZpbmVkIGFuIGV4dGVuZGVkIElELCBsZXQn
cyBzZWUgd2hhdCdzIHRoZXJlLg0KDQpBbHNvLCBkb2VzIHRoaXMgZmxhc2ggaGFzIGEgdmVuZG9y
IHNwZWNpZmljIHRhYmxlPyBDaGVjayB0aGUgSkVERUMgU3RhbmRhcmQgTm8uIDIxNkQuMDEsDQpz
ZWN0aW9uICI2LjMuMyBEZWZpbml0aW9uIG9mIFBhcmFtZXRlciBJRCBGaWVsZCIuIFBhcmFtZXRl
ciBJRFMgd2l0aCAiQW4gTVNCIG9mIDAxaCB0aG91Z2gNCjdGaCBpbmRpY2F0ZXMgYSBWZW5kb3Ig
T3duZWQgdGFibGUgYW5kIHByb3ZpZGVzIHRoZSBiYW5rIG51bWJlciBvZiBhIEpFREVDIEpFUDEw
NiBhc3NpZ25lZA0KTWFudWZhY3R1cmVyIElELiIgV2UgbWF5IGdldCB0aGUgYmFuayBudW1iZXIg
ZnJvbSB0aGVyZS4NCg0KQ2hlZXJzLA0KdGENCg==
