Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F403999CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 07:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFCFYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 01:24:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:37467 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFCFYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 01:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622697778; x=1654233778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2IpSopZ0Q+flyCzz9howpViDDP9HB6uoETQ4GJxZEqk=;
  b=Wog+D13XlxEh2EVMp60DCBIDMH714+uQvXZ5UGdnHEWn6X+ZhFCvrikW
   jj2BlxiYmdmNGaEqK5k/ooFdoZPIMj8K3KV9tfGIsElBSS3saNJLFy/V3
   e6+h0Xqwhi6Jhsoa427UlK8677Ni1XowQ88lEcrVhoRfn1+2gORHyij3G
   /XkQwiUYO0/9utOuIDyMExfO7atyuamflz0Lz44ICPhN630Tmq0gfQsnt
   iLX9wS4d23k0zpHH1SWbMAzW0h9izltVf8GRay7ffh5lNWYAk75jd2N6P
   I7ygQVulHQgQ2/hShm6NBqS7eukToWzurcC6XAhts5pghsJYDVV/MGZj4
   w==;
IronPort-SDR: yGrKDGv6amHSshh0Em0IzdBPvoj8+ovQnjx/spPEAblenF7q1n5p6gmmEUFGXmypajhgrSq6m3
 NMsf/g3PKFyBZwu6oaL6vbHVpc6QA9mLPWChzz2/6eo/LvQeKN0oFTjLxckAZM736MGBEbrdGf
 DqZpLn3hnMzqgErvjz4Lgovr2nMPr6CRGXMKLvc1CgXvoYDFN6zZTNffidvFoMsb5hYdjoH6+H
 1u24QK4TmBuF0fjCXqDSSB2pmltBdyxIEABae6DAGKEgewTilpS2+VDpZ0HR+E4kIH/TMSP3XB
 mrM=
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="57716305"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jun 2021 22:22:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 22:22:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 2 Jun 2021 22:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxM+6kemHGKIUbCzh1I/tW+IzjRsRq9cVfAXeZIj2iURUOQJV8WyQH5PLBdpCd+PDj15tyrT6oMldfjsR3zDaQjtn2GQmliPLjLbqXRooGH3nVTnib6/R5fJwF7LNlD9a6uouHLoLDu7QdZuaPYYqmYt6THuE5Nvyw+3Gtd3UflYCvWA8LBAEpvjXnaaOehQ+ngCG9HDXtKKpYn9Q+7x3DYzi7+TVnZfx/jejTpnlaGFYSYnG4AkKGUY14jhdpB9intZt5OSC8Py44kUY1r5K3J3vxnLa0dl8I6/svUyyHmUvEPbyOlBGvjr/T+GMGBmL//FAKBqxEb+S4Ym8kW9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IpSopZ0Q+flyCzz9howpViDDP9HB6uoETQ4GJxZEqk=;
 b=f9UP0ltE3zycgNSVD0TC9yszX+PgUoTgBJpsiWNzdrgS6qBAIQyaMH2gnleTN1szhHFRoRuKOMDzJ0wuMUGozSF2ZoCBQYHTlyxsFnYOoUBej4dxiFm6MVvzzHWQqJi2um+sp447XNQOKDziDb4efO8D4WSaOVRk0tfQt8qy665556ROb3aH8KvfWVOQRMrGzw6drrFmEnjW1G+ArNaaXSpNK5+oMaH+mzU6BjA/BP/o2IvlkJIXDC1MLL4qz6aA6UpzeD8zMIYzBIwxVKqWN17ZuzHa2k6U/hMBEn7eBrokPY72PwhW+JKY0AQKhqYODoE68t3SVSGa6eb+PRpvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IpSopZ0Q+flyCzz9howpViDDP9HB6uoETQ4GJxZEqk=;
 b=EvbKIraEcIl8yE7Ocuk8By99iUurVcFgChFWbF5BzN97J5Oc6eN4RGkR9dYlLLuWmLvSxIKsUlaThPW3jYOxJcJDayvYjHs8ieolVcUx3Ylu9FHXIO9nJsZkkBncTDVDyu5im8lNzI+8gDg5pz7GQAj8KsntgVIeBODGOl3xVWQ=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR11MB2064.namprd11.prod.outlook.com (2603:10b6:300:27::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 05:22:55 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 05:22:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/4] mtd: spi-nor: otp: return -EROFS if region is
 read-only
