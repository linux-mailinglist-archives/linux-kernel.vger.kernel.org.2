Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502B83B8D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhGAFs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 01:48:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23089 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhGAFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 01:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625118356; x=1656654356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rxr25uBvvBYxp4sSfLvguHu2zkhdBsrYjQ/WQ/F/HBM=;
  b=CWTzUjTcaJjXZChcoH0pEtfjJ0HNDxa8Heu6DwxBCzsEOBygR/hKir1e
   TDF7WPDtbt2cg+QWhj5p1+jVw2Dx9YS8W5nYpQrNS+kafEfu9xe20L/gZ
   LbfSzYWSNuAg1rpyzR1owk6GD48EAry+HoOk7me46vd62z+0d8qi7x0am
   rG9HG4V90EXVZxfru2p3OUS30cWgBwmSF8sho+znGEO0IZc69pskslZDE
   4jbcPZ5DDUeXlVEVRH0YF2rnb2UZ3IXMSPTFtKwTxYBLr95yRxVFDpQ2Q
   97iN3gkt/CL9SbJnJLlQvfyozwtyHhIHkH0HIiohdNxDoAQAfuwFx+B2V
   g==;
IronPort-SDR: Lrmo61EF7AMNq3E/I5HzJyhfFxD2WjQBL2/3nLjI/6WP+rCfAgLc5lzTEn0PxcHgA+xA+hthc3
 khbXJ0oUDLYTZRICvHDUMJB9iEm4i01sCwmokOwebQXWKxyqqA4+vHuBm6ouHmGrvibr9HSZjp
 VHQh4p2MorTeM0gzneYrpmshzojdN9ssqqChFshEMzKL9sZbiN92nieQ+xiG+90b6kH2RbwlIr
 MwxCEQxwtlHniLRTcMBwrbB93syR/53eRG+dKkeHTlt2/WGb8c01UVp0CT2v+yTXDIOoJUrr2l
 a+E=
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="120620927"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2021 22:45:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 22:45:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 30 Jun 2021 22:45:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCKgI9oZQE8AR1wG9912SUk8IXisTi7iF+pNlsldcS5NLXan6fUbvSeDs7M/T5MRBCfg2LuIKeN9laBmeRAJyXi5iYMs4vlr1lO4KouxpAAG0SN3naXS7p9Hixo88tCluYPGFS3c3GZLb2E9mXdjOTPQGnjptChCNgMyXV/ldvPe6utI8BIPZMFD31gbvA9biO5eQlr/SFCEfZO31zE6koGVCSAo1ObwFmYxL8nPffZGpc+dc/x0+CfD3S0KcY3uZwTNTKDkshqL+9BDJIK6ux+Shb1qce2QjYvFWCBrbObCkqx/j2jDWZWCl7uPtNxLywongRv/7nrPatWeTLzORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxr25uBvvBYxp4sSfLvguHu2zkhdBsrYjQ/WQ/F/HBM=;
 b=VIkfCseamaDJqDDRYfbhIjaJexwDWRQOBUHLFRHA23qK/H2Ajhip9cO6Wwbun+bmiL9HwIOh0o/joy5V6eTGT/IJEFDcOzrDpOzSN0iJQma3/a9hAJkNBK0qZdJj4Nyx6ZqHS/a4c5PUwlBm8xHTSU7FfE4DlWLRMCYxOO3vXmxjUCmdknEmyv4KC4pDDpubVD+IqBhbTBYaLmeUfDvP/+yfxJSKJDMMvQyrTa0lHB1yLwJGd3/zw6fcgduJWEqxEoKFPx7JnYXB6VO0SmqJHjhhD1CQGu8ikMTb/V+2i84xZfFkUeUsGy2AlEDjzKlzxCQoyL4cSY3hCaPR+CAiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxr25uBvvBYxp4sSfLvguHu2zkhdBsrYjQ/WQ/F/HBM=;
 b=I/bVaNne5LJ/IEV5J6OvsZMy8E+owMeb0oo6RgVm47wgzUi7vy3UUeoIq76WKwUH8JE/Ht/TxTnLe9dyynoMZdpGxQVxvLhwCviSrAQuZKldmYVuHvYNKlxtzv3txfegu9fRFT1RfjwYQd8MJZEB+tSCnmOtV/vHdUIdHjnTvlM=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB3995.namprd11.prod.outlook.com (2603:10b6:5:6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Thu, 1 Jul 2021 05:45:51 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5%5]) with mapi id 15.20.4264.027; Thu, 1 Jul 2021
 05:45:50 +0000
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
Date:   Thu, 1 Jul 2021 05:45:50 +0000
Message-ID: <6a33e55d-b101-cda2-7f53-ce6e5e6ace93@microchip.com>
References: <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
 <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
 <20210623141907.GC491169@rowland.harvard.edu>
 <8bff20a7-8eb8-276a-086e-f1729fbbdbe4@microchip.com>
 <20210623164148.GC499969@rowland.harvard.edu>
 <f03ccb09-4b5e-4db7-2cf0-375d53234099@microchip.com>
 <20210624132304.GA528247@rowland.harvard.edu>
 <856493cd-9d53-24b3-8e8b-c3c366f282bd@microchip.com>
 <20210630182137.GA743974@rowland.harvard.edu>
