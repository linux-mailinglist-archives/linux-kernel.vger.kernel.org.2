Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915964554C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbhKRGZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:25:19 -0500
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:48866 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243344AbhKRGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:25:18 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Nov 2021 01:25:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1637216539; x=1668752539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xSUORY9teb+hpbM3B/zmTqWwLQf6NEeC9SuS5Z3hMO8=;
  b=pQ2F7le//JZK1391gFX8SI+TYlqST18NGE9VFnStjfjd1454HwfLjOon
   QVBTd7gXYpnw/rQsB2ea4ob3H9MN4de1UTP8bmBdJcwZo/cnCvRfIlkDQ
   yamdhPrHaloMBZBKTaPlz2F5hvPCBm1qE0Qac0DujZp7e95nJaRNbZPPv
   LJSUlTdiBxIIsG/W/dQnS1CDJiWq78UjPZ3XCvWv4AkRglTTxy6eIcKAU
   BwOsyWA64ujcpJ1+Z+g2jJ4BbD1wKJuVbwSU6FHqR0cG8EqWbw9+7W2w1
   eToKRS4nuKsbdQmY1nVRcy4BBE2Y5q/rlHP9n2npClJUppgitOgvedkyD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="44021113"
X-IronPort-AV: E=Sophos;i="5.87,243,1631545200"; 
   d="scan'208";a="44021113"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 15:15:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTTUtRAwmIilPy0c3te6CeJz4FHh+pS1i0/+cgfIKdaC2e7S2/60is8ez2fwRhHFuI2HuJwUOH6XakDajbKaAGOS9Y85RHzyEvhC8s1T3jsgV5js5LgFZSXfVFJdb/E22alfBcXn/utjJy9AqQKuXnpyh/VegSXAT8B+t+HFCidl3ipSFuVDsHChjYVS4iTuRp+IjQJFCRUaAL3zZc6EjDeI8ENHgFByebCt7NMaoraZI3DOYrwZ2MEytMHuCMeI6ICCiXTPqHq1nmKbzn7nN2REJrDY7Z8ZxIczyd7DoMGuzf7jj6gr88qGb6LFhnU3Ux+bO4zDXydzItu5CKSdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSUORY9teb+hpbM3B/zmTqWwLQf6NEeC9SuS5Z3hMO8=;
 b=jdE8y6Z83MGZwEwIPxGzYtHuUKeGKwEcz7w4IBVS0vjDBnu2Y3HTwsXjHPmooJ89x/7M1xmAUGFH24ZqQCISR6yNP9H5xckOzXOeJQlXg4J90xB12fJVgb9r2ECCInLETZtgnBeIiyqXKPeBSh3WDzfnAkvw90h/6pGKvrD5ZWqAAYiACY4ygHx0cv5CvAXA0rJozCt7YPqaCV2nNBZoOeuncXI1LzuwIUkI1cnzPj7fasg3SiSVluxQHgPvlgRte9W1r0SuOY5wQx3cNtBOFx0Mk0TAFFtLTlcM/D1Da9L74bRX1yUyJUHH4jyBH5islTaIERUIN6zkSgxCae790g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSUORY9teb+hpbM3B/zmTqWwLQf6NEeC9SuS5Z3hMO8=;
 b=IzQ4EKo+G1IbTw5Qtem6Q/M/GBRiod/3vKG4KYhxbGZLoM5Gz3byS33+tez0oha2F9plzAN1Lv/SlBPizPEKpS7HQFXxz9LN2WfTPt19AVWTcDxfLiBv32HEkhYvcU5m7S6qKFPTHMtU1jlIEHOOwtHHOJST4udN2EdviUVVkGg=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB1763.jpnprd01.prod.outlook.com (2603:1096:603:31::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Thu, 18 Nov
 2021 06:14:59 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124%7]) with mapi id 15.20.4713.021; Thu, 18 Nov 2021
 06:14:59 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Borislav Petkov' <bp@alien8.de>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Thread-Topic: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Thread-Index: AQHX0Tvqcmg6rBpliUSJLBUQh9tTC6vzenEAgAVvZFCAA48gAIAMZACA
Date:   Thu, 18 Nov 2021 06:14:59 +0000
Message-ID: <OSBPR01MB20375F9AC9E544FC7239A0C1809B9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
 <YYP4fAgKSh4bVvgD@zn.tnic>
 <OSBPR01MB20370518F9296BA4302FF7DC80919@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YYuD+jRPUQrsmAkD@zn.tnic>
