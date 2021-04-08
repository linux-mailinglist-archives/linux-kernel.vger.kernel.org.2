Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C73584F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhDHNki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:40:38 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45818 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231727AbhDHNka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:40:30 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1B4DB405C3;
        Thu,  8 Apr 2021 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617889219; bh=2W/6+qR1Ckhg4z/i3+fCnCsI5ZxEAUpNJPvasiCQvRU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aPCSRpZ3fbJDGfi8C4vu2G5fs7WUfjErgFSljfh2H1eIe6F7mRL+Mt3jQ7pJViG9S
         ZpvBF9hWiikquf8hse1hnVXxD66ot4AMTB6QdyOWYI9j/iA+sJS/mUiNSgHaSzw6RW
         ttnmPLSop2skyjVRtiL1R12KTroN0qW6UU3uujlSNQF1MT9CS4ApwOguavsMadZTvX
         FgRTu8AybFixTEDB7hFkPCM3T4w01QXZWXFBNJvMgL/Y4bFXZVwv8QXXK+yM39MJsZ
         5FAAtIFjfdlUuHhHB2nOY56e828rZNOcOllQFBE49wVAV52lNa43iKx9gnMjaADxQM
         qo7YOwvnD3UFQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0B5A7A007C;
        Thu,  8 Apr 2021 13:40:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A8148400C0;
        Thu,  8 Apr 2021 13:40:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KNeM3iZy";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8OcO635395R4F5tOz9MsNKlUsHzq2mOwVxzAgFC7f8oqbKVIqhoena8PqMYa4t2bg3RwFW6JqRc31/v6CyT98fLYOZjetjozgaFZHr68lXpy/RLyo3KtGUaNGC7XtNdDGG5jt341WqugetffGj3V7K9A/p+UXi8DOXt5GkGPoJtNhnunHrRVLUf+X84n8RPbzp2gjtwiWwW8L6tW2VO18ZaRcPwk3cxeWHkxxU+sJZvKJo8ZhyJfxHBlVizXLLruYBEa/9Hgy97zB2/PoIxCg7vWA1ZheWLSw5bgEZT6GX2/doigKdS67jr//CUKlBrVH6KCSBpf+MzIviwALKPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W/6+qR1Ckhg4z/i3+fCnCsI5ZxEAUpNJPvasiCQvRU=;
 b=bzNI23mySfiF3tEzSlcrxSLmg3UWRPJfga7KpK/pmf1H3LED4dEgRQljcNHcH+WqJpKdBNMlwsCMwej0Y5hOW1jWXbz7CGsfo7uT0rVIz7msN2DHCMOwuYa2Ey6JOLXZ21qE4t0wcGqSTGXUr2sFtThECtAqDWjP61ddkTcvVmSUaIAtg/8GISZ09oHSzRONjW0ho9l6CT9uXeJQrtCC75JN8xSZ4au/wQoXD3SsOzZOCmbo0rDM7JJFh4LnnFyfsjClmC7BGnU20juLGlL8JqUddw5U/YHxNdh01BvppV6iN6FNW+ohNjqXP49WmZdheoO8Amw5vE8gzD/s6mqmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W/6+qR1Ckhg4z/i3+fCnCsI5ZxEAUpNJPvasiCQvRU=;
 b=KNeM3iZy116Eb+GMhBOHCOPDFsl2MpAln5AgoN4KrQ1rRFNpItOi+81/GJ1scLzYQgyi0eDHukAUipfHpLl9LMmtBo2OhmfXUIFDMLDOV8vK3tk3XQfSh3OUxgrSWdC5ms1q3nYKk8bgySt5YbkQOi7gfT78jHuMWX9MeNgS1qQ=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BYAPR12MB2965.namprd12.prod.outlook.com (2603:10b6:a03:ae::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 13:40:17 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 13:40:17 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v3 10/14] usb: dwc2: Allow exit partial power down in urb
 enqueue