In-Reply-To: <20210630182137.GA743974@rowland.harvard.edu>
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
x-ms-office365-filtering-correlation-id: 4fb7921f-f242-4221-1df0-08d93c537bff
x-ms-traffictypediagnostic: DM6PR11MB3995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3995E0A68473ED7B905190D987009@DM6PR11MB3995.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5VPGKHvTbirUrA63zfXwfI01ykmA4u7RCfrdYCqxMbm4V2Ttfujy6xJw5UIstNLE095DEc7E5nosTUdvRlWOohYn41ZtKeG5g4rVdeaA0i+EpxxxNipqILf2SZvw+f15sAJjgDtF2e8rEudEKAQTicMjpUP3BvSEUvHw5m0I9X2HNUrq8FhJzbmnQ5rKnRqYgitUVknVHGgAySBbhk5vdAzT2cUaWAXGkgX4ZwpJKmAEFOcbQM119UtwRpH5zXEiMvYATC/67cbkjaFuI/X/XBJPM2UPB7fu3f+ivPjVLCZ7g6Tpa1fhbf7d2B12MEp5h/cpzVxl/NM/moUfTCU+JQ2jIZ6b49bdumqQZutk7+OVGbke2oBDRakWKb+q3/UIEzrHl7eyqXAaFtzphCQ0ZxV9xIMrVCWoLNf/il3K+2LUW+aJBZdLnZeYpj7gt5aRUydQNuzhNmQUPdvgQuNCl/iKZTFAI5QZL28Zza0Dv/el9HDxSpYAQLEpRE4rfjh6CLpPxUTm3Cw5WLF+9rBzwBWSkV7igOt1oEFgxhvH/SriXeZPr56LTi+I2EMBiltlyeht8B3VZQZzpXHy2N/55B7EX19v4NWFJ584iyp+1Gn28GGxQgmnG9240wQgEaQMdbPQGnAjv4r6nFKzdrWZZSNf99jP+YnZEb6u/8ywH9TFkasUAxqarfhFs4K5x8N4As77TGqhe3M6TiNArQkjs1Zr+Ukw5lMefuLQh8YfAbPoAOtbZcY7Lc718jxChw30FLMCFFHl2bL9PERRexXcY7SdGl7zqQJfYr7Taa0yJ8NXajdGcM20yWtsiQqBxkF2qKkBbxQ7OR7Hqtd7Z9FbDV3By9T8e2Got7ULbA2wDPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(54906003)(6512007)(83380400001)(2616005)(4326008)(36756003)(26005)(186003)(2906002)(31696002)(66476007)(15650500001)(66556008)(64756008)(478600001)(66946007)(31686004)(91956017)(76116006)(8676002)(966005)(8936002)(6916009)(6506007)(5660300002)(122000001)(6486002)(53546011)(38100700002)(71200400001)(86362001)(66446008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0dFSEx1Uzk4RWt5SElxTFJ6NjZyeGc0REhielRDTnlTVWtEbzI2UG1ZWjdF?=
 =?utf-8?B?NWxuZWdIMmQvVHphM1FZK29FdkxSY3JWdHVpZ0lqL1Q5bFVJb3NRUllNbHVG?=
 =?utf-8?B?NXpFQ3E3dEp2cU5yY0U4SlFRdnYreWJLdmtyNDJDSDZCajYvOS9UaDh2RDY2?=
 =?utf-8?B?L1lacWoxUWxaNko1d0graDJlY1p4Tm9NclFMU0ZDajRCK3NvU2Z1NlN5REV6?=
 =?utf-8?B?Y1h4d3g1Q0ZTZjZQa1UrYTd3YnEzS1l6QktOQytYN2ovY2ZRdGsvWHc1T0Fl?=
 =?utf-8?B?WGg0Q0QxZTNTc3dra3NmUERhbjhBOG5UTTRZMU55VUVVZVNIMFRZcDFYaW9K?=
 =?utf-8?B?OGRDMlEybzBLQTZkT2hsTTVRZFBGcndBQzlFOW9sdU9YdkJZKzJVWERGT21t?=
 =?utf-8?B?STRSNUNpbGFTZWJHU3pBbHpvd0tMTkFPalFiNjNyVGFsSEZUMnBXVm5QTWZm?=
 =?utf-8?B?cGwxVmZUVkc5eHcrbG9yVVFzZ0lpVEFOY2l4ZkdiNTA4Z3hod2NhWmxrRFJO?=
 =?utf-8?B?YXB2b0l5ZUV5cVYzSmIyZHRITXRjdzkvYWc4dUROMWlIbjlUQzlzU2xMcEZ6?=
 =?utf-8?B?WFBLR3dQS1NiVFNWandBV3JPOGtKdlRxRkpyWkFZeHhLYTJwa29sZzVNTjJY?=
 =?utf-8?B?V1FLZDlLa3gxR2J1Qmordk9BU29WRWV4SXZQWVBxR3pHdTA2RkZFMUFXVjlS?=
 =?utf-8?B?ZHRUWG8yU3AyYUwweWhDR3RBcm0zOHpaQ2g2blhTNlBZYkpmd290T3I4bDBr?=
 =?utf-8?B?TmxueFpWUTNKN1FnY1huUzZFUitLSHIzbDI5QnlNMXg5d0hFcVM3cDdtdndJ?=
 =?utf-8?B?UHpJZEtHamc5d1ZiODN2bEhQV2xEMnNHUTBEbko5dHJYNDZlWXdlMHVkWjhn?=
 =?utf-8?B?ZTBsZHVoR1Jaa0V5T3d1TytPVzdPQytheWhTY3JBZzZWZERJYjd1YTRRT1Fo?=
 =?utf-8?B?K1YyU0NuVUFiY3FJYzl1eGxlZTQ2RU8rRGJBRzFScmM2TlpUaURlSlZmRVlH?=
 =?utf-8?B?N3NhN3J4UjBrUjg3eDA3UjhtRGJNTlB4enpPQkVLUWZWRFBRTzFmd3lKVlV0?=
 =?utf-8?B?Z0hONnpLS1A1OW81allqM25TK0tZMnlRTEpkS0R3MDZ4VG8wVEI2MVdlUldO?=
 =?utf-8?B?NVN1UXlmZnRkaHFtSzExLyt1M1hudmp3bXVpeS9EUURPOGZZL21CeGpITWt0?=
 =?utf-8?B?ODk2WTZCaFo1RWNLRFkzK3pkMmYzcjlrOE1PeG1paWo1aENCNFFQV0QrNWk3?=
 =?utf-8?B?aDdnZU9WT3VFV055NGdXWFQ2TWhZdmF0WjBLZkw4TlM5cXNlekt3Q1ZORzJR?=
 =?utf-8?B?Y0FJR0RJZ1VCbFh4NUN5RXNOTzA2Zm1ZMWxGNVpUK0g4VHNYMGZRUEhzUXdt?=
 =?utf-8?B?blpTOUEzWVFRSTFxcGxkdTU5MTJBdTJrNEpFVHVzdHpBQnc1Zi84SjdXMWln?=
 =?utf-8?B?L0laT2NRNHpoN0E0bkp6OERLSFdEd1NTNE5jOG5na2NNN3U0N0hlUGlvOXFt?=
 =?utf-8?B?ajRjZE1VM2crRWtTdENkYTFqWkdHTG5ILzkxWlFVd2ZTWWRuNWFTUW1CcVk5?=
 =?utf-8?B?M3E2WlhScU9Wb0QxVVczSjNFRUNMVDBSa1ZFcE05dGJMR1YwVitLNHM2dWpn?=
 =?utf-8?B?QmppOENleTBycmF0Nis3MGREeStua2tIVm5WZlp6SlIxczNxcVRkK0g5K2V2?=
 =?utf-8?B?Z21wMm9PYzlPM1Y3a0UyOVBIQVhydFM4WGM4dklDTXg3KzRGeFhoM3VpU01Q?=
 =?utf-8?Q?N/EB8ZsHhlC50CW0Lw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E226EF3EEB9F1489F19E3AD454A334A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb7921f-f242-4221-1df0-08d93c537bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 05:45:50.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YgpQEfnuAcn6sJrM8sAO6JTmzvN2ieXjXMBqN8ER2tdHhmGEtYE04gLx0lEgDjbnrs2LR+C8dJ/mx/mNU8RSk9S+MJzrOiZG7cu/6qxMHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3995
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDYuMjAyMSAyMToyMSwgQWxhbiBTdGVybiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEp1biAzMCwgMjAyMSBhdCAwMjo0Njo0
N1BNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMjQu
MDYuMjAyMSAxNjoyMywgQWxhbiBTdGVybiB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIFRodSwgSnVuIDI0LCAyMDIxIGF0IDA2OjQwOjI1
QU0gKzAwMDAsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IE9uIDIz
LjA2LjIwMjEgMTk6NDEsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+Pj4+PiBBcmUgdGhlcmUgYW55IHN5
c3RlbXMgYmVzaWRlIHRoZSBTQU1BN0c1IGFuZCBvdGhlcnMgeW91IHRlc3RlZCB3aGljaA0KPj4+
Pj4gbWlnaHQgYmUgYWZmZWN0ZWQgYnkgdGhpcyBwYXRjaD8gIERvIHRoZXkgYWxsIHdvcmsgcHJl
dHR5IG11Y2ggdGhlDQo+Pj4+PiBzYW1lIHdheT8gIChJIHdhbnQgdG8gbWFrZSBzdXJlIG5vIG90
aGVycyB3aWxsIGJlIGFkdmVyc2VseSBhZmZlY3RlZA0KPj4+Pj4gYnkgdGhpcyBjaGFuZ2UuKQ0K
Pj4+Pg0KPj4+PiBJIHRlc3RlZCBpdCBvbiBTQU1BN0c1LCBTQU1BNUQyIGFuZCBTQU05WDYwLiBJ
IHRlc3RlZCB0aGUgc3VzcGVuZC9yZXN1bWUNCj4+Pj4gdG8vZnJvbSBtZW0uIE9uIFNBTUE1RDIg
YW5kIFNBTTlYNjAgdGhlcmUgaXMgbm8gY2xvY2sgcHJvdmlkZWQgYnkNCj4+Pj4gdHJhbnNjZWl2
ZXIgQSB0byBPSENJLiBJIGVuY291bnRlcmVkIG5vIGlzc3VlcyBvbiB0ZXN0ZWQgc3lzdGVtcy4g
VGhlc2UgSVBzDQo+Pj4+IGFyZSBhbHNvIHByZXNlbnQgb24gU0FNQTVEMyBhbmQgU0FNQTVENCBz
eXN0ZW1zIHdoaWNoIEkgaGF2ZW4ndCB0ZXN0ZWQgYXMgSQ0KPj4+PiBleHBlY3QgdG8gYmVoYXZl
IGFzIFNBTUE1RDIgKGFzIHRoZSBjbG9ja2luZyBzY2hlbWUgaXMgdGhlIHNhbWUgd2l0aA0KPj4+
PiBTQU1BNUQyKS4gSSBjYW4gYWxzbyB0cnkgaXQgb24gYSBTQU1BNUQzIChJIGRvbid0IGhhdmUg
YSBTQU1BNUQ0IHdpdGggbWUgYXQNCj4+Pj4gdGhlIG1vbWVudCksIHRvdWdoLCBqdXN0IHRvIGJl
IHN1cmUgbm90aGluZyBpcyBicm9rZW4gdGhlcmUgdG9vLg0KPj4+DQo+Pj4gVGhhdCBkb2Vzbid0
IGFuc3dlciBteSBxdWVzdGlvbi4gIEkgYXNrZWQgaWYgdGhlcmUgd2VyZSBhbnkgc3lzdGVtcw0K
Pj4+IHdoaWNoIG1pZ2h0IGJlIGFmZmVjdGVkIGJ5IHlvdXIgcGF0Y2gsIGFuZCB5b3UgbGlzdGVk
IGEgYnVuY2ggb2YNCj4+PiBzeXN0ZW1zIHRoYXQgX2FyZW4ndF8gYWZmZWN0ZWQgKHRoYXQgaXMs
IHRoZXkgY29udGludWUgdG8gd29yaw0KPj4+IHByb3Blcmx5KS4NCj4+DQo+PiBJIHdyb25nbHkg
dW5kZXJzdG9vZCB0aGUgaW5pdGlhbCBxdWVzdGlvbi4NCj4+DQo+Pj4NCj4+PiBXaGF0IHN5c3Rl
bXMgbWlnaHQgcnVuIGludG8gdHJvdWJsZSB3aXRoIHRoaXMgcGF0Y2g/DQo+Pg0KPj4gVGhlc2Ug
YXJlIGFsbCBJIGhhdmVuJ3QgdGVzdGVkIGFuZCBtaWdodCBiZSBhZmZlY3RlZDoNCj4+IEFUOTFS
TTkyMDAsDQo+PiBTQU05MjYwLA0KPj4gU0FNOTI2MSwNCj4+IFNBTTkyNjMsDQo+PiBTQU05TjEy
LA0KPj4gU0FNOVgzNSwNCj4+IFNBTTlHNDUuDQo+Pg0KPj4gVGhlIGxhc3QgdHdvIChTQU05WDM1
IGFuZCBTQU05RzQ1KSBoYXZlIHRoZSBzYW1lIGNsb2NraW5nIHNjaGVtZSB3aXRoDQo+PiBTQU1B
NUQyICh3aGljaCBJIHRlc3RlZCkuIEZvciB0aGUgcmVzdCBvZiB0aGVtIEkgY2Fubm90IGZpbmQg
dGhlIGNsb2NraW5nDQo+PiBzY2hlbWUgaW4gZGF0YXNoZWV0IGFuZCBkb24ndCBoYXZlIHRoZW0g
dG8gdGVzdCAoYXQgbGVhc3QgYXQgdGhlIG1vbWVudCkuDQo+IA0KPiBJIHNlZS4gIFRoYXQgc2Vl
bXMgcmVhc29uYWJsZTsgdGhlIG90aGVycyBhcmUgcHJvYmFibHkgdGhlIHNhbWUgYXMgdGhlDQo+
IG9uZXMgeW91IHRlc3RlZC4NCj4gDQo+IERpZCB5b3UgZXZlciBhbnN3ZXIgdGhlIHF1ZXN0aW9u
IHRoYXQgTmljb2xhcyByYWlzZWQgYmFjayBvbiBKdW5lIDkgaW46DQo+IA0KPiAgICAgICAgIGh0
dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LXVzYiZtPTE2MjMyNDI0MjAwMzM0OSZ3PTINCg0KTm90
IGRpcmVjdGx5LiBJIHJlcGxpZWQgcHJldmlvdXNseSBpbiB0aGlzIHRocmVhZCAiRm9yIHJ1bi10
aW1lIGNvbnRyb2wNCih2aWEgb2hjaV9hdDkxX2h1Yl9jb250cm9sKCkpLCBJIGFncmVlIHdpdGgg
eW91IHRoYXQNCnRoZSBjdXJyZW50IGltcGxlbWVudGVkIGFwcHJvYWNoIGlzIG5vdCBoZWFsdGh5
ICh0YWtpbmcgaW50byBhY2NvdW50IHRoZQ0KY2xvY2sgc2NoZW1lIGFib3ZlKSBhbmQgdGhlIGZh
Y3QgdGhhdCB3ZSBkbyBmb3JjZSB0aGUgcG9ydHMgc3VzcGVuZCBvbg0Kb2hjaV9hdDkxX2h1Yl9j
b250cm9sKCkiLiBOaWNvbGFzIHdhcyByZWZlcnJpbmcgdG8gb2hjaV9hdDkxX3BvcnRfc3VzcGVu
ZCgpDQpjYWxscyBpbiBvaGNpX2F0OTFfaHViX2NvbnRyb2woKSBzbyBJIGFncmVlZCB3aXRoIGhp
bSB0aGF0IHdvcmsgbWlnaHQgbmVlZA0KdG8gYmUgZG9uZSBhbHNvIGZvciB0aGlzIGZ1bmN0aW9u
Lg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQoNCj4gDQo+IEFsYW4gU3Rlcm4NCj4g
DQoNCg==
