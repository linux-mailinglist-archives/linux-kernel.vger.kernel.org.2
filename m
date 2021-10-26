Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3413C43A9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbhJZBUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:20:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63054 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236141AbhJZBT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:19:57 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMicGA006800
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:17:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EqrVIeHfHjSp7hSfwbh2YPKMFYMnjEEmSOPa0M/5w7o=;
 b=USR2n1lyjQtSlDUu7L4669TFaFpxx0BIlr3Y63ZScG2+60KHYnB7MRbvna/EIsJQGGM8
 Ts9QEatJ+c1oN4yfcdMARy4KxRfdDe5PrMcIE+ImFU5Ffxxip4x49PXuSis7dkUXWjMR
 eV+mWUSLcmPBKHSEuqs87gAQRw78iO492Mk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4gn99rm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:17:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 18:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deUrYQ3SZCJk5orxxcNyq4Z+eh/9I/+Q8CYWt0gk/Xdax0STW+kBHYTa5QukMf8Hi/yUQigQuLl4tXdGEYZqNmJnujjk4AwKVMNM70ikBnDEaf/x56pGzv1EJzXUUJac3vQmDZfE1NoVrvsxItgbLGG4l11uhGM3etpyZSRNghollZfkdOZqeaIDqzAlF9Lw5WALWBCIEFrQYcnbxnprasm4SHSIWSd/YuTCmWwOGfxMJurL0jn3jjLvg4F2BtgBmGpEQf4WYS7Q64To8jRVUrH9a0DBq2iElMBZQCGiXdxp96C1fcdQRKMtgcp99b6+KVlG1R9ESVY4NlnzZJ+zZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqrVIeHfHjSp7hSfwbh2YPKMFYMnjEEmSOPa0M/5w7o=;
 b=HHkCK/wMxHuOhFaQIYzRKNazF6HVwjluctZ4X2qXmqpKNSWPp9kxFk+MXiUdu+OB6HWjp6lyLDCQNfCPa1BSOsHMpP66bwUEMKz6gmrTFIHxA1vqQwxA/hZ0ZM+dGJzDoiz6JxEuuo2Fm4dfXsqRN02XrLjBlg4hU2xRnRHEcCTudSmX93eGNhJZlaFRME/mvFrGuVRttYo42GpyDD9vIK4X7b7VmDVWKApWJuYf2NTGrsVhDklgImIh8z0Xc2KF9cB1ObBMN23HhpFhjvQ4FpjwLSyEJh6EK3vZfxpkHLDQg8NNhvdwZYWQcbqzlUzyyGUhovg3qmKqcpgdWkj3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2823.namprd15.prod.outlook.com (2603:10b6:a03:15a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 01:17:30 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 01:17:30 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] lib: zstd: Add cast to silence clang's
 -Wbitwise-instead-of-logical
Thread-Topic: [PATCH] lib: zstd: Add cast to silence clang's
 -Wbitwise-instead-of-logical
