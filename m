Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9E3BF3B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 04:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhGHCCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 22:02:30 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:12379 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230123AbhGHCC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 22:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1625709589; x=1657245589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7QWV+O+UDYtD0hafGMOtLWm5jYCGxey+4V1cAYIHR0w=;
  b=c0o+29aJ2WRcRh59TYcrXBjiNkb80D2ew1DV/6E+dnlkU7K7ZJz/U4n5
   VL3Zmfq0+X3GcbH14/KIBLQd8Lg3pm0DhDkEBFTbB8c8dftIFSNO1cVp5
   GquK/Zix4AkaYb9sU5BcNebxcs37nBm6wCGuvd9Z23IvChDWHq+YEuB84
   j+7x1V93WIKrblApv2W+yfpDFdyDT3pIsk03s/MESg3rv59Fwx6kpRXBh
   yK2JXBqU7KUq39BiBRfsctAkXgTNiba6GUrIOdZwcxqjXyA/0P4LV6aDy
   nPE/MTm1/qw45fmGPMi4tQyQ2HmLHt5B//2WFLziMUg77o33xzExz80WG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="34595049"
X-IronPort-AV: E=Sophos;i="5.84,222,1620658800"; 
   d="scan'208";a="34595049"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 10:59:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP3zt4/+MgcLgthybhF4J0oxA2qVJwqJNFHt2OVNYnkQhzo0j9rYx+4uhbx2kVtyU0oU6FmdbUuGFC0z3lKhVY6DpS1l8TFQj59SQPe3UgHnKZbEQS6MbCWncChnz1swy0z9+SFWxMik70nK56OrFMJstoX8WMjKIPgLoRxhQULuWOxnivaoYfdAySY+q8hMmrknKvo1YD/ihEorbqZZKi9DcgSt0mBeHEl07euvrS7yiZAlLZW6Yie/CnRLdlLLILciRl31KQo+JOKh/MKCRtP1mnzqxr+r5yIgtoQR9b5LTofnUNdXqDwu+73TFK2SU4Xf7zOJ2KqkC5LnnGVUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QWV+O+UDYtD0hafGMOtLWm5jYCGxey+4V1cAYIHR0w=;
 b=CcppFVCuj15TpufL04nGmDg9r84rZONhSs797oMVLWnB/xkA+0PDu5SadThy9lWktUo3WUJDuLJIPsrjLpM1NRDeXdyqiPPkJwM8l9kE7TZpKhXEQUFeKjZAsY7FeMtomvu8IG6uJ8dWePBV5btgkZZmRLsMM62GyaPHcZWbkuimz41AcdwmozfzSiZ7I0IGNZ0MxQzEN0A+ydRAuC+RAC0hn0fjd2t/zH49ClGhuOKmItqIy/gOnXsW5Ws8CepzVsRPia98YQpq/G/DJQWo7nQT9bm7SboTj2X0wLni1rh/+f1XqCo23qOOqTIBopiQqrWNkswEvPKIvabA28Edkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QWV+O+UDYtD0hafGMOtLWm5jYCGxey+4V1cAYIHR0w=;
 b=QaHxUBmPKmiTfop4FUdXEgZjwpOMIUWR5Z+KXqHBVlH/jz4HH5yNz/uXkbLe4dBqx0GrZFu+LZzka4Fyk/S2Q3vbZMBCUCkJ5Ii36DDVotDJ5RWfG28EqQ886YZuZY/GqdArH66YrZshc2duEPuT6eoBxH2pjb0NQYfJf3Ad7qI=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSBPR01MB5127.jpnprd01.prod.outlook.com (2603:1096:604:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Thu, 8 Jul
 2021 01:59:42 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::cd0d:36ad:ca28:a0bc]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::cd0d:36ad:ca28:a0bc%5]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 01:59:42 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "'hpa@zytor.com'" <hpa@zytor.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Will@kernel.org'" <will@kernel.org>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'Borislav Petkov' <bp@alien8.de>
