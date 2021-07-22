Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AE43D20F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhGVIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:51:36 -0400
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:1856
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231282AbhGVIvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:51:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAWWzAXTR7tHmA3wzGK8oig8cFEayWGz5djQPsS+2DQZqkVLKNgVrfP87bxO8XAs7rB3UmMEPIiAQ+ypcGo1IMErEcXZKdA7YKUOvBRO09KKU1No7LvLaGVvekyhU1kbKgBRhD2W2UyZv4B7fRcwWpUO/DpEk28EPfqrnRuGbAfxUYnqIZcX75whKQ0bKQ3DvFuKDlxZsvgjbMnxLNwF0cx3OOCpya7ohXb9UDaQxJUt+Of0k68m8bQ6sWE2u8mIKh6RqxnPnSzD4eQoEwXpk97VD5AuTxJAO2dpFrIKFE+OZY4pisawY3KYcHYNZ2jGwTeRMW2LsPc8Ikp6sXCIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ozjink1ka6LHGtdtp9y9jrgkC+3MBZFrOUmbfTWSQo=;
 b=RUnna3dQiqOkc0lltSupXTygIKqKB/t18wcqmP2Ki8xolmcouDP5V5ktgvO1RnW6WS8G+0G9SnlnN5Jc+Pg1BEOI9q8mjjB9OFIfWelKq6ZwLUfKEmSo4ZJqZ1AqDDN6zk6F+j254Kax4kDAwV7biIbt8vApdEmGgh05b72Ab0hrbyyhI86D0kxFIVQ7+1E4e1PqP/eaOWvo3f5cM/KqCLr0DfMWqwRdKBY8vzrMxnIsfXv1xh7xFTm2RVfuoEMJXnTFBfcT9ZuqRiXSfXKm4VR6QilQ+Fgt6UOmbMt+f2iy+rFxWlGQQKg4s5+q75fI17m8FtG6GDdJDFlFu1K43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ozjink1ka6LHGtdtp9y9jrgkC+3MBZFrOUmbfTWSQo=;
 b=hviVaNezXag1wU6SoFsn6zUwDhVHVi/7Yg0fyRvYzubBLueeljJKV8+yrhVjX8cM42efFxbSnttDKseE0Gabuq5PFGXmrm5+sbzh5AH9rvgnTiqSklTUHo/1Tu6J1Kuq1UhQ0KTFMV1Hm5RUUVYLXO71x42Z0iTfrOvw4I0LXJA=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB5862.eurprd04.prod.outlook.com (2603:10a6:20b:a0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 09:31:38 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27%8]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 09:31:38 +0000
Message-ID: <9117e5212a3b743ca541918ec2b701c159ac752c.camel@nxp.com>
Subject: Re: [PATCH v2 2/3] clk: fractional-divider: Introduce NO_PRESCALER
 flag
From:   Liu Ying <victor.liu@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Date:   Thu, 22 Jul 2021 17:29:23 +0800
In-Reply-To: <20210716133448.24890-2-andriy.shevchenko@linux.intel.com>
References: <20210716133448.24890-1-andriy.shevchenko@linux.intel.com>
         <20210716133448.24890-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 09:31:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffe9a0b6-1228-4816-7493-08d94cf38189
