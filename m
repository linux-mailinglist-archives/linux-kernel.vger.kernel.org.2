Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747AD4536E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbhKPQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:09:29 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:40736 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238801AbhKPQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:09:21 -0500
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AGCm3HZ018305;
        Tue, 16 Nov 2021 08:06:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=+YjWhV0bjuYA76LQZx3ZkId58sHfhQEt5+vurHGOsZ8=;
 b=sLFINMqTzCHDSmrytEbnbdXJ2LgfMNTnfjmJYoHqEjt9AKyJavLfeNwFU/W6iDWEMaVl
 W5DEBoRcVnjNa9rrcIfpI1LGYueDeS/EF5co9nkQuihb5k3UoSPP0v9SuTD0lcBkWR/o
 E3ljJg0hciKubouZp7gpAlGnVnubKG+NROS8j831FRdRMMbCFFUVdkMH1+TYNd6a4OO4
 79mIDLvg2F/p5AGVmI0VGTUC3fgEnDV+6D5nNI3PtiS3FLO3+21IMfQSxeNVvKwFDOmb
 tva7/CKmuRnTZ+JDT+W2LixSrMvkTvVvxrd7Q98FI0rTYrcuUnNvsHx8V/1TPQ9GgoNe 9w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cbfw5hftj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 08:06:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aad6s7Tro4NPbctgDlKjsXlQtkPnJqLeTXxxO4FKmHmIuhqUZeIai9OufWLAgzkRlu2ro2cPk9sZS42QXM3JwV1dDOauT9gE4b9j5mWipVFhJT6Yv5szybNzbXiPTI6bvLtLUj7/NCOmhyGvB+qTDItvtgdT319f4K/bELJMblz3CiVzZnCI6XWikG64JBfC+yg+E8+uL7GqTwDVNAOiLnUpVOxhEKO1sfTuge0nmqBZg7/1Akho5niTj//reATvVrkBa4Uxk6vVGd4SRbB6IcGHjATEyjIlhl/KpE5z3FwR1wpVJWRqTLinZbHvaJAtno1L98caBhUm1/I3eqg+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YjWhV0bjuYA76LQZx3ZkId58sHfhQEt5+vurHGOsZ8=;
 b=MjLuRDkd/JT7PCE/hJCV2Se2Z+WePJkgRtOjk0AfVtfm2dlETdNMffGejQtr24kpXtCTURgvIiTnBr8d9TBwphPPZyFZYsZUF/2W+g5WX3UzOAAt3e6QV2POhG830nNX8M8X6Zd0fx0flKsPI8uUtn2kP/aZpVTb8x8RZ1w4VUQpaj8XX7hTnreWyPuoEsEvgpkQVlSzambD/nMdcL6oNX7mf+7VALnfd2/EPYVYydtcxuFpu6b1hvICvSgk4Qg3XTqU609AW6tn3Uryob37I0q5t29P82BtWhvemeUvKs7QrTWed+uTFTASK8OgiR6sAMKHQCMEIW3I8X6FIrOegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 16:06:13 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 16:06:13 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
 preempt-rt kernel
Thread-Topic: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
 preempt-rt kernel
Thread-Index: AQHX2th3swEitpfWC0aos9Q3CXq7i6wGDekAgAAjI2CAABluAIAABuxQ
Date:   Tue, 16 Nov 2021 16:06:12 +0000
Message-ID: <PH0PR11MB5191D2E1436F6286700007FEF1999@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20211116105424.12685-1-Meng.Li@windriver.com>
 <CAK8P3a241g2vQrfiEf_YcQ0=t5fhN0R0CrzQE5DK7XQgAGxKYg@mail.gmail.com>
 <PH0PR11MB5191FEE6D75B558D629D517AF1999@PH0PR11MB5191.namprd11.prod.outlook.com>
 <YZPQmDJ1PI+TlG7C@google.com>
