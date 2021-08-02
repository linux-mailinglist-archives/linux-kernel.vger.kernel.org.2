Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B335D3DD21D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhHBIhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:37:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:15919 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhHBIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627893416; x=1659429416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pikqRNW/DvzD2q2JYw0NdSld21hACFuztN0Lhi5vgyk=;
  b=k9/IcUjJHRm3hRmJt4Q+Jccq+tkdaAXFjRZpVWUjuEaybWVCYuhHwLti
   1T+x4jBElWsnlXQdyNe2ZJRh9Ox8Np9VJcUUIKiUfx+LgKHUFHJ4Vw+YL
   0M/uPx+v3ApFJiLdvnOQ7u2Akm+fm2dFkPPdNih/YWpBO/0je50/S2Oxv
   HuFlcON5SMlLrHH7PKOFWHmNUGD5HuRnDqvUWrxigeERKXj/UenRMUpax
   dxAuj9VSN5Dur5W1NzcoOdihc431FXqUF706bPpjOi1f76EUyVrGUUJwR
   0XvWDtwSJMnPhkG/fevpmlnFtvz2OUYRi7ZWniG/to/z6ElukQACoRAME
   w==;
IronPort-SDR: PrsEutRqhB9lxqNAxW2CsLtyOM4SQRwOVtXO0BNVkNzh1eVjaCkbyiwahh11PTP6PQf1cKKLH7
 S8torj7yFTEtIJkktDs9JCIoeT059sTD0QK/ReSLmvErIzpR9OwdeG8lAm/VqdDLTOgCC5Snh6
 rutRHHUZd4ioV10rkOyXrrjXOc5SSo0GhNnVDN6NS+To47abHdYmXIpgfUvKRhPQYyjsnKod/N
 GsERRe6Oeyf0zu+Yq/qlcUwAbopPoeQ+0vZ0I2Ef+SojWHfqxCVFB/mKj06gE7l/iY3gAZUv9v
 r51ej/gbj+1tekCIeWh0v6Rt
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="64372137"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2021 01:36:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 01:36:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 2 Aug 2021 01:36:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYX3d/+cQaYU37z/R2bTCjvbUzzrfNQkboYioftH6EdkfLVFbOG1LkPdBt4mCd01EwY1gsjwk14W16UbEG/6rBI+snpgEteNknED4qgy4uX3QM6sMXSucaVGEFO8GOqyNtn5RtqbuVs4BXTaQo3Q/UxcjovTR62i/yMrVlKgAieSU+e/2eKln6Zs3+GEN4l1YthNBpmQdeDT9jBVkgfpTyio7In1Q6xX2dMMiSIV+3dMJ+ew+RA42ufDxXNIlULqIb4wSXAgpPN63cNnbgNSE6r2XDNJb/X7lqMhRcrQmu6WjZ9Pjft+GLbQ1+rjCQVLvCA3oPqfJL7aVIzf53fIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pikqRNW/DvzD2q2JYw0NdSld21hACFuztN0Lhi5vgyk=;
 b=FLS5+R85yQGlQ9oxuLVo5PsioSjPVfn7ebYS8WHtUCgQVQV3ZcOfMwZlwizHS8/z1wClwCNkB15ghXFGkLk5ht5AYamVdHjT0G2b5q2fh7LRUH/hfoBj+x+wPfyFUsIBg7z1knY34bDOqcO30Ut8ZtntR0FwBEhab7uTwZQUamLPXx8Uoa4uX1lVJQL+4il1yT9969X8CKUjCxPhox+slrlWHDkrHYT6xyAiXMsBN1ocbdXVCI3SgiXGsoiRh/dbKCRGIfxN6jNN2p/yORRciFcSsatLVxtNtacOXtIfR4M7VdJ0Ne87KDNVkml3CxheAJBLajCPOsHksN3gaJSnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pikqRNW/DvzD2q2JYw0NdSld21hACFuztN0Lhi5vgyk=;
 b=MwWwix2fw+nzcy5u4F1BkY86Xa8rNoibf8GmLz0rfP3xMLJEuRGsJCLjGZAolnWoYUaOpRUU50MUpe1PsdDAgc7aLOaKfo9fUE3nqqv0n7vncVYNMBnT270+M0B2hD/V+IYRt1PGGy1PYuQbYbJpPuQsaPhj+hsWBLKOGQkvWXg=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Mon, 2 Aug 2021 08:36:52 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::619c:afc6:5264:d3c]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::619c:afc6:5264:d3c%5]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 08:36:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] clk: at91: updates for power management and dvfs
