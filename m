Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03307356AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbhDGK6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:58:30 -0400
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:12891
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235067AbhDGK63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:58:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARQXq7CJrCMoWjkF6fUePRhDPnmJgposmbuQ0LtcKmFmUfnGe+xQMP1TkkULaqb/xZ0OurjhYnEe1jE2mxeLvytVxB6e+W8XmU86yXk7iyQGLMTOwz6JmWo/ZPMnk8XjJppVmJAlLw2i3W5HXpTwGX6EAPkrSGV7v7M93wb063Cd2eibpYAyV85h07Je+HQflRGPu+Yto8I9Pk+dWreMsJJwkA74F5jzVAeo2rOH/6NsRnxOZ2ycF1vXVzPQu3HgeyOnYI/G0kH9Ch3dXgfz0Wi3SbYifSkposw8cDzBO7KCFtst2lg5DfbbIQKybkHVuNYL9Hhdmg4D778vwxRt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUYt+kJQx6Cok3cBXmHNMYDwqhJDGNuy3EHMBk8p4GU=;
 b=eja3GT9He8zaOK5OKNCnLLMQS79ijy5YjwAG2H3fw8G5wtVgCmdz1yud3tWC3gJZ7wdqNwFwAin8o3j7muTyYB5aD8S0mM2GS1R2jThGQVxArUIqPpR6wqEmZejGnp77vvkIXLSHre+Y4t3CxpILjyX6IugqmS0B+GoZsuZeck69D89VWO3TAY9qBp5Duu4GaB8W8hZrizB1k0s8x6qVXUaLSbDaQokZkb+Wilsfl79zs0beOfVJJDT3lkMBhN4SQDVrlI1ulxl1KcojGCeJr8pkkFyeRyaL0h9LgYIN/tbipHBZBUDFuY2Vi6UkUEPDfPMh0rpfCjvXJDd8d5pZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUYt+kJQx6Cok3cBXmHNMYDwqhJDGNuy3EHMBk8p4GU=;
 b=5W981hhQRQe06G6f1gA/yba1E/n5Cx39+RS0viudBOlYQGP+hcE0jj95DjVvKZGxSDXxgQHycXdnKK6nXXNpP2Rn2t0Kzrh9JFWmRJG1twgJ5F/x++Yo63XOyLvvVud+TCw0PmpICRmiqcp/A41r+dT7iQMGLQGxsNKIsXcXNsY=
