Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A63B5ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhF1JIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:08:05 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:23070 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232284AbhF1JID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:08:03 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S8vSTR012982;
        Mon, 28 Jun 2021 05:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=wmklQWtDyhsmSAj2yn6Yc4pgH9L9lhQrxRuPwrIYwzA=;
 b=ePujQ2LvSzxWpiH0EZrKSR435Vd9jzAMs+1JZJz03dgcW7b+f3v+Rkp7xBVq3YkPif3e
 hUtl47Hp+b53HM62EzwMG789DYCb9S8Q/LDd2RYva2n+6AVGtwhg8VZ/b08uJgDpALDW
 f0vjIZodYKdLsv2v9ZHSyhrO5Ckf53jatILMu5wAhd8aHsWUHlNI2kvUNRvpKzPayIHb
 rBkaNn1Kan2F2ZgWojnR/voSd7UuOueLtzqQdGwuA6/lBQK6GkyxFV8ceBiFUg3cR3QJ
 fhL+WVWD+BEIDMiElP7vobABSfjGZwh5v7ccPecUhoxUGqWKZhSzMn3qh4Ci1YGBH2ML lA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 39dya5muqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 05:05:30 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S95Qc3091299;
        Mon, 28 Jun 2021 05:05:30 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00154901.pphosted.com with ESMTP id 39ehuymw5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 05:05:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDEJ+sdBen5uaMZpDaqBf/0nBiBcDjS0350WFwX3GHR+JVyPZXkQWElwbMPZIWmpk1iXahBGiA7sDOPicONLdmuEMDngA9+vzbaWvhyW3ILOXRKv1id/Q4R/skC0CxsQyxDgnZBaE/YG/jj35ZZeCMU1Hrwgtf6oSQq9DJtjJ7bb/Se2miVGKkqNQHhC0WFW1iJ2gcKP0pSf2LJnNjNBS1CJ+Snfl+5e2TN/rGaFieiRB9RCn+5gAziHPkeab3STlylmBfT7Q2Axm01cb2R3/GSOqN8Qzw93xyPaAwkpv3Pnu+2PyAiFuD46VbgRWhR0iKwBg0XZp0J5zorwf1YEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmklQWtDyhsmSAj2yn6Yc4pgH9L9lhQrxRuPwrIYwzA=;
 b=M2pYDJZJMO2ZVEmyuNNYHv2iZ5PmOSQ2BPsI5ELVvj0axdxZGubyANzNf8PZyx2m+IWbqk/4cTTUybRhq7EVL4R627fdygKkmj3QNbjF6n2SeAmEB7Gk5cc0cRv2yOr6qFfFhD8te1+odJkv+l4SPnJaKAuBNCrzZTTnDaTgEzb8Arrxcq6aQmVDjH3cqMCy4vEA+bdtNE4Q5ewysEOCODnCW501QaT9ibyjC8HNCAhkenBhcQR+Q9yT7btSNGbL9PAHnxRdgJo3P5ebCaG6+DMyH97qt76XcGDNneYaLWt70XTT2IX1Mwe09odLiqYbGurkQXunoaMFK771Vv6S3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB5078.namprd19.prod.outlook.com (2603:10b6:303:d4::15)
 by MWHPR19MB1439.namprd19.prod.outlook.com (2603:10b6:300:cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 09:05:18 +0000
Received: from CO1PR19MB5078.namprd19.prod.outlook.com
 ([fe80::dca3:f8fd:13a6:9e10]) by CO1PR19MB5078.namprd19.prod.outlook.com
 ([fe80::dca3:f8fd:13a6:9e10%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 09:05:18 +0000
From:   "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Prasanth KSR <kosigiprasanth@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>
Subject: RE: [PATCH] platform/x86: dell-wmi-sysman: Change user experience
 when Admin/System Password is modified
Thread-Topic: [PATCH] platform/x86: dell-wmi-sysman: Change user experience
 when Admin/System Password is modified
Thread-Index: AQHXa/qX+QCHn4v12EWuUBI+3ztFmKspIHaAgAAAPQA=
Date:   Mon, 28 Jun 2021 09:05:18 +0000
Message-ID: <CO1PR19MB507806E0DA8FB8070BE534FA82039@CO1PR19MB5078.namprd19.prod.outlook.com>
References: <20210628084906.4233-1-prasanth.ksr@dell.com>
 <e9818bf6-13fb-dec1-c2ee-87ecb2b2cc20@redhat.com>
In-Reply-To: <e9818bf6-13fb-dec1-c2ee-87ecb2b2cc20@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [49.207.213.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0afd4068-2d15-40e5-8935-08d93a13da2c
x-ms-traffictypediagnostic: MWHPR19MB1439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR19MB1439B24019C1CA0ED5B22D3F82039@MWHPR19MB1439.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j4/S+HWhHML0/Erwa14ZnIQb5AwIN2N1Z9rlPbGEgfMo9DnG3Ux2EbfS6VoPi71kQhpFlICC+6YQs1aAg7K8JsXAcQ99chnVnC2ys8JOQ9S4+oLavCGg3QaV86UrpWNHglVH/vmHP5GITGFJOc2Bq06crXjjr1S/zK62CSjZZRR7BfizHR3N7Rik/u6L9HGucK3GGwtvzo6EcLXfe/QkN3CsMzoEyryupd6KU1p5zylhwgTiZBI1JBCUGQypDqLkzpYA9Gfwsz0+2LqcSUE8LWH3w8j61LDPKa+VLPwX66UjTh0Af6WC2+nRvGRIDNDXsnnfnGqHZyY6wCWYuTBE4ItTbPity2ZtqF89WEMPh74FgnWu6SIkXB/YyKv+epSSlTEq5/wrvGHdaGVNq3l62e/DeGEqH/Q5ksGrJUB1iprorW6UUmgIYnT7oQI4CozDwvEqx3IXkX1clUcY7Q1xiMLu5qGEr7b4PULYICtUdObzXDSotrvzYCr2lhCxavVAsyWx2vNgyvzLQ0cEer56IOU4fPQM2m1/MAUio3NUUFi2TZsKHrHYSFFS3un0Gb9C9KM4sRvUJViof4tl71vTu57ZVnzK5TnWjCPmiHTUUHQfBFtm8f11rYyON0pBamUFxP1n4r1v6uBHBPewjEr8uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB5078.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(8676002)(8936002)(33656002)(83380400001)(478600001)(71200400001)(66946007)(38100700002)(7696005)(186003)(122000001)(26005)(55236004)(2906002)(53546011)(6506007)(9686003)(5660300002)(4326008)(107886003)(54906003)(86362001)(110136005)(786003)(76116006)(66556008)(66446008)(55016002)(316002)(66476007)(64756008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NENaRm15V0gxd25LRjFPMHhZZEtCMkE3L3Fyb3NaaE1GSHpyd3R1NEJJU0dj?=
 =?utf-8?B?cmFSRHpVbER5QS9oVHN1ZDVOZmJ0S2dZY1dvQkNNaE1SdS9KUzBwS1BBdElT?=
 =?utf-8?B?S25QeW13anlWTzg2QWZSeGtoNHhMM2xWQkwzWGRadlVRQmszeVByeEVYc2Nh?=
 =?utf-8?B?YnNobitMaElBdUVrRDFSYUJ1aVlXWUU0a3ByVC8rblZ1dGE2V1RPL1Q5LzFq?=
 =?utf-8?B?MHhBRE00YlhrT1BSTWVCenZJRDBTNVVMZVpIN0hsZXlvMzR3Q2ttb05VVWRL?=
 =?utf-8?B?ZEpvSzNMdXZzWU1FdmszM3gwLzE0UmFNTWRUZkF5NCtyNTJPM2tQTXZrYWpp?=
 =?utf-8?B?UzZGbzhYQldpdjM4WnZQNDNpTVFSWk5XL1hvblBtcEtTbm9mVzBzcE5UaVVy?=
 =?utf-8?B?RW5PQmFvOFhkZllvMjJ0aXVvMDV1cHBhVjdndytDSjA1alRRS3NnekVYaFpt?=
 =?utf-8?B?VFNuMFVjR2F0Wi9XSktQaG4ydDNOc0ZsZkJIQW9ZNjk2Y1FzR2ZiRWh3ZEg3?=
 =?utf-8?B?YTJtREJQZXVJdEc3Q3NQMlF3SWR1ekFIS21adGRQZk5FbTI3KzhWNmdVb3Az?=
 =?utf-8?B?U244RnZzY0U2Sjg3Z1RGa2ZaekZGQ0VwYzZ5VEpzUEVqazVGT1BlVnhSbzJv?=
 =?utf-8?B?dVFEVWN1eS91TzBPRUlDbVRxRWdhSXNwTmVzQ0xpVVd1aEhjVVNpdWtnTXdO?=
 =?utf-8?B?RTBXVHpkQTU4RGRwZndRT21tMXpNaWY3K1VHVFNMYnVFcHFVUXNndWpuZE1K?=
 =?utf-8?B?Z0Q1VXVDc1I2V1BzcGk3c0Mya1lLblI4MUhJOTRNT0x4Vi9oa3Y2YnN1alNM?=
 =?utf-8?B?blV3MmpZR3Vsc3h5M0FVLzVEeE1URUNjZmtEbStpS2diY1BOcFZVelhYSEJj?=
 =?utf-8?B?M3k3YThnc1RiaE1uVG5QV29weXMyeEpmYThib3RJZyt2TnJZdWdNcTVvenZt?=
 =?utf-8?B?aWJwNkx6N2ZCUS9hd3hsM3dadlVQRDI2RjloNDZvTjQyQk10bnRYVXF3SGxZ?=
 =?utf-8?B?L1ptY09VS2R0cnBKaGV5dmE3UG9iVGdNb3VsUit4SWV6d1J2NnNxVzlZK0pU?=
 =?utf-8?B?QTBkUXRTRW5RVHVOeENFcVB3Z2dkUnlKcjJYZHpRalN5d0tWNTM4SS92S2tD?=
 =?utf-8?B?TEd5eElRNUJLRzlSRCsrL256d2Vlc2ZISWlxOU5yN3RWeGltcTZiY2FBUG5h?=
 =?utf-8?B?RUJkT0hoc0pRWDJPcUU1dHpmN0tpK3NYSStiampKa005enB5c0FVOWdxNEZK?=
 =?utf-8?B?emR1Tk5Lb3BYVUdxVTc3YlJ3Qm16LzhOK2o4L0pmUjJLVlF3am0reDVpV3dj?=
 =?utf-8?B?RGN3bDBWdks5ZFk3Q2ZjTlZyY29hWGNwRW5rV3A4Qm0xTlFmbGU4Ty9Ec01i?=
 =?utf-8?B?aXZkR3A0UzFVcW02SXhhVks0aVJLU1lGWC8xN2Fjbmx1RHpkeS9GZWIyNnpW?=
 =?utf-8?B?Nk92SXRQRTlSU1VyTmk0UEdUVEdZQzBBdXJjakxVbStKaTY2SjhkNlN5dTZM?=
 =?utf-8?B?aWh1bCtPZmM5K1kzbFo3cjU2SjBGaTVXbXpkZGJTTWRqN0UxSVRQZDNEOEdX?=
 =?utf-8?B?OFhoT1FnUGx0cmcwV1FLd3FORGVTM1FkWTh0ZGdNS2FLZ1FOMGZhdGJDYVN4?=
 =?utf-8?B?Sm0zOWU5dzRWai9YcUhWZlVGdDBsQU9HTnhtczYzTGtIKzlpZWZ4WTBVb3pl?=
 =?utf-8?B?WUVZRW1sdFNZdHhxYVpWdUYvYU9ZSlU3WEVlcE1VdUZnOGxqL2NwQUNVZ0M0?=
 =?utf-8?Q?4nnsN2zIkgBYitYI0HnRBxEGU1PkQ5RE60uLPhc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB5078.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afd4068-2d15-40e5-8935-08d93a13da2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 09:05:18.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vz7Xt/aDbaQLwQ7pinqlb4tzrewEJ/HRahFCZ+q7uNj0zqiZq/P1Zyg+rTA+z6CZQsKJmytks5Qli1cMGU7cWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1439
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_07:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280063
X-Proofpoint-GUID: 35q6UwRMF9Ul6yZuBG5Gc8w0wJts-S87
X-Proofpoint-ORIG-GUID: 35q6UwRMF9Ul6yZuBG5Gc8w0wJts-S87
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIGRlIEdv
ZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjgsIDIwMjEg
MjozMiBQTQ0KPiBUbzogUHJhc2FudGggS1NSOyBkdmhhcnRAaW5mcmFkZWFkLm9yZw0KPiBDYzog
TEtNTDsgcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7IEtzciwgUHJhc2FudGg7
IEJoYXJhdGhpLCBEaXZ5YQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwbGF0Zm9ybS94ODY6IGRl
bGwtd21pLXN5c21hbjogQ2hhbmdlIHVzZXIgZXhwZXJpZW5jZQ0KPiB3aGVuIEFkbWluL1N5c3Rl
bSBQYXNzd29yZCBpcyBtb2RpZmllZA0KPiANCj4gDQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4gDQo+
IEhpLA0KPiANCj4gT24gNi8yOC8yMSAxMDo0OSBBTSwgUHJhc2FudGggS1NSIHdyb3RlOg0KPiA+
IFdoZW5ldmVyIHVzZXIgaGFzIGNoYW5nZWQgYW4gQWRtaW4vU3lzdGVtIFBhc3N3b3JkIHVzaW5n
IHRoZSBzeXNmcywNCj4gPiB0aGVuIHdlIGFyZSBhdXRvbWF0aWNhbGx5IGNvcHlpbmcgdGhlIG5l
dyBwYXNzd29yZCB0byBleGlzdGluZw0KPiA+IHBhc3N3b3JkIGZpZWxkLg0KPiA+DQo+ID4gQ28t
ZGV2ZWxvcGVkLWJ5OiBEaXZ5YSBCaGFyYXRoaSA8ZGl2eWEuYmhhcmF0aGlAZGVsbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogRGl2eWEgQmhhcmF0aGkgPGRpdnlhLmJoYXJhdGhpQGRlbGwuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByYXNhbnRoIEtTUiA8cHJhc2FudGgua3NyQGRlbGwuY29t
Pg0KPiANCj4gVGhhbmsgeW91Lg0KPiANCj4gSSBhc3N1bWUgdGhpcyB3YXMgdGVzdGVkPyAgVGhl
IHJlYXNvbiBJJ20gYXNraW5nIGJlY2F1c2UgaW4gdGhlIExlbm92byBUaGluayoNCj4gY2FzZSBp
dCB0dXJuZWQgb3V0IHRoYXQgdGhlIG1vZGlmaWVkIHBhc3N3b3JkIG9ubHkgYmVjb21lcyBhY3Rp
dmUgYWZ0ZXIgYSByZWJvb3QsDQo+IHNvIHRoZSByaWdodCB0aGluZyB0byBkbyB0aGVyZSB3YXMg
dG8ganVzdCBrZWVwIGN1cnJlbnRfcGFzc3dvcmQgYXMgaXMuDQo+IA0KDQpZZXMgaXQgaXMgdGVz
dGVkIGFuZCBEZWxsIEJJT1MgQWRtaW4vU3lzdGVtIHBhc3N3b3JkIGRvIG5vdCByZXF1aXJlIGEg
cmVib290IHRvIGJlIGFjdGl2ZS4NCg0KPiBSZWdhcmRzLA0KPiANCj4gSGFucw0KPiANCj4gDQo+
IA0KPiA+IC0tLQ0KPiA+ICAuLi4veDg2L2RlbGwvZGVsbC13bWktc3lzbWFuL3Bhc3N3b3JkYXR0
ci1pbnRlcmZhY2UuYyAgICAgICAgIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsL2RlbGwtd21pLXN5c21hbi9wYXNzd29yZGF0dHItaW50
ZXJmYWNlLmMNCj4gPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwvZGVsbC13bWktc3lzbWFu
L3Bhc3N3b3JkYXR0ci1pbnRlcmZhY2UuYw0KPiA+IGluZGV4IDMzOWEwODJkNmMxOC4uODZlYzk2
MmFhY2U5IDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVsbC9k
ZWxsLXdtaS1zeXNtYW4vcGFzc3dvcmRhdHRyLWludGVyZmFjZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvZGVsbC9kZWxsLXdtaS1zeXNtYW4vcGFzc3dvcmRhdHRyLWludGVyZmFj
ZQ0KPiA+ICsrKyAuYw0KPiA+IEBAIC05NSw5ICs5NSw5IEBAIGludCBzZXRfbmV3X3Bhc3N3b3Jk
KGNvbnN0IGNoYXIgKnBhc3N3b3JkX3R5cGUsDQo+ID4gY29uc3QgY2hhciAqbmV3KQ0KPiA+DQo+
ID4gIAlwcmludF9oZXhfZHVtcF9ieXRlcygic2V0IG5ldyBwYXNzd29yZCBkYXRhOiAiLCBEVU1Q
X1BSRUZJWF9OT05FLA0KPiBidWZmZXIsIGJ1ZmZlcl9zaXplKTsNCj4gPiAgCXJldCA9IGNhbGxf
cGFzc3dvcmRfaW50ZXJmYWNlKHdtaV9wcml2LnBhc3N3b3JkX2F0dHJfd2RldiwgYnVmZmVyLA0K
PiBidWZmZXJfc2l6ZSk7DQo+ID4gLQkvKiBjbGVhciBjdXJyZW50X3Bhc3N3b3JkIGhlcmUgYW5k
IHVzZSB1c2VyIGlucHV0IGZyb20NCj4gd21pX3ByaXYuY3VycmVudF9wYXNzd29yZCAqLw0KPiA+
ICsJLyogb24gc3VjY2VzcyBjb3B5IHRoZSBuZXcgcGFzc3dvcmQgdG8gY3VycmVudCBwYXNzd29y
ZCAqLw0KPiA+ICAJaWYgKCFyZXQpDQo+ID4gLQkJbWVtc2V0KGN1cnJlbnRfcGFzc3dvcmQsIDAs
IE1BWF9CVUZGKTsNCj4gPiArCQlzdHJzY3B5KGN1cnJlbnRfcGFzc3dvcmQsIG5ldywgTUFYX0JV
RkYpOw0KPiA+ICAJLyogZXhwbGFpbiB0byB1c2VyIHRoZSBkZXRhaWxlZCBmYWlsdXJlIHJlYXNv
biAqLw0KPiA+ICAJZWxzZSBpZiAocmV0ID09IC1FT1BOT1RTVVBQKQ0KPiA+ICAJCWRldl9lcnIo
JndtaV9wcml2LnBhc3N3b3JkX2F0dHJfd2Rldi0+ZGV2LCAiYWRtaW4gcGFzc3dvcmQNCj4gbXVz
dCBiZQ0KPiA+IGNvbmZpZ3VyZWRcbiIpOw0KPiA+DQoNCg==
