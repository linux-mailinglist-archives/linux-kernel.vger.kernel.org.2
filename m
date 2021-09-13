Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BF8409980
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhIMQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:40:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:44030 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbhIMQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631551135; x=1663087135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kSKc01gKTeTT8bqCZdFkJ347SD8sDmpxgJJS9yvRL3U=;
  b=iKHkReHc+wpKIOMEOcQnaeQ+m141FItXncO4CQJvp5aRaHgWbxuEJDBC
   hPgQRqEm5z+BQzh2BJxs8NSSaEu9IjPGfKJf58Qs3hx0xsJ+UL9m98iNl
   Q/ZE4zeC2fT8m5/8vCrhqvIbCnfD1FWNejBzshrEkJ0pjuvTmBKdB74Iw
   bmScuyvGSkqX8KTY/qnH6i4SfFRhIQqeyk2fTlbAiUckYwa68Qci7Sgve
   LZPqIX29YRh2h/KRoXS7E64S+hpwe4CbmcWD6+wKqUFmvZc3XGteh9/pu
   PoFiBBoOFz1KFyyf4hATW+CjyK7JqgXAsz/tLdO+xKlYoZ3ecFEDxgd0r
   A==;
IronPort-SDR: isHpCDaNTKvah0f0OZMIErEef/AjPlb/CCSO53skP2tV3Skddk3zrwhxegrRR3HISgdKh49cp4
 XVipoehD9V8hgfBXqNmgyKgO6H4usj8DYK4qq/Ju3HmJ5k7x+cMVIe12vePDO1YIgGLgP7PqJD
 /of9Y+Ow4wvnHD9Cu8BZXBSbQ1q1qY/OLyXpCw1ePL6BI5iYMBhh/LtvhovMDv5EJE9i3ZmlC6
 7FvxLIhsJcIMeDP7Au4QFO7MWDFFR7ZXkNEpF1VDXfGWYXYwOysR2BTAwdmBxzYCaTJ7TSl5Vj
 TO6sB/JG9/reoEe1/8GFTcg3
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="135786403"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2021 09:38:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Sep 2021 09:38:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 13 Sep 2021 09:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3vJvSQhFQ0DE1wdH787E/ax2xT5HwCu9SUoTtJdZe+SpzOiEKOO9iGjoqByU+rqFUt/owTlb1b5mM7z6uvdgkWmi/LzOa5/ggJUxpcN9thAZC4l/C6lhOHXEARdZWsWUX1EtjAY8wZTR7flyA2WVZZ66HC1zigkVp5sB6rp3H0eagHfvgZJNrzzG6lKDtTbAVVmz754PaANcmClvy5Coi+k7VePBivSNAI/n1F6ZalENuIgtxtPhouxsMqHb9H/91IZtOjXG6MrM21j33xD6BNlopLWRa3rvU08tNLL7B3IJotKxaT9gKHXzKnB7IGExSqpWPp49BKt1q0itlB+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kSKc01gKTeTT8bqCZdFkJ347SD8sDmpxgJJS9yvRL3U=;
 b=WyG3QE4kWNsvmTnW2tMelO8e593op5ZLP0rvTyNyZLr8WsFeIvKSTlGXV8ODjrpo4pokLdn5hGoRJTBfOT4hXkbyfq3MCsYrsr7ae2xh9e2mG93G5/63Ov/8a6TVtKraTXn3ZUkPCGLlxkS2Mbf4r+3Ex7CumNgwfm4Yl/Ew0mbv2xhtf6ecJQi4Q6YyM5SmSkyaeyvJMKuRlFwpAlnXsEh4Tyf4vrtxfaFJjXPlNE/FOJmEjZ228AsctXisbPjU2z/u4GHfj+5KhDqSeAAmYYZJ85eMGGwUa3ci4VbC3G5oM33RvBTEhbsoIax8rlpxB4G528Cz/TGB7Oi4ZfJ1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSKc01gKTeTT8bqCZdFkJ347SD8sDmpxgJJS9yvRL3U=;
 b=aPxoBlm5O3vWnhwsHE6MQejoBRuy7zbEY5XayyLGqVWfjUng0/6yCYpMn/gO0mmzhZo2fG4reTAurJMFSa5Z/yKwC+B1eKSi7ANlLlKaqPzLYaU9rZkXeGunj+nNJZH2jo0S4AeraSkbuUBDEk+33M51UdpvykTMuD7Rg8bAJVk=
