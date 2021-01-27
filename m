Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB2F305058
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbhA0EBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:01:44 -0500
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:17013
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231652AbhA0DAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:00:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw9O0QSmoHfyrng+nc6WXHdNbHHCQBIjNWhcm9rB3AAhetJhqNrpn5oyRpUb6VSYq7EjpJHk9zXkRhj5+dS2Sut/QTZxWRd3ppCjIWi6kD3pySufLqbBemiyVlhwR6VCOnQ0rpRLzN+ZUE9EWxdY4O0q6Xt/X7xZcOL4gmd9eNTxeGG/gd7vZkRvdinR/SoK4HSDkB4m99ZT1Q32vxFNCrmF8CyfvOdrP16FLGphe4WbrWGLoLzMADPylcbDXi0wlmUmM3HuAuhLXedTly1xapakc9uyw8UtEgLnLKTWXGo8q3GPacUtblv1XVKBWAVcchag7T9RnHMo66FUJr862Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGF8ZmY0KnRUH0IurYzkLJj3Gr0dDuykDh6e1Dxz8LA=;
 b=UZLBt7NGXV5CPPa/BtzlMstLZcTTyGp4+UJhSLM7pODVbYpUtD3ZHv/ISeTr+ZpM6xWiOVZVzBklZdz002JEhna2/CDxfk9jkUjvtz4gH7UHdR0zvQJLNJ3o24JCGhKTJ4Aklk3MVJoXzLGuV6sQiUUkOtLLsiCN5rcTSfXTR21ZOH5OIiDdqCKAAf1Ysy9jrBhP74huqLyOWFeYgD3qwUbYPlPxbvxdPQPcmc5RbFTDZ3a5FjLk2vc0UlHz/TTf5z8BFtqOCNU/ai31yvmxkc+uoUxjRIz7xzNKIz8e06/OCxB2A9dyHodfXCYjavZEdmCfFmhUcISczQXl7SA+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGF8ZmY0KnRUH0IurYzkLJj3Gr0dDuykDh6e1Dxz8LA=;
 b=JwifxJjLlTOcdId2LqDNSv0G0VJDC7e13Bx2SQ3Wr3EGBm7D/DQELE6gdtJzgKHXCBBMBQG4gecK0iBPyK5hqWuivmfr/4jHmmSb2TZbDOXVSD8my/vNvo9/nHONOwrp+0eQdBIkTCGWjobGDhFHB8EoMX+u+ac0YUsTckM8MXY=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB8PR04MB7003.eurprd04.prod.outlook.com (2603:10a6:10:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 02:58:55 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::7987:5db5:cd4c:7cd2]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::7987:5db5:cd4c:7cd2%8]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 02:58:55 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Marc Zyngier <maz@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [PATCH] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to
 remove call trace
Thread-Topic: [PATCH] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to
 remove call trace
Thread-Index: AQHW9FhZU97XOmWF60+g9kjoFHIeXw==
Date:   Wed, 27 Jan 2021 02:58:55 +0000
Message-ID: <DB6PR0401MB243885243B2B3D5BD04B66888FBB0@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20210126110027.39689-1-biwen.li@oss.nxp.com>
 <c0f1d3a6fcafebd226d53804ec0df0ed@kernel.org>
