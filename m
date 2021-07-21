Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533773D116E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbhGUNxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:53:52 -0400
Received: from mail-eopbgr20079.outbound.protection.outlook.com ([40.107.2.79]:42318
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232825AbhGUNxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:53:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3fXhuj6usa8nq7TbBNSEdn4C8cFsmuP3fxS7Y/woMui8VLLddh9rtAoMk4HnsGSjTQSAZzwyxF7zUfRmLIdzegSOsXruSlhi/MjRu3+FPPB7kBWQe+ddlUaULI1pjOnkk723gwDH7b8jux/s8xKktI+zEemAtrq91l0qCqqu/UHG6ZD/CQhdL96hjfQSZ4a7dSzolcBki+C9wQvLRTah5wLC0/dNt8dOlbj/YlclfuPwgaxui4fjZSi49Nkv5iT6X2PvCEG5O+DQS/SNrHt5hfuEBFzzEjn3paN5fY93UHt9Keac5saQhphlfmqHdnhVLR7CDCKfSEfb4IKkk7mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ntWB9kiht2hy/zmIWQYDCnUkTDA18ormSmz9RjoKkQ=;
 b=UCE12hXMi4BONrsKePBRV57DVei6NB2Vxm9YvZj3dOgh8fiYrvn10mTSPhpL0KUDtGJIvvXun24CmPzw4i6x1wA68AcT6oD/rFuhsezo6vF/SQSB7iBvxPb+su517fegd3YEK92e6ev8x4GjdT/S9UoW6jhUSh8xB/4waLgxCcuwO7g41OMVFxebaOMpzNNWN6Sue91rfsMbDDjycG3wFCOZl4PWm9wD2UobnP9sdYtW3RLvOKf68AHWwD/vx7KyY3yJUkZjFtDpdxL5LfX5kXY5JSlmJeZV50+Dd0atG95NimT4/Xz5MZ/WXx28y71bCN2GAYbsiljeJY9JiD+boA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ntWB9kiht2hy/zmIWQYDCnUkTDA18ormSmz9RjoKkQ=;
 b=SEdGGfdjQ+fguvprf6B9zg6uOcLz8OpvZbuWMWnjZEFhET24vn15Q8VkBIyfXWrxxf+UOv5bbojEHx0qnDzHBcTJdRsm1bObtD8yumjNCd1W7fNoi0HIyxSQTAFIvg83kSWjHqTpn3pqZtLmD5Dqh3k5REamJrbiZE/MLQYdwJk=
Authentication-Results: cmss.chinamobile.com; dkim=none (message not signed)
 header.d=none;cmss.chinamobile.com; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB5872.eurprd04.prod.outlook.com (2603:10a6:803:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 14:34:17 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 14:34:16 +0000
Subject: Re: [PATCH] bus: fsl-mc: fsl-mc-bus: Use
 devm_platform_ioremap_resource() to simplify code
To:     Tang Bin <tangbin@cmss.chinamobile.com>, stuyoder@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20210720125050.28064-1-tangbin@cmss.chinamobile.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <899adf75-713a-3fcb-9c6f-a9c2f5e52021@nxp.com>
Date:   Wed, 21 Jul 2021 17:34:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210720125050.28064-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.105] (86.123.57.228) by AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Wed, 21 Jul 2021 14:34:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30145a7b-2ddd-45b0-965f-08d94c549e53
X-MS-TrafficTypeDiagnostic: VI1PR04MB5872:
X-Microsoft-Antispam-PRVS: <VI1PR04MB58729E6E7E5D845DFF132DBAECE39@VI1PR04MB5872.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suSJsU4jqHcJwwqD4CNSdDqO2t3AWREkLG+ECfpKNS/gpwdilJEovCKW3s7Lz4QLpgdmkl/+JNgfU4eAK7wFsAcxmZCXShLRqoASkX79UGd+us5kCJu4ZCHS7vKwQTObGLpNhHLq8QkuyTifqCKFna6AE7tpymw81zWhgnFlKPYnp5XyX/aoSiR22v6KyLZ0/3XJO35ejx1g3rMIads80CkgGzeNbSerwImKb/ouqT/k/6IjbbvtSlNQJ/9+6f0/bMx5rvgYkPxiZVn8vV5LtHpO9HmrS4objbrduP9QcnIZO2wgzz3wIARpwvLX1XscCXRYIc7HIaZD7McXznrmUYGY/7yXBHXVjCfCcbJLuTaBulLVN0+A+YYSJNGOlcdJ/p0OGcZWLJJDvdhDvTQlXD19NnpeBWYrYRLefoYvi0qf+PNQbwAI1fdB+SzESXtVj518fte5arDN1slKe19R0feW3GuJ7f7l5mRdoE+7ehwaEQTqHjt1ZEbRbHTsoP1W+A5ZzD0s1q5V7xYeF9J4hctx3QWg9M4L2bd2lSJeLCNj9GnlHgTRMEH+nZyRs6PVkP4rGpFV9mFBPLd4RNkEaoNNQLjntJSVXqkC2zFpPaywNVvlcgQysM3zq9tuDDlcuhdNNo5BsQrAeiyySQkE4rw308ygzKfkI7WiwmnYVTYu9qcWM38PU0pdC6G0C3rnOV9mZKVFC1GAfl4pb8rAZRKVu2ECLtydKBpsaJgs6ClxfPMhovct+WZXOCPaI7yuwhJaka1brx/Tv3adGqG6z1XMB+YiS6umbvVSfmSCIbKhCeGpWQj8NYP0MxCjUTgfOuMycx2XBFm95FSw0X3WWqru3+qbooIfP4SVzAVCpm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(6666004)(83380400001)(956004)(2906002)(86362001)(478600001)(36756003)(186003)(38350700002)(38100700002)(44832011)(8936002)(316002)(16576012)(2616005)(26005)(5660300002)(31696002)(31686004)(66556008)(966005)(4326008)(66946007)(52116002)(6486002)(8676002)(66476007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhWRTVlLzFWS2NoSVBtcGZ5ZDRNc3hBb1phbXVJZXlZcVRlNDZGOVp6MUM2?=
 =?utf-8?B?NmdCS0pFZHhTcXRFYmhVcnowWFFVTXRTdFM5VGlZZTZVNkp3d0ErMnVUSlNK?=
 =?utf-8?B?R2VWZlBMRDhnUVc1Z2FFQk5ydE5zZkNKcFN2UXp4TjY2MXBNamRaMW12MUN2?=
 =?utf-8?B?bXNWZEcyQ0M0RmdnMklaU2VNZ3dPVHZNaWpoeGpvVmlDTGxtK3BtNUVEZFBD?=
 =?utf-8?B?QnEvU3B1NFdNeFA5K1hHQ1ZiU2hTZWJVNlNwbTJzYmVEbTNoZXJPcVE4WXdG?=
 =?utf-8?B?aWVLdzdVN0VacERzVVphZk1uaDZyMHZDa05ycXlUaERMamdyNVlmZjdBcnlE?=
 =?utf-8?B?REczUFBnMG5SM3o0QWtEODBXVi9Ibm1aMFNyQmt4QVdEdTdIVm1McUdzdW96?=
 =?utf-8?B?T002ZVNtaS9VWnpIaGxMeXhxWjRvcUpWT0tXS3pTMDNubGE0WkZKMXdGTlNo?=
 =?utf-8?B?V0NxL2MvUW5UY0xTdW9kaTBFNldMSE5iZ1VTaDduNVQwQ282NWVNUWx3bmFE?=
 =?utf-8?B?WmtTek5UUnFDUS9EWmprbUQ1QkZhL0o1dzFzc3lqZWJ6WEl4TFB1S2hjdk5v?=
 =?utf-8?B?Qm9GYzU0MWVHUENIK0ZZOGZUeDJqQU9LT1hUa1dSZnVaWjRPdS9OcXROck5P?=
 =?utf-8?B?VVRqZHFENENLdXFQMXl0eXVRV05wZ3F5NXNCMm5kUlJNSm4rUUVZRlhPa2lX?=
 =?utf-8?B?QTlxTTZjZWNaQmtzbUNpOU1GYmFtWEVDd3RMdFhscFVhYWhremdUb25rZmMv?=
 =?utf-8?B?Zk1WSWw0ZFRaMFp0Q1g5QWpCN0p3ZkpEeXlMWjhsTTJaM2hicS9nQlAyWU9v?=
 =?utf-8?B?VWxCREx2Z1d3cTJaNkQwQUtuZzZPUC9FVXZhOVVSRzdiOTQ0a1pOaTdrYnFH?=
 =?utf-8?B?eExCOTNWNXBCVkQ2MEt6cldseEpYdW1JUC9uM3lIWE4wWm5qYzNpZHVzSUdw?=
 =?utf-8?B?TG4wVU9xOGE0VSs4eVN0OTE0QnBjK3p4VE5mZXhaekRqMSs1S2hLWU1nNWlm?=
 =?utf-8?B?VjVYQUU2bDZMbXNIc1FYZHNSeE83SjRBNWpTSEs4QzNrb1NabDR1S2I3QUpp?=
 =?utf-8?B?THlnTzVYUlFoVm1YbG9mZzhzVDB2aXRKY1IvYXUzbVM1YnFSV2tPMk9qSVk1?=
 =?utf-8?B?dkQwbWxGODgzQkFUakxUT2RsWUpBVlR3YWVGdStzV1l4WElwSGNsRVRTbDNF?=
 =?utf-8?B?cTV1eTVScnNpNkJ1SHhhalA2TDF6SERyNmNZeTkzK2JhWGsxd0EwdkNUVEdj?=
 =?utf-8?B?blNnYUlXUFRLVnpTWXllZjZESWRUUDNjU041dkdGaFkwS1JJVVRXNUVhVkxU?=
 =?utf-8?B?TEt6TitiWm1nb1lmejFTS1RkT214MWkyWTRtQ3phMXdSTWR0RWlndExYQW1v?=
 =?utf-8?B?Mkg1SFNmVkExYTZFTVFEZ1puNVVwUHRDNkpyQlZXZ2dVZGNhUXpUTDVqdCtk?=
 =?utf-8?B?elZ0RUI4L1FOZHlDdHY5QUxzSytjKzhHUjRnL3pqWmtSOHpLOG9BL2l1bTBP?=
 =?utf-8?B?R0ZWVEx1RnU2QXoxUlNqOUg2Um9PNVVsQ3VGNnRadWo0TnZSZlRNajd0Tjlx?=
 =?utf-8?B?MGhqQ1dnY1pRVk9sVytnZ3Z6RHFQWUM0bDI4eGdXSDM2czBOTlZ3cHlHbW9w?=
 =?utf-8?B?S04yUWNKeHoyWlEyWHB5RDdaNXRRM2EyOFJWcWRkOHpncDRyc0xTQU8raG1y?=
 =?utf-8?B?b0grVy91RDNVRlE0MnYreGUwNGI2ZktTWm4ydTY1dUZUYmhFaUF5clpQTTly?=
 =?utf-8?Q?VDfh9KTccRimiklqHzCOixX2Br/SZdBO3ZG6y+R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30145a7b-2ddd-45b0-965f-08d94c549e53
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 14:34:16.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJubPGkkLsAn5LgNadSN1Vd5jtTleUSCjNY69eRx8sW7tWK70xcHzlIl05AfJNzh5PSQcb05DxNBMjWHEoj0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5872
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2021 3:50 PM, Tang Bin wrote:
> Use devm_platform_ioremap_resource() instead of
> platform_get_resource() + devm_ioremap_resource().
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 380ad1fdb745..472f0daf4271 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -1080,12 +1080,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mc);
>  
> -	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (plat_res) {
> -		mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
> -		if (IS_ERR(mc->fsl_mc_regs))
> -			return PTR_ERR(mc->fsl_mc_regs);
> -	}
> +	mc->fsl_mc_regs = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(mc->fsl_mc_regs))
> +		return PTR_ERR(mc->fsl_mc_regs);

Thanks for the patch, but this is not ok as it alters the original
behavior. Not having region1 in the device tree is a valid scenario, see
binding [1] while not being able to read is an error. Your change treats
both cases as error.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt#n58
---
Best Regards, Laurentiu
