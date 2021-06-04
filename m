Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9180B39B96A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFDNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:08:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49239 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhFDNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622811981; x=1654347981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JJK7Zx89/AKtbtaumja5fyEXBdiRA4G6sqGOywwXhFU=;
  b=QOGRq4VZTIr5hghtF4UxZV6p2GrckDtw+I7n4u1wkfsVyv5F9uTt5Yr3
   8xg/K6riDjgIS2KyKRvUFIJSP6F9DabUO/XB30L1aMPIGwWPIAdt28itp
   BcHASxUXW972hyQlJvcuHslfbamocowOMO5YTZfvBj4oJTdfv1ZFd9XTn
   PqZupfKgkh/XaJNdDnWrESn1+XpX45m7k0QxnrleNcmupN012ZsvyPskE
   Yj4B0Ojj0bcX/fKsKfBKL2eV0Wkjw9YVsNY3PPOgIQJUS0bk9fV+kA+42
   MQPzQlkEfeo26Ha5orLp8DnkSaPQeL03ASWpdMEoC73jU7QCxwS+czbir
   A==;
IronPort-SDR: l1PMwliyXmLNHnLZ4Ugw6nx6zxQhjw4tmvSIJ+3Lp3Tj/hLpXZDljw3gJxyoyWnS6jLwZRwxFo
 1g58fcXV3Xe5OfAhkmBOz3LeQeGVa4pXujgqfkxQCurTZ5pWQXVfdV6gA5MUNlZ4j9M1KAHIqM
 nTl+XAN0yEQR1FP7nBVzoDvS/YVdPSWKFGxRPgu9++XlmJdXLTcke8L9lHGIxA5yso040HuKHZ
 V656UPve75zGybgSrdjoJDHqRLnhsIgRAEauw67SUb7FN8RRt0pkV52Wx5oU1cUn9Seozp9w+6
 W20=
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="124093819"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jun 2021 06:06:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 06:06:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 4 Jun 2021 06:06:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfgRmZ9utLqhnsiLR8wkmkZihdB40OjEDG8WJ/R1Cdjqgdo6K3yvaw1gGuihOYTZ3OF782qJNnES7WkzjyFP0g7G1yTPKuMaFCVlFikR0bl/cMa6l+1XUcH8vfIqAV9xV0SOerGpoTAwJgzvGDWkbqGo63T/KGs7miCJKRi/A1KahSuEeTJizoujYqEUwxH7syII8CN3s03gC8RtbZ8L0qCQSRklEtreGRPFA585T3UtVlrac/mhEXO8jiOE8zlSeoOkjaeV8eWsaly2cFVWiRtHywNS50Zw5usFIKzxKsRr7qqNB5t9J86W/ZFm5dNoAnaaYTJYs7X5EHTAUP/Ovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJK7Zx89/AKtbtaumja5fyEXBdiRA4G6sqGOywwXhFU=;
 b=OeZnON6ogMaa0gofk1SYrronS6/aB4lyo4F4WOM9IVVYXI/drvw4ED8O0ZzR8TEaNaRZiTSBOGloyBseL6yto8+nm3IMsT54PO03a7zvAgCTcTplRoT3DGzsJyq6I1l1KowGDDpuUPxFO1Q/EKMzqmzCL5QySKTjQTUTSbH4e2aoYnMWqN+zReAl0UenlUcemwSNWpvGt/nNUqnILlRRLyF3q0hHgrX1eLyd4k+tFsrEKJod60bWACRMnG3dTH6g/tKIzReiUPEEJbwLzBzFxj5MLdV8pT9Mt7vT3b7TME227/KPmhFD5lR1A517eok5ZcLmD6pwy5WX+7CgJe3R+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJK7Zx89/AKtbtaumja5fyEXBdiRA4G6sqGOywwXhFU=;
 b=iKcMDACIZS3JWBoyYpazqYoHENAy6tFSnIZHr4SRJnjjKNnOdoYdmvAq8SqMnfcBKkElExRD1ojdHdiUv3ZZm0nE8u9opjPgESyGjK4uPHmB+h9rrqomfSNMGefrOpGxS9EC1Yip9GqtIdiz9SwK+oi8JR+pm9ukQJ/7FW+BaZw=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Fri, 4 Jun
 2021 13:06:18 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 13:06:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v5 4/5] mtd: spi-nor: otp: simplify length check
Thread-Topic: [PATCH v5 4/5] mtd: spi-nor: otp: simplify length check
Thread-Index: AQHXWUJnwVs2gjeHfkq+jT0cxpWjhw==
Date:   Fri, 4 Jun 2021 13:06:18 +0000
Message-ID: <e613133f-87c8-6374-66ff-1b674990cc90@microchip.com>
References: <20210604100252.9975-1-michael@walle.cc>
 <20210604100252.9975-5-michael@walle.cc>
