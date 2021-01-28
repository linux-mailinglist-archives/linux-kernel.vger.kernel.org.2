Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745AE307446
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhA1LAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:00:48 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:5913 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA1LAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611831643; x=1643367643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fK6V99RZaWH2mjCfOpzvQiREWtxp4KGJv3E9jDZ2mQ8=;
  b=HpT94uPxR8S4AVK1xLNNuA9rXcyS99IPLMg68mh4k+6H8u+AaIzpzT/g
   238hBVHgVv7yBh+eYQgkrux4purW4GosFJTiL+3pqffBbZlYA3zgzTvU9
   0UR+Pl3nCxpDZfw8uJqIu+ZOiV50+KEJ/+elZuxezVnD8BG3AJhpVlVDq
   itS7AV/CfXfiWh4qt5XR78ujanYFHv1vHW49F/B1HEHKkyMfga9S6UJFN
   SzVzm7B/PJoEppW+CEUNDzIgaMG+3vMGVCgx2Cy4tRAuXG3r5uZ9llNpu
   mNbirA7gta9vtIp5V6PmgGg+QJ3FX1HPKBZdz7fGYO37/U/OTistukowS
   w==;
IronPort-SDR: ePJXljisqqPtyqMvZSZCWc3+Sf6xqYRVwMyStboHrtJ8F+wyWPJV83s2yJfoy2vQ4aQ6iLpKdk
 o7B881c0tP8WNOuwzcu5NZRaCbiuwCvb/UKv3wpCgxS69XtD9SfBdlUDrE+Lrr2zTJvcpYZsrk
 48uZGDpDcEWejf9SiWezJRj0EBVmvyklyzI4P4XsWsC97XHalOAYzYyWqOUWKxYUAXAfJLn5RZ
 NNiCSZdTZkYURJ0gXwh+o1tGopUSJHkmQoDwgEUEvfFqd+75BMoKy7akdHUZv9AaLrzJVyzCMk
 fTo=
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="112833730"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jan 2021 03:59:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 Jan 2021 03:59:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 28 Jan 2021 03:59:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldvbh7kyIEhF4yAI1GRnOS3NZwRv6U7w7qraf4ndLGLIry1UFkqfCfVbqjM6hltJ4Q8whxAu7JwoX2VIqkjK8Iw/4me757oEHc7roVnOZvgc+DJqSdqtZYKIGEdfK07bfRggqxvibachn3E32mKywAzt721TO0eL7W8vko5NnIKP/i7lCDwKlaxcAZMseV3UpdoF5JQeajoVSN5WvtHkJ0ZmDBJC4WpPIDbVvz353tMABYburkAaoTDEzHRiODvx/V+PtQnHyb5D/VlvgGGMPZOgBBqSUkUgmEkoZJTn7DSKCp72yNHvwFUykJcz48qWSW4DjbMje0n7hSWzL5dCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK6V99RZaWH2mjCfOpzvQiREWtxp4KGJv3E9jDZ2mQ8=;
 b=mIHINjrHim8ywwYbDHttts0N6/eBPJuw6oCXH0m9Q1vn1jH/4bXCIMdzr8HRYUcheh8HxG30OVLzzDFLQUYoE8m2RlWInGiDtc545ZsQiv3eKcZGoXgRJ1fPrSVdbqLU9a5wibMGFMeJI5Pn7k3Drd7Y01yKX/ae8DHMKSWx2Het7PNTYGmpseXtUF9IRrzYE3Ox4ggZWr0rWw3ui4T8PrNgQN2TdYjlCorZrw8SWP16hLgIYvZmj1a1iogWo/nwte/IiZ/gYbSHSBvuV7ZohpP0YEE1dXVdnziR4+Ikd1oMNbdozmTodhdHZc1V70yFg0WhC2JUJT4c+QlsdNvLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK6V99RZaWH2mjCfOpzvQiREWtxp4KGJv3E9jDZ2mQ8=;
 b=eaL1ArJX0AeDXcK3HP28okj66WCcflPOxFP6R8daJ08qlw03ONtLIzQErw37pwECo2uhOGUPSCuHlhoREJKluc3gjtt+zPi2KI56kpsSZMPvk2GAMgegUHox1Z8Xtq9or6YAtOuFIjj9cC11spuFZJznPJC2DnzDyL3MnpxYJT4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2880.namprd11.prod.outlook.com (2603:10b6:805:58::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 28 Jan
 2021 10:59:24 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%3]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 10:59:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <saravanak@google.com>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <Jisheng.Zhang@synaptics.com>, <khilman@baylibre.com>,
        <john.stultz@linaro.org>, <nsaenzjulienne@suse.de>,
        <maz@kernel.org>, <geert@linux-m68k.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
