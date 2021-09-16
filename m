Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E43D40DA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhIPNB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:01:27 -0400
Received: from mail-sn1anam02on2051.outbound.protection.outlook.com ([40.107.96.51]:28164
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239553AbhIPNB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:01:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7fiMO7bAEEk5B9iC0lcPdcAgq2m/8PsPxSRom1L2NEazDmeEoLKfzSX1/h1Lub7gSFmeEoegpuRu6p0q/BKPctGMV8E8ltMoCA1OoTEFoIhB5Ny0d6nbEE/SfauOiOv+UgDFulfbhxKtDBYNcUgpaCeFEMy+8blu9/ACTbKBoERVi/HEDGy1CTMKvPU/j5Vkm0Fli49gg9QITPNScH8YKkUKK+BQI1TA9DB2UJ8A93gyVzhMH1HOPPhe8UQMXV0EGSMSPuOpx6LQKU7MzI0GcHUu8FXkvOrfA/CYA0GeMN67+xn8eri1973ubau1ZJZFBSKusqmcqiLKERZf14oMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7ctazRk+ikSq58dfXPY13o5AoQVwvIjf9vKEm89uWfk=;
 b=oCMSM7Y7snY/g6mQ0B8sUk0cupG3xWV7eJooaFw/9SGRffjzzAHgIV6K3mFHWOT/90lM/kA2htupuK+iR2XIuTAN6PCnQpsQ/hxndETD0/cdSfCJZngBUoE22CHe6g3WbSvYOA8zHOeWUPcYlbsdzOjlUpFojZfgxxjqS93d/AEWpiGxl7HzS/5Bd6hH4RGAPuv5gzK0BgllB7t9AuF0yjrMOPdKdiEKpxApP9+e6LClKMR63aj4HrVvol7low7NlYCsa8ELHj57O6vGFE2It/1oshyoFxl8FHw6Dr3XNUx6x4hGbRQdltnxhleWZsnQstfF4rxoXQXQV0G9WNFwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ctazRk+ikSq58dfXPY13o5AoQVwvIjf9vKEm89uWfk=;
 b=C7c9dqTcDft51BM91TEqh2ZRs2WgWAUHkdKtJV5S4UoQBcsLd95tvKFf2m3cP/fxgpGsZP8CHpDcDrMTMi08V7rRw3ZiOm7FVWcYFoHh9EWYyVz/u+iPPeF/DL9A5sUHXIelmI1EJjF2r1uHVqHPSBq+zVmUn3uDDYuGpuF2xOs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 13:00:03 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::888b:8deb:3f8b:8d61]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::888b:8deb:3f8b:8d61%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 13:00:03 +0000
