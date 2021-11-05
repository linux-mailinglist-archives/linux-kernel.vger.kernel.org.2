Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7040446A47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 22:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhKEVJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:09:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233365AbhKEVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:09:40 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5L3YFu030022
        for <linux-kernel@vger.kernel.org>; Fri, 5 Nov 2021 14:07:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OHwfofyJz1attrHrdTc6QxsteOGaE2mj2ybI3LAdAcM=;
 b=PAgaoQYUS//nQBJbEky0aGypCXDDUPeX9gnXudycpVdpekoEVGZ+7iZ46/JrWls3rsuw
 UsMT81MwNOrgQqGfIANwbca8q9yA89vzRBMUzOvP0GKPKtOVKI3w0dVs2GaxTPf6xlJO
 Ytb+WkRdX5kE7c5x957hsuVgKFYSrH421PQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4t4hr5xe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 14:07:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 14:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzHYb8jECx410Z9FjtFfRxuQE/RmkRtYz8zpviqKpNnNsYQIrCXfAU+YJDUs3y5X3bM1I3xHSv578S1UG6+AJtodOcERHMO7vMjdvK9qsJNTXveu0RpYa0EnaRI+RACuWmET+fNBh4R6ofTBBfeNgtxVqI+tTO8JijGmw3ss5LJEIoVysPxmCao0jw02BqKlXVLeoDJLY4USx+ok/4S+NpqBUzeEbcAsmR92Z38JhoPd7roS42M2Pmq3FIc2B9YgmYeQ3OPLOR8dK1fwX5p/ndJC2eZyVRowDN6P/7s/tJ9Up/7fWhLV5GaHVqBbj9O5HVgEjhSIj1Fmg0gZl2u/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHwfofyJz1attrHrdTc6QxsteOGaE2mj2ybI3LAdAcM=;
 b=KbrkqRDDznWJVAKpugHZ1V1wF4HcGDBkNKQUAv6S6LEg0Pwc4upce90tNi2h7uUJSiMaf3eXkKvOhrgeC1oHf2+AVhvLFnjQO/8WtYj4KFlpddXcgzGAqb+Gk2TDtqf/rRhxkTL8qz4qGT0ky7s8jNA20+5D0BGoG+D2HImqRaaCsGyuXp4jzkCQUOQDRkFpb/aygWX1/IxrpM6lV9dg0yWIaT85VfEtbvxSvaslz7HXijK3CQ5Q5V89CPclrBzTqC8P9jEiFxGy/hZUGZclNZ63VQPlFhv/mYOI6W8oNZx1pKviUr15MsXas2eRphrzEhhB+ssq5IKMf9riv/9ljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SJ0PR15MB4390.namprd15.prod.outlook.com (2603:10b6:a03:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 21:06:52 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 21:06:52 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] lib: zstd: Add cast to silence clang's
 -Wbitwise-instead-of-logical
Thread-Topic: [PATCH] lib: zstd: Add cast to silence clang's
 -Wbitwise-instead-of-logical
Thread-Index: AQHXxrmhV8EJKX2UAE+nrwZQNmVvMavkgQmAgBEDnoA=
Date:   Fri, 5 Nov 2021 21:06:51 +0000
Message-ID: <B96DD7CE-A1AA-43C9-8F21-DC6EC8E0E3A9@fb.com>
References: <20211021202353.2356400-1-nathan@kernel.org>
 <4245BD7A-4B12-4172-B4EE-76A99C717C7D@fb.com>