Received: from BL1PR11MB5272.namprd11.prod.outlook.com (2603:10b6:208:30a::5)
 by BL1PR11MB5272.namprd11.prod.outlook.com (2603:10b6:208:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 16:38:43 +0000
Received: from BL1PR11MB5272.namprd11.prod.outlook.com
 ([fe80::9d8a:c6de:2875:aca2]) by BL1PR11MB5272.namprd11.prod.outlook.com
 ([fe80::9d8a:c6de:2875:aca2%8]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 16:38:43 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <sergei.shtylyov@gmail.com>, <stern@rowland.harvard.edu>,
        <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
        <ada@thorsis.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: atmel: add USB PHY type property
Thread-Topic: [PATCH 1/2] dt-bindings: usb: atmel: add USB PHY type property
Thread-Index: AQHXpmJkQnG098x5ukqYrf7AG+CfuKudoWSAgASNdgA=
Date:   Mon, 13 Sep 2021 16:38:42 +0000
Message-ID: <e90e18d8-0653-0aa3-1faf-9b39ea910bf9@microchip.com>
References: <20210910163842.1596407-1-cristian.birsan@microchip.com>
 <20210910163842.1596407-2-cristian.birsan@microchip.com>
 <55c75f95-6a14-7f05-c15c-64d4dbc1dee8@gmail.com>
In-Reply-To: <55c75f95-6a14-7f05-c15c-64d4dbc1dee8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb79ef64-5e5e-4b72-3270-08d976d4f2f4
x-ms-traffictypediagnostic: BL1PR11MB5272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR11MB5272E52817FC181A59F13002EFD99@BL1PR11MB5272.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWdgERknresBlPs7KX9xLrXgg5OxNaM8+F6HQ/XiOptzj6CCZpJidsQv7vmT1LQ6dFi42EwBN6mkQwYOZzLXQhiqD844MkCQbEeRb4l13kStfpEExTjkMZka60fER4fEH6dKNJInFfbP6mokBqa94shFgfkvUdtq8BEWbOFaNHYN1Y12tTRi/GK3j8ryBNdt6c2MAFwdfuRjQ5zGk3BIE0Vy7D1h/pGNi3O3urLf7AED7erRKcBwKc5qK930kNYY0ObyuRsLU7aWJpy4sCV10X/Z9pYmuBqXU6bL/uiS+Ium7RbGqQnpyZal2scZptr7WuIY1/DKqdT7NN73gevLTpZWyGaghkFvb6Mq9xNvv83oaWwq9WdGxaNL6HWbF1jnSWur6vvSNIUHW7ItWoK20v4hTL69xelQwFZUHxi9dc7OWHxsimNvJD9xR+Yj470+gI5H9CT/nmt/kdv4ra/+vbk067JwugHlLBP3wFGFJHEqkROC1R35z8QuS5Bju9sO4EPqqQzfHFOrMN944kuFtSYeP9eTw+rCg59sBRHf/YznK57xmolLwusNJ6yRrL7QX9Re02iDAB4/GatI+5v/I/gtqDEjchaRmHAg4c8fVdM9pQB+popebV0vH7CB1psKRsSA9RZKGXMPnQHCinySSYyAM4EDMbvni4q88Kna+bvpJlT0hAgzHvC3iy9o/wFn2xWPLBOB+PrZXeT2wNGMDCbEmxzfISAD3XIpKrj88HHjw+YdDaoJTDgf4dclbNYuznYFWhyKz5oSuE0OucB9atNK+hmHmgW4YhyIKOB+SGGyQ2P9talRX355HdpDwDNh4Sq77p4VihQeROys58g0rzRkwG8H1unPwlxRffGREg4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5272.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(346002)(376002)(54906003)(2906002)(6486002)(6506007)(53546011)(31686004)(8676002)(31696002)(66556008)(76116006)(91956017)(8936002)(66946007)(64756008)(2616005)(86362001)(316002)(110136005)(4326008)(66476007)(38070700005)(26005)(83380400001)(122000001)(478600001)(6512007)(5660300002)(966005)(36756003)(38100700002)(186003)(66446008)(6636002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZNc3ZyZmxGclVaSVZBQzY0RCtyVjNCOTYvYVZ2d3M5dlU5ZEp1YURqbnNP?=
 =?utf-8?B?ME1TQUFjNUw1dURXTWtnTGcrU1JxMkNqY0ZpenRVR0dqY1phSEZpTHYyTzJ5?=
 =?utf-8?B?MEpESGszWkZVK2JRZ2hNRStsb3FBUVBacVlrY3ZVYS9YVUhNNVI4dzR0UThC?=
 =?utf-8?B?Y2FENHl4L0pHUkFwSmpvdkwrNkE5b0tlYUVMcWdsR1dUV1JvdUQ4NjZqZnNR?=
 =?utf-8?B?T0FiU1JDdnVCMnQ4enBIazhFRWgrMjlWRDVwWkFVYStadi9qMWRKNVNTYXJu?=
 =?utf-8?B?QitIelFkVTJhams1SGV2OW40VVIxM2RDMVM3UWgydFhVLzBSWFpCcCtuaWpm?=
 =?utf-8?B?andkeXdmdHdhRnpnNit0c2Jvd3NHaXVYNnNqQkYyTXZYRGhvRm9xNUQwNFhr?=
 =?utf-8?B?SnRqWGZQNGtlb0JnMWszUDAyZDlLbk5EMUlldGV2RnJ4amhCL2t5R3p1SEc0?=
 =?utf-8?B?SnliaVRFaXFJSFpFNXRMVW8zVDVheUFWU0NmbEl5YzgveWpCbUxtZEt3TFFX?=
 =?utf-8?B?ZjhhdDRWRTNScjREOTZ2NVdiYzh5eExkakVhM3R5QmJBZCtTclY5MFpOdUJk?=
 =?utf-8?B?VmdGUElZYW1VVThnbUZYblgrZFpyRW5PNTA5QkxZeERZVUdtajk1NmpnajQ0?=
 =?utf-8?B?Sml3M0JkNm82RHF0elZlWXZkVFdMZEpqWFlFMzUyUW55RE5tTjZEdHMycEJG?=
 =?utf-8?B?NlgvTi9MSERFUFhJOVBkdmRsbW05OGRrM1BJU2ljM3d5elo5U2JYd3ZLM1dG?=
 =?utf-8?B?WXpJeGI3WjVoSUk2eU9WRnZaaUdhbFdXTm1zSW43S1RDN05xVndQYUV6OGZz?=
 =?utf-8?B?c0wreHA1NEE5bUQzMGlUcWJkdzJDb1lwcWNBc0htb2wxVkxZdnVPZHQyeDhp?=
 =?utf-8?B?bjdjMnVuS2ZjUm13SnRHVkRvdUVpdWM1YXNWRVVYenF5bm0wKzBtbUx1VU5N?=
 =?utf-8?B?T2JzNHZQYWFkZzhINDk3QlZab1V2S1FVeVQzMkdPQWVVMlVOb0V5ZGF0aGNa?=
 =?utf-8?B?dml3S3lLRitGWi9FQWVXTW9DVXhUZU93WVdZekdpdml3WjIrYzUrYlM4VEVr?=
 =?utf-8?B?RGhkc0wrOEt3Q0FUa3BoUDZ2cXk0cEJGR3hPRFVhKzl1eWw0eGNGNXNVNU5Y?=
 =?utf-8?B?NXU5cnk5ZVUvV2EvN01RUVFlUnVHUFFWbjg4MU9HSkFvcWttZWNVTmtlc05C?=
 =?utf-8?B?YklYRkZLYTgrSjhzaUxrbDgxNSt1TCtWUHFxZU1WNHlTSmtkS2R2bGVvMXhk?=
 =?utf-8?B?Z2I5WXd6TTh3SU5XUWdzZ05qenBMSjVHcmw0djQwVStwMFRid3FSUlRiMnA4?=
 =?utf-8?B?U2VoVTBiWnVVZmVWT0tJTWw3YzZqSHk2Z2FVb2F2bFFnVitpV005L0VmMmNx?=
 =?utf-8?B?T3ZwVTFRQ0VDRDNYQWdOMi8yMmpyVWpnQXRDa1JpZnRNaGhFUXN1clBCWXI0?=
 =?utf-8?B?K1pRUVBkSTlRNXF5azVpWGprSXB3a1JkQ3d2bExxZmhPMS9uS3VEYXlTaVpG?=
 =?utf-8?B?N3NzY29Zb1VqOVN3ejkvNXI5RlJUbHhVSytwMnc2ZXhjOEdxM0pyMEVQQTYx?=
 =?utf-8?B?Q0ZqUFNaVzU0TUIxdkZSZVlDYm5hVW1TcVlTSkMrSkZJc21TTmhHMHk3QXRK?=
 =?utf-8?B?emhBQXVxQ01MeURKVDRpTXUrRnZuOFI4dVV3cDcwY2hWNFZSTkJUMlN3VlM1?=
 =?utf-8?B?a1BNVGRmL3pTSjhBbUt4SmVia2lyMVBHbEkwMUxudDUySi90UGJKbGlrZW1E?=
 =?utf-8?Q?AC3+vkIRAnoFgPjmp4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43082094EB9ADB44BC32753B2A41E6A3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5272.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb79ef64-5e5e-4b72-3270-08d976d4f2f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 16:38:42.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtYj8mF7o2LgzgbV7ywHQsvGbQw8WiM83X3hUYQ21OFyhUmEA2ZsqSAtl9ZGPq2JNjJk2GW5zPeim7uhcQ0TuFQumPLgt6kcAmMFatUMIdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5272
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VyZ2VpLA0KDQpPbiA5LzEwLzIxIDEwOjA3IFBNLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8hDQo+IA0K
PiBPbiA5LzEwLzIxIDc6MzggUE0sIGNyaXN0aWFuLmJpcnNhbkBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPiANCj4+IEZyb206IENyaXN0aWFuIEJpcnNhbiA8Y3Jpc3RpYW4uYmlyc2FuQG1pY3JvY2hp
cC5jb20+DQo+Pg0KPj4gQWRkIFVTQiBQSFkgdHlwZSBwcm9wZXJ0eSBmb3IgY29udHJvbGxlcnMg
d2l0aCBIU0lDIHN1cHBvcnQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ3Jpc3RpYW4gQmlyc2Fu
IDxjcmlzdGlhbi5iaXJzYW5AbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvYXRtZWwtdXNiLnR4dCB8IDQgKysrKw0KPj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9hdG1lbC11c2IudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9hdG1lbC11c2IudHh0DQo+PiBpbmRleCBhNDAw
MjYyNGJhMTQuLmY1MTJmMDI5MDcyOCAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2IvYXRtZWwtdXNiLnR4dA0KPj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9hdG1lbC11c2IudHh0DQo+PiBAQCAtMzksNiArMzks
MTAgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICAgICAgICAgICAgICAgImVoY2lfY2xrIiBm
b3IgdGhlIHBlcmlwaGVyYWwgY2xvY2sNCj4+ICAgICAgICAgICAgICAgInVzYl9jbGsiIGZvciB0
aGUgVVRNSSBjbG9jaw0KPj4NCj4+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPj4gKyAtIHBoeV90
eXBlIDogRm9yIG11bHRpIHBvcnQgaG9zdCBVU0IgY29udHJvbGxlcnMsIHNob3VsZCBiZSBvbmUg
b2YNCj4gDQo+ICAgIEh5cGhlbnMgYXJlIHByZWZlcnJlZCB0byB1bmRlcnNjb3JlcyBpbiB0aGUg
cHJvcGVydHkgbmFtZXMuDQo+IA0KDQpUaGFuayB5b3UgZm9yIGxvb2tpbmcgYXQgbXkgcGF0Y2gu
DQoNClRoZSBwcm9wZXJ0eSBpcyB1c2VkIHdpdGggdW5kZXJzY29yZSBpbiBzZXZlcmFsIHBsYWNl
cywgaW5jbHVkaW5nIEdlbmVyaWMgVVNCIENvbnRyb2xsZXIgRGV2aWNlIFRyZWUgQmluZGluZ3M6
DQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Iv
dXNiLnlhbWw/aD12NS4xNS1yYzEjbjMzDQoNCkkgcHJlZmVycmVkIHRvIHVzZWQgdGhlIHNhbWUg
cGF0dGVybiBhbmQgbm90IGFkZCBhIHNsaWdodGx5IGRpZmZlcmVudCBwcm9wZXJ0eSBzdHJpbmcg
Zm9yIHRoZSBzYW1lIHRoaW5nLg0KDQo+PiArICAgInV0bWkiLCBvciAiaHNpYyIuDQo+PiArDQo+
PiAgdXNiMTogZWhjaUA4MDAwMDAgew0KPj4gICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkx
c2FtOWc0NS1laGNpIiwgInVzYi1laGNpIjsNCj4+ICAgICAgIHJlZyA9IDwweDAwODAwMDAwIDB4
MTAwMDAwPjsNCj4gDQo+IE1CUiwgU2VyZ2VpDQo+IA0KDQpLaW5kIHJlZ2FyZHMsDQpDcmlzdGlh
bg0K
