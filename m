Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E858447B77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhKHH7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:59:40 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48114 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhKHH7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:59:38 -0500
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8473FC20F7;
        Mon,  8 Nov 2021 07:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1636358214; bh=UUPSTLY/BlJtXgQ1pplhgAutjzw0TmGALq3iuvKx49U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kPjUQi1GpBo2PnmaMuw0UgHKWbYVjnAanh+2wXvrGxFBP+VLOdHZU9IvpuWBnbZv+
         p9oesAslf0vvnTsbKtdQRMlfpWCDbDYfa0kNUpkg2y4oIaOEvShA9k8P5C4brTcycF
         4Qidq8NMjiPieCsrc01XZOj6KS6KUEwKQn/6UgzQg9vf+vJ0MMRn/ghd/FBy0rCb9z
         d5ZR/oZQEXjiHh6+jVOxN1mNAf2V+OSYWXq+hfUvoK5mUCDh5PDz01dnwJkXfDpWDL
         hcLWM6t2koMnFaC4pKX+g81AfueZN0rxNWkqfOiIdMreybvterftTWHPwGwbJUOOyl
         rpCvANlwiIFyQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 36919A0080;
        Mon,  8 Nov 2021 07:56:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5B802800C1;
        Mon,  8 Nov 2021 07:56:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="SmRwtHhU";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO9yR4ONnShyOy3rxdhJ6resjvXI8BHBC4DKMaOSE/A9RTKLKrM/uqL134R3ZEDL5wpXD1SEATF4znPsvcCytzgCA8Om8BAkB+qQHNefGwhm+gzr/UtIeAg7ANWNtP9mmXRizc2QBiiI1eXan+/KmQzr90c/GDiBuhCRZltxkU3hDg673tWvdgELsjkQtJ+GVytfSX1OV1N4ineOehs6zHWkq8R70S06eKg17x0FUvqSLabJIVoBzMCKtRlXAj6OZHTBrUsarjFgBEo/MVuEN6JuPZXA9fB9d3xI5RUAyOt2rYvOC5lCUxTo/b44D5WbAlbqIb3q6Hpzn0KCtTzNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUPSTLY/BlJtXgQ1pplhgAutjzw0TmGALq3iuvKx49U=;
 b=hW22NZ9w4b2e6yZH/xS9O4SYYTrEQRlfYuYBK9bb03ah77esHU4/UZfJxmcP9QC9jRSgNNrdYcoVUfz7fYZMmCF+MiC42cZYuRF+uIXOFDdJjwoEVwlr+Nhahfa7EaIQNLDICxfMKLkeD/8/GTAVPonJaAAH3OijK3Ic/OeOVMjy1w7m8U2HRudLYo5o1xWPAQm5C0VIoH98ESOX7Dmh8GNrialv+JC50xuLSgemDEVdUMOOj2vvFak668TXulrq/AOSsHDb9BC16+0aAMSj83sCeoPXSi392VX+U99MbebAqdqId3RMFjzUiP+5X5iVBigfddBOjVW14Ybup2XNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUPSTLY/BlJtXgQ1pplhgAutjzw0TmGALq3iuvKx49U=;
 b=SmRwtHhU1Nc0g7fYaxfrwK+bVtp6xJNc7YfmqyPGBCEXAgoMgMnPW36F+Br+yIsd1W/d9zU+gsZ7QuGWF1+WCQoOq01QUAsIQrLOMixb5hWQOPV53lVKQG1e52W2SBbp4KjRAiOvF0bqlwvZ0EBzHlGaDfH4pjZJ4d2GzVM4tMA=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 07:56:51 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::a0da:c3e5:4562:cea9]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::a0da:c3e5:4562:cea9%6]) with mapi id 15.20.4669.015; Mon, 8 Nov 2021
 07:56:51 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: respect driver's max_speed
Thread-Topic: [PATCH] usb: dwc2: gadget: respect driver's max_speed
Thread-Index: AQHX0mnUhtEm5SmpGEmInJqP6ZYB/qv5R4sA
Date:   Mon, 8 Nov 2021 07:56:50 +0000
Message-ID: <e3652630-f479-185f-0afa-9980a4fdf444@synopsys.com>
References: <20211105172304.1308458-1-john@metanate.com>
In-Reply-To: <20211105172304.1308458-1-john@metanate.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: metanate.com; dkim=none (message not signed)
 header.d=none;metanate.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdf79c70-77c4-4be8-abec-08d9a28d52a4
