Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50341D775
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349814AbhI3KR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:17:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30399 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349640AbhI3KR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632996975; x=1664532975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8fikHpK6ANcLQP4g/EJ/u46/gPHj8eney5ARTp/tihU=;
  b=ejjUE4ynZF4zo+Knb6qeQvkTD6wPqcQs/I0tfZA6bF94TWWk34K9Hf38
   tk6htge9Z23DkBr+IhsuBRj1KeRhlAGEb1woIaiVXorFu7PasLw6OPsYD
   sKUFYJTFz7iX4btdSST4hdELbk2K5b4JikGC02ZdjZL4RxHMeAQGQtxV1
   AwEv6MWCHGRsz2anoNkI/qHUL6WhHIF7oon+AC4O9vHr5HB/DbF+jJw6W
   yXQ0wMZcRs5Ubq+7WbDwmh+vabB/RzZijO5bMzX2LniCu1N9zbzVSjqrv
   93gkWx/BxkaoE5stu88oDq9CLgrydpXqaI9VGuMjdCmdCitD/cBzG8Vpu
   Q==;
IronPort-SDR: NiXAVJJgO1omSBDOna2MW2BN6qW+vfO1yoAYuBafuN4u1pWiwaz0aXXE1J+Ag77WuH7m82C9jT
 NbMs45qgQd5W0SPkTCZm7/cX6QwHhejScJXAFdi1cYVNPvrbhu151z13syyK4cyBRZqIG8QbuB
 x3s9YLhzj+U39JHsZh758cC4kKDNAheat3yLyWEoIpok4peNq6bjjC15EjgT2H2I9zmMxZoQeB
 2te7iegdOZXYL//xFy5YgdDlaezKWviwNRAthD0Z46CvitkfNUEWtmVDTwdsJTHcuZmLqqSvP4
 lpPgH8upKAn9+EgW8HYAd7Au
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="146249017"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 03:16:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 03:16:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 03:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH+M+rGWBXpjt+9tKCxb0sX+zXBXwdWImBgX1NAdbv3VXWzBOCIFs8ZgGxIVaO1O42DZUCcNWVN8RBHREBKYK0zOXxBe4E95+sX//BTCavPfFPEQTakRjp4M5WwXhB8Kp3n+yv9XIp69PWnkQ648W75ITxNKwkiuXs0Dp6e4ng67lC5RE9odN7iewO7UAfa4YZBLFaoaMjJEEyyuLh9wYe3TOPlAs1sjBIXUBac+aZ/ei2zmHS4bSBY8tsdG//zzQptY5a3yd+k7wGsEz0fSDFeLL+MdDEUJFWlbQYjAACnoVfe57czYkL3mThGrjC6hnaIv8x2Ic995FHCyGQm7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8fikHpK6ANcLQP4g/EJ/u46/gPHj8eney5ARTp/tihU=;
 b=cBrVII4gOxLx4gc0cRT3GMDT/akKAS5T4H5dJK+Y6bm0bt5KM4VUd3aH69k6HdygHjyq+N0IYi9xy1F9egPtOtmFbgu+nQjmTwcMNM0xRge6eqLdHTsmgXZzElEt/OyjuvM3PUkzLZerkeUQX29wSyKm2BNf9D8zHGV1/jkc804CDvetKarbDFlDTD7OymbuiJgPzR4VN1c8F+JDcQSV6mHoA7HEDwdfCsfeZMKYfAeC5i67E52a4YHCnzZLbgP6PHt49D9BRcMJuZF831LOKDiUOiEOpoQmtCo6wTLbiHaQSOy/xYCUQXpCEam4CrNN6A9OYVa5mlsV4ekEcax3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fikHpK6ANcLQP4g/EJ/u46/gPHj8eney5ARTp/tihU=;
 b=ojyFINfPEZ6rTdtI7u4/OJ6N1LB2Yzl4drWc0vto1a5/1l3F4/mP7VTiTj8SmkB/6MUaIZT+NBmOILX5xuCh5R6je4Mu/ZoSI0NNSAIgWRTZwIrEOCQO7JNJ7gB/SWgwkXRQFgo1zIyKSfEfjb5bfzULp5CUeOARhRvxnLcrqHA=
