Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1343A03AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbhFHTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:20:45 -0400
Received: from mail-co1nam11on2124.outbound.protection.outlook.com ([40.107.220.124]:22529
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236374AbhFHTIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:08:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG070LU+LI+U+04v4Gzk34DrLsZ29ti9/2SB4+efvL+oW8dJxeFaT3N97rVBGbarjl1x6Q7CbPwWe9KIsWyRXIU4WttNZaws1u+vc1xN8Ea57q2lpMNgAn+pe1cRJ0lMNyKQ/tzMItShk0+LYsQlVcgLH73vRyT+i/Sm/4/jBrvUNJfMu9atlnNtSx/TxkLVIPMCH2g8xJ01Y8ubIks8BoX9cSy+rA5BYyxixSd97ijCL0vZNV4JTGcyVHhuOwphyZyvJ9jUK58Z3SlfDT7jDr/19cZnrn5/OVPFpSie9sGKgdKi4B0tc6uYDLR0DtOCme/DEElKhTxdt9pUXz7vZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u8mBT6g4321TZWs9xqP6egioZGgyEntbiiV96tBlMU=;
 b=bXr6L3H0EaNoO+zhtqEmZaUXwO4cGdBEEvz+1VUnoKQcZeXcKiy0v4fUilRVdR6N6cGh+cR6ypH3+ZMJ/gWiPcLtYmcDdpq8/VdzlkWjsyyy2Yx4BESPEVn3zx1BghfFT4sBOsVgTOP/6BhD/dSEd2R4p2/cTjLc25uiOrWIYkEftxJFVHqpND7IkYMqOvHjXBonCzCvXNlCnR6Z5/q9l1tTDznh92oicVGi9tUHRgnwde2vOmzB3I074C4z7VR9gKlI4yYqsiKezyqdWRjzgznh0tJnqE58TInvoinRifQEyobgPl2Vv4yUYaQYSrqQpPzjhIgZV7tnRqdd/F0RcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u8mBT6g4321TZWs9xqP6egioZGgyEntbiiV96tBlMU=;
 b=eIhf4iiB3iBIca0bQ2vx7G2qiJs5BVQmBYAWzUFxAzlN4M2rIjbAkXODPIahKRf3VbBR7WPC7tHzTNmFGAND1r0dAPBrY/O16i2hjpGJ9Bc91DwQ+TOijgK+uf2kSeR4YWL9fD2Sgt9HGFBuboy69sG/Skn0jbH7oYnJtvgtDrY=
Received: from BL0PR02MB4370.namprd02.prod.outlook.com (2603:10b6:208:42::31)
 by BL0PR02MB5425.namprd02.prod.outlook.com (2603:10b6:208:87::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 19:06:45 +0000
Received: from BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::35b8:ef07:8fb7:45cc]) by BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::35b8:ef07:8fb7:45cc%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 19:06:45 +0000
From:   "Lin, Zhenpeng" <zplin@psu.edu>
To:     Kees Cook <keescook@chromium.org>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slub: choose the right freelist pointer location when
 creating small caches
Thread-Topic: [PATCH] slub: choose the right freelist pointer location when
 creating small caches
Thread-Index: AQHXXJPcuZEfER7lZkGUYZVvC3KPw6sKLTUAgABFaQD//8QFgA==
Date:   Tue, 8 Jun 2021 19:06:45 +0000
Message-ID: <25AB8A72-B970-47C2-8688-48126075E72E@psu.edu>
References: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
 <202106081125.E2DA4DE8@keescook>
 <F9847E9B-5557-4FAC-AE80-829D0AD712A3@psu.edu>
 <202106081140.F73F91F@keescook>