Subject: Re: [PATCH] platform/x86: amd-pmc: Check s0i3 cycle status
To:     Sanket Goswami <Sanket.Goswami@amd.com>, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210916124130.2581-1-Sanket.Goswami@amd.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Message-ID: <1787c8b1-b539-a619-b7b5-58ca829baa57@amd.com>
Date:   Thu, 16 Sep 2021 18:29:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210916124130.2581-1-Sanket.Goswami@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::12) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
Received: from [10.252.89.180] (165.204.159.242) by BMXPR01CA0026.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 13:00:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9ac9e9-a888-4812-2192-08d97911e638
X-MS-TrafficTypeDiagnostic: BL1PR12MB5254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52547A87A4D89DDDF3514ED69ADC9@BL1PR12MB5254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZoyDlU6Wkui4YY9Io2jXzFPOZ4iIrVGaiWCx4U7j4Fx+V8YV97KOjCmNWNQTKqEVDhRuPOifl7KM+JHR290PzSr8PV10yq7j02GvUPVPN0H7W4ZPGcQ7GEdO+4Pvn3DKhrGd73r/x4TQFdk/YQBfUbwgNItoWn7xJT1aLZJ9guJEjNVwOyGMmko9SL+4eZ14ze1rZ9mhD7teEU9gm1oF2FV8I7q7xWaYfUJo0uFVR6rEo7gkmr/DDLBeb7AjJ5tn5CEcSqYt90bUN/lVJ7cr1GMFrqZWR6imGTCbfaQfiJikwEWtP3Twi3RS2J+6oFFWR7kYQgFERE2TiTvyARtIMs/33U4FeZRkflRpXJnYA5zoD42Y50cBTzcJH6zxwh5jZ3ITzqvwlrTmvSMmFrF74LM3gMkxAvPnNOl4bPHi2IC4ByQGSuovTSPkLWKATxoJswBPCXk3wQoTB1EltUY4XVYNgoIFU1MSDyGadjGl41LWyWWtsrGLDlGCEqR9pyCxVruXlARUFUTSpYBC3rJUfXlMymDnXTmr4pKG7LViFt/EiIfDwIwmmOnejPiHjWUPeiekHc55ROKn/OZtvi8R8o76oWwohs4uHNBBJZoq9hxM5kzvzjdYMSJxkx5/3V/eu+uy6iG+aGE/5DqXP69Un81cgXtHm5dCFIoQR8KF/wAIoc1p/6KpmJlyIYqBJVIW6o6vM3rY/HObtTwlzx71Iz/tiLKc8tZmyZjd7PwvxdM/xJPVJKglJhIaI+ikOrH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(53546011)(5660300002)(83380400001)(6486002)(186003)(26005)(38100700002)(4326008)(86362001)(66476007)(8936002)(66946007)(316002)(66556008)(16576012)(31686004)(2906002)(6666004)(31696002)(8676002)(956004)(2616005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wjlzb0hVMHZtWTJTOGt6eHlhbXlsV0dhdUIyNGR0dDF4MUY5ajBNSzIybC9Z?=
 =?utf-8?B?eG95YkVEbWJPZWd4QzVvV1lBTEhNR2xXZjJ2YmdoM3gwUGNsanlQOEtZRCtV?=
 =?utf-8?B?aVBtcy9rVkVobVZ3RmZieTA2VUJqQmlrZ081di9RbkxBOUJOT3dreXhqUVVR?=
 =?utf-8?B?cmVyVGxTTTR6anZ0emVEY09EVzM0anZvNExEdEIyOTlYdVhFWisvYW1walFp?=
 =?utf-8?B?TGFCVWNmcGNONStTVlpkZG9xQmkvRWtEMUp2WWx0K3lzeFUzQThUYUwrK3l5?=
 =?utf-8?B?b3JEcVNVNlpXSFkrZ2FiR3BRYTAxcnlRZ3JnSUVYWFAxUk5zNWNWUnNSSmRz?=
 =?utf-8?B?MDAvd0IwSGVRTllIWllrdGVqbitnSkxTRWc1S3dWOWRycXlQcTV2UHJSZnIz?=
 =?utf-8?B?VmwxQlFja3lLWWJYbUtURk5XOUx5WmxRYnh6TzFjOUtQdWltcGM4UTg5Nyth?=
 =?utf-8?B?eWJWSE5WT3NzK0IrejhzdWxDVHYxUVpaQVpDd1ZNREVjeGVkTDkrTXVLWUtt?=
 =?utf-8?B?aEl5ekFHMXd4Yy9uSUd6cGNCQjVQTm1GWGRjeG94Q2s2TG11M090bWQzdlow?=
 =?utf-8?B?RHhjQkl2NVl5NW5JcVFlWXBXS1UwU0Y5ZEJrMGpzZVRtRXhHQWQ4aXNoYjZK?=
 =?utf-8?B?QnFhbEV1WC8vRDlsYnpaSDNFYVZ3cUZaWkZ1V3BUcU50aC9qZ3BZYlJYYUlr?=
 =?utf-8?B?M2xBKzVXdlVhWGY1d2lIUktVNWJnTnZyMFJWTmM5RVZWOVVJUmpidGhwa1VS?=
 =?utf-8?B?ZUpJZnM2TG9xTUdtTlhqM1ZPOTN6MUtkaTAyVThHTEhSOHhhN0ptRDNKTnZZ?=
 =?utf-8?B?YTBwd3RReXBzdHpwclRjSHhzcCt3RGlQQ1FZZFJmMk81bllrRkk1bE9XNGEw?=
 =?utf-8?B?R3dIQWwxM1VPNi9NVGdWUy9SZ1JYRFp3V1VLSlNLdVo4T3o1c01DeFRWaCtO?=
 =?utf-8?B?MzRSSEF2N09jajd4enBNYitISXZIUnREQyt0YS80WmlnS1lRaDlrL204c21y?=
 =?utf-8?B?ZjhwUFZhdU5GUko5Z3FRdzJIN3hlNzBOUnJTZktkQzJwbWdZY29CVkVTS2dn?=
 =?utf-8?B?UlNFYjkwREVaOEkrYS9LckdpaHZFbUsxNVlWS2FQSTNsMjBOWGdZLzhCd0Nn?=
 =?utf-8?B?L3FMSDFjWitGdGFSWHFFSWpINEJlK2Yza3dGeFNFeXJPSHZSL093ejc5NHls?=
 =?utf-8?B?Vy9HRzdKTEhaZFgyT1pFaEpRd2cvZUJMenQ0Vkh1MzQ1V1h3ZjlCZXBCVnZX?=
 =?utf-8?B?TFNvd1hSaUJreHlLZm5iVGszeVUvcHMwU0tyR3ZRZTNzL0h0QWZGRnU1ZmJ0?=
 =?utf-8?B?SXFOQVFPMGVYNWx3S2dyNGdmcHEwQjFjcGxhTm91Qit6d1ZHc2hZTCtVR29z?=
 =?utf-8?B?b01QTkQwOTduQ0dmOHBKSDloWUpLOG9sSzZ6MldjVWtsTlk5SS8wd1ZxOFNC?=
 =?utf-8?B?ak5xUnUzQVZXc3FPU1UrMW5oS0dQelJxM05VY0NCbDBzQ1VKZDFyMnhvWDJ1?=
 =?utf-8?B?N3Q2dXhxelpKU3pObit4Z3d4cTU2TWthVVpadGVVQWNkd3lPNndXdEszRGZa?=
 =?utf-8?B?SFBudnB4czh6cWhTYW1lZzdWTjBuVVhRMGplWU1QZkI1dmdHMklIdUltTk9m?=
 =?utf-8?B?L3dKQmlQcHVDVkU3SkNBY3kwODdmcW5vQWVPT2hKK1RmTDVia0dpQ1puRjN6?=
 =?utf-8?B?MVlEaS9WZkh5elppRFZmUlk2TFJnaXc1Z2xlelcycE1nTFZHZXBJaDlGNWxa?=
 =?utf-8?Q?Wi/soHLgZQuLW4kd30GTQ2SrQmVgR0Fx7frhPnF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9ac9e9-a888-4812-2192-08d97911e638
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 13:00:03.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTq1lUMoJBf7KBkaQlWBWsTUwWKB2FX7qnB91qGlp3SyAMQEI+4xQJZO+uqFjGDeFllGWTg7mK+V/uYJ5/9Ozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/2021 6:11 PM, Sanket Goswami wrote:
> As the PM firmware returns the status of the last s0i3 in the smu_metrics
> structure, the existing name "s0i3_cyclecount" seems to be a misnomer.
> Change it accordingly to "s0i3_last_entry_status".
> 
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> ---
>  drivers/platform/x86/amd-pmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 0c970f613e09..91c1f1c6c929 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -141,7 +141,7 @@ static inline void amd_pmc_reg_write(struct amd_pmc_dev *dev, int reg_offset, u3
>  struct smu_metrics {
>  	u32 table_version;
>  	u32 hint_count;
> -	u32 s0i3_cyclecount;
> +	u32 s0i3_last_entry_status;
>  	u32 timein_s0i2;
>  	u64 timeentering_s0i3_lastcapture;
>  	u64 timeentering_s0i3_totaltime;
> @@ -170,7 +170,8 @@ static int smu_fw_info_show(struct seq_file *s, void *unused)
>  	seq_puts(s, "\n=== SMU Statistics ===\n");
>  	seq_printf(s, "Table Version: %d\n", table.table_version);
>  	seq_printf(s, "Hint Count: %d\n", table.hint_count);
> -	seq_printf(s, "S0i3 Cycle Count: %d\n", table.s0i3_cyclecount);
> +	seq_printf(s, "Last S0i3 Status: %s\n", table.s0i3_last_entry_status ? "Success" :
> +		   "Unknown/Fail");
>  	seq_printf(s, "Time (in us) to S0i3: %lld\n", table.timeentering_s0i3_lastcapture);
>  	seq_printf(s, "Time (in us) in S0i3: %lld\n", table.timein_s0i3_lastcapture);
>  
> 

Looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