In-Reply-To: <4245BD7A-4B12-4172-B4EE-76A99C717C7D@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ded4300b-1191-45a7-6378-08d9a0a030a8
x-ms-traffictypediagnostic: SJ0PR15MB4390:
x-microsoft-antispam-prvs: <SJ0PR15MB43904368B5E03922860383ECAB8E9@SJ0PR15MB4390.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJgbCWZ+MGDwKIG0hC/Tqy1VyWUMJ7O8x0HI44CQZRd0Gt1ORdhtwfNj5+QMAzlGmq5YeY/EWiQtMqX68OV13woDdS32MUVTBRN3AldFJeRgu1/qxA9Hq/64N0L7jqofnEa27sWRwkfyZb6fKt80zSUPjPx8fa8Na7SqmfH7WK/8AmWPmqt+42J/BARBt6Af88hdOaxCQhT22v49uMj10YrxyV9h/FwNqKiDZrbTGTXfR5vYZ9nrvT6w/u4KJUbJ6DVlIdODZ8JyC57KTwiKACW3pdni1VE/EB78U9Vev2YEVQAzOLbI8D5PcM3KZJPbEsPCThfB7JI84KzTAnVmqgyymfwIa/wqp2DrwdORgXkGvszlGrHlz1XEN59h+QZ1uKJb4hJ8od+t+hTeWghETj39VIgD+W2c9Ezb0KiyIyO9yFZVyNklTOBnkk05gxO2yyAwjY57wW/IeqgRPpcy8knTDyR6rv6Iw3VEYBDwrypcwyuljIPE3siGIdICckJD85zeNiK4+g4uBcjSKcq5n5jdoZnL8CHEdLRupCz2uQAjOgEzi+Ffe3x0PCX9w5AkDxLfA3N/y8kZrf80BeY/W4XvDPgHwiMAyrYTqfGRdkpOoo/iNk2I6bb79BSnI2gvpeJQyDtq49w6yzHenBT0orjnRWnKyTFLXMByBKW2j8moPqkzFczjSkklCCpOxpnDtegEbaOm/Ye96wIHJ71tIE3tJgdNw9LfzzwmTL/ATbtC3auCidhusP/ojGnTDbzUHS6l0mNjlF9iQMnMQKuxFK826YiKMLr3ry7ZvYkB78R3SlqcIPasEI/eV4STP/lOR5Pk/IaeX1875FDe70+6QkZpMg5zWTfBgp7U00ThYsggVxI1ksPq6NV5YuAbg83v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(33656002)(6916009)(66946007)(38100700002)(54906003)(86362001)(122000001)(316002)(6512007)(36756003)(4326008)(76116006)(71200400001)(966005)(508600001)(8676002)(53546011)(6506007)(66556008)(2906002)(186003)(5660300002)(64756008)(66476007)(6486002)(66446008)(2616005)(8936002)(83380400001)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2tFUnhkK1cwZUZkTnRLaURMK0l5T0JJNWdvTlNXeTJ2aGxsMUl2TXBXZWhs?=
 =?utf-8?B?Q0dBc0xBeXVkNldXcVUyTFBxZEx3V3pMbklBTUJIbnhCV2hjOTFsdXZ0VnpD?=
 =?utf-8?B?U1g4ajdJc01hdE9PcXh6VklNSFBhZFFlakhrUVhoTitlVjZ5NnZNVGF0MU1O?=
 =?utf-8?B?WDFld08zQnVxbjU1U0h0eTUxaWZlamVJSG9Gam00cmNKZnFiWkVIdEpOMktn?=
 =?utf-8?B?TXJtQmM0bjVYdW8vNk1JNXBsNldRV3RiREtrSG82RzM5NU91TUxoRHI0bmFM?=
 =?utf-8?B?RDFkckxGUGZNcjNFTTBjZm4veDZSU1JTWXFzenFrN25sdmJtWVdyWVJSN2Vu?=
 =?utf-8?B?QjViMlBJOXZ2aTE1SDhqdGN4MW9wNnFKVE5MSmd2RXBFRTdLR2VsUG5XMnVF?=
 =?utf-8?B?bWJHcEQvVnlGS0dZSml6VE1hRGhzVENhdmtZRlJ2WVhPUnp0S2c0RS81ZkFo?=
 =?utf-8?B?UnJBTC9HRmdsUlFaaTJIYjB6cWZBL2lBYno5UkhOWUpGUXFnNUVYbXJ4NFhN?=
 =?utf-8?B?dGNBeEo3Z2NmS3d3QTNTeHYwWkZURG5SVjFaQzBNbU1UeWdMajhleDVZUTE0?=
 =?utf-8?B?NG85RWFOMWJHSU8xWURXR2pEVVovS2tiSDZxUERISzYycGZ0N29QdlJ1eWRO?=
 =?utf-8?B?ZU5wV0tNczJwaU1BbEZJR3ozWjA5RDlLR3RSTldPRkJmSm5vcUFRTzlMQ0dD?=
 =?utf-8?B?V0lHcmRDdzk2NEpYNXovUThmV0R1Zm5SVVUxWCtmL1Mwc2E1WHNRd0I1QlND?=
 =?utf-8?B?VG5Qb0UzOEFVanE1Q2c4NkhVT0h6blZ5ZkM1U0VNSkFNL3RJS0tNRFhmU3pJ?=
 =?utf-8?B?bDVBeVBrVFp5ZkZzVmQwVzVXaEN1UXlVVkRUak1FTmdaN1ptYndtRkY5QTI2?=
 =?utf-8?B?REdyeTI3bDFqd21ZaGlRdXc5WUk4S1ozbXhaRVhNeTlUVWpuU0FzYTNzMDF3?=
 =?utf-8?B?ZFJySUJRUVFROUNBditGT2lZVkdPUnF5cFdkUFdjaU1IQ3JmSkxaellGc05K?=
 =?utf-8?B?MzkzWG1sQnpJMDZ0VUhXanhjTW9MeFJOTTlhVnFtMjVHOVpMYldxZlNXQi9E?=
 =?utf-8?B?TW5BTnNNdm1WaDdEOGpCRHdVUXhaNDJPUHN5RHJPSExHTDJhbE90YmFxNGlK?=
 =?utf-8?B?WkdHeWhSaVlxQ05OZTUra0w5dEJpZE5OZ05PT3VET3M5eG5aUWxvRkxLZUZs?=
 =?utf-8?B?V0VWQXBqWmJPOHREMlJ1Yk9wdm1HTG9PU3diejFUdnFnRmNVS24vQkErN1FL?=
 =?utf-8?B?WW55Q096aWVlb01rNDUzVVFzcTFWYWVRSTVsRVBNdDVwaTE3djZFeG1LSlpr?=
 =?utf-8?B?QmRtMStpc3RJRUlteTJvZWt5ZEdtTFlZbHNmM2dCR0dXZUM2cnVRV2xlc0J4?=
 =?utf-8?B?Z3RjSHFOdGxuVVZldEwwNHVNaENMSEhKeC9PM3hNTk5GOTVnQjVqT1RhRHh0?=
 =?utf-8?B?clJSNFMvdE9WUGQ5ZjB5VUJoY1UvQmtEU3BacVJzcDA4OHNHRUxuZC9wbzZT?=
 =?utf-8?B?WjZvVy9pZ2FvU04wdUl0bjRMMGVONlp2cmhoUlR6eWdVYjljT0tsaXZ0TmQv?=
 =?utf-8?B?OWVxSGJyMEk3WmcyV3hXZ2xKYkF5QjRlek9oOFBXRGlzTGY1WWlQYnlZand2?=
 =?utf-8?B?SXc4YUw3RVYyT1ROU25pZ0xPLy9iSm9YZHFVY3ArM0wvYXhidW4vSE4vVlBP?=
 =?utf-8?B?L21TL1dTTmxMc2ExbE5CZFpjc044T1Zuc2c3UWlQWGlpM2dIWHYwdzFFbUxy?=
 =?utf-8?B?NjlISU5Ka3ViMk9CeWdRdHg1SHJSQktaNk9OOGdxRjRYY0JhdUpEanJhejgv?=
 =?utf-8?B?R2VNMjIrdGF2Nmw3NUdsMUdhalVDTnFHZ3UrdWdVMFZxTGhvaDc4TC9sUW8r?=
 =?utf-8?B?ZzFnd0hRSHdDelQrSEFoQkFvMSszTG1XeTA0cHVxRDRzc3pCamtqOVAybmVY?=
 =?utf-8?B?OVNtWWtIQjZBeXBwZnUzeTlwaFRsdy9UV09FTk13YmdPY1oxWENVdGFOc3BT?=
 =?utf-8?B?WTN4SFRGTm5vck1qUDkyK1BzUmVQOFRzYkNVTEQ5R1ZkdkdpSzVBYnNmSFVk?=
 =?utf-8?B?UGw1SUwxQzVmK1JjZmRhVEZORDljTVpPOG53d2p0ZUpGRlUya3lVWFlBWVFZ?=
 =?utf-8?B?SUJpR0lob0cwdXJMbVAwYVFMMjNZWm9jbjJOaDFKMWNLZW9vZjgxdHhkaUIy?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E27F677793139042A86592BCCE3798A3@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded4300b-1191-45a7-6378-08d9a0a030a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 21:06:52.0409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vovwvueq0oq1I6qMTTSMqi/tYDDVshmHsRJ0eU1+1TR2MvcZu/PqjaMrzF0o8hEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4390
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: tDhlpr3pTb4KC84w-GzA4NWSDGZzApjD
X-Proofpoint-GUID: tDhlpr3pTb4KC84w-GzA4NWSDGZzApjD
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDI1LCAyMDIxLCBhdCA2OjE3IFBNLCBOaWNrIFRlcnJlbGwgPHRlcnJlbGxu
QGZiLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBPY3QgMjEsIDIwMjEsIGF0IDE6MjMg
UE0sIE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4gd3JvdGU6DQo+PiANCj4+
IEEgbmV3IHdhcm5pbmcgaW4gY2xhbmcgd2FybnMgdGhhdCB0aGVyZSBpcyBhbiBpbnN0YW5jZSB3
aGVyZSBib29sZWFuDQo+PiBleHByZXNzaW9ucyBhcmUgYmVpbmcgdXNlZCB3aXRoIGJpdHdpc2Ug
b3BlcmF0b3JzIGluc3RlYWQgb2YgbG9naWNhbA0KPj4gb25lczoNCj4+IA0KPj4gbGliL3pzdGQv
ZGVjb21wcmVzcy9odWZfZGVjb21wcmVzcy5jOjg5MDoyNTogd2FybmluZzogdXNlIG9mIGJpdHdp
c2UgJyYnIHdpdGggYm9vbGVhbiBvcGVyYW5kcyBbLVdiaXR3aXNlLWluc3RlYWQtb2YtbG9naWNh
bF0NCj4+ICAgICAgICAgICAgICAgICAgICAgICAoQklUX3JlbG9hZERTdHJlYW1GYXN0KCZiaXRE
MSkgPT0gQklUX0RTdHJlYW1fdW5maW5pc2hlZCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cj4+IA0KPj4genN0ZCBkb2VzIHRoaXMgZnJlcXVlbnRseSB0byBoZWxwIHdpdGggcGVyZm9ybWFu
Y2UsIGFzIGxvZ2ljYWwgb3BlcmF0b3JzDQo+PiBoYXZlIGJyYW5jaGVzIHdoZXJlYXMgYml0d2lz
ZSBvbmVzIGRvIG5vdC4NCj4+IA0KPj4gVG8gZml4IHRoaXMgd2FybmluZyBpbiBvdGhlciBjYXNl
cywgdGhlIGV4cHJlc3Npb25zIHdlcmUgcGxhY2VkIG9uDQo+PiBzZXBhcmF0ZSBsaW5lcyB3aXRo
IHRoZSAnJj0nIG9wZXJhdG9yOyBob3dldmVyLCB0aGlzIHBhcnRpY3VsYXIgaW5zdGFuY2UNCj4+
IHdhcyBtb3ZlZCBhd2F5IGZyb20gdGhhdCBzbyB0aGF0IGl0IGNvdWxkIGJlIHN1cnJvdW5kZWQg
YnkgTElLRUxZLCB3aGljaA0KPj4gaXMgYSBtYWNybyBmb3IgX19idWlsdGluX2V4cGVjdCgpLCB0
byBoZWxwIHdpdGggYSBwZXJmb3JtYW5jZQ0KPj4gcmVncmVzc2lvbiwgYWNjb3JkaW5nIHRvIHVw
c3RyZWFtIHpzdGQgcHVsbCAjMTk3My4NCj4+IA0KPj4gQXNpZGUgZnJvbSBzd2l0Y2hpbmcgdG8g
bG9naWNhbCBvcGVyYXRvcnMsIHdoaWNoIGlzIGxpa2VseSB1bmRlc2lyYWJsZQ0KPj4gaW4gdGhp
cyBpbnN0YW5jZSwgb3IgZGlzYWJsaW5nIHRoZSB3YXJuaW5nIG91dHJpZ2h0LCB0aGUgc29sdXRp
b24gaXMNCj4+IGNhc3Rpbmcgb25lIG9mIHRoZSBleHByZXNzaW9ucyB0byBhbiBpbnRlZ2VyIHR5
cGUgdG8gbWFrZSBpdCBjbGVhciB0bw0KPj4gY2xhbmcgdGhhdCB0aGUgYXV0aG9yIGtub3dzIHdo
YXQgdGhleSBhcmUgZG9pbmcuIEFkZCBhIGNhc3QgdG8gVTMyIHRvDQo+PiBzaWxlbmNlIHRoZSB3
YXJuaW5nLiBUaGUgZmlyc3QgVTMyIGNhc3QgaXMgdG8gc2lsZW5jZSBhbiBpbnN0YW5jZSBvZg0K
Pj4gLVdzaG9ydGVuLTY0LXRvLTMyIGJlY2F1c2UgX19idWlsdGluX2V4cGVjdCgpIHJldHVybnMg
bG9uZyBzbyBpdCBjYW5ub3QNCj4+IGJlIG1vdmVkLg0KPj4gDQo+PiBMaW5rOiBodHRwczovL2dp
dGh1Yi5jb20vQ2xhbmdCdWlsdExpbnV4L2xpbnV4L2lzc3Vlcy8xNDg2DQo+PiBMaW5rOiBodHRw
czovL2dpdGh1Yi5jb20vZmFjZWJvb2svenN0ZC9wdWxsLzE5NzMNCj4+IFJlcG9ydGVkLWJ5OiBO
aWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4NCj4+IFNpZ25lZC1vZmYt
Ynk6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4NCj4gDQo+IFRoYW5rcyBm
b3IgdGhlIGZpeCENCj4gDQo+IEnigJlsbCBhcHBseSB0aGlzIHBhdGNoIHRvIG15IGxpbnV4LW5l
eHQgdHJlZSBhbmQgcG9ydCBpdCB0byB1cHN0cmVhbSB6c3RkLg0KDQpBcHBsaWVkIHRvIG15IGxp
bnV4LW5leHQgdHJlZSBbMV0gYW5kIGJhY2twb3J0ZWQgdXBzdHJlYW0gWzJdLg0KDQpUaGFua3Mg
YWdhaW4gZm9yIHRoZSBwYXRjaCENCg0KLU5pY2sNCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS90
ZXJyZWxsbi9saW51eC90cmVlL3pzdGQtMS40LjEwDQpbMl0gaHR0cHM6Ly9naXRodWIuY29tL2Zh
Y2Vib29rL3pzdGQvcHVsbC8yODQ5DQoNCj4gQmVzdCwNCj4gTmljayBUZXJyZWxsDQo+IA0KPj4g
LS0tDQo+PiBsaWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmMgfCAyICstDQo+PiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlm
ZiAtLWdpdCBhL2xpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYyBiL2xpYi96c3Rk
L2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYw0KPj4gaW5kZXggMDU1NzBlZDVmOGJlLi41MTA1
ZTU5YWMwNGEgMTAwNjQ0DQo+PiAtLS0gYS9saWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXBy
ZXNzLmMNCj4+ICsrKyBiL2xpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYw0KPj4g
QEAgLTg4Niw3ICs4ODYsNyBAQCBIVUZfZGVjb21wcmVzczRYMl91c2luZ0RUYWJsZV9pbnRlcm5h
bF9ib2R5KA0KPj4gICAgICAgICAgICBIVUZfREVDT0RFX1NZTUJPTFgyXzAob3AyLCAmYml0RDIp
Ow0KPj4gICAgICAgICAgICBIVUZfREVDT0RFX1NZTUJPTFgyXzAob3AzLCAmYml0RDMpOw0KPj4g
ICAgICAgICAgICBIVUZfREVDT0RFX1NZTUJPTFgyXzAob3A0LCAmYml0RDQpOw0KPj4gLSAgICAg
ICAgICAgIGVuZFNpZ25hbCA9IChVMzIpTElLRUxZKA0KPj4gKyAgICAgICAgICAgIGVuZFNpZ25h
bCA9IChVMzIpTElLRUxZKChVMzIpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIChCSVRfcmVs
b2FkRFN0cmVhbUZhc3QoJmJpdEQxKSA9PSBCSVRfRFN0cmVhbV91bmZpbmlzaGVkKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgJiAoQklUX3JlbG9hZERTdHJlYW1GYXN0KCZiaXREMikgPT0gQklU
X0RTdHJlYW1fdW5maW5pc2hlZCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICYgKEJJVF9yZWxv
YWREU3RyZWFtRmFzdCgmYml0RDMpID09IEJJVF9EU3RyZWFtX3VuZmluaXNoZWQpDQo+PiAtLSAN
Cj4+IDIuMzMuMS42MzcuZ2Y0NDNiMjI2Y2ENCg0K
