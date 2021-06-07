Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8130F39DC16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:19:17 -0400
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:31265
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230145AbhFGMTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:19:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbUUT7N2WaWJ7PZGLdwvZ4I/WyRvXubGTjaH+377JMFeaYrd+ZhYE4c6VGrT2+ARPqiuGG9czOOeBJKFMxDImK6vKhRoS89CLpySs8+WOX2HEfKaARShNR4fTkU6WRp2iB3722w/R/gZrz08J1e8awimiAQT+F7q2PsAfDU8biNujwupS0dz9CKoAfPk1ey6jokA3X8FMmvaxM1tkNFXJSE5Cqq3bs1rSXJi6ICwl4WjwyNafYtyXd8/hIFtNtle2IaeWuth3WkJDL2uKXXPyIeR5fGYg62KH+78inmBM7ppJyThwT9hILThNjYLpsIkvhFhbr8R0T48p9YgTeckkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odx5toYn1ehbB9LtpszgrZ+edFAK+EvL0Lev7YNg1VI=;
 b=lmLY14WlZGLJZ0X9a2RJ4jNAHOnliF2AtrZog1G0HoKolJptbxdokhh2fzscQpPNdYaXRi2W+60MOhX/JWJpGlOzY5anDAG2vSQ6te0LDm8BubdmderDSFDcFnqtqgnHXEsVJHOKgnjM4rr4f4PT5jfV8+iHh9ty3q8jypm061dIjHa8yj3gFTt/CuIlZdpVEeLkYDmEgZrRP7KW9FV6ZvnlF184OJ/PfsJS/+yWMxO0oJMmc2zcD49lQtQn4cBmgJuZYyIkiFjsyOk4fffk6iUs/pfV7tPQ62Tb0u0M8Z3yWOyBt5XlLz1MOkAstD8OYTQUSeysGlPGzZMXI25FUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odx5toYn1ehbB9LtpszgrZ+edFAK+EvL0Lev7YNg1VI=;
 b=CJb8xV2BDy03uq3JfDeFUZ2fckGeLt/UU3oyYkpUSVrvgt61xP9fsXHxb3iHD/HEbX6MS0MSLpGQQ1qS8YqsP54VGrQwSkne6KxgXUFzroxUgLIla1Hbp5//BYLCNh/uNrmR/0KRl/iSP0DGyH9B3PmXCPHBOc1dTNphF9tZJrA=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB5039.eurprd04.prod.outlook.com (2603:10a6:803:59::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Mon, 7 Jun
 2021 12:17:23 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa%3]) with mapi id 15.20.4195.029; Mon, 7 Jun 2021
 12:17:23 +0000
