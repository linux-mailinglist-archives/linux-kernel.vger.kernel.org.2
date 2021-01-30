Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5921C30924A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 06:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhA3FmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 00:42:21 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:18198 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233831AbhA3FiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 00:38:13 -0500
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10U3bnBN004068;
        Fri, 29 Jan 2021 22:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=LweVXdNK6nC8lO6u6fL2WOGaNF/id9k0CqF4bBGwgIU=;
 b=K7ZXwq8h+/0Ag5JCtvuBQ+96ePoxHUrf/Go06kwg25/no1TzYQQ8uABruA1SFN/8ZF8s
 X3m3yT9zGYsLJw+sER//LbLXKhxTteaChP2lcJL+pyCPOO8DL4C5lxi+nlp3m3uFVafL
 5w0xOCDJxr36yU67Wr4gXwdtZE9/gQBleBR1p+pGwFVmL9elRi4IwfZWKEe+mjQUAsLs
 dM5gesr+75k+8wrB2s4Yk9oBTG5/X9dQx/pVCm37FtCVeF8olO/erb1ubDtiPzzATG/I
 ESNVnGnMgdTBoCP1ambqwUMPVRZylVowyL+KPG0nU1PlUFmRkeU74QpbcGLuI+VBVLHA Gw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 36cb0nuhyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 22:55:19 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10U3a7vg130690;
        Fri, 29 Jan 2021 22:55:18 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0b-00154901.pphosted.com with ESMTP id 368ey8d0bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 22:55:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUxmmb/MhGwThRq2LdZ/R2DwgiMBvPc0bgEzkrOpcs9cC10x9sRcxs3no5ZqcptTN25llaRTydrsys2UzanmCuokmy2Vt9Vb4o9ooeLCPnJWKdsR6p0lZg43Kdk5dQoXkjOX5k8Mn5iDUftWd/RdOFavXbQMlqxmGaYtCdZ4D+tAyN3UDYg8ifJBgqeWyG5GvCfT5Wu7e5zfnygdof4Dhh/7y3PG22Vzm5lKciWFZqwOEByO63MFvmVe3fNdKEy+Z7qea56UYFBNl7yAuqSq0fBKQGnCDJDdaWF/n7f408sDjzhSepaIX0P+e2pQY4w9T+e391D9bQ37D06MVYdC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LweVXdNK6nC8lO6u6fL2WOGaNF/id9k0CqF4bBGwgIU=;
 b=eOp1t8Bzdwu/cob4GRd7L+oOjafp1lWdYQVmFiVekt94JFWIdgAkKJfCtqUGdVwEfHv4HemjI0PKX8v6prr8M4/wfP6/19gqEfZ+uxABc6VrSeeM90Z4TmSrI479mbfqtWQaHjURzI5+BjC9bn5iUNCBJhv4oHXM/ZszSU+DQQ/4lY2WxaMqptoM7d7ZEEfO8v9BT5gXbYCvudPreUGGXA+n+F6F54QL5ClZH3tY3OkcbefLGgNTH8iYr2bJlCUQayOoTBi2m7MfngBrwu/qNvtW9nl3JA1vrpFvbbv6tsxe4SHkcuDEH7KArjuWocW73Xd6CX5ZYgdii1uopml/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com (20.181.202.134) by
 BY3PR19MB5028.namprd19.prod.outlook.com (13.101.49.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Sat, 30 Jan 2021 03:55:13 +0000
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::f49a:eb87:f48b:9e13]) by SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::f49a:eb87:f48b:9e13%7]) with mapi id 15.20.3805.019; Sat, 30 Jan 2021
 03:55:13 +0000
From:   "Yuan, Perry" <Perry.Yuan@dell.com>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        "Martinez3, Juan" <Juan.Martinez@Dell.com>,
        "Wang, David D" <David.D.Wang@dell.com>
Subject: RE: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
Thread-Topic: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
Thread-Index: AQHW9mP0cWNChGE38Eu6VwA6sJM74ao+255wgACoQkA=
Date:   Sat, 30 Jan 2021 03:55:13 +0000
Message-ID: <SJ0PR19MB4528B841F60B7F86997FD19884B89@SJ0PR19MB4528.namprd19.prod.outlook.com>
References: <20210129172654.2326751-1-mario.limonciello@dell.com>
 <SA1PR19MB49265FC286F5D09F88F2A054FAB99@SA1PR19MB4926.namprd19.prod.outlook.com>
