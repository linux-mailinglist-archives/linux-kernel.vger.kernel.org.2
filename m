Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78F03E842D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhHJUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:14:50 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44338 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232731AbhHJUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:14:45 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB8E641188;
        Tue, 10 Aug 2021 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628626463; bh=1YB3RHnSq8/t1XSBHWGfrwfw7u+LasY1KH1+1ZR7WzM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KugkLPwnr4aY5jz5x61NNXcfjwyLpzdPKYRrzhp6myPK66iUsVgouhfu0njupVEgC
         6lax51eDuYMyk09aBhrX7ZcpsSlrZPwgWjCQ9GprFgRUgMFlIkSmGSCG0xZD61f5Qz
         u74+ZDFn8kiCcpJ8Oug2uiL9+GMQsPFxOma9aduWctc4tOXEyezVQq1g7IEWhQW6xf
         7+SkhlLn2vHXY/EqsXqPxXKMubXQSn1w55mQfHr6aOCv9j+J2SQiM9/xWLDOXzFY/3
         9tX0AIpLbFo4+bNaEkriTW2scFW6ysmYHpv3i0w6bBpnHTYDJU/K7DwXYLMU05Xm8I
         Xt4H8oF19OUgw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 99A7FA0082;
        Tue, 10 Aug 2021 20:14:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B23C94014A;
        Tue, 10 Aug 2021 20:14:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HarYt/c3";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsABz5LEIdHIelNVBXUE8Ti7P8kBrtOeMJ6uZm1sxnXz7QaqAeHXjzzelFo6iGGaQi9wy1WBEzHooX8EYAiwJK4D4wv1FVETa7zIeLbWYRffZyjx+w5kXPr/fxtBf6nhVT5WIOgqTmByrBiqyBXe8avo2dZW+sW5y08ChczcusDyB+GyQqaDxloVD5AxYjWiIohq7KodJQYVtzXm4ahN0MpKHWkqpDbTmpv8iljkyekb3dElYDh+OOVoTVE2CZ5vowzrSsbwK6QzzEZ+6mE2fyMB+ue7nBF8rHzhEfjB+IX4rTbIpMQlJS1W7WvxauZV0g7VDyQZGtx5/oX8JiF6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YB3RHnSq8/t1XSBHWGfrwfw7u+LasY1KH1+1ZR7WzM=;
 b=EXE4t1aO9ZweAnnVSchMpmMdu5ofPNQP9hJ2f+LkKr3ZBwE+gojtuufd4kMq5wR8enpMJphDmj2AXr+FO/A2kvD5/GSYFQiXo/cZ0hhfUCpAaSIuLsDYplKzDplGCGNX83aAeafOkfnK4rOBYtA6ta6rML4VSdCQVkIMebpTFO929FUjUP/6TVSdmDPlfTi6uDSWhqUp99xUnJC+35rgXV4jyYZqmD27awaW3VdqQU0ZZSx/vAt/Eb3LgNwWKuf0nTuE3bayoiWGyFp0jLRAD90/l7CB3fEvmAQpiULRygsAzA6PkJCrJJu79Pp9J0BtXDuKlTSITrg8aLDCInbgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YB3RHnSq8/t1XSBHWGfrwfw7u+LasY1KH1+1ZR7WzM=;
 b=HarYt/c3uTMgt+CpKjbo632C5m++NXjIwLRr0GYYRqz1mEQVb1SRTcSjgzhofT8co0zmtBmbjqhgc1nEuO8JNpQ+gYwmPqxhXhNJbUziI90k4Y8AlBFNziD+afcuP9ZOvnh5BvM/Wu1HKTzlS0gVMv/NLUU0MuwQTVFfiF/S42U=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Tue, 10 Aug
 2021 20:14:18 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 20:14:17 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Petri Gynther <pgynther@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
