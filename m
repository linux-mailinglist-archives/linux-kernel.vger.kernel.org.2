Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074D73FB0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhH3FrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:47:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:57055 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhH3FrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630302379; x=1661838379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5TLTQm28YeYof+92YrWNhms0+6zICVMoRzAH/dqTaso=;
  b=b3XX9U7Ex0HbuPei8N8hCMNDqNJMCfBSLQxfuv/VYvGhn8NR+nyxy3zI
   T2fbcBuKJzc3cdxNEVHe9VJwiiKvEC4YJW4vr6rRAFIgoiCBOqDJWdGCv
   lYTh27zSIICzBZWcr9FGw7UA5oblh4Luheoj3wj/t2yNDzhgRPo3zIlbe
   ncVREYjXq3SRX3FrhGKldJA8TQvMVWnh5iJYrdTgP1/EIrUH/pQwkVAML
   O5dKMweOK9EIRX68wz7nxsKhCikZMS5XqaBsK/sOrXHhrpyR/uVTRpWrD
   H0a1LujTi2uAZjJRrmaO0zOnH4AoISKuiVvm6MhgjeN/glsPl9sl2aE17
   w==;
IronPort-SDR: j4KUm+6RX6dvzyOh47nsJRc6+JJc+leWyKAqihreRCgqkrXHKk8k6oxkDXR1/hxSH4E1l+By6n
 NFP+CSYElqgnrGU8SUommxLTBld6KmtTSgINLlptgRRTkjSdPvXOD9ULJdvmrg4m6Xd+bUZf30
 PZ0Mwi1ruTT7WWMl0DZTeGdA1NHWBcTPFVSg///ZzxOKYqHNoclH4YmXEVAHcHAPG+pvORbOc8
 lUCoA0dlyHKhpQI7qD2k9H5GJR9m2lW2ZJyM3QjRqJClk44qwk9nJJ2J0WHQ5MFRZw8YKAoxi8
 H3lAzFo69p8QWnqqLO77BvBX
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="67539040"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2021 22:46:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 29 Aug 2021 22:46:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Sun, 29 Aug 2021 22:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWrc5xh6/IxP2r6ggVs7eMv9lFNEjYyjNUBFmtjQ8TSSd0HCA4HAMpPY0wJd29frJoRn9jE/y6sComkhUsRqxzsScUG7F/6Q/aWQTruXl24S/4QOn2b5bMl7y7UNUqr+cxkRgVOgHhbr0bzL23b9dwM7vI0MIknuk0aIcuBU+ZNpuqwCJXCe9Vnk3Oerf2hBqHHUqLEsQnWE8aD0W+cNplm1yQbkkU84RUmnPehr3ddse2t2CxKvw8I3hum5ogfdOXgYBhIz3njFtKcMhyhKFIzCswogYBpd2HsJnzaLEyoQneHaNSftMVAvVy0kWlBQMIhVlUT+t2LLjuUELACZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TLTQm28YeYof+92YrWNhms0+6zICVMoRzAH/dqTaso=;
 b=cI7AmmsAx/kLpdH+Kl69NaKxxiItCwzPJjUsZ7YLwKGrXHz4gpgA9StU3WhhPvzseHv85lWjU12g46LFslO6YQgzgO/2Z+SCLe5lTGkgH6bgMy1NguTv+r4AG3Wcmywo+9Si5q6IG7cCVgAc/NUtgbHRFR/i4Soe2OIeFJMSaNftfvVCkf4m8AeWqaO8P+zBOZJYKgnHeP+ABAWZqARN7sJ5mhqt7drqCnijSL1Oq2Z3bqcRr9s5/s4PQ6iKikSpTbIiEJnDFnTXERhQsQ9EZETnORxmqLNuRHK1Bkl//ZpzVqIi7qG8lV/Ikl3f9yaP+rclOs4hI59HY1fiN6rvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TLTQm28YeYof+92YrWNhms0+6zICVMoRzAH/dqTaso=;
 b=Y3rWa98YppVbmLfr0bAy4qKcFEopHXyL3mg2+FqtUkAmv8fvHeJFPFBwSGBw44S3xXruXgcaWnxwKHmOLu9ee02CibhNbV/egQyhXdMjWzK9EuyXIluSFTy6s5jgxP2Zad4cY3dCRIMlk107G4ZcHK+f7vM1ybX39OXVNuaLxr4=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.24; Mon, 30 Aug 2021 05:46:14 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c%7]) with mapi id 15.20.4436.027; Mon, 30 Aug 2021
 05:46:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sboyd@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mturquette@baylibre.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] clk: at91: updates for power management and dvfs
