Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BAB454B82
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhKQRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:05:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21438 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230228AbhKQRFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:05:10 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHGUrfr004195;
        Wed, 17 Nov 2021 09:02:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ghLjXXywqwfXJyek+zz+WoJroZIwsOY+fa/2SYBrKLM=;
 b=GZlX3nk2XoSl4iP9XbPMXFeOLWfD1YD+SbuISkKlHpB1IfKUeGogn9ChjuE2t55Oguuv
 EiOTXa6OjrlrvCwN2pNOFshP5GUoLnrPer5pjd9Eh1nbr5UwwifKsQOfATTYE3++2dgZ
 Lzinf6ZD+wb9uI5euMan0BV9jai7LCfq9mo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ccuxsbtuh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Nov 2021 09:02:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 09:02:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YksA7l0jeEqseIfnJXJz/2RPCWQfc8EiWw3LqUpfR8JxVDYL6/X17qIOFiL7rDd2bkP9vP7HDYMrlSYC5po4mbpeyPet7GbfS2H5a8KNNgVnfCeErXlQHeQm3JObhujm17NGILYhFZqilVSCPUoOfvxJzsa13LOjA4wprVu0ntMyiDcfFJI8gK1K2twptznBK0e55TsjERKb6ggJ2pnTaBagDNDtOhMLBnXbZfS1UmZB03Q04pOBNx9nzpJrV6Vo7QCmW1l3D0jeM2YhVHmMApfMOMkKcuo67Q0iVBKwPSNbphk9isMq7+mQE8vb8+LPDyWO8IRGvCRWQUHITlTq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghLjXXywqwfXJyek+zz+WoJroZIwsOY+fa/2SYBrKLM=;
 b=ecON2an+qRh1kTwWEOGa8OiXBzcnSfJT8FceORgY++d3l4lpW0katPrmr5OojM11EQm8XkrfWfQE0ekyyPUpkHB/ydxPnYGS0kBoxftrjL2LFMQ2SdNJXMh3DEEwH+fc5LKXYfkHAS3KDnb8yBZQT0u9BIOzpUXDyYWVgDtHQKNm2RcdbGyoAOrt+AVU7KT5LJkcr29qWkKweRXd3yL6+/BtKBRMMWDC8ssQrhc/jbrdc2rAVRoCDae5BpXrhJDQJLmXyHGGBpbYIAr6I9FiB04GSTb+5Ksy0BUj77iy8Azg2QS0iUzEawtdMKQ9OJyU/9qIE7QMET7WoSRhjtY50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BY5PR15MB4787.namprd15.prod.outlook.com (2603:10b6:a03:1f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 17:02:08 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 17:02:08 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] lib: zstd: Fix unused variable warning
Thread-Topic: [PATCH 1/3] lib: zstd: Fix unused variable warning
Thread-Index: AQHX21SKEl4Mk4VAvk+gjC4wH9+1L6wH7oMAgAAEiQA=
Date:   Wed, 17 Nov 2021 17:02:08 +0000
Message-ID: <47A2B47F-CAC5-4DAA-A8FD-1D3E08E7CA73@fb.com>
References: <20211117014949.1169186-1-nickrterrell@gmail.com>
 <20211117014949.1169186-2-nickrterrell@gmail.com>
 <CAHk-=wibYLDep=BPrUaw_wuZRDXnq5BVtG-6gLuBq6+3fdMhOQ@mail.gmail.com>