Thread-Topic: [PATCH v3 10/14] usb: dwc2: Allow exit partial power down in urb
 enqueue
Thread-Index: AQHXLFvziD4A4V43EEK+bG3n83EmR6qqoLIA
Date:   Thu, 8 Apr 2021 13:40:17 +0000
Message-ID: <5f451cec-65a6-9367-ae50-2ed4eb4b9407@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
 <20210408094542.685BAA0094@mailhost.synopsys.com>
In-Reply-To: <20210408094542.685BAA0094@mailhost.synopsys.com>
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
x-ms-office365-filtering-correlation-id: 93c44f7b-f550-405c-85fe-08d8fa93d891
x-ms-traffictypediagnostic: BYAPR12MB2965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2965AEA3820E490A9247FC79A7749@BYAPR12MB2965.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wCFNbazIZmQAmH7duLZli9WMPl11ty9ASlutDkp2+hx9/Svhp6EPB1NdHWh2FgsaAjuou6yCwaMMj3Qz5r4xcXiKs+dkWMHer0F2wYghJjOXOtGKHLB1KwAHBWbg5/IDZzYR/zR39XJLxLXlJZG56UG8SbFSeuYW9byuL76LvvpqYvxIB+jjBYUB3ipZdjpf4BBqX02Ug0ukNzEUSG8CHSRz85PZPNRhMuv/b+voFW737hvK/seVbIWBagqu37eyZojA9k1haM/rkNB4zmH33Zzbnk9zBKOZ6pVKtWh5s+uZnLkf0IKdY9LChahA2JdFSxoTYfVtH+lNgUA/wd4OYZws7SQdEzIm90ZBK1r0dtFckhLYhakZKOHAtMWggLKlyal6FS5vDjFCLIkF5fZPo5EWfb+3QGkWZ09Go+8oN9fR5NpA6V2fZBn7fx7dWin8dpeE7khvhu5YLfU5NRxjlu/CX5Og8odBEI2S6EDVLtxWMajeYQUSMoh2EUHGN7lYsyWXUNA1pO/vURbVpSAdNpGktS7iNqCCBSG/WCG+NGV6VggavIjEkHGl2q9L0ZaO7OBAC+3olgRV2XshQoNXhiVBsIbwSnlHSXKP+OOT/RRZpdUyAS9S4Twau2nC42Dd52k/Ix0r5qcwynI43L2/4bKrfKklm4rjWiJX/BNGcwv5BninzsPDEh95KEVUUrrzoeewK/OOB5sl7GlUaUf9EzjLt+ATTV4ZwWXb3JLXRc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(39860400002)(346002)(478600001)(83380400001)(8936002)(36756003)(6512007)(8676002)(38100700001)(5660300002)(71200400001)(66476007)(64756008)(4326008)(6486002)(91956017)(66946007)(107886003)(316002)(76116006)(186003)(53546011)(86362001)(31696002)(6506007)(110136005)(31686004)(2616005)(2906002)(66556008)(66446008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZUpzS09UTUtTWHlqQlVDUzc3Y081Q1h5N09IaDVTdkxqT2k3elowSWRvL3RP?=
 =?utf-8?B?YnZwN3hNa3pqZ3diVlJWWjVVcythMXFQUENxaXpJZEdFNmVHY1NHczZ2dXAy?=
 =?utf-8?B?MWlybUZkK0hvNmJDMWRJZmI1bzQ1d21sQ0k0MTNNVlhMdzZDS08xSWxBUzdW?=
 =?utf-8?B?WVowaDhnSDhoWWNhbEt1QXRpMnRaZ05vamlmSGxDK21Rallxc3daQlJtaXZO?=
 =?utf-8?B?MGpwVkxrQ0Zod1dEUWNSY1U3OWxPQkhKU2hQbk9wbVQyeEFKUGVNZ0xnUHBB?=
 =?utf-8?B?QUN5aDdnM09xVVJFMGJNb29RcWxYS3ltZUpVK09HM2VPWVRBelNJQ09qR25m?=
 =?utf-8?B?RmdCTWNma0xqVit3dGpJMG50a2RTM1RSaFdhNjhERkMxOWtkV25PRmQzVG1M?=
 =?utf-8?B?VDFDT21OaTVZZEJMSWV0bjNmQmp5WEdLY2V2QVN3MW5sb0krMjhtZkJMeGR6?=
 =?utf-8?B?RXI0MHQ4RnE4MVFzOGNNYlpIOUw1eWlONTJ0ZkRuakU2VFVmOGh6NVBLemc3?=
 =?utf-8?B?WXZLUzgvczVSckpvVmlYVjFXZThCVHVEaGFTS0UvNlk5SU5EaG9kSDdCbFNl?=
 =?utf-8?B?dUdRZFdFSGJuSlB3MUxiVEFoNlRiUmk5QnJuWWprR2JjVFZOUXRWUnFuemx5?=
 =?utf-8?B?YUFzOEFQTlNnY1lEUjVOeFVNRTlMdDE1eXFiQ0lFT0FtRGkyZ0c2Tlh3VEFi?=
 =?utf-8?B?bnAvVllYM3FhY1Z4SGlrOHFNUzFqT0pHM3JYMEpRQ2U0N0pCS21lUjQrQklq?=
 =?utf-8?B?S2xyUEgva04xSExTaWpEZUFDWFpaY0d1azBEV21oWkJsS0pPWjZpdnhFTFZJ?=
 =?utf-8?B?NkZCV2lMUEU2SE9UNSs4UlVVcDBZSnY4c1BxcVlrT2t4Q3o2VG9Vd0RzYkxC?=
 =?utf-8?B?akJMQXBtRUFuUjhUQ0ZKeUJDQjIyakhHb21KSlc4VlBheVhDcTZuYnlLdGx3?=
 =?utf-8?B?ZWdTR3VkUkhRR0N5ZDZSNUExcEcyZkNad2k3anhKSHVYM0tDb2JteVZPVllY?=
 =?utf-8?B?aVhDdlBENjhEbXVobmVXck53dW5TU0FmK1M3aGZrQjVvRE9xOGNaRTBJcC96?=
 =?utf-8?B?NTRVWXBCUmZMTWVCSEpLazljR0NIaUV1NE1yV29zZHMrS1dyRzM1a3AwSkJQ?=
 =?utf-8?B?K2l3V0xSREZKMnVzZVZ4NXRYaEZlZWRucm9xNHh4SmRoTDZqbWlpcFNDRW9r?=
 =?utf-8?B?ZEF4ZUM4dkZDTmZpSlQwei84T3hUYmdVTm4rUGFwa2E4NHJidXJtMWtkeVR6?=
 =?utf-8?B?L1pEcFBPaE82alNXTHpzR0pVRXdQTkg1Sm12bWdmU21jYXlnMDlHVGM2bjBo?=
 =?utf-8?B?VS9sSTJONjljOFl5SzZjYWlDY2srUW95eWd4SnBrY0xSMHBTdEQrK0Q0U2o3?=
 =?utf-8?B?bGxWdUdtYXJYVjFQcDBGQnNvbysrNnkzN21FSXFmSkFUZy9iMWJsTTU2LzZS?=
 =?utf-8?B?RGU0eHRYUzhDTzFPZk10dTVySVhYelIrdXV5bVVpSFlQeVNkMUJkbjVPMmxR?=
 =?utf-8?B?dzg1c3FlU29SZTZUa0ZTeCtxQzNZZDJlbFdvMkpHb1VXVkNBVEVJN0k0U3A0?=
 =?utf-8?B?TmJ6ekJ4YTR3aFI4WDBUL3BlbkNDOUlWaFRQVnpuVlFuZHZPNnRvdVFlUm1v?=
 =?utf-8?B?ODA2aUJMSnRVZzF0YmtQcWJTOHRmQktHNXd6L0JQc3V6bXEzVXY4WllZdUZG?=
 =?utf-8?B?dVYvRUY2bm1sREQ2bUEwWUhmRVpNODc1aEVMUGUxK3BhbXVTbFpUM1ZRVFJh?=
 =?utf-8?Q?VYqEXgGrF91q5Xd7xk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9FAB0698AEBAE43BB41F56D2D65F96B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c44f7b-f550-405c-85fe-08d8fa93d891
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 13:40:17.1778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTautY34IyltlSfQoji/hNob350H1gSEewzdzizfXDmcH38hcVjI3G4zTpMm+O7pQO2sdSWZ/mnSq+Agm2ubMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzIwMjEgMTo0NSBQTSwgQXJ0dXIgUGV0cm9zeWFuIHdyb3RlOg0KPiBXaGVuIGNvcmUg
aXMgaW4gcGFydGlhbCBwb3dlciBkb3duIHN0YXRlIGFuZCBhbiBleHRlcm5hbA0KPiBodWIgaXMg
Y29ubmVjdGVkLCB1cHBlciBsYXllciBzZW5kcyBVUkIgZW5xdWV1ZSByZXF1ZXN0LA0KPiB3aGlj
aCByZXN1bHRzIGluIHBvcnQgcmVzZXQgaXNzdWUuDQo+IA0KPiBBZGRlZCBleGl0IGZyb20gcGFy
dGlhbCBwb3dlciBkb3duIHN0YXRlIHRvIGF2b2lkIHBvcnQNCj4gcmVzZXQgaXNzdWUgYW5kIHBy
b2Nlc3MgdXBwZXIgbGF5ZXIgcmVxdWVzdCBjb3JyZWN0bHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBBcnR1ciBQZXRyb3N5YW4gPEFydGh1ci5QZXRyb3N5YW5Ac3lub3BzeXMuY29tPg0KDQpBY2tl
ZC1ieTogTWluYXMgSGFydXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4N
Cg0KPiAtLS0NCj4gICBDaGFuZ2VzIGluIHYzOg0KPiAgIC0gTm9uZQ0KPiAgIENoYW5nZXMgaW4g
djI6DQo+ICAgLSBOb25lDQo+IA0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvaGNkLmMgfCA3ICsrKysr
KysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gaW5k
ZXggOTUyOWU5ODM5OTYxLi5jYjUyYmM0MWJmYjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzIvaGNkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBAQCAtNDYzMyw2
ICs0NjMzLDEzIEBAIHN0YXRpYyBpbnQgX2R3YzJfaGNkX3VyYl9lbnF1ZXVlKHN0cnVjdCB1c2Jf
aGNkICpoY2QsIHN0cnVjdCB1cmIgKnVyYiwNCj4gICAJCWR3YzJfZHVtcF91cmJfaW5mbyhoY2Qs
IHVyYiwgInVyYl9lbnF1ZXVlIik7DQo+ICAgCX0NCj4gICANCj4gKwlpZiAoaHNvdGctPmluX3Bw
ZCkgew0KPiArCQlyZXR2YWwgPSBkd2MyX2V4aXRfcGFydGlhbF9wb3dlcl9kb3duKGhzb3RnLCAw
LCB0cnVlKTsNCj4gKwkJaWYgKHJldHZhbCkNCj4gKwkJCWRldl9lcnIoaHNvdGctPmRldiwNCj4g
KwkJCQkiZXhpdCBwYXJ0aWFsX3Bvd2VyX2Rvd24gZmFpbGVkXG4iKTsNCj4gKwl9DQo+ICsNCj4g
ICAJaWYgKCFlcCkNCj4gICAJCXJldHVybiAtRUlOVkFMOw0KPiAgIA0KPiANCg0K
