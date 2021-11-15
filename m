Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4DF44FCC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 02:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhKOBsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 20:48:23 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:28342 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231716AbhKOBsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 20:48:15 -0500
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AF1c7JE013199;
        Sun, 14 Nov 2021 17:45:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=X4oYbvr8PRb+BPWi4mK9TIRloPugtjaP1eoplrQVU9I=;
 b=WW2LtWxFWjc0Sc1Am751iVKSXwdh08A6uvULCxywYQ0Fev92LnFMC2/AFuukwIDSCaoB
 lbWVw2te61wcfyMkUdF1FGQ5+o6f+/SWCi2arYpp9+sAlxpftoE6Uoi+w6ZXs+pXJiDL
 uVpd7Bs/fmZDNYoxl5f2ZJz5xNcr55qH3nIBWmUAIcS9tzqs36jyzXx1VZv/qIoHk/FV
 9HTpxwFSPK6V1j88TrZR67eSfZ6UoFwY2JDUBx3fcMG3QK07cLL+WAdeDDh2cWsDUYKz
 tR09N0O0zlnq6dZQ2/UQreGjlK1IxghRRU0p3CwDqpFLaduFo9W3ClDKn/3b20Nvk12z ug== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ca9h816ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Nov 2021 17:45:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYpPzBZsRFtOpMLV6Slg+smkMQ2URMJ9qAy/MlLXqFGc6Llpx2BML7qmD0IhkTh9kcVApvMefeF8LktbKDrZqCK7rRuerSQ3fghP0F+0CuCH2JiAPQR7Fv5hR/gAMYHN2pyn89DGuE23umy5Ng0V2+5NU1C+tjzEkJTWlNgjFE8NWuIhUIbAAAf0YDo9QaCeVANiiH1CVy6qwb7GS6K+K9ORVf7K4wrGOYsQLLRq5pZNkUe4BSZs8cH3MLD23YneginRTTeyXWmq9c7goReiZxSfBM0mEFiTEjrAvjL6gKk4pNGbocNjyRAfspzqphDn1g6BuH3TfTqqUX+DcOM4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4oYbvr8PRb+BPWi4mK9TIRloPugtjaP1eoplrQVU9I=;
 b=JEMh2GUseRK+6QdyNVOML0Wi2iirN6HBTwRuSAK4qEeXQpHkYLeWZurP6CV/WqsUBlKFB40Ywm4B2FJFbdttd4o2SDEmNCQkDb5CWb3QyYT2/I5dWMEsXuaxQfgAc22Cdr64j3JQRBZoM0wc3rf52wt8vY5j1Gj8lgL6wkWUbUwweS+G5Yt+MHcECc8HHMiOev686BcureIAmjdpznEts2YAEU+HiLDXC0kDJw+g5087zsQzVeUK6lVGVA9pJQDD54brCcPUqFaAHjaqwXiIniF/s/uqJbqplh5Tm2W3/3Z25WQO1gcrtKWX1dlfqMNwnxmcHQJ1TcBa6cfeKDyQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH7PR11MB5886.namprd11.prod.outlook.com (2603:10b6:510:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 15 Nov
 2021 01:45:12 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 01:45:12 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] driver: firmware: stratix10-svc: schedule thread out when
 there is no data reveived
Thread-Topic: [PATCH] driver: firmware: stratix10-svc: schedule thread out
 when there is no data reveived
Thread-Index: AQHX1T3ovWzV/jh7UUqnTweSTn8LYqwATlaAgAOLskA=
Date:   Mon, 15 Nov 2021 01:45:12 +0000
Message-ID: <PH0PR11MB51910BB817C175EABC209A38F1989@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20211109074613.13994-1-Meng.Li@windriver.com>
 <9ead8789-381d-2358-0c11-95b3350ca63e@kernel.org>
