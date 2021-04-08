Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3443584FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhDHNlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:41:22 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45614 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231816AbhDHNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:41:18 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 17E57C09C2;
        Thu,  8 Apr 2021 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617889267; bh=tpDvM1K810K4ve6ZTeKjy9gfnPxiWakByWUgGOhZYxg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=l4xuk/cQ9OwIHgGfCZM6Dbcy+bKa2Aez3XTwub04oCeIhqKArXpehhBvxwwahIXJu
         9+qtlAU0zYdg64Be8VRifTDM9xCO6vj+3yJiaIqj4LmJl88nWm/TgJqtElG2PNZcD4
         XQcW0afRGu78/Rh3DQakJ2BylcPCkdDjyR20n0Kb433CMutUNS7eDdRELrGSD6DpMG
         RNEaJweoQUJSEQBSQqvYXbihqrbK+nVpEt2LUjeVJiWHfDpOWal1znYI1UYcziN11f
         5xgga7QYxu5wy3vRD9U7Zt4CLJOx5pGezKVxnAzbOugB7n/qObCD7iWFA/9KUtk1u5
         p66lE5IZLandQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F2914A0084;
        Thu,  8 Apr 2021 13:41:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9CD784014D;
        Thu,  8 Apr 2021 13:41:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="DSL1AzhU";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZglZI0mrYENjIJaiLlcICwtp7Gp2SP4XrfBiPvtNoo2ezuvmY6ticFg+Ry/J346myJSZHSp2ndax1xMOr6Zp5y+HH1sdT/EMwtsnhcjgQ05W8K6knJdNNnfh8zDolvDLHEYoBhQ9Y6DBV6SmjzF1ywuu4RGZ7jZp2Lrd2b8BWFkO63o/MzlWGVDdg0VS5Piuiph9T8FrjzFInGJEaiWnh185jdk/3YnGkCZTUv9aAbelgihgfWtUNTomHCPCxcq0+kj6iVL9dmPxusaUA/stiERm9dLnv70YOgnPOb8d240eewH04mtE3J611EXFa7Kp5yVg12Zg3u32xrWWVV7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpDvM1K810K4ve6ZTeKjy9gfnPxiWakByWUgGOhZYxg=;
 b=YuKMa5fk8fjNflMFRv9a/VCgigummh6IH8wwRZwItvaSlom0BfyzBz1XWETSmccRb7yCVg1+nJhmyASQY4OKEtS1dwfdf4wWlpGk4zkVHr4kTaCvT3+aFJroOVt5iqJkD6PyRTvx/Doi8nGAg9/D2/Ad4CmGowbmo3w0JUvYpD6pQ0wmG0epycc50YJR0A6VZaQygqDi83sQFvHOKKRD/WdSuZh2eZe2K2GP71ryzFyW18Nh0ZMy5nQCp34w04so7o5JxYePvj17ucBfAdfTWIdkWui2jo4pBZKg8KMORO8XP9pomnB0B8VSfAqfj2jjTGR/xvExIh5dNbI599yLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpDvM1K810K4ve6ZTeKjy9gfnPxiWakByWUgGOhZYxg=;
 b=DSL1AzhUzB0jOf3J4mwdRXxoPHzaql822mQ4t326mG9Dex7+imXCLtueaR23OgnD/NN06h8MhpiRrR/xmJ6F2XRSgVvoj6pwuOhx065GegpX6TuZfdzNpsGTpItBQe19p1xbd/XphEg5CKd2fTAJYUoLXvj87k/S6B4MMBTfTZ0=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 8 Apr
 2021 13:41:05 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 13:41:05 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v3 14/14] usb: dwc2: Add exit partial power down before
 removing driver
Thread-Topic: [PATCH v3 14/14] usb: dwc2: Add exit partial power down before
 removing driver
Thread-Index: AQHXLFwHfRkzNFV1lUylBy75nKKlM6qqoOsA
Date:   Thu, 8 Apr 2021 13:41:05 +0000
Message-ID: <f96eae5d-3210-f071-50cc-2f38104e5ab5@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
 <20210408094615.8AE35A0094@mailhost.synopsys.com>