In-Reply-To: <20210604100252.9975-5-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 205f6bd5-3411-4d9b-6fbe-08d927598ad2
x-ms-traffictypediagnostic: MW3PR11MB4635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46358BF2B915050D47108D19F03B9@MW3PR11MB4635.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S2VkyhpoiO27MQARna6N4wXV3GBmwY5u4J4fbRShGCppoISG0Vvr0dajbijC+uftAqGbHf25APYzxlw/PMcrU6uCuyT8wBGQ+6HeKmX6giPEEj1JmsYZit46syi3xv9J0yr0MlTcH44ZIHpD1AH+7hoI/hAQ6GvFksf9bjznNUKCh2vlRziUEcrWV61AiL6ZozGq/pePUUKeVKT5Z6yugpz5cSuSsYk4naLpWXxBzlkhPA6XHp/IjQr+2+5/DACI6YmLLfPDxc0Ej6NP4OI+jWkMDKfIWa8kjNpcSmXDVhGh9RR6bX+tfWCYUlit9XAPKqg9ZShjsCsHurCXb7bPWlGcmTBXV71/T0vjDydQ7Fmp/jb1Ea6dnLucb0/k7BkNAfk9gXEOQU1ylcZR2n17gzyNIxCQp6HFsOfxdhKvvhoYSJg7BGMESVCGUDSWI92qnN3BqSklSTFzlP4sad9gg6ak0K05pEb0G6hya+a4rcBhvcM+FUppn1HC0tLEndzD0TbYYYFvHwH645d3jP3TzZ83t1dGaM8fqmhVMYxZfU53XR8EOtSJzd1aof1CJVVtrs3TCtxo/fEX5SsVc6z8kPToV706jpKw6MEMwsZRpc07rZQ+8+DZR4icqbKS5bDkyJ273H7ByZsyHPzC5PJMgHXxUMSi1GttvWLCqM7Mror1n7/EqtL0v63eXlNaJ9j9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(346002)(39850400004)(4326008)(38100700002)(478600001)(6486002)(31696002)(122000001)(71200400001)(2906002)(6512007)(8936002)(83380400001)(8676002)(31686004)(66556008)(6506007)(36756003)(5660300002)(66446008)(64756008)(76116006)(26005)(186003)(91956017)(66476007)(53546011)(66946007)(2616005)(86362001)(316002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WFAxcXlaUVJnMzV3Q0VoUUtWb2VHanA3aEpHNFhuTndQbkdjdzIrenhiV1JD?=
 =?utf-8?B?eUR5TjJPMFRpd1dCd3dYeWZoTFg0VzJhaXU1a0lxWFZmOE5ReGNrbERoa0o3?=
 =?utf-8?B?ZmtKSXhqVnVQcUtQN1FIbHJmZjRSTnBuUnlaT3lnRlRzc0FBbW9WQUVIR0t0?=
 =?utf-8?B?WCtwa2VRcnErUEdsQ3hYK2d0NnZEYUdXcmg3VkU1WTZvNDRSbVRHQUhVN3VM?=
 =?utf-8?B?TjN2UGpsSzQzbVhnYThML2hzUENub2FtVHEyM0xRbnR1R2wvdldQUU1GbWNN?=
 =?utf-8?B?WlNuV0tEbCtUVXlGTG5PNXNNN2x2ZkN3WWlGUHdMZGRFQ0tBVFBxT3VvUVgv?=
 =?utf-8?B?SkFURkJUekJ1MzdCZEtCV0t3WUdHVWdrc2hTYWVsZFB0NU1Gd1Q1QjZXR0ZZ?=
 =?utf-8?B?azlucUZvdWl0VC9vaEh3NklVQXBHVTNmNnRhK1FDczNjOWZDOU8va2R4OUF4?=
 =?utf-8?B?TDBaL2NkS2RiMmpRSzY0QXAvOWluRENVdzcvWnNyNG83MWFIeDdtTTNRM0NS?=
 =?utf-8?B?a1lMN2o0V2N6djUwV0dheTlvRnpFMFVEcnZzNDlxM0l1K01SOVFGNjZuU1dQ?=
 =?utf-8?B?Um5kTXUycVhGcDFjS0FDZldURXJJL2drVHlWRENER3NMSG1BMmVYM0JjK1hI?=
 =?utf-8?B?dnZIRWduUm9MVjlLV2hiR3Qrd1gxS2h1Q25JVXIvVkFVRHNkU1Bnc0R6cFVq?=
 =?utf-8?B?aFNPZk8xUVl2d2hzUFJ1bEtxZCt5UmhtbUJRcEtmRWV6NTUwVXJucC9RTFZZ?=
 =?utf-8?B?S2MwZFN3MnYydHBDZFRSVHlyV3lrRXRIVDR3YmNEWEprSWtBK2s1WHphS2hE?=
 =?utf-8?B?aXltVUQ5emU5Qkh4WThDaWYyUk9ERWFtZVkvTWNsMjBHajJCc1NDbEM0Y1Q1?=
 =?utf-8?B?RWtWaVE5R211eDVMYmtBMEIvcWswUy91Wmg3S3ViR0UxM2JPVTZBSkY0RmdE?=
 =?utf-8?B?SDZnY1o0MnFxVzVZY1pNM1F6MFNrMnhGbWhwUk11cTZaL0psZlFVak5VMXZY?=
 =?utf-8?B?RDNZdGM0TXY3dWk4WjJYZWJlNG1RYU1zbHVRdTZBNzVPMmJtdEpUaUdDd2oy?=
 =?utf-8?B?UHRTWXlNVUJHOWphaGJsZHAxTDFEazNieU05M29kdk1mRWhNc0ZxWk1idHVE?=
 =?utf-8?B?ZlpKb0FBdWZLY0NYMTYycElZYS9wNWZDV0k2SC8xdmdTaW8zbjREZVUzNWFr?=
 =?utf-8?B?WXhlZXdRRXY4YjhuV252NkVNa1p2c0JZRHlTUVZrY0lJZ0xZWjZibU4wQmli?=
 =?utf-8?B?MnhHMmw5OFhVRC9SN2ZXNjk1OG5Va29qVWxKUktzaHRuTnZ5bmFMcFFKRkN5?=
 =?utf-8?B?aGN1K2RpSUNSQzBBN21wamM1OEVFejZQVnBRTE11TDFtRS9lWjZBc2c2b09m?=
 =?utf-8?B?dkNYUkx0MndFMXBWblU2WmxSV0wrQ0ptWldUK24xRmRzN3ZMb2N3OEhTSmxz?=
 =?utf-8?B?MDBya3pKK2tYbDN6U1hOaDlmUytYUHdBUmdPclFIOGZQZkkvajZZVW00NUxZ?=
 =?utf-8?B?ajV3S3dXNzloZjNDcmVlRjQ2T09UYzRXeE0vSDBBRHoydm90OWdUT1Z0b0Yx?=
 =?utf-8?B?ZkQ0VHlueDQyUUZZdVUvQXV2amhQamRoeFVaeXJ0NWYxdlRUUVVLWlNOMEVE?=
 =?utf-8?B?M3hYVDdSSHNrSE5PYnpmY2pBSE1VUnRrZzlMTVNBbGtBdXBoSWMzRS91VjRl?=
 =?utf-8?B?NW5JczJ1L2dNY1FWL3NSbjZNTlBvZ2FNRFU0bHFFaGlTczFRVEN4T21Zbkxm?=
 =?utf-8?Q?02i7yjkr+JU00EyRSI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB54E8BCD44EB241B6F6350557A58A98@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205f6bd5-3411-4d9b-6fbe-08d927598ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 13:06:18.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EooCB0Cayx3f0bFnnT4qS7ZIAa7cYTm8vNzBfggkI9/mKbc5ApvkS1DG+iBHNZilqn6P7BVVB7L2cn05FXvKaYj+ULRRsgd3wzZ2xouGRHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi80LzIxIDE6MDIgUE0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQnkgbW92aW5nIHRoZSBjb2RlIGFyb3VuZCBhIGJp
dCwgd2UgY2FuIGp1c3QgY2hlY2sgdGhlIGxlbmd0aCBiZWZvcmUNCj4gY2FsbGluZyBzcGlfbm9y
X210ZF9vdHBfcmFuZ2VfaXNfbG9ja2VkKCkgYW5kIGRyb3AgdGhlIGxlbmd0aCBjaGVjaw0KPiB0
aGVyZS4gVGhpcyB3YXkgd2UgZG9uJ3QgbmVlZCB0byB0YWtlIHRoZSBsb2NrLiBUaGlzIHdpbGwg
YWxzbyBza2lwIHRoZQ0KPiAiKnJldGxlbiA9IDAiIGFzc2lnbm1lbnQgaWYgdGhlIGxlbmd0aCBp
cyB6ZXJvLiBCdXQgbXRkY29yZSBhbHJlYWR5IGRvZXMNCj4gdGhhdCBmb3IgdXMuIFRodXMgd2Ug
Y2FuIGRyb3AgdGhhdCwgdG9vLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8
bWljaGFlbEB3YWxsZS5jYz4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL290cC5jIHwg
MTMgKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL290cC5j
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9vdHAuYw0KPiBpbmRleCAwNjNmOGZiNjg2NDkuLjg5ZmU1
MmUzODUxYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9vdHAuYw0KPiArKysg
Yi9kcml2ZXJzL210ZC9zcGktbm9yL290cC5jDQo+IEBAIC0yNTYsOSArMjU2LDYgQEAgc3RhdGlj
IGludCBzcGlfbm9yX210ZF9vdHBfcmFuZ2VfaXNfbG9ja2VkKHN0cnVjdCBzcGlfbm9yICpub3Is
IGxvZmZfdCBvZnMsDQo+ICAgICAgICAgdW5zaWduZWQgaW50IHJlZ2lvbjsNCj4gICAgICAgICBp
bnQgbG9ja2VkOw0KPiANCj4gLSAgICAgICBpZiAoIWxlbikNCj4gLSAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KDQp0aGVzZSBsaW5lcyB3ZXJlIGp1c3QgaW50cm9kdWNlZCBpbiB0aGUgcHJldmlv
dXMgcGF0Y2guIENhbiB5b3UgcGxlYXNlIHJlb3JkZXIgNCB3aXRoIDMsDQpzbyB0aGF0IHdlIGRv
bid0IHRvdWNoIHRoaXMgdHdpY2U/IFdpdGggdGhhdDoNCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFt
YmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtDQo+ICAgICAgICAgLyoN
Cj4gICAgICAgICAgKiBJZiBhbnkgb2YgdGhlIGFmZmVjdGVkIE9UUCByZWdpb25zIGFyZSBsb2Nr
ZWQgdGhlIGVudGlyZSByYW5nZSBpcw0KPiAgICAgICAgICAqIGNvbnNpZGVyZWQgbG9ja2VkLg0K
PiBAQCAtMjkwLDEzICsyODcsMTYgQEAgc3RhdGljIGludCBzcGlfbm9yX210ZF9vdHBfcmVhZF93
cml0ZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgbG9mZl90IG9mcywNCj4gICAgICAgICBpZiAob2Zz
IDwgMCB8fCBvZnMgPj0gc3BpX25vcl9vdHBfc2l6ZShub3IpKQ0KPiAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7DQo+IA0KPiArICAgICAgIC8qIGRvbid0IGFjY2VzcyBiZXlvbmQgdGhlIGVuZCAq
Lw0KPiArICAgICAgIHRvdGFsX2xlbiA9IG1pbl90KHNpemVfdCwgdG90YWxfbGVuLCBzcGlfbm9y
X290cF9zaXplKG5vcikgLSBvZnMpOw0KPiArDQo+ICsgICAgICAgaWYgKCF0b3RhbF9sZW4pDQo+
ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAgICAgICAgIHJldCA9IHNwaV9ub3Jf
bG9ja19hbmRfcHJlcChub3IpOw0KPiAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiANCj4gLSAgICAgICAvKiBkb24ndCBhY2Nlc3MgYmV5b25kIHRoZSBl
bmQgKi8NCj4gLSAgICAgICB0b3RhbF9sZW4gPSBtaW5fdChzaXplX3QsIHRvdGFsX2xlbiwgc3Bp
X25vcl9vdHBfc2l6ZShub3IpIC0gb2ZzKTsNCj4gLQ0KPiAgICAgICAgIGlmIChpc193cml0ZSkg
ew0KPiAgICAgICAgICAgICAgICAgcmV0ID0gc3BpX25vcl9tdGRfb3RwX3JhbmdlX2lzX2xvY2tl
ZChub3IsIG9mcywgdG90YWxfbGVuKTsNCj4gICAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7
DQo+IEBAIC0zMDcsNyArMzA3LDYgQEAgc3RhdGljIGludCBzcGlfbm9yX210ZF9vdHBfcmVhZF93
cml0ZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgbG9mZl90IG9mcywNCj4gICAgICAgICAgICAgICAg
IH0NCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAgICpyZXRsZW4gPSAwOw0KPiAgICAgICAgIHdo
aWxlICh0b3RhbF9sZW4pIHsNCj4gICAgICAgICAgICAgICAgIC8qDQo+ICAgICAgICAgICAgICAg
ICAgKiBUaGUgT1RQIHJlZ2lvbnMgYXJlIG1hcHBlZCBpbnRvIGEgY29udGlndW91cyBhcmVhIHN0
YXJ0aW5nDQo+IC0tDQo+IDIuMjAuMQ0KPiANCg0K
