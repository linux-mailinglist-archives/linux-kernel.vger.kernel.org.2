Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63C64260F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 02:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbhJHALo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 20:11:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34510 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232682AbhJHALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 20:11:43 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KCJY2004500
        for <linux-kernel@vger.kernel.org>; Thu, 7 Oct 2021 17:09:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lIy6W8814it+snFWkS8hlcxdUwo0QKkUrNj4+l9zKyU=;
 b=nY5djkDRrduaIKo77zddWp42BbCRrLJ10JxxNWbXqLckafImZ1Miq9sVtCXxr8VaDrt1
 EkgeWtl64e9VCwPt2vMbZ47FJ2U7rZXs7KO9VVsVfbs5da3CeEp0AE0ZoN1grz6Eaxfo
 8P2we4q3nVAg4eR49tM98brJLOj1qzUMuxY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bj7q9hmjj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 17:09:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 7 Oct 2021 17:09:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5x+Ct5zRg0WA5Bjx0VjBOj0qbxFr3lrdO6T6sms5WWh/UQUeZAIrZKr0eMMtSAVgQV84TBONJWn7JUspvIXFeazZq1Y+aluQCEHsaWsnFqmdbztwfR+73HobKC3f9mNvPrIaXAz4VJOsJ0WLbj81PL8MKNsd3EZaBF7ARZlW07+KqYSHfEUg+HXEtX5twNiTpbresdSN/rpQTJ7HhDrl7p0YRAyFEhMSBBPFDDgbrO/RvhEN4DMU6mkdjPvjvH+lwmY4xHuItDwf8hEzRp5jl/JnCIbuRztrzjzm6GWJhEbNEKdyRuu3Z0OBL6RV+SqRwG1Eni1n1JLRQB8O1l+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIy6W8814it+snFWkS8hlcxdUwo0QKkUrNj4+l9zKyU=;
 b=SAtaRD7+E3KCPb88cm7RfeaRDX4h4hCiBjyiwZDqyUBEPfmMsYVhrl0VdBw8gJFTTuk96HxZMog09coi1w7ZNjel80jNoqnSpKwUyvBXZPuraGNPEhRK06sOmYVYX7zbKD+fLUQzpm4p3ltzF8XmwhWTevkudIzcPl67xV58sV429l1g4WzENOoM8Qw2e8KNQztItUjG8lGbpXmaqQLY1rxePKKrCAzjX3CbZzEeIoQ+C4VJ3hWj/229q3twn7OnH9VeS1rSTI27e4fVMC1TNG6D6z9jiOdBXS6GSjvpjZMl+5d6h8xCkIJzMoPMWRxMFCIylnNTPQIJHm8kqfCMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB3207.namprd15.prod.outlook.com (2603:10b6:a03:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 8 Oct
 2021 00:09:46 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4566.023; Fri, 8 Oct 2021
 00:09:46 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH linux-next] lib: zstd: fix duplicated inclusion
Thread-Topic: [RFC PATCH linux-next] lib: zstd: fix duplicated inclusion
Thread-Index: AQHXu9MMls7MqBGvD0WWpmB9pDAx1qvIOfQA
Date:   Fri, 8 Oct 2021 00:09:46 +0000
Message-ID: <88ACF3A0-13B2-414C-ABFA-36CDF1BCCC27@fb.com>
References: <202110080712.2N06tmuF-lkp@intel.com>
 <20211007232743.GA59732@7c2d80b4df4a>
