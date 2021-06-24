Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3E3B2802
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFXG4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 02:56:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:48827 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFXG4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624517655; x=1656053655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I07BNf/KnA0z7bmGwH8QMW1QDa+GEPZBEZ513y7xfBU=;
  b=li8XAD38hrpydro5IvrHmH13/hZIfM2dIWyzSqDozjSL2Zsbnf1sGePS
   RqqFP2Iz+IvCkCIIrOARoDYnJ6myw5GfPD/nFghhBsWjznZm1dQYpPwIF
   wfViDtfSVexe+GKG6ZwbYWHJ0VpMVvfrfV538sY5ezk+DrQATCv1Gowve
   HX/ThrXL49vMZgRefcGS6LrGT/lA27tIjYNWMLs1UHbCjlN6sWB1Dh51A
   oDQbhtHWiFU9mXZGYmL8/4/y/vHlgliFMy54P0p2UC6k9uvl5aIunL2WE
   KDddVhy+O1vlpUQRGkvlPYuELciu8/pF5DVX+J4q7LuBjM2XjLdVtSI5t
   A==;
IronPort-SDR: ktV/bzNIMv8L0VcYgWfZw4FIBNH7Y/d1VMRFIWPdvUQ5TvPRk5ViYO5Vl8fmdjVfxHjgh1/nfh
 zKOvTwZVY40ybVPTvBm78xy9OTLF9Eg16ey7W1aC+ZPH9J+sK44pKPvbsuKHk6xR4cXZLEAAef
 iUXrVrnMn21MmMEc5ziFG5SpdkOKuzc3xn3jBu/Z8XUY1LYLf1/U56VAVAwgfKBcaTkzmI2JNc
 LFoCNpS++YaBLcXQVXKrtAbadlMFk8ifsVb2N1dZEY0fpSPX1JdQEz6ftcOO7ut9FQU7Eq8D0h
 zn4=
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="125889817"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2021 23:54:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 23:54:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 23 Jun 2021 23:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUXfQTb8Yr0VxOYuILHKu3m4CiE33ioED85SyrGQAv8Tts0yxguIr1SxA3godzEl27g43cDVyZQu6nUI8wxxqJGAzA514ZrBM59LYZ/iu+ABYx44pIE5KkrqgycG/qjwjxPYnCVChoiqmTdANBgvvqEgP0e37AazgVVSiutVOCt7Vgs3E5svJbcCyRi0+TGw2es+btiQZ//r/r3IxBg1s6n4glHJcIQz3D+macIG2GSFq0xKwmTU28CsPMWPnP3kVL95iCsG+3Nnc9h0OJs1xVr/f0T7fl8vJGuYaRsQXUUX8aUMTo1j5bRtA1Lmi0J2NaA7qJhEY65lF6MAfp+aFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I07BNf/KnA0z7bmGwH8QMW1QDa+GEPZBEZ513y7xfBU=;
 b=Jsuqyr4j07GUE9gKbhwzaB6QyffiiA51t/5G67DsMfUDDPokQ8IzKiXJk3/2BdAp4B0fpIvw1i18+kSj6EBGW73gBubCPoPTkiQejd3WZs/Vrt4DE+ANJi4v+PiIXLkZ58bO/pZWVmnWwNpxVN77YN7LJXEOGqUgY55HalPH6R3wppUVPhIMJM5tqwn7DBXomuyPSvQA4D87Y7KToUrWza3XdrzDq++TP8aqIo3ybaYX2zfRVeppQ42fHyh4JORQcCZVGeklVoz88HetyQAczNA9EN3Pu0oiINWRuro/l7afOE4rLvf+N6ffzmdR52jp2vuTAP/eZ18dYSMDxXeq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I07BNf/KnA0z7bmGwH8QMW1QDa+GEPZBEZ513y7xfBU=;
 b=Q4YMen8LjnhSutIRTWta2R7DFC53Wq/C4qaMGLTNIYV7Ej2WaOXDtNbUFNv8p7sRJtr6z4FDB9MZ5uupi1X/0CP0Jhs0jG48Y8MGzudFsl5LkrxU+ZQePzACuuc8l4RZgKl/cYqExO6HfDIeh3DQm1qvre104xPMJrgPdsvxSAQ=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB0028.namprd11.prod.outlook.com (2603:10b6:4:67::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.23; Thu, 24 Jun 2021 06:54:09 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5%5]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 06:54:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Cristian.Birsan@microchip.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Thread-Topic: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Thread-Index: AQHXaC37D+YfoBgtzEKBvdp3Oa3YYqsiuxkA
