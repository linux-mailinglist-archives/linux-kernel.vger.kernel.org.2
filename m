Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763D944AAC4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbhKIJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:47:18 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:55693 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244968AbhKIJrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636451072; x=1667987072;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lk7Twvo212qIewP0WzJ9JLrJdJQ+a3C+sTziYCo17yA=;
  b=WHyd/WnOud92rqiy9vr2Cyf7UAPu11W+5TgE2KYtmp0VDMraAxQ5fUAp
   /rhuxk+mWYX81b/888OCVWTtVXWUh/5f9IjkPJ6I4raEz8UzKYRTKLhvO
   7xfvE5FsRsRCLai00i5PnN3oXvvHj6ySWd+B/SvDDxo5R4mk4ZowlXJuI
   rsTm1nKbf0UQu1QPUpcgCJUIKko6/ZqHf7Fx87DWPS9QvZRge+ke3WE5i
   Sz3txCJ+zpYi5Zd8NVsgTp4L+V2a1x1TsSBLzIKGdmncL+T/4nOCCZTIj
   KUGppT7a6d7ejxseVsyylRbNvf2Y299xGjz/QK0UUNWGiutZkdlB/QcUJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="43958634"
X-IronPort-AV: E=Sophos;i="5.87,219,1631545200"; 
   d="scan'208";a="43958634"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 18:44:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADfPkQQxB+QDCysHp+JF9lemPExdp7KlFSwb1DbBwhcI9z5ojSgC3nkVzzv9tXUezDxE4R1FbTrunfm4/U08uJ7A8hx3YDYLZFQ8Eeoj16OpeE3mEzbesdYBeOrlsEdvTJcYWyD4haQksF/JO1K7Vh5WACPuO8iMyZNUYXP2zI+0i0Zh+N/2fmOK4Hpb3kSQveFVpubxiVD4lo4HyFqAI64VxaGbo9oVYVDz0xqGi8tsVE/43+hEt0VvYD5hUVwo/UeeqCK3oRXbDFGDGbPCo4Eh1q5vraUyGTR0qBU9AkcvY8lePDrQoS1rTWEdqN86Jm2vq2wXyGcCWQY5IDrB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk7Twvo212qIewP0WzJ9JLrJdJQ+a3C+sTziYCo17yA=;
 b=XqU2W8w81KpbK8c2DLa/3i5Tj15RJSKrKBajK+gSISUmB8wNiocfj7tUKokriqjByQLeN17gcNi0Huzby3iUykHlzn0YRz1wO1HG/OWHQOV6W9AKj8zzyP5k6N/fwu1NqwW+4K9U0qgLc+UReSwgBd7pQa+adNX34eOieCjlA01EiVCqyGBHFuFVqX3rgGAlrrVSZJteBmLhjI6UoD9FodROl7VLxk2FY9LHLBeTOZ+1udsworsTWa7sB907+EmjJSv1jNVAvwqietjZl+a84Py74eaB/GugIQvKWCL6epUW4DGlr1BEMq9+QSehxHI6bDHUQeObYjo9EjK5CggVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk7Twvo212qIewP0WzJ9JLrJdJQ+a3C+sTziYCo17yA=;
 b=inigINuUnzEdc9ayLqUlk2EGVhRvyuTuZlhm9teqc8RUVA0iRiHTt0RdS263zMkR/mQcZkw39aac/xHebjEZNzYPt6Zaoi4u6X8qTSHJIoIN2Z898zHcH8HqMx9wFDrbNoSvUr3rym4n8NNmkH6fP+2ZQ/t9JLoRNLk6Ugd7Tvk=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB2961.jpnprd01.prod.outlook.com (2603:1096:604::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Tue, 9 Nov 2021 09:44:04 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 09:44:04 +0000
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
Subject: RE: [RFC PATCH v2 3/5] driver: hwpf: Add support for Intel to
 hardware prefetch driver
Thread-Topic: [RFC PATCH v2 3/5] driver: hwpf: Add support for Intel to
 hardware prefetch driver
Thread-Index: AQHX0TvtFJxBKTmOz0StTWJRoV81zKv447AAgAIV1MA=
Date:   Tue, 9 Nov 2021 09:44:04 +0000
Message-ID: <OSBPR01MB20372BC4AF4B03A319F7C62380929@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
 <20211104052122.553868-4-tarumizu.kohei@fujitsu.com>
 <664cf198-55b9-469f-ebdd-c8fb436544d5@intel.com>
In-Reply-To: <664cf198-55b9-469f-ebdd-c8fb436544d5@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NDE4YjcyNjctODg0ZC00OWM0LTg0OTYtNzI1ZDQxMzhl?=
 =?utf-8?B?ODcwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0wOVQwOTo0MTozOFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b812cb93-2498-4cbf-ce8d-08d9a36577e7
x-ms-traffictypediagnostic: OSAPR01MB2961:
x-microsoft-antispam-prvs: <OSAPR01MB296168E58C6DFD57E727AC8D80929@OSAPR01MB2961.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2c/N4SarOnrihYBVdedDUD4Ed8bSenhzckB/I1MJ1Mh59tFi2PP6Pbuwgw+yXdk3TQUX1D+S4tcgvKHEEWDEyfgfO8bjTgmGdxfDpCGbEKQ84hb67hclNCItkSgXtin/RhNVW4Recio8o+KPLyAQhye+C9YlugpvcUFLY/7p2An9H/pXszV3jaRiO7UXptnUuv1PcNROPGZDZxFDBKOqEnq3oWcAopGAcTyTMNZskzkWQHuwqUUt2g48Xup5ZKsEjKBaQwRGrNeGNtTZ/NEJpBLoxo5m5/Qg6kmc0HOC0AUlOrl5EacHenDl26KAMiwEcmN4WfPvmc1Aq9HcQ8iiCRvQLaEdF9y0I09gDBDCCsbbiBqUZ2Jo11YVAj4CmYxnIya6fUq61+xQ3jqwiH9TpTfm7yCaM4ngbEXrBiYB8Ht7QAsJt9urWB8b6lDUZKC6S1z8rPBoALSWKIjkf3/8QnDycHx+DK3gMmJcA6WrhkD3jjLYHUta4fkQisK8pxSJ/6n8YOPTZZyE9ihtbOmgr4zG9fyakERQNgbTs9WCj3APxpdbv2BKaj+HSb26WXgAhozaDzuEBSqBxWjKCxUo2/1Gz1aR3VDrVHF3HmUaxAFDKe5NkHTO8S+9f9gv3uRgobGcMMtd3DUIa+bYnWdz9YsTR0JxbfVMxlAD9l8bKd0Oydr5puWKt8uAeUHrLkEkYxT9znTq3XPX7lvN7SRJJMxCWVHuNrpqHRa8EVREYnY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(8676002)(38100700002)(8936002)(508600001)(6506007)(110136005)(55016002)(7416002)(316002)(2906002)(26005)(186003)(71200400001)(76116006)(558084003)(66946007)(122000001)(64756008)(5660300002)(66476007)(85182001)(86362001)(66556008)(66446008)(9686003)(38070700005)(7696005)(52536014)(82960400001)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXRyUkNCcU4xa0x4SUtuZWdzcWhrS2lhM2VzR05MRU12Wnl2WlQ4cGdpSDVs?=
 =?utf-8?B?UVh3TnFvczJmSXFjU1Jqc2RPVUZIODNlUW5EaDlZWDVxWlFGdlRZTHh3QTFG?=
 =?utf-8?B?UWJXdnpuZk5NY3BTRWJsUkFJdWtacTlRdEVSQnBuWmxOVnBaV1c3STMzdWFH?=
 =?utf-8?B?L3NzbVBmeVc0eTZrcWtZbzRLMDAxMGp0SXFvZnJwT24zSU1YTW4yeEFKSUQy?=
 =?utf-8?B?alJneUM5L2JxSXhydDJrNXJHSDVSQ1ZMazhQSkRCc0ZrcnFaanRQTzRuTFlS?=
 =?utf-8?B?S1VWWHl5SWVXL2ozeld5eHBSTm8xNHJqVlBDNmI0N0ZrWmNwR2FCeFpMNjYz?=
 =?utf-8?B?b2N1K3ZyT1hIejFBSGxJZVJmZ3ZFeTUyNHcveFNEazN6SWFNYXV6L1lZS2Z0?=
 =?utf-8?B?YTZKRXV0MEJwVndKako4dG1mOXJnYVdpYlpSVEdOWWN1S1FHYTV1ZHhJajVS?=
 =?utf-8?B?bXAwM2VNRWNkYVNJWWhOY0hHdkxzUWpPV083eWVwaXZEazFTdndxMjJGSmlP?=
 =?utf-8?B?OHZjMENveThsdndyamtVTXlQVnJZMGxWRHVkVHlWSmpmenAwZElTL3JKNnA5?=
 =?utf-8?B?dTVpMDFtNnpYM1hDSGhXV3ZDSEZpZlI3R0hOaTVONGpCbmZER3JLckJlUE1J?=
 =?utf-8?B?c3NLSktRdDkzNXZOMjVWemswZDJLWlZRM0tjYVdRNGt4MnV6UE5aamltSUFZ?=
 =?utf-8?B?RGpCTDJkZjlUaGN6OHdxZnA4Wnp3aURqZDM5WUg1dlpvNldIbExsRWVZcktJ?=
 =?utf-8?B?ZHpnY0Y5VXd4V2U3QVI5VFlMSERYTXBxS3laZlZnRURvZEl4eEVVcWpEZUpH?=
 =?utf-8?B?TTg0WVA0UGhRL3FudTQwTGkvODNYNXB3Y0hyNXZuSFhiYUNYUnlxYUJjaDFk?=
 =?utf-8?B?ejBSQTFtYW5Wa1ptWEVBaVBvbXcyOTFDa1ZlSGxOWDZMak1XSDFJRVFXZlBC?=
 =?utf-8?B?LzhjZ2hPUVJWYStSVWxqUkEzN2kySUxjWmhjOWZXYm05VVhtODdBcXo5K1Qx?=
 =?utf-8?B?RVpVT2h6cWRuT0VmaFNnV1p0Vm1PWW1GL0ppR0czUXp3VnpwZ09HeTdhMklJ?=
 =?utf-8?B?dWNLRFlZWHp2eWhkbjNXd3R3ekdwTTZhcTZLdXdDaTB5bjZFN2JRRmtseHFK?=
 =?utf-8?B?V0x6TzJoVUdEa1ByRGlKU3dhL1RQd2llekd4bGk3Z1Q4dldwQ2FjWHdyQm81?=
 =?utf-8?B?RG01NEwwUGVTUzl1Z2ZTeG9GOVNJd1RGeGlZbXJ3cGN6SytrTFJMNG1tVzVV?=
 =?utf-8?B?UkV1VnhIS0dvOFNLdWVJTmRsN1RRZlo2SEpBWnZSMW12akc5WjJXdjJNaTVD?=
 =?utf-8?B?d3lrUlNUd1lZeUpVMUNqOTh6ZmZEYUhvdzhYREV5ZjY1L29aRktpS1FXNm5C?=
 =?utf-8?B?Rkx4SkZKNGtoM0lhcHRnaStQOVNkVXhHSml1NFNDQ1RuczNjR0ppdjdxNWc0?=
 =?utf-8?B?K0FmY3BuOFNZYjFEVy9GVHVTUW0wTkVmcDZNRHlzN3FCU2lqenV5R3NUMFlz?=
 =?utf-8?B?T0lFREpjNU1RanhlM1ZMNXZhTXJpUGd4cTRTa3Jld2RlZzF0MXhyUFBNcHJM?=
 =?utf-8?B?RFNSeGhQekFubWNMNXB6OVNoQ0JoN1JTbHlvL0lqelY2VG1UdlBpSk1YVTZ5?=
 =?utf-8?B?RmZuRlIvUjhNaSs5d1dyclNoV1pncUFoTTBzV3ExSS9zaUdoSDgrOWtWTUNx?=
 =?utf-8?B?NkdSbjZxd3B4RTdzSXdxaFZaVExqNnFaR3BsSG53T1FhL2JwM2dXUUFpeWNH?=
 =?utf-8?B?ck12eDR5UGVxcVBTMXh6ZEl5NmlWVXJJSWJHV2sxM1FwcW5uOEt1Zk5SZTU2?=
 =?utf-8?B?YU9tSjJ0a1RxTlNzM3lKYUpsZzVxL0V0WldDcHRJSVhQV0hES3ltd2JwSTdY?=
 =?utf-8?B?UkFFTmNSV1g1RVJDVTRxTjdWLytSTU1GMTE5SnVmS1dmWitlbjNrMi9wajhQ?=
 =?utf-8?B?dTBJSWZXbG9tRFArUUpzTWk0S1BweklTelozQkE3TklMYlFubTRmRlo3YU5z?=
 =?utf-8?B?cXhkTWtLMktnQkY4a293SkxlYndQcTB5VVo2NTdvQklDQ1krRVdOYi9MNm1x?=
 =?utf-8?B?SFZqbkNJdGp0TE9VODlKUEN1OWsyQWcyRGlXQWcrY0h5V2I1VTlKOE12MmxU?=
 =?utf-8?B?Q2Jodk1IYmJvcVJqWjRWS3RuTVBsUHdYYkJYUFdLMlFWVWhlQUllaXJuMUlK?=
 =?utf-8?B?RFVqenhNejhmQTcyK0VNclVCdG9uN0Nwb3JnTXBoN0NWVzIwSUxKYUlrMTg5?=
 =?utf-8?B?NWgzS0NiYWVJbXhKMWJyT244K1hBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b812cb93-2498-4cbf-ce8d-08d9a36577e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 09:44:04.8010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hlJ43u5q/IkbzwvJPi/neq5v6bmcsrNQbPMw4japXNTuFHDML/f5sJHWP+dTqlZ5O5hsavwAzx5XVRusYz9RhAJSRTGELgZoMBolpzUTy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2961
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBDYW4geW91IGRvIHRoaXMgd2l0aCBhIHN0cnVjdCBhbmQgeDg2X21hdGNoX2NwdSgpIGluc3Rl
YWQ/DQoNClllcywgd2Ugd291bGQgbGlrZSB0byByZXBsYWNlIGl0IGluIG5leHQgdmVyc2lvbiwg
dGhhbmtzLg0K
