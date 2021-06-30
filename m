Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FFC3B854A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhF3OuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:50:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:32017 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhF3Otl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625064432; x=1656600432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xv333fkVSS07Uo/InHZ288HKaJVBTfEg5ePmY/0emhk=;
  b=BZN8sf3XRfMlr2enzNtN7GC5/hjjxlbVbNchCdwdcYVQBRj0UtwzCycb
   Q9phIsYyU/x8o8zsm2Ub0KdA+T/VCwTJcioj7d8lgcgdOJL9oP/jVkfaF
   nP5GmIITUBh+N8gylk0wq6VTp7SKPNTM4aYMI0f92QxA2/PfcCLtYq/9N
   s3s4XAumY1HDov0hx5OHeswXN/f9PdHLPaUwuick68GRU9UmvG+Kb4WHb
   1ikTeIUp8FWXybxtMLlzzZZfRFZo1afFfy6FZ895t0ucWR5naZLrhnK0y
   VoshB7nwGc5tW1ANghzgc3Mu0hDsUy8PNvX6dsryIOr04qnjRQxZszoZ3
   w==;
IronPort-SDR: t3lmdO90PU3uIG/CVdmqPzSxegoyBSehAdN1eHjFMdT1P+taAp9Pw4ClvSxCPJg5pkmkilLaoa
 NG2TwwPgetashDgHGa3+nl9WwZWzVD9LbvYVuId1xMnwXMYUBN1N3vU5oiBLQ//OYB/x2CJEmG
 yEhzTTGAvLVVsI6xSADWVE1RyLCE1CT8FqLqFbpuGTLA+9QVI3+ANcnM9WM1QnvDnZpBktJWRY
 irIblZMqTKCqQgwTkAfrfmIp5h1+sqRicSPRdNE81H06poraFyOOMbaSPMji7NnpqTxLxHnnPt
 b5k=
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="134082358"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2021 07:47:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 07:47:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 30 Jun 2021 07:47:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIkSfivNtd742vQ2U5bhgAONq1evmQ/195g83IBAhEvIB5h1HG0+q4ZpVQ+U36g/a45B8nA7lIfwTPjGc7L8oFSePs4ugMwgwcc4dr0IFaNbkWLfMQwZ8/ywLCghy3jI/WJvuIzk5mXpCjzzNUqnG80Q26xIlnkmC4IZTUSstJkUXd+tcZcegAjiDYurDAe0U6ThaCtYCVDgSBnCt1DxS5z5JOGJP51Tb8D6lMdF/tfkC1fkob5haiFn9AC1wEAqhyZz16cYBjvGuRWvQcH0GEmtW27bxq65DurSYxJnXHjbVnWklqPZ+bgkvjOaT0aaWXjPSqFVzhhBCNbdX05DxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv333fkVSS07Uo/InHZ288HKaJVBTfEg5ePmY/0emhk=;
 b=W4yL28CxpC4edlSsTbAmlz7Tg8oaRdnD2z7Q1nL2t+PrWU8BetbtRWQi9vnTQ50vvOdwfayJo66lw25klO3wdLU0R5LSwf4wH7kiRiJWcow+w/x9gnv5bmMypxNb8ggHF92v5E28L1bL1SQP7r8xJCsudsn09mYSVKPYNpPv3ScZlMg241/OIrhD7uaYUZF6lOKOOpqIfWnCiYvKs2P4ldScoCytsaBsAMQcSzAJlWCt1pfQg+tH+lHOpKijUnFZHoi4vrl2dQxNXkgnuqdv/nR25Sosn7MlwJJ8YKPiCH8MUBhNe7WOrxDnC5NqNhno2KB6lt3hX7JJ61DiXD1XAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv333fkVSS07Uo/InHZ288HKaJVBTfEg5ePmY/0emhk=;
 b=XcjNvYT7wX2n+L5m+ZKBgQYlUR1a3/t50xLoFILoBRAJ3vcP+lh9hrtmAdF6kjCGxmqtFMtB5W36OH8EReSAGNvC4PbX4c2mePNaSjbJPfdwyaVAmRjhxhk6ui9xHGf17UaCkbgKWRIy2eiSRKQNcYH4zO9hCTAwTAk1hzlDUNc=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1577.namprd11.prod.outlook.com (2603:10b6:4:a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Wed, 30 Jun 2021 14:47:09 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 14:47:09 +0000
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
Date:   Wed, 30 Jun 2021 14:47:09 +0000
Message-ID: <b16453b9-e320-5591-0629-00cd9adf1771@microchip.com>
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
x-ms-office365-filtering-correlation-id: e79d67be-a634-4a28-1f80-08d93bd5f08b
x-ms-traffictypediagnostic: DM5PR11MB1577:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB157738E8FBF7DBF597C743FE87019@DM5PR11MB1577.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYXL5PqPPNrc1hJzVVFWHwVS8XX6xYvEEdhrveCVdAe9RRnDtSsRHhg1IysJlu70h6j7HwSriQeQQOEIQp3jl/D7cdJvQ+T88it7frwgzq37AYqr5xhvXLzRFCFOFwStdy56Eh6PC90ml3/B1cNZfDm+2iO/yn7czMRzVMZnt2Gl1+7D4RwQupzvj51YsqAmB9kNt7jtK2X65py43cwsxjwR/Z+1hzF9SrlJ6A2d1UqnYeYdS1CZP0Pbt2iR+N7hanSuZML8LAzbfnGgbL5kbif1yP7Ryh+zHraqdilwdMNtQq44MUrrCEXOH+8+PSiSDnrw7r2VGkNsFgAmyAdNod9LkDcs0EfihiHwMOhryx76KTAJ/JvyO2y7uZwvyD1Cu4m3WECMJVDMMNokHAy3dXO1FkiO+wyh55Vhq8Kp6rxRXp+YIXfjKFbzmuebSHAqXXOU3EJSjenpt+/7gfgXbWHi5KIXLaCBettvR1aCeMp4db+9pL8dIPs86ZTmPob+Vf1s2oFJTKdsfUDB1hLzV+XNzRBxq/iKAYcgSsd3QipRe4DAwLLF/L2Oabd3PsWNSAxOhZAGDbGhYd7f1XNsbu4ZxHbkHiNVfKtTYDDATMSl642wT5BvqZ5SjVrcfODjYQcfz47MYxpUH1zbGB04h8CMUBdoFiGhORHIazHPbzHm9mp4W4XXAFgQJQw8oRsbGnYb2WIGRhf37Ac2beqKwbZ4yA+PSMI8SaLbHxIPxoeT5hfU7A4MB0VsYzVlk0rz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(6486002)(31686004)(4326008)(66556008)(64756008)(66446008)(2616005)(38100700002)(66476007)(76116006)(91956017)(66946007)(2906002)(15650500001)(36756003)(316002)(86362001)(54906003)(31696002)(8936002)(478600001)(5660300002)(186003)(53546011)(6506007)(6916009)(83380400001)(6512007)(26005)(8676002)(122000001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2VmaWNxZ2NXeXpMVTkxcEsyV0lKdHhwcTl1VzloR3RtTjRQY2ZYVG1WcDgv?=
 =?utf-8?B?Z243RnVLVWRiVlI2dmVCR3NobjQ4cWZGczdPci9uTjRrSFBJOHk3TjFsZk1T?=
 =?utf-8?B?M0ZkZDNqY3QzTGttWWp5YTY0L2kvY2hZTVFXNExaZVp5T05HS0lYSTAxRmM3?=
 =?utf-8?B?UFB6dmJVZUNLU244SHZGUVBzZ3RkYjcxckpXbGNJWHVROVl3a2ZTL3FMbUJ5?=
 =?utf-8?B?THpQaU9lRHFnZ1VuOHZTejJsVW1xRmdGemN4WWdjQzB5cStweExZV1pkbVdI?=
 =?utf-8?B?cWY3Y2pwZ1VuY3pyK25wSnFyS3lpVjdERXVabmZJcTZrVG1kWkRqdHY1ZlZT?=
 =?utf-8?B?SkJSREdrc0VRS1p0V2lDcUxaMlcyY09FbnBlTWJ6T1lyd0lESnNPeGVBdi9G?=
 =?utf-8?B?Mlo5Qm1XNXRTa3E4WG13ZmE3NGpWVHh1YWFDUHJJa3dDT0c3ZVcvOTZQY1dS?=
 =?utf-8?B?MWlNSDFQRGYzWmtWRkxxbmlSR21DOEt6SFEwaUxncVoxZVVkbzNCeVM2bkgz?=
 =?utf-8?B?bjc0aFpzQThuc3UxMFVhUG9RaC9FM1J2T3JxMzQ0WVdYVTd0NVRXQjJuS0hr?=
 =?utf-8?B?RHJDVUpSbDJ3RXplbkFpRHFCZFV6YTlKS2VveGViV1JQdjcyUWpvK25KQzQ0?=
 =?utf-8?B?MXV2WWlMNWh5bGJNaHZ2OHZ1Q096UWkveWROUWZDajVTUUJ5WUp2eCtQVlRw?=
 =?utf-8?B?ci9WODEweEx6QXVNQ0J0Z3RDN2RqK3F1bVhVMjhzZUJKb21lNE93bWV0YzBj?=
 =?utf-8?B?VXhKM2x3MHhHNDJkV3hxWWdWeGZyckxVeUZaS2xxVmEvNjNhNXdndkNsRFBL?=
 =?utf-8?B?dXZrUzhQYmJDWTFwMlR5WGVBNzlBNklySmVFNmxOaUozOVM3UStLWVJkdTE3?=
 =?utf-8?B?WUtpOHh4V3pHek5ZSlR6d3g3aS8zcCtwNUsweUJRMWVjMFV4WVRsSVRzQjVi?=
 =?utf-8?B?MmVYOWRkd2tMdThPbktzajd4RzZKVmtLWno0OXNwTXJ3YU54YXdaVjI1VlAx?=
 =?utf-8?B?Yll3Und0Vyt5WXJXNnhPREJFS3lTL2ZtSFhOQnNrbUZabXpTTmNVR3BRcFBD?=
 =?utf-8?B?Z3JKUDdBWm1BTHp6WU01dU82L0REL0IycElLMm1ZZDdzRllINy9NSUxvZ09C?=
 =?utf-8?B?MDlkTlVJZEZRalBKSDRXZ01wdlQ2NWRTSjVYbzltR014TitYOGF0N2lvYjJm?=
 =?utf-8?B?NHQwRjQxWjd6MlFxM0YrWlhrNmwyMXkyb0lsT3h1U0JONWJoMUx2MW5UdWlE?=
 =?utf-8?B?R3RhOGZKUi9pdm1LVVpVU01rdXp4OVoxNURhbFZDV0JrekpvV3BhdlluWXRa?=
 =?utf-8?B?YUJLTXNuNnRTNXRoS3RBWXl2dkZqb1hoM3pCY2dFeFE0SWZFYXdHeFZSbE9o?=
 =?utf-8?B?ZFhFald3QTdnSmZCMjJaVnNEN0I4aFJ4NnRFNUd3WXEvdnJPS3dzQkwzUitI?=
 =?utf-8?B?M1paTGtlMWxWeVowSDBLcFk0K2JOaW1oVHpmZFU5UHpEN1RWdUpYUzhhL2Fy?=
 =?utf-8?B?aDRjdjdNMkdWaCtpNnY2WUwwU01NSjFFRTRZdEgvMU1iREs2SmphT0wraWFN?=
 =?utf-8?B?UkFVaTZBTGs4RG9TRFByQlhLdXFNalFQbEpyNUsrSWpkNVZIZXRGK2xraEZv?=
 =?utf-8?B?TGZPUUVxY0dBNlpWM2dMb1ZLWElvQ3BSVHl0M1IyNUNDKzNNNE41NHJuYTBw?=
 =?utf-8?B?YU1haVJqMXh1TlRCMERGc2h3QlVkL014OGlLcEV1TW85YzdMSnBaMkV0NlIz?=
 =?utf-8?Q?9Gpx+eleNRf+HMRq4A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A3501F2E7A29746AB7922E8BEF6D4A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79d67be-a634-4a28-1f80-08d93bd5f08b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 14:47:09.8418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCqBcGZ3I/kSqka9uTDxISCq8CQxFAAQvrwVJGfsrfJyMWbUdNGuyxV3tZ2Bkav39Tow1zQeMtCkuXkjlsLC37+tnQZ+AEKKl9XLO+UADVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1577
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
aW4gZGF0YXNoZWV0cyBhbmQgZG9uJ3QgaGF2ZSB0aGVtIHRvIHRlc3QgKGF0IGxlYXN0IGF0IHRo
ZSBtb21lbnQpLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPiBBbGFuIFN0
ZXJuDQo+IA0KDQo=
