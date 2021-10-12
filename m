Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8868F42A500
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhJLNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:01:43 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:43813 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhJLNBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634043579; x=1665579579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=77TWiCnJ+CllWWe/NuHeiXgG1eWhm21UBDjllXqUeeo=;
  b=vSKPs17olucdfRNBUOkdJeglBKs2xM/y8D6TUEiINUTs18ypK3H+atBn
   hg+B0iQhigyP26ZRCMf8zpmXOaIyHmLNre5YbsFh65yy6yDXKo2+CZoqE
   EyFcABXyywjGkOyrinzxLMB6awQ5xIiv+W0XPw6+xxPrwwu7zMZHCcoOP
   P0RlqyoAtcCUo1tUKQzfHu6Q3wyRpT8tSawzO2YCsY8cJh/Hpwtw72mSm
   HsV3CRDZk8m4k/XRKmgeS4q2SinHeDOZbn/dYiFJO/Fd64O/m5VIYONgM
   v4faI/neiEo2unQSUDNHSm2DHUt/4TCD0i8l/7+/fKOaybAg+S4y0qHBp
   Q==;
IronPort-SDR: 6Bt8LSNED25ZETPT+z04IWeAED/fhu+rnqRi1+gv/WoHWabAuCN53zQjBB3vYmDF5c/YLtlqR2
 SHyLhyZ/is1R9NACVQH6ZWQrYn3L9TshuK9qBxOmxe4IgnXuQU24N0V+xmGCLUa/aS5CHx9/YZ
 9uPa9f6G6MUOpQ8tGFXnZEtpDmD14KR0Bwt3WO7CDvXT5pvRNLZtpgYF91K8WyH/oQEG41pzuT
 4h6gJqr/4E06LIJfOhDfA1J0Xq8E0U54T4DiPMTW75ufI3fPzfr4qJ12G7VctOcc2OThbA5y8V
 fbALB0hOUB4F9AFudVfuB1S8
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="135228679"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2021 05:59:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 12 Oct 2021 05:59:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 12 Oct 2021 05:59:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If0NsFGzOCjPjX//Ll1NsOcjIiIFe12i2SvlDUlHHvwk1sivdTuIe2KQMeXoTh+qPR1ba/yYQa1JcOUip1SXdl7+925RfceMus71HRl45ff6iV7/KvkTy0RjoYZz8eP/afucyAqPApRb2FFnO6PupgV3btlimyCiwYEP52XJVUetqmJagtUNtklFF17E3WnTpnE30RRS7qJaHwA1y6oODr9/zOT1PIRaH2hFxTHBHa0+JVgbYbygeq5Y7fzcNkm5S9zL0lSkdOomCzTXj0YcEkM2mmDudy6zU7z6aFT7E3yRgjhGoCMg2zcfSWbhNgWM6sj1TlCU6CTD/lzpOMADKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77TWiCnJ+CllWWe/NuHeiXgG1eWhm21UBDjllXqUeeo=;
 b=j5rW7keLdUHEMKY7QAwhuZNYq6dGckVU3bWYYewHr0iLniOmGm0YYZQ9tLH9RYjFyjSxguEnYX81DCLBS3rvd0yFKNQpIQrG7RQyN2W7+V1MwmR/KR4GMSivSH0BhLSb2uLSigGQI8g1ePUD07bBcia5WN7+epPel65Y/UlQh9/cK2AxUR9EhzfO0JLzjACcO9OlbcJ6+XYMSWkBJqsC1ESM3F6MuJyPKvbwOuwGnZVYrk1Ecvuo59o9z2x+64BoL8dJNokmMkdeGPV3YHNQu1gdq82J0G2y6No9LSDJInglhNwC+8cIDfaQcgM0INTNdze/LwmnzCn6SSyhBcXhrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77TWiCnJ+CllWWe/NuHeiXgG1eWhm21UBDjllXqUeeo=;
 b=c7dd4n7i7CA93OjHc7jr36DVkSpluzadKpsehVJhk5+c17BAX7q/P1gOjvA22fzqD5DjOEiTzS6jh3gaRocTNLGtmXL9PtIvrhC56qbeWJ/tzOwG4+J/DrKvpnAVl6A1J9MxEzjQvE0FMa1BD7GnBnlhordMwMDYvsTxGhgYngI=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1996.namprd11.prod.outlook.com (2603:10b6:3:13::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.26; Tue, 12 Oct 2021 12:59:33 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::6d76:89d8:307:9fe8]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::6d76:89d8:307:9fe8%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 12:59:32 +0000
