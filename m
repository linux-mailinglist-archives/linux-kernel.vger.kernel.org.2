Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60023152C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhBIPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:25:45 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26639 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhBIPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612884168; x=1644420168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+XtBEH8Jix6Hlr5x+mTg/a24UymRLGRHSU+zUc3Wzo0=;
  b=x/NwZjVezRUzScZ7He2CSlYVusXRbmRa8d+LWIo56q/fe8oo+QhskuVp
   sVe5NI03oovicHvEjxls5ZWXw+Q07crNzlTObn8XW4BaYcncv1SsNUf7e
   NOsS1vrkIH2ZjVXIdFPhtS0bkDCsuieS0eK65xBSQE0DR+T5FCqeqTcCV
   XpohafRJQBcZLWg/DyN5YnF+tcf7aUC0JHo13/P8AWux2WgodPulXZoyb
   TveT7IjIn+6EPqSfQBoY6cU5yfgKA+0zTYg/QctSkdcLuHp1F24rdL7oT
   LPxn4oAwpQha6wV3GHhiXXNmP9GCBJRgv6LzfYx6VHr3XhSFToC1Tczf/
   w==;
IronPort-SDR: n8A4/9SUjZlXmi3SsH3fZTrFmsmKF2l4axGVHrBT4eUaOHIV2kmpyqF795bBmTQcapDDFVPn/o
 Zth7jlwTSKoLt/KW8Ur0EAfL91ze37g52uNMWN544QYKOKdI4H2DDnzYGAC4CoJBNUBXLwXlHa
 WX6hHrxCXnLPv5IKyCrVRlaWOBXZAyEVnMsUBk4/juT3dio4qjW8UEV+EoB2vi+nTQKKUdDXxt
 a15qFHWoNwzGxcc4ePj1X3YQskCKlFh6thAlHsu491FKFC3x2P9BM6FCaBPBsUxw+iO0fjQbmQ
 Hqo=
X-IronPort-AV: E=Sophos;i="5.81,165,1610434800"; 
   d="scan'208";a="114396473"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2021 08:21:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 08:21:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 9 Feb 2021 08:21:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhsMFHQtF6Api7lwM48x87zh5Ee3O8FFMa95H7c9fnZ378kLN/VdJ4RR7A09n0ALBZwy7C1a7SkYyEU7lGV/LqmleplkHE7KA3J1GJaXR/VNBaJYzktNqQ1DR327WQZUn/WTyjYjRYyHM+X8yyLtP6OcG3nLXS9KBv6Xfrxe6KQAdgIDrFKGQ3jf5woHyadMUe2WHAfg8HVwBDZc5+YQO8yfbctDFySrCdyU/X6lxaZs0m10BpoTB9RXvx7AZ4wr4jhgvME4SkzzutfnilzWRptl84V0YaOUgAoB2VtJ8D6+11cXKmkXl2zGb4LncwNVwuq3/8wuVt3mb8lyDL6htA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XtBEH8Jix6Hlr5x+mTg/a24UymRLGRHSU+zUc3Wzo0=;
 b=PKAMOPYofqAYbCCbp53jsDiAMmtPj4qe5o6ozl3V4mhGAr9f8m8NMkQjMcLGhpShlwTv5zYeyrIOC8+llSt8eKu5Mz/M949OORZObJ2cW0uUsiMOxwHEY9t2NHxp+yg6psJnfYsdMIeNCaifUIs7IyqeeYezGubVspmLsPoaKkejmizZ6u01DVL+NV0yu5RPiUK058bmN52B8OaPKsgYBNqf25wrzAx2NLQRv26U8XDtQvSRcXZqwe5bTexHn3FcvDJfwvQq1Ie+ia+Gaez+5A+CYw1RvjZ/O/lTWcpamhx67fVFEjxCRkTxiktX1I9yPlRrvIeOcvJ7MVAFTJgd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XtBEH8Jix6Hlr5x+mTg/a24UymRLGRHSU+zUc3Wzo0=;
 b=eZh3Ee7dhfB3e3sefer0N03b2qHjQuX0fzsoZC7ZVnFUNOFnjjP2sOnyOK9e7XwFL++hSSII7yByfmO7Na0IKKgP+uwr+2Q/2K/E6oJ41wsmoQSdHuvVfGzmSPV6lKcaAkn48nHVHlYf95j/yqF5fCQelCWv8FkB72+uPxhW4q8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 15:21:30 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%4]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 15:21:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <saravanak@google.com>, <sboyd@kernel.org>