X-MS-TrafficTypeDiagnostic: AM6PR04MB5862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB586278F73FFA70DFD28DF75198E49@AM6PR04MB5862.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzpgOt2OuIvgmhtD6QNTggZzSTYmmeHugPvSw8UsK9CCRHblmy6qBKeLF/861raSr45SvnEE1vDk0bfHaZDzZEJqfjMedymn62sHDpiqhJEcxyMRFE7ilAWbl5mKrl5iKp3xVwQhLZp4TCRpO+Y3P2hPwfhAOu0cvkDG1R7QUINWCAhKpDbNUwTnh0k73RWEMqkLtGdoPZvdNNdJ/o4bco7vjNTnG4108G28TZP2twj/nxKdJ0882M/XOuYRrk4Ni2m/ibgleECFHBuVFs0KP68Q0VwhgsIbKZpnkltTbo7EvL0LZTs8DmzklNBb1wJ0qDapmpaaq26esQMLSnFLfc/RhiNWMeVNVD7pdZzDMFkV0OIjQSZD7lB7DQb57afpKfq4XBTzFj9Fz7NutnWaxcr4wSmwJ3GyiY01XiraX43GG8Sb+KI+zFVucZ9nl+W6QTxEglozrFb4c3YNCt/DqCfnsiVFp91271XmY9vUb/fu/DaT2kYT+CCWQvbe01Sx891O3WZO1vOyxSnMqLhyyY44FRkrQxcDIZNW8p0oZMzmvfVQoxcVi7Ti8VfArM+fWUB2YniVUK6LO2zdsks4cxDlUpvBTYleoECB/Ky5v8AIDTfM5GlmIzEecj/W6B8GkCjt407qH4kmDnh1FnbnSfOAk+N9rpu+8K+TFys7kUPSIgTMcvyTBrHTiy7zEl+rT2VuL+cSa4wPBFnCBUA+Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(478600001)(66556008)(66946007)(66476007)(83380400001)(8936002)(110136005)(2616005)(86362001)(956004)(316002)(6496006)(54906003)(6666004)(36756003)(8676002)(186003)(6486002)(26005)(52116002)(2906002)(38100700002)(4326008)(5660300002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEVlYytYdzZFdW1mR1lOeitMK29ZSzBacG5jMTdTSmxWemozK2kxWkZTYmFL?=
 =?utf-8?B?eWozZ3p4ekc2dzU3NlFvRWRMT2RWKy9Ic0pWVCt1TmFpTXh5NjcwaU94NkFm?=
 =?utf-8?B?Q3ZrS3VZVDZzd2k0bnBrZzdaUGo5UVI5Y1pMeXNWeHNxVGhXamFtNXA5Y3h6?=
 =?utf-8?B?SmxoWDVHZUxYSkdQSHdZelluNjZFS1dudlR3NjdIM3FTVnFhUi8yZERNTUli?=
 =?utf-8?B?M2JVdmlmMzNoVzZ2ZVFhY2F2MldEYi9yTUJrdkdnYXBHc3o4MFZNSUNuOGxP?=
 =?utf-8?B?bXZuNVJFVUx1bkU0SDJWWlluZUg1QzZOT2ROUkp0VkJFb3FYSDJ5dUJqN0kw?=
 =?utf-8?B?VkJiM2RZT3BwR054amhOZG5QeFhKYUM2N0szRHkvSm9DSThHVzdGSzlZZmhT?=
 =?utf-8?B?NWt2VVE4R2pLY0JJVVpKZXIzeDhYTHhBeDBzM3lvTGU1cFcrRzdvelhuYU9G?=
 =?utf-8?B?ZWxlNXdwQ21hQktVNStMYkNKdEJWNzFmUnpkMU8vRUxsWWRHNng2d1ljVlBI?=
 =?utf-8?B?M2lpOFFmcHRsSE9zRmZuT2xlK2pGTTJxbmc3QWFMUnZQTSs2YS9EbG03K2Vw?=
 =?utf-8?B?dENOWTVSOXVDTlJnb2puaFhMVjdteWt2dFBVV1VlTVU4NS9sZktNVEtMN2g3?=
 =?utf-8?B?NjZ5MzN1dHZqUUNKYmtoL2lNNWZiaFdudDFLNzU1b3FNbFlseXZxcUpkUDEv?=
 =?utf-8?B?UDgrbG9jQU9WbWE2cXUwa1pyZ0pwclNvRUMyNW9MRHhLY2cwZTFabGNVYVpX?=
 =?utf-8?B?d21BR1Z6THp0dCtxRit0S2VPWWNMTlJCeXF6RzF0ZWcwM1RPc1h6cGlXUmor?=
 =?utf-8?B?LytxWWhnTjZKQm9oNEZqOG95bzJ6OUpiWUI1WHJsOElua2g1Mkl4SmJ4NTVx?=
 =?utf-8?B?QkwzWmEzWnErM3lIL3JRWjN5QTY5NW82eVZqYkJsQ3FKMUFSNE1TNUkzV0pa?=
 =?utf-8?B?dXkyeVE2L2Q0VWRoWUh2bGxnMGQ4V1MxeHM0eEJXTGpNc0h0WWh6eGp5Tk10?=
 =?utf-8?B?akhpQ2piNHUyNzg1QjB3Vjlnd2cwaXBMaGx1S2MwREY5eFg5ZDE3VG5ZSlhk?=
 =?utf-8?B?YnBaUGNwYnZUamRWZVk1aXdyeWM0MlhZeW0zdTVsblBrbUVCd2RhbGlGMUV3?=
 =?utf-8?B?M1FCZngzL1VVdWlOY000M0kwTFA4djN0eGtkUFp0Q1BzbE1jazA3Q2tTUmtD?=
 =?utf-8?B?VXpKWDhaSHFVTWZKRzJWNUFLU2gxR3R4UjV3a21hUW82QmRxb2ZtQjJnekFt?=
 =?utf-8?B?S2E3cytOUXBlSmcycjhkWEhYRWFWNkdZUk16Z00vS0JIbUUyUll6YXBMakRJ?=
 =?utf-8?B?RGVXTVFhejM4V0NDWm5PSUFmdnpaVEVucjgrZTRSRmFkd2UrMWdudUZRRWNt?=
 =?utf-8?B?OGo4OXJzZk8xZXNmSC9PTk96U0RvKzZKcjE2Y2VkNVZRVENlZjl6U0d0Y1h2?=
 =?utf-8?B?S1kxYmUxTTF2ckZ1RllIaU1yQzRydzJ0a1RGN0Mxdjc0RzhTVUxQQ1huL2JB?=
 =?utf-8?B?bnV6SVl2Z1d4aFVGa1o0d3JLQzYxeWRtbVNtcTRDcVJPME16N091MXZVbFJW?=
 =?utf-8?B?RXNrZnA3eW1ybjEyejN0RzhQZWwvYzkvMVFkVFc1VU52ekZNQjVtYUtmV0tT?=
 =?utf-8?B?cUdvN1BmWS9obnRSUk44VXk0TmlYaWIxYkFNaC9PWitCeG80K3dXcUoyZ2pU?=
 =?utf-8?B?OGRIWDRKUnN0VUtaVWdiK3RjNU50ZFYzVUs5Vk5ZRUFCMi9rOXVQamU2UXAy?=
 =?utf-8?Q?3aDOhZMoPXsUuMmpEQd3IG5wSNDUzuMejj/MWrt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe9a0b6-1228-4816-7493-08d94cf38189
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 09:31:38.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KIYKVORoQJPjezS+cqwxc+yZlE3LAfmy2KmpK3E9ZkAA/8e7W67lM3Gdxp3AHL8GhkEHVxroKyjA5vYip9/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-16 at 16:34 +0300, Andy Shevchenko wrote:
> The newly introduced flag, when set, makes the flow to skip
> the assumption that the caller will use an additional 2^scale
> prescaler to get the desired clock rate.

As I mentioned in v1 comment, it seems to be good to decouple the
prescaler knowledge from this common fractional divider clk driver.
This way, we'll make it simpler and easier to maintain. Also, then, the
NO_PRESCALER flag is not needed at all.  However, it seems that two
Intel drivers which use the frational divider drivers will be affected
and rate negotiation logics need to be implemented for them.  Please
consider if it's doable or not.

If we ultimately keep the prescaler knowledge here, please consider to
add the NO_PRESCALER flag for i.MX7ulp as it hasn't the prescaler IIUC.

Regards,
Liu Ying

> 
> Reported-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: moved entire snipped under new flag check (Liu)
>  drivers/clk/clk-fractional-divider.c | 10 ++++++----
>  include/linux/clk-provider.h         |  5 +++++
>  2 files changed, 11 insertions(+), 4 deletions(-)