In-Reply-To: <SA1PR19MB49265FC286F5D09F88F2A054FAB99@SA1PR19MB4926.namprd19.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-29T17:29:09.2447069Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=f2e2fe84-58fd-4854-9e04-f2330771d27f;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: Dell.com; dkim=none (message not signed)
 header.d=none;Dell.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [114.84.248.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 354e468b-5099-40ec-0809-08d8c4d2d918
x-ms-traffictypediagnostic: BY3PR19MB5028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY3PR19MB50288B4868E7E5D2A71BBB1084B89@BY3PR19MB5028.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4pjyNqPD3PFaUPY5mwivwtE4ejnOiJ33XNzVSr5QKXvX+U3caK5MoslS2bbHO3w2n73La/tmlXv25j2Z65fia7h8iNHjbp6YNbxZskgjXHNB/6ERISr1i8mURS3jrFkRX94SHCyA8Fdz24hIdGvnp2pkYJqKOGob8eBrAeYFpV8bOFud2ri0uHV2GsMvBWRqO1sImwKjNNE9pmaImLEPV8hdcJvFDL2tXex6b5peyCvplQD/M1HaxX0wFnCxy324dQKrzmobY/Cyw068dF8+1EHKMX05cYEWIyYIk6ChG06EWbZGzKKMCNbwze41AP4oNUViUCeSIXuuJYKT77+zY2SadbiXl1hpfTJh1adN/An6xQfEb2SDUeVqh2PrEwywHF/yoVnGnnixeneIFYumJqsgt1XVqoX+qL8sthPPHRu9UTCOu8125NVLqNB5noaMs8G0HLc12kDy3HMR3ZQQ7FRpCpPu8Nsf/RQfR/aADOTFUiC/ltkFzIZkdWb0VYx5yl4y0i9R10N0KiV6nVVYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4528.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(71200400001)(54906003)(55016002)(2906002)(110136005)(786003)(316002)(66446008)(64756008)(66556008)(66476007)(66946007)(86362001)(76116006)(33656002)(52536014)(5660300002)(26005)(53546011)(6506007)(7696005)(8936002)(8676002)(478600001)(4326008)(186003)(9686003)(107886003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V3E3SDBnQ1RSTGlmQWFzTGltTmUxd1VhTldJWTlQUkpGRk1JTEYxSjh4MlpB?=
 =?utf-8?B?amp1dTVSS2hvWG1Lam44NXhYOENzUXFObGFRUS9rUHlvZUFyei9XOHpGUHlI?=
 =?utf-8?B?UXBOM2lVZ1hkWU5IWmE1aFVmY0U0V08yNDZlVXJqMExKV0xjSHZOanNlS2J1?=
 =?utf-8?B?ZUY0RHdIemxyS3QrOTlveDR0SDVYb2NEUGgxcWJwdTFmL2dyVjdnQWt5bGgz?=
 =?utf-8?B?MEZPNHUrdFNGVVVYL3lVcjhnZGpmS3FyNS9NR3YzQ3BCVVdDcW1vNGdLbHZn?=
 =?utf-8?B?TGxLMmR5eHg1YlFkcjNvMlpWanE2bG9SVTR5aU5qMzFWYnFBa0RKOUZ6bHhM?=
 =?utf-8?B?SUdSTnZxWnBkb05mMnN3V2Uxb1c3RjVuckV3Q3BwM3BVd2c3WVhDVUd5ZE1q?=
 =?utf-8?B?TEFMVlZMb2dSYkxzc3hGWUNhNGkwOHhxTkFHaVptVmc3YllrdVBkUWFoOHJi?=
 =?utf-8?B?ck1OTXNDeEF1alBVNEJhTUlXYUIzcC9DdHE5YmFrajJtZERTbGxSdlZSbDFH?=
 =?utf-8?B?SWp6aFU3a3VkcFZnZmUxR1lsQVNLSTNUOUllTFdDTERmZS9yV29relFQdktI?=
 =?utf-8?B?YlVzTGJRbE9VUSs5MlFpRjBaZlZTNVpONS9LcDVhS2wrbzZDSEFWeGI2SlhZ?=
 =?utf-8?B?QnRONFV0N2xBN2NyeVJKNGp4Wlp4dnJDVXV6Y01rSVNLcnR0UDdSakR3em1x?=
 =?utf-8?B?ZEJFcFN1Ynk1NXlYSnJlUnRtaGlUTkdydXhDZjAvSkdHckpTSXFsdWpnb1dk?=
 =?utf-8?B?dEU1elQvOUx3cjNwdmpXY0ZUd0RwQVlDRUhFOUwvTlBTRXRyVkk0S1p1MjYr?=
 =?utf-8?B?dFpwQ0dpYmxacW1oNHMyVUpScGxWL1pWNHhSM0dESGdvZ2VDVmxZaXRjNm44?=
 =?utf-8?B?eVVoM2g3czVvenlxZzJUYUtPUkV6YWl1NlhMMXdUSHBuNGtMa0txMzZjZ3FJ?=
 =?utf-8?B?K0xxdnlwM1E0SkZuN3czMnY1eEFrL3FYb0VjU016ckxVQXFiaitXNG15ZUJK?=
 =?utf-8?B?TUVtZWsyK2VoeE1xNEo1NkYwQW9uL05HZG1ZM1VLWi96bEluaW5FcVgrYkVy?=
 =?utf-8?B?djQzWWE0Q0djc0FyUjNSQlU0SU1DNXhMcXI0Q0hGMURNakxpSFFOSXl1N1RN?=
 =?utf-8?B?Y1ROQkNlSVhqOHVKL1I3VEkyWjF5R2Nnb25RVXovRW1jcUJDOGJ0WVp2UE9j?=
 =?utf-8?B?d2JKczhFRENRUmVlL0g4eGFnUVkwVFFpUC9lZmdzVnFyNitnRUlQWVV3SERl?=
 =?utf-8?B?ZEdwNVhkWnRtbDZ5ampRZEhmN3RoSElpVDdGU282RUVUbDZkUVlWemd1bXNO?=
 =?utf-8?B?dDhDRCt2RlBIaTQvQUsvb2kzV0FPam1PYjRSRlJqeXRJa05SQ1lweTc3NDZq?=
 =?utf-8?B?ZkI4N0JQRW1xUnd6bzJUTlJWL3dBbVU3TTkxekErR2FHNVNGL2d3ZjczN1p5?=
 =?utf-8?Q?9q9d2aal?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4528.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354e468b-5099-40ec-0809-08d8c4d2d918
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2021 03:55:13.5470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLmeguMYT/lLbliXPSFvrliHbB09B6TlXlKxMPWtoa0ZzYw1+R8CIquA1KXgRm2MDlL6knF/NBkuEPh7cFudJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5028
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-30_01:2021-01-29,2021-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300016
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101300016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8g
PE1hcmlvX0xpbW9uY2llbGxvQERlbGwuY29tPg0KPiBTZW50OiAyMDIx5bm0MeaciDMw5pelIDE6
MjkNCj4gVG86IEhhbnMgRGUgR29lZGU7IE1hcmsgR3Jvc3MNCj4gQ2M6IExLTUw7IHBsYXRmb3Jt
LWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBCaGFyYXRoaSwgRGl2eWE7IEtzciwgUHJhc2Fu
dGg7DQo+IFl1YW4sIFBlcnJ5DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHBsYXRmb3JtL3g4Njog
ZGVsbC13bWktc3lzbWFuOiBmaXggYSBOVUxMIHBvaW50ZXINCj4gZGVyZWZlcmVuY2UNCj4gDQo+
ICtEaXZ5YSwgK1ByYXNhbnRoLCArUGVycnkNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvX0xpbW9uY2llbGxvQERl
bGwuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAyOSwgMjAyMSAxMToyNw0KPiA+IFRv
OiBIYW5zIERlIEdvZWRlOyBNYXJrIEdyb3NzDQo+ID4gQ2M6IExLTUw7IHBsYXRmb3JtLWRyaXZl
ci14ODZAdmdlci5rZXJuZWwub3JnOyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPiBTdWJqZWN0OiBb
UEFUQ0hdIHBsYXRmb3JtL3g4NjogZGVsbC13bWktc3lzbWFuOiBmaXggYSBOVUxMIHBvaW50ZXIN
Cj4gPiBkZXJlZmVyZW5jZQ0KPiA+DQo+ID4gQW4gdXBjb21pbmcgRGVsbCBwbGF0Zm9ybSBpcyBj
YXVzaW5nIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluDQo+ID4gZGVsbC13bWktc3lzbWFu
IGluaXRpYWxpemF0aW9uLiAgVmFsaWRhdGUgdGhhdCB0aGUgaW5wdXQgZnJvbSBCSU9TDQo+ID4g
bWF0Y2hlcyBjb3JyZWN0IEFDUEkgdHlwZXMgYW5kIGFib3J0IG1vZHVsZSBpbml0aWFsaXphdGlv
biBpZiBpdA0KPiA+IGZhaWxzLg0KPiA+DQo+ID4gVGhpcyBsZWFkcyB0byBhIG1lbW9yeSBsZWFr
IHRoYXQgbmVlZHMgdG8gYmUgY2xlYW5lZCB1cCBwcm9wZXJseS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BkZWxsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVsbC13bWktc3lzbWFuL3N5c21hbi5j
IHwgOCArKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVs
bC13bWktc3lzbWFuL3N5c21hbi5jDQo+ID4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLXdt
aS1zeXNtYW4vc3lzbWFuLmMNCj4gPiBpbmRleCBkYzZkZDUzMWM5OTYuLjM4YjQ5Nzk5MTA3MSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLXdtaS1zeXNtYW4vc3lz
bWFuLmMNCj4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLXdtaS1zeXNtYW4vc3lz
bWFuLmMNCj4gPiBAQCAtNDE5LDEzICs0MTksMTkgQEAgc3RhdGljIGludCBpbml0X2Jpb3NfYXR0
cmlidXRlcyhpbnQgYXR0cl90eXBlLA0KPiA+IGNvbnN0IGNoYXIgKmd1aWQpDQo+ID4gIAkJcmV0
dXJuIHJldHZhbDsNCj4gPiAgCS8qIG5lZWQgdG8gdXNlIHNwZWNpZmljIGluc3RhbmNlX2lkIGFu
ZCBndWlkIGNvbWJpbmF0aW9uIHRvIGdldA0KPiA+IHJpZ2h0IGRhdGEgKi8NCj4gPiAgCW9iaiA9
IGdldF93bWlvYmpfcG9pbnRlcihpbnN0YW5jZV9pZCwgZ3VpZCk7DQo+ID4gLQlpZiAoIW9iaikN
Cj4gPiArCWlmICghb2JqIHx8IG9iai0+dHlwZSAhPSBBQ1BJX1RZUEVfUEFDS0FHRSkgew0KPiA+
ICsJCXJlbGVhc2VfYXR0cmlidXRlc19kYXRhKCk7DQo+ID4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+
ID4gKwl9DQo+ID4gIAllbGVtZW50cyA9IG9iai0+cGFja2FnZS5lbGVtZW50czsNCj4gPg0KPiA+
ICAJbXV0ZXhfbG9jaygmd21pX3ByaXYubXV0ZXgpOw0KPiA+ICAJd2hpbGUgKGVsZW1lbnRzKSB7
DQo+ID4gIAkJLyogc2FuaXR5IGNoZWNraW5nICovDQo+ID4gKwkJaWYgKGVsZW1lbnRzW0FUVFJf
TkFNRV0udHlwZSAhPSBBQ1BJX1RZUEVfU1RSSU5HKSB7DQo+ID4gKwkJCXByX2RlYnVnKCJpbmNv
cnJlY3QgZWxlbWVudCB0eXBlXG4iKTsNCj4gPiArCQkJZ290byBuZXh0b2JqOw0KPiA+ICsJCX0N
Cj4gPiAgCQlpZiAoc3RybGVuKGVsZW1lbnRzW0FUVFJfTkFNRV0uc3RyaW5nLnBvaW50ZXIpID09
IDApIHsNCj4gPiAgCQkJcHJfZGVidWcoImVtcHR5IGF0dHJpYnV0ZSBmb3VuZFxuIik7DQo+ID4g
IAkJCWdvdG8gbmV4dG9iajsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KDQpUZXN0ZWQgb24gdGhlIERl
bGwgbGFwdG9wIHN5c3RlbSB3aGljaCBJIGZvdW5kIHRoZSBpc3N1ZS4gDQpLZXJuZWwgY2FuIGJv
b3QgdXAgd2l0aCB0aGlzIG5ldyBmaXggcGF0Y2ggd2l0aG91dCBhbnkgcGFuaWMgdHJpZ2dlcmVk
Lg0KDQpUZXN0ZWQtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5X3l1YW5AZGVsbC5jb20+DQo=