Thread-Topic: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
Thread-Index: AQHW8zw5m+rE14u/qUW96zJAI+USHao4pg2AgAQ8wIA=
Date:   Thu, 28 Jan 2021 10:59:24 +0000
Message-ID: <97a1fe96-ee2c-43cf-58fe-6ed910d3fb2c@microchip.com>
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com>
 <6ca35fea-3c67-127d-2190-a34c0318a5a3@microchip.com>
 <CAGETcx-sZC4nKi9VKYUgaBnH4Kf3FraKEe+CMXxm_-DWjz9t5w@mail.gmail.com>
In-Reply-To: <CAGETcx-sZC4nKi9VKYUgaBnH4Kf3FraKEe+CMXxm_-DWjz9t5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.77.80.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c0e10e5-d151-4b63-9abb-08d8c37bc62c
x-ms-traffictypediagnostic: SN6PR11MB2880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2880E02421E7072F2F0F3745F0BA9@SN6PR11MB2880.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R2FsVaMd7UrFt8JpykHiV9EPdO+TZSppirhhxtJmepgRjoKHjlsah9Pi8wohsi516nb2OchYsixIUjqJthpwFpSIHQ0F89/5rmhzA4vSsMTbXH4J7ypqh3tIS8O+j0zSNpUEHdiim8W17Pti6YQM1e7fzyAXqaf9dGj5kBKRVoV464jft03yFdtSqa8Yd/MCGHwgAywJHGLktNbdpyjwWxxhQGhDZTSeYebfJ3l55DLSufyoubdDSJuYq+uq/4kG/t+ohIlcO57Va9VJZ12+MWJeqD8FgJv96VMhpIHGLnWHrhZ9/ieR8uQJk/+OOFlh4Gio3CFV7AWFuqGFNHs4QlBPdfNplXCNTgh/Oq9b87J+3JEGPxwr+ki6W69y2MZxG0FgzakKbNXKJmIH8meCp9EYQ8OkhjP5to+J3oZ0EZ6pIItIlFQUcrLTwl5mLAY9ZLSLFkEH+1/COFUEeiN6hPnE3KEm9Ww2Hq+WpbA6Bqzd60KJZrvfdbAOrndey8NtMoWzys/yym20OrFOTPK4hoNXYZ869bPgG7fXN/0lfU66e8D4nFIZVVa/ggxXaajgtjBJztX8vt2abrzc3IrVttDupcg3AWBYzeTdT+B+4exMaWwcUUuhOZ9ga6RtOOj0x3V0Bc1TwzGj4O0DDkSUOJp55TtpU8MbpQ0tJBUg6Xr0bd56nzDXj0ck6S+/EK0x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(136003)(396003)(346002)(31686004)(66476007)(2906002)(6506007)(53546011)(4326008)(8676002)(966005)(64756008)(5660300002)(478600001)(316002)(7416002)(54906003)(66556008)(66446008)(71200400001)(36756003)(86362001)(31696002)(186003)(2616005)(83380400001)(8936002)(66946007)(6512007)(107886003)(91956017)(26005)(76116006)(6916009)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YzVYVWtXajdsZnVMakJqWnFiRlRKNnB4TVBQWGJpd2s3cmdvWUFGYncyQW5n?=
 =?utf-8?B?N3ZkWkRTaXlYWFFkSFh0QzlhNWMxTTZFSXN3YUp3RkVzSGV2ZjVVUk5VTEJo?=
 =?utf-8?B?ZE1xeDZXWXNyT3MzRkVhSUlSNTU4Z3YySE8vYVJyMnI1SUxtZFBYRWZNbzJR?=
 =?utf-8?B?R2lmZ0VKZ3hHcUFOU3lISnBkMnpaVTFtQXM0KzNDOGZKblFYTVllL1duSTky?=
 =?utf-8?B?VTNaTURZajZyZ2s4VkEzYlkwUkFGUFUxWGZJTW1kL0RwSmxVc2RVN3RsVW9P?=
 =?utf-8?B?MTZBbnpJUVQ4ZnNVblhBVkRuMGRVOFFzMmQ4N2pCZ1pjNkpUdkpyTE45ZFJU?=
 =?utf-8?B?TkVMSXBGRGFqSEEzQ2Z4RnMxSitSclBVZVdYaTdubkZKU1AveXFISUJCTlNN?=
 =?utf-8?B?WFVDKzdiUVprK0pDOFRVeDJ4MjNuVjR3VWlFVU0zZjVuYmJrMTRvM2dWamww?=
 =?utf-8?B?RmUybnVuZ0x0bFhxNXVVRi85RUNGZGp5bTVOMHVFVlh2bWowd3JmSXRhZ1JK?=
 =?utf-8?B?bkVvZG9XVzB3VTBESlppYk5GSHpzWkxTL0dMVTh5WU1DN0FzcnJlUFA4aVJJ?=
 =?utf-8?B?K0l2TGxKRTArNlZXd0dtNXZnUGZWRWZGcWFvU2JlcEs0MnJFV1ZWNjJNSWZR?=
 =?utf-8?B?cXRtUlVTcjF3WVFsQVdFMlhZR1E1aDNNL3JmbXdDMm93QzBqczhkTkVrSWhF?=
 =?utf-8?B?UVppQjRoeGlEVmxyUUdJSURQdnAvSVlOeW4zZkEyS0dNNkxYWHJNQ2k3eXJK?=
 =?utf-8?B?aFBEZjEzaHlhSUM1NStxbjRxUEJDQTNMZ3M5dVBGK0E3amZ1RkJMdlJFSXNU?=
 =?utf-8?B?RWZMM3JkbmFodWtrLzUzbFlkNWhRcDNYWnptU1c0YktVMStXK1NxV1p6NVZn?=
 =?utf-8?B?anE3cnhSTkRBREJ1VkZqU3A2b2JhdTF3Z0RRZE9XSEcvUy80cEROYTArRXB3?=
 =?utf-8?B?Tm8rejNHN1V1bzhMcUVTRjQ1c0V3ZlJXNm9DNGo3dnRrRnE1SEg5OHRxekxs?=
 =?utf-8?B?bzRlcE9HRktnZjhLOFA5OEJZYkFEVlJOMUFKTVVmMDVtbi9qZUJxR1V4dXFk?=
 =?utf-8?B?ZU9NNHAxRWE0ZjBkd1lFS2w4TXkrY1JTbml2a2FzSElzcHVWMHVOa0NWL0JK?=
 =?utf-8?B?bmZSYlcwMUlmQjdSdzY3Wm11TUovdDFVTnJtUW9FTDRwbnJjSDJtajhRcUxB?=
 =?utf-8?B?K3FIUHhmQlFYSCtTVmZROTZZMHN5cFFIVEw5K0lBbk5xVE5rbVNTOGZmUGMv?=
 =?utf-8?B?dGhaR0dSVDcvWi9oNkZwWUU2NUh6Y1FuUW5sNlMwZVBtTXY1UDAyZzIzRldm?=
 =?utf-8?B?ZUxWa3M1Z1BoSlRlQjdKSUhob2xJcVlBSGgvNXdSdkxDY1RiQnVLQUNxMUc5?=
 =?utf-8?Q?4G+2E5f6ITfcHTGf1H7JSX8NgZlRhYPI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7925BDD5A5BFDE44A8475D887512C42C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0e10e5-d151-4b63-9abb-08d8c37bc62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 10:59:24.4886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvyCWhqSwxOHX/dmAysla//bRptO/aX+lgYEjYLRdxe5D5PE39fKWFoRNYVEV7oqMEzE3nzBwIIWgGYrvgOe5qlzpHJcKsafzjVnJPoI3a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2880
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNhcmF2YW5hLA0KDQpPbiAxLzI1LzIxIDg6MTYgUE0sIFNhcmF2YW5hIEthbm5hbiB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIEph
biAyNSwgMjAyMSBhdCA5OjA1IEFNIDxUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20+IHdyb3Rl
Og0KPj4NCj4+IEhpLCBTYXJhdmFuYSwNCj4+DQo+PiBPbiAxMi8xOC8yMCA1OjE3IEFNLCBTYXJh
dmFuYSBLYW5uYW4gd3JvdGU6DQo+Pj4gQ3ljbGljIGRlcGVuZGVuY2llcyBpbiBzb21lIGZpcm13
YXJlIHdhcyBvbmUgb2YgdGhlIGxhc3QgcmVtYWluaW5nDQo+Pj4gcmVhc29ucyBmd19kZXZsaW5r
PW9uIGNvdWxkbid0IGJlIHNldCBieSBkZWZhdWx0LiBOb3cgdGhhdCBjeWNsaWMNCj4+PiBkZXBl
bmRlbmNpZXMgZG9uJ3QgYmxvY2sgcHJvYmluZywgc2V0IGZ3X2Rldmxpbms9b24gYnkgZGVmYXVs
dC4NCj4+Pg0KPj4+IFNldHRpbmcgZndfZGV2bGluaz1vbiBieSBkZWZhdWx0IGJyaW5ncyBhIGJ1
bmNoIG9mIGJlbmVmaXRzIChjdXJyZW50bHksDQo+Pj4gb25seSBmb3Igc3lzdGVtcyB3aXRoIGRl
dmljZSB0cmVlIGZpcm13YXJlKToNCj4+PiAqIFNpZ25pZmljYW50bHkgY3V0cyBkb3duIGRlZmVy
cmVkIHByb2Jlcy4NCj4+PiAqIERldmljZSBwcm9iZSBpcyBlZmZlY3RpdmVseSBhdHRlbXB0ZWQg
aW4gZ3JhcGggb3JkZXIuDQo+Pj4gKiBNYWtlcyBpdCBtdWNoIGVhc2llciB0byBsb2FkIGRyaXZl
cnMgYXMgbW9kdWxlcyB3aXRob3V0IGhhdmluZyB0bw0KPj4+ICAgd29ycnkgYWJvdXQgZnVuY3Rp
b25hbCBkZXBlbmRlbmNpZXMgYmV0d2VlbiBtb2R1bGVzIChkZXBtb2QgaXMgc3RpbGwNCj4+PiAg
IG5lZWRlZCBmb3Igc3ltYm9sIGRlcGVuZGVuY2llcykuDQo+Pj4NCj4+PiBJZiB0aGlzIHBhdGNo
IHByZXZlbnRzIHNvbWUgZGV2aWNlcyBmcm9tIHByb2JpbmcsIGl0J3MgdmVyeSBsaWtlbHkgZHVl
DQo+Pj4gdG8gdGhlIHN5c3RlbSBoYXZpbmcgb25lIG9yIG1vcmUgZGV2aWNlIGRyaXZlcnMgdGhh
dCAicHJvYmUiL3NldCB1cCBhDQo+Pj4gZGV2aWNlIChEVCBub2RlIHdpdGggY29tcGF0aWJsZSBw
cm9wZXJ0eSkgd2l0aG91dCBjcmVhdGluZyBhIHN0cnVjdA0KPj4+IGRldmljZSBmb3IgaXQuICBJ
ZiB3ZSBoaXQgc3VjaCBjYXNlcywgdGhlIGRldmljZSBkcml2ZXJzIG5lZWQgdG8gYmUNCj4+PiBm
aXhlZCBzbyB0aGF0IHRoZXkgcG9wdWxhdGUgc3RydWN0IGRldmljZXMgYW5kIHByb2JlIHRoZW0g
bGlrZSBub3JtYWwNCj4+PiBkZXZpY2UgZHJpdmVycyBzbyB0aGF0IHRoZSBkcml2ZXIgY29yZSBp
cyBhd2FyZSBvZiB0aGUgZGV2aWNlcyBhbmQgdGhlaXINCj4+PiBzdGF0dXMuIFNlZSBbMV0gZm9y
IGFuIGV4YW1wbGUgb2Ygc3VjaCBhIGNhc2UuDQo+Pj4NCj4+PiBbMV0gLSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sL0NBR0VUY3g5UGlYPT1tTHhCOVBPOE15eWs2dTJ2aFBWd1RNc0E1TmtE
LXl3SDV4aHVzd0BtYWlsLmdtYWlsLmNvbS8NCj4+PiBTaWduZWQtb2ZmLWJ5OiBTYXJhdmFuYSBL
YW5uYW4gPHNhcmF2YW5ha0Bnb29nbGUuY29tPg0KPj4NCj4+IG5leHQtMjAyMTAxMjUgZmFpbHMg
dG8gYm9vdCBvbiBhdDkxIHNhbWE1ZDIgcGxhdGZvcm1zLiBObyBvdXRwdXQgaXMNCj4+IHNlZW4s
IHVubGVzcyBlYXJseXByaW50ayBpcyBlbmFibGVkLg0KPj4NCj4+IEkgaGF2ZSBiaXNlY3RlZCB0
aGlzIHRvIGNvbW1pdCBlNTkwNDc0NzY4ZjFjYzA0ICgiZHJpdmVyIGNvcmU6IFNldA0KPj4gZndf
ZGV2bGluaz1vbiBieSBkZWZhdWx0IikuDQo+Pg0KPj4gSSd2ZSBhdHRhY2hlZCBhIGxvZyB0aGF0
IEknbSBzZWVpbmcgb24gYSBzYW1hNWQyX3hwbGFpbmVkIChzYW1hNV9kZWZjb25maWcNCj4+IGFu
ZCBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfeHBsYWluZWQuZHRzKS4gSSBlbmFibGVk
IHRoZQ0KPj4gZm9sbG93aW5nIGxvZ3M6DQo+PiAxLiBUaGUgb25lcyBpbiBkZXZpY2VfbGlua3Nf
Y2hlY2tfc3VwcGxpZXJzKCkNCj4+IDIuIFRoZSBvbmVzIGluIGRldmljZV9saW5rX2FkZCgpDQo+
PiAzLiBpbml0Y2FsbF9kZWJ1Zz0xDQo+Pg0KPj4gVGhlcmUgc2VlbSB0byBiZSBzb21lIHByb2Jl
IGZhaWxzIGR1ZSB0byB0aGUgcG1jIHN1cHBsaWVyIG5vdCBiZWluZyByZWFkeToNCj4+IGNhbGxp
bmcgIGF0X3hkbWFjX2luaXQrMHgwLzB4MTggQCAxDQo+PiBwbGF0Zm9ybSBmMDAxMDAwMC5kbWEt
Y29udHJvbGxlcjogcHJvYmUgZGVmZXJyYWwgLSBzdXBwbGllciBmMDAxNDAwMC5wbWMgbm90IHJl
YWR5DQo+PiBwbGF0Zm9ybSBmMDAwNDAwMC5kbWEtY29udHJvbGxlcjogcHJvYmUgZGVmZXJyYWwg
LSBzdXBwbGllciBmMDAxNDAwMC5wbWMgbm90IHJlYWR5DQo+PiBpbml0Y2FsbCBhdF94ZG1hY19p
bml0KzB4MC8weDE4IHJldHVybmVkIC0xOSBhZnRlciAxOTUzMSB1c2Vjcw0KPj4NCj4+IGNhbGxp
bmcgIHVkY19kcml2ZXJfaW5pdCsweDAvMHgxOCBAIDENCj4+IHBsYXRmb3JtIDMwMDAwMC5nYWRn
ZXQ6IHByb2JlIGRlZmVycmFsIC0gc3VwcGxpZXIgZjAwMTQwMDAucG1jIG5vdCByZWFkeQ0KPj4g
aW5pdGNhbGwgdWRjX2RyaXZlcl9pbml0KzB4MC8weDE4IHJldHVybmVkIC0xOSBhZnRlciA3NTI0
IHVzZWNzDQo+Pg0KPj4gVGhlcmUgYXJlIG90aGVycyB0b28uIEknbSBjaGVja2luZyB0aGVtLg0K
PiANCj4gVGhhbmtzIFR1ZG9yLiBJJ2xsIGxvb2sgaW50byB0aGlzIHdpdGhpbiBhIGZldyBkYXlz
LiBJJ20gYWxzbyBsb29raW5nDQo+IGludG8gY29taW5nIHVwIHdpdGggYSBtb3JlIGdlbmVyaWMg
c29sdXRpb24uDQo+IA0KDQpJJ3ZlIHNlbnQgYSBwYXRjaCBhZGRyZXNzaW5nIHRoaXMgYXQ6DQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEwMTI4MTA0NDQ2LjE2NDI2OS0xLXR1ZG9y
LmFtYmFydXNAbWljcm9jaGlwLmNvbS9ULyN1DQoNCkNhbiB5b3UgcGxlYXNlIHRha2UgYSBsb29r
Pw0KQ2hlZXJzLA0KdGENCg==
