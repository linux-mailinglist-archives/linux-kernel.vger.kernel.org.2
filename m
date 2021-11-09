Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF9444AAD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbhKIJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:51:55 -0500
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:15801 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244158AbhKIJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:51:24 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 04:51:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636451319; x=1667987319;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IuQ5G9CLVDMiWNaMAoQRZUYlsittToi5jg8I4m248EY=;
  b=nx6iHLqYRNFgWzAOnYWbC7Q5RlFRcygB9eJmlykmAL1hapoVvCJ9Gtzv
   uOZTYpay8KLfGSAD4KPWzkJCnwQDAUFKxwMXs2CkNz4HJfZ63szWZNDA/
   Y1lA9tEU1Nz1gSXALVwrvqD2tagyQfCXOFj7cqdgkBH72Y9eqDcs8HQ9J
   V45+eu0GK5Se6aZiAoMe8PFgp37rVYk1yEn+R+hEANUfKE1bvDwWGO1xO
   QxPDgEQvJKnvi+tAAl1ljoeeDiPL8vzDOCGun8GQCO/AYJhmM9FLd1ARa
   eYbmPMQ2WCOnEQxoV2YhS28TCauTVSaWkGW5WPoDpagav3C4D37UbsfgM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="51380974"
X-IronPort-AV: E=Sophos;i="5.87,219,1631545200"; 
   d="scan'208";a="51380974"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 18:41:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr0YDEldKvzdBefNU2lv/1jjWGEr7Kijp4XN7vpmG8aS7ASrFRmWWND2cBLbrkeS73vEs8CgyNlT25p2rD4SAoaoNTlaD3Z/6B8kn9wesdRLHfx8iARwZDC0y4wTYY0MZuiIC5Pdk1Cuf4nBfOcAgm0x5hIOsnZdjwjk8O5BZzdz2m7Yu1H/Uil2PC6kSlHHLRS1NngVnQ7CfCUSgKlkLGweseuM3g3WDcdImtDN1kOpaTr2Ia9oxYO2cxFNjsJrtfH3imZ8B6369lcTwTRx5fzJ/X4hQ18UKOGBsscLAsdeFRM9C7NoCNckLVfBSxCvbh0GgeNCiG3Ar8klsJi9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuQ5G9CLVDMiWNaMAoQRZUYlsittToi5jg8I4m248EY=;
 b=Ndr4j1t7iJowzZ6HbyMaK5hxRSPEVWwc2I8mpfgLGVDgtVNlUnWiYdhfAI0dG4LDb0Uaj4biSw/sg1wEMdrvIAHNPVHX5FAvcJsvowITe9Imc7XvSNSzicvqPCYI4CIBn/RMjq5cR80jalEaKl1EF7FChxdAy8SZ14MVY8JFNETfyGsgrX5+ic6mOju3PDFMrPafFkhCU6OPDhrSHsUbeXeCY6J+1ApYcJnbBPJSmpU9hnhFbKEvjkPbboa3br/52/V4LWrbUI++VVy+PKkIIt0pfi1ymAxYWIA3vL6+AR5n7e29UVylAG262Llm/uA1W77rNtGAO/eyTHtfA2K9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuQ5G9CLVDMiWNaMAoQRZUYlsittToi5jg8I4m248EY=;
 b=D+hx0iZHl/gJvLjiun1RIMMn2caOoh8rlXFq02IlqmsmzcwhLc5wwEa34YI4ZKTktdvRNHJsVRy56HSNBlgKdJzdlbKCs8YEouFBfp3EZy5VR62SDz1oS/lvY8LMTOu/SbSCDTvAFY2iur4g8JWj6R8ElPbfFLZiooYBeiZkfIs=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OS0PR01MB5554.jpnprd01.prod.outlook.com (2603:1096:604:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 09:41:23 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 09:41:23 +0000
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
Thread-Index: AQHX0Tvv/kPkA9E5NUSVJk6TV6BF/6vzdXUAgAVgQBCAAA1zAIACEpXw
Date:   Tue, 9 Nov 2021 09:41:23 +0000
Message-ID: <OSBPR01MB20374AB09F302F5CB0C63EED80929@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
 <20211104052122.553868-6-tarumizu.kohei@fujitsu.com>
 <2a939a62-7016-bbd6-6e2f-2824214687fd@intel.com>
 <OSBPR01MB20379FB0D979C0B130FEAD0280919@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <d9c31c0a-a0ce-452d-7f7d-df535eb5e918@intel.com>
In-Reply-To: <d9c31c0a-a0ce-452d-7f7d-df535eb5e918@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YmQ2OGFhMTktMjg0OS00NDAzLWI0NzQtNDQwN2ZiMDMz?=
 =?utf-8?B?MDNiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0wOVQwOToyODowN1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed71eb7e-ba94-4557-7847-08d9a3651785
x-ms-traffictypediagnostic: OS0PR01MB5554:
x-microsoft-antispam-prvs: <OS0PR01MB5554DA9454F40960757FE34F80929@OS0PR01MB5554.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HoG/iHa7C/cUeW2IFRMGKjZP48z1BOBTt7CoSHPUvRjEduhmFUaZ4A6eEclDhV5p6qwN5+BfzWyCjpzXggnhZVrMflNo8w54iQDpMgfZIvMVLqPmRrevD+AD2YnPzOAWmitPuz2QzrBOpo1RauWqjPaVe2Mvzxmvw1Otw9lyldukzQ+2DLFqAU45SCdu6K6vOkPotL2f/KQDh/YMXCtSiEAxBgc1lBbGE2zdNBfcN0x5O1vrlU/Qkh79LVsgjw6GNvzGYQ/Qx7x4rPcq7Wh3X6bnIYwVApRe2p8eLDZihdh7F/qM3I4EjZMEJNWLwS5l//tM7RivOAFVPluSxjOTejJZmtnsTML+pnoUpG1Zpwe/O85PNiWdWqpSwXIlE8Oj64g8xC14rWBoDx/ps+1SMBXUT7v0ww0KQx4+uRdpX+ZztvaudnWDytq20auDf29vw971bvGG7kPrG5EJSTrteho72dJS233XggcLqOEuIHCndfASEGLQIb/PIS4e3H70/NGkuYXJDBZ4IKX7Eoyw4fIDrlVIcBCQGU6y9MkN+juAWv4Ni8Ou6oNEd1GoAdsrO/9je+tTeucAqleaVZOOyY+VnpYzTQ0Z9b1z2GPy4r1BzThemqWuch1/n7V8XYuJQdWxesD/KB6WrAg99PMozC3IjO4nOjv7l2y9Wf/wv9DNq/UuaT5uF79O8515C3aeZCiUCBS9yhQQO0BYEglUaGKblzT6vP2pfvqGBJNO/yzI1Ozw3uuXPwxL9i7PlkQdnnYb4W6lXORSbNww5bLLKQEEv0M5wH4ZphMFFnlzdX2MFaRChpCBfveXSO+PCb7P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(52536014)(921005)(7416002)(26005)(316002)(5660300002)(2906002)(66946007)(7696005)(76116006)(64756008)(6506007)(55016002)(66476007)(66556008)(66446008)(110136005)(508600001)(71200400001)(33656002)(186003)(38070700005)(8676002)(122000001)(82960400001)(83380400001)(38100700002)(86362001)(9686003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S29YQlE3WGhVMVB1dlJYM05jdnZuNS9aRjI1VWhjT1ZsMTc1VDM3L2RZUE9H?=
 =?utf-8?B?YVNKcUpmZGZoM0hKOHdaYktQREhxeFNyeXQvSmcvb2liQlE0cTFuNGtRdEFF?=
 =?utf-8?B?eEdCV2RWSUdpUXM5MEJiMzV6SE44akZ0U0hsMjZDMnM2VzdOajl5cHNMTWNm?=
 =?utf-8?B?YjBwYUxlOXNFa3lmUE9NTjJyK0R1NTNCWktGM1dZMzVZVjhTakp1aHlWaGZ5?=
 =?utf-8?B?SEJuVEJLTGw1eitPMXowVHlDMTlqaDhKNVZQaXFqN0EveHVRSlVBRVYzV0ZF?=
 =?utf-8?B?UkxXaFlDNlhPRXZ4dEgwR0pvVkdvc2JFTjNKY1MweVhpZ1Q3TkxOeXZWWUlR?=
 =?utf-8?B?YVo4cjd0QlY4OW9jclJwbVQ2WlU0THhOSmthM3ZoNzZJNkpvWkdFd04wRS9J?=
 =?utf-8?B?bzE0NTlFcGZQMDlSK3pSMGlDZmZrRDVDV094RXAzR2QzbmVlU2JjTHlRYm1Y?=
 =?utf-8?B?R2NpQmdtMXR6SlRDTGlzUnJhMi9XRjRQQk5rNEVHNmFJNjZBcGJrM2ZmbHFp?=
 =?utf-8?B?V09DV0drY0JmeUJrRmJIMDY1dTJxSGUwK0ZHVnYxY24vemppb3p4SGlKVW9W?=
 =?utf-8?B?Z1BQRVRpbGFRNEM2Q2g3a3g4N3F0cC83Tk1JTGJrRkhCRDFrUURiZDZZNU5a?=
 =?utf-8?B?ejdoT05xbmpFSHlTVzY5dzdrVXBMSUZVU2tXcVgvSHZFOVpDOTBvVE4raXdJ?=
 =?utf-8?B?S2NoU3JJQXFvdUl3dmlWTnVDS1BzbnBlU3ZnVHJnUTZIWXE1UDRSQWoydFJl?=
 =?utf-8?B?cjdVMXo3NTVzOWpEeU9rMHNQMG5pYUZta3k3cXpMaHRreGwyN0JjWVF6MFNT?=
 =?utf-8?B?eUszbUcrYWt6YzVzN3E1MEdNNDNndW1CckhoWHYxR3RQSVhwN0ZoVStHVGxD?=
 =?utf-8?B?VVVWU0ZxTmFXMXdJaDVFRXg4ZjVER01JWkxzeUZQQVE3SjhKOEU1bVdWZ3Jh?=
 =?utf-8?B?U1ZHbDZOaURTRTM0SXB1SUJNV1FOWmU1K1VRNEp4K0lxSXlkTlpxMS9qM1hO?=
 =?utf-8?B?U1VVNFgyUkJiUU5GWFdqVmI1V1ZVemZ4eGQ1N1RuTkNsNWpRZXpzN09HVnVi?=
 =?utf-8?B?RmNPQ1diTzhDdjZmYkdiTDhabmJIT0xKanlXaFlsYkUyN0Zwck5sN0VUVUV6?=
 =?utf-8?B?TVVXUy95dng5cTVBUEJzRUVsWHc0b21oT28rcm9TMVYyQVJEcmNLeUJsT2hs?=
 =?utf-8?B?MUwyOG9mTDM1TVBabnRjM1BicHZqcHBrZkU4bmRPREdTbnIvanlWY28zMDk3?=
 =?utf-8?B?OCt3YUFUZ05CaHBaWnpSQXNWTm81dFFNUmhEcC9NcEtUMDBuRll5RjdBZmt5?=
 =?utf-8?B?N29ldHI1WkJURmlSVFRIazJWaGR4bklURnZYaXhDTGNYTm16R2Q5NURKc0R1?=
 =?utf-8?B?ejkrV2thVnZMS29IZ2RqcDkyZHF0Z3pxck1ubUtZUzJTZDJ1TVVmNlFCU1Fk?=
 =?utf-8?B?R2FzQ1FuajZ6ZnZ0czA1Y2FhOVUwaUhMaWpBUTFRRVFwWGVmQ0VxQitLc1ZL?=
 =?utf-8?B?VnBJZFQzakJQVGVDUEFhVWRnN0J4c1FHeDVTcHNXMHB0Mm4xd2dGUzN5c3c2?=
 =?utf-8?B?WUx0TURNM0t1Q2xXMVhMKzlPVFdNeUVDZFJVVmtvZlNrMmgwTEtVZDc2SUFQ?=
 =?utf-8?B?RURZZ0JGWWFhTTJPdlh1NDNNanpzNnRpc0kwZGp6Q0ZReUtNT05KUFpWWDNa?=
 =?utf-8?B?NWxqcEVpbU9sV29nZFJMZFVFUmNGcG52bWpuTzcyZ1htZDZpQTVQeVU3dzFi?=
 =?utf-8?B?Y2R1YzZoa1J6NGhoeXJ4NTJrbysvUFlXZ2VkL1orT0RQcnFQNGtVOCszZ09U?=
 =?utf-8?B?dzBLLzl6TlJ6ZWF6RUUzdGtJMGQ5QmZGYWJYMlMrVXdmV0tvQm1GR21YNjBs?=
 =?utf-8?B?eW9laTZ2UUdZR2ExbjJXMmpIaW1HdmlLTENOQk05Y3NhOTNaVUY3RXJTOTE3?=
 =?utf-8?B?Tm9aVzN6c3dhRnUralV4S0dua3lCRnNEWFdwV1QzOG1MRUF4dlNqbTkybVhh?=
 =?utf-8?B?Q0g1Nld2RERQOUF3TU9TUWREQzdCY3REWk1DOU5pR3JhVm1GTkkvZk4yWTlJ?=
 =?utf-8?B?aU8vM0hsZG84WDZycEdaK2M5Zk5jcUVqUlJtK25yamZXSlNVYmZNWlBxdjk2?=
 =?utf-8?B?Ymt1VXdKajJHVHNKc1ZleVNPbkU3c0E0YUhUd2hvdldFK3Y3aVBsYUtDN1pm?=
 =?utf-8?B?YTA5QWpsQWUrak5VcEZCVGRzMzRYM05vNnF5NWhmckYvMXkzclJTSTlTRUNO?=
 =?utf-8?B?eXk1Q1ZwMEExRmNaTzBORmFZWkFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed71eb7e-ba94-4557-7847-08d9a3651785
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 09:41:23.0953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cg2qzidKeqqLPKXaj/EPXXRjsKokV5Qg18eVLq3jJQoLlW0jEyIoNM3f0V23/n7jBtGHTTZrKjVV8x7OAhLzK3B+Lok3eSf4QWJ66brrdgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5554
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBaGgsIHNvIHlvdSByZWFsbHkgZG8gaW50ZW5kIHRoZSBsMiBkaXJlY3RvcnkgdG8gYmUgZm9y
ICphbGwqIHRoZSBMMg0KPiBwcmVmZXRjaGVycz8NCg0KWWVzLCB3ZSBpbnRlbmQgdG8gY3JlYXRl
IHRoZSBsMiBkaXJlY3RvcnkgZm9yICphbGwqIHRoZSBMMiBwcmVmZXRjaGVycw0KKGkuZS4gIkwy
IEhhcmR3YXJlIFByZWZldGNoZXIgRGlzYWJsZSIgYW5kICJMMiBBZGphY2VudCBDYWNoZSBMaW5l
DQpQcmVmZXRjaGVyIERpc2FibGUpLiANCg0KPiBJIGd1ZXNzIHRoYXQncyBPSywgYnV0IHdpbGwg
Zm9sa3MgZXZlciB3YW50IHRvIGRvICJMMg0KPiBIYXJkd2FyZSBQcmVmZXRjaGVyIERpc2FibGUi
LCBidXQgbm90ICJMMiBBZGphY2VudCBDYWNoZSBMaW5lIFByZWZldGNoZXINCj4gRGlzYWJsZSI/
DQoNClRoZXJlIGFyZSBwZW9wbGUgd2hvIGFjdHVhbGx5IHRlc3RlZCB0aGUgcGVyZm9ybWFuY2Ug
aW1wcm92ZW1lbnRbMV0uDQoNClsxXWh0dHBzOi8vZ2l0aHViLmNvbS94bXJpZy94bXJpZy9pc3N1
ZXMvMTQzMyNpc3N1ZWNvbW1lbnQtNTcyMTI2MTg0DQoNCkluIHRoaXMgcmVwb3J0LCB3cml0ZSA1
IHRvIE1TUiAweDFhNCAoaS5lLiAiTDIgSGFyZHdhcmUgUHJlZmV0Y2hlcg0KRGlzYWJsZSIsIGJ1
dCBub3QgIkwyIEFkamFjZW50IENhY2hlIExpbmUgUHJlZmV0Y2hlciBEaXNhYmxlIikNCm9uIGk3
LTU5MzBLIGZvciBiZXN0IHBlcmZvcm1hbmNlLiBJZiBzdWNoIHR1bmluZyBpcyBwb3NzaWJsZSwg
aXQgbWF5DQpiZSB1c2VmdWwgZm9yIHNvbWUgcGVvcGxlLg0KDQpXZSBkZXNjcmliZSBob3cgdG8g
ZGVhbCB0aGVzZSBwYXJhbWV0ZXJzIGluIG91ciBzeXNmcyBpbnRlcmZhY2UgYXQNCiJbUkZDICYg
RnV0dXJlIHBsYW5dIiBzZWN0aW9uIGluIHRoZSBjb3ZlciBsZXR0ZXIoMC81KSwgYnV0IHdlIGNh
bid0DQpjb21lIHVwIHdpdGggYW55IGdvb2QgaWRlYXMuDQoNCldlIHRob3VnaHQgdGhhdCB0aGUg
c3lzZnMgaW50ZXJmYWNlIHNob3VsZCBiZSBnZW5lcmljIGFuZCBjb21tb24sDQphbmQgYXZvaWQg
c2hvd2luZyBhcmNoaXRlY3R1cmUtZGVwZW5kZW50IHNwZWNpZmljYXRpb25zLg0KDQpXZSBoYXZl
IGNvbnNpZGVyZWQgdGhlIFByb3Bvc2FsIEIgdGhhdCBtdWx0aXBsZSBoYXJkd2FyZSBwcmVmZXRj
aA0KdHlwZXMgaW4gb25lIGVuYWJsZSBhdHRyaWJ1dGUgZmlsZSBhdCBhYm92ZSBzZWN0aW9uLiBI
b3dldmVyLCBpbg0Kb3JkZXIgdG8gdXNlIGl0LCB3ZSBoYXZlIHRvIGtub3cgdGhlIHJlZ2lzdGVy
IHNwZWNpZmljYXRpb24sIHNvIHdlDQp0aGluayBpdCBpcyBub3QgYXBwcm9wcmlhdGUuDQoNCkRv
IHlvdSBoYXZlIGFueSBpZGVhIGhvdyB0byByZXByZXNlbnQgYXJjaGl0ZWN0dXJlLWRlcGVuZGVu
dA0Kc3BlY2lmaWNhdGlvbnMgaW4gc3lzZnMgaW50ZXJmYWNlPw0K
