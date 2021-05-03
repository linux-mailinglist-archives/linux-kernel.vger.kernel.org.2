Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8723715EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhECN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:27:54 -0400
Received: from mail-eopbgr40098.outbound.protection.outlook.com ([40.107.4.98]:5670
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233592AbhECN1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:27:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGQRAL32gdTggAz8UF8kApbaC9tdiRw2g9yrhxbYHzQErVzSLYN3UNwU+YxBcT2vYaDxYhkNrGV5FLOBUlurJ3xc7E+jlf/SCucvWTJchivuXEQl6veynvPRnmenkxlRcDjv26u1JOE7tVWJp5n3Oxo6J58cFEoCirfuT7JnMBa6lrzSEypZpBlfgYmv4jD9Gge+K1F6OK/i1RqqCvIpNp/S9i5Sb6kqdLL3rrsgHnM3twyLOmXVjJTgT9Mem43IYKP2LE6ixUALpwft8TO9uLjbdsv2r2XeeqRM3GOOhggEz3fw4yPfMu5j/iMLPjsoNqD76/buTjL2r+LlSklp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1uJN5mGh2Ijsry/UfCLMkdVKSWugfJ080q5bvAEEaE=;
 b=L8Q1BrWMS39pNhrL8XWDPh4IukAK0wKQeWYqbzw9qFKaKXENIV+o+JBNC7oVQw0/pqXggTc/cPWD/begkQEg0A9j/FRdr/IV7dTDOZvrCu7KuXKkvnKwkgClUqUPgOfJAUbrPKip0n9+kU9z+/7S1vlZxDdMQeG9olCZfcf+gccF8+iMGQSQA86HZDkI8gzlUxj+3aWaKvq7Fj6KyF164ip8pF2QM0qbPi6xXDdhvUHkd0Op2YGZ05mWIWZUxzKUDk20qCUeMv1F9dXwwZx9ukmM+beEqRdpqXH5wgc/wNr0UQv1qcXserQePLY3WWmV3WLGIwmfdlzEkzoCapCZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1uJN5mGh2Ijsry/UfCLMkdVKSWugfJ080q5bvAEEaE=;
 b=kbhGKvy8awlg13+TI+Doe0lhlR9gv80HrLaxdtP1E0/RF9cdD9fGEUb1SQchsCq7UiVegEGr4osxnbyuf9MZ3Ji4iaXk1senHP61nlR4SXmoouKkHq3pmue8plBaXaucY/FBd+ZiUL7POg3OF0/J6mzWyuF502xuQj8lnc3CdnE=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 13:26:57 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 13:26:57 +0000
Subject: Re: [PATCH 01/16] soc: imx: gpcv2: move to more ideomatic error
 handling in probe
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-2-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <c8853ad0-edb0-13de-774c-3593313e9a6b@kontron.de>
Date:   Mon, 3 May 2021 15:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429073050.21039-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AM0PR03CA0075.eurprd03.prod.outlook.com (2603:10a6:208:69::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Mon, 3 May 2021 13:26:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00fa10ac-e835-4e07-fb4b-08d90e371fb8
X-MS-TrafficTypeDiagnostic: AM8PR10MB4100:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4100263758D936D9119FAB23E95B9@AM8PR10MB4100.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUIAd30TA/RqclD90TJGglfHHPldL6TmTaKBh/XD0uaB1Rv2pIrgAqOgvAS++pHAqpBaOerFqBcXidXfHSqwRB1OiGJD1BksRHzJ3c9FiT18i+WYe6Gtjgk+jhrZXSnB7mBMajwshLFtNBhxkL7DZqgEUJqVqeVUxAW+s6bKSZJhrxAWw1GiM8e7ZFI7WUo7cPFxPtdpUpUcm+jsKeUFy1DDLfERv9jGnxxKYl7B5UndGr3psFWIio9xSTCDP8jIFviYMlWpk3cMjjv/AobgLWvuUL/wJ/azgUlb5LVXqjoWrI0UD+DRZJsfiogn13wCeXxrVOaHYZ/Z/1whVOzhK0tausmFiG4KQlH8I09ZCkxCg6VTmRZRHrnqHZd2pqV1BiCpwL0TNN+TAt43VkbrVbg4XoTk/8MJG5bKHVHkPNVK/X/trftdkhmkuu/70K2ugXpP/IUmadITTnPN/t2hlQ5ld1TSux43dmCB46F2wiLqhgtWvu0hWn0Gsg9HGjtMRmGA/DGqxDM5I2/YRscDxHMOtumD+ltze28hDwdUswYhkTQAxFa215QCVFpco7QGjvQTRu9JqzrZ+kxwBVyHVXTlwJbUjEC0DY3esqLH/rbBgl8ne0/raw4cbXNRaUfA0jAanHp4lUlGtZQ0HmcohlzI9JE6K1kjUEEMt14u8iIWV3ww38HcAM9aokHQwkgt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(376002)(346002)(53546011)(5660300002)(4326008)(8936002)(6486002)(31686004)(2616005)(86362001)(956004)(478600001)(16576012)(186003)(7416002)(44832011)(316002)(8676002)(16526019)(66946007)(2906002)(31696002)(26005)(36756003)(83380400001)(38100700002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NjJDbmg4Z0hhSktsWFJUclFpSWwvQnJYWSs5NWtsc2RwN3hZcS9qS2l4cUda?=
 =?utf-8?B?MmtSMVVkWVlkcDF5SEN2cXZYKzg1RjdMVjVWNHF0TEkzRnZLRGVQK0lVUkhD?=
 =?utf-8?B?YTRSZDVuTkwvTVpjekliaUc5Tk00aVVHSW5EeHlOYy9VYjhJN1kxeGJBUU81?=
 =?utf-8?B?bmUyLzl1clAvZzlGS0VLNVZiTjFkYW5uM0NBL1lrMEFmVnJPb0Q2OHdUeDBy?=
 =?utf-8?B?WlNaenZmOTdOa2VMWHVuV1pZRkN5Z2ZWRjFPZCtJaEMvK3crb0RvU3greXBM?=
 =?utf-8?B?eGc5K0NxNDVGUGJxaXpYb2Y5QXZWa0JEZnBXRldremJRZXhBbzFSRDFaZDV4?=
 =?utf-8?B?dGRmQ2FkdWg4Zkhwd2o3djEzazB0M1Q1bVIrM2xuYXJXQVZWNy9BSTlsM0Nm?=
 =?utf-8?B?SHBPc1Y4Q0thU0puSElMb0RyNWJlT25MUjh5cG1EVWk0bG5PTmk3TWZPcHh0?=
 =?utf-8?B?SjdkbGFQRndCNlAyV0hOdVRNS3R0ZHdHdkRrQk1nYkttc3JWbk1Bc0ltRkhL?=
 =?utf-8?B?VktFdGxFZDA4eFYwSktWUGJyMndVZ1R4YTV0RlRKdGRNbjkxWXF2eXRKWCtF?=
 =?utf-8?B?U1U2RG9SRWVvUDBDR0QraE1jQmc1cHBOM3pYTVVPb0dOUXE5bG4rcVVyYkx2?=
 =?utf-8?B?R3ZSZFZRd3pVaVlsa1F1T2xPNjZhWllEZ0xhTjZ0YjUxYlh3TkZBUktlK0Iv?=
 =?utf-8?B?Zm9XL21PKzJ4WHNDTDFmVFdKQWhlNFF3dURqOUxLUG9TVk5DdkgwTnNKNUYz?=
 =?utf-8?B?b2o5Y2ZscTdPaElaYlpHWXJYSzRHUFJSRFBZRTNqZW1LTFY1djdDOHI0eWtQ?=
 =?utf-8?B?UDFVU1BrblUzUGc4Vkc2UUhXdzN4ZVVBZ3JWRFpYY2pTK1lVUGVJd1l5UVRw?=
 =?utf-8?B?UkRTakxYVFZWdmZHR2N0NStEY3lhMUtITTR4SmxRRUJPU2IwNGEzQUd1QVJk?=
 =?utf-8?B?aWFNWnFjWEVNTDExOEV3ekM5bXdseE5lV0ZxSFkwR3VISzQwcExaWEREZERj?=
 =?utf-8?B?QWZyZkhHclRlR25nS3dPTTg3RCsrZ2dmUWJ6RDRlb2FQNjVZU05HNzcrQXJz?=
 =?utf-8?B?UjdPbVBIM09pVkdJNnYreW5Db2JjR3R4ZjBZM1BpN1JMNGZ6SE1FQmFMSTNs?=
 =?utf-8?B?VzVkVEZYUURLTllRMmlKUDRCZnhZSFpjVkZsOW5ZcWUybENEblljOU9BMitH?=
 =?utf-8?B?UnFuaThVeStDQjkwbmJtVlRDMVpXQ1pvUmFnVlNINmdMUHZZRkttWXJiNlZr?=
 =?utf-8?B?S1RhTDUyeVI2aWhiTHRVa2ozSjNUY0xQMTdtVEFvS3lGbU1FQWNmSUNqK1VQ?=
 =?utf-8?B?VGZONktjc3IrSEo5U3k5U2NUTEptazZISFBWaHFHUWVObGt6M3psR250TEVI?=
 =?utf-8?B?OFh3OUpUOFduVCtjN0d1LzFOYklYemk1a2hxaWF5NTRDMHg2RnNPcEpISHlv?=
 =?utf-8?B?dnRoTGsxKzRkazJ1U1RDc0wxSlg2QWVHNDQwQ3NSYnc1bnZuVUhvWnlvaC9F?=
 =?utf-8?B?V2VkNXkxWDZxN1JKWlR1ZkNTSXVGS2lIZlZZL2Zka2RCVTlQWXA2SFB5UkpF?=
 =?utf-8?B?Q0xON1VERE84b2tVcklsb1ZDZmZNUXNwT1p6MUJ2S3diWDJpRkMvL0dQVm51?=
 =?utf-8?B?azB6WlB4ZmxZLzFjT25kWXVVd25YWVBzN1pUL2NBc0Q1Rm0xcE5LR2RjUmgx?=
 =?utf-8?B?WmdSUzZPeW52VHpnMzhWblNiMGdCbllJak9zOGtPa3ZXZ3VLUldaYVBFUG5h?=
 =?utf-8?Q?jxKbSYZmdmXA/d2uo6S2nFn+A7GdR/UeXg6ejJR?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fa10ac-e835-4e07-fb4b-08d90e371fb8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 13:26:57.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLZ2yuqfWWBzXLOCxaOAceLVa/VMZLrW8IKoj0etN8KYfH7QT+Q/+282ly5vu+vASvIOX6yO8IAWyDrgrP/A3j7rDLuEvzQvE20DjdHk+oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Switch to "goto out..." error handling in domain driver probe to
> avoid repeating all the error paths.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Tested-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/soc/imx/gpcv2.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index db7e7fc321b1..512e6f4acafd 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -502,18 +502,23 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   	ret = pm_genpd_init(&domain->genpd, NULL, true);
>   	if (ret) {
>   		dev_err(domain->dev, "Failed to init power domain\n");
> -		imx_pgc_put_clocks(domain);
> -		return ret;
> +		goto out_put_clocks;
>   	}
>   
>   	ret = of_genpd_add_provider_simple(domain->dev->of_node,
>   					   &domain->genpd);
>   	if (ret) {
>   		dev_err(domain->dev, "Failed to add genpd provider\n");
> -		pm_genpd_remove(&domain->genpd);
> -		imx_pgc_put_clocks(domain);
> +		goto out_genpd_remove;
>   	}
>   
> +	return 0;
> +
> +out_genpd_remove:
> +	pm_genpd_remove(&domain->genpd);
> +out_put_clocks:
> +	imx_pgc_put_clocks(domain);
> +
>   	return ret;
>   }
>   
> 
