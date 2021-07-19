Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915E63CD26D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhGSKCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:02:34 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:13122
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236150AbhGSKCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mcw0SBhCeK47QhqTNeoSE2L1qNzCjYrUPwAssQbgRoMrWRDXZY1OKw4kHUiCKloHConvpt3qfWm8x5Pmgluzto+Zs2abUlYor2wZqqdjVk2ms+dR8ib95qJecrWjfZ8jwc3c7fRO6stqReNqGMtkmo8/ZIA/Z/MjFiraONCLF23hZXage0RhznwDwsWqkRwy1HVg56ueqRnr5ZRLkheEG04VZoIP49AEPX7np6f5QHtbG/ArTrEByeSl2ZJGQsby8/bY7nDNyUZBYxaYF5myvvoB9vTfFH2wjtfZPzfNEzqi6TrVtTOPWZCAEAb4WiNAlMizi9JFXHHSV9qybbSykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c7iUkpyv4Q9nIGrMvBcGNx7b3rQGsSPOv28sfkpS8I=;
 b=Unjt0ttS+G/CQm71QXiWuuJ8oYw7R1exZthJgC2EhhnP2GyRDBwgGKb5LhUbRYvrAgv9cXhHG5GG19+ZbimvnxOyEDOiM6BJ2WdvXbhHzlwGsnZfGRJELFXneVt+AXA6ePV+6ebA5llp8VkzU+HdqRCE+kIedSk9y66MYaRKFFfsBzamJ8w8+YqCaeQkEwsmgoipUKLqRgBnLgZhjZYi7HoKJA+kUd5T5Xggw8mXuZxkhJoehkIhrc55s4Bwq3vRsOUyzxBMzT/AgZ7FUzflBJd70otoGpvta13CWUlXVIBL1XxwGDlkiMOxYPHmYAndt84g/ELdz8ly9X2twXHoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c7iUkpyv4Q9nIGrMvBcGNx7b3rQGsSPOv28sfkpS8I=;
 b=FlkaZVe72npd6UN1D7l+HpLnzgm7JABy/ZtlhqO8DYfVlwToCdzK0tygCJoo38qw1fo/ymHemUrC0WJCXrwAGHrfyISqo4KNijmb7bhNg4yU+t7BNrmpPdIDNguvSNeHEbSLBcemh23spVfw/mjJGJmfu00SPTYad0QduivU15c=
Authentication-Results: googlemail.com; dkim=none (message not signed)
 header.d=none;googlemail.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR0402MB3680.eurprd04.prod.outlook.com (2603:10a6:803:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 10:43:09 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::1dc0:b737:bf34:46b]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::1dc0:b737:bf34:46b%3]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 10:43:08 +0000
Date:   Mon, 19 Jul 2021 13:43:06 +0300
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
Message-ID: <YPVXOkex7EfTQTre@ryzen>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
 <20210702225145.2643303-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702225145.2643303-3-martin.blumenstingl@googlemail.com>
