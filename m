Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32F40A96B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhINIj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:39:59 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:22816
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhINIj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:39:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJH0yok0d+9iHseaNSq6bahXdH12Tm+a2c2GLRSyEXRh2oRTeuKPAJ+9DDGThPpYjRgUtdunR0Pgj3xt56HCLEpsN4uVmAvqqhrYOAN1qrgFqcS3H4/bube8Ruyh8J8SPD72G+P2vBFYBQA/2p59G4Qgtup9BPQSrN58FIWi1W06hdYLEm/MfqtIGm2Rt5bnnrU/e1wvOhh0ScfQ7VOT8hNtFGl+nQRhREyHgROjrczeKIKsTQ+sLXl4gGviNImDC3gEBLSWSrMgPuCoVZ6SRRoI+CDPTYk71+mdV6rcIiwLTWDTnmmIuUUGEUFY+tMLQHiifZXpRM8UBxjnxQ0DeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G1humwj+NR19tTf/0txX0z4834SpFqBfug4O6f3qE8k=;
 b=aSBpjOlYgtMHs9wMKt78oxntwgu6SnMRrN+X10WFe9R8cwhL0f2vnI+wM4nWB99tiXfXcu36pkVW+uIDOeXI0UyR3zazDni7+flav6NumEeImY8e5gaoaM39oqCk6wDfUSmzuSvGxNblhn95PMQOx4hAYX4SvbELu8O2k0dvJYC/UvNEGfv7Cm8KEUdv81n5Itme899ud9u5NZ6iZY9gW+x7lH1zEWWsyWaCeX7zO8I6eOnGCMSYe9DVd5Sc4QKzqGTVRBI6qfApIv+lQvqNxvMHdOz6i0Z4ycO58CYoIHRjLEe1HoGGXvnpuFvfBzRd1aBWMCpeVf5ew638MdrveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1humwj+NR19tTf/0txX0z4834SpFqBfug4O6f3qE8k=;
 b=fAc1QTwX/glZnwL8O1JM4ALS7qqBc2W424BJXEfgd1aeV6I6MKS7c5jK8O08uf4rgOTX7L/VilPKe83mdmXX9VWwdO+hCGAFdVoZmr2unZCn6xC1lBv/qheq4MykdFDKAx02q0eRLQg9W1QTq0oGCntnt4spjXP7Ppeszgr3Ujg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 08:38:33 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::888b:8deb:3f8b:8d61]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::888b:8deb:3f8b:8d61%5]) with mapi id 15.20.4523.014; Tue, 14 Sep 2021
 08:38:33 +0000
