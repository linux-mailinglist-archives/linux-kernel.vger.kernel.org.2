Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8277C34DD65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhC3BUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:20:02 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60944 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230100AbhC3BTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:19:45 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8F279C009A;
        Tue, 30 Mar 2021 01:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617067184; bh=9N+bjQ0yIJry1LOjJwjx9x/vh1k0i8SxS0yvo7G2xiw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gXCapc+FwM1VVpj+y9wbuNdfBI/lMy80WHlz5QDuxoD7s/3HYS8OZkeIOaOjjzkDt
         Ovw283FWwahuRwXWchalx7fSqyj0GhNdNV4Yc5EWP7JO7OB/mPtrmU1ZTcQ3XG2s5/
         wyzxby3zGR1taL+3iBztUaT39f7+q7RHuAoMJ7hNKgA9rslOMltthw8sh69PLiGNDC
         /9kk96uIEgTu6wEiUuR7RXvztXikFGcRfPhp0zq0xBMd+7WNStGZ7J/zgpahv9/QQS
         nDDM0sJUtvXYfWXdHRE3gmidHgYtEhqAyCrVE190y/assHUwjgIhJq3z+IXMayI7W/
         gk+yHX/pt1c+g==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 68D08A007C;
        Tue, 30 Mar 2021 01:19:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 80E4B400E5;
        Tue, 30 Mar 2021 01:19:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="B5njO5me";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0fGIV3JBAiOTHUOX9dV1ur3wuePg7VmWZ0uRhIgeICSjc6oBH6l7/vfKWi6jcgXv6R+NzNEXgEnhZimqCUFYErmaoyM+dEYX+UsydYilAbm4rAqUinYZdagA/puHvh+mIlvOb7b3zJpH3DmdYv+dEKCea2Ha+f2Gqlo2Gq3DsEnWNnM/THwLQy9FGbiAOZBuz2l6odsGElFkjosNz7rDqJJ1MxecA16hK5JgE48EroTUSYGO9+Wcsby0EJDXR7pxNaTZKSLXasKCdnRuCDsiOgnIz2NcGaD+zo6Mod+3NGZ6JhNpgJNGouJ5/8HWE6hFX+4zxhprAfaujAGxOQBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N+bjQ0yIJry1LOjJwjx9x/vh1k0i8SxS0yvo7G2xiw=;
 b=b1c0fRoz6IFWQ4V78NPl4qRnuO6UjJ8szrSTcqLJ4fvy+I8RfDaHR0I2RY32UudeEBMHcfJW/BPcLuUMa6TEkbg7bVm447jNBxoO4X8ZNAik7RINJLlvGgASMt9NoMsY1wkcSgFNJr2VXMhlcTsMF2B/oYkycaDouCPYNShamhQ92Jqu2N8tevgWe3XbkWswfrdUvpX9WVJ4DTGz+okx4FR608dHjZ9+qKqu4CaKtRN/ojxb2Op6+6Ez9Yvo3zO11uHjnftml7GEBZczhH/kMMEP311dLKqOgYnCxh7oi1YwEdGMN62NWT2twRYUkIQBdJlHoNHbkkGmhA/wBVWHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N+bjQ0yIJry1LOjJwjx9x/vh1k0i8SxS0yvo7G2xiw=;
 b=B5njO5mewL/gqRHk4w+QL91QK7t+GEWe4BSN5/puAnhVBmDPWpxiK/HXDq6b89/IgiVWOqU4KiZ9MNVGkCn6CWRI8ipfm2Qt0g0Y9oix9CufGk9sECf6+RbjBiLYYSS+zj0kDPyQQ3bpgOnTGNmiq/xeGZsKI6x2/knaYcNqG8U=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2903.namprd12.prod.outlook.com (2603:10b6:a03:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 01:19:39 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 01:19:39 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] usb: dwc3: Fix DRD mode change sequence following
 programming guide
Thread-Topic: [PATCH v3 2/2] usb: dwc3: Fix DRD mode change sequence following
 programming guide
Thread-Index: AQHW5WDIwx81PtjZwki8YDgRRTr5BKp3A20AgAD1lQCAJA72AIAAMscA
Date:   Tue, 30 Mar 2021 01:19:39 +0000
Message-ID: <9af42bff-b083-18f0-1ea8-dca00af583af@synopsys.com>
References: <20210108015115.27920-1-john.stultz@linaro.org>
 <20210108015115.27920-2-john.stultz@linaro.org>
 <eb4b8540-a57c-53cc-a371-cf68178bec15@codeaurora.org>
 <e696b018-b310-5811-5c80-3c50dde297e7@synopsys.com>
 <b08386c0-503d-a333-46be-9df77122ec4e@codeaurora.org>
