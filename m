Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED9130FB37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbhBDSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:21:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:39373 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbhBDSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612462781; x=1643998781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mS6rEgMwGeeKjHBoaN7R/2Q2r4gA+qYjzKdedI7YHq4=;
  b=p+4f1faUQHHuLOO7l1vOwQzi2t/eIfHkH8iHx5iV5q1L4FIFjZ+Ab0e2
   d1M3SPvgITlNvih37gsZNeOTOGq45UVJI5vVkscwaWYnbpX1yqZVDPwyQ
   1XNGQ9Ud10wNTRiSMxbrmDLqcKNxC3DBbow9w37HVcm0CHvdm7I/eeHss
   he9RkBorzL2wi4NP/mHYk9+oLOnQZLq5Bgb9XlAteaJJkb3322llE/ueX
   x5ZhKlgnsV4TTMK0OcsZgXzZ4Pp6FHdaIQ6GQGZ3bfRNi386mfg9YNGAl
   /CgoegAYclRRphuMWNp4On3R5uy8U30okRw151YOssyFFd/dXycp34gu6
   w==;
IronPort-SDR: T8HHXIcYR3aA2Tgf1jid6I4+sAzawDgoJGp4c9PobZS+TZieIoBHEfOwlZq6hv1PyAIXb2LbcB
 fb99yOdOyNV7xZ2BRdSBE+oqTmfyr3uHTUkFq2kiQV89d5D2O/i5oNUdqSi526jBVXl2ECv6GU
 jJXpm0Gr6jxuUF0I30irvfeGVTYINA6OPsOAA19Tg8rx52wTMWlju2bfJnxSbOVYxnTmCVrVHM
 lB+OMXi45ibvy5Hu0LobDmgvUHecGf6Wr37WiwV9+PKfveTtpSg2Y94PDoS9C7UFoI/v7MEYhR
 xJ4=
X-IronPort-AV: E=Sophos;i="5.81,153,1610434800"; 
   d="scan'208";a="42955131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2021 11:18:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 11:18:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 4 Feb 2021 11:18:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAGNQ3I8kVuWKt2qiShGe1E501MEHosotFx5aMdWcN8wNTD7QieOgwyDqs6yQFKh7bpaWfTKzsdF7efWGzVEJbT4UbmZNcLEBpE4xH4EsW+SyZjL//MPo+R9Xt2w4Lj795jQBuhfe2LxKMPtuHMVO6bZcGjA/hVoj23Zdmd5gBtjd+hJ8ZDb/dFt/xgqdxfn2eEUyHQT33cuaKAzJPZgZyXZiaLwPIPR0EYO1c+lVXvEOymMhTM0Y5NLign4nkox5Est/WbSBfu7eWrCw56nKEL2pjzFkVBGRLKFWjG67N59fslQpLbrZ6xE6Ql6mAs3H7JTmU5IkyYo7b1BZ3EFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS6rEgMwGeeKjHBoaN7R/2Q2r4gA+qYjzKdedI7YHq4=;
 b=kt2YWJPoiOZiFySaUljLUK9FsZSjk+Ua5DlKkPeDJrQLiNou5U9ddFP/k2JU0CoIjMuSyt2jPT2z8Sf4EaW488PtZSFak8WWrPxZ+U5y4SEMCWKWzNCUNcp4TCrSo3GTKcr1TglfnzSbM8mP+IFEy1H8nWMskIUeWZohm5kg7JvRBktV9bBBJ06l8753p4U3eLd5vNbU+c4vxbnmPe2/+cBMJ0q06zrB8ysWDONvIM7jHPdAHH+jjI3FZbA5vKUzIY6ImetpWO9vy6VewdpnHzvVQ3okjpzPu3IGEjPzktUc1hKyDHPBiPPlRMi8yOsEt+PuHfz32HNXeAwGEZH0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS6rEgMwGeeKjHBoaN7R/2Q2r4gA+qYjzKdedI7YHq4=;
 b=cWc10JdmgPExRjpAXgp2s3JFVi1P85VwGywlPufMe+0wB1XVzZMec21kkzCqiV8PCSuh6PtxAJYZykwyAGDf9PLHz5CxV36AFGC6eYU+PYvIbI84FroruOYfUw1HxROFmBhYmueoZyxuwcx8/gLNI1yrWCa6CQ7ihUbYTIJSLmc=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1993.namprd11.prod.outlook.com (2603:10b6:3:12::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.23; Thu, 4 Feb 2021 18:18:14 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::b96e:6776:6971:80f4]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::b96e:6776:6971:80f4%5]) with mapi id 15.20.3805.027; Thu, 4 Feb 2021
 18:18:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <arnd@kernel.org>, <linux@armlinux.org.uk>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>
