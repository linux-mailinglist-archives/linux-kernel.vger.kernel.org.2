Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60471309CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhAaO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:28:35 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:5494 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229584AbhAaOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:04:58 -0500
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10VE3gaV028677;
        Sun, 31 Jan 2021 09:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=iPTsQUI2RUewqhhN3q1wyM8tgNlRT6zS1tgiK/aqOr4=;
 b=Adc3djnFPb0EEIXyapgDNOHvxEKMVLjttVT8/1m9Tajn84w+Qg7dQ7bvAZ+tVH5MfrDm
 5wvgpdrSbyy8jDyyVuVJGREFrDWUpBUX/yveodGoqXHFV8a4auDh0TCdIahPFeFgijhz
 MlsNuBu2fdB/z1uRfDMSIGJB3Xf284uCNoqwiWDk/oIt7KYpQ7csbs7RDowmrsPmtW8o
 iS+Q3hxx7yHMsh0qtbG/2rRF1V8Vhu1NMA1RwOzWU5Xyj8hRC1F4hRDOX4mNUvWasRW0
 zsuHp7cVUbtJy6sW8MnyVI5fDjnCU9TKcZPIL3fv+vg8C/Rw3c1FXTcvGj20xyQdrInJ NA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 36d3npswrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 09:04:10 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10VDtCmA113172;
        Sun, 31 Jan 2021 09:04:09 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0b-00154901.pphosted.com with ESMTP id 36dnu0k4fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 09:04:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rw4bcf+p+Al09tOnAronzO6ddP0vE0mx168LMoJPJpWMbmiLSIIeKvI+DQqhpGIZkz/GMRn4Sn9d+1dv5oAIHybU6MizAYKoAB0w140KqtPLPuYoLqeL9OSuJAYPdcvhvqcKfeAaee2e3IlQh9l6cN2OzGrCUoT2OycNztMUFWpQf1hIdT8BJC0ugAnQfpdogXdScuc8wGvc08lWo6+bczlPDoQYfE7P0Btua5vTjEO7k4w8TDmvFGvTXl4JSMajjDKD4wnGzJW+U9ApNOvM/wpxlL3NGO3BgzRLhrd5gW2Ax6ZHTqtkDCZF+AmkWOrucTOgwaRdv11Pt5uIvsU2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPTsQUI2RUewqhhN3q1wyM8tgNlRT6zS1tgiK/aqOr4=;
 b=enlXHSw0m1zpn4Dwz/AHW84SAl6z41LLzge8P2UwIY1dv4SoSLFy4FmpI74Tx9VdalGBTDS3GGEZz68pViDf84PDA4s2KomQ2fgepQlWCSLPy18M/4SUB3FASCi5vVkpPec1s0l8ReU7Fh2gz2GdbOmCC5gyj2Ng/7ydZHusb4OMMlbx3tOIGhOVFEGYfLekxxxHi870wdYzM/LYquGYB/g12icYNLH7fe+yfieUzoTMobsVoBIotzk31Brex1gOuMyjswvpaxeqDy8zK5v66wGF7BWdJe3VyHX4m5RPvacQp3LtnixTIRWLRfddnCavZYwyzmoNyFHz2bw8id5FIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SA1PR19MB4926.namprd19.prod.outlook.com (13.101.59.210) by
 SN6PR1901MB2159.namprd19.prod.outlook.com (52.132.117.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.20; Sun, 31 Jan 2021 14:04:07 +0000
Received: from SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50]) by SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50%6]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 14:04:07 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
Thread-Topic: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
Thread-Index: AQHW9mP0cWNChGE38Eu6VwA6sJM74apAtSwAgAERnVA=
Date:   Sun, 31 Jan 2021 14:04:07 +0000
Message-ID: <SA1PR19MB49263EE7ECF0D06962BE00ECFAB79@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <20210129172654.2326751-1-mario.limonciello@dell.com>
 <0da9ca30-53b1-8d34-4fc7-62edb6423b26@redhat.com>