Subject: Re: [PATCH] platform/x86: amd-pmc: Increase the response register
 timeout
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     stable@kernel.org, Julian Sikorski <belegdol@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:AMD PMC DRIVER" <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210914020115.655-1-mario.limonciello@amd.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Message-ID: <666c9ae0-68d5-6008-6fc8-05d097fe3023@amd.com>
Date:   Tue, 14 Sep 2021 14:08:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210914020115.655-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
Received: from [10.252.137.85] (165.204.140.250) by SG2PR01CA0130.apcprd01.prod.exchangelabs.com (2603:1096:4:40::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 08:38:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67372e89-8715-4b83-67a6-08d9775b0912
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128801757C946FCB088680F9ADA9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+CiBVlbPgw7/ZFoVvEewoVKv3q29IFvsLh/wPxox9F8TLEFNQKl/b8rI36vGMXEyaGtrxflGwAa8mW0txAb075irHLrOXDwRjSjVWy7zss48YvNHyBnZ6wfHgZeBY7h5XpYI4ppICdg/TFYi3BiSDVagHT43Yy8o8sTVQeJmmMZj4X2R7zeLaB8q4ZLEaaEtYnb1mn5jeBDnrZxiNrhZlCt6o2X5P8uyjlXYMpYXLUsafcuBMamVtWoJvHWCJ070O1yHQxpFOQUqo9PrgQKNmZVgfnsPh5OjFppUGstdrbzFMV6Qvvm4vzUL6ziZW7dlnBppkGyf7BtIBEQ81T3JCkLVH2qwAfJ8GZZD+LwapfWy1A3mU/JFYbIzOV9q3okxYf14toaZ6n72xL1o11j33WT9BG7i+02nnaNv7FuWtM8sU77aWNgOsvIfhibGeo8ocU/1pegSZ6sogN/9vHYdcZMEbfQwZMlY2qCcTDonXMv/Btrervu9q046OYMO2jE5LdlfrxQo2l5zmZUHhnhgNJ0cEONFlt/scsnyJt/bK8HK5w7UudEZB2GR3VEE2J8qHnUgTv3cDZxjv/0LwmmzwyEikOvyNyWya/v112P2swBOMG595JYk4OhwUDyweCZR2mZpFH/zHqlI4ssc/BEBI+S3dy6Rzr0XiV5HPU+680YmF2oFsY4f60jaiV2aRs+hQse+OVF8l5I1acxV56hwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(186003)(26005)(4326008)(36756003)(54906003)(2616005)(966005)(53546011)(5660300002)(31696002)(66946007)(6486002)(2906002)(316002)(38100700002)(31686004)(86362001)(110136005)(478600001)(83380400001)(66476007)(66556008)(6666004)(8676002)(16576012)(956004)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWUzeWt0K3dES3NxcmFzVGVsMk52ZlpNZWhFaHhxaUN1djJBbTVYUWswL0ky?=
 =?utf-8?B?a3Zoa1JjcWkvTTJpK1V5OU9FOTF3M0t4bkhFV2pPcDY5bTlXUXVFNFdkNXZZ?=
 =?utf-8?B?cVdibFMzMWI1dWtYaG5zNzlSNVFUU09pbGVxek4rcUducnZkOUZUZE9ZcUM0?=
 =?utf-8?B?Zks0TmJPV3krSy9sT1NkYXFQK2cvelZwenRlbUZPM016NWowZkRweVMybXNM?=
 =?utf-8?B?emljQzFnY2ppZzljK0NPVU5CcXJjazd0WXFZT3JDK0FKMlBhWkV0cm1CZEFJ?=
 =?utf-8?B?cExlZlgzSEJhVFlUSUVVa00yaHdpNDZFaEN2ZnRJOSttbkNydjRFZkU1Kzhn?=
 =?utf-8?B?S3BiWkk1V21NbmN1dlVuOVJUTnBJV3YyYmNiVzNGUkszRGduNmFDNmdaU3Ix?=
 =?utf-8?B?WXpsaVhqWnMzVzFLUmt4d0dKamhyWWMraWZDaXdObTh6djMydTB6ME9HOCsv?=
 =?utf-8?B?MjFqSC9uTkV6NkRCdVFVcGZ1bHpnbnhPVExZeUFwY0cxQWVjQWdmTExaK3o3?=
 =?utf-8?B?M3Z1WFVQVHNqZjhoTHo4V1dWOERGTUpHN21oMlhLbDFrbm1EOXZzQXlGUzFW?=
 =?utf-8?B?L2NnRFJXOWdRWjlEbUY2SlEyT25vb1NhWnhndXowd3NiYjgrQ3ZUMDR3T0wz?=
 =?utf-8?B?VHRIL2thZUI0dmE1T3JEL2c4aTVDMGdWeHp1dEZZMGE4YlMyYmRXb3pUeTdz?=
 =?utf-8?B?K0x4cVU4aVJHN2czdkVxR2xDUENEd3N6alc4dG9aQW5Bc1BlMEM3VlpBUDUr?=
 =?utf-8?B?OW9LQkN3K3ZVZkZHQyttaEpIVm5iNHpSK1VvL3YxWUpOV0tVUFAvbmEySE0x?=
 =?utf-8?B?bjVudzFXdm9NU2psZnB5QkFjTVVFWXZGYmhBeGFUSjhDd2NDanRLcHpkVGFT?=
 =?utf-8?B?SjJPM01ESVdhMndVeHFobUh5eTBQOGNlMnZXYmFIY2ZrOHY5dSsvWkZTdFVu?=
 =?utf-8?B?R3J4ajFFTG5hOWk1MEs4WFZVQ28rbWFFMUJ1M1RNS1duSmo4Z2hhMWZEbkY2?=
 =?utf-8?B?WExPM3J4VW1pUGNrVU8zN24xR1RaYzdyTU9qczJsdzZqSUVsSU1HY1A5b2JE?=
 =?utf-8?B?SUZpYkxYMytHeW14bTcyYW5WcE02WXJqTWZNM0tLS0g3RWs2cWwyMGgrRmFq?=
 =?utf-8?B?Uy9PV3FGR05vL1hUOGNubEFoMGNoMFl1VC9iNDZ2a3pSV1FmcmMyb29kdXFD?=
 =?utf-8?B?cXRtU3dZRWFtMHFhUzRYRkEvTUxzaDVOY0NRa1ptZlF6NTVmeUlVTDdKQkg4?=
 =?utf-8?B?V2RoTlI1cEdDVlRXYmx6c3gwZElNYjQ5TVpoN0h3WHR2ay8wakk0UFpXaFNL?=
 =?utf-8?B?aXV6R2VXaEFwbGVqdGdUV3UwY24vWUxEZ29rMFB5M3MwU2daV09HSUs4RkhS?=
 =?utf-8?B?K1c2QUJBYmgxZWQ5cUUxUktTSldIcENZUVk5cmtKNnBpczNSUWhzWG5hYXR3?=
 =?utf-8?B?TkJoV0JDa1NLNS9PMHN6RVc4N1hrVEV6dW12aXBpa2RMZEJ0TFF1WE82Q1ZC?=
 =?utf-8?B?b3VkY0VveVlpMElMZXQ4TGkrQlZOVm1zNk9nUjFFaVlpZFZhV0dzNEg3ZWhF?=
 =?utf-8?B?QTMxcXRTamJ0MkhYOGJ3K3k4Sm9lVE94c1dYOXkzU0hWb2dQK0hVWEZZdjRT?=
 =?utf-8?B?bWRvN1J5MExyaEZpZUE0VWNXSTArYjVHeUJINU93Z2tCUFVvdkVSQVZUTVps?=
 =?utf-8?B?SmFubzdZbmdlSnhwTmlQY05MY1pVdW9pcnR6Mk9kQmw0dDkzTGxHaFZOaDJx?=
 =?utf-8?B?M1ByZ0FuSTIzNTVrOFJDQXNxSStDL0RCWGluRWlGNklGWUJqTVpLVHRUeTBR?=
 =?utf-8?B?SkRIejFJcXEzUDF3dk10QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67372e89-8715-4b83-67a6-08d9775b0912
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 08:38:33.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FVbZ/i1ZwNFUhPse1Ka4CiqXtGGePp9NycTRhhjzZrKiqe2UY4mXRtX4U7wlOLGQxk/hvi/iouHQT3shHVXgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2021 7:31 AM, Mario Limonciello wrote:
> There have been reports of approximately a 0.9%-1.7% failure rate in SMU
> communication timeouts with s0i3 entry on some OEM designs.  Currently
> the design in amd-pmc is to try every 100us for up to 20ms.
> 
> However the GPU driver which also communicates with the SMU using a
> mailbox register which the driver polls every 1us for up to 2000ms.
> In the GPU driver this was increased by commit 055162645a40 ("drm/amd/pm:
> increase time out value when sending msg to SMU")
> 
> Increase the maximum timeout used by amd-pmc to 2000ms to match this
> behavior.  This has been shown to improve the stability for machines
> that randomly have failures.
> 
> Cc: stable@kernel.org
> Reported-by: Julian Sikorski <belegdol@gmail.com>
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1629
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd-pmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 3481479a2942..d6a7c896ac86 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -71,7 +71,7 @@
>  #define AMD_CPU_ID_YC			0x14B5
>  
>  #define PMC_MSG_DELAY_MIN_US		100
> -#define RESPONSE_REGISTER_LOOP_MAX	200
> +#define RESPONSE_REGISTER_LOOP_MAX	20000
>  
>  #define SOC_SUBSYSTEM_IP_MAX	12
>  #define DELAY_MIN_US		2000
> 

Looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
