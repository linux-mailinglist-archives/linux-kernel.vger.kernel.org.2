Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512B54264E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhJHGtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 02:49:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54816 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhJHGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 02:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633675636; x=1665211636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yAqicS0fUHRoL5HGQamhRR7FQbb76eqyvo4yuzdZQcU=;
  b=ppil1uHTfqZtMOGtmFdnvg4Y4umQyCQmqmtGQf85OMJ3mH/nLg2J7dUc
   UqIMx74K/qjbRjCZBvo1PGzA5sQ0zKBlJmrYZUFrt0CfiOy7WkviosiZU
   Q11Fm1ZKAuWr07UllXC6bn9WQ8OQw/GPVoz8dJYoY+b98hUhDyh7P1/x6
   GsMWshZQI2B/ZXo2pj1RVR8+pqxSz5n4JwR/iXpABHNMtPQMiioVNFDep
   1xeZ9BUtSt4RhsNbmGI5QeaQy3ClLQ5uUsOWp5PfoLm/PbLDVS07SmPTt
   UY/MDgrO4UeXs+fE8p/IJhWkmVAE75GP06w9OsTprCBOWmiN175yrzSZs
   w==;
IronPort-SDR: KWj5GvTcMBZ0kHQ3hLOFi9XYKRtwBoVi49NlTRTxXqxr7zp3MEDTtfho5hQWzF3e8K7EsxE4Ys
 NH8NjXllwyLyJK99vCuG/5knqKa4VAyAXSKY+wU2rq5ut2cgvgmIAlzis+egnRWHnsnZtHCFi8
 txDuUGpdPY5WXWHc/AI3wdtTT3+jR+6iyhHudHQIC9Cpgz9Wu28bnN/SGhQq40bHNsJkePDK8V
 yPlPZ0JFi2AfjHjDgKjeliixA3siSqFflDT93fpxrmRndd/tik4J79xnah88hUsMGjiAWR/+LP
 osfXc9IHTcWceojOlH1bdCe0
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="132165501"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2021 23:47:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Oct 2021 23:47:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Thu, 7 Oct 2021 23:47:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NswYCb52kxcwAV4Izkm92zL8LD6bhnKNpPo+naj1q6oNKCMarvAGeC4XZ5IU2n0XuTjzA+h51esUb5UMlnQeTppRP4UR1ePK/Fr0m6itaOgIAfmRoXk2a2atU9475R8EPFD3m9swsyyLpXLbd/bNq5WMpQDqixAIZVzlX8yeSpZ5rdGXa7pAMuZljDJ5O7pi6MTEmql2hQwnFSyBTeexh/16y1OS5scrn14fvUQ3KZG4EgW8kwS75zq0a8ypdrqp29stvfYBhtDha0EtjH+sSQnfpqFDj7yz+n852qbHeMdu0pcGAsTd0SEVfkfFB9zUhkxaX7dEeantqo/FEYlbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAqicS0fUHRoL5HGQamhRR7FQbb76eqyvo4yuzdZQcU=;
 b=QKjuBrNstIIIJiP7NPj4p8ipY9HL9BZmPVIVI2GcaRrOwx4QfFkC6zzyK1RF4ojryIe/FSE7pHyZfpHsypf7oNBFImRHeGJ32hi8/FesO7/1qSVoKTlHSCaSUfZYC4UmLtZQm/vltipABCe/jyQtoXEpUrMcw9Rne8ItUUhCn14URV/pa6i20vAxKC8CTeu7bFbarAlfFohFUqldnhVyKhBt8w91dWjR4fQIVoASbpuuRlds5+z7Vg+ug1ltcc56ZGpYN9SrYcZ6VKHofIkEfx++GOiXZpTKM3N2Lv5fAAe5PD1rYvLGh7SvRcZm+shjUKH+wdAGgmYcis9DAAXvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAqicS0fUHRoL5HGQamhRR7FQbb76eqyvo4yuzdZQcU=;
 b=e6B6GvqK/4UYTHVsA7geDdr0JKTbHwsM8L1CE4wxAtFdjzbA5RNBoZ/Ay0AoYlTHUVQXPmHLi6AsnC9R1Yh4aakqxe6ubwKWlpdjgnVw6v10397G4xNRKVIk3YI/B9aFA8hHYmavYUkjhIKwEc9Lb6K7cgoRxPwGdq4GQpXnSSY=
