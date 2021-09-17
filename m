Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9FF40F759
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbhIQMV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:21:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50656 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhIQMV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631881235; x=1663417235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SmH1Z3waykOM0ekKOX6DciUcc2MVHABBZuZRkDGVODk=;
  b=wIE41d3xfkKDC38xRjy3riU66YHDx1R0nMBAFJR8q4RT9VjXqGTo5vVE
   4fKsTMsXVCOJfKEZYAAxpqQTxjEk73sjnA/ijn5jW953w3ESy82sNqrlv
   XkjmUDTQH4X/gVqpPjl9KPQ6hENE4TOVRkvPtK7dhkjeQSj8hmlk4AlPl
   F/vTvMMwgBWhi8IgeP3wTrAPz6hjSYhPrZfiXWBSQlIgA0JkoBTfrbrAi
   QHwNjaYw9U4oh4JdetnKhONMjiIXQc7d0vOWQQfCYtppMyX3v/31HPIR8
   V4bCjFh2KGbzROuV2NXx4l0to+HTBTkZBU/W48d3YaFp7ba69CDxwGUsi
   Q==;
IronPort-SDR: 3sJ9Lu8VutDHyfIK1cISSnfYvEcnYUVh+Qv4gceWUZHFspRjdPcshAc8LdVGF6PhLWIDbNwNxF
 I+kq/jvXQIxZ+VfwNpHbl7k4zhROhaoa7kAAL5q1nuzZF0l+D92qOt+osSSSbLZhL8/EVqtrd0
 hRq7ph6ciTZr7Y9CU3F/JmzqEkdcXTjPw7VtS8QtiiYy22I+tK9XGUdm9RXYwX9mnhW0A4yyvF
 jT45vu+Exmrn/N7iBvCXSlcD2F+YAXcGmTy4Q3lxmY5b190SltsN01FbA17q0fyttJQpwF4lqQ
 GxiUYBGrRYjdd/T2+oWT+86W
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="144536447"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:20:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:20:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Fri, 17 Sep 2021 05:20:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrzscZkI6P/yrYZAe9T3PGOg3h0Kzofa67eR5njoVwOI7WfnmUYPOHFh3Wx+yNnOG7Hh9HUUPBcSnsnYbgpzWLyy7je0IJ75FGVfMbkhsLLgzmhcQDsSeXyt/5FYcQUloBqUoGpetFx6bQFv9+nqf32gHKBUggE857GsyhtrzjW4hbdW+oMSz3ZbyOWlGF6mxySTsguMD7EfOvq/ABTQ5UvS0G80HPT82REzXnJLDTvEksYWDYgu4AoEkcxXmgG1/0DnMqBA5DCpWFEkR/wP18bQahVntKkrj1/EZlkSDKuls747o982wicFcQUzeNWcnp5HdzDuh4ArE32+dblRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SmH1Z3waykOM0ekKOX6DciUcc2MVHABBZuZRkDGVODk=;
 b=SnviqQyOlbgWNNwgn4g0dOkw9rkANc4h7rp5EH5SjUhoaMGo9+ZCJK4CZcYb/m5uqUxzYwtBwoHq4iHpbITdCztfUYUw7qtKGKevIiWZ0n/SKylAnEV4w3sukLDGN2WZZjRywFabwq95sfEKrfcoaz3m5J7C2WiVkGK0gQc3Od1Kc2XV/sOnwMXqBOEfgHThvWOjAKKMdgKi8CpJfQ6+2fPsO+ogkqZJhmYsM4DBBXOn53Guwsjf7frApSkp6iZc3R+xks7cJBQWpdWezQgfhizW2PFpdyCnpKwtQx+dqlCbeVLR59vnFwEWx4HLgQ0SN1c86+E3CJvPMNSFLhpmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmH1Z3waykOM0ekKOX6DciUcc2MVHABBZuZRkDGVODk=;
 b=e/i1DonMXg0t3dizjgP9tm8ugk4P3hEFHRiXk+a/+jKMJQgz/xX9xVHkFzEdpKhfeiRMju5Kf9ha4g1g7wczVfDRmlv/WR9oTAKRT3Xh2vnTeqQcT9ZYqXxfZ5ZOxT3QHBk1p6UytHgdmxtxHPGICByBt0VIld/5jUrPJZZQnYM=
