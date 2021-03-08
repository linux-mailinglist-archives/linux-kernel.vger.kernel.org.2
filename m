Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E713306FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 05:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhCHEyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 23:54:17 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:8493 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhCHExo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 23:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615179224; x=1646715224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fy82VTg1b9UgSHROYy3MNBU5Ey//eRNqWzTMT+AmKKo=;
  b=BeyDi3Y0ObiZ3vxCunTP2vvxiWaAJKNfeJi5c238MnWHvCwbkK921xqr
   qq+0GU0CPDwUzi6D+DBElpLi5bFftkXbrJAUPmY1N7rHUehTkZJahdeJ5
   qFyvRq6faJBHi0NZegbBSL5DToQ+YWloZ7qcFqMttymC+oj8DFZimnl2j
   sePdmNOJPrHuQR4iXAtl7kFoP31PmU3dCzkFdYGbTos5r3uKzxVcIR0PH
   k+nhhqssFeqFZHnbSJoAeNzNoUHkwLoo31DEIc94uLp2FsMipH1eoBPxv
   aUr3CnMwrblwY84tC19Un6IpFDjKCX9zT0y97UmyOyOfl8NIqHSYlNlJX
   g==;
IronPort-SDR: QYKw6EQwJnD2tfmCqkg1U6+n6En/Qty2Waby9MZIldsuxCdWfE9J0Ll6myz9RjzNj6FGqhBTW+
 W766JFIsA9oML8W8WjMfx1zbwn9eRr8m2v9u98wZWo9rxpl42zB3BFFP2xT3CK7n0+E/7jAib/
 9wFBVLaQQuu8X29pQj7211RyIhN/ZH51+o8O1lSrtDekKCjd+RbYsiaT0NVXPtyN/iluP9eG/X
 cEVHCcIMH3/ix3+uhTteRgDUJSrBntwtZimJFyK0Nw6jXl0UlOTN5uegKSg0SVCsQu6Urjyjpz
 ZF4=
X-IronPort-AV: E=Sophos;i="5.81,231,1610434800"; 
   d="scan'208";a="109100072"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2021 21:53:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 7 Mar 2021 21:53:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Sun, 7 Mar 2021 21:53:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbSG3SYf7FMqzYU1Cz4K6CHnMRL0Ub+H6f9Zlu+RssHgAZNKGx9ikGsFpSEVau1EuuXX7Lgt6lXKzkdgxU6B7Uv5XbANj0nujLPSUpWII2DwE+fQ8ZWWtY3uwOpDwnNMpQWL/PGrFEFVoXcS+zJiDA32FXjhnIxdFWMMO+KJUv8cRfpkIycjsBrqazYIW8sZb1aekSEdYUnqDKv41zRQNgVWa8/kx3IOIir0WZ4J6JfrclqDDLkbcCKy0M9m+xe4deCDVGBEkiFNs9hRCiqiJcyOnTN6p3GGidcBPS2aS6KPsgl40Ev0ceIpahAj4Xq+8imn8ZhRsgEA7lbT7nHNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy82VTg1b9UgSHROYy3MNBU5Ey//eRNqWzTMT+AmKKo=;
 b=JHniblLEqnKHBOxc/AFN4InhvbR/sEeEgzfR5N7s32hs706qV2QXczNmFNQ8DyWiEb0XKZNNlt4lKBr1rszmbucXSG69Y08lI66u6XQnco/LFoyJKHYuT2bZF/qSyawZJoy7G9He4UUjA8MWLAogMuJlkn7gswb3R1Jsa00Ny50HSMSCRrkwcoM3yJIOrB98O43fnnJPhetqOKW15caOXSXstnN4o6oE668oQOzCV+YpdBKfxNKCRUqvHnWiVCecgD4wAGJXI55JYoSvVakyP+OzTl+WbWjfd+tH+2Idxnq+QYuXsMrQY63u4n69W2eqzQHlC5JeiBAyxkNPeexRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy82VTg1b9UgSHROYy3MNBU5Ey//eRNqWzTMT+AmKKo=;
 b=QchAuIaabm/H/I1Ykm6GTT6cISHOCDqWfltheqOj0pZlgyZVsuZGdUIkrxXogOhs8LsjnwzU+ht7r1j8RCYX0elerW2XycC0qI6xKhaJ8P1RlNBz500WrwEJwM3mhRc+pS0aU/uu105YeuI4xM35quPOlUVX45cT5sXYyfUrZgw=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 04:53:42 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f%7]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 04:53:42 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mbriand@witekio.com>, <p.yadav@ti.com>