In-Reply-To: <202106081140.F73F91F@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=psu.edu;
x-originating-ip: [67.22.19.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 744bd815-110d-4fad-bea9-08d92ab08f59
x-ms-traffictypediagnostic: BL0PR02MB5425:
x-microsoft-antispam-prvs: <BL0PR02MB54257E4D4BD28CE449CF6E34B7379@BL0PR02MB5425.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xiqBpjoBM2grw7zsmHZz9Um5PEkwbWmE0QKW6/4WX8LvuV5xI8VAfoKJmU5s3f4nXtInG1aZsJG48UHVy4HxMHbRNT1zXFIMyMrJOgTCaUdrtnSObgZ0fzCP1NVPO7AXDWQoJT8dQeZMWL8kHuk9nLJogwRXzKLPnStFs6U17zul1cMfthFT5XDaw7p6xh1cvZHNmGC2hlywntQstpUIUuLnq2mBHzn57WGqe9r/P4RxWue+KstYEiJjWmusdH+Gn5wQ0Nq3ODYhVx4Bvrgos0ImG6gNwIkPEaxAfXYlBFOyG0uaIEUOxqDtQOSA1i2JkNIWJzZmE/32ICjHG5eXypB7BVydeUzWIrljWDr1Qv/CP8qPbISubWKhVlT0ZW0SA5mEUN1prG4HTf/L54hk2Hs37cgwSXYNV3HrbX2kV+AZ16X3r3cYR3jkIwkZft40xWvmrRTO0IResSayjQ3eLkQl0ionssNgEuGzm7+qzvJ2WwAKlTjuLAVL5rpjl4hM3zjK07cCdjc4JChEdEJSIljn7qpaMkP+tvzjjeFkH0yYE6cyLb3plPLsxupPWo7Dgk4tSwhs9uOntJP4yGyYkYmQFe9teZOHzg/W5QRXlIAUsgTw59pF3fHpCKHz+tyHdYCAvz5oXddkQkXKnZiCdvSmGnCRi/0mbLcpbahPv+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4370.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(6486002)(83380400001)(33656002)(6506007)(5660300002)(36756003)(4326008)(186003)(122000001)(86362001)(38100700002)(6916009)(66446008)(76116006)(6512007)(2616005)(66476007)(66946007)(64756008)(66556008)(786003)(316002)(75432002)(26005)(54906003)(8936002)(4744005)(8676002)(71200400001)(478600001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW5QMkV2K0NPTzdUMlN3amZKdUY3NzQrYXhaRHB4NnhmZ0hwK1oyaWQ2N1lk?=
 =?utf-8?B?dDVPOElkU3daTnZhYkVwd2dncXRNdENRVEJGY0xYekoxRnc3TUoweU4vWlZK?=
 =?utf-8?B?S0tlWlEyRXhmRXZ1dXpsZ3JEMi9FZmdiWGJUZDYwOE1PSFRmSzJjMkhFWms4?=
 =?utf-8?B?T2JWMjFRcXVYTGhIdVE0c0JZelJBci9vZWFraU1pSmw2dXNaZWJ1UG5rK1hR?=
 =?utf-8?B?a29WS2tldXRKYjcvSlMvQm9DYldRSXRxRzhkVkE4d3VTMzNrbnJtekNXT3Zw?=
 =?utf-8?B?cGRqUFAzS2hEaEVNWjB6d0FnZFB3OTVVQzYwU3BmTkVFaFo3MUxlZ3Zpd3I4?=
 =?utf-8?B?b0hEV1dwTDVaemYyRjR0Y0s2T3E3NlA5OVU1U0tsbzUwN29Dd2FDYXRoNU0v?=
 =?utf-8?B?N21wR0JaV0FKV1N4M1p6azVJVXNMN0x1ejJ5MHpuZG1qM0tub3ZJMTNxZmpv?=
 =?utf-8?B?aVlMTTZYK1VmeG1sa050NU1idklQTGtSRzY3RHd2ZkI4bFl2S2xIaGs4UFNs?=
 =?utf-8?B?Uk9oWWNYM0hDZEl2NHovcmdnclNjMDZBWlZXUDVHTTVYNFNHSVlTTXpTbURV?=
 =?utf-8?B?UzMvTEZ3UXRWMU1SQVFOVTVCcWNsOW0xdGVhZTVlQ2FjczNBMjQ1T2dkWkZO?=
 =?utf-8?B?Z1lOTHV3cEl4NHFJTTdnUVZpdFp3YTBQa3dtVmNFNW5UNEJnclVmdk1qa045?=
 =?utf-8?B?MEptZSsyZEJ2QUxjc0xVanJpWDJ5eHZtME9TTnlHQW9XRFBrSjNkdWliSGp2?=
 =?utf-8?B?ek01UWVuZkdCYzI2RXFLaFR0Z2Y3Wnp5ZElkN2pHTkxzVUFlNXQzYVdaYldl?=
 =?utf-8?B?SmlaZmFuTno0bFlhVGJYTTVWcVV0c2tRRXpRd3V6UXFVajdiZE1kVnlnODMr?=
 =?utf-8?B?eGZYQmVjSTNIRUV6TG1YRDd6b1pLTlViVW1DY05pMm5RWk1vUWFnZUtSSFNu?=
 =?utf-8?B?djdWeXdVNUwwWkNTeXc0UHBrN3MyVlE5b3ZjaWVvc1ZjZC9rYUFaRVJReGhz?=
 =?utf-8?B?am5nUGZjRWEyVm9JeEhEbVNhZEJGa2djV2ZQVXZMNUdGbFlVWkYrcUwwU01a?=
 =?utf-8?B?dEgwc0V1NE92M09WUldNQ2FmaGJGdEhGdW0vNnpnQmR4SDlVYTRRaUpYV0pB?=
 =?utf-8?B?d1NFVjNaeWNUMUNuOU1VRjdrUE44ZjRYSkhZYVhlaXBQZGswb09xWXptSlhW?=
 =?utf-8?B?RDVrOUNJY3BkYzA1T1RPVnpuTUtxUyt1WS9ta1BoUXlLY3FleUU5Mm0zNldy?=
 =?utf-8?B?M2dsMjIzUy9mZmJPUGd0aXBrSGdRQm53Y3NMM09uSUplVUg3NmtvSitvb3hr?=
 =?utf-8?B?ajF3Sy8xbnFGdHAzSTE5dFZpdlFYT21RTzBSM1RxaGJmN3lmVlRISUEyV0p4?=
 =?utf-8?B?VXpIcU8rOG42ZWtHRXQxOXdVak5Qek9PNEY0bXVLZzhSZDYwYVFvRTJtUG5k?=
 =?utf-8?B?OUZyNWdPMllMUENyR1ZONWhHZ2pNN0hoN2dpazdha2E2a0NkeEJSZUpDUkFZ?=
 =?utf-8?B?K2dFUTUvQXcya0tLTmwwNmZ0Umc5N1ZoZmptSEdkRXFUUGlQR3RwQVliZVNp?=
 =?utf-8?B?dTgwc01YcERCbFBXR0pxSDVmN1ZPNmFrRVY5QzV5U0xETlFxSWhTVldKYWFB?=
 =?utf-8?B?cmZxVkJwcllvT254cXZ3Zk56NDdFVXF6TXNTTUhZVWZaRStNTzZ0M1BHQjRN?=
 =?utf-8?B?TllFQ2NobjVZWERyY1FzWHVobVBOOGhIM05SZTBZdWhlbm40Nms5NHhtdEdF?=
 =?utf-8?Q?9XuARK2v291NmbOnk9hmCdsBFDFZzEr8AvqX0CS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C8E731DDC834048A12404D000245F07@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4370.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744bd815-110d-4fad-bea9-08d92ab08f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 19:06:45.5780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSRyZg6o5ouugqxCwtkxbPdaV58zNutODZY/jMO32l23U6fMuFuBAZJQ3ybF5Qke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5425
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm8gcHJvYmxlbS4gSnVzdCB0b29rIGEgbG9vayBhbmQgdGVzdGVkIHRoZSBwYXRjaCwgaXQgbG9v
a3MgZ29vZCB0byBtZSENCg0K77u/T24gNi84LzIxLCAyOjQxIFBNLCAiS2VlcyBDb29rIiA8a2Vl
c2Nvb2tAY2hyb21pdW0ub3JnPiB3cm90ZToNCg0KICAgIE9uIFR1ZSwgSnVuIDA4LCAyMDIxIGF0
IDA2OjMzOjAxUE0gKzAwMDAsIExpbiwgWmhlbnBlbmcgd3JvdGU6DQogICAgPiBUaGVyZSBkbyBl
eGlzdCBvYmplY3RzIHdob3NlIHNpemUgaXMgc21hbGxlciB0aGFuIDIqc2l6ZW9mKHZvaWQqKS4g
RS5nLiBzdHJ1Y3QgY2NpZCBpbiBEQ0NQIG1vZHVsZS4NCg0KICAgIFllcywgc29ycnksIEkgbWVh
bnQgc2l6ZW9mKHZvaWQgKikuIEkndmUgc2VudCBhbiB1cGRhdGVkIHY0IHNlcmllcyBhbmQNCiAg
ICBDQ2VkIHlvdS4gQXJlIHlvdSBhYmxlIHRvIHRlc3QgdGhhdCBhbmQgc2VlIGlmIGl0IGZpeGVz
IGl0IGZvciB5b3UgdG9vPw0KDQogICAgVGhhbmtzIGZvciB0aGUgcHVzaCB0byBkdXN0IHRoaXMg
c2VyaWVzIG9mZiBhZ2FpbiEgOikNCg0KICAgIC1LZWVzDQoNCiAgICAtLSANCiAgICBLZWVzIENv
b2sNCg0K
