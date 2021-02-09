Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3422A314BFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhBIJp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:45:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22477 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBIJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612863825; x=1644399825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=irYeTrNUm3eS49z5RDvBQ3G/cM8fCXK3aRqSCzUvP2M=;
  b=dIwxL6tDSliWkPqlzyCAZpe0bq2397fhrM6t4WSvOQBpxJ25mt0bTMJN
   n+juv0LvCk31qEYxOLlHUWX4LNC+babwh8L3G+l4bHTPb/KBuUqUGhCa3
   01ig2SIU2PPsKX6BbwwzGDiT1QRdobwkBFwnLONUgEc3uxmGIm8TExNqN
   rWdnXx4/YJHkhyWtwU+3wIoYk0y/lCP9Dshqa6Igp0VU0SeCL7z4Dwqjc
   xezwEw2UREV0wu2XhJlT3qSM76D2xuPl8brXZBiuidGN8pxegGWiykHVE
   GuH1bA9dbg5wObLous24i5UN0wP8ARhd5ic964pRlo3E05JfWhrpVlAIX
   Q==;
IronPort-SDR: EdMDSoErt3e247Iwitaw2dSwWle8tPjwsQbrq73VWLNT1oLeVlH8/eHYuv7QrKytX8sS5Ap6Yd
 ZwEPwSqoHl1A7kzvr9sZTS2wJ6VJizPEBbh5jNJNvQxjfrg1bSLFZz+C6zU53TNv0CZ+Jz0Fep
 LEBFeR8iJyun1V11YEYmAftdqGL21ProEzAgKdi1OVuXKduhB8CPqxs6LoiLZH9tJ8HuSJ4AKJ
 6a39tolf+L+ZrAMh79SVTImhq4YbjoYR65EGjr04IzfkstiMJIqa6Wj+oMTRg1DM0+Nl+qtFr5
 CdE=
X-IronPort-AV: E=Sophos;i="5.81,164,1610434800"; 
   d="scan'208";a="114358618"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2021 02:42:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 02:42:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 9 Feb 2021 02:42:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO5XutWkCTqUI/oDQPJyv1ExhmGkMOBxHDUc69FgMgohAZsi9NYy6kqnfEf+Ur1Go3cdKRwLij8T98830TrSvQxGOtGYahPm1d1gNQZzgviDF1eLxGyJzPmt+wcqApHtZXN77YGesDCawKeregxZ9ruxhTp5kEItDNdA4b0DdjZOPibS0vAoDQXaTfx+jYdQeHD68QzRsOQn76Jtiy6x4d++AAmNqtf2wAI4WIVVNr+KNs7cxbU9fXoeoNnfSXFNPRvF3zfp/s/Hrs6Ohl8mq0A54bsT4HhdLVii9xi+zfZFjhdCFBfAbNRj0AYvmzyj2TmM1GjTBGJBsNI8XkeXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irYeTrNUm3eS49z5RDvBQ3G/cM8fCXK3aRqSCzUvP2M=;
 b=WuKuHTBsTCedOj89W631V36lXr7euNnRaGFLJHMSAcNWNI6oRYB3MHSD+zRQLrE85n/OR9u4tezOTQAZKZuEP9OHpd6MJv/1s6MYG01MQjwCjAt+or8dN03FDB0Un7ugaoVe0SFpP2qAhJAZk4ivGN+jo0hfqceXFCCM/G9wfGcyFMBrUe21TAAbi28JsI/2+zix7olLP/e1Fbk5qt04ujDevjKLmx2LeqhZnDY5tsFrmrlqvX2IwGhgbfSwOWUWkRRR7mkIIBYHLA6ZTlI0cDMpSAeiBb+7uugQ4IJ47srJQAc8ix3UYQM/EqpMr5Rx2RHlNgBglGMT/1XC1PqS0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irYeTrNUm3eS49z5RDvBQ3G/cM8fCXK3aRqSCzUvP2M=;
 b=aAC3fZVY9uzUd0+cxVm8LYaCfbP+gcqb0zDJ/U5YnGwBvVQnN1fC7sLFv3+vBYCiLtI7YdnfDmkceutt+Mt2GOWJlGJIKBN9d9i/R9nDhela+DUtKTtOp+D+bZRihH3kWePTBIUZ/ac6Phx1rx8R58caycvakNmFS3jXm4KtP9g=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3101.namprd11.prod.outlook.com (2603:10b6:805:d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 9 Feb
 2021 09:42:26 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%4]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 09:42:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sboyd@kernel.org>, <saravanak@google.com>