CC:     <vigneshr@ti.com>, <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: sfdp: Fix out of bound array access
Thread-Topic: [PATCH] mtd: spi-nor: sfdp: Fix out of bound array access
Thread-Index: AQHXE9cCL0q2/sedikm1K07/izxd/w==
Date:   Mon, 8 Mar 2021 04:53:42 +0000
Message-ID: <5585fd98-3aa3-e95c-e3c1-d3e434deed73@microchip.com>
References: <20210212154717.362233-1-mbriand@witekio.com>
 <20210215151414.6542yhluvx3yvbia@ti.com>
 <20210219075056.GB3519372@WIPC17090108>
In-Reply-To: <20210219075056.GB3519372@WIPC17090108>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: witekio.com; dkim=none (message not signed)
 header.d=none;witekio.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 882faa0d-fd28-4187-360a-08d8e1ee25a8
x-ms-traffictypediagnostic: SA0PR11MB4655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB46551BE2BAF7C92481C84428F0939@SA0PR11MB4655.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:171;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Um7lw3Vb1m+vJlPdj4Smn+V52rpEQp05MMOxeTbS8sGgac0Bz49hpdoLldWhAyOU+n/3GAx26Tzy8H8HCB3R3eqpnGLidFQ26qzbBxXwK0nch8AKl9NwNU30Vxvt1uAqGwwtLGmnZjhPEoJWWtDq9su1OjS/0FTDrJXBk5KR/3AJd+qhQU+Lht3UE4GuSMQEJdAZUnWikK9D+cLVK7GzITEpcK6q7avl1oMILHmsjncgXJPh7zS1jj5V9wP3WxkydYGvIbmq+qfR3Pw7iZU35WhbE/nHHcRTZTxMge2LE7oH4xQfQFIb94eXvgv1UJld7zVnBzWpdO7brQnX+aMRoF6k8FyWadKnXPFGZsTCMmX1b21Mdg3hL5L1f5ritjjJL+pFz9YMuQa4k9zNCZE3lAGpcuVDtqy10ufGanMm5p+WBfdidQoAbSVv8E9woKL0EpVZHREMaV5wGX8CnIwi8sVAmTqc5Tk6DkUl6nAnFEhOm4QaDejQp/h74QniyFIf2EVtTZYToPWEdtDYS64p1L9+AHaYLMGbTBmPmeBEaE+DrgdIPOZDxSBIVDEDihVn4Tp8eSAl50JNnsFXfRCg+RioFfdchYNuC6xJXcIBg3feEV3RYjG/GzpuqVuNKqMG96mXyvkhn5LBnBowqLdnmT40tdgOv7082n9LGJ0rab+HOgWVWmJR+cySm1pMhGim
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(36756003)(26005)(6512007)(316002)(186003)(31686004)(66446008)(2616005)(31696002)(6486002)(86362001)(4326008)(2906002)(5660300002)(4744005)(66476007)(66946007)(66556008)(478600001)(71200400001)(91956017)(53546011)(76116006)(6506007)(8936002)(54906003)(8676002)(64756008)(110136005)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QnhYZmQ4RXlWNTljN0c4Q3dlaFF4bFFRSHdoMUNnQXYyb1hmN0hST1FCd28z?=
 =?utf-8?B?WFpnTTJDZ2k1bmpubUcveFh3TWVBMWo3cXVBaXNUNXRNcW8vcmNMa2ZRdSt5?=
 =?utf-8?B?bFRLYzhuS1dna1FuaUV2b1RtaGtJNVRFT0dEbG1kUm1XWktOS0Y4QlQrZjFS?=
 =?utf-8?B?Q294Qlk0eGNGWWR1RGY5Mnp3VmUxMkI1dlI3cEVZdWszcXlyUEp1MDRnT2dC?=
 =?utf-8?B?Vk5lUXZRL0F6SzZWSVg1ZEl4dFJYSE8xZmZvZkZMN1FpRjVaYUlhd1FBUmNM?=
 =?utf-8?B?M1kxVk9iK1JPZTR4SGM2OUhYeFFUMWtuTGZmc1RsVExUTmcxWndDRjdKdVNB?=
 =?utf-8?B?YnN0V2R4SnkzemQ5Snh2MkhPNVBTUUNUejdWbkxadEZoNW81WUN0emRmZG1t?=
 =?utf-8?B?WnBUclBYZ3VtOU9nVzZxaHRMSGVRTE1tVU01UllpN0tTQ2VUWjhGdkpKMDg1?=
 =?utf-8?B?YVNKc2IvMWpFa3locFU3T1JISTB1TFFFSFBSY0NLQ2Q0a3dIZlBXaFB0MjFJ?=
 =?utf-8?B?K0JVRHBKbTBaeFNFb3NhMWpCTGNWUlk0SE9PYndYM1kvM1JzUmJtaGJuY0F1?=
 =?utf-8?B?ZjU4V21pSjZMN2NKZGs3bHVRZGFrT0YyK3VFSmFleEt4NGI0dWZEaElEQlJx?=
 =?utf-8?B?eXJSZDRMa0lVVE9Qa1lGRkx3RitSam51emlLMkF5ejVHV05xQ0p6cC9jY1Fa?=
 =?utf-8?B?VytscG1KRUh5VGlyY2pHZGJZeXcvQ2FpWGZjS0tWRldGYityVFNFTnJVNWZY?=
 =?utf-8?B?NmgvcGNzWGhNaFFiay9ZS3Z0SlQ4cHAzTW84UTRqb0Q4NkZyV0NnODJrV3BC?=
 =?utf-8?B?dndqeXd5d1k2UFNXaHVySlJvMGl6WHNvaWhuSXcwVW1rWmFkaHA2UWJ4aHh3?=
 =?utf-8?B?Z0oybEd4NlVheWdPOUhSaHlPelZIT0hYUUNxd0hzV1FQRCsyZUZCM2NkTzB1?=
 =?utf-8?B?d1ZDNTdNMjRWSEZ2dG9Wb3UzRFVTTWc5K1BYOXhrY05NTHF3R2FFeXFaYkk5?=
 =?utf-8?B?cUJuSDlQZlNtWms1ZDBXc3RYY3lQbDY4a0s5dFVicVNBd1F0UFZnTVZlU3kv?=
 =?utf-8?B?RFI2TTJ0bGZvT3dYenAvR0RPVjhUQW9DbFl6cCt1bGtTaUVZUTcwQkNVaDhs?=
 =?utf-8?B?K29YVExmYnl5MHczaGN2NjFSV0JIZmpQd0NwUFRLcHB3UVdVUnpyak80ckNp?=
 =?utf-8?B?eTRpSmxlWVhLSXRKR1ZkR0xYUkJDSHY3WWplN1ZGMHBXU1kvb0hJS0lGR3Jz?=
 =?utf-8?B?Y0F5Vmd4NDB3WlkvUDFtWDlubVVrdEEwd3U1UzBVS0pGZStoSjVkbnJJYzRo?=
 =?utf-8?B?d1pBcDFTdWh0a01WM3MyazMrcktyR1hEbW92OFBTaXZ6N0MvV21pQkFqempT?=
 =?utf-8?B?Y2ZRaEdSVlZqcS9tNVNZVGNKUmZFQi9ZQ01KN1lsK0UrQ0UvWWV4TXIrQzZn?=
 =?utf-8?B?aHUwTy9ISWZNVDgwaDIxMWk0U2h0UjJVazNhSi9qUE5GTU9XSDZyOHhaRVo2?=
 =?utf-8?B?L3JSeVRzREVScnN0TzltdHdzZFpabnh6Qkk4NDVHeDJ3RzBDK0FCSk9mWVJm?=
 =?utf-8?B?dkxBSytNUWJRc2kzYTlQcmVRRDVUUkMwbDA2R1lkbzdwbytQQmhoeHcySHBJ?=
 =?utf-8?B?dmdLWEVKNXU5WWhaYWJtZDdLUUJ4ZjU4ajJ3NmQ1dXZXOXlIc3drTkVQZXM4?=
 =?utf-8?B?V1FmUmtNN0NuanVmZ3ZCbktPRmMvbDJ5TzN2TUxMT1JDWVJGM1ViZmFJVXJT?=
 =?utf-8?Q?Q4pPrnhUJ/QYULab2g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <939F80B1CECAD04CB74DA863B1994CDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882faa0d-fd28-4187-360a-08d8e1ee25a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 04:53:42.2126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUpdte6GwPUxAYlz4PAzerUgNK+cOEsOpu++eloKJszEP2epAJ3LLt6VWCjkHcA5IopR5ab6suyi5GAyytMW2hA3fWhsUzD9H7YfZL+kqq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xOS8yMSA5OjUwIEFNLCBNYXRoaWV1IER1Ym9pcy1CcmlhbmQgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksDQo+IA0KPiBJIGp1c3QgY2Ft
ZSBhY3Jvc3MgdGhpcyBjb21taXQgKDkxNjZmNGFmMzJkYikgaW4gc3BpLW5vci9mb3ItNS4xMjoN
Cj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXRkL2xp
bnV4LmdpdC9jb21taXQvP2g9c3BpLW5vci9mb3ItNS4xMiZpZD05MTY2ZjRhZjMyZGI3NGUxNTQ0
YTIxNDlhZWYyMzFmZjI0NTE1ZWEzLg0KPiANCj4gU28gSSBiZWxpZXZlIHRoaXMgcGF0Y2ggaXNu
J3QgbmVlZGVkIGFueW1vcmUuDQo+IA0KDQpUaGF0J3MgdHJ1ZS4gVGhhbmtzLA0KdGENCg==
