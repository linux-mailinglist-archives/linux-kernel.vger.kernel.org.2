Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6731F4556DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbhKRIYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:24:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62664 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235672AbhKRIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:24:19 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AI4Mcco019133;
        Thu, 18 Nov 2021 00:21:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SAUqp5n8oiIVakmvB8JIFPg/N1iy1IU54XxO7Z0bYkA=;
 b=RZDsq/6fnqCa/767zxHWWQtJFAiZVsYWPmb65GvvRSzIbqWMA7d42zQAGY/yTt0EDaje
 WRewv0XWx+wlCNaRWCYuEti5geuSvmjdVfGMpEfAPliqCFBN4hwgEuKFI/FDW3jlJxoc
 /vjPPZCNu4Q7TVSdMskET1Oa9qq4zYG+RUk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cdfr9s44u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 00:21:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 00:21:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVcTrXcd9DFzZmgRyFDmLyanl0EQWAr0Erryh2N4vNRjrlZydHWgmniz152hIkqqqfEVgyb/x1biIbV6y5UtyKshMWCqf+i5JYfIRkYJgxP+aKvwqBw/+OyqudPWHv6eCr0PwJP9XNbtIzy8ly/3j744sALA7geerf/pef1Rpr6xLcx32eWGV96dGkQkNX5ouf6c7lYjzXqTX6Pmx2/GQvmWiSQpMzOa6fxa+5eloU5yBy+oxstlenweqTTjk3O5IWUZNtKhEg/kEI4Vg02aTMYNUQuyw1aUJxov4qp+aivGdYkHnDW6m6iF4APF9C+mtUrcGmExUfbctsAPhK2tVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAUqp5n8oiIVakmvB8JIFPg/N1iy1IU54XxO7Z0bYkA=;
 b=hk2rT86XYoSbf2C5vN7Kzz0YJXPk8Q4/4l6LNIk5GFSV0hDlro/f0j6g5khMyzI/Gnh+DRcvVlyFopqcQJCm0s7x/yme49RcgJOqbUofI28CHaoQuz2ztUlpZ1IH5Ik7xj+fwqnmGrzNpzS8IC88Cb4hjgzsLtcuVP4d0+RZH2HBuo6XZtaBqCDFJ8gb7wJCepIOSEL/JpHwmyLLIBpy80R6E1vN7JOcQvZ5feL2tLsRqVcBfrKNyjGJ8KVjQvcRGPQIAlcCWaYWRuCc/Eg8v9YsJy09Y8jLBkZ9bARcEUZU8e/cC02WuAq28laXM+IU5KOl+NX0xSYfMUxi8ermuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BY5PR15MB3714.namprd15.prod.outlook.com (2603:10b6:a03:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Thu, 18 Nov
 2021 08:21:14 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 08:21:14 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/3] lib: zstd: Fix unused variable warning
Thread-Topic: [PATCH v2 1/3] lib: zstd: Fix unused variable warning
Thread-Index: AQHX2+7oDC81Zjs/oEu+owg4J/QRgKwI6gAAgAAIogA=
Date:   Thu, 18 Nov 2021 08:21:14 +0000
Message-ID: <D766ACB2-3DD4-4F1E-B9EB-F512A8E881CA@fb.com>
References: <20211117201459.1194876-1-nickrterrell@gmail.com>
 <20211117201459.1194876-2-nickrterrell@gmail.com>
 <CAMuHMdWts1kh8koe7y9CLqRX3DoF_Lnm9o7M=TULJhJDPGKnkw@mail.gmail.com>
