Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA744292A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhKBIQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:16:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:12755 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBIQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635840835; x=1667376835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HEPRCTt7Ncb7zKISkYad+0mc6S+HhX4AzxaC+K2N+kM=;
  b=vaWsn0QufE1cjw2ioanciMrvL9RWmzIrwN9aJr5MXNEf1/0adaHIEeNn
   m9X54RpfYIjTZlZ/zwBA8bOExKB4a+iI8uYsiWQJDDk177IiWhmjsUNcf
   aKhJIkaQdPoHCuAigKLy8n38nUY6VrRZQmMTTwCAl1M422X36rbK/JaZv
   v4fJ+/BDofzGMg5meCQ9SlLzPQpj4osbwNM65FobidQ/QcKw1l/cUCVwl
   VF4Po2AQClJhR/JhmGh/lp/vstcMVX2K2kkC/rXo0KYIRLs4DbY83LDBy
   or9ndwVJixBvnOgeF7hiTla9rSvHNkPhZCpyFT93BrOd8CycuO1s50KXu
   A==;
IronPort-SDR: sKkQKzhqiF5X+Al6EUnLQy8MXX42TSQ9ftb7RPG9manCwZNQvfmNmBl6ZcRx9K4w1XaGv+EQIK
 2/DpPFwnWrCXcxZzLm8G0XtEq6ICUqK/YuSki7l732QIm2/XQyCKGU8cGGREojIELXDAMj16K+
 5cA275h4xLlDhAkpsjfKZJIoRrDdhlHe5fiyM17qzqfUy34scP9qTGgPQwAErlZY/8C/10aOQw
 i9cvtcB5h7jxsT15/22hNosMa27stu6C4WM2Pxv/+An3l+zMJeU4DWbQFdcM26SV3wAHiybcoe
 7qClzI6wAp/pzyhQWvhHvthq
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="150389289"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2021 01:13:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 2 Nov 2021 01:13:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Tue, 2 Nov 2021 01:13:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTS40HSEpjJ/+ciaWCOWr8u6+1IuE9+nMPkRKjEjo/QKxrR8T+cZsCz0p4Fj9Zakgx4j5AHOvKZ+N+bRcd1mLrATPL7H4amQElS16jJgjIYFK75V10MLYOUhLlXa7Jjp5kDUdGDX+xCtI/5nkX4aNaiYuHgj7iqoKrrVTRtUlxWs1Up1zNtWAlPdwO/4cSWZqJ05o+dhT48C9Loq0SmHNNGtFXP7FMiIW6ebSJZfYN8mVCkugMzdR7Drz9GtC1aYLSOEGAAmBHOsd7/7KR98YxZVfwn/vE8xtdF8Gw/R1Foyj4WvTTgKCOtGQM1aX1z+Rmkz/2S6FxmSnup2rflJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEPRCTt7Ncb7zKISkYad+0mc6S+HhX4AzxaC+K2N+kM=;
 b=VRwBwZEFZOF2XY3/9GLBuh/kx6Knxg7smmk5biFPr/ZmHFbBASb5VTjS8vR1sd8+GB891cZB94lzw8fh15G9nnisD1Jno3jWlVrcM+onX42TEiKlf7feR6H4evYhkSViAIJU0wAYikLFskrz1FQHAziv8Eemz1HDprtQlfj2F1wP1pWfnWjmb4j2rRK6Cj4ihe9lRAiGMrLUoohi7+PvdpuyUisNpLnUeCDKMQQQ2d5BHXVY2OT2L4EyOFG0mybIA0ajy0ukL1AwrFJ/+k+Kb5N2yBG4L0jacEBUKb1IPxEJeWnVHhT1JvAwLiWZsXdSDICJROIgNLjU9sD5fDNztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEPRCTt7Ncb7zKISkYad+0mc6S+HhX4AzxaC+K2N+kM=;
 b=bvF/EmAD1OZBfx1t/v8zFuIHUbxOtO+9saX8sbtzEXb8p5MiyD3Jy57ui1IMBnHDW0ILdYJMXUYXVU5GhQ1L8rgSSUDHk4aie13NdAspcnOspYYa5YfnE9AY7Lkh1ciXvYbNYzPRdPWic6QCKN85YjQx8SkSIxNvqWR7doJBOWc=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 08:13:49 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8%7]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 08:13:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as the SPI NOR co-maintainer