Thread-Topic: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
Thread-Index: AQHXjW5ko6qYUR8aokekS5eRbPy7oKtrxUWAgAACvICAAAD6AIABMcaAgAAy+YA=
Date:   Tue, 10 Aug 2021 20:14:17 +0000
Message-ID: <a2139dcd-2512-2138-66b4-311056d92afa@synopsys.com>
References: <CANcMJZCEVxVLyFgLwK98hqBEdc0_n4P0x_K6Gih8zNH3ouzbJQ@mail.gmail.com>
 <20210809223159.2342385-1-john.stultz@linaro.org>
 <4e1bef57-8520-36b9-f5cb-bbc925626a19@synopsys.com>
 <CALAqxLXPGt69ceiXkGT-nDjeP72mmCUgEzDdMpXr=rSNwpespw@mail.gmail.com>
 <0dfa8cd6-99b6-55c7-8099-0f6f1187b7fd@synopsys.com>
 <b025412f-c27a-a59b-cd8f-aec0faa98928@codeaurora.org>
In-Reply-To: <b025412f-c27a-a59b-cd8f-aec0faa98928@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ba9979f-f3f6-4b37-83ad-08d95c3b6ea0
x-ms-traffictypediagnostic: BY5PR12MB4210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4210BB2068B424D909B0791AAAF79@BY5PR12MB4210.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crUJR8ZE0rXkc+QlNGM4b1GCpUfI48A51eAYRlJNcq0gF+8RiWgIBUnkP+QS+S1ycP9uOJM5J8JGL6p4Xk50EI/JnUIEMIt+EtRIgO0P9dG2xyMUe9n7cOtSy5xIgk5MkJF7xdy7rpUyx+bAO0qWRNzALW8bh+gF6mwfFUNuM56otx/yJRBppxqEgCSg7Uqtx0I5MHHyzPcC3mUkrcypp1tB5RytkBRGLA6zne97sCsGjWLSV2EL6vBO0k2j4i4XqbmwV9XokHPyv0pzljJfVS6gW94ZXoUxMSV9jSBYDngYweCgx7eaix9ykAjDT1kB9+2Jx4IEb1NOlOFRDTd1HXu7CnSb/ZfT+2Cv4OTZAZ9V1kUtUtmgsDPYPpKyqw5xSGiocwdD1vvhcdGmm3LR39SURAbZhY8jzIFCu88LBF+NaUfV3vHzL3BN298zis+M2b4M+b/OUwi2KcotXKE0tzF0VSqusHGurKiH7aBW4Nhbv5wJW8RSX4CPXC70eYfnv5jguadMdpiOBcdVHUOVNOLS8oPSRaCp92pYXNfxeZtPrhDiXKiDbrtiMRZFLEILQKjRIiwMAA+guAU/dDD3ormUQlUOjErz9Xya2d2ouFyY73krpI/dV2ljEeSBPbbWt/w/9EgsTO3l4IfGBNcXNGlC5Pge8+slbldwCaU2Fot6IkkcvTCj5LfWfO4doAVGpWhxTw1OC9bBm2l878pWpwJRb8TjVC/pTreWeojjauWtuRPJQ8qZV/L4RAt6fPNsEEhJC2qalCEFd/8pF0YUMBx2g9YzTJO20Y5myddkckPqmDBTkD8eOO5fmuXekBNau10ruMYUqpCL/eNQPXXYE2bJFbgLXu9mmulud7198fo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(136003)(39860400002)(8936002)(26005)(186003)(66446008)(2906002)(6506007)(31696002)(53546011)(8676002)(5660300002)(38070700005)(66476007)(38100700002)(66556008)(66946007)(76116006)(64756008)(83380400001)(71200400001)(122000001)(86362001)(54906003)(7416002)(4326008)(110136005)(6486002)(6512007)(478600001)(316002)(31686004)(2616005)(36756003)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWNKUGw0NDhXd2VLYXpHSnFJMjlNaHgzSWxtVWo5UHRKUnpUWDlhM2k4V0dv?=
 =?utf-8?B?VkgrYTVOZlZYeEVMZkFyME5JZlo4WWgzNkZFanJFZzl3YzdvWTdIbWlzR0NW?=
 =?utf-8?B?VXlKM3JObGVtNForRFMyL2twVjlJaVBSejdMejZrWk8vcU1kelFPbmk1Vkwx?=
 =?utf-8?B?K3lKRUUydWNYNTloV01ncGZmdTd2bmNyYW5HQ2xQbHNnVVQ1am83dzg2NFFJ?=
 =?utf-8?B?MVBJRktQUFp0eHdMOGo1bXpZcGp2NDZwQUdvK3hRdjhPYTJKQ2UzY1FYc3Bu?=
 =?utf-8?B?OTJrM1VJUmY1d2dPdkpLS0pyV3RpL1hiUTRjSWVVVFFMTEV6UkhoLzNaQy9j?=
 =?utf-8?B?Uzk0SWczOS9IMjFFZ2VlWFo1UFcvTXBEZjhUZkZGUTNuMWdhK0U3SGo0K0hp?=
 =?utf-8?B?SnVNcVdrTkdOdzBmbk5DbmhzM1M5VFFXU0ZxNDlndDk1V2tRTXZsWkQvd2pT?=
 =?utf-8?B?SWNuWk1oTy9lbGFoTDA4dlNueXQ3WUhJK3BJRG5HdnRUaFl3a3VCQXlncUxl?=
 =?utf-8?B?UjJGaDlKNW1nbm45ZkZSeXZ5RFlaaGhNV0JaTzRFdE9YRUtTY3FXbjBsY1JB?=
 =?utf-8?B?MDVCUklzd3B6UnZTaW5od0cvQWZ5cSs4czFjQTVNc2d1R0NianhvWVlqQnIw?=
 =?utf-8?B?V2g4UU93WHlIWmRsa2dIci9SZGJqNWFCS2c1eHFBWlR0OC9PVmRwL2xyWTF4?=
 =?utf-8?B?b01WRDcraVJpVGJRZkNRbVE3TndTZ3R6Ukc3ZGVTazZuQlovVUFyN3VLdEVQ?=
 =?utf-8?B?WEZlVUdzWFRhaU1tbStNTU40ckhCMkNROGNzQlZmMnFkdWhpRi9zSm1BU2tl?=
 =?utf-8?B?V01sQUExN0tMMnNaa0Rha0NWRElYVVptclJqbjNCZGY2U3ZyR3dvcmhNYk5p?=
 =?utf-8?B?KzAyRFpvL0IvYVpPYkxybDB0ckJMY0tnQVlVU2dlWTVBV1FTVjNhWEUzYk41?=
 =?utf-8?B?MlEzbTRNaEFKamk0dEo4d3pnTXFqa1FNOXM2LzlUTGFlWnZ6TWdMM2x5RXVI?=
 =?utf-8?B?MUF6TGtOcEdSaWVYeGNSdHNCVk42TXpFNHdtTVN5d2hZRTlabWdqbEdmdHZ6?=
 =?utf-8?B?NWhTK2NyS1BnZmtzRXoySWFmZkNNSXlia1JteDRWa2tXYWxJMFdWZUN1bkI0?=
 =?utf-8?B?azBibmFPSlpIUWxhR2ZPWko0L1ZVQ2M2d3JVR0dTNW42L1l1Qy9yUC9Mek4v?=
 =?utf-8?B?QVhNZXdoN3NJT3dQSTFKbWYzZlNkWkFrUmVaaUhrMFlma21NbnVOcjVGdW4y?=
 =?utf-8?B?WFZnVVFDTTRURE5vTGRUVjlUUGprWUxGQVJFdHRNcVVkemo4UmRjV2FXVGQ0?=
 =?utf-8?B?S1BTeDdTMlRTUHBwVm5YSVhoTDNzcGgwaWlRcnh1T3lPWlFnR1E4d2wxL2hk?=
 =?utf-8?B?bXNWeEFjNkhxNjdpZlE2Wk1UK0JVVHMyR3FvMGdtaGNCd2lBOEx4ZE5aUW4v?=
 =?utf-8?B?NC93ZnJkN3lvcyt2clVjNThEVXBGbGM3ZWd2cDBYdXpQeTJjZzlTMXVhZlQy?=
 =?utf-8?B?LzNnUmZibEUwNmNaQXJaK1NUZm9Ob1hQUmxOOHpFNHFsdXFuUUZ6Z21lZFg3?=
 =?utf-8?B?bVdKRWVtZEJDKzBhMlE1amNyMG81NlJTS0NkODR0UTcwdmFDdHc3dHdxV1Ur?=
 =?utf-8?B?djU5VGVzWWxBTlhNMTlLNjZKcjlZeUM3MVpkNU9ZanJwakJEa0dhR0NzUnox?=
 =?utf-8?B?UEN5V0xkS01JR3VGdkNBeU1PQStnMytjSFQxUXN2UEN4bnhVazBhQUNTUzM2?=
 =?utf-8?Q?uaVCir06Wj4DqXHA0Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3BBC10F4D01A74C86CCF8B393D12963@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba9979f-f3f6-4b37-83ad-08d95c3b6ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 20:14:17.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPMpGV2fudud1kc7PgpSVhl+5IO7ghdoq/wM8ckqq2pQWgY0FNWnKe9wGdjfURcmENc2EfYh+FoBx6PSM0dRww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IE9uIDgvOS8yMDIxIDM6NTcg
