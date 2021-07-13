Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E33C7336
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhGMPcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:32:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:40267 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbhGMPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626190150; x=1657726150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7if/kVDl2FcZtu3lvYkyVaNW9/Nv3aIEfZqmcIi2orc=;
  b=hHI9w9glLQE+UNjsHw0KNMFRyoP1NEGoW22chCDwPYbHhGU/ycaiYno0
   vXzk0Av2XHXexQu8xhP8nw39qoqkoqKWbuZBjYmdRTkoqcCJtp0niryDi
   ZAJXLab+yhadYJZ+3iTkQaV4xL3XUHuW8x8F6akvgbskqqy/uv2nA4L37
   4KFjL2kmfgdioY7rr85fPeN0OQK65kITv5mmbuRKdAXuZsfKR/aSzXCZQ
   uHdBOOOEc+32Wfz/8RRCyiDJsyQywqhOY67XbA8JYYSpa53UyQZjewFUG
   3ccId64WQMImV2rg9c6JqbGZGQH0Kt7F1muRHFwEgtbsIPmuSbjmZZ86p
   w==;
IronPort-SDR: Me46roF+JhqjHRukedxZ3vsZkrwglqWNhexXj4nCc9RBYgnkZATn4bTplKnQ5FormveD6vS+Q3
 rJSrtFRhM0Us4JHkL4ccNKAfVPvNwVEi2l0jVmosu0Q2YXA/ecZkiMIywaArhMCeZyI8CDYXCN
 Rfb6f+qOiFib242Kt2r7l4Gl2fV+fvDYi1c5QlWdIVCtDkwgidFnBenWysmu8aOuGlxJXBIUQk
 koI7ULKmRfELQ3sj2mMy4/rt8gU9FehDLuJHp4iCLSvGVeuKUlZMfZ2lmUoxbw2RGrseMSirc6
 QJE=
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="62067093"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2021 08:29:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 08:29:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Tue, 13 Jul 2021 08:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bonx1loBe9on6kJ5Rcl1iRLZr7N4wnze57culeZShNso3wAW5SvTlGR75nUqVEz8V9kpF3pRdsZSemb1+WmyC7caT1fS/lnoLuNwwiv+Z+NKBjV7BzHjfP8v8cEtxOmA8VR+/qCQDpITWhiQOjFMYjzSpvIS0oGdSWBHcEHPCNQkt/6ekXHJMibxdWSnSschOib1tCroyY/m7jukxEQnITptl0pZGaZv+eYBG81TH1mRWgvW5Jr0Di9OMZqOhSlZDssBDx1MpVL54usbutZdFSEmmieaisO0hGejdridYz2rSpP2YbUhSZl+IEVWC/APXar5Oig77UvB0SKlX38PMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7if/kVDl2FcZtu3lvYkyVaNW9/Nv3aIEfZqmcIi2orc=;
 b=U03g4kWn+nraK6waid+nGQRpa+3QJQkKK/2sEZDhMioZOQtxpxBjrIyfZWh+TtGy3ZNSJhUbKGMwdK5RG1Ybv1DBlJB0ys4nuO/qPsXYAMVAM/nZJfMoRRer1EhBXp6ul7jIc+yqatk/xfERoizKtP4MWjfXBeqXkGV6ljX80hkXCQaJQI5zBF55Prq+ktlQhGAim1wjh/eYZykY4URx3BUF9K2VzSp0QADNLVb1DL582zj08W8b8RylfcHW8Os53nvWTHburQzHpK1nZ8sBsJl8Rr6bmj+W/DFg51z4Ezzx0QFhpFUPWswADXaLuIOXXpjFGeaFVtXvSmrJbMoHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7if/kVDl2FcZtu3lvYkyVaNW9/Nv3aIEfZqmcIi2orc=;
 b=Zox3deGzPb0PGjHodPjp9jj4kTPx8qY65+GiRISXRTTy532S+2FuMtszsWFR6Uv6iHAbB6g6gzQgBKlZ1RBBQ+2LaGmI/cGxC0NUSlr8ho5VIeqkSMuLpHgLphIq8swZ9UOGnTXWFlkdGFfBe8deU5c3/hDQgUctUcHXqsFriyY=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by PH0PR11MB4806.namprd11.prod.outlook.com (2603:10b6:510:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 15:29:07 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::a825:537d:74ba:2aaf]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::a825:537d:74ba:2aaf%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 15:29:07 +0000