In-Reply-To: <20211007232743.GA59732@7c2d80b4df4a>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fecc36f6-4212-455f-8f1d-08d989efeff7
x-ms-traffictypediagnostic: BYAPR15MB3207:
x-microsoft-antispam-prvs: <BYAPR15MB320710CC6B240272446418C3ABB29@BYAPR15MB3207.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwnb45gHtwFMsfAI3IOMZ269OOxbuFZL0ViNNUOFxNUCRxRBCPQ4bfmPSVnTZw07yenYfAwUl5RSDcaL7t6gjocbCOzM7Tqqrw8BmMXGSJe94ftDv6hGvyVs0l6kPH7HmELiS8B6ajjKaMKsMNhtRrXRNrfkHzyStiJJlxWFyVYD8cI29vEJOHc2MCGARk1fJLVtBr2HkDzk6qKr/65FQG4t1WcFcVseg12g3vrMlRQiI703naQ+TVBAfmZw2iMtf6tdNeh7uS6KE+6MoTmJILm4xTzPFjxBvipMp4J8kpJJx6mj+j4ctX2EKuqzEo2TumaC2VAzjXdWRh4PDBOAuJWZ+zoKGeVRxoa7suuUGy1DD1lbmz9VMK+mY4c+L9HedVljsX2yBc4W9ffGyvcCRn38EirZNYmkPwObu4cXZgzVOIDX8EUNV3BthfyiBPAFEwk31IZuOQW034SIcMR4qawzPv2TZDnz+60rFh4sgWDXV8ZUnuA87SidR3NA7EORpcxfLrXkdYZPiWhWI34WiPBpfP90QpfD5IGLtR5FusPDAWmH5hQphQSAJ86w5iTC2n4VBJKD275sDQsPWv6Y207KXtijQfMyatZ9YC+0QG1GKFNyxD//gMlYEaivoys2MGOrPh4Q+VGKSr4N+yVj7FXIlBdomP3CPj6WtHnOZ5Cgf7AyPfpgsgrWFuITB0Zpo98ja3+DafOfruaSgmqRLKk5lIvT23FcPg2RhuSFiedsBnV9+V6irXA7/rmp+Afr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6506007)(64756008)(66476007)(66556008)(86362001)(53546011)(4744005)(6486002)(66446008)(2616005)(8676002)(4326008)(26005)(54906003)(5660300002)(66946007)(8936002)(76116006)(316002)(6512007)(2906002)(33656002)(83380400001)(36756003)(38070700005)(71200400001)(186003)(122000001)(38100700002)(6916009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFhMTUdQTGxQREw4WTRvMjc5Y04vTitTVEVzS0x4ZXlEejkzLzdzTWRsZ1ND?=
 =?utf-8?B?Ui9jVkloYmw4QTM5U2JhM011VlU4WllxNU5uaFhoVTg5U1MvUERLYTlhTHo2?=
 =?utf-8?B?cjBOd2JBMnNobWcxS2JHNW5GNHlERUQwVnhReGpGY3F4M1V6YWx1eklyd2Uv?=
 =?utf-8?B?M0VBWnhXQ0pEbURUQXExOEh5OFRGM3Zobis4bWVNTmZwaVh4Sk5XYUk5bGdt?=
 =?utf-8?B?dzdxb3VwT0hJUVdiZ1lxdVBvZk9Zb1dPdW80ckRzeS9MTHNka2M0RTRVU2xm?=
 =?utf-8?B?dDFWWS9rajIvTk9RdGlwUlByQ0s4Q1dicnNaVVdxZEtuWHpRVVhwTW00TW9a?=
 =?utf-8?B?MkNDV0sweEp3cFh1MkJQNmVwZ1FjRmZ5c2k1M0pnbDRVMDNvcTE1VmlEcVNT?=
 =?utf-8?B?a0N5cHROZ2NPZ3lwd0xQSVBHM1VqSlVvVXFwMmU3U0l3d3JaTFBqMFdNUGls?=
 =?utf-8?B?aDNEb0JRcWQ3ajg0dk1pU3o5YjFjb0ZwR09wWW5DSXJlU051MHg5STBLdDNZ?=
 =?utf-8?B?VHFVNmQzMTArRDJRbnk5NG5vWGpuVWJPcU1ySko2NlJxZ0JHdUR6RnFOemVS?=
 =?utf-8?B?WnVuZ2hZSmdmM1BMNUtMcGxMaXRYZkNOVVBzQ20vbXFlVWQxOUlTWTB4NXdl?=
 =?utf-8?B?WUxZSlJaVnp2WEdnOHZqZmJWUXFraGhOUGRXZ01PZE5LTWVXeTBrMWZISjNN?=
 =?utf-8?B?OXU5K0hMV3dKMTdZUlpJbm1jNGJIYmFiL1ROdWxhUzZwdjJxbWpvVFNaazBo?=
 =?utf-8?B?SDhGZEM1cjdiblJmY1BTY3RjbVRFclRqbHZZYkZUNDdMRVVOYWtkbG84ekNx?=
 =?utf-8?B?SHIvNEwrQUVTMEU3cVloVGdHSi9TOC8wMGFua2ZCdzVlS3lKUEJ0WHhvZG12?=
 =?utf-8?B?VVd0RkJFUmJsRDZkdDAxZjVuUHRkS0lFbkV3R2hoRmlXOE9mOHZvSVFnaDZT?=
 =?utf-8?B?SlJhR3NqQWc2K1Y4L0c0SUNUYjNWb1A4Si9HK3gxSTZLYzV3WGlRKzVsMmJp?=
 =?utf-8?B?a2dRZGZEeEZ4dFArVTY5SlZjRWdPWnRpZ2tCMEo5b0ZpN2xqcFJpVlh4KzFP?=
 =?utf-8?B?TS9LQ0twUkJkVGVJdGh6a1dleHNxVmk0RGlhbHhqajZMNlZQSzU3N25qZjJ1?=
 =?utf-8?B?YU1TWmhNaEcxd2JSM0RzSmVCZDVYVWF5a3pnaTNCR3pXN2FkZkovUFB1bi9L?=
 =?utf-8?B?aXR5c3BNNXRsM0ZER3YwY1NwclNwQUdtMUV3RFJZdExIenJLV0NMdFNtVWlp?=
 =?utf-8?B?MkhZaFJRYnltMUJzVEpMVGdubU5qUGh6QmppR1VXeWp2ZC9GVEFVdHluTGpZ?=
 =?utf-8?B?ZGhVYVlTaU5QMStscmlWM2R6MmgvbDI2OFF3VWR1ekpEM1pScmF4SUdVcUI2?=
 =?utf-8?B?aHhDWHFMcnQxcVlsQ2JGVFpXajZQSEMzSzNXWkowdzZKL2FrVGF5Y0Jxdmsx?=
 =?utf-8?B?cWtsM0NxWUZ6TzNpb0dNVkJnRDQ4WHI2azBOVnJDWHQvMzRMSS9pN0VOYUVa?=
 =?utf-8?B?K3lwMEVYUG5XbTIvbTRwNGg3SThsaHlsajB5YzdiSXFiZDVZT0RxWWh2N1Zs?=
 =?utf-8?B?TW9oVmE0VEFXa0RTTXhUT2F5YWViR1FIZnorUnd4TThlcm1sYm8xazlsS0xO?=
 =?utf-8?B?T1JtbWQrTHhWREdvOEJMY0hBRkppZm5idTZNbmp2SkdxcEtKeFlYZDVaMW1K?=
 =?utf-8?B?bU1tYkFLUkh1Y2VmeTAyVTdaT0FlZk1jUGFxc1RzaVQvVWhHZXJOL0tUcVRu?=
 =?utf-8?Q?8ILASI9HL2sqg4EyHDgehuvt/njvCvE+N3bNT5P?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1615C2FB73393E4FBB823AA37C37344C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecc36f6-4212-455f-8f1d-08d989efeff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 00:09:46.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuCTqHHxVjiVLdJgO5JB3H6a4QiC9gXkb/SA5fDn39EltYq/IJN6r9TyLJq0bJzT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3207
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: V4ZwCVg6Cb_JFqII64UTduf6YAAT9p8S
X-Proofpoint-GUID: V4ZwCVg6Cb_JFqII64UTduf6YAAT9p8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_05,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDcsIDIwMjEsIGF0IDQ6MjcgUE0sIGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IEdlbmVyYXRlZCBieTogc2NyaXB0cy9jaGVja2luY2x1
ZGVzLnBsDQo+IA0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0K
PiAtLS0NCj4gZGVidWcuaCB8ICAgIDEgLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi96c3RkL2NvbW1vbi9kZWJ1Zy5oIGIvbGliL3pzdGQv
Y29tbW9uL2RlYnVnLmgNCj4gaW5kZXggNmRkODhkMWZiZDAyYy4uYzhkYzBiMTg5MDM2OSAxMDA2
NDQNCj4gLS0tIGEvbGliL3pzdGQvY29tbW9uL2RlYnVnLmgNCj4gKysrIGIvbGliL3pzdGQvY29t
bW9uL2RlYnVnLmgNCj4gQEAgLTY1LDcgKzY1LDYgQEANCj4gDQo+ICNpZiAoREVCVUdMRVZFTD49
MSkNCj4gIyAgZGVmaW5lIFpTVERfREVQU19ORUVEX0FTU0VSVA0KPiAtIyAgaW5jbHVkZSAienN0
ZF9kZXBzLmgiDQo+ICNlbHNlDQo+ICMgIGlmbmRlZiBhc3NlcnQgICAvKiBhc3NlcnQgbWF5IGJl
IGFscmVhZHkgZGVmaW5lZCwgZHVlIHRvIHByaW9yICNpbmNsdWRlIDxhc3NlcnQuaD4gKi8NCj4g
IyAgICBkZWZpbmUgYXNzZXJ0KGNvbmRpdGlvbikgKCh2b2lkKTApICAgLyogZGlzYWJsZSBhc3Nl
cnQgKGRlZmF1bHQpICovDQoNClRoaXMgaXMgYW4gaW50ZW50aW9uYWwgZGVzaWduIGNob2ljZSBv
ZiB1cHN0cmVhbSB6c3RkLCBhbmQgaXMgY29ycmVjdC4NCg0KRGVmaW5pbmcgWlNURF9ERVBTX05F
RURfQVNTRVJUIHdpbGwgY2F1c2Ug4oCcenN0ZF9kZXBzLmjigJ0gdG8NCnByb3ZpZGUgYSBkZWZp
bml0aW9uIG9mIGFzc2VydCgpLCBldmVuIGlmIGl0IGhhcyBhbHJlYWR5IGJlZW4gaW5jbHVkZWQu
DQoNCi1OaWNr
