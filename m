Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9439F3B853F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhF3Ot0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:49:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31977 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbhF3OtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625064412; x=1656600412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=itCZTBxGiS0l5eXvco6UpLdbrMqo0V6BEVEy4LcZ0ew=;
  b=f1DCYQUIM4eyHRlGgnh6KDTSYd/xqFPGAWD1azXz0120xsgn8JWjKzCq
   PGkqa/D7Dpu89rdTDZ+YofDM26bnjyya63USWf1k+bambJDsiMZ4yc11s
   OX9OGgnTju+nJPJxyTh8cOxtuSHDDGygeu7mn0zex6LsNmZW5DVcojkOh
   ZXU7Ulcib+B8z9+buboZarNfPhhdeJR86nbNe46Q7/LpFZY4s65rUR09y
   QYflYdqPYRBKqRLZCgJ5+MkS30wjsXqeUFvIPrTTkW545WrfCmIYHEP3Y
   R18L6fGh/AGO9swBgvaIxy31J0m5uGZ/X+v+7hqnKTG2M4FBiKvfa2S3Y
   g==;
IronPort-SDR: MMpXk66q+8IrIIqG7baJu9FgbnIoTCt0RJsZXOaqZZiupr0F5MRrn5hmhdiNU6LFa0+2GJuva4
 f/TG/ymS4nR6n3GLkmx9exHOBdQeksx5TqxLFEvc0LITBM3nHJEmwoUK/jyMJBKCjkrd7vHruY
 wVGrX07UO+ZLCexlOEcQbCzhluT8zPHiUjAmw6BLYTlpdGGz67/gRqU2rrrvcWLkrn4k3tLosW
 rPcaq3thxN/MqQhztFE9aA86wkB46HQq6cGOYiSpPHK7XkvuqdRle/Zvj7i44I+JYBOYvrdaqu
 gQ4=
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="134082313"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2021 07:46:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 07:46:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 30 Jun 2021 07:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz4AYoOlhqYAOeLBVz45TamUiSCIEjdzD7S/l0kSGn9YldMp23y8wR5BuVso86dTv8lEg7JSYMk1fq0N0bvu6/7kscz0lZHox3AgX9gCu/qjLM3LDxHMkQS+ea2n0xXaIsEsVotjhmR7+xfWZiQ/qUNvHiKT/qeE6TjBaSCPEaEprtvJ4OdSb+uXq0oOX6ysFmdpn4nExWkXvhOtIHYB8EqXJt7dYM4oBpAu+LTz0F9EKahvwDjfa1+eFYapDzJj0d9HehaqMbdyFUU7shGzmTJtXD4FopC1QIGAa8IR6TGdgM//+doiFDVXdj+NEPg3KaEggsczYYQg1hLvfhZfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itCZTBxGiS0l5eXvco6UpLdbrMqo0V6BEVEy4LcZ0ew=;
 b=Xr9PFNyygMUY5lw0CiN8Wrtz/9Bfr6twFIosovJ6KmCXjaNkk9Hv7nLnjblrj7w2hDwPTD6P23WCtpx7K69yMldg8A4bPYsFqTsYQmbL/iKzTCzeJNO/DGbLnA6VxqkTQ+WcBafrbdZJ55TM5R1bqCwyyq1pVn3oYCaWdqEJaBJILvQeyqMywgmtuBHLT1xOv69nFn6sCZEEXqxoG8UhjyZXp5XRR0lm08TtKMIHR9qxZED391nkocz9XCo2D9oFAxHm3XFudmkqc18Z2acyMDeFDRF7ySOgGC4tSHPhWibThVO4sxtnnUzp3nxwdP1VisuX7XsXWLemcgDSvz7fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itCZTBxGiS0l5eXvco6UpLdbrMqo0V6BEVEy4LcZ0ew=;
 b=qAro8Qt7NBsXjcRVJ4YGTCbaaRtH74lqMHAD2UhdyUEF1IZTynxDCcT72CJ1OmVmujYxoM8LYEI4HijzWwEiiWjIhCKL2pxP9CNb1+xs1SBUsoslcRZa2K7CxjYFSp0zkABe9Af4tlS6RZsjKrrH2gLrD3Q7pbafhwq1tqRojXQ=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR1101MB2267.namprd11.prod.outlook.com (2603:10b6:4:52::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Wed, 30 Jun 2021 14:46:47 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 14:46:47 +0000
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
Date:   Wed, 30 Jun 2021 14:46:47 +0000
Message-ID: <856493cd-9d53-24b3-8e8b-c3c366f282bd@microchip.com>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
 <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
 <20210623141907.GC491169@rowland.harvard.edu>
 <8bff20a7-8eb8-276a-086e-f1729fbbdbe4@microchip.com>
 <20210623164148.GC499969@rowland.harvard.edu>
 <f03ccb09-4b5e-4db7-2cf0-375d53234099@microchip.com>
 <20210624132304.GA528247@rowland.harvard.edu>
In-Reply-To: <20210624132304.GA528247@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.78.167.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b000156-2b6c-43e9-a09a-08d93bd5e358
x-ms-traffictypediagnostic: DM5PR1101MB2267:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB226703746546A907B1DBAD7787019@DM5PR1101MB2267.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bm3s81RrylSx13pS5xBAdT20GABwJAtV/SdALFWfaG4MBPEla0ECM4bpipx7IATVwA/61meeHc3FN7bvbenut9IWtHa/ZU0BFLqkopq3gHxByBToPeADIXFG+B1sEVEUcZpY8Bk0n8HiwZ6stx3ki76kK8wYxzm1+kAAocqTwIi1sQQlkBUSQDr4fjCxcxFjutTAnIEi8i8eDSy84IAIsxo8ZS+PKbobAOTnrE/g7rAYpMFs8UFtFSu2F1V9w4EUDoQB7V1uffgRRln0bb6KiHxHR+Da7wHTyaXKO7ei8EA/O39//2+nC2KHioEkehCX0vzLoUGJWazwvXVXGxesuy2Ajey/OSuuh0aq8dsxMrLxDnCItVGVtINzuiK55u+E8DV8a/ynJ5nvAv+XiCdQjT3FhnMRHMkWWLbEHQ0bn2ZfOyc432lAQeEYNSvurtWpE9rXINbojcAAG1g8jPrHcvPKBQxN/5m0/5LO1Cm8+SQMtCwLPdQTd2lsuGsCuR13zKON+qy+fk9642Jr+3L6ptVWy+rljQ2ilO58/0jPKi+f8C9AnQSqX+8REOa16R6zlo2xN+DXoOoCdxUW+yTu7pz1wr7ItpSnd9PT0xyFM4lV9HL5SI8nou9gH5Lftk5HReBpmmmxm4H/Oq7+c0D58BRnbcV/zEqn5ik3Mv0bcMYfA9Ezd5WNwTh4TsftYF0YuV+kADtV7i+j3bRa7ll6IOqpq5p5X9OR0FoQLqqbpupriyJ21vazyyEcOEbV9wkJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(346002)(396003)(31686004)(2906002)(316002)(4326008)(8676002)(53546011)(6506007)(64756008)(54906003)(83380400001)(36756003)(66446008)(66946007)(66476007)(8936002)(66556008)(91956017)(76116006)(31696002)(71200400001)(6512007)(15650500001)(478600001)(38100700002)(6916009)(186003)(86362001)(6486002)(2616005)(122000001)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azlBZncxdncyOEx5RmtOQ1JqL09HTEdJdzBoTlZHbC95VUNxTDIvM0tEaWlM?=
 =?utf-8?B?bWdhNzAvOXhnMmlMM0VyUFozYjJzakxqTlhBMGRGNXJOeSt5LzVoRFVvT1JZ?=
 =?utf-8?B?WER0b1JJbDIwT0ZNclVoSHBrYnFoMWpBTm1YMmlDQUM0WTh4OWxnY3g1TElR?=
 =?utf-8?B?OGxBRGt4Nk13aFJrMVlxdTZzaUFnT0pYczVRbEVUcGN5VWEwZzczK3BoL1ow?=
 =?utf-8?B?WExkZTFmV3ZoUXBEVFg2bjRvYXRvWk1GMEI2ZGg3RzFySzE2Q1Y2WWlNZzJE?=
 =?utf-8?B?OUdDaG04SEkwb0FkczdjMGpEU3ZjZHBpQS93SlhHTjhxQ3hhNDA4UzFlaWJN?=
 =?utf-8?B?VTFTRllXUDZKdWdrRVBkNVlVREpkYTQydmpOMzg3V2xPQWREUlE4WGtCWVNM?=
 =?utf-8?B?ZFZvYjNKQXl0MHpLNDJ2QUpWY25kbHE4V3F6cno1S1JqbEJWMXFKNFdJWmJy?=
 =?utf-8?B?MldSdFc4T1hYd08xS3JYc3VvR1pZUHNBMkZEU2FCQ3RncjN4YTNrZ1BhR1lM?=
 =?utf-8?B?ZE92WjZOK0RYLzNGRkpuUkVvUlpyTnY2SStWdkRCR05Gc3ZrZmJhSkZZL2w3?=
 =?utf-8?B?bHl0K2haVkhqM3NVa2RmSXBQUnZwU1hldjZQUWgwNG40TXZPY1lVVHAwYlND?=
 =?utf-8?B?TWtVQkdMZkdQbUJReXdFSUhHUFRBU202VGdrQit2emtUZTBvWVpSVDlGL3dY?=
 =?utf-8?B?SWp4UHVhajByNlczQmVGSlFmN2FXNEQzRjErdExQelloRXZLUmNrV05sOW1q?=
 =?utf-8?B?YzRWWlR1RzI4dTc1YngxWlAzZGtTSHdOelRWMHE3WHFkZVNOVmlQUkFzZ3ZS?=
 =?utf-8?B?cHpTcG5rd2VhRCtTYm1XWnpMbFJRUzFJYXRsZlhrSWlpU2ZiV1pYVW1rTHlM?=
 =?utf-8?B?V2h2TEdqNUV5Yi9uTG9JOCs1M2o1TXpkRmUrdXVOWWNMaVlwQktDSVQxZVh3?=
 =?utf-8?B?dUUwZVhjdzM1UW9wZndWZ250dzBhbnFtS3J2QmlqR3puU01OeERwYmFpbktK?=
 =?utf-8?B?OVlDVEkyV2RDSlZKTHpLeFZqREI1OTl1Q3FxcXBMdVN1Vm45SWxwcUw2eStE?=
 =?utf-8?B?a2lmUm1KNHo5eGdpQjBTUVBjbDJJVmlLQ0RpZWRCM1lKa2VjZG5GTWo4aWI3?=
 =?utf-8?B?VXB1WnFLVERCTGE2aUZjZDZidm1aZmJINENBeUZvV2d2TUtQcS92Q2VMSTBu?=
 =?utf-8?B?SGZyU3Erbi9iUmpUZkdPaytLa1lZM0o1b05jYnJhWXJqY0N5MnZnWHE2cndx?=
 =?utf-8?B?UE5rS1JOTjllb0NLMVc1WXVmSGYwS3dSbklCV1lpblVwTkdadnlVaG00NG0w?=
 =?utf-8?B?WnpidTI1Ulg4SkRwSjZrUkhScVlTa3o0bTRhanpXZi9GUGZ6Tjd4NzZ4UFBN?=
 =?utf-8?B?RTZzTmRGbjQzQ0QrdE91MXdmSURkTENnNlptYk1JVURLMEpOV2lvd0ZXeC8z?=
 =?utf-8?B?YUNoSmNBWTN5SWRlSVZlRm91M0R4MjR2U1FqUHdiMFd6RE5XS05BVjJPaEc0?=
 =?utf-8?B?cnkraDk4QzlBNjZYdGxBSXlPbWdmbk1ndHNKOUJQV09IZE5GdlI5ZElqSEFO?=
 =?utf-8?B?MWNJYmVyaTJsOUFWQ3VSOEtvOUMvRTE3VHVDa2wxMGJNN2xlOHdhbHV2UC9I?=
 =?utf-8?B?UEN2Q0hqT1pyUHhhbkVYQ3orNGd2Z2NWUE9vYlVyL1oyZ3M5dndlcmRWcnI5?=
 =?utf-8?B?OFlVakJyMS9QL3RlNDdDMzBKQUNoNW91MVl0d2MwclFmb0dUU3YzekhPVXNJ?=
 =?utf-8?Q?g2KBBufMblLA384lJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7388FC51D8C5BC48B24830C8A5B759BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b000156-2b6c-43e9-a09a-08d93bd5e358
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 14:46:47.6425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jT+yZW0wj0wghxkPFN8vlGjEgEDsasSR/vUHxieLQ+qUGN2DTLqhNXuGDdcrNL+0V8c2xDOvkxiWwXcvx+7tIp0POaSgmi+XP/SrX1gY4hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2267
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQuMDYuMjAyMSAxNjoyMywgQWxhbiBTdGVybiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIEp1biAyNCwgMjAyMSBhdCAwNjo0MDoy
NUFNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMjMu
MDYuMjAyMSAxOTo0MSwgQWxhbiBTdGVybiB3cm90ZToNCj4+PiBBcmUgdGhlcmUgYW55IHN5c3Rl
bXMgYmVzaWRlIHRoZSBTQU1BN0c1IGFuZCBvdGhlcnMgeW91IHRlc3RlZCB3aGljaA0KPj4+IG1p
Z2h0IGJlIGFmZmVjdGVkIGJ5IHRoaXMgcGF0Y2g/ICBEbyB0aGV5IGFsbCB3b3JrIHByZXR0eSBt
dWNoIHRoZQ0KPj4+IHNhbWUgd2F5PyAgKEkgd2FudCB0byBtYWtlIHN1cmUgbm8gb3RoZXJzIHdp
bGwgYmUgYWR2ZXJzZWx5IGFmZmVjdGVkDQo+Pj4gYnkgdGhpcyBjaGFuZ2UuKQ0KPj4NCj4+IEkg
dGVzdGVkIGl0IG9uIFNBTUE3RzUsIFNBTUE1RDIgYW5kIFNBTTlYNjAuIEkgdGVzdGVkIHRoZSBz
dXNwZW5kL3Jlc3VtZQ0KPj4gdG8vZnJvbSBtZW0uIE9uIFNBTUE1RDIgYW5kIFNBTTlYNjAgdGhl
cmUgaXMgbm8gY2xvY2sgcHJvdmlkZWQgYnkNCj4+IHRyYW5zY2VpdmVyIEEgdG8gT0hDSS4gSSBl
bmNvdW50ZXJlZCBubyBpc3N1ZXMgb24gdGVzdGVkIHN5c3RlbXMuIFRoZXNlIElQcw0KPj4gYXJl
IGFsc28gcHJlc2VudCBvbiBTQU1BNUQzIGFuZCBTQU1BNUQ0IHN5c3RlbXMgd2hpY2ggSSBoYXZl
bid0IHRlc3RlZCBhcyBJDQo+PiBleHBlY3QgdG8gYmVoYXZlIGFzIFNBTUE1RDIgKGFzIHRoZSBj
bG9ja2luZyBzY2hlbWUgaXMgdGhlIHNhbWUgd2l0aA0KPj4gU0FNQTVEMikuIEkgY2FuIGFsc28g
dHJ5IGl0IG9uIGEgU0FNQTVEMyAoSSBkb24ndCBoYXZlIGEgU0FNQTVENCB3aXRoIG1lIGF0DQo+
PiB0aGUgbW9tZW50KSwgdG91Z2gsIGp1c3QgdG8gYmUgc3VyZSBub3RoaW5nIGlzIGJyb2tlbiB0
aGVyZSB0b28uDQo+IA0KPiBUaGF0IGRvZXNuJ3QgYW5zd2VyIG15IHF1ZXN0aW9uLiAgSSBhc2tl
ZCBpZiB0aGVyZSB3ZXJlIGFueSBzeXN0ZW1zDQo+IHdoaWNoIG1pZ2h0IGJlIGFmZmVjdGVkIGJ5
IHlvdXIgcGF0Y2gsIGFuZCB5b3UgbGlzdGVkIGEgYnVuY2ggb2YNCj4gc3lzdGVtcyB0aGF0IF9h
cmVuJ3RfIGFmZmVjdGVkICh0aGF0IGlzLCB0aGV5IGNvbnRpbnVlIHRvIHdvcmsNCj4gcHJvcGVy
bHkpLg0KDQpJIHdyb25nbHkgdW5kZXJzdG9vZCB0aGUgaW5pdGlhbCBxdWVzdGlvbi4NCg0KPiAN
Cj4gV2hhdCBzeXN0ZW1zIG1pZ2h0IHJ1biBpbnRvIHRyb3VibGUgd2l0aCB0aGlzIHBhdGNoPw0K
DQpUaGVzZSBhcmUgYWxsIEkgaGF2ZW4ndCB0ZXN0ZWQgYW5kIG1pZ2h0IGJlIGFmZmVjdGVkOg0K
QVQ5MVJNOTIwMCwNClNBTTkyNjAsDQpTQU05MjYxLA0KU0FNOTI2MywNClNBTTlOMTIsDQpTQU05
WDM1LA0KU0FNOUc0NS4NCg0KVGhlIGxhc3QgdHdvIChTQU05WDM1IGFuZCBTQU05RzQ1KSBoYXZl
IHRoZSBzYW1lIGNsb2NraW5nIHNjaGVtZSB3aXRoDQpTQU1BNUQyICh3aGljaCBJIHRlc3RlZCku
IEZvciB0aGUgcmVzdCBvZiB0aGVtIEkgY2Fubm90IGZpbmQgdGhlIGNsb2NraW5nDQpzY2hlbWUg
aW4gZGF0YXNoZWV0IGFuZCBkb24ndCBoYXZlIHRoZW0gdG8gdGVzdCAoYXQgbGVhc3QgYXQgdGhl
IG1vbWVudCkuDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+IEFsYW4gU3Rl
cm4NCj4gDQoNCg==
