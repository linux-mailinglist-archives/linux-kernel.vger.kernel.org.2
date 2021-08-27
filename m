Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23D53FA1FB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 01:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhH1AAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 20:00:38 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47226 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232354AbhH1AAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 20:00:37 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B2CBBC03C8;
        Fri, 27 Aug 2021 23:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1630108787; bh=GQvDONFWKVKzf/mM76hcHNh0D/99UuBXsYJ9CAYp/sY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dTO3vncWEiHvHmIKtCspPnDK0+7Cm/eI1zcNvh9/on/BcWo+E/FOKDKMmkBXOBzPi
         ragSeAZOSdExeH1L5jqNNj0efQMZy8MmklUDrWZOK6T2hV8Js9gzLcypk0RPeXHfOg
         xDv4nTmPNKg+vV7NZOjbyWRQcDSFYw6Vic8tdWhGqBoGI1ZYnJBmr7WaAFNrYbi5c2
         33YAwULuPSWAEtPR2Awc7FItOP+Mic0La//s6sepONDVV1ZDKEDUFJKISGTfLtEHka
         9JYOES/Gqa0+SxQmEqdXmvBwIZ0x4yeJmU4+CyUozP832Ip4pZ912kEpMa3bShajq2
         R/m+XLcLec+xw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CDFEDA005C;
        Fri, 27 Aug 2021 23:59:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5678D4006B;
        Fri, 27 Aug 2021 23:59:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="YZsKZGo+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwDdypR1gfDkOiQAWwC8Dl+psjJr03HKc3JXpF5Jl41pJw+6iRHJUS6MTsskmLe1WgyTZir5Pr3+h09KVALV0Zr2Y1tG72sK1BPOjrRJRqQxNUgQR61KDiuJN3mGPvSnufP3GJ6rZ83WZTKkXkT3NRQj/eom7yy4qSIAWHUThZlKzu5eE2WO+Toydou7seFHv4Io+ikNyvQ3dkRoP3SPukOKqnMPb62WK2nC8Cy7IOInXMgwMdzdAT2Q/Ju/ZiU9KZzoFd+nSpM7njDbgFUGSDUJj+PBaZc4mZPXAVTicO1q1A++9zb5SGJd02rjaaTcPYjohN87ouXJjU4/mDCfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQvDONFWKVKzf/mM76hcHNh0D/99UuBXsYJ9CAYp/sY=;
 b=YsOJW5g4dsSVGY1tazDgMvbyxh08N6fW+VVTv1igA4V+G3WzjIHtY1pXpCJevh2OFCXTL65g3lPQ9HwF6EsSY0t+jsa4vB9WTSxlYS0IMoWerMlgunBkCl61jI/C+qpm/58ZEHs/H2HPeM8hlO9uc4ZMsZ98OUqKuz7hY8nVFCvv5/9S78jNZIqhPW/HWU/nTlGqidO1h9kJh87xZEmpxq9oB2sDsYXshylcwQ/zX4EmcJAw32fjJyCGO37m70zVweFz4sebeVBUvRVgpABNWaNdYQ91avcISOYUtB2SKOb8qSGHgF9+7i00tOC7oChWq8GLOHlE9iHBglYGSIwIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQvDONFWKVKzf/mM76hcHNh0D/99UuBXsYJ9CAYp/sY=;
 b=YZsKZGo+XYxFg0iAnxk9+zHKpc35KNVpvZkvIAD84BNcK2Hzx4SXUQ1rq3VGdqjrAp3ZI/NElwo707YmH2JA2WVRdnk3OkNIUIdTpxwGj6LVdhyq8P3A86uGd5ht2mD+UY4zFpn4rjnwqdIkFdM2AcCihbJQlOfXY01pqgXxT5U=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3301.namprd12.prod.outlook.com (2603:10b6:a03:130::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 23:59:43 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e%4]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 23:59:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb: gadget: u_audio: fix race condition on endpoint stop
Thread-Topic: [PATCH] usb: gadget: u_audio: fix race condition on endpoint
 stop
