Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5A33B0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCOLZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:25:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:47550 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhCOLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615807475; x=1647343475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IGA8iprVA+QiHRSowP4VkJeNOBSDsApcwzHhObjJf5E=;
  b=i7p9bSjP77mORcrNx++SEsRcFjp+bTq5+lhWori2An4FDJdw3eRZPJIt
   YLBt7midQimE/AonSeM5KC5X3f2vuUUHHkDktdW7lPLzeBPFUI66eosZ2
   5a7WHq1ezWNOBa54OPKO446o9K2Iyc1VAf0HPbm9gRyZQwXgXJNHRaNF0
   TavFOx0gGgkQhpthznTO2c5aO8/zsHbzy+dUrI6/6id11YFCYofgoTlmK
   FCOgz2kjgKgpm7jSYRvijRCtcl8GAq8G5r8LB0BKZf+EweBpT2JGfmYAs
   +k6l72A1/V4DNy7D9JsVYv3ePj+9o8mLgKU7TEWCKJAL096fagiIMyZq4
   A==;
IronPort-SDR: Q4jFLEHU/kMDzVpuAgt6MF9XF/lVoljrqujCEwlcHEOPOS5ATDRyxFsi50fSIb78uPvJsdSKOs
 a9EmrGfWJ1phWDhFxpUc7ad88/XXiHpySKRjxzIdyViSMcWSiwpIoSE2Rhl25Zn/ARZrX0IJ1p
 1tP6f4WIAKgKhfZnNszEZ8ckNOiKeR6MSQhTP+wCp9hO3G7shKVFQP9/tgR3DeDdyWzaylj5k8
 iRkycyHySrBWXb3Fv1jMjRS2w8MlT2wagnNYtYjkYmvMqcAMXl6+yE5W64zIj2aDQ3HkGRg/KD
 nOk=
X-IronPort-AV: E=Sophos;i="5.81,249,1610434800"; 
   d="scan'208";a="107214011"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Mar 2021 04:24:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 04:24:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 15 Mar 2021 04:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqY4LpHDYaHOUCBQf95XCGjB46l244tGbbtTPxCyR6S+RG0KLmiPpmb7xUFTyrJ2fgRc8m9nFkEKB8ijoMxWnJefJ7jN0avppeDx2PZbRTVGsfeifR6ADe4J+kw/zxifdhQWtvbSnT1zCSRc7ByH2nEgmt1DD9ouDC/9R7iVQqvMjeveqCKCxDkRZkI/J3IMurawgrhB7CI+29Ln++Ct7EkF+jerlNsZUsLWw1mPRoEIm72GM6UssOBvAXjiAClPDZ9a26PDQ5FTYme/5kYZAELOMfgmxMZZNcUp4q0GBWpNWn9HnY1tlY1xLP0yZBeaeJUhESHIRd/YR9K9IyW1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGA8iprVA+QiHRSowP4VkJeNOBSDsApcwzHhObjJf5E=;
 b=i5iWvQPubCTGy1zJQ2PubC+rWSeGNn1hprnyi/5ZR6RbU5qMQ+22AtTyKW02fkPNy9A6/77oS6KwOH2fo8+z8AfYV6O2BGPjKGLGCSi676QYnY0wRRSN4aOwBODlRLCb1X533/dShcZa9ffZVrHSQWN0xB6Pc08UIXK1zoZ6s5ixEsSbkWTsnX02OSlAXiT1W7qOdqkvp/dOAowygbuBeyKeOJ5dBgDJpesPs9hT6AKhh702fnLhkrSXxvyqMlre71v15y7sl3MkWgpq8iD1pv1aiWIgx4mlY/IiApB7hGigC6LtbkRAsUSh+2hE324PNJCm0AAf7yIpxM5b2t8Exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGA8iprVA+QiHRSowP4VkJeNOBSDsApcwzHhObjJf5E=;
 b=N/WVQhDcaf43WaPLWJaGZ6/I+HaPILKrZceoDansHHBC7Opv48Zqe95K11afCxIfxElgT3S7Op9eFOP754YDfvB4291HQRfqTqzt6sFCBUh/kahC7mHgZIc46Ao7BmOi2zh8ymVkLP6oj3Q4SN/zcTuKovceZgDJtz/jCwhwiII=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2621.namprd11.prod.outlook.com (2603:10b6:805:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 11:24:32 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:24:32 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <joe@perches.com>, <p.yadav@ti.com>
CC:     <vigneshr@ti.com>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] mtd: spi-nor: swp: Drop 'else' after 'return'
Thread-Topic: [PATCH v2 5/5] mtd: spi-nor: swp: Drop 'else' after 'return'
Thread-Index: AQHXGY3EuW2H3unPVUaRE39dynJgqg==
Date:   Mon, 15 Mar 2021 11:24:32 +0000
Message-ID: <3ed8da81-55cc-4fbc-cb01-9405ac9709d7@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-6-tudor.ambarus@microchip.com>
 <20210308062821.wn4uqfxcg6vo3gcb@ti.com>
 <5723fabcc03455ee6624a7d223186e5fad2bf2e9.camel@perches.com>