In-Reply-To: <YZPQmDJ1PI+TlG7C@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e99780c-4416-4fbb-73b4-08d9a91b031d
x-ms-traffictypediagnostic: PH0PR11MB4872:
x-microsoft-antispam-prvs: <PH0PR11MB48726B79F98111539B874100F1999@PH0PR11MB4872.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VvjbaxlPT4OhoOti2Ua/wdNxM7NgiaoqwM3iPszZJiuXQA63kH0TRImJniS9Pmn5vQp73D0bZGsBYx64pd1AN3oAPu74eUo0Ld4hViVS/GmG47TJFLywID8uXBMX4U1jHu/noIfCLjsf9AXvQwU7DX43iHQIAHDqFOZ6OYAl+7PhmHpOuhwfVmnDQNPuuMf3dZxi1bYs3NY95lKVFk8tgjyufjAJq71lCaotXEbCgRRRFbsAwjipDz9mRTYYoqKYB0oyZKwJEdmDRcLuQD3ZkD25PyrpdYInf+4Vaix4gL0rJTVEA8NDEf32yJvexFQuPe8kTFzswCeb2TrujPqh0HYXDehJ8kx9nQMTQrdc0ZuHJ4Or8siatWrgZpMktFrHaaQOw3ISb0PuG62EfYhV240evAaL8wOpLgObbQQk/9JkUxuH1EXXcL2nlYeSyzmx685jAH3baG53K4uJ3wg2r+lpzRXWJaXK453B6x3gEIfDnq1fknJZ63YpP+ft5kHCcgWZdWD70rS9i1k94K+Y9hm2wqdSlphP5ZChd+2m+boh6NyTHaXL5lQxo6JuVPINg2/L6SgWp6u1kotkJ9vpUuBicI8bNLRLqdmyzvUcmpYrtyoBho94ahYfzTX7nCPqgBfYtw5XckVTkwCXvp+mdYz9ptuYNuOOS0058SocZWitY1bj1V+PC7PfScoNhH7MIbQJRvulFMkRjR7iLJhrmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(7696005)(4326008)(122000001)(52536014)(5660300002)(9686003)(66556008)(54906003)(6506007)(8936002)(66446008)(64756008)(53546011)(6916009)(66476007)(55016002)(38070700005)(71200400001)(38100700002)(316002)(26005)(66946007)(83380400001)(8676002)(186003)(33656002)(86362001)(508600001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0FmQzlSN0xWbVVGODBaT0tncStFTzdwbXl3ZGR2NzFYSEZpZzQ1dmNqdU56?=
 =?utf-8?B?MkczbzM1MmUvQzBZdmVPQldFcjRKRXZKNUdCaHp1VjVyalZKQVN0Ynk1aHlH?=
 =?utf-8?B?SGtvbkZIVXV1ZlRCUGo5UFBONTJ5YTIyOW9mRVM1NWxVK0hubmN3SHYvdjlE?=
 =?utf-8?B?MXFGcS9ubjJEQVdLanFTVmJuOEhTbVQwU3VQR3FhaTRGZkdlYzFzSEhLckFi?=
 =?utf-8?B?UFZOTHNmbjdjYlgybG53cnRINkRCOVk5WlVXQ1QwdzRqbTl2NXJkVkF2bHYr?=
 =?utf-8?B?RGFhOElNclFlK3YzTDB3N1JrNzhqV2ZCSklmU2ZxdFIzLzRya05OSW43UGZZ?=
 =?utf-8?B?U0xpSGYxSC9OaTkwZmpHMC9rSnQ4OXlyemp3MG9uMndES0k1WlhCVlUzclM5?=
 =?utf-8?B?VjEvYTB4UTdsTm1vZGh6RHRCSkhWcnZFUmQwd0V5RFRGWVVjeFBocHBDbGhF?=
 =?utf-8?B?cHRveE9KMjV0dWZDQWtTU0xxZFl5aFNwR3JHMUxHSVFIMjlIK3ZCWDJuVTBj?=
 =?utf-8?B?TkxmcnlnbVp5YURCbFFkdjdVOTRMRGNXWWNGMytVVU1jNVJWaVFJNGJNMS9r?=
 =?utf-8?B?MFR6WHAzQTdFT09zdjNFVlJXRlBzMWZPYWVEV2lTMFdJSW05ajJUNUhoSFc0?=
 =?utf-8?B?SHpGOVIra1dqMkhWVHlLa0l6OGVTQ04vVkRIQVR4UnBMY0dsYjJ4WGFTeGJm?=
 =?utf-8?B?OUxudTU1ckJLSTNPYjJRQVRUZXdXNEpkRkxxWVFlcVprdWZtbmxxcWNKbm96?=
 =?utf-8?B?QWFURTRJRFJ0cy94Q0RUYU5HUFdCL2xaOS9na2RSWHp1VDAvb29uS0oxNUZa?=
 =?utf-8?B?RzZhak9RM3ZlT0RRSXdwVzhSSkRBSnpOOTRYbzJ6RTJrOEdBaStRekFUZC96?=
 =?utf-8?B?RHE5b1BFT0plTFhVS2wvaGNkK1JQa25yenoyRUFPVDF1S3B4T3RnRysyVzNk?=
 =?utf-8?B?VWxBSFA5NEkwZmlzUUJzcVlmSlE5cFAwbCtHQkd1VWRQZEtHYzFYdlI0elhq?=
 =?utf-8?B?MDcvUmlscHBQNm8xZ21tWWxBYmpTbGx1NDZBOGxFZDlXVXNjTnZ0OW9ObHF1?=
 =?utf-8?B?RTZjOE9RMG5jb05QR2FpYkowdlZDSmE1WGx4T0dqcHBaL3dNRG1VUi9ONnhS?=
 =?utf-8?B?UDFia29NOXVnK2JPZEdZUEpibEtoN1R4U25WbHRicERHVjkvb0NpbHVhdlRQ?=
 =?utf-8?B?ZmJmOEFWUGI5elcycVVwV2VTeTNyZ2kvUjBpRDd3blF4dEJ1cGlHOWMyMFJV?=
 =?utf-8?B?T0lNblAxZ0NtbXkzcTZ3UGNTbi9vbHR0dkFlazNlV21nZjNEMVFqRUNNYnRx?=
 =?utf-8?B?NENaeFF5cmdKRUsvQ240QS9qZVlIVEJ2V0ZFbVZjVERZa3ExWGpvaEJkRkpH?=
 =?utf-8?B?K3NHd0RKK3J4aEt2VjlKaUZzMStpajUyRGJEdERVSFEvcDQrWllZZi92VjY3?=
 =?utf-8?B?aTJBUUd0djhmQjhOa24zd0g5anlDalpiWTVVNm9wOHQ5WUw3a0ZXdUdxWVhs?=
 =?utf-8?B?bEo3VkdtTnZhbkZQaHU4cGRodmVFaDNqTXpVZms3aGxwakIrUlM4aEYyc2Iy?=
 =?utf-8?B?VDFKYWNsOXZyTE8zSm84QndXL2g3Vm10YjVUb29vNzVZMlAxbEVoMUlVSWgw?=
 =?utf-8?B?Ulh0UFZlRkZJWk9BRU1xMGRDSVhBUWNqMzdnYW5jZTU5L0xtRGJtbkhUd1JW?=
 =?utf-8?B?V25FZ2RqN2lZS2hjVURKK29EbXlubGo5MnNiaHlBYml0QlVJdEFubGl1Q2ZW?=
 =?utf-8?B?TVZkNi8rTk05dXh2azN6UU9LdlUvd01oUjE0ZnZVeDMwb2V5NmVRdUgzZzRl?=
 =?utf-8?B?TGloYUxZK2lUV3Qyb1Uzd1RNWURqSDR0WDJvWDl6b3UxRlVTd0ptZ1VjU2ZF?=
 =?utf-8?B?ZnExSkNKc1gvVkJkQTRhVnFZRENpamxheXhYblRWVnEzbUtkNGQ4ZFY1N2hD?=
 =?utf-8?B?OFFSQXhQWE9teE4vcW5ZTXBPdzVrcEp1d25VdnVwYmgyM0JNVlNiSVd2UEdl?=
 =?utf-8?B?NndBRTB3NVhEVWk1aXlBZ0hsL3NnVE1JaFFrRnlENXpVUzJCVWJiQWF3dzZj?=
 =?utf-8?B?REVtQ3FZL3BoQ2pPV1U5VVpaYUk5b2lVZjZadWRnc1dDaXhoSW1jVjJTR0FZ?=
 =?utf-8?B?NnBveWQ2Wk55ZVl0NndWeExmejBmeUU0OEhVREJIVk1JOTNGdXo1UEk2V1dL?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e99780c-4416-4fbb-73b4-08d9a91b031d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 16:06:12.8898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMxEuV8GJwhJA967tlJnCRdALMTBfTfju4AmDGcN/WAkK4FNbXSA1c1GiyMi5/gVMzg6lqUAv4/vudND5vF+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-Proofpoint-ORIG-GUID: aH9PtQl7eylupP9X0gVurwi-Xt4QgEzo
X-Proofpoint-GUID: aH9PtQl7eylupP9X0gVurwi-Xt4QgEzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-16_03,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVlIEpvbmVzIDxsZWUu
am9uZXNAbGluYXJvLm9yZz4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTYsIDIwMjEgMTE6
MzkgUE0NCj4gVG86IExpLCBNZW5nIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+DQo+IENjOiBBcm5k
IEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgdGhvci50aGF5ZXJAbGludXguaW50ZWwuY29tOyBM
aW51eA0KPiBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtZmQ6IGFsdGVyYS1zeXNtZ3I6IGVuYWJsZSByYXcg
c3BpbmxvY2sgZmVhdHVyZSBmb3INCj4gcHJlZW1wdC1ydCBrZXJuZWwNCj4gDQo+IFtQbGVhc2Ug
bm90ZTogVGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRkcmVzc10NCj4g
DQo+IE9uIFR1ZSwgMTYgTm92IDIwMjEsIExpLCBNZW5nIHdyb3RlOg0KPiANCj4gPg0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE2LCAyMDIx
IDg6MDIgUE0NCj4gPiA+IFRvOiBMaSwgTWVuZyA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPg0KPiA+
ID4gQ2M6IHRob3IudGhheWVyQGxpbnV4LmludGVsLmNvbTsgTGVlIEpvbmVzIDxsZWUuam9uZXNA
bGluYXJvLm9yZz47DQo+ID4gPiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgTGludXgg
S2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
Pg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gbWZkOiBhbHRlcmEtc3lzbWdyOiBlbmFibGUg
cmF3IHNwaW5sb2NrIGZlYXR1cmUNCj4gPiA+IGZvciBwcmVlbXB0LXJ0IGtlcm5lbA0KPiA+ID4N
Cj4gPiA+IFtQbGVhc2Ugbm90ZTogVGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1h
aWwgYWRkcmVzc10NCj4gPiA+DQo+ID4gPiBPbiBUdWUsIE5vdiAxNiwgMjAyMSBhdCAxMTo1NCBB
TSBNZW5nIExpIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tZmQvYWx0ZXJhLXN5c21nci5jDQo+ID4gPiA+IGIvZHJpdmVycy9t
ZmQvYWx0ZXJhLXN5c21nci5jIGluZGV4IDVkMzcxNWEyOGIyOC4uMjcyNzFjZWM1ZDUzDQo+ID4g
PiA+IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21mZC9hbHRlcmEtc3lzbWdyLmMNCj4g
PiA+ID4gKysrIGIvZHJpdmVycy9tZmQvYWx0ZXJhLXN5c21nci5jDQo+ID4gPiA+IEBAIC04Myw2
ICs4Myw5IEBAIHN0YXRpYyBzdHJ1Y3QgcmVnbWFwX2NvbmZpZw0KPiA+ID4gPiBhbHRyX3N5c21n
cl9yZWdtYXBfY2ZnID0NCj4gPiA+IHsNCj4gPiA+ID4gICAgICAgICAuZmFzdF9pbyA9IHRydWUs
DQo+ID4gPiA+ICAgICAgICAgLnVzZV9zaW5nbGVfcmVhZCA9IHRydWUsDQo+ID4gPiA+ICAgICAg
ICAgLnVzZV9zaW5nbGVfd3JpdGUgPSB0cnVlLA0KPiA+ID4gPiArI2lmZGVmIENPTkZJR19QUkVF
TVBUX1JUDQo+ID4gPiA+ICsgICAgICAgLnVzZV9yYXdfc3BpbmxvY2sgPSB0cnVlLA0KPiA+ID4g
PiArI2VuZGlmDQo+ID4gPg0KPiA+ID4gSSB0aGluayB5b3Ugc2hvdWxkIHJlbW92ZSB0aGUgI2lm
ZGVmIGhlcmU6IGlmIFBSRUVNUFRfUlQgaXMNCj4gPiA+IGRpc2FibGVkLCB0aGUgZmxhZyBoYXMg
bm8gZWZmZWN0IGJlY2F1c2Ugc3BpbmxvY2sgYmVoYXZlcyB0aGUgc2FtZQ0KPiA+ID4gd2F5IGFz
IHJhd19zcGlubG9jay4gSWYgYW55dGhpbmcgZWxzZSBzdGFydHMgcmVxdWlyaW5nIHRoZSB1c2Ug
b2YNCj4gPiA+IHJhdyBzcGlubG9ja3MsIHRoZW4gd2UgcHJvYmFibHkgd2FudCB0aGUgZmxhZyB0
byBiZSBzZXQgIGhlcmUgYXMgd2VsbC4NCj4gPiA+DQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIg
c3VnZ2VzdGlvbiwgYW5kIEkgYWxzbyBhZ3JlZSB3aXRoIHRoZSBzcGlubG9jayBhY3Rpb24gd2hl
bg0KPiBQUkVFTVBUX1JUIGlzIGRpc2FibGVkLg0KPiA+IEJ1dCBwbGVhc2UgYWxsb3cgbWUgdG8g
ZXhwbGFpbiB3aHkgSSBrZWVwIHRoZSAiaWZkZWYiDQo+ID4gMS4gYWx0aG91Z2ggSSBzZW5kIHRo
aXMgcGF0Y2ggdG8gbWFpbmxpbmUgdXBzdHJlYW0sIEkgb25seSB3YW50IHRvIGZpeCB0aGlzDQo+
IGlzc3VlIGluIFJUIGtlcm5lbC4NCj4gPiAgICAgTW9yZW92ZXIsIHRoZSBjb21taXQgNjcwMjFm
MjVkOTUyKCJyZWdtYXA6IHRlYWNoIHJlZ21hcCB0byB1c2UgcmF3DQo+IHNwaW5sb2NrcyBpZiBy
ZXF1ZXN0ZWQgaW4gdGhlIGNvbmZpZyAiKSBpcyBhbHNvIGZvciBSVCBrZXJuZWwgZXZlbiBpZiBp
dCBkb2Vzbid0DQo+IHVzZSAiaWZkZWYgQ09ORklHX1BSRUVNUFRfUlQiDQo+ID4gICAgIE15IGlk
ZWFsIGlzIHRoYXQgaWYgdGhpcyBwYXRjaCBpcyBtZXJnZWQgaW50byBtYWlubGluZSwgTGludXgt
cnQgbWFpbnRhaW5lcg0KPiB3aWxsIG5vdCBzcGVuZCBleHRyYSBlZmZvcnQgdG8gZm9jdXMgb24g
dGhpcyBwYXRjaC4gQWZ0ZXIgYWxsLCB0aGlzIGZpeGluZyBpcyBtb3JlDQo+IHJlbGF0ZWQgd2l0
aCBkcml2ZXIuDQo+ID4gICAgIEluIGFkZGl0aW9uLCBJIGZvdW5kIG91dCB0aGVyZSBhcmUgb3Ro
ZXIgcGF0Y2hlcyB3aXRoICJpZmRlZg0KPiBDT05GSUdfUFJFRU1QVF9SVCIgbWVyZ2VkIGJ5IG1h
aW5saW5lLCBzbyBJIGFsc28gc2VuZCB0aGlzIHBhdGNoIHRvDQo+IG1haW5saW5lLCBub3QgTGlu
dXgtcnQuDQo+ID4NCj4gPiAyLiBJIGNoZWNrIHJlZ21hcC5jIGNvZGUgdGhhdCBpcyByZWxhdGVk
IHdpdGggdXNlX3Jhd19zcGlubG9jay4gSWYNCj4gUFJFRU1QVF9SVCBpcyBkaXNhYmxlZCBhbmQg
dXNlX3Jhd19zcGlubG9jayBpcyBzZXQgYXMgdHJ1ZSwgdGhlIGVsc2UgY2FzZQ0KPiB3aWxsIG5v
dCBiZSBlbnRlcmVkIGFueSBsb25nZXIuDQo+ID4gICAgIEluIG90aGVyIHdvcmRzLCBpbiBtYWlu
bGluZSBzdGFuZGFyZCBrZXJuZWwsIGlmIHVzZV9yYXdfc3BpbmxvY2sgaXMgc2V0IGFzDQo+IHRy
dWUsIHJhdyBzcGlubG9jayB3aWxsIGJlIHVzZWQgZm9yZXZlciwgYW5kIHRoZSBjb2RlIGluIGVs
c2UgY2FzZSB3aWxsIGJlY29tZQ0KPiB1c2VsZXNzLg0KPiA+ICAgICBJIGZlZWwgaXQgaXMgYSBs
aXR0bGUgdW5yZWFzb25hYmxlLiBTbywgSSBrZWVwIHRoZSAiaWZkZWYiDQo+ID4gICAgICAgaWYg
KChidXMgJiYgYnVzLT5mYXN0X2lvKSB8fA0KPiA+ICAgICAgICAgICAgICAgICAgIGNvbmZpZy0+
ZmFzdF9pbykgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBpZiAoY29uZmlnLT51c2VfcmF3
X3NwaW5sb2NrKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmF3X3NwaW5f
bG9ja19pbml0KCZtYXAtPnJhd19zcGlubG9jayk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbWFwLT5sb2NrID0gcmVnbWFwX2xvY2tfcmF3X3NwaW5sb2NrOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1hcC0+dW5sb2NrID0gcmVnbWFwX3VubG9ja19yYXdf
c3BpbmxvY2s7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9ja2RlcF9zZXRf
Y2xhc3NfYW5kX25hbWUoJm1hcC0+cmF3X3NwaW5sb2NrLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxvY2tfa2V5LCBsb2NrX25h
bWUpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNwaW5fbG9ja19pbml0KCZtYXAtPnNwaW5sb2NrKTsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXAtPmxvY2sgPSByZWdtYXBfbG9ja19zcGlu
bG9jazsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXAtPnVubG9jayA9IHJl
Z21hcF91bmxvY2tfc3BpbmxvY2s7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bG9ja2RlcF9zZXRfY2xhc3NfYW5kX25hbWUoJm1hcC0+c3BpbmxvY2ssDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9ja19rZXks
IGxvY2tfbmFtZSk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAg
ICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIG11dGV4X2luaXQoJm1hcC0+
bXV0ZXgpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBtYXAtPmxvY2sgPSByZWdtYXBfbG9j
a19tdXRleDsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgbWFwLT51bmxvY2sgPSByZWdtYXBf
dW5sb2NrX211dGV4Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBtYXAtPmNhbl9zbGVlcCA9
IHRydWU7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGxvY2tkZXBfc2V0X2NsYXNzX2FuZF9u
YW1lKCZtYXAtPm11dGV4LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBsb2NrX2tleSwgbG9ja19uYW1lKTsNCj4gPiAgICAgICAgICAgICAgIH0N
Cj4gPg0KPiANCj4gSSBkaXNsaWtlICNpZmVyeSBhcyBhIGdlbmVyYWwgcnVsZS4gIFNvIHdpdGgg
dGhhdCBpbiBtaW5kIC0gaWYgaXQncyBub3QgcmVxdWlyZWQsIEknZA0KPiBwcmVmZXIgdGhhdCBp
dCdzIHJlbW92ZWQuDQo+IA0KDQpPa++8gQ0KVGhlcmUgaXMgbm8gcmVhbCBkaWZmZXJlbmNlIGlm
IHJlbW92ZSB0aGUgI2lmZXJ5Lg0KSSB3aWxsIGNoZWNrIHRoZSBzdGFuZGFyZCBrZXJuZWwgYW5k
IHRoZW4gc2VudCB2MyBSUi4NCg0KVGhhbmtzLA0KTGltZW5nDQoNCj4gLS0NCj4gTGVlIEpvbmVz
IFvmnY7nkLzmlq9dDQo+IFNlbmlvciBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNl
cyBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZQ0KPiBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MgRm9s
bG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZw0K