In-Reply-To: <CAMuHMdWts1kh8koe7y9CLqRX3DoF_Lnm9o7M=TULJhJDPGKnkw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3c725aa-05f8-4f22-8257-08d9aa6c6302
x-ms-traffictypediagnostic: BY5PR15MB3714:
x-microsoft-antispam-prvs: <BY5PR15MB371490C0592D7D91DE41067FAB9B9@BY5PR15MB3714.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UuHIDp6cCnJSY4D/0bQdWAArkJ9kEnzWH1wzMC2GPyibTygkOogWgWu2vNE/AGjZE+D+Yl0TWBJoHfz3Vh/IUITaAlThdMsNOsIUscIZ0vHTJvf6IkBW3W0fvSLoXq0NDlyECKa4cXIpRm1GS3wgsHop8v4L8g5VLVunvxvPmok7L6ZWFEOOm9wScz62YMhZYgYeKk7z8hfyvKJG7GBt1F+In8eZZ+jOcHxtU20DLKP/4BTAmq8QJhcCa0Qedxf24ZYakqySaZBb3mAhh/gknO0gU/3mUB5odQfvh7WfHhevUoLQEImuznYTmzAlD3ZTlXSyIkWpXDG6HGkKlZZdlgoKyc/q+fN7u12+0HckCivVzEdMOqjq8Vm4amR3dC3kW70peCuFUNuya40KrKdP5vlcFbMTTfPj0c1XAPmiAAY9YDcyv1vonYl/MH45K/RMAFE4W9ks7tle7uW+y/btaYz2Z0zxYLQ81pbjW8F2BYFY9AbVkzJtPfDIBLvSE9DfCaUKty2+Cl/mgyfUHlAw8V+oc2qUJTXOkTCepomDvH6+gtQ+8OYarupiL8RCcZlHGgHBlL8dGq3epw4w+TUBMaGkxvTgJmFkPwTAnG/Ghi2jqMVbDzjrkeCnGI1OzuCL2CCfg3rrsIdPD9Mvsgo6X8p+l8yq15eRGIPuTjh2IMTX5LdMRZ7xApSWdLSmAhaXlXWPJrRPwELBNLJkvqXQ2AoB7AGZ50l+VeYB90oMQvb7LO6VoIgeIDmXFrnBy+WrEileKGHIwbpq4v7EVrrCINbrdHOZbvJGCqNzCZCpiAA70uYJYjTkek/4hF85yQwISaYM3z/9D6DOYfCdffAptfIvs7S5WbUB2V/WQDoJpoKa6GO7w2roq5EiCts+wNH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(71200400001)(33656002)(6916009)(6506007)(53546011)(122000001)(8936002)(508600001)(2906002)(8676002)(38100700002)(2616005)(86362001)(4326008)(36756003)(83380400001)(26005)(76116006)(91956017)(66946007)(186003)(38070700005)(6486002)(316002)(6512007)(5660300002)(66446008)(54906003)(66476007)(966005)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UklyTkhVSEdNbDh4Z0ZPd2VIWXRBUGNBdjhKVzNJQVZ0MUp2aisxVkhMWlNr?=
 =?utf-8?B?dGRBcmhpejlWYlVGYTM3WkxYeTFueHRuOXp6OEdQaUZVYVZkaTVCL2RyYXgw?=
 =?utf-8?B?NFZNYU5lbjVFUXZMS0h2TmhJYkJhR2RYcnl6ODZOVHZFZktNVEhHeVNZV2Fq?=
 =?utf-8?B?M2xxYkNVSzhUUGZjREhwTXk3NlozSlBpNzZyUW1kdHRTcFBUcG40ZzFHdVFF?=
 =?utf-8?B?YXB3d2J1SmU1N1RDaW10R1B5OXdtY1lPS28zS0RzdWJKVWo5VlRUK1ZHNXIw?=
 =?utf-8?B?S1JDMXdtRjJJWFg1djhBNC9PWkZtM2o1RnoxbDV1aTBGSUVXRGVmYU1BTGpw?=
 =?utf-8?B?cjFZR3NmL3k1RHpKNnBwcmpza2hXckd6YVEzZDB2YTUwaHZ2eVdNS1lUS05t?=
 =?utf-8?B?L1RjbjhJejFKSXlaL2VsUlNGai9ta3YrR3ZtWFFYV3o4YWQzM1NjNVFQaG56?=
 =?utf-8?B?RWh4ME0wV09MUWtGTzJYR2RRclJPS1kvNmlBbkNEamRBWlROeGJ1cFFOalo1?=
 =?utf-8?B?YTdwWWJVNmtSWWxkNjRwYTFuNzBXaWJ2eXRCS1I0Z0w5RFVTRldVandJa2Mv?=
 =?utf-8?B?SU5pQm5KdEdJeXlCSWJlZHBiYnBHRWdmUEV6ZjNrb2VtQkowbUZqckV5V24z?=
 =?utf-8?B?RjhHYWVyOXUzTjZleTdNZUM1bTFRMmc5NGlJdk0zaWVFdjRTNFVTc3VHOW1a?=
 =?utf-8?B?NVdxK04xMFpFRUpJTHJsT3JOUE4zVVk1YlRyRzlSWlZSOFJuTlRrOW9vbTdN?=
 =?utf-8?B?YXVLRWlpMzJoNGFJVUlraDFxcFUzUzJiUlY2MWRKSm5ZUG5DZFJIZ3MrU3g0?=
 =?utf-8?B?TWg3TldXQ2J3aXp4TldsREFYellWa3E4NkJKYXJtSDQwVWpRSTN4bVhIa3lj?=
 =?utf-8?B?cmUvc1VSOXVsQ3ZVWnBvSzd4YlV2OHhWVllUQ2RPVDNWTDBISjUrL3JOeDR3?=
 =?utf-8?B?TW9RbkE5L2VxeW9BejBRZjdLNlFQbXorYWRFZWRTYnY4UFU2NDVEV2JoUzNa?=
 =?utf-8?B?aWp1d1NkaU9BRGhkMFBIM3B4UGlQMTlZYmMxYTdRdUVSaFhEMDd1TEZyTldF?=
 =?utf-8?B?K0VUSUd1SzlPclp4UkxYRnQ1U0I4cG9GcmFBLyszNXhwQWdaQy83dTBNUGdW?=
 =?utf-8?B?SnFQMk8yc0ovRVRWRVZESG5RYkRRVUc1bEhnK1ljRnJieGIzc0w3dXNHQ1hq?=
 =?utf-8?B?SVhkZnNDbm5JRkQ0ZWVrSWFkVVlBbitSZDFBVUF4S3lmRG1sTlNtV1J3SEVZ?=
 =?utf-8?B?c01RVVZDVE8zbnFRbk12QkVteWxsODR4SHJWa3VuYW9adkhGcjZwVG9LMGdR?=
 =?utf-8?B?N2k1L2FiWUtxUEc2eDNGMmo0amRDN3hvVU81S1JOTlF1V0ZpZCtPeEJPUkVu?=
 =?utf-8?B?ZHBoTHBUUm5HOUlqS2p0VWRtSEZzajhiZjEzQjFYM1JpT2RzZ3c0VXZxRFI2?=
 =?utf-8?B?dTVGd0tVd2RjM0FFbzB2WGhpTEZQVkdYZGRMYkdtbXR4RGovaEt1ZGxBU2Nh?=
 =?utf-8?B?UUxyUGV3RUFsTFM0cks1dVV6eGJxMVVtcWhQcWU5VVNtcDdqeEMzOFptL3JW?=
 =?utf-8?B?TFRpQmhpRFVnYk5xcU1RQ3dnZUc2SnRhWGJmWjJFeVJWcHNRMGFTYjBGa1BV?=
 =?utf-8?B?R0twRGZRTlpiNkc1RWZWNUpQbGlaNHBwWVBRcm9OK2xvR3BaQXk5aENHeXZn?=
 =?utf-8?B?VUNXVkQ5QjB0b29pTVovTHFVamNmanNZTC81cTRvbnJwaWVZT1BYRFZsR3E5?=
 =?utf-8?B?bkNXa3pEQnc5SVA1azhHalV5ak1XRHZYSnJZdXdJTGVYWE9HRTd4RkhHRDVk?=
 =?utf-8?B?SzNZK0NpQUVkWTY3dzBTcFhuSWl3cWJOMmJqZ1ZxK0p0QkxXUmxoL1Y3bGNM?=
 =?utf-8?B?WTNyK1hjQTVGNlpjbE9mVzZpSmF4RWNkc3N1aDNlUXo5eTdCNlNXQ2wvelJn?=
 =?utf-8?B?cUxkOUxFbUUrWEwzcER6VEZmTDZzQzh0eHo3ck5HaXo3RUM3TWJPWkR3Rncz?=
 =?utf-8?B?WWVhWWNwb0Y4elk0V0tYTjFSK3dwUnhzMkdsQTBzS2VCUXJ5a0JEN0szdmpo?=
 =?utf-8?B?TjY0SDh3YjA1cjN0VHh3ZzVqN0dkK2p2VjQzM1lmTi9GZnpmeUQ2YzU4dWZn?=
 =?utf-8?Q?1PgQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A6478B1BB0D5E4D8A1885B0ACB442C9@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c725aa-05f8-4f22-8257-08d9aa6c6302
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 08:21:14.2855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+BQ5mxImLMv0t6tSqkjybv4faE2VO9mzbXIvwAq4PEbeZ3bOG8D/yuAGE2jktjM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3714
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: dTM9W7kNEFcgDsNwB_hkncrofbb-CWYK
X-Proofpoint-ORIG-GUID: dTM9W7kNEFcgDsNwB_hkncrofbb-CWYK
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_03,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDE3LCAyMDIxLCBhdCAxMTo1MCBQTSwgR2VlcnQgVXl0dGVyaG9ldmVuIDxn
ZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+IA0KPiBIaSBOaWNrLA0KPiANCj4gT24gV2Vk
LCBOb3YgMTcsIDIwMjEgYXQgOTowOCBQTSBOaWNrIFRlcnJlbGwgPG5pY2tydGVycmVsbEBnbWFp
bC5jb20+IHdyb3RlOg0KPj4gVGhlIHZhcmlhYmxlIGBsaXRMZW5ndGhTdW1gIGlzIG9ubHkgdXNl
ZCBieSBhbiBgYXNzZXJ0KClgLCBzbyB3aGVuDQo+PiBhc3NlcnRzIGFyZSBkaXNhYmxlZCB0aGUg
Y29tcGlsZXIgZG9lc24ndCBzZWUgYW55IHVzYWdlIGFuZCB3YXJucy4NCj4+IA0KPj4gVGhpcyBp
c3N1ZSBpcyBhbHJlYWR5IGZpeGVkIHVwc3RyZWFtIGJ5IFBSICMyODM4IFswXS4gSXQgd2FzIHJl
cG9ydGVkDQo+PiBieSB0aGUgS2VybmVsIHRlc3Qgcm9ib3QgaW4gWzFdLg0KPj4gDQo+PiBBbm90
aGVyIGFwcHJvYWNoIHdvdWxkIGJlIHRvIGNoYW5nZSB6c3RkJ3MgZGlzYWJsZWQgYGFzc2VydCgp
YA0KPj4gZGVmaW5pdGlvbiB0byB1c2UgdGhlIGFyZ3VtZW50IGluIGEgZGlzYWJsZWQgYnJhbmNo
LCBpbnN0ZWFkIG9mDQo+PiBpZ25vcmluZyB0aGUgYXJndW1lbnQuIEkndmUgYXZvaWRlZCB0aGlz
IGFwcHJvYWNoIGJlY2F1c2UgdGhlcmUgYXJlDQo+PiBzb21lIHNtYWxsIGNoYW5nZXMgbmVjZXNz
YXJ5IHRvIGdldCB6c3RkIHRvIGJ1aWxkLCBhbmQgSSB3b3VsZA0KPj4gd2FudCB0byB0aG9yb3Vn
aGx5IHJlLXRlc3QgZm9yIHBlcmZvcm1hbmNlLCBzaW5jZSB0aGF0IGlzIHNsaWdodGx5DQo+PiBj
aGFuZ2luZyB0aGUgY29kZSBpbiBldmVyeSBmdW5jdGlvbiBpbiB6c3RkLiBJdCBzZWVtcyBsaWtl
IGENCj4+IHRyaXZpYWwgY2hhbmdlLCBidXQgc29tZSBmdW5jdGlvbnMgYXJlIHByZXR0eSBzZW5z
aXRpdmUgdG8gc21hbGwNCj4+IGNoYW5nZXMuIEhvd2V2ZXIsIEkgdGhpbmsgaXQgaXMgYSB2YWxp
ZCBhcHByb2FjaCB0aGF0IEkgd291bGQNCj4+IGxpa2UgdG8gc2VlIHVwc3RyZWFtIHRha2UsIHNv
IEkndmUgb3BlbmVkIElzc3VlICMyODY4IHRvIGF0dGVtcHQNCj4+IHRoaXMgdXBzdHJlYW0uDQo+
PiANCj4+IFswXSBodHRwczovL2dpdGh1Yi5jb20vZmFjZWJvb2svenN0ZC9wdWxsLzI4MzgNCj4+
IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIxMTExMjAzMTIuODMzd0lJ
NGktbGtwQGludGVsLmNvbS9ULw0KPj4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9mYWNlYm9vay96
c3RkL2lzc3Vlcy8yODY4DQo+PiANCj4+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE5pY2sgVGVycmVsbCA8dGVycmVsbG5A
ZmIuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4+IC0tLSBhL2xpYi96
c3RkL2NvbXByZXNzL3pzdGRfY29tcHJlc3Nfc3VwZXJibG9jay5jDQo+PiArKysgYi9saWIvenN0
ZC9jb21wcmVzcy96c3RkX2NvbXByZXNzX3N1cGVyYmxvY2suYw0KPj4gQEAgLTQxMSw2ICs0MTEs
OCBAQCBzdGF0aWMgc2l6ZV90IFpTVERfc2VxRGVjb21wcmVzc2VkU2l6ZShzZXFTdG9yZV90IGNv
bnN0KiBzZXFTdG9yZSwgY29uc3Qgc2VxRGVmKg0KPj4gICAgIGNvbnN0IHNlcURlZiogc3AgPSBz
c3RhcnQ7DQo+PiAgICAgc2l6ZV90IG1hdGNoTGVuZ3RoU3VtID0gMDsNCj4+ICAgICBzaXplX3Qg
bGl0TGVuZ3RoU3VtID0gMDsNCj4+ICsgICAgLyogT25seSB1c2VkIGJ5IGFzc2VydCgpLCBzdXBw
cmVzcyB1bnVzZWQgdmFyaWFibGUgd2FybmluZ3MgaW4gcHJvZHVjdGlvbi4gKi8NCj4+ICsgICAg
KHZvaWQpbGl0TGVuZ3RoU3VtOw0KPiANCj4gVGhlIExpbnV4IHdheS10byBkbyB0aGlzIGlzIHRv
IGFkZCBfX21heWJlX3VudXNlZC4NCj4gQnV0IHBlcmhhcHMgeW91IGRvbid0IHdhbnQgdG8gaW50
cm9kdWNlIHRoYXQgaW4gdGhlIHVwc3RyZWFtIGNvZGViYXNlLg0KDQpVcHN0cmVhbSB6c3RkIGNh
bid0IHVzZSBfX21heWJlX3VudXNlZCAob3IgaXRzIG93biB2ZXJzaW9uKSBiZWNhdXNlDQpub3Qg
ZXZlcnkgY29tcGlsZXIgc3VwcG9ydHMgaXQuIFNvIGNvbXBpbGVycyB0aGF0IGRvbid0IHN1cHBv
cnQgaXQgbWF5IGVtaXQNCnVudXNlZCB2YXJpYWJsZSB3YXJuaW5ncy4gV2UgbGlrZSB1c2luZyBh
dHRyaWJ1dGVzIChsaWtlIGZhbGx0aHJvdWdoKSB3aGVuDQphcHBsaWNhYmxlLCBhbmQgd2hlbiB0
aGVyZSBpcyBhIHBvcnRhYmxlIGZhbGxiYWNrLiBJbiB0aGlzIGNhc2UsIHRoZXJlIGlzbuKAmXQN
CnJlYWxseSBhIHdheSB0byB3cml0ZSBfX21heWJlX3VudXNlZCB0aGF0IHdvcmtzIHBvcnRhYmx5
Lg0KDQpPbmUgb2YgdGhlIGRlc2lnbiBnb2FscyBvZiBsaWIvenN0ZC8gaW4gdGhlIGtlcm5lbCBp
cyB0byBub3QgbWFpbnRhaW4gYW55DQpsb25nLXRlcm0gcGF0Y2hlcyBvbiB0b3Agb2YgdXBzdHJl
YW0uIFRoYXQgaXMgc28gd2UgY2FuIGF1dG9tYXRpY2FsbHkNCmltcG9ydCB1cHN0cmVhbSBpbnRv
IHRoZSBrZXJuZWwsIHNvIGl0IGlzIGVhc3kgdG8ga2VlcCB1cCB0byBkYXRlLiBXZQ0KY2FuIGFj
Y2VwdCBzaG9ydC10ZXJtIGZpeGVzLCBidXQgYWxsIHBhdGNoZXMgaW4gbGliL3pzdGQvIGluIHRo
ZSBrZXJuZWwNCm5lZWQgdG8gYmUgcG9ydGVkIHVwc3RyZWFtIGJlZm9yZSB0aGUgbmV4dCBpbXBv
cnQuDQoNClRoYXQgZG9lcyBpbmN1ciBub24tbGludXggc3R5bGUgaW4gbGliL3pzdGQvLiBIb3dl
dmVyLCB3ZSBtaXRpZ2F0ZSB0aGF0DQpieSBwcm92aWRpbmcgYSBsaW51eC1zdHlsZSB3cmFwcGVy
IEFQSSBpbiA8bGludXgvenN0ZC5oPiwgc28gdGhhdCB0aGUNCmNhbGxlcnMgb2YgenN0ZCBkb27i
gJl0IGdldCDigJxpbmZlY3RlZOKAnSB3aXRoIHpzdGTigJlzIHVwc3RyZWFtIHN0eWxlLg0KDQpC
ZXN0LA0KTmljayBUZXJyZWxsDQoNCj4+ICAgICB3aGlsZSAoc2VuZC1zcCA+IDApIHsNCj4+ICAg
ICAgICAgWlNURF9zZXF1ZW5jZUxlbmd0aCBjb25zdCBzZXFMZW4gPSBaU1REX2dldFNlcXVlbmNl
TGVuZ3RoKHNlcVN0b3JlLCBzcCk7DQo+PiAgICAgICAgIGxpdExlbmd0aFN1bSArPSBzZXFMZW4u
bGl0TGVuZ3RoOw0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUn
cyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0K
PiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxs
IG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMg
SSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQoNCg==
