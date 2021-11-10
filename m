Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6542544BDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhKJJfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:35:24 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:50663 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJJfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:35:23 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 04:35:22 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636536756; x=1668072756;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=0Um2MVbAsSF4PG/KteDPca/dg3s/BnBTis9pU6BsU+I=;
  b=R4zugj/ytD7tOLAuu+khfqmmkWeWt09F556oqqHxNHxFhWAGEVBwcYTI
   apeADVwMCa1JpawaoPLQD17spVZWUoYmSG7yv0yriwi4aQO6JaDyHA+TY
   22CAvNjPuYqEr7qrjsKN4YHlu/0XYTOc+RNipcR2pL+Dam8+nSGrgLy3n
   PteIHCUkjwKz2OZjiVaRkbURtR3DhqKN/TgrmKxK1ZFqZdz4z6UW0sTpL
   bUxVRh7DuHhOoBsK5W6MOQP8YiKpAfsABIVfKEsw79bHhl/uD2cApJ9od
   yLcMrjqhHo+oBKf3AIAF51pgRzJCM39PTTIDQjloQ5NMdxwJBO/urWhPW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="43349569"
X-IronPort-AV: E=Sophos;i="5.87,223,1631545200"; 
   d="scan'208";a="43349569"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 18:25:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFx1K+nzMCFd3Lf8FWdtkljOZ6V/jcnj9/D68ZqpcFVIiXfCHYKTstzc5fn64+qfjx4OKcb/2hD3M0QPptC6xG5gUgakTc6+aJ7301+Rzs98BnJB2DY4laeHdiYe5mntyJ7npyt4HFvxPh4GutD11LNZqv8Vw20oDO4MynCt06/a7OW4Fy6wt4wW1DolVGS/hViA0rdixeyFG+AjLPM6KMphqpjSFPsu6HEJ/UkmKFYFOMA+XpJpEKsLZ2RJ7ranFbf5bjjaqkIAhH8Qj8hg+wIZjsF/Ovgj1a5R8M2W//8AWN5ZpEoOmq81Jjn+VNiMCGR1g1iE03jgM8n0+mtw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Um2MVbAsSF4PG/KteDPca/dg3s/BnBTis9pU6BsU+I=;
 b=b5ThhWS3V6XysNwfpD7BG33QKtJidVr3R1A515S9YCyTFl8FyPDTNHxMFPJaEMaPialtzYZZ3x3dqStCYbd9vUqjtf0o+CfbvhGJrQaJ0kgVXgNaMd9QWddh65SmuPONTVvPDyhAqkKmCFKeFMt93D4MR+PelS+CRTFs4oF1CEpqwAxMGLarPpEjHcuWAUsIXwrCfm8xcoW1PISc2+AGYrdFAgL62TvYAgZjvtszhJygcxgHfAxOxl3xTCKEKUKa8Yq9+FnE6eiaBQ54TswUG/z5xQGjnYAQBkFK8MR1ZauAlSUIKBOh9erQeh6gaCMvjprk39mwsM0nCEPza1EGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Um2MVbAsSF4PG/KteDPca/dg3s/BnBTis9pU6BsU+I=;
 b=f0p3mudQageXy3yD3V5N0Dru1ftjOeEmy6/jzadclmvd8114xWBDp/YBz8Td9yVQ4gFlq6b+Ojg/2NFAy+2jMDtHZZTHkC7y1CSw8OQ6sxu/UXlpt84xmuhLd+f9lGZwIG6RMGJLRhUsDLUicaHCWu0TDlewWmumCQijS+AdeTY=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSZPR01MB7066.jpnprd01.prod.outlook.com (2603:1096:604:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 09:25:20 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 09:25:20 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 5/5] docs: ABI: Add sysfs documentation interface
 of hardware prefetch driver
Thread-Topic: [RFC PATCH v2 5/5] docs: ABI: Add sysfs documentation interface
 of hardware prefetch driver