Thread-Topic: [PATCH v4 3/4] mtd: spi-nor: otp: return -EROFS if region is
 read-only
Thread-Index: AQHXWDiB0f/OzqNCxE+GIZpPHw2egA==
Date:   Thu, 3 Jun 2021 05:22:55 +0000
Message-ID: <d4b4d8c5-aacc-0cb7-2d30-8480b7904ac6@microchip.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-4-michael@walle.cc>
In-Reply-To: <20210521194034.15249-4-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65a23a82-d79a-48c8-c440-08d9264fa45c
x-ms-traffictypediagnostic: MWHPR11MB2064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB2064BEA3DC0D0962B3634551F03C9@MWHPR11MB2064.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJNby6pnZNrqo7vnPhODn9pnG/QBwLl07G5Qei5C5sTL6Z8lRfVFHlPWFqXFESdUpWFD5Hktt+QlD9xy6bs/m3PB5ECdh128PLICg9MPL708to3brlfbDceHuC9VBzAKosft1UOuuJZWMrksECquiWYbbzqXQq+IJIXWh+ac1r/iaopHGp78wp7S6OhdZsprJIh9soWqkU1vnZgyIJHVeNMlhJIzOSW5M4XXwqbfl6YFPYjWRcrQKUPORfi5vN1w0FjrDaBdOMIMa59Q3FJVNcynrhfFNkHlz2OpXp+IQctE5AYkYDVilW0ODh1BooA9uyeEiKstu4LDMrwpQMyMXfhZi9Ex+Y63Bv1+JniKNo2suEhaXUysrZkrkjNd+WAmrwQd9rN6H7zEEvnOVvImtp8oezvZDz22JueDFqucts5q1PZqYMbZQBAJHFniENa4GBhgwqk3eO09sORfplhKemnYGAm2sLdzYFhtJFEWRJ2PYtkAYRdT5HV+mvI/IAhGJ+0H01Ku7462gRiaB/hbUiaXKjd/9HxxesixDSKGfyphPJvaIssh7SJjglp6Q2891dg+kYzJDNn9QdZABCBj6Nm9YLyU8FwURZHBES6l+TFAImC7EQRH95c0vbDs6AE8y0N+FDekTjzso12kr+6tP99uMtfMpj0CBScaG9c8GYeDfXPobOnSjZN0Znzd8Uda
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(346002)(396003)(83380400001)(5660300002)(4326008)(6486002)(2616005)(186003)(86362001)(31686004)(91956017)(31696002)(26005)(6506007)(53546011)(76116006)(316002)(122000001)(36756003)(38100700002)(66446008)(66946007)(66556008)(66476007)(71200400001)(64756008)(54906003)(110136005)(8936002)(2906002)(478600001)(6512007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dTdvTCt4QWlyaVhJcDRUdkl0QXlVWWdBL1BGWmR4ZFRtWWczOUR5RDZkU3Na?=
 =?utf-8?B?aWVhcC8wQytWbFFTNGZacDZvdTdIZDQ0MS8xVXFCNGFSTDFVMkZZN3FGSDdp?=
 =?utf-8?B?bHBONndjSlpGR1hvZUxDWlhCcXd3NG5wRjYrZkVDeHhacUJoblNROE5FMGVG?=
 =?utf-8?B?aTFia0tlN1NWcGdMNlFCNWZtcmdRQkZjSndpdUJ0QXp1RklNazdUdnZNeTAv?=
 =?utf-8?B?R0x1cUZQNFpPMUlrK0daR1BES2QrbDFNZyswTDlYQmVLWHRjMDVqUGtJWjZp?=
 =?utf-8?B?VUtjTnRlTVkrL0FzbUVFdnAxSTJlWVA2Wmw0aW80ZzFpTmg2TXBISjUrMEFy?=
 =?utf-8?B?RVdKSEZjMUVtT0VZZHlVandhWlA5cTJXcXhBNThNSkw1T1pLU05GMXZFTEIy?=
 =?utf-8?B?WFFSRUxTZnV1M0UyNldvSzZIRTlvYitMS1pNVWVRbmxSOUtFOFJrN1kxSWZa?=
 =?utf-8?B?ZjFvUTNyWDBzRWtvekxnYjVZME84RGZvRXNVQW1WOTFDZ0o0Kyt4c1FUeFMz?=
 =?utf-8?B?UGszUGZ0UU5oWDZ0TFo0cWtqR2FOamI2ZFlla0laN3lKNU55dEFFLzZBelA5?=
 =?utf-8?B?eS9lTk1xK3NqdDN5Zk0vNWdjYnVrT0wyd1NWSlZVZ3kxc3c0Ry9ybFV5S0FH?=
 =?utf-8?B?RTNZSURUM3VFUXZiTUpqNzRiOFpXQzVqN1dCenRSQVlDQnJkbWJTYXB5a2R0?=
 =?utf-8?B?RXltdkhJSk1kNXJDV2Q5dmlvOEQybHZZSFd6ZlljZXdDRjVmVytiSFBsVUpQ?=
 =?utf-8?B?UnhaK1NIZlpnRk5tVWxUcTBoZm1QU2F4NEQyQmxsa1BhZDZFR0V1U0NLbDJh?=
 =?utf-8?B?Zm9yL0pKZkI4N1NtTk9SdVAzUkJjLzhLUDRORlJqQ0txUUxTdkY5M05FZ2pa?=
 =?utf-8?B?NWZTVWFEaDJBYStCbHV5TWJxdG5MWkgvdGVUalNHM3hsbGt6bjBNcFlyZmpI?=
 =?utf-8?B?T3FaZVpJdlhLY1Q0dnNuM01LS2dGZjBUc2x0aHdqaHVKMWZzcHRJSUlHUXdC?=
 =?utf-8?B?OVhES1prVUZpdWxKbDJPdVdrUzBmNGs3OHRyN1ZtQzJ2ZnplQ3NnYkkxZkQ2?=
 =?utf-8?B?d0hiUXN3bC9QdXhyRHRXNmdEMDRwK2ttWE5PaEhtRGpIWFdQaDdNRmNJakFS?=
 =?utf-8?B?Q0dSMElqLytpSE8vTFZTbDFzWUg4MDd6cFY4U3cyZ2xGekdhaERVVEdyelpD?=
 =?utf-8?B?Vit1TkRiWmtTVE8zamxMT2ZGYU9ZdHlPKzEvWXZZMzZwNXg0cWRyZ0hGYUx6?=
 =?utf-8?B?bTZ6Vm1SdVNlSUdhL3A4ZHIwVnJKSW50MWRpQ3phb21nRlRiaW9TRnFiYWg2?=
 =?utf-8?B?bXF1UDdSNExTNmkrS3ZBdEZELys5SWQyVFJ5UUVleFdON1B2elBmRXplbHU2?=
 =?utf-8?B?SXV6UW96UDFuWmcwZWlob2o4eGY1TWJpeUNCU29nM0hudkwrZ1hXdlQ0VGRW?=
 =?utf-8?B?Vk5uc283c1RjdVlvbjQvMDNwVllTVjViZytHRVlYdHlJeUhzUW4vbUZBQlhH?=
 =?utf-8?B?c2NXNFBDVytVZm50b214a1lsenRlemlKZXBrbG44OHFTNlZDUTRQSUI2Ukti?=
 =?utf-8?B?dGEwdHNLd3BZYnYrSUlaWnJKL1hYd0JGcUliWFpXVkFRY0UwdzlINGZBTTV6?=
 =?utf-8?B?MmliaWdhZEViUWJ3OE04RVdSU3VFWGo1TXRzcHlGc1UveElpT0F4RzhBNU9M?=
 =?utf-8?B?dkFLdTlIVE9IR1hqVGpJc1VIdmFBMzJVaDd2OGNPc3FmQUxYRytJSzl5VGRk?=
 =?utf-8?Q?DTqcJ4VOlfYir+xy2I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <619F6A2D4E0FA541B291D362A2207E9E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a23a82-d79a-48c8-c440-08d9264fa45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 05:22:55.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hsyfk2DJwu6o9GmnqLp739m5qirpL4+/m4fAadPJISJb5X6b/zKDi2I9nV053s1xKVAhZgsd9ExXnQbLQxJXl/uSFq2Cg7IIf5mu+hEx+hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMS8yMSAxMDo0MCBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTUEkgTk9SIGZsYXNoZXMgd2lsbCBqdXN0IGln
bm9yZSBwcm9ncmFtIGNvbW1hbmRzIGlmIHRoZSBPVFAgcmVnaW9uIGlzDQo+IGxvY2tlZC4gVGh1
cywgYSB1c2VyIG1pZ2h0IG5vdCBub3RpY2UgdGhhdCB0aGUgaW50ZW5kZWQgd3JpdGUgZGlkbid0
IGVuZA0KPiB1cCBpbiB0aGUgZmxhc2guIFJldHVybiAtRVJPRlMgdG8gdGhlIHVzZXIgaW4gdGhp
cyBjYXNlLiBGcm9tIHdoYXQgSSBjYW4NCj4gdGVsbCwgY2hpcHMvY2ZpX2NtZHNldF8wMDAxLmMg
YWxzbyByZXR1cm4gdGhpcyBlcnJvciBjb2RlLg0KPiANCj4gT25lIGNvdWxkIG9wdGltaXplIHNw
aV9ub3JfbXRkX290cF9yYW5nZV9pc19sb2NrZWQoKSB0byByZWFkIHRoZSBzdGF0dXMNCj4gcmVn
aXN0ZXIgb25seSBvbmNlIGFuZCBub3QgZm9yIGV2ZXJ5IE9UUCByZWdpb24sIGJ1dCBmb3IgdGhh
dCB3ZSB3b3VsZA0KPiBuZWVkIHNvbWUgbW9yZSBpbnZhc2l2ZSBjaGFuZ2VzLiBHaXZlbiB0aGF0
IHRoaXMgaXMNCj4gb25lLXRpbWUtcHJvZ3JhbW1hYmxlIG1lbW9yeSBhbmQgdGhlIG5vcm1hbCBh
Y2Nlc3MgbW9kZSBpcyByZWFkaW5nLCB3ZQ0KPiBqdXN0IGxpdmUgd2l0aCB0aGUgc21hbGwgb3Zl
cmhlYWQuDQo+IA0KPiBGaXhlczogMDY5MDg5YWNmODhiICgibXRkOiBzcGktbm9yOiBhZGQgT1RQ
IHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxl
LmNjPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivb3RwLmMgfCAzNSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL290cC5jIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9vdHAuYw0KPiBpbmRleCAzODk4ZWQ2N2JhMWMuLmI4N2Y5NjU5M2Mx
MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9vdHAuYw0KPiArKysgYi9kcml2
ZXJzL210ZC9zcGktbm9yL290cC5jDQo+IEBAIC0yNDksNiArMjQ5LDMxIEBAIHN0YXRpYyBpbnQg
c3BpX25vcl9tdGRfb3RwX2luZm8oc3RydWN0IG10ZF9pbmZvICptdGQsIHNpemVfdCBsZW4sDQo+
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgaW50IHNwaV9ub3JfbXRk
X290cF9yYW5nZV9pc19sb2NrZWQoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IG9mcywNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBsZW4pDQo+
ICt7DQo+ICsgICAgICAgY29uc3Qgc3RydWN0IHNwaV9ub3Jfb3RwX29wcyAqb3BzID0gbm9yLT5w
YXJhbXMtPm90cC5vcHM7DQo+ICsgICAgICAgdW5zaWduZWQgaW50IHJlZ2lvbjsNCj4gKyAgICAg
ICBpbnQgbG9ja2VkOw0KPiArDQo+ICsgICAgICAgaWYgKCFsZW4pDQo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gMDsNCg0KbWVoDQoNCj4gKw0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogSWYg
YW55IG9mIHRoZSBhZmZlY3RlZCBPVFAgcmVnaW9ucyBhcmUgbG9ja2VkIHRoZSBlbnRpcmUgcmFu
Z2UgaXMNCj4gKyAgICAgICAgKiBjb25zaWRlcmVkIGxvY2tlZC4NCj4gKyAgICAgICAgKi8NCj4g
KyAgICAgICBmb3IgKHJlZ2lvbiA9IHNwaV9ub3Jfb3RwX29mZnNldF90b19yZWdpb24obm9yLCBv
ZnMpOw0KPiArICAgICAgICAgICAgcmVnaW9uIDw9IHNwaV9ub3Jfb3RwX29mZnNldF90b19yZWdp
b24obm9yLCBvZnMgKyBsZW4gLSAxKTsNCj4gKyAgICAgICAgICAgIHJlZ2lvbisrKSB7DQo+ICsg
ICAgICAgICAgICAgICBsb2NrZWQgPSBvcHMtPmlzX2xvY2tlZChub3IsIHJlZ2lvbik7DQo+ICsg
ICAgICAgICAgICAgICBpZiAobG9ja2VkKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gbG9ja2VkOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0K
PiArDQo+ICBzdGF0aWMgaW50IHNwaV9ub3JfbXRkX290cF9yZWFkX3dyaXRlKHN0cnVjdCBtdGRf
aW5mbyAqbXRkLCBsb2ZmX3Qgb2ZzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVfdCB0b3RhbF9sZW4sIHNpemVfdCAqcmV0bGVuLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHU4ICpidWYsIGJvb2wgaXNfd3JpdGUpDQo+
IEBAIC0yNzEsNiArMjk2LDE2IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9tdGRfb3RwX3JlYWRfd3Jp
dGUoc3RydWN0IG10ZF9pbmZvICptdGQsIGxvZmZfdCBvZnMsDQo+ICAgICAgICAgLyogZG9uJ3Qg
YWNjZXNzIGJleW9uZCB0aGUgZW5kICovDQo+ICAgICAgICAgdG90YWxfbGVuID0gbWluX3Qoc2l6
ZV90LCB0b3RhbF9sZW4sIHNwaV9ub3Jfb3RwX3NpemUobm9yKSAtIG9mcyk7DQoNCmNhbiB3ZSBt
b3ZlIHRoZSB0b3RhbF9sZW4gY29tcHV0YXRpb24gYmVmb3JlIGNhbGxpbmcgc3BpX25vcl9sb2Nr
X2FuZF9wcmVwKCksDQphbmQganVzdCByZXR1cm4gMCBpZiB0b3RhbF9sZW4gaXMgemVybz8gSXQg
d2lsbCByZXR1cm4gZWFybHksIGF2b2lkaW5nIHVubmVjZXNzYXJ5DQpzdGVwcy4NCg0KPiANCj4g
KyAgICAgICBpZiAoaXNfd3JpdGUpIHsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IHNwaV9ub3Jf
bXRkX290cF9yYW5nZV9pc19sb2NrZWQobm9yLCBvZnMsIHRvdGFsX2xlbik7DQo+ICsgICAgICAg
ICAgICAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91
dDsNCj4gKyAgICAgICAgICAgICAgIH0gZWxzZSBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldCA9IC1FUk9GUzsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBv
dXQ7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfQ0KPiArDQo+ICAgICAgICAgKnJl
dGxlbiA9IDA7DQo+ICAgICAgICAgd2hpbGUgKHRvdGFsX2xlbikgew0KPiAgICAgICAgICAgICAg
ICAgLyoNCj4gLS0NCj4gMi4yMC4xDQo+IA0KDQo=
