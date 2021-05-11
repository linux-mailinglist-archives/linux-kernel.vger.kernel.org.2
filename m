Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CFD37AF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhEKTeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:34:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27946 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231454AbhEKTen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:34:43 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BJVeHi006517;
        Tue, 11 May 2021 12:33:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=6rt2BudSuusF8Jce/b3Oupl4N8cBBCUvMQc27DvYlg8=;
 b=Cwe2XxaDkA2nnUd4is5QTwx80kpLNZ/uuKigMR7YJ4zXeZdtBuAaECpH1IK4FiJcclJW
 MSoxLY/jak+SDIpyUEHtT6Qgk9duWaugDj/pwxOmZteVSba9Gl2ruZ4+lDkEuZuQhhwC
 XEfsr1q8GUpv1nVEa4pMOoz021PfrNlX8kQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38fap76uw0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 May 2021 12:33:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 12:33:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRjGk6Z6w5IoBA8TZCPmkK2lifMYAfyVYbORHUwgVVrxJbJGpHJuEHgKbjxjfD8de6rbKo86S4GRQrTqPZA5VuGNs79Z2xSaLGEMxIGi4dcsOZunqlRr26wO+L+WmJMP0WRhhEfaRjloMyWo+7Up98devdX45JU3MzhCLqnGFuZFwFmIzAUAJfp49P7+zHEMzL9gxxmyXtkhffNSlX9qPTo+FnXZwk+vpqzRXsaRZ7Dsvo521+SAopMnQjJUeyU0YRlNRO+76ZGxVooUwtev3+sa90dSm0Vkn1yo/JbCa1Pb8eS5VtX4/oqPFSPP/mgFwIiB6n1pbCEtVS2jfB1LJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rt2BudSuusF8Jce/b3Oupl4N8cBBCUvMQc27DvYlg8=;
 b=InUUd8H72H1XAo0rPrWyuvIsVyOQxvYksxLVJo77/Y9XDFzrMXo+yoE8RpRBz/XKWwAbZPSQLZdMZb1Ou37w6KccXGxWR2/9Z9E6+Na1oS+b71hSoWBNfE8RFHHKj1JVMyPfhrSJ5slAtWm3BUp7WaWUD/1FpV2Z36CGMdCXX8vKbU4wPzZAcQSaH4i75X0mqYgTdmqRxTZ0+QIlhmwgk6AK5ZY2NTHawHYahR0OhP6TIPNOELfWA4WBS4ZAT1/h9YpgGxeuMSY5UPjGrw3a9qVPVCHirt19Oj6sGQms74budvqkujik/04K696keNMTXcMQ7psMmpb3QddxiURNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BY3PR15MB4977.namprd15.prod.outlook.com (2603:10b6:a03:3c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 19:33:26 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8a:2386:5e51:e2e7]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8a:2386:5e51:e2e7%6]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:33:26 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Rajat Asthana <thisisrast7@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <hsiangkao@redhat.com>,
        "joe@perches.com" <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lz4_decompress: declare LZ4_decompress_safe_withPrefix64k
 static
Thread-Topic: [PATCH] lz4_decompress: declare
 LZ4_decompress_safe_withPrefix64k static
