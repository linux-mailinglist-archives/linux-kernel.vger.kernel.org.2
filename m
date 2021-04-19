Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27849363C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhDSHay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:30:54 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37292 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhDSHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:30:53 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C912D4023A;
        Mon, 19 Apr 2021 07:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618817424; bh=4TKWjBZJKyneG66a2CpVz0fU+L0JTNge2EBSZm4wbjg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cA+eXdpn2B5TGrnfahOQnF0GCiMJ0tSbFph8pm6208hHJYnI1hLdH8IfT+ZzRU621
         /G7Nj37fyL64Ace2Pjg/qtKzgl9lmnIJ4ADwLoDM5/pRTAio5qFvnlw6Zgcs0WF2rW
         HXLTMrRgH0t1gSQJ/E15o76IKG3vWxFoqpe8E4mFej8u5Hg3PazrXE/RobD9UGUetx
         6xIHoIBact6jQnurQD3GnRm91dvGrPrL75bbdlHwiCc4Vub2HwyLYsqLaaodBB+oeW
         vKXnXDEZTtgy4pt0PeOsur6qBRYt5tqdCGo9xXwBIq2UlCxZIUI5XCJsCwzB0lhXtM
         m955NWYqogZEA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7553DA00BA;
        Mon, 19 Apr 2021 07:30:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0AC94800C0;
        Mon, 19 Apr 2021 07:30:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Oe9RtMvc";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFScmx6lNbiq9AeE9dd4eUbGknDFt1yV40CB+VP2sIymNsI1rKhmOEptqjO2GKBDegbWxvuHomg435fokUmCT72YrgsiZwk7a2r7ZR+wXdhn0GohlnH2TNDErvbPYnY5p+6jAT94KFjKEhLKU3OqeOVReg0/j9q3xJ7rz7U1VG8J5zsyRYSWdhjXhD2CSPxxhXhh6yB+MxJHJkcrYjcxi8shrOFEout+LheDuSKpIsfb9sx7WHE8xa5Wc7tfIUOTTDpBYifWt0BJMTM+csYXbp5G4BnP2IFTJ8KFXLGoJ3rYwxq69PRmT1I0aMkJcfJUd4EJeEOB5IbiO/GPvMECnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TKWjBZJKyneG66a2CpVz0fU+L0JTNge2EBSZm4wbjg=;
 b=E0PMQnZ0Y0XGBQpxZ+f9G+3SsWV9JeeW+NDfQwUHgqjZne5t24Bfs+gCRCw6SG/EEl0FEIONTrw/TWj4w9vOqYRTsb3fFR63UnlBEMQQjn7R7llbRdroTxGR2B4krXmp55TnvTNv5RONV23H/YT4oYpPEbwkGVFrP0K62COQVB3a+a7AUEKcW8gTZwIrahH8clUzfiNJ+IJHBiM/UzHdBGPjgyqYPYa1tTHcPi+NoQJ+A9Z9bIuIuKMXvkQg0tTn4ka61BKtDu87oYdZMFd6Y++goPBRk3T0E0fL2JqaK5Uxcx6wTTCzhwoqJ30u08dzEV+1xZcACDbM309H6E1yYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TKWjBZJKyneG66a2CpVz0fU+L0JTNge2EBSZm4wbjg=;
 b=Oe9RtMvcG6aklr60VErDMJepgsTm45rIDKEmpf9DhHv5fVkG2oFxncF+KyTlYRKuoIUktOZQnmpzNzXNNTo4FbdIG27F416pRhXZmA2k/E2TqEaXHYRWOjvKJ2f3qC+rBuLMZjH82Ervmkk8lIxsFOcVEsSF4D+UrZ8XSLFCoG4=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:30:20 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 07:30:19 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v2 01/15] usb: dwc2: Update exit hibernation when port
 reset is asserted
Thread-Topic: [PATCH v2 01/15] usb: dwc2: Update exit hibernation when port
 reset is asserted
