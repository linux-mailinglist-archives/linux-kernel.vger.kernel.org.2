Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4A457656
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhKSS0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:26:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231667AbhKSS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:26:34 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJEvWg6010114
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:23:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+kIaMBGggrtEknmcmGH/pRpdRMWpcDruXGH9nHRaHXg=;
 b=OWwYsX6sB9iWPOGivSS7+oKMrYSqtHa8pPG4FLF1DH+t8+stSTFXIVcvs68d1vxPwGQD
 FRlWsTEUjO6pLMxEWHERFhntzPElZ1x5VZEBDLzFCNPF2RKuE9w6BNv0Tda6xeMEXmB+
 Dbdg4b3sOPqbfcodKkysJ+MXZ0+X9cYjXQY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cee521ke8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:23:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 19 Nov 2021 10:23:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7ppYDZl+GMO+3NPUkvICtOeugJttAaXDwMuhyGDDqTx2AHgqPYCILnw5O6ribn91BDceIrhzmzWEwu5XJfUhIzID5eOvpn//6JOsSN6DnP4QJcxSNVyyHlY2kjT0amHpQmleS5At7T0fywejWhvSeHtsreXKTmZ/4oilQ6DBFwr25/SZrFjVJUItd4NkcNFlvX0bg4GfnMJBLhEG9etotBrnXWkRdhMD24lQoENtUQgGTJyMhIpjiKdOGzRQhi0U/H6e8LDsPrSFA+tb6JB6uC1Fx0uit+q10jYWT+ogVawDgzc4u5kbCCxYHRN/Xju8kOPvNCh9rRy58qx+6cR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kIaMBGggrtEknmcmGH/pRpdRMWpcDruXGH9nHRaHXg=;
 b=QsLjn/CetE2vf1O0B/RRDstncDBaSTcuKKDPnRgrldaAFpxmBYAXtNdP57Sl58RmMk3LPD1htxl43lJGJvt/dox1NWw7uG6MdIo91KBCiiXO2YvAlHXmhIWRRYblJcDCRQ4FepI5AxMuWx4mpAbdsXhua+POCn4P1JOb+rrvnQ9+OPKtY9ebUo0nhJAXuVhuPPle7dWoOPsPEOLoAfU1FnKNZwck/UK17j+BCz1TOKpE6mf/ozXRwBXpLs5dkQeowfWOAuuumD9gNfXWsljeiGGjTtQm5KJKqkZhR0L6K90ET9KDyuHv2xertvFM9N4BGmHeT2OqkL0PSjckQOsIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SJ0PR15MB4678.namprd15.prod.outlook.com (2603:10b6:a03:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 19 Nov
 2021 18:23:24 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 18:23:24 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Guo Xuenan <guoxuenan@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Chengyang Fan <cy.fan@huawei.com>, Yann Collet <cyan@fb.com>,
        "fangwei1@huawei.com" <fangwei1@huawei.com>,
        "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com" 
        <syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com>,
        "wangli74@huawei.com" <wangli74@huawei.com>
Subject: Re: [PATCH v3] lz4: fix LZ4_decompress_safe_partial read out of bound
Thread-Topic: [PATCH v3] lz4: fix LZ4_decompress_safe_partial read out of
 bound
Thread-Index: AQHX1ujPCQdihx7JykuOrso6Uuc7u6wLN0CA
Date:   Fri, 19 Nov 2021 18:23:24 +0000
Message-ID: <CCE83845-DC40-4E14-9105-6319C048FACB@fb.com>
References: <20211111085058.1940591-1-guoxuenan@huawei.com>
 <20211111105048.2006070-1-guoxuenan@huawei.com>
In-Reply-To: <20211111105048.2006070-1-guoxuenan@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17cf448d-42d5-4b30-54a5-08d9ab89aca2
x-ms-traffictypediagnostic: SJ0PR15MB4678:
x-microsoft-antispam-prvs: <SJ0PR15MB46783728E06752A322D4EFFAAB9C9@SJ0PR15MB4678.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEYi27DYcbnNrXG2CuQGjIA9MAK6sHv2Z7Xlzh4rttCSSOaiq9xeVTx5WYmzSMoW4DT2qQ0KkVinQI36MSSh6PkGwQhHrAFKQpBTnw1YtSq7JxlqlqYgbsUk9rhumiImFtzv6WeP/2r33IZJpXuTXOnnPOcKYDLdbTBP9Xu0lJL8Xv0WboYdS13Ohj0r8gTbmdXgkQnGDx3FPQpKt3J8OKTKrNetBGIcZ8HwK9IvPo7JjsuXY0+8EDEomZWjZIUPAdHZqmRzjdVl9gmKNB7JERFlb9LocKmjoJ3zcgwDp3SmQ0DiSHj2hPxYydnT/vC9GfAoGL5O6z9wRWIoxLe3N6xtOA1RXytLR0ej6p4y7chYM8nFhR5dT86knOoTboriCfMvPwmJtEw77Ugio7rMFM0ZJhXstBzbmNEowVzBOCbjG9Bmr3eqfNuJB+3w/hctUaJ4FsCzF4wsvWZsuwZfV+R5nlkSmAiUw30rTOtou4716IY/9XP2p+1JmzwEuX3YjeHx06xVeNiq361bwRtAHmBSJVev/mqiVzPhTDNOj/XtezsCcAGPlx7ENYCeMOrzAYzQ5LFSG/Nj6bX18fkr08DRsyWhgodMGSTuZYRlqhp7W4+jjpwZlfgJvEM5uS419xJLe3MY8DG3TtRukRr0EsOE0jr5hIazAEik42BBcH8O63+deObJPfKle6Dth7/EpQaHHIMSSkwdYrnCRwLqajf6hWn3L99+D4C3ZpbwP1z7tYc7HGHagAkxX7r9C4CCemzsoP2DepjDTfvka3dvlH0YAk9gvcBzRTa7iO+K3By7n2x7Vn5RRL8sVTeewcWMpxDoY3hV11RlD8dvl8gSowo3ty0okgm1hHihkfyZ82Uiy/nZCaUfIlBsMf76H1Fn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6916009)(5660300002)(122000001)(508600001)(2906002)(36756003)(6486002)(33656002)(966005)(6506007)(6512007)(86362001)(66556008)(64756008)(66946007)(66476007)(53546011)(2616005)(8676002)(186003)(76116006)(4326008)(91956017)(8936002)(316002)(83380400001)(71200400001)(38070700005)(54906003)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm5CemRXRHNUamFoMXYvSDdBcVhLMmZBb3MwLzZldXJ1eWFDQ2J0TVB3VEIx?=
 =?utf-8?B?S08rT1hpZXFUcklEazMzVllnMysyMURpVStjMXlRZGpVOGp3VWFTeFkrbHVa?=
 =?utf-8?B?dmd3OXpUWmdGbUZ1Mmg4VE5mT2xrbnlSOTNnamVXbWRPYktDUDNRbVFpYWdu?=
 =?utf-8?B?WkRFVzNLdnhLMGM4WG9vTEVwck5hckc2bW9iYngxZjJxZkNYUE4wM3lTRnlv?=
 =?utf-8?B?U2hlQjE5UVh6dS9sODZ1MjJHOWlnVFAyKzhkM1IwR2ZQVFhxQkY1Q3pLVkZq?=
 =?utf-8?B?MkpuMGZPTHU4TVEwTXdtTG9EejZwZktGbk9USVNUbXNzMkp0T0pxVVJvVER2?=
 =?utf-8?B?VTRmc1RPMTFzMVV0VjFkd0hrUDdNdEFOQ2lwNlh1UUpUUHZlUE5sUSs3L1d3?=
 =?utf-8?B?SFU5WWNaTC8wcjU2Z25PdDBSLzNacDBmWkY0bnBPQUlRcVBrZkRNcXkxZ2dp?=
 =?utf-8?B?cEhibTNGS2dSNm1HR2NlSndRcE9ocVdGY29xT0R2bklQdDhnWHJRT0lYQmZK?=
 =?utf-8?B?b2pQalNRSmNsWEVhT0ZOVjhHd2k0MDkxM2FIM3dYWE8vbm1QczZkZm5uV2lE?=
 =?utf-8?B?SVJNQlQ0RkYxaGR2cFkraURSVDQwbi9DNnc0bW1hNDd6NFBFdVRHT2JxMU01?=
 =?utf-8?B?em0xOHJ2OU0yaXU3bUR0V3B6emFnazQvWU13QUloZE1tMlR1NnB3NTYxT1VZ?=
 =?utf-8?B?dnJUeE85T0hiRFRLNnI2U05MSGZTV3kyNnFwZUlUVG5OQko0QmRUd2I3bHl0?=
 =?utf-8?B?Nk9FVTBKQm9Jb091ZlplTVQ5T1JndDlpQ2pHMFpjUVE2cWxJNnBqbUE2UVk2?=
 =?utf-8?B?Smpwa2FCL25PTXhnMUdaalRoTDVzOVlqZlhrUE1UN2R0dUxmeW81cTc5LzhE?=
 =?utf-8?B?Uy9aakRvUngra1dLQTlJMjFqOHltZXBQc0hKaG84bWsySFN1dGNtZ2p6a3pa?=
 =?utf-8?B?bXlHOC9QQldtZnlueUlqcXV5NXpBVVVSYUtNN2xHemh0UG9yZFFqQjI1U25w?=
 =?utf-8?B?Tm16T05rQkVWeS9odFBxSkdzeVZTUjhvQTRTc1ZBRFZIdE1DZC9rcUxqVnhQ?=
 =?utf-8?B?YmtXUTZLaE1MRzVvOXNZVTlsb0FCL3E1QVlzM0FJSk1LR0hXcVB3R2RlR3h4?=
 =?utf-8?B?VDlVazVxZERBOVcybjEyVmI5VHFYN3BJSDVYcmNyQ2FXTkZyOURLamZrdTBG?=
 =?utf-8?B?Q2l6d2ZWbkRMV2JtMkxxK1lvdkQzc2RFVUlBZWNYUXhEMXNqZFpmWTNzOFNn?=
 =?utf-8?B?MUVxaUhaOXJsQXdvUUpxLzlMaDBmc2NkckpEV3JLZVBWY3hlbzcyU1VjZkxt?=
 =?utf-8?B?NW1SNWwycUl0aVJzZ3c3VWs2TCt6NVFNNHBNMXhXTzM1dG8wVG9sYzVBMUJj?=
 =?utf-8?B?aDFTd2tmU3VDNTZ2WStyaXN0eDh5UmRrOUhQSkNvLzZMQXBvVGZqQUFNcU1p?=
 =?utf-8?B?djcyTGs2dXgvYmhuUi8zQUU5VHBnOWkrbW1scG55amFROXJxa0g1WHI2OEZx?=
 =?utf-8?B?TGsraVRoTkQxcUIwbnFMbk94YVo3QzV6MlpOOVZCT0JYL3M5ZDFQMHppeHhZ?=
 =?utf-8?B?MkNmYk4wQVU3RjY3VXROTVpjZURXRURPdW1tN293OHZQVlcxYWg2bzJkaGRT?=
 =?utf-8?B?UlpoVjY5UncxNGNuUk4ySXhnY2t3MDBzcFA2SFk1aHFNSUtUdzhvSnJoSGtH?=
 =?utf-8?B?Q1k3cm15ODhoNW9FN1ZyTkNkM21VbmVvdzg5aW9ON1Z4aXljaVYyQ3Z6MGEr?=
 =?utf-8?B?RVd1UUp5NWpKTFJ3a2dTdWp6QzQ0NTdNdVlacm04Tmx3Ui84MlZjamJZT1ls?=
 =?utf-8?B?NWpac1JGVUVGV3lVS3JYMFk4TFNScE8vUWNQVU4rd1h3Z1dPbENIMFJBZ3Br?=
 =?utf-8?B?eElKUnRxL0pQU1FkdmtnYlJBeG9IZ3lLWUpBSlFycEZKdTBFcnhmVEVWeWdn?=
 =?utf-8?B?bFBTT1hIS1R4UHhFUm1ONk9uSHNNNmlOR0hnbk9VL3R4bGZTRDJ5dG5ZRXl6?=
 =?utf-8?B?N3pUendxTFF6dXhnTW1VbFVLUUdZVlExUHU0U2docEF0VkRyaGVXQU14aDJG?=
 =?utf-8?B?YUVWQVkzZEdvWUZoa1pBbUo2VXFPWHlDOGlldDJSRzVEblYvUXk0T2hpdGsz?=
 =?utf-8?B?ejFVWjBCdTQ2ZDZWQlVkK25rOVdUa0sxZG5FMEwwSldHSGtRU0hBUkdPTDZr?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B37034E33DCD5E49B1A87B6E78DF4245@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cf448d-42d5-4b30-54a5-08d9ab89aca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 18:23:24.3735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRFNDPRD5R65ZA3mH13QfF8/T/n8qMfFUu0wf4MNUinUO7ogPX8Zphn0d1vpfgx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4678
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: kF_MVRdNzAIku6uqlNxjNAl4WwPbUAuv
X-Proofpoint-ORIG-GUID: kF_MVRdNzAIku6uqlNxjNAl4WwPbUAuv
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_14,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111190099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDExLCAyMDIxLCBhdCAyOjUwIEFNLCBHdW8gWHVlbmFuIDxndW94dWVuYW5A
aHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPiBXaGVuIHBhcnRpYWxEZWNvZGluZywgaXQgaXMgRU9G
IGlmIHdlJ3ZlIGVpdGhlciwgZmlsbGVkIHRoZSBvdXRwdXQNCj4gYnVmZmVyIG9yIGNhbid0IHBy
b2NlZWQgd2l0aCByZWFkaW5nIGFuIG9mZnNldCBmb3IgZm9sbG93aW5nIG1hdGNoLg0KPiANCj4g
SW4gc29tZSBleHRyZW1lIGNvcm5lciBjYXNlcyB3aGVuIGNvbXByZXNzZWQgZGF0YSBpcyBjcnVz
dGVkIGNvcnJ1cHRlZCwNCj4gVUFGIHdpbGwgb2NjdXIuIEFzIHJlcG9ydGVkIGJ5IEtBU0FOIFsx
XSwgTFo0X2RlY29tcHJlc3Nfc2FmZV9wYXJ0aWFsDQo+IG1heSBsZWFkIHRvIHJlYWQgb3V0IG9m
IGJvdW5kIHByb2JsZW0gZHVyaW5nIGRlY29kaW5nLiBsejQgdXBzdHJlYW0gaGFzDQo+IGZpeGVk
IGl0IFsyXSBhbmQgdGhpcyBpc3N1ZSBoYXMgYmVlbiBkaXNzY3Vzc2VkIGhlcmUgWzNdIGJlZm9y
ZS4NCj4gDQo+IGN1cnJlbnQgZGVjb21wcmVzc2lvbiByb3V0aW5lIHdhcyBwb3J0ZWQgZnJvbSBs
ejQgdjEuOC4zLCBidW1waW5nIGxpYi9sejQNCj4gdG8gdjEuOS4rIGlzIGNlcnRhaW5seSBhIGh1
Z2Ugd29yayB0byBiZSBkb25lIGxhdGVyLCBzbywgd2UnZCBiZXR0ZXIgZml4DQo+IGl0IGZpcnN0
Lg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8wMDAwMDAwMDAwMDA4MzBk
MTIwNWNmN2YwNDc3QGdvb2dsZS5jb20vDQo+IFsyXSBodHRwczovL2dpdGh1Yi5jb20vbHo0L2x6
NC9jb21taXQvYzVkNmY4YThiZTM5MjdjMGJlYzkxYmNjNTg2NjdhNmNmYWQyNDRhZCMNCj4gWzNd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQzY2NkFFOC00Q0E0LTQ5NTEtQjZGQi1BMkVG
REUzQUMwM0JAZmIuY29tLw0KPiANCj4gUmVwb3J0ZWQtYnk6IHN5emJvdCs2M2Q2ODhmMWQ4OTlj
NTg4ZmI3MUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+IENjOiBoc2lhbmdrYW9AbGludXgu
YWxpYmFiYS5jb20NCj4gQ2M6IHRlcnJlbGxuQGZiLmNvbQ0KPiBDYzogY3lhbkBmYi5jb20NCj4g
Q2M6IGN5LmZhbkBodWF3ZWkuY29tDQo+IFNpZ25lZC1vZmYtYnk6IEd1byBYdWVuYW4gPGd1b3h1
ZW5hbkBodWF3ZWkuY29tPg0KDQpTb3JyeSBJ4oCZbSBhIGJpdCBsYXRlIHRvIHRoZSBwYXJ0eSwg
YnV0IHRoaXMgbG9va3MgZ29vZCB0byBtZSENCg0KUmV2aWV3ZWQtYnk6IE5pY2sgVGVycmVsbCA8
dGVycmVsbG5AZmIuY29tPg0KDQo+IC0tLQ0KPiBsaWIvbHo0L2x6NF9kZWNvbXByZXNzLmMgfCA4
ICsrKysrKy0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL2x6NC9sejRfZGVjb21wcmVzcy5jIGIvbGliL2x6
NC9sejRfZGVjb21wcmVzcy5jDQo+IGluZGV4IDkyNmY0ODIzZDVlYS4uZmQxNzI4ZDk0YmFiIDEw
MDY0NA0KPiAtLS0gYS9saWIvbHo0L2x6NF9kZWNvbXByZXNzLmMNCj4gKysrIGIvbGliL2x6NC9s
ejRfZGVjb21wcmVzcy5jDQo+IEBAIC0yNzEsOCArMjcxLDEyIEBAIHN0YXRpYyBGT1JDRV9JTkxJ
TkUgaW50IExaNF9kZWNvbXByZXNzX2dlbmVyaWMoDQo+IAkJCWlwICs9IGxlbmd0aDsNCj4gCQkJ
b3AgKz0gbGVuZ3RoOw0KPiANCj4gLQkJCS8qIE5lY2Vzc2FyaWx5IEVPRiwgZHVlIHRvIHBhcnNp
bmcgcmVzdHJpY3Rpb25zICovDQo+IC0JCQlpZiAoIXBhcnRpYWxEZWNvZGluZyB8fCAoY3B5ID09
IG9lbmQpKQ0KPiArCQkJLyogTmVjZXNzYXJpbHkgRU9GIHdoZW4gIXBhcnRpYWxEZWNvZGluZy4N
Cj4gKwkJCSAqIFdoZW4gcGFydGlhbERlY29kaW5nLCBpdCBpcyBFT0YgaWYgd2UndmUgZWl0aGVy
DQo+ICsJCQkgKiBmaWxsZWQgdGhlIG91dHB1dCBidWZmZXIgb3INCj4gKwkJCSAqIGNhbid0IHBy
b2NlZWQgd2l0aCByZWFkaW5nIGFuIG9mZnNldCBmb3IgZm9sbG93aW5nIG1hdGNoLg0KPiArCQkJ
ICovDQo+ICsJCQlpZiAoIXBhcnRpYWxEZWNvZGluZyB8fCAoY3B5ID09IG9lbmQpIHx8IChpcCA+
PSAoaWVuZCAtIDIpKSkNCj4gCQkJCWJyZWFrOw0KPiAJCX0gZWxzZSB7DQo+IAkJCS8qIG1heSBv
dmVyd3JpdGUgdXAgdG8gV0lMRENPUFlMRU5HVEggYmV5b25kIGNweSAqLw0KPiAtLSANCj4gMi4z
MS4xDQo+IA0KDQo=
