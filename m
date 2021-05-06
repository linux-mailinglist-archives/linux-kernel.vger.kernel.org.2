Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641433750F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhEFIeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:34:03 -0400
Received: from mail-vi1eur05on2112.outbound.protection.outlook.com ([40.107.21.112]:35809
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233568AbhEFIdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:33:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELqUp+iyzKuayPjAwXhYkxfDsYXN/90F0mh8B56ax7AUBKacG155zorPRlW+rt2L3i6hbZidYLwbJXri41scE03uW1W9QdASw48AIQ5RCKMdFnaXD/sMGFCpyFDsYj02kyah8j0ncjzyUcMzPbiiHAIsU5Iw8eaqbuJaVVVA31iJhfi4XEC7Htr9oA5jN6O0djLxFHnhpG2ZTmGU5fIwRlzKwsk2+wYsLyrYlNxZyWyzDwzZh8EhT79ySsoskYveSs2mnv8V3cPijrDWwqthqd6jEPqSAlLvFRnq2e0L7VKUa5UwI8gulrATjznkLHj7Kebw21FXHfnOTQll2o8mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+so1Y+X9gnFoTIK95vbpd1Bibk73V/vw9UtDeWj9SQM=;
 b=JeVd0UNoFdMo8eOzuShbAeY9oSUY1UcK7QbtW1wnbg/x8oRMLw4FIYy5dTzGLvllKtaSxKlNgG2C3GzqJX7iIfwgq7CwMukoMsuRb3ILpgS+AqhNXZYqBI17UX1eH9371qr52Dru23zfiZ1ttFxrOsOInSM0LltAFoYgbEGjcfSGieAJJGke7H3dks47LhtmPVnlzzCQMaIbHqd5ywvJVNnPWIqrnSWP6AlxZRKF72txX68x+epUw2drvU1LlP+dXWgOMhq/AMZDIWC2d1QTm/D+FTJJtdmiHCNN2ytJmtoDWjCpmIQ16+NKZ21DAw686TCcdMKzO43Yb6LOeOGXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+so1Y+X9gnFoTIK95vbpd1Bibk73V/vw9UtDeWj9SQM=;
 b=jWrHhKfMB7jd4BQmAQUXD1SXLUdGqBe1TBSYIqHdnpdYQtrwPSHFvvAPkEGpGxkviG+p7B+wTQ0T2niDvztmflCjdK0E0N/a5pIrhO/IqSvdUrCkm79zGK1Kqxg1C0BUmpjtU81XVDTJba0ibJh/W1vHZlEBOQkBX8x2emxnfHI=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 08:32:32 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 08:32:32 +0000
Subject: Re: [PATCH V2 00/13] soc: imx: gpcv2: support i.MX8MM
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <3c5ef283-0895-05ab-7568-0d108b761008@kontron.de>
Date:   Thu, 6 May 2021 10:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210506010440.7016-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.180.42]
X-ClientProxiedBy: AM6P193CA0113.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::18) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.180.42) by AM6P193CA0113.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 08:32:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a688bdf9-5151-4773-a4ff-08d910697d5c
X-MS-TrafficTypeDiagnostic: AM9PR10MB4322:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4322297370ED679F4636803AE9589@AM9PR10MB4322.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+JvYibHBz3+xJ5eyOjyOw5PW3fpS3i2ovBqem/onrqALe8UqEGL72Pj7oxzLHmDFl0z0qkKrFzAv+tGYEsgPETliOQxZYEDpoaDYdGi/GwObG5dAnzIHwGWM9GL1KunTGZGGPHrG7yajDIhMfSkNY7WG4jvidFXxswBbAv7Gl9XWGcMVwJvweVHSTFddIAnuwW+HDh6XabreXNfc6pnPuAkYNYq5GSLabIWHreyp4yX7nQB5yMQm3yl2OWNEQ4W20Gsto1mhHQTdMeCitorJvBZ4Y3SdW6WenggzL9Ph/bmhMf9dWHw4+COr/Jed8W2tRSB5ymhZdzIwOQ4CWJLSEbpof7v9SrnqFEh4uWwIbyBAFXC//U4zoMqvX9t+rXXjtnv5ObsrQ1pf5CyVgois955/mj4KhSHWgShZ3+N60jUL05dAHrFMzpt0TXxYDsx0rMLSXsLQM4C9iEzUV/3fYvGPmULNuns/yxt4+aGbvSzuYlKbVfQyOYM5OV8YhuXeDoqGo0LKHTjgnUdtSyOEyCROTcxYpAYWyhnabaBw4gh6Fm5laBXy1a+7lTLLiNaehHqxstG7dirnk5QRGpliZG3Wa/ZMYso1LiXM6cG02z1XzaIkhCHGXWdlmL0gXTLL34Q/01UW6XQw8+/51l1tH4acy4ifTEUebZx0dX176ExeAaooPSCnnLshNotgmhn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(366004)(376002)(136003)(86362001)(8936002)(66476007)(66946007)(66556008)(316002)(8676002)(7416002)(36756003)(6486002)(31696002)(4326008)(478600001)(2906002)(53546011)(956004)(186003)(83380400001)(2616005)(38100700002)(16576012)(26005)(5660300002)(16526019)(31686004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cjZYeWwyYXFUbENocUY1bncxT2IxQzZ1aUdmQjhHMEVxbVg3K3gyN2FFcWFF?=
 =?utf-8?B?L3hyM2RRN1VoL3JQZlg4UHhYRC9jRTROOS9qenZ4MyszazhvSS85b1o2citK?=
 =?utf-8?B?dXFWVy9Ua1BVVE5nQXNwTW14ZURnR2JoM25BTC8vT0dtNTRnOFp2REl0eFVO?=
 =?utf-8?B?WWNqQUJLazVFQy82LzB0ODFDR3cwWENOZTB3VDEzNWJKQ3RJOHc3eno3QW9J?=
 =?utf-8?B?OGxManRNZGFsNHFSMURRWTBKcFNTM2VJeVFEUlFYbmZ1K2dKVFdxalEyUHpT?=
 =?utf-8?B?UGt6UVIxaS9IdjFzVUNTUnpBRmlMVm01Y2wvc0ZxZzl1UkUyVFZzUzJjcmJw?=
 =?utf-8?B?b2pjdVh2UkVLNnlrYS9XWncvVEdVb0RNenF4NXF0N1ZBY2dSeTY1OGdGQ0Rw?=
 =?utf-8?B?N3UxME9aM1l5NXBiNVpWb0piWDlOZ1dFeDVHWml0UUcxN1RXMEY3ckpYNGRM?=
 =?utf-8?B?YWsybDE2WUtOSkdXRzVOL2pzNzlKTTVHM2JWNGQ0akdZbSt1a2tCR01KcUJQ?=
 =?utf-8?B?b21NdUhUTHBvbWljSDRadFRXQ0llYTd4akpsVktSYlg1d3AwQzFKQWxoSVla?=
 =?utf-8?B?d0ZSd21iaUoybWVyRHNlbGFRc3dxaFFzSFdEYzBuNW8yeUdRS0VrZitYU05H?=
 =?utf-8?B?SXBKZ3JvWXhsSzNuejZYQXVvYVdvSjAwdnF1N2FreU9GMURnSndiMFVCRktE?=
 =?utf-8?B?M2dhYVN3eWc2aUpyenYrSm9QZUtCTDRqV0pyWTVZOFVoN2FlUFliZXI5VFZk?=
 =?utf-8?B?RFZQT09QN01jK00zTlVhbjIrWi9IVjJVUFdjVDl0eTc5VGFUam9xNXA3R1li?=
 =?utf-8?B?ZW5GNWlKWGdERFBMcnNmcWtjSUtER3N4dHR0WkZkSm05TGx4YjNtc29Ta2ll?=
 =?utf-8?B?UmVadlVDVkw2bWF0czBEc0d5QnV4VFVLTEdJUENycGNYWi9wTzdBb0NYNk84?=
 =?utf-8?B?THZ1djQ5QjFpUG5jUzd3OU91UXlVd21TUWZEQXhWS21qd1E0UEZUQU4vcUcr?=
 =?utf-8?B?STRRTWl6NkNtdmorVW9QREtiTC9aM2JkOEdlTVpjeUppeHh4THZtVnVWNGh4?=
 =?utf-8?B?ZGdGWWptbVU3SnhiOG52ZndKNjZLZy9TdHdnQzdCcmhZRkx2VVUzakdJV2NM?=
 =?utf-8?B?L1JIejVMdGJ5eXZQWWNRVU1Jbi8vOHRpKy9LdmxnSlhLYUNpUmhoVk9JOUJR?=
 =?utf-8?B?VUZNUldRQWR5aUZrWDdYQ29xT1JiSmNFV2hKKzBFc0xOMnh5ZkRmbXlvbXh1?=
 =?utf-8?B?c0ZGTWQ4OHl2cWErYkl2Y3VWS0NOUGo3TkdqakRrOXhHWHllTlhibEw3bUVu?=
 =?utf-8?B?LzBBcUlBVXprYUw5SnUyRnRPVTU0YXB0RGZmQS9OVUJTL0Q1enF1WlJ5aVBM?=
 =?utf-8?B?S1E2OUYyclBVM1NjcUM2NlBoT2tZSmtGOGpaRUM2dVFGMmlFWjJyMzA4VC9i?=
 =?utf-8?B?R01yYy9qSDg3eFlwd2V2cHZhYWJicCtRNm1yK3pLQWl1L1Z6ZEhoU0lIMlFX?=
 =?utf-8?B?dFYxZnRXdmpmNU12Q3BjVWZONWFwNTVGNkJiMkMzR2c2Yk55T0Q1OEE5SGlo?=
 =?utf-8?B?YWwva3JhSmM2Z1FRcUN2UVVOMFljRU9Ja1hDeTUrclFTOVRmcCtqUkRzbzRS?=
 =?utf-8?B?SmVEWkJBWVRKY3pZTVkySHM2dTZCdW5CVFFzVDhlcHgza0RsU1lFTXUvclMw?=
 =?utf-8?B?ZkZUTDBiT3hIczNhNGsyMEtpMmwrM2U5QVhSdDJmbjFuREFVYVgrenhNenZl?=
 =?utf-8?Q?WM/4dI7jJjJk95CABqqvp30mjjxwBiGZJYFXCaT?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a688bdf9-5151-4773-a4ff-08d910697d5c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 08:32:32.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWRWlF7flmNxBWoEfqDt3YSvof1JFL1b7I1AcIyZP4A+IgxVPqNHH2TptMFljn4YdOaufGAWcw5jHdgyz6o1mtZSwAwaSROqIUWUTcpXDrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4322
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 03:04, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> 
> V2:
>  - Add R-b/A-b tag
>  - Merge V1 patch 13 to V2 patch 6
>  - Drop V1 patch 15
>  - Merge V1 patch 16 to V2 patch 5 and add comments in patch 5 to explain
>  details
>  - Add explaination in patch 8 for "why the resets are not defined"
> 
> This patchset is a pick up Lucas's gpcv2 work for i.MX8MM and several
> minor changes from me to make it could work with i.MX BLK-CTL driver.
> 
> Thanks for Lucas's work and suggestion, Frieder Schrempf for collecting
> all the patches, Jacky Bai on help debug issues.