In-Reply-To: <5723fabcc03455ee6624a7d223186e5fad2bf2e9.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 934d562a-6a1d-46de-55e1-08d8e7a4e7d4
x-ms-traffictypediagnostic: SN6PR11MB2621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2621D3FC48DD593C9A3724E4F06C9@SN6PR11MB2621.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJKguIrJqsoH9vbJhMJgBerPRUTByxNSPAOzgbf8L6XMpjMY33yJIyQ5vpDbVn8sH/GqR+7nItitlfOOdPRm0IyfBbZLtOP0RRxyKtrAhOPr/ZPevC+8Y6M26PKoKumaPvTrYsQP7QF0eU12h4QOgPAHOKOrOkBwCIgfDCvZrpJxZiNdBx04JZI+WHUDeBj4M6Zgbl74aOTCsN+uucsvieuJR6+LW/wHdG03osXUms18OcLs6e/El9ru3hF7YIeMM2lpDSqSlKSDEYYFSa9ktIyYehYnC6H14YSG3RL9x9N75juLRLvf9Otkbc5hczJbiKOVCvGdSxDvzGnwLF1uGZeuQW2juYt3lo8J47khIce5ONBlatBEtaGUQzFMxdjHlWRO3EG+4Q64ACUGHiORI1tMgfJ1v4nIHOmhE6wYodKolcH/Yimu+l8nzO5Zap7mz1dWw4XW2hnaMianJohxlQhOb3C+awEzt9zfWBZt60ZXKr7Ukgdrt0bTwbBPQXeibXyD9iaiRCv8as8n08MOiiTwjnwThjwva8BnGYRQHaReQbtOfBHP7+1gnvP+wU7uZBSrEEbTkjz6OMCbu+lkbE5bBU1h0pEiCcSV2qdrG5UFc3KC1UVoyZNTABmu2hJpVsmNLubV7b1Lkw+se7fwyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(83380400001)(86362001)(66446008)(31696002)(478600001)(2906002)(64756008)(66476007)(5660300002)(31686004)(71200400001)(8936002)(54906003)(66556008)(36756003)(2616005)(6486002)(66946007)(76116006)(316002)(53546011)(6506007)(8676002)(26005)(4326008)(6512007)(91956017)(186003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UldUb3lOMTZ6UU41ZzBYdnBJd3VHc3kzck4yN2ZtNVhaOEZ0bnJ5clpldlpD?=
 =?utf-8?B?RU5QeGpoNExXTjArYlEzS1M4RUFNTEZRc0xTclUyZDhueXcxZDF5QXEzQ2Y1?=
 =?utf-8?B?clJLWkRxR29iYURjUkZITEZtZ3NkQzhLT2xZcng0VUdRckdvWE5aZnN0VThJ?=
 =?utf-8?B?V3ZVcHFqRS9uUm1nNXN6QmVIY24zam9IRVpZWFFRRElpVkI4Rzd3d2ZrZG9k?=
 =?utf-8?B?RGVsKytPZVRNdXFyb1BCSTB1MTRpK25MWHZLOThpMVB4d0QxbFhnVFgzWnQx?=
 =?utf-8?B?SVJGTnVvVEIycHhFN3NsT1R5cmdUOWtDUE5zNmlodkNIVjFvU1JHUlkrTFFo?=
 =?utf-8?B?TTJaMllJa3J4SU9uMm95czhObmxxR0QwZ01IY2E5RkR5OUJOSC9DSVdxa242?=
 =?utf-8?B?eE5RWGV4SHlsYVdKN0VReE1obDdCNDZhaG9VaE1sYlIvd2JVSTlrRmpqY3RH?=
 =?utf-8?B?ZVFHY1J2WXg2cXhmOFR3dkplS2VIUStMcVA5RWJnRFpwZnlMMmNPT25qWTR0?=
 =?utf-8?B?bm9DeGFnaC9ZS0xtSWxvOGVDbkd1b1cwMTRuR3RDWURGcWdiRU9BakVpSGFH?=
 =?utf-8?B?UWJSYzZFWklPWGVGZjV6Z3UwQ0pvUUMvYU9Zd3NVZSszVUp5Nk1obE1LRWpp?=
 =?utf-8?B?bWtaMUZEVkFnMXhSOExobnNITmRMU0FXb054anV2bzBObFN3cGhqNUVJdGNO?=
 =?utf-8?B?SXplQ1M5WHViTVBkeVZNdUhYVkF6TlhTaTN0OEJVSDQ2NmV5U3VnRUVldU5B?=
 =?utf-8?B?eEY0d256NDlBRTlGaXVvQjJpd0VOSTdUVUNXeitHb3kvcHE5VDNxSUZKck9q?=
 =?utf-8?B?R2hFNXdiSGhLYkNLemw3d0VQS1VjS0dtN2pZSjhoTTJxOHQ3aEdFM1d4OW9Y?=
 =?utf-8?B?MDUvTzd6T3hYVWZ6cnRKQlBwK3dLYkJHRWx1anVPVmpmR1hrcWdHQjVSQjNQ?=
 =?utf-8?B?OGNZdmxTZTB2QU9MZ2N6QUdWcTYxaEJJTjk1WldtS0NZdkJZQTJzK29HTjBo?=
 =?utf-8?B?Rnh4bkw3YnRiRHZjMTJjczdsQmJ6RnluR3V1RGtUK0Vzb2Vnekx4YVlNdjE4?=
 =?utf-8?B?dlNFbHQ1Z2NrZ0tpdU4wMFhzZG11eFFBOXkxcUN4Qks4TDh4V014NEk3UGJp?=
 =?utf-8?B?T0pzZUx2eTY3QXlxaXRVQXJDOTRNVU5EV3lueWREK2M0MC9LQVM4MDhRV3cx?=
 =?utf-8?B?SEdROXR1cmRJWjYwNTVQTExWVy9nem8wZWN4WUVPbTBMcURzSHdza0dCMUIx?=
 =?utf-8?B?aXRVWEZCNCtpZDhWUDNleFlyRUtVRGd1TzVFTnlzc1Bsd2wwR2UzT3hCakVm?=
 =?utf-8?B?dlZVSEtvUnpLaFlqMTY2blNZVUFTd1RkenhWUGRHamVTUnlXMnlJMDdUS0Vu?=
 =?utf-8?B?TlJBb3N0WmN2YTBkR1VrZnFDVUU4R1VGeEJGbi9WNkxqMGNqOVFYTmdoRnc3?=
 =?utf-8?B?azh5U2lUR0F0VHVxK1J1UnNSVVFXNTZmcmlwZk5OeTl2akI2dG9ZQW5QTE1G?=
 =?utf-8?B?ei9qWERTeWowR1NmTmY5K01MUnVKQSsrbmJab05lK3hMRkYrN2NKYk9qTUZp?=
 =?utf-8?B?Z0c4ZlFJS2xQVWlsTENJSWN4WVFUd1hwY24xQWpZR3FNOXgyNnd5clBUMVU5?=
 =?utf-8?B?SGFFbmY3WFZ4dGEvc3A5OWpIekhQU3phdS9sREt4eHhnSzRIcVJ6Vjk0Q1ZJ?=
 =?utf-8?B?aDJjWFdNeUM0bVlGdFV3NEtvZTFxUlZKaXVJakdGT0lRaUpIRFFnaHYzci94?=
 =?utf-8?Q?wv0bEtsC0ISQMqYIhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DEBBEDCBE816940A2A920E27E000713@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934d562a-6a1d-46de-55e1-08d8e7a4e7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 11:24:32.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: useVzy0tD3x2qQzrqeHCdcF+euLH4N+jUKI71iCl+b3vi0C3cuoVKoN8B4cTQmicXkbQfDbbFGJnofpxd9/f31qngMHg08iVdCDudykdX+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2621
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8yMSA4OjUzIEFNLCBKb2UgUGVyY2hlcyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIDIwMjEtMDMtMDggYXQgMTE6NTggKzA1
MzAsIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPj4gT24gMDYvMDMvMjEgMTE6NTBBTSwgVHVkb3Ig
QW1iYXJ1cyB3cm90ZToNCj4+PiBlbHNlIGlzIG5vdCBnZW5lcmFsbHkgdXNlZnVsIGFmdGVyIGEg
YnJlYWsgb3IgcmV0dXJuLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFJldmlld2VkLWJ5OiBQcmF0eXVz
aCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+Pg0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlt
cHJvdmVzIHRoZSBjb2RlLg0KPiANCj4gR2VuZXJhbGx5LCBjaGVja3BhdGNoIGlzIGEgc3R1cGlk
IGxpdHRsZSBzY3JpcHQuDQo+IA0KPiBUaGlzIGNvZGUgdXNlcyBhIGZvcm0gbGlrZToNCj4gICAg
ICAgICBpZiAoZm9vKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIGJhcjsNCj4gICAgICAgICBl
bHNlDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gYmF6Ow0KDQpJc24ndCBlbHNlIHJlZHVuZGFu
dD8gV2hhdCBhcmUgdGhlIGJlbmVmaXRzIG9mIGtlZXBpbmcgdGhlIGVsc2U/DQoNCj4gDQo+IHdo
aWNoIGNoZWNrcGF0Y2ggcmVjb2duaXplcyBhcyBPSyBhbmQgc28gY2hlY2twYXRjaCBkb2VzIG5v
dA0KPiBlbWl0IGFueSB3YXJuaW5nIG1lc3NhZ2UsIGJ1dCB0aGlzIGNvZGUganVzdCBhZGRzIGNv
bW1lbnRzDQo+IGJlZm9yZSBlYWNoIHJldHVybiB3aGljaCBjb25mdXNlcyBjaGVja3BhdGNoLg0K
PiANCj4gSSB0aGluayBiZXR0ZXIgd291bGQgYmUgdG8gY2hhbmdlIHRoZSBjb2RlIHRvIHVzZSB0
ZW1wb3Jhcmllcw0KPiBhbmQgY29udmVydCB0aGUgZnVuY3Rpb25zIHRvIGJvb2wuDQo+IA0KPiBT
b21ldGhpbmcgbGlrZToNCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDI1
ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IGluZGV4IDA1MjIz
MDRmNTJmYS4uZTE3NGEyZjFkNjIxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBAQCAtMTc5OCwz
NiArMTc5OCw0MSBAQCBzdGF0aWMgdm9pZCBzcGlfbm9yX2dldF9sb2NrZWRfcmFuZ2Vfc3Ioc3Ry
dWN0IHNwaV9ub3IgKm5vciwgdTggc3IsIGxvZmZfdCAqb2ZzLA0KPiAgfQ0KPiANCj4gIC8qDQo+
IC0gKiBSZXR1cm4gMSBpZiB0aGUgZW50aXJlIHJlZ2lvbiBpcyBsb2NrZWQgKGlmIEBsb2NrZWQg
aXMgdHJ1ZSkgb3IgdW5sb2NrZWQgKGlmDQo+IC0gKiBAbG9ja2VkIGlzIGZhbHNlKTsgMCBvdGhl
cndpc2UNCj4gKyAqIFJldHVybiB0cnVlIGlmIHRoZSBlbnRpcmUgcmVnaW9uIGlzIGxvY2tlZA0K
PiArICogKGlmIEBsb2NrZWQgaXMgdHJ1ZSkgb3IgdW5sb2NrZWQgKGlmIEBsb2NrZWQgaXMgZmFs
c2UpOyBmYWxzZSBvdGhlcndpc2UNCj4gICAqLw0KPiAtc3RhdGljIGludCBzcGlfbm9yX2NoZWNr
X2xvY2tfc3RhdHVzX3NyKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZfdCBvZnMsDQo+ICtzdGF0
aWMgYm9vbCBzcGlfbm9yX2NoZWNrX2xvY2tfc3RhdHVzX3NyKHN0cnVjdCBzcGlfbm9yICpub3Is
IGxvZmZfdCBvZnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50NjRfdCBsZW4sIHU4IHNyLCBib29sIGxvY2tlZCkNCj4gIHsNCj4gICAgICAgICBsb2ZmX3Qg
bG9ja19vZmZzOw0KPiAgICAgICAgIHVpbnQ2NF90IGxvY2tfbGVuOw0KPiArICAgICAgIHVpbnQ2
NF90IGxvY2tfbWF4Ow0KPiArICAgICAgIHVpbnQ2NF90IG9mc19tYXg7DQo+IA0KPiAgICAgICAg
IGlmICghbGVuKQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIDE7DQo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gdHJ1ZTsNCg0KcmV0dXJuaW5nIG9uZSBpcyB3cm9uZyBpbmRlZWQsIHdvdWxkIHlv
dSBzdWJtaXQgYSBwYXRjaCBmb3IgdGhlIGNvbnZlcnNpb24NCm9mIHRoZSBmdW5jdGlvbnMgdG8g
Ym9vbD8NCg0KPiANCj4gICAgICAgICBzcGlfbm9yX2dldF9sb2NrZWRfcmFuZ2Vfc3Iobm9yLCBz
ciwgJmxvY2tfb2ZmcywgJmxvY2tfbGVuKTsNCj4gDQo+ICsgICAgICAgbG9ja19tYXggPSBsb2Nr
X29mZnMgKyBsb2NrX2xlbjsNCj4gKyAgICAgICBvZnNfbWF4ID0gb2ZzICsgbGVuOw0KPiArDQo+
ICAgICAgICAgaWYgKGxvY2tlZCkNCj4gICAgICAgICAgICAgICAgIC8qIFJlcXVlc3RlZCByYW5n
ZSBpcyBhIHN1Yi1yYW5nZSBvZiBsb2NrZWQgcmFuZ2UgKi8NCj4gLSAgICAgICAgICAgICAgIHJl
dHVybiAob2ZzICsgbGVuIDw9IGxvY2tfb2ZmcyArIGxvY2tfbGVuKSAmJiAob2ZzID49IGxvY2tf
b2Zmcyk7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gKG9mc19tYXggPD0gbG9ja19tYXgpICYm
IChvZnMgPj0gbG9ja19vZmZzKTsNCj4gICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICAv
KiBSZXF1ZXN0ZWQgcmFuZ2UgZG9lcyBub3Qgb3ZlcmxhcCB3aXRoIGxvY2tlZCByYW5nZSAqLw0K
PiAtICAgICAgICAgICAgICAgcmV0dXJuIChvZnMgPj0gbG9ja19vZmZzICsgbG9ja19sZW4pIHx8
IChvZnMgKyBsZW4gPD0gbG9ja19vZmZzKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAob2Zz
ID49IGxvY2tfbWF4KSB8fCAob2ZzX21heCA8PSBsb2NrX29mZnMpOw0KDQpUaGlzIHNob3VsZCBi
ZSBmaW5lIHRvby4NCg0KQ2hlZXJzLA0KdGENCg==
