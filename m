Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D45351283
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhDAJjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:39:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:57378 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhDAJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617269938; x=1648805938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HCfM+bA9UaPraqeLxX6zAyD3z+puyOmEtqFJLwS2YHs=;
  b=kUKfQRkJOASK0ZqKnyWYuxrWcEsxsO5ha7aV+wBUgumhdcLllSZp9yt0
   ynU2Bm4MN2d65DUdHLdYhzIpfJ1IneegIpK0Q+TfHVxj3VhJ613GBOdPh
   FwLont7BAdanW7fnIKJlNVdPQ2mnXmidZeTLLOSp7xzXLveFczCfsJGvJ
   CKXdoPW8GuywLSVEK2X+lazlAhnlwtkwxXvqpfY8uY22LL8+U7RdILNv+
   IVFWuXUnZadDuRLrKmDMstdfeWm+O9+433EReRbN7xE+RfvIoDQdoZu5r
   KgldAQVkbkhcdpMV4joAaeloH6/v0S0CeH8GbnhuRvLhvr/qKTGtIXiXa
   g==;
IronPort-SDR: LUGK15PB2sYkQkd2AxM6AqUtR+nlMTsVP2tbb1Ia3g/qigRrbu7hqzfsLoExWTyfdMDQ1SHYbx
 Sd/CPkco2IT4qOYKyatG7r2mDmwHbh+AsF4Anh3RzfVXiv13gtzPVzFfjA/jCi5Q6uQ6QBnWoq
 OqexPzuD03Q3Fset9Xpjn6qA2u+ozZDSi+1pvGflygvYDbEy9kp8XWhp+xruxNUOkEp2TX8FSZ
 UPanOxNfnq7FrTJKIpksMD+bFIgA5ZgnYG6ETdklpxMLAKwTal3pVsdp9XUnb0kgw+ppkH1eVB
 oGA=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="115484880"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 02:38:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 02:38:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Thu, 1 Apr 2021 02:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzQqdS0Nbt7uNT75NPm/Ef0Lnpab15FBqyRiBos9KrR/8nI+zXbJyAZQfVfmJI5OBFcjx/cD6MIB8fFLusn4lY3K7KIPh+sB/Fd12wlnDa418VJzhjwRpHqmvsFswsYW1EJeJdeXGpHVvP2ffkE0U8yF1kDc23/fqh4VRO7Zzm8FEHJudA3g/IJtW2a/PLUmuvwCsKLdtwkitYAOHgFw6Y5LCjt13n2LBGlT632ACj6ot/zAEqrs44EGHH4mlLCC250L086Uji1758RAiKtlpJchoDei4NPygi1yjOpXV9pWiZ/kYXdJrxLeNZZU/Ipa/S0nb6WxPfs0HDt4uyCGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCfM+bA9UaPraqeLxX6zAyD3z+puyOmEtqFJLwS2YHs=;
 b=PZIMd1ASdvIGrxm8zu+De0iHwRtu8a3qSSBJ5gCuifuNq8V9nhz+n0SOxEXvJXa8nUkcKT/AwdSLQ50gzKpLlcwphML29hUACSFgLt1DWXb5U9VK1AgnFMSa78Rn/4S7bUPbIG+pQ/yGsOkA1XuTar3+LmDMcJpoQz4icGu1jFGthpdoCieGf712QjW/kCZNVzq+7Q5qOp15Q22j22qCBgdyhBj/V39rShNi/sBV2nihh6Bx3uRT4Oorjqvx7X1zMGlTK1GTUdxiWQtA0CM9QJPsiDxm9P9+vViGgdB8TjBiNBhPwdCl0xiLZp5gMC8YTmG1WHC1oLeBUtO+n0NXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCfM+bA9UaPraqeLxX6zAyD3z+puyOmEtqFJLwS2YHs=;
 b=dbz3hd17QYCKacjaA2nECacC2GXE4ivu+eJTQoMoNOKbxclzYbpkmHNlZf8Iv+al3Q35x/BV8jqPjOL3hw3m9yv02uZmq31WDWuI+zUqdcqJM7JddPZHpRiTdcejt+qBIX09b4a7ADwEU9At5gxmrPmYYo7IE3NTpVBwh30L+ug=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Thu, 1 Apr 2021 09:38:56 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 09:38:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH 22/24] ARM: at91: sama7: introduce sama7 SoC family