Thread-Index: AQHXMr6VHlKlkiBWsUOxuynH77Fwaaq7djQA
Date:   Mon, 19 Apr 2021 07:30:19 +0000
Message-ID: <eae54d3f-3382-133a-ce49-dc23476e6b4d@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <20210416124651.51C8DA005C@mailhost.synopsys.com>
In-Reply-To: <20210416124651.51C8DA005C@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ee14b7-7677-4a45-12b3-08d90304fc73
x-ms-traffictypediagnostic: BY5PR12MB5000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5000E9166A13399B447C664AA7499@BY5PR12MB5000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oPYqZ/WXTy/eVJRe7KAE4EFQDAxb82yJk6T6Tr6QG3R7PRgMmOeKBzSuz2x5WedS3/LP5mfrSVYXO6hYQbcPPtZRhovZLQgGPhC2BoPK11LyqgEUUFufpEor/Q0HzVXSYQwLMhfb270a4dpkl5khgrcfeFs+Su6KIuRhfzKTo2EE/AvPYtFAO8MuBN6usHBeFihJ7RcJogy37pZNmQrAnhO75KJjjdaADBlTXUWdOC7SYvA0PUdF+rrWwiBNpSH3rbfjcl0JHVzSHZOupuZ55pKTYP9j9kznmigRmRBFie+tTbQL4o5fNxW5CqOKAfTFt1IoP9CN6dSVouFeY8lFXV6AibwUEyB9PpQlo+nSYf4qlmBfiUVFiN3Ylaka6iOXeBJVY5HpmoZIA8/wZX43BRSQxm77fGwa+3cr4GUeKCP3syy40ziq/XLYw+t2IrgBGerV03mbpW/6vgFMqlXiMwflmj0RZWkyJNOaUMqbP48TpL5v+SAEx0dvJjZy2tALAgRYS7fo2SBa3ZFmJaKGh3rdMnf61Sv3aN9xk76/wYbYUzflXo35Fyk0V0M1HeukTkpBaMbSokaHk5cXq5WUDz6ULMXEUDT4E5OpcIvl28Wbt4ieWfqJPHBH8XRcsXRPXV1Ge00HF2NOYbBh+Nf/LCoVFuCF2v1u0T+iSWIdkwnXR6Z/g710Nun2MYOWCIrn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(31696002)(2616005)(83380400001)(86362001)(110136005)(122000001)(15650500001)(2906002)(31686004)(38100700002)(107886003)(6512007)(316002)(4326008)(186003)(26005)(8676002)(478600001)(71200400001)(66476007)(6486002)(76116006)(64756008)(66946007)(91956017)(66446008)(66556008)(36756003)(53546011)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UFdhczRaZ29oaHlRbjJMbTNZZDZ0c3Z1aXpXcDJiRHltMFgzZStuaG1pRkN3?=
 =?utf-8?B?SlNTQUxJTEg4dmM5V1VCSWpMRmlISSsvVjl2dUJaVHdKUmRKdlMyb0Qyc3E1?=
 =?utf-8?B?L3ViT2s4MWE0RmJ3OXBtYUJ0aVZuc2FWNGtlUGl0cTc3dFNLV2V2aVdYMVNv?=
 =?utf-8?B?ODdNMERYUU52VzRwdjF6eVVDa0Z1TGpRY1BSMWo2MDJobk91YWhFakhKdVpn?=
 =?utf-8?B?QzZTRWZGbVpxaG8zbXlhL1FPanQwRC92eEFxSDE1ZjVQdzR3dGxibWJ3aGJG?=
 =?utf-8?B?eFcwc0Fpa1RIWitGb29QSTJUYW85YU50b0tCU1lQZjhoeDNTTHMyUGVBYjdF?=
 =?utf-8?B?cnd2WlBPcS9HeDBWQmJDdWZQeVFTRHA4aVZWNHZQOGRuUzQ5QzhRd2ZPczZt?=
 =?utf-8?B?cTZkQmlwUStXaTRqNGtjWUNBL2J1K0V4ckFsUkoxWWhmOUdVRzU3VFBTVDlw?=
 =?utf-8?B?Nmc4ZVdWSTQvWm5mRmNyZnBnRytDQ1lSV3ZzcE5IM3JNVFBRZDgrMytpS1Nn?=
 =?utf-8?B?NjhhUDU4L0ZIZTA1NURGcXk4YnVBMXdLQWdMK0NXWmZxTElYN2liNDVHOFRj?=
 =?utf-8?B?enU4czlKRi9EWTRGTjl3ZGVzamI1ZTQvYk9uZWloTDR1YnN5c250VW9IUmJa?=
 =?utf-8?B?UjdqMWpRYzE1SVJPeURLcUYzT2FJT290cHVYL25OdXBycVNYejRaM2E3ZmpT?=
 =?utf-8?B?OUVEYkM0WUJ6eWoxakZWRGM3VGMzeUVuSS94ZDY4Um9NSk9GbmxpMXFvMFB6?=
 =?utf-8?B?eTZpNDcrelJqUEFwY0tnQ21iUkFjaG1XYzA5R2FPK2UxQ3lxVEx4WlZsWG1C?=
 =?utf-8?B?cERLZFltZnNJUjNhUXpLdTIxcDhyQkZEellvVFdFSW9YOVJjckdnbUI3U1h2?=
 =?utf-8?B?VitLQ1lBR0NQb0hURUNoaFg1OUQ3eVVvZjhhSWVvMjdENlk3elM4RWVxV0Vx?=
 =?utf-8?B?aEZXZFhrM3VKQ2hrVTR1bWdwKzU1LzR6V0x4am5sRzdGMDREQjFyZ1lPa01y?=
 =?utf-8?B?RjZoaSs2Z2tKTnNFNkFOaTAvaUV0b1lNMnBtZTZYTDdXSjJ6U3dIUngycGkx?=
 =?utf-8?B?aG8xQUlhUnlUaVBSQXdSNllYTzE1YXdoTzBWRExsOTdiK0FCdVZHU2c3ZWo0?=
 =?utf-8?B?QjRtKzBIcFNnblU2K2pxOFlFWHdVVlhGSVFqU0ZHQnVod1V0VGN2cUo4RGZ5?=
 =?utf-8?B?TkRCaFpPMXB6UXVXNTAwZkJOa1E0RXlZQ0xjTUJkUlljRHpJMnVheXNHK2Zp?=
 =?utf-8?B?V0MrU3laVVQwMWJaK05KU1ZrcXBOZWVZQnhVbnU0VXVGVmRiRWp2ZHA1d0xo?=
 =?utf-8?B?SHlHWXEvVE9MUkFWM3pBdG9panZRVERQUHltbkVhNVdIRzhjQzVwZklmMlpN?=
 =?utf-8?B?QkplQlNuU0FLRGxRZFhLMEY2eEc3YnlORGplOUovMTVxdUlTdVRISFA0Vk5U?=
 =?utf-8?B?VzlhRkVmMU5KUWtDa2NpUHFkM3cyazJubkFJd2JvSDhLL2ZlZVV5NGpUcEtS?=
 =?utf-8?B?QStoTjJZNHRtTDF2Ui9zS3JDZFNuS1FnYzRPQWUvSVlnU0Y1N1pTZGpvWCtI?=
 =?utf-8?B?dmN6SUxDcjZrSGI1bjl5VWlTVmlwLzU3R0pNRENaREU4WHNZY016UFJOWkI5?=
 =?utf-8?B?bEhxdUtxdkxMeCtjT3VSR1VNMmZqbzBlaXBXTGU2b0NrN0c4TWExZE5PeFVj?=
 =?utf-8?B?UG1RQzhjVWZRc0lpOUdyTXBBdEJKQTEzWnFEa2JzN1RNN0JIOFpQKzI0ZXVD?=
 =?utf-8?Q?w195QF96/iRqsHqbBI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8101EA31EBA2B644926ACA61E3325E6D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ee14b7-7677-4a45-12b3-08d90304fc73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:30:19.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAFA+D7s7xdNrd6rrZ88S97PBqx4GhDfkpFKHX6jiyPdXaESWboO9CQs4Dkv6nIiVoBO+YsNXFEJVMaI4+egdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIxIDQ6NDYgUE0sIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4gTm8gbmVlZCB0
