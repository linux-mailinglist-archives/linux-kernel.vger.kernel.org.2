Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA04556E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbhKRI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:26:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4352 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244270AbhKRI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:26:02 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AI03pqO032401;
        Thu, 18 Nov 2021 00:23:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MWj4F+rVv4hamjOnrVPoX7SUQfswkDtQ82wSzMmIeVY=;
 b=jUS+Y5hsNco1uz2mfgElpz23tmLtIsOCJT/uaqPwIwYX3VHxnxWziVk51bWHiAUlRuKj
 AZzoe8ZJG8jhLbULzYlAtXKNS7nZYSxeYF9BlWYCaLL7gCS2zooI+EtqizI3xllcMWsu
 d/odMaZpDCJnirldmTxXL5VZddnExvVjsgc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cdby4a8th-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 00:23:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 00:22:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3e6KE5oKdxryiOe8Zptzxih5BmKaIEQOBz/iH3bwS3f7dI5R+eIj/ZtAbcakKYW8bQ6BBN6y8yLmw4DllXaLGF3HeEj1CCCNujHu/z+JJTAxY6DT0bUPwiTi9cPrUpxiZ+3tVKAXgJWsrGd9MJYlSvi9lEFpzJAvEcrsnjjKfVkRap4Dli/Ne9zGOczcQeNz1IM6Gx4BzBImaEb3FN8fCaxdX2pX5wUh5aWFBg+FvOs1k8kenLc8nKluUhLVFOPWd2aeO7hAShycot77eG19qc+qvyrTCCh2OkgSPPBPoyjc7CBVqSr5niELhwa7SutJ53rSZeKzC2lYxnVJNJREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWj4F+rVv4hamjOnrVPoX7SUQfswkDtQ82wSzMmIeVY=;
 b=NRdSwx1Jcbna81HFuGKhNCPENdFBxGhpeZ3X9+FYwljSZalQvwdGp8ZGs8tV6ROtlafPhH0eCmFzlnyrivxH/vbaNO4n3p27U3CkSuX7dx0fkuFWBljEf0YBqHGfZve/Stnb+T/mPCL0s82c2wo7hjCoIOV6vHnu1Qw10j3K+KNF5Y2QwS0Vop2lh21QIMNWluERmchJS1X6sUsrpEj+DmX21HAqZx01GDXGXyEjo5D9p1P1w4PYO1gt8vsZCC51xMn3zshJewWaRSBo159RfWzDw9RBkracr3kx0jehfbNuXaT0K2EKxoZlMe/WK0T8OQPtWKG7M+vWvHAzKsRLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BY5PR15MB3714.namprd15.prod.outlook.com (2603:10b6:a03:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Thu, 18 Nov
 2021 08:22:43 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 08:22:43 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib: zstd: Don't inline functions in zstd_opt.c
Thread-Topic: [PATCH v2 2/3] lib: zstd: Don't inline functions in zstd_opt.c
Thread-Index: AQHX2+7moN3YdsIVHka9r3V//a+H5qwI6ruAgAAIUYA=
Date:   Thu, 18 Nov 2021 08:22:43 +0000
Message-ID: <7A6FE6BF-55F9-4BDD-99C0-EECB9E7E9064@fb.com>
References: <20211117201459.1194876-1-nickrterrell@gmail.com>
 <20211117201459.1194876-3-nickrterrell@gmail.com>
 <CAMuHMdU0JaSKG95ozPWQUhBBBgbGUMOrxdsA=N-q-Cm9-RoF7A@mail.gmail.com>
In-Reply-To: <CAMuHMdU0JaSKG95ozPWQUhBBBgbGUMOrxdsA=N-q-Cm9-RoF7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ade66aa0-9c89-48fe-ee26-08d9aa6c9855
x-ms-traffictypediagnostic: BY5PR15MB3714:
x-microsoft-antispam-prvs: <BY5PR15MB3714EB15F4E214E40390A261AB9B9@BY5PR15MB3714.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jv04sfWCzjtC8rCmPOaKt6kG+EgVW5cINpKIxVWzG746unBKwud1dcD4QCQX08VHAMMtFWv9/sedCwQ/rjD7EhJy32iVCQO42Coe4WO8su7+zNBFjZLGoQLs35GQY6W+LD2a4kT/EhPM8/skgzXR4pdbhzto68V1T5gredLRwjNI7rbYVRFtSq9J2Rq4iUjtN6hrqKncODgfmO9kp6CVqp+wvbdn9E28TFL8gX0t5Uk216p9BjyxeI0r+3rz9HKtg1zBcv5kEXzzQT5HXwqLzLBOvCeBOeOg46S9y3nRMjWzAMQymKD54wzUTFFfo+J0787wg5F1aZkjNq59rhLjnyaH98Uk/IwtHQBtogdoMpIveeQbnkbTF0YWLwCZ5IcCQ+th/vAFEYUNkYhkKt1B3VSMcrfN0pemk/+sv6MY0eG20k6uoIn56Pj5zUYCA+8+iJPiNP3gZtLFE3gGiVIjgOejwYuJTvRQf/jQ/bLaBzWWk4YzeoA3J8w+IDFEaSBZDQ3HntZ9m7GkwwhOSliBuBwgClWxTRgXBoEvCPhKeg9qoOKYf0nCC7omVPKd6hro4QjkPy385RHO1r9tpEAEEsjXBHb4uwvnoGRhCGFHdtUPXT6Vl+iFffm5OUPmxe3XdgOwQlcW/rcoJgSdRSPS+TwEA9cAvAfliVFlD2+bY8VUAYvLRY28gH7RoZJefh3dWHY/kyqPonPi2hxN0ewCDPj6CZsgrvDv3/IbS2faG5WZbVjDH3q3g5tkg/CZVnKvjEs8uAJXtv6wxNnnrEHLJj4aM1jL7FkQ3Euegd3m2hljfedYQY4EZN7Auqz+BTjzDQJwdpMP3aKyUfRfUlqnkJTY31VdyF7W3aydZprDh+yzhP1Iwv7pO0ctQE5Yd/mc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(71200400001)(33656002)(6916009)(6506007)(53546011)(122000001)(8936002)(508600001)(2906002)(8676002)(38100700002)(2616005)(86362001)(4326008)(19627235002)(36756003)(83380400001)(26005)(76116006)(91956017)(66946007)(186003)(38070700005)(6486002)(316002)(6512007)(5660300002)(66446008)(54906003)(66476007)(966005)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWNiSVY0NjM2dGpnRFhVd282bkJMYThCSXEweElJTCtXcDBXYVZWZVRXMnAw?=
 =?utf-8?B?andLaVdKNE5FTmlnRVYwZHg2ZG5vdGtzWVIxVnlFQTEwWVlLSDR1bER4eG9K?=
 =?utf-8?B?bHlQWTRaeUlEdzBIbGVmUVg2a0xJSWdqanJaL2hRNjd2aDFoY2hpVHpUd2lN?=
 =?utf-8?B?NHFKSWlDcURYTmtCRkUrNWZNR0lOSFUwM0krdWlmcllHK3JYVnh5Vi9IdGY2?=
 =?utf-8?B?anQ5cUsvUTRiSnl5MkJ1RURSSkJWRVV6cFJ5V3ZJS0VJNjlPWFJBV2V1SEdv?=
 =?utf-8?B?SGJVRk82UGxsVi8xQWduZmppWU5pS0V3elJYQ0FNd1VvTFQrNngraVpaa2du?=
 =?utf-8?B?MXVrQjB6eXJFVTlwMjNxRDlmSDIzdkJ5K3VreHZVTFFNb2J3TlhKRkJHWnI5?=
 =?utf-8?B?LzVUTDhNUUdqQ2kwQVpXYkVGT1pCcktNZUxEYXFGU0ZlNU9XWnRVOFludUNW?=
 =?utf-8?B?ZjlVdnlnV1Rpd0dmR2Q4Tmd4VzQ3UHlWbVl5ZDY3K2V0MDg3N1NoNnV1b2hk?=
 =?utf-8?B?b0VPV0l0R1RsSE1BOWVRa3ZyQ3ZzcUV5d016TEtwSkhObVZteE93WDh1TGlL?=
 =?utf-8?B?L3hOUG5YN1c1bi9QNEVXTUwrSUEzL2E0NU40cDRTMXJhdGtKOE5Xc1h3MVhJ?=
 =?utf-8?B?bXJzMDR6SkFZUFp1QnRRZ1NhZkoxb2I1bnBwN1dqZVFhMVlQWjNmU3dpLzRV?=
 =?utf-8?B?L3h0bk9WQjZqODd1UmU0SFp0T25IajBpQlVPaHV3RjB1M1NlWnNPZUNmL2Uv?=
 =?utf-8?B?YXdYRFpkUUozKzJ2QytNalNBVS81TFFzdUgzM0lBUVB0TTlMN2VybHV4QlpI?=
 =?utf-8?B?VlVWRnBOTGR4QklCQ3MwS0tvRUMxQ1F5blhhcWlwUk40YXZ5Vml5MENiZE1p?=
 =?utf-8?B?MCtUTlZzQU9iOXhwV0x5ODNjR3NLYXZSNEFvMTM4V3pWYkxjUDFvOCtCcTFK?=
 =?utf-8?B?VitkSHZYVDBkQkZKY05lM1lmUzNDVWRBRU42ejZKd1lSeDh1aE8rSFFNMVdt?=
 =?utf-8?B?azJmc0V6SFF4TXNObmI3SmZaNWJwbjFBOUh4aDg5UXBYOFhSMjQxNVA3Y25S?=
 =?utf-8?B?dVdDR0x3RCs5UkpvYnNyeHBCNTFZdm1hazdSekRYR1hDVXdkcFJPdHBOZGx0?=
 =?utf-8?B?b29jZFd6am05WGxaSjhmZFYvSG5XVWUzWG1jcDZReitwNGNWTHVIaEJRaXN5?=
 =?utf-8?B?Wkd3NzNzc1NFbDhUSVY1UGw0aGVjMDZpb01wSE5abDhuVUUyNjRCeWU5UkQ4?=
 =?utf-8?B?bnlEb3A2RXdNQU13TlIrWkxzb1drc0RoMmcveTJ5bmZITlo1NVBmZEVZaVFJ?=
 =?utf-8?B?WEYyUkV1R1dPTEVLZ1ZxTHBkUVZvbTNONUEvekxxbGVEU0ZubzJXbVRFMmFG?=
 =?utf-8?B?d0h2d1UwRUIybjJzNFgwYjlQNkh0SGRWMmJPanpBVmdIWU9FSlVGM0dhWTha?=
 =?utf-8?B?bTErakl3Vnp5NlpwUks5OTdjaHFCekVpSDVqRTZKZm50ejJUa0dCbjQvbmVt?=
 =?utf-8?B?Uy8xSC9Ca0xRTTRjbmprM0N0SW1zNjlnWjRIV2J3c2VwUk1MbllRdTFUK3Bt?=
 =?utf-8?B?NHpjUHJmbGxSdG1sWUlrRmIzNDNiQzlxK3J5Z2lhNjlBaStqMlBubGVYdjVV?=
 =?utf-8?B?TG9oR2ZLQWRsM1dZVXBGcDJwWi83NW1DTi9ZdnNyMnU5MTNNVkNkQ2J6cFNP?=
 =?utf-8?B?RUw5QWRra003anJWcGZBc1dvczlDMFlxbkowZnZNdWdPQW80RFRINWtyWWFP?=
 =?utf-8?B?YW85ZmFKU2RXb080VWNiREZDbGtma3FkM1lscVdJNHRnSW9PbXc4T0p3OHRv?=
 =?utf-8?B?d1BDK0JmUDI4Y3drY3J6MDA3TVNNVS9BRWo0NWdjQXpWNXB1Zm95UWxUV3N1?=
 =?utf-8?B?SzdjYVJsWFBGY3RkTU9lZmFhQURyR0NCVGcrdVkzcTBxdVNPUmI1a1Ewc0w3?=
 =?utf-8?B?T20rUTlEQS9EUExoY0ZJRUcxeE40UnZyMDVNR0pwdnhmVGVMZEt5NzZjd2Ju?=
 =?utf-8?B?eXVqSE1vNW84YThEMjV0V1dEaFZxNGY0SlI0ZHc1TlJybWpPeTc2MFc3bkNK?=
 =?utf-8?B?dm1IUmNodGFjQlNpQ0lxK2Z3TGhUN1JuS25HV1prWFhuejVsRVMzZElGNW93?=
 =?utf-8?Q?8964=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C3F6247D16C4C4FBE86FEBB6EB4E31E@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade66aa0-9c89-48fe-ee26-08d9aa6c9855
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 08:22:43.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBuK+uVZSMy3+yVXH9ZIAX1KZGY/zaXUu+vRewVdIcOvStA6GcSezfrkNuYCWEWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3714
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: KGgeYXx3UQHYOT3OLfszAPbRRC750UUA
X-Proofpoint-ORIG-GUID: KGgeYXx3UQHYOT3OLfszAPbRRC750UUA
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_03,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111180048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDE3LCAyMDIxLCBhdCAxMTo1MiBQTSwgR2VlcnQgVXl0dGVyaG9ldmVuIDxn
ZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+IA0KPiBIaSBOaWNrLA0KPiANCj4gT24gV2Vk
LCBOb3YgMTcsIDIwMjEgYXQgOTowOCBQTSBOaWNrIFRlcnJlbGwgPG5pY2tydGVycmVsbEBnbWFp
bC5jb20+IHdyb3RlOg0KPj4gYHpzdGRfb3B0LmNgIGNvbnRhaW5zIHRoZSBtYXRjaCBmaW5kZXIg
Zm9yIHRoZSBoaWdoZXN0IGNvbXByZXNzaW9uDQo+PiBsZXZlbHMuIFRoZXNlIGxldmVscyBhcmUg
YWxyZWFkeSB2ZXJ5IHNsb3csIGFuZCBhcmUgdW5saWtlbHkgdG8gYmUgdXNlZA0KPj4gaW4gdGhl
IGtlcm5lbC4gSWYgdGhleSBhcmUgdXNlZCwgdGhleSBzaG91bGRuJ3QgYmUgdXNlZCBpbiBsYXRl
bmN5DQo+PiBzZW5zaXRpdmUgd29ya2xvYWRzLCBzbyBzbG93aW5nIHRoZW0gZG93biBzaG91bGRu
J3QgYmUgYSBiaWcgZGVhbC4NCj4+IA0KPj4gVGhpcyBzYXZlcyAxODggS0Igb2YgdGhlIDI4OCBL
QiByZWdyZXNzaW9uIHJlcG9ydGVkIGJ5IEdlZXJ0IFV5dHRlcmhvZXZlbiBbMF0uDQo+PiBJJ3Zl
IGFsc28gb3BlbmVkIGFuIGlzc3VlIHVwc3RyZWFtIFsxXSBzbyB0aGF0IHdlIGNhbiBwcm9wZXJs
eSB0YWNrbGUNCj4+IHRoZSBjb2RlIHNpemUgaXNzdWUgaW4gYHpzdGRfb3B0LmNgIGZvciBhbGwg
dXNlcnMsIGFuZCBjYW4gaG9wZWZ1bGx5DQo+PiByZW1vdmUgdGhpcyBoYWNrIGluIHRoZSBuZXh0
IHpzdGQgdmVyc2lvbiB3ZSBpbXBvcnQuDQo+PiANCj4+IEJsb2F0LW8tbWV0ZXIgb3V0cHV0IG9u
IHg4Ni02NDoNCj4+IA0KPj4gYGBgDQo+Pj4gLi4vc2NyaXB0cy9ibG9hdC1vLW1ldGVyIHZtbGlu
dXgub2xkIHZtbGludXgNCj4+IGFkZC9yZW1vdmU6IDYvNSBncm93L3NocmluazogMS85IHVwL2Rv
d246IDE2NjczLy0yMDk5MzkgKC0xOTMyNjYpDQo+PiBGdW5jdGlvbiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBvbGQgICAgIG5ldyAgIGRlbHRhDQo+PiBaU1REX2NvbXByZXNz
QmxvY2tfb3B0X2dlbmVyaWMuY29uc3Rwcm9wICAgICAgIC0gICAgNzU1OSAgICs3NTU5DQo+PiBa
U1REX2luc2VydEJ0QW5kR2V0QWxsTWF0Y2hlcyAgICAgICAgICAgICAgICAgIC0gICAgNjMwNCAg
ICs2MzA0DQo+PiBaU1REX2luc2VydEJ0MSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0gICAgMTczMSAgICsxNzMxDQo+PiBaU1REX3N0b3JlU2VxICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC0gICAgIDY5MyAgICArNjkzDQo+PiBaU1REX0J0R2V0QWxsTWF0Y2hlcyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC0gICAgIDI1NSAgICArMjU1DQo+PiBaU1REX3VwZGF0
ZVJlcCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gICAgIDEyOCAgICArMTI4DQo+
PiBaU1REX3VwZGF0ZVRyZWUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOTYgICAgICA5
OSAgICAgICszDQo+PiBaU1REX2luc2VydEFuZEZpbmRGaXJzdEluZGV4SGFzaDMgICAgICAgICAg
ICAgODEgICAgICAgLSAgICAgLTgxDQo+PiBaU1REX3NldEJhc2VQcmljZXMuY29uc3Rwcm9wICAg
ICAgICAgICAgICAgICAgOTggICAgICAgLSAgICAgLTk4DQo+PiBaU1REX2xpdExlbmd0aFByaWNl
LmNvbnN0cHJvcCAgICAgICAgICAgICAgICAxMzggICAgICAgLSAgICAtMTM4DQo+PiBaU1REX2Nv
dW50ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAzNjIgICAgIDE4MSAgICAtMTgx
DQo+PiBaU1REX2NvdW50XzJzZWdtZW50cyAgICAgICAgICAgICAgICAgICAgICAgIDE0MDcgICAg
IDkzOCAgICAtNDY5DQo+PiBaU1REX2luc2VydEJ0MS5jb25zdHByb3AgICAgICAgICAgICAgICAg
ICAgIDI2ODkgICAgICAgLSAgIC0yNjg5DQo+PiBaU1REX2NvbXByZXNzQmxvY2tfYnR1bHRyYTIg
ICAgICAgICAgICAgICAgMTk5OTAgICAgIDQyMyAgLTE5NTY3DQo+PiBaU1REX2NvbXByZXNzQmxv
Y2tfYnR1bHRyYSAgICAgICAgICAgICAgICAgMTk2MzMgICAgICAxNSAgLTE5NjE4DQo+PiBaU1RE
X2luaXRTdGF0c191bHRyYSAgICAgICAgICAgICAgICAgICAgICAgMTk4MjUgICAgICAgLSAgLTE5
ODI1DQo+PiBaU1REX2NvbXByZXNzQmxvY2tfYnRvcHQgICAgICAgICAgICAgICAgICAgMjAzNzQg
ICAgICAxMiAgLTIwMzYyDQo+PiBaU1REX2NvbXByZXNzQmxvY2tfYnRvcHRfZXh0RGljdCAgICAg
ICAgICAgMjk5ODQgICAgICAxMiAgLTI5OTcyDQo+PiBaU1REX2NvbXByZXNzQmxvY2tfYnR1bHRy
YV9leHREaWN0ICAgICAgICAgMzA3MTggICAgICAxNSAgLTMwNzAzDQo+PiBaU1REX2NvbXByZXNz
QmxvY2tfYnRvcHRfZGljdE1hdGNoU3RhdGUgICAgMzI2ODkgICAgICAxMiAgLTMyNjc3DQo+PiBa
U1REX2NvbXByZXNzQmxvY2tfYnR1bHRyYV9kaWN0TWF0Y2hTdGF0ZSAgIDMzNTc0ICAgICAgMTUg
IC0zMzU1OQ0KPj4gVG90YWw6IEJlZm9yZT02NjExODI4LCBBZnRlcj02NDE4NTYyLCBjaGcgLTIu
OTIlDQo+PiBgYGANCj4+IA0KPj4gWzBdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIxLzExLzE0
LzE4OQ0KPj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9mYWNlYm9vay96c3RkL2lzc3Vlcy8yODYy
DQo+PiANCj4+IFJlcG9ydGVkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02
OGsub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogTmljayBUZXJyZWxsIDx0ZXJyZWxsbkBmYi5jb20+
DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiBJbXBhY3Qgb24gbGliL3pzdGQv
enN0ZF9jb21wcmVzcy5rbyBmb3IgYXRhcmlfZGVmY29uZmlnOg0KPiANCj4gICAgYWRkL3JlbW92
ZTogNS80IGdyb3cvc2hyaW5rOiAxLzkgdXAvZG93bjogMTUzOTIvLTE2NzIxNCAoLTE1MTgyMikN
Cj4gDQo+IE5pY2UhDQo+IA0KPiBUZXN0ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRA
bGludXgtbTY4ay5vcmc+DQo+IA0KPj4gLS0tIGEvbGliL3pzdGQvY29tcHJlc3MvenN0ZF9vcHQu
Yw0KPj4gKysrIGIvbGliL3pzdGQvY29tcHJlc3MvenN0ZF9vcHQuYw0KPj4gQEAgLTg5NCw3ICs5
MDYsNyBAQCBzdGF0aWMgdm9pZCBaU1REX29wdExkbV9wcm9jZXNzTWF0Y2hDYW5kaWRhdGUoWlNU
RF9vcHRMZG1fdCogb3B0TGRtLCBaU1REX21hdGNoXw0KPj4gICAgICAgICAgICAgICovDQo+PiAg
ICAgICAgICAgICBVMzIgcG9zT3ZlcnNob290ID0gY3VyclBvc0luQmxvY2sgLSBvcHRMZG0tPmVu
ZFBvc0luQmxvY2s7DQo+PiAgICAgICAgICAgICBaU1REX29wdExkbV9za2lwUmF3U2VxU3RvcmVC
eXRlcygmb3B0TGRtLT5zZXFTdG9yZSwgcG9zT3ZlcnNob290KTsNCj4+IC0gICAgICAgIH0NCj4+
ICsgICAgICAgIH0NCj4+ICAgICAgICAgWlNURF9vcHRfZ2V0TmV4dE1hdGNoQW5kVXBkYXRlU2Vx
U3RvcmUob3B0TGRtLCBjdXJyUG9zSW5CbG9jaywgcmVtYWluaW5nQnl0ZXMpOw0KPj4gICAgIH0N
Cj4+ICAgICBaU1REX29wdExkbV9tYXliZUFkZE1hdGNoKG1hdGNoZXMsIG5iTWF0Y2hlcywgb3B0
TGRtLCBjdXJyUG9zSW5CbG9jayk7DQo+IA0KPiBUaGlzIGNoYW5nZSBpcyB1bnJlbGF0ZWQuIFdp
dGggdGhhdCByZW1vdmVkOg0KPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVy
dEBsaW51eC1tNjhrLm9yZz4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3ISBJIHdpbGwgcmVtb3Zl
IHRoaXMgY2hhbmdlIGJlZm9yZSBzdWJtaXR0aW5nDQp0aGUgUFIuIFVubGVzcyB5b3UgaGF2ZSBh
IHN0cm9uZyBwcmVmZXJlbmNlLCBJIHdvbuKAmXQgcHV0IHVwIGFub3RoZXINCnZlcnNpb24gb2Yg
dGhlIHBhdGNoIHNldCB3aXRoIGp1c3QgdGhpcyBjaGFuZ2UuDQoNCkJlc3QsDQpOaWNrIFRlcnJl
bGwNCg0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
R2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2Yg
TGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNv
bmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEg
aGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5
ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg0K
