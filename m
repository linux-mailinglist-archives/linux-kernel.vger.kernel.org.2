Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C993B3A13F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbhFIMPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:15:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44384 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbhFIMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623240827; x=1654776827;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=O+sQ9QR+Dwcw5f1E53g1MB1EKtsxCJ3TNQ9ukvl1M98=;
  b=HRMW5RJFIO9R3WK+KBKhbyWsXFHsV06b0hZ9m0dzJDZDxLIUFpeubIvB
   XdwU9z/L4xf7h75G/eH/BkXDQePzIiQTe0pu0EGGQ0QqAZCjvbfuGhPaO
   HZ5u1o6FnZxDfHgKwBZjiw6JUJQUWj7RDBtkpiZCc3ZIJIWeipJulRWda
   KfdEGZz1WjcfJknCXpTSGnEMcOVIvECGieC8WjK6I+DmQlYkNL+4mQolK
   e6cmSb3YLWNiZKp9uyJQnjf9rwB0+QOHUy27m3S8UiPR98UFuppMw8evB
   ec6C0UDu9gqYQfCOdgxU0fZUn/RzXYyX18lP2i9nsBm6Ou0/VTFw2U35i
   g==;
IronPort-SDR: qDvpY8r4QTYqknFQUsm5LVde0gcGQadDI8QQ13T3u1s4RP3dRUNPxDeqs64hFqc0qA8TU7BJxt
 ltcHPfP8W94rcshYKTEykPEarfba/3iofDfxIjXiL7vXsnnmpntg+mnDimqMRokTQnKtG7OdUA
 D2yil8Xk/UVgqbAoJj5QmCpJEGucIi5Nkgisd2zHSJSzDuKC+lUdck0Q5DyUbQJCojWtW77SeM
 Kn8oySv4ppRlHi3UmWjDW27qYTCqUAev8jlQE9F31j4XUloD+rQuRrJ2Q+jf9e9wm7Mb1nCjYO
 wP8=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="170575125"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 20:13:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTWmV4vC1zV0YqWn6fUCN1VvSVLt88FN2pY95Yxfrc92mpQeR8pGWNfYY73uXqp1bBXY1NwsC/39ND8ExJ4rU3TouZhF7y1iveP2k7x/NY6BgVx04BuGbFffLtkB1mCcyBPsUMDYQIovQCP98vKo5vyHqNqA8ve8/E3mWKB7CQ1sl0lD7T8IFx2mXLPOoePnpUuZj96CXnMz53lGm73aZ5MfyGq53g93HKpNLidAvhk7VCT8oqsqG7jIC0esny1ieEW9j4r8zNASOVD3ZhYBZoy8uPlnH54uEwrBlHOTQOUpX9MriPeMNXmLo0SepZOCE+7hz3luF51bixNpwPhKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtY3Tja3XPrKeKpN4/f54RHFt1//9h6CecA97NrsGQw=;
 b=MObTs5WtM5MhZTZ7qtCdVB+awkG8y2Lx3CRJ8vRV+J8GfTix2v19AAWFT6Xs/Iyr5QRI1UnmKU6Sq70OxEpNGZs6DTHfnd4yQbAXUJ62bvuK3Z3K9mGP/dw897CMNvJIDvjJKbDAwQjTiAx0+du6YKrn8dB21PMALV3fdtLhODlQLrl39Qyt/4kcN73mn2Ocn2OuYbi29WC8x5r/Ifb/qmYEzMZGgwFyTHOg8/WsFudxJ8lOyanHR2N97hNLxq6tptxihM2bRyLmy7Bg+3sjepIl+AJnwteVswFmQ1WlHDQSyuElQTWh62czUpN7pMUdOj1Wdc9y8MWhWsvm2PyBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtY3Tja3XPrKeKpN4/f54RHFt1//9h6CecA97NrsGQw=;
 b=I38d7vPu03RDMyWP1hhnwuwySAXtQnyjg46mq4a7LhbVKs5i0Gf4C51GtupB8WKf7hGdaVEu+XGh0ap3FSCs5vY4ciuxcKMCHVlNpTIImE54xZA667i+86IEh4inY1gh3o8Xue8BanWwh+/B5gCZGyAWo5+doc8AzwyKEWVdEcE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7794.namprd04.prod.outlook.com (2603:10b6:303:13f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 12:13:44 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 12:13:44 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v7 0/1] SBI SRST extension support
