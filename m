Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001723584E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhDHNkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:40:05 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45538 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231652AbhDHNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:40:01 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8C164C09C2;
        Thu,  8 Apr 2021 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617889189; bh=dFRb/Vp7QGDNtIq++eG+CZva8daaB+xH82/RH8gx6mQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aMrxboUrqnEOBGslalI7pmcmm3AC6eJ10hKb63gwmWKm2zYi6LoTeS7kKqIfnybwR
         Kglr6oFm61aNOMvOsOymCL4o9YfmKeX+5Pcm9dBiU4B0LKjGH2mS5CcX4aFmat7KQX
         l3THgaECgHOpGZVPCK4HFaWbf1xhKNa35+sWKNuL0Zrnr4tFP7rpHsg4gAp2amfRwM
         ItlgpdZsYH9VryZjnNiRd8cETsIGseETGg4C1rYgRHCQeNiDV0ms8zRn89XXWZM2Pb
         Sch+6Il6KGhDmdrdDurMVFuR6H5ERGYbl9oA+GnWyjs4dGBAUTHHi61qDJ7HqM3V3n
         bRB00F1Lcmo/g==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 28F62A006A;
        Thu,  8 Apr 2021 13:39:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5B02B400C0;
        Thu,  8 Apr 2021 13:39:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="glt9BDHo";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtv8qY/RwFtpUNABZVi4nVJAzgCVzH3l5eL4RFvBbbrl/9blSbxhep+zE43h36MrtINaHFFQmMYbmbX6c+qQyainoJA5l8mVK7ACOz37o8EkOnk/mHmvfotX1oPS1p3A/uNB6xPkKaGINvCmla/gF+UL+cSnSiOymEyi5Q/iDF2uZ7+oprbUUcQzp0LCw0+GtaviXfW5NO8z3pNC8RLEqJ5y8edUZp3bnPLOuhnksVX6qIvNoapfytt8np05BiWzYW+mWRnDF1X6FoAjQMSDYNSkL5F59yhbRTy/Jl/LLkT7IJ96ROI/QfV6ZBej3jQ13g3qcUDyGf33VS9Bnp7bmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFRb/Vp7QGDNtIq++eG+CZva8daaB+xH82/RH8gx6mQ=;
 b=QdxttfAIasj3S+wt9BTT+IzcaxO+DQ6OrnrLW8tLHDtdcq8AZSkc1qspILhm8BvnBfnkSNYGLBpRBP0oE3BzlSudNxRkGCRW/gG12d+PiTwQ9blHhzjOMltnv4LI9+qhl/puzamdJtB46DyxuTTijrpjBFmtWQgIW5dCcZ7y4cNo1rMa2ZoxGjVxjglrj0GdXIryU1F945nAOcjVdROwL4vBgL78G7ANo5Xqx+cRw89Jdv06X+TfGzr/KsGEbv0VdO+i2iUTtdB5odn1TbKU6Yn5mMN7Ngn4xxgJI5b84mIdGKr2v89pVPw+1cVBBYK1+L75nCSfmYufmy0YpL0Tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFRb/Vp7QGDNtIq++eG+CZva8daaB+xH82/RH8gx6mQ=;
 b=glt9BDHo/7JSkrDBXzqgwNVMagbN56qdDEZzq3b5Th4vzUirqTck7cBwv9VdF1MffbOl2XuQRG4VOgaPZI+vLL3FuX+omod+A3EbFLDpK4eHz2dNVRGSY71eNig5K/PZCsFBKo92YPjCZL+DwD3i/J3lDp2Wma5sJ87S1PoSz/Y=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BYAPR12MB2965.namprd12.prod.outlook.com (2603:10b6:a03:ae::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 13:39:46 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 13:39:46 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v3 07/14] usb: dwc2: Add exit partial power down when port
 is resumed
Thread-Topic: [PATCH v3 07/14] usb: dwc2: Add exit partial power down when
 port is resumed
Thread-Index: AQHXLFvlMSUojUhyB0yskNyUDjZNiaqqoI2A
Date:   Thu, 8 Apr 2021 13:39:46 +0000
Message-ID: <729e551c-ce40-e069-38c3-7f2505943c6e@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
 <20210408094518.6DA1DA022E@mailhost.synopsys.com>