In-Reply-To: <9ead8789-381d-2358-0c11-95b3350ca63e@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aaccaa0-4004-474b-89ea-08d9a7d9909e
x-ms-traffictypediagnostic: PH7PR11MB5886:
x-microsoft-antispam-prvs: <PH7PR11MB5886846FB2217CB9044153A7F1989@PH7PR11MB5886.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXTEVxXuQjwH2Vr1FTpPYFZTe98hJYaxqwUNAzwGOxdE+FtDJ0C30boBsApMwOfSH/diS6puiq+L+LvcdAbbVD9EE+DGv6YrKVnKdkYdoQ2Gkp4jmJOh0OPiXggrk0DG7RDEoYzRvzaF+c16Qa6nApAWJWcbQF9eizkE3qH0jtS5Dy6XkHJc9ztqrLF/UIzk4B5USk7MiMLtL6jHlQrGPF/S4aHCws+mnhW3UPon3H9LCsnZs2kKYt3Nw5+ZfQiKj/XSiHVbRkMirJNbk9t9nEVI3ASyQgaucfqT5rvbQWObVzMTmUMcCShrfRhvcPDWkATQQtDxufd9ba3R1zifK0FJC4CtZAtHJJgAhv6qk6h/Kiil6zW8Vm8mW+UPLDWgiyZUwS0kZwYJt0CKBHEwy8h2bMERbr9ekxKVF40mJCwRl00YcQ8soLkagApFX3/lYeHhck7a8TH+NMzU/Mn7FAzcB/IGih7kTg4xUslh4AEyp/YK8jZ8OuEICzyQkql8pRCLAAoDgVm4rlwu3HOEV3MHNinVEJp9ZaSYAqbx7M2fdWOZlH6Vub2TrzFRV3BVSD7Xc3IzKd0rz6H4nhbnK9e45BYJbIyhKDAd74EkzHZefrBNRWa3jmrj/8M54+XMdJLGKDdCBek6NBTyBu0pV8VkVtGxbzHj8Y/mvLUCU8GF9mderQa5PCuK8rH0WeBzT/7SkqLbCBPb+2wFLMg5Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(8676002)(110136005)(55016002)(4326008)(122000001)(5660300002)(53546011)(33656002)(76116006)(66476007)(66446008)(64756008)(316002)(66946007)(66556008)(8936002)(6506007)(38100700002)(83380400001)(71200400001)(52536014)(86362001)(7696005)(508600001)(9686003)(2906002)(186003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGxOMndqMmtBdnRLYVl5UVhjRmdsc0dHblF5UWFlQWp1ZXJUNEhLdGdBTlVu?=
 =?utf-8?B?cDJYVkFZZ282TEd2NlNRTnFwWlV0REhNeUkyTEFnbjk1Z3NZTmJ0MkhiMjlG?=
 =?utf-8?B?clNqSkt1T3VYOG9MbnNEU0IxVmF1UEpiYjJ4L1B1L2hhSDdnSjV4M2Z1YnRp?=
 =?utf-8?B?T3JvZlErdE9TZG5tamRZSUl4Skl4dWhsNElYY3JqTVIzdElOcEllWjhoTjJM?=
 =?utf-8?B?eXZTZXFDb3dqeUlSK2pGSVhqK3dENytGOW0zVzRPMWp2citCWlpSYWM1LzQx?=
 =?utf-8?B?MU9KTzQ0d0lMZmlBdnEvRTlQc3QwRnVkUG03UGVoUEtUblNEMjIwVGRnM3do?=
 =?utf-8?B?cm0veHRiWlFoZUQzdGVsY1JvMHlUT2R1TlhBL3UvRlNXQ1pSZGxrNXFVb3Vp?=
 =?utf-8?B?bGhTMms3Z082NlBDelRPcTRoczBZbTFHUHBkd3BuK2dOSzV6Y3J4UFBsREhZ?=
 =?utf-8?B?UGpKNDJhNWxDcGF4ZlI4dlJlc3pnOGd2eTE5ZElNQXZGNDBhRDM2TjNScHdl?=
 =?utf-8?B?VnV6cUwwLzQ2RndBNy9vTmV6REk3MWZ2VHlpcVVud1BTMnJONTdZUWorbHJQ?=
 =?utf-8?B?STQwanhBRlh0YU02YVNuazFKT0V3VVE4TTU0dW5uTjNzT3dIZ1laSHZjQ2V6?=
 =?utf-8?B?MkEvR29tK2w5azgyYUpYV0pyUlR1OWxGTUNTdENnWjFWdHpBRnZPeU5Db1Jq?=
 =?utf-8?B?WHg3aVNEUVlxbmxVY2loYXdQMXRJLy80LzlKSWdXaW1IUVlXZ3pjemhzUHQr?=
 =?utf-8?B?OFJmU0p1TWJkaUJuVlZyZTFTMExlL1c0dXRIOUVIZkEyYUMxSmxVYnJWMVRj?=
 =?utf-8?B?WTQvSFJmUVpNUHVBZkp1WVQvcFp3aW9xa0dsM3Q4MUVreFV3V290QUx6RS9Q?=
 =?utf-8?B?Q2hQNU1CdEpNRUZMeEd4emZGbjdzeGNjSGJCUmVxOExRUlRxRUxpY2Nmb1dC?=
 =?utf-8?B?UW5maDhnbWdJdmpKTXFzeUJPZTJwRmJxRnVjamIvVzBnQWhzelNQV2grcEd3?=
 =?utf-8?B?OWVQWkZOS1U3WTM2eHlrbUFpTGZlTnlKY1l4ekJXa1ppSHhSdENsUjA2Vldy?=
 =?utf-8?B?ZzVneVN5bFBoZEU0K2VPS2lveXJkYk5ZM1UzRDhIV083b2d1dTYxQ0dxdEEy?=
 =?utf-8?B?OUh1MlQwOVlZQ2lNREgxTWVUVkJsZi9EYVdrODFGczFZOXFvQnZsMUNmMUsx?=
 =?utf-8?B?TFJSMHVmbW5odkpoalVuaTMyVW5lUDlNOEZ6NzJWbVFOL2F3RVQ5ZEd4cDVz?=
 =?utf-8?B?SlUrTnZoZ2xmN3JtaWNsSmh5MlZ2Y0FNcFNiM2wra1gxa3k1SWh2UHRONit2?=
 =?utf-8?B?ZmdOVEpVSEZlRWtZMEVvelBNTGc0TjArNWN4Z01qTFRwanVPRHpOWmN0UHk5?=
 =?utf-8?B?SUpaNW01WEZ4bWVWcHowRDVBaUk3MzVpckwrTXJZU0xHb1hQMDlUNW9wRG5i?=
 =?utf-8?B?eFBnREx5R29ya0wzTjJVOEEyMDFEWEwrbDdvRWxxQ0FyM085SEpYSkN2ZjVV?=
 =?utf-8?B?U1FZRUZUNXYyQzZET1JWMXowbEVOajhUOG9ockVKQXNzeGdQQXo2MStwbTZ3?=
 =?utf-8?B?M29qeURSWDl6VGZoMTlESUJVY2NpVk96ekdXd0Rac2VkZWhTTmFmN2Izc2RL?=
 =?utf-8?B?RVNCMXdMMU4rQkxhb0Y0ZzY2YXgrbUFpRExrZFF3bEdBVm1FWVptNEFWbHh4?=
 =?utf-8?B?UjFaQ3h2c3RDSGc1R1dlNWhzSlhSYUU3cSs5amt3a245SEVSUmhFbXAvNzVM?=
 =?utf-8?B?N25ZKy9oVk5TWm5TeHlEUHBldjYvZEN4ckZSSVB3ZVNRVk9Held0Nm5HRUJL?=
 =?utf-8?B?MEwveXJFaU9xWUk4ckFRS2RjWll0Q0xaOXhqYXFCMUd5RHY3TFd3N1ptQm84?=
 =?utf-8?B?MjJFMkhmZUd6UmhKL0FueTUrUEhTdmRZZDYxNEhCMlFmbCtrT0tXZTdYZWt6?=
 =?utf-8?B?bUdjVmtuc0Eya1IvOUpPdGRYZVFFcFVpTEVwNzhpVnFrVUVDT2ttYUlTMWw5?=
 =?utf-8?B?b2djUGhNVW5vc0RNTUVUOXg0WUVZTzBWeTZwY1JOTjgvZFduV3pQMDBlR3Az?=
 =?utf-8?B?VklQaGlsM3hBN3ZyYTdnd0lEbE9oM0NFK3U3OWt4UlBMUXlMTlQ3Wjk4Q3Vn?=
 =?utf-8?B?SzM3VmFnWURGQmpQdmx2MytleEFyQUcrb3IwdEJIYU1qSWMxVTBreVc4OFIz?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaccaa0-4004-474b-89ea-08d9a7d9909e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 01:45:12.2650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MF5N/j1wFs4SAC3fU36KlhsLQ/5UYL3VNg/9rPDu3INAXxSoHwEiJEx4NrfVlR1MI9BvJFOPFpzBETkwwqR3Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5886
X-Proofpoint-GUID: QITkFiEBL9GrkVRhoqqB38lNnOKPk5NK
X-Proofpoint-ORIG-GUID: QITkFiEBL9GrkVRhoqqB38lNnOKPk5NK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_01,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111150008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGluaCBOZ3V5ZW4gPGRp
bmd1eWVuQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAxMywgMjAyMSAz
OjM1IEFNDQo+IFRvOiBMaSwgTWVuZyA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPjsgZ3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gZHJpdmVyOiBmaXJtd2FyZTogc3RyYXRpeDEwLXN2Yzogc2No
ZWR1bGUgdGhyZWFkIG91dA0KPiB3aGVuIHRoZXJlIGlzIG5vIGRhdGEgcmV2ZWl2ZWQNCj4gDQo+
IFtQbGVhc2Ugbm90ZTogVGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRk
cmVzc10NCj4gDQo+IE9uIDExLzkvMjEgMTo0NiBBTSwgTWVuZyBMaSB3cm90ZToNCj4gPiBGcm9t
OiBNZW5nIExpIDxtZW5nLmxpQHdpbmRyaXZlci5jb20+DQo+ID4NCj4gPiBJbiB0aHJlYWQgc3Zj
X25vcm1hbF90b19zZWN1cmVfdGhyZWFkKCksIGZ1bmN0aW9uDQo+ID4ga2ZpZm9fb3V0X3NwaW5s
b2NrZWQoKSBhbHdheXMgcmV0dXJuLCBzbyB0aGlzIHRocmVhZCBjYW4ndCByZWxlYXNlIGNwdQ0K
PiA+IGV2ZW4gaWYgdGhlcmUgaXMgbm8gZGF0YSByZWNlaXZlZCwgYW5kIGNhdXNlIGNwdSBpcyB1
bmRlciBoZWF2ZSBsb2FkDQo+ID4gc3RhdHVzLiBTeXN0ZW0gcGVyZm9ybWFuY2UNCj4gDQo+IGRv
IHlvdSBtZWFuICJoZWF2eSI/DQoNClllcyENCg0KVGhhbmtzIGZvciBmaXhpbmcgdGhlc2UgdHlw
b3MuDQpJIHdpbGwgcGF5IG1vcmUgYXR0ZW50aW9uIG5leHQgdGltZS4NCg0KUmVnYXJkcywNCkxp
bWVuZw0KDQo+IA0KPiA+IGlzIHBvb3IuDQo+ID4NCj4gPiBUaGlzIGlzc3VlIGlzIGludHJvZHVj
ZWQgYnkgY29tbWl0IDdjYTVjZTg5NjUyNCgiZmlybXdhcmU6IGFkZCBJbnRlbA0KPiA+IFN0cmF0
aXgxMCBzZXJ2aWNlIGxheWVyIGRyaXZlciIpDQo+ID4NCj4gPiBUaGVyZWZvcmUsIHNjaGVkdWxl
IHRoaXMgdGhyZWFkIG91dCB3aGVuIHRoZXJlIGlzIG5vIGRhdGEgcmV2ZWl2ZWQsDQo+ID4gYW5k
DQo+IA0KPiBzL3JldmVpdmVkL3JlY2VpdmVkDQo+IA0KPiA+IHdha2UgaXQgdXAgYWZ0ZXIgc2Vu
ZGluZyBkYXRhIHRvIGl0Lg0KPiA+DQo+ID4gRml4ZXM6IDdjYTVjZTg5NjUyNCAoImZpcm13YXJl
OiBhZGQgSW50ZWwgU3RyYXRpeDEwIHNlcnZpY2UgbGF5ZXINCj4gPiBkcml2ZXIiKQ0KPiA+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogTWVuZyBMaSA8TWVu
Zy5MaUB3aW5kcml2ZXIuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9maXJtd2FyZS9zdHJh
dGl4MTAtc3ZjLmMgfCA1ICsrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2Fy
ZS9zdHJhdGl4MTAtc3ZjLmMNCj4gPiBiL2RyaXZlcnMvZmlybXdhcmUvc3RyYXRpeDEwLXN2Yy5j
DQo+ID4gaW5kZXggMmE3Njg3OTExYzA5Li5kZGI4NmQ0NDE3MjYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9maXJtd2FyZS9zdHJhdGl4MTAtc3ZjLmMNCj4gPiArKysgYi9kcml2ZXJzL2Zpcm13
YXJlL3N0cmF0aXgxMC1zdmMuYw0KPiA+IEBAIC0zNjUsOCArMzY1LDEwIEBAIHN0YXRpYyBpbnQg
c3ZjX25vcm1hbF90b19zZWN1cmVfdGhyZWFkKHZvaWQNCj4gKmRhdGEpDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBkYXRhLCBzaXplb2YoKnBkYXRh
KSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmN0
cmwtPnN2Y19maWZvX2xvY2spOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICBpZiAoIXJldF9maWZv
KQ0KPiA+ICsgICAgICAgICAgICAgaWYgKCFyZXRfZmlmbykgew0KPiA+ICsNCj4gPiArIHNjaGVk
dWxlX3RpbWVvdXRfaW50ZXJydXB0aWJsZShNQVhfU0NIRURVTEVfVElNRU9VVCk7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsgICAgICAgICAgICAgfQ0KPiA+DQo+
ID4gICAgICAgICAgICAgICBwcl9kZWJ1ZygiZ2V0IGZyb20gRklGTyBwYT0weCUwMTZ4LCBjb21t
YW5kPSV1LCBzaXplPSV1XG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgKHVuc2lnbmVk
IGludClwZGF0YS0+cGFkZHIsIHBkYXRhLT5jb21tYW5kLCBAQA0KPiA+IC04NjEsNiArODYzLDcg
QEAgaW50IHN0cmF0aXgxMF9zdmNfc2VuZChzdHJ1Y3Qgc3RyYXRpeDEwX3N2Y19jaGFuICpjaGFu
LA0KPiB2b2lkICptc2cpDQo+ID4gICAgICAgcmV0ID0ga2ZpZm9faW5fc3BpbmxvY2tlZCgmY2hh
bi0+Y3RybC0+c3ZjX2ZpZm8sIHBfZGF0YSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVvZigqcF9kYXRhKSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZjaGFuLT5jdHJsLT5zdmNfZmlmb19sb2NrKTsNCj4gPiArICAgICB3YWtlX3VwX3Byb2Nl
c3MoY2hhbi0+Y3RybC0+dGFzayk7DQo+ID4NCj4gPiAgICAgICBrZnJlZShwX2RhdGEpOw0KPiA+
DQo+ID4NCj4gDQo+IEkndmUgbWFkZSBhYm92ZSBzcGVsbGluZyBmaXhlcyBhbmQgaGF2ZSBhcHBs
aWVkIGl0Lg0KPiANCj4gVGhhbmtzLA0KPiBEaW5oDQo=