x-ms-traffictypediagnostic: DM4PR12MB5150:
x-microsoft-antispam-prvs: <DM4PR12MB515058054FA72E8251EE6025A7919@DM4PR12MB5150.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4OzMmsP9GA60UmQ+Tz2rZppVFyfYaboWYt+XMO1JpOlKHfh6pYyHE3CjHf1qC01sBy2voLA8QBUxiik9YODoa3K3JJ0MjqQyMTUEz33sCBpe0oHB0ZYva9U07NIjiZgoSWcXSDPMQKMcF7tHXK6sIXvSSCzrTdUU+jjTgTkwAlZPKgDwXkUjDGFpf15AaLomcGva4h5BEbyegE+jtKQ+9JFdlvxyo1jL9zJS33lhPqsA3wL7nhy59roCSEEfUOU5KCqOSLjE+21RSOgsepLTKHPPwt/KHR/xtP4AgbQEJKzwxArPrOiLfiGUAQgcJz8Oml8k9vVOcyGEJX/zVEYMzzKJhaCSLF6P/p5jmtXcP0rjaek0PDtJfE3D+z41Il+C30zKd/hmkn7AX5upMN1OIvSZZ3l6p7p5fDsw8HJHNBSiuDFX18fiXk6jfmppFab9MWxYohasVs66648yRMCrAGiW8wH79akIokbrndJ0zD70ZUrz7M87iyUh2ZpG5+Fnpbs/2VkiLgNwuAvSH1ITQD1X094KB+FEoWZnlIPHvWpJNel6tMWQdUh1r6kHlJMNmAEzan2+IrFsqybmiQgAA6Obp+ZCscmTSsCVyBgLDWA8CVSu35Oso2w3XpRX65P67C/VcylZzZRnkIc9AmoeM70AULtoLgi9RKvw1D4wqrbH8q0JxMIINlGwRLALMERwvruhn4/Z13L68/0lM/tp2OIEkCjhmPqgmwDXga8OqTlS25Gqz/71ANXlq0cPkvfD90i/4ZMFSAEbhhjkaVvkOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(26005)(91956017)(186003)(8676002)(31686004)(76116006)(6506007)(64756008)(38100700002)(53546011)(66556008)(36756003)(66446008)(8936002)(66476007)(83380400001)(31696002)(66946007)(38070700005)(71200400001)(508600001)(6916009)(5660300002)(6486002)(316002)(54906003)(4326008)(2906002)(86362001)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3h1NERSQ09Sdm1xNUd6OXFiYllsUk5lYjN6NVN3S25DbVMyMFhwVUdiR0Ry?=
 =?utf-8?B?VmZBZVlCNUg4dmlpZzBkZzQ2V2VrenZud1lnNW5ERmRxcGExTE0xMHhGREwv?=
 =?utf-8?B?cmtCYWwxVEQzMFVBbzkvMUpaYUdKa3lEL0VxaGh5UXJQcisvSzloQ3NxL05O?=
 =?utf-8?B?MlYzQXBTT1VnZW9OWHpaNEU5ZGNmS1MrWkpJZmluMytzcnhjemVtTWZTNWdr?=
 =?utf-8?B?VFVKaUsyeUQxRlJGSVY3Y2VWN21NL0R4dEIzWFBHMWxBenRpeVVwZzRlVHZ4?=
 =?utf-8?B?dFpXTXp0MVJTM0FsT3BRYld6TjhmcSs1dFVnR0ZtV20rczVwdEloSTF1VTB2?=
 =?utf-8?B?Y0hSOGhXMmJBcElyMEY5eWdEK1hWU0dVUXpISlRXUmF3dFZpYmRyejFMTlhq?=
 =?utf-8?B?WUw5SU8rend5ZzFVVllNK3VuWnd2M2IzV2o0MENJRTljcGRuZm0ydG9XTWky?=
 =?utf-8?B?OG9FZ0Z2VVJCVlZGUkt1aWdDYUk5dEpvclJVV2F4Mk5WU08zKzVJcC9WS2dp?=
 =?utf-8?B?UlJmaE5nbHBmOGVtT0hJNmlsek5QYS8wQkhsQy90OURSRVNHNWdxT0NodFhl?=
 =?utf-8?B?cnRJd0UyQVlSeVZmN25lcHdDdFczUlpmelZad2VWMkpDTjI5OHNWVWZiVEdl?=
 =?utf-8?B?TnNJMFFGRHVsN1pFdE0ydkVwRGJQSUF0bUxxUHFPM28wbS9YaTBZUDZ5WTlN?=
 =?utf-8?B?WjZHbHpzMlRmYS9LRm5adTlXdTlGSzRWaU4rNEwxOGxMUmpIYURiUzY0L3Q3?=
 =?utf-8?B?Q2k4RTMrY2E2VWtYNjZEWSt2MFNKVGorcUtLQkE5RUdKT0tmVEFhSVJrSzUy?=
 =?utf-8?B?L2RpZ0xOMXQwbmFHZVY4bkQveE1tc3hRb0ZyZVQwcVRvYmJjTXNUSUk4K0VQ?=
 =?utf-8?B?dThtWEFUMXBhcmVyOVNjVUc4YUlpaGJhelVpM1lOb2plYlV4T2VYK1J0YVZ4?=
 =?utf-8?B?T0MvTGRpR3NaYVNwOWpTYkRDZFhUSTFDeXQralNTWm9odEljV0owc3RLblRt?=
 =?utf-8?B?RTdJbEFnaVJ1VVhZeS9zUjhxV2MwVW9RNitKdk90bFBvY1ZLMUFIaGRoRXBF?=
 =?utf-8?B?VGRBS1l3dEtKTjMzdlZrdDRjbVQvMEtQVkJFTEZPTnowTjRhODVSbWlBK0gv?=
 =?utf-8?B?bThNNEkvVGdvL0pINWNVaW1FbUtMRDc0VmVJcXgyR0Frc1N6Qk9KZU1TdzRY?=
 =?utf-8?B?VS9GcGQ4M2RBMy9HNGlnWElCb3RMcjJZc3d2ZzNrTVl0K2U4K2I5U3pmZUlt?=
 =?utf-8?B?eEltQXcxVGw0YzVheE1tckNUZUtRbFdKZzh2QXlhOXYwRE5WT05IOTk1cUtO?=
 =?utf-8?B?U0Y1MnNIa2s4TzFOdHo3dnpvajJYdy9tQzlrN0huaFdsblV4a25TSkFxZ1B1?=
 =?utf-8?B?Sm5SMElzalc2SGFQNmJpZFd6ZmdySjVxOG52ZGlDcy94OWNzYWZtMmY2NGlu?=
 =?utf-8?B?VG5VVjgwQXhOVHJFNDFBdWVmMXFvR1VveHIreTJhTE1xRG1VclJJRUhLMzh4?=
 =?utf-8?B?aWxOSlVJZ0R0eHVrNFowY0V2ZGMrY3J5cXhKdDMvaVNkTnU0ZmRUK0RONjBk?=
 =?utf-8?B?bFJnZmw1VisyNmliV2I2cUhmMHYrTEdNYkY4L1BNdkFkZXkra3lOQlVpY25V?=
 =?utf-8?B?aE1UZGhOZW9VYTRoZ0UwdVpuRHR0VHFiK1oxR1Z6dTUxMzBrMlVqdjBsL2N6?=
 =?utf-8?B?bDRpdXFWM3FLYmtoek9jaFVHeXhUcno4MFBpNEwxdCtuOUtBakdwMkhKdUh2?=
 =?utf-8?B?Q29iR0UwU0FIcnE4NDIwV2JoME51eDF3czRvYmhZRDVsanVJVkdIVldCU1B3?=
 =?utf-8?B?ZGpoTi9XWk16blpKM09OT3ROTG12bmJQYXJycTJ6dmdlUUVoN1FkM0NyWnV1?=
 =?utf-8?B?YnRjM3J2Sis5bjVBK1JERThtNTFhb3RrSy9MYlp3c3Y5SkQ4S1o4VWp5VXZS?=
 =?utf-8?B?aGVuTmhMeTNjNm5ISElYYlRPaTVuKzVFVkFWQ2V2S3FNSGxQVzhqSVl6RDlR?=
 =?utf-8?B?Nk1RMUZiOG1UaW9yN2trZlN0K1RoZ3VXSnM5VEhNYTZwdzdTcDZnMUZkVFNs?=
 =?utf-8?B?N3ZpMWxRb0pSMVpLLzY0b2ttYko0YyszMmY5NkdhR1FJK2YxREw2TzBubHA2?=
 =?utf-8?B?WjU3R3IzZzMzVmRMd3VHMm9yeWwrQm9LcnhCM2VHbEQrR1hDeDJOV2ZMK01G?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D78F3797050464E9614B05C547CFCCF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf79c70-77c4-4be8-abec-08d9a28d52a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 07:56:50.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEbDiSibBJUp7BqH6eslndN+4kVvkrZluaYnffmguxhXla5QNXMzb2x0zn8wIDqSofwCgvgjl99CTOOR2zNJIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNS8yMDIxIDk6MjMgUE0sIEpvaG4gS2VlcGluZyB3cm90ZToNCj4gVURDcyBzaG91bGQg
