Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820073DA225
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhG2La6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:30:58 -0400
Received: from mail-vi1eur05on2052.outbound.protection.outlook.com ([40.107.21.52]:32352
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234999AbhG2La4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:30:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ip8hYJW7BJZBsv/WXqg9f+akzAilDk/honBTuHD03H5HeWQ90tc/BBbAunIJBAGFU8uOGprACyDqCLdRY+GiBSr0vPumtPvBTZoRyQi2Iwh1tgUlF8PW0T1pKNIEMa6aBW1EohsezVDGxSGuh0YDEcxSeRabZj072g7Jsa7LrMHI56Gh0j4nEG/uLv0aEzuDOVhhpJ8XHOZMimxV+zom6NAYZI3Fd7dpFiZVtxG9ZXBNnrREcOMLND4TnGawnCos17H3ggiw/Q3b14MoLsOMM6cSM9YBefQZXH7j8l0q2hJtDhdVwfw/CRVjZU8lw9OaijL7a0Hy33ItbSJRW27N2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJYgae6930xrgAJebfEr14FYjT9IJLkY+oQPwVcTa6Q=;
 b=bFTKy+NO9C9qlKszEz6duWqda5acXCZsUSzm9CImvsz46DO9qk+NJOMpY1bc1zMnkyzwGsTMG64hAMP10X2vCOdnddELcAgyxqavkF/JdckQLv5oa9KUKsB5O/Cs8dTJMAa3nTaY4doVJ4X/Qe+WCBc+xAKFFRybVqyC+8gcaqnB5KobNmSgpHSK7qIQLBE2AOSHBIF0SozGIeWpt8o5oXuhtAPQkjg6HxZIR19JMMAKQhy6CRvHxbDfU7vjEeFo1K94CRZ2t73wEOgKefB8yRQnF9QthuLfooPUc+ZOLu0ASfvoYlPVw6cSXXKOAj2GJJwp2Qs9/f35/2H1NRuAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJYgae6930xrgAJebfEr14FYjT9IJLkY+oQPwVcTa6Q=;
 b=C8+PXA1tfdapAchCCojbHsukYIlh9mJ70qUrBNlHsVVxVW94FYoCUpJwYutxf9vh7h7zcCkpKyJ0Kh89Uv7yOGq1hIRy/HimGURbu7FydfV6erPpzgzH1Nw9K+4TZ5ro4HTSEmX8x2EjunAEA6HrSZS9c2t415jz3Kd7RzA8F0k=
Authentication-Results: googlemail.com; dkim=none (message not signed)
 header.d=none;googlemail.com; dmarc=none action=none header.from=nxp.com;
Received: from AM5PR0401MB2546.eurprd04.prod.outlook.com
 (2603:10a6:203:38::12) by AM6PR04MB4582.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 11:30:51 +0000
Received: from AM5PR0401MB2546.eurprd04.prod.outlook.com
 ([fe80::c532:c933:418a:cc5e]) by AM5PR0401MB2546.eurprd04.prod.outlook.com
 ([fe80::c532:c933:418a:cc5e%5]) with mapi id 15.20.4352.031; Thu, 29 Jul 2021
 11:30:51 +0000
Date:   Thu, 29 Jul 2021 14:30:48 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v1 2/6] clk: imx: clk-divider-gate: Switch to
 clk_divider.determine_rate
Message-ID: <YQKRaNmOl0MUeRPb@ryzen>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
 <20210702225145.2643303-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702225145.2643303-3-martin.blumenstingl@googlemail.com>