Thread-Topic: [PATCH v2 0/6] clk: at91: updates for power management and dvfs
Thread-Index: AQHXh3mKhFUuH0RmS0yHhRgJvP8+0A==
Date:   Mon, 30 Aug 2021 05:46:13 +0000
Message-ID: <35d409b5-75d9-636e-e9c5-42d833b8e592@microchip.com>
References: <20210401122726.28528-1-claudiu.beznea@microchip.com>
 <6ecc4822-8112-43d4-1259-cd7dfe79d71c@microchip.com>
 <163021931214.2676726.2951110502140668721@swboyd.mtv.corp.google.com>
In-Reply-To: <163021931214.2676726.2951110502140668721@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17a8ef48-6605-4846-b222-08d96b797a97
x-ms-traffictypediagnostic: DM6PR11MB4722:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4722C0FCB2F9933AEC8DC98187CB9@DM6PR11MB4722.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gw3yO7YyZ3hkNkVCVthk1R6KIFmzV1+YsfaWRXb6YZXR3nJBNVWsdKrFzt8hR07RCLkCj9IHN5EL2IdCsei49qYpyZ+MNQChaQKu514W26J4Xl7lLDJM9AtMGANRH8lneFa38CxlBV+66vkJstrZc4YZcSaMFHp6FkqSZ6hjlRboWJdOpco2la0Vd1wy1dogMSJHzrzaGhDNZyk5KdgfkDAmld7+uRqm5kWTxWuynkRwzBx6EFzUtjm5Y92/MgA6dJ46pCAiBOf/uIZJA9zJ+ZrN87HC+Crp3ZwWl1o+OTonqlueSmqguNa6lq6IAjMbhBbEndW/s03FwKrICXytOkkXddYYzsnefpBuZqb+JJg7w/oqWTXWu2UhiXxIbBp3YFhXlBclln0OBn6uGvyq32987TKeqs7jnrQAc/um+saFJkhx2XSUc4Y1jbFB7Bt7alvHd2Je5yjbp+TXNagERNY0ZP0Vlcw/v9AcoZJ+4Gg+q8b8mPWVjy5JROsUa+E2tpBAu+7YlPSeVjaTndwObchXPL9lHM8La3EiEzpZYYjN3d/TX/nBIejHj03zVZDTZkEmGM8XREHyUb0fIkAydNRXPI2HewwmKhQqaYegIhOKFAucRIXOzUAH+XI6BfyKRfeDydMuhqCdRs6/WO2jAYYqI9dqeaYT4UraNBJE1HuyTZACpSkWo1vfrfOTrnQP4yV2Uwi/gCC+DqkALKAAGPsoODdkFN07OLyo7aQ+HJIxpdy1je6bDTcGnKpt1DZMqwta2dckaCZq27iZlVc20Yu+9txGkQDv+zYRWZeS6wR1UrchxvEh9jyXW+dIA/i3vAm2SJrzgiWWqwZs78krXabwQFBPP3GoEBTxcU39xGk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(54906003)(86362001)(91956017)(76116006)(5660300002)(4326008)(6512007)(71200400001)(66946007)(66446008)(83380400001)(66556008)(64756008)(66476007)(2906002)(110136005)(6486002)(36756003)(38100700002)(2616005)(15650500001)(316002)(26005)(122000001)(31686004)(53546011)(6506007)(4744005)(966005)(8676002)(38070700005)(31696002)(8936002)(186003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTlsQjdzWGtUWUNLZWxXOG5RUjRXYlJrVExYN2pWN1ZQbk56Qjhqck43WC83?=
 =?utf-8?B?b0J5R0RTRTZ5QVpsUmRTR1cxNHRwQ2d3c2phd1ZEQklUaDg1N1pDczJFM3FK?=
 =?utf-8?B?T1BkdU5CbTFIV0J5bG9hbWJ3N2dsNXBBRS81MVUxZmJxRVlpc3hNMnhkOFN0?=
 =?utf-8?B?cjJwbzlCaFhRQ3lNK3hva2JVSjd0VGJsMFlsUlJaT0cvNzlZTEZWUzQzVGU2?=
 =?utf-8?B?MFFqaEd3ZEs3QXhqWXdhTFFIeWRKODc3MUJzb3Roak42L2xXMTBOdE1rSHg5?=
 =?utf-8?B?ZnBwbjE3cTNmKzBPUERCQ25zV2paS0l6SllHbjBuYldWUDF1bHZPdkNRS1l5?=
 =?utf-8?B?dGR1YmIzVGRMYnBNMWdJbGswTFNyeGJUOHJOMkxQaHBVeGY2Z1RkeVMwSFZQ?=
 =?utf-8?B?bllnbFZUSy8zeUJsR203VjR1bkdKblRsd3ZTcFdQVUNkQlpYQTRYSkFjZGhv?=
 =?utf-8?B?b2xTSXpqSlJEY2hkeUFmQW5WN1FabHlWTkliL0JLT0w0Q09sVVdGTkZ3M0F2?=
 =?utf-8?B?NUZFM1BGZWpqeWdQeXFyVU1MVjd3dWVBVXBPekZrdkJ1VkhLbllnUllpTXFo?=
 =?utf-8?B?aDVHM2wvTXI3eTRXQXJUSTgyYWt0Zy9QNmNnNDY2cmlJblR1cnZWK3ltRC80?=
 =?utf-8?B?T2dqQk8wajlxNUNhZ2lSSmlHT2wxcUVGNUpGdFBUWnd4encwMnI2SDFqOGJV?=
 =?utf-8?B?Umlqamc4cFNYVmticVp0MTRydGpOQ2pqZk1mMFdSZXVMc1loSGhESER6T2hj?=
 =?utf-8?B?RzlFYUxta2lENENJSW1ycFdFNzMzVERHSTl0QWprVXNuMXJ1dmsvSjFWY2tj?=
 =?utf-8?B?c1NZbmkxd3c3T0tjZEw4ZzRtcGZuN1ZmeWVZOWFOc08vS1lKR3B2Qi8vNzZj?=
 =?utf-8?B?RGxyNXV6L21qZ2E5TjV2V0RIRGJkNnBMd2p4NVhlR1Z0MW52cldrelNabXN0?=
 =?utf-8?B?SjZNZ2N5NFBoUXhrRDRkaS8yektGa2RFZFc4Yk5VY2IwNUw5ZTNoNDNZMEh6?=
 =?utf-8?B?Y2NYMjkzUFp1NUFRNENoL3p5clkxeU52VVlJeGdpSzJTdkpsWElXNmw0Sk5s?=
 =?utf-8?B?WWpwQkd0Y2NuRE5CUm9BMnFwcVFhRG51RXZPeUNlTW9IVnNNKzhqV0pBbGtJ?=
 =?utf-8?B?QkhEUjFma3hybHhRREF2eUI1N3VwdFFPbkRrczdsSDMwQWFTVDV4eVNUdStW?=
 =?utf-8?B?akNReEdDL3FBQVN0ZU05MmY3NStCZVRJelpWb2hGYWtlaUVwNGxET2xwNWtl?=
 =?utf-8?B?bDV5VGF6NGV2RmJncXIzbEZMcWkvM0ZQb3RyK1pwWXp0NlVzVWxLcFRwcVpY?=
 =?utf-8?B?VWFMWENjRDJsSW8wK296STR1QUZYNTBKY09WZlExcnlvOGxhZ2lUQ0VMQkRz?=
 =?utf-8?B?Z2NkMStydmkrb1R2cUJrWTFpRGRvWkdrM1lXd0xkVktrNEliMEZCUklpM3Vo?=
 =?utf-8?B?cVJVeGJETCt3ZmlkVE14WVFrYTllSFd0bVdXckpya05GYnhkOG8xV3kyUWIv?=
 =?utf-8?B?QUNkMzRib0xuVGM5bHFqeVVkUXAzRDM0U1JYQzQwdmpkQmppcGd0cW10TWpW?=
 =?utf-8?B?cDhkajBBVmFWSkMxRVZrd1VJK08rUitySStSUWt5c0w2eFB4aXQ3bjR2Wll2?=
 =?utf-8?B?RE44aEdGWHhUN1J4blJjRTdPZVdETkVuU0lWUEo1eFJ0MTl0QUw2MzhTcTJZ?=
 =?utf-8?B?OTh5YWNzSWtaNytTTGUrSTJndnVPUE9mSW5mWXBOSGFhMktpdDdZeElSNUhL?=
 =?utf-8?Q?oN6SXWV6Vg2ENakzuU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA2624B370A64C4B9D5E6BE54936DEF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a8ef48-6605-4846-b222-08d96b797a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 05:46:14.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3y590Qawxv5al1g7WMHI7CvXfdSh8uBYuG6CtjUQKkEv16jhmdC77pD7pWTtevJMtce3UkxTii57wYw5vKFYvbKrMDUaySTanrsIvc0gQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkuMDguMjAyMSAwOTo0MSwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFF1b3RpbmcgQ2xhdWRpdS5CZXpuZWFAbWljcm9j
aGlwLmNvbSAoMjAyMS0wOC0wMiAwMTozNjo1MikNCj4+IE9uIDAxLjA0LjIwMjEgMTU6MjcsIENs
YXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4gSGkgU3RlcGhlbiwNCj4+DQo+PiBQbGVhc2UgaWdub3Jl
IHRoZSBEVkZTIHBhdGNoIGluIHRoaXMgc2VyaWVzDQo+PiAoY2xrOiBhdDkxOiBjbGstbWFzdGVy
OiB1cGRhdGUgZm9yIGR2ZnMpIGFzIEkgaGF2ZSBzb21lIHVwZGF0ZXMgdG8gaXQuIEknbGwNCj4+
IGludHJvZHVjZSB0aGVtIGluIHRoZSBuZXh0IHZlcnNpb24uDQo+Pg0KPiANCj4gQ2FuIEkgYXBw
bHkgdGhlIHJlc3Qgb2YgdGhlbSB0aG91Z2g/DQo+IA0KDQpZZXMsIHBsZWFzZSEgT25lIG5vdGUs
IGF0IHBhdGNoICJjbGs6IGF0OTE6IGNsay1tYXN0ZXI6IGFkZCByZWdpc3Rlcg0KZGVmaW5pdGlv
biBmb3Igc2FtYTdnNSdzIG1hc3RlciBjbG9jayIsIGlzIHRoYXQgY2hhbmdlcyBpbiBoZWFkZXIN
CihpbmNsdWRlL2xpbnV4L2Nsay9hdDkxX3BtYy5oKSB3ZXJlIHRha2VuIHRyb3VnaCBbMV0gdmlh
IGF0OTEgdHJlZSBiZWNhdXNlDQp0aGUgYnVpbGQgd2FzIGJyb2tlbiBhdCBzb21lIHBvaW50IGZv
ciBtdWx0aV92N19kZWZjb25maWcgb24gbGludXgtbmV4dC4NCg0KVGhhbmsgeW91LA0KQ2xhdWRp
dSBCZXpuZWENCg0KWzFdDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9hdDkxL2xpbnV4LmdpdC9jb21taXQvP2lkPWVjMDNmMThjYzIyMmJiN2JlYzA3NGNl
Nzg0NWMxNTdkMWM1MTk1ZjYNCg==