I tested this series together with the BLK CTL patches by using the GPU and the display stack. Everything looks good to me.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> 

> 
> Lucas Stach (12):
>   soc: imx: gpcv2: move to more ideomatic error handling in probe
>   soc: imx: gpcv2: move domain mapping to domain driver probe
>   soc: imx: gpcv2: switch to clk_bulk_* API
>   soc: imx: gpcv2: split power up and power down sequence control
>   soc: imx: gpcv2: wait for ADB400 handshake
>   soc: imx: gpcv2: add runtime PM support for power-domains
>   soc: imx: gpcv2: allow domains without power-sequence control
>   dt-bindings: imx: gpcv2: add support for optional resets
>   soc: imx: gpcv2: add support for optional resets
>   dt-bindings: power: add defines for i.MX8MM power domains
>   soc: imx: gpcv2: add support for i.MX8MM power domains
>   soc: imx: gpcv2: Add support for missing i.MX8MM VPU/DISPMIX power
>     domains
> 
> Peng Fan (1):
>   soc: imx: gpcv2: move reset assert after requesting domain power up
> 
>  .../bindings/power/fsl,imx-gpcv2.yaml         |   9 +
>  drivers/soc/imx/gpcv2.c                       | 542 ++++++++++++++----
>  include/dt-bindings/power/imx8mm-power.h      |  22 +
>  3 files changed, 458 insertions(+), 115 deletions(-)
>  create mode 100644 include/dt-bindings/power/imx8mm-power.h
> 