Received: from SN6PR11MB3422.namprd11.prod.outlook.com (2603:10b6:805:da::18)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 12:20:33 +0000
Received: from SN6PR11MB3422.namprd11.prod.outlook.com
 ([fe80::e139:9d6a:71c3:99c8]) by SN6PR11MB3422.namprd11.prod.outlook.com
 ([fe80::e139:9d6a:71c3:99c8%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 12:20:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/17] clk: at91: re-factor clocks suspend/resume
Thread-Topic: [PATCH v3 01/17] clk: at91: re-factor clocks suspend/resume
Thread-Index: AQHXq75pmfCE8nfFy0iZXcBE2Xbfhw==
Date:   Fri, 17 Sep 2021 12:20:33 +0000
Message-ID: <75da98f4-dd5d-33ae-33f0-4b3dbfc4e7b2@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
 <20210917120642.8993-2-claudiu.beznea@microchip.com>
In-Reply-To: <20210917120642.8993-2-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2304799a-68b9-4e14-55f5-08d979d58c2b
x-ms-traffictypediagnostic: SA0PR11MB4655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB46557C26182F579345A7E82C87DD9@SA0PR11MB4655.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJQZUb5EGuOkYIQ9l/VUZLhhxQf1ZmJKewN12BUdIpla00Jl3jIWtM6ks9KSLeKxX8EuZrcN9DdOI6o8xDPFn1Bfd8FUu9mahm0ec6vC20/w0Kx3QTFcQvkXiFyWAe6rNfh63ed6Qj9Y4wucIcuhlvFeBWKbDJiAGeJdnFY01HLBj7r6EoP8mfibmvTmnje6K+mLK2VVCKFg6+D9hi8Fhfrajp/v3U48d03i1Dklkuy2Jp/9aGnL0p7oCo50X3HnMcEZVTBzVk8rrSip6ABs/J86A6sTgO+NuxR/KUZ1QCnW2UurWSjX5FxbiBvFVrHchtwdxCrTI1iJOKZxdDXQNE8jXVZmhHHd46V2FGxyMDBa0U4WFBmu+3EuUbo28gw/28yOlJV9X2rtGc32V4X+fIkGdfkT79b2a7KTHOtksTAs5OLau5bUyA2N/9EvL/dw7ZH6sWSAUn9bvv3xZ5OlsmmN44sEAUDdDzia1/gFi12fr4+lvmgV2tEiPl/sMYr+7CDM5TIVbHkxOQfqVsQUFaNi6k/VxyuLno5frfTcqnH3vyR2/isjn+KR2gHCVPBJ5q96B918mlHirHD5igovDUU3nC+d+4QZXzvq2YhF9pZAkYvrI5c+tPBArTSSmk+Lv7KtdqfBE0XaJZzJI2WzwOx4NPO14bzogEVIBBHk7XS/qYd/Fyj5A2xJyZuY49zMHq/zbkK76imWOB6+o10L4xIK9qsZwudFoBDCYsjNuWOnxMDZ+KlnczwpcFB9224AlOr2n1do1OMSIEXAWVcgJW0dxD33OodZurK2Vt2UjQhJ4JmsdOVuaVvUK+eLdAsZjlhrhCKENvE9cSbUY9XjT3j6R1uren6m6zUSGyM06Tg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3422.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(376002)(346002)(71200400001)(186003)(26005)(38070700005)(6636002)(15650500001)(110136005)(86362001)(5660300002)(31686004)(36756003)(31696002)(54906003)(478600001)(6486002)(966005)(316002)(64756008)(66476007)(122000001)(6506007)(53546011)(2906002)(2616005)(8676002)(4326008)(6512007)(83380400001)(38100700002)(8936002)(76116006)(91956017)(66446008)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S29JanFOakMvazQ1YnQrdmJTU1ZuU0JnSGFPL2h4eklKVjZ5bk84MlVDZWZ3?=
 =?utf-8?B?RlpXWjRCNndzTXB3OWNSaW4vcTdRTGZoM3M4bTZSUnFNOFJoRStEanBvU1Vl?=
 =?utf-8?B?ZnpPUWR2SDF2NjkzYTNWYlppYWQwMmF4Q2JQMm13Q01PcHZxa2QxTnZxd1RQ?=
 =?utf-8?B?eWR6REg1dldCY0ljSm94czBxRURGM2VtVWpIeXAvckcrVUtWOVRXZGhsUXZm?=
 =?utf-8?B?ZHR3WVFwd3pldmg1OHZXWnh3cEVyTjVvdHlKdFNZU1BweGFxenEyV1hJODRJ?=
 =?utf-8?B?SWg0YXBPbDhsazJPY3U0VUR0K3BwYmprWFltSHlSTjQyckJyVEVMUnluUGFQ?=
 =?utf-8?B?TGJWSFVXY3BSQmhUY3ArS3dKVjJUaWhxY1BZQXNqcXRhQzNqTkZycWh2d253?=
 =?utf-8?B?MjR1Yisyd2hPd1NLOGVGaG5vbnJiWDR5Nmd6enJIR3hKenhCbmpQd2o2SEpn?=
 =?utf-8?B?Tk9tZEJIU1c3MHMrUGtBQTBuRzlPMkcreTR1YklxRkVMSmJRTnRLUGJTUCtm?=
 =?utf-8?B?VUt1OFFwZGIycDhxZWF2clY1M0FLK0I2QlUzQ3BqRnZVanFYTFN1dkhRRzlY?=
 =?utf-8?B?cDVNc3YxbVFlTFVmbG95OERtVkNyeFllcm5ydDZFUmp4dUV5M0lwWU1oa1NQ?=
 =?utf-8?B?akRMQ0RZU3JUQUNNbGNhVE9GSWxIOUNqc01UWEhIRlRSZThPMVVUOXlpUElM?=
 =?utf-8?B?TEF0NmFhZG5OTE4rYUJOdy9CRzZVaUJZUW5pbEQ3eDlCOHkvNWpyMXFZak5z?=
 =?utf-8?B?R2JWS0oySmN5YllRQVVhM3lsOUg4Zlh1V3dNUk5GM2JWSWtHNGNMQUljVFRU?=
 =?utf-8?B?K0wwemY4QlZoeWRncG93Q0g2UTRzdHBsQllyMnFRMHdNQlQ2MU1KeVFxWW9B?=
 =?utf-8?B?eGhnQ1ltdjZvdjJhRTFNRVZMUTIvOWI2bFQ3ZUwwcktJQUNRaHVHWjFpSWhU?=
 =?utf-8?B?SUN5Y3BvRk5oQUxZWG5GMlQxMmh6UTFVdm16aUU0ZkxDZndlQXVqQlBkZm10?=
 =?utf-8?B?M0F5dCtLa2N6UnhqcUpqZk1QYTc0NWNMSUJTRTZMU3RLOTZodGVURlB3QjVM?=
 =?utf-8?B?VXJhYi84TWdUVk5SSDFrMmhuRXNXY21TSXBGbFJVRUY5Zm53Z3hGVURheDQ2?=
 =?utf-8?B?dEhiRzVHaGNxMGh6bVRkc2JnRWc5N0V6S3ZhZFdUQmNSeTd3aXlTMjNkZDlR?=
 =?utf-8?B?K1o5T3BpbWFNNEJERzUxTHo1UUlUTkkySjA4dkhQSG5YNWFKS1JDLzhockc1?=
 =?utf-8?B?TGlWSyt6QUZneDQ4RmRKN0VMY3o2V2lmRU5YcWtDSkgyeUU5c1VsZjh2eG9L?=
 =?utf-8?B?YVZRUHhhZTlCeFVuUFhpZHhTeXkwcmdyMGhsaGl3SjFVZk9tVjFzb1A4WmFT?=
 =?utf-8?B?ZGY4OUVoK1hCYldIeXFEZEcvTTBsRnRQbHd5TG1xdWVxQ0dmL0l2eEY3aFVt?=
 =?utf-8?B?aS9uaWpCRGpmWkwwSFBWQWRKWUJQbk5yeDhBT05TYlB1NlFJOHJnU3BhVStz?=
 =?utf-8?B?akJMYi9YYWIzdlRNc1hqZEs5UjBQY0VndkI5WW9tNnpObVhlRW5UTTBJUXF0?=
 =?utf-8?B?d25ZNG1lb0RoQjZTNDkrQ3d1eFYyMmtrR1RGRGtJYm5vTWRoNENtc2ZRdHVy?=
 =?utf-8?B?enliRUhpejQxSytyeHRHUUE3a21qT0huVHdDbndVYm9FV05PZzBLckRhczE0?=
 =?utf-8?B?dFBTRGU5dWRTajAvUkhpSGlMMWVyV2NLQ3NsSnJTaFdRY3M1d1Y1Vm1VcS9s?=
 =?utf-8?Q?B+WKmTTy0l1uL+pwVU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB16F1DAE8DDA143A9C82845286352B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2304799a-68b9-4e14-55f5-08d979d58c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 12:20:33.5721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vvpg2MmHtz3xdd3hD/ftv8ARrnY1iH38Rtqr7WhTOHeWkP7Czfsx539/RyP5gXP57/RbG98O96Aq+yfV8kNVlDbzsNRGEwQBzoB3CoTBS8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDkuMjAyMSAxNTowNiwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IFNBTUE1RDIgYW5k
IFNBTUE3RzUgaGF2ZSBhIHNwZWNpYWwgcG93ZXIgc2F2aW5nIG1vZGUgKGJhY2t1cCBtb2RlKSB3
aGVyZQ0KPiBtb3N0IG9mIHRoZSBTb0MncyBjb21wb25lbnRzIGFyZSBwb3dlcmVkIG9mZiAoaW5j
bHVkaW5nIFBNQykuIFJlc3VtaW5nDQo+IGZyb20gdGhpcyBtb2RlIGlzIGRvbmUgd2l0aCB0aGUg
aGVscCBvZiBib290bG9hZGVyLiBQZXJpcGhlcmFscyBhcmUgbm90DQo+IGF3YXJlIG9mIHRoZSBw
b3dlciBzYXZpbmcgbW9kZSB0aHVzIG1vc3Qgb2YgdGhlbSBhcmUgZGlzYWJsaW5nIGNsb2NrcyBp
bg0KPiBwcm9wZXIgc3VzcGVuZCBBUEkgYW5kIHJlLWVuYWJsZSB0aGVtIGluIHJlc3VtZSBBUEkg
d2l0aG91dCB0YWtpbmcgaW50bw0KPiBhY2NvdW50IHRoZSBwcmV2aW91c2x5IHNldHVwIHJhdGUu
IE1vcmVvdmVyIHNvbWUgb2YgdGhlIHBlcmlwaGVyYWxzIGFyZQ0KPiBhY3RpbmcgYXMgd2FrZXVw
IHNvdXJjZXMgYW5kIGFyZSBub3QgZGlzYWJsaW5nIHRoZSBjbG9ja3MgaW4gdGhpcw0KPiBzY2Vu
YXJpbywgd2hlbiBzdXNwZW5kaW5nLiBTaW5jZSBiYWNrdXAgbW9kZSBjdXRzIHRoZSBwb3dlciBm
b3INCj4gcGVyaXBoZXJhbHMsIGluIHJlc3VtZSBwYXJ0IHRoZXNlIGNsb2NrcyBuZWVkcyB0byBi
ZSByZS1jb25maWd1cmVkLg0KPiANCj4gVGhlIGluaXRpYWwgUE1DIHN1c3BlbmQvcmVzdW1lIGNv
ZGUgd2FzIGRlc2lnbmVkIG9ubHkgZm9yIFNBTUE1RDIncyBQTUMNCj4gKGFzIGl0IHdhcyB0aGUg
b25seSBvbmUgc3VwcG9ydGluZyBiYWNrdXAgbW9kZSkuIFNBTUE3RyBzdXBwb3J0cyBhbHNvDQo+
IGJhY2t1cCBtb2RlIGFuZCBpdHMgUE1DIGlzIGRpZmZlcmVudCAoZmV3IG5ldyBmdW5jdGlvbmFs
aXRpZXMsIGRpZmZlcmVudA0KPiByZWdpc3RlcnMgb2Zmc2V0cywgZGlmZmVyZW50IG9mZnNldHMg
aW4gcmVnaXN0ZXJzIGZvciBlYWNoDQo+IGZ1bmN0aW9uYWxpdGllcykuIFRvIGFkZHJlc3MgYm90
aCBTQU1BNUQyIGFuZCBTQU1BN0c1IFBNQyBhZGQNCj4gLnNhdmVfY29udGV4dCgpLy5yZXN1bWVf
Y29udGV4dCgpIHN1cHBvcnQgdG8gZWFjaCBjbG9ja3MgZHJpdmVyIGFuZCBjYWxsDQo+IHRoaXMg
ZnJvbSBQTUMgZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNs
YXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkkgZm9yZ290IHRvIG1lbnRpb24gdGhhdCB0
aGlzIHBhdGNoIGFwcGxpZXMgZ29vZCBvbiB0b3Agb2YgcGF0Y2ggYXQgWzFdLg0KDQpUaGFuayB5
b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyMTA5MTMwODI2MzMuMTEwMTY4LTEtY2xlbWVudC5sZWdlckBib290bGluLmNvbS8NCg==