Date:   Thu, 24 Jun 2021 06:54:09 +0000
Message-ID: <7442ab4a-cb23-efa2-6f8f-6806028a752e@microchip.com>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
 <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
 <20210623141907.GC491169@rowland.harvard.edu>
 <8bff20a7-8eb8-276a-086e-f1729fbbdbe4@microchip.com>
 <20210623164148.GC499969@rowland.harvard.edu>
 <f03ccb09-4b5e-4db7-2cf0-375d53234099@microchip.com>
In-Reply-To: <f03ccb09-4b5e-4db7-2cf0-375d53234099@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.78.167.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1885e78c-dcff-4efc-4d9e-08d936dcde06
x-ms-traffictypediagnostic: DM5PR11MB0028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0028D06589C694C7CD3E8A3D87079@DM5PR11MB0028.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxen0sJoYL4fvTdOKH0xIvTC0S8uLp1aee5nnBuMMCiokral4Anp7hHsGmJY7xWG3+Ct2+PLXPCD0rStQjs6SsIDCiJYGS6HR4lsE2MHDlyPMMb7h5uvEq/u5IQXIQpSW0dYaKBB7cS1ZA4fyLOVaBSkHVFVie+U71Ri6WYTK0FufhPTsls5KGHvtGVlTQFfxug61Z4S9B/69j022TcGFZxNjI79AgQL8PhiPSQHOBJjGzPSP08IJra4EXEaJiEk/d6qWaYORZ9NZGpLmLAZ4kyBTldCfuGuKcjC1fTeTtbxEpwcyt9Qrhgwcef8QIMbnzwPrYgsV/AhM46ibo9hs0Fn0s+hbArUZ7JVDevlhpEhu6eI0V+L2gF0AwOf3eiTIUt9r6toto3ekCOQXt60Q4SG3oEJC3wtHhRb8hnBRIJLPQCau1Ae81QOG9G9XtyYnARqg4UOXMGS87iYXgdcNgKoRKMx+//ivVFSQ+DLBiX9fUnsIJnkKMKZZHLM4HUVIyXJRyUUq2k89VwcpuOpCfXHniNEQfDjW+FzQRCo6aJHdq2xV1D6W1UvuOqkXvM6UlrRaLViABYKZXcGDt1GsN3sG9S9AmxE2E+oKwmijvfsh5SFPWk5Mfy2OLT3gvcMOCJ1im29oU1P8lH/6LI7czadPuiY+81m8xX7nUnHL5IWwxyYktZ/8tj1bhXuAG3J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(316002)(26005)(53546011)(186003)(54906003)(86362001)(6506007)(8936002)(71200400001)(478600001)(2906002)(5660300002)(6916009)(8676002)(4326008)(36756003)(31686004)(66946007)(66446008)(6512007)(38100700002)(122000001)(66476007)(6486002)(15650500001)(64756008)(66556008)(31696002)(76116006)(91956017)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGpwNWRwNEZ6ZEoyTmdURWdTYmw0ZXpsREFDa0JGYkc1V2hhL2xxUkRQTHBD?=
 =?utf-8?B?UWlEeWM0cXMrTWxGdm1zZlYyVE1xaVpma1ZuOXJNMy93T09NMDU0Z0hmTjJU?=
 =?utf-8?B?dWRwWlVqRXRrRExmS2xVeWlJVWVVVWs4NHZqVTM2RW9SbXcwanFNam9Jazhh?=
 =?utf-8?B?QlVSaTlqTll0QWNnOS9QOGhQWDU2SjBGQkUzRWRvMnhxVTJwKzJIWnRmOUlM?=
 =?utf-8?B?QzRteVJ6UFdNQkpiMENxS0VOWTFoUnora0ZPN2owUEM0bmVuQnFYUlZVU29T?=
 =?utf-8?B?M1ZHMDVZZkZSWWFZaWZ3alFCamFzNDVSbnlla3lDdWtFVGJUYnJHT3JrK3A5?=
 =?utf-8?B?dGlxbWxNaEZMYUVDZ2FKL2hBR0dXVEVBRW5HU2tEVU14c01mY0tmSC8yNk1C?=
 =?utf-8?B?WlNlUVFlTUxjK1Fhekw5cUZCRENwWFkzNlU5ekVXK1U4blpPNWRGWWhVUnpp?=
 =?utf-8?B?VkVTc01vV0NpV1hEYkFBYjNGSWp1cG5wWjF1VlNSS0tIR1hlT3ROV3ZsSG5C?=
 =?utf-8?B?ZnlkL1RRdERrakd1TS9vSUhBU0xUNU9ObWdDREFieEtsM0FEeHFvdldSaFNY?=
 =?utf-8?B?SDZHNzV6SHlBcFdreHJpekp1VWc4V2R4SFY5V1BjVzRNalBtK2UxTzR5OUt3?=
 =?utf-8?B?WVFOOGxWOC9OMHVWSER5d2JNc2IrR1lycXc0M096ZU9oTzlrb1d0MUIwMStz?=
 =?utf-8?B?aFFjQ012Rklxcm1QTzVwRFJLYmg4Um02VlJUcU1USGFlc0tqd3RWenRLeVVI?=
 =?utf-8?B?UzA5em1VenlxTGRnMk45M2JQRWpQL3F2amg0UUJGR081SUx2ZS9WNWtYdSs4?=
 =?utf-8?B?VkF3TFAxTENoREtxWUZrcUZ2NEgvYkJNNHp1R3JpZFkzVWw1UFRxREJKUjhk?=
 =?utf-8?B?Y21EUUFrSW1sWXBrU0p2WENkeVprSnIxdmt2N3BXU2NkQnhYUXZPMUttNVky?=
 =?utf-8?B?dWhsQjZuSHJsT0swNzNhRkN6YkFLS2FVeG9IcWxycjRYcmNXOWhGVFB1NlUw?=
 =?utf-8?B?WTEyK2tiY0lxdVBoVzhlVFZ2dlZOMThRRnBGcXdBSzN5cW96Ym5lMUJROTBS?=
 =?utf-8?B?S0hqZE1BTzgyZE05WXgrNUlXRlRmSUYzakhsVTBDdjZId2wycm9qZDNIaGdL?=
 =?utf-8?B?ZXVIUlMzNE1aaEkzbE1Hd1BiSUpmWk9pSjdQaFVBZStKTnNuU2llb05uMlZM?=
 =?utf-8?B?YVp4dEZlUWRYcUtKdTVhb1U1UmRNRTdTd3hSYjJmQzBZYXdtS09TRUlaWXVE?=
 =?utf-8?B?WlVnRis0SlBDQWs5TmFENC9IVXJOdit4UGRIYUVCNzc0aUVwS2dxbFRyamxj?=
 =?utf-8?B?NzBvZkwzVGpXWTVXQWtvTkJ3cHUvdjRIMVRHSTRnbDhKYkw1cDRvYU84djNC?=
 =?utf-8?B?Zkt2VXdCK1hUVVVESmQvalU0UVo3SFYzRWpFSDZESGNrbFpXU2NxaUVRSVRz?=
 =?utf-8?B?OXJxb0RQNENqM2h2WkxwYUV5VGVoeGtkclNkTlFqemNvaEZyVSt1dHc2c3hQ?=
 =?utf-8?B?R3hBbldkRHhjREJTcnVuRklMczAzT0lKdTRpcENiZHVJV3laSFhFcHdPZUVz?=
 =?utf-8?B?R0RHVThXQmp6TVVGUEppa3hCTGlubkM3eUp4cDJ1ejhwaHdZejdZNUxOQzdH?=
 =?utf-8?B?UG8xZlg0UUM4RTNOSDAwUzRqZFFGMng2d1YwZ21OM3FOVkpMRDdMalh2RTRw?=
 =?utf-8?B?QWpEeERnSnJRRUZEUWRxQXF0YjU1YlNxTndLV0V5djBVTjYvVGtub3h4Y3FJ?=
 =?utf-8?Q?LXizRF6M/Ulab9ZY+k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31C55D5E705A6740A9720A32076A1B85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1885e78c-dcff-4efc-4d9e-08d936dcde06
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 06:54:09.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lY/foxkaxb4FmV9hReArJ4uOQMVlCbg6ST84o21G6pyc5hMcd1uwiT2K9KukpsnS7D+dPnSkDWop9+4kXVgY5xpn8Ldt1UpPM6uoLEbw7MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQuMDYuMjAyMSAwOTo0MCwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDIzLjA2LjIwMjEgMTk6NDEsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+PiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4+DQo+PiBPbiBXZWQsIEp1biAyMywgMjAyMSBhdCAwMjozMzox
NFBNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+IE9uIDIz
LjA2LjIwMjEgMTc6MTksIEFsYW4gU3Rlcm4gd3JvdGU6DQo+Pj4+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPj4+Pg0KPj4+PiBPbiBXZWQsIEp1biAyMywgMjAyMSBhdCAwMjow
OToxNlBNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4g
T24gMjMuMDYuMjAyMSAxNjo1OSwgQWxhbiBTdGVybiB3cm90ZToNCj4+Pj4+PiBPbmUgdGhpbmcg
eW91IG1pZ2h0IGNvbnNpZGVyIGNoYW5naW5nOiBUaGUgbmFtZSBvZiB0aGUNCj4+Pj4+PiBvaGNp
X2F0OTFfcG9ydF9zdXNwZW5kIHJvdXRpbmUgaXMgbWlzbGVhZGluZy4gIEl0IGRvZXNuJ3QgcmVh
bGx5DQo+Pj4+Pj4gaGFuZGxlIHN1c3BlbmRpbmcgdGhlIHBvcnQ7IGluc3RlYWQgaXQgaGFuZGxl
cyB0aGUgY2xvY2tzIHRoYXQgZHJpdmUNCj4+Pj4+PiB0aGUgZW50aXJlIE9IQ0kgY29udHJvbGxl
ci4gIFJpZ2h0Pw0KPj4+Pj4NCj4+Pj4+IEl0IGRvZXMgYm90aCBhcyBmYXIgYXMgSSBjYW4gdGVs
bCBhdCB0aGUgbW9tZW50Lg0KPj4+Pg0KPj4+PiBCdXQgdGhlIG5hbWUgc3VnZ2VzdHMgdGhhdCBp
dCBvbmx5IGhhbmRsZXMgc3VzcGVuZGluZyBhIHBvcnQuICBUaGF0J3MNCj4+Pj4gbWlzbGVhZGlu
Zy4NCj4+Pj4NCj4+Pj4gQW5kIHRoZSB3YXkgaXQgaXMgdXNlZCBpbiB0aGUgU2V0UG9ydEZlYXR1
cmUoVVNCX1BPUlRfRkVBVF9TVVNQRU5EKQ0KPj4+PiBjYXNlIGluIG9oY2lfYXQ5MV9odWJfY29u
dHJvbCBpcyBqdXN0IHBsYWluIHdyb25nLiAgSXQgd29uJ3QgbWVyZWx5DQo+Pj4+IHN1c3BlbmQg
YSBzaW5nbGUgcG9ydDsgaXQgd2lsbCBkaXNhYmxlIHRoZSBlbnRpcmUgT0hDSSBjb250cm9sbGVy
Lg0KPj4+DQo+Pj4gQWdyZWUgd2l0aCBhbGwgdGhlIGFib3ZlIQ0KPj4NCj4+IEFyZSB0aGVyZSBh
bnkgc3lzdGVtcyBiZXNpZGUgdGhlIFNBTUE3RzUgYW5kIG90aGVycyB5b3UgdGVzdGVkIHdoaWNo
DQo+PiBtaWdodCBiZSBhZmZlY3RlZCBieSB0aGlzIHBhdGNoPyAgRG8gdGhleSBhbGwgd29yayBw
cmV0dHkgbXVjaCB0aGUNCj4+IHNhbWUgd2F5PyAgKEkgd2FudCB0byBtYWtlIHN1cmUgbm8gb3Ro
ZXJzIHdpbGwgYmUgYWR2ZXJzZWx5IGFmZmVjdGVkDQo+PiBieSB0aGlzIGNoYW5nZS4pDQo+IA0K
PiBJIHRlc3RlZCBpdCBvbiBTQU1BN0c1LCBTQU1BNUQyIGFuZCBTQU05WDYwLiBJIHRlc3RlZCB0
aGUgc3VzcGVuZC9yZXN1bWUNCj4gdG8vZnJvbSBtZW0uIA0KDQpUbyBiZSBzdXJlIGl0IGhhcyBi
ZWVuIGNvcnJlY3RseSB1bmRlcnN0b29kOiBhZnRlciBzdXNwZW5kL3Jlc3VtZSBjeWNsZSBJDQpk
aWQgVVNCIHRlc3RzIGxpa2UgY2hlY2tpbmcgdGhlIFVTQiBkZXZpY2UgaXMgcmVjb2duaXplZCwg
d3JpdGluZyBkYXRhIHRvIGENClVTQiBtYXNzIHN0b3JhZ2UgZGV2aWNlLg0KDQo+IE9uIFNBTUE1
RDIgYW5kIFNBTTlYNjAgdGhlcmUgaXMgbm8gY2xvY2sgcHJvdmlkZWQgYnkNCj4gdHJhbnNjZWl2
ZXIgQSB0byBPSENJLiBJIGVuY291bnRlcmVkIG5vIGlzc3VlcyBvbiB0ZXN0ZWQgc3lzdGVtcy4g
VGhlc2UgSVBzDQo+IGFyZSBhbHNvIHByZXNlbnQgb24gU0FNQTVEMyBhbmQgU0FNQTVENCBzeXN0
ZW1zIHdoaWNoIEkgaGF2ZW4ndCB0ZXN0ZWQgYXMgSQ0KPiBleHBlY3QgdG8gYmVoYXZlIGFzIFNB
TUE1RDIgKGFzIHRoZSBjbG9ja2luZyBzY2hlbWUgaXMgdGhlIHNhbWUgd2l0aA0KPiBTQU1BNUQy
KS4gSSBjYW4gYWxzbyB0cnkgaXQgb24gYSBTQU1BNUQzIChJIGRvbid0IGhhdmUgYSBTQU1BNUQ0
IHdpdGggbWUgYXQNCj4gdGhlIG1vbWVudCksIHRvdWdoLCBqdXN0IHRvIGJlIHN1cmUgbm90aGlu
ZyBpcyBicm9rZW4gdGhlcmUgdG9vLg0KPiANCj4gVGhhbmsgeW91LA0KPiBDbGF1ZGl1IEJlem5l
YQ0KPiANCj4+DQo+PiBBbGFuIFN0ZXJuDQo+Pg0KPiANCg0K