Thread-Topic: [PATCH 22/24] ARM: at91: sama7: introduce sama7 SoC family
Thread-Index: AQHXJtrVVYAy3lPKIkuJ1UvS6Ea1/Q==
Date:   Thu, 1 Apr 2021 09:38:56 +0000
Message-ID: <a908274a-c4d2-faab-54a4-31fd0ffeab7e@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
 <20210331105908.23027-23-claudiu.beznea@microchip.com>
 <YGSc1L8yW0KniOsx@piout.net>
In-Reply-To: <YGSc1L8yW0KniOsx@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02d80346-b4a8-416b-5813-08d8f4f1f869
x-ms-traffictypediagnostic: DM6PR11MB4075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4075EB73126AD487119204D5877B9@DM6PR11MB4075.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGfi83TKetRBD7LIQQp0scHj7LgerVHbpRf/k6Gz5PlzI6bBI2ffN+agMeztaz6hACMyIi4YXJ6Io/bISI5pgWOUlRjAlayLmHv74LYPdOo+jNpoGW9GZKqK1fBvfXkIkJqnDHtrGnQfiQmGYz0c6fpqaZEjytPufTa2CrzTNO5ytfTWUF4ZB7+JJcDX8q9tcEbObDoP2ZCtympesSoyax/M3kGdYQluxniFDr+gqetodOdLuac4pSfqz6AYl5frh8EabzFvZSr7bJX1J07oW97yadSXXjMpuvL9N9jaDAolzaqHlZEbDLSz2QcaYB/4tQujqqkqtCJLTGEpgIWAqIy5cdHSii/1lu+sp0GZT8pTtz9J7/cU1NFnMmrwaMB6Jin4LegGT4DEvD50i9S0viLJvtarmbzH0Rx42Ny5ypcBwRXoqwPaMePiTXGA5Pe2U10hEnjOeKcBMKvx6dJ1h7nFJ9TubIcMF+q/5//IzL6pyhfLhcvUTDaYR+tUVjtmego0WUHtzcGdH5d+hqzSJjidliO3ZJG7NXDMxqeVA6kBuT65oD5ktxYrY+VJLMTfIbEDUiZWSTsuKLUY2Anxo883JH4YpJsNo4mYtn1JVRhpW+nvPSpu7xKNLkoeBYMiYuGSvQiQ4Sww1GLda8cdRzejPH9mOIhdvPhksLO+cCJB4PrdNSm4OvZSMnPkgnK4eYhFa0COgUwsUrDulobQ/JvT5wOK6XwanKmomd6Pl+tSjp4nOPDTJUOx9x9JmX8b0fJZ/KtTxJt3C6wxNpY3f5d2aRaUkL/HkUGlJpeIAZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(366004)(346002)(376002)(54906003)(71200400001)(26005)(86362001)(8676002)(83380400001)(2906002)(8936002)(5660300002)(4326008)(38100700001)(6486002)(107886003)(31696002)(478600001)(316002)(2616005)(6512007)(966005)(6916009)(66476007)(76116006)(36756003)(66556008)(66446008)(91956017)(31686004)(66946007)(6506007)(53546011)(186003)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RmZibVBnVlo2b3ova2ZGT0IxdW5uY0JmcnZqWGpYWTdrNDlZTDJFWVlabGs0?=
 =?utf-8?B?dzJGUERXYW1PZWlpa3RSbVE2VTI1dGxwbzc5UmNyWUl5YktiSEtoWFFWQXRO?=
 =?utf-8?B?SVFQbGhyNEVNWHJ3R25oV1g5RjFMVHdUclpQaG1iSjNHOURpMG5wam9xcDkv?=
 =?utf-8?B?c01WUDU2TllOL1hiV0FiY1lFK2VBZERXZjNFamt6NG1kLzhiRmRzN3F0d2V1?=
 =?utf-8?B?eWN3RE9OMytDL2s5ZmVPSXBYTUh6aVVRNjNzOUJzRzg4Q052Q09YWEcwREtE?=
 =?utf-8?B?ck56R1VHOWI4Y1NmS1hablZKamdMdGJSY3c3akxKK1d5OFJPaVE4QWhOWFB2?=
 =?utf-8?B?R0xKanJ2cGpHTC8vTU9LNzRMMll1U1Z5bkNXcVpmZEdzU1h4eWFRRnFHSGtC?=
 =?utf-8?B?WEt2NjRhWW5jK0NIU0cxRVdjSzhidCtob3U0NTY1U09MQjdYajdtS294WDI0?=
 =?utf-8?B?NGhtdHlhOTE4eWJ3NnI3a1kzODQ2QnM3RXhrWFRzR0FOYjZoc0ZZNkFYbUIx?=
 =?utf-8?B?WS9zRlNYK09CdmJBSlowY2FSOFNpell3anF1RjRxSG95YldoaWc0d25aeGNz?=
 =?utf-8?B?enNLdzlOTEFseG1NdlhwaloyUVIxU08vOGc1c1NSdThRMWNJUi90bFRhNWpS?=
 =?utf-8?B?bjM3ajNnTnZjYTZLNEJxM2FpM2ZmL3pBbk5QVzhvMi91TmJwOGJhMENpYVhN?=
 =?utf-8?B?L3lvaENWbzc3OTNESXdteGFLd3kvcUhJVmdWdGxDT2p3V0JjYUdkRC9XRkFz?=
 =?utf-8?B?VndzaHRpdU5UZCtpSW1BQUhodkJsSlNUQmM3QU0xcVRkR2VBQjVITksrVisz?=
 =?utf-8?B?dGV0clc5dXJWY0tHNHVDOXJSMmJNLy9VNW55a0FYQ0ZuNVNEYi9kZ0drNUJx?=
 =?utf-8?B?dzdGWndoZDlySjJQOWhEODZVTVpESkpSZW9yZVBzMERWSDVLQlk0UVVsODBF?=
 =?utf-8?B?QTRWdlZmcDYxelV4UDB3TlQ2WHFxNlJzQmJFM0tkalREYXRadi9nM2hUSmNI?=
 =?utf-8?B?dytreFNqOWcwWmJvVDV1eGFHYWFTeEJES3ZaYVozQjJtVGxCSWFnOHp4Qkxn?=
 =?utf-8?B?bEFuQ3ZTSDFQUURiRUM3dENhd25xdmVETDNpSEtlM1JKMS9ldXJNMk8yNGFK?=
 =?utf-8?B?VWd6ZlhuamJEMUsxOFg3VElMdmtsL2hSeFppQm8xZjM0RlpOVFgrcWNEbkNG?=
 =?utf-8?B?cmYwekdGQ0ZEQzBQa2QwSm1Eajl6T1ZheDAvWC9jRVc4dmR3R3dvcmkzVGYz?=
 =?utf-8?B?d0FnZmZvUWpBeTlweEE0NElmaGxYd28yKzhldTBSVjNiVzZkd1lmYmt1RG1Y?=
 =?utf-8?B?Q2VubWVidjdYanppUzUvb0lQMzI4NDVnV0JXMTVGa1hDaWhUM2F3VVVlcjJ1?=
 =?utf-8?B?elBmOWp1L0ZoRWdhMHdyRkQ1d2pPRHlNdVRLUFpUUENzZjNSMzA3NnI1VkxJ?=
 =?utf-8?B?a0REaW8rdVM5NEEwZ0VURkx3QTZJN20yenNuenBGMFh6QmlWZXA3V0FKMmRS?=
 =?utf-8?B?S0dJVE91ZTltMm5iUitaQ08rNVRjUE00SzN5OE1zcVJQSFpmT2IxVXdneGUx?=
 =?utf-8?B?Um8xREcwdXBBS24vbmJHcGc0L3RZNjZoNnY2NVZJWFdYVTBmVjJtUUIyNmR4?=
 =?utf-8?B?djFLeXRkK2pJeC9tT3cyVG9QUUIyNFZhVlhOS1liNkpJWG1rZ1dNd2hRd3lB?=
 =?utf-8?B?MTN4VVJMTGZlSzNjOGRmRVhKaGZIN0gra1pPU1RRWWZwd1R6Y3lhSG1Gc2J0?=
 =?utf-8?Q?gNeMdzGD8HZ2ZpJu9Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A685E280FCC8247981C99DFB45D7892@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d80346-b4a8-416b-5813-08d8f4f1f869
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 09:38:56.3694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9Oy6tt+fxt5TuIdth3iiWMAr1MmOr4fqAH+27RJHmwQJxJcPLcoYMvWQJYPhBQCDWsaTWNZX9SE32ZIG6At+QGbXRUeveKhHB/KYq5AryA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDMuMjAyMSAxOTowMSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMzEvMDMvMjAyMSAxMzo1OTowNisw
MzAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IEZyb206IEV1Z2VuIEhyaXN0ZXYgPGV1Z2Vu
LmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBJbnRyb2R1Y2UgbmV3IGZhbWlseSBvZiBT
b0NzLCBzYW1hNywgYW5kIGZpcnN0IFNvQywgc2FtYTdnNS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+
IC0tLQ0KPj4gIGFyY2gvYXJtL21hY2gtYXQ5MS9NYWtlZmlsZSB8ICAxICsNCj4+ICBhcmNoL2Fy
bS9tYWNoLWF0OTEvc2FtYTcuYyAgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspDQo+PiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtYXQ5MS9zYW1hNy5jDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtYXQ5MS9NYWtlZmlsZSBiL2FyY2gvYXJtL21hY2gtYXQ5MS9NYWtl
ZmlsZQ0KPj4gaW5kZXggZjU2NTQ5MGYxYjcwLi42Y2M2NjI0Y2RkYWMgMTAwNjQ0DQo+PiAtLS0g
YS9hcmNoL2FybS9tYWNoLWF0OTEvTWFrZWZpbGUNCj4+ICsrKyBiL2FyY2gvYXJtL21hY2gtYXQ5
MS9NYWtlZmlsZQ0KPj4gQEAgLTksNiArOSw3IEBAIG9iai0kKENPTkZJR19TT0NfQVQ5MVNBTTkp
ICAgICs9IGF0OTFzYW05Lm8NCj4+ICBvYmotJChDT05GSUdfU09DX1NBTTlYNjApICAgICs9IHNh
bTl4NjAubw0KPj4gIG9iai0kKENPTkZJR19TT0NfU0FNQTUpICAgICAgICAgICAgICArPSBzYW1h
NS5vDQo+PiAgb2JqLSQoQ09ORklHX1NPQ19TQU1WNykgICAgICAgICAgICAgICs9IHNhbXY3Lm8N
Cj4+ICtvYmotJChDT05GSUdfU09DX1NBTUE3KSAgICAgICAgICAgICAgKz0gc2FtYTcubw0KPj4N
Cj4+ICAjIFBvd2VyIE1hbmFnZW1lbnQNCj4+ICBvYmotJChDT05GSUdfQVRNRUxfUE0pICAgICAg
ICAgICAgICAgKz0gcG0ubyBwbV9zdXNwZW5kLm8NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLWF0OTEvc2FtYTcuYyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9zYW1hNy5jDQo+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5lMDRjYWRiNTY5YWQNCj4+IC0t
LSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9zYW1hNy5jDQo+PiBAQCAt
MCwwICsxLDQ4IEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXINCj4+ICsvKg0KPj4gKyAqIFNldHVwIGNvZGUgZm9yIFNBTUE3DQo+PiArICoNCj4+ICsg
KiBDb3B5cmlnaHQgKEMpIDIwMjEgTWljcm9jaGlwIFRlY2hub2xvZ3ksIEluYy4gYW5kIGl0cyBz
dWJzaWRpYXJpZXMNCj4+ICsgKg0KPj4gKyAqLw0KPj4gKw0KPj4gKyNpbmNsdWRlIDxsaW51eC9v
Zi5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPj4gKw0KPj4gKyNpbmNs
dWRlIDxhc20vbWFjaC9hcmNoLmg+DQo+PiArI2luY2x1ZGUgPGFzbS9zeXN0ZW1fbWlzYy5oPg0K
Pj4gKw0KPj4gKyNpbmNsdWRlICJnZW5lcmljLmgiDQo+PiArDQo+PiArc3RhdGljIHZvaWQgX19p
bml0IHNhbWE3X2NvbW1vbl9pbml0KHZvaWQpDQo+PiArew0KPj4gKyAgICAgb2ZfcGxhdGZvcm1f
ZGVmYXVsdF9wb3B1bGF0ZShOVUxMLCBOVUxMLCBOVUxMKTsNCj4gDQo+IElzIHRoaXMgbmVjZXNz
YXJ5PyBUaGlzIGlzIGxlZnQgYXMgYSB3b3JrYXJvdW5kIGZvciB0aGUgb2xkIFNvQ3MgdXNpbmcN
Cj4gcGluY3RybC1hdDkxLiBJIGd1ZXNzIHRoaXMgd2lsbCBiZSB1c2luZyBwaW80IHNvIHRoaXMg
aGFzIHRvIGJlIHJlbW92ZWQuDQoNCk9LLCBJJ2xsIGhhdmUgYSBsb29rLiBCVFcsIFNBTUE1RDIg
d2hpY2ggaXMgYWxzbyB1c2luZyBQSU80IGNhbGxzDQpvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVs
YXRlKE5VTEwsIE5VTEwsIE5VTEwpOw0KDQo+IA0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9p
ZCBfX2luaXQgc2FtYTdfZHRfZGV2aWNlX2luaXQodm9pZCkNCj4+ICt7DQo+PiArICAgICBzYW1h
N19jb21tb25faW5pdCgpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgY29uc3QgY2hhciAqY29u
c3Qgc2FtYTdfZHRfYm9hcmRfY29tcGF0W10gX19pbml0Y29uc3QgPSB7DQo+PiArICAgICAibWlj
cm9jaGlwLHNhbWE3IiwNCj4+ICsgICAgIE5VTEwNCj4+ICt9Ow0KPj4gKw0KPj4gK0RUX01BQ0hJ
TkVfU1RBUlQoc2FtYTdfZHQsICJNaWNyb2NoaXAgU0FNQTciKQ0KPj4gKyAgICAgLyogTWFpbnRh
aW5lcjogTWljcm9jaGlwICovDQo+PiArICAgICAuaW5pdF9tYWNoaW5lICAgPSBzYW1hN19kdF9k
ZXZpY2VfaW5pdCwNCj4+ICsgICAgIC5kdF9jb21wYXQgICAgICA9IHNhbWE3X2R0X2JvYXJkX2Nv
bXBhdCwNCj4+ICtNQUNISU5FX0VORA0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBjaGFyICpjb25z
dCBzYW1hN2c1X2R0X2JvYXJkX2NvbXBhdFtdIF9faW5pdGNvbnN0ID0gew0KPj4gKyAgICAgIm1p
Y3JvY2hpcCxzYW1hN2c1IiwNCj4+ICsgICAgIE5VTEwNCj4+ICt9Ow0KPj4gKw0KPj4gK0RUX01B
Q0hJTkVfU1RBUlQoc2FtYTdnNV9kdCwgIk1pY3JvY2hpcCBTQU1BN0c1IikNCj4+ICsgICAgIC8q
IE1haW50YWluZXI6IE1pY3JvY2hpcCAqLw0KPj4gKyAgICAgLmluaXRfbWFjaGluZSAgID0gc2Ft
YTdfZHRfZGV2aWNlX2luaXQsDQo+PiArICAgICAuZHRfY29tcGF0ICAgICAgPSBzYW1hN2c1X2R0
X2JvYXJkX2NvbXBhdCwNCj4+ICtNQUNISU5FX0VORA0KPj4gKw0KPj4gLS0NCj4+IDIuMjUuMQ0K
Pj4NCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBjby1vd25lciBhbmQgQ09PLCBCb290
bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9i
b290bGluLmNvbQ0KPiANCg0K