bm90IGVudW1lcmF0ZSBmYXN0ZXIgdGhhbiB0aGUgbWF4X3NwZWVkIHNldCBieSB0aGUgZ2FkZ2V0
DQo+IGRyaXZlci4gIFVzZSB0aGlzIHRvIGZ1cnRoZXIgcmVzdHJpY3QgdGhlIHNwZWVkIHNldCBp
biB0aGUgRFdDMg0KPiBwYXJhbWV0ZXJzIHNvIHRoYXQgdGhlIGRldmljZSB3aWxsIG5vdCBjb25u
ZWN0IGZhc3RlciB0aGFuIGlzIHN1cHBvcnRlZA0KPiBieSB0aGUgZ2FkZ2V0IGRyaXZlci4NCj4g
DQo+IEZvciBjb25maWdmcy1iYXNlZCBjb21wb3NpdGUgZGV2aWNlcyB0aGlzIGNhbiBiZSBzZXQg
dmlhIHRoZSBtYXhfc3BlZWQNCj4gY29uZmlnZnMgZmlsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEpvaG4gS2VlcGluZyA8am9obkBtZXRhbmF0ZS5jb20+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1
dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5Ac3lub3BzeXMuY29tPg0KDQoNCj4gLS0tDQo+ICAg
ZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzIvZ2Fk
Z2V0LmMNCj4gaW5kZXggNzQ0NTM5Yjc4ZjZjLi4xZjM5YzJmMWJlOGUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9nYWRn
ZXQuYw0KPiBAQCAtMzM3Nyw2ICszMzc3LDcgQEAgdm9pZCBkd2MyX2hzb3RnX2NvcmVfaW5pdF9k
aXNjb25uZWN0ZWQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnLA0KPiAgIAl1MzIgdmFsOw0KPiAg
IAl1MzIgdXNiY2ZnOw0KPiAgIAl1MzIgZGNmZyA9IDA7DQo+ICsJdTggc3BlZWQ7DQo+ICAgCWlu
dCBlcDsNCj4gICANCj4gICAJLyogS2lsbCBhbnkgZXAwIHJlcXVlc3RzIGFzIGNvbnRyb2xsZXIg
d2lsbCBiZSByZWluaXRpYWxpemVkICovDQo+IEBAIC0zNDE4LDcgKzM0MTksMjIgQEAgdm9pZCBk
d2MyX2hzb3RnX2NvcmVfaW5pdF9kaXNjb25uZWN0ZWQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3Rn
LA0KPiAgIA0KPiAgIAlkY2ZnIHw9IERDRkdfRVBNSVNDTlQoMSk7DQo+ICAgDQo+IC0Jc3dpdGNo
IChoc290Zy0+cGFyYW1zLnNwZWVkKSB7DQo+ICsJc3BlZWQgPSBoc290Zy0+cGFyYW1zLnNwZWVk
Ow0KPiArCWlmIChoc290Zy0+ZHJpdmVyKSB7DQo+ICsJCXN3aXRjaCAoaHNvdGctPmRyaXZlci0+
bWF4X3NwZWVkKSB7DQo+ICsJCWNhc2UgVVNCX1NQRUVEX0xPVzoNCj4gKwkJCXNwZWVkID0gRFdD
Ml9TUEVFRF9QQVJBTV9MT1c7DQo+ICsJCQlicmVhazsNCj4gKwkJY2FzZSBVU0JfU1BFRURfRlVM
TDoNCj4gKwkJCWlmIChzcGVlZCAhPSBVU0JfU1BFRURfTE9XKQ0KPiArCQkJCXNwZWVkID0gRFdD
Ml9TUEVFRF9QQVJBTV9GVUxMOw0KPiArCQkJYnJlYWs7DQo+ICsJCWRlZmF1bHQ6DQo+ICsJCQli
cmVhazsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiArCXN3aXRjaCAoc3BlZWQpIHsNCj4gICAJY2Fz
ZSBEV0MyX1NQRUVEX1BBUkFNX0xPVzoNCj4gICAJCWRjZmcgfD0gRENGR19ERVZTUERfTFM7DQo+
ICAgCQlicmVhazsNCj4gDQoNCg==