Thread-Topic: [PATCH v2 0/6] clk: at91: updates for power management and dvfs
Thread-Index: AQHXh3mKhFUuH0RmS0yHhRgJvP8+0A==
Date:   Mon, 2 Aug 2021 08:36:52 +0000
Message-ID: <6ecc4822-8112-43d4-1259-cd7dfe79d71c@microchip.com>
References: <20210401122726.28528-1-claudiu.beznea@microchip.com>
In-Reply-To: <20210401122726.28528-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd3d077a-0321-428e-ea97-08d95590ad8d
x-ms-traffictypediagnostic: DM6PR11MB4530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4530F9089E25415448E89B0787EF9@DM6PR11MB4530.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwbJ9s58i+eMVTiPsBnHLgKYIsAifNF6DUqVpvkvLO+4KBgn1YjbrxGm3Jq68Wwl/Q52CYKfpN5blwosoT1M3Hj24jCtY2L2p8mBEwf5zstaytZn4VdCJ8zcMRaSbXdkaiHUrOKdaB4V6W6dHsuHjsdyQp3cDQgQMBd07d51QPkECdtXxqgDd31ZkButGwhyRTdwLia2nbR4EaIz9re4ACXb6DwnL4jpu5VjUanXj5qvLxI1fCU0m7jyIiAd/ISR0JcJbPeTdP1lHVI5MdmVpVepLWkScXOeplp+VUZYv9ANH4Em3doc12GW7F/BqwOF/CtMI/591RnkEukxxubymaWDseAs44dNdPAdG0cCtXeYUohvHunsFSIVClXQSWu3A3k0Vx6209CVheMJeK3YFyAPkE7T8bwAQActwarqFjURSXI/+Vvk777uGwCG4YFB3Vg2HgsjdrZUtk+um/7W3cI9Mo6WSHRuxYB3aPhMJ9+edvl7aB98jeDd6BC699nGdoqfyPifSweSEs+ysZhu1DDVpO6fYhVkaXqLa9illA/G3v7L4ZB2WvZrQ6qM+cck/rCDw6ewHpJXvvTjw0dIF3CwbkmmVJfo7CyxovV166ty8+FNmNGOo5jXAa2Pv4L6/901fOQzQmiEaTf55tbv+Y5ZXdzL1EjUXoXzm9dZUbFsnwLFUu+U+mHwDYFATfwwGIW9vK8y4I+gYmZt8g54wZlI81sWkj2mDKJLGzX0Us0liouNUow1TUF5wOedj4+0brBopnKB3WSyK0wJQNS9Q103Q24jwA2FyvxK39hih15EuczB/BuWZ9J0yK9ovF+bDs43qTNgG+McOeb2uVXXtXBLUaoTOyMiCWyfQ4TS66Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(396003)(346002)(366004)(966005)(64756008)(2616005)(15650500001)(66946007)(31696002)(6512007)(66476007)(316002)(8936002)(66556008)(38070700005)(2906002)(86362001)(6506007)(66446008)(91956017)(76116006)(110136005)(53546011)(5660300002)(38100700002)(122000001)(186003)(8676002)(54906003)(6636002)(36756003)(83380400001)(4326008)(31686004)(71200400001)(6486002)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cER0NExWU2djbG4vS0t2amNMM2JNYnhLdVcrQ3lCaHBWbGs1bDRVWHhlbkNr?=
 =?utf-8?B?d3R5N0x6S1hRZ3Q0WjRYeW1pdVNsdWY4RWJJV0x6d3FPcFQ5UzFRL3lSUnRV?=
 =?utf-8?B?cVpNbEZIdWsySnNKSWtuUWgwU2YzTjdrNEp3M3ZWUDBCcHdnd2tlYWpWbDIz?=
 =?utf-8?B?bnZBVTE0QlFmbW1hTTRsbE13aE9iQzhkSmZWaFc1Y2dIOHRiQVZ4enZoWlFD?=
 =?utf-8?B?TE1IdCtqVjBpV1dpMGlCNXVTYlZsTGtIMjZuckQzcmJGeGg2RFh6OGQvbVU0?=
 =?utf-8?B?eGNUalZBZFBuRVJLaDNYazkvZlRFMmxkYXZFcmtVU1ZYd0wxRmQyRldUeWsv?=
 =?utf-8?B?b1o5ZkRWK1V0UDZ4alpFYU03cWJyQzFFRkdmYWt6WW5wQUdqd0Jla2VPa2tw?=
 =?utf-8?B?ZmFZSm10WGp1R0JvQWpkY3lsaktncittQVFmREJHZTAzSXZqdHJJOFVHYWxM?=
 =?utf-8?B?KzdVTmdsSjhXTXhoSnlXb1pwUzRRc05FblJRL1dBTEg0V1V0eTlOY1BSRlBo?=
 =?utf-8?B?dEpBUkwrNktVYXk0WHpTM3dXYzJJOXJaV2NiSFp0UDBRMWQwQ2NGaHFSNlJV?=
 =?utf-8?B?R0FONlk2UWdNaFVWVzBzZS92SVlFRlp5MWdVQUg0WEp6QkJoVCtKOE1uYzdy?=
 =?utf-8?B?bmU5L05SenhuL1AwMlBOT3hpRTRvK0VoZTFLbUJQK29PS3dtclNFaGxnRTNj?=
 =?utf-8?B?ckhDcTdhTHZHOVR4MGdYa25rNlJWaERmUnFVdGxJNmNFamljb0E4V2dJWWVi?=
 =?utf-8?B?SWhOMDA5SWg2ck9sWkJNejc1b00vWEYxYi9PZjVRNjF2YjVXc2NxZE1TdEpU?=
 =?utf-8?B?SGZtNythc1djMTh1Wi9XemNTc2JvK1Y3Q2VMMGp0aVVMNmh0WW0wdloxWGF5?=
 =?utf-8?B?bU9xQlBsMVlhYWdrK1g5Y3l1OElpZ0JlenBTUmpwRFFLaHRFVmNsNmt6eFVJ?=
 =?utf-8?B?UDBpcVJSa21pM1RqRFdjaEltS244NzBpVmFSOFZjbm1rU1paZkU2R3JxbmZn?=
 =?utf-8?B?RzU0WHQvSG5DdzAyTWNkbHpWLzVhRmRsN0JRN1BxZS9TQnNOTERKNUJ5Rktr?=
 =?utf-8?B?MVlMekJlNWE3WVE4NlVrSTRtdHliSkFWZkM5NUtvR0lJVmxsOWZUK2doNis3?=
 =?utf-8?B?M3Bhd1BoNVp2ZjZJdndTZWUzeUNiRXFxNVhpeVdtbUxOWkpraHc4U2VmUERp?=
 =?utf-8?B?bGt1eVNLUVVGblc3amJiQUxEUlFCOUJpaVdjS3NYNDI4U0NKbDdYajJYbmZl?=
 =?utf-8?B?S2ttNGh3aEt4TFd5bnE2VHVmZE1TbFpRNHp1dTZaYStITXhHMFdtc1A5dGhi?=
 =?utf-8?B?NTZiczlHVWpCRks0MkNpbngrQXZyYi9mUkh1T2Rnc2JYVnRTU001cUordTlu?=
 =?utf-8?B?SXFMeEhjWTVqMXAwNW9tMjFsZ0lsYnkvVzY5N2NSRGR0dEowLzF1b3FiQjRB?=
 =?utf-8?B?MTNpRmFGR0IrVXNXSk5QRTVtZVNXTkNHWG1EQXpza25wS2RMZXdERThMTVV2?=
 =?utf-8?B?cENMOGRRNjUwbHVmWmZpTk53bzJRS1BMUkpsUUEvcFNsWlVLODd6SkY0a2lq?=
 =?utf-8?B?NnFEU2V5OUdaOE1lZ0dmVGFpcHYxd3dFWXpvaWluMUdrSFdtVlQrUytEcDVr?=
 =?utf-8?B?NXI4UC9wd3Y0UDYyQkI0bDN5RHpNdWpaOGlPQ3ZXZisxek5VeVFTTGxqeDRS?=
 =?utf-8?B?N3hVWmNRMjBKdU5HWDRTNWhoM3hISkM2MWZUTmdDTFVGcjFCNzUydzA0N3dI?=
 =?utf-8?Q?uBx2zNbWpFOAXCPIAU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73185777235D4648B79771C9AE502A77@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3d077a-0321-428e-ea97-08d95590ad8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 08:36:52.4126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82nCK+Rmi6frgoq5fiI70nOY3AfhcgyYOl3B5bDA4XDu8pLA35cunR31unNjBjtCmYHg4W2sqlH5xY4RjgOF7yYxcSOZIZFdS+T0gHeN5fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDQuMjAyMSAxNToyNywgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEhpLA0KPiANCj4g