Authentication-Results: yulong.com; dkim=none (message not signed)
 header.d=none;yulong.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2545.namprd12.prod.outlook.com (2603:10b6:207:4e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 10:58:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.017; Wed, 7 Apr 2021
 10:58:16 +0000
Subject: Re: [PATCH] drm/amd/pm: convert sysfs snprintf to sysfs_emit
To:     Carlis <llyz108@163.com>, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     evan.quan@amd.com, kevin1.wang@amd.com, nirmoy.das@amd.com,
        ray.huang@amd.com, Xiaojian.Du@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@yulong.com>
References: <20210406141148.64795-1-llyz108@163.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ef97b546-2c5d-5e66-782e-c7b4c7d31f00@amd.com>
Date:   Wed, 7 Apr 2021 12:58:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210406141148.64795-1-llyz108@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:c8cb:bea6:b85a:47d0]
X-ClientProxiedBy: AM0PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:208:1::44) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:c8cb:bea6:b85a:47d0] (2a02:908:1252:fb60:c8cb:bea6:b85a:47d0) by AM0PR04CA0067.eurprd04.prod.outlook.com (2603:10a6:208:1::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 10:58:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 057c3e82-ce94-4ad0-7812-08d8f9b40bae
X-MS-TrafficTypeDiagnostic: BL0PR12MB2545:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25450D1A35CEDF32C9E6CCC683759@BL0PR12MB2545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:86;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1b19dwhu3CqAsp6YrfIAUS+Dcm5yiSFzQihip5DkmqoaHOB9a1KN9TxY+ARzKNe2X3d/aXMbCv/oJ7UKSy9+KFCkjpBPnOrRMIuLWM6yYc7/uSsZrj7K0MB5KPGKrgHlfIkURkmtgZVMTHeufd/7foyxD5YUYphCa644bo8A4j+yGya7lRZEnzcg3j3H+LdF44FrEdavEQtZYeMnjrNxNZVcdIM4mdmXwYVmAhne+UFFoYwy7ZCCRr774hzmWSP+9Z7cP1ealemoB4XA9dpq9hAtq+VhoYH2hsKegoKoyoQKNY+lweXjZqbIR4BeVvIPRKoGKdHrTjuHUpRXDtm96N7MGYKQWFLQh58pv2AeIxBdFMsT2kl/cbMiqMHqMKC4lg8paCepsCN69JqPLS+Rm3XObXoHBrpEPZZJiNKEayiM3GcNT6EEYtqs/rexTeA/nN+lsMT0rUoxUvozuMNr8iIOrLq+05FPqMQUtFQOI990RvPouleZO6nS7oJeqUDUd9Hzra6jEgIKuOoIXbNI95fYskpFMU9Dip7A9r0r/vjIfCPFAIgMhEhXkuRGOSJekfzb5CNgDH8QK9Kztc/7s++PvofhJO9z4GA5CYKIGk5b/II3Svp620YjrEQsUAs4VDVZpE6NUP67vfkQcEUqYRwRrYZNMp7ZFCbG28XHPdKHUQ8XxdUUh7VCAYqPxTzWEmBR3FBnEnauEmjfZiAGJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(478600001)(66556008)(66476007)(66946007)(16526019)(186003)(31686004)(36756003)(52116002)(83380400001)(6666004)(316002)(66574015)(5660300002)(2906002)(86362001)(8936002)(31696002)(30864003)(4326008)(8676002)(38100700001)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?KzUvUEdZdDRhb3lLcmlsbmY1b01iMXBvdlpZSjI5WXd5cVNlbE5iMm5ET25L?=
 =?utf-8?B?NUNySng1amNRd3lueGw0L2tnN2dOdEI1UGRMRmNYWWxPNkhRN3l6OVZ2b1Rr?=
 =?utf-8?B?SUd2eWZxbVZPQU1Uek9CNEtXOTQvUGZGdW1TMm5qdkp2dkdNbXFmRjdLdUp6?=
 =?utf-8?B?cjJYTTVyVFZkMytJTEI2eTBCUmdzaVRRNml6c0QzczJIQjNOaXc2YjViempR?=
 =?utf-8?B?ZVhmVmJ3VlA5RDcwYTROeEE0QTduVzdDcGhwWC9UNFdTZlY2T2VYZldoamJE?=
 =?utf-8?B?RUd4emVQUzJ5QUptVERxY3FNcVU3dE9NeEI5cnczMjcrNmh4VjBaNTRGWWdt?=
 =?utf-8?B?elB0VWdGV21IOGlZckVNeEFiaTNoaHN0eWU2N3ptZzB6SDBpN21qMEtMaUpO?=
 =?utf-8?B?VFlVU1hGb04wUlYyMmovUE50ZldoeksxbHNOTVFhVjNlTUs2OS9jajNzMk03?=
 =?utf-8?B?Z1BKeWRMbnhiNzlPajJIMjd0MFhoMmZGTFdLWEprZnZHazNKVUIvakowcUkr?=
 =?utf-8?B?ZHJIUmVGSzRGTGNqWnorMzJtRU9iMlJiQmJBM21JWldjbDdUeFlrU1U5MTdR?=
 =?utf-8?B?TXJUbzhQWHBDNllFT2VjQUhYUVV5WTZtWldQTEZwaXpJME5XdXdJaWhsSmlL?=
 =?utf-8?B?V1QxUGdsaHU0ajVVL21za2wxRkFzcUhWWWFXQ3JOdHhkRHA0Q0poT3pZcmox?=
 =?utf-8?B?SlRzaEVwWjJNVzNqLzlPWUVKZXMrVEdYVHZNRUJ6dXFZK2ZQdkQ3RVNTd29h?=
 =?utf-8?B?b2drTW4xNzZVMjY0TjM2WHZuS1prSEFyQzNGK1FPM1ZJY24xbDc2QXgvMVZp?=
 =?utf-8?B?Z2ZldEtRS0RRdjA2TDY1WWRjYnZnYS9ITkkrOGhsdEg2aGc3RjVSZCtCTS9l?=
 =?utf-8?B?WHlrSGpOQ08vVVN2NDFWMjJXWGRPVjV0K0dETFFOdzB4ZHU3WURxV1ZtTUly?=
 =?utf-8?B?SkhRd1JOOHNQVDRYWGs5TUZmc1RHSFlIWVB4SkVvakZzemN6d1hoYVdDajk1?=
 =?utf-8?B?cHBFQ1BZSmF0SGMzZGlkTVZnVFNzMy9wOHhybm9uT0cvdW5MdmVWQnc2eGQ4?=
 =?utf-8?B?K1pSMGsrek8vWHZpWXQxWkFhYm13R1RoMXhFMTB3SUE5eFNSVFQzVkZ5WmZB?=
 =?utf-8?B?QlpraEVUWHJMdGYxV2RqQkNpT3FScCtxN1NyVmlsdFpyQUVFcUM3UVdpQUJB?=
 =?utf-8?B?cFJpd3ErOE1ScFNVLzNrcU5IZzVVLzlUYVdSck1BZzVvQ2Z5L1k1My9KT1F1?=
 =?utf-8?B?VnFsM2MzZFAxT1FqSURybmlIZ0s1N2hMN2lFdjl3MlA2dlQzQmc1SDdidDli?=
 =?utf-8?B?UDlYSkZwTklLQXJ3ellDUEJneEdiMHMwbXRBY2xjbUZFZWJSeC9zaXpBcjZM?=
 =?utf-8?B?TWRkdnk4b0VqWVZnZ1dHblFTN0MyM1pYenlxdFVaZTdObmVoWVJxVnhLYVVE?=
 =?utf-8?B?dWpJRnhReFVBelpQbE95eFR6SS9semt6Q2IrTFZYdElhRjRLQm9CNU1wb01O?=
 =?utf-8?B?V2RKUWthb0ZKZExMUSswQWcyajEyd1NFRmw4azVjVy84TlUwd2ZWM3pDZ1JM?=
 =?utf-8?B?UmdLQkphMVVwclFueVg0WFE4di9IQ01DQTdwNktTbUVSN09Id2FzK1pQbU0r?=
 =?utf-8?B?OGpLWVBvbE50QnkvTE1zMmRLRURuM1QzN29SYWlETDRmcEhZNEg3SWR6ODF1?=
 =?utf-8?B?SmVrWXA5RmN6U0Q1N0RqbG5uZGxsYWZQMjk1YTAyblMrQU9KNmd5UXIvcWpS?=
 =?utf-8?B?SGs5UXd5VGlGSkFvVi9XY2FDR0pRVSs1VCtITllLRjNJTDlocDVaTnlUUG9q?=
 =?utf-8?B?emE1WlZTY1dNQ3FQWGRSem1lYmZxMCtvS0k2QTk2MkdwWDc5TGJmTnl2c3Bu?=
 =?utf-8?Q?qpGexncEtbIiP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057c3e82-ce94-4ad0-7812-08d8f9b40bae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 10:58:16.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrgT2X9xU9Ow/csRNDa85IN3AT0Pln9lcEkwnvyYdCV89VmLu0vlCg2PsGz5SVQE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.04.21 um 16:11 schrieb Carlis:
> From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
>
> Fix the following coccicheck warning:
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:1940:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:1978:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2022:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:294:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:154:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:496:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:512:9-17:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:1740:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:1667:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2074:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2047:9-17:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2768:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2738:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2442:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3246:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3253:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2458:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3047:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3133:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3209:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3216:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2410:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2496:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2470:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2426:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2965:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:2972:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3006:8-16:
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm/amd/pm//amdgpu_pm.c:3013:8-16:
> WARNING: use scnprintf or sprintf
>
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 58 +++++++++++++++---------------
>   1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5fa65f191a37..2777966ec1ca 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -151,7 +151,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>   			(pm == POWER_STATE_TYPE_BATTERY) ? "battery" :
>   			(pm == POWER_STATE_TYPE_BALANCED) ? "balanced" : "performance");
>   }
> @@ -291,7 +291,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>   			(level == AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" :
>   			(level == AMD_DPM_FORCED_LEVEL_LOW) ? "low" :
>   			(level == AMD_DPM_FORCED_LEVEL_HIGH) ? "high" :
> @@ -493,7 +493,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>   	if (i == data.nums)
>   		i = -EINVAL;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", i);
> +	return sysfs_emit(buf, "%d\n", i);
>   }
>   
>   static ssize_t amdgpu_get_pp_force_state(struct device *dev,
> @@ -509,7 +509,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>   	if (adev->pp_force_state_enabled)
>   		return amdgpu_get_pp_cur_state(dev, attr, buf);
>   	else
> -		return snprintf(buf, PAGE_SIZE, "\n");
> +		return sysfs_emit(buf, "\n");
>   }
>   
>   static ssize_t amdgpu_set_pp_force_state(struct device *dev,
> @@ -1664,7 +1664,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>   }
>   
>   static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
> @@ -1737,7 +1737,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>   }
>   
>   static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
> @@ -1937,7 +1937,7 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>   }
>   
>   /**
> @@ -1975,7 +1975,7 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>   }
>   
>   /**
> @@ -2019,7 +2019,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> -	return snprintf(buf, PAGE_SIZE,	"%llu %llu %i\n",
> +	return sysfs_emit(buf,	"%llu %llu %i\n",
>   			count0, count1, pcie_get_mps(adev->pdev));
>   }
>   
> @@ -2044,7 +2044,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>   		return -EPERM;
>   
>   	if (adev->unique_id)
> -		return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
> +		return sysfs_emit(buf, "%016llx\n", adev->unique_id);
>   
>   	return 0;
>   }
> @@ -2071,7 +2071,7 @@ static ssize_t amdgpu_get_thermal_throttling_logging(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   
> -	return snprintf(buf, PAGE_SIZE, "%s: thermal throttling logging %s, with interval %d seconds\n",
> +	return sysfs_emit(buf, "%s: thermal throttling logging %s, with interval %d seconds\n",
>   			adev_to_drm(adev)->unique,
>   			atomic_read(&adev->throttling_logging_enabled) ? "enabled" : "disabled",
>   			adev->throttling_logging_rs.interval / HZ + 1);
> @@ -2407,7 +2407,7 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +	return sysfs_emit(buf, "%d\n", temp);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_temp_thresh(struct device *dev,
> @@ -2423,7 +2423,7 @@ static ssize_t amdgpu_hwmon_show_temp_thresh(struct device *dev,
>   	else
>   		temp = adev->pm.dpm.thermal.max_temp;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +	return sysfs_emit(buf, "%d\n", temp);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_hotspot_temp_thresh(struct device *dev,
> @@ -2439,7 +2439,7 @@ static ssize_t amdgpu_hwmon_show_hotspot_temp_thresh(struct device *dev,
>   	else
>   		temp = adev->pm.dpm.thermal.max_hotspot_crit_temp;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +	return sysfs_emit(buf, "%d\n", temp);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_mem_temp_thresh(struct device *dev,
> @@ -2455,7 +2455,7 @@ static ssize_t amdgpu_hwmon_show_mem_temp_thresh(struct device *dev,
>   	else
>   		temp = adev->pm.dpm.thermal.max_mem_crit_temp;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +	return sysfs_emit(buf, "%d\n", temp);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_temp_label(struct device *dev,
> @@ -2467,7 +2467,7 @@ static ssize_t amdgpu_hwmon_show_temp_label(struct device *dev,
>   	if (channel >= PP_TEMP_MAX)
>   		return -EINVAL;
>   
> -	return snprintf(buf, PAGE_SIZE, "%s\n", temp_label[channel].label);
> +	return sysfs_emit(buf, "%s\n", temp_label[channel].label);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_temp_emergency(struct device *dev,
> @@ -2493,7 +2493,7 @@ static ssize_t amdgpu_hwmon_show_temp_emergency(struct device *dev,
>   		break;
>   	}
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +	return sysfs_emit(buf, "%d\n", temp);
>   }
>   
>   static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
> @@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", min_rpm);
> +	return sysfs_emit(buf, "%d\n", min_rpm);
>   }
>   
>   static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
> @@ -2765,7 +2765,7 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", max_rpm);
> +	return sysfs_emit(buf, "%d\n", max_rpm);
>   }
>   
>   static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
> @@ -2962,14 +2962,14 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", vddgfx);
> +	return sysfs_emit(buf, "%d\n", vddgfx);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_vddgfx_label(struct device *dev,
>   					      struct device_attribute *attr,
>   					      char *buf)
>   {
> -	return snprintf(buf, PAGE_SIZE, "vddgfx\n");
> +	return sysfs_emit(buf, "vddgfx\n");
>   }
>   
>   static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
> @@ -3003,14 +3003,14 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", vddnb);
> +	return sysfs_emit(buf, "%d\n", vddnb);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_vddnb_label(struct device *dev,
>   					      struct device_attribute *attr,
>   					      char *buf)
>   {
> -	return snprintf(buf, PAGE_SIZE, "vddnb\n");
> +	return sysfs_emit(buf, "vddnb\n");
>   }
>   
>   static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
> @@ -3044,7 +3044,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
>   	/* convert to microwatts */
>   	uw = (query >> 8) * 1000000 + (query & 0xff) * 1000;
>   
> -	return snprintf(buf, PAGE_SIZE, "%u\n", uw);
> +	return sysfs_emit(buf, "%u\n", uw);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
> @@ -3130,7 +3130,7 @@ static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
>   {
>   	int limit_type = to_sensor_dev_attr(attr)->index;
>   
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>   		limit_type == SMU_FAST_PPT_LIMIT ? "fastPPT" : "slowPPT");
>   }
>   
> @@ -3206,14 +3206,14 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%u\n", sclk * 10 * 1000);
> +	return sysfs_emit(buf, "%u\n", sclk * 10 * 1000);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_sclk_label(struct device *dev,
>   					    struct device_attribute *attr,
>   					    char *buf)
>   {
> -	return snprintf(buf, PAGE_SIZE, "sclk\n");
> +	return sysfs_emit(buf, "sclk\n");
>   }
>   
>   static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
> @@ -3243,14 +3243,14 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%u\n", mclk * 10 * 1000);
> +	return sysfs_emit(buf, "%u\n", mclk * 10 * 1000);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
>   					    struct device_attribute *attr,
>   					    char *buf)
>   {
> -	return snprintf(buf, PAGE_SIZE, "mclk\n");
> +	return sysfs_emit(buf, "mclk\n");
>   }
>   
>   /**