From:   <Christian.Gromm@microchip.com>
To:     <gregkh@linuxfoundation.org>, <nikita.yoush@cogentembedded.com>,
        <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
Subject: Re: [PATCH v2 1/2] staging: most: dim2: do not double-register the
 same device
Thread-Topic: [PATCH v2 1/2] staging: most: dim2: do not double-register the
 same device
Thread-Index: AQHXvmbzswGTOwMoxUWM4K+I/yuClKvPVWEA
Date:   Tue, 12 Oct 2021 12:59:32 +0000
Message-ID: <5f6a8019218c1cc083883d5fdf06ef95fff59e8f.camel@microchip.com>
References: <YWKHvvLtb0MSJy2X@kroah.com>
         <20211011061117.21435-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20211011061117.21435-1-nikita.yoush@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe2d4966-7e85-4262-a889-08d98d8022d0
x-ms-traffictypediagnostic: DM5PR11MB1996:
x-microsoft-antispam-prvs: <DM5PR11MB1996D4A2D050C938393D1DAEF8B69@DM5PR11MB1996.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Omg6Ju1ZDmVcLz1pK1w6i1ofX3LmuLR0SBjn0nT38macTbxp16Ozxc4rqKXTkRbPrI1es3UGWw5tDWGHI1hAaMarO78jVo3TbpKlHLEWvYtoO14tN5KMkq7XPlGt8coUf43EiwD133HoUJ9banRbaXSAqB8izEN9KjJmsxjvTVb2OTQqRtyZdxa9bCEwBFsln3kFy673VGdkIzsK+VO5WHqv1YvHYy4d6JAjXnpX/d1fup15PARWMdx3EfL55Q0oaIfVlTlhwv30PbdfUtMmI7zy3HPKrphz53B7IHo1yJYacL15HovDj1HMFtxrScPdXIN+T6i5ZmW9iuC9NjJXo0BE8wkRl6etD4b8qGN9qgUIOZqG6tBiY1OeCjW9s9RJJ1dgRxcAKkebut7NqRkm0XflESmTJEtlqeGfh0GlAl9xNVlt/6i3H3qdMkdraNkHIiqTrNMrhCSdb1cXN+O7i2by2tgjFqucZg9dvgdyIYq2YzQliz58r06hQxo9i4xPLTluJV3nuXddsTlxAWsgDf38QvDsVE+2564+8L2ZCl3QWJd4/syoh9n+iEzDnyiztKAoOQyptzL6JbI6LRxfKjJRYYQ8RA4u6ONtQfyZBa1THpIie/LvGLdmfEMJSuHWYTzurUemIlGMz9Q2Za45eCrAvfu2iisyCyrw4S3L7HytLrQQH3KrLQRAOvpeoXFRMGXE+GZrNJZIM87Rbo0yk+SJfHT0uzh1ganGaCxyDaw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(76116006)(91956017)(66476007)(66446008)(64756008)(66556008)(6506007)(38070700005)(186003)(66946007)(2906002)(26005)(122000001)(508600001)(83380400001)(54906003)(6512007)(110136005)(2616005)(8676002)(71200400001)(86362001)(6486002)(4326008)(36756003)(38100700002)(316002)(4001150100001)(8936002)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFpnRGs2TGJINkg5TWJtR0pFTXl1YWhNZkhrcFNQL012L215TVdvOEFoTVR5?=
 =?utf-8?B?bzdYTDN3SE12M29BSnMwZEQ5bHZURmZVT2RpYXg1WVJraXYzbkRXZ3pjNTM3?=
 =?utf-8?B?aDIyZGVaY0hBZ2YxL1UySVIwbEFLM2Y2SVBVN3BXd0cxTlFFTTVoTWwweDc5?=
 =?utf-8?B?SWIreWJPcXEwS0kwbWlKWmIxUi9LdnZCVC9iZ0pzTHVHME1wcjE1QWhXaWxr?=
 =?utf-8?B?bzdqdmRBdmZzZnhTV1c5SmhaSzMzVDc5dm9GcUppNFlhSDRFVFVSZ0s2eDkx?=
 =?utf-8?B?TnU0WnlLRnA4b201aUU3Y21ROHNvTWx6OTgvd01IOW5iQURLazF1SXlrV2g4?=
 =?utf-8?B?Njk3YUw4SmZrMWRZZGQ3bE04NHNmOHNVQmhQbEVpVi9xL3RjMkF1SFB5em9N?=
 =?utf-8?B?UXl2NVhLL2dka2l3V2xmZS9UdnhnU2pmYUtJcWUwQjc5TFF4QXF5Uk5kMVho?=
 =?utf-8?B?WDA0ZkN0QWNNMkRlVXllaEMyNjJKTU9YemlrZzVoYWdrYUdsM1BaTnF0VnRs?=
 =?utf-8?B?c3NXWWRIRHdnKzdzbWE3WmNJUlRTWnVySUI0dUxtcG9mci84emdjR2dQSDgv?=
 =?utf-8?B?VjFYbVRtY1ppSVVvYUhEMmpiK3I3YXBzQ21rbzNucWlNWFFaOFhEcFZhRjV2?=
 =?utf-8?B?U3ppZFRTWFg4RVBNVE1idklHNm93eFhWZHNSR3hMVVExSjN0MG1yV3ZqdXVr?=
 =?utf-8?B?RFJIWVNiN2tiTmU2b0FUeFZ1aHNwcE9OSnlDNzNLWDdnTjk1QnNXb1ZQa1RN?=
 =?utf-8?B?ZlQvUlRUbnpNMTZMK3NBR1E5Qk15VjhsTlBqZ2xvV2dIdUp5WHYxMHFFb3lM?=
 =?utf-8?B?SjlrMFRjeW9XQXlrZXlDWGQ5ZC9mSy9HMmpxUWFFdlY3djFyVEREb1hjbkl6?=
 =?utf-8?B?bms1emZ1SmphdE8yczJYSHJwcW1ES0hqU1ZhUFBGMGYxdm9mcGZ5ajJuOFIy?=
 =?utf-8?B?bDc2NWNUZjR5RGs4ZkNMc1dPbDVhQnh1dTg3MDhnbGdRbTJKRzdWcmltZ3BB?=
 =?utf-8?B?cVIvSzZDSlJGdi8zdjkveE40Y3JONmFLZUJVbTY3b3Aya2xrMGp5SldtYWZm?=
 =?utf-8?B?ekpSVnZKMk5EVFpld1NidzlITCtTdTB4WGRTZTF2SFJBK09HaG1PT0NaUzR6?=
 =?utf-8?B?S0lteDhCUm81QUtwWUFhOWIyNXlia3dCWjMzejZtMlJDNGpGdXNoYWp2WmVo?=
 =?utf-8?B?M0FVRk9FOUJjTVV4cnA0NURMSkJkb3phaE0rUzFTb29Od2xPRDdKeXV5Kzlw?=
 =?utf-8?B?T3BsK2JGVVpEUStOd0hYU3Bqdm5ZZkRMalNYWW40YWgyek5JNU1idkVkdzZs?=
 =?utf-8?B?dzVCOVVQQlQvQWkxbFlUZDNjdTg5bkR6RkR2Y0ZjVGs1RGtCQVhIM0V6blds?=
 =?utf-8?B?ZkxHNmFmbC80N3B1ODhGTWhNYUNuZUZIY2hKZHJwTXIwMlNQdld0THN5aUwr?=
 =?utf-8?B?OFJGdTN6aDJYZGFqbE52dGVTbllkZ3NWd2dZWXNqQWRpWTFzWEFhK2hUWWk1?=
 =?utf-8?B?L2RJcFdYU3IvNnAzTFdRblgxRFN0Tm4zeE5sZHUvUmFtUWZkOVhMWDdFS3Mx?=
 =?utf-8?B?a1cxRDNuYUVaZjBwOHZRZVlya2tudzJQRUNoVFdiS3dNRmZONm1Ya21IR1J5?=
 =?utf-8?B?M3h5R1B2RXgzNW5zeXVwTU93U21GWVovWmFGeC85K3VPYnZhUkVBSFhCTm1X?=
 =?utf-8?B?ekd0dUttQTNyOWZRZjFBZytxRTY4OGlMTVNkU28xakVZSGZmZFpvSnYvdmdK?=
 =?utf-8?Q?zy6VcANFUqWhbZ5ouB1tI/T8f6t04pj7fSuc2xr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EFDA4C3DF8FA44D8372AD3EB6FA42E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2d4966-7e85-4262-a889-08d98d8022d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 12:59:32.7317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvkEG8WxcUnLFf+tJxAi9Do4cAplPdC1Miq/FdMzSY5J4R8Du4PoZC46SzQvaCt0eRbyxrIVMPhPaRaFm4YmYlPKt6T4zIiAycTaV3Xp5x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1996
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTEwLTExIGF0IDA5OjExICswMzAwLCBOaWtpdGEgWXVzaGNoZW5rbyB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBDb21taXQg
NzIzZGUwZjkxNzFlICgic3RhZ2luZzogbW9zdDogcmVtb3ZlIGRldmljZSBmcm9tIGludGVyZmFj
ZQ0KPiBzdHJ1Y3R1cmUiKSBtb3ZlZCByZWdpc3RyYXRpb24gb2YgZHJpdmVyLXByb3ZpZGVkIHN0
cnVjdCBkZXZpY2UgdG8NCj4gdGhlIG1vc3Qgc3Vic3lzdGVtLg0KPiANCj4gRGltMiB1c2VkIHRv
IHJlZ2lzdGVyIHRoZSBzYW1lIHN0cnVjdCBkZXZpY2UgdG8gcHJvdmlkZSBhIGN1c3RvbQ0KPiBk
ZXZpY2UNCj4gYXR0cmlidXRlLiBUaGlzIGNhdXNlcyBkb3VibGUtcmVnaXN0cmF0aW9uIG9mIHRo
ZSBzYW1lIHN0cnVjdCBkZXZpY2UuDQo+IA0KPiBGaXggdGhhdCBieSBtb3ZpbmcgdGhlIGN1c3Rv
bSBhdHRyaWJ1dGUgdG8gZHJpdmVyJ3MgZGV2X2dyb3Vwcy4NCj4gVGhpcyBtb3ZlcyBhdHRyaWJ1
dGUgdG8gdGhlIHBsYXRmb3JtX2RldmljZSBvYmplY3QsIHdoaWNoIGlzIGEgYmV0dGVyDQo+IGxv
Y2F0aW9uIGZvciBwbGF0Zm9ybS1zcGVjaWZpYyBhdHRyaWJ1dGVzIGFueXdheS4NCj4gDQo+IEZp
eGVzOiA3MjNkZTBmOTE3MWUgKCJzdGFnaW5nOiBtb3N0OiByZW1vdmUgZGV2aWNlIGZyb20gaW50
ZXJmYWNlDQo+IHN0cnVjdHVyZSIpDQo+IFNpZ25lZC1vZmYtYnk6IE5pa2l0YSBZdXNoY2hlbmtv
IDxuaWtpdGEueW91c2hAY29nZW50ZW1iZWRkZWQuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBmcm9t
IHYxOg0KPiAtIHVzZSBBVFRSSUJVVEVfR1JPVVBTKCkNCj4gLSB1c2Ugc3lzZnNfZW1pdCgpDQo+
IA0KPiAgZHJpdmVycy9zdGFnaW5nL21vc3QvZGltMi9NYWtlZmlsZSB8ICAyICstDQo+ICBkcml2
ZXJzL3N0YWdpbmcvbW9zdC9kaW0yL2RpbTIuYyAgIHwgMjQgKysrKysrKystLS0tLS0tDQo+ICBk
cml2ZXJzL3N0YWdpbmcvbW9zdC9kaW0yL3N5c2ZzLmMgIHwgNDkgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAtLQ0KPiAgZHJpdmVycy9zdGFnaW5nL21vc3QvZGltMi9zeXNmcy5oICB8
IDExIC0tLS0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNzIgZGVs
ZXRpb25zKC0pDQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL21vc3QvZGlt
Mi9zeXNmcy5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL21vc3QvZGltMi9N
YWtlZmlsZQ0KPiBiL2RyaXZlcnMvc3RhZ2luZy9tb3N0L2RpbTIvTWFrZWZpbGUNCj4gaW5kZXgg
ODYxYWRhY2Y2YzcyLi41Zjk2MTJhZjNmYTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2lu
Zy9tb3N0L2RpbTIvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL21vc3QvZGltMi9N
YWtlZmlsZQ0KPiBAQCAtMSw0ICsxLDQgQEANCj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjANCj4gIG9iai0kKENPTkZJR19NT1NUX0RJTTIpICs9IG1vc3RfZGltMi5vDQo+IA0K
PiAtbW9zdF9kaW0yLW9ianMgOj0gZGltMi5vIGhhbC5vIHN5c2ZzLm8NCj4gK21vc3RfZGltMi1v
YmpzIDo9IGRpbTIubyBoYWwubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL21vc3Qv
ZGltMi9kaW0yLmMNCj4gYi9kcml2ZXJzL3N0YWdpbmcvbW9zdC9kaW0yL2RpbTIuYw0KPiBpbmRl
eCBlOGIwM2ZhOTBlODAuLjk2Y2I1MjgwYTM4NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFn
aW5nL21vc3QvZGltMi9kaW0yLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL21vc3QvZGltMi9k
aW0yLmMNCj4gQEAgLTExOCw3ICsxMTgsOCBAQCBzdHJ1Y3QgZGltMl9wbGF0Zm9ybV9kYXRhIHsN
Cj4gICAgICAgICAoKChwKVsxXSA9PSAweDE4KSAmJiAoKHApWzJdID09IDB4MDUpICYmICgocClb
M10gPT0gMHgwQykgJiYNCj4gXA0KPiAgICAgICAgICAoKHApWzEzXSA9PSAweDNDKSAmJiAoKHAp
WzE0XSA9PSAweDAwKSAmJiAoKHApWzE1XSA9PSAweDBBKSkNCj4gDQo+IC1ib29sIGRpbTJfc3lz
ZnNfZ2V0X3N0YXRlX2NiKHZvaWQpDQo+ICtzdGF0aWMgc3NpemVfdCBzdGF0ZV9zaG93KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0DQo+IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgY2hhciAqYnVmKQ0KPiAgew0KPiAgICAgICAgIGJvb2wgc3Rh
dGU7DQo+ICAgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gQEAgLTEyNyw5ICsxMjgsMTgg
QEAgYm9vbCBkaW0yX3N5c2ZzX2dldF9zdGF0ZV9jYih2b2lkKQ0KPiAgICAgICAgIHN0YXRlID0g
ZGltX2dldF9sb2NrX3N0YXRlKCk7DQo+ICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
ZGltX2xvY2ssIGZsYWdzKTsNCj4gDQo+IC0gICAgICAgcmV0dXJuIHN0YXRlOw0KPiArICAgICAg
IHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4iLCBzdGF0ZSA/ICJsb2NrZWQiIDogIiIpOw0K
PiAgfQ0KPiANCj4gK3N0YXRpYyBERVZJQ0VfQVRUUl9STyhzdGF0ZSk7DQo+ICsNCj4gK3N0YXRp
YyBzdHJ1Y3QgYXR0cmlidXRlICpkaW0yX2F0dHJzW10gPSB7DQo+ICsgICAgICAgJmRldl9hdHRy
X3N0YXRlLmF0dHIsDQo+ICsgICAgICAgTlVMTCwNCj4gK307DQo+ICsNCj4gK0FUVFJJQlVURV9H
Uk9VUFMoZGltMik7DQo+ICsNCj4gIC8qKg0KPiAgICogZGltY2Jfb25fZXJyb3IgLSBjYWxsYmFj
ayBmcm9tIEhBTCB0byByZXBvcnQgbWlzY29tbXVuaWNhdGlvbg0KPiBiZXR3ZWVuDQo+ICAgKiBI
RE0gYW5kIEhBTA0KPiBAQCAtODc0LDE2ICs4ODQsOCBAQCBzdGF0aWMgaW50IGRpbTJfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX3N0b3BfdGhyZWFkOw0KPiAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgcmV0ID0gZGltMl9z
eXNmc19wcm9iZSgmZGV2LT5kZXYpOw0KPiAtICAgICAgIGlmIChyZXQpIHsNCj4gLSAgICAgICAg
ICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBjcmVhdGUgc3lzZnMNCj4gYXR0
cmlidXRlXG4iKTsNCj4gLSAgICAgICAgICAgICAgIGdvdG8gZXJyX3VucmVnX2lmYWNlOw0KPiAt
ICAgICAgIH0NCj4gLQ0KPiAgICAgICAgIHJldHVybiAwOw0KPiANCj4gLWVycl91bnJlZ19pZmFj
ZToNCj4gLSAgICAgICBtb3N0X2RlcmVnaXN0ZXJfaW50ZXJmYWNlKCZkZXYtPm1vc3RfaWZhY2Up
Ow0KPiAgZXJyX3N0b3BfdGhyZWFkOg0KPiAgICAgICAgIGt0aHJlYWRfc3RvcChkZXYtPm5ldGlu
Zm9fdGFzayk7DQo+ICBlcnJfc2h1dGRvd25fZGltOg0KPiBAQCAtOTA2LDcgKzkwOCw2IEBAIHN0
YXRpYyBpbnQgZGltMl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4g
ICAgICAgICBzdHJ1Y3QgZGltMl9oZG0gKmRldiA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYp
Ow0KPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IA0KPiAtICAgICAgIGRpbTJfc3lz
ZnNfZGVzdHJveSgmZGV2LT5kZXYpOw0KPiAgICAgICAgIG1vc3RfZGVyZWdpc3Rlcl9pbnRlcmZh
Y2UoJmRldi0+bW9zdF9pZmFjZSk7DQo+ICAgICAgICAga3RocmVhZF9zdG9wKGRldi0+bmV0aW5m
b190YXNrKTsNCj4gDQo+IEBAIC0xMTAwLDYgKzExMDEsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RyaXZlciBkaW0yX2RyaXZlciA9IHsNCj4gICAgICAgICAuZHJpdmVyID0gew0KPiAgICAg
ICAgICAgICAgICAgLm5hbWUgPSAiaGRtX2RpbTIiLA0KPiAgICAgICAgICAgICAgICAgLm9mX21h
dGNoX3RhYmxlID0gZGltMl9vZl9tYXRjaCwNCj4gKyAgICAgICAgICAgICAgIC5kZXZfZ3JvdXBz
ID0gZGltMl9ncm91cHMsDQo+ICAgICAgICAgfSwNCj4gIH07DQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zdGFnaW5nL21vc3QvZGltMi9zeXNmcy5jDQo+IGIvZHJpdmVycy9zdGFnaW5nL21v
c3QvZGltMi9zeXNmcy5jDQo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCBjODVi
MmNkY2RjYTMuLjAwMDAwMDAwMDAwMA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvbW9zdC9kaW0y
L3N5c2ZzLmMNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSw0OSArMCwwIEBADQo+IC0vLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiAtLyoNCj4gLSAqIHN5c2ZzLmMgLSBNZWRp
YUxCIHN5c2ZzIGluZm9ybWF0aW9uDQo+IC0gKg0KPiAtICogQ29weXJpZ2h0IChDKSAyMDE1LCBN
aWNyb2NoaXAgVGVjaG5vbG9neSBHZXJtYW55IElJIEdtYkggJiBDby4gS0cNCj4gLSAqLw0KPiAt
DQo+IC0vKiBBdXRob3I6IEFuZHJleSBTaHZldHNvdiA8YW5kcmV5LnNodmV0c292QGsybC5kZT4g
Ki8NCj4gLQ0KPiAtI2RlZmluZSBwcl9mbXQoZm10KSBLQlVJTERfTU9ETkFNRSAiOiAiIGZtdA0K
PiAtDQo+IC0jaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+IC0jaW5jbHVkZSAic3lzZnMuaCIN
Cj4gLSNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gLQ0KPiAtc3RhdGljIHNzaXplX3Qgc3Rh
dGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0KPiBkZXZpY2VfYXR0cmlidXRlICph
dHRyLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKmJ1ZikNCj4gLXsNCj4gLSAg
ICAgICBib29sIHN0YXRlID0gZGltMl9zeXNmc19nZXRfc3RhdGVfY2IoKTsNCj4gLQ0KPiAtICAg
ICAgIHJldHVybiBzcHJpbnRmKGJ1ZiwgIiVzXG4iLCBzdGF0ZSA/ICJsb2NrZWQiIDogIiIpOw0K
PiAtfQ0KPiAtDQo+IC1zdGF0aWMgREVWSUNFX0FUVFJfUk8oc3RhdGUpOw0KPiAtDQo+IC1zdGF0
aWMgc3RydWN0IGF0dHJpYnV0ZSAqZGV2X2F0dHJzW10gPSB7DQo+IC0gICAgICAgJmRldl9hdHRy
X3N0YXRlLmF0dHIsDQo+IC0gICAgICAgTlVMTCwNCj4gLX07DQo+IC0NCj4gLXN0YXRpYyBzdHJ1
Y3QgYXR0cmlidXRlX2dyb3VwIGRldl9hdHRyX2dyb3VwID0gew0KPiAtICAgICAgIC5hdHRycyA9
IGRldl9hdHRycywNCj4gLX07DQo+IC0NCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRl
X2dyb3VwICpkZXZfYXR0cl9ncm91cHNbXSA9IHsNCj4gLSAgICAgICAmZGV2X2F0dHJfZ3JvdXAs
DQo+IC0gICAgICAgTlVMTCwNCj4gLX07DQo+IC0NCj4gLWludCBkaW0yX3N5c2ZzX3Byb2JlKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gLXsNCj4gLSAgICAgICBkZXYtPmdyb3VwcyA9IGRldl9hdHRy
X2dyb3VwczsNCj4gLSAgICAgICByZXR1cm4gZGV2aWNlX3JlZ2lzdGVyKGRldik7DQo+IC19DQo+
IC0NCj4gLXZvaWQgZGltMl9zeXNmc19kZXN0cm95KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gLXsN
Cj4gLSAgICAgICBkZXZpY2VfdW5yZWdpc3RlcihkZXYpOw0KPiAtfQ0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zdGFnaW5nL21vc3QvZGltMi9zeXNmcy5oDQo+IGIvZHJpdmVycy9zdGFnaW5nL21v
c3QvZGltMi9zeXNmcy5oDQo+IGluZGV4IDI0Mjc3YTE3Y2ZmMy4uMDkxMTVjZjRlZDAwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvbW9zdC9kaW0yL3N5c2ZzLmgNCj4gKysrIGIvZHJp
dmVycy9zdGFnaW5nL21vc3QvZGltMi9zeXNmcy5oDQo+IEBAIC0xNiwxNSArMTYsNCBAQCBzdHJ1
Y3QgbWVkaWFsYl9idXMgew0KPiAgICAgICAgIHN0cnVjdCBrb2JqZWN0IGtvYmpfZ3JvdXA7DQo+
ICB9Ow0KPiANCj4gLXN0cnVjdCBkZXZpY2U7DQo+IC0NCj4gLWludCBkaW0yX3N5c2ZzX3Byb2Jl
KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+IC12b2lkIGRpbTJfc3lzZnNfZGVzdHJveShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpOw0KPiAtDQo+IC0vKg0KPiAtICogY2FsbGJhY2ssDQo+IC0gKiBtdXN0IGRl
bGl2ZXIgTWVkaWFMQiBzdGF0ZSBhcyB0cnVlIGlmIGxvY2tlZCBvciBmYWxzZSBpZiB1bmxvY2tl
ZA0KPiAtICovDQo+IC1ib29sIGRpbTJfc3lzZnNfZ2V0X3N0YXRlX2NiKHZvaWQpOw0KPiAtDQo+
ICAjZW5kaWYgLyogRElNMl9TWVNGU19IICovDQo+IC0tDQo+IDIuMzAuMg0KPiANCj4gDQo+IA0K
DQpBY2tlZC1ieTogQ2hyaXN0aWFuIEdyb21tIDxjaHJpc3RpYW4uZ3JvbW1AbWljcm9jaGlwLmNv
bT4gDQoNCnRoYW5rcywNCkNocmlzDQo=
