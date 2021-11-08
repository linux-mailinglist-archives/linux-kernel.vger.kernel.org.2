Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7CE448011
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbhKHNND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:13:03 -0500
Received: from mail-eopbgr1300084.outbound.protection.outlook.com ([40.107.130.84]:48756
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238803AbhKHNNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:13:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKALsxYdg6cGxu2V/FbO5RqWmPoFCUbt6UWlZs3Ks3M+hg0QspI4jOV49XlvQ1ohCdkBN60TNMhj/hJ+3m/R6Uo73jwOE6f+lEajssaOUq7c5xYHtv40CmI4YaO3M3RqVT7YJGFZLdVu71uA43/yrtiP8BRIc0HK26HwjATqATZYCwswHbekCWmIAKkSQKaD3sKlsyao4SqG8FrNM+KTcmGBoGThUIOkAHirS1Kea9Lppc11W5bOlWr7hIPYdngHOR3LTB/rSY0vPMMLZosApSzEHoHTFBAHj14aSqc1htzpRG/1vq/92eGXXSKP8y5/SCjppFcYFwEvtFo+RIRlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPhJCjZxE+SZ1bTvYDFkINagmwI2H5jRBuBpFmR/yMk=;
 b=iWiej++KkOS2RrCA32eQR3ZayiQv7ADaJ5Z1PvgI/BEganhKU9BqABBbzrGhSuOjmgY1ulnT6W9ZigCvCa7Y7QhzrMGzKXuD4zJyMHcv0///jL7s3Tjk7kCzmFRWCZTvaL5K/z97IsK/E+0JXMrQ5v30NoaUXWI8YxrwXZec7CzhvOAxZfCVzKZ3IvFuUrpPiVeZ+Yi5K7BpTQZJ6AuLQf8FTssLV5bvkn/5Y8KxQjrqK/JaEVnIBWXjRhVIXRhaFkvVGv0W3cIGSwO27a3S2trDLd+87wyDKbnln2N12/VSjIOJGi0qLhwNTBVRk3FKBUO3X8BtEyJKXaTHSM2gKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPhJCjZxE+SZ1bTvYDFkINagmwI2H5jRBuBpFmR/yMk=;
 b=WnUBHSxZ0BjbXNEL8Numa379xZA4txGljJyaQEGTMmRcDgaNCac8QPN3MYl2cB4uWcjdTfRez8GW+qTtwtBgVz3rfncsGLKYD/KHTJAzyntfor5f9hjEPXk3/5nk8toAEpro07LMvSF59RA7xaDqwvYpQaSBxhnosq9PdJ21YYo=
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com (2603:1096:802:22::12)
 by KL1PR02MB4530.apcprd02.prod.outlook.com (2603:1096:820:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 13:10:14 +0000
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8]) by KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 13:10:14 +0000
From:   =?utf-8?B?6IOh5ZCv6IiqKE5pY2sgSHUp?= <huqihang@oppo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: gadget: composite: Fix null pointer exception
Thread-Topic: [PATCH v2] usb: gadget: composite: Fix null pointer exception
Thread-Index: AQHX0jK4VLpQhw8UMEatV/SgvUblXKv04WCAgAS0XLCAAAXDAIAAAICA
Date:   Mon, 8 Nov 2021 13:10:14 +0000
Message-ID: <KU1PR02MB2536DA8D51945A1CD85A9C09B0919@KU1PR02MB2536.apcprd02.prod.outlook.com>
References: <20211105104840.159533-1-huqihang@oppo.com>
 <YYUnM0/82FwS5OUE@kroah.com>
 <KU1PR02MB253627CFDBE573DE95F3A09EB0919@KU1PR02MB2536.apcprd02.prod.outlook.com>
 <YYkeUgz1wr4s772X@kroah.com>
