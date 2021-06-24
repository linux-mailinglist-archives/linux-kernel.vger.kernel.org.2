Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C814E3B2784
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFXGmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 02:42:54 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:23944 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFXGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624516831; x=1656052831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=URii9btjS/OX34m+NpUU1xw+ORrht+t2UoCyThyjDbc=;
  b=1iUpbHUt4JlDQa3/Gzr+7WDGqpVrfuDlnmG71wQEBpGFQ8nTj8GbTCs2
   3JMEiahdkwAnTJOpO3E5jed28FyQTcREG3Maywd3yNCDmE6deSFKMNy7u
   i071ZRh+DzuSsR9vb0o5jdiIxTixa1eNXFJioj85le4l/MIikF/GO/n1a
   l6a2SbLTar6wU25R53xLRJb6RAT4XeLw6QWFk8pEqwvz0yGFmpskMXUqk
   wQcJWG/VZ11+jHCgBsK5HOCGgiZRNtl+0utMG0ixuOzd+VS9V/t5XfiLM
   y8wbzuDYBHtbmI2Jx1RkbcnmZSzRXI1V7CFh43au0ZacJ82yEfXbNGb7e
   Q==;
IronPort-SDR: Xnzc8wSWHjJkNcWpaosQkZETqjlSvcxnshqUBQyMABXxj74eXOSPCZwUio3SRF0hh3cYOh85mE
 CimDr6rcBx4WpB5IZ3x8f0uynMjGU73E14hgGwErDAzywxVp10tbC9YtUxHaMeWcPPtn/aWHhs
 dbhdCAgOxmOcm5kFoX96zGRgJTUQG450dlReC5PhmLu2GAwrTp9C1SS0W204QR/11WJgt0yaU+
 JpmbR1sR/eRs1oAwXvBsD9RhcfoUgl5HEDQu2Q6thCttfoJYFSIwSdV5kKIQ3f5noOkAFWCpcW
 NNQ=
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="133276870"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2021 23:40:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 23:40:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 23 Jun 2021 23:40:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Twx3LPOqWIzcdVPrlhSHZdZ3uNQftCjTa/iiIDmxVRfRbdMGLYMZzE1ld/lPCDcppngcdPsoEqIJkAS62vxXE6rOuCJoaiOyX/ARuv/GzCTouWGsF5U14GhBJwTkWvdVi91D/5D+NlsVvKd3UJl3T2KVHuZ9Q9FKDl76kf5e/DrglBsDrIVdl09xjZWwKarhQ96JC0CcrPGPQjkUdb0EKzZE2Aw078xHtxlz2fiFGf7krpEn5jlHEpKMP1rXvZX7JRBrqIZFqFZoUwionrrSob64/EeC3lBkEm7R08X+91fu9jEDkAmvJFP/zc4doXbZcgTFF7em19fop+kE5eby4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URii9btjS/OX34m+NpUU1xw+ORrht+t2UoCyThyjDbc=;
 b=VuLjoX7whMoTtm+NpffnEIS9lPU2wQt6eKPXQd3b8ughbhgDZ1rTsLcVca+ltQ8+T5cSc1PqsgUF2Jxf7fDALgP4RMfj55v+NRAdhs6Bvbs3KOFV5Tz02AbZOcwT+Jw31puyv6JlSQ2hQ2cS+6qm8NaxTRSF3buhUh0x1XJ6Fj/S9m2MNlHtDjmTnrINg1lhJZA87poLsx1TabrNkMu3n0XOeTu/SDd8lxMLn2PzjMnDlHWNyLlepP8sbxRPPDhRIta7gvU1r0p9ERsniq62kf2ze+V1YvRylDQDJvlYNtxcB0Q8lmOHFeVskGPo/WHq9UFAjZtQVQ/6js4icOftdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URii9btjS/OX34m+NpUU1xw+ORrht+t2UoCyThyjDbc=;
 b=K1VOiLS+3fmCD25yjgg0+6px/dWKxSiKSO+ip2xqc+Fagj27miutox+Dcub/nNo29jIu7T1nCuZz1HrFY87BhtAB3/DbnDcXcTbsW8/JDYWVsULXqh3DgSkv2EtituOp+wZA20+zr0b9kFOnUjSP21n/leufeez2LWd8EMIcAXI=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1436.namprd11.prod.outlook.com (2603:10b6:4:8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Thu, 24 Jun 2021 06:40:26 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5%5]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 06:40:26 +0000
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
Thread-Index: AQHXaC37D+YfoBgtzEKBvdp3Oa3YYg==
Date:   Thu, 24 Jun 2021 06:40:25 +0000
Message-ID: <f03ccb09-4b5e-4db7-2cf0-375d53234099@microchip.com>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
 <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
 <20210623141907.GC491169@rowland.harvard.edu>
 <8bff20a7-8eb8-276a-086e-f1729fbbdbe4@microchip.com>
 <20210623164148.GC499969@rowland.harvard.edu>