CC:     <mturquette@baylibre.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <mirq-linux@rere.qmqm.pl>,
        <gregkh@linuxfoundation.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
Thread-Topic: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
Thread-Index: AQHW/vc9M0xRwyNg8kaFXOuETguw+A==
Date:   Tue, 9 Feb 2021 15:21:30 +0000
Message-ID: <d15b1045-2dac-a1ba-a078-2f37786c1d9d@microchip.com>
References: <20210128104446.164269-1-tudor.ambarus@microchip.com>
 <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com>
 <161285731192.418021.10555916396092570051@swboyd.mtv.corp.google.com>
 <CAGETcx9C+sH-GKz61GfCxd9qk=E-AMueHSwPgp5Z_5QcOzXJiQ@mail.gmail.com>
In-Reply-To: <CAGETcx9C+sH-GKz61GfCxd9qk=E-AMueHSwPgp5Z_5QcOzXJiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78370757-ed7e-41c1-d5ce-08d8cd0e6076
x-ms-traffictypediagnostic: SA0PR11MB4621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB46211B54CCB5CC6DC087F17AF08E9@SA0PR11MB4621.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFDqKVN/jPc+ZWMskNYZYMIVgeKq+DSIYBeBsXhlox94pSQpD1hsSf2w34CCxvFB/i+UQTwrvQ+ahQcmXkuSXPTN3ek9+ZJ2GBoqaS9u7TtW9jZlCOwY61SRvPOLyCW5TtJpkwCMpVG8D0wvNMX53WTRNXhk8v5Wb/QzhsTefln9R+GZY7CejuX3NMMrwsIImAk6K6wbeH36SsStdXi7RzxPV+T8yaaZf7CYI8o7tQWlbmjTYq7t3Ln6T4KuHiQHeDKMErtuKNYRA+nE0senpkNwsdHhd61LUb9Teo0ghk6KmwogSlyAHQm0iJwxwHjhGpxCpUXpu+kbcCemWaGup0zoCi2cc9tznDwmW6srONkEsK6pEAbMR4MPj4UXfQrcTeLmHd+TBOlUYiqpSTK+ezvC3pp8UU2nFCn46Qvuy515/JxK6vkxQt09cY9j9USDsUndH49rcTHEGoB2eclwBHxTjHAbj7RXDw9GYlerp6HGS8fDJyY81rOtYOVQHn0TAsDUeyePt9//ixIoLJXqbdsK+EvP4aumtZWinKhTVUEkb64zr/pQ2nKw1Nxamaji5L/chYztK1A58QqsYnVK3CIu6YHed9/pTzFLyBJ+2T75iEfR5iNFkQyDqWqFvn5FGot1YxcbWBN5CqR/MQfrbQN+eVDNC2vka8LNd8j8blPs0V6zdeHLxCqxzB5rbsyW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(2616005)(31686004)(31696002)(316002)(6506007)(53546011)(6512007)(66946007)(8676002)(2906002)(26005)(76116006)(6486002)(36756003)(54906003)(91956017)(478600001)(110136005)(71200400001)(186003)(66446008)(86362001)(8936002)(66556008)(66476007)(64756008)(5660300002)(83380400001)(4326008)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dVBQcHBHNkpSa3ZLWlBLTUxvaFZ5WWVnNWJRRkRqYW4zWTZxdzdoQUtsV3dQ?=
 =?utf-8?B?cnFlcUZTYUs5QUdtUERsY2N6UHU4Q25WZHJrUFloTm54eEs2Si9IekVydnZ5?=
 =?utf-8?B?RWpHWlBkQVRsbk9LL1N2cTJ1UkJmMlRadG9RUlJLbWtzUnBqdnluOTNHTjZv?=
 =?utf-8?B?RDlHelA3QU8xTDFIS3BJMnBVSXJtVkMxeG5PZ1ZFMHRhSk41RG5MY2dlQjBx?=
 =?utf-8?B?ZCtNZ1dVVGExZlU4Rkl3MElkRFgwZ29IeDJlNlB6T2szZjVOb3JTanNXNXlY?=
 =?utf-8?B?czVYK01YamNFMzR3TDZlbUtGb0hCN0Uza2ZpNTZzcmwyMnVPeHJGWm1jSHJq?=
 =?utf-8?B?QzNtd04rMmdwZ2RCUVAveS96aEk4ZWJKVkJqWTRGZXliNWY1VkdyaDZIb2Nj?=
 =?utf-8?B?cHVac2RHYlFOYnplNDhwbFQxaFU5TU5INVh4cWJHZGMzclNuUFlycEErWCta?=
 =?utf-8?B?VmFMY05VVlNoMlgvYmRUTFh2K0krSFY0TUYvRitaVnZXRmVqVCtVSUk4UUFt?=
 =?utf-8?B?b2daM0JjRlBpMDJTT3hRNlhQbWluUk5wMFlDaWxwUHVncmhqeGVTWnFGL3Vr?=
 =?utf-8?B?Z281MXpMUnhkZ0lqWVJiT01mQm1OaXg3b1RBMWdzTEcycnAvTlp5QXhhL1dG?=
 =?utf-8?B?ang5ajROSldNaEM2dHNRM2lRek9MR3VscHlzSU1nWEFkTnlGcWtLTEJaMnJO?=
 =?utf-8?B?TWluK1dBMzk3cTZ6OG9CYzl1TUYxN0NhN1JVUGprRHpHVWRyK293MEVOWkFZ?=
 =?utf-8?B?MTh3ODFxMGNiNExkWHQxTHlyemNHK1pzZy94OUdoa2hNS3VXbzB6d2RySGVk?=
 =?utf-8?B?eW9jS1VnRExZNFZGaE1xQ3QxUXdkMmdHbGdEUkFjOWpBdGZjYzhnb20yY3JN?=
 =?utf-8?B?NHM0dXpNdWNaRS8zYkxWVkZvd0tVelRoeG9GZTNmSG9tNE1JWW9nWWFBZ1NR?=
 =?utf-8?B?Zzh4QmRDbENHbm5OTVM4RTZOdEkwdHFBR3FxMkNicjU0OXJtYUlWakFRZElY?=
 =?utf-8?B?dWFSR2NsUU53NlRGa1cxS0h2dlMwb0NNZm1KWm1GSlFMZ3R0VEVDb0hyeUZ2?=
 =?utf-8?B?R0VjcVFnY0NjUHBXb2Jjc3dqRWRIZWdGQkZ6Tis5MUNxbWc3UkF5V0lLZmZZ?=
 =?utf-8?B?WFh4SW8xNUh1NjNpT0hSOFVXY1Q1QlBYWGd5eW9wVUlla0x1bkxQdGZVdU1n?=
 =?utf-8?B?SEVrYUIvWm15Z01jVzJqOWI4eHo4OEZjUENtTDRuV0FieE8wVmFvOVBHbmZu?=
 =?utf-8?B?cFEwencxNno0MGJZKzlZbW1vVW43VkpsMHcvQ0RqRlNBRUk2UjNVci9jaU5P?=
 =?utf-8?B?WlErWEltU3NndVpGbWExWU1JWHBLRkd0NnJSK0k1NmkvWU1vekN1VVJLMzhh?=
 =?utf-8?B?TDRPZStsRGszUzZZdDJiZTBROXNzemtpejZSa3NQQjlUYTZDakEyWjVrdTQ0?=
 =?utf-8?B?NmxVUEY0QVBCVU1wWUVYQ01oalBvdkd2SCtLK09lejBSdmxEK1FvTnBUUTlu?=
 =?utf-8?B?ZkFLK2xBZmM2T041TlBUZjNsR1lCeHJpcGRac0prQlV5OTRwWkkxZ0lncGs5?=
 =?utf-8?B?UDRHTkRNR1R5TFpkYlNxTDdRZnkvWHdXOVBlSWNLTXJuNmdKeGprWDdQN1pI?=
 =?utf-8?B?TzY3UHJqb0g5aGRGdHFwQlFGb1dPUlhXZmtWaHhWMzVNTjBXWmNsUm9kMXk2?=
 =?utf-8?B?RTA2UGNPN3h4QU55cjhzakVpWFp4dW4wVnA2enMwWm9RN2RGNXE5MGxwc3Rt?=
 =?utf-8?Q?EUvbuAMoUTf9+yAe0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7923C13605F5747BA2F5DB34ED7988A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78370757-ed7e-41c1-d5ce-08d8cd0e6076
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 15:21:30.3247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TY4A0cq4AzjTuS8SFsmyYKLhhl8SNCQbA64Fjea7OyOpecs+ivovSeWdoq415V4Xk5PGww8ZL1ySpk049B4DDqF5E7fN0XiT/1Nb8Ijth4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNhcmF2YW5hLA0KDQpPbiAyLzkvMjEgMTE6MTEgQU0sIFNhcmF2YW5hIEthbm5hbiB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIEZl
YiA4LCAyMDIxIGF0IDExOjU1IFBNIFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3Jv
dGU6DQo+Pg0KPj4gUXVvdGluZyBTYXJhdmFuYSBLYW5uYW4gKDIwMjEtMDEtMjggMDk6MDE6NDEp
DQo+Pj4gT24gVGh1LCBKYW4gMjgsIDIwMjEgYXQgMjo0NSBBTSBUdWRvciBBbWJhcnVzDQo+Pj4g
PHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IFRoZSBzYW1h
NWQyIHJlcXVpcmVzIHRoZSBjbG9jayBwcm92aWRlciBpbml0aWFsaXplZCBiZWZvcmUgdGltZXJz
Lg0KPj4+PiBXZSBjYW4ndCB1c2UgYSBwbGF0Zm9ybSBkcml2ZXIgZm9yIHRoZSBzYW1hNWQyLXBt
YyBkcml2ZXIsIGFzIHRoZQ0KPj4+PiBwbGF0Zm9ybV9idXNfaW5pdCgpIGlzIGNhbGxlZCBsYXRl
ciBvbiwgYWZ0ZXIgdGltZV9pbml0KCkuDQo+Pj4+DQo+Pj4+IEFzIGZ3X2RldmxpbmsgY29uc2lk
ZXJzIG9ubHkgZGV2aWNlcywgaXQgZG9lcyBub3Qga25vdyB0aGF0IHRoZQ0KPj4+PiBwbWMgaXMg
cmVhZHkuIEhlbmNlIHByb2Jpbmcgb2YgZGV2aWNlcyB0aGF0IGRlcGVuZCBvbiBpdCBmYWlsOg0K
Pj4+PiBwcm9iZSBkZWZlcnJhbCAtIHN1cHBsaWVyIGYwMDE0MDAwLnBtYyBub3QgcmVhZHkNCj4+
Pj4NCj4+Pj4gRml4IHRoaXMgYnkgc2V0dGluZyB0aGUgT0ZfUE9QVUxBVEVEIGZsYWcgZm9yIHRo
ZSBzYW1hNWQyX3BtYw0KPj4+PiBkZXZpY2Ugbm9kZSBhZnRlciBzdWNjZXNzZnVsIHNldHVwLiBU
aGlzIHdpbGwgbWFrZQ0KPj4+PiBvZl9saW5rX3RvX3BoYW5kbGUoKSBpZ25vcmUgdGhlIHNhbWE1
ZDJfcG1jIGRldmljZSBub2RlIGFzIGENCj4+Pj4gZGVwZW5kZW5jeSwgYW5kIGNvbnN1bWVyIGRl
dmljZXMgd2lsbCBiZSBwcm9iZWQgYWdhaW4uDQo+Pj4+DQo+Pj4+IEZpeGVzOiBlNTkwNDc0NzY4
ZjFjYzA0ICgiZHJpdmVyIGNvcmU6IFNldCBmd19kZXZsaW5rPW9uIGJ5IGRlZmF1bHQiKQ0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5j
b20+DQo+Pj4+IC0tLQ0KPj4+PiBJJ2xsIGJlIG91dCBvZiBvZmZpY2UsIHdpbGwgY2hlY2sgdGhl
IHJlc3Qgb2YgdGhlIGF0OTEgU29Dcw0KPj4+PiBhdCB0aGUgYmVnaW5pbmcgb2YgbmV4dCB3ZWVr
Lg0KPj4+Pg0KPj4+PiAgZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMgfCAyICsrDQo+Pj4+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jDQo+
Pj4+IGluZGV4IDlhNWNiYzdjZDU1YS4uNWVlYTJiNGE2M2RkIDEwMDY0NA0KPj4+PiAtLS0gYS9k
cml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYw0KPj4+PiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL3Nh
bWE1ZDIuYw0KPj4+PiBAQCAtMzY3LDYgKzM2Nyw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzYW1h
NWQyX3BtY19zZXR1cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPj4+Pg0KPj4+PiAgICAgICAg
IG9mX2Nsa19hZGRfaHdfcHJvdmlkZXIobnAsIG9mX2Nsa19od19wbWNfZ2V0LCBzYW1hNWQyX3Bt
Yyk7DQo+Pj4+DQo+Pj4+ICsgICAgICAgb2Zfbm9kZV9zZXRfZmxhZyhucCwgT0ZfUE9QVUxBVEVE
KTsNCj4+Pj4gKw0KPj4+PiAgICAgICAgIHJldHVybjsNCj4+Pg0KPj4+IEhpIFR1ZG9yLA0KPj4+
DQo+Pj4gVGhhbmtzIGZvciBsb29raW5nIGludG8gdGhpcy4NCj4+Pg0KPj4+IEkgYWxyZWFkeSBh
Y2NvdW50ZWQgZm9yIGVhcmx5IGNsb2NrcyBsaWtlIHRoaXMgd2hlbiBJIGRlc2lnbmVkDQo+Pj4g
ZndfZGV2bGluay4gRWFjaCBkcml2ZXIgc2hvdWxkbid0IG5lZWQgdG8gc2V0IE9GX1BPUFVMQVRF
RC4NCj4+PiBkcml2ZXJzL2Nsay9jbGsuYyBhbHJlYWR5IGRvZXMgdGhpcyBmb3IgeW91Lg0KPj4+
DQo+Pj4gSSB0aGluayB0aGUgcHJvYmxlbSBpcyB0aGF0IHlvdXIgZHJpdmVyIGlzIHVzaW5nDQo+
Pj4gQ0xLX09GX0RFQ0xBUkVfRFJJVkVSKCkgaW5zdGVhZCBvZiBDTEtfT0ZfREVDTEFSRSgpLiBU
aGUgY29tbWVudHMgZm9yDQo+Pj4gQ0xLX09GX0RFQ0xBUkVfRFJJVkVSKCkgc2F5czoNCj4+PiAv
Kg0KPj4+ICAqIFVzZSB0aGlzIG1hY3JvIHdoZW4geW91IGhhdmUgYSBkcml2ZXIgdGhhdCByZXF1
aXJlcyB0d28gaW5pdGlhbGl6YXRpb24NCj4+PiAgKiByb3V0aW5lcywgb25lIGF0IG9mX2Nsa19p
bml0KCksIGFuZCBvbmUgYXQgcGxhdGZvcm0gZGV2aWNlIHByb2JlDQo+Pj4gICovDQo+Pj4NCj4+
PiBJbiB5b3VyIGNhc2UsIHlvdSBhcmUgZXhwbGljaXRseSBOT1QgaGF2aW5nIGEgZHJpdmVyIGJp
bmQgdG8gdGhpcw0KPj4+IGNsb2NrIGxhdGVyLiBTbyB5b3Ugc2hvdWxkbid0IGJlIHVzaW5nIENM
S19PRl9ERUNMQVJFKCkgaW5zdGVhZC4NCj4+Pg0KPj4NCj4+IEkgc2VlDQo+Pg0KPj4gZHJpdmVy
cy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2MuYzogICAgICAgeyAuY29tcGF0aWJsZSA9
ICJhdG1lbCxzYW1hNWQyLXBtYyIgfSwNCj4+DQo+PiBzbyBpc24ndCB0aGF0IHRoZSBkcml2ZXIg
dGhhdCB3YW50cyB0byBiaW5kIHRvIHRoZSBzYW1lIGRldmljZSBub2RlDQo+PiBhZ2Fpbj8gRmly
c3QgYXQgb2ZfY2xrX2luaXQoKSB0aW1lIGhlcmUgYW5kIHRoZW4gc2Vjb25kIGZvciB0aGUgcmVz
ZXQNCj4+IGRyaXZlcj8NCj4gDQo+IFlvdSBhcmUgcmlnaHQuIEkgYXNzdW1lZCB0aGF0IHdoZW4g
VHVkb3Igd2FzIHNldHRpbmcgT0ZfUE9QVUxBVEVELA0KDQpObywgdGhlcmUncyBhIHNpbmdsZSBk
cml2ZXIgdGhhdCBiaW5kcyB0byB0aGF0IGNvbXBhdGlibGUuDQoNCj4gdGhleSBkaWRuJ3Qgd2Fu
dCB0byBjcmVhdGUgYSBzdHJ1Y3QgZGV2aWNlIGFuZCB0aGV5IGtuZXcgaXQgd2FzIHJpZ2h0DQo+
IGZvciB0aGVpciBwbGF0Zm9ybS4NCj4gDQo+IEhvd2V2ZXIuLi4NCj4gJCBnaXQgZ3JlcCAiYXRt
ZWwsc2FtYTVkMi1wbWMiDQo+IGFyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaTogICAgICAg
ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9DQo+ICJhdG1lbCxzYW1hNWQyLXBtYyIsICJz
eXNjb24iOw0KPiBhcmNoL2FybS9tYWNoLWF0OTEvcG0uYzogICAgICAgIHsgLmNvbXBhdGlibGUg
PSAiYXRtZWwsc2FtYTVkMi1wbWMiLA0KPiAuZGF0YSA9ICZwbWNfaW5mb3NbMV0gfSwNCj4gZHJp
dmVycy9jbGsvYXQ5MS9wbWMuYzogeyAuY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLXBtYyIg
fSwNCj4gZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQyLmM6Q0xLX09GX0RFQ0xBUkVfRFJJVkVSKHNh
bWE1ZDJfcG1jLA0KPiAiYXRtZWwsc2FtYTVkMi1wbWMiLCBzYW1hNWQyX3BtY19zZXR1cCk7DQo+
IGRyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmM6ICAgICAgIHsgLmNvbXBh
dGlibGUgPQ0KPiAiYXRtZWwsc2FtYTVkMi1wbWMiIH0sDQo+IA0KPiBHZWV6ISBIb3cgbWFueSBk
cml2ZXJzIGFyZSB0aGVyZSBmb3IgdGhpcyBvbmUgZGV2aWNlLiBDbGVhcmx5IG5vdCBhbGwNCj4g
b2YgdGhlbSBhcmUgZ29pbmcgdG8gYmluZC4gQnV0IEknbSBub3QgZ29pbmcgdG8gZGlnIGludG8g
dGhpcy4gWW91IGNhbg0KDQpGcm9tIHRoaXMgZW50aXJlIGxpc3Qgb25seSB0aGUgZHJpdmVycy9j
bGsvYXQ5MS9zYW1hNWQyLmMgZHJpdmVyIGJpbmRzIHRvIHRoZQ0KImF0bWVsLHNhbWE1ZDItcG1j
IiBjb21wYXRpYmxlLCB0aGUgcmVzdCBhcmUganVzdCB1c2luZyB0aGUgY29tcGF0aWJsZSB0bw0K
bWFwIHRoZSBQTUMgbWVtb3J5Lg0KDQo+IHJlamVjdCB0aGlzIHBhdGNoLiBJIGV4cGVjdCB0aGlz
IHNlcmllcyBbMV0gdG8gdGFrZSBjYXJlIG9mIHRoZSBpc3N1ZQ0KPiBUdWRvciB3YXMgdHJ5aW5n
IHRvIGZpeC4NCj4gDQo+IFR1ZG9yLA0KPiANCj4gV2FudCB0byBnaXZlIHRoaXMgc2VyaWVzIFsx
XSBhIHNob3Q/DQoNClRoZSBzZXJpZXMgYXQgWzFdIGRvZXNuJ3QgYXBwbHkgY2xlYW4gbmVpdGhl
ciBvbiBuZXh0LTIwMjEwMjA5LCBub3Igb24NCmRyaXZlci1jb3JlLW5leHQuIE9uIHRvcCBvZiB3
aGljaCBzaGExIHNob3VsZCBJIGFwcGx5IHRoZW0/DQoNCkFueXdheSwgSSB0aGluayB0aGUgcGF0
Y2ggYXQgWzJdIGlzIHN0aWxsIG5lZWRlZCwgcmVnYXJkbGVzcyBvZiB0aGUgb3V0Y29tZQ0Kb2Yg
WzFdLg0KDQo+IA0KPiBbMV0gLSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEwMjA1
MjIyNjQ0LjIzNTczMDMtMS1zYXJhdmFuYWtAZ29vZ2xlLmNvbS8NCg0KWzJdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAyMTAyMDMxNTQzMzIuNDcwNTg3LTEtdHVkb3IuYW1iYXJ1c0Bt
aWNyb2NoaXAuY29tLw0KDQpDaGVlcnMsDQp0YQ0KDQo=