Subject: Re: [PATCH -next] bus/fsl-mc: fix doc warning
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, stuyoder@gmail.com
Cc:     linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20210607035319.289741-1-chenxiaosong2@huawei.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <44f606cf-ef71-952f-eeb4-1d9f3ce20a67@nxp.com>
Date:   Mon, 7 Jun 2021 15:17:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210607035319.289741-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [79.113.48.243]
X-ClientProxiedBy: AM0PR02CA0205.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::12) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (79.113.48.243) by AM0PR02CA0205.eurprd02.prod.outlook.com (2603:10a6:20b:28f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Mon, 7 Jun 2021 12:17:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a18824e-9032-4d93-3e81-08d929ae3483
X-MS-TrafficTypeDiagnostic: VI1PR04MB5039:
X-Microsoft-Antispam-PRVS: <VI1PR04MB5039002E68F9F2E10DCAF55DEC389@VI1PR04MB5039.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMlziNjVSWihjJleMjeihQP4EYAtCGaQT+8fj2LgjYfy+ba0Rb5MZa+2j6yBbkE+jS5xIw5a4juQRFYlGR9zaxWQMA/mubHFokjvghtMbjviAIHZBk0R47ZDLmMI3q+Hx2VXK94frbPS8BZ7gK6QwBvKNWF+Q5yfyJ0Pqc4OMwMmCqUWrqg+67oq7QyfxWdTC09amXE2YWo5B4LNcCDMyarggVRZBKSFnGntj2LcaDc6fQ6keUVDl5u6tIOyzxRdW0HTEnZtGVQE7TofWruSVO28Q2PCB5qBVjTisTqdEL+FFq4fQx2gEoUDx/JEdPDqjYdMRdkl2555uawe3deGbY75NIWuxxrI7cYkBIEwC8nqwmG8ZNr3L2EdXM4FDFO5agvjdWDWBH7e0qahCGcO0gk4x9+KCx56nPE9h+uSscdTfgq5KrL+Kh2kMJtqsD0aVIfyHbEZaG2iIZZVfXl0yeFR60RpAejAb91f2WK1s36/VdaX9UPN+YkUD3/JjkY1Wxf1zLdjO8SvZAjCEwx+M0/UrcA5ljvXt5ILfMU2x9BciqdhR03IG0fXwBgMMOsPuFAgMI4OQ2+aQBVS3x94cPZzdFrD3Rl1gkAdvpwPYRL7q7ve2pWy5zgQ0EOpwf8DP3FaTkVXH3s2GpL3QB/UI3vJCLLZ6uXxbCOu6vXGKNdISm4WXvnNjHbWrHqTowraCgSsL3gZtOT7Vs4u8rclLplyTA7qeJ/uzNHjE9PXsz47lYxJmpJNQmkvVseMaXcZ7sPA5GlGBHaU1qNOigVYbe6xXXNgw3gXQYPsqJz4NukxEncnfPPRL5pQyY4/UIaOac2fyQC86LGoUhX4iiTtfXd2wm+nICRq01G2vMw4Whdyd4U2xCoumTft7liOt7IG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(53546011)(16576012)(186003)(316002)(83380400001)(66556008)(31696002)(52116002)(6486002)(5660300002)(36756003)(31686004)(16526019)(478600001)(66946007)(86362001)(966005)(956004)(2616005)(66476007)(44832011)(4326008)(38100700002)(38350700002)(26005)(2906002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UGRmSElOQTlUbTBlZGlHZk9jeEZtRmdJT3h0RlN5djVweDdCUnJSM2x4aHpt?=
 =?utf-8?B?ZDRUVlIvc3FudXJ5eTkxTEQzOEtvRmttdTQ0WjNOZ2M4NnVkNGlGUFI5cUww?=
 =?utf-8?B?V3BtREdYcVhNT2tzb3NNN0QyNWFMQytoNnRmalV5aVBGL2N3ZWFGWS92dnJG?=
 =?utf-8?B?MlB4WUtVRTdGRHo4ZHpYM3NJcGEwL3BQQmpPb3BBdDIxQko5ei8vVlpJRklU?=
 =?utf-8?B?bkhSdERwMGtyeFQ5em5NMXhzNXp1eVA2OU1iZTJETVYzSjM0cFVtd2llblAv?=
 =?utf-8?B?UGRoYWthMFoxU1lyWmtMOEJSTC9ReEZRSmVlT1hnRGMwdm0zUFdaQk1DZHhD?=
 =?utf-8?B?M0tWdFJiNTNtN1VYSTNRM0RxK3RqcldEM2E5RExuMFpqZVFDa1FWYVFWbXYw?=
 =?utf-8?B?aFU1UEtjeHZVclNtckZ5SlpNSm8ybVpCL3BEMFk2M20wTnZMaGxFWFhIRFVo?=
 =?utf-8?B?Z1ZIRWNJSDI0RWhnb3pHS0tMTHJKL2ZGWlVweS81ckZUUVc0MXFhZ3Bjd0VV?=
 =?utf-8?B?dnhWR3lLa0NacUJyZWxsZlJDWmc0MThrOEVEM0Y5NXBwNzFWWFpNaDlNZG4w?=
 =?utf-8?B?bTR6RDhLMG5heENwaFJnS2oxVlZMSmFvZEpoTndqUXFFMmhHVU5oUFpTSFU0?=
 =?utf-8?B?d0RUUXhqQXh3dzBodTA4WUJmZG5RMHVuYjcxV0VTbU5XeERONjdRVGlZV3BM?=
 =?utf-8?B?a1dENFV2OE1pckhqU2tTY292bGhqWGRwNlVrcDdIWmtJbzJrQ1d6djNQOTEz?=
 =?utf-8?B?UWY3TGVLQzdoZGFCV25QenZUNWlMMGV1aGJVcE9MMitoeHV3RUg4MVVKNzFP?=
 =?utf-8?B?VTB6YU85TXI4MlB0SlVOMlhUR2tHbm44MEhiRTFkbWVFZ1lya2w1L2QyUnlO?=
 =?utf-8?B?MUdlZG5NTDMwVmRvaGtpZDlPRDQ5Q3QyamRSRVVOamZSQ1ZzLysyRWJDR1I0?=
 =?utf-8?B?RkphVlJReEY5cG1zVXI5OVpyZXhWOUVWWXBRTmU3VHNXWmRodWxVYXpvcVd4?=
 =?utf-8?B?WmhHZ3BUbHQ5b2o2USsvY1d6bGI2dXN1MWp4ZHJkNFpLZEdnaUNXbXhOajRL?=
 =?utf-8?B?cE90aTk0SUtVc0NFWWlHNzB2Wkpsb0JDSWhMWW43MU54cGJ4SU56R2p2N0M5?=
 =?utf-8?B?cDJscHVlN0MrTWlJRkZidXRja2d4VWVKc2dSSENmRFRyL2wzS3ZxUzVWdVY5?=
 =?utf-8?B?SGxzcXhidHRUb0VxaWpBZHZRbVhSTlp5bHFiM2V5RmJ3RFlvbXYwNEJWdmtC?=
 =?utf-8?B?SElDcSsrNkh1Y1YycW0xbGRYWmJBREwyMWRLRElNTzBKUDArd0VFTG5wVjBT?=
 =?utf-8?B?ZGI4ZnV0MDU0eGZmS1d6eW5ubjFxM3NSYkRna3dpNzMyYnIyNzNOTDRhdmEr?=
 =?utf-8?B?NkFuYXhFeHlDTC85Mkx6UGk3dGFSaDdTb1h6aW9vY3plWnl5VFNIMWtYZDdq?=
 =?utf-8?B?Mi94N05IQTRIRm4xY1UydjIwYVBDVGIvL3QzbW5Gbko4dnh6Rno0dzM5RFRk?=
 =?utf-8?B?bmNWSUdYbTJ6NFprRzI5ZXZnQW1IV21FQjVMWWwra2VBSDZpcGVnOXFablBP?=
 =?utf-8?B?ait3a04zMXl1azBBenpXSTVPMWFnQ1ZiT3RaMHp0OTFvc3Z0WmlxWnFlWmRk?=
 =?utf-8?B?dTZjZWlDbmN1akxVVmhmTTgwTHcxTTcyMWpkVTQ5WUJPcDNHalZpRWJxQUtD?=
 =?utf-8?B?V1J5NzFPNHZkdGxEcWx3Z0RPQWI3Q05CcTRVcmgyakVtb1lxTmxwVGtHRngw?=
 =?utf-8?Q?PC0cXQyLb/HqnStV1mDDpTtse0FZSDpFN/le3wC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a18824e-9032-4d93-3e81-08d929ae3483
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 12:17:23.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkXDkwipW6DngF/G5vhrdx00radVaTwhMKS6xfdQM3xfMoyJ3CQRpJZGhAQJG5NJ/kAH410OBsEvlcw/EvdWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/7/2021 6:53 AM, ChenXiaoSong wrote:
> Fix gcc W=1 warning:
> 
> drivers/bus/fsl-mc/dprc.c:345: warning: Function parameter or member 'attr' not described in 'dprc_get_attributes'
> drivers/bus/fsl-mc/dprc.c:521: warning: Function parameter or member 'obj_type' not described in 'dprc_get_obj_region'
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>  drivers/bus/fsl-mc/dprc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
> index 27b0a01bad9b..c862e9119b4d 100644
> --- a/drivers/bus/fsl-mc/dprc.c
> +++ b/drivers/bus/fsl-mc/dprc.c
> @@ -334,7 +334,7 @@ int dprc_clear_irq_status(struct fsl_mc_io *mc_io,
>   * @mc_io:	Pointer to MC portal's I/O object
>   * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
>   * @token:	Token of DPRC object
> - * @attributes	Returned container attributes
> + * @attr	Returned container attributes
>   *
>   * Return:     '0' on Success; Error code otherwise.
>   */
> @@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(dprc_set_obj_irq);
>   * @mc_io:	Pointer to MC portal's I/O object
>   * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
>   * @token:	Token of DPRC object
> - * @obj_type;	Object type as returned in dprc_get_obj()
> + * @obj_type:	Object type as returned in dprc_get_obj()
>   * @obj_id:	Unique object instance as returned in dprc_get_obj()
>   * @region_index: The specific region to query
>   * @region_desc:  Returns the requested region descriptor
> 


Thanks for the patch. This was already submitted [1] as part of a larger
series [2] by Lee Jones.

[1] https://lore.kernel.org/patchwork/patch/1436378/
[2] https://lore.kernel.org/patchwork/cover/1436375/

---
Best Regards, Laurentiu
