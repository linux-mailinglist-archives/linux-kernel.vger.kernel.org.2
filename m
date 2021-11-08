Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A564944789E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 03:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhKHCjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 21:39:36 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:59981 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhKHCjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 21:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636339011; x=1667875011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xxku4OvoJubBGEspxolXlLiAUz9P4uNP1Z41mJ7CnDs=;
  b=t9e2QFrU0fmf0Oudypjjva8Jb7RPlgK1tzljCXAJcNQ6EhHcCDjr0Smv
   RNWTNMg/n2a8zkQWeCq0wKRsiGsw1C+E64ewu4ly4HvMXUR8KSF9OutTY
   MhPdP53aSOktlBkP+AZwOzgPVItPGxqOQn+mVXVy8rSP7VVeqwOjCraSP
   2mK10z7KUycixg9Yi/Ae/kFE1yYp2bykYn5Oo6EU8nxs5yixSsIsfstMD
   SJSThbkzobR79LKzkGVTpnfmPNLakVGP9FA7V3O2fS/l285N0S6EMhXcb
   OixDG4jAGeupbuqx3bjqPZfKIRW8gHw22Kh+uAE41XN2aa9neEClExpJy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="42923822"
X-IronPort-AV: E=Sophos;i="5.87,217,1631545200"; 
   d="scan'208";a="42923822"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 11:36:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zndve8TpIDgTpFXFNnzwx7xHE3Sdz/hb0QOBJV7oUjWhykMbitdxojm5K9pE8yp2jg8r400tUn0pic859D+GHQiIph5hDwnnaouXcXlskbobAP8BzbWJ6IrTD9tpx9dJJsI3mgUvtJR/evckf0XwYQc0/aDxbJjhGdn5oCleea7gSMov1dN8AK7q45qWNdU1BWAy1yK+XXY57WHpPFGzbU9qn29/SqMdMPOSof+KpTtA3fMdMcsU20/o/V3sLu3UwqkfkaAzaRIcElXfkagPVtipSI26CuazvT3wyUenSvSrdphXPqqdJ1RZXArtR8gLiEW/Xub8IlqWECEbcwcTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PF1Mj9z+ISWfRd/8E7qb2MkXiUc2Jedkybc9kwY85A=;
 b=ejGY3+txa4c1BBmGZemPwlAAoxbt1KhJtyRlBK67TRTjEos41r+RIAgC/8l8TOgpmWNUoU8jUyHQ+1gYx4mBg5PXgqpOPb20+3uKpnm2bjlvfNTww+d0nkNFMlhGTJ7mQecLv/4r2BzwiZvk0QKGzR/bh60YpS2Lh9UcC5BO41UNZM95v78mY0F0e9XUAq2tssdNkM9bHuG1913ofdhSv9Ju/HQ1mQT2Ma3Yl1/DRwlwpmmmmuewBTBIogYfwJ7NPdRnhnVANN/Qz0Qlne15+7BTOlw1FK1g9pNZ56GZPVUUTk1/JsIc5iahjrSr/W73tEZvvbCEaZZxRkhONejPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PF1Mj9z+ISWfRd/8E7qb2MkXiUc2Jedkybc9kwY85A=;
 b=ZW8Pu6MYNnxCW1FIcYEVlZpJmEr8dQMrmb7inCf8HmaVoMxDw3GQ8P8G0SaIVEb9Yw+WcuNEIAKZsgwLsRHOdd+phRcb89tSnrIqWGLF5Bm8StXdU42Vr3d7/itwLd5tHCEKffOJ9lPedt92tbFsLureCRPGU0LBUxNhmigWzbw=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB3073.jpnprd01.prod.outlook.com (2603:1096:603:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 02:36:44 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124%7]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 02:36:44 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Thread-Topic: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Thread-Index: AQHX0Tvqcmg6rBpliUSJLBUQh9tTC6vzmy8AgAVSNkA=
Date:   Mon, 8 Nov 2021 02:36:44 +0000
Message-ID: <OSBPR01MB20375EEEA0B9EFBD3FAF853180919@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
 <20211104171012.GC174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211104171012.GC174703@worktop.programming.kicks-ass.net>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ODIyMTk1NmItZjRhYy00MDg4LWFlMGUtN2Zi?=
 =?iso-2022-jp?B?MzY4MGZhZGFmO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTEtMDhUMDI6MjU6NDRaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12837968-41e1-431d-bbcf-08d9a2609a82
