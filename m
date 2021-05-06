Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E84374F70
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhEFGhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:37:45 -0400
Received: from mail-eopbgr60116.outbound.protection.outlook.com ([40.107.6.116]:7426
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230078AbhEFGhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:37:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTYPbEohUQDGyiVrPHgbRagbdAmw+8ECNARERvX8BGIqmBx6qXqZWIAic0QwSlKR/z6r3/IjvXyyZKMXc0L3tH/u7V5C6RJ3DDE8s2e4U7tVWpxiSu8VcfnkePbVH18pdEQY1l2j1IMO+IkeC9rpNc4ZvwBtw8F5X5M/86+jIo53ygtEiKo48Sj/gjBpuHBAs6/WUzqLlYjwPv5IX/QNXuUp2e14/+xICEDNtcwWqKDV7jqsEPihkFPmh8f2Ewzl/yOnBbn6pOfRRuiyOxWqmhiJuiDLvFvdqM1dT/cZXoR/yBYY+ylxeQ/qhwGLkZD+zlkwlij8u+fWVVC6eDMdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL/fN59qfx7p8cUVcCxk5C2oXpGF5gikRFO0Y2pi6Zk=;
 b=btk1yXf0w5B0nhOVzEjVJ4ekKrz5D7L+aopRQHNaFxI9PH68/U8SSnvR7EwNJDF5LnUkWp29/oNx3ddq1Q/F7ryzKIQJDUSeTbWtTRbiu3j5/dT2fPCkUdLwBC6TQFFtJVHzHge78OW/8TUhq+wCTjtqQBURqeno2A2250rtFzDGrYbDFuv3GO0c/llwWVRX1ebAT55ugjHtN8S9iLiQjn5oYiCTkpTPTY8UhESe4ctUAMnxBmvMP+VYyKxthQvd1BadPAjgr66c/12cEGVLzobBF7O2uTI7JM05kwX1QgVhi6iU6FCSgl4ECN489b+aGMeUeEUehoGCXRIL6tC+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL/fN59qfx7p8cUVcCxk5C2oXpGF5gikRFO0Y2pi6Zk=;
 b=j+dsysNcERCcY6lSZtjNAMfI84CEwJZH32Kg4xrCgZ9h75Czya364bhDIUx+FDfUntPA4Nbv2ZuydgLIZ7Bf9xPHf2uiw19W8sVwx0VSkEh83YnqDU8g1gtoqgCM2rFei+vWoY/Whb27g/nGtgdXZT3fxkvcHSOId4aXpXWj01s=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:368::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 06:36:44 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 06:36:44 +0000
Subject: Re: [PATCH V2 04/13] soc: imx: gpcv2: split power up and power down
 sequence control
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
 <20210506010440.7016-5-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <6b4eb1ae-f87c-8947-5921-62da42b7e662@kontron.de>
Date:   Thu, 6 May 2021 08:36:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210506010440.7016-5-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.180.42]
X-ClientProxiedBy: FR2P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::18) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.180.42) by FR2P281CA0031.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Thu, 6 May 2021 06:36:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b98fd8-a178-4e55-79e8-08d9105950a5
X-MS-TrafficTypeDiagnostic: AM8PR10MB4674:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4674976AC706AEE945C827C4E9589@AM8PR10MB4674.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5BoUO4Qa1IvmVXigMJomdTQYQ5WSsKw3Ksdo4PfsM2yEItHxFbrTnkNaGf9L0NKpJaLOAHWgXqZvGp7oU6Jp1ftZnvscbdmZ/TkX6VA5doGOdw9sz40w+RT6GzbXzp1D+XCpK3DC/4wAQVn+9sJDpo/IeoVUNHXsDtdpT3gnK0Q7CmkuS5zL/XbhH+l+zJdBpbWIeRT19b4DUI9GRxacQbZ4jCcDXZHzavFuSNLSDp3BsDrRBhLvIz7Qlayv7eXxOQkinQchm3Wr4NlvsAEo0M0BOBUdf1hb7/6/t5zPF918gzq3MM92TdXN5K/iwM8J5II3smFyFSRSIXU9kAS23n8CEbGe7vWYmLLQYW4ak+byuRlmSqiaDRc46kZrToTa0VpfjSSa5dYK2SOT9kUlBL+OVQFVlj8RxVRXJihPbAVJL/CLJFR8kPlEwM9qpxJrn+l+3ir7VNjQ7iMjQOVxb8mlz3Z4kMQYfLPVCxdNsFwBeGRMNGeUVo45OlW4w9rX0CdnjpAH1OSjMnaYF9AjenLIoahcZNncGhWvh0c7v188OGzVTpQ5Q5fEfVn/9AgW029TdLI+45b3T7juDxTwGJuIGSHJZvjElJU8SxQQg10tvb7r5U7Aq5/uF4XLxpZivqkZZ8eItdoAk9pGVCAgruwHPuX7+CTNthUypKVfBCN7ow4ASCqHBCpa60MeQg3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(66556008)(16576012)(6486002)(83380400001)(31686004)(38100700002)(8676002)(44832011)(8936002)(316002)(956004)(2616005)(31696002)(5660300002)(66946007)(2906002)(26005)(7416002)(66476007)(478600001)(186003)(16526019)(53546011)(86362001)(36756003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajNrZWFKVlduMklSVEZyZU1aVG5sQnFKYURLWWRWSnZ0QXRkbVFQSCs3RW8w?=
 =?utf-8?B?czFjd1NEUFd5WVJTdWZPUTRERkJld1ZnNWZsczIzZGowNFFGbnZuc05PVzd2?=
 =?utf-8?B?MHZBUFNJSGhPenRETmh3bWh4ZUJpbFMwejZ4ZGJXSXM1ZkNuRnBJL21lc05K?=
 =?utf-8?B?YTFnSEY1dnR6SXNPdzVFR1V2bDAxQWNyM21JTHE3NXJQWWRiS1U4MWZPeVhH?=
 =?utf-8?B?N1liTW1mc0R0Wi9ucnRZOFZGT3RiY0xGUlBQaEIrQjdjczdKL2VCS0RGQVg2?=
 =?utf-8?B?Kzcwak5QTW85Q05zZjM2RVlsaDhvS0Rzb3p3QWpZY05vNXBjUjFrOHBodkZ6?=
 =?utf-8?B?bFZPM0pYWGp6UGdHVHFuTlZ2U0oxK3VEV3QzSWxFL09BTUFlNFlHZmZlWTRi?=
 =?utf-8?B?ZnFQQXVNeGxMWEVQK0NNU2JGZkY3VnFONy83TGJsWXpxcnhveVpUenBTVXZJ?=
 =?utf-8?B?M0w4MUYvZkFEdmlFZzJwdTVFTlAwRldtRXhTRW00OFhHTTRtZkQvYlJlVms4?=
 =?utf-8?B?akZvTGNLWFhMRUI0aE9kc2hBMlcrWTZNVVo5bFNkMGdmM3RNbmJzMWdUbnQv?=
 =?utf-8?B?T0pteURFbElmS2doM1VTR1lucDdqMmdTQ1Jwb3VxcDU1VUMyRU1DTmVpTmxY?=
 =?utf-8?B?S1djUkQ5c0RrR1IwOHl6UnZHelhQYk9XRDAyc3JqV0hDbTNjem9Xa1I0Ukov?=
 =?utf-8?B?T3duTWJ3RWE4NFBoRDdkdFlJUzIzSkU5dnV5SlNIdmd6QXlEQ0ZWQjJMeHhN?=
 =?utf-8?B?KzBteXo4LzdnSXplKzBZaHBjUGNJZUQ2VitIMS9GL0pnYjA4Q1h0cnUxNVFB?=
 =?utf-8?B?dWxRM2dRWVRoMDRzUEVHQllZbENZeUJERjRTWlkxZzFiMHhBK3EwMmxwMVhY?=
 =?utf-8?B?RncvQ0NJUmJQT3VSaGdmSm41Y1FXcU0vUWw0NmNTQXNna05zdkpCUHl5R0JZ?=
 =?utf-8?B?Q0ZkdHArYVp0R1pMaEY2R3d1ZEl3cng3bU1hMDg1bnV5MDAyUDQzUDlZTm1K?=
 =?utf-8?B?c3N4eC9NUmdUaWpmcUlLd3UxRSs1YTBGNWZvQ2NlUTFiTFZudnplM1VZV3o4?=
 =?utf-8?B?OWNZa2UrYjgvYWE0TFVMR1Y1WXgwdVU0emtYeFZxMjBoNCtEVitqR1plRG03?=
 =?utf-8?B?dGlXcWVkYmVHQ01BaGpPQUdUR3FTbUJ4VjkrRjNRcjQ0YytISG0vWjZrOHR1?=
 =?utf-8?B?WTJjOU56ZVBBWFBWOTF2S2FmVE1mUXdjZDFramI3NmhrUU9CdWxkVXRCYTBv?=
 =?utf-8?B?anJrSHBjTVpxTHpYZ085eGhCWmZGeXNOdHh0K2J1aTBINzdneHNGa0tZdDl5?=
 =?utf-8?B?ckpGVDk5Mi9YK3hTblJoNmF0SC9VanFiUDlLNklRVldZNEp1czY2WkduNzg2?=
 =?utf-8?B?SzJCVitHUVd2NkR3bVk1WnloM1dUL3ZYRC9sNHo1am05dW8wTU93V1NVT0ZN?=
 =?utf-8?B?WkJsbFRkak9SK0pac3l0Rkt6ZnFRQXJMYmVETTdYSlhoRjRySU5lNDdlT3d4?=
 =?utf-8?B?ejVub3hsRkRPWWpjams0RkZzZDBsRW5paGZqUUtkQWVJMkI4VHNBTEF6aG91?=
 =?utf-8?B?QlZ5cndoTkJzYWpFU2NBamM1Ujd1RjVIek4zVCt3bmxhVlYxMnhKWi9tdjJH?=
 =?utf-8?B?cTlCbWlYZmJYa3hQVHN1UklJTmZiejU5bU82cmwyZWdFT1JtZ2pWcUk0Q0Ji?=
 =?utf-8?B?WEZ1bUsxd1IzYVZzemZkYnlQeGdYQU1icDMwcjRMQ1k3aVpkYmlueTc2VEpY?=
 =?utf-8?Q?XgW3D59juuYEwL9Sz3NO6sefc9AXI5LvQxKQiJ2?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b98fd8-a178-4e55-79e8-08d9105950a5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 06:36:44.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSwIjRnjBlBlm3Yx+DPcKa5X1gZr+ApXKFpxo3uoUIOBtmOMDHgorhkJ8ADQzUvgrwynOGujNwRr8eVOBRVV0skXi1fhaBM3q7DSsnDlQ+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4674
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 03:04, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The current mixed function to control both power up and power down
> sequences is very hard to follow and already contains some sequence
> errors like triggering the ADB400 handshake at the wrong time due to
> this. Split the function into two, which results in slightly more
> code, but is way easier to get right.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/soc/imx/gpcv2.c | 141 ++++++++++++++++++++++++----------------
>  1 file changed, 86 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 4222b6e87e7c..bcf1f338b0bf 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -125,20 +125,19 @@ struct imx_pgc_domain_data {
>  	const struct regmap_access_table *reg_access_table;
>  };
>  
> -static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
> -				      bool on)
> +static inline struct imx_pgc_domain *
> +to_imx_pgc_domain(struct generic_pm_domain *genpd)
>  {
> -	struct imx_pgc_domain *domain = container_of(genpd,
> -						      struct imx_pgc_domain,
> -						      genpd);
> -	unsigned int offset = on ?
> -		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
> -	const bool enable_power_control = !on;
> -	const bool has_regulator = !IS_ERR(domain->regulator);
> -	int i, ret = 0;
> -	u32 pxx_req;
> -
> -	if (has_regulator && on) {
> +	return container_of(genpd, struct imx_pgc_domain, genpd);
> +}
> +
> +static int imx_pgc_power_up(struct generic_pm_domain *genpd)
> +{
> +	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
> +	u32 reg_val;
> +	int ret;
> +
> +	if (!IS_ERR(domain->regulator)) {
>  		ret = regulator_enable(domain->regulator);
>  		if (ret) {
>  			dev_err(domain->dev, "failed to enable regulator\n");
> @@ -150,69 +149,101 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>  	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
>  	if (ret) {
>  		dev_err(domain->dev, "failed to enable reset clocks\n");
> -		regulator_disable(domain->regulator);
> -		return ret;
> +		goto out_regulator_disable;
>  	}
>  
> -	if (enable_power_control)
> -		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> -				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
> -
> -	if (domain->bits.hsk)
> -		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
> -				   domain->bits.hsk, on ? domain->bits.hsk : 0);
> -
> -	regmap_update_bits(domain->regmap, offset,
> +	/* request the domain to power up */
> +	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
>  			   domain->bits.pxx, domain->bits.pxx);
> -
>  	/*
>  	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
>  	 * for PUP_REQ/PDN_REQ bit to be cleared
>  	 */
> -	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
> -				       !(pxx_req & domain->bits.pxx),
> +	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
> +				       reg_val, !(reg_val & domain->bits.pxx),
>  				       0, USEC_PER_MSEC);
>  	if (ret) {
>  		dev_err(domain->dev, "failed to command PGC\n");
> -		/*
> -		 * If we were in a process of enabling a
> -		 * domain and failed we might as well disable
> -		 * the regulator we just enabled. And if it
> -		 * was the opposite situation and we failed to
> -		 * power down -- keep the regulator on
> -		 */
> -		on = !on;
> +		goto out_clk_disable;
>  	}
>  
> -	if (enable_power_control)
> -		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> -				   GPC_PGC_CTRL_PCR, 0);
> +	/* disable power control */
> +	regmap_clear_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> +			  GPC_PGC_CTRL_PCR);
> +
> +	/* request the ADB400 to power up */
> +	if (domain->bits.hsk)
> +		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
> +				   domain->bits.hsk, domain->bits.hsk);
>  
>  	/* Disable reset clocks for all devices in the domain */
>  	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
>  
> -	if (has_regulator && !on) {
> -		int err;
> +	return 0;
>  
> -		err = regulator_disable(domain->regulator);
> -		if (err)
> -			dev_err(domain->dev,
> -				"failed to disable regulator: %d\n", err);
> -		/* Preserve earlier error code */
> -		ret = ret ?: err;
> -	}
> +out_clk_disable:
> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +out_regulator_disable:
> +	if (!IS_ERR(domain->regulator))
> +		regulator_disable(domain->regulator);
>  
>  	return ret;
>  }
>  
> -static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
> +static int imx_pgc_power_down(struct generic_pm_domain *genpd)
>  {
> -	return imx_gpc_pu_pgc_sw_pxx_req(genpd, true);
> -}
> +	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
> +	u32 reg_val;
> +	int ret;
>  
> -static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
> -{
> -	return imx_gpc_pu_pgc_sw_pxx_req(genpd, false);
> +	/* Enable reset clocks for all devices in the domain */
> +	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> +	if (ret) {
> +		dev_err(domain->dev, "failed to enable reset clocks\n");
> +		return ret;
> +	}
> +
> +	/* request the ADB400 to power down */
> +	if (domain->bits.hsk)
> +		regmap_clear_bits(domain->regmap, GPC_PU_PWRHSK,
> +				  domain->bits.hsk);
> +
> +	/* enable power control */
> +	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> +			   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
> +
> +	/* request the domain to power down */
> +	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
> +			   domain->bits.pxx, domain->bits.pxx);
> +	/*
> +	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> +	 * for PUP_REQ/PDN_REQ bit to be cleared
> +	 */
> +	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
> +				       reg_val, !(reg_val & domain->bits.pxx),
> +				       0, USEC_PER_MSEC);
> +	if (ret) {
> +		dev_err(domain->dev, "failed to command PGC\n");
> +		goto out_clk_disable;
> +	}
> +
> +	/* Disable reset clocks for all devices in the domain */
> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +
> +	if (!IS_ERR(domain->regulator)) {
> +		ret = regulator_disable(domain->regulator);
> +		if (ret) {
> +			dev_err(domain->dev, "failed to disable regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +
> +out_clk_disable:
> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +
> +	return ret;
>  }
>  
>  static const struct imx_pgc_domain imx7_pgc_domains[] = {
> @@ -590,8 +621,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
>  
>  		domain = pd_pdev->dev.platform_data;
>  		domain->regmap = regmap;
> -		domain->genpd.power_on  = imx_gpc_pu_pgc_sw_pup_req;
> -		domain->genpd.power_off = imx_gpc_pu_pgc_sw_pdn_req;
> +		domain->genpd.power_on  = imx_pgc_power_up;
> +		domain->genpd.power_off = imx_pgc_power_down;
>  
>  		pd_pdev->dev.parent = dev;
>  		pd_pdev->dev.of_node = np;
> 
