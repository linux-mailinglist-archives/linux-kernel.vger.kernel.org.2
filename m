Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50978415F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbhIWNYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:24:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:39289 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbhIWNYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403385; x=1663939385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=80RzUi07GT1G11QEPX6EUNpdrXm6tSoSzHt8n8dv1P4=;
  b=avzxV7uimXRkFMFPl4x0MLAkJUnH8YUc+0JqIqRcHaUJ0wiugLrzX8zZ
   L8SknK/6aiRIwz7rpXxzPxyy5CJDkGcN26XrfDhuouD4pxsrDY/AElwYm
   XaAfUJfrMKV8GlER11+xO/UNz43uMmLnBrzOUWA5l7R33Bsr2LZPuOchR
   KShVYAgvAjsyIQmIH2RgYv2BZk3/tAuYy1M7X34VKfvzDvnBAGnB/Yt5v
   5Tsd4EtoVoK6YFmAS1rg5YiKxFrrADk1FglquZp6j/qrb4SToU5C4xo2Y
   y4PUhRI6r61GDRcyUDp7bwMCIcqa3IWXhbofd4kNa7VCf57logAQyvO5U
   w==;
IronPort-SDR: ZlrEHHfY9X+BtmvVPEd5juDqZ41FllpdqIat64mCi2m7XFF8LQVJl5YFlUx39ui4gF1Ids031n
 3LlRDpmA19LFFqLAxQ7jXiiVE9y4ah6EBTpOnDr7uC9gvyZ24JNZf50tqBvUA3XKaOIcQJlUqX
 xJXyUNSGCTf9HcvkEMvV9Azy8oBNur4H3IG9A08vNor1Irlh+NultFmjEs+nI6wrWSUPyP2Lx3
 qWNyvWXId8aGawgflQr3aINkUEEbTik+uHRUUV8WK0vTk1lAgWzc/xnMk1Ydvr8wSd2Gmp2VBV
 yur+8trWW3NOV8bJLpDs7mgm
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="145305650"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:23:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:23:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 23 Sep 2021 06:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGqx7on8k4GHR/G6FF/Eut2m2ClkxkDu58W1cVuwwqoMmiiKoPr7d0yc8bQKC7YYOmRDFcGR+FoVufNwh4ndDPXBLSqoN08G9YCqZU1E+xoyK94O9BcGFTbEcza+BU1c/NT9UmciCc7e5ZQUWHd3lcJfDQQrnRIC0DA6P4TrEuoMKSPBf7Yi9ilHNli0Bfncmyx8EEP5B57wuvWMqib1m7tKKM8vEffFugrA5OwSktPzO1pHg1GhCNbUQfL9aBnFwtPovEQeiFoAq2kuuvDIn4yMQs6MeG7GCVseKXHMAHQBQJWK7C4e7h5X0tWlKfIZzXIQgFjW1E/CmaGyY3tSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=80RzUi07GT1G11QEPX6EUNpdrXm6tSoSzHt8n8dv1P4=;
 b=AIs2PO1129Dk7pSi/MNMdQ22bDbh4jroogOeVzUFRzB04x810eoHWYwxsLBQtrEtF+YnCCp/46CoQ11pagVxwtbcZY6Jk+oAgQD3m2lMWfbUZBpzrZlkrLKOIgOGPS0XPUGnO1FTRFAiUQx05KenTdJkwj5lXlw4yiZikbnLc8DfUPlcxLkyh3oylr9ab7AmKs1CaB2iz/p0IGwmeNNkBRqVHA36K4yG+2YLUOpeFw+aL6Dz8UrCHKu4vaJ4fURjxjh2yHkmG1qu0eO4QYoCEJNZXMtSjQi8wvV3CrOqxzg06ExuqzkFZwvv49TxPyojUdGL2qCAI9BIX1+dGMpDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80RzUi07GT1G11QEPX6EUNpdrXm6tSoSzHt8n8dv1P4=;
 b=bqmv1JrcOyH/+M2ob7XnlI7uvoN36qfCBr2aw5cySenhIJVmjbsr9u6vp4z8WLGC2kKXB5U77xbb6RYeHldvFXATS/4zawKS5/XKNDIDjTDg8vh4RsBSOFYPAAFNIGWJcp4Z4/ZIntrAMp6Z+OIoytMGSodaOt/Rr8/ag+kNCgk=