x-ms-traffictypediagnostic: OSAPR01MB3073:
x-microsoft-antispam-prvs: <OSAPR01MB307365FCF01235D829402F8D80919@OSAPR01MB3073.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zedMG6Smi/7hc+w6HgVyg66wR5EhFDEp1gjpxSetngjtN4yHyf+5hsY7j3KuiEyNLaD+omrhlOh9v0nW1liOqLFtZ6FDP3Ub6+1xL8ekEJg5TcKBrpj45y7+JhCKXLufeqEdTXS9yHs4x2ArRjYTBew7/ocMWXOQX2bi3TqspSDHrckt7y5Wd6kD2hxfFEW0njM97tI4PDdPtGnWtZ65HUCLPzVl4zx8YYxRhjR1o0VDMHHFTCv1b4/uOq9geE61orY17qh8MZI5srx+2BoyKCttDBZLVmj8Zvg+4VV0pAMeP7ibm86HksKShQBw0YG9H09wcqrd6c5PXfoEC7sGfev03STsIiPYcOuJAWpXREIoqCvAZMocrXCtkjepQBKXJk9oW3yYx+m08Z/n9QP4cJ2eKSXz7lkQVsKNSnYeowKG0LMAxra/IZkb/22JqhsEWpZbDp4GNgyeMZzplS7ysklVL5xNMyEraAfzL70NGs0jAMczMTi4Enj+VQzGtiEkRQDqwEbrruMF6AUnL2DT469ht3X9t/sxVtMOCNM6kvUjWNnzLdI/uxqSlz2bgvucjOUJRWVZMSYUsacdPTkt84bYHkrPivD9+M6ghImsSxYWsObGRFKDuuT5fUScbgTVyrSIh/gYyl3qyEFvdnJoYDh/Nnf5W8rloz3gmY8jy4TGOUjxndjAE+/ysBUs+42GUMT+iOomajxFHtGwhtk5GA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(6506007)(86362001)(54906003)(8936002)(2906002)(85182001)(5660300002)(33656002)(71200400001)(52536014)(7696005)(8676002)(9686003)(66946007)(6916009)(76116006)(38070700005)(7416002)(66476007)(66446008)(64756008)(66556008)(316002)(186003)(4326008)(508600001)(122000001)(38100700002)(4744005)(26005)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YVdDemZKdnRxcDBFckphVnY2R3dNclY1eWZWL1EwaE5XclUvR3FNOXhQ?=
 =?iso-2022-jp?B?OXVhdG9NYkFKQ2pRbWR1N0VUK0FwRFg4RnpxcWVMejVGVEpRN1QrMVZo?=
 =?iso-2022-jp?B?bDhqdGJUTmxyMUhKcVVKNnRvTDFBRWlXZ3dwUXphOVpQRWxRSU5PRmRv?=
 =?iso-2022-jp?B?U1g5bkFCdXdBNUZWSDl2dlo5d0g4YWxMSCtkeTFOVWRYNWVSZTU1V2tp?=
 =?iso-2022-jp?B?M280K2dRMXMwNnZmVW0wMVlUYmFnQXpCZURWT3Yzd3RMbFg5VWx5Y09v?=
 =?iso-2022-jp?B?ZlJYbzFHRXd5YjVSYUF5YmZhdSt1bUNSa3Zxc0hvQnhnMFhtVktHVldu?=
 =?iso-2022-jp?B?Mm11cVNrajdKdVdzVWJ0SzhtL3ltbHBXZHhKUVcwdDZyVUJnb2hxSDNs?=
 =?iso-2022-jp?B?RVJkeXBQcEVmL2IvSy91b0tOQ1VPdjN1QnRNbHBqU2pRcGZnbXRSd3BJ?=
 =?iso-2022-jp?B?YkpDZ2NZaHFNUGRtdUQxdjdjOG5ZbVlEM00xd2M1a3dHeUkwVHpjNkRS?=
 =?iso-2022-jp?B?WDFLR3Q1UnJZZTVTTWlkTjRYRk03RG42bE95b3lmTHRySkpCbHN5SWQy?=
 =?iso-2022-jp?B?UFluSXBqdWYzWndVWUE4bFNCbnpyQ1FUYWV4cGE2S29kVTBIQ1hHRTBG?=
 =?iso-2022-jp?B?ZDFYQ1lDUHdxRzhCdyt4dUtYcnRQdFZPRmxDTk1DWnJaK3h2aGxybll6?=
 =?iso-2022-jp?B?bWNPZkVheDB2dDdudTl1NmFWUzY4QUxWUEh1VndWNjlsSlNOY1FtVXU5?=
 =?iso-2022-jp?B?TmlkVW0wVjRrRXBnR0I2Tmxxa1dsbkRDdFNOMTA2eU9SRUE2bnpLMWFH?=
 =?iso-2022-jp?B?MzN0aUxVNFVXQi8yb25DaHJ1Vm56L3haaFNDSldlV2htYlhUN0ZERWdF?=
 =?iso-2022-jp?B?MU96Sk94VFluV3dhL0IxQzhCWE1DY3BCM2M4Mk5oeFpBWVNwZDJsVytu?=
 =?iso-2022-jp?B?Ni91ek9wSTAxUWg2WnJ0TW5hK2F4Um9iQ2xRL0NRMFlsZkNTT1pvWWFY?=
 =?iso-2022-jp?B?ZWk2YTU5UjV6K2dPT3Mrd25Fci9VQjltNGNaUjZPYlBia2lCNFQwQklX?=
 =?iso-2022-jp?B?UDg4UkhMSVRHekhDeE9rUFZHY0xRVk9ZK2lOWkduVitQMjlXR1VlWngv?=
 =?iso-2022-jp?B?a3hMRWJscVBUQU1rVURodEVnVnNkZ1ZJSm5wSkNNZzZoUElGUENicHFI?=
 =?iso-2022-jp?B?dEJkcEo3RUpWU3RXNUJYQmwwS2lUK0cyeUY2QkthK1ZlQk1BMEZEcm5Q?=
 =?iso-2022-jp?B?blpaQU1HWmdXdGxKUXVnZlNWcnRJbC9zc3hGUmdGc3BQbE5NVXRsNm4w?=
 =?iso-2022-jp?B?a2l4TmhmVE5NL1d1Nk9yQU9pMDdkKzNmQm9LUlQ2S0E1c0l0Skpvcm9z?=
 =?iso-2022-jp?B?NHlwTDRkUGxkZGljOGFOYXlsUE1yQ01Ya09oZXJhc1FFenJDNERsR2tq?=
 =?iso-2022-jp?B?Zng5QVBGWnhVRVEzV0JMSXVGbFA0RFhIRnpHS0xKQ2ZkL3hoMWZ2TzBO?=
 =?iso-2022-jp?B?b0JMeUpqVmgvRVpBdWNob1RTTGVUM3pMOEZJK3BpcEZCQmVWTUpMNDNy?=
 =?iso-2022-jp?B?dVBrM3RaZWRIM21vdGZYOW1ndkM5empOUzQ0S2YyY251K05zU3l6N1Va?=
 =?iso-2022-jp?B?VVU4TzIzTXpYcmZhdjJEaDBlOVI2K1gyMlhoVU85UDhDekJib0pHQy92?=
 =?iso-2022-jp?B?bUovbDB6VDBzZWJ5aWJES3NqZnJUNUVNV0luZnVrQkpzYnlXQW01OEJL?=
 =?iso-2022-jp?B?a2Y4NjJHZmUySVhhNWhZWTZEcW9zdnNoVStpVnc3NE9peXNQNVJZZE0y?=
 =?iso-2022-jp?B?amZrMVJIMVpQbnEvbm1aeUpLZ1JHRTB1eWNldUdmdmw1UUU3U1hybEtw?=
 =?iso-2022-jp?B?dnRZV0ZtZTRGOEhsVUlqYVVma1JaY3ZaS3ZRbkt4NkxpVnc2ajVzU1Nl?=
 =?iso-2022-jp?B?bjh4OE9NR1l1WXU0cEQ0SEo3WVVuQ1dJS3M2MmhiZDFPVUFvK2JNT2RX?=
 =?iso-2022-jp?B?QklrNlE3b2tSTDBqUG5WV3BOZjJOZHhSbnNuajN4WFovcUFtWEFBUDhp?=
 =?iso-2022-jp?B?NmxrYVdhYmltOEJkYWw3aU5zc1gwNUIrc3F6QU9DWUZzVERtR24rZVhh?=
 =?iso-2022-jp?B?TDlobWRmTUZxUDUxUkUvaEFiZWdTQ2VuS1BOcXEydVMzbFBKWTF4RTUx?=
 =?iso-2022-jp?B?bE93OG1kY0o0VjVESFpkcVI5aHdRb1MwR2FSdzFEeE13TWl1N3Vsc3Mr?=
 =?iso-2022-jp?B?QjlKYmV2RCthUTB6cStDOXo0TmV3eFhiL0JvQnpxbXphYmRvMkVnWElk?=
 =?iso-2022-jp?B?Tlk2RXJYM3Zpb0ZTNkprZUEvaXJFZDRubmF0d2plOFM0MUp4MFNFeXNi?=
 =?iso-2022-jp?B?UTladC8ybWhBUFZudCtndVRKRXJNUWFDYVhIUW5UOVZ0UUNTVnRjSkFB?=
 =?iso-2022-jp?B?NHFhSjh3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12837968-41e1-431d-bbcf-08d9a2609a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 02:36:44.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maHW2PlnAMbBAEUe3Xl6IVoA+BgQIopJE4fZKksLmQ3Pk8ISB7XWSBZG5rs0Y1SsSZ8VEFyZE5Vo0PE/cpc/dhVA+7L7mnjEjOUMrit9Fco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your comment.

> Here you talk about applications..

> Here you talk about CPUs..
>=20
> How does that work?

Does your question mean how users tune their applications? We intend
to use it as follows:
1.) User tunes the hardware prefetch parameters of a particular CPUs
    via sysfs interface.
2.) Execute the application bound to the specific CPUs set above.