Thread-Index: AQHXxrmhV8EJKX2UAE+nrwZQNmVvMavkgQmA
Date:   Tue, 26 Oct 2021 01:17:30 +0000
Message-ID: <4245BD7A-4B12-4172-B4EE-76A99C717C7D@fb.com>
References: <20211021202353.2356400-1-nathan@kernel.org>
In-Reply-To: <20211021202353.2356400-1-nathan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71bc46f8-163c-4561-650e-08d9981e6171
x-ms-traffictypediagnostic: BYAPR15MB2823:
x-microsoft-antispam-prvs: <BYAPR15MB2823A5D1E86DD825CAD4F286AB849@BYAPR15MB2823.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJwIm7CM2Xh5i+BaZvTgC+JxOlDuqEVlxX6esQQIkrMwXIAN7uOLTQVV0iFo6tew5zFgO92cf//DHkq2DlpMVYBkBO48bC2OyFB6KU0O/6ty2v59OF/82wf05AzNPhT26jKNViNcPGdMgTv7i/MbSnn9BwEw9zgXsVdgW0ONsTW6oQvPip8BaaqwCCQ6epjraf4UH5tZgIq83Y91CJO4vuXewY9rzEXj3dd+gNnkOunEZ6N4v6AC+j4gvn25Im2oyM6JMROHR6AISv8B0BjRN+Ag1LrSGKmhSdjQBfjXCtg/juiNieNeOohpaWfI3hvDX2cE7i/ekUBeV+DuSZqBGpkQR+9FnvB0Ypx5SRixya23shLP4TfoAhpY8NDrpXllbOCwRt3gz6aW9KrKp/pqDg/v0ip6pSlaPmlpBJUC8+QaRIWbZZ8rTUvXFkd34pm+1wQIIqR41wI1LES/2Oubcws56WMpiv578qLs0eLIdj1cy8YOg5xrY4Ym5tVKf7ED+2MMrk9DPD3oo35tMrLU//QAJT/l/NGdEzDVvn8S+nHIEcxJ6n6/cfV0FSMVGoiEerXuEHqIjJHvGCM1u+D1KGbdP8VnPCjFU6BMGd/NQYLrsETf56MgqlGiPy+c4D7WxAXWDhUQXdK8HbGN8wNfsoPnCLPuJ5Iip9nBheCmYKHEOQXQi6hXMnUyvF+obIxk+/zsyVgWwBtLdX13XYUipSn0lpF8VX25BaMsq3xRjQuBjfi0OVIGfvD8PkFEQOgxw3aspQWJx/tXTQz+jbFEoxDE9XLXPaLcJsY4xcgp397jM7gfSz8Pm9KWD1g3/4Q1qQnYf8D0Y4wpNvoaIW5gvxqZG2t4v4Vx16Y+aFkrqKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(86362001)(33656002)(8676002)(71200400001)(186003)(966005)(6486002)(5660300002)(6506007)(53546011)(8936002)(2616005)(91956017)(64756008)(6512007)(2906002)(66476007)(66446008)(83380400001)(66556008)(6916009)(76116006)(38100700002)(316002)(508600001)(36756003)(122000001)(54906003)(66946007)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFVQK0xqUzJLU3FFUitNWXE2TW5rK09UOC91MzNHT29TSjk1Z3U3MW1lV3pa?=
 =?utf-8?B?NVhJQi84RTBsWHgza1p3NjI0b1dTZFY0Zy9BOVdKcnNBbmtPUEZ5QnJpQ2Fw?=
 =?utf-8?B?a1d3amovVXV2bTk4Ull4NS9BMGNtOVZBZm1yL1I0V3dyVGtjSy9nV3RYL0pi?=
 =?utf-8?B?UEFYTFVwaldVQXRzRDYyNkpYWTBhU3VSejdDMmFHOW9ja3NDVVVXZ3BWZThV?=
 =?utf-8?B?U2ZYNjEwcVdtQkRWYndWcmgyeEdrVkJOWjBZOGhZaXB1VnZDUXpVNTYrOGVm?=
 =?utf-8?B?MGRuelBvWVczSTMyYUJFb2lGb1VTOHFRbEU5bjdmTit4bkRSQVlRVU9SWkYv?=
 =?utf-8?B?NXBVaHovdnVIL0RRamdVYzlqREVZRTFPWloyWlhPUFRSZ2drWVlkakQvSHdw?=
 =?utf-8?B?SFQ5QzBDUjZBSEx1dnRNVmdmYzE4dDRPU1hvVXFXL0RoaFdRV1VOc1NvOTRY?=
 =?utf-8?B?V0lqZWp5TlhORGZibFRFYTRmVWxVdTdOdFF4RkZHQjVQMnY4OU94T0JScW5w?=
 =?utf-8?B?Z3NOak11RC8yVmxENDFTd3dLbTJ3UDg1VGU3WnAvdG5UL2p3eU1sUzFvWE95?=
 =?utf-8?B?VklCNlVmMU1YMFJvd3dvR3FDTlppYitrcHhxd3lOMGVPRmlUOCtMRjc1YVU3?=
 =?utf-8?B?c2RLRnJMeCtzbFpaNXllUm41UXJmMmFFM0M2dzhSMWlOemlzYzJHMW1vbVJV?=
 =?utf-8?B?SkZXd1lTZThDUkNST29GYXBGL3d3VUlJMXJndWFQQ3lvV3ZSL0hiU0p0bC9i?=
 =?utf-8?B?ZW9VTDBTRGV6ZDhOSk5LTlhuYnF1U0ZaeEZMZ1p3UWQ0VmZRejdHLytJaW9p?=
 =?utf-8?B?dFBCOGRCNnBGT09zWmVJVDdmZXlEUldiV0NvMXlRWDJRNkYwbHMvVmRNYlZC?=
 =?utf-8?B?WkFWMTlFazB4UnJVZ1NtbnRKMS9mbjRuTlpUcThlYWlxV2tueCt4R2dCdFVv?=
 =?utf-8?B?dm5jdEMxeTlOcFB4SWNVbzgxbzVaSmdxQVdtNFpJOXpZRE00TllKRXZCWGZL?=
 =?utf-8?B?cFdOSXRpR2J5M3Y4dE1wZzQ2b2o4UmNmSnpoZGM3SmhrOGhyK3cwYTNwVG9I?=
 =?utf-8?B?dkI2QzhjWnlQYmNZVHBvaVZWOGFJYUhSNmdnOEczeFVBNFJac0dST3dTbm1u?=
 =?utf-8?B?WkozMjZIN1dPV2FEbFB1V29PbDFwZ0gxaXNOd2RkREsrR2RPUzNKUDRzeGpn?=
 =?utf-8?B?WVNBUVRTWEx5SzllSUI5QW5VNlFLMDM0amhMdTR2Mis3WkltY2ZJMUwzbXBy?=
 =?utf-8?B?bkw2Z1BJUis4YWpSQ0k3Q3FtM2xnbzU0bzlnRjlqSkNneHBMSlRodHFGNFh1?=
 =?utf-8?B?RXJDRWFwbm9ROU82MkZDY2RvZDEyczNjMzMvZ2RVWklVeWJXNGIxdXNnSnFV?=
 =?utf-8?B?cUx1Sk1JU05OWFd4NEZqK3V6WTNRTkNBWTZiam42SDJwMDdjL0xEend1Y2hI?=
 =?utf-8?B?UTREeEdmajdmYzRXUkRsUGxsNjlnNzBKLzY1TEYyWVlxWmM1SzJWaElDbU52?=
 =?utf-8?B?Qi80NzdrR0tCZ1NrUENRT2N5TzVnRlB6YVE2VmUvTXNxY3REKzFtZ285Q1dv?=
 =?utf-8?B?akdiVkgwd1FML3kzZjArUGxSOGNva2luc2FkMHNYRXBMVkp4d2NYUEhVUkt6?=
 =?utf-8?B?R3o2aGJYWDgzbXNUTXg1eDAvZFhGNENuZG5xeHpxZjE2eCt1ODB5eUtQV0F0?=
 =?utf-8?B?YytIWUNmUW11MEhOYmVnaVlIMTRyMytlbWN3KzRoREFnZ2t1QXc1M1pSYnkx?=
 =?utf-8?B?b2lSWkcyVDBVYTJIYVRXdW1scTA1Z0x3R2h6bGRFTDdCbnRzL0cvdHJMMnBw?=
 =?utf-8?B?UThuWDRDR0NkZ0p6UkpaZ2VjdE9LTUJhUW1vNkxoc1pmUEEwRDJGTXlQMGpF?=
 =?utf-8?B?MW5sVDdMUjBzY282VGF2UG9jSUtSM29MYWQwZk8ySlJBYVVFNHJLdjZvZHAy?=
 =?utf-8?B?eGtvblI0eVF3SFdFTDFKSFIrSnpBOXdsUmQ3dWI2TUI4eTF6dll3U1RPcURO?=
 =?utf-8?B?Y2c1aVY3YUhEWWExVXdjcnJPMjJXU0h6TGJ0QkttRSt2YktXL1NvLzJKV21V?=
 =?utf-8?B?N1FDTWwzd21IaWs4dlZaK1ZBeEcxbjZoc2RVSnhKWCsyM0NzblcySlVpdTJh?=
 =?utf-8?B?Y1RMRFpmdjNLOFNDeko0U2dCSXp6NCtLZXFuYWRXREROQUZaTk9mSVpjVVlV?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <730DBF67B10F8347B42787C1D4BB86F5@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bc46f8-163c-4561-650e-08d9981e6171
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 01:17:30.0358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kc6kYFMFxGrB/4vXzSQaTll9jeBeiP8GqK2XKJc9d25PKoQG6bPCbGlEXfGFrp1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2823
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ugiC_Zm3QH50JCCrhcaC8zTmHu9aupQm
X-Proofpoint-ORIG-GUID: ugiC_Zm3QH50JCCrhcaC8zTmHu9aupQm
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110260005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDIxLCAyMDIxLCBhdCAxOjIzIFBNLCBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0
aGFuQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gQSBuZXcgd2FybmluZyBpbiBjbGFuZyB3YXJu
cyB0aGF0IHRoZXJlIGlzIGFuIGluc3RhbmNlIHdoZXJlIGJvb2xlYW4NCj4gZXhwcmVzc2lvbnMg
YXJlIGJlaW5nIHVzZWQgd2l0aCBiaXR3aXNlIG9wZXJhdG9ycyBpbnN0ZWFkIG9mIGxvZ2ljYWwN
Cj4gb25lczoNCj4gDQo+IGxpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYzo4OTA6
MjU6IHdhcm5pbmc6IHVzZSBvZiBiaXR3aXNlICcmJyB3aXRoIGJvb2xlYW4gb3BlcmFuZHMgWy1X
Yml0d2lzZS1pbnN0ZWFkLW9mLWxvZ2ljYWxdDQo+ICAgICAgICAgICAgICAgICAgICAgICAgKEJJ
VF9yZWxvYWREU3RyZWFtRmFzdCgmYml0RDEpID09IEJJVF9EU3RyZWFtX3VuZmluaXNoZWQpDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IA0KPiB6c3RkIGRvZXMgdGhpcyBmcmVxdWVudGx5
IHRvIGhlbHAgd2l0aCBwZXJmb3JtYW5jZSwgYXMgbG9naWNhbCBvcGVyYXRvcnMNCj4gaGF2ZSBi
cmFuY2hlcyB3aGVyZWFzIGJpdHdpc2Ugb25lcyBkbyBub3QuDQo+IA0KPiBUbyBmaXggdGhpcyB3
YXJuaW5nIGluIG90aGVyIGNhc2VzLCB0aGUgZXhwcmVzc2lvbnMgd2VyZSBwbGFjZWQgb24NCj4g
c2VwYXJhdGUgbGluZXMgd2l0aCB0aGUgJyY9JyBvcGVyYXRvcjsgaG93ZXZlciwgdGhpcyBwYXJ0
aWN1bGFyIGluc3RhbmNlDQo+IHdhcyBtb3ZlZCBhd2F5IGZyb20gdGhhdCBzbyB0aGF0IGl0IGNv
dWxkIGJlIHN1cnJvdW5kZWQgYnkgTElLRUxZLCB3aGljaA0KPiBpcyBhIG1hY3JvIGZvciBfX2J1
aWx0aW5fZXhwZWN0KCksIHRvIGhlbHAgd2l0aCBhIHBlcmZvcm1hbmNlDQo+IHJlZ3Jlc3Npb24s
IGFjY29yZGluZyB0byB1cHN0cmVhbSB6c3RkIHB1bGwgIzE5NzMuDQo+IA0KPiBBc2lkZSBmcm9t
IHN3aXRjaGluZyB0byBsb2dpY2FsIG9wZXJhdG9ycywgd2hpY2ggaXMgbGlrZWx5IHVuZGVzaXJh
YmxlDQo+IGluIHRoaXMgaW5zdGFuY2UsIG9yIGRpc2FibGluZyB0aGUgd2FybmluZyBvdXRyaWdo
dCwgdGhlIHNvbHV0aW9uIGlzDQo+IGNhc3Rpbmcgb25lIG9mIHRoZSBleHByZXNzaW9ucyB0byBh
biBpbnRlZ2VyIHR5cGUgdG8gbWFrZSBpdCBjbGVhciB0bw0KPiBjbGFuZyB0aGF0IHRoZSBhdXRo
b3Iga25vd3Mgd2hhdCB0aGV5IGFyZSBkb2luZy4gQWRkIGEgY2FzdCB0byBVMzIgdG8NCj4gc2ls
ZW5jZSB0aGUgd2FybmluZy4gVGhlIGZpcnN0IFUzMiBjYXN0IGlzIHRvIHNpbGVuY2UgYW4gaW5z
dGFuY2Ugb2YNCj4gLVdzaG9ydGVuLTY0LXRvLTMyIGJlY2F1c2UgX19idWlsdGluX2V4cGVjdCgp
IHJldHVybnMgbG9uZyBzbyBpdCBjYW5ub3QNCj4gYmUgbW92ZWQuDQo+IA0KPiBMaW5rOiBodHRw
czovL2dpdGh1Yi5jb20vQ2xhbmdCdWlsdExpbnV4L2xpbnV4L2lzc3Vlcy8xNDg2DQo+IExpbms6
IGh0dHBzOi8vZ2l0aHViLmNvbS9mYWNlYm9vay96c3RkL3B1bGwvMTk3Mw0KPiBSZXBvcnRlZC1i
eTogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4NCg0KVGhhbmtzIGZv
ciB0aGUgZml4IQ0KDQpJ4oCZbGwgYXBwbHkgdGhpcyBwYXRjaCB0byBteSBsaW51eC1uZXh0IHRy
ZWUgYW5kIHBvcnQgaXQgdG8gdXBzdHJlYW0genN0ZC4NCg0KQmVzdCwNCk5pY2sgVGVycmVsbA0K
DQo+IC0tLQ0KPiBsaWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmMgfCAyICstDQo+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2xpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYyBiL2xpYi96c3Rk
L2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYw0KPiBpbmRleCAwNTU3MGVkNWY4YmUuLjUxMDVl
NTlhYzA0YSAxMDA2NDQNCj4gLS0tIGEvbGliL3pzdGQvZGVjb21wcmVzcy9odWZfZGVjb21wcmVz
cy5jDQo+ICsrKyBiL2xpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYw0KPiBAQCAt
ODg2LDcgKzg4Niw3IEBAIEhVRl9kZWNvbXByZXNzNFgyX3VzaW5nRFRhYmxlX2ludGVybmFsX2Jv
ZHkoDQo+ICAgICAgICAgICAgIEhVRl9ERUNPREVfU1lNQk9MWDJfMChvcDIsICZiaXREMik7DQo+
ICAgICAgICAgICAgIEhVRl9ERUNPREVfU1lNQk9MWDJfMChvcDMsICZiaXREMyk7DQo+ICAgICAg
ICAgICAgIEhVRl9ERUNPREVfU1lNQk9MWDJfMChvcDQsICZiaXRENCk7DQo+IC0gICAgICAgICAg
ICBlbmRTaWduYWwgPSAoVTMyKUxJS0VMWSgNCj4gKyAgICAgICAgICAgIGVuZFNpZ25hbCA9IChV
MzIpTElLRUxZKChVMzIpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIChCSVRfcmVsb2FkRFN0
cmVhbUZhc3QoJmJpdEQxKSA9PSBCSVRfRFN0cmVhbV91bmZpbmlzaGVkKQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgJiAoQklUX3JlbG9hZERTdHJlYW1GYXN0KCZiaXREMikgPT0gQklUX0RTdHJl
YW1fdW5maW5pc2hlZCkNCj4gICAgICAgICAgICAgICAgICAgICAgICYgKEJJVF9yZWxvYWREU3Ry
ZWFtRmFzdCgmYml0RDMpID09IEJJVF9EU3RyZWFtX3VuZmluaXNoZWQpDQo+IC0tIA0KPiAyLjMz
LjEuNjM3LmdmNDQzYjIyNmNhDQo+IA0KDQo=