Received: from PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 13:23:03 +0000
Received: from PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6981:5132:c754:1b63]) by PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6981:5132:c754:1b63%5]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 13:23:03 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/17] clk: at91: re-factor clocks suspend/resume
Thread-Topic: [PATCH v4 01/17] clk: at91: re-factor clocks suspend/resume
Thread-Index: AQHXsH4jN8RQ6/Kng0OFCk83wLpv2w==
Date:   Thu, 23 Sep 2021 13:23:03 +0000
Message-ID: <ed0c9f6b-0e45-a792-4f5c-9944b067d9d5@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
 <20210923132046.1860549-2-claudiu.beznea@microchip.com>
In-Reply-To: <20210923132046.1860549-2-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e3ce2b4-714a-4797-8078-08d97e9545ba
x-ms-traffictypediagnostic: PH0PR11MB4968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB496885247AB919CB3B214B7C87A39@PH0PR11MB4968.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iEcUKAvNGOBf0RdG/+FsmB8+qpB1DHYrSp/wyeG9W9SaHvSsJjeq4eGIglUlby2bg0N44wofgRlrj6autcQxPmIRNE5Kgi6DCqKvWopU3niPsnCDPJkMSD+7CmXljP3XJBt/nOQMB0KrUZeXgvLQXTBuxgftC4vi4k+POIgpvkQb/wS+8+wXf1jAYQ6QE3RamEcq/tqxusifaCtki1LU7Q5YNvon8rIdCZtdCam5j3r/RHCXiHjma2YYIsL33rj9eWwXrU1nOfeTx/7sYziJgGQTEAPHfEQnwVCzD9wyJw+FmaU02t/h39OWQDMCL1iHpgjqc5S6BK/ZZk6Bi1G3YAkPeGciR3dgA8eUk+vZN+2TKTwx8q/OmfhGJR5rQ39iiUSbbWkNlW1IJX7w8abAnhubucM6zbzFzBD/nPgnWHiWLaYO9osmMgjz09rjFxsv8UMR9ZHRWlGh2XUmIoBfvpt9g2jgChCdLsYBc1LaAM1mnsUbzo3NXVGSnx4DN+H5hQgFsBxPym85VbUdn1Dw6o9bqLQqhBvepN6e5OqcvzvAAIXVZt3NyMFiozL/rlTciMCgdxOB9RcAuUuaAXRFJvQGHcaV2bwUtf/B++xwP1uxSxVqqmt/jXmLL6+F2v0BObaZ9YpcWaoYJthsuNkNSi6G+5Ilgd+CLR8RljpyOe2hdj3K8j8EzcQp1hVtPrlF4pVKcKZKYSN72AnO/gLoq/gczhLUnOut3oalh9uOPo1tdkWWMSjlmR19/fVNpUayftNyS9AKQxRU3epaWF9My8j2JrATXenfSwBpR/9RNEq0kLP2U9Fdd5iDIul0er1XbYkypoiEmxpxrwbaFO+RzXIesoIlmIFFGI73mGDSQcQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(6636002)(8676002)(316002)(6512007)(8936002)(5660300002)(86362001)(110136005)(54906003)(71200400001)(2616005)(4326008)(91956017)(15650500001)(122000001)(76116006)(83380400001)(64756008)(66556008)(38100700002)(2906002)(31696002)(966005)(186003)(31686004)(66446008)(66946007)(66476007)(26005)(6506007)(53546011)(36756003)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUI0aE9UQmt2MnlJa01wNkd0QXUxVVZpR3poWmRnMXIzVUJFN1VCaCtidzFx?=
 =?utf-8?B?QXdvZTd6Ykk0enY0Nmk2NlNjcmhYY0ZRNytqNUJTRC9DL3MreHdubmEvUzJh?=
 =?utf-8?B?YWNlQWpIdUozd29SRndkUFd5YUg1aklpTm9sMFAzdHE0b3NKQ1pXMVAyQ1hL?=
 =?utf-8?B?L002RG9ZV1NQMlE3c1JobEtIRXAwZ3dpKzAzQWVWWlVWWnB6KzJQdkVjNDds?=
 =?utf-8?B?dU5YN3ZSbFBhcEpOK0EySjRtZnczQkUzTm44TDVvZFcyZ3ZuOGlXR2VRYmRu?=
 =?utf-8?B?VmtmNHJvV1FNZy9COWhCN1lZa0h5ZTZrb20rQTdjQ3pIT29uR29XSTJTMXp0?=
 =?utf-8?B?d3l3ZFVGYlQ4cUdLY1JkakJYUUZuT0c5RldES3NlSDRwUW1BdGJrVjNjUEhF?=
 =?utf-8?B?em5hakFWUFF3QnRIcEJaNmxKUVV5cGdxRHFzcG05VGE2MUs5bjYyMW5oQlM5?=
 =?utf-8?B?dG1EdXF3U3IvMUl1SFBxSmROejR1Q3Y2NGs5dmxjNjc3Yk1YN3pHNVd4aTFI?=
 =?utf-8?B?QmR4Vy9xZzk3ZE1yYi82UEcrNEt5Um5za2xPQVpLUkR1S3M1WnpYbWNNN0lP?=
 =?utf-8?B?VkxTT1ZIbTBFcjlYWHZ3bmMzZDIxSmh3ci9CSkNnRTh6LzVYUXlCbnpKNnlF?=
 =?utf-8?B?TDBpTzZFVm52K3pBdmYyb2tYQXdwYWxidmcxbEdQdFgxWXB5WlZUemVhZGx1?=
 =?utf-8?B?RU9BRWJHSTVvMmFzSlJUQTNSRlNGclJVU0JweU5hTDdmR3RxbDVyM3RNc2NK?=
 =?utf-8?B?K3VydUNkNnpVaFhpU0FvRjErV0ZOV2pFY0llNnRNOTZmUWhyRDhtVUh3akl0?=
 =?utf-8?B?WW1xR25Ra2Q1VTE3bS9PMXgzQXcxYXFQOTV6ZTF1L2YxOGJQU01mbFBZdi9R?=
 =?utf-8?B?ZlliL0F3REp4SEkzK2QvS3k4Ui9YcGUyNWIybFRaYUx0SWVCdy9PV0FyeGcz?=
 =?utf-8?B?TjZRMlVMZ0NaTk9wb0lpSU8zOGRRUG9wQlhVZ0RtNWMvSUdBa1lmMjdHWWpq?=
 =?utf-8?B?ZzhmdHhWMnd3R3hpMXhyOUhLMGVsOFc1WVBESUtCayszVHkrYlJIRVU1ZXBv?=
 =?utf-8?B?WGNpc2RNak5rNzJxMHNyUGtiLzNaMTQ5bE5WTWJhMllUR3lRTER5TXlSTXg5?=
 =?utf-8?B?SWZQMjJmemxIbVBNS21yY3FxdjIxMUFOZW5kajFwd0NqWkowZlR0T1lEUkxz?=
 =?utf-8?B?NERkWmExT1JTYndTdEE1U21IaGVlZGpTRTBMd2l3RmxKbGQ2UUdlTHJwbUFn?=
 =?utf-8?B?cUErZDNNa0thQWVSUkZEMTI0R1ZEMS85ZzY4dUdjMEI3WDgyeFdPNWg5U2Zr?=
 =?utf-8?B?UEFPbVB0Q0xhbTU1WUszb3ZyUENGZXJrUHI1UWxpZWgrZWRIcGg3ZFNzdm84?=
 =?utf-8?B?dDRWd05GdnV6eHFuenBMRXdYcG9PN2plVkFIUDkzMklFYktlaG1NQ2QxVHQ2?=
 =?utf-8?B?UDhzNVpzR3NYKzJYbUdub1pHSFBMN3hUSHY1UEpESnpHNTZHcWJteEJuZUl2?=
 =?utf-8?B?U1VTUkh3bnJqVFpXZFhsWkNrRHVJR1A1Q0M0L0tqS1NVVVlNSkl0LzBLRlM5?=
 =?utf-8?B?aUkyOVllTnJidXpNeStMYnR5ZXJjemYzUE1Xcyt0ZmQzWklvbDBXSGN1NzNK?=
 =?utf-8?B?N3p1ZW1lQTBPb0dNTWN0VFFzNFJmWGJZSTRGcWVBTmQ3MlJvOE5KUURFaENi?=
 =?utf-8?B?ZTBDYXFDMTJ6UGtHai9LK05UTktrMmFTRzBrVlFtSkRRZmNrMUE0eGpNSFJk?=
 =?utf-8?Q?IBbY1r8ObetgCdEnV8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7501C4B510408C4EA5E09AD2FC580E27@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3ce2b4-714a-4797-8078-08d97e9545ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 13:23:03.3578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6McTPbwc7xp99xQkpKK2jdvL8p0Nx5UErpvjkVOC2ALNOMNlzp1/ydDo2V0DbbHkInyX2zcrJAxgo52s7OjVT7kuMkNZ0A3Wr24fuhnyBj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMDkuMjAyMSAxNjoyMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IFNBTUE1RDIgYW5k
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
YXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KDQpJIGZvcmdvdCB0byBtZW50aW9u
IHRoYXQgdGhpcyBwYXRjaCBhcHBsaWVzIGdvb2Qgb24gdG9wIG9mIHBhdGNoIGF0IFsxXS4NCg0K
VGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KWzFdDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjEwOTEzMDgyNjMzLjExMDE2OC0xLWNsZW1lbnQubGVnZXJAYm9vdGxpbi5jb20v
DQo=