CC:     <soc@kernel.org>, <arnd@arndb.de>, <sboyd@kernel.org>,
        <clang-built-linux@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: at91: use proper asm syntax in pm_suspend
Thread-Topic: [PATCH] ARM: at91: use proper asm syntax in pm_suspend
Thread-Index: AQHW+w8qQUwoH91XlEGs7R8gkYKHo6pIThMA
Date:   Thu, 4 Feb 2021 18:18:14 +0000
Message-ID: <c7e601ab-03c0-7b20-9678-3f9f4615836d@microchip.com>
References: <20210204160129.2249394-1-arnd@kernel.org>
In-Reply-To: <20210204160129.2249394-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [213.233.108.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80926142-59a2-43f4-15d3-08d8c9393d01
x-ms-traffictypediagnostic: DM5PR11MB1993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB199344A0959F1ADF0D46910687B39@DM5PR11MB1993.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++vkoc2lnFJ7WKplb4iC6fZ/D6YnTPJUN91fALo0A8fvNVq0CMbvOj7KkFqvOE/eu13Eb323ClVzDI1S1cw50wLmQeyAU6lu4IEYjGZGPSXhK0hR/a4VwzgvdBrz4lZiu8I3tjlhLMwXF0Nwb9ncwwOvYogSRQGbt1eS7czf4aU2JzbWFoctaOrWDmg4k4vh8BmjqC1dyD26m7M55iIZx0qYau2XDnItxfm37iCfe7/BHSNQ2cXHtT54HKCna6gqXLU4WrrVyjWKnhXPzEweBdFzNK5VXTgoUSRn62reFvsoe97DKz8zYNns44/mOGky9cNkez8FvPt9oZzQZWDH46Skqoibv2TOUZz6jUHg+pLt75HObH2p0aBXtX6hWnmuuEknwrNl8KpFwD1418toRcSaLMBxh4ZufEvnkkeZAn8VROoh592KuNitsjiquaBfv19UaLl4asVO7+2ObGmX83SmIShU6R5G9joNF+oxh1xVwULu6b1cjRJTS3XJR0Qj2/Ca+wsfsP/HopEKc6wOF/0+AXIQAAEcMOVO186zz72ZY1T+s5xXsdaTeb+p63GrlmokWC52VEa0BCw6foNZiM4MHq4yUAsGINVRerXf/PE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(366004)(376002)(31686004)(53546011)(26005)(4326008)(6506007)(186003)(31696002)(71200400001)(86362001)(2906002)(6512007)(8936002)(2616005)(83380400001)(5660300002)(36756003)(54906003)(66476007)(76116006)(66556008)(6486002)(64756008)(110136005)(91956017)(316002)(66446008)(7416002)(478600001)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R1F1R0JqaGlacEh5Z2poV0hKWjFGUGV4Q043bEdRVGNNaS9ndSsxR1FCN0pP?=
 =?utf-8?B?YVpBeWppNjYrTWo2YW9EVWlvQU9GM1luT0hDMlFEWE1uVXVBSUhXMDU1cjdN?=
 =?utf-8?B?Q3d3bTNwdHdnKy9mNndzV0RvaVp4b1Awc2dJZVk3RGJTbEY1NXRzd3B2MjIv?=
 =?utf-8?B?LytDOTZ5VDlrcnR3UEduUVZRQlVkZm42a3JlNXBDSjUxdHFiUkRzYnBDeWFN?=
 =?utf-8?B?bzNoQUswaTlndXNQU1NxeDFDZEJkZ2o3S2VkeExuZXNmQ3pyclg5VUp3VERB?=
 =?utf-8?B?T3A1MWJZaG12Wm1wTEJ2eWoweTlHL1hVM0Z6TEZpd3VKV1JaNjFGQUZ2d2R5?=
 =?utf-8?B?TGlENmNwT3pzUHBUMmtFOVB0bUhLUCtkdDNIcitzL0htVzZKVWNzOEhmYTFj?=
 =?utf-8?B?UnNXZWdGUFpnUWI2VlJoTkhoMjJVcWNaQ0hQaUVOVkVyMHNHOVlaTnlQQVNh?=
 =?utf-8?B?d0JkcGdiK0V0U2VJSENka2ZoQzM0eXNObFM2ODk1dGNxcS8wQXVVT1g5eitC?=
 =?utf-8?B?dnlaei9aNk9TWm54VlBsWlh0TjZoM04yUlo3U1pCSGRGUFJvdFJjdEJ1dkpR?=
 =?utf-8?B?a3Rjbi9oaEZMTWtCRjZYNkdpNnQyT0hVWG1mT29NcVVuTTAyU0s1NGJiRGtM?=
 =?utf-8?B?NkdNcHFGbWJlZERkaUFiMVk2NjMwVzBSUzhCQ1hZUmg5azZsenNCQUgzYTBh?=
 =?utf-8?B?WEd5N2FibXRJRnZTZmNGS0pxOGZhNFBDTS92UUErZGZUQUJmRldhYm55VEQw?=
 =?utf-8?B?OC9OVWZzRWNnZEhwWVM0SlpuZmpVaHdJMzNLTWJBbUxOWVF6MWVoYTJ5dUFG?=
 =?utf-8?B?SDlzTVE3VFJPOEdHWVRQbUovaXpQS2VhWTdud2VGeElqamVPQlRxRXAxOVR5?=
 =?utf-8?B?OG5YUlc2SlExM3FadjlzNUIrZEdoV2VyV0MyQWNSZWovUHVNeXRtYmJpbERq?=
 =?utf-8?B?MmhGZkNGc1VZZFBrblZpZ1VpcDFTSUo5NlNJZXRaYThqeDcremVmdG9VVmR0?=
 =?utf-8?B?NEtyekJENEdoSEJ3eHE1TVgzWTJZNWJJRXhXS2dIbzhIZ2hJYm1sTWgvbCtp?=
 =?utf-8?B?blNuNDZ0aVRNcm44ZWxaTHh2RkNNdlVNRmNRTndHOERkMjNRdkpaZVduT2F3?=
 =?utf-8?B?aEpMYS9CeFNYMzBDQ1JaZEhGVDhOSm90YjRVUnBzZjlDOE52a052R0NyVWd5?=
 =?utf-8?B?RFZ3WDFub0ZuYXBSNzVldGUyZTZONFcrN0VPbTNnWS9NWmFJSFRGWDUrR0pu?=
 =?utf-8?B?MVpsUHJTRVAxTWFmSkprSGpJRnI3NUppUS9oMzBodkUzOW81RFRGcTV1VU83?=
 =?utf-8?B?TklNMlpWNEZVL28xeFFzY25VRnR3UVNNY2hUc1JQN0hOaGhKSVROcWpuUEsv?=
 =?utf-8?B?azJ5S01XYm5rVWJTRWM2V2dZNHhjckdyY2d2Q0svWlBrdEx5UXRSMit5Z3My?=
 =?utf-8?B?RzRxY2Y4YkhDTWZZSUN1T2lweEJNQlBMeVhVZ1RpQk9RNHdRd25uSHVKdmRP?=
 =?utf-8?B?TzI2NzE5ZVIvZDZjODdmM3RSZkFuUGJDcXo3SUpiV29UTWZ6L3RVaHkzWDdH?=
 =?utf-8?B?OGlocjVBZFc3R0ZEYURiZFlTZjFzempLRFNDTkN3dHh4QWFwMGxxTE44Wm5o?=
 =?utf-8?B?MlZ3d2FQRjJjZk4vMU02S2Y0VS94L1FSTlJnVnJpWmZRNHhFeFFSWjJOSFRU?=
 =?utf-8?B?WCtKVXpBUVAwMXFxQU54c0JhaVJJbi95RTZnUktQT1I5SStZY05qa0RHMmlU?=
 =?utf-8?B?VkUraG1abGUrdGJlMnpYM3RjQXpjWk9BWG9MUVd1R2NoUSs1UGt2amRNMzJz?=
 =?utf-8?B?eThONUZZa1ZaejNjamZudz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD43F4833FCC8245888A679CE06E24CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80926142-59a2-43f4-15d3-08d8c9393d01
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 18:18:14.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fi2vYrG0ksxu59gxdj07bYhsuceSjkofLfOUUtl3EgVnGRaPCtO9P02yWbJ8YJJ+abTOGMBYJSq/sT1gH4W6pT5yTvATJn4Z1H3tt4sSyxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1993
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA0LjAyLjIwMjEgMTg6MDEsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJu
ZEBhcm5kYi5kZT4NCj4gDQo+IENvbXBpbGluZyB3aXRoIHRoZSBjbGFuZyBpbnRlZ3JhdGVkIGFz
c2VtYmxlciB3YXJucyBhYm91dA0KPiBhIHJlY2VudGx5IGFkZGVkIGluc3RydWN0aW9uOg0KPiAN
Cj4gPGluc3RhbnRpYXRpb24+OjE0OjEzOiBlcnJvcjogdW5rbm93biB0b2tlbiBpbiBleHByZXNz
aW9uDQo+ICBsZHIgdG1wMSwgPSMweDAwMDIwMDEwVUwNCj4gYXJjaC9hcm0vbWFjaC1hdDkxL3Bt
X3N1c3BlbmQuUzo1NDI6Mjogbm90ZTogd2hpbGUgaW4gbWFjcm8gaW5zdGFudGlhdGlvbg0KPiAg
YXQ5MV9wbGxhX2VuYWJsZQ0KPiANCj4gUmVtb3ZlIHRoZSBleHRyYSAnIycgY2hhcmFjdGVyIHRo
YXQgaXMgbm90IHVzZWQgZm9yIHRoZSAnbGRyJw0KPiBpbnN0cnVjdGlvbiB3aGVuIGRvaW5nIGFu
IGluZGlyZWN0IGxvYWQgb2YgYSBjb25zdGFudC4NCj4gDQo+IEZpeGVzOiA0ZmQzNmU0NTgzOTIg
KCJBUk06IGF0OTE6IHBtOiBhZGQgcGxsYSBkaXNhYmxlL2VuYWJsZSBzdXBwb3J0IGZvciBzYW05
eDYwIikNCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCg0K
UmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Pg0KVGVzdGVkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCg0KPiAtLS0NCj4gIGFyY2gvYXJtL21hY2gtYXQ5MS9wbV9zdXNwZW5kLlMgfCAyICstDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWF0OTEvcG1fc3VzcGVuZC5TIGIvYXJjaC9hcm0vbWFj
aC1hdDkxL3BtX3N1c3BlbmQuUw0KPiBpbmRleCA5MDk4NTZjOGE4YzYuLjBkNDY3Y2M0MDEyOSAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1hdDkxL3BtX3N1c3BlbmQuUw0KPiArKysgYi9h
cmNoL2FybS9tYWNoLWF0OTEvcG1fc3VzcGVuZC5TDQo+IEBAIC00NDYsNyArNDQ2LDcgQEAgRU5E
UFJPQyhhdDkxX2JhY2t1cF9tb2RlKQ0KPiAgICAgICAgIHN0ciAgICAgdG1wMSwgW3BtYywgI0FU
OTFfUE1DX1BMTF9VUERUXQ0KPiANCj4gICAgICAgICAvKiBzdGVwIDIuICovDQo+IC0gICAgICAg
bGRyICAgICB0bXAxLCA9I0FUOTFfUE1DX1BMTF9BQ1JfREVGQVVMVF9QTExBDQo+ICsgICAgICAg
bGRyICAgICB0bXAxLCA9QVQ5MV9QTUNfUExMX0FDUl9ERUZBVUxUX1BMTEENCj4gICAgICAgICBz
dHIgICAgIHRtcDEsIFtwbWMsICNBVDkxX1BNQ19QTExfQUNSXQ0KPiANCj4gICAgICAgICAvKiBz
dGVwIDMuICovDQo+IC0tDQo+IDIuMjkuMg0KPiA=