X-ClientProxiedBy: VI1PR06CA0136.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::29) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen (188.26.184.129) by VI1PR06CA0136.eurprd06.prod.outlook.com (2603:10a6:803:a0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 10:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59f8d39a-7c41-49ff-8e48-08d94aa1ff84
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB36806683DCD03F7C06A471C4F6E19@VI1PR0402MB3680.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFwHXt0Ulyxi69wrwXHC6UiQ2mDn6L+7+xEZG0q8Y0k4bdkPSTqZl1vMMgDjUiXVfiT94nvgbSqwDFGoZWt7kIT1IYDwk10wZYAcCVPk5ajnWLnvUKUteO8baKiJFe1sxwSxH5TTBaRZHdSP8uxj0i4C9YlqPC2RcvwHMaqF+UMe1zgGNYWO4wOMkb7iwS5FHFVJD2tGNtOpgWYz7NIXGuzfABCZky57NbPzy64HWIvhVrMOUafVakzUDPWuJ2I44024YOHGLTHsT0leU6FjPvYsDp27BxZsiCqlBRcLJY4s28PZ4fDBPx4n2CEjAStwf+2ZVu8SGfIc+YmCN6ei4MPCM/QzP1dcPEUb8Q7j5MkPS8C6324TPIbWXRcmM4mMjLkB0dFDZsM3sJAtBIttG/N+2u2WIgc+WZIYnC1I3ecEf2hvcBq+X1nGJLyz2lvr3hpl/KDxUkjOka2gvLIO73PqJw9MzEj+7KflM4VLoF+aS8cbVN/UIy9zuqWvfGPB0qG+CbjrdYlDLZK5xNFsURqnQGd0q9T81mtHGfzBkr/oaJFUr19INiehYqppdappwl/Ft+Oy6QQyFqm/ag6AdlJ1dwi+pwrcSrC1JJ9ZSBKXRKrkxbBghqtRnB4t4XamZhW12tKuXx3JJOOGf5Kj5RVMnQDXsqVe4vQmrsQjW/j6f5Q6w9YgShvrfaqudq6BcrGZRlRhzogcJz/8LawyoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(8936002)(33716001)(38350700002)(38100700002)(956004)(8676002)(9576002)(66556008)(2906002)(5660300002)(66476007)(66946007)(9686003)(44832011)(26005)(6916009)(316002)(4326008)(54906003)(83380400001)(53546011)(55016002)(86362001)(52116002)(6496006)(7416002)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dw4RfGQXiiLiIzBqqbxuLcvnZKhSFS+z15uPuWvUGz+1whDkkIznIWPG45FK?=
 =?us-ascii?Q?rW4ngWGlA8qvn8ynTlX+KTPVqIVf4iScA057EllxPN4WCFZnutZNxo39D6o3?=
 =?us-ascii?Q?KiCiBYFTJ6Y7J/Ox+A7mWL8SDtAKYqwUS0/MuAaT/K9hTCstmHa9RkcUNjiJ?=
 =?us-ascii?Q?kOcc3fIRmOoyheVHtg3be5HLC5OX4JIzKLNT+VCDEvzHWFDmifPfL2ebzqo6?=
 =?us-ascii?Q?erGCVpBSOaM9CffvrAAdkEdTD5Sfo2jUpdJfGPvlu1TQgc+0nDfoQV7es9K4?=
 =?us-ascii?Q?m2b9CU3YFvW/504baGUF3HCxGdrvcW60SEvRJlq+8nxFDCFHqRnhioOscPr6?=
 =?us-ascii?Q?MBnNsBNBywSIC/HAL/+h0/gGbLHGxTby3YQMRDtvILKmhjIH4fHV0lIngTDs?=
 =?us-ascii?Q?LfJXA4ZTSmsquxCReGFHBnpqlYGK7fJN3/x90ixi6kly4ccFeNFkdxj6u71m?=
 =?us-ascii?Q?H/Z0FEKJDE63HdGT8ilLKGQflBGnY0oiPvhaU1IY9BRK/6uvSV8U2AUH++nU?=
 =?us-ascii?Q?PfuHN+2bC9upF7rVyFatpAHQs7lYx07aEPwr1wma5xmL0GZu1VTx+THT1EL2?=
 =?us-ascii?Q?1oFYhIKlFX53BW9hzW34bSNXCePU4ZOQZ7VTD0fQsyTmEFJaiflQsJXEeRXb?=
 =?us-ascii?Q?75L38m014eBiR4eZIz58p6cbWG07T8hSFaO7nYoOyUvIstT25aE06EWUsi4L?=
 =?us-ascii?Q?qhf8q9DhyRhwjewV98yMs+jsNlg2mpUrD9u0RJueRMp/nlAu8b1YJlUTG8TO?=
 =?us-ascii?Q?Onaja8gTmshvctpxV/6VcqAIzeJ3Mw8QMnuiqd2MkuOisGtqKjZ79CZl9pKS?=
 =?us-ascii?Q?gncDDGYRUL3FNu4ZY9TYc/Op4Q7SmL0HaskeQSDS1HvVYcpEkgspSGUq0q9C?=
 =?us-ascii?Q?M0mFo6Z1VWK04X4o3cqdVKqgQD9a9us6iU3agJPxlaolOyJcq2wGZRup9buN?=
 =?us-ascii?Q?0jJI16LEn7RQp7UxrbPnUj4RergvRLhtMY14ki+FQyu4XxKSvNjUnzIJRGMf?=
 =?us-ascii?Q?v73TRWJplr3UByBevQ/60EOheTFbGYa4MiC6dz/4n1+4haxVWNr8L410yJWu?=
 =?us-ascii?Q?jQbO1dujQcxxnoK/OOMWPmB1/SA9FwAdBEUPA1axSI3KYPsvO1EH6sctm6/1?=
 =?us-ascii?Q?QyBHGuU9bgHv1E46kdqTeQQINjfs0oMrgNmUcxarJFhvvNLyMgD4WZYXYxey?=
 =?us-ascii?Q?1fWLnWuT8pUSUlP4/XnhZ64r4m33rOptJ4VYnlnw5PixwC+HOIbk5H6aCQtc?=
 =?us-ascii?Q?FLxZSPMFkf/U0mWsyR5OLFQoqxgj23D3as2YYsMJrxqtpgOCu87xfd7yMykv?=
 =?us-ascii?Q?qogeQz1RI0hyf2ipbiKMFlRj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f8d39a-7c41-49ff-8e48-08d94aa1ff84
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 10:43:08.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G7tP9DryY6UGtC9wlSndZ4q4jJL14HmyC5+dwlUt9/cn8s3thqcS0YNRXxyGiJ0rdnh9xSjG+PDPvh2w+wigA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3680
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

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

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