In-Reply-To: <20210623164148.GC499969@rowland.harvard.edu>
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
x-ms-office365-filtering-correlation-id: 1db5ce28-553b-491d-1a4d-08d936daf32f
x-ms-traffictypediagnostic: DM5PR11MB1436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB143678FDD8F5CE0C0E3FABE887079@DM5PR11MB1436.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUA1CgYNUZhXqHyeDFFqlsw8x7m2zx++w4gcr5mIep/F5PNdbt7R4oeEoYJQOBJk9blhdwtXmty1mqUHF4r3eh8uhs3SzTOZDKufmjHV+mAqmmQ8tIIWFSCWwj95jugKkFynQVM8VSG/ZwGi/QBZAaie7Ne0bC2Asch9gRHxxmghycPpn6hLHej0HyZqUx3GDRpGRcicx89t0Xgyax47CpaybM+OLrfULI29HzxiOgezTXz57f0W9IBF4AzRL26CcuGMZraKW7KrZuCnrerXouZRyPlehCWlYseDinIc/JUGVdiuSR4z89If3Kk0jPzbEfuQJAU7EvNTYwFQeevxdtQKxUwvLXltBv68yt8IJfzlVPxzZHQgvqMrzX6nP8XNlZloWEobN+oyYdR/3V9QeQbEqq/EwR3W0twy3KBm9d0bKeXmLvngp44CdNpkisZh1Sl6UeRgq566vZms9l8p2UTIDGQahKhz8Z4z3lwTvxYml9t1S6oCoZvqwlxiFjDx9INUdIk2qmn4QLV8Q9hg5ya5Fm/AIBbDGykmoO6K2En22TuYclqW/tWnH/NyOsCT1ipuYrcJilqViACLGMZVs6S7BEMApoAT8HMAR6f5Zz6ccGT0dyJUXmZYo5En/SbwdBSEHw1Oj3CA7D84SvWgnVGB0PIrhpnL0nMtMEB8BjOZEvV5YhPRaXgw36M+LthN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(366004)(346002)(6512007)(66556008)(66946007)(6916009)(53546011)(6506007)(66446008)(64756008)(66476007)(5660300002)(91956017)(186003)(15650500001)(26005)(76116006)(31696002)(86362001)(36756003)(54906003)(2906002)(478600001)(71200400001)(122000001)(4326008)(316002)(38100700002)(6486002)(83380400001)(8676002)(8936002)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnVVbUJ0Vm1BdWpPRmZrK2w4dEdKanhMSnJXSVIrc1psTjFRcUlRTGQwWVhO?=
 =?utf-8?B?TDVHSFBNcms4NjR2eFBBNTlXYXgxSUNCelBkeGdnQi91SGN1eFFOL2xrbmo2?=
 =?utf-8?B?MVYxa3B3V0ZRdnY2a3hoSG5EZ0xtTWFoYUQ2dTZMZE5OWjNkK000VW52Z1Jz?=
 =?utf-8?B?ekNmK2tUMjZEUEV3YklOcHR5YzZ5dm42TVJnNC94YzhxRjNvMFh5ZUF3V3pz?=
 =?utf-8?B?WjVWYVd1akdGSWwwdUJoNFlwczQxelVoU0lHY3A1WjFoVGdES3dodFRraW8w?=
 =?utf-8?B?YkRVT1crN3locWNvSFF4RDFoZEtmMG1lR2RibGczVjJGSXlNVmhlTDR1TWpL?=
 =?utf-8?B?ZnViOEdMSDUzZ3pScTNvd294SitaZHVKbGU3SU4zZzhWU25vd0dYVUE4YTh6?=
 =?utf-8?B?a0o4M1Q5akhUUHB0SEQ0MTFuRVFIb0lERXNHaE5mQmVPeEUxR09SOHh1cUsz?=
 =?utf-8?B?aXMvVVdBekRjTHJKaSt2MWozWkdBL2dnNjBKUDN4ZzdRWURmNVRPUTFqZC90?=
 =?utf-8?B?TTNqYTdBMUh2dXo2M2V5djNGdTFvQ3JZb1BWY0Y5Z3cvdG1oQmFOVHhBOHZZ?=
 =?utf-8?B?TklZWnVHQ2VoSnp0RFpYRHFFUkhaRDl2WFJCM0lUKzgrL0VEeUF0dXhwZDNO?=
 =?utf-8?B?Z0UwWE4weXdRTkl3VnhmNmJvNWJKS29mOEdlZ1ArWlBUTys5Q08yZzRYM1U4?=
 =?utf-8?B?TjU3N0puanU2MzlWZ3hFa3JGYk0rczlncTJ5c0tGemg0UC90SVhVeGxzNGV4?=
 =?utf-8?B?Z1V3Y2R5NHdUSmplaVcyYVhQSG12c3o4ZWFLdWtqakNuaGpqMFR4THJzZVRC?=
 =?utf-8?B?MExudHpaWktXZEZmWGFuR3JKWEwvdmlCOU1tQTIxYnJqelhxNUlCVU1nTjh3?=
 =?utf-8?B?RUEzQW9WaDVodDFhcWNhWTlZWGFFTloyV2NkZUlmand3aGhXbG4wbTFVTWcy?=
 =?utf-8?B?VmY3YzFOc3hOZmlDK0RVazRWbTdQdHFxMnBhMDc0NGt6T0VZanArd3Y4VCtL?=
 =?utf-8?B?VXBDVFQ3VUx0UjE5UWNUbjlJQ3ZHV2RhOE1BWHJ1RWhuTzdTYXZCLytjTFpk?=
 =?utf-8?B?Z01PZkNybGgvQlhHcCtwRWlOQ2xpT29oOXI3clF2a1VrVGphVHpjaVQ3aTYr?=
 =?utf-8?B?RkJxRCtiNU42bUllMmg0MlhGNlJjSjBVSk5jMExyUW5xN3FVYitELzJ3VVVX?=
 =?utf-8?B?QkRpeVlXQkdLZlR6YWVmWUN3ZU03VHJJRkZlNWhpZVJGZkJFeFZmbTRNMlkx?=
 =?utf-8?B?R3RVMkdQNEVWaHYydUpvVkxaU1FSeXZPVjdFcTNPZ3c4R1RRTTZOM04vNkVC?=
 =?utf-8?B?Q1NDdnVad1hPczdOYXBTaVplUFpvanZXc1ptWDl2WWs1ZnJIbFdic09WSEUy?=
 =?utf-8?B?VHQ3VG9UVzZoU3lFaVJZU1N5azdYM1NwR28rVmpXL25qYzJZRTJVSHJnckxM?=
 =?utf-8?B?aTNsNmRVRGlORWsyWWlocmNISndhMDg5dFJsR05IUGVNMWdqMkVUdFVCUEdz?=
 =?utf-8?B?aU5tQ0FwUWtRVXNObkZGS2k1TlMwRitwQTliRXJZdE9VTHROdklwQ2FJTmcx?=
 =?utf-8?B?a3oyc2h2NWNBdVRIamwweTFaYmtFQ0pPQWhBSGJibmVORmo0dTZUY0p2a2I0?=
 =?utf-8?B?eXRya1BtMGt4RlpkL2NYbVJ1OGNiKytWM0R2NFNIekFDdUlLU2VPMEhUb1Vk?=
 =?utf-8?B?UjU1UDZTQkdmbHg3Vk0rQ2kyVzBYSENxYk84SHU4MWRzbGxBeW1zVjR3dm5l?=
 =?utf-8?Q?NpiLWy/+jBzwMEYUCg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1892A0ABE12C4D98883365FF12B1EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db5ce28-553b-491d-1a4d-08d936daf32f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 06:40:25.9059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKVJ4GbqjVX2bD7SDZ13eaIeR/dExgt4u6uiv2i6f2o08LqNGC3UEf94TWS7/H5LXa0HdrqcQrrKC/3vUQHVY25/VwoXWIp+pW7jaJWxzHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1436
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMDYuMjAyMSAxOTo0MSwgQWxhbiBTdGVybiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEp1biAyMywgMjAyMSBhdCAwMjozMzox
NFBNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMjMu
MDYuMjAyMSAxNzoxOSwgQWxhbiBTdGVybiB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIFdlZCwgSnVuIDIzLCAyMDIxIGF0IDAyOjA5OjE2
UE0gKzAwMDAsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IE9uIDIz
LjA2LjIwMjEgMTY6NTksIEFsYW4gU3Rlcm4gd3JvdGU6DQo+Pj4+PiBPbmUgdGhpbmcgeW91IG1p
Z2h0IGNvbnNpZGVyIGNoYW5naW5nOiBUaGUgbmFtZSBvZiB0aGUNCj4+Pj4+IG9oY2lfYXQ5MV9w
b3J0X3N1c3BlbmQgcm91dGluZSBpcyBtaXNsZWFkaW5nLiAgSXQgZG9lc24ndCByZWFsbHkNCj4+
Pj4+IGhhbmRsZSBzdXNwZW5kaW5nIHRoZSBwb3J0OyBpbnN0ZWFkIGl0IGhhbmRsZXMgdGhlIGNs
b2NrcyB0aGF0IGRyaXZlDQo+Pj4+PiB0aGUgZW50aXJlIE9IQ0kgY29udHJvbGxlci4gIFJpZ2h0
Pw0KPj4+Pg0KPj4+PiBJdCBkb2VzIGJvdGggYXMgZmFyIGFzIEkgY2FuIHRlbGwgYXQgdGhlIG1v
bWVudC4NCj4+Pg0KPj4+IEJ1dCB0aGUgbmFtZSBzdWdnZXN0cyB0aGF0IGl0IG9ubHkgaGFuZGxl
cyBzdXNwZW5kaW5nIGEgcG9ydC4gIFRoYXQncw0KPj4+IG1pc2xlYWRpbmcuDQo+Pj4NCj4+PiBB
bmQgdGhlIHdheSBpdCBpcyB1c2VkIGluIHRoZSBTZXRQb3J0RmVhdHVyZShVU0JfUE9SVF9GRUFU
X1NVU1BFTkQpDQo+Pj4gY2FzZSBpbiBvaGNpX2F0OTFfaHViX2NvbnRyb2wgaXMganVzdCBwbGFp
biB3cm9uZy4gIEl0IHdvbid0IG1lcmVseQ0KPj4+IHN1c3BlbmQgYSBzaW5nbGUgcG9ydDsgaXQg
d2lsbCBkaXNhYmxlIHRoZSBlbnRpcmUgT0hDSSBjb250cm9sbGVyLg0KPj4NCj4+IEFncmVlIHdp
dGggYWxsIHRoZSBhYm92ZSENCj4gDQo+IEFyZSB0aGVyZSBhbnkgc3lzdGVtcyBiZXNpZGUgdGhl
IFNBTUE3RzUgYW5kIG90aGVycyB5b3UgdGVzdGVkIHdoaWNoDQo+IG1pZ2h0IGJlIGFmZmVjdGVk
IGJ5IHRoaXMgcGF0Y2g/ICBEbyB0aGV5IGFsbCB3b3JrIHByZXR0eSBtdWNoIHRoZQ0KPiBzYW1l
IHdheT8gIChJIHdhbnQgdG8gbWFrZSBzdXJlIG5vIG90aGVycyB3aWxsIGJlIGFkdmVyc2VseSBh
ZmZlY3RlZA0KPiBieSB0aGlzIGNoYW5nZS4pDQoNCkkgdGVzdGVkIGl0IG9uIFNBTUE3RzUsIFNB
TUE1RDIgYW5kIFNBTTlYNjAuIEkgdGVzdGVkIHRoZSBzdXNwZW5kL3Jlc3VtZQ0KdG8vZnJvbSBt
ZW0uIE9uIFNBTUE1RDIgYW5kIFNBTTlYNjAgdGhlcmUgaXMgbm8gY2xvY2sgcHJvdmlkZWQgYnkN
CnRyYW5zY2VpdmVyIEEgdG8gT0hDSS4gSSBlbmNvdW50ZXJlZCBubyBpc3N1ZXMgb24gdGVzdGVk
IHN5c3RlbXMuIFRoZXNlIElQcw0KYXJlIGFsc28gcHJlc2VudCBvbiBTQU1BNUQzIGFuZCBTQU1B
NUQ0IHN5c3RlbXMgd2hpY2ggSSBoYXZlbid0IHRlc3RlZCBhcyBJDQpleHBlY3QgdG8gYmVoYXZl
IGFzIFNBTUE1RDIgKGFzIHRoZSBjbG9ja2luZyBzY2hlbWUgaXMgdGhlIHNhbWUgd2l0aA0KU0FN
QTVEMikuIEkgY2FuIGFsc28gdHJ5IGl0IG9uIGEgU0FNQTVEMyAoSSBkb24ndCBoYXZlIGEgU0FN
QTVENCB3aXRoIG1lIGF0DQp0aGUgbW9tZW50KSwgdG91Z2gsIGp1c3QgdG8gYmUgc3VyZSBub3Ro
aW5nIGlzIGJyb2tlbiB0aGVyZSB0b28uDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoN
Cj4gDQo+IEFsYW4gU3Rlcm4NCj4gDQoNCg==
