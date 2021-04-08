Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDDA3584E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhDHNkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:40:15 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45796 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231722AbhDHNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:40:12 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 449A5405C3;
        Thu,  8 Apr 2021 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617889201; bh=Rhw7WzNP3UnlVwGN6THODC8VuX4x40KsSOAwe0qLLeA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZxBr5m5eTIDOcGl77FsNcaVUlHT+K+Ea8R43KIjJNlrHCtNC1Ol4V4jgqDvpoFnND
         mXfrdr5WMBIjTJv0fqHg5X7V8qHWKPjh/1eD3H0p2Y9UJkNUln/MN7o7oswKSws1s1
         ORF+SNRNXfMnwKvcKTeiNWqG0YMQ018bm3ZGqxhjOnKhx+sWhPJX00NsZyL78DvBoU
         1P2EWIhu6BMEv8zMHkSDX7WyFEExVqYH4u2pNLaO+ueTMJSUTJRMflLjIy4ZfBcRe2
         E1K84maFX5gPivqI/hD+W1cwEJRvK2wT+rzrTWTMPm+K9dqc289pRzEXzH1wFAyftH
         g7qrncd9Ygx1g==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1FD9AA0068;
        Thu,  8 Apr 2021 13:40:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 629E9400A1;
        Thu,  8 Apr 2021 13:40:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qP91Xk6b";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNdOoFMN42MOOukVEl7DLC2qcLVP5tMnL4FIlycbR8/iUE6aP/OibyL6gELQBgsePPzruqDwCDN2qZ+v3tcA3xHywzmxpDDsTzlaJve/vNHxj+Mmy7fOP0VNS+UudE+1A9+YoTT+yyudwM3uPrsKhDb/YpOvUKk3ebIzOH0n6Wnx+leaYpOAK8E8MRFDYp9r+OFuIH2wVGlrSi9+Kg9EgteTe2GpPAolFQWilUbis9IiCJQ+j92knPVtVYyYJNGUyhPKgIMjbE22nMLHpnF/zGkHyZR7rF6nxpJUdjoiaO1BnCeBr/oXGAmIr6x5vQ4bPQTrSbTKRwoIG6eM1fVInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhw7WzNP3UnlVwGN6THODC8VuX4x40KsSOAwe0qLLeA=;
 b=nA4TBYv8vOhKzMOSYwieIP37WMy4JkiU/VgDftOGogjg29+dCbYZZB9jw+T7xz+Lxk+OUWgGYxdbpNroRUzcL7rRDVsQ6ePsHQTSGuslJLrAXoN43n+xERaHgfctBn/gP6rtunYoNRfJPa1MJcosP6JLX6U2MVw4eK/rYiHC1kdgQpYFlV/ZoDQsc5X2JnmZPun5IF2TBkA/qCRM7HD4iezNhxzCDy1rClilsQRo+A7KjwhsiVg1heGs6tVBw4WvKYxvPwbp6bFFsgXEPkIG8ir5Tv4i86e645c286U8BYbkabonD8HGjl/SLCT52e0VhZNGSQMtnhZwaK0suiVh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhw7WzNP3UnlVwGN6THODC8VuX4x40KsSOAwe0qLLeA=;
 b=qP91Xk6bUH5sKdgxTw/x6tkpg5gP04xTJne0uzDiSmPHETj0YD56O27avx6Il8H8SEZGCmMYrhTpYzhb+s6OlpOHFt8vzUzBJTTbX8rrUoZeDBVqw7HnA3JEmybv5KoLWydYXki6dfEDIu23A+09k2U3e+PmCS8aD2JFiyr7018=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BYAPR12MB2965.namprd12.prod.outlook.com (2603:10b6:a03:ae::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 13:39:59 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 13:39:59 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v3 08/14] usb: dwc2: Add exit partial power down when port
 reset is asserted