In-Reply-To: <CAHk-=wibYLDep=BPrUaw_wuZRDXnq5BVtG-6gLuBq6+3fdMhOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0f0d10f-4014-448f-db84-08d9a9ebfd91
x-ms-traffictypediagnostic: BY5PR15MB4787:
x-microsoft-antispam-prvs: <BY5PR15MB4787900D3D71DC0185BEFACBAB9A9@BY5PR15MB4787.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e93/wMVX00upwuNkPXsjgjNBkz6AMK0dwuTj7OdzJxmaO7luN9q84OwURck09RMkpMStzvaFUPVC1OKTz9vYhxcTgfSca2qbvFLBKu/lezAxiDto+2FGMb1Km4ezFmQSPYpAbsB0lEUk6Hkx9lG2dXVq8+gb4gZfvwzzzWYFyyPt0YTw66iAYJ9FB08+9edZ2OKPICBMzOB9taDdDt6oDGYXrMXorYgUQKHtv0aQbS6QZVMImTVefJn3BNmduk7j6pCaJ2/zutr0lRnghU0DxLEb8+M93/wm8DaBCanzx4d955seOEh4SE6aIipF9toZv463bLd31p3Ex0tfTKYDg+hZNxjlb73T5e8YmyJMig/0abHIdk1uvIAUv3d69W7XExDQDCQyZ6p6CbfItHFMXl14+EOe5xYpRKKNbC2iMd3znpsKmUxcXEMoJ408CW9l/wBY1EDVX9Wg1W3KCHbjHilY4mwC1T+5o8fCXhSrDNoshAujOAhznXN4LCVHqcpaiIexCfFOn9ncnjaNEua9sFwCG1LM1ELOa6smjbqEjkPZ6zTbwJmaoGJ2xIrdpxM1UvBE7vR5kP0xNaqrDLIIE7eLqQq7ILSZYWn2jOzkm9o2FFFQ8v9CmGUh+KkqNGLg5vWPcWhF9iQpc1MjH33zSwhEGeDr/4fKk1tUrBpM89IMkTBAfJAo5hdUpIWIbIGKRMSTz1Ojjaf7hFXO7+kUDNw6Yi42Mck0tXJ+dJcfkgVF0NptOLEEN9Y7p8mr887K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6486002)(6512007)(83380400001)(38070700005)(8936002)(53546011)(6506007)(8676002)(86362001)(71200400001)(4326008)(54906003)(316002)(186003)(122000001)(64756008)(38100700002)(66476007)(66446008)(66946007)(66556008)(5660300002)(33656002)(2906002)(36756003)(2616005)(91956017)(76116006)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RERLR0JuZXZKQ1A0MWhJKy9kL250Qy94bk56ajFYNHlxQU9YOGFIczNZN09t?=
 =?utf-8?B?KzZCcERaTThoblJPaTNFeWtrWjM4S2hDbXM4Q3JMNlQyQ09EVytDelFIUnBt?=
 =?utf-8?B?RWs0UjNhM3ZjdnBtTWZuakVyK0VXU0hqRFdOYmN2Z2hQQUEzMjZONmVBWFVT?=
 =?utf-8?B?ZE16OXcvQU5OaTdwYnFZejVkMitneERpVWRtK2ErOVZ3QmtLVWtEZHQ5NFBz?=
 =?utf-8?B?NjVhKzdWSTdnNHpWWGhsN1hWTHdJTkJ3WlNDN1ZiQU4zdjZDR2F0c3lSSDhs?=
 =?utf-8?B?MGtBenY5djFmL1cyUG8yRlJTVTdyWlNWeTVZV2Z6VzNxOTlNbXI0bVNJS2dx?=
 =?utf-8?B?enUwSWJtZUVLZmtXdi9XVWM4RjZXbmlPSzNoZFJ0U29BdFlFRkJvM0dtWXdB?=
 =?utf-8?B?dy9iVW5YOTBKRFhjZGU0MlNzampmKy9kOTFKMnA1Nml2YmtOZHcrZFRtNkdP?=
 =?utf-8?B?NVk2KzRGWnBMYVJhRldwVlRKVDFBQUFoQzhja0FaUTdPNm1BcWFCVE5GMXlR?=
 =?utf-8?B?RjhDdkVkMjdaZUZDNzIyOEU3QnZxNUVVQjd1ODBEN3JpSlhzZGV2VHErYzdu?=
 =?utf-8?B?SGJWcDQvYlBGRkpkY0NkVnNvYlZqaFJPT3RPUjNUVE43bFowODRKbmU5WTRT?=
 =?utf-8?B?K1Q2ZWd0OXJ6ZXFNTzdnbHErMkVncTh6UmQrTG52MHNjekxNeVhaZVpQbFFP?=
 =?utf-8?B?a2V3eHQveWFnOTRCY0NRMTdhOUFTRXhIbUlnVWkzb1VFK2ljTDlLNmZKMi9k?=
 =?utf-8?B?UDBzUUNYaTAzSFBUOVF1MnFMNXZZSmR2VXN4SmJPUTBrZnJ3eVV2RmtJcGZE?=
 =?utf-8?B?b3RTbGtpeU1rTFRMMjE5M0V5MlRleUZuN1FwZ0d5bVM1MVdkMEZrUkYxTWNp?=
 =?utf-8?B?VXZnM2FYa0duSW03SUlHbVdOeWg2NnRBQy9HV0htZVZ4eFNLNjNWMGpkQitt?=
 =?utf-8?B?aDFWdFRjc2gyRHZMOS9rSDVSSjNTc3JMYmNYbjQ2elRpazY1OGdXaDVKZnFT?=
 =?utf-8?B?U05ETzVLejB5ZFNKelZTSDZ6dzlDeXhvRUIwZjFHQzIzUmZMUXo5UW0zd0FP?=
 =?utf-8?B?Z0lFckJDV3ZhZE53c1VVM3JSY1o5V3JJWUg2RllCNU53UHBwOWtmZEZ4QTBE?=
 =?utf-8?B?bzhaRE1hWGpETDlIWmJWb29JbUZCMzkzMmRDdWQveHVxREtYQVRPc3Qvb2xY?=
 =?utf-8?B?VTRhQWwxNElCTytiYjlvMzI4NVBLSnd3NGNETllsZHhBYXBCalQwdGlHeFhq?=
 =?utf-8?B?dklCT0MxWVBrSy9YN1hMQUpjMDY1eWNzQmM0TjlETE1MSTZneFptbnJjNk5s?=
 =?utf-8?B?SEpVNDBTVkNtbk9EeFpaZmw5R1BITEYvbURoMldmUHo2UUVzbzdSRU8xN0hs?=
 =?utf-8?B?Tm1IMmJWcHJqV3VhMVJoY2FCWG1PMW5QSHlWN1lMZTA1ZVljaFRMRjhCZ3BH?=
 =?utf-8?B?QWIweEQwcGQ2QWNnVElGSTZKWmRkRUk0UlV5ckcwWFZTVUFGNE4xdEtWdVRC?=
 =?utf-8?B?dGhPcE0vN29hYkxYcExFRGkrR0NMVU5YRHkxOGF6anZXSTVxYlFHWWlBTjhs?=
 =?utf-8?B?bEF1THp5OGs1TGwzV2pHUVZaMnlNODNyMzY4MllwV0tSbU5CQVBZR3RJazZW?=
 =?utf-8?B?VnEzVGRncFJNRGJCbW5WL3VYTWhtOWE5QktIODlxTVZLQ1hsTStZcE83Wmtj?=
 =?utf-8?B?aFgxdVdxQi9BcUhvczh0TlJWNmo2NDRYMk5ibFFSV0FPdkV2UWs0a3FFUStl?=
 =?utf-8?B?aW1pYm1RSXJKTncwbjhZdmVKcEMzVzdRa2E2QWZWVnFKN01IanU3MzlVaHRJ?=
 =?utf-8?B?ZGhJWkZSYS9KRkIxUXpSSFVyWVJzejNJZDZTaFJuRVE3WXZleUp2SzRPeDVP?=
 =?utf-8?B?VFJPeU5kVnRaellIZlZTY0gyWlJQYlNmanFNdjhORG9IWXFabWVadGYvOTlt?=
 =?utf-8?B?ZzJRT0MvUVVTYUJ4LzlScXl0Sk43V0kzVERpUDhoZndhOFR4YU9TamlFbndJ?=
 =?utf-8?B?MVFJU09aVjdsWDdZdGxFdytDeEdtTWhyQmtIQnlsbjB4amJnR1VOTzN0dlFq?=
 =?utf-8?B?Z3RoaDF6bWpuMzlrYVc3WFdTZUxkUWVLYVU5NEJwTWlpbXNqMDkzZDNKbXdQ?=
 =?utf-8?B?ZXNYVGNQMzBjb1FsamhjZzBvSksvNDdPZkg3UVNQV1EwSzlNUkhtcHlsVW1v?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89718686BC5DDA4FB9B2D339029F5881@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f0d10f-4014-448f-db84-08d9a9ebfd91
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 17:02:08.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHuWLJWZLDccVOiyaHaZ0fjLgKctHwXFvq5/apTCfOwqjcg1Wa46riJ4tZj7lap0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4787
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: HzXU7JatJ04ogrIJ_jlsVi-QlnNdW-go
X-Proofpoint-ORIG-GUID: HzXU7JatJ04ogrIJ_jlsVi-QlnNdW-go
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_06,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111170078
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDE3LCAyMDIxLCBhdCA4OjQ1IEFNLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBOb3YgMTYsIDIw
MjEgYXQgNTo0MyBQTSBOaWNrIFRlcnJlbGwgPG5pY2tydGVycmVsbEBnbWFpbC5jb20+IHdyb3Rl
Og0KPj4gDQo+PiBGcm9tOiBOaWNrIFRlcnJlbGwgPHRlcnJlbGxuQGZiLmNvbT4NCj4+IA0KPj4g
QmFja3BvcnQgdGhlIGZpeCBmcm9tIHVwc3RyZWFtIFBSICMyODM4IFswXS4gRm91bmQgYnkgdGhl
IEtlcm5lbCB0ZXN0DQo+PiByb2JvdCBpbiBbMV0uDQo+IA0KPiBVZ2guIE1pbmQgaGF2aW5nIGEg
YmV0dGVyIGNvbW1pdCBtZXNzYWdlPw0KPiANCj4gVGhpcyBqdXN0IHRlbGxzIHlvdSB0aGF0IGl0
J3MgYSBiYWNrcG9ydC4gSXQgZG9lc24ndCBhY3R1YWxseSB0YWxrDQo+IGFib3V0IHdoYXQgaXQg
Zml4ZXMuDQo+DQo+IFllcywgdGhlIHN1bW1hcnkgbGluZSBzYXlzICJGaXggdW51c2VkIHZhcmlh
YmxlIHdhcm5pbmciLCBidXQgaXQNCj4gZG9lc24ndCB0YWxrIGFib3V0IHdoeSB0aGF0IHZhcmlh
YmxlIGlzIHVudXNlZCBhbmQgd2h5IGl0J3Mgbm90DQo+IHJlbW92ZWQgZW50aXJlbHkuDQo+IA0K
PiBBbmQgaXQncyBub3Qgb2J2aW91cyBpbiB0aGUgZGlmZiBlaXRoZXIsIGJlY2F1c2UgdGhlIGNv
bnRleHQgaXNuJ3QNCj4gc3VmZmljaWVudGx5IGxhcmdlLg0KPiANCj4gU28gYSBjb21tZW50IGFs
b25nIHRoZSBsaW5lcyBvZiAidGhlIHZhcmlhYmxlIGlzIG9ubHkgdXNlZCBieSBhbg0KPiAnYXNz
ZXJ0KCknLCBzbyB3aGVuIGFzc2VydHMgYXJlIGRpc2FibGVkIHRoZSBjb21waWxlciBzZWVzIG5v
IHVzZSBhdA0KPiBhbGwiIG9yIHNpbWlsYXIgd291bGQgYmUgYXBwcmVjaWF0ZWQuDQoNClllYWgg
b2YgY291cnNlLCB0aGFua3MgZm9yIHRoZSByZXZpZXchIEnigJlsbCBwdXQgdXAgYSBmaXggc2hv
cnRseS4NCg0KPiBPZiBjb3Vyc2UsIHRoZSBhbHRlcm5hdGl2ZSB3b3VsZCBiZSB0byBtYWtlIHRo
ZSBiYWNrdXAgZGVmaW5pdGlvbiBvZg0KPiAnYXNzZXJ0KCknIGFjdHVhbGx5IGV2YWx1YXRlIHRo
ZSBhcmd1bWVudC4gVGhhdCdzIG5vdCB3aGF0IHRoZQ0KPiBzdGFuZGFyZCBhc3NlcnQoKSBpcyBz
dXBwb3NlZCB0byBkbywgYnV0IHdoYXRldmVyLCBhbmQgdGhlIHpzdGQgdXNlDQo+IGRvZXNuJ3Qg
Y2FyZS4NCj4gDQo+IFNvIHVzaW5nDQo+IA0KPiAgICAjZGVmaW5lIGFzc2VydChjb25kaXRpb24p
ICgodm9pZCkoY29uZGl0aW9uKSkNCj4gDQo+IGluc3RlYWQgd291bGQgYWxzbyBmaXggdGhlIHdh
cm5pbmcgYXQgbGVhc3QgaW4ga2VybmVsIHVzZSAoYnV0IG5vdA0KPiBuZWNlc3NhcmlseSBvdXRz
aWRlIHRoZSBrZXJuZWwgLSB0aGUgc3RhbmRhcmQgQyAnYXNzZXJ0LmgnIGlzIGp1c3QNCj4gZXZp
bCkuDQoNCkkgdG90YWxseSBhZ3JlZSB0aGF0IHRoZSBzdGFuZGFyZCBDIGFzc2VydCBpcyBub3Qg
aWRlYWwsIGhvd2V2ZXIgSeKAmWQNCmJlIGhlc2l0YW50IHRvIGRvIHRoYXQgaW4gYSBxdWljayBm
aXguIEp1c3QgYmVjYXVzZSB6c3RkIGFzc3VtZXMNCnRoYXQgYXNzZXJ0cyBhcmUgcmVtb3ZlZCBm
cm9tIHByb2R1Y3Rpb24gYnVpbGRzLCBzbyB0aGVyZSBhcmUgYXQNCmxlYXN0IGEgZmV3IHBsYWNl
cyB3aGVyZSBpdCBtYWtlcyBwb3RlbnRpYWxseSBleHBlbnNpdmUgZnVuY3Rpb24NCmNhbGxzLg0K
DQpJIG1heSBiZSBhYmxlIHRvIHRyeSBzb21ldGhpbmcgbGlrZToNCg0KICAjZGVmaW5lIGFzc2Vy
dChjb25kaXRpb24pIGRvIHsgaWYgKDApIHsgKHZvaWQpKGNvbmRpdGlvbikgfSB9IHdoaWxlICgw
KQ0KDQpCdXQsIHRoZSBjb2RlIGluIHRoZSBhc3NlcnRzIGhhc27igJl0IHlldCBiZWVuIHRlc3Rl
ZCB0byBidWlsZC4gU28gd2UNCm1heSBydW4gaW50byBidWlsZCBpc3N1ZXMsIGxpa2UgdGhlIHBy
ZXNlbmNlIG9mIGRpdmlzaW9uLCBvcg0KZGVwZW5kZW5jeSBvbiBsaWJjLg0KDQpJ4oCZbGwgdGFr
ZSBhIHN0YWIgYXQgaXQsIGJ1dCBpZiBpdCBlbmRzIHVwIHJlcXVpcmluZyB0b28gbGFyZ2Ugb2Yg
YSBjaGFuZ2UsDQpJIHdpbGwgdGVuZCB0byBjb250aW51ZSB3aXRoIHRoZSBjdXJyZW50IGFwcHJv
YWNoLg0KDQpCZXN0LA0KTmljayBUZXJyZWxsDQoNCj4gICAgICAgICAgICAgICAgICBMaW51cw0K
DQo=