In-Reply-To: <20210408094615.8AE35A0094@mailhost.synopsys.com>
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
x-ms-office365-filtering-correlation-id: 5177a931-0af6-4d5e-474a-08d8fa93f559
x-ms-traffictypediagnostic: BYAPR12MB4630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB46307FBDBA589A5C1F574115A7749@BYAPR12MB4630.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8v+wGc4Oye9VMld9ZvTvljWb1ntt9/oswgkQMYguSEgm63BSPaG3W/C/Xsrt5RlDEicb8XdffK7pKpeH3fsQF7b0ssnYriTB3Bok4A3cnqyScgu+aLeY5D4K+9EidDVhCXj2rlhek+q+wNINcei9xoxnBoHiL2pVCyrOj3PliSeTeqKS84efakmdQuh4b4cQH/cBTp6t3ROYKYED8iJSmjwH1e2I82Whjt9wVc9wuzj6uvkYxGruQPjgb5F0GXyKkVZdaXS665argOOkGJ/DGUQ20BCxclDz4p0deebfsen+xODmXxE6O+eDXANUMohcHocDDzv1/iGPwb4GEzyuZX9qencj5Zc48fJv0fg0fI5GKqwCi3nX1QNS9myX36Q0TOO/k/CIyHUb2d/l8H6ksn/az6kHLCiZpbPSNqsuj8HV4xUMqMOHtn4+gqv7smXJfbOAdxs4Ab976tQom8M7LPNuThl0RVRVs82MszQVrskKFXb1PX++Jr2/kr0zI1WPGkcuh3ZUHwGfUpJ2i2v1a3AtNOVsJvl59tP6qLu3gvvH0ovmxPTZQr28PmM0USB8FV4KGnJ8wdy/2Pdhg1RMYOOJoswWZeWiYEDyTRw+nJY4swflVopIsoCndhI6Od29laoHvr7v5Ry5MvVSZnlgsVICWGw6TvT8oY+pcrZV99Tue4cQYtuw6MQSwoiVeQTzEJF80wD5LqcSSpuVwPFffQX/qEDoB7KIB5jhtXWokXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(346002)(376002)(6486002)(38100700001)(2616005)(26005)(186003)(91956017)(76116006)(316002)(2906002)(110136005)(71200400001)(36756003)(4326008)(64756008)(66556008)(107886003)(86362001)(66946007)(66446008)(6506007)(53546011)(478600001)(66476007)(6512007)(31696002)(31686004)(83380400001)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aTk5MDgvQ0VqMm5hanFORDdMZmZPampPWUxUQ3hNOHZzdk9Fb200UUt0ZG1E?=
 =?utf-8?B?LzFlekd0Q3JHVEE2RnpWaWhod2JlVVNMeEhMZW9LcE9NVVkxbEI5eVNUZkI0?=
 =?utf-8?B?WGo1cysxaHNxZytaSEYybGZkc3RlM0U4cjRsejB2ZDlxdkt0NDhxV3RweXBX?=
 =?utf-8?B?U2NTbitYYjhtZndjZEttM0tUeU1OMUN6QVpSazgrWkw3SGhiTExsZ2U3NDNi?=
 =?utf-8?B?a1Q3RWlzaHZ0ZXo1VHErMHpmUjlYVFB5S25jTE9vaVNqQU8rT21uenJ0Y0o3?=
 =?utf-8?B?YisydzFBRTNLY0VqVzdMcXRuendnT2tZd0V0VjExSnVXeDNwNkpIVFVqbjhp?=
 =?utf-8?B?WDBaWDFmNFl2cjkva0lpNk5zMUN0SDZMd0ZrRWIrZXpjRUQwNUZ5akpOWlIw?=
 =?utf-8?B?dTFqbHZsRDBZYVdtbXZVVjVMTlh4ZnEwdnVxdkJKbGU2eklTV2RubFpzVXIr?=
 =?utf-8?B?ZmtUUThoUzZsa2MwUkFOOWNRc3VEcVJCUzZreGowMUMxUnFtcFRvNVFkV3JJ?=
 =?utf-8?B?dFhabFpERXZWb0gyOEdPWjhOMnhtOHArOUVYVVk4MnhGalNDT1VydE5IVnU2?=
 =?utf-8?B?NDREbUxUQ0RVa00vSWxlUzgwV1Y5S0dnVzh0WDlzbHVCQUtyOUdMOHdFSTN5?=
 =?utf-8?B?MzdhWlBNSUQ1cHFZRUQySUZ5Rjc2YmpTSU1sUWM5NVhlalcrVHFITGtLQzh0?=
 =?utf-8?B?cG1UblJDS1g4Z1Y3VXRScXVqYVRpanYxMUZ5d2gzN0lCRlFLdmJBeHVlOGd5?=
 =?utf-8?B?TVgxVGFDbHZqWWk2bjZrc2YvanRDUUgyTFNucXZWZWNZeGlCamhIZnRvZ2xa?=
 =?utf-8?B?UENzV3VJcjdlZ04renh6Y3JrbnAvMHN5UzJ3c20yc3BJVFVHbzFKUk5HSjJh?=
 =?utf-8?B?YzlRSnNmbVRjQzdUeVQ2VnBJUUM0Y3o2bkJxc0xhaG56cnpWNDBvak9IRkRx?=
 =?utf-8?B?cUFVcVdhVXZrYSsrWkFjazNDdVczdDVjSmwzcVR5NVJMTHFYbTMwS0R4N1N2?=
 =?utf-8?B?eWNHU2VkMkRMclpuaEc3QTltdWx0b1J3RFBQU2hXemtxeFNRSEowWjlBdWxv?=
 =?utf-8?B?WFdnVjJMeGpNMW84V0IyZWNQMUpTSTdWdS8xUWpzYXBuVTh5T1NQWGQxS0xu?=
 =?utf-8?B?MVZ1ZmY1VWxVUW5IanljQjFBZGl3V3BFQkVyZUhFVUhUb1pCSDY2SVNkUjQ5?=
 =?utf-8?B?V2NPOGlCWnV5SVc2RWZhNHJ2ZUZneDI0QmJpYVZvaEpZK2VqN0MvYmV6RERZ?=
 =?utf-8?B?TXZnaGNzeVpHU0lmOUhhMkhSTWlEUHVBekIvRWxybmpzTm1ucWtUV2YrZWtF?=
 =?utf-8?B?UEZ3RE14ejY5blBwYWVyQkpvb09VYUVmK09lckJzWGVxbSs1TWdQYTRPSExM?=
 =?utf-8?B?eVk3VUFseU83YTJ0clFMQi9uRlFVWjRxbVpZQlNlbFpXRHBnQ0pHOEs4QUZC?=
 =?utf-8?B?WWYyY2VkdEJSV1pDL1FQT2RnTFVPNnVhR1IrVnlMZVUraGtMWkgxK0JzWEJK?=
 =?utf-8?B?bjVHNEVhODF5R0pjM3dINnB3anFQNXpyVDFWOTgrWTViRmtjWUMwZGRrWlY5?=
 =?utf-8?B?K3RoVEFTTjZ1V2JjN2hBTlhON1BhNHdGSjh4VzZGN04vWVVYTWJ2S01Qd216?=
 =?utf-8?B?alRzY09oSUx2QzNNRDF1TXNQaUhTQkNXRDJ2elFuYy9hbVpVVDFHQll2K2FZ?=
 =?utf-8?B?M2tSaFYrZTBjU24rakY2cXRnaW85QVZrZDlKNzNNL0dkcTRPV3NoM3VaMWpN?=
 =?utf-8?Q?vD6dn4pcrk3FcEmNks=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADD39DE0D5AF2D46965CE209DFE89D6D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5177a931-0af6-4d5e-474a-08d8fa93f559
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 13:41:05.5041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LeBMMskrN9gdX3oZluJa67cSBxBd3+fZErL2nLZ6pVTKt0PUxUYHloUiDXo5pUhxr7Lw9QrgqKYTB40WpkflEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzIwMjEgMTo0NiBQTSwgQXJ0dXIgUGV0cm9zeWFuIHdyb3RlOg0KPiBXaGVuIGR3YzIg
Y29yZSBpcyBpbiBwYXJ0aWFsIHBvd2VyIGRvd24gbW9kZQ0KPiBsb2FkaW5nIGRyaXZlciBhZ2Fp
biBjYXVzZXMgZHJpdmVyIGZhaWwuIEJlY2F1c2UgaW4NCj4gdGhhdCBtb2RlIHJlZ2lzdGVycyBh
cmUgbm90IGFjY2Vzc2libGUuDQo+IA0KPiBBZGRlZCBhIGZsb3cgb2YgZXhpdGluZyB0aGUgcGFy
dGlhbCBwb3dlciBkb3duIG1vZGUNCj4gdG8gYXZvaWQgdGhlIGRyaXZlciByZWxvYWQgZmFpbHVy
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFydHVyIFBldHJvc3lhbiA8QXJ0aHVyLlBldHJvc3lh
bkBzeW5vcHN5cy5jb20+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFy
dXR5dW55YW5Ac3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiAgIENoYW5nZXMgaW4gdjM6DQo+ICAg
LSBOb25lDQo+ICAgQ2hhbmdlcyBpbiB2MjoNCj4gICAtIE5vbmUNCj4gDQo+ICAgZHJpdmVycy91
c2IvZHdjMi9wbGF0Zm9ybS5jIHwgMTEgKysrKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzIvcGxhdGZvcm0uYyBiL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYw0KPiBp
bmRleCA1ZjE4YWNhYzc0MDYuLmIyOGI4Y2Q0NTc5OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91
c2IvZHdjMi9wbGF0Zm9ybS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYw0K
PiBAQCAtMzE2LDYgKzMxNiwxNSBAQCBzdGF0aWMgaW50IGR3YzJfbG93bGV2ZWxfaHdfaW5pdChz
dHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgc3RhdGljIGludCBkd2MyX2RyaXZlcl9yZW1v
dmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQ0KPiAgIHsNCj4gICAJc3RydWN0IGR3YzJf
aHNvdGcgKmhzb3RnID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwlpbnQgcmV0ID0g
MDsNCj4gKw0KPiArCS8qIEV4aXQgUGFydGlhbCBQb3dlciBEb3duIHdoZW4gZHJpdmVyIGlzIHJl
bW92ZWQuICovDQo+ICsJaWYgKGhzb3RnLT5pbl9wcGQpIHsNCj4gKwkJcmV0ID0gZHdjMl9leGl0
X3BhcnRpYWxfcG93ZXJfZG93bihoc290ZywgMCwgdHJ1ZSk7DQo+ICsJCWlmIChyZXQpDQo+ICsJ
CQlkZXZfZXJyKGhzb3RnLT5kZXYsDQo+ICsJCQkJImV4aXQgcGFydGlhbF9wb3dlcl9kb3duIGZh
aWxlZFxuIik7DQo+ICsJfQ0KPiAgIA0KPiAgIAlkd2MyX2RlYnVnZnNfZXhpdChoc290Zyk7DQo+
ICAgCWlmIChoc290Zy0+aGNkX2VuYWJsZWQpDQo+IEBAIC0zMzQsNyArMzQzLDcgQEAgc3RhdGlj
IGludCBkd2MyX2RyaXZlcl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQ0KPiAg
IAlyZXNldF9jb250cm9sX2Fzc2VydChoc290Zy0+cmVzZXQpOw0KPiAgIAlyZXNldF9jb250cm9s
X2Fzc2VydChoc290Zy0+cmVzZXRfZWNjKTsNCj4gICANCj4gLQlyZXR1cm4gMDsNCj4gKwlyZXR1
cm4gcmV0Ow0KPiAgIH0NCj4gICANCj4gICAvKioNCj4gDQoNCg==