X-ClientProxiedBy: VI1PR0802CA0003.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::13) To AM5PR0401MB2546.eurprd04.prod.outlook.com
 (2603:10a6:203:38::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen (188.26.184.129) by VI1PR0802CA0003.eurprd08.prod.outlook.com (2603:10a6:800:aa::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Thu, 29 Jul 2021 11:30:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5de01fe2-a9c3-4c09-aba4-08d9528451c6
X-MS-TrafficTypeDiagnostic: AM6PR04MB4582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB45820407E35AA1E780A76984F6EB9@AM6PR04MB4582.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOBr08kvNHaVwwuLQ4/F9TzJl8YMi1amwoPa6KPAaD1uF8PRb1xJ6RlXUbALoIjjL90s4ycff7clcJ7XTW5rkk1rOu/suz3FdBIXplvLnfpR69hF+RbxoJ9d4D5gAM8l56SEjuikhSuyTKavM4Hjkpf5bSNmicrf6WCJ+PeQzu0BHEFRfH+ucx+TU13Mhxc2V88u9lQXCpaFe4QADyDOEy0lGwHUropcZ7gI6OE7/T+3GEwSStzIOuldNWXer+jK3R0hFRZ7ixoo8o1L7tJL32/Inl8sDii0hjAglKGPtUC8xrwM6fZT4ab+uH8G6muuUNZx7R6uZh3UYiU8XzmQQSFXz3Wx8tQQRuNiKdQv+h57HQO5yEBoL8J8VD0Gcu2gpbielPPObtrGzDw4m23om3PKRacJy1uvHS93dMt0LfvuH3JWdBeHj2D5XJF0a3TbgsZ7P9tq/mOtB4ApEe+0dPuI+EsrtERj88Lto9RFG3HE7RuQVK+a7juhHJrLN59tJkcG1qJsAS0G9a9Q16TB11UVRwdOYg6GDSv2Jui3M3c6ohe/beCn26mZVaKpeWW85JUoUASQausNgYs3oWXKbBlyuAgL/6NIYJJAv9VPTsd9jSlo6GrmncsJZiwwyXZlkn7IpKy7cKlBMx5MA3RjUpdTl7yNiaJohj0h38iW6/2HXUPgXT4xqh1DVv75nX+kIei24MN9lZJT9VEMvxqFPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0401MB2546.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(956004)(2906002)(478600001)(86362001)(66556008)(7416002)(26005)(66476007)(9576002)(4326008)(54906003)(6916009)(8676002)(53546011)(44832011)(66946007)(8936002)(33716001)(38100700002)(38350700002)(5660300002)(6496006)(83380400001)(52116002)(316002)(9686003)(55016002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y7x0QObAZCLtb57NoV+r0m55y8qcYag28kykF0QoniAK8hTmB3e1IEIc0snG?=
 =?us-ascii?Q?q6HNrBHPKBhIkP5dTHi9bV18uMTZBASnuVJKsb29xVnwAFB7JVHLH5UBYFc2?=
 =?us-ascii?Q?3j/38IRgBYeRg6LKqHyIQqZntTX6OGimk+7LDNBo2csauE6ZPHWnORT7SGDw?=
 =?us-ascii?Q?IEAdxaY9P+aqH3t5YpT6s6nFzrWZtgLMIIHQCXkNP1XmmMDNErxMKYrZ5dvB?=
 =?us-ascii?Q?Ge+rxuYmVwFpg4U1h2RKBvIVSunkO60VIzhf/2uidNgd0LGgBYkC5spLeYQk?=
 =?us-ascii?Q?XNX6/DcMAmIjse/IY7YYn033j8xLQxRmJQ8qQZfrGcHkgLmOEwCE5sJyb5Cx?=
 =?us-ascii?Q?id5F1EmRTrSp7H6nKjdvDAref/+tZQHnCXJG1EDpU6b2VvrVc4paK6D7dSTU?=
 =?us-ascii?Q?TYyKTiZeste4lKQA5YwxUf6nJePcEhV34OOvIAbDa1+JrCiJazRCbpnMrrxb?=
 =?us-ascii?Q?3wnEAKsJL0O5z6vKAU5LibKwJcPyOhgnj3CBW421fTXD0o9+y5Ti/bB1nrSX?=
 =?us-ascii?Q?TqraNzh5mgkOd+N/A7YLj8uadknXYbFB9az4M2OZNid+GxowC090CqxrdPHE?=
 =?us-ascii?Q?xAHXmbf/8e+J51X9uT9e/yvujgjA2NIhTZKLupQuTsynanaKEH1094DjVmnT?=
 =?us-ascii?Q?BenhG2VIzTX/x73ODVWJGbQ26pRAbSo6q1CVx39FQtxc/MhsqBJe4BadKbSW?=
 =?us-ascii?Q?4mdM/+5xrSyvmKZd2+Xnq88X6GynlWPZMJTm1zwWKzkqNlrjXX0z3Esz4ra5?=
 =?us-ascii?Q?wOefTdFxJh/gFi1dHbh4NRCZ8rz/Wbxrx3MPvIqC5gl7emC7p/AwJsrn0SVU?=
 =?us-ascii?Q?TFBQ/MyGSMCWM+9ReHPi8qDJJm1ERQ5WyZB6YU2sORYnhaGgIxsM2t8/eB46?=
 =?us-ascii?Q?+SmVIPyWbSFLsXgTlXc7NFd4DGrvEf031XiiFZfUUG1hzfxFvUMXZjEqhmH1?=
 =?us-ascii?Q?kl2e8MJ8tR2JDah03FNFzHQZtGxc8MEBHAkPNTTq8+XFRlvQqahyNVIjNQ5H?=
 =?us-ascii?Q?rsW9zyf6tzbwmhqz/cx89K8tl7jUAxGeox/KnMNbiD5yBEsZCu1lcm2NTlZ6?=
 =?us-ascii?Q?9RwFnhdc3y8jTrvPq5aiE9dUaH3C4CApm5ZjydjrQhMF2q/1U5/Bp9SarI+N?=
 =?us-ascii?Q?nWUZfmwPypIsRXRALJL/Qy3YgObDB+QLqYIH+QkK+VnL6Q+vkSlb43AeSJ+u?=
 =?us-ascii?Q?Dk4KeEbvsVeQsYkvxu7GzkfmIrgA2UfjJSIxkqp39FU9uXH/qB7w0AFEROhq?=
 =?us-ascii?Q?pd/Hh5KSpcCzg9We6veBUZMxmkLHJT9Ne519MowLkY1fqg1doqehAIxiUdYT?=
 =?us-ascii?Q?EnsXS5lIFiGVFRyn0u1xBnkC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de01fe2-a9c3-4c09-aba4-08d9528451c6
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0401MB2546.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 11:30:51.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DwaKD2x0LjXn9lOy71c8ANVYeHeeFpc8sJaNf15HjzQCACsuWq3GBu/uTkvjtOXjZ3NjkoKI45Jze71dObA3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4582
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-03 00:51:41, Martin Blumenstingl wrote:
> .determine_rate is meant to replace .round_rate in CCF in the future.
> Switch over to .determine_rate now that clk_divider_ops has gained
> support for that.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Abel Vesa <abel.vesa@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied this one. Thanks.

> ---
>  drivers/clk/imx/clk-divider-gate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-divider-gate.c b/drivers/clk/imx/clk-divider-gate.c
> index 0322a843d245..26b210cba9be 100644
> --- a/drivers/clk/imx/clk-divider-gate.c
> +++ b/drivers/clk/imx/clk-divider-gate.c
> @@ -64,10 +64,10 @@ static unsigned long clk_divider_gate_recalc_rate(struct clk_hw *hw,
>  				   div->flags, div->width);
>  }
>  
> -static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> -				   unsigned long *prate)
> +static int clk_divider_determine_rate(struct clk_hw *hw,
> +				      struct clk_rate_request *req)
>  {
> -	return clk_divider_ops.round_rate(hw, rate, prate);
> +	return clk_divider_ops.determine_rate(hw, req);
>  }
>  
>  static int clk_divider_gate_set_rate(struct clk_hw *hw, unsigned long rate,
> @@ -154,12 +154,12 @@ static int clk_divider_is_enabled(struct clk_hw *hw)
>  
>  static const struct clk_ops clk_divider_gate_ro_ops = {
>  	.recalc_rate = clk_divider_gate_recalc_rate_ro,
> -	.round_rate = clk_divider_round_rate,
> +	.determine_rate = clk_divider_determine_rate,
>  };
>  
>  static const struct clk_ops clk_divider_gate_ops = {
>  	.recalc_rate = clk_divider_gate_recalc_rate,
> -	.round_rate = clk_divider_round_rate,
> +	.determine_rate = clk_divider_determine_rate,
>  	.set_rate = clk_divider_gate_set_rate,
>  	.enable = clk_divider_enable,
>  	.disable = clk_divider_disable,
> -- 
> 2.32.0
> 