In-Reply-To: <b08386c0-503d-a333-46be-9df77122ec4e@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0edbf13c-235b-492e-1ced-08d8f319e3cc
x-ms-traffictypediagnostic: BYAPR12MB2903:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29033F5E4C7F4D0AEAA11EDAAA7D9@BYAPR12MB2903.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U6N1AfovXJuS880qy50PYGNokZLfqUSRQoTLxXT8Ial0TEPw9R2YkAXvwwQ6Gi/Wqfbbkui67eVuuaE6bpNGNQ97VUlNBDQuYfiB9oc/LsqkehYAHVK56owq8xInMbhD5j7j31AzdNqMQqVmBJNqYh9wA+OHzq5Bbsbf0HObLqTIofl/AXkkXfgDMgTgksO6pHFL7G5ZGxVmE5wY+CGZ19Ld7pQj9HXQI263fKsZQMmjpyvMMGm9OBBVzcsAPqAuNFCeaye2shjYXOZLJ6nB3udiVKb2GSZgOBV1WILPAebgpPbg0gAUK/nMbejaLXM4kqS8YAZzJ9eDSCzA+WUf7mZytMqzwZRqzjh8CHaCoVFFNpMu+yYxVk/QxKMpcZpFZmLuT9vlP1Akl9k5qcfo6YbfrA5sO9w5WgZylS+VvkwG8GiXIZ0d6Tk90hB77DPLLV15qUj7RT3M7hBdytaMsFKfgG4BZwReIloA42tA/SEk/kwqClCRR0n7CKD1YuzYS58FT8yAN3vku4YvHJ/wSv6J7nZda9QgG2q8yR4VhIAHGkqPLQVVd12D/JgSNNeO1A4uwG/T6qOcHfpYEs8Upcewn4ECTwA/r0ppTB5f/ukUO2pc8avr4SPUyYHcESz+zJLrQWgf8RBfb9ZEGKKTGwXvrYNRaWaYM950AnJD3D8SlaeVo1v0p0TDx088dBdNeQqdTg30AWbAs0GC4pKwHSgjObC50dJfqPclu8wyjRc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(2616005)(186003)(6486002)(76116006)(6512007)(7416002)(2906002)(53546011)(54906003)(31686004)(110136005)(38100700001)(86362001)(8936002)(316002)(66946007)(8676002)(66556008)(5660300002)(66446008)(64756008)(4326008)(36756003)(66476007)(478600001)(83380400001)(26005)(6506007)(31696002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bE1vdkplYS9FMEJqZFQ0RVFSa3RmSk12d3h4c1FmUXMzT1A0NnpJM0Zha3Rk?=
 =?utf-8?B?SGhjVDRYTXdzbEM5MnExTzZ1a2trcXdHYUt3Skh6M2N3bkdGaU1wa0hoc2dx?=
 =?utf-8?B?dE4rRW94SWdJUXEyYXg1elZqQWZUanB6NUNvcmh3S1VUWFR0ZW1UTU5la1Fk?=
 =?utf-8?B?MGZJbVVHVVpKTkdtUk12emNSSG5hRU5NTDRCQmF3c0FzVHNNRm5FNXJ5c1NB?=
 =?utf-8?B?Q3JRR1RhOVhxWU5xTHh5TjNOa1Mrd3poc2lmbDY4a3BWSnJQNDhFRy92WnhE?=
 =?utf-8?B?UkNMNVliay9PZStQNmt4REdYMW4rSW9rNldhdlAvQ2labUlxdHJvTW1ocDg5?=
 =?utf-8?B?bDF0QjA3NUpWV2t3YjdJU0FPUmNUNW5najl2S1hSenB4UTEyRkhIVEdjNk0x?=
 =?utf-8?B?WVhYdlRCTVNLY3EzRjF3WnZFcEVzbGR2Mk9hNXdrMDI4VkFtNUVtN3pXZHdp?=
 =?utf-8?B?Tm50N1NVRk5FWktlSjZNcTBYZll5cW02Um1PbERHajE4Rjg3enllQzR3Q0dX?=
 =?utf-8?B?bk93MGhWNGdxbkpQZEV4MEZwQ1dWeExLWW4rOEl5SE1aYTU1NlAyd080VUVs?=
 =?utf-8?B?MkxFdEE3WUJaWFFnRXdBZkdnanc2V2RpaDZYYXRZa2sxNTVFOFRmM2JsQmdT?=
 =?utf-8?B?ckF4eis4eVFrZndWcm5yZU44TkRTcE1TekQ2SzVkTW95SzhRMVphWitwUjNO?=
 =?utf-8?B?akFIK0xwL08vc0JGQ3p2ZWtqMU9YWnZwYUc1SEJkL0JwLzVTY1k3WU9IT05q?=
 =?utf-8?B?ekhoT1FEazI5cWU3QVlIdnZjb3c1S2gzUDVZTk9xeDJyM0wvOVUySzFLOE0z?=
 =?utf-8?B?UVpYOUF1L1NxNGMwTlZYbSt6T2duTFBIUkJKbzBqc0NnTFg3aGpJWmpJTVVx?=
 =?utf-8?B?NGwrOUpqbjZjOHBqL1V5bTlibFpNYVZyc3puYU1ZSHAzamhPZStBL1dQa3hx?=
 =?utf-8?B?d2pnWjNIZ3RHZ1NoMFR4TGJVR2t1MVp4SGk0eHRBMjF2Vjl5YTFnRzU3b1Rs?=
 =?utf-8?B?ZVBEcCsrUUoxYXVjZS9oREhndHRhenlQVDVINDlIbG9KNldRbXdvYTl6ejI4?=
 =?utf-8?B?OE9yckNxWmxWQWc3aThDQ2U4d0duUTdzSStENWsvWitUNmRMQVA5Mzc4Rjky?=
 =?utf-8?B?dENKZUhoYXUrR3B5a09leDNGYnpzY3ZJRjBnRGlRWFFwN28weWw1Q2F3T1c0?=
 =?utf-8?B?eWxpQ1BHUk1zcFVOTGdUazZHVXRWRk01TE9MelFFZTY2TVROV0hiQU8yTkVO?=
 =?utf-8?B?OVkzcDUxSjRuWnFnMyt5eE1SQmYvYTZhZG41a0dWNXZtYnk1aTcrS2hSQTlv?=
 =?utf-8?B?Z1VBdVgxTEJtQlE1ZlNRQlh2OUtLd01yaFQ3clZtMkllbW1YTkEwdWlkQXg1?=
 =?utf-8?B?UU9HTTlRQkd0UDdnNHNaZ0xyTWF1TnNxZ2Z2L3J6dzRYSExVTmhQcElFOTBI?=
 =?utf-8?B?OHkvVnd2eEpTenVpMXpjUHZqdVk0VDZkNWgxak9XMis1NkZNb3d6Wk1BMTRW?=
 =?utf-8?B?VW0rdm9hK1NyWHo4SGNOVCt0V2ZvNS80RW53ckRPbDNFdm5CSHZUdGZTaGRU?=
 =?utf-8?B?NENrRk5WMVk1ZFZPTkplRnZiSWQ5SVlvbFJ4UkhDbTc2aDYwM3dvQ1VpTUcx?=
 =?utf-8?B?YURqVThxcndpVFovUjBsMmp1RHhiVHlxYXJ5VmIrNWNTTnNBNjdwbXUyQUJQ?=
 =?utf-8?B?cTNXNVpWVmlwM293cysvVmpOSFp1QzYyT2VZN1RnQkJlM3Rod1k0OEZJaXg4?=
 =?utf-8?Q?GdYjWpW/HVFDOeTLYw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF826C00E63D1D42964539744633F0C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edbf13c-235b-492e-1ced-08d8f319e3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 01:19:39.2273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZbWOO6iikfEEB623flmKoEHZyqg+VFc+HDYX7zyfKnb7q115W5F2h8+PsMrQRI/CR1yNoazRmogIjujn5xAsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2903
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDMvNi8yMDIxIDM6MzkgUE0sIFRoaW5o
IE5ndXllbiB3cm90ZToNCj4+IFdlc2xleSBDaGVuZyB3cm90ZToNCj4+Pg0KPj4+IE9uIDEvNy8y
MDIxIDU6NTEgUE0sIEpvaG4gU3R1bHR6IHdyb3RlOg0KPj4+PiBJbiByZXZpZXdpbmcgdGhlIHBy
ZXZpb3VzIHBhdGNoLCBUaGluaCBOZ3V5ZW4gcG9pbnRlZCBvdXQgdGhhdA0KPj4+PiB0aGUgRFJE
IG1vZGUgY2hhbmdlIHNlcXVlbmNlIHNob3VsZCBiZSBsaWtlIHRoZSBmb2xsb3dpbmcgd2hlbg0K
Pj4+PiBzd2l0Y2hpbmcgZnJvbSBob3N0IC0+IGRldmljZSBhY2NvcmRpbmcgdG8gdGhlIHByb2dy
YW1taW5nIGd1aWRlDQo+Pj4+IChmb3IgYWxsIERSRCBJUHMpOg0KPj4+PiAxLiBSZXNldCBjb250
cm9sbGVyIHdpdGggR0NUTC5Db3JlU29mdFJlc2V0DQo+Pj4+IDIuIFNldCBHQ1RMLlBydENhcERp
cihkZXZpY2UpDQo+Pj4+IDMuIFNvZnQgcmVzZXQgd2l0aCBEQ1RMLkNTZnRSc3QNCj4+Pj4gNC4g
VGhlbiBmb2xsb3cgdXAgd2l0aCB0aGUgaW5pdGlhbGl6aW5nIHJlZ2lzdGVycyBzZXF1ZW5jZQ0K
Pj4+Pg0KPj4+PiBUaGUgY3VycmVudCBjb2RlIGRvZXM6DQo+Pj4+IGEuIFNvZnQgcmVzZXQgd2l0
aCBEQ1RMLkNTZnRSc3Qgb24gZHJpdmVyIHByb2JlDQo+Pj4+IGIuIFJlc2V0IGNvbnRyb2xsZXIg
d2l0aCBHQ1RMLkNvcmVTb2Z0UmVzZXQgKGFkZGVkIGluIHByZXZpb3VzDQo+Pj4+ICAgIHBhdGNo
KQ0KPj4+PiBjLiBTZXQgR0NUTC5QcnRDYXBEaXIoZGV2aWNlKQ0KPj4+PiBkLiA8IG1pc3Npbmcg
RENUTC5DU2Z0UnN0ID4NCj4+Pj4gZS4gVGhlbiBmb2xsb3cgdXAgd2l0aCBpbml0aWFsaXppbmcg
cmVnaXN0ZXJzIHNlcXVlbmNlDQo+Pj4+DQo+Pj4+IFNvIHRoaXMgcGF0Y2ggYWRkcyB0aGUgRENU
TC5DU2Z0UnN0IHNvZnQgcmVzZXQgdGhhdCB3YXMgY3VycmVudGx5DQo+Pj4+IG1pc3NpbmcgZnJv
bSB0aGUgZHdjMyBtb2RlIHN3aXRjaGluZy4NCj4+Pj4NCj4+Pj4gQ2M6IEZlbGlwZSBCYWxiaSA8
YmFsYmlAa2VybmVsLm9yZz4NCj4+Pj4gQ2M6IFRlamFzIEpvZ2xla2FyIDx0ZWphcy5qb2dsZWth
ckBzeW5vcHN5cy5jb20+DQo+Pj4+IENjOiBZYW5nIEZlaSA8ZmVpLnlhbmdAaW50ZWwuY29tPg0K
Pj4+PiBDYzogWW9uZ1FpbiBMaXUgPHlvbmdxaW4ubGl1QGxpbmFyby5vcmc+DQo+Pj4+IENjOiBB
bmRyemVqIFBpZXRyYXNpZXdpY3ogPGFuZHJ6ZWoucEBjb2xsYWJvcmEuY29tPg0KPj4+PiBDYzog
VGhpbmggTmd1eWVuIDx0aGluaG5Ac3lub3BzeXMuY29tPg0KPj4+PiBDYzogSnVuIExpIDxsaWp1
bi5rZXJuZWxAZ21haWwuY29tPg0KPj4+PiBDYzogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hl
aGFiK2h1YXdlaUBrZXJuZWwub3JnPg0KPj4+PiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4+Pj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5v
cmcNCj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5v
cmc+DQo+Pj4+IC0tLQ0KPj4+PiBGZWVkYmFjayB3b3VsZCBiZSBhcHByZWNpYXRlZC4gSSdtIGEg
bGl0dGxlIHdvcnJpZWQgSSBzaG91bGQgYmUNCj4+Pj4gY29uZGl0aW9uYWxpemluZyB0aGUgRENU
TC5DU2Z0UnN0IG9uIERSRCBtb2RlIGNvbnRyb2xsZXJzLCBidXQNCj4+Pj4gSSdtIHJlYWxseSBu
b3Qgc3VyZSB3aGF0IHRoZSByaWdodCB0aGluZyB0byBkbyBpcyBmb3Igbm9uLURSRA0KPj4+PiBt
b2RlIGNvbnRyb2xsZXJzLg0KPj4+PiAtLS0NCj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5j
IHwgMyArKysNCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4+Pj4NCj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4+Pj4gaW5kZXggYjZhNmI5MGViMmQ1Li43MWY4YjA3ZWNiOTkgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+Pj4+IEBAIC00MCw2ICs0MCw4IEBADQo+Pj4+ICANCj4+Pj4gICNkZWZp
bmUgRFdDM19ERUZBVUxUX0FVVE9TVVNQRU5EX0RFTEFZCTUwMDAgLyogbXMgKi8NCj4+Pj4gIA0K
Pj4+PiArc3RhdGljIGludCBkd2MzX2NvcmVfc29mdF9yZXNldChzdHJ1Y3QgZHdjMyAqZHdjKTsN
Cj4+Pj4gKw0KPj4+PiAgLyoqDQo+Pj4+ICAgKiBkd2MzX2dldF9kcl9tb2RlIC0gVmFsaWRhdGVz
IGFuZCBzZXRzIGRyX21vZGUNCj4+Pj4gICAqIEBkd2M6IHBvaW50ZXIgdG8gb3VyIGNvbnRleHQg
c3RydWN0dXJlDQo+Pj4+IEBAIC0xNzcsNiArMTc5LDcgQEAgc3RhdGljIHZvaWQgX19kd2MzX3Nl
dF9tb2RlKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4+Pj4gIA0KPj4+PiAgCWR3YzNfc2V0
X3BydGNhcChkd2MsIGR3Yy0+ZGVzaXJlZF9kcl9yb2xlKTsNCj4+Pj4gIA0KPj4+PiArCWR3YzNf
Y29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+Pj4gSGkgSm9obi9UaGluaC9GZWxpcGUsDQo+Pj4NCj4+
PiBJIGFjdHVhbGx5IGFkZGVkIHRoaXMgY2hhbmdlIGludG8gbXkgbG9jYWwgYnJhbmNoLCBiZWNh
dXNlIHdlIHdlcmUNCj4+PiBzZWVpbmcgYW4gaXNzdWUgd2hlbiBzd2l0Y2hpbmcgZnJvbSBob3N0
IG1vZGUgLS0+IHBlcmlwaGVyYWwgbW9kZS4gIFdoYXQNCj4+PiB3YXMgaGFwcGVuaW5nIHdhcyB0
aGF0IHRoZSBSWEZJRk8gcmVnaXN0ZXIgZGlkIG5vdCB1cGRhdGUgYmFjayB0byB0aGUNCj4+PiBl
eHBlY3RlZCB2YWx1ZSBmb3IgcGVyaXBoZXJhbCBtb2RlIGJ5IHRoZSB0aW1lDQo+Pj4gZHdjM19n
YWRnZXRfaW5pdF9vdXRfZW5kcG9pbnQoKSB3YXMgZXhlY3V0ZWQuICBXaXRoIHRoZSBsb2dpYyB0
bw0KPj4+IGNhbGN1bGF0ZSB0aGUgRVAgbWF4IHBhY2tldCBsaW1pdCBiYXNlZCBvbiBSWEZJRk8g
cmVnLCB0aGlzIGNhdXNlZCBhbGwNCj4+PiBFUHMgdG8gYmUgc2V0IHdpdGggYW4gRVAgbWF4IGxp
bWl0IG9mIDAuDQo+Pj4NCj4+PiBXaXRoIHRoaXMgY2hhbmdlLCBpdCBzZWVtZWQgdG8gaGVscCB3
aXRoIHRoZSBhYm92ZSBpc3N1ZS4gIEhvd2V2ZXIsIGNhbg0KPj4+IHdlIGNvbnNpZGVyIG1vdmlu
ZyB0aGUgY29yZSBzb2Z0IHJlc2V0IG91dHNpZGUgdGhlIHNwaW5sb2NrPyAgQXQgbGVhc3QNCj4+
PiB3aXRoIG91ciBQSFkgaW5pdCByb3V0aW5lcywgd2UgaGF2ZSBzb21lIG1zbGVlcCgpIGNhbGxz
IGZvciB3YWl0aW5nIGZvcg0KPj4+IHRoZSBQSFlzIHRvIGJlIHJlYWR5LCB3aGljaCB3aWxsIGVu
ZCB1cCBhcyBhIHNsZWVwaW5nIHdoaWxlIGF0b21pYyBidWcuDQo+Pj4gKG5vdCBzdXJlIGlmIFBI
WSBpbml0IGlzIHJlcXVpcmVkIHRvIGJlIGNhbGxlZCBpbiBhdG9taWMgY29udGV4dCkNCj4+Pg0K
Pj4+IFRoYW5rcw0KPj4+IFdlc2xleSBDaGVuZw0KPj4NCj4+IEhpIFdlc2xleSwNCj4+DQo+PiBU
aGFua3MgZm9yIGxldHRpbmcgdXMga25vdyB0aGUgaXNzdWUgeW91J3JlIGhhdmluZyBhbHNvLg0K
Pj4NCj4+IFllcywgeW91IG5lZWQgdG8gd2FpdCBhIGNlcnRhaW4gYW1vdW50IG9mIHRpbWUgdG8g
c3luY2hyb25pemUgd2l0aCB0aGUNCj4+IFBIWSAoYXQgbGVhc3QgNTBtcyBmb3IgZHdjX3VzYjMy
IGFuZCBkd2NfdXNiMzEgdjEuODBhIGFuZCBhYm92ZSwgYW5kDQo+PiBsZXNzIGZvciBvbGRlciB2
ZXJzaW9ucykuIFdoZW4gcmVtb3ZpbmcgdGhlIHNwaW5sb2NrIHRvIHVzZSBtc2xlZXAoKSwNCj4+
IGp1c3QgbWFrZSBzdXJlIHRoYXQgdGhlcmUncyBubyByYWNlIGlzc3VlLiBCVFcsIGhvdyBsb25n
IGRvZXMgeW91ciBzZXR1cA0KPj4gbmVlZCB0byBtc2xlZXAoKT8NCj4+DQo+IEhpIFRoaW5oLA0K
PiANCj4gU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNlLiAgTXkgbWlzdGFrZSwgaXRzIGFjdHVh
bGx5IGp1c3QgYSB1c2xlZXAoKQ0KPiBmb3IgYSBsZXNzIHRoYW4gMTAwdVMgKHBvbGxpbmcgZm9y
IGEgc3RhdHVzIGJpdCBjaGFuZ2UsIHNvIGl0IHdpbGwgZXhpdA0KPiBlYXJseSBpZiBwb3NzaWJs
ZSkuICBGb3IgdGhpcyBjaGFuZ2UsIGNhbiB3ZSBqdXN0IG1vdmUgdGhlDQo+IGR3YzNfY29yZV9z
b2Z0X3Jlc2V0KCkgb3V0c2lkZSBvZiB0aGUgc3BpbmxvY2s/DQo+IA0KPiBUaGFua3MNCj4gV2Vz
bGV5IENoZW5nDQo+IA0KDQoNCkhpIFdlc2xleSwNCg0KZHdjMyBjYW4gZ2V0IG5vdGlmaWVkIGF0
IGFueSB0aW1lIHRvIHF1ZXVlIGEgd29yayB0byBzd2l0Y2ggbW9kZS4gU28geW91DQpuZWVkIHBy
b3RlY3QgaXQgZnJvbSBhIHBvdGVudGlhbCByYWNlLiBJIHRoaW5rIHlvdSBjYW4gdXNlIGEgbXV0
ZXggZm9yIHRoaXMuDQoNCkFsc28sIHdoYXQgc3RhdHVzIGFyZSB5b3UgcG9sbGluZz8gTm90ZSB0
aGF0IHRoZXJlJ3Mgbm8gc3RhdHVzIGJpdCBmb3INCkdDVEwuY29yZXNvZnRyZXNldC4gRm9yIERD
VEwuQ1NGVFJTVCwgZGlmZmVyZW50IGNvbnRyb2xsZXIgdmVyc2lvbnMNCmJlaGF2ZSBkaWZmZXJl
bnRseS4gVXNlIGR3YzNfY29yZV9zb2Z0X3Jlc2V0KCkgZm9yIERDVEwuQ1NGVFJTVCB0byBnZXQN
CnRoZSBsb2dpYyBmcm9tIHRoZXJlLg0KDQoxIG1vcmUgdGhpbmcsIG1ha2Ugc3VyZSB0aGF0IHRo
aXMgZmxvdyBvbmx5IGFwcGxpZXMgZm9yIERSRCBtb2RlDQpjb250cm9sbGVyIGFuZCBub3QgT1RH
IGZyb20gb2xkZXIgRFdDX3VzYjMgSVAuDQoNClRoYW5rcywNClRoaW5oDQo=