Date:   Wed,  9 Jun 2021 17:43:21 +0530
Message-Id: <20210609121322.3058-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.172.176.125]
X-ClientProxiedBy: MA1PR0101CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::22) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.172.176.125) by MA1PR0101CA0036.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 12:13:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9d19a99-1d36-4765-7f9c-08d92b400662
X-MS-TrafficTypeDiagnostic: CO6PR04MB7794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7794F6D454852C07D5959A068D369@CO6PR04MB7794.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqzEuVUB7/PW7GT681bqZsdRYpThqZcfxTGaIFXnegFOgrZWzf8BsPP8+JtkF5QSS0dWPn5XP/S6bOhr7Dn/Gexlfx0grldiqie3YDg93vGsVKOdV1GwC4Kvydh0xw54Bu/yNOfbj0kIaHjokOqY3+uZfPDQqwuURTUGWK0JSN47xLFHtLg8UZglQe66CO0yXhbgzOBCvB3Jf0A92sshAYqQG4mTFpM7hRDEf4zeEiKVudhxg+S1FJIdoP0Y2iaOfoVTZmQDvzS85U/Bk4PH9SZU5CKuA6YsZP/3ct8o9Wft8h9YXF95vtKVPDeNF7axgDvu0ahXpVaJfO7Y7y2Cys4SNAbgGiLCY9PZlYQ2HzEmChj1z7NXE9VWpw727WfgN4BW57RcnYshPcXSIRnF5UILMxRUSoUXVPRztBj1K9GtauYB/QAIYUa1pJtbzfmIO9DIfSYf34NjyBI4TcD2rz81/a6T2l0oM0UUTYVkxdLOoeRQwfvIybq3gzYd74akkFPKpMawjgLJNl2+tAej62ckdzlrpELk3MKuYP6vE8ac865MsYxWE6OEUeZmSwRHzLQ2jKYoEigDRmfXFJ2MlRklAd+St/4R4T2CdRJNtsPUUx0S03yLNkh6pOXfnA0lUrlv0HHbPaBmNry1th3LozREwuh2tRMXXfAzJlrewLiAkYkaLWAVPUY9E7uq6bC3d+QwuNG9Oxcx9o/S0kJgDeFlN6gYWbyV+jTYs0XLmZAXxBQk+Obd7oQ8JvZmATr8Zbs6wQSRtEeScQhlnyO15Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(8676002)(316002)(55236004)(38100700002)(38350700002)(110136005)(86362001)(54906003)(4326008)(956004)(966005)(478600001)(26005)(186003)(55016002)(8936002)(2616005)(7696005)(52116002)(16526019)(5660300002)(8886007)(6666004)(1076003)(66476007)(66556008)(36756003)(66946007)(83380400001)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?daBw3CZ8xtGSbZcxRxVuI1nbHEZHsoPOKauNXmNZjWnCwgcMZ6/bQctmNmFy?=
 =?us-ascii?Q?Q34sDRuQXFx/bNFBYtYr7V7g+Zs0L5AUrAQnp5kxwDifRiH4/MZMTYbkPwum?=
 =?us-ascii?Q?DSPD5JJUSwBdAyUlY0JP8Az05Eie5hNlozKwFDryGyYM11Y4UvsBLGgWleJB?=
 =?us-ascii?Q?aEIMK4WO27WDgUqIj6GnyFrxTW+Rm/4YjpCjQtavDZNex6bRWj1Nvvt8I0ZA?=
 =?us-ascii?Q?uQybcfr1OLuY8M/MkSmav6tinCqXpzd5n48LPEkXAqnyMM4edr3XuFrXXFIT?=
 =?us-ascii?Q?RXJxNs54i5sr25BNqxuZuis5B/zO2oPT0QsEbPUyPNQmsBe1qWBkiJC/Ego4?=
 =?us-ascii?Q?+tQyY4UbzDDP2c8GWbL7ijQoDlSImymQQMNNCvXQ8rdXRjfPRyh099JOZaCP?=
 =?us-ascii?Q?rfVRnFDzkjDpFQf9ajCftdadutXhMiEIiles23ptIkMdd8vp10Ss1vABjwAf?=
 =?us-ascii?Q?L5H3i29Vau/4IskH+ncBhswfoh0qW/E4A4/OOfWyQ2HU81utxC+CPUAdZH21?=
 =?us-ascii?Q?S3nSBAljzGp1kYfC+66v1FISUSc2WqUgKpdMeq9H8CIM7YaKf7nXu7EXeYZw?=
 =?us-ascii?Q?nmJzjB8dQord5Euv/utCTgynu4k0OBHeMQnyUeS485LGgvmhzKOXBZCtFCj0?=
 =?us-ascii?Q?iddd5KzQCo9f4Q2QHAF132mkMOKJpZOAvU/5LLO0KHsnw1BTyEw2L+E+21K4?=
 =?us-ascii?Q?idrsX9C3oDSYziq9DSTzxPzRqxhYVopj1lDMedig3F15o7kBJMEmqk8oH6cW?=
 =?us-ascii?Q?Gm71ioag1iSGA1aEbdfx8r2FyKnewX5jo0cFT2DkorgP92chDILVZN+HfDg1?=
 =?us-ascii?Q?xOS9Bp+KYdolPPn0PuC5gpRejdpWlZITQtNJonV0ocbI0N347xxPaEUmf02o?=
 =?us-ascii?Q?rEz1th2S9yxi9Gf+9AG+Y7HiJOHdxr1/4eyhnhUTH0p/EViC0LLcFpCcx8Qq?=
 =?us-ascii?Q?+zgVC2IMnXZVk9TWCNdTruNJkhGEgYTL7eRTpSsEfaVZh2F6mrcV72rrz2FR?=
 =?us-ascii?Q?4W5+txE1V0b5VLDATVZZyQOwwHLAaoyl21l1QyOgwOi4/MIuu1gtvWDSpnMZ?=
 =?us-ascii?Q?y5o4PGCcZD1Agsxnru0E1ndi4zZsY4p0kf+GrWOOIWpSJQlYEOhypAZRhfi8?=
 =?us-ascii?Q?mnVz84tHw+9oIDoPYnB7JF7KrORPp2PGUG1futCoChqviiLxeBHUqM2CLPYm?=
 =?us-ascii?Q?Fp/dt9vvaiDjHrQcDqczQMaph1G3NQHzfoEHwhcfp/czfFskqW4FPCddYPEZ?=
 =?us-ascii?Q?3/Zndt4hFNsSbmr1WAjXy14gzlSwUzMAyGFxpxPVPyNeuEw1T3bSMrRxmxNf?=
 =?us-ascii?Q?w9Fqef0ym8ovRxOdiIcqDMaJ?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d19a99-1d36-4765-7f9c-08d92b400662
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 12:13:43.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLvOJ18XdqpMQEPjNvU1UQ6Kezk1oLS2PXLl5fjxMXnkS2f/UPOzwy0iq21I+oyPSRgZXP2qoo1wYI+tTH0FRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7794
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds SBI SRST extension support to Linux RISC-V.

These patches can be found in riscv_sbi_srst_v7 branch at:
https://github.com/avpatel/linux

Changes since v6:
 - Dropped PATCH1 of v6 series because it's already merged
 - Rebased on Linux-5.13-rc5

Changes since v5:
 - Factored-out pr_info() related change into separate patch
 - Added cover letter

Changes since v4:
 - We should compare both major and minor number to ensure that
   SBI spec version is 0.3 (or above) for detecting SRST extension.

Changes since v3:
 - Rebased on Linux-5.12-rc1
 - Check SBI spec version when probing for SRST extension

Changes since v2:
 - Rebased on Linux-5.10-rc5
 - Updated patch as-per SBI SRST extension available in the latest
   SBI v0.3-draft specification

Changes since v1:
 - Updated patch as-per latest SBI SRST extension draft spec where
   we have only one SBI call with "reset_type" parameter

Anup Patel (1):
  RISC-V: Use SBI SRST extension when available

 arch/riscv/include/asm/sbi.h | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c      | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

-- 
2.25.1