UE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IEpvaG4gU3R1bHR6IHdyb3RlOg0KPj4+IE9uIE1v
biwgQXVnIDksIDIwMjEgYXQgMzo0NCBQTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+IHdyb3RlOg0KPj4+Pg0KPj4+PiBKb2huIFN0dWx0eiB3cm90ZToNCj4+Pj4+IElu
IGNvbW1pdCBkMjVkODUwNjFiZDggKCJ1c2I6IGR3YzM6IGdhZGdldDogVXNlDQo+Pj4+PiBsaXN0
X3JlcGxhY2VfaW5pdCgpIGJlZm9yZSB0cmF2ZXJzaW5nIGxpc3RzIiksIGEgbG9jYWwgbGlzdF9o
ZWFkDQo+Pj4+PiB3YXMgaW50cm9kdWNlZCB0byBwcm9jZXNzIHRoZSBzdGFydGVkX2xpc3QgaXRl
bXMgdG8gYXZvaWQgcmFjZXMuDQo+Pj4+Pg0KPj4+Pj4gSG93ZXZlciwgaW4gZHdjM19nYWRnZXRf
ZXBfY2xlYW51cF9jb21wbGV0ZWRfcmVxdWVzdHMoKSBpZg0KPj4+Pj4gZHdjM19nYWRnZXRfZXBf
Y2xlYW51cF9jb21wbGV0ZWRfcmVxdWVzdCgpIGZhaWxzLCB3ZSBicmVhayBlYXJseSwNCj4+Pj4+
IGNhdXNpbmcgdGhlIGl0ZW1zIG9uIHRoZSBsb2NhbCBsaXN0X2hlYWQgdG8gYmUgbG9zdC4NCj4+
Pj4+DQo+Pj4+PiBUaGlzIGlzc3VlIHNob3dlZCB1cCBhcyBwcm9ibGVtcyBvbiB0aGUgZGI4NDVj
L1JCMyBib2FyZCwgd2hlcmUNCj4+Pj4+IGFkYiBjb25uZXRpb25zIHdvdWxkIGZhaWwsIHNob3dp
bmcgdGhlIGRldmljZSBhcyAib2ZmbGluZSIuDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBwYXRjaCB0cmll
cyB0byBmaXggdGhlIGlzc3VlIGJ5IGlmIHdlIGFyZSByZXR1cm5pbmcgZWFybHkNCj4+Pj4+IHdl
IHNwbGljZSBpbiB0aGUgbG9jYWwgbGlzdCBoZWFkIGJhY2sgaW50byB0aGUgc3RhcnRlZF9saXN0
DQo+Pj4+PiBhbmQgcmV0dXJuIChhdm9pZGluZyBhbiBpbmZpbml0ZSBsb29wLCBhcyB0aGUgc3Rh
cnRlZF9saXN0IGlzDQo+Pj4+PiBub3cgbm9uLW51bGwpLg0KPj4+Pj4NCj4+Pj4+IE5vdCBzdXJl
IGlmIHRoaXMgaXMgZnVsbHkgY29ycmVjdCwgYnV0IHNlZW1zIHRvIHdvcmsgZm9yIG1lIHNvIEkN
Cj4+Pj4+IHdhbnRlZCB0byBzaGFyZSBmb3IgZmVlZGJhY2suDQo+Pj4+Pg0KPj4+Pj4gQ2M6IFdl
c2xleSBDaGVuZyA8d2NoZW5nQGNvZGVhdXJvcmEub3JnPg0KPj4+Pj4gQ2M6IEZlbGlwZSBCYWxi
aSA8YmFsYmlAa2VybmVsLm9yZz4NCj4+Pj4+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPj4+Pj4gQ2M6IEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xh
bmQuaGFydmFyZC5lZHU+DQo+Pj4+PiBDYzogSmFjayBQaGFtIDxqYWNrcEBjb2RlYXVyb3JhLm9y
Zz4NCj4+Pj4+IENjOiBUaGluaCBOZ3V5ZW4gPHRoaW5oLm5ndXllbkBzeW5vcHN5cy5jb20+DQo+
Pj4+PiBDYzogVG9kZCBLam9zIDx0a2pvc0Bnb29nbGUuY29tPg0KPj4+Pj4gQ2M6IEFtaXQgUHVu
ZGlyIDxhbWl0LnB1bmRpckBsaW5hcm8ub3JnPg0KPj4+Pj4gQ2M6IFlvbmdRaW4gTGl1IDx5b25n
cWluLmxpdUBsaW5hcm8ub3JnPg0KPj4+Pj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2Fs
QGxpbmFyby5vcmc+DQo+Pj4+PiBDYzogUGV0cmkgR3ludGhlciA8cGd5bnRoZXJAZ29vZ2xlLmNv
bT4NCj4+Pj4+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQo+Pj4+PiBGaXhlczogZDI1
ZDg1MDYxYmQ4ICgidXNiOiBkd2MzOiBnYWRnZXQ6IFVzZSBsaXN0X3JlcGxhY2VfaW5pdCgpIGJl
Zm9yZSB0cmF2ZXJzaW5nIGxpc3RzIikNCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU3R1bHR6
IDxqb2huLnN0dWx0ekBsaW5hcm8ub3JnPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyB8IDYgKysrKysrDQo+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+Pj4gaW5kZXggYjhkNGIyZDMyN2Iy
My4uYTczZWJlOGU3NTAyNCAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+IEBAIC0y
OTkwLDYgKzI5OTAsMTIgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jb21w
bGV0ZWRfcmVxdWVzdHMoc3RydWN0IGR3YzNfZXAgKmRlcCwNCj4+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4+Pj4+ICAgICAgIH0NCj4+Pj4+DQo+Pj4+PiArICAgICBpZiAoIWxp
c3RfZW1wdHkoJmxvY2FsKSkgew0KPj4+Pj4gKyAgICAgICAgICAgICBsaXN0X3NwbGljZV90YWls
KCZsb2NhbCwgJmRlcC0+c3RhcnRlZF9saXN0KTsNCj4+Pj4+ICsgICAgICAgICAgICAgLyogUmV0
dXJuIHNvIHdlIGRvbid0IGhpdCB0aGUgcmVzdGFydCBjYXNlIGFuZCBsb29wIGZvcmV2ZXIgKi8N
Cj4+Pj4+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPj4+Pj4gKyAgICAgfQ0KPj4+Pj4gKw0KPj4+
Pj4gICAgICAgaWYgKCFsaXN0X2VtcHR5KCZkZXAtPnN0YXJ0ZWRfbGlzdCkpDQo+Pj4+PiAgICAg
ICAgICAgICAgIGdvdG8gcmVzdGFydDsNCj4+Pj4+ICB9DQo+Pj4+Pg0KPj4+Pg0KPj4+PiBObywg
d2Ugc2hvdWxkIHJldmVydCB0aGUgY2hhbmdlIGZvcg0KPj4+PiBkd2MzX2dhZGdldF9lcF9jbGVh
dXBfY29tcGxldGVkX3JlcXVlc3RzKCkuIEFzIEkgbWVudGlvbmVkIHByZXZpb3VzbHksDQo+Pj4+
IHdlIGRvbid0IGNsZWFudXAgdGhlIGVudGlyZSBzdGFydGVkX2xpc3QuIElmIHRoZSBvcmlnaW5h
bCBwcm9ibGVtIGlzIGR1ZQ0KPj4+PiB0byBkaXNjb25uZWN0aW9uIGluIHRoZSBtaWRkbGUgb2Yg
cmVxdWVzdCBjb21wbGV0aW9uLCB0aGVuIHdlIGNhbiBqdXN0DQo+Pj4+IGNoZWNrIGZvciBwdWxs
dXBfY29ubmVjdGVkIGFuZCBleGl0IHRoZSBsb29wIGFuZCBsZXQgdGhlDQo+Pj4+IGR3YzNfcmVt
b3ZlX3JlcXVlc3RzKCkgZG8gdGhlIGNsZWFudXAuDQo+Pj4NCj4+PiBPaywgc29ycnksIEkgZGlk
bid0IHJlYWQgeW91ciBtYWlsIGluIGRlcHRoIHVudGlsIEkgaGFkIHRoaXMgcGF0Y2gNCj4+PiBz
ZW50IG91dC4gSWYgYSByZXZlcnQgb2YgZDI1ZDg1MDYxYmQ4IGlzIHRoZSBiZXR0ZXIgZml4LCBJ
J20gZmluZSB3aXRoDQo+Pj4gdGhhdCB0b28uDQo+Pj4NCj4+PiB0aGFua3MNCj4+PiAtam9obg0K
Pj4+DQo+Pg0KPj4gSU1PLCB3ZSBzaG91bGQgcmV2ZXJ0IHRoaXMgcGF0Y2ggZm9yIG5vdyBzaW5j
ZSBpdCB3aWxsIGNhdXNlIHJlZ3Jlc3Npb24uDQo+PiBXZSBjYW4gcmV2aWV3IGFuZCB0ZXN0IGEg
cHJvcGVyIGZpeCBhdCBhIGxhdGVyIHRpbWUuDQo+Pg0KPj4gVGhhbmtzLA0KPj4gVGhpbmgNCj4+
DQo+IA0KPiBBbm90aGVyIHN1Z2dlc3Rpb24gd291bGQganVzdCBiZSB0byByZXBsYWNlIHRoZSBs
b29wIHdpdGggYSB3aGlsZSgpIGxvb3ANCj4gYW5kIHVzaW5nIGxpc3RfZW50cnkoKSBpbnN0ZWFk
LiAgVGhhdCB3YXMgd2hhdCB3YXMgZGlzY3Vzc2VkIGluIHRoZQ0KPiBlYXJsaWVyIHBhdGNoIHNl
cmllcyB3aGljaCBhbHNvIGFkZHJlc3NlcyB0aGUgcHJvYmxlbSBhcyB3ZWxsLiAgSXNzdWUNCj4g
aGVyZSBpcyB0aGUgdG1wIHZhcmlhYmxlIHN0aWxsIGNhcnJpZXMgYSBzdGFsZSByZXF1ZXN0IGFm
dGVyIHRoZSBkd2MzDQo+IGdpdmViYWNrIGlzIGNhbGxlZC4gIFdlIGNhbiBhdm9pZCB0aGF0IGJ5
IGFsd2F5cyBmZXRjaGluZyB0aGUNCj4gbGlzdF9lbnRyeSgpIGluc3RlYWQgb2YgcmVseWluZyBv
biBsaXN0X2Zvcl9lYWNoX3NhZmUoKQ0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8xNjIwNzE2NjM2LTEyNDIyLTEtZ2l0
LXNlbmQtZW1haWwtd2NoZW5nQGNvZGVhdXJvcmEub3JnL19fOyEhQTRGMlI5R19wZyFQMEUxcHYz
QzBQU3REZXBLeXk4aXFLZ1VhT2hEeTBaRGhZZHotX2Nad25KUlFqTmp2dzBNZEpRQ2RVNlh3bnQz
WUFzXyQgDQo+IA0KDQpUaGlzIHNob3VsZCB3b3JrLCBidXQgdGhlIGF3a3dhcmQgdGhpbmcgaXMg
MiBsb29wcyBmcm9tIDIgc2VwYXJhdGUNCnRocmVhZHMgY29tcGV0aW5nIHRvIHJlbW92ZS9naXZl
YmFjayB0aGUgcmVxdWVzdHMgYW5kIG1heSByZXBvcnQgbWl4IHN0YXR1cy4NCg0KQlIsDQpUaGlu
aA0K