Subject: RE: [RFC] Adding A64FX hardware prefetch sysfs interface
Thread-Topic: [RFC] Adding A64FX hardware prefetch sysfs interface
Thread-Index: AddbPDa/0dTuSZ8EQoejgzf2ST6z3wAOHlgAAN3YDYABPVAOkAPsz1Zw
Date:   Thu, 8 Jul 2021 01:59:42 +0000
Message-ID: <OSBPR01MB2037CAAFECABB5B1C35B0ED080199@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2037D114B11153F00F233F8780389@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YL3UpAZ6wZi6GyAx@zn.tnic> <fe05554f-74a5-175b-73d5-ff20b8d3abde@arm.com>
 <OSBPR01MB20371014562980857F550EE3800D9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB20371014562980857F550EE3800D9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ODBmNmI4NTQtYjliNi00ZGUwLWI5YmYtODZhZDc2ZTdj?=
 =?utf-8?B?MjgwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0wNi0xOFQwMToyOTowMVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12b27b33-75da-422c-d01c-08d941b40d60
x-ms-traffictypediagnostic: OSBPR01MB5127:
x-microsoft-antispam-prvs: <OSBPR01MB5127DE02127C143DF5FEEC8F80199@OSBPR01MB5127.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FAG71FKz19Fzj9pm41kIfN9oLHP0ZH5biu/vZ+oTQDEpL6AobCpboi7U/cGvmN2nn0QtZqQ1EoQr34BFmH2y9zJfsHLNuRGddx57pbSfWUW8YxartWcCYMDxzc2Q39AvWaK1GUSBHVVtVDimK3YETsV0tSuuEzk/nGOpUJB1MboMawoehz4LL7yQqtjtXdlmRQlTuBAvn4MhRrNRHt6rO7GLtKx9eyI7ovICXKQREdeaSrhstcZ6Lbdd1iJ25AH4K0T8KHcZ+6Z9us66EeX1zJe12vpp3w93le/WdGzwItL6crJjlB8CX3Rjh3Mqd37v4PBSPgJAouESAd7Q6AY/B2kmmmiMAiBEy/d7x4dH87HN7us/KG1XeN+MY5KVx5c1LWlIKTCNlsJo3XMTChZhBp+nyDq4gdOHnTOtLv8tTYp4eA2i7G5/eFHOkOwRPHVEhRplAz2LC9s0P4XU474xXqPhVFf+t/pNxxoOOGIg4Sc6Ls2kGRGVS6G/zXq6AN0oVw4fejH+HzLkaDoB46mo7UlQGy3FvmTZTu4tVeVheo+DilICgjkYDI0+56kDE939i4Aloc1yr1DY4DU60lPLsHo9Qk9gYxlcLM8sZ/JZurf2GLJ12udMWx01i2QP6qfKonqrLlg4tuFvdE3PQ29/nvaDAUHQuVqM1RKVwgcLm8FsmZNJhHGnJIzEd7buY7y3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(110136005)(9686003)(38100700002)(83380400001)(186003)(66946007)(52536014)(4326008)(71200400001)(6506007)(122000001)(5660300002)(478600001)(33656002)(8936002)(7416002)(54906003)(7696005)(66446008)(66476007)(86362001)(8676002)(76116006)(2906002)(316002)(85182001)(55016002)(26005)(66556008)(64756008)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3Q4Y1Vma1VYbGNJM2dZTHpYRTRKempPRzdHdEQ4TWtpcDg1ZTREbHFvZkV1?=
 =?utf-8?B?Ujd3dGRJRlZoZ281RVlpU3pWcUlEZWc1ZnNwdWVadGZiU0dPN1ZMSk1tZS9s?=
 =?utf-8?B?VTloUXc4d2RrcTZXdkt2VHU4d2E5U245Qk9zUnlzbXhvUjMxSnRpREgzODAw?=
 =?utf-8?B?eUtjcnZ6cnA3aUh2cmExV2R6c0crdEcxbWdBYm45SzZ5Umd3Y2ZvQVQ1Ykgy?=
 =?utf-8?B?Q2Q2OG1FSnA0S29ibDByd1RBN2gwSGhySmk1ZGxZb0xSMzlqKzhZbUdwSHpr?=
 =?utf-8?B?NmpVMU1oOWVDQkpUa2phcUU4eHNTNDlHZ0lHNFVUbkIycmphNHJLVElIUEVp?=
 =?utf-8?B?eThDVy92Z0YrYk92eFl5cWpIeFU4ZXo5RzcxYkNWWmtIa2JremtUQktiOHZx?=
 =?utf-8?B?cGJRa1JBZEJNM01zNktGZFdmWWlRVGthOWtJbXY1SU0wVmM5UE5uczM5WDNZ?=
 =?utf-8?B?UWU5OElIVjVSdG5GZXdGV3FoMHhoR2JwZGFDQ0E5Q1Y4cFp2UE1wSE1TSTlL?=
 =?utf-8?B?cHNLZFpjajBrZzNUbHBhby9heFJQWklDRnMwRVFsNUc1ZnR3S3RMMDE1bmR2?=
 =?utf-8?B?V3Y1WnZFQjl0MCtPYnRadENuMWZwOGo0V2JNdEFUZUx0aVQ4Y2lMUE9ySkZa?=
 =?utf-8?B?SEg2cVJmazl4UzNTS0tXNzZhaUN4OXk4NHdwWFczQWFib1VkYUVObEc2bVFu?=
 =?utf-8?B?T1l3U3lqMXlRemhUSjBGdXhiQldQWUpWR29kbFQ0cllDb1ljVWpmZXVFS1pK?=
 =?utf-8?B?aW5mMk1NeDdwT3pudEczYno1aTFIdStSTDdhSHBHWVdjM2NaUkJSYXRuWUZs?=
 =?utf-8?B?T2crcjdnZ2ROV1p6cW9MeU5LY05Jc0VKS3gwMW5IemU4bi9iZ3IxYmpPbTN4?=
 =?utf-8?B?RG1DTTZwdmZDd2NNQTlLdHJMU292UXRkV0JPSjczS2VsRS9oK29SWThtaVha?=
 =?utf-8?B?THlVMjNaUGltdlkvTFdUcXJOV1UvZHJyTXlyZk1jT0oyZDBKUlVEbWZ3L3dy?=
 =?utf-8?B?WUUydVZzczZkTkNFcklHWG9wZUZoVXZ5U25KRjA2azlJWUdGU3dBdlRuMDQz?=
 =?utf-8?B?NjJYWDVYaUY1dG5JdTA3eTRlWDRabEs4WFFWZC80MjkyZjE4Nlh6N1o0T0JE?=
 =?utf-8?B?eDFKNWFURTlYbktocm5hTnJ5Rk5Hbi9YR0I0cHVNNXNBWUcrNHdTejNhTHVQ?=
 =?utf-8?B?NHVxWmd5TUl1TTNhNy9CdVlqTzJUSUx0UnYycForUDR0cStNVkg3enBUVFA4?=
 =?utf-8?B?YWQ5RnFLenRJUG4yZm12TDc3RzB3SGVQdWZqSWp4NkhqRHF3alBLeWZ1V0tk?=
 =?utf-8?B?bGxOQTU5NVV3WURDNUliZU9VR2lOckpDY0hZaWJqNStMbTQ5UDhpb21TR09M?=
 =?utf-8?B?SlFDTG5rdGZoblJHV0gxZzF6ZXdaNDhYWmhlVloxMGIvYUxlUU1QaFNlbkky?=
 =?utf-8?B?ZVkya0ZhVkN1SU0rZjZEV0lCdmlLY2lWWmZHY0h1VUpPUDJjS3pNbWlJZWZ6?=
 =?utf-8?B?N291cTZ3bHZHdnNvNzkrR2NibXAzc0NmeDc4VmduWGtMZVNiVUhjK2tMNUJp?=
 =?utf-8?B?WlpHcW5YR2tuUXpUMGl2OFpmVVVoenkrdFVTY1RGWGJ0enNRR0ZjdkROY0lJ?=
 =?utf-8?B?bVptM3h3aDEwcDB6SHJobTA5ZkhabmlBU0w4ZWQ3dWh3ZThodG93UFR6Wi9R?=
 =?utf-8?B?cmE1MHJJMnF4YmZVVUFEM04rV1krSWtzWVA4azE5eWI3ZVVrdnB4cWFtM0hj?=
 =?utf-8?Q?c8k25pzK2d64YPfiYmZRLkj3Vzf3U2pgNENpGci?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b27b33-75da-422c-d01c-08d941b40d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 01:59:42.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODwGY7fzbCETvCJtCm285FuHeJRoucNTeAe6lizmm51G9VE7utgC6RLiSIvrtfD17MiP6nlCV/Xn4LWEcDz7NPk8FeUPjwUmM3nFEABjkxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFSTSBmb2xrcy4NCg0KPiBGb3IgdGhhdCB3ZSBhbHJlYWR5IGhhdmUgYSBoaWVyYXJjaHk6
