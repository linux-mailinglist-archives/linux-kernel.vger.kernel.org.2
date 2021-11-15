Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F2451BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354026AbhKPAJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:09:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38996 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352146AbhKOUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:42:25 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFGuPZN006328
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 12:39:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=o5XWn8w9lxpe1yAVwUyQa/WSNim5gdVDqmWKofhK1Fs=;
 b=O83V5gFuiduMpUX1rjbBuc4mLQg2+GlbC4Tbr90HmBiITxgwG91NdFRAqz9+5yR30ri9
 Khv5/uDdcATexTEUMx/UTolZalil/5ClPB7FFwqDH0vctjbKyHgCz3lBxOyTRNtqO8Wi
 0snJtw4YsCU0EBHsBGZacCbjo9DP3/67QrM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cb5yuyjw8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 12:39:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 15 Nov 2021 12:39:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv46a8rZgyXonHGyKr06zNzSeqmhhbCfBJvX1pyRc9jUOzPYtm5LaeTGJy7dUAME2LaRmlqnieAo8t5qAdmHZaxynu+9cUuDbsg+OnkOYF2/r0lVY+0Y2g5r540JT/xxn8nvvQvrUdMi2GUtof1gD1ySOr3/SixNy6xYvSM3WTmI7KVQwoCCZ/+jFru5EYho+eCrIpflk2QfqmwY1xCQzsRQSFsOayEP2obqr3qfGfdKRPgXd090lMxrjJLQLc9JVuoAA7CDP4RGhuFnkouETT0xgOhYwU8cJAbGny7tbXcgRxu8vL5jwUYzHKnkzRDB3Ca54EXe3RaAgYEaO0dNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5XWn8w9lxpe1yAVwUyQa/WSNim5gdVDqmWKofhK1Fs=;
 b=P+UannjuI8cbOdrwgRoSWNPUlQ/iF2OkTmpzgUPUNZbyevV6yBbVqNr78WG6HlxXemz0eoAifW9irblgn3dACCfxD/aEJ6xX3yQ9dle2UnUSCoYxwroZsjVJBT/16ye2CuVWXIwNwBZ/If9eSH53VobT9ehIykTrH/d3hlTNtPeBpv16HxyuV86l8SVsvJKYL56ST2mNdzZxUNREA1ymSfr6ZxPCLw4QHxdqQCfBhEyRmYxLQco1dZQFQG0oRq7VM/vXc0mH0yHmmVN2An+mQLp+9ZnZ2hkTP3iz1tpH3L2mwZIoucyTSHNQv8mKlWsZzylKf8GSM/VeDEwVLbpVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2837.namprd15.prod.outlook.com (2603:10b6:a03:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 20:39:23 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 20:39:23 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.16-rc1
Thread-Topic: Linux 5.16-rc1
Thread-Index: AQHX2knC7SPD2UM1SkiAD7QCiQlWTKwFDSoA
Date:   Mon, 15 Nov 2021 20:39:22 +0000
Message-ID: <8023FCC7-E59E-478F-92F5-3E6581E75D48@fb.com>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
 <CAHk-=wgm-Co+ys0TQKZ8aRp-NGTb+ER-VFmEOEVamH724cWwFQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgm-Co+ys0TQKZ8aRp-NGTb+ER-VFmEOEVamH724cWwFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3eb7bce-f605-44ea-c2ae-08d9a87801d8
x-ms-traffictypediagnostic: BYAPR15MB2837:
x-microsoft-antispam-prvs: <BYAPR15MB2837D7373414EBE3CBDC54ECAB989@BYAPR15MB2837.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12gaheQSsMRRruBvCt34xPhwvcdpgto0EgB8l8OLz0JysihtOm6sSU2693QaOtizkvg6Ru7+2RkGb+qA+98jO8aYOGD58unDXGy4kxyX5/hhQgGVC0IJwz2rxvit9/mUhbEoDqk4M3/ZjsYPe+LI2HcVbg3RQs+ttdydPTBuAGgP+/sIZmF+BNAEZ1xXPyZN0vBzqo83zUCkIPZ4LeOrlvynXaBIhQPKFBXa3WsdZtwXQLwsgLrz/iEL8FsT7ThG/NHg99e+bJnlDG4Mf3bzLPJh5+2mZbC4GG6V+LcYW70aWIUIH82vgWFJyiuKgKcW1wggf4OjGdOLRcG5vZCP1FzBymFoKeB+Jl8VIQNuIZ+wYtG1Aygw18gjuseZlTYeEdSOiqjuaFOUJJ5xsWnX32E/Gu6C7LIAA1LYVfNQB1J4nQKzekrvkRLKf6KMsfLYa6+RGYG9CNK8g7bhHcKIaJig+m0YBLUrKTOt4JO+JO5DCuLPnZMytBx2rvaB+z6bjL3rT+gNF68S2pGN/1tyWuM2eCR27mxW0cl33E8+OqpvBRAxdLcxx9s7g5EUaAridhD6om2/d60qYCv7YJGUMeIv01WDFGFDeKLo5Nb3Qq8K1GVObLTsjvFQmVSgc6PiWaAb4nXYbQAxREKo6Fa4wST060jZ/fMjE9wkZQVB8eHhudRVGRqB1Ys3xqctFhxkwgyCVTktrMcsbUw2d9cr2DiSvPMk3H6+SdzQWBAJ7JhPV9UdskO6+wKUZCm96zx/k1LUa1ytIhMME8NJ6Bb9ADGkmnVAG8ejuQOHaLpBMdca0JE8XnDVK4todMmZGUyoCeU+YWbUB5LVYioE3DwOu3j5gcMb+dsRULDiWM6LpBEAiK33ohmqvbyCwUAmmSyw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(2616005)(38070700005)(6916009)(2906002)(86362001)(36756003)(33656002)(8676002)(5660300002)(66946007)(8936002)(186003)(966005)(38100700002)(122000001)(91956017)(6512007)(508600001)(6486002)(64756008)(66556008)(316002)(4326008)(53546011)(83380400001)(6506007)(66446008)(66476007)(71200400001)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2xNTnNveWlNQjlVd3FTc2RlRGg5ZlBjZ08yRzBqRVNzUEJEZU5ENnp1RzVB?=
 =?utf-8?B?NHdycmFoWGEyTTBHdHRHcm04RzYxUkpmamY1TlZhZzBxZ0FzOHpBbDREd3Zh?=
 =?utf-8?B?R2cvY0ZVSEtQMWk0RUtGZzZwOUdVZE1sWWxhUXA0OUFnNG1oVHYrTzlWWkR1?=
 =?utf-8?B?UnFzcW1XVllkWS9wby9vMjF3RmdWWFNMaVhnQS93YktJbStyMWFXTWdUVHo2?=
 =?utf-8?B?MWY0RjBxS25ScE5mZGEyeDIzL2w1VFEzOGhUaFVBcnQxRTNPMVE3SzJIRlFt?=
 =?utf-8?B?WlRQeUpRd1BJQncycHNkaTMwbVRWMkpCU0RmdTkxZmMwc0JWb3ozOEpLRDBT?=
 =?utf-8?B?bzRwRHh3aTZnak40bnZGeGJvc1gxTlBhdkJIdUdyR0ZDVU5mV2pZaFZtSW4x?=
 =?utf-8?B?MkQwSDY1RGc4aEtGelk4U2dac043WFk3YlFKUG9RbUttemZyYUp6cUhYSnZO?=
 =?utf-8?B?MjhxRXRVbXVqTVM2OURVcEFMQjdYZzA1Zkt6dFc3a0Q5NjVGZm16alQ2aFhl?=
 =?utf-8?B?QjRua2VZdHdqcG51OWkrZURHWEkySlVHUnBWcUh1MDF3SnpURzBXVTQwRElO?=
 =?utf-8?B?TERZd2dBNGJJZ1QzeDRGR01FUjNaOXVZUmNHMmViWjBLdmJBUE01UWs2NUNo?=
 =?utf-8?B?eDkrUStXejBUQldNS29aNlNwaGtSVGZCV2ZsdGdpRVZCdG03STNCN3VwbHk0?=
 =?utf-8?B?c214SGxzSFlCYXF5bVBXUEpUZEJqcWM5bU0wNGZwbHJSNmkvSU5WMU1TMWRH?=
 =?utf-8?B?T0FDRVozS3RNY09pc0VZMlprVXR0Ni9QWTkwMm5ycDE0QWhHZVV5Q09QZE5P?=
 =?utf-8?B?ZEpsSTYzaUszSlZEOGJOaXpWSHpFbEY2U1JTa0hKNmU3eFcyUTBlL0lOa1Y0?=
 =?utf-8?B?MlAwSksrRTFFd2RhSG9vY0l3UFo2UFBhQ08rUmtiN0NkbmNFWDhtS1Jpd1hx?=
 =?utf-8?B?T0ZlK0V5OEJHaDdsZ29DTjlsUU5GZlNMSXFUQ204OTBmaWk3YmNGWEtQZlAv?=
 =?utf-8?B?aC9BUHdRQWhFWFJoZ0FWWG1Fd1F6K0xSR21zTmdZWmJtdHpBaGc0ZTV2YWpL?=
 =?utf-8?B?cDBGY3ZLcG1jakloU0J6K3RyalVqYlhwY0VQVFZFcFhjL2d0R1pJSERJL1Rh?=
 =?utf-8?B?eVFjMlR2dURxT2dxSCs1N21wa0ZoSVU5VUF3UnI2WkFLN0ZsZEtqQU1HNnpT?=
 =?utf-8?B?ZlEvTW1uQzRrbUxCTHlHUkowbDJsQjRyVnFzM2hKNGNHcWRDb2pTak4xZFNS?=
 =?utf-8?B?Q0lmYncvOXg0SjdnSHBCenNLN1FjWW5iNTRBa01ZeDR6cnoxQTk3UXZ2WVpQ?=
 =?utf-8?B?Wi9TYTFnVmRFa1crKzRQQ3ZPNHNvbUlKeHBhNnVTTEl6QU1vR3ExamdONWND?=
 =?utf-8?B?MlJvQm5Ddjc5WjNBeFVvWDRkQ0lDTXBIazhQbStsTTkyQlQ4cTJ0ZEhyV2VV?=
 =?utf-8?B?bXp6M1JUMElGay9oeEl4dmEvZnI4aU04MmUrbXZBbllwNWgwVTdBdjN2YVBa?=
 =?utf-8?B?d3Q4L2tyV0NlYzVLS3JoUUZUNHBjUGVBTWxaK3Fra2VrMCs4WklRSlRybVZQ?=
 =?utf-8?B?dGkwVGZraW9rdnVyZVpUTVJ6T0E1RzgxTy9yNVB2M3JIeUR5RE8rN09tRFZn?=
 =?utf-8?B?WGtpUEMrRUZhckNOcHZjVjlGWkwwdFdXTlkvNUNxSWszTXdMZU9GeVh1OWlT?=
 =?utf-8?B?SnpZZlYzVVZjMUNlNS9GaEV6dGpwZFZZQWZQdjhTMWxRRVE4VzF2Qnc2c1Q0?=
 =?utf-8?B?YnhHMWhWQks2eFR1ZUR4TnRGbGNvTlN0TGYvdzhmZDlVWjdEalQyTmJRc1k4?=
 =?utf-8?B?UTBoNkZXQ1ZuS2VYSFQzNFFWcU1sZ05qdEZxOEZNZjBIN0JkSFdISXgyTjJq?=
 =?utf-8?B?R2k0bFhMNGxFRTc3UGJXc2MwemJjUVhyeGl3N0wyYm5TMW5XRmc4bnhTMEow?=
 =?utf-8?B?SVo3dHZ6bUNoRFVVT09xWWdhSVN1YzFUU1ZHR1ZPQkJwK2hBcldMSGxRNkxH?=
 =?utf-8?B?SFJZNzZzS20rUU0wWWtCcHArU21teU1oMThYc3I3L3dybGk5N25XSFBWc0Jx?=
 =?utf-8?B?MWpvRFdqN2pqSXRYVXJmR2NyZUE0N3YwSkt3akVEVWlMckY0YzZTekFqMzRw?=
 =?utf-8?B?cEdrYXBxb2FHQ2t4TEVTUyt1SC82YUYyaWtxTGlsMW56b2UxdzMreXhuUzBt?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD5B44E80C8CB34C81FA3B6645D3F0E8@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eb7bce-f605-44ea-c2ae-08d9a87801d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 20:39:22.5403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1wfGM76I1dqc5hR6h+aTiZhrohejCTvKq+5F38UYFY+LxzeQiPwXg1vCz0uRXoX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2837
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: _q9_3EUuxGKOgb0u3bC05aI2FqCSfbIV
X-Proofpoint-GUID: _q9_3EUuxGKOgb0u3bC05aI2FqCSfbIV
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_15,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=477 suspectscore=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDE1LCAyMDIxLCBhdCA5OjUzIEFNLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBOb3YgMTUsIDIw
MjEgYXQgOTowNyBBTSBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOg0K
Pj4gDQo+PiBUb3Agb2YgdHJlZSBpcyBhIGJpdCBiZXR0ZXI6DQo+IA0KPiBUaGFua3MgZm9yIHJl
LXRlc3RpbmcuDQo+IA0KPiBUaGF0IGRvZXNuJ3QgYWN0dWFsbHkgbG9vayBhbGwgdGhhdCBiYWQg
Zm9yIC1yYzEuICBTZXZlcmFsIG9mIHRoZW0NCj4gYWxyZWFkeSBoYXZlIGZpeGVzLCBhbmQgbW9z
dCBvZiB0aGUgcmVzdCBsb29rICJlYXNpbHkgZml4YWJsZSIuDQo+IA0KPiBGYW1vdXMgbGFzdCB3
b3Jkcy4NCj4gDQo+IFRoZSBtb3N0IHdvcnJpc29tZSBvbmVzIGFyZSBwcm9iYWJseSB0aGUgc3Rh
Y2sgZnJhbWUgY29tcGxhaW50IG9uZXMNCj4gKGxpYnpzdGQgYW5kIGEgY291cGxlIG9mIHBvd2Vy
cGMgb25lcykgdGhhdCBHZWVydCBhbHNvIHJlcG9ydGVkLCBidXQNCj4gdGhleSBtaWdodCBhdCBs
ZWFzdCB0byBzb21lIGRlZ3JlZSBiZSBhcyBzaW1wbGUgYXMganVzdCBkdWUgdG8gdGhlDQo+IHNh
bWUgZXhjZXNzaXZlIGlubGluaW5nIHRoYXQgd2FzIGFscmVhZHkgZmluZ2VyZWQgZm9yIHRoZSBj
b2RlIGJsb2F0Lg0KPiANCj4gQnV0IGl0IGNvdWxkIGJlIG1vcmUgZnVuZGFtZW50YWwgLSB0aGUg
a2VybmVsIGp1c3QgZG9lc24ndCBsaWtlIHN0YWNrDQo+IGFsbG9jYXRpb25zIHRoZSBzYW1lIHdh
eSB1c2VyIHNwYWNlIGRvZXMsIHNvIHRoZSBzeW5jLXVwIHRvIGEgbmV3ZXINCj4gbGlienN0ZCBt
aWdodCBiZSBhIGJpdCBtb3JlIHByb2JsZW1hdGljIHRoYW4ganVzdCAiZG9uJ3QgZm9yY2UNCj4g
aW5saW5pbmciLg0KDQpPbiB4ODYtNjQgSeKAmXZlIG1lYXN1cmVkIHpzdGTigJlzIHN0YWNrIHVz
YWdlIHRvIGJlIDEuNktCIGZvciBjb21wcmVzc2lvbiwNCnRoaXMgaXMgdXAgZnJvbSAxLjRLQiBi
ZWZvcmUgdGhlIGNoYW5nZS4gSSBzdXNwZWN0IGl0IGlzIGEgcHJvYmxlbSB3aXRoIHRoZXNlDQpm
dW5jdGlvbnMgb24gdGhpcyBjb21waWxlciArIGFyY2hpdGVjdHVyZSBjb21ibywgd2hlcmUgdGhl
IGNvbXBpbGVyIGlzbuKAmXQNCmFibGUgdG8gaW5saW5lICsgY29uc3RhbnQgcHJvcGFnYXRlICsg
cnVuIGRlYWQgY29kZSBlbGltaW5hdGlvbi4gVGhlIGZ1bmN0aW9ucw0KbWVudGlvbmVkIHJlbHkg
b24gdGhlc2Ugb3B0aW1pemF0aW9ucyB0byBiZSBlZmZpY2llbnQsIGFuZCBJIHN1c3BlY3QgaWYg
dGhlDQpvcHRpbWl6YXRpb25zIGZhaWwgdGhlcmUgd2lsbCBiZSBhIGxvdCBvZiB1bm5lY2Vzc2Fy
eSBzdGFjayB1c2FnZS4NCg0KVGhlIHNvbHV0aW9uIHNob3VsZCBiZSB0byByZW1vdmUgdGhlIGRl
cGVuZGVuY3kgb24gY29tcGlsZXIgb3B0aW1pemF0aW9ucw0KZm9yIGVmZmljaWVudCBzdGFjayB1
c2FnZSBpbiB0aGVzZSBmdW5jdGlvbnMuIFNvIHdlIGRvbuKAmXQgZW5kIHVwIHdpdGggZXhjZXNz
DQpzdGFjayB1c2FnZSBvbiBub24teDg2L2FybSBhcmNoaXRlY3R1cmVzLg0KDQpPbiBteSB0b2Rv
IGxpc3QgaXM6DQoNCjEuIFJlZHVjZSBzdGFjayB1c2FnZSBvZiB0aGUgbWVudGlvbmVkIGZ1bmN0
aW9ucw0KMi4gUmVkdWNlIGNvZGUgc2l6ZSBibG9hdCBvZiBsaWIvenN0ZC96c3RkX29wdC5jDQoN
CknigJltIHdvcmtpbmcgb24gdGhpcyBub3csIGFuZCBleHBlY3QgdG8gaGF2ZSBhIHB1bGwgcmVx
dWVzdCByZWFkeSB0byBnbw0KdG9tb3Jyb3cuDQoNCj4gTmljayAtIHlvdSd2ZSBiZWVuIGNjJ2Qg
dHdpY2UgYmVjYXVzZSB5b3Ugc2lnbiBvZmYgeW91ciBjb21taXRzIHdpdGgNCj4geW91ciB3b3Jr
IGVtYWlsLCBidXQgdGhlbiBzZWVtIHRvIGFjdHVhbGx5IHByZWZlciB0aGUgcGVyc29uYWwgb25l
LCBzbw0KPiBJIGRpZG4ndCBrbm93IHdoaWNoIHRvIHVzZSBhbmQganVzdCBhZGRlZCBib3RoLiBT
ZWUNCg0KU29ycnkgZm9yIHRoZSBjb25mdXNpb24uIEJvdGggd29yaywgYnV0IEkgcHJlZmVyIG15
IHdvcmsgZW1haWwuDQoNCj4gIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNjUyZWRlYTct
MjhhMC03MGQ5LWM2M2YtZDkxMGI1OTQyNDU0QHJvZWNrLXVzLm5ldC8NCj4gIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAyMTExMTUxNTUxMDUuMzc5NzUyNy0xLWdlZXJ0QGxpbnV4LW02
OGsub3JnDQo+IA0KPiBpZiB5b3UgZGlkbid0IGFscmVhZHkuDQo+IA0KPiAgICAgICAgICAgICAg
IExpbnVzDQoNCkJlc3QsDQpOaWNrIFRlcnJlbGwNCg0KDQo=