Thread-Topic: [PATCH v3 08/14] usb: dwc2: Add exit partial power down when
 port reset is asserted
Thread-Index: AQHXLFvqfh+vs3UxaketQk/13TrPdqqqoJ0A
Date:   Thu, 8 Apr 2021 13:39:58 +0000
Message-ID: <32f574b5-e433-e211-625f-48e261c50e91@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
 <20210408094526.4DD7AA022E@mailhost.synopsys.com>
In-Reply-To: <20210408094526.4DD7AA022E@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8b27c4f-6480-494c-62bc-08d8fa93cdbb
x-ms-traffictypediagnostic: BYAPR12MB2965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29658D96D964E03C65958A08A7749@BYAPR12MB2965.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJzgqUHX6S3LXUdRhGOj3OECNkTv/0y4xb0zOpratUmq/slbgHLCQ1RPwrFpre6Qc4Kn5GqoVJEToiru1fNLqQGJePBqpIy8nku1kWt3vw7XNEfmqBslmaHrSKx7NMWC/UwHR9VY/ibwm9RXLo4eyipSmHd7Bbh2qi3R/0KnFHeAxRgwU3AXmWjEsv+Sk6NSLKRPF/dq1Yd3lfZ324BxfA0l1AL4E/1lQi2q+GIpJS+J/f1l3V+vYkz36bEb5WQ56PiKPCZXlT7GVtBs5gjRThEZNY/0jXeFLhubxisDZj95qIptkhIZv2nWwicnaWEZ5ls0VHxtJmQ8W2S2jhhOOclQinJjzur3QpwUyrpZtNSGTUpGvzmoIW8A/e0+cmvmfcPdgS8XeMdwF4rX8FWnoU+ePZtO0VLDc4YYLzVZIrgHt/bQFIHsck876TDwFJ+OdkXokD6ziE5+rm33EJdH1JbYsHmxqXtsDX84ncn2EvsB/VvenTkG7ShzQnyQ3PU4wUS9Bgk8D/0JENG9zdS6iwT8iX/zHszTz80Be+FNraUKsiRt1xn51xGduULW9Y76899KQtmCqyVpCoaeiiOlSuVEKvIxgZi96DGedEpaMSy7LHUC3UH05isXZvy7tY8LM/5Pu7LJWMhp2DgDBBYHqNJT53P7kbxxM96UaNwrWSXf8+8matiCaHRrEINWvGOSdRRS+QU10TbOrKsFlB/6ppNv27msQc5N6L71Ou6hFUU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(39860400002)(346002)(478600001)(83380400001)(8936002)(36756003)(6512007)(8676002)(38100700001)(5660300002)(71200400001)(66476007)(64756008)(4326008)(6486002)(91956017)(66946007)(107886003)(316002)(76116006)(186003)(53546011)(86362001)(31696002)(6506007)(110136005)(31686004)(2616005)(2906002)(66556008)(66446008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0d3bFBaMnFLN0JnNms1WWhHTDMxYThQYWh5SkhJL0Q1N0tlWk11dFRpUXNU?=
 =?utf-8?B?N2hLdXRvdUZVZ05mSUUzNElRZ3FPWGdNV2ZySkNZbFE0ekFRRUZVUkkxZ3BJ?=
 =?utf-8?B?bmtkWUhkM0ZiUnZoYVMxUEdzMjRablhhRXVzSSs5eDRDelMxeGV6ekVOWTVy?=
 =?utf-8?B?S3pObnljVG9UYlRTczBHN3hZT0U0TUhaSXkyWVZGNFRYeGEzSjBmcXRUeFJq?=
 =?utf-8?B?UnJnVU5ERGE3cWZaNVVneU1EVERKTHMwT1NFcjVQbXFlUDNUSXpCajJGSEYv?=
 =?utf-8?B?ZS8rd1R6RFFSc3BJZGdrS0xRZThXWmhnbXk1dzgvU3NzQ01CZE96SzNZTm1q?=
 =?utf-8?B?TllYMU9nZFI0aGI4YWNNclBFZzc4RkR0L0Fxd3N3TUhLOFBOUExaUXIyd0Q3?=
 =?utf-8?B?cHVLUU8zYS9qeElySXRnRFlNTzB5SlZRMzNhZGNlcEFyYmxPRGdwZU9sa2Zu?=
 =?utf-8?B?ZHRnbFR2K0YvT2pBZUpyL1loZWkySmd3NnFmb01hSXp0dWVlT250OUF0L1pD?=
 =?utf-8?B?RnBSKysrMDVCUG54V1BaK2w1R2JBOXVKQ3IzZzNOUitNdkFaUEc1dkpWTXZ3?=
 =?utf-8?B?RFhZR0FQUXRLZk0wMGVXaXA4bTlwZXBiUkh0MUF3ODg2dVUwNXNLYW5kKzVw?=
 =?utf-8?B?Nlg0ZGJYV3h3MDN4YnRDb1RJSll0OE5ocktsSngybC80RUp0UDhNZlVBM3BS?=
 =?utf-8?B?QkhEM0t1aXUxZlFEc2xYd0ExRVptalZpMU1MV1FGVUdNMDV5clpXOXk2dmor?=
 =?utf-8?B?ZWZyUERXbElIOG0yMmEydnVhUVVDd2ZGN1lONmNiWnk0V1VXWkNOZkFjTVVQ?=
 =?utf-8?B?SnpZYnJlTENqMGZCS3VmdlpFSFduRmphbStJWEhmN1BxM1VSVEJXRUQ3dkM2?=
 =?utf-8?B?VVN5VGFSRlhKQWFLOGpoRjM4NXVpZSsrTTRzc1hyMlZaazU0aHVidFZpT2tZ?=
 =?utf-8?B?OEE4U21iTmlIMUpyc1VKS2VycXJHQjRBMjZaVnA3ZlRFc1AxWnhQYmJyUWdp?=
 =?utf-8?B?a1BFRHJ3WFVqRVZmRnRmK2NSVm5PZi9qQnpCSGFNQmYyalE3dTdzUHdrdEIx?=
 =?utf-8?B?N2ZyZmVXYlI4djd0VzMrY2E3d3R6d25rWHhLZGV4Y0NFUWx5MXo1QTB4NmJI?=
 =?utf-8?B?Q0xjVGRyOUQwdnRqM1dpRU9uMktwZUVCbGlEK0hrcUYzUzFYNlVyUVJ3N3Fv?=
 =?utf-8?B?Nm9pYytaZVdvc3JvaEo5OEdueWpRQWIyazVsV1RITktBYmk0Um5Vc3BIRFlt?=
 =?utf-8?B?TGF1RnoxcURFaEZKTFRZK3VwMzlzNitISk1FdURhSVdFZ3c2bnh1eEkrckF4?=
 =?utf-8?B?YzFWTlJvdm9Pd1IvMWVWLzFZRGlkSU1PRjVyaGhGY1VObUFCWWhTYnUxdXFV?=
 =?utf-8?B?SE56allPM0xQT3FRY3lrRGQyMkp6WVJxWllIRjl3OGg5MUF1VmZEQkE0ZVJ4?=
 =?utf-8?B?QTZCSnVObFB2aDNuTGwyb1VGYVk5bktHOUZpUVJZYmNraUJaQlM1eWpxV1Rw?=
 =?utf-8?B?ZGZCMVkzck5JZC9YVGxORjlhZ1BxNm5YMEFtdU1lbEpvYjRLUERadS91OTJD?=
 =?utf-8?B?dG1lbGp4Q2MvVnhNdVlNT0RDelVEdGt2KzVDQWNwam00eWQwaDh3WTUvbThF?=
 =?utf-8?B?ekR1eWgwSW83VU5hcCtxZjdwUHozbkdDejNXRnQrUXdrUTA4dzJ0NXRQRnBF?=
 =?utf-8?B?NkZMb012RkVxeG01eVp3Vzl1NDArZWJwR2QxMWlMbEpyWmNlRFIxenNCUDBS?=
 =?utf-8?Q?H/vYgkGpYDKSwVmhaY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B2AA98D3581E94981D0179296E56690@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b27c4f-6480-494c-62bc-08d8fa93cdbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 13:39:58.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErDioHsp0hYX/dA/HdXXQxx4GYZUbLqnNDN7YSRoTnyu6LTGE2XW9XsM1+FoKpvCa2is6eG3viR1rAoWpRzxRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzIwMjEgMTo0NSBQTSwgQXJ0dXIgUGV0cm9zeWFuIHdyb3RlOg0KPiBBZGRzIFBhcnRp
YWwgUG93ZXIgRG93biBleGl0aW5nIGZsb3cgd2hlbiBzZXQgcG9ydCBmZWF0dXJlDQo+IHJlc2V0
IGlzIHJlY2VpdmVkIGluIHN1c3BlbmRlZCBzdGF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFy
dHVyIFBldHJvc3lhbiA8QXJ0aHVyLlBldHJvc3lhbkBzeW5vcHN5cy5jb20+DQoNCkFja2VkLWJ5
OiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5Ac3lub3BzeXMuY29tPg0KDQo+
IC0tLQ0KPiAgIENoYW5nZXMgaW4gdjM6DQo+ICAgLSBOb25lDQo+ICAgQ2hhbmdlcyBpbiB2MjoN
Cj4gICAtIE5vbmUNCj4gDQo+ICAgZHJpdmVycy91c2IvZHdjMi9oY2QuYyB8IDkgKysrKysrKysr
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IGluZGV4
IDcyMDM1NGRmMDE0Yi4uN2M3NDk2NzE5MTUyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9k
d2MyL2hjZC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gQEAgLTM2OTQsNiAr
MzY5NCwxNSBAQCBzdGF0aWMgaW50IGR3YzJfaGNkX2h1Yl9jb250cm9sKHN0cnVjdCBkd2MyX2hz
b3RnICpoc290ZywgdTE2IHR5cGVyZXEsDQo+ICAgCQkJaWYgKGhzb3RnLT5wYXJhbXMucG93ZXJf
ZG93biA9PSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fSElCRVJOQVRJT04gJiYNCj4gICAJCQkgICAg
aHNvdGctPmhpYmVybmF0ZWQpDQo+ICAgCQkJCWR3YzJfZXhpdF9oaWJlcm5hdGlvbihoc290Zywg
MCwgMSwgMSk7DQo+ICsNCj4gKwkJCWlmIChoc290Zy0+aW5fcHBkKSB7DQo+ICsJCQkJcmV0dmFs
ID0gZHdjMl9leGl0X3BhcnRpYWxfcG93ZXJfZG93bihoc290ZywgMSwNCj4gKwkJCQkJCQkJICAg
ICAgdHJ1ZSk7DQo+ICsJCQkJaWYgKHJldHZhbCkNCj4gKwkJCQkJZGV2X2Vycihoc290Zy0+ZGV2
LA0KPiArCQkJCQkJImV4aXQgcGFydGlhbF9wb3dlcl9kb3duIGZhaWxlZFxuIik7DQo+ICsJCQl9
DQo+ICsNCj4gICAJCQlocHJ0MCA9IGR3YzJfcmVhZF9ocHJ0MChoc290Zyk7DQo+ICAgCQkJZGV2
X2RiZyhoc290Zy0+ZGV2LA0KPiAgIAkJCQkiU2V0UG9ydEZlYXR1cmUgLSBVU0JfUE9SVF9GRUFU
X1JFU0VUXG4iKTsNCj4gDQoNCg==