CC:     <mturquette@baylibre.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <mirq-linux@rere.qmqm.pl>,
        <gregkh@linuxfoundation.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
Thread-Topic: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
Thread-Index: AQHW/sffM0xRwyNg8kaFXOuETguw+A==
Date:   Tue, 9 Feb 2021 09:42:25 +0000
Message-ID: <3a6de99c-00f9-875f-a7b7-46073e6b1fa7@microchip.com>
References: <20210128104446.164269-1-tudor.ambarus@microchip.com>
 <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com>
 <161285731192.418021.10555916396092570051@swboyd.mtv.corp.google.com>
In-Reply-To: <161285731192.418021.10555916396092570051@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6901358f-d109-4002-1de2-08d8ccdf0242
x-ms-traffictypediagnostic: SN6PR11MB3101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB31015089520A109F66CB1BD6F08E9@SN6PR11MB3101.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: STcylB9O/0ZZ9T/h/hliDWjX5UDPO9wySqOmy66ci6iu0FIvBaryeOj6DIeKr3bsEDHKQEMzz3pgefHPw9jCf1Xjz4t9p5C4XjKKsD1Ftkh1naj3ts5kFHR+6UNA3pLYxttRHCOICc8QpE3gIydjwZ+J4ymGAeneTJZUbzjOTI9Eop9Ohv0VV49/WDY54AqG+c3rAdKkGtdvwaagMRHDc3notjF8F3FXkNqUlQw738Zkd2OmIf3ah8W7QcynaUIklckweCVW+Kr4s3l6X4/+Qe1PU/7uJ8zUhP0Vjrb1oh4TBEqarsYfD2r0+BjRCpfMv1MmW1dd4v1FsimZXFsBN+xM9lMOroY3Db6kuFXNMR91EqrJOkj/SzBiX2nmTLGIkkcFvh0I8q5+AxQzfGqKTtNJr5xYg7BrYhZhMaL+3dU8GsC3cEDDd+5mnbemqjiCm5Dt0FG2KXbbzEcAbzscgMy5GlY9Z1eU2drruvLdV0UOsKnAiQM+9n8b8DcZ0+IsjzzOHjV29p3Dd5CsIQGhGPwMcPBuYHnL2CmjEhmHs4ngSZCUTQetUoDv1JXawD0mha7ebxr27cQSiiJlztSs7OXzRqVfJYBagwpYFQzS+qTnTKbm2J3eoPN6rJNnx3HlyNGQMGB1sfjHuPkLDM8k6kFS6qbsp0+o49EUwgBEFzzi0ih5a8hvsbYLIHNWghuC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(396003)(376002)(5660300002)(66446008)(966005)(4326008)(8676002)(6512007)(54906003)(66556008)(66946007)(64756008)(66476007)(86362001)(53546011)(316002)(6506007)(91956017)(2616005)(478600001)(2906002)(83380400001)(186003)(76116006)(36756003)(6486002)(71200400001)(26005)(110136005)(31696002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Kyt5aXFDZjVVMkpkdktpWWR3THR2S1FpZXhzY1puR0ErVDVHQmt2MUVmRXl0?=
 =?utf-8?B?ZjFXVmpibmJyWEJraUxNWDVwVVBKbFdETHpTdlhmTEtSaW9RcDVndXRna3Z3?=
 =?utf-8?B?WkxRWGZVaDN0YW1EWHJ3NFpiL2JJZUsxU0NsR082Rnp5aHZibFBMVGo1djdo?=
 =?utf-8?B?VnRvcjVjbEF3cGREaFg4M0hzL3Q5TFdLRG13MXg5Sm1rYUhtWUgyRTZhVEti?=
 =?utf-8?B?QVBzSnorcDdCbWI0eEJOTGZsTVplWWhDY3hlcXBHYkt1TXhQVExpZ2JDbHFr?=
 =?utf-8?B?RXN0Zk1wdzAvK3ZMMURVcTRkQjRmUm44M1A2ZDlrSmJiaFdNeXIxbjVRZVRK?=
 =?utf-8?B?ZFVJVnFLY1N5V1MzK3dEaXRYRVdNS2JEOGtZSm9TclZIQ1c5QmFvbFlHbHBj?=
 =?utf-8?B?ckM3U0JKVzZkOVdLOVlnV25HenNwTnZuUThjT0RseFAwb2tqSFBCUkZQWW9s?=
 =?utf-8?B?VjZ6K1pLYk5CdGJ5ZkJTK0JibE10ZWcrTlJwemVnbHNEQ2dkempvVnY2OGNY?=
 =?utf-8?B?TnUxd1BvUS9tekxsU1VLeWNvM2pmeWxQdnFCOGQ0aTJiUThiSlExdGhDdVBY?=
 =?utf-8?B?bHBxeTdaRkRSNkEwWG4veVphM1ZsbnczLzhXekY1MXUwdUdMSlZaSHhsa3BQ?=
 =?utf-8?B?WXlMbHBoL21vNnN6VjRxcUlGVG5HT0IydWFteVhoMnZwNzVIWlR0NXQ3bWY2?=
 =?utf-8?B?Tms3UzhaUGlPZGd2TlAyMGdRWlpYRmF5NEtLeWw5a2c1eTQyd2xFOWRpYUV6?=
 =?utf-8?B?QVVoYzVMbHBQSmJmVmRTT1BEa1VqUEk4M0lmbEdBYWFjQjMzMjE5ZjkrN1dK?=
 =?utf-8?B?TElVWmRLRDNGaDRUUStCV0VXdVFKNlhJS3dzNEFXWWhxQ0kwRnhSU1VVMFVO?=
 =?utf-8?B?aUtQbWVqdm1CbmVSNEUxV2VTMDhVM1AzbHMrUVNrUVFyWW9Ca3VXUkF5Zmgz?=
 =?utf-8?B?TEhWMHVHVVNsdVpyVDh1TGtxVGRZS2NseUVhZWs0RlZLWHpQN2lTUm41emxS?=
 =?utf-8?B?LzBpd2tJUUJMcEVENU14WUo4S2c3aFdnbCtGdk1yY0tORGZxaDRqU01SaHpC?=
 =?utf-8?B?WFk4c1gyRGl3emMxWG50YnBTUm84enBmZkhqVnErZE1RaFZGVW5oYXRYdjQz?=
 =?utf-8?B?WC9MZlpwWS9aTysyR0h5QzEwR2NhSURERkFIVll0dTNDZGR3d05qSm8yTFhy?=
 =?utf-8?B?WFBrZ0hJS0o1YWozWHNOWU9IRXFGYndYLzlIdzdlQjdlcVpTY3JNc2wyQlUr?=
 =?utf-8?B?L1BsTk9tOUlIQ0FseGJNM0NnRTdWa1VhY09BdjNnSUlrWExYclFhVFJjOGdy?=
 =?utf-8?B?REtjUlRmR3UrUytlZ1RDelpGODEvVXZBWHF2Sm5zZmNXMzhuMU4wZTBlQnNT?=
 =?utf-8?B?OVlBOGxWRVFRQklEcTM3dy9FWmt6WEFnM0Mwb0F3U2NUK2Vjc3JoYThRc2ph?=
 =?utf-8?B?d3JFanJCV3lpRkplcnQ4K2tGMzVadFZaVmxsRER3ZmpWM1ZSTzRZYmFSc0lD?=
 =?utf-8?B?THg3RERTaWFEZGFvaUxFdmNXMzJUa21YaUxDRUQ0dVlzVEJYYmJYeHNFbnBT?=
 =?utf-8?B?Q0Eyb0d1ZVJMV3ROMzRqYkQ1R201K093ZUVNaU12UVdSVGl4SDRHVXpiK2Z5?=
 =?utf-8?B?VUNyUk5BbjdHcm1scjF2NWEwT2FDa3F4Q2FiSzBXWGFaYmo2cDNUaGUrbGIw?=
 =?utf-8?B?amQwOTVIaVcrOHBKbFZOWG90U0ZMQzl4K3NJTUs0WG50WDU2dXFRRGFtcE8w?=
 =?utf-8?Q?xHui3fr8XuhzcJeP/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EA327C440B3194B9354857B43EBF3C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6901358f-d109-4002-1de2-08d8ccdf0242
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 09:42:25.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLK06WEp9kN3/GJ7XrRlSE6pbjtQnSE7veMxrhbBVSA5bx3ic/jysBH0t4jFlcP8HtG/4Y/2zzksjBuOV3NUG/p7+bFn3f9JtsekTnLiqG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4sDQoNCk9uIDIvOS8yMSA5OjU1IEFNLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gUXVvdGluZyBTYXJhdmFu
YSBLYW5uYW4gKDIwMjEtMDEtMjggMDk6MDE6NDEpDQo+PiBPbiBUaHUsIEphbiAyOCwgMjAyMSBh
dCAyOjQ1IEFNIFR1ZG9yIEFtYmFydXMNCj4+IDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+
IHdyb3RlOg0KPj4+DQo+Pj4gVGhlIHNhbWE1ZDIgcmVxdWlyZXMgdGhlIGNsb2NrIHByb3ZpZGVy
IGluaXRpYWxpemVkIGJlZm9yZSB0aW1lcnMuDQo+Pj4gV2UgY2FuJ3QgdXNlIGEgcGxhdGZvcm0g
ZHJpdmVyIGZvciB0aGUgc2FtYTVkMi1wbWMgZHJpdmVyLCBhcyB0aGUNCj4+PiBwbGF0Zm9ybV9i
dXNfaW5pdCgpIGlzIGNhbGxlZCBsYXRlciBvbiwgYWZ0ZXIgdGltZV9pbml0KCkuDQo+Pj4NCj4+
PiBBcyBmd19kZXZsaW5rIGNvbnNpZGVycyBvbmx5IGRldmljZXMsIGl0IGRvZXMgbm90IGtub3cg
dGhhdCB0aGUNCj4+PiBwbWMgaXMgcmVhZHkuIEhlbmNlIHByb2Jpbmcgb2YgZGV2aWNlcyB0aGF0
IGRlcGVuZCBvbiBpdCBmYWlsOg0KPj4+IHByb2JlIGRlZmVycmFsIC0gc3VwcGxpZXIgZjAwMTQw
MDAucG1jIG5vdCByZWFkeQ0KPj4+DQo+Pj4gRml4IHRoaXMgYnkgc2V0dGluZyB0aGUgT0ZfUE9Q
VUxBVEVEIGZsYWcgZm9yIHRoZSBzYW1hNWQyX3BtYw0KPj4+IGRldmljZSBub2RlIGFmdGVyIHN1
Y2Nlc3NmdWwgc2V0dXAuIFRoaXMgd2lsbCBtYWtlDQo+Pj4gb2ZfbGlua190b19waGFuZGxlKCkg
aWdub3JlIHRoZSBzYW1hNWQyX3BtYyBkZXZpY2Ugbm9kZSBhcyBhDQo+Pj4gZGVwZW5kZW5jeSwg
YW5kIGNvbnN1bWVyIGRldmljZXMgd2lsbCBiZSBwcm9iZWQgYWdhaW4uDQo+Pj4NCj4+PiBGaXhl
czogZTU5MDQ3NDc2OGYxY2MwNCAoImRyaXZlciBjb3JlOiBTZXQgZndfZGV2bGluaz1vbiBieSBk
ZWZhdWx0IikNCj4+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVz
QG1pY3JvY2hpcC5jb20+DQo+Pj4gLS0tDQo+Pj4gSSdsbCBiZSBvdXQgb2Ygb2ZmaWNlLCB3aWxs
IGNoZWNrIHRoZSByZXN0IG9mIHRoZSBhdDkxIFNvQ3MNCj4+PiBhdCB0aGUgYmVnaW5pbmcgb2Yg
bmV4dCB3ZWVrLg0KPj4+DQo+Pj4gIGRyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jIHwgMiArKw0K
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMgYi9kcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIu
Yw0KPj4+IGluZGV4IDlhNWNiYzdjZDU1YS4uNWVlYTJiNGE2M2RkIDEwMDY0NA0KPj4+IC0tLSBh
L2RyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jDQo+Pj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9z
YW1hNWQyLmMNCj4+PiBAQCAtMzY3LDYgKzM2Nyw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzYW1h
NWQyX3BtY19zZXR1cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPj4+DQo+Pj4gICAgICAgICBv
Zl9jbGtfYWRkX2h3X3Byb3ZpZGVyKG5wLCBvZl9jbGtfaHdfcG1jX2dldCwgc2FtYTVkMl9wbWMp
Ow0KPj4+DQo+Pj4gKyAgICAgICBvZl9ub2RlX3NldF9mbGFnKG5wLCBPRl9QT1BVTEFURUQpOw0K
Pj4+ICsNCj4+PiAgICAgICAgIHJldHVybjsNCj4+DQo+PiBIaSBUdWRvciwNCj4+DQo+PiBUaGFu
a3MgZm9yIGxvb2tpbmcgaW50byB0aGlzLg0KPj4NCj4+IEkgYWxyZWFkeSBhY2NvdW50ZWQgZm9y
IGVhcmx5IGNsb2NrcyBsaWtlIHRoaXMgd2hlbiBJIGRlc2lnbmVkDQo+PiBmd19kZXZsaW5rLiBF
YWNoIGRyaXZlciBzaG91bGRuJ3QgbmVlZCB0byBzZXQgT0ZfUE9QVUxBVEVELg0KPj4gZHJpdmVy
cy9jbGsvY2xrLmMgYWxyZWFkeSBkb2VzIHRoaXMgZm9yIHlvdS4NCj4+DQo+PiBJIHRoaW5rIHRo
ZSBwcm9ibGVtIGlzIHRoYXQgeW91ciBkcml2ZXIgaXMgdXNpbmcNCj4+IENMS19PRl9ERUNMQVJF
X0RSSVZFUigpIGluc3RlYWQgb2YgQ0xLX09GX0RFQ0xBUkUoKS4gVGhlIGNvbW1lbnRzIGZvcg0K
Pj4gQ0xLX09GX0RFQ0xBUkVfRFJJVkVSKCkgc2F5czoNCj4+IC8qDQo+PiAgKiBVc2UgdGhpcyBt
YWNybyB3aGVuIHlvdSBoYXZlIGEgZHJpdmVyIHRoYXQgcmVxdWlyZXMgdHdvIGluaXRpYWxpemF0
aW9uDQo+PiAgKiByb3V0aW5lcywgb25lIGF0IG9mX2Nsa19pbml0KCksIGFuZCBvbmUgYXQgcGxh
dGZvcm0gZGV2aWNlIHByb2JlDQo+PiAgKi8NCj4+DQo+PiBJbiB5b3VyIGNhc2UsIHlvdSBhcmUg
ZXhwbGljaXRseSBOT1QgaGF2aW5nIGEgZHJpdmVyIGJpbmQgdG8gdGhpcw0KPj4gY2xvY2sgbGF0
ZXIuIFNvIHlvdSBzaG91bGRuJ3QgYmUgdXNpbmcgQ0xLX09GX0RFQ0xBUkUoKSBpbnN0ZWFkLg0K
Pj4NCj4gDQo+IEkgc2VlDQo+IA0KPiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtc2FtYTVkMl9z
aGR3Yy5jOiAgICAgICB7IC5jb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDItcG1jIiB9LA0KPiAN
Cj4gc28gaXNuJ3QgdGhhdCB0aGUgZHJpdmVyIHRoYXQgd2FudHMgdG8gYmluZCB0byB0aGUgc2Ft
ZSBkZXZpY2Ugbm9kZQ0KPiBhZ2Fpbj8gRmlyc3QgYXQgb2ZfY2xrX2luaXQoKSB0aW1lIGhlcmUg
YW5kIHRoZW4gc2Vjb25kIGZvciB0aGUgcmVzZXQNCj4gZHJpdmVyPw0KDQpObywgaXQgaXNuJ3Qu
IGF0OTFfc2hkd2NfZHJpdmVyIGJpbmRzIHRoZSBjb21wYXRpYmxlcyBmcm9tIGF0OTFfc2hkd2Nf
b2ZfbWF0Y2g6DQoNCnN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0OTFfc2hkd2Nf
b2ZfbWF0Y2hbXSA9IHsgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgIHsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDItc2hkd2Mi
LCAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAuZGF0YSA9ICZz
YW1hNWQyX3JlZ19jb25maWcsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQog
ICAgICAgIH0sICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICB7ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAg
ICAgICAgICAuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1zaGR3YyIsICAgICAgICAg
ICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgLmRhdGEgPSAmc2FtOXg2MF9yZWdfY29u
ZmlnLCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICB9LCB7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCiAgICAgICAgICAgICAgICAvKnNlbnRpbmVsKi8gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgIH0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KfTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICANCk1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGF0OTFf
c2hkd2Nfb2ZfbWF0Y2gpOyAgIA0KDQogDQpUaGUgcG1jIGNvbXBhdGlibGVzIGFyZSBsYXRlciBv
biB1c2VkIGluIHRoZSBwcm9iZSBmdW5jdGlvbiBpbiBvcmRlciB0bw0KZ2V0IHdpdGggb2ZfaW9t
YXAoKSB0aGUgcG1jX2Jhc2UsIHRoYXQgaXMgbGF0ZXIgdXNlZCBpbiBhdDkxX3Bvd2Vyb2ZmKCkN
Cm1ldGhvZC4NCg0KSnVzdCBmb3IgdGhlIHJlZmVyZW5jZSwgdGhpcyBwYXRjaCBpcyBzdXBlcnNl
ZGVkIGJ5IHRoZSBmb2xsb3dpbmc6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEw
MjAzMTU0MzMyLjQ3MDU4Ny0xLXR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbS8NCg0KQ2hlZXJz
LA0KdGENCg==