Thread-Index: AQHXRnyFFV6Jn7ipZke+ct3Xm8d/HarerA0A
Date:   Tue, 11 May 2021 19:33:26 +0000
Message-ID: <E0798788-E0E4-4DC0-A64E-B137D618255E@fb.com>
References: <20210511154345.610569-1-thisisrast7@gmail.com>
In-Reply-To: <20210511154345.610569-1-thisisrast7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [98.33.101.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40fd05b9-3f0f-4515-c289-08d914b3a5ee
x-ms-traffictypediagnostic: BY3PR15MB4977:
x-microsoft-antispam-prvs: <BY3PR15MB4977CB0E3EE29D8092CAF808AB539@BY3PR15MB4977.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3EWJcV0tOXPPrrTCUrcXHa5WCFb732L2H9BLotWCbvYgdvzk4DeStDnPZRTAqm7nCbnhiYRVAjIJtaFj6y2mQwe17+RFVsA0oiMkSthMdFZcAw7Dvz6bpzv3Qdop/WbbNetQwqfdJ/YdBYqK5CUYD1yN4W1MktcVL9JJQE2Cv0PX1ODGPzXGb/iEaK1P7qSMPMmIEH+kRsojVg0mXqtoyEEjCLhswhPjG1+sxvQpI8i0zDclau9KYfMKs3n+TJsVGbQfnImDkmSQ8rrlicBkX2eEoOSR+jfADJ1fTf+3aQydJSiT3SVb+MWaWITiUS4i1yv68kv4TJQT1pKpKixGN2Un8RUlH/gxLjvPxbZ5XGuN3uyqsr0sU+rAcOQ8zH53UULC0hk5y+3WPptutuR1GMi4hvJchbi3VTkI/IdsLaMY/WzKyoEqKQaBR6t1mzW0IdNb+ABNkuIl1BA2Vxwu0hBrRpO7NLRrdng2DuEQ1uwo12p/Q4UYiH2negoeYbotZkTITPfPFtShrvZMf2rT1UUm9QqKhQ4riXg0yE2SgZs2N+4MP0EfvEUtrDI4/MSZOOCNgdqquYPUu5kej2ywZrPVA+Ylw9kSYDPot6zx7WEvlZGuNlVYHCz6VCSMg/W78P9EAy/sg2Ixn5AdgQ4YUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(86362001)(33656002)(76116006)(122000001)(38100700002)(83380400001)(64756008)(71200400001)(66476007)(66946007)(66446008)(66556008)(186003)(2616005)(2906002)(4326008)(6512007)(54906003)(8676002)(6486002)(6916009)(26005)(8936002)(5660300002)(53546011)(6506007)(498600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R1VVcE5MRkFUd2RnM3lCRDY4aWdQN1B5SVRTZlhMTGZmUnpDMEZPT2h3Rms1?=
 =?utf-8?B?a1k4STdqUmlEdlhnSzJNYXhzTlcyRkMrQitLZUNkVTdzNU5mU2FGVytiUFNT?=
 =?utf-8?B?dHV0ZE5NQjdySnpZZjF3WWQ0aVN2dzk5dVd5OUZ4R2d3SjFlYXhCRU9ReFdZ?=
 =?utf-8?B?dlJHV1JnSWlZZSs3MkZwY0IwRE81V2lOOFlOUnVRYVhQQVRuUFdYRlJ0UlNr?=
 =?utf-8?B?Vm1VeWxGSVFxdDJEZUxsNFBRODBWWWlCVDNrNTI1Y3FLbzRWZHJ0VEczODha?=
 =?utf-8?B?UzZwMGFXTjlrcDk5MkRlbkkxUTdBbStJY2pYanA0U2tyWlZpcmljalRnbGUy?=
 =?utf-8?B?WFhTTklSSm9DN2VpV0VqM0dXWjdkYjZkSUx1TTJIa0x0TmFscEkySStMUlox?=
 =?utf-8?B?OFpkNnh3c2w5V2sydXU0VXRLWjNvVXU0TEJIclVCMXA5SkxWZUlOVU5rbDlF?=
 =?utf-8?B?NlY5RGxsTDN5NEVnTXhocWd0dEhmMHpNS0JMUUZKMXMzRG91cys5Nnl0dWFt?=
 =?utf-8?B?eEJ4VDVnNkpuZGM0QnAzNU0xQ2xidDZKQ3BBU2R6eTNrbGpzZ0xwKzNneW53?=
 =?utf-8?B?SE9idlgrY3VGcDZ4RmVJaWl2bGgyOUV2Mjd4YXg3c3kzMnhJSHJ2dkpNM1Mz?=
 =?utf-8?B?RkNFS0s0Y0E3eW1XaE1ydlMvN1hYQnR6eVVjM0daN1ZaV0dPY01DZ0FRVzdW?=
 =?utf-8?B?VVJJSFdkMG1SOHRLR3RVbjROYW9sdVRqYUE4c0VCaWViSm0vVDhQdXpIWWRK?=
 =?utf-8?B?MVVGZHJTR1ppVnNhd2ZNMWJGR3RibTlaOWNVa3l3SFlSdzQwazVKQjkvT1lR?=
 =?utf-8?B?TmJnODBKVEtudW02cjdEMzRWMHRVUENRdGNmeDh5VWxaSURlVmZLa1gxQUpH?=
 =?utf-8?B?QWhaOFFFd29uS0FiZmhkaW9PbDdCb0RoZHAvdGtuNWpEbnNXVVFTN3NaMzNt?=
 =?utf-8?B?TE9NRXU0Z09kQ3BZR0g2VWpQejJ3SEJPTmZhaUhMOEhOc0tVNXg0VERBRjFy?=
 =?utf-8?B?RTdUQlVzOFFiNmxxbkdSVWd6dnBsNE5heDkrWTFUaExudWVRdUJBY3Jlei9o?=
 =?utf-8?B?MkNrbWMzK3lteklsVmFoeTFEVEkwdFlWaGt6KzFwQkgrUllCK3YzQXBkZVR0?=
 =?utf-8?B?MHlXTmpMOSt6MVc5N0RBMkxvcjFseDlaTGFPbWx1SnYvbk82cEludno2KzVS?=
 =?utf-8?B?OGkwTUxJNkVPcHhHYzNYSmg2UTJXZUpiNldVcGJEQVFKZEJNa0lzN1ROSmRm?=
 =?utf-8?B?d050OGlsZFhwYUsyUVlkeDBNN2RPUlBEc2VGcHZhV0JyRDVzZldLblpjYjc5?=
 =?utf-8?B?R29URUtwR1RvQXQ1Rm1USEhDaGlTbXJtOWpJcjRWSzNvZnZ6N3dXSW0vNXRP?=
 =?utf-8?B?bFE4V0lLMzY5MDdVSmdUZUFNdG01SVdVYXRnenErSElFbU5pL3NQWXNYcVZ2?=
 =?utf-8?B?QkhEWHJkMGZHZTk5TzQ1WTh5cmxEUGFhWExIaUlMeFpQVXhJWmQ0Nll3bFlv?=
 =?utf-8?B?ZUFLTTlJS3RGSW1kMjF3VjB2OHlxRFFsZDlFellPMmNZSU1Cbkl4RkdGYWls?=
 =?utf-8?B?cUV5ajhvNWhQbUtPL3lqU1grbjdhVzBkN1pabW1yWUloNlRsTnFiVWVQbnRu?=
 =?utf-8?B?QjZjMnhvWXlDSnpsd3J4ZHpSQVRuM25FczhiSUVTZUFocnpVZC9pTWVHRCts?=
 =?utf-8?B?T3k0c2RjTUlrcFZ5cTlydzVWS0I1SDUwOTU0emJnMERlZy8ycld5M0xUZWYz?=
 =?utf-8?Q?64ETVidHmADESLhkvE3O+6FakUOblB+fpU3DGHL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B0D6E36E76FED47BDAAA0F7FAEB51B1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fd05b9-3f0f-4515-c289-08d914b3a5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 19:33:26.4875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1kqfRNT8D4AzHE0L3h6TMbEooygrTP4ps3JMzXT0cjsfPwtwkhp88C+lJOWXrCI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4977
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 2idkLELocsXajarNEKi5h6hweCGaui4t
X-Proofpoint-GUID: 2idkLELocsXajarNEKi5h6hweCGaui4t
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_04:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDExLCAyMDIxLCBhdCA4OjQzIEFNLCBSYWphdCBBc3RoYW5hIDx0aGlzaXNy
YXN0N0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gRGVjbGFyZSBMWjRfZGVjb21wcmVzc19zYWZl
X3dpdGhQcmVmaXg2NGsgYXMgc3RhdGljIHRvIGZpeCBzcGFyc2UNCj4gd2FybmluZzoNCj4gDQo+
PiB3YXJuaW5nOiBzeW1ib2wgJ0xaNF9kZWNvbXByZXNzX3NhZmVfd2l0aFByZWZpeDY0aycgd2Fz
IG5vdCBkZWNsYXJlZC4NCj4+IFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBSYWphdCBBc3RoYW5hIDx0aGlzaXNyYXN0N0BnbWFpbC5jb20+DQo+IC0tLQ0KPiBsaWIv
bHo0L2x6NF9kZWNvbXByZXNzLmMgfCAyICstDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi9sejQvbHo0X2RlY29t
cHJlc3MuYyBiL2xpYi9sejQvbHo0X2RlY29tcHJlc3MuYw0KPiBpbmRleCA4YTc3MjRhNmNlMmYu
LjkyNmY0ODIzZDVlYSAxMDA2NDQNCj4gLS0tIGEvbGliL2x6NC9sejRfZGVjb21wcmVzcy5jDQo+
ICsrKyBiL2xpYi9sejQvbHo0X2RlY29tcHJlc3MuYw0KPiBAQCAtNDgxLDcgKzQ4MSw3IEBAIGlu
dCBMWjRfZGVjb21wcmVzc19mYXN0KGNvbnN0IGNoYXIgKnNvdXJjZSwgY2hhciAqZGVzdCwgaW50
IG9yaWdpbmFsU2l6ZSkNCj4gDQo+IC8qID09PT09IEluc3RhbnRpYXRlIGEgZmV3IG1vcmUgZGVj
b2RpbmcgY2FzZXMsIHVzZWQgbW9yZSB0aGFuIG9uY2UuID09PT09ICovDQo+IA0KPiAtaW50IExa
NF9kZWNvbXByZXNzX3NhZmVfd2l0aFByZWZpeDY0ayhjb25zdCBjaGFyICpzb3VyY2UsIGNoYXIg
KmRlc3QsDQo+ICtzdGF0aWMgaW50IExaNF9kZWNvbXByZXNzX3NhZmVfd2l0aFByZWZpeDY0ayhj
b25zdCBjaGFyICpzb3VyY2UsIGNoYXIgKmRlc3QsDQo+IAkJCQkgICAgICBpbnQgY29tcHJlc3Nl
ZFNpemUsIGludCBtYXhPdXRwdXRTaXplKQ0KPiB7DQo+IAlyZXR1cm4gTFo0X2RlY29tcHJlc3Nf
Z2VuZXJpYyhzb3VyY2UsIGRlc3QsDQo+IC0tIA0KPiAyLjMxLjENCj4gDQoNClJldmlld2VkLWJ5
OiBOaWNrIFRlcnJlbGwgPHRlcnJlbGxuQGZiLmNvbT4NCg0KVGhpcyBsb29rcyBnb29kIHRvIG1l
ISBMWjRfZGVjb21wcmVzc19zYWZlX3dpdGhQcmVmaXg2NGsoKSBpcyBhIGRlcHJlY2F0ZWQNCmZ1
bmN0aW9uIGluIHRoZSB1cHN0cmVhbSBMWjQgQVBJLCB3aGljaCBpc27igJl0IGV4cG9zZWQgaW4g
dGhlIGtlcm5lbCBBUEksIHNvIGNhbg0KZGVmaW5pdGVseSBiZSBtYXJrZWQgc3RhdGljLg0KDQpU
aGFua3MsDQpOaWNr