VGhpcyBzZXJpZXMgYWRkcmVzc2VzIHRoZSBwb3dlciBtYW5hZ2VtZW50IGZvciBTQU1BN0c1IGFu
ZCBhbHNvIHVwZGF0ZXMNCj4gdGhlIG1hc3RlciBjbG9jayBwcmVzY2FsbGVyIGFuZCBtYXN0ZXIg
Y2xvY2sgZGl2aWRlciBkcml2ZXJzIHRvIGFjY29tbW9kYXRlDQo+IHRoZSByZXF1ZXN0cyBhdCBb
MV0uDQo+IA0KPiBUaGUgcG93ZXIgbWFuYWdlbWVudCBwYXJ0IGlzIGltcGxlbWVudGVkIGJ5IGFk
ZGluZw0KPiBzYXZlX2NvbnRleHQoKS9yZXN0b3JlX2NvbnRleHQoKSBvbiBlYWNoIGNsb2NrIGRy
aXZlciAocGF0Y2ggMS82KS4gU2luY2UNCj4gdGhlIFBNIHBhcnQgaXMgbmVjZXNzYXJ5IG9ubHkg
Zm9yIGJhY2t1cCBtb2RlIChzdXBwb3J0ZWQgb24gU0FNQTVEMiBhbmQNCj4gU0FNQTdHNSkgdGhl
IHBtYy5jIGhhcyBiZWVuIGFkYXB0ZWQgdG8gY2FsbCB0aGUNCj4gc2F2ZV9jb250ZXh0KCkvcmVz
dG9yZV9jb250ZXh0KCkgb25seSBvbiBzd2l0Y2hlcyB0by9mcm9tIGJhY2t1cCBtb2RlDQo+IChw
YXRjaCAyLzYpLg0KPiANCj4gUGF0Y2ggMy82IGFkZHMgdGhlIHNlY3VyYW0gY2xvY2sgb24gU0FN
QTdHNS4gVGhpcyBpcyBuZWNlc3NhcnkgZm9yDQo+IGJhY2t1cCBtb2RlIG9mIFNBTUE3RzUuDQo+
IA0KPiBQYXRjaCA0LzYgYWRkcyByZWdpc3RlcnMgZGVmaW5pdGlvbnMgZm9yIHRoZSBuZXcgbWFz
dGVyIGNsb2NrcyAoTUNLMS4uNCkgb2YNCj4gU0FNQTdHNSBhbmQgYWRhcHQgdGhlIGNsay1tYXN0
ZXIuYy4gVGhlIGRlZmluZXMgZXhwb3J0ZWQgaW4NCj4gaW5jbHVkZS9saW51eC9jbGsvYXQ5MV9w
bWMuaCB3aWxsIGJlIGFsc28gdXNlZCBieSBwbGF0Zm9ybSBzcGVjaWZpYyBQTQ0KPiBjb2RlLg0K
PiANCj4gUGF0Y2ggNS82IGFkcGF0IHRoZSBtYXN0ZXIgY2xvY2sgZGl2aWRlciBhbmQgbWFzdGVy
IGNsb2NrIHByZXNjYWxsZXINCj4gdG8gYWRkcmVzcyB0aGUgcmVxdWVzdHMgYXQgWzFdLg0KPiAN
Cj4gUGF0Y2ggNi82IGNsZWFuIHVwIGEgYml0IHRoZSBjb2RlIGluIGNsay1tYXN0ZXIgYXMgc3Vn
Z2VzdGVkIGJ5IE5pY29sYXMuDQo+IA0KPiBUaGFuayB5b3UsDQo+IENsYXVkaXUgQmV6bmVhDQo+
IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDEwNTEwNDQyNi40dG1n
YzJsM3Z5aWN3ZWRkQHZpcmVzaGstaTcvDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIGFkZHJl
c3NlZCBjb2RlIHJldmlldyBjb21tZW50cw0KPiAtIGNvbGxlY3RlZCB0YWdzDQo+IA0KPiBDbGF1
ZGl1IEJlem5lYSAoNik6DQo+ICAgY2xrOiBhdDkxOiByZS1mYWN0b3IgY2xvY2tzIHN1c3BlbmQv
cmVzdW1lDQo+ICAgY2xrOiBhdDkxOiBwbWM6IGV4ZWN1dGUgc3VzcGVuZC9yZXN1bWUgb25seSBm
b3IgYmFja3VwIG1vZGUNCj4gICBjbGs6IGF0OTE6IHNhbWE3ZzU6IGFkZCBzZWN1cmFtJ3MgcGVy
aXBoZXJhbCBjbG9jaw0KPiAgIGNsazogYXQ5MTogY2xrLW1hc3RlcjogYWRkIHJlZ2lzdGVyIGRl
ZmluaXRpb24gZm9yIHNhbWE3ZzUncyBtYXN0ZXINCj4gICAgIGNsb2NrDQo+ICAgDQpIaSBTdGVw
aGVuLA0KDQpQbGVhc2UgaWdub3JlIHRoZSBEVkZTIHBhdGNoIGluIHRoaXMgc2VyaWVzDQooY2xr
OiBhdDkxOiBjbGstbWFzdGVyOiB1cGRhdGUgZm9yIGR2ZnMpIGFzIEkgaGF2ZSBzb21lIHVwZGF0
ZXMgdG8gaXQuIEknbGwNCmludHJvZHVjZSB0aGVtIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNClRo
YW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQo=
