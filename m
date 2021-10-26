Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48A143B2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhJZMxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 08:53:46 -0400
Received: from mail-eopbgr1410122.outbound.protection.outlook.com ([40.107.141.122]:38498
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233805AbhJZMxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRTVonWCeVgoEJo4DtRUU/yJWA03FDOtyijKlVdqPmrx5Gux/PaPFt4/RahkCv9YGIZd/Hx2PFVvv30FSk8Hvf9WeCADRc94NCRFCuaCiEXz/PZB9eCR3c3zCb22JzpZpSaQIUGk+RZBwchPauwi5cHJwnncIyHlPVOYzqs+gIIZB338YaR76aKnxtVwZX6UTklQTsZsl/FYUFzbvnUuTshxEWPttmrq4B8eeEfaGqZwEo3dCxEZtDvQutheLUkCnZcE5bO98RSZeFPtMWXoVNKYcRc6XEMjzM7uMy2k8aRpSmHlSzAro405b3/j82liUy49P3RXzAZVWX/gmMca5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goSpCFQv8qymWitxtxVItKoZ6dV1rucnjIgVOvkswrM=;
 b=JHFu4z/LX7f6XDg4MsTtOmlIEtPNBzVQ/WpG8z0ds787Dx1+8u0a+ZEoGs7uQHa/GVWORp9XYyFb2S/khYg2ZCps/fDPcM9lE1E4EmTmAviyq1DZzwLLeDkDxMYyjP5Nef0KkwQMXbcU/2brWZGjKwDsEtc4gk5PmkbQpDPCkKOUet7avbcrmGJl7DM9K8qUzJnJDGNhL6vGH6VRggTlFK3WfPPa4Xyv5OU+387M2lP4TuoazdsKTr8BWpDw7MV9z9o0umIRw7PCyOGEJB3d9x0wgbnDbp51/pa8jaNnD2t2mdEUAryT79WOfQx+ALk4hQ1nXRpYWpWJflzoDk1zoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goSpCFQv8qymWitxtxVItKoZ6dV1rucnjIgVOvkswrM=;
 b=SdYDOTk9trZUtFkkA6h3CADGuMmuwpewBvb07a6IShvzOQxUy9dhZD4ONk7Ojw1FzvVf7+cSerMCmI+TgzMq6syTV3CflkGU6yWvYSxhh1pFLLoax4yh5VTQYL/3END7sr+kQGhsL/J9NBicUZo9ZYYlIRMro3i/N7pewNIZnqU=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB0928.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ae::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Tue, 26 Oct 2021 12:51:18 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 12:51:18 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBzb3VuZC9pc2EvZ3VzOiBmaXggbnVsbCBwb2ludGVy?=
 =?gb2312?Q?_dereference_on_pointer_block?=
Thread-Topic: [PATCH] sound/isa/gus: fix null pointer dereference on pointer
 block
Thread-Index: AQHXyMRq8B3kaI1rJkaKNTp1IyLQDKvkzJSAgAByJzA=
Date:   Tue, 26 Oct 2021 12:51:18 +0000
Message-ID: <TYCP286MB1188D629BAF8D3F708CDE76F8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <20211024104611.9919-1-cyeaa@connect.ust.hk>
 <s5hlf2gxr0q.wl-tiwai@suse.de>
In-Reply-To: <s5hlf2gxr0q.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd4d8887-d57f-4def-a89d-08d9987f4e21
x-ms-traffictypediagnostic: TYCP286MB0928:
x-microsoft-antispam-prvs: <TYCP286MB0928E3121F74B9FC48F05ABF8A849@TYCP286MB0928.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0AEIpxtzipSHySvbr2YkhLKO8uqJIy6ml9D0vqbO4Wg35jIGHUH6IBmpKV5L44vQBLnFa/D0kZPsQkKguv+FX1yeoMkuNpA7Zh1d9v1mu+BgExjEWIDTLe4/ucnirlhvH1mX+fNrFwoJPc1bmjAR2LcpM+PHLdmzfDBW3vKw6Pc2IB1xGoxEFmoeyc/SlwUAO6r5dYb8iZnRP6Af0xoG67KMpY59XWzHmLIOBI+HgDe2Ye25a3QyjXQ/y9+4wgUwfXdAlT62MHpCum3MgKRRsEZPC6gvG4ayQv0sP2Viyt8pMvvOmEelE2D+DboYwPV5YV4rJPT1Zgbr+mO2SGYgOn+/qUNycQT/EvX709nqXwE/fs/2fh9q1nqxeeeB3K3VFg/PfZm+8/hN9fqor/mHs0x6ETw026/IksErtJJKaKkG0/h3tvdaQYMpFfdUwsFst+Dxc7KkjuYwvjMSF9lRXLYpVvMTC0KeRjNWWtElzUGG8uMZ8Ei0+que+4STA8sZmrwagj2SgJB14ZEXutAybSZ9KwuskKS5CVjtDOGY3Qk4M82+yBQoNib28BwwAkcYVXbvzKFX6ycEWZAGU+gB64XdZ0wWBRvPVn5AQHzw9ewbiGRveIZBif3o+yjgk3idQ2rccsiQhfs4nP/+FtlB1zD0HKReceWfI7aMppS9qoVFHv0xKseZn9tcp+mHwT8XuiNsDvTSW0/Yjggx+QGfMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(9686003)(7696005)(64756008)(38100700002)(66446008)(54906003)(52536014)(4744005)(76116006)(38070700005)(33656002)(508600001)(122000001)(5660300002)(2906002)(66556008)(71200400001)(83380400001)(186003)(6506007)(8936002)(26005)(86362001)(4326008)(6916009)(66476007)(316002)(786003)(224303003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZmRoS255RVVLTk9hK2JPbFZBTk9LZ09uYk9OY0ptQTlDNTV4RUVRVUc0YVg5?=
 =?gb2312?B?S2N0TTZHS0k4Mys4QVl3YjF3MXZyM1cvdDB4cWpCeTl4eWk3TnZmMmY5NGxk?=
 =?gb2312?B?V0FwbUlPWDhRcTBmdVB3czdpMkR1UmZpUERBMWxLcm42QmlmZnNIUS9NNzBW?=
 =?gb2312?B?N25RN3lCaklmdDZwYno3RXl5bEFKYTJySGhPWStRM2ZWclU1QVVRZFM2NlVw?=
 =?gb2312?B?TjBSUWJkaFYvMzZUMG0velNFMXFxRHJBdm0vTTBlelpRVUtzMGJWb2NuTWV4?=
 =?gb2312?B?M0ROUng0dnpwdVNoYUN2OEhZcjRpQUxSU1FqSCtqQ1dpQnQ4YXFSOVBESExP?=
 =?gb2312?B?UmRDUWVDZW9aSVNFTmw4eEl6VS9ZTHlMQjdVdUpaQm5CanVoWk11eW4zM1BV?=
 =?gb2312?B?YWdPUFE1M2prQnp4ZkpUNVJUNzB5eHVoTXEyMmNVbm5WMDQvQmUyREd1NWM3?=
 =?gb2312?B?MDBmaTVtRzg1N1Z3M1o3YkYrcG04RG5saXQzVVJiRmROMTdIRU5qTllZL0JN?=
 =?gb2312?B?ZktOT3RjeTJWOFBBaFVyTUdDN1pIL0RqbjcrL1pvZ0ZPa2orNFAyazhBL3Nt?=
 =?gb2312?B?WXA0R0RtTnQ2SnBkdjNydjM5c3BZNXhQZVBzSUFXaTZMVDIzYWRpMEthR2NL?=
 =?gb2312?B?aDcrSXpHSzBSU2tQYmxhTzZITUhIdGJiVlloZW5JNUl0a3ZiU3lrSTRvT1VW?=
 =?gb2312?B?TDg1aEJQNUxtNm8rby9sV1kxWVVNcXhFbHJkVWhGMURaY0NWdHQ0WW9BcExI?=
 =?gb2312?B?R25WZ1JsM1dKM1poRVBKY1c2MDd3Sm1Ub3N0cmxhWEN4Q2s3cEVTeTA1Q2VU?=
 =?gb2312?B?UjZQQXEvWjJ2eGo3NGJiMy9HcEpEVG9aVmJaVzRCaGI1M0FEODRQQVkxS0l6?=
 =?gb2312?B?STdCd0NFWkxUd1Z5R2RnbjBUUGtVMFAwOGhGVTZwMmluVDJwQ0U4Y3k3V3JX?=
 =?gb2312?B?SU5CMmp4ZHl1YmtFM2wvb3dBemliY2dHZWtDMzZvS09GVk04Z1gxaHM5ZkZq?=
 =?gb2312?B?N3NxakZRSWRta213bS9RMmlQNHNFM2hybG5NQjV4eEFPSHJFbHZ6QVExM2Iw?=
 =?gb2312?B?YWIrclNGeG1UUlY1aXRMdjJDbzBwei80OGI2OWgzeGV5ZExOaXg3NlBPcXRK?=
 =?gb2312?B?R0FGVEdJOFB6eDQxVEp2QjY4KzFWRzRoa0JzaGhMTWpTZWx4ZUJWQkd5eERQ?=
 =?gb2312?B?SGNObHU0bEF6alpxMVNZc2wrd1E1RmZiTFNxRVdFQThkL2krZW5aSGdGOGpY?=
 =?gb2312?B?cTdLa3AxVkZrZ3crV09oUjh4VHAvTzJHOWEwZjVxS1NEVzR4Q284eTR1YjV4?=
 =?gb2312?B?MEcyRjdjSEdVaWdxTWlBRys4dkhQN28zS3gwc2MzVUR4NDQ3TVdmMi9yTnp1?=
 =?gb2312?B?SklYS3J5ZkpRZUNtdXAwR1lxaVdibEk4VWVaRVlTQkwyTklkL1UwSWlGV2FB?=
 =?gb2312?B?eExoWjJlUVM5SVRwWmprQjhJZ1g5blU2SlJva09qcENTQXMxQytZRTFtNU1E?=
 =?gb2312?B?S0FoeFVkdXM0aGhES1U2QTRvVFVLUmxLZTgvTGR5aXBUc0Z3VHR6ZzgzRG5r?=
 =?gb2312?B?R1k3N1BmQ1pZVFo0T1pSaEtoZzVveTIzY0dmUXgxcTNxV1BySlA0SjM2MGE3?=
 =?gb2312?B?QmRhZFM1NGxqQ1pBUjdCd2ZtOC9NOVFvc1A4VDBWckpRL0JETExJcXRJOTlE?=
 =?gb2312?B?SHFUcC9pVndocE1hU2JtMVFsVWtHRzVEMWFrWmJVYXBWc0JIaWEvTmNld2xT?=
 =?gb2312?B?OHo1Z09SUHk1RFd6NzhQTkpjS0UvVGJLWUMxSGdYSVo5VlhLVXJEYnpRM3VK?=
 =?gb2312?B?TVVjQmVZV0t3MkFYNmdja2czbmh5U0hzYjJnMWx5aUZGc3VCREpZS01yaWRE?=
 =?gb2312?B?MjlKT1RnWlY5UTZNMThhU1B0MGhvWkVBVjZzcHdlNi9tMnVuODU3UUNJZ3VG?=
 =?gb2312?B?ZjhkRWhLWFVhZFdJR1dMT2pTUHYxSEV1L0g5MFpMb0hVd1R6bXFhWFVFZEh6?=
 =?gb2312?B?YTh2YVpxcVlDTUVadU1EMHF4M0d1T1l2NnNldEZ6TndZNmZXaXlNQTVUZExk?=
 =?gb2312?B?UnJxdWNyMHZOb3BBZmM1ZThDVDg4bCtqZXVBUC9xWmgxMzlPQzJXSitkZTJH?=
 =?gb2312?B?VEJNQXMxd0RoT0hvMU9CT3FUaTNoN0dkZCtHMjZ1VlZ2by9VWnQycXJoT25Q?=
 =?gb2312?Q?s/tPXMEO65RTL2cXnDraxM8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4d8887-d57f-4def-a89d-08d9987f4e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 12:51:18.7408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AT90E7s2F6UTM77kwBYktBTMk1nr5plYnBj33F7rlHc08Qz1CFO6L/rVhJ85Z52Cz4ki/t0aCDEBAsKNmQfO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0928
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIHNvIG11Y2gsDQotQ2hlbmdmZW5nDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjL
OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+IA0Kt6LLzcqxvOQ6IDIwMjHE6jEw1MIyNsjV
IDE0OjAyDQrK1bz+yMs6IFlFIENoZW5nZmVuZyA8Y3llYWFAY29ubmVjdC51c3QuaGs+DQqzrcvN
OiBwZXJleEBwZXJleC5jejsgdGl3YWlAc3VzZS5jb207IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM4jogUmU6IFtQQVRDSF0gc291
bmQvaXNhL2d1czogZml4IG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSBvbiBwb2ludGVyIGJsb2Nr
DQoNCk9uIFN1biwgMjQgT2N0IDIwMjEgMTI6NDY6MTEgKzAyMDAsDQpDaGVuZ2ZlbmcgWWUgd3Jv
dGU6DQo+IA0KPiBUaGUgcG9pbnRlciBibG9jayByZXR1cm4gZnJvbSBzbmRfZ2YxX2RtYV9uZXh0
X2Jsb2NrIGNvdWxkIGJlIG51bGwsIHNvIA0KPiB0aGVyZSBpcyBhIHBvdGVudGlhbCBudWxsIHBv
aW50ZXIgZGVyZWZlcmVuY2UgaXNzdWUuDQo+IEZpeCB0aGlzIGJ5IGFkZGluZyBhIG51bGwgY2hl
Y2sgYmVmb3JlIGRlcmVmZXJlbmNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hlbmdmZW5nIFll
IDxjeWVhYUBjb25uZWN0LnVzdC5oaz4NCg0KVGhhbmtzLCBhcHBsaWVkLg0KDQoNClRha2FzaGkN
Cg==
