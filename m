Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABC93A2503
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFJHHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:07:08 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:10368
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230118AbhFJHHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx8T8IO5OFophjtS8ZCc7/sOThIvnzKhlWxX+Z9I6K+tu4Y8HpfMYK5wfwk1vD5J4jfMduXm5sNAnxzh3Q4qXm8/KE0krZedH3mzIGVnGBZNS5aAh2qKFJOaJgGg6LkXQ4WAyIgl9jo9l/djqvH/vLhOsxOaWkPIca4VLIy/E0ByWJ89Jmu/ZQc8c+dgtWBl+/y5khqMGQhLs7rAbDp5s9EoqhYDL0YQzWTW0tWdUBjJu5D+Ucsn1Ws3ttFpYNv6nattDKEAJKje9ErlmTiu4mTZNspFxNosTYyuMG9I5V2cUj+bXQUd/YjARRVS4wDGS2l24ogLAh3elnl5Jms+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXarlD2hU3+FkPXl2iJPIaXJ3LEZ+FB7sKmrhM1vFOg=;
 b=YptU3fLDrpcJIqQzKLVQ71zPQvp5akLEfVFzGB5+HA8RVSXKYQX22+azIrHINsswySRxzvlc6aNz3nOVT5J6Zwjxhy3+JdqsQYyeWuCI1KvQJCSYcvU5SVgFpCG6/R+pet4NKkSgxWbUJ8zqgRuJuOYIWkFR+zgICQfaNaC1e+ikSDlyOLf3WGFuBuPDGvEny2wzmB4AWRkdcZEBxJs3SwuwcIFKrQQr1bNg365UN6OcEZZWwrS+rqaUM52P60FSnbPFoNMILbdrpTGIBWNJxCv+4kBt3q6OXgfnwmi1SJjICHSVb8inuvl2km4oAGz9IeLPjTWPDPi3EhrzKD+gsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXarlD2hU3+FkPXl2iJPIaXJ3LEZ+FB7sKmrhM1vFOg=;
 b=cVM6EKnJ0JxZsaL2+SbIedYvWgFQcz/P8THD+lpBTC1DfKIGEQUv7f1XdbxYhB/1qMShTpdnB3+w9n1F7K6M/IMZj4mnYPiT8O3IiqqxTX08WYCX5IhYAbd2qFHJYExDOMgEmoFnozwcWHr4SM81hGJyJVrM94hBA6KyMxUapb4=