In-Reply-To: <0da9ca30-53b1-8d34-4fc7-62edb6423b26@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-31T14:03:57.7424227Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=210d4a10-71e2-4c9b-9d0d-27c631b90c65;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d95cbe2-f9b0-4347-464f-08d8c5f11341
x-ms-traffictypediagnostic: SN6PR1901MB2159:
x-microsoft-antispam-prvs: <SN6PR1901MB2159D4EC47D22FD742EBB193FAB79@SN6PR1901MB2159.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7qL+dxDGDGqO6p4GyvCidaJPPQcLjKnGaihn5oCtcZU1bBNrKG/5Yqx5+v1g/FtlpbBAIB5elk4Er2WmS4TjCe81+DobZTAzJfwISMo7ewKEiuwWEj+Pfvkb+jESHT29PdolbDNw4wXIpHrrkffTKug5DyDo8FXY0GXCf5Fv1wmJYt7r51a0HYMrjSzGYlU6eRn+KNXUJ2bhoCT9wdzTVe/bfB27XXoCxxfuQJnfLELqK1ypQo0njlt358tPAXlnLNzsOwA4VN/LqCNRDmPNQOjeti+z9kv9lYLZ2wd/S9kwjxEZS7Ub+6BILcmR/IfzbJt5htI+svaydtW4komXwolqOnMS3aZKOQXjpuahkvCqLM26ko29+fuKO3Bw5zFf/mFTfyYPafLecz66ICKt8WPSYr6W/O2v/dRXjCfjBOnB6S8K6y2la0M/vW6fhCVbtJ2odUT/1/WOgwHPTQlBBQ9UOFlqbdrkm9M/XLtGtOyGGOxl9UqCy4dOqpC0lXrIiMo6FwaNF2QdKBbycZSzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4926.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(86362001)(71200400001)(53546011)(2906002)(26005)(186003)(4326008)(64756008)(66446008)(66476007)(66556008)(76116006)(8936002)(66946007)(83380400001)(478600001)(316002)(7696005)(54906003)(786003)(52536014)(33656002)(110136005)(5660300002)(8676002)(55016002)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?clYyU3NDbFovMXM4THg2dWd1MjdMUXlibGtjMUY3THp2Tm9OUWRHKzZMUlEv?=
 =?utf-8?B?QW5aNW54d3FoTGdiNjZiWFRtbThwK3ZoL3B0ODlJMklwQnN5bFdvcytZZzFz?=
 =?utf-8?B?VUlJMFNaMC9LVnpjT0NKbmxzQXp3M0RmVjRLOXZLRkZYS3Z1QUxqWFIxVFZm?=
 =?utf-8?B?alZkSXpKRTJRWTZPcEFsOXdBSXdMTXVGcFBmL3RvdGR5T1lqVzBLWk1aNzM1?=
 =?utf-8?B?MjcyVXF1d3d4Y2ZkNHQ2RzBnZlI2b3FHYnFLazdDRm1YeE41M2xNNG0zakUw?=
 =?utf-8?B?SllwT29wVyt6SHBudXhHQVdhOGJpbVVyRkpOMDBPTXdOTGhMbjRPQTdZc3ls?=
 =?utf-8?B?dCtCTm5TVllzUzI0V3VhWDBkOHR3T1ZHVlF0Q0k4cTBMZXZidExmV2hkSTg5?=
 =?utf-8?B?OC9Wa2ZkcXhBb05jMTN6a25FUHlsN2ErRG0zemlNVnBaR2F2cEhhcS9CRVFm?=
 =?utf-8?B?VXJvdDJxTE4zZzBPcFpKeTVnRTBKNUVJUXlycFg4MlN6TTE1TlZTd2QvMkhQ?=
 =?utf-8?B?My9QSTRGOHg1YzE5SThtTS9xck9OK3VOMzRXTTdlTFB6Q011N1FROEtqN3R6?=
 =?utf-8?B?VjFEOHM2TDVzOGFCTXBSNnludGp4Qk8yUXhLamg3dEFnTCtmTWQ2ZnoybnBn?=
 =?utf-8?B?d1FCOU1NelgwWFRZZEQ4QXlNa0NHemdEa25IZ1U0Y1ZwYm5hZ21SV3RtSm1K?=
 =?utf-8?B?Y3ZVYkIySXhpMC9GYWVBVXlZWGFjbEQ4UXJCU2dCdDN6ZXJrM2JNUEFDZWhz?=
 =?utf-8?B?ZnhxSy9reVNzQmtUcjlqdGpqVmphdkVDSmcxbGZWdHRGK0k3cEtJbjV6MmVU?=
 =?utf-8?B?eEswSFNhdjQrN2dYR1BucGVtNlBqVU1jdGxVQ25JR3NMa2RBSXExSnhNQ0hD?=
 =?utf-8?B?YnBVRXp0Qm9WYkwwSnd0MWJLN1NUNnFWVy9zandzeGE5LzVZREJFSkdaZjRP?=
 =?utf-8?B?akxYMHNXcHNTTllST3FKcCtZUGN5NDZxUHRScHFGQXlxd21BajZVMitNdFRw?=
 =?utf-8?B?ZEJXUWNTcDkzaVRmS0dERkFtSzhud3FQYWJLR0FqaXFudElpV1JYaWM2QUU4?=
 =?utf-8?B?QVBIeHdQbUJXbjJPN0oxL0RHSTBPSW9rbFQvSmxsRmhWU0NOR0VlM3NPZkFV?=
 =?utf-8?B?UTQyODduNTBFVGNwNTEyRlNxMkFxSGxSQmF5YXBkNWpjZGJaZ1RRMkpnelUy?=
 =?utf-8?B?R1BwNFlkYU1ocW9CUmhXVEtiV01tQjN4R1FiSmd1WC8rMGpqSUNrMWRYWUVX?=
 =?utf-8?B?MWtGWG5DUm8rSkt4R1NjVzdtZURvQkV1VnB3TS9JdTZOTnQvOFpoWUNxQVVZ?=
 =?utf-8?B?bnUvMVJRaXJkR2pIWGoydXo3Zm90K1VhWnF5TlRTZFdpTHlhblQ4aCtmRkln?=
 =?utf-8?B?T0lkM1RJMFc1QmdvZE1IZ2grd3hsUUlwVmJDUHo4Y1RCeWxwS1BFS3BwQjZr?=
 =?utf-8?Q?qEPkLpKe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4926.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d95cbe2-f9b0-4347-464f-08d8c5f11341
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 14:04:07.0484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSYhq+bExfSMzzGcTohy7+rnaCBYLmy5FxJF/jAlgmpdW13CLa2Nm/LDR6BzoH7yG89xLmphpU3fH5dUsS4vVV5kOxRzuFtzwceGrDkFTNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1901MB2159
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-31_04:2021-01-29,2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310079
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEphbnVhcnkgMzAsIDIwMjEg
MTU6NDQNCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbzsgTWFyayBHcm9zcw0KPiBDYzogTEtNTDsg
cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gcGxhdGZvcm0veDg2OiBkZWxsLXdtaS1zeXNtYW46IGZpeCBhIE5VTEwgcG9pbnRlcg0KPiBk
ZXJlZmVyZW5jZQ0KPiANCj4gDQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4gDQo+IEhpLA0KPiANCj4g
T24gMS8yOS8yMSA2OjI2IFBNLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gPiBBbiB1cGNv
bWluZyBEZWxsIHBsYXRmb3JtIGlzIGNhdXNpbmcgYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UN
Cj4gPiBpbiBkZWxsLXdtaS1zeXNtYW4gaW5pdGlhbGl6YXRpb24uICBWYWxpZGF0ZSB0aGF0IHRo
ZSBpbnB1dCBmcm9tDQo+ID4gQklPUyBtYXRjaGVzIGNvcnJlY3QgQUNQSSB0eXBlcyBhbmQgYWJv
cnQgbW9kdWxlIGluaXRpYWxpemF0aW9uDQo+ID4gaWYgaXQgZmFpbHMuDQo+ID4NCj4gPiBUaGlz
IGxlYWRzIHRvIGEgbWVtb3J5IGxlYWsgdGhhdCBuZWVkcyB0byBiZSBjbGVhbmVkIHVwIHByb3Bl
cmx5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxp
bW9uY2llbGxvQGRlbGwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9k
ZWxsLXdtaS1zeXNtYW4vc3lzbWFuLmMgfCA4ICsrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLXdtaS1zeXNtYW4vc3lzbWFuLmMNCj4gYi9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni9kZWxsLXdtaS1zeXNtYW4vc3lzbWFuLmMNCj4gPiBpbmRleCBkYzZkZDUz
MWM5OTYuLjM4YjQ5Nzk5MTA3MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni9kZWxsLXdtaS1zeXNtYW4vc3lzbWFuLmMNCj4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni9kZWxsLXdtaS1zeXNtYW4vc3lzbWFuLmMNCj4gPiBAQCAtNDE5LDEzICs0MTksMTkgQEAgc3Rh
dGljIGludCBpbml0X2Jpb3NfYXR0cmlidXRlcyhpbnQgYXR0cl90eXBlLCBjb25zdA0KPiBjaGFy
ICpndWlkKQ0KPiA+ICAJCXJldHVybiByZXR2YWw7DQo+ID4gIAkvKiBuZWVkIHRvIHVzZSBzcGVj
aWZpYyBpbnN0YW5jZV9pZCBhbmQgZ3VpZCBjb21iaW5hdGlvbiB0byBnZXQgcmlnaHQNCj4gZGF0
YSAqLw0KPiA+ICAJb2JqID0gZ2V0X3dtaW9ial9wb2ludGVyKGluc3RhbmNlX2lkLCBndWlkKTsN
Cj4gPiAtCWlmICghb2JqKQ0KPiA+ICsJaWYgKCFvYmogfHwgb2JqLT50eXBlICE9IEFDUElfVFlQ
RV9QQUNLQUdFKSB7DQo+ID4gKwkJcmVsZWFzZV9hdHRyaWJ1dGVzX2RhdGEoKTsNCj4gDQo+IEFs
bCBjYWxscyBvZiAgaW5pdF9iaW9zX2F0dHJpYnV0ZXMoKSBoYXZlIHRoZSBmb2xsb3dpbmcgZXJy
b3IgaGFuZGxpbmc6DQo+IA0KPiAgICAgICAgIHJldCA9IGluaXRfYmlvc19hdHRyaWJ1dGVzKElO
VCwgREVMTF9XTUlfQklPU19JTlRFR0VSX0FUVFJJQlVURV9HVUlEKTsNCj4gICAgICAgICBpZiAo
cmV0KSB7DQo+ICAgICAgICAgICAgICAgICBwcl9kZWJ1ZygiZmFpbGVkIHRvIHBvcHVsYXRlIGlu
dGVnZXIgdHlwZSBhdHRyaWJ1dGVzXG4iKTsNCj4gICAgICAgICAgICAgICAgIGdvdG8gZmFpbF9j
cmVhdGVfZ3JvdXA7DQo+ICAgICAgICAgfQ0KPiANCj4gCS4uLg0KPiANCj4gZmFpbF9jcmVhdGVf
Z3JvdXA6DQo+ICAgICAgICAgcmVsZWFzZV9hdHRyaWJ1dGVzX2RhdGEoKTsNCj4gDQo+IFNvIHRo
YXQgYWRkZWQgcmVsZWFzZV9hdHRyaWJ1dGVzX2RhdGEoKSBjYWxsIGlzIG5vdCBuZWNlc3Nhcnku
IElmIHlvdSBjYW4NCj4gcmVzcGluDQo+IHRoaXMgcGF0Y2ggTW9uZGF5IHdpdGggdGhlIHJlbGVh
c2VfYXR0cmlidXRlc19kYXRhKCk7IGFkZGl0aW9uIGRyb3BwZWQsIHRoZW4NCj4gSSB3aWxsIHRy
eSB0byBnZXQgdGhpcyB0byBMaW51cyBpbiB0aW1lIGZvciA1LjExIC4NCj4gDQo+IE9yIEkgY2Fu
IGZpeCB0aGlzIHVwIGxvY2FsbHkgaWYgeW91IGFncmVlIHdpdGggZHJvcHBpbmcgdGhlIHVubmVj
ZXNzYXJ5DQo+IHJlbGVhc2VfYXR0cmlidXRlc19kYXRhKCkgY2FsbC4NCj4gDQoNClllcywgcGxl
YXNlIGdvIGFoZWFkIGFuZCBkcm9wIHRoZSB1bm5lY2Vzc2FyeSBjYWxsIGxvY2FsbHkuDQoNClRo
YW5rIHlvdQ0KDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQo+IA0KPiANCj4gDQo+IA0KPiA+ICAJ
CXJldHVybiAtRU5PREVWOw0KPiA+ICsJfQ0KPiA+ICAJZWxlbWVudHMgPSBvYmotPnBhY2thZ2Uu
ZWxlbWVudHM7DQo+ID4NCj4gPiAgCW11dGV4X2xvY2soJndtaV9wcml2Lm11dGV4KTsNCj4gPiAg
CXdoaWxlIChlbGVtZW50cykgew0KPiA+ICAJCS8qIHNhbml0eSBjaGVja2luZyAqLw0KPiA+ICsJ
CWlmIChlbGVtZW50c1tBVFRSX05BTUVdLnR5cGUgIT0gQUNQSV9UWVBFX1NUUklORykgew0KPiA+
ICsJCQlwcl9kZWJ1ZygiaW5jb3JyZWN0IGVsZW1lbnQgdHlwZVxuIik7DQo+ID4gKwkJCWdvdG8g
bmV4dG9iajsNCj4gPiArCQl9DQo+ID4gIAkJaWYgKHN0cmxlbihlbGVtZW50c1tBVFRSX05BTUVd
LnN0cmluZy5wb2ludGVyKSA9PSAwKSB7DQo+ID4gIAkJCXByX2RlYnVnKCJlbXB0eSBhdHRyaWJ1
dGUgZm91bmRcbiIpOw0KPiA+ICAJCQlnb3RvIG5leHRvYmo7DQo+ID4NCg0K