In-Reply-To: <YYkeUgz1wr4s772X@kroah.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce852cdb-9d93-481e-5e7e-08d9a2b91a61
x-ms-traffictypediagnostic: KL1PR02MB4530:
x-microsoft-antispam-prvs: <KL1PR02MB4530AFC02355B963BA991674B0919@KL1PR02MB4530.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAhzcX9K+PQyOCzG2r0ja51h3vgOv2DodMOFTM1zA2pyXQ0l1KT7LDUCAxSzfJpejaotm9xHZtdlAzkdk6IYSl9YP3RmiFMVgfv9UVhaDREQ0YvLskmFvruQVAx4U4ZQxzIEJyrVaqBK3DXekQ0rDRLzF3aC1V8kovuZHMTlGHz3aBMuQrc62BvGI4wTza5VZA13jDlamUQ5nGcNgIGFjZ5v1Dpm22j/E3O3OwPeCqFg3FRoubfQZdbwqzRhS/ugFnTRFdPRHssDOlKQ4LJRBfaKTmz26Gd8ojmGygl5rPLDAdpwghH+ER5o32gF5qqUsZ+Cc2djmTeO0yhs6nPbQ7YFgax71sDjFe0XsC4JDnMU9lXUiF/u2DSDAKitsLhZ5+OlTuu2fIwhNfuX0hZx7EmkwMUf+ipobt3xsb56OQsym0Xa2+7I5sfrfzKTTqOycBbOS2vCFcbHRUfkumkpw3V2StnB1Y4yEExWvdvFTc/218eWsx97zfXXMWxjQnNIj5y669phjpZBUmR3fINBI4+5qPxbfvSOpeXFOs0gkvJplcI6bg8QjOmAJP5NC5M562h2BgVYV+sJmiHADWipPmOxIu4N210mYubgd0hvrE5GobO4NDIgVNFXvztByUttWz3SPGvHG0wSpUb5tlQPm+1SkukiIkG1l6K1DEWbyR5Ld3VFHk00coSQbIFJzzZhZ3K8YxkxqZBzX6MChav5sx9xqdr3tl0LF7CL7RR9ZBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1PR02MB2536.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(7696005)(38100700002)(4326008)(5660300002)(316002)(38070700005)(2906002)(52536014)(8676002)(71200400001)(66946007)(55016002)(33656002)(186003)(54906003)(66476007)(8936002)(76116006)(64756008)(6916009)(66446008)(66556008)(53546011)(6506007)(83380400001)(26005)(508600001)(122000001)(86362001)(9686003)(11606007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkkzTldaV3ZRUXZ0bkd4TDJmdjlzMUlWTWhjNHkxOVRCT1BzZy8vcFM0SmFY?=
 =?utf-8?B?OHpmVndVZWFMa0tLUVFsUTlybmk1M3BVWXpmRzlaY25wWlRmUlZ6QmdydWZZ?=
 =?utf-8?B?Qjl2ek5rV3c1RGVpL085OVVnTGV1UTlGSHNYZkpXckd6MVdicUFaOE4rZzlX?=
 =?utf-8?B?bkcwUkNDTkVZdWRPeXpRR3dmcWEvRmVORkN3dXJ3WlpQajZwYUFqbmNyOU5s?=
 =?utf-8?B?L3h4ZzYxa1VrQmNPWGllRUY0NkcvL3VKblhxenpSeHltQUg2RHVMUGlaVFJC?=
 =?utf-8?B?V21MTTFyVjNoaG5CZ1FmRmRCaUxhV0JYR0Z2Zk9RTjU4M1hzekhTWTlLR3Za?=
 =?utf-8?B?c2N5emFsbVEvRzB4UUJZcWFJdEtPMUdXenE0M29tNFE0QWppdzNnSkRNWFVu?=
 =?utf-8?B?bG90dzROUktMWk9GYUo5UkRXY05UL1VtTjhyREEvemJoWDdwSHAya2dBZDVq?=
 =?utf-8?B?a09id1BmalpzOTNEYlYrVXhtdEgwbUh4dEM0cGZXSXhSenYyOXlyWTFpVTNw?=
 =?utf-8?B?VFRRK2lrTmV1VFNyTHNmWGpXaUlZOVhYaENFdkYzOHNGMHdpcXpHc0NNakRu?=
 =?utf-8?B?OU9GZ0Mwa0UxUXJHR0poajBubGoxbWdaYUZiM1VMVTRwbmtjZzdWQWhIRS9v?=
 =?utf-8?B?TnRiMUZZT0x6bGh3ejZuNmxibStweWgyUGpuNHhmMThpOFA4eE04UzZUNGdD?=
 =?utf-8?B?NW8xTHk5cnNwTXZyRkhIaG5xVm16ZzM4RnZWZjlrVzJveDRwSFhwR2VVRzE4?=
 =?utf-8?B?NHJ2OTZkMUtReXJNVG1yK1ZUTkRXVkowV0JER3pObW56MUZTTWN4WUlkQU5T?=
 =?utf-8?B?em9kelliNHE3U1pDTFR3Q1F1dTZiMUJGMEhTTTRlOFRrMm0wb2hSK0FQVTJr?=
 =?utf-8?B?SHJoZU1vMGNsNXlDWGxMMkZFRmtSODhTdGhobFBLUkZQcUdjRGpiNlNiQ2xT?=
 =?utf-8?B?TVVjRjF1eTA2MVZWWWlnRjE0WnBZclN4VFBEMkRrT3c2cWpLcDNVeWNRN3Vs?=
 =?utf-8?B?Q2xRWWJ5SVBBcDg0dzdjRWVmV0JLaytnYWdCcXRZMm5LRDVEK3VoRFFDai8w?=
 =?utf-8?B?TFBJajc4OFpEc2ZUMlBCWklJTmVUdXhJbmhkWS9UR1BYa3pXbnV0anZPZTMy?=
 =?utf-8?B?d2diUEptLzkrNlJ5MlVmdGNaN1FPdktWNHp2T1VtQUNudElZU29aNi9iSWk1?=
 =?utf-8?B?bytoUkFqazBqS0YrZ1NDaGluWWhUb0QzQmZkdmJDTm1qZ1hIejA1eGF4RlRq?=
 =?utf-8?B?RDVsWStJWkJKbUVQM3hZcWFXazFqQWhFUS8xSnJjNlFTZjl0Z2dZNmpKUjZi?=
 =?utf-8?B?TzRrT2M0VmVVRnpkeXRZT3RNckFSQWRsNGJxODhqRnMyMTkyR3R6MWRwM0h6?=
 =?utf-8?B?MFkzK1gvbHZieFdzOHpSM1hCYlM3WWFYWU5JZ0dMV1pmTXRPdElxQ3ZIYjd1?=
 =?utf-8?B?NkovNExGbDJJY01DYlFoMytrbWNWTXBOMytWNVVUNzdUd1kvTWg2dGlPZkNt?=
 =?utf-8?B?cGRqWUlNb0NyaG5wT2QxbWYwNlF2QzhQT005SXlTRlZQcUJNTWQvTkdvNHlL?=
 =?utf-8?B?cGVoN0dsV0lzNWtiMExzSDFXRGJNOFNtRFBwVllNNzRRSEhZczdBS05SN3ZN?=
 =?utf-8?B?WEcwbjRRcm0yZWkyVnovMGNiejRINlBVTXYzaDExelNoVWlOOGdxNHhLV2l4?=
 =?utf-8?B?Zm40N1l1YWtxbWRQZWFpRjcwWkFYcFNCdVBtWFUxZXpuSDBsRWtUQnlZY1dn?=
 =?utf-8?B?UWZ4RHpwRU1maDB2aExwdi9ldjlZakpKRWhtczRUbWEvYkJPS2oxVUtXWHRV?=
 =?utf-8?B?QjdkSk1pSWpwZFhwMVZxVUIxc2MwZGFFUFJkeTNjcTNaKzlITEcxcEFVaXRU?=
 =?utf-8?B?UEppMG9kU1hINkZHckJjTHd4SW5KUUR4T2hqTy9LRmljUnludVVNUkVvQ3l3?=
 =?utf-8?B?ck11QnplRlM0Q1RmSEFvdWdXdThOVnR2eERvRE1wRnZYK1U5VkZWRHZGcFNm?=
 =?utf-8?B?Vkhzdjdxc0lrOW1ING9ISEJFOGpHVTYxMTh6eTYvdlg4K0ZrUENUQXZ6NVdK?=
 =?utf-8?B?RStvK1lhR3dPMDhuNlBoemtoMTQ3b1k3YTRrbEdYd0VJekRMT3ViRHVNQnpU?=
 =?utf-8?B?WjlTWW13NGdidE5TSTJzaTFZSDVPeVJOamVvdHRYTG1mdFZSQXdMQVFJMysz?=
 =?utf-8?Q?ZJ6jRwMphU1dS8NRzDr7LII=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1PR02MB2536.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce852cdb-9d93-481e-5e7e-08d9a2b91a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 13:10:14.3684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7ALNNOWP+FDk//Oiu+ATIjIgcVmHTtnEYQH2maCdYg4VpTGuWi+Ayn0wGepmLZjK2C2RV0YlSHzoCeT81wUCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciA4LCAyMDIxIDg6NTYg
UE0NCj4gVG86IOiDoeWQr+iIqihOaWNrIEh1KSA8aHVxaWhhbmdAb3Bwby5jb20+DQo+IENjOiBi
YWxiaUBrZXJuZWwub3JnOyBwZXRlci5jaGVuQGtlcm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2Ml0gdXNiOiBnYWRnZXQ6IGNvbXBvc2l0ZTogRml4IG51bGwgcG9pbnRlciBleGNl
cHRpb24NCj4gDQo+IE9uIE1vbiwgTm92IDA4LCAyMDIxIGF0IDEyOjQyOjI0UE0gKzAwMDAsIOiD
oeWQr+iIqihOaWNrIEh1KSB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiA+
IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgNSwgMjAyMSA4OjQ1IFBNDQo+ID4gPiBUbzog6IOh5ZCv
6IiqKE5pY2sgSHUpIDxodXFpaGFuZ0BvcHBvLmNvbT4NCj4gPiA+IENjOiBiYWxiaUBrZXJuZWwu
b3JnOyBwZXRlci5jaGVuQGtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC11c2JAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyXSB1c2I6IGdhZGdldDogY29tcG9zaXRlOiBGaXggbnVsbCBwb2ludGVyDQo+ID4gPiBl
eGNlcHRpb24NCj4gPiA+DQo+ID4gPiBPbiBGcmksIE5vdiAwNSwgMjAyMSBhdCAwNjo0ODo0MFBN
ICswODAwLCBRaWhhbmcgSHUgd3JvdGU6DQo+ID4gPiA+IEluIHRoZSBjb25maWdfZXBfYnlfc3Bl
ZWRfYW5kX2FsdCBmdW5jdGlvbiwgc2VsZWN0IHRoZQ0KPiA+ID4gPiBjb3JyZXNwb25kaW5nIGRl
c2NyaXB0b3IgdGhyb3VnaCBnLT5zcGVlZCwgYnV0IHRoZSBmdW5jdGlvbiBkcml2ZXINCj4gPiA+
ID4gbWF5IG5vdCBzdXBwb3J0IHRoZSBjb3JyZXNwb25kaW5nIHNwZWVkLiBTbywgd2UgbmVlZCB0
byBjaGVjaw0KPiA+ID4gPiB3aGV0aGVyIHRoZSBmdW5jdGlvbiBkcml2ZXIgcHJvdmlkZXMgdGhl
IGNvcnJlc3BvbmRpbmcgc3BlZWQNCj4gPiA+ID4gZGVzY3JpcHRvciB3aGVuIHNlbGVjdGluZyB0
aGUgZGVzY3JpcHRvci4NCj4gPiA+ID4NCj4gPiA+ID4gWyAgMjM3LjcwODE0Nl0gIGFuZHJvaWRf
d29yazogc2VudCB1ZXZlbnQgVVNCX1NUQVRFPUNPTk5FQ1RFRCBbDQo+ID4gPiA+IDIzNy43MTI0
NjRdICBrY29uZmlnZnMtZ2FkZ2V0IGdhZGdldDogc3VwZXItc3BlZWQgY29uZmlnICMxOiBiIFsN
Cj4gPiA+ID4gMjM3LjcxMjQ4N10gIGtVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgYXQNCj4gPiA+IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDAw
DQo+ID4gPg0KPiA+ID4gU28gdGhpcyBpcyBhbiBpbnZhbGlkIGRyaXZlciBjYXVzaW5nIHRoaXMg
cHJvYmxlbT8gIE9yIGNhbiB0aGlzIGJlDQo+ID4gPiB0cmlnZ2VyZWQgYnkgdXNlcnNwYWNlPw0K
PiA+DQo+ID4gWWVzLCBpZiB0aGUga2VybmVsIGlzIGxvYWRlZCB3aXRoIGFuIGludGVyZmFjZSBk
cml2ZXIgdGhhdCBkb2VzIG5vdA0KPiA+IHN1cHBvcnQgYWxsIHNwZWVkcywgdGhpcyBwcm9ibGVt
IGNhbiBiZSB0cmlnZ2VyZWQgaW4gdXNlcnNwYWNlLg0KPiANCj4gV2hhdCBpbi1rZXJuZWwgZHJp
dmVyIGRvZXMgbm90IHN1cHBvcnQgYWxsIHNwZWVkcyB0aGF0IGNhbiB0cmlnZ2VyIHRoaXM/DQo+
IA0KPiBXaHkgbm90IGZpeCB0aGUgZHJpdmVycz8NCg0KVGhpcyBwcm9ibGVtIGlzIGNhdXNlZCBi
eSBhbmRyb2lkIGZfYXVkaW9fc291cmNlLmMNCkkgdGhpbmsgdGhlIGNvcmUgZHJpdmVyIGNvZGUg
c2hvdWxkIGJlIGltcHJvdmVkIHRvIG1ha2UgaXQgbGVzcyBzdXNjZXB0aWJsZSB0byBmdW5jdGlv
bi1kcml2ZW4gaW5mbHVlbmNlLiANCk9mIGNvdXJzZSwgcmVwYWlyaW5nIHRoZSBmdW5jdGlvbiBk
cml2ZXIgaXMgdGhlIGZ1bmRhbWVudGFsIHNvbHV0aW9uIHRvIHRoZSBwcm9ibGVtLg0KDQo+ID4g
PiA+IFsgIDIzNy43MTI0OTNdICBrTWVtIGFib3J0IGluZm86DQo+ID4gPiA+IFsgIDIzNy43MTI0
OThdICBrICBFU1IgPSAweDk2MDAwMDA2IFsgIDIzNy43MTI1MDRdICBrICBFQyA9IDB4MjU6DQo+
ID4gPiA+IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMgWyAgMjM3LjcxMjUxMF0gIGsg
IFNFVCA9IDAsIEZuViA9DQo+ID4gPiA+IDAgWyAgMjM3LjcxMjUxNV0gIGsgIEVBID0gMCwgUzFQ
VFcgPSAwIFsgIDIzNy43MTI1MjBdICBrRGF0YSBhYm9ydA0KPiA+ID4gPiBpbmZvOg0KPiA+ID4g
PiBbICAyMzcuNzEyNTI1XSAgayAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNiBbICAyMzcuNzEy
NTMwXSAgayAgQ00NCj4gPiA+ID4gPSAwLCBXblIgPSAwIFsgIDIzNy43MTI1MzZdICBrdXNlciBw
Z3RhYmxlOiA0ayBwYWdlcywgMzktYml0IFZBcywNCj4gPiA+IHBnZHA9MDAwMDAwMDIwZWYyOTAw
MA0KPiA+ID4gPiBbICAyMzcuNzEyNTQxXSAga1swMDAwMDAwMDAwMDAwMDAwXSBwZ2Q9MDAwMDAw
MDIwZWYyYTAwMywNCj4gPiA+IHB1ZD0wMDAwMDAwMjBlZjJhMDAzLCBwbWQ9MDAwMDAwMDAwMDAw
MDAwMA0KPiA+ID4gPiBbICAyMzcuNzEyNTU0XSAga0ludGVybmFsIGVycm9yOiBPb3BzOiA5NjAw
MDAwNiBbIzFdIFBSRUVNUFQgU01QIFsNCj4gPiA+ID4gMjM3LjcyMjA2N10gIGtTa2lwIG1kIGZ0
cmFjZSBidWZmZXIgZHVtcCBmb3I6IDB4MTYwOWUwIFsNCj4gPiA+ID4gMjM3Ljc4NzAzN10gIGtX
b3JrcXVldWU6IGR3Y193cSBkd2MzX2JoX3dvcmsuY2ZpX2p0DQo+IFsgIDIzNy44NTQ5MjJdDQo+
ID4gPiA+IGtwc3RhdGU6IDYwYzAwMDg1IChuWkN2IGRhSWYgK1BBTiArVUFPKSBbICAyMzcuODYz
MTY1XSAga3BjIDoNCj4gPiA+ID4gY29uZmlnX2VwX2J5X3NwZWVkX2FuZF9hbHQrMHg5MC8weDMw
OA0KPiA+ID4gPiBbICAyMzcuODcxNzY2XSAga2xyIDogYXVkaW9fc2V0X2FsdCsweDU0LzB4Nzgg
WyAgMjM3Ljg3OTEwOF0gIGtzcA0KPiA+ID4gPiA6IGZmZmZmZmMwMTA0ODM5ZTANCj4gPiA+ID4N
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUWloYW5nIEh1IDxodXFpaGFuZ0BvcHBvLmNvbT4NCj4g
PiA+DQo+ID4gPiBXaGF0IGNvbW1pdCBpZCBkb2VzIHRoaXMgZml4Pw0KPiA+DQo+ID4gSSBoYXZl
IG5vdCBzdWJtaXR0ZWQgYSBCVUcuDQo+ID4gSSB3aWxsIHN0dWR5IGFuZCBzdWJtaXQgYSBCVUcg
YXMgc29vbiBhcyBwb3NzaWJsZS4NCj4gDQo+IEkgZG8gbm90IHVuZGVyc3RhbmQgd2hhdCB5b3Ug
bWVhbiBieSB0aGlzLiAgSSBhbSBhc2tpbmcgd2hhdCBjb21taXQgY2F1c2VkDQo+IHRoaXMgcHJv
YmxlbSBzbyB3ZSBjYW4gbWFyayB0aGlzIG9uZSBhcyBmaXhpbmcgaXQuDQo+IA0KDQpUaGlzIGlz
IGEgcHJvYmxlbSB3aXRoIEFuZHJvaWQncyBkcml2ZXIgY29kZS4NClRoZSBrZXJuZWwgZG9lcyBu
b3QgaW5jbHVkZSBpdC4NCg0KVGhhbmtzDQoNCg==