Thread-Index: AQHX0Tvv/kPkA9E5NUSVJk6TV6BF/6vzdXUAgAVgQBCAAA1zAIACEpXwgACKvACAAQTcIA==
Date:   Wed, 10 Nov 2021 09:25:20 +0000
Message-ID: <OSBPR01MB20377DD32D4E285CCEC3629480939@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
 <20211104052122.553868-6-tarumizu.kohei@fujitsu.com>
 <2a939a62-7016-bbd6-6e2f-2824214687fd@intel.com>
 <OSBPR01MB20379FB0D979C0B130FEAD0280919@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <d9c31c0a-a0ce-452d-7f7d-df535eb5e918@intel.com>
 <OSBPR01MB20374AB09F302F5CB0C63EED80929@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <f5d0ce6d-c732-9fe8-5433-1362e4e77feb@intel.com>
In-Reply-To: <f5d0ce6d-c732-9fe8-5433-1362e4e77feb@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MmNhMTM1YmEtNjVlNi00OGI5LWJhNDQtOTdlYzJjNDQ0?=
 =?utf-8?B?ZjZkO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0xMFQwOToxODoxOVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cadb52d6-3fc3-4dfe-40b1-08d9a42c0457
x-ms-traffictypediagnostic: OSZPR01MB7066:
x-microsoft-antispam-prvs: <OSZPR01MB7066807A74A1083A742532F580939@OSZPR01MB7066.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sIzuU4XfxOgtjiqEefok3wg2t6uDY4mnTGjAH8RCgICjPLQvGpfty2/1Q7RRwy1KN5XTlkje3i+jMtiIEexnVWioegz0IiRBjzjrboGi06XGE5xwy/Ib67zih32oxPqHCZ50eI7lwJgI856mwY9gw+71EakJcRd+7Azo8TTt6MmZQkezNKQ0mJRybjeOZFy18pDywuH40lkBiGIGbv+X5VL7Tl+bQi43FW+0a/PO8lFw5IqVowRg7c8Bpnv58OtdWi4gRpulh6IR/ZSBp6DbwU2CW88mJgNUn6uxYsshpkTqvMq5VsQgaHVeU+KMZVnbLMMDOFhUXW/ivazoNghEgCjY3+ue0qRHzZmI1ATQS/8rKH2NtZMv+wryn58S47/vSb+UehKDHXlV7iuV2gBJVqQ6eZvSO/xzeq6kei5GwQN/PZCSPp1GvyhVLNOUHsO9+MPdNIq7hejb0RJ/L9D+b3wN711NK6gxRJqw3LUBLFBmUyuBIpz7dajBGHULzjOBIuDXYS/P9JS3gmqZiErP3+nNAGyPe2wfGrEOVa5v0M9mzV7hmL5g/zH1E8/PSGBVx0V6ss+sESAFJnvo40WX5m9vWDoKoy5SKsUzZZJE/fQ0Z7C6NB2nR8SD3v0LFK6OBIvXjjlNscb0DttAK0Lw52B1i/BFgMxshLZ+I4pWF+CjDXvNGokrrjZfe6MumqvXzuAOZPuyHVpmvzg/ci1BG1LDGGx9wQWy7JrJ6y8TAk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(9686003)(66446008)(66476007)(66946007)(64756008)(76116006)(71200400001)(5660300002)(52536014)(7416002)(66556008)(921005)(8676002)(85182001)(316002)(8936002)(508600001)(110136005)(82960400001)(55016002)(26005)(6506007)(38070700005)(186003)(38100700002)(2906002)(33656002)(7696005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlBpT3RhU2xVVU1SN2tIU1FPRlFBSXVFbk5qV0wxbEczSDBUU2VZc2NHRVJW?=
 =?utf-8?B?d2Z4cS8reUtpdENWa0pUUTBzT2Q0YXYrS3U4aEhXckd2dWpMMzE3Mk1YRllB?=
 =?utf-8?B?MFgxTEZoRnYyeEIyWmR5ZkVHcFU4bVBHSld5bVRLc2VnYTRNdm53RzZuOUda?=
 =?utf-8?B?bXQvVm9JL1krZ0tIU1V6UzJwWXFQbjVKOWZqSDhHR0ZvSDdMd3NNOVNNaVM3?=
 =?utf-8?B?TnhLeHRtM0xSeHVkY24xMWdZRGtZREFpYW1mV1lpQytRZno2dmFFRnFLVkFx?=
 =?utf-8?B?ZFBHeWxoVTR6K3JZRkJXRCt2WW02ZmVCdEZsYmIrNjkvOWVTc2N1aUpleDRp?=
 =?utf-8?B?VHpJdTNmdXdqS3creUdFU3BQV0x2ajRRT2F1UVA4SFBjSXJEZE1lNGpmcE1D?=
 =?utf-8?B?UGtQekhUdzBqaVN2S09uelViQXhjenlSdEJRM1pGTE1lZUd1Mlp3dUIxYWRr?=
 =?utf-8?B?K1YyNGZyRExHNEhCOURDMFQyaWJnaW10UU1PZzZmTGloT2hCenlXbHhRVkZU?=
 =?utf-8?B?NW5mZjVUa0tDSURsaVJQVkJQUWJDQll6cFJaSFlaSUFGZEtxWmRpM1BvcU9Y?=
 =?utf-8?B?MVUxbDYwME9ISUZHM1VhQlI0ckNuQURQd1RXM0o0ckxUeWJ1MEFhRGttRDNP?=
 =?utf-8?B?SWlrYVAwT212Y0M4KzB4RHhsU0JacUVxc1paTy9ZYkdRMjNDRHFyaktFZWh2?=
 =?utf-8?B?ZmJnSzNDcisrWWdSSzhSNU11eEx1N29sVy9EcTFWRFhoN3NselV0R09RK2tn?=
 =?utf-8?B?MWZlUmpMdHd0MTdCOTZGbTRwQmNMaUY1d3F4SEZYS3pWLzlnU0RYRDlaNEJ1?=
 =?utf-8?B?MkVjQTVPKzBQL3pWaGdpL2RubENBK1o2VzFYTVpkczhKeDI2OFY5L0R3anlE?=
 =?utf-8?B?czdwQjdMY3FIeTA5OFB1TlZwbzBGUEs4ZEpuUEd6RXlJN1ZzeXJxT2dudEhK?=
 =?utf-8?B?Vlh2OEZVbHErQWZBdGhjOTQ2UDlidjBUOEdjUEpBMEFQeU9pUThLM2lGaXUr?=
 =?utf-8?B?L0JhRjlaMnRDU3dCY3E4cUlzSzFKSENxNmJkSGZEOUdJa3p6OThySGtWVWRZ?=
 =?utf-8?B?WDhybXJMNHVEdDJBelUxamI4NUNZd3hOY041R1psTWRwdGtxUUQxTTVObWZs?=
 =?utf-8?B?YzBhZUorYkdneHdXdzdIcWphV2YwTTN2c3d0UmRqUnRqZ0d0c0xZTVNIUUV6?=
 =?utf-8?B?clB4OE1RYU5yNzhsNHdLMTBQbyszclRJSVFLaDdwSlJ3VkF2M1E0eDNLN0Vi?=
 =?utf-8?B?MlEyUXN1Y3RYOUpGOTNuM0pNNEhMbWQxZGhWNi9IUWMzbzJqRkJFV0I0UE1C?=
 =?utf-8?B?YnJRdlhHY3JYc0xidXZzaGtEZE5SU2FUWFJKTjdLMTJRTWJ3bk5Ca1R2WkV3?=
 =?utf-8?B?RjlLRFY5MjhWZXBPekM5azBTZnVua0ZtaG5odSt0VnlTcnJGRVN2aEdhVFdn?=
 =?utf-8?B?OFFDSEtGbTVSY2VBQWdobktWRWVobGpvTlh6aXU1QjRmd3ZTNTdmU2hkVDgr?=
 =?utf-8?B?dzd1V1VqSUNzdHYwOUlVNnVxWkovUGZlOG1BbzdpdkEvQmtocDlPRjdCaTVE?=
 =?utf-8?B?bFg0cWxncERUdTVGU0FsUUVnMi9mazFuTytJM2tBYzNzMkpTRUJ5UlBSTlI0?=
 =?utf-8?B?SWx4NjVFRWphbSs1a0E1emIzK0RvdG9QTUViWjlKa2lPQkU4eVVOZnk1Y3NN?=
 =?utf-8?B?R01pVUI0U3NtTmczOUJweTFHUmMyNEoxaUlGV0ZUbUEzQUNNWjdReUtvYzNV?=
 =?utf-8?B?NmpWVkxJSGlTa3BiK0FUWktYdDVnYm4zMVBJeUhySEhsd1lNL0FDZUZTYjBI?=
 =?utf-8?B?OFIvdk54RXV0bjJzdE9YQTZUNXR5WjA3RGdpOG5BZ1F3M0ZvdzJ2Qmt5Y00x?=
 =?utf-8?B?alMwdXg4S0lHalppSExhYXovUmNFUE54enVzYjh0SzU1R0xGTGhldjdUQzVE?=
 =?utf-8?B?ckxDUit0WVl0RFplODdtVnJMQ2RtR1RSTkhFYkNoSmdtcnZ4QUE0TVhnWGRt?=
 =?utf-8?B?eGwwTGlqbGtwWS9LdUlUUTAyVW5yNVg3MitBQ2U2dXdGcXI4eGwrSkpEVFBh?=
 =?utf-8?B?Q3NPdUVmaXJPdU1UMy9JcFRFQVpsMXlvcUdUTFB0ejhERklBL28yRndjMEs5?=
 =?utf-8?B?M3JlWXlyRzVhdlNwTUMwZWMxd2JCcXhkdlQ2ckJ5NFZDZWU3U1o5NnROUWRw?=
 =?utf-8?B?NjZHN1RNa1ZTU2ZqZzNvTWlPNGZoRVprcTFmclhvS0lRRHlzbHppLzFZN3Rp?=
 =?utf-8?B?Ym5KSGMxcDhrbDk3dWR0akNqQVVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadb52d6-3fc3-4dfe-40b1-08d9a42c0457
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 09:25:20.7279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yok+oF5ecij7UU3K2EnfT9uk34SHbC+0INTuLb3krtO7eyjVZflof5gRW3S1yhyWdiNLQZD6UgS02tSpuUtkyZg6sXPJYhSjnkjGzOoD9+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGaXJzdCwgSSdkIGdpdmUgdGhlbSByZWFsIG5hbWVzLg0KPiANCj4gU2Vjb25kLCBJJ2QgbGlu
ayB0aGVtIHRvIHRoZSBsZXZlbCBvciBsZXZlbHMgb2YgdGhlIGNhY2hlIHRoYXQgdGhleSBlZmZl
Y3QuDQo+IA0KPiBUaGlyZCwgSSdkIG1ha2Ugc3VyZSB0aGF0IGl0IGlzIGNsZWFyIHdoYXQgY2Fj
aGVzIGl0IGFmZmVjdHMuDQo+IA0KPiBXZSBoYXZlIGEgcmVwcmVzZW50YXRpb24gb2YgdGhlIGNh
Y2hlcyBpbjoNCj4gDQo+IAkvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUqL2NhY2hlDQo+IA0K
PiBJdCB3b3VsZCBiZSBhIHNoYW1lIHRvIGlnbm9yZSB0aG9zZS4NCg0KVGhhbmsgeW91IGZvciB5
b3VyIGFkdmljZS4NCkkgdHJ5IHRvIHJlY29uc2lkZXIgdGhlIGRlc2lnbi4NCg==