From:   <Conor.Dooley@microchip.com>
To:     <bmeng.cn@gmail.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <atish.patra@wdc.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <bin.meng@windriver.com>
Subject: Re: [PATCH 1/2] riscv: dts: microchip: Drop "clock-frequency"
 property of cpu nodes
Thread-Topic: [PATCH 1/2] riscv: dts: microchip: Drop "clock-frequency"
 property of cpu nodes
Thread-Index: AQHXYnVF06x5/3pZjk+WP/cBJfg+2atBMriA
Date:   Tue, 13 Jul 2021 15:29:07 +0000
Message-ID: <32afd49a-28c4-3354-c15e-f1b0fcdd9591@microchip.com>
References: <20210616060251.398444-1-bmeng.cn@gmail.com>
In-Reply-To: <20210616060251.398444-1-bmeng.cn@gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20bb976f-86a5-421b-a806-08d94612f4a2
x-ms-traffictypediagnostic: PH0PR11MB4806:
x-microsoft-antispam-prvs: <PH0PR11MB4806CCD2B692429E436FC58F98149@PH0PR11MB4806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8IbH1itUnuxPnDj3KYR49V3HuFORzXW6H/hgHZ72FyHtNEsANyjfMY2yFcKdD/9G7JgW/rSbwzMJ+rqgMPkoTC3bzEIQO5dxj9KHfajA5v9XzT2QPF2mxvKCEUt+W9nhmSroaw4vrCJ0WdAYbx6c0eTcpEfbc8kTQN0VUlRnqInmuMFWRiNW4UsJXVG+V8A1sRAhuKfMKte6nxmMaBMnAaug0i9nRVDvTeKujCjiDwgFo44kbuO689QY8LbGybMuP9+M/5+Xylgn5DbAwgC8rvRjDCKk3mG8VAedcjLR95kn+aykJdr+mvbTe/D4rQcbgHndNGowTUyDexNQV440cLcd484sd/ffsyr390lm8JwdZvfW03mzFqHVQK99BXP0mhTwz5syOorRuY5Py55tv0b/p5+f6r2KVl9GEo0p7O9OQkf7KOiUEfjvzQ00SCO7Oltag/527jFxCVge0moPJ02542dGS9EvM8/vXo69cXsnmWKaA2ATIPuv3Uqoc4rhS2B+1eOciR9R1ZWbCLrmHZp0S4WF0GSS0yWmJPOlQMgQDRv5+P1SjtFro27xi2KsQRBg1CHxpSZtmA8dxh8E1hJHcbopovtGelLGkygDZtiUMRIVp+W7GAcoNo/L3HG4ZAsNkVoTsHqgtbHA1Ts0Jm4mmZ9pCdW8to8DV+h7LosD7GYZxSUSud5GmaZk7UGXuUHXMQKTmYQzhZYJx0cLL5cP36Etd3dqgGyt5Mw6PfZN/TtTINMEBXuszrUkuGIH9n6tVvQFe1Cepm27yvW/kDkcixSFKJ7UhcAU/W4DHKOog+DaAaYhlYucZz8BF86
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(83380400001)(6486002)(2616005)(6506007)(53546011)(186003)(26005)(316002)(76116006)(91956017)(110136005)(4326008)(31686004)(8936002)(86362001)(66946007)(66476007)(2906002)(31696002)(36756003)(5660300002)(71200400001)(66446008)(66556008)(64756008)(8676002)(478600001)(966005)(38100700002)(6512007)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVVpNiszUTNuendWSVoxdHVXWTliWWVuYXY0UW9HYmpIT2U5b1FFTnRKN3lq?=
 =?utf-8?B?ZnIvZXkxeUIvZXlCNWsxVS8vRitxdWYxblV2VWoyM2dvTHF1U3VGNVF2NjZh?=
 =?utf-8?B?UmJhOGhWVVRrak9XR2JhRWxhbGpzcWJrVDBsRngyMHpWQ2VYWkdPUUo4aHdM?=
 =?utf-8?B?WkVwU28wVEdkQWtCbTNtWFBtMlJOTlMrYkI5WlBPSGZmT2l6aVRucFhXbnlB?=
 =?utf-8?B?VThuVm4vYklLR29xYzJKcUxJUHRPZyt4cWpzVDFxT2V6Mm9YMFZrMDdtUHVj?=
 =?utf-8?B?b3NHUXJoWUsxajBDNXhReEV6Smw5enV4VnlqNWtwb3B2bU43YlRZN2plVkxj?=
 =?utf-8?B?bjhjZzU0Nkt4bnlmbDNvekpuOHdlTktXcHhnOGZLQTc2RnFmZkdPQW4xNFd6?=
 =?utf-8?B?RWFTVXJsNFBJcHVQamhvK0xYNElBc1dWUjFqeGpFYk1aRGhtcGMzMmUzeHRM?=
 =?utf-8?B?amJMeWVxUHAvYS9MTHBqMExOOGI5Q0FyRkYwclFxUmlIOHNoMmIwU2RINW8v?=
 =?utf-8?B?WThVRUVHck8yL2lkSWtFakRmSmRlMVpUcXBUTjhFWEtFNm5YeDdicjVyWWNL?=
 =?utf-8?B?Y0xHV2ZzMFRtOTUwZGcrOThJNGw5RjFRbFc5YjFEWGxLb0R4eXBOOFB0b1V3?=
 =?utf-8?B?QWR1bWFHZ1ZlL2FFdHFqK1dxZHluYkYrYktqTXA1Uk9FeVJEZlNxbWdUcGFR?=
 =?utf-8?B?UjA5MnBaelZlVGlUYmljRHRBV0trcWRSOWF2RGlzTkZLVU9wWVYyMkI4bm0v?=
 =?utf-8?B?b0VCL0R0OGJ1bkZqVmNtTnlsOGdyNFZWV0VXTWI5WEhJNXR3emkxMzYvV0VY?=
 =?utf-8?B?aVlWcmpiYzdJaGYrN3dmdDMwTWpSSGlLOGhnRnJPNmI3MU1pMWRWL1paenRM?=
 =?utf-8?B?dVAyN0Vxb1JTS0txUmZ4dW81ajB5YU0yNE5mM243bWc0cEFmWlU1WmpSZ0NG?=
 =?utf-8?B?d3UrV09VQXVpem15Z2FYMHNMMWlUWDBiS1ZIYldlMkJ3V21mQzJOUEs2RzlF?=
 =?utf-8?B?QVdUQWxoNmpHZkdDS0d6M0R3Wjk5Q3FjNi9GNzRlMHRFWmloNUM4eDJ5M0xS?=
 =?utf-8?B?SEV6bUdJRlpZeENBc09YLzZKdkw0Rk1sZ2hPNnBMajN0Q093Wm9zMWw2eGU5?=
 =?utf-8?B?VmNjbDVwWC96Mkk4bUpGdTZlQWVXSGZHZjViOEFPc3VXUks1Y2xBVndGYU1J?=
 =?utf-8?B?d2hOWnkrZzhJQWVuRTBhYm95NkVrT3I4WlB4OHBCNGZHUzFXa21BUkNSWjkz?=
 =?utf-8?B?eUxPYmNYS2N6MHhhcW8vdzdDdDFIWWdVdjdFVCtvN01yemZ5OVBwRU5IaWY3?=
 =?utf-8?B?OFdTRWZPYzlsTzFiYXExbE5SR1B2bElWODVUNzJ1TmpSbjVxK0FHSWt2SkRN?=
 =?utf-8?B?MG56TzdDTXprZFpuWkxYL28vcUVBbDRTd3lrT1JRVkNWaWkyU1RjSUlKdEpT?=
 =?utf-8?B?eDVudjFnclFadkVKeDhvTWp4ZFFobU1FTXVKOGZSckdLd2trU240UlhPOGxv?=
 =?utf-8?B?VnFQTkV5dHlEc3p1dzZ2Z0pzK0NVWERaNEZTc2hNemd3T0lFZ0p0MmlZam1o?=
 =?utf-8?B?UTBlSVAzV3VTcGFYbFdFNVR2Zkc4eThrNmFlOWNlZWNSb2NOL3RvYlBOREY1?=
 =?utf-8?B?NTkxcjgxTE5aMkV6R0tiblA5N2xjRS82Z2pueUtGOTY1dVViRUU5UjhYK1ZV?=
 =?utf-8?B?UlRkb2JtN3JlNllkdVV6MDR1RWJOMUFEMUhCRkRYUW5HQllZeWlEekJZSkVv?=
 =?utf-8?Q?ND9RnZPK6XOkw/pJHo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2AE8CE4D4B0284B9C81FB160FEDBFDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bb976f-86a5-421b-a806-08d94612f4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 15:29:07.6286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3/7+c51b3EIl+BXcwmSnccepZFPaARZdiNnW5k9kZJ/4LZZypauAQJdgDV5tJ+9n+ySRTLqot7F8lMRQkf037Y+C6MGEoBkZ8b4B2wfyQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDYvMjAyMSAwNzowMiwgQmluIE1lbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBGcm9tOiBCaW4gTWVuZyA8YmluLm1lbmdAd2luZHJpdmVy