In-Reply-To: <20210408094518.6DA1DA022E@mailhost.synopsys.com>
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
x-ms-office365-filtering-correlation-id: bf933214-ca13-4783-ace0-08d8fa93c636
x-ms-traffictypediagnostic: BYAPR12MB2965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2965AEB68EB5A1FA03E101E8A7749@BYAPR12MB2965.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62Zyn5mH9fSFpAfi1k92MUlp2XrOOv40FJx9IcXzdinR6rWIKPyRF8pM1jZqIc08B0WSmt0Vp3QKr7+nWfvzElvsJUqB5tAEVYqn1ROubPdnqwGYv01+UdrrymKH2lmP5C0i36zPGRyVYZY0CusiyfrPj4vp3DHFHAhdmMPuXEE07GYZ/8n70Aabr2fd7jvfr31xmGRVHUCGayBo1RNTo2heSkRaFn9SWjy1CeLaiqNu9iPsdvcXIBNHGC0v6lT1f14o1TlgzpurB/2sBlOkTJwVRyjVqv5y9238JPHPUyJLLUmjUWfr0Zemk3IG1VgQMyWx+EWJyqyEgg/BkI+2x74msR6DSejj3/d+L6xyNJZtFEw+SEnC58/+q7TaBbQrg/Hpq0GaTpyPYGqhfH22zINaOYoXW0LNU7F9XpNC+JCsyDJRuQMYTjbMuE6AVKzI0VAfLOm+r/gE9xGCTSYO2E0E85MjWT6Z2HrAg7tvt7/V+Z3DGG2Nid0Cmr327W7Yt17RSPAfm0Yznun63R76UTPxBsveLNDfyJbjg2d6SFmSTR5FPxen7Td3KjSp3ecyw19+DRqweeg4YGVD0k4zl/fRkKaIT61gClQ1+svyKSYHXhfscUjVPEMZv1R0d1KgKlrynd+pmAwj+VYn0kmvUklrTvc5LRVATulbHALgSL0ogtEx9pEYtLwz931+ko5WTpdcOOIPwvzbYW7f+/l7CRdI6NyvlFePZifP6GVpQ2A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(39860400002)(346002)(478600001)(83380400001)(8936002)(36756003)(6512007)(8676002)(38100700001)(5660300002)(71200400001)(66476007)(64756008)(4326008)(6486002)(91956017)(66946007)(107886003)(316002)(76116006)(186003)(53546011)(86362001)(31696002)(6506007)(110136005)(31686004)(2616005)(2906002)(66556008)(66446008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d01OM0o4MGs0VE9yNG9GakdXNjc1Snh4Z1VxM1J6WGlJa3NacmVJd1E4c2t4?=
 =?utf-8?B?bUd1cWpoemZ0Q2luK1ovbTVIbGNNLzZyUWN4QlBYN0xqM2JOSkdrZ1JWdWZr?=
 =?utf-8?B?MmNFaGIzck5wSEtKbkF4WDJ4cXRWM1k5MHFNSnlDMnJRaWtwMlBlVENwK3Zj?=
 =?utf-8?B?aVA1aFh3Z0RHY2hXNFZCd25qL051S0twOHAzK01IZkxLU2pNeG8xeUpQQWVF?=
 =?utf-8?B?TWVBV2hwQ1hSdS9kUnRGMVJTSU0vY2FFbVFDbTJnRWVNcVBsS2VVTHVEbVZO?=
 =?utf-8?B?MDhjWU1KVzl2T1BYak56Y3dwVzhlRFdhdXdITzQwMzU1NFZ6eTVCL2dmMjJQ?=
 =?utf-8?B?WFYwVjM2Lzg2TFZrUlJEVGhJUDJtOHRRTllTblQwV24veGRycU15M3hERTNS?=
 =?utf-8?B?Z05EM2w1bkQrMWJyZTBONXRuZHM4RlhueGtXUTY4Y3M1cklXclFKeVNGUmRR?=
 =?utf-8?B?dDFjTU9wb1Y0NlcwN1Z5ZUp0MzErNktXZnpRUmpTY3FSUTRTc3lYRTVmczFj?=
 =?utf-8?B?NHNISks1RHpWQWpmVTRUaDZXcHVWT2tMbFExM1RYZnM5U0ljRUc0U1BlRU1B?=
 =?utf-8?B?VG1ab2wzSVg0dFc0bW80K1hDYi9SdkRQVEwwWlI5Q0pyakJsSHpaRW8ycHBw?=
 =?utf-8?B?OHJibTg0eXJBNHJXQjZlV3FPMzgwZ0tTWHlUM09nQnNpTEI1VlQ1SVBBSzZj?=
 =?utf-8?B?Rll6bFlLeHJoWFIvWUtkRXVpR21CUmN3aVJyZFRKcUhzRGtQSmQ0OEJ2cEFs?=
 =?utf-8?B?YnFERUl5MERuQm52QitUWVBOY3VKUGh0ZFVOYXJZUTRXQWFkNkcvRXppZGNW?=
 =?utf-8?B?TEZPTTRuWXk2N1orM3lublVrRjAyZjFxaFhQQzlaMk1UYmFiZGpnWmw2Mnpj?=
 =?utf-8?B?eUZmZFFIdWNGVXl4UXNodWxXTTlDb1doemNnRnhiTDdSMXdXakcyNVlLS01C?=
 =?utf-8?B?TWRLdE9TMkp3MUg0Yi9WenFSWmdITjZMVFplYy93TnFXNTlYRGsxUUFMZVBG?=
 =?utf-8?B?RGE0bVo1VHdEQ084SGhZbmVzT1JIOUFsUzAvbWxjMXorRWFnUWN5NHBpM2dI?=
 =?utf-8?B?NmRNc04vS1BOQnA4Yy8zZkpVR3BlM0JQVVRHYTVQTUJLRmk1UVpiQjNQOUxh?=
 =?utf-8?B?V0lETFoxOUxYdGdlL0RhNnZQWGN4OUYwaXlCYmRONENMV2tQd3A5a1kxYVgw?=
 =?utf-8?B?VWRoWmo2NUl5eEJSdVQvVERocUZkcU5SYVBtN2MwNkU2SGM3clNscVdpTTNj?=
 =?utf-8?B?UGhXd0UycEhrcXdsLzBjYmNQOUpld2JZRGpwbzNOSk1mU25vWTRyYUZ3Sitm?=
 =?utf-8?B?RE9VTHVEN3Z5ZmFtOFZXb2xGOTZCYlNRR3pQZTltYUNLWXdOT3BCN2Q4c1h1?=
 =?utf-8?B?OEUxWDhUd0xiazBNcUdJOVVodE8zbmZMTDIrREpOckdFRW1ESEgwNklaaG9N?=
 =?utf-8?B?MUZIbmhSajhHSXFrRnZjaG1ScFBjRUtlSzN2Y2hJNkJTRHRzZmZSUXNUaFkx?=
 =?utf-8?B?OUpoTmNoSW84c1FzRmVNZVBGNFl6MFpOY1l5a2FSR2p2VDUvemJTaHRmYkxw?=
 =?utf-8?B?dmgwUktobjdaWjI1cFVFNlJVQzEyYi9QOE9PNU9iSGpsV2pNcGZqNTQ1RkN3?=
 =?utf-8?B?dEwyUmtWa0t5NXo1dU1JQUtvenFuUW9KZVdhUVp0ZStUOTB5VXJYRXRSc3dV?=
 =?utf-8?B?VTlRaVRQRG5hMVlJcERRRHZ6dDBzN1hhUHJQRE9FbG1kZ0Y5SlBpZXdHWVlL?=
 =?utf-8?Q?ts+KYzG+MYCijZHRtQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D3148109580994CAB85907E2A358802@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf933214-ca13-4783-ace0-08d8fa93c636
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 13:39:46.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbKALFYpFwYKikMVP3He97o4BTy57xh2xIIIt9OW+Cgi91peGF0uwPt6AF3G2S6b3EWfyvjzWaHr0znM3pq1Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzIwMjEgMTo0NSBQTSwgQXJ0dXIgUGV0cm9zeWFuIHdyb3RlOg0KPiBBZGRlZCBmbG93
IG9mIGV4aXRpbmcgUGFydGlhbCBQb3dlciBEb3duIGluDQo+ICJkd2MyX3BvcnRfcmVzdW1lKCki
IGZ1bmN0aW9uIHdoZW4gY29yZSByZWNlaXZlcyByZXN1bWUuDQo+IA0KPiBOT1RFOiBTd2l0Y2gg
Y2FzZSBzdGF0ZW1lbnQgaXMgdXNlZCBmb3IgaGliZXJuYXRpb24gcGFydGlhbA0KPiBwb3dlciBk
b3duIGFuZCBjbG9jayBnYXRpbmcgbW9kZSBkZXRlcm1pbmF0aW9uLiBJbiB0aGlzIHBhdGNoDQo+
IG9ubHkgUGFydGlhbCBQb3dlciBEb3duIGlzIGltcGxlbWVudGVkIHRoZSBIaWJlcm5hdGlvbiBh
bmQNCj4gY2xvY2sgZ2F0aW5nIGltcGxlbWVudGF0aW9ucyBhcmUgcGxhbm5lZCB0byBiZSBhZGRl
ZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFydHVyIFBldHJvc3lhbiA8QXJ0aHVyLlBldHJvc3lh
bkBzeW5vcHN5cy5jb20+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFy
dXR5dW55YW5Ac3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiAgIENoYW5nZXMgaW4gdjM6DQo+ICAg
LSBOb25lDQo+ICAgQ2hhbmdlcyBpbiB2MjoNCj4gICAtIE5vbmUNCj4gDQo+ICAgZHJpdmVycy91
c2IvZHdjMi9jb3JlLmggfCAgNSArKy0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9oY2QuYyAgfCA2
MSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMi9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuaA0K
PiBpbmRleCA3NjgwN2FiZDc1M2IuLjVhNzg1MDQ4MmU1NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMi9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9jb3JlLmgNCj4gQEAg
LTE0NzEsNyArMTQ3MSw3IEBAIHZvaWQgZHdjMl9oY2RfZGlzY29ubmVjdChzdHJ1Y3QgZHdjMl9o
c290ZyAqaHNvdGcsIGJvb2wgZm9yY2UpOw0KPiAgIHZvaWQgZHdjMl9oY2Rfc3RhcnQoc3RydWN0
IGR3YzJfaHNvdGcgKmhzb3RnKTsNCj4gICBpbnQgZHdjMl9jb3JlX2luaXQoc3RydWN0IGR3YzJf
aHNvdGcgKmhzb3RnLCBib29sIGluaXRpYWxfc2V0dXApOw0KPiAgIGludCBkd2MyX3BvcnRfc3Vz
cGVuZChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIHUxNiB3aW5kZXgpOw0KPiAtdm9pZCBkd2My
X3BvcnRfcmVzdW1lKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zyk7DQo+ICtpbnQgZHdjMl9wb3J0
X3Jlc3VtZShzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpOw0KPiAgIGludCBkd2MyX2JhY2t1cF9o
b3N0X3JlZ2lzdGVycyhzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpOw0KPiAgIGludCBkd2MyX3Jl
c3RvcmVfaG9zdF9yZWdpc3RlcnMoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKTsNCj4gICBpbnQg
ZHdjMl9ob3N0X2VudGVyX2hpYmVybmF0aW9uKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zyk7DQo+
IEBAIC0xNDk3LDcgKzE0OTcsOCBAQCBzdGF0aWMgaW5saW5lIGludCBkd2MyX2NvcmVfaW5pdChz
dHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIGJvb2wgaW5pdGlhbF9zZXR1cCkNCj4gICB7IHJldHVy
biAwOyB9DQo+ICAgc3RhdGljIGlubGluZSBpbnQgZHdjMl9wb3J0X3N1c3BlbmQoc3RydWN0IGR3
YzJfaHNvdGcgKmhzb3RnLCB1MTYgd2luZGV4KQ0KPiAgIHsgcmV0dXJuIDA7IH0NCj4gLXN0YXRp
YyBpbmxpbmUgdm9pZCBkd2MyX3BvcnRfcmVzdW1lKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zykg
e30NCj4gK3N0YXRpYyBpbmxpbmUgaW50IGR3YzJfcG9ydF9yZXN1bWUoc3RydWN0IGR3YzJfaHNv
dGcgKmhzb3RnKQ0KPiAreyByZXR1cm4gMDsgfQ0KPiAgIHN0YXRpYyBpbmxpbmUgaW50IGR3YzJf
aGNkX2luaXQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIHsgcmV0dXJuIDA7IH0NCj4g
ICBzdGF0aWMgaW5saW5lIGludCBkd2MyX2JhY2t1cF9ob3N0X3JlZ2lzdGVycyhzdHJ1Y3QgZHdj
Ml9oc290ZyAqaHNvdGcpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jIGIv
ZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBpbmRleCBlN2ZiMGQ1OTQwYmMuLjcyMDM1NGRmMDE0
YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MyL2hjZC5jDQo+IEBAIC0zMzUzLDQ0ICszMzUzLDYxIEBAIGludCBkd2MyX3BvcnRf
c3VzcGVuZChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIHUxNiB3aW5kZXgpDQo+ICAgICoNCj4g
ICAgKiBAaHNvdGc6IFByb2dyYW1taW5nIHZpZXcgb2YgdGhlIERXQ19vdGcgY29udHJvbGxlcg0K
PiAgICAqDQo+ICsgKiBSZXR1cm46IG5vbi16ZXJvIGlmIGZhaWxlZCB0byBleGl0IHN1c3BlbmQg
bW9kZSBmb3IgaG9zdC4NCj4gKyAqDQo+ICAgICogVGhpcyBmdW5jdGlvbiBpcyBmb3IgZXhpdGlu
ZyBIb3N0IG1vZGUgc3VzcGVuZC4NCj4gICAgKiBNdXN0IE5PVCBiZSBjYWxsZWQgd2l0aCBpbnRl
cnJ1cHQgZGlzYWJsZWQgb3Igc3BpbmxvY2sgaGVsZC4NCj4gICAgKi8NCj4gLXZvaWQgZHdjMl9w
b3J0X3Jlc3VtZShzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICtpbnQgZHdjMl9wb3J0X3Jl
c3VtZShzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgew0KPiAgIAl1bnNpZ25lZCBsb25n
IGZsYWdzOw0KPiAgIAl1MzIgaHBydDA7DQo+ICAgCXUzMiBwY2djdGw7DQo+ICsJaW50IHJldCA9
IDA7DQo+ICAgDQo+ICAgCXNwaW5fbG9ja19pcnFzYXZlKCZoc290Zy0+bG9jaywgZmxhZ3MpOw0K
PiAgIA0KPiAtCS8qDQo+IC0JICogSWYgcG93ZXJfZG93biBpcyBzdXBwb3J0ZWQsIFBoeSBjbG9j
ayBpcyBhbHJlYWR5IHJlc3VtZWQNCj4gLQkgKiBhZnRlciByZWdpc3RlcnMgcmVzdG9yZS4NCj4g
LQkgKi8NCj4gLQlpZiAoIWhzb3RnLT5wYXJhbXMucG93ZXJfZG93bikgew0KPiAtCQlwY2djdGwg
PSBkd2MyX3JlYWRsKGhzb3RnLCBQQ0dDVEwpOw0KPiAtCQlwY2djdGwgJj0gflBDR0NUTF9TVE9Q
UENMSzsNCj4gLQkJZHdjMl93cml0ZWwoaHNvdGcsIHBjZ2N0bCwgUENHQ1RMKTsNCj4gKwlzd2l0
Y2ggKGhzb3RnLT5wYXJhbXMucG93ZXJfZG93bikgew0KPiArCWNhc2UgRFdDMl9QT1dFUl9ET1dO
X1BBUkFNX1BBUlRJQUw6DQo+ICsJCXJldCA9IGR3YzJfZXhpdF9wYXJ0aWFsX3Bvd2VyX2Rvd24o
aHNvdGcsIDAsIHRydWUpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJZGV2X2Vycihoc290Zy0+ZGV2
LA0KPiArCQkJCSJleGl0IHBhcnRpYWxfcG93ZXJfZG93biBmYWlsZWQuXG4iKTsNCj4gKwkJYnJl
YWs7DQo+ICsJY2FzZSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fSElCRVJOQVRJT046DQo+ICsJY2Fz
ZSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fTk9ORToNCj4gKwlkZWZhdWx0Og0KPiArCQkvKg0KPiAr
CQkgKiBJZiBwb3dlcl9kb3duIGlzIHN1cHBvcnRlZCwgUGh5IGNsb2NrIGlzIGFscmVhZHkgcmVz
dW1lZA0KPiArCQkgKiBhZnRlciByZWdpc3RlcnMgcmVzdG9yZS4NCj4gKwkJICovDQo+ICsJCWlm
ICghaHNvdGctPnBhcmFtcy5wb3dlcl9kb3duKSB7DQo+ICsJCQlwY2djdGwgPSBkd2MyX3JlYWRs
KGhzb3RnLCBQQ0dDVEwpOw0KPiArCQkJcGNnY3RsICY9IH5QQ0dDVExfU1RPUFBDTEs7DQo+ICsJ
CQlkd2MyX3dyaXRlbChoc290ZywgcGNnY3RsLCBQQ0dDVEwpOw0KPiArCQkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmaHNvdGctPmxvY2ssIGZsYWdzKTsNCj4gKwkJCW1zbGVlcCgyMCk7DQo+ICsJ
CQlzcGluX2xvY2tfaXJxc2F2ZSgmaHNvdGctPmxvY2ssIGZsYWdzKTsNCj4gKwkJfQ0KPiArDQo+
ICsJCWhwcnQwID0gZHdjMl9yZWFkX2hwcnQwKGhzb3RnKTsNCj4gKwkJaHBydDAgfD0gSFBSVDBf
UkVTOw0KPiArCQlocHJ0MCAmPSB+SFBSVDBfU1VTUDsNCj4gKwkJZHdjMl93cml0ZWwoaHNvdGcs
IGhwcnQwLCBIUFJUMCk7DQo+ICAgCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoc290Zy0+bG9j
aywgZmxhZ3MpOw0KPiAtCQltc2xlZXAoMjApOw0KPiArDQo+ICsJCW1zbGVlcChVU0JfUkVTVU1F
X1RJTUVPVVQpOw0KPiArDQo+ICAgCQlzcGluX2xvY2tfaXJxc2F2ZSgmaHNvdGctPmxvY2ssIGZs
YWdzKTsNCj4gKwkJaHBydDAgPSBkd2MyX3JlYWRfaHBydDAoaHNvdGcpOw0KPiArCQlocHJ0MCAm
PSB+KEhQUlQwX1JFUyB8IEhQUlQwX1NVU1ApOw0KPiArCQlkd2MyX3dyaXRlbChoc290ZywgaHBy
dDAsIEhQUlQwKTsNCj4gKwkJaHNvdGctPmJ1c19zdXNwZW5kZWQgPSBmYWxzZTsNCj4gICAJfQ0K
PiAgIA0KPiAtCWhwcnQwID0gZHdjMl9yZWFkX2hwcnQwKGhzb3RnKTsNCj4gLQlocHJ0MCB8PSBI
UFJUMF9SRVM7DQo+IC0JaHBydDAgJj0gfkhQUlQwX1NVU1A7DQo+IC0JZHdjMl93cml0ZWwoaHNv
dGcsIGhwcnQwLCBIUFJUMCk7DQo+ICAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmhzb3RnLT5s
b2NrLCBmbGFncyk7DQo+ICAgDQo+IC0JbXNsZWVwKFVTQl9SRVNVTUVfVElNRU9VVCk7DQo+IC0N
Cj4gLQlzcGluX2xvY2tfaXJxc2F2ZSgmaHNvdGctPmxvY2ssIGZsYWdzKTsNCj4gLQlocHJ0MCA9
IGR3YzJfcmVhZF9ocHJ0MChoc290Zyk7DQo+IC0JaHBydDAgJj0gfihIUFJUMF9SRVMgfCBIUFJU
MF9TVVNQKTsNCj4gLQlkd2MyX3dyaXRlbChoc290ZywgaHBydDAsIEhQUlQwKTsNCj4gLQloc290
Zy0+YnVzX3N1c3BlbmRlZCA9IGZhbHNlOw0KPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmhz
b3RnLT5sb2NrLCBmbGFncyk7DQo+ICsJcmV0dXJuIHJldDsNCj4gICB9DQo+ICAgDQo+ICAgLyog
SGFuZGxlcyBodWIgY2xhc3Mtc3BlY2lmaWMgcmVxdWVzdHMgKi8NCj4gDQoNCg==