Thread-Index: AQHXmyYVNA8UuVoGEEGXDbpl+r0teauICOmA
Date:   Fri, 27 Aug 2021 23:59:43 +0000
Message-ID: <3c62d031-7334-3984-e002-f3eef1fa3b3b@synopsys.com>
References: <20210827092927.366482-1-jbrunet@baylibre.com>
In-Reply-To: <20210827092927.366482-1-jbrunet@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9dd86a2-43fe-40fe-7bba-08d969b6bd96
x-ms-traffictypediagnostic: BYAPR12MB3301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3301CBC519ECDF616F3600AEAAC89@BYAPR12MB3301.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtSyBhdZZ+yPoKoI+6i5BPg4havJ9z8ECSQBg8Qnit1CT6H5UJCDCuMXTCS1rSjVInfLPELilM46af5aPOvbYFwwZiYx8KYs/fdfe1TpR4+bvgTmmw3c5hi+pxQ5Sz2UFUZT7w4d6yLvNCs+vJDSlgIxvARFPX7SkidJjSZei0D6DZ7IZHtnMKX9SecgROas6c4eHguzjsB0MUxq4zw0DpwW2SeK7PR4mWEvkYB0lvg2YRSK1XJoFt1CY3a3IviaGFq6IuXaI6SKWbE1TM6O6DGoZjWq4AIxvpu64zXGv8gjd1pvJR/TDocakw0p627Z2UiP3Jz91fikgAoKptPcVql7dfTNx6MwEoR9IhEcLHJcDn44eJkEvruJFWvHrIzfIQZaCDWT/LNk5KwsVmm3cbodBIRBmOrEb01TVjwy2ZLttDi0rWMSsrVecaK+6DbCc7xt+4/pS8fhZVlIOXUP+AuEkjEGhvc1xePLVkZ1fktdO/r84fed4zkOj9QnFu3ZSTZC01eFwpvdhle+ogsFHwjjX31y6XTKodtVnw+6R0J9RwpJ2gYB4LJiuSv8IOoRNnFoBhyMCN7nhBX60f1fs+rOG4aFKVKAgDLFdGs08Te5eTKDdHQBMYICtewRq2eW5AClbnZG3yMzw6p4KG40sPSvSKixegBuqu7b/USfrB8L1b7DcNssXGbrGvbWEhJYMTRiG5re8MAk0BQbyE7xM+iEsg1DVUnt+UsUnw3MuKTrHTliOIY2LtzmR7uLcVnZai84kUgaMO7o18ltXm90qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(86362001)(6486002)(66446008)(186003)(31696002)(54906003)(4326008)(2906002)(31686004)(8676002)(38070700005)(76116006)(107886003)(36756003)(38100700002)(6512007)(478600001)(110136005)(66556008)(2616005)(5660300002)(6506007)(8936002)(71200400001)(83380400001)(316002)(64756008)(66476007)(26005)(66946007)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFtVWRaMzdKOUNDWXNhWGVxeUdFRHoxS000T2FsekJ2RFlVMmYwZEVraFJx?=
 =?utf-8?B?d0huWFZ3S0hESDlKak9wdFJIQ1VoMno3dnBRV3kvcmZib0VxeWI4MHFJdExI?=
 =?utf-8?B?S3BBa05qZk1TTlRLNytrUXpsYTJzZG9QUURZSU5tY1hHTlBkYjhSQU8yb3R6?=
 =?utf-8?B?Q3h5eHJ5WkplNWxVVG8zc1hFS0RCU3ord0U1bDNjNEJ5V0hsaWd0Z1lyMHFu?=
 =?utf-8?B?ZkY3MUY0L0dJZi92WitjRkFHMG45dFlRYm1uWWtEc0plWExTS3pQV25iMGo0?=
 =?utf-8?B?ZmRQbDZ4V2pqMlN5eEtHR25UUmNNQlFsNktiWGpJQ05EWjZQRnJyVDZSdGRT?=
 =?utf-8?B?Q2o3VGJVbXlLNXYxQit4VVplb29rOEN3U0JSNTBOVzNxWEMwVm92LzBOcUhG?=
 =?utf-8?B?cXVLL3hxdWE4SXRtazZVT0xIai90K3gxak1KRnlDNTloa0xvS2tXbkdSbGlX?=
 =?utf-8?B?OVVtcjc3VzZiZkhuMG1iT0F0L0o2cnFzaVkyMzN1dng2ajI1WHJVQWFhWFVP?=
 =?utf-8?B?RjFGUm9ibVRKSGJMVndlWkhmZ0JjMmJxU3ArNzgvbTlxK0ducWhlNE1WajAx?=
 =?utf-8?B?eEZRNXN0MVlkSjRyaEdxaGF3ZUlIWDZrOHRQVUVnN2NRNkJKbWhrdkZjeVVE?=
 =?utf-8?B?SXdxYmJZckN0ZGFwOW1LYnRYRDBtdFBJbnY3eXJkSFJPTmN0dkV0TGpIYUk1?=
 =?utf-8?B?THhFYXhHeEhSUm5pZ3o0ZWhpa1I2Y3BKbUc0S2MveHN0UlRHWmR4RGY1TGJT?=
 =?utf-8?B?dCtsQ1VTUjVzOFM4V1NiZ292dGZDbUM4d0grenhESSt3T0k1blNCaEt5aG4z?=
 =?utf-8?B?TUdZVGtlMkcwOTBCM1FNTG5qYklOK2FiYW1SV0lYQWZvR0dWYTNoQnpOT2Fz?=
 =?utf-8?B?RDFTUmJaK1RPRWxuaGYyNWoyWFZ0dHhWT0ttRXVReDZyVzdmRXc3WmNNQVVV?=
 =?utf-8?B?dHNNZVdIUk5CY1hkMUVzVEdEd2pKSHcrN0JiSXlwRjNrWkNFMnFXeGNiZWZY?=
 =?utf-8?B?ai94WnpWcnRoZUZGMEVTcHJwd3BMTS9MYTJrUEpFdDZKNGZwenJiRFdYWnph?=
 =?utf-8?B?TldGSzZsdjRScnVNaFBlWXZoR1duYTVjb1ZlbDkzdUVERzh2dFkxUDkxV0hp?=
 =?utf-8?B?d0lOQXVMdnh1SGVOQUhsUDlwYm82SHJaRWlIaXp6VGtDbG85K2VvdUM2S2s5?=
 =?utf-8?B?ZDBTZC9WOUUxNnJZV1R6S0RaRzBWWWJMLzFYdi9VWVBlaHFiUU5zR1lWRTJm?=
 =?utf-8?B?T1ZlUUJaV3o4VlhoSDl6dC9XS0tkWWtIYmF3NDFjNmphNGtsYTZNOGRPb0x0?=
 =?utf-8?B?RDJJZVVNQVFnU3Y4TXBpRms5MkwvMU5MWCtTS2hJTXViUmM3RUJxc09mekRq?=
 =?utf-8?B?WHIyODQ0N2pDSjJ5NGtNems2VE9BeUM2bzJmcUJoUzBVREdqLzFZaml5VTJX?=
 =?utf-8?B?Q2M0ZkJJaytWVDR1LzdQSGRlQmR6cE5naGtjMng5ZlY5RXd4alRuQkt6MXY4?=
 =?utf-8?B?elF1eFE4U0pyZndhVE9SY3dnQ0dlTjJKMndEQUhxam05NnVyVHhUakp2ZWpG?=
 =?utf-8?B?aHFKUy9HbC9sK25NVzFJM1poTHBvSjZmQmRud2dTSFV2Z1k4RFlGaFVFOVdK?=
 =?utf-8?B?OGNBMzhsY2pubkNnOURpTE50OHpoTmVCa1hiZUw3aFBJbG9XYWQ2R1lwRW15?=
 =?utf-8?B?MXJ0cW5oNDByYVJGSEpKajEzZ0Z0RnVRdEhwVno1NE5IcHhPQjlmSWgyTTk2?=
 =?utf-8?Q?8RbUMuW79DsaXEixKg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4338AA46A241E74C9FCBE79B1EF03E4C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dd86a2-43fe-40fe-7bba-08d969b6bd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 23:59:43.4526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwvVaUkfsPDiitNyBoPJRrTrzr0Q2y4g0puvaHmLIFYLAT7DwAEfC29/2eH8mLxCHd7NK2i8FEkV7sEBekEu7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3301
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmVyb21lIEJydW5ldCB3cm90ZToNCj4gSWYgdGhlIGVuZHBvaW50IGNvbXBsZXRpb24gY2FsbGJh
Y2sgaXMgY2FsbCByaWdodCBhZnRlciB0aGUgZXBfZW5hYmxlZCBmbGFnDQo+IGlzIGNsZWFyZWQg
YW5kIGJlZm9yZSB1c2JfZXBfZGVxdWV1ZSgpIGlzIGNhbGwsIHdlIGNvdWxkIGRvIGEgZG91Ymxl
IGZyZWUNCj4gb24gdGhlIHJlcXVlc3QgYW5kIHRoZSBhc3NvY2lhdGVkIGJ1ZmZlci4NCj4gDQo+
IEZpeCB0aGlzIGJ5IGNsZWFyaW5nIGVwX2VuYWJsZWQgYWZ0ZXIgYWxsIHRoZSBlbmRwb2ludCBy
ZXF1ZXN0cyBoYXZlIGJlZW4NCj4gZGVxdWV1ZWQuDQo+IA0KPiBGaXhlczogN2RlODY4MWJlMmNk
ICgidXNiOiBnYWRnZXQ6IHVfYXVkaW86IEZyZWUgcmVxdWVzdHMgb25seSBhZnRlciBjYWxsYmFj
ayIpDQo+IFJlcG9ydGVkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEplcm9tZSBCcnVuZXQgPGpicnVuZXRAYmF5bGlicmUuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2F1ZGlvLmMgfCA4ICsr
KystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2F1ZGlv
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9hdWRpby5jDQo+IGluZGV4IDYzZDkz
NDBmMDA4ZS4uOWU1Yzk1MDYxMmQwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQv
ZnVuY3Rpb24vdV9hdWRpby5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X2F1ZGlvLmMNCj4gQEAgLTM5NCw4ICszOTQsNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZnJlZV9l
cChzdHJ1Y3QgdWFjX3J0ZF9wYXJhbXMgKnBybSwgc3RydWN0IHVzYl9lcCAqZXApDQo+ICAJaWYg
KCFwcm0tPmVwX2VuYWJsZWQpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAtCXBybS0+ZXBfZW5hYmxl
ZCA9IGZhbHNlOw0KPiAtDQo+ICAJYXVkaW9fZGV2ID0gdWFjLT5hdWRpb19kZXY7DQo+ICAJcGFy
YW1zID0gJmF1ZGlvX2Rldi0+cGFyYW1zOw0KPiAgDQo+IEBAIC00MTMsNiArNDExLDggQEAgc3Rh
dGljIGlubGluZSB2b2lkIGZyZWVfZXAoc3RydWN0IHVhY19ydGRfcGFyYW1zICpwcm0sIHN0cnVj
dCB1c2JfZXAgKmVwKQ0KPiAgCQl9DQo+ICAJfQ0KPiAgDQo+ICsJcHJtLT5lcF9lbmFibGVkID0g
ZmFsc2U7DQo+ICsNCg0KSG0uLi4gdGhpcyBsb29rcyBhIGxpdHRsZSBvZGQuIElmIHRoZSBjYW5j
ZWxsZWQgcmVxdWVzdCBjb21wbGV0ZXMgYmVmb3JlDQpwcm0tPmVwX2VuYWJsZWQgPSBmYWxzZSwg
dGhlbiB0aGUgYXVkaW8gZHJpdmVyIHdpbGwgcmUtcXVldWUgdGhlDQpyZXF1ZXN0LiBJdCB3aWxs
IGV2ZW50dWFsbHkgYmUgZnJlZWQgbGF0ZXIgd2hlbiB0aGUgZW5kcG9pbnQgaXMgZGlzYWJsZWQN
CmFuZCB3aGVuIHRoZSBjb250cm9sbGVyIGRyaXZlciBjb21wbGV0ZXMgYW5kIGdpdmVzIGJhY2sg
YW55IG91dHN0YW5kaW5nDQpyZXF1ZXN0LiBCdXQgaXMgdGhpcyB3aGF0IHlvdSBpbnRlbmRlZD8g
SWYgaXQgaXMsIHdoeSBldmVuIHVzYl9lcF9kZXF1ZXVlKCk/DQoNCkFsc28sIGFub3RoZXIgY29u
Y2VybiBJIGhhdmUgaXMgSSBkb24ndCBzZWUgYW55IGxvY2sgb3IgbWVtb3J5IGJhcnJpZXINCndo
ZW4gd3JpdGluZy9yZWFkaW5nIHBybS0+ZXBfZW5hYmxlZC4gQXJlIHdlIGFsd2F5cyByZWFkaW5n
DQpwcm0tPmVwX2VuYWJsZWQgaW4gdGhlIHJpZ2h0IG9yZGVyIGFzIHdlIGV4cGVjdGVkPw0KDQpX
b3VsZCBpdCBiZSBzaW1wbGVyIHRvIGZyZWUgdGhlIHJlcXVlc3QgYmFzZSBvbiB0aGUgcmVxdWVz
dCBjb21wbGV0aW9uDQpzdGF0dXMgYXMgc3VnZ2VzdGVkPw0KDQpCUiwNClRoaW5oDQoNCj4gIAlp
ZiAodXNiX2VwX2Rpc2FibGUoZXApKQ0KPiAgCQlkZXZfZXJyKHVhYy0+Y2FyZC0+ZGV2LCAiJXM6
JWQgRXJyb3IhXG4iLCBfX2Z1bmNfXywgX19MSU5FX18pOw0KPiAgfQ0KPiBAQCAtNDI0LDggKzQy
NCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmcmVlX2VwX2ZiYWNrKHN0cnVjdCB1YWNfcnRkX3Bh
cmFtcyAqcHJtLCBzdHJ1Y3QgdXNiX2VwICplcCkNCj4gIAlpZiAoIXBybS0+ZmJfZXBfZW5hYmxl
ZCkNCj4gIAkJcmV0dXJuOw0KPiAgDQo+IC0JcHJtLT5mYl9lcF9lbmFibGVkID0gZmFsc2U7DQo+
IC0NCj4gIAlpZiAocHJtLT5yZXFfZmJhY2spIHsNCj4gIAkJaWYgKHVzYl9lcF9kZXF1ZXVlKGVw
LCBwcm0tPnJlcV9mYmFjaykpIHsNCj4gIAkJCWtmcmVlKHBybS0+cmVxX2ZiYWNrLT5idWYpOw0K
PiBAQCAtNDM0LDYgKzQzMiw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmcmVlX2VwX2ZiYWNrKHN0
cnVjdCB1YWNfcnRkX3BhcmFtcyAqcHJtLCBzdHJ1Y3QgdXNiX2VwICplcCkNCj4gIAkJcHJtLT5y
ZXFfZmJhY2sgPSBOVUxMOw0KPiAgCX0NCj4gIA0KPiArCXBybS0+ZmJfZXBfZW5hYmxlZCA9IGZh
bHNlOw0KPiArDQo+ICAJaWYgKHVzYl9lcF9kaXNhYmxlKGVwKSkNCj4gIAkJZGV2X2Vycih1YWMt
PmNhcmQtPmRldiwgIiVzOiVkIEVycm9yIVxuIiwgX19mdW5jX18sIF9fTElORV9fKTsNCj4gIH0N
Cj4gDQo=
