Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46D3646B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbhDSPIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:08:32 -0400
Received: from mail-eopbgr680127.outbound.protection.outlook.com ([40.107.68.127]:58242
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238693AbhDSPIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:08:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8heHhyStdi6dYgQbQ0Aul41xHJ38DUSWChvRGYX0cmCN2eb8KjyxXahAN5o2FVIvqqlDGl/6kq7iNAjCVdrwNAls+KkZBpCAiJgfRKl5MhZL6FktdEq/5Q8iRlRok+D3A8+CeGMb/uXdJcsyXm4IA0JurXnjPUfsTIfrJ7XIkpXwcX3+TD7mmPD/djSLenAwr1sTM3RA9dEWNHMGm1+dZPG+80zMzhoDNvi995ZpWPdzZAP/soRMJUSGMbWI6DWg03wvvCSMJ6XCGRvlm+MmjhKld2lJ9Texl/euo5ene8txKb8sRGzzFxmHm+w0N9+hch/PD6m43PbU5PLbXtUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyoQNN8GdSMZZLjHaWufdnQHng2FEtwbN8RlenvHGRM=;
 b=eGLeYMRxOort6IlytEc2ligXFPAkY3NBLOEC7VYWQUsP11TV/oblmnUIB3RfEmcNXegubgVRxqAcUNm/ortF8Ty4I2TCvxmAhzhBRoSdLjnK6h5EobduCjivPD0kpIz//1gQ7WroCrRdWkwwvA6qro3qPYZug/CwNdiquef9I0py/SdvsPT72RL0YAuzEmjt28zNZLiu3+3xU/H6GFbWMI6+D4xOFs3pP5RthnFdlJh4HLjsZNh7ANNEeMg/ORgQioaN5SS8xu+CtQKVJNpBhzIn/3XRFsT/IDhLD/qlf8yv2Uh9YrXL0dB2GXyyXdXOIXplIoaWNb/nQmalAL+ufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyoQNN8GdSMZZLjHaWufdnQHng2FEtwbN8RlenvHGRM=;
 b=KU+JCHa9yEQl6LeyNgkL1vgVzs7Q+8vuMfwTHsp1dik1qGLep2u27nkuWwXezbmQOnDkLGiSwXdTruozuEnoBWjAQ2U5M5iargVkH8mll52l+uky9PDCaOw1vs9ehdVZtiy5QjD7TSzirtQ8niPpVUWNSTB5t8TDl/kNsaCOZbQ=
Received: from MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24)
 by MWHPR12MB1533.namprd12.prod.outlook.com (2603:10b6:301:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 15:07:59 +0000
Received: from MW3PR12MB4475.namprd12.prod.outlook.com
 ([fe80::f1fd:22ed:7fb5:983d]) by MW3PR12MB4475.namprd12.prod.outlook.com
 ([fe80::f1fd:22ed:7fb5:983d%9]) with mapi id 15.20.4042.018; Mon, 19 Apr 2021
 15:07:59 +0000
From:   "Raju  Rangoju" <rajur@chelsio.com>
To:     Josh Boyer <jwboyer@kernel.org>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ramaraju Yelavarthy <ramaraju@chelsio.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: RE: pull request: linux-firmware: update cxgb4 firmware to 1.25.4.0
Thread-Topic: pull request: linux-firmware: update cxgb4 firmware to 1.25.4.0
Thread-Index: AdctiTaQbV9CxbfgTXySIUiT7axwyAHmsa0AAAJyVdA=
Date:   Mon, 19 Apr 2021 15:07:58 +0000
Message-ID: <MW3PR12MB447519AE1CA6CA521BEB43BABC499@MW3PR12MB4475.namprd12.prod.outlook.com>
References: <MW3PR12MB44753AF63DA77A737AE8781ABC739@MW3PR12MB4475.namprd12.prod.outlook.com>
 <CA+5PVA5bqGJoJw3njfWfOjHvzDzU2KDz5cHJ4QCexxKe1e8=8A@mail.gmail.com>
In-Reply-To: <CA+5PVA5bqGJoJw3njfWfOjHvzDzU2KDz5cHJ4QCexxKe1e8=8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=chelsio.com;
x-originating-ip: [175.101.22.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4d56e0f-5644-4c97-b3cb-08d90344eb65
x-ms-traffictypediagnostic: MWHPR12MB1533:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1533B476C447906436A00FB4BC499@MWHPR12MB1533.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bf931VPd92TJt90QCpHwUgj33/sbVsh+aiQoNqHxxcxC+XBJJ1LNO6vB+xY0452pIght4HD7uZi5bbbHj5thNYSjvPj7QPatsoaad/ErqXk7CQlzCUA46QS9nb/ToPMxp3iJx0cpNpgGq0wFD+Bsx4yY2d2BtgIddfjXLnZO1pRsqmlAzjVDi+64gpCCjUyYyWYRf7Oj/MRcHFoQF4U9NKRSu4IMAxTOsr869NBGl8Nc74MgNHbQaZVsnKd3VeFQsJFo8kAgBd07PaRdEjAxETNfaN6Z7VcqdywL8pljuO6iscBd1L6oUfUFaVacxlAYracxnNZjmZYorrAt9X4F/qMuSHAmdNJEn8YJGhA9EHcOALYMOQ3cqtQR2gsT8g2AMPLRV4F89RN5TkpVPOtIylhZMWnOEN9WK0BPaGiLwEPZwmS6S+BUf0gRlZRnL79MFskDAW/xZBZ6k322hM0Zoil7ubP8omXrbf3J5rMUvvuLk7PBEYt36XWy/aqdMCX1IAIPWok8Npc6q226X4lOiHBnoyowMvc/MlQxmpFUyQFt38OwieVn06O7HVT80P8rqwchsuv1/HExAUtLB/++YU3u5Tva/EkDc6NcGLAr7/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4475.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(39830400003)(346002)(66946007)(76116006)(53546011)(66446008)(6506007)(9686003)(6916009)(2906002)(33656002)(64756008)(122000001)(5660300002)(52536014)(66476007)(478600001)(38100700002)(66556008)(26005)(7696005)(107886003)(8936002)(4326008)(86362001)(186003)(15650500001)(316002)(54906003)(8676002)(83380400001)(55016002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MWQ2REhKT1VhOTVmRzN3TGhKWk1DMkpZWE5IbjgyMnJKYitrcjUxQjRQRGVy?=
 =?utf-8?B?RkVZTmhnZ1o3Q1Fxb3pvRUxhekU0KzhxdDNCSFRBRzF6NG4vclh4dzJDTXF1?=
 =?utf-8?B?WUlpYVRSVWIyeXMvTWo4em9EdHNFMVFrZzQ4V2pxdVdPcXVUV0trQlV3YnVp?=
 =?utf-8?B?dUVydHB4REs0bm1WVEJXR3ZzVkUzdU9MMlF0L1JMdDRKR1QreDR4eGlBMmh5?=
 =?utf-8?B?b3ZWZmsyK3ZLWTYvU2NBVEhxa2RrT0RTd2ZVUUxSeCt1Q0NXL0xxMjJWR28x?=
 =?utf-8?B?QmJLSWVvWGpQcWRPTTZleWptY0x3ZXh3UXV2ZzFaejFQL1hlV2ZWZWJ5ekRR?=
 =?utf-8?B?MWp5LzVhVm9HbmoxK0ZROVFONG1OYTRFZ3ZGRHRkWXpLOTZ0TThiMXZSZ2Nv?=
 =?utf-8?B?L1k1TEkyZDhxNC9DZytDU0kyaEZ2QTNjdmttNGRHUzJHT1V3SnNNNjM5YTJX?=
 =?utf-8?B?RHBWL1FPSnBNalJXOWhZUjdtanNBdSt3V1Z5MW4xTllHekQ2MnVnZHJxcjV4?=
 =?utf-8?B?anl3R0d0VjZxSFZOT3VYSjhTNDhqOUtobjI0ZEJiUDZ0L3JmbWh6RUU3NER1?=
 =?utf-8?B?WS9scGhjQWtTdnlUZ2MyTGx3SEdQcENVdUhJNVZHRWFPc0I2WWNCWk1wUStT?=
 =?utf-8?B?TGdXZ1c0ZFZoRXcwU2Z5Y0pBS2lwQmkySnpTeWRNa2kyWXd6OE5uYkR5ZXoz?=
 =?utf-8?B?dWc4a3FUK1dtdTd2clpuTjdHVHo4VHBnTnY4R0srOUZnN0w3UEtLMDNTVWtt?=
 =?utf-8?B?MXNjeWxYMzRhNEtVWWwxcC90UmJGVlFFdHU2QWYzaG1SQm5iZzlEUEZqSy9K?=
 =?utf-8?B?T3lsUUt4YVVJL0ZFd1NvYjNVK0ZvS01vREwyQmdUWkw0R01mL3h6NFNZWTZB?=
 =?utf-8?B?NHZKR014Q3VNYzVKWDFWTkNBYWNpOXowcEx2dDhJamRGY3lzcTdQZU5pbUx1?=
 =?utf-8?B?N3dTQmhybEpGaTFhUVZUY3NaaTFKM1MxSVVCZW9JeW0zOXhXU0hWdnZXWHRM?=
 =?utf-8?B?c3hnQmRoVHhvVDhKZTU3Q3BmZ0w3d1g3YzErV2FYYm9CL0RUYzJlcFVhQWF4?=
 =?utf-8?B?SDdua0UwdSsyYVJOUEQrZGpMNkVKazJWeUpsSkVGNGRrS0k3dlV3MUxqdTkz?=
 =?utf-8?B?aStiUEczL3JnNTJLd2R6eCt4ZWdwT1l6Smw0V3pGUGtvS2N2SGdvZHVFb3Fk?=
 =?utf-8?B?SWhETnJhcExYaUhSUTRKblBjSnFCZnRCWXNBejMzZkIybXRyTlQwMXhpT0p6?=
 =?utf-8?B?NE5wNThYRnc2NFVjSFdPTkJ4UDRFMUxlQ011M2JGcHN0cS9ObDNaYjgrSGxz?=
 =?utf-8?B?T3dKKzU3dTRiWlRFNVNiekxYZmxsaVR6ZjlkNG51TmhNRFpubXBxN2QrZWR3?=
 =?utf-8?B?dmRObG0zaEh1NUt0ZlZtTmRTT1dQQmlmS2NBR05pY014enNqM0tOdXY4ZE1o?=
 =?utf-8?B?dVJudHNPNkZkT1QxOTB2aW04b0VDWHJRaTNjL1U3U1lBMjlxNEpRclYvSzlR?=
 =?utf-8?B?bTB0QnhoajJQQmgzbTVLTWN1azRHNzdrazdnZnE4RUxRS0x4ZGJMamxoSU1m?=
 =?utf-8?B?N1JUbmcwaFdQL0xOdzJXc3ZNUk05R2paa3FHdktUZ1FUOS9PNWNEV2JJdjVo?=
 =?utf-8?B?V20yK09XZUdHVGMyUHZMTmt6VG1YQ2lJTGtOVHZjSzFzYjFSRFk4UENJbmtp?=
 =?utf-8?B?cm42b3hIR0RkSE1abHlNdis4bm9wR0RSYzhKNHRPUjRvUnNCNlN6eE1TRU53?=
 =?utf-8?Q?gAjej0BwfVJ8u/XSpgJv5sJRRfJphUFKMhp3ppb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4475.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d56e0f-5644-4c97-b3cb-08d90344eb65
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 15:07:59.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ky4luc+I017O0UGW7514BSFK28UxgzhgF++pCMrCo9Cq4KT2wfWfj4oVbA3pQbX8IBUtrUb2z4W0kB+GbsQhuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1533
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9zaCwgdGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dC4gSSdsbCBzZW5kIHRoZSBuZXcgcHVs
bCByZXF1ZXN0IHNob3J0bHkuDQoNCi1SYWp1DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBKb3NoIEJveWVyIDxqd2JveWVyQGtlcm5lbC5vcmc+IA0KU2VudDogTW9uZGF5LCAx
OSBBcHJpbCwgMjAyMSAxOToyOA0KVG86IFJhanUgUmFuZ29qdSA8cmFqdXJAY2hlbHNpby5jb20+
DQpDYzogbGludXgtZmlybXdhcmVAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgUmFtYXJhanUgWWVsYXZhcnRoeSA8cmFtYXJhanVAY2hlbHNpby5jb20+OyBSYWh1bCBM
YWtraXJlZGR5IDxyYWh1bC5sYWtraXJlZGR5QGNoZWxzaW8uY29tPg0KU3ViamVjdDogUmU6IHB1
bGwgcmVxdWVzdDogbGludXgtZmlybXdhcmU6IHVwZGF0ZSBjeGdiNCBmaXJtd2FyZSB0byAxLjI1
LjQuMA0KDQpUaGlzIGZhaWxzIGNoZWNrX3doZW5jZQ0KDQpbandib3llckB2YWRlciBsaW51eC1m
aXJtd2FyZV0kIC4vY2hlY2tfd2hlbmNlLnB5DQpFOiBjeGdiNC90NGZ3LTEuMjQuMTcuMC5iaW4g
bGlzdGVkIGluIFdIRU5DRSBkb2VzIG5vdCBleGlzdA0KRTogY3hnYjQvdDVmdy0xLjI0LjE3LjAu
YmluIGxpc3RlZCBpbiBXSEVOQ0UgZG9lcyBub3QgZXhpc3QNCkU6IGN4Z2I0L3Q2ZnctMS4yNC4x
Ny4wLmJpbiBsaXN0ZWQgaW4gV0hFTkNFIGRvZXMgbm90IGV4aXN0DQpFOiBjeGdiNC90NGZ3LTEu
MjUuNC4wLmJpbiBub3QgbGlzdGVkIGluIFdIRU5DRQ0KRTogY3hnYjQvdDVmdy0xLjI1LjQuMC5i
aW4gbm90IGxpc3RlZCBpbiBXSEVOQ0UNCkU6IGN4Z2I0L3Q2ZnctMS4yNS40LjAuYmluIG5vdCBs
aXN0ZWQgaW4gV0hFTkNFDQoNCllvdSBjaGFuZ2VkIHRoZSBsaW5rcyBpbiB0aGUgY29tbWl0cywg
YnV0IGRpZG4ndCBhZGp1c3QgdGhlIGFjdHVhbCBGaWxlIGVudHJpZXMuICBDYW4geW91IGNsZWFu
IHRoYXQgdXAgcGxlYXNlPw0KDQpqb3NoDQoNCk9uIEZyaSwgQXByIDksIDIwMjEgYXQgNTo0NSBQ
TSBSYWp1IFJhbmdvanUgPHJhanVyQGNoZWxzaW8uY29tPiB3cm90ZToNCj4NCj4gSGksDQo+DQo+
IENhbiB5b3UgcGxlYXNlIHB1bGwgdGhlIG5ldyBmaXJtd2FyZSBmcm9tIHRoZSBmb2xsb3dpbmcg
VVJMPw0KPiBnaXQ6Ly9naXQuY2hlbHNpby5uZXQvcHViL2dpdC9saW51eC1maXJtd2FyZS5naXQg
Zm9yLXVwc3RyZWFtDQo+DQo+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYWYx
Y2EyOGYwMzI4N2IwYzYwNjgyYWIzN2NjNjg0Yzc3M2RlODUzZjoNCj4NCj4gICBhbWRncHU6IGFk
ZCBhcmN0dXJ1cyBmaXJtd2FyZSAoMjAyMS0wNC0wNSAxMDo0MDowOCAtMDQwMCkNCj4NCj4gYXJl
IGF2YWlsYWJsZSBpbiB0aGUgZ2l0IHJlcG9zaXRvcnkgYXQ6DQo+DQo+ICAgZ2l0Oi8vZ2l0LmNo
ZWxzaW8ubmV0L3B1Yi9naXQvbGludXgtZmlybXdhcmUuZ2l0IGZvci11cHN0cmVhbQ0KPg0KPiBm
b3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gN2RhZWRiYTliMDJiZmJiNDdkYTg5YzRkYWU2
ZjIwYzkxYTVlNTQwMjoNCj4NCj4gICBjeGdiNDogVXBkYXRlIGZpcm13YXJlIHRvIHJldmlzaW9u
IDEuMjUuNC4wICgyMDIxLTA0LTA5IDA3OjQ1OjI3IA0KPiAtMDcwMCkNCj4NCj4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiBSYWp1IFJhbmdvanUgKDEpOg0KPiAgICAgICBjeGdiNDogVXBkYXRlIGZpcm13YXJlIHRvIHJl
dmlzaW9uIDEuMjUuNC4wDQo+DQo+ICBXSEVOQ0UgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNiArKystLS0NCj4gIGN4Z2I0L2NvbmZpZ3MvdDYtY29uZmlnLWRlZmF1bHQudHh0IHwg
ICA4ICsrKysrKy0tDQo+ICBjeGdiNC90NGZ3LTEuMjQuMTcuMC5iaW4gICAgICAgICAgICB8IEJp
biA1Njg4MzIgLT4gMCBieXRlcw0KPiAgY3hnYjQvdDRmdy0xLjI1LjQuMC5iaW4gICAgICAgICAg
ICAgfCBCaW4gMCAtPiA1Njk4NTYgYnl0ZXMNCj4gIGN4Z2I0L3Q1ZnctMS4yNC4xNy4wLmJpbiAg
ICAgICAgICAgIHwgQmluIDY3Mjc2OCAtPiAwIGJ5dGVzDQo+ICBjeGdiNC90NWZ3LTEuMjUuNC4w
LmJpbiAgICAgICAgICAgICB8IEJpbiAwIC0+IDY3NTMyOCBieXRlcw0KPiAgY3hnYjQvdDZmdy0x
LjI0LjE3LjAuYmluICAgICAgICAgICAgfCBCaW4gNzI3MDQwIC0+IDAgYnl0ZXMNCj4gIGN4Z2I0
L3Q2ZnctMS4yNS40LjAuYmluICAgICAgICAgICAgIHwgQmluIDAgLT4gNzI4MDY0IGJ5dGVzDQo+
ICA4IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkgIGRlbGV0
ZSBtb2RlIDEwMDY0NCANCj4gY3hnYjQvdDRmdy0xLjI0LjE3LjAuYmluICBjcmVhdGUgbW9kZSAx
MDA2NDQgY3hnYjQvdDRmdy0xLjI1LjQuMC5iaW4gIA0KPiBkZWxldGUgbW9kZSAxMDA2NDQgY3hn
YjQvdDVmdy0xLjI0LjE3LjAuYmluICBjcmVhdGUgbW9kZSAxMDA2NDQgDQo+IGN4Z2I0L3Q1Znct
MS4yNS40LjAuYmluICBkZWxldGUgbW9kZSAxMDA2NDQgY3hnYjQvdDZmdy0xLjI0LjE3LjAuYmlu
ICANCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGN4Z2I0L3Q2ZnctMS4yNS40LjAuYmluDQo=