LmNvbT4NCj4NCj4gVGhlICJjbG9jay1mcmVxdWVuY3kiIHByb3BlcnR5IG9mIGNwdSBub2RlcyBp
c24ndCByZXF1aXJlZC4gRHJvcCBpdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQmluIE1lbmcgPGJp
bi5tZW5nQHdpbmRyaXZlci5jb20+DQo+IC0tLQ0KPg0KPiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMv
bWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kgfCA1IC0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRz
L21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNy
b2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaQ0KPiBpbmRleCBiOTgxOTU3MGE3ZDEuLmVlNTQ4Nzhi
M2Y4OSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9j
aGlwLW1wZnMuZHRzaQ0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNy
b2NoaXAtbXBmcy5kdHNpDQo+IEBAIC0xNyw3ICsxNyw2IEBAIGNwdXMgew0KPiAgICAgICAgICAg
ICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPg0KPiAgICAgICAgICAgICAgICAgIGNwdUAwIHsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDA+Ow0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaWZpdmUsZTUxIiwgInNpZml2ZSxy
b2NrZXQwIiwgInJpc2N2IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV90eXBl
ID0gImNwdSI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBpLWNhY2hlLWJsb2NrLXNpemUg
PSA8NjQ+Ow0KPiBAQCAtMzUsNyArMzQsNiBAQCBjcHUwX2ludGM6IGludGVycnVwdC1jb250cm9s
bGVyIHsNCj4gICAgICAgICAgICAgICAgICB9Ow0KPg0KPiAgICAgICAgICAgICAgICAgIGNwdUAx
IHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDA+Ow0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaWZpdmUsdTU0LW1jIiwgInNp
Zml2ZSxyb2NrZXQwIiwgInJpc2N2IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGQtY2Fj
aGUtYmxvY2stc2l6ZSA9IDw2ND47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBkLWNhY2hl
LXNldHMgPSA8NjQ+Ow0KPiBAQCAtNjIsNyArNjAsNiBAQCBjcHUxX2ludGM6IGludGVycnVwdC1j
b250cm9sbGVyIHsNCj4gICAgICAgICAgICAgICAgICB9Ow0KPg0KPiAgICAgICAgICAgICAgICAg
IGNwdUAyIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDA+
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaWZpdmUsdTU0LW1j
IiwgInNpZml2ZSxyb2NrZXQwIiwgInJpc2N2IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
IGQtY2FjaGUtYmxvY2stc2l6ZSA9IDw2ND47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBk
LWNhY2hlLXNldHMgPSA8NjQ+Ow0KPiBAQCAtODksNyArODYsNiBAQCBjcHUyX2ludGM6IGludGVy
cnVwdC1jb250cm9sbGVyIHsNCj4gICAgICAgICAgICAgICAgICB9Ow0KPg0KPiAgICAgICAgICAg
ICAgICAgIGNwdUAzIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stZnJlcXVlbmN5
ID0gPDA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaWZpdmUs
dTU0LW1jIiwgInNpZml2ZSxyb2NrZXQwIiwgInJpc2N2IjsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIGQtY2FjaGUtYmxvY2stc2l6ZSA9IDw2ND47DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBkLWNhY2hlLXNldHMgPSA8NjQ+Ow0KPiBAQCAtMTE2LDcgKzExMiw2IEBAIGNwdTNfaW50
YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KPiAgICAgICAgICAgICAgICAgIH07DQo+DQo+ICAg
ICAgICAgICAgICAgICAgY3B1QDQgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1m
cmVxdWVuY3kgPSA8MD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
InNpZml2ZSx1NTQtbWMiLCAic2lmaXZlLHJvY2tldDAiLCAicmlzY3YiOw0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgZC1jYWNoZS1ibG9jay1zaXplID0gPDY0PjsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIGQtY2FjaGUtc2V0cyA9IDw2ND47DQo+IC0tDQo+IDIuMjUuMQ0KPg0KDQpS
ZXZpZXdlZC1ieTogY29ub3IgZG9vbGV5PGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4
LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YN
Cg0KDQo=
