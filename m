Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8930D3C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhBCHFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:05:07 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:19791 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232012AbhBCHEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:04:40 -0500
IronPort-SDR: dq5HcinwWBYvOSSMevNssrJ6+vQUlPpu/O3f+Hk8/skkHEHYdUWhewDES10LZl8zOu7UkwvotE
 ZY2CK3Wd1B2CGA6MAFa3k93oRs3zJKx1mvQFiu9ASiNjfoUR/The1skU7OFR0y1UEgVWGY9PGO
 xk9oCluwe3rDXGWHXvFnWjm8AqKiDG1UxZy7DoaUIYPh9O3varUBVdNC2w1cznsytIRnk4YbQ4
 CE5nQNZiAiB8p2WVMBDsv6QGr6rvx8QeJiWxj1ZFrEQzQrtLz3HIJ8Pr2zgooYVjx6cgckhfPg
 5iU=
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="25280114"
X-IronPort-AV: E=Sophos;i="5.79,397,1602514800"; 
   d="scan'208";a="25280114"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 16:02:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEKiaU7qv3LxoxGGOZKOS1QJYLOCqzCTosp1XKu105AgF3XnS2tgwTYvUGuLqODABBn17wdefCOHGPZmDCmoUm2BSLbaaXWlf3S1+DOYa7ox5y9GQlmcm7OnyeavnweSdRibrlYyuK3OgKYIiXJKt0zWiGV+uEPtswZYJjqFUoJRgOLkLG0Yhxy6eDdk+r1+2IBNm/Ie8vxDDi2jQLfyX6c5HsHeoj05obFS4ddxmPoKCMy20YrKbocfQBs8P0r2blBO1UhCEeXB5vDQ4xEUX+h3b4jETR+2j84NTn54z1b/CF+2W8sM1B2Tn5is33CJEOsq7jC2cuehI+RB84LCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYoGPV6lu9q/g1qgfhA/gefT2snxmvawDlOmT5K0OPA=;
 b=G8cYyePSrdcR57tlKo4HSS/omcsmH+y3v6KhT730Dw+Yo3yh8BFHRVLSXfbixSat68V1lIxOVaP5t79TblHDK4Bc9WSfgvnmpa41hl/L+Ea4796dZY+DkHmmjbsCTR6EUbd+BnDofCVngyeSLOd6mEYvK3Yu5kzSPN3q90Rmo6RkxCdT8UGWDQ0bapZEfTE8pmQN+8r0AD4kRZhioQ+3b6gx7bICrpSl6dPQsNRqcSM59tdARI/d0DZWDbDFa9d4wK4i+oWY3ucDpQ7ECH/0CT6zmJRb6vEptWEqMNfrBTqjBmyUQUxr1cQ7T/Jb1ms81kEf0ZqNDy4DZVxyHcGF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYoGPV6lu9q/g1qgfhA/gefT2snxmvawDlOmT5K0OPA=;
 b=e78xTtZOmeMVMfCQ0Nt96aLpyKqZNuHOtSYWEAvUSF3JPZfHCP2n+J1jC0bgKM9AFQdsD4iNI5fVRjR0IYWeMY56FCPrzwGDZnV1IJs0vpD8UMx5zJmuX5j5s2KmKzyqmNDYUagBt2hGErZLE8AChSvi4lD7fkoU0GqF5IElBCM=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB2469.jpnprd01.prod.outlook.com (2603:1096:604:1b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Wed, 3 Feb
 2021 07:02:12 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 07:02:12 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
Thread-Topic: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
Thread-Index: AQHW+WMHTGeMdPN4T0+BYj0CxDS1qqpFEjAAgADvEKA=
Date:   Wed, 3 Feb 2021 07:02:12 +0000
Message-ID: <OSBPR01MB4600991FC47D2E5A7E013F0CF7B49@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
 <57c6b89d-e0b2-3df4-8dcf-2cc71f772cb4@huawei.com>
In-Reply-To: <57c6b89d-e0b2-3df4-8dcf-2cc71f772cb4@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 9730e6c701ba4bc0aa111395052bbbbd
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9537ff0a-b94b-4bd5-b9d0-08d8c811a175
x-ms-traffictypediagnostic: OSBPR01MB2469:
x-microsoft-antispam-prvs: <OSBPR01MB246945A9301589DE38359D28F7B49@OSBPR01MB2469.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RSXRJ3GwMOX8GVGqfQCMEmeYLBmjiyLfhyCgcHtz5HnWpzXBBKv3zeleqHB3uJN9c1c0qIBEf6PpKTK43clu3XP64NSdEjJs1FchvJSbTSt46DuzhZF6EscAW0udzXhURHcjsbKNgeq+uU6/R8qHvvzBtYGIxWLDA761Od+BqxisLL1z/EiVBMKFvPx/W+zyWhoB6P9Q17DQpuCE6gmVxYni78NiSe5fW1ikIDZ4aPNJiMvxqkT1xddXNd9srjAYTa8UAhfVBSrn6uHZwdFpfK3Cbtmwm3f1OM1CBuFMw8aLKIBHyPQsmX+xnMc3wvETQC0O46u4KH9Vt9Y7yQkd3Alogto6wWOdu1FHhBC9dw+qcMD74tHGC7KzAIgiLZJ/0B9yHttaG1RGJukeet0Q1razlVo3xBwI5YB/7S5k60noP9vXXklLsXtGbQa9QL6CsV+haF5uNOa1gOTjOKXjEJqUcotLOB4Z97x/2QViV5q/szwnMr49pB1g4CLPJha59jPfvDSrC9wclY6hzujzolqG8BbDqioWRCk18NxfaIqXBsDLFLFrzFxPUX19ZRIZKlA73JCuXum6DHduDHieBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(86362001)(52536014)(5660300002)(66946007)(110136005)(921005)(6506007)(8936002)(54906003)(26005)(83380400001)(66476007)(33656002)(64756008)(76116006)(4744005)(55016002)(9686003)(66556008)(66446008)(8676002)(85182001)(2906002)(186003)(478600001)(316002)(7696005)(4326008)(7416002)(71200400001)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y0tvMW5jdFJUSFRwMjNRMUhrYW5yc1VBQXM1Q0piOVVma1Bua3QrTUpiV2U4?=
 =?utf-8?B?NWVhL1JnaVV2Wm92dkhSbUJCL2hPak4xcEU4OXBndExKZmU4ajFpeEcybjlE?=
 =?utf-8?B?SGpMTUIwTzQwRlZFUDVBVUpqK252WFpqNDBtZjBXdGdOUVRGMGFlUVRpaldV?=
 =?utf-8?B?eG1PQXBPcWg2RzZySkVuR0UwMTlyQ0QxaVY1Yk14MW9OODFMQkVNV3ZQNjR2?=
 =?utf-8?B?VWoycjhnM1FJc3djclR3clZNVVREdjIzYy9TVGlCTmsveDJIcHRUTnFhVVIz?=
 =?utf-8?B?ZHRVRVAvNVMweWhUV1haY1pkNGNvNTZ5SDRiaExDZWZOL1ZWNzhhU3JIZlY5?=
 =?utf-8?B?UHV4QlRFL0FDZm9JQXNocHUvdElqVmxFMUFCcXdlYmFzTUMybytmZitmNWxw?=
 =?utf-8?B?c0dpSysyTHV3YllYU3ZFQ05YZEt1V1I4WDVlL2dHRWM0UUZhRHZoNFJ4T1U4?=
 =?utf-8?B?OGxHQWkxV1Rycm5ielM0VVhEV3FRdzZyUFFwT1AwU2F5a0VVTFlHcGNZM1Bx?=
 =?utf-8?B?TDgxUURUeUtud3QyNUdrZWpOZnQ4SVlZVzlveWsraHpYTzRHODVpV1dZREZu?=
 =?utf-8?B?NjFTbjhVVVBtOGFrU3R5N0lFUE9QaGxFRXl0Kzdxd3BLWkUwS0NzTEhsL2Ns?=
 =?utf-8?B?RFZpUFJZTDJXQ0tPT2lJNlQ2YWdCTWhCSG9sb3dDcWdXQlhWdHBwVUp6Yk1W?=
 =?utf-8?B?VnFuNVRDQ3ZUcEYyd1dXUDVoRWFMZmMyNFUyb3QyNEpZL0ZNd043K1lYbGxO?=
 =?utf-8?B?aVlXRERpQ2NIdHJPY00xWlJHN1JHY0dzWnBucmRBSmg4UndwbHBaRXNWUGRj?=
 =?utf-8?B?SjdSeE1ZS1JIeWI3Sm05TWZSTk5JVy90b21YM0NuaEFwL1ZzMWFEc0ttOCtl?=
 =?utf-8?B?emhaSm9NSXVJcU5mdzJkcVBOSEJJMWJLUE91NmNFcDlrNkl2WDQ0VENnS3ky?=
 =?utf-8?B?S2pMaG0wM2hsKzN4VVcyNkRxTDFOUG83NHVHdUg2S1lEQkJWbDdjN0ZwMDJa?=
 =?utf-8?B?T3VXVFovbVVmcFNNMCt4T3FFVDc2czcxUjVtVlNBMDQrNDJ0U3BEdGpVMytZ?=
 =?utf-8?B?MGJWa2tOelBEL3A5Z1I3Z1N1dnhXMVFMdzB2eUxvTXVUbGpScXo2TFFoOTVT?=
 =?utf-8?B?RW5aWmZ6WTBQbmpnQVZsNlA1cDZiMCszYTZ1U0t1MGtSc2JBaHd6WTdWYytH?=
 =?utf-8?B?clc0QVBzYzZEdFBQcWpWMGVlWTBET1ZRWDFHVmM2VUx2c0lRbDA2Vm80RXU3?=
 =?utf-8?B?SGZ3WFd5UW54bVBSV2QrdHVTZVZERkVwNHdoVDRGQ0dwWDIvVUVWR0dKbTlS?=
 =?utf-8?B?ZkQraVNyVlpvK1VqQ3BnRHpTL3Y0U293RVFtSUl4Qm9wQVRSaFUxb3JDdmUr?=
 =?utf-8?B?RmxPS0NvTGRUc0ZwdUJrUzVxdEl3YUtmU0h2VE1McExJTFMveFlPdGVvbnd0?=
 =?utf-8?Q?QLatdzlo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9537ff0a-b94b-4bd5-b9d0-08d8c811a175
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 07:02:12.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXvdN07t6jAPPNb7FhFXHzHnFXUGpmC8V9zPTEfmea4JfInY92cM2TNuNIAzS4yjK+fP+QF2W1A6lkkbFV3aWaM4md7++vr51fsMVSh3Pms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2469
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEpvaG4NCg0KPiBKdXN0IHNvbWUgdGhpbmdzIHRvIG5vdGU6DQo+IC0gcGxlYXNlIHBpY2sg
dXAgYW5kIGFwcGx5IHJldmlld2VkLWJ5IHRhZ3MgZ3JhbnRlZCBmcm9tIHByZXZpb3VzIHJldmll
d3MgaWYNCj4gZXhwbGljaXRseSBncmFudGVkLCBzdWJqZWN0IHRvIG1ha2luZyBhbnkgdHJpdmlh
bCBjaGFuZ2VzIHJlcXVlc3RlZCBJZiBhbnkNCj4gc2lnbmlmaWNhbnQgY2hhbmdlcyBhcmUgbWFk
ZSwgdGhlbiBkb24ndCBwaWNrIHVwIHRoZXNlcyB0YWdzIG9yIGRyb3AgdGhlbSAoaWYgdGhleQ0K
PiB3ZXJlIHBpY2tlZCB1cCBlYXJsaWVyKQ0KSSB3aWxsIGZpeC4NCg0KPiAtIEknZCBzYXkgdGhh
dCBpdCdzIGJlc3Qgbm90IHRvIHNlbmQgbXkgcGF0Y2ggaW4gMS80LCBidXQgYmV0dGVyIHRvIG1l
bnRpb24gdGhlIHNlcmllcw0KPiB3aGljaCB0aGlzIGlzIGJhc2VkIG9uIGluIHlvdXIgY292ZXIg
bGV0dGVyIFNlbmRpbmcgbXkgcGF0Y2ggaXMgb25seSBnb2luZyB0byBtYWtlDQo+IHRoZSBtYWlu
dGFpbmVycyAoQXJuYWxkbykgbGlmZSBtb3JlIGRpZmZpY3VsdCB0byB0cmFjayB0aGVzZSB0aGlu
Z3MuDQpJIHdpbGwgZml4Lg0KDQo+IEFwYXJ0IGZyb20gdGhhdCwgSSB0aGluayB0aGF0IHdlJ3Jl
IGEgYml0IHVuY2VydGFpbiBhYm91dCBwYXRjaCAzLzQNCldoYXQgYXJlIHlvdXIgY29uY2VybnM/
DQpJIHRoaW5rIGl0J3Mgb2theSBmb3IgcGVyZiB0byByZWFkIGEgbmV3IGV2ZW50IGNvZGUgd2l0
aCBhIG51bWJlciBhdCB0aGUgYmVnaW5uaW5nLg0KDQpCZXN0IFJlZ2FyZHMNClNodW5zdWtlDQoN
Cg==