DQo+IA0KPiB0cmVlIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY2FjaGUvDQo+IC9zeXMv
ZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY2FjaGUvDQo+IOKUnOKUgOKUgCBpbmRleDANCj4g4pSC
ICAg4pSc4pSA4pSAIGNvaGVyZW5jeV9saW5lX3NpemUNCj4g4pSCICAg4pSc4pSA4pSAIGlkDQo+
IOKUgiAgIOKUnOKUgOKUgCBsZXZlbA0KPiDilIIgICDilJzilIDilIAgbnVtYmVyX29mX3NldHMN
Cj4g4pSCICAg4pSc4pSA4pSAIHBoeXNpY2FsX2xpbmVfcGFydGl0aW9uDQo+IOKUgiAgIOKUnOKU
gOKUgCBzaGFyZWRfY3B1X2xpc3QNCj4g4pSCICAg4pSc4pSA4pSAIHNoYXJlZF9jcHVfbWFwDQo+
IOKUgiAgIOKUnOKUgOKUgCBzaXplDQo+IOKUgiAgIOKUnOKUgOKUgCB0eXBlDQo+IOKUgiAgIOKU
nOKUgOKUgCB1ZXZlbnQNCj4g4pSCICAg4pSU4pSA4pSAIHdheXNfb2ZfYXNzb2NpYXRpdml0eQ0K
PiDilJzilIDilIAgaW5kZXgxDQo+IOKUgiAgIOKUnOKUgOKUgCBjb2hlcmVuY3lfbGluZV9zaXpl
DQo+IOKUgiAgIOKUnOKUgOKUgCBpZA0KPiDilIIgICDilJzilIDilIAgbGV2ZWwNCj4g4pSCICAg
4pSc4pSA4pSAIG51bWJlcl9vZl9zZXRzDQo+IC4uLg0KPiANCj4gdGhhdCdzIGNwdTxOVU0+L2Nh
Y2hlLyBhbmQgSSBiZWxpZXZlIEFSTSBzaGFyZXMgc29tZSBvZiB0aGF0IGNvZGUgdG9vLg0KPiAN
Cj4gPiAgICAgbDFfZW5hYmxlICAgOiBUaGlzIHNldHMgb3IgZGlzcGxheXMgd2hldGhlciBoYXJk
d2FyZSBwcmVmZXRjaCBpcyBlbmFibGVkIGZvciBMMSBjYWNoZS4NCj4gPiAgICAgbDJfZW5hYmxl
ICAgOiBUaGlzIHNldHMgb3IgZGlzcGxheXMgd2hldGhlciBoYXJkd2FyZSBwcmVmZXRjaCBpcyBl
bmFibGVkIGZvciBMMiBjYWNoZS4NCj4gPiAgICAgbDFfZGlzdCAgICAgOiBUaGlzIHNldHMgb3Ig
ZGlzcGxheXMgd2hldGhlciBoYXJkd2FyZSBwcmVmZXRjaCBkaXN0YW5jZSBmb3IgTDEgY2FjaGUu
DQo+ID4gICAgIGwyX2Rpc3QgICAgIDogVGhpcyBzZXRzIG9yIGRpc3BsYXlzIHdoZXRoZXIgaGFy
ZHdhcmUgcHJlZmV0Y2ggZGlzdGFuY2UgZm9yIEwyIGNhY2hlLg0KPiA+ICAgICBsMV9yZWxpYWJs
ZSA6IFRoaXMgc2V0cyBvciBkaXNwbGF5cyB3aGV0aGVyIHJlbGlhYmxlbmVzcyBhdHRyaWJ1dGUg
Zm9yIHByZWZldGNoIGFjY2VzcyBmb3IgTDEgY2FjaGUuDQo+ID4gICAgIGwyX3JlbGlhYmxlIDog
VGhpcyBzZXRzIG9yIGRpc3BsYXlzIHdoZXRoZXIgcmVsaWFibGVuZXNzIGF0dHJpYnV0ZSBmb3Ig
cHJlZmV0Y2ggYWNjZXNzIGZvciBMMiBjYWNoZS4NCj4gDQo+IFJpZ2h0LCB0aGF0IEknZCBkZXNp
Z24gZGlmZmVyZW50bHk6DQo+IA0KPiAJLi4uL2NhY2hlL3ByZWZldGNoZXIvbDEvDQo+IAkJICAg
ICAgICAgICAgL2wxL2VuYWJsZQ0KPiAJCQkgICAgL2wxL2Rpc3QNCj4gCQkgICAgICAgICAgICAv
bDEvcmVsaWFibGUNCj4gCS4uLgkJICAgIC9sMi8NCj4gCS4uLgkJICAgIC9sMy8NCj4gDQo+IHNv
IHRoYXQgeW91IGhhdmUgYSBkaXJlY3RvcnkgcGVyIGNhY2hlIGxldmVsIGFuZCBpbiB0aGF0IGRp
cmVjdG9yeSB5b3UNCj4gaGF2ZSBlYWNoIGZpbGUuDQo+IA0KPiBCdXQgbGV0J3MgbG9vcCBpbiBB
Uk0gZm9sa3MgYXMgdGhpcyBpcyBhbiBBUk0gQ1BVIGFmdGVyIGFsbCBhbmQgdGhleSdkDQo+IGNh
cmUgZm9yIHRoYXQgY29kZS4NCg0KQ291bGQgeW91IGNvbW1lbnQgb24gdGhlIGZvbGxvd2luZyB0
d28gaWRlYXMgZm9yIHRoZSBzeXNmcyBpbnRlcmZhY2UgZGlyZWN0b3J5IHN0cnVjdHVyZSB0byBj
b250cm9sIGhhcmR3YXJlIHByZWZldGNoPw0KDQogICAgMS4gL3N5cy9kZXZpY2VzL3N5c3RlbS9j
cHUvY3B1PG51bT4vY2FjaGUvcHJlZmV0Y2hlcg0KICAgIDIuIC9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2NwdTxudW0+L3ByZWZldGNoZXINCg0KV2UgdGhpbmsgdGhhdCB0aGUgUHJvcG9zYWwgMSBp
cyBiZXR0ZXIgYmVjYXVzZSBpdCB3aWxsIGJlIGNsZWFyIHRoYXQgaXQgaXMgYSBjYWNoZS1yZWxh
dGVkIGZlYXR1cmUuDQoNCj4gVG8gdGhlIEFSTSBmb2xrczoNCj4gV291bGQgeW91IGdpdmUgbWUg
aW5mb3JtYXRpb24gYWJvdXQgdGhlIGN1cnJlbnQgc3RhdGUgb2YgY3B1PG51bT4vY2FjaGUgaW1w
bGVtZW50YXRpb24gaW4gQVJNIGFuZCB0aGUgZnV0dXJlIHBsYW5zPw0KPiBJZiBpdCBkb2Vzbid0
IHlldCBleGlzdCBhcyBhIGZlYXR1cmUsIHdlIHdvdWxkIGxpa2UgdG8gY29udHJpYnV0ZSB0byB0
aGUgd29yayB0byBlbmFibGUgaXQuDQoNCkFib3V0IHRoZSBhYm92ZSBxdWVzdGlvbiwgd2UgdGhv
dWdodCB0aGUgY3B1PG51bT4vY2FjaGUgZGlyZWN0b3J5KC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1
L2NwdTxudW0+L2NhY2hlKSBpcyBub3QgeWV0IGltcGxlbWVudGVkIG9uIEFSTTY0IGluIHRoZSBm
aXJzdCBwbGFjZS4gDQpCZWNhdXNlIHRoZSBjcHU8bnVtPi9jYWNoZSBkaXJlY3RvcnkgZG9lcyBu
b3QgZXhpc3Qgb24gb3VyIEFSTTY0IG1hY2hpbmUsIEZYNzAwIHdpdGggdGhlIEE2NEZYIHByb2Nl
c3Nvci4NCkhvd2V2ZXIsIHdlIHJlYWxpemVkIHRoYXQgZXZlbiBmb3IgQVJNNjQsIHRoZSBjcHU8
bnVtPi9jYWNoZSBkaXJlY3RvcnkgaXMgY3JlYXRlZCBpZiAiQUNQSSBQUFRUIiBvciAiZGV2aWNl
dHJlZSIgaXMgc3VwcG9ydGVkLg0KVGhpcyBwcm9ibGVtIHdhcyBjYXVzZWQgYnkgdGhlIEZYNzAw
IGZpcm13YXJlIG5vdCBzdXBwb3J0aW5nICJBQ1BJIFBQVFQiIGFuZCB3YXMgbm90IGEgY29tbW9u
IHByb2JsZW0gd2l0aCB0aGUgQVJNNjQuDQpUaGVyZWZvcmUsIHdlIHdpdGhkcmF3IHRoZSBhYm92
ZSBxdWVzdGlvbi4NCg0KT24gdGhlIG90aGVyIGhhbmQsIGZvciB0aGUgbmV3IHN5c2ZzIGludGVy
ZmFjZSB0byBjb250cm9sIGhhcmR3YXJlIHByZWZldGNoLCB3ZeKAmWQgbGlrZSB0byBjb25zaWRl
ciBhbiBlbnZpcm9ubWVudCB0aGF0IGRvZXMgbm90IHN1cHBvcnQgIkFDUEkgUFBUVCIuDQpJZiB3
ZSBhZG9wdCBQcm9wb3NhbCAyLCBubyBzcGVjaWFsIGNvbnNpZGVyYXRpb24gaXMgcmVxdWlyZWQu
DQpIb3dldmVyLCBpZiB3ZSBhZG9wdCBQcm9wb3NhbCAxLCBpdCBpcyBuZWNlc3NhcnkgdG8gY29u
c2lkZXIsIGZvciBleGFtcGxlLCBjcmVhdGluZyBhbiBlbXB0eSBjcHU8bnVtPi9jYWNoZSBkaXJl
Y3RvcnkgaW4gdGhlIGVudmlyb25tZW50IHRoYXQgZG9lcyBub3Qgc3Vwb3J0ICJBQ1BJIFBQVFQi
Lg0KV2UgZG9uJ3QgdGhpbmsgdG8gY3JlYXRlIGVtcHR5IGRpcmVjdG9yeSBpcyBwcm9ibGVtLCBi
ZWNhdXNlIHRoZSBoYXJkd2FyZSBwcmVmZXRjaCBjb250cm9sIHN5c2ZzIGludGVyZmFjZSBkb2Vz
IG5vdCBkZXBlbmQgb24gdGhlIGNvbnRlbnRzIG9mIGNwdTxudW0+L2NhY2hlL2luZGV4PG51bT4u
DQpJZiB3ZSBjcmVhdGUgYW4gZW1wdHkgZGlyZWN0b3J5LCBhcmUgdGhlcmUgYW55IG90aGVyIGlz
c3VlcyB0byBjb25zaWRlcj8NCg0KQmVzdCByZWdhcmRzLA0KS29oZWkgVGFydW1penUNCg==