Received: from PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 06:47:14 +0000
Received: from PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::a16c:b728:8048:af80]) by PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::a16c:b728:8048:af80%6]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 06:47:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <mturquette@baylibre.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/17] clk: at91: pmc: execute suspend/resume only for
 backup mode
Thread-Topic: [PATCH v4 02/17] clk: at91: pmc: execute suspend/resume only for
 backup mode
Thread-Index: AQHXvBBTJGQvtKkCiUSu7lQ+SsybDA==
Date:   Fri, 8 Oct 2021 06:47:14 +0000
Message-ID: <3ac4d209-58a7-60f3-a3c1-7a44407bac03@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
 <20210923132046.1860549-3-claudiu.beznea@microchip.com>
 <163366509609.2041162.16407625879723979586@swboyd.mtv.corp.google.com>
In-Reply-To: <163366509609.2041162.16407625879723979586@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f134e4c9-02f1-4ed1-b913-08d98a277641
x-ms-traffictypediagnostic: PH0PR11MB5143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB514301706DFC08AF5667064A87B29@PH0PR11MB5143.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c+MeDagl23mrGV91YaE7srT9w97ptP8W14jiSiqFL7+/qzqgeoIBqvUTNnC/4nGv26q3q8ysiTMDu6Iw3nHNtaIAyqGsBZ4WDwgsZxSP9fJ6R4jF7jB968jO45CyWgwaGZ7Q0gmGnwSm1x6ys3ZdkfqWjizSEUJbN0VqSlvZIXcBkUUMrCApwBopkZ06V6ltfLH7U0LeH1bAoOzFVxvjT43f9VjG/bUf7mMM1/sgnW96Jpy9AB+gqxbmXhJhOOXOOJxCq3sV5c+wfOnRTrhb1YbsCoqDQ06Ol/83H6mQJYjE2D8PYi6tNRT4Kyi5Klf+m+fPFQaw5dIy/1tVMpVcw4N/35jlDibVIbEnfmaj3DQasXP/VtHCSrVHOwsqXAVe0WHZw9uMCdZiDqla8XXzn0xXYEFBXwck5cDSKw9AS00tBCAohNMzopW/PakaO5lR7a2ctd483Crva6W+sxyaCWrwkMNJNraZp7za5wlXq1IJc+P6sD9G2CnopNx+XFxAPQcbkGxcXHEUtvubGejfZaJ9XbTCOAiPw5fd1NeTZ3qntO6xPv7+Zyj9UIlBOdWK7qkOU29DXVdd+n+wcWh0gTXwW/mK8+UzuPMOVEOzINR1m3TfuXCrWmAaAYVyvTwnV1fFfPOBtfn3A8iBQtG5c9kBC/DyMmE3yC8YKnqmaJQcR0IRHWnL8156v7sVV+vONcc0NAbwqPxhLrWldYL47SQDjVf8F+2miAlMzB1xNUjQP8qJ+gND8ncW37fCQHVSrAfihXJjcJUgndqYRewHqTTuKhX89Kp1u9ThA9pO1d+6Vsc6X7KPFjC92g2VD5pwHHHORm64O6K1Y+eZoph07bkXtdPOot+mXAH1UzMTc/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(84040400005)(54906003)(5660300002)(110136005)(316002)(91956017)(8676002)(66946007)(64756008)(66446008)(76116006)(31696002)(966005)(8936002)(86362001)(66476007)(66556008)(38070700005)(15650500001)(508600001)(31686004)(186003)(4326008)(2616005)(6512007)(2906002)(83380400001)(71200400001)(122000001)(38100700002)(6636002)(36756003)(26005)(6486002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU52OWtJUXBlQkF2eDU0Z01JZDlEUVhqNFlQVWFUL242VURNVmcwcWpuLzBG?=
 =?utf-8?B?RCtwT1ZQT2R2Z2lsUXlWRVpZcFRIUW9HRXlWbWltVFZDam5hdzkxOGRYR1Bx?=
 =?utf-8?B?WVp5TVArb1ZKNjlHODlTZlNEMzN3WmJ2RWlScWdwdlQ1VTdwRGJQYnFCcWZq?=
 =?utf-8?B?c2d2cFdsM3h3bkg3d0pBenN2Zmx5L0xoUE55SlZsN042WGNLZmY0ZURSWm4x?=
 =?utf-8?B?Qk1DSnFocCt0aFVYQ3RoejZlb3FXMXVUdmJKbUJzL05aSXBrZEhwM2d5VkZi?=
 =?utf-8?B?R3dCcStzaEc4a1QwajZEVHliRStXWDYvNU02TGdObmpZcEZVRDJsTzlCc2gw?=
 =?utf-8?B?ekIrZTZDVEdFeGJEQy9FTGxwVVdUbGlYSWltSmhtTjBvTTN6MHo5QmNuYXhC?=
 =?utf-8?B?K00zamlDM1BiNHNlb2tuTEY0YmIzVnlZNWdHNXlVOXpENnhSK21QbkNHeXgx?=
 =?utf-8?B?TllKRUpPK1lDa3JueTllQk9rMmxlNFlzclB3Vm95c25Sdnl2K1Y4MUd2YkVL?=
 =?utf-8?B?REg5clBTSkhzcVMwVktZcFJXRVJnSmhrQlNNaENURmRrVEVMamo4VG1ybWk4?=
 =?utf-8?B?UVAyMWhPOXMyWFF6b2QrNi9KdHhPVy92a1pqd04xYThWSkZTeGdLaWRKbE5J?=
 =?utf-8?B?d01oK3h4TzN5cnhiSGE3dkh3UG1HT1NVVWtvNnoyanVxbktoS1pIbVVoNldK?=
 =?utf-8?B?T2s5alEzNlh1RlRWSTgva2ZoMmtUOTBoa3FxZ05LTTZKTEcwbVVJcUJqaC9G?=
 =?utf-8?B?WkpVQ0JCZE03RS9LN3BySnJYSmtVcnFLT3krODMreGNnenNWTzBnQThTNk1x?=
 =?utf-8?B?VTM5OVl1SWZ3R2FoMC9RNEVSN3hZa0loVUNVWHh4cWRVZnUybGVJbnVONEkv?=
 =?utf-8?B?ZlE0NGJ2c3FSbjFUZWo0TVdxN1dmQ3cvNnBZMWw2d1hieDNUajRxWlQxRGI3?=
 =?utf-8?B?TUZyYS9jSU1uRjZRd0htQUREQ1dEN0RZTXZvTjgvSGVHck5zRkNmZlBORWpW?=
 =?utf-8?B?RTVEdE1CYWgrR01ZeHBzc2xWMTRreklWdG1TUExsRzNIM1hrZFZGOTI3Wldv?=
 =?utf-8?B?Z2ZKeVlyRVpBSmZub0ZpYWR4Zi9DUUJna1MyRnNEUEwwZEY1R3ZRbmo5M0F0?=
 =?utf-8?B?eFlMYjRkbkk4UXJRM1J3NG9TWTVYVThFeGpDOFVwd09TVlpoSEFBdnhtc09v?=
 =?utf-8?B?V3NJRVgxQmhvZ2dEWFpsV2x4SEFMT1AwTXQ2citqR0MxVUFMbmFpcVA0bHZS?=
 =?utf-8?B?dW1ZVHhVUFlwTm1BNFlHWW0yWVRFS292Mk1oVjladmlFTkFORDlHcnBZK2pL?=
 =?utf-8?B?M09NWWxXakIybFVBRUJBa2tBc2Q5MWkvMjhMTWNUYVRWUm1sV0gzUFVlZ0Fq?=
 =?utf-8?B?ZzhZRWROVkJFMVhRbTE3WHlrSVQ2Mm53K3RuYkxnYTliSHBlNTNaWWFsZGRw?=
 =?utf-8?B?K1VKM3FaZXExNlN1THJBY3BDNk14MEx4am1VUXNnaUR1UlJYM2tKTENRSU5W?=
 =?utf-8?B?THFnQnZiampLVGdKWDFuUEpjK2lQVWlmWFR5dFRwNWJxbFlUajF5b1gvWE9k?=
 =?utf-8?B?SjgrZlpxd2l1dDZhNG54VjZjdUxhY0wxYURVWVprOWw5NGI0TlJqM29laWdJ?=
 =?utf-8?B?QVZ1Wm9IYjMrbU0zSFpiTWFFbVY1aThUWW9kUmhFcGo0MGdka2hmUEp1MDVa?=
 =?utf-8?B?eEUzMDZrVUZvUlZDRXdVN3lNYzJ6bTNBY0VHWGpLRzlseVZpU1JBT3lIWS93?=
 =?utf-8?Q?BGJyyP9tWy95DltPOU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E11C08BC190044C93828B42D73F7A17@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f134e4c9-02f1-4ed1-b913-08d98a277641
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 06:47:14.0887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wktMATa0iVINX6MR4CC8osGLtX2CPAHDpe6tcSPf5wzfX9QNT/IUAwE8BgVm/CLiF+1yHUVl/LUol/I+Ff/5x8w6ZKFXOrN1xV8urAp/cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMTAuMjAyMSAwNjo1MSwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFF1b3RpbmcgQ2xhdWRpdSBCZXpuZWEgKDIwMjEt
MDktMjMgMDY6MjA6MzEpDQo+PiBCZWZvcmUgZ29pbmcgdG8gYmFja3VwIG1vZGUgYXJjaGl0ZWN0
dXJlIHNwZWNpZmljIFBNIGNvZGUgc2V0cyB0aGUgZmlyc3QNCj4+IHdvcmQgaW4gc2VjdXJhbSAo
ZmlsZSBhcmNoL2FybS9tYWNoLWF0OTEvcG0uYywgZnVuY3Rpb24gYXQ5MV9wbV9iZWdpbigpKS4N
Cj4+IFRodXMgdGFrZSB0aGlzIGludG8gYWNjb3VudCB3aGVuIHN1c3BlbmRpbmcvcmVzdW1pbmcg
Y2xvY2tzLiBUaGlzIHdpbGwNCj4+IGF2b2lkIGV4ZWN1dGluZyB1bm5lY2Vzc2FyeSBpbnN0cnVj
dGlvbnMgd2hlbiBzdXNwZW5kaW5nIHRvIG5vbiBiYWNrdXANCj4+IG1vZGVzLiBBbHNvIHRoaXMg
Y29tbWl0IGNoYW5nZWQgdGhlIHBvc3Rjb3JlX2luaXRjYWxsKCkgd2l0aA0KPj4gc3Vic3lzX2lu
aXRjYWxsKCkgdG8gYmUgYWJsZSB0byBleGVjdXRlIG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKCkg
c2luY2UNCj4+IHRoaXMgd2FzIG5vdCBhdmFpbGFibGUgYXQgdGhlIG1vbWVudCBvZiBwb3N0Y29y
ZV9pbml0Y2FsbCgpLiBUaGlzIHNob3VsZA0KPj4gbm90IGFsdGVyIHRoZSB0Y2JfY2xrc3JjIHNp
bmNlIHRoZSBjaGFuZ2VzIGFyZSByZWxhdGVkIHRvIGNsb2Nrcw0KPj4gc3VzcGVuZC9yZXN1bWUg
cHJvY2VkdXJlIHRoYXQgd2lsbCBiZSBleGVjdXRlZCBhdCB0aGUgdXNlciBzcGFjZSByZXF1ZXN0
LA0KPj4gdGh1cyBsb25nIGFnbyBhZnRlciBzdWJzeXNfaW5pdGNhbGwoKS4NCj4gDQo+IElzIHRo
ZSBjb21tZW50IHN0aWxsIHJlbGV2YW50IHRob3VnaD8NCg0KRm9yIGFyY2hpdGVjdHVyZSBQTSBj
b2RlIHllcywgdGhlIHNlY3VyYW0gaXMgc2V0IGluIFsxXS4NCg0KUmVsYXRlZCB0byByZXBsYWNp
bmcgcG9zdGNvcmVfaW5pdCgpIHdpdGggc3Vic3lzX2luaXRjYWxsKCkgdG8gYmUgYWJsZSB0bw0K
aGF2ZSB0aGUgcHJvcGVyIHJlc3VsdCBvZiBvZl9maW5kX2NvbXBhdGlibGVfbm9kZSgpIEkgaGF2
ZSB0byByZS1jaGVjaw0KKGRvbid0IGtub3cgaWYgc29tZXRoaW5nIGhhcyBiZWVuIGNoYW5nZWQg
aW4gdGhpcyBhcmVhIHNpbmNlIEphbnVhcnkpLiBJZg0KeW91IGtub3cgc29tZXRoaW5nIHBsZWFz
ZSBsZXQgbWUga25vdy4NCg0KWzFdDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9hcmNoL2FybS9tYWNoLWF0OTEv
cG0uYyNuMjkwDQoNCj4gDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNs
YXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9hdDkxL3BtYy5jIGIvZHJpdmVycy9jbGsvYXQ5MS9wbWMuYw0KPj4gaW5kZXggYjI4
MDY5NDZhNzdhLi41OGU5YzA4OGNiMjIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2Nsay9hdDkx
L3BtYy5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL3BtYy5jDQo+PiBAQCAtMTEwLDEzICsx
MTIsMzUgQEAgc3RydWN0IHBtY19kYXRhICpwbWNfZGF0YV9hbGxvY2F0ZSh1bnNpZ25lZCBpbnQg
bmNvcmUsIHVuc2lnbmVkIGludCBuc3lzdGVtLA0KPj4gIH0NCj4+DQo+PiAgI2lmZGVmIENPTkZJ
R19QTQ0KPj4gKw0KPj4gKy8qIEFkZHJlc3MgaW4gU0VDVVJBTSB0aGF0IHNheSBpZiB3ZSBzdXNw
ZW5kIHRvIGJhY2t1cCBtb2RlLiAqLw0KPj4gK3N0YXRpYyB2b2lkIF9faW9tZW0gKmF0OTFfcG1j
X2JhY2t1cF9zdXNwZW5kOw0KPj4gKw0KPj4gIHN0YXRpYyBpbnQgYXQ5MV9wbWNfc3VzcGVuZCh2
b2lkKQ0KPj4gIHsNCj4+ICsgICAgICAgdW5zaWduZWQgaW50IGJhY2t1cDsNCj4+ICsNCj4+ICsg
ICAgICAgaWYgKCFhdDkxX3BtY19iYWNrdXBfc3VzcGVuZCkNCj4+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4+ICsNCj4+ICsgICAgICAgYmFja3VwID0gKih1bnNpZ25lZCBpbnQgKilhdDkx
X3BtY19iYWNrdXBfc3VzcGVuZDsNCj4gDQo+IFRoaXMgd2lsbCBmYWlsIHNwYXJzZS4gV2h5IGFy
ZSB3ZSByZWFkaW5nIGlvbWVtIHdpdGhvdXQgdXNpbmcgaW9tZW0NCj4gcmVhZGluZyB3cmFwcGVy
Pw0KDQpCeSBtaXN0YWtlLiBJJ2xsIHN3aXRjaCB0byBpb21lbSByZWFkaW5nIHdyYXBwZXIuDQoN
CklzIGl0IE9LIHRvIHNlbmQgc29vbiBhIG5ldyB2ZXJzaW9uIHdpdGggdGhlc2UgYWRqdXN0bWVu
dHMgb3IgZG8geW91IGhhdmUNCm90aGVyIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgdG8gcmV2aWV3
Pw0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPj4gKyAgICAgICBpZiAoIWJh
Y2t1cCkNCg0K