Thread-Topic: [PATCH] MAINTAINERS: Add myself as the SPI NOR co-maintainer
Thread-Index: AQHXz8GPphtofhm500u8CWUcmzkfMA==
Date:   Tue, 2 Nov 2021 08:13:48 +0000
Message-ID: <4f4d36f5-8939-fda1-9c75-cbffbe587451@microchip.com>
References: <20211029181157.20623-1-p.yadav@ti.com>
In-Reply-To: <20211029181157.20623-1-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf8234c6-80f2-40cb-26bc-08d99dd8b2ff
x-ms-traffictypediagnostic: SA2PR11MB5145:
x-microsoft-antispam-prvs: <SA2PR11MB51455F1D2DDAA0DF3A6E1751F08B9@SA2PR11MB5145.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yypam8uiIGVmUt/SqlYuH/sAHya9Tk5z5Nlro7dyN25B4uN5TKn9srcGVEg5Qo9JTRii8dJgmmAA73iHhQhS6f+7XdKxd6SBaQEPxj6pJGjyvbnebtdYIGkKQ5jwJ3ULINsPA/utPYc5m3xdplALyewHrgm1+FrVzU7tkWNR9kqOK1Vz4rWLy6v+Ty8w1VtQjGUN0tU3Eilv7mnDxQFUTIb8gbs3IGu/05RLUJFbyZbsSebDS5sNPclMbva8MGuIDWtDeaNzwuINnDGTpcLTbP4mfmhPIu7Vsy6Kn0k5ULG+7Fh97oD3oTRz8kGXrxiYX3jHt/ac+Zj56/vjBRdGAYSRoKrUtnZnvdM2u7g0ztxCj7Snrzu8GKeUqat0ettxYjQUOPPrBp4CVkrdBfa4qZssqRZyYfoWbYylX/q/rPAL9zrc7VLdMv92aB13miM3K1Qr76ioYDbA88WdkPuuHmQC/z9b/6KxIxNbeqKwm5FMNG5eSEmllt1KZNOlhXJiwGOTttPzrInYej65cdnykNCFcJxgIBVXyRbCNsIXG8TXuYETlEbB4Kdqy5CCU2ftTr50YhWfQvveuCYcSsBbOn1dbpRVihjxUEsAmknVA1YLIDuyJN4CeOEr/gGtRIO5MBD9TT711yqVErOmO4KuiAnhhG2DN+QzY2G8qmlpA6HHSrNAYZFGHMEYMR0QxQQ25V8dvTVku8rvl5ENTcPC7H0bW8SeAJAb+44AfOfV3TsUMZApFveOHZs0USEYuL1uMoK7WJNfsU9E2+WZ6+Y+uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(38100700002)(71200400001)(2616005)(31696002)(36756003)(38070700005)(6916009)(54906003)(8936002)(316002)(6486002)(66946007)(86362001)(8676002)(66476007)(6506007)(53546011)(2906002)(4744005)(66556008)(5660300002)(26005)(4326008)(91956017)(76116006)(186003)(6512007)(64756008)(66446008)(508600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ank3SkZ1SU9FbHlUcUFzdCtUYVlrSkRxWDM0ckxpWkFnNWxyb2VZVCtIVVlU?=
 =?utf-8?B?dXNic2h4UmFFUW4yMUJDMk1GRWM4bExrSGpMR3V4dGdCMmZ6VFlIYWM2VUd4?=
 =?utf-8?B?cWprNUJYY01KZ2twRmJlRXI2dGFNWWpKcHg0NWcyRGFvMWxwZEN0SlMzaDVj?=
 =?utf-8?B?T2RuY1RuQ3Zmam9RY0g3ZW12UDI3c1czd0FuempoYkZrZXVteFlISzBpVFJi?=
 =?utf-8?B?S29ucTFVQ2JadTIxVmEvZjRMVXFSVzk0SW5EV0tXZVprZ0xrc0JuelMwdUZh?=
 =?utf-8?B?WlNaWkR3NG90S0dmMkQvVGVPOGM5RXZsc1dLOStSb3ExWlpjdXJGcFJrMC9w?=
 =?utf-8?B?bnZvSUVMb3NTYTNPTG1IR0pTS2VndnZQZHRaZDNJR1pCSCtKZTB2SjdGcm5Y?=
 =?utf-8?B?emNwNEt1d21FTDh5YTU4d0NORmJlb3pWUUNwZVc0ZEF3Y0xsSHJFR3p4cVp2?=
 =?utf-8?B?cGl0WWhCRWtORG1zWTRONEFoTGhHbkFkQ1ZIem8vaXR1UnNOZVpUaDQvWWZ2?=
 =?utf-8?B?QjRaTk5Kblh1aDh0RUlHODhNVjdPOHoxalVJcWhvNERSUjVyVUpzcmtQSVZ3?=
 =?utf-8?B?SDR1R2NjYzk3eXljMkREdUhrdW9yYXRoU1k4eUgyV1RDenlGQldWYTRpc2Na?=
 =?utf-8?B?VVVxb01aU2hDL1ZhSGw0bnJWVm9QK2tveEpMeWpzSGlRckhtdzZjNkVDeVUr?=
 =?utf-8?B?by9Samp2NVFBUjVTTU1TTDRBS0lzdWFmckM3cFJHRDFpeXF5QzgvNXZ4UVh0?=
 =?utf-8?B?TTVzVGUzUTdleTJOVGZ4WUZodXErNTFYY3VtVy9wcndrblVCQkJ0QTJrN2w0?=
 =?utf-8?B?bzY4dUNwM1dWVmhGNGpxM3RwUGxPQW5xU1NucEN6Vkt0azZTdzdtMEowcTRF?=
 =?utf-8?B?anB4aWdLRmhzenE0WmJrcEpsRXRzVXEvcTRrbm9mMmZ3K0FhYWhzRGRPS2xB?=
 =?utf-8?B?UmlWdHkyTXlPdVlWWEVGQkRoVStMSEZNYkVheC9TSG1rbENsbURTNk5pb0lj?=
 =?utf-8?B?SVhYSmtDWkFZRXpvTkFQc2FmQnpyZmh0MzB3U3F4L2NidU05WmRwVk1SVUJu?=
 =?utf-8?B?SU1kS3VmMW1QS2RDZk9TQ1dJQnlxMkZaVWdIcEt4a0tXOXloVnZnNlc0bGpy?=
 =?utf-8?B?TEVjbGRDUnk3K3MxcnArNFQ4ejhvUDQ4Q3p6OGorbnRwQTA0UjN0NVArUGgv?=
 =?utf-8?B?RTV1Yll4TEtYbWRubk91K0UvWmhjTXpLcnBGWGJHdjhEZ3FLYWZwSGxESGsw?=
 =?utf-8?B?bWN3M2lPaVVhUk1lSGxlMitCU05SRm1KSTVER0lubFMvbjVLTkNmMjk5UTM0?=
 =?utf-8?B?WXZpRGxIUzNXaXI2NC9menRIcGtMbGEwT1JnVVpsdXg3eWI0VjdWaVBBV3NB?=
 =?utf-8?B?NXo2RlF6Nk0rWEEwRkQ2U3ZRejVKUUY4eGJMSHRZNlRTY25TMGVuOTZ0MXhH?=
 =?utf-8?B?dXRYZnBUTVcyNlhqWGxKTW5mc3JYNlJ4NnBiZGU5WEtweEZGMlh6RGlDakRQ?=
 =?utf-8?B?QjRpREFZMUtOczZ2QzR4YU1ZUVg4cW50S0gva2lDUHdRWGZKSVRFWTNUMEFN?=
 =?utf-8?B?NGR3anUzNWVFKzlMcDI3aU1WWWNsQngrVXY3Wmw4TmEzclNFUnU0QTJ5SzI2?=
 =?utf-8?B?UHNMTUdZNHRISysvYVVtSkxxcEg1V2F6TmtpcVRRQkRGTERkZ3NFNFRjZ2lm?=
 =?utf-8?B?RzFMRGtmZHNwQVp4U2pPQXYxRjNxRTNta2xCOEx0Q2xkR2hmMFI1b1l0RkdK?=
 =?utf-8?B?QU9DTjY1UlpTU25GVkJsa2xuTGZCZWJMSXR6RklwUkRJQmR6ZDdZTll0d3po?=
 =?utf-8?B?OG43THRBZmdHS3Y2b1JUZng1akhnQ0JuVXg3TTNoT0dpSldMVW0rNHdWWWtJ?=
 =?utf-8?B?b1kreXJadUZSdDE0ZmdLVTROWkNYcXMzUWloU3NRY2VPZzlMc0o5UkFLckE4?=
 =?utf-8?B?ZFlWdDFHVzFCZVR4QkNWQ05MNUFZQnFiVVdyWGlCenM5VHY4RmRJcEdCVDBW?=
 =?utf-8?B?dm5wTDZUbmg3WWxwUjJEUXF1WGdPV2J1Umx0UUlHdUtHZXB5cXBTQ3dJSnhB?=
 =?utf-8?B?OUlYN2o0Z0taeVJJOWJrNkhUTThkZkI5bWVncXZtM1hQajVzQ2pHVk9UTzM3?=
 =?utf-8?B?RjFmazlXZTlkcEE0RzZ5ZDdkNW9rVVl2ZzlTcWkxT0t2TXFFRE9FMXhFNXoy?=
 =?utf-8?B?cldHT3JRWjBKMitWZWtBUVE0WGFGSUJxdEZsOENwMi8wVmI0MFNsSzhTRzhv?=
 =?utf-8?B?Y0JRdGcyV2srdUJmU29YYmVEbEF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <342F237F018D0543A2E18034B11C4921@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8234c6-80f2-40cb-26bc-08d99dd8b2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 08:13:48.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dP6vsnMXIQ4Ur5G1nxKsRShdgMKe0rx6t5t4/42YbY4NsBf00vxjvkCLVOSTU5nXlwwIKOef0KJokqxCwxniwLZBicfnlbvNn+c8Nbb3JyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFByYXR5dXNoLA0KDQpPbiAxMC8yOS8yMSA5OjExIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJIGhhdmUgYmVl
biByZXZpZXdpbmcgcGF0Y2hlcyBhbmQgY29udHJpYnV0aW5nIGZvciBvdmVyIGEgeWVhci4gSSB3
b3VsZA0KPiBsaWtlIHRvIGhlbHAgbWFpbnRhaW4gdGhlIHN1YnN5c3RlbSBhcyB3ZWxsLg0KPiAN
Cg0KSSdtIGhhcHB5IHRvIHNlZSB0aGF0IHlvdSdyZSB3aWxsaW5nIHRvIHRha2UgbW9yZSByZXNw
b25zaWJpbGl0aWVzLCBpdCB3b3VsZA0KYmUgbmljZSB0byBoYXZlIHlvdSBvbiBib2FyZC4gSSds
bCB3YWl0IGEgYml0IGJlZm9yZSBhcHBseWluZyB0aGlzIHBhdGNoIHRvDQpnaXZlIHRpbWUgdG8g
dGhlIE1URCBtYWludGFpbmVycyB0byByZXZpZXcgaXQuDQoNClRoYW5rcywNCnRhDQoNCg0KDQo=