byBjaGVjayBmb3IgIkRXQzJfUE9XRVJfRE9XTl9QQVJBTV9ISUJFUk5BVElPTiIgcGFyYW0NCj4g
YXMgImhzb3RnLT5oaWJlcm5hdGVkIiBmbGFnIGlzIGFscmVhZHkgZW5vdWdoIGZvciBleGl0aW5n
IGZyb20NCj4gaGliZXJuYXRpb24gbW9kZS4NCj4gDQo+IC0gUmVtb3ZlcyBjaGVja2luZyBvZiAi
RFdDMl9QT1dFUl9ET1dOX1BBUkFNX0hJQkVSTkFUSU9OIiBwYXJhbS4NCj4gDQo+IC0gRm9yIGNv
ZGUgcmVhZGFiaWxpdHkgSGliZXJuYXRpb24gZXhpdCBjb2RlIG1vdmVkIGFmdGVyDQo+IGRlYnVn
IG1lc3NhZ2UgcHJpbnQuDQo+IA0KPiAtIEFkZGVkICJkd2MyX2V4aXRfaGliZXJuYXRpb24oKSIg
ZnVuY3Rpb24gZXJyb3IgY2hlY2tpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBcnR1ciBQZXRy
b3N5YW4gPEFydGh1ci5QZXRyb3N5YW5Ac3lub3BzeXMuY29tPg0KDQpBY2tlZC1ieTogTWluYXMg
SGFydXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4g
ICBDaGFuZ2VzIGluIHYyOg0KPiAgIC0gTm9uZQ0KPiANCj4gICBkcml2ZXJzL3VzYi9kd2MyL2hj
ZC5jIHwgMTcgKysrKysrKysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MyL2hjZC5jIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBpbmRleCAwNGExYjUzZDY1YWYu
LmNkYTNmOTMxMTk1ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IEBAIC0zNjY4LDkgKzM2NjgsMTcgQEAgc3Rh
dGljIGludCBkd2MyX2hjZF9odWJfY29udHJvbChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIHUx
NiB0eXBlcmVxLA0KPiAgIAkJCWJyZWFrOw0KPiAgIA0KPiAgIAkJY2FzZSBVU0JfUE9SVF9GRUFU
X1JFU0VUOg0KPiAtCQkJaWYgKGhzb3RnLT5wYXJhbXMucG93ZXJfZG93biA9PSBEV0MyX1BPV0VS
X0RPV05fUEFSQU1fSElCRVJOQVRJT04gJiYNCj4gLQkJCSAgICBoc290Zy0+aGliZXJuYXRlZCkN
Cj4gLQkJCQlkd2MyX2V4aXRfaGliZXJuYXRpb24oaHNvdGcsIDAsIDEsIDEpOw0KPiArCQkJZGV2
X2RiZyhoc290Zy0+ZGV2LA0KPiArCQkJCSJTZXRQb3J0RmVhdHVyZSAtIFVTQl9QT1JUX0ZFQVRf
UkVTRVRcbiIpOw0KPiArDQo+ICsJCQlocHJ0MCA9IGR3YzJfcmVhZF9ocHJ0MChoc290Zyk7DQo+
ICsNCj4gKwkJCWlmIChoc290Zy0+aGliZXJuYXRlZCkgew0KPiArCQkJCXJldHZhbCA9IGR3YzJf
ZXhpdF9oaWJlcm5hdGlvbihoc290ZywgMCwgMSwgMSk7DQo+ICsJCQkJaWYgKHJldHZhbCkNCj4g
KwkJCQkJZGV2X2Vycihoc290Zy0+ZGV2LA0KPiArCQkJCQkJImV4aXQgaGliZXJuYXRpb24gZmFp
bGVkXG4iKTsNCj4gKwkJCX0NCj4gICANCj4gICAJCQlpZiAoaHNvdGctPmluX3BwZCkgew0KPiAg
IAkJCQlyZXR2YWwgPSBkd2MyX2V4aXRfcGFydGlhbF9wb3dlcl9kb3duKGhzb3RnLCAxLA0KPiBA
QCAtMzY4NCw5ICszNjkyLDYgQEAgc3RhdGljIGludCBkd2MyX2hjZF9odWJfY29udHJvbChzdHJ1
Y3QgZHdjMl9oc290ZyAqaHNvdGcsIHUxNiB0eXBlcmVxLA0KPiAgIAkJCSAgICBEV0MyX1BPV0VS
X0RPV05fUEFSQU1fTk9ORSAmJiBoc290Zy0+YnVzX3N1c3BlbmRlZCkNCj4gICAJCQkJZHdjMl9o
b3N0X2V4aXRfY2xvY2tfZ2F0aW5nKGhzb3RnLCAwKTsNCj4gICANCj4gLQkJCWhwcnQwID0gZHdj
Ml9yZWFkX2hwcnQwKGhzb3RnKTsNCj4gLQkJCWRldl9kYmcoaHNvdGctPmRldiwNCj4gLQkJCQki
U2V0UG9ydEZlYXR1cmUgLSBVU0JfUE9SVF9GRUFUX1JFU0VUXG4iKTsNCj4gICAJCQlwY2djdGwg
PSBkd2MyX3JlYWRsKGhzb3RnLCBQQ0dDVEwpOw0KPiAgIAkJCXBjZ2N0bCAmPSB+KFBDR0NUTF9F
TkJMX1NMRUVQX0dBVElORyB8IFBDR0NUTF9TVE9QUENMSyk7DQo+ICAgCQkJZHdjMl93cml0ZWwo
aHNvdGcsIHBjZ2N0bCwgUENHQ1RMKTsNCj4gDQoNCg==