In-Reply-To: <YYuD+jRPUQrsmAkD@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YTNmNGI1NzItYWRhNi00YTJlLWI1ZjItY2ZkNGRiMWJk?=
 =?utf-8?B?ODViO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0xOFQwNTo0NzowM1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a25a0711-7f7f-41a9-385f-08d9aa5ac028
x-ms-traffictypediagnostic: OSAPR01MB1763:
x-microsoft-antispam-prvs: <OSAPR01MB17637E3245FCF60C759D7B62809B9@OSAPR01MB1763.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLosTe0OfBYze9xd3IECtHtTlseX1MyJ5363Byv1ttYEFpWYvwJHMhwssUCD1GwmY3rmujGlt7Hh5ah3Nd6ykc/yb0RmiOtwVBZbciKrFJcpvdIQombVuJMCSIXmZsR2PdvPpsp70MSWiEM4cfY6awezwrpgoZFEwyFp8bKV6ynOk86mGWPIxFtPS+op4RI7o8vTss5apEMphiTKFgvGlz2gZrj3qDcMpARMEaRYqe8iqHhbkHCsfPDtRxNQA43I6g1HcV0jrWoOekSDEspewS6lGLsP+DdYEFmNv+risWnZ1sB+wUR0AK2usPHTRe1l99A0orJZrJIAL5MTXk0zZxTMvxgII2JIMNjlqNqWCuyc5yCqGUbCJ6365Vf8ZvO4nQYAuTb5OTA2lMjsge1pj0KJEwZ2Zk1TOrE5x+3ZGEWrHm5yDCm1yDNFljOZ8YiwLwkh0BE7WOuoyYoPgkR44k1fghnsO2MWZQoMkfZG0rjJ7vbFsGJ/ygAE1Em1jsudxun1Mr8x1VYvO2U3cCBr0OEEsam771RLE/wbNfmLl+wwyrgEBkigVJP0BuWlgYlvfKrOdqkNZRfI44VLYffv5g6/Cst6DV7t1JWC1rR2WCLPAeUOwBtlwVwGfyHtEpk4ZDtVn9ZOo3HLVqtlKKaC3nb2DVil6czHhOLYTDl6lZasz+tPSjWpb8YWhRiCVtkU8lgCYSk1khfdzmv7phGk0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(82960400001)(38070700005)(76116006)(5660300002)(38100700002)(86362001)(8936002)(6506007)(52536014)(186003)(508600001)(9686003)(316002)(66556008)(7696005)(64756008)(66446008)(66476007)(8676002)(4326008)(7416002)(6916009)(66946007)(55016002)(85182001)(33656002)(2906002)(83380400001)(54906003)(26005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUY2RzF1RXFCOWFZSXdWUjJjNGM3STJVc3dIK0UwcGhmaW1KQ2pIY1lKQUh4?=
 =?utf-8?B?aEJjcERZakplVE50VkxPMFR2d25yamdSVFcvSkJRU2dMdUQvU2pqN1p0ZzhL?=
 =?utf-8?B?c3I1V202V2hYRW9lNE9sQWovQmxDYXJIUitMa3RlekFhZG02RlNRUndyRGln?=
 =?utf-8?B?ODhpZ1Fscit5VEhaeEtCYlJTNE5MbStQSDJPbHZteWl5VXMvS2tlZDU1aHpH?=
 =?utf-8?B?SitPNUZocXVvbUNzOXBFVks5L3N4eWpYOEVCbmlOYnFxVkFtZ0t4dWIvM1VE?=
 =?utf-8?B?ZTJ6SWFrdUJyWWY0OEFOVVdQTVB4WFpqK1dzM1BXU3FaWllzTWZOcGx2Vi9J?=
 =?utf-8?B?dUpUcE80YXplZ1pzdVZlSTQ5MkJkaGY0cER1ODNKVURDR3NXKzZpbVg5U1lk?=
 =?utf-8?B?Z09PcnJnTjZkK2gzU2tYQzF3cnpDdkQ2MXA4ZEpBMDJEVEtQc3FvM1JFdm5T?=
 =?utf-8?B?ZXg3VHlMdlNNR2hVeVZuRmprVEU4d3kyS2t4bmpzZC95RGVabDl0ZEp0MThB?=
 =?utf-8?B?VmNOcmgzMUJPZlBTV1Fqd3VSY0NTYURYcUdBQWowdnBIRE9LN25IUXAvaUd1?=
 =?utf-8?B?NVFYUU80TURGMjBHQnh3ejJYVVV3SXhxQUZnODYwYy9HYUx0QVlNVmVYLzlj?=
 =?utf-8?B?SXUxcCtuU3Q2THhSMC81RTIvRmVZUUJXNVptSkZzdkVXSmVGR0F3S2ZCalFt?=
 =?utf-8?B?cGdpYWdjanlKdi9Sb2phTDRKM29hQUJCTEJHYmVjaVlDcmxWbXJwNzJsYWRX?=
 =?utf-8?B?cWZKeHZYRnduc0RsWTczeHVETXg0TWVUSzg3UkdjZTBERUdDRURlbFZlcTk4?=
 =?utf-8?B?WTFYM3I0VkdSNzUzRnhQOEUwcXJSLy9IdVVlZkdSMzV6cnoyMFdyTGdCc0pw?=
 =?utf-8?B?U3BBTXFITW1tNkp4QlVQK0dLU041eW9ocGF1cDVka2xrQ2xKYkxZeWNZZnkv?=
 =?utf-8?B?UUVlcmxuWHBXYlFyalJRdnJ2ODYzbEtjbDFNUzNIMmRLZWhnRXFtSnJhZFVv?=
 =?utf-8?B?WlZSaXZtZGpyVlc3Qll1VmxOdWd0T1F4TFcwWnV5czZlc3Fxb1E4UVB0SFFR?=
 =?utf-8?B?b2YzSENKdmYvQzc4dFJFdzBycVhHbXFUOWlUbjRIZEcrUTliKzljOUh6Q2FF?=
 =?utf-8?B?Q01SSXBpQjNRSkFDTmhDK1Q5ZGkxU3NaWFdqK2hadzBCR2dnR0c4cWIyZFJn?=
 =?utf-8?B?ZGwwcXhJSlJOZjNVcjJuZ1VnY3IvYVV1QjJKcnVzYTdvUjBLLzBCQzdsTGpE?=
 =?utf-8?B?N0hPZnNRVlZ3N1dYQmtlOFJGUzFtN1IwOG14OXJzNXVibDVvSXNNSnRrV2Ja?=
 =?utf-8?B?NmttK2Q3TS9CcHlWNW12RTB2UXdLL1M4dFhyaU5FT284R1NWR3g0bWd1WjV3?=
 =?utf-8?B?enN3RUtrSnZEWVhmQ29ZQTkzdjhsV3k1K3JINEg1U0YrZEVVVWVXUGVPTjJL?=
 =?utf-8?B?aVpZZHRvVjNCamx0M2wxWm5mVDRWR041U0NPRFZ2VU5tSlMwR0VweHpuQURj?=
 =?utf-8?B?cnlCWmZlcllPVVlTRXFoU3IyblUrL3RoMmIyM0JlMG11YVN6YWNYdmM4cFJB?=
 =?utf-8?B?WWVweUI5bmpvODhZM1BvcWtkRm83K1Q1VjF0MVczSGlieUhHNkpaQVpGdmdl?=
 =?utf-8?B?L3dEUndWclpzYTNKTUduK0tvMEw1MnBvL0VmQ1JvZENnTTB6YUFLcm04RlNJ?=
 =?utf-8?B?MG5GaTVJQldvZlVuWkNUcXRqcHR0L3A3aU9tT1ZXQndpZXg4eHZwdDRBdldu?=
 =?utf-8?B?N3llVFdTcmljaWJwaExheVRkUlRnY3hjUWVGb1VxQTBPTG5PZG1SSVlFVkFi?=
 =?utf-8?B?VGNiRWF6NStpaHhZK3FZalp1cStQWHFWTTF1VUhZS080NEhXODlCZEQvWWFL?=
 =?utf-8?B?Tlh1NkhlSTRHcDh5ZlNwMUpiT1JxMVdvZnFyL24yWUJ3M2tHZGRIK0VLM2pZ?=
 =?utf-8?B?dmhvME1JNkxHSTJwdm9PRFpFRmUwY0twMWo5akVRdm5rYXlBQ1dHVTdVaWZx?=
 =?utf-8?B?NmNEaXVOOU0xK0JHZkVDZnczajlGV1laR01Pd0lTVzJNY2FTL2tNVFJreEZP?=
 =?utf-8?B?V0RXdUxBcVNKNUpwK1p0YzBLaTE5YSswM3pvSnI3TjNyeWlIeWJHWFoxc0ky?=
 =?utf-8?B?YVdiZlFPSXRzQUxuSlNRUk9JZTJCclByekZyNEo5dGdRcmRHbExnajRlRGpE?=
 =?utf-8?B?UWN0VTZibk9nME1abWxna2Ntcllsb2ozeURMUkhjN2E4QzZTdmtlaUdGWlVn?=
 =?utf-8?B?Z0xRc3NjUjNEUkFYenVlOHZ6YmdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25a0711-7f7f-41a9-385f-08d9aa5ac028
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 06:14:59.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWueVg+O2NqkFXfJReZxGpKJT22U3wP5/kMUQFVOOOUurQd2sALDZU7rs//mfI/98xbRLLp79VXVL0T7UByzttLC6qa3ijkWlCuYoQMOFIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSdtIHNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4NCg0KPiBTbyBwdXQgYWxsIHRob3NlIGp1c3Rp
ZmljYXRpb25zIGF0IHRoZSBiZWdpbm5pbmcgb2YgeW91ciAwdGggbWVzc2FnZQ0KPiB3aGVuIHlv
dSBzZW5kIGEgcGF0Y2hzZXQgc28gdGhhdCBpdCBpcyBjbGVhciB0byByZXZpZXdlcnMgKndoeSog
eW91J3JlDQo+IGRvaW5nIHRoaXMuIFRoZSAid2h5IiBpcyB0aGUgbW9zdCBpbXBvcnRhbnQgLSBl
dmVyeXRoaW5nIGVsc2UgY29tZXMNCj4gYWZ0ZXIuDQoNCkkgdW5kZXJzdGFuZC4gVGhlIG5leHQg
dGltZSB3ZSBzZW5kIGEgcGF0Y2hzZXQsIHB1dCB0aGVzZQ0KanVzdGlmaWNhdGlvbnMgYXQgdGhl
IGJlZ2lubmluZyBvZiBvdXIgMHRoIG1lc3NhZ2UuDQoNCj4gV2VsbCwgaG93IG1hbnkgcHJlZmV0
Y2hlciBkcml2ZXJzIHdpbGwgYmUgdGhlcmU/DQo+IA0KPiBPbiB4ODYgdGhlcmUgd2lsbCBiZSBv
bmUgcGVyIHZlbmRvciwgc28gMi0zIHRoZSBtb3N04oCmDQoNCkN1cnJlbnRyeSwgd2UgcGxhbiB0
byBzdXBwb3J0IG9ubHkgdHdvIGRyaXZlcnMgZm9yIEludGVsIGFuZCBBNjRGWC4NCkV2ZW4gaWYg
d2Ugc3VwcG9ydCBvdGhlciB2ZW5kb3JzLCBpdCB3aWxsIHByb2JhYmx5IGluY3JlYXNlIG9ubHkg
YQ0KbGl0dGxlLg0KDQo+PiBXZSBkb24ndCB0aGluayB0aGlzIGlzIGEgZ29vZCB3YXkuIElmIHRo
ZXJlIGlzIGFueSBvdGhlciBzdWl0YWJsZQ0KPj4gd2F5LCB3ZSB3b3VsZCBsaWtlIHRvIGNoYW5n
ZSBpdC4NCg0KVGhpcyBtZWFucyB0aGF0IG91ciB3YXkgaXMgbm90IGdvb2QuIFRoZXJlZm9yZSwg
d2Ugd291bGQgbGlrZSB0bw0KcmVjb25zaWRlciB0aGUgZmlsZSBzdHJ1Y3R1cmUgYWxvbmcgd2l0
aCBjaGFuZ2VzIGluIHRoZSBpbnRlcmZhY2UNCnNwZWNpZmljYXRpb24uDQoNCj4gQWxzbywgYXMg
ZGhhbnNlbiBwb2ludHMgb3V0LCB3ZSBoYXZlIGFscmVhZHkNCj4gDQo+ICAgL3N5cy9kZXZpY2Vz
L3N5c3RlbS9jcHUvY3B1Ki9jYWNoZQ0KPiANCj4gc28gYWxsIHRob3NlIGtub2JzIGJlbG9uZyB0
aGVyZSBvbiB4ODYuDQoNCkludGVsIE1TUiBhbmQgQTY0RlggaGF2ZSBoYXJkd2FyZSBwcmVmZXRj
aGVyIHRoYXQgYWZmZWN0IEwxZCBjYWNoZSBhbmQNCkwyIGNhY2hlLiBEb2VzIGl0IHN1aXQgeW91
ciBpbnRlbnRpb24gdG8gY3JlYXRlIGEgcHJlZmV0Y2hlciBkaXJlY3RvcnkNCnVuZGVyIHRoZSBj
YWNoZSBkaXJlY3RvcnkgYXMgYmVsb3c/DQoNCi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSov
Y2FjaGUvDQogICAgICAgICAgICAgICAgaW5kZXgwL3ByZWZldGNoZXIvZW5hYmxlDQogICAgICAg
ICAgICAgICAgaW5kZXgyL3ByZWZldGNoZXIvZW5hYmxlDQoNClRoZSBhYm92ZSBleGFtcGxlIHBy
ZXN1bWVzIHRoYXQgdGhlIEwxZCBjYWNoZSBpcyBhdCBpbmRleDAgKGxldmVsOiAxLA0KdHlwZTog
RGF0YSkgYW5kIHRoZSBMMiBjYWNoZSBpcyBhdCBpbmRleDIgKGxldmVsOjIsIHR5cGU6IFVuaWZp
ZWQpLg0KDQo+IEFsc28sIEkgdGhpbmsgdGhhdCBzaG9laG9ybmluZyBhbGwgdGhlc2UgZGlmZmVy
ZW50IGNhY2hlIGFyY2hpdGVjdHVyZXMNCj4gYW5kIGRpZmZlcmVudCBwcmVmZXRjaGVyIGtub2Jz
IHdoaWNoIGFyZSBhdmFpbGFibGUgZnJvbSBlYWNoIENQVSwgaW50byBhDQo+IGNvbW1vbiBzeXNm
cyBoaWVyYXJjaHkgaXMgZ29pbmcgdG8gY2F1c2UgYSBsb3Qgb2YgdWdseSBpZmRlZmZlcnkgaWYg
bm90DQo+IGRvbmUgcmlnaHQuDQo+IA0KPiBTb21lIGNhY2hlcyB3aWxsIGhhdmUgY29udHJvbCBB
IHdoaWxlIG90aGVycyB3b24ndCAtIHRoZXkgd2lsbCBoYXZlDQo+IGNvbnRyb2wgQiBzbyBwZW9w
bGUgd2lsbCB3b25kZXIgd2h5IGNvbnRyb2wgQSB3b3JrcyBvbiBib3ggQl9hIGJ1dCBub3QNCj4g
b24gYm94IEJfYi4uLg0KPiANCj4gU28gd2UgaGF2ZSB0byBiZSB2ZXJ5IGNhcmVmdWwgd2hhdCB3
ZSBleHBvc2UgdG8gdXNlcnNwYWNlIGJlY2F1c2UgaXQNCj4gYmVjb21lcyBhbiBBQkkgd2hpY2gg
d2UgaGF2ZSB0byBzdXBwb3J0IGZvciBhbiBpbmRlZmluaXRlIHRpbWUuDQoNClRvIGF2b2lkIHNo
b2Vob3JuaW5nIGRpZmZlcmVudCBwcmVmZXRjaGVycyBpbiBhIGNvbW1vbiBzeXNmcyBoaWVyYXJj
aHksDQp3ZSB3b3VsZCBsaWtlIHRvIHJlcHJlc2VudCB0aGVzZSB0byBkaWZmZXJlbnQgaGllcmFy
Y2h5LiANCg0KSW50ZWwgTVNSIGhhcyB0aHJlZSB0eXBlIG9mIHByZWZldGNoZXJzLCBhbmQgd2Ug
cmVwcmVzZW50ICJIYXJkd2FyZQ0KUHJlZmV0aGNlciIgYXMgImh3cGYiLCAiQWRqYWNlbnQgQ2Fj
aGUgTGluZSBQcmVmZXRjaGVyIiBhcyAiYWNscGYiLA0KYW5kICJJUCBQcmVmZXRjaGVyIiBhcyAi
aXBwZiIuIFRoZXNlIHByZWZldGNoZXIgaGF2ZSBvbmUgY29udHJvbGxhYmxlDQpwYXJhbWV0ZXIg
ImRpc2FibGUiLg0KDQpBNjRGWCBoYXMgb25lIHR5cGUgb2YgcHJlZmV0Y2hlciwgYW5kIHdlIHJl
cHJlc2VudCBpdCBhcyAiaHdwZiIuIFRoaXMNCnByZWZldGNoZXIgaGFzIHRocmVlIHBhcmFtZXRl
ciAiZGlzYWJsZSIsICJkaXN0IiBhbmQgInN0cm9uZyIuDQoNClRoZSBmb2xsb3dpbmcgdGFibGUg
c2hvd3Mgd2hpY2ggY2FjaGVzIGFyZSBhZmZlY3RlZCBieSB0aGUgY29tYmluYXRpb24NCm9mIHBy
ZWZldGNoZXIgYW5kIHBhcmFtZXRlci4NCg0KfCBDYWNoZSBhZmZlY3RlZCB8IENvbWJpbmF0aW9u
IChbcHJlZmVjaGVyXS9bcGFyYW1ldGVyXSkgfA0KfC0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KfCBJbnRlbCBNU1IgTDFkICB8IGh3cGYv
ZGlzYWJsZSwgaXBwZi9kaXNhYmxlICAgICAgICAgICAgfA0KfCBJbnRlbCBNU1IgTDIgICB8IGh3
cGYvZGlzYWJsZSwgYWNscGYvZGlzYWJsZSAgICAgICAgICAgfA0KfCBBNjRGWCBMMWQgICAgICB8
IGh3cGYvZGlzYWJsZSwgaHdwZi9kaXN0LCBod3BmL3N0cm9uZyAgfA0KfCBBNjRGWCBMMiAgICAg
ICB8IGh3cGYvZGlzYWJsZSwgaHdwZi9kaXN0LCBod3BmL3N0cm9uZyAgfA0KDQpEb2VzIGl0IG1h
a2Ugc2Vuc2UgdG8gY3JlYXRlIHN5c2ZzIGRpcmVjdG9yaWVzIGFzIGJlbG93Pw0KDQoqIEZvciBJ
bnRlbCBNU1INCi8uLi4vaW5kZXgwL3ByZWZldGNoZXIvaHdwZi9lbmFibGUNCi8uLi4vaW5kZXgw
L3ByZWZldGNoZXIvaXBwZi9lbmFibGUNCi8uLi4vaW5kZXgyL3ByZWZldGNoZXIvaHdwZi9lbmFi
bGUNCi8uLi4vaW5kZXgyL3ByZWZldGNoZXIvYWNscGYvZW5hYmxlDQoNCiogRm9yIEE2NEZYDQov
Li4uL2luZGV4WzAsMl0vcHJlZmV0Y2hlci9od3BmL2VuYWJsZQ0KLy4uLi9pbmRleFswLDJdL3By
ZWZldGNoZXIvaHdwZi9kaXN0DQovLi4uL2luZGV4WzAsMl0vcHJlZmV0Y2hlci9od3BmL3N0cm9u
Zw0KDQo+IEFsc28sIGlmIHlvdSdyZSBnb2luZyB0byBnaXZlIHRoZSB4bXJpZyBleGFtcGxlLCB0
aGVuIHdlIHNob3VsZCBpbnZvbHZlDQo+IHRoZSB4bXJpZyBwZW9wbGUgYW5kIGFzayB0aGVtIHdo
ZXRoZXIgdGhlIHN0dWZmIHlvdSdyZSBleHBvc2luZyB0bw0KPiB1c2Vyc3BhY2UgaXMgZ29vZCBm
b3IgdGhlaXIgdXNlIGNhc2UuDQoNCldlIHdvdWxkIGxpa2UgdG8gYXNrIHRoZW0gd2hlbiB0aGUg
aW50ZXJmYWNlIHNwZWNpZmljYXRpb24gaXMgZml4ZWQgdG8NCnNvbWUgZXh0ZW50Lg0K