Received: from PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22)
 by PH0PR11MB4856.namprd11.prod.outlook.com (2603:10b6:510:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 30 Sep
 2021 10:16:12 +0000
Received: from PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6981:5132:c754:1b63]) by PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6981:5132:c754:1b63%5]) with mapi id 15.20.4566.017; Thu, 30 Sep 2021
 10:16:12 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] ARM: at91: pm: group constants and addresses loading
Thread-Topic: [PATCH 2/3] ARM: at91: pm: group constants and addresses loading
Thread-Index: AQHXteQxk97Cjvrsc0Ko00MQbxQezA==
Date:   Thu, 30 Sep 2021 10:16:12 +0000
Message-ID: <fe93c4ae-4ac4-02e2-ce4a-03ead76e65e6@microchip.com>
References: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
 <20210928084257.2188017-3-claudiu.beznea@microchip.com>
 <YVLn4WScnmybTzy1@piout.net>
In-Reply-To: <YVLn4WScnmybTzy1@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e67e35ba-7db2-4605-645d-08d983fb5463
x-ms-traffictypediagnostic: PH0PR11MB4856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB48565C0ADEF3D38FBDAFAC5C87AA9@PH0PR11MB4856.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9twgZuvHzVJkGyVWDMGoLSVt5nYcuc581sEeuuT4Ka5geUdK9siIpdnfNSOiNLThfysEvfqW1AUm6v4xe5558cJxb3kqLH2ITbWPJHrBK04+IIsbwjL1MEdlwj18EDHpGzDP5HfW/VlRCR9q09fpZgSozS/K5QGzh/oYu/vdZlt+YeebaO4bamWYbVNKalbV76oHiQBI9eRIDW3OLBpAb83PTh3KwlXvXGqWQINU1sUf+hsAl5cY6GadkSjekgmq2zpaBqgV323lc2ZYTG0xmBxDhNPGPp6HCTfitNuoAOgkccfnyMukRFa86CC9B169fKawzFXPB5ESdxuK3FrLVRjfq3SdRa7+VV3Qh+Mcn6Vl0zpyxRr/iGnqyd9acZOPo0PQa6bGSPPk2Xlhesd//RhMrRFlPSwhL41wRHQsznyq2t8jF7C6QkV4Sxk7RPZrlAotjWln4dQj0PLC5UzBv34gOZK8RaT3ngDMxLQ5frnYSR7FRN32qTHK9sqBgP1DH67Ph/RIIkJTyEMa1yWL3/oWGAnp7DWGmjYv4IXgg+muPnlpr3VCXkdvDaIBrDORyW7txaUpiEKsRbmuLKSDAtF4ZYhHPYKRhMOaMaIKLnpEcJHimdQSefsNNu74zyxtDI+JagYswK/b6x2zRpBRM7TQWW+QJhopioT72pTyThu3ziKyJACTPJacqIpTzqx0bbILwhxFjWJ3YTqVWQGOiZPdQwOeWaY5VRLQv4FXwCdgP/nySiUu79wk4adU0+YZEavEzctPn2NJ6mQpvwQXr5z4oPdcKCp9ca5dZq9X50DYk6kbpCfdKchM+JmqSEvA/qAiov+0FmFFjiBV7c/GUoV1F6aD3MOwdsSChq1jmM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(91956017)(4326008)(316002)(71200400001)(54906003)(2906002)(36756003)(83380400001)(2616005)(186003)(64756008)(66446008)(66556008)(66476007)(86362001)(5660300002)(76116006)(66946007)(508600001)(6512007)(966005)(26005)(6916009)(8676002)(53546011)(8936002)(6506007)(6486002)(31686004)(38100700002)(38070700005)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVcvblc3NEhhTDB1aUtJTlRpS1ZHdnBtOURvNW9TeC9pRmt0Zm1PcDhCMFlz?=
 =?utf-8?B?ZVBSaTJtK1FqYk1kV1R6NVJoYkI1cU1EM2JGVU9NcVZxZVpKRFNia3p1ZThT?=
 =?utf-8?B?RHVGNGxyREt3WVBOdkRDM0xnN0oxT25wYmRPTUVPS3JhTlFQekQvSElLeG14?=
 =?utf-8?B?RVRBc29FbVVrOUFNUVpXSTNpUWZKcndoWE9BL0pVQXJWd1N1aHNqb1BJNjhy?=
 =?utf-8?B?S1I5ZnZaOU0zay9Pc2k2b2J2SnE0eXBqZG1uekQ4ZW1SVm9lL0xBbUlzdUlU?=
 =?utf-8?B?bjIzV2lBNnMrMWpCb3FkaXZ1aGFOMFA5MGRiY2FDeFp2aGNjWU1paUwxU1ZK?=
 =?utf-8?B?Ni8vRVZBeGJSUndIaVhnNThOTUZNMnozejJZVnJGRlVVZHp4RVErM1prcDhx?=
 =?utf-8?B?cEt4MnJGenBJUFVnMUNpNno3WGh3cCtUdlZ2TXlJZTl4SW9tazBmM1pyQUNx?=
 =?utf-8?B?SjFhOVdOcWorRnhsWGs2VTZqYXc0eFZBVHY1dWcxMXJmMXJybDB0cEF5V1hK?=
 =?utf-8?B?QnYvS1A2ME5lV1hWRHpOU252RTk4c1V1ejhld0UyQURvLy9NVHV5VVU1VHVP?=
 =?utf-8?B?Tm0rQnFMVGNQTGpwZTBUWVhnS1h1NVhzbVBRTVhQYk1paXZVK0tPb2dRZEVC?=
 =?utf-8?B?cmgzRVdDUTZFdDI1ODBRVUhvOHUvem80RG5ON3QxUEVrSUVGNXE3RVNpeDNB?=
 =?utf-8?B?c2ZXZUhvYUVVN2NGMWJacDU4MGtCN2tHSE4vWXU3SzFRcm56enMrUy9Pbk5Y?=
 =?utf-8?B?TDJ2RUVCU3dTdUlmVWhaQ0lFNktlVm5TL0NUc0I4czE5RnlpYVZYMVJXMFlr?=
 =?utf-8?B?UElMVUgrQlduMGc0VGZPSFBPQWhUNGpGb3V0S2pMQnpZUmNWYWZyNmpaT0Zm?=
 =?utf-8?B?QUxzbXN1dy9ySVFyajFLYnQ0MlhndUEvRWJuWHFHdVB2aUI2OG0rakNjWkpG?=
 =?utf-8?B?N2dxamNyb0RzcjE2d1RDQW1VdGtuSTduWXV0eE9OSytGVzBHK1pmaThZTnQ2?=
 =?utf-8?B?dlBtc0FqSU1KdFFiSFpPMXpvSnd0T28rSzVoSlZMeUlzME9xZzBDUC9jenJJ?=
 =?utf-8?B?U3UxWHZxQ0N4emU1RjIrQ00wRHFSbmNra20vbVBWYmxRU0xLR1pjaE51K0VL?=
 =?utf-8?B?Mi9pR3JNT2lPZzh5Nk5EUDdxbklmbTZ4OUVFRTl6ZWdXN3dIT1hsUGg1OGt4?=
 =?utf-8?B?SUtnT05HSkNkNzV4VG5wVXhibFh5REpNaVZSejlvRGhMRlcwSkVNYlhkWTZh?=
 =?utf-8?B?ZGxRS2QvankyVHJQcDZjTW5Xc3lMb1pWWmF5djdDaENhaVpBOHNLWUF5V012?=
 =?utf-8?B?VXp3alRkcXI0WWQyMUZkVi9CSjhJRG1zT2lQNExkQi8rN1IwZERTeXZQY3hk?=
 =?utf-8?B?NmRsMXp0L3JxenhUOFJFWUszOXMwc2ZjVVBMNG02TUxyVGwvZTJPWXZSeWlh?=
 =?utf-8?B?Ni9pT2FvWFBIc0JQc0IvN0pjRWFCY1BNRkpIZTIyeTRiTzVhWm1INnptVlI5?=
 =?utf-8?B?YUVNZGZEYmNrc1ZXSW91NFpObmhiTkZEOUdqKzhlNTE1dXNVRTJaYlJUZUV6?=
 =?utf-8?B?TUlPREpaY3MzWHBtVmZyOUxPSVM1bFlqSGpEdHR6TGQzZXc2cS9QdFAxYThx?=
 =?utf-8?B?UlJSNVBneWs5QzAwcFlIT3diREJKT3NFQXg3Z2wxWVF3NEZHMk1jSzlLaUZI?=
 =?utf-8?B?WVl3UmwrVWxkdllmMURtTVl6ZmR2ZExOOFg4RVN3WUxDVkVxYnhKeTRjN2FF?=
 =?utf-8?Q?hPbsQxaI3R/5r7UNig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A9849C303CC53428EA7D0D3AE6ECF83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67e35ba-7db2-4605-645d-08d983fb5463
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 10:16:12.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLIusI6kIFgoBrOBN8XmIVyt9pi1Ks+0ZLmNQDoG2e1xT69Idco879k9NIihkNx/WuJ7lcjx6BN+/m6vFeyGdRCT9AJuNX2a5yIekvfzhTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4856
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjguMDkuMjAyMSAxMzowMSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8sDQo+IA0KPiBPbiAyOC8wOS8y
MDIxIDExOjQyOjU2KzAzMDAsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4gR3JvdXAgY29uc3Rh
bnRzIGFuZCBhZGRyZXNzZXMgbG9hZGluZy4gVGhpcyBjb21taXQgcHJlcGFyZXMgdGhlIGZpZWxk
IGZvcg0KPj4gdGhlIG5leHQgb25lLiBBZGRlZCBmaXhlcyB0YWcgb24gdGhpcyBjb21taXQgYXMg
dGhlIG5leHQgb25lIHdpbGwgZmFpbA0KPj4gdG8gYXBwbHkgaWYgYmFja3BvcnRlZCBhbG9uZSB0
byBvbGRlciBrZXJuZWxzLg0KPiANCj4gVGhlIHByb3BlciBub3RhdGlvbiBpcyB0byB1c2UgRGVw
ZW5kcy1vbjogb24gdGhlIG5leHQgcGF0Y2guDQoNCkF0IHRoZSBtb21lbnQgdGhpcyBwYXRjaCBo
YXMgbm8gc2hhMSBhc3NvY2lhdGVkIHNvIEkgd2lsbCBhc2sgTmljb2xhcyB0bw0KYWRkIHRoZSBE
ZXBlbmRzLW9uIHdoZW4gaGUgd2lsbCB0YWtlIGl0LiBEbyB5b3Ugc2VlIG90aGVyIG9wdGlvbnM/
DQoNCj4gDQo+Pg0KPj4gRml4ZXM6IGYwYmJmMTc5NThlOCAoIkFSTTogYXQ5MTogcG06IGFkZCBz
ZWxmLXJlZnJlc2ggc3VwcG9ydCBmb3Igc2FtYTdnNSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGFy
Y2gvYXJtL21hY2gtYXQ5MS9wbV9zdXNwZW5kLlMgfCAxNyArKysrKysrKystLS0tLS0tLQ0KPj4g
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtYXQ5MS9wbV9zdXNwZW5kLlMgYi9hcmNoL2FybS9t
YWNoLWF0OTEvcG1fc3VzcGVuZC5TDQo+PiBpbmRleCBjYmQ2MWEzYmNhYjEuLjM0ZjI1MWZkYjc0
MyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL21hY2gtYXQ5MS9wbV9zdXNwZW5kLlMNCj4+ICsr
KyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9wbV9zdXNwZW5kLlMNCj4+IEBAIC0xMDE0LDYgKzEwMTQs
MTUgQEAgRU5UUlkoYXQ5MV9wbV9zdXNwZW5kX2luX3NyYW0pDQo+PiAgICAgICBtb3YgICAgIHRt
cDEsICMwDQo+PiAgICAgICBtY3IgICAgIHAxNSwgMCwgdG1wMSwgYzcsIGMxMCwgNA0KPj4NCj4+
ICsgICAgIGxkciAgICAgdG1wMSwgW3IwLCAjUE1fREFUQV9QTUNfTUNLUl9PRkZTRVRdDQo+PiAr
ICAgICBzdHIgICAgIHRtcDEsIC5tY2tyX29mZnNldA0KPj4gKyAgICAgbGRyICAgICB0bXAxLCBb
cjAsICNQTV9EQVRBX1BNQ19WRVJTSU9OXQ0KPj4gKyAgICAgc3RyICAgICB0bXAxLCAucG1jX3Zl
cnNpb24NCj4+ICsgICAgIGxkciAgICAgdG1wMSwgW3IwLCAjUE1fREFUQV9NRU1DVFJMXQ0KPj4g
KyAgICAgc3RyICAgICB0bXAxLCAubWVtdHlwZQ0KPj4gKyAgICAgbGRyICAgICB0bXAxLCBbcjAs
ICNQTV9EQVRBX01PREVdDQo+PiArICAgICBzdHIgICAgIHRtcDEsIC5wbV9tb2RlDQo+PiArDQo+
PiAgICAgICBsZHIgICAgIHRtcDEsIFtyMCwgI1BNX0RBVEFfUE1DXQ0KPj4gICAgICAgc3RyICAg
ICB0bXAxLCAucG1jX2Jhc2UNCj4+ICAgICAgIGxkciAgICAgdG1wMSwgW3IwLCAjUE1fREFUQV9S
QU1DMF0NCj4+IEBAIC0xMDIyLDE0ICsxMDMxLDYgQEAgRU5UUlkoYXQ5MV9wbV9zdXNwZW5kX2lu
X3NyYW0pDQo+PiAgICAgICBzdHIgICAgIHRtcDEsIC5zcmFtYzFfYmFzZQ0KPj4gICAgICAgbGRy
ICAgICB0bXAxLCBbcjAsICNQTV9EQVRBX1JBTUNfUEhZXQ0KPj4gICAgICAgc3RyICAgICB0bXAx
LCAuc3JhbWNfcGh5X2Jhc2UNCj4+IC0gICAgIGxkciAgICAgdG1wMSwgW3IwLCAjUE1fREFUQV9N
RU1DVFJMXQ0KPj4gLSAgICAgc3RyICAgICB0bXAxLCAubWVtdHlwZQ0KPj4gLSAgICAgbGRyICAg
ICB0bXAxLCBbcjAsICNQTV9EQVRBX01PREVdDQo+PiAtICAgICBzdHIgICAgIHRtcDEsIC5wbV9t
b2RlDQo+PiAtICAgICBsZHIgICAgIHRtcDEsIFtyMCwgI1BNX0RBVEFfUE1DX01DS1JfT0ZGU0VU
XQ0KPj4gLSAgICAgc3RyICAgICB0bXAxLCAubWNrcl9vZmZzZXQNCj4+IC0gICAgIGxkciAgICAg
dG1wMSwgW3IwLCAjUE1fREFUQV9QTUNfVkVSU0lPTl0NCj4+IC0gICAgIHN0ciAgICAgdG1wMSwg
LnBtY192ZXJzaW9uDQo+PiAgICAgICAvKiBCb3RoIGxkcm5lIGJlbG93IGFyZSBoZXJlIHRvIHBy
ZWxvYWQgdGhlaXIgYWRkcmVzcyBpbiB0aGUgVExCICovDQo+PiAgICAgICBsZHIgICAgIHRtcDEs
IFtyMCwgI1BNX0RBVEFfU0hEV0NdDQo+PiAgICAgICBzdHIgICAgIHRtcDEsIC5zaGR3Yw0KPj4g
LS0NCj4+IDIuMjUuMQ0KPj4NCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBjby1vd25l
ciBhbmQgQ09PLCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJp
bmcNCj4gaHR0cHM6Ly9ib290bGluLmNvbQ0KPiANCg0K