In-Reply-To: <c0f1d3a6fcafebd226d53804ec0df0ed@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 331e3ef7-4a2b-4185-746b-08d8c26f7c6c
x-ms-traffictypediagnostic: DB8PR04MB7003:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7003B6ED0870FD18CA7020D5CEBB0@DB8PR04MB7003.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wqjcq/HZPAaOj5+02+rDR3pfx0lK68dhwHGcq2RvVXjrmfo7tj4FOPqBg3CRktKJrzUVTNvWdc41KqPsqCr3VA0YlBYYmL8CNMoV6cR5yHIFVA5jnF0YSTReDnsy3eD4DsreNzCbhyw4UPQ3SpFIhiUGzH7ZF3SbmImWYbFITQHaz+USWXwWC/6+z0z/+LfJ5dPbANU2AFT3yTD0dmAUQoJQz943Lwxi2HZ/8GJy2y0FYTfTnJ6t0RaPjw/4jx+zeoWH432/N4mfeFGhd97Hi57TJuLg49fawJ3iNBj3O5rb7jLEttGyTueUOn9dtv0maC1EYeHCwKIF3qXItntK1BCjbyr69UK4vTLf64imAz3A4KFj5afzhQBf5ggotejupg/ZqcRPZCuLt2LBF9y1wJHErJhgAtwCs8vzI7bQhi5xu8PI58rXUCa78bFMUQJEnkkm0SArPddoKlhx/wjgulSL1l93/BPxHDvBsZOqIYYp5u+tTTSGByPdAKKvp2c//L8upo7gLqgTAe5dLW2aYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(8936002)(4326008)(66476007)(66446008)(4744005)(64756008)(33656002)(54906003)(83380400001)(66556008)(9686003)(26005)(53546011)(66946007)(5660300002)(478600001)(55016002)(186003)(110136005)(76116006)(71200400001)(8676002)(316002)(7696005)(2906002)(86362001)(6506007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?V3hYN1o4Q0IyVEd3YUFpQjlxWkl4RC9yM1BCL1dpRmpnaWdaMENWTVNmeWtP?=
 =?gb2312?B?NnIxY05NK3R4VmZSV0hqSnZ3Sk5va0gzSWRteTd5Z2lRUkFycjBVQ3lXSkFk?=
 =?gb2312?B?dk5LUEpCYUtmd3Q0WGhRemY3OFlIL0dvNXhhc0QwZm1jRlo5dHpQb3N3Y3FN?=
 =?gb2312?B?Zkx5UnU3REhJRW82ZC9JUWV2TUJLR3J1R2ZtL2tPUXRrOTM5Z1pMRUhtcVkx?=
 =?gb2312?B?Rk1PYXFwcWs0Uy9qVE5YOUFBdTN0K3grUTJKWVB2RUQ4WjJuaFh5TWhaYUxK?=
 =?gb2312?B?eDRrTElvZjZSUE9Sem5LcWFGNnFsN2dwYytKT09xazBEN2FHZ1kxL2dwaGxI?=
 =?gb2312?B?RmZBWnUzWU43Qkw1U1J2MzZFZURxekRiU3dhOU8wT1ZmaFByRUJBalptYVZi?=
 =?gb2312?B?TnVLSzlRaVl4eTFRZjRwRnpnVkZzM0V5dDVmMUtLeUxFeFdvLytwR3NVRU5q?=
 =?gb2312?B?S2pTVHhXdnNRY3VPSzZjZm92QU1IUEV6M0FKSFE1elNVekJQVGVzWjJUR25v?=
 =?gb2312?B?ZE5jd3d3Nnp0czByUUNlTmp5VUNVNk5STS9nZ3o2L3ZFMCtzemczRU5HQVpj?=
 =?gb2312?B?V3ljSzdWQjBhS09iYlJIVUVRcGN5L3krazVsZUNRVWRRaHRvVXY2SDhkYjFG?=
 =?gb2312?B?QXROSlpsK3hLNnZJYzlkQ0ZmRjZaL3F2VDB0cHlvdWloUDQ4b1JWdEN6b3po?=
 =?gb2312?B?ZE10ZEJHdU9OV1EvS3J2NXZndVRTc0wvMlhid214M2ZIQXdMOCtRWFVwK3VW?=
 =?gb2312?B?eW9SRThxdDgrODlyMjhZenBzcldGU1dZdkhSWWJLaE5sRTFYWmllL2Q2T2Qx?=
 =?gb2312?B?bUN1Y1kvVXd5SHN0Sk5qOHJHS3U0UDRLME9yaUkyZ0FJU1FnSEdHa0o5TnRs?=
 =?gb2312?B?TEYraE96SFRmTzFXUTl2ckhFU2FtTWhjdzl6eFA4ZEpkVjNLejRGWWpiUG5q?=
 =?gb2312?B?b1ZvYStzMWxRVGxyZENwTU9KaDFMYzhVdzNHWXNBYmFJSERWZDh6ckxlcGhX?=
 =?gb2312?B?NHdIUUk1OUhlUUNXQk9tYXhlV1VPU2h6K21LVUFPMDBhRGhPRUk4Wm8yM0wr?=
 =?gb2312?B?WG1kMlVMczJQOERkWDk4S25wbGErZmFwY0d4RnpseTgyelljYUkvT2U3Zytr?=
 =?gb2312?B?QW1IdmdpVlB6TkdoOFBQejJUWlo4VHZ1OGx0Zjlqa250NlVYR3FmM05Dcytt?=
 =?gb2312?B?UkswWnhIVEVkRHBHMVZocHRCUk54UlJzQ1MySk9Bazdvcm5xWEgvbWpWWE56?=
 =?gb2312?B?d1Nkb2xOVDVOSTFTMmhEc2EzV0ZnYlQvazJ5d21QMlJJWHRnMVZEeU1uZFli?=
 =?gb2312?B?dW91V2dQV3VjbWdDWHFncGw1OWppQnJRSDVKcXlEdTdWQWZaMlpaTmt0VXRI?=
 =?gb2312?B?ZzIzWkZjNHB2aEcrbUlsMndrZU5oaFAwQ3lmUzlWSGpFQUErMkpIZldYY2dq?=
 =?gb2312?Q?dlg6Xv3G?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331e3ef7-4a2b-4185-746b-08d8c26f7c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 02:58:55.6366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QwUfTrkykZGlbTyHx23qCzlaokXJjL+WFG8q6YyftelpaKoiQbKHEGlh8IVUsPNZCSEsEuhLGA4ZS2ABVWjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7003
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXJjIFp5bmdpZXIgPG1hekBr
ZXJuZWwub3JnPiANClNlbnQ6IDIwMjHE6jHUwjI2yNUgMjI6MDENClRvOiBCaXdlbiBMaSAoT1NT
KSA8Yml3ZW4ubGlAb3NzLm54cC5jb20+DQpDYzogbWFyay5ydXRsYW5kQGFybS5jb207IExlbyBM
aSA8bGVveWFuZy5saUBueHAuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBKaWFmZWkgUGFuIDxqaWFmZWkucGFuQG54cC5jb20+OyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IFJhbiBXYW5nIDxyYW4ud2FuZ18xQG54cC5j
b20+OyBCaXdlbiBMaSA8Yml3ZW4ubGlAbnhwLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGly
cWNoaXA6IGxzLWV4dGlycTogYWRkIGZsYWcgSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHRvIHJlbW92
ZSBjYWxsIHRyYWNlDQoNCk9uIDIwMjEtMDEtMjYgMTE6MDAsIEJpd2VuIExpIHdyb3RlOg0KPiBG
cm9tOiBCaXdlbiBMaSA8Yml3ZW4ubGlAbnhwLmNvbT4NCj4gDQo+IEFkZCBmbGFnIElSUUNISVBf
U0tJUF9TRVRfV0FLRSB0byByZW1vdmUgY2FsbCB0cmFjZSBhcyBmb2xsb3csDQoNClt1c2VsZXNz
IHRyYWNlXQ0KDQpNb3JlIGltcG9ydGFudGx5LCB3aGF0IGlzIHRoZSBidWcgdGhhdCB5b3UgYXJl
IGZpeGluZz8NCg0KW0Jpd2VuXSBTdXJlLCB3aWxsIHVwZGF0ZSB0aGUgZGVzY3JpcHRpb24uDQoN
CiAgICAgICAgIE0uDQotLSANCkphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qgc21lbGxzIGZ1bm55
Li4uDQo=