Received: from BYAPR02MB4280.namprd02.prod.outlook.com (2603:10b6:a03:5a::29)
 by BYAPR02MB5272.namprd02.prod.outlook.com (2603:10b6:a03:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 07:05:07 +0000
Received: from BYAPR02MB4280.namprd02.prod.outlook.com
 ([fe80::19f2:a0be:769f:44c4]) by BYAPR02MB4280.namprd02.prod.outlook.com
 ([fe80::19f2:a0be:769f:44c4%5]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 07:05:07 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Michal Simek <monstr@monstr.eu>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "helmut.grohne@intenta.de" <helmut.grohne@intenta.de>,
        Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Subject: RE: [PATCH v22 16/18] MAINTAINERS: Add PL353 NAND controller entry
Thread-Topic: [PATCH v22 16/18] MAINTAINERS: Add PL353 NAND controller entry
Thread-Index: AQHXXQW5i7IWheILN0SmnRSCpAwThqsM08cQ
Date:   Thu, 10 Jun 2021 07:05:07 +0000
Message-ID: <BYAPR02MB4280EBF6A071385B106E1831AF359@BYAPR02MB4280.namprd02.prod.outlook.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-17-miquel.raynal@bootlin.com>
In-Reply-To: <20210609080112.1753221-17-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40330973-97a5-4dd5-cccd-08d92bde146f
x-ms-traffictypediagnostic: BYAPR02MB5272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB527225ACD7587FE9F1B13299AF359@BYAPR02MB5272.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLRRNCyKUZOqoveDpbSZo195ak1fORbDopzY4ovVGt/lMyjiS377s0kErayy35TqXxBRFsJ5Do989TdGCFV1YIRzYqj9xBifIf/50rJNvcfN28sTiNCZkAAiDkVoK+cVs291Jxp6uSskuxrEIV/l/3q1n0BCbgnCah0rEKQVBaHFpld+nODukcZtzjbTtPSrl3CqHNaS+GWtoyjVl+aCSprHQl9/WDmdKmpfJBy0aQlPdYHZKU+XJOOWvkacof80VR91g8l1HB7R5GQUumFmBDV21E+jLjN9oO5CS06TjjsANcYWycnUr8/AZqJUgnfPi9v/3VCn/Ogm861EMhRn44iRbsD3mxJUPZ2mQoToXbalayNPwtffoLSQ9WQcc8gszxUz/7qNXJw9v9/0iKrAoKaC/AmEmah3YLJ+UUFYLTjTi7l5jCWxOPC8qbIaDxadmA9nHNFEEaB0INio9vqEPer3OR/bJUE0RjTnVldnJTq1s/h8Bnkmq/1l6pj1CwBCoVrIINoSzXUFVrYgljy88bK2BYSbtU9fNxYDFil0CIz7Y5VzsIifz5sb29Rp90vPiK1Jp0LHGAxInJVSbD9Pfa34EWml0xLFJdtsTQDQzNQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4280.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39850400004)(7696005)(478600001)(8936002)(6506007)(52536014)(5660300002)(7416002)(86362001)(66946007)(64756008)(33656002)(66476007)(26005)(66556008)(66446008)(9686003)(76116006)(53546011)(55016002)(8676002)(83380400001)(4326008)(2906002)(316002)(71200400001)(110136005)(186003)(54906003)(107886003)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVNXeHJCdTNzUkRXYk5GbnlCcEVkU1JDMHRwM245QzBCVDZGUEZKOVdnOFNZ?=
 =?utf-8?B?NkNEZjJ4clVBZUZDWFR1Qno5ZlFkWmFERFNyVGg5RUsyNGVRUkNteXdqQ1d4?=
 =?utf-8?B?RUtjZE1HL29SalZDOVBGMjdZTVFSSlVRYllOMlB1T1c3TElpcHBYRWF4dUl2?=
 =?utf-8?B?bFE4d25yTXBPaDA5SjAvQWcySzN2SWh2dG9YbUM1ZllKMEw5VzFXODhRTXZ3?=
 =?utf-8?B?Q0U0TjVyMzZ6LzlkQkdmK3lPMHM4SVE4R1lHV1RPaVVLaUpzbm0xd003U3o5?=
 =?utf-8?B?TS9tMktraEptaGtNZGt4M3MzNllNaTdtaUF3MUFucEl3OWc0VHprc0NIYzll?=
 =?utf-8?B?bTlxeFZxakFqZTRneUg3dWhyWmRLa1Nkb05SWjg0TUptTitmTGNSUXd0MlBS?=
 =?utf-8?B?a3JQTjRkQ0NjNlBudXliK0x6d05RYUt0RU5VODdPNTNSYys5SGd5SWhBMldW?=
 =?utf-8?B?MnlvbDJkYk81QWtIWlNHQ1IvRHlXbDhrMDBBVHl5cFA2bEpyV2hDSy81c3Jt?=
 =?utf-8?B?RG9ES1Z6UHZSL3QwTWdnUy9xR1Y4N1ozMm52RWo1ZDZoaDdvN2Jmc2tsNGZi?=
 =?utf-8?B?N05zRHlFMUVwY0tBZ1FobDdpQmtYZnJxeEM4Qk9OVmhpVEt1ZTREcWFEYWxS?=
 =?utf-8?B?aC9QMU52cnZta0xNMHg3dUxyOWFlN2FKaW5jM1hyZWh0WitLSzN0VFg1ZEM5?=
 =?utf-8?B?cHM1NFRBNlprSHRXN3QyVHRMNFZFQmkwTjJoRnBsR0dzc050aDQxODFUdVdU?=
 =?utf-8?B?SnN0ZjhSTnlPL2VrL3lQMnZZN2oyS2tQZkFPTzhkZ2crUUwya0Q2VldBUDlO?=
 =?utf-8?B?TGRqSCs3NkR0R09OdXpIOEJKaXl0VktnTXhoTzdwaWFwNEE1N0dDS0xjMHpD?=
 =?utf-8?B?MVhseWV5L1RUb2p3K3l6WkNDeDFsZ1FOTXF5RllsNlphUmdjM1lqdnIzUG9O?=
 =?utf-8?B?SzYyZElndXU4VDU3RnRETG15UjMySFJjR25aTkpSb3R0VW9sVm9hdEVBY0lL?=
 =?utf-8?B?MlB6ODdBYmlCRWs1eTJYQVhzRU5OdFo2T2dBdTl2WkY4aHF2d1VndXhHcGJu?=
 =?utf-8?B?U1M2WTZaa3JCcXh2NGhxUG1keWlVMzlKSlJkT1psK1c2ZVhrRGlXZ3JZMGRj?=
 =?utf-8?B?dWFNaVJSREplSTBEOXZWSHl2cmkybkRyWVczV3MxVUVTdlJoOTdUWWU1dEF0?=
 =?utf-8?B?dUJ2d2s4K2NxenBqNFJvbmtTRkF3cGVwQ3U2UWN0NFpFTWc2NmtLYTgxVElx?=
 =?utf-8?B?dVM4QnJWVkRpVnlqR1MrUm8xVks5TkVWL1RUVlBpNDNMYXJqNVB1RjVIWWM5?=
 =?utf-8?B?dSt4YWVKSlFxNEFSMmJMSnVoVFJuV3BORE9LSkpvSUxQOUdTNmc0bjJJdGd6?=
 =?utf-8?B?U0pBSTE2KytZRVFzeFF4RHAxbXlhTDZJcjhyK3lob0hxNzVZUUxHY290S0NC?=
 =?utf-8?B?M2RDby96V3B0YlRGVDlDRm9XZyt2NkhrVGhuam92MUxzd2YwWC92K0t2dk4y?=
 =?utf-8?B?WWx0WUIxMWJYRGN6d3hML2ZqMEJac2w1a2Z2UlFTYWxzeGNncmxnRndUMG40?=
 =?utf-8?B?N2Zyc20zdXI4aU5FdzIvOXdCVUJIZ24yS0FFU0MzK1l5MVdLY3NGK2JzMHA0?=
 =?utf-8?B?ZWNHcXJOUE9ReDEwOHBiRzZSSmo1VEM2VmliUnN0bjBqNUpUQVJaN0hvdXI4?=
 =?utf-8?B?a29ScmwrMXB3U1VrRFF2RTZ1MU9aMDcxWFQyYkFMOHpzVUR4dGtPQktLUFBw?=
 =?utf-8?Q?7VxIotKR3STuRbq35yCjCWn3NdLLQaMlCwm1sI4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4280.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40330973-97a5-4dd5-cccd-08d92bde146f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 07:05:07.3851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iyb/IPx1jOAm4IAj23gnaqBJOCWI/jd5BtXys3f9ZyieAdNKRbxa/GeDh8c7JjPJg8w3D87JOzewpW3ks9UvqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5272
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDksIDIw
MjEgMTozMSBQTQ0KPiBUbzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD47IFZp
Z25lc2ggUmFnaGF2ZW5kcmENCj4gPHZpZ25lc2hyQHRpLmNvbT47IFR1ZG9yIEFtYmFydXMgPFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbT47DQo+IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2lA
Y2Fub25pY2FsLmNvbT4NCj4gQ2M6IE1pY2hhbCBTaW1layA8bW9uc3RyQG1vbnN0ci5ldT47IE5h
Z2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gPG5hZ2FzdXJlQHhpbGlueC5jb20+OyBBbWl0IEt1bWFy
IE1haGFwYXRyYSA8YWt1bWFybWFAeGlsaW54LmNvbT47DQo+IFRob21hcyBQZXRhenpvbmkgPHRo
b21hcy5wZXRhenpvbmlAYm9vdGxpbi5jb20+OyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBoZWxtdXQuZ3Jv
aG5lQGludGVudGEuZGU7IFNyaW5pdmFzIEdvdWQgPHNnb3VkQHhpbGlueC5jb20+OyBTaXZhIER1
cmdhDQo+IFByYXNhZCBQYWxhZHVndSA8c2l2YWR1ckB4aWxpbnguY29tPjsgTWlxdWVsIFJheW5h
bA0KPiA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyMiAx
Ni8xOF0gTUFJTlRBSU5FUlM6IEFkZCBQTDM1MyBOQU5EIGNvbnRyb2xsZXIgZW50cnkNCj4gDQo+
IEFkZCBOYWdhIGZyb20gWGlsaW54IGFuZCBteXNlbGYgcmVzcG9uc2libGUgb2YgdGhpcyBkcml2
ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJv
b3RsaW4uY29tPg0KDQpBY2tlZC1ieTogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYS5zdXJl
c2hrdW1hci5yZWxsaUB4aWxpbnguY29tPg0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFyIFJl
bGxpDQo+IC0tLQ0KPiAgTUFJTlRBSU5FUlMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUw0KPiBpbmRleCBiNDMxNWI3NjY0NWEuLmEzNmZiOTE5ZTkxMyAxMDA2NDQNCj4gLS0t
IGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTE0NTIsNiArMTQ1Miwx
NCBAQCBTOglPZGQgRml4ZXMNCj4gIEY6CWRyaXZlcnMvYW1iYS8NCj4gIEY6CWluY2x1ZGUvbGlu
dXgvYW1iYS9idXMuaA0KPiANCj4gK0FSTSBQUklNRUNFTEwgUEwzNVggTkFORCBDT05UUk9MTEVS
IERSSVZFUg0KPiArTToJTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbUBi
b290bGluLmNvbT4NCj4gK006CU5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlu
eC5jb20+DQo+ICtMOglsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiArUzoJTWFpbnRh
aW5lZA0KPiArRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9hcm0scGwz
NTMtbmFuZC1yMnAxLnlhbWwNCj4gK0Y6CWRyaXZlcnMvbXRkL25hbmQvcmF3L3BsMzV4LW5hbmQt
Y29udHJvbGxlci5jDQo+ICsNCj4gIEFSTSBQUklNRUNFTEwgUEwzNVggU01DIERSSVZFUg0KPiAg
TToJTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbUBib290bGluLmNvbT4N
Cj4gIE06CU5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+DQo+IC0t
DQo+IDIuMjcuMA0KDQo=
