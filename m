Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F047043725E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhJVG6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:58:32 -0400
Received: from mail-mw2nam10on2040.outbound.protection.outlook.com ([40.107.94.40]:9057
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232445AbhJVG6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKDPfI9iLYD3MkP/Cw7UpARAG+MWn4pUzvUjyHVoDfEpk+tJMFhrFSFK4me0D0r7X1zJEjQnXwGdeBAr/we551XtFlHUh9+z2YmDfCyDa5CMSxef7yIDToa3avXT+zorX0KN0WvSupMmjuQ4G0x74HHgNWjxdbCP3bYfCcTkqyxpG1azufNo1cb7U4mhNHMZWqXW0x6N/EPzMqpN2UwcdDg7F+6xT28wlmTe857hmEFOv9/mkiPWG7cD0sKRw66iozlTQ40ByONsb/T3PZ8P1Z9Hm7L1PgIuhNu3JpHqPifKLSBbQJs+3UsJukSt05IlQc4PCmrgfiEyrmct4tFssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV6fUO3IEohcoiQ1JtfgnXrj1rgh0y7Y8bZhTeFpqMw=;
 b=cWpCOCMj5jypbp4xVLdgLC3oqehYsV2PlLXO/6WAHOHNKvRWmXmouMhSmTiMli5iWS/ExbbHPRX8/m/w5oJg3/WDkayzFp0fVJq8728eMjBglg5bA4Kh45FBLYTm5ty+qGkPZ37eiTaUiuXKb0bJP+wsSq0TjnUMP5WCxqVUjVucVhLHkxw1ugXQbXmxzBnQysG5QvSh0WLpJQjiwumoeg/M8VVCEuJ1MEY6SN4VZUzOF/IVS4soEfBOxEhyqflzXBKE8u38i9DuVcN9choHX/+1kJ9rxUpuccFOR2G+wZWu9Z8H2RtA4vS2o+QYWwdPNjAmBQIF7AHdgvE3B97LIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV6fUO3IEohcoiQ1JtfgnXrj1rgh0y7Y8bZhTeFpqMw=;
 b=pAk+smQE6FAY1TMQBedOPHPsFvvJ2rVc4bGj23FOveSADV+1OZKz/IKRYn/l3x179CoCWM9NRW8v2yapPoHlcpFnty8HhAbuEspDtnUOdAy9J3nxmv9DcYyVFiFDmw77Grm4mLOo7D/tOclkO/GiaC1PDIRwA4sdb7FvLmPux1Q=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3508.namprd12.prod.outlook.com (2603:10b6:408:6b::19)
 by BN6PR12MB1329.namprd12.prod.outlook.com (2603:10b6:404:19::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 06:56:01 +0000
Received: from BN8PR12MB3508.namprd12.prod.outlook.com
 ([fe80::1d74:c55a:fe83:bd18]) by BN8PR12MB3508.namprd12.prod.outlook.com
 ([fe80::1d74:c55a:fe83:bd18%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 06:56:01 +0000
Message-ID: <7714d522-36b4-47bd-332c-c4ff5eeb1237@amd.com>
Date:   Fri, 22 Oct 2021 12:25:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] platform/x86: amd-pmc: Store the pci_dev instance
 inside struct amd_pmc_dev
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, Shyam-sundar.S-k@amd.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211021092938.196933-1-Sanket.Goswami@amd.com>
 <f903b9d5-0477-1618-6596-b6039b56a5af@redhat.com>
From:   "Goswami, Sanket" <Sanket.Goswami@amd.com>
In-Reply-To: <f903b9d5-0477-1618-6596-b6039b56a5af@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::14) To BN8PR12MB3508.namprd12.prod.outlook.com
 (2603:10b6:408:6b::19)
MIME-Version: 1.0
Received: from [10.252.90.71] (165.204.159.242) by PN1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 06:55:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f52e633-7381-4d8a-9ebc-08d995290208
X-MS-TrafficTypeDiagnostic: BN6PR12MB1329:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13296DDDA368E9AEDD0BEB479C809@BN6PR12MB1329.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1c+cav8eFJm5e/82ZrYLoJQVjBzOVOdzOASm5c50LvtYP5ALa1A+U7Qej23s0PYB1yW/gLI4OsRCMAaPFSt9ZVX9h+PhYT5FNNPYayI1x1fqBQb6RbQyj7Ey1YnhgBnqa2C0wTsvOgyXaanzqbXXGTk4BFo47qSusBjV5zSZbwOwpvMoDQ6EmH11z1jjifM4WkHXd+G2JqZ7M6P++0CHsp8WARS49mH/2JVblscVEfduw/gytVe8tITdjha8NoFUCb3TPRSv1TgSK6pyuGknXNjq1W7vctFygac6GuSqGSqd0DoT5wtqnDy15Qdek80yIeiMMGCSjDqDXJOXBds9zwGlytiqrmdYHKXI22XIJDeaHN3sB6ERs9GFkCbeJCbHjcGhvMpyhlvabCc2e0QhhiRPcYGiK3Cw6aegQa6MSgMklaYMUeYuu3nNJgY+dG6+MckFsYinFsdnV+ZPkI46lXs3AIzqyngHhDLXNrYUrDEJmlY9h3lfaNq14mXAEZ47AY4EpAcPu15D0xb5UuPVYJYdYwEZwxy+0L9+PT+b/BclfgHFNukwz0foeEPqKHP46N/iCjCpC4/JdJqpsUZUFGVLGYPI2pudOL8wZy7aqc3VzEUsr5jOtLTOUeoe/MUNoGxuLDb952MU4sIhCAr7gT2VsRSg4NM4oH014X/mz4NCp7Qy1lQ1G5VNIxLp166ICN31cQ1Ta2E5RX0zEnOHgO9ZSaYIlNt2RIW9hg5Crb9xMsVnCAxjIWp/DwdccZtm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3508.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(26005)(186003)(8936002)(5660300002)(6666004)(2906002)(66946007)(956004)(316002)(8676002)(31686004)(31696002)(86362001)(66476007)(2616005)(36756003)(38100700002)(66556008)(508600001)(53546011)(83380400001)(6486002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJFVWNmZDBUUEdGRDdHekxZemtqazRuVEp6MFNQMzlRZnRTLzZkRDBTWHZn?=
 =?utf-8?B?RUJxSUQ4ZjJ1aTk0MFdwM1lPQ1BhSTRRMU9KcUtDNXJwNmV6cWxWZGNlQnly?=
 =?utf-8?B?S0llQ2dveEFrb21SLyt1YXZ2d0tVeHdpZnU5M3labEs2aHBQWllwS3gwV25o?=
 =?utf-8?B?dGlpRGFWUHMrQjE2MXJDSFgvKytzZFRQMitqV2ZiSlJmdXJwUHYzN29QdnRS?=
 =?utf-8?B?ZmN6aHFVUks4SWFpaWxJWGtLZ3dyL3lQMFhhZmY3RVZWand0eWMxMHFpUHZZ?=
 =?utf-8?B?V0NxNW1GMm9Hdlo4cHdXK1lxQndJOE9iZjdTU3c0NUo2ZGZMeEYwSEczN0lB?=
 =?utf-8?B?NTR2VjFYSnhUUHJIWmt6Q3ZDQzB6YUo5ajMzMnJVaFZ2eC9qSVd3WEtseXQ0?=
 =?utf-8?B?dC9ZOW11NEJJR3RvbjVhbTNuY2Y4eDBSMmJ3ZHNDa1hheURUa2lZaDRDZFEx?=
 =?utf-8?B?NXNKckk2MnZXcEcxTGpNNlo0VjU1YS9zYnV2OXFTeGRUNUdHV29ST3J5R2tF?=
 =?utf-8?B?YkpJOTdlRUdIUGx4dVg5YlZYdGxoc0xSZ01naFRVQmNQUWxkLzl2VkduWmYv?=
 =?utf-8?B?VSsvRnRYc2tia1VKTjFnL0hubjBTdXo2MjIwVVcxV2ltVUx3YVIyLzRJZ1J6?=
 =?utf-8?B?NE5PdHE5N1lxVGhHNlRqZ2NINXB3N1JWOW9xa2F5dEZUTm1nS3VvSEV5NlJY?=
 =?utf-8?B?L05yU1JqY2hReVFYdW13WkpxNmhSNnI5WkN4OXk4UkR3MU44Y3hjY0p3MGt6?=
 =?utf-8?B?SlJNTGhyOHhOcXpxaFg4d0ZCSHA4VTNBK3oxZWlIY3RFL2xNMUlOOEhZaGc3?=
 =?utf-8?B?ZDdlcGRkOEFzeW5FUjA1TDVvSm1seTRpNXhvNUw0aW5zSFVoR2pSTWIxN09L?=
 =?utf-8?B?NTR3QVZCaFU3d1pUWUNrS2U3ZHVmTVJmYmhBcSt0UFQ1Yjh1YUdxbkVaU2FU?=
 =?utf-8?B?eE1OUmE5SFEwZElNdDByQTJIRWEzSlFkR2U1YU52UEJOc0hMM09reWN2eFBy?=
 =?utf-8?B?QnFhaEVuWGJWNUdVaUFlZ3o1bmc2TFFVU1ZsckZLYmtYaVd5VU5hVCtNQ0lW?=
 =?utf-8?B?WXVmclk5SlR6dHU2eUg5cHJhY0Z5NndTbk1SZzB5d09SdXcycGd4NlVhY3Js?=
 =?utf-8?B?NnNBU0VXcjc0aGJubVZFS1dTbDJaZHFIYkY5K0FTSjVqcGFac2ZQWEx3YytW?=
 =?utf-8?B?OFlweFMwc0ZoRmxrakZsdjlrL1lSckdzYVVWUVVTR3pZRnZ0QThJdTd0TDFl?=
 =?utf-8?B?WnRkWFMzdEJnWlpDQjZSTkRHdGg4MTVHTGczY2tFejZWN3NMb2lWNFpFcnRC?=
 =?utf-8?B?WjBsbmt2bk1rTTIvc3dVbEJtRzRnanR6QkxyZ3podUJtNExwaEdJSmxVTmVN?=
 =?utf-8?B?VXhETmtIMlFmREk0RVgxYzhrYUdCSHUrdW8vdXpXOG5qMDdHaXNhZ2RUS0ZY?=
 =?utf-8?B?VHIyWkZ4NmNDalFqakQrMDJDcDZtSlVEN0FjalRKREdmN2ZOck5YcHZpNUo3?=
 =?utf-8?B?c1BhUUtSbW1nUi8zb2gvS1czYWlFZUNqSUk3Y2xITklNNXl4bEZWTDNVajh2?=
 =?utf-8?B?MGlQYjB0K2w5cTVFQXd1RkVPc0YyTzN1cERaQ1NMaHRMN3IzSjJQVGRGd3Zu?=
 =?utf-8?B?b0ZpUHp0ZXdxQkU4M0hVaWt4Rm9TaXZreTh5RDJtQ0grek9XWENMMXhLeW5x?=
 =?utf-8?B?MWRFRXdsSmxLOHRJSTU3bms5OHFpcDBILy9HVkhLSVRrU3pSYkdSeUJDMzVt?=
 =?utf-8?B?MG9VbjZ2c2tPclFramtkWi9DVUN2blpDd28rOGFWd01saVphd2xQM2IyNXZT?=
 =?utf-8?B?YW82cFdURm5RL2ZxRlhUU1J5QjZDZHdqQ0VubmVlVjgvanpOOSsxekRka0tN?=
 =?utf-8?B?Ulh5RnVQVlVKcXBXQzRQenlvOEFZNWw1alhITTI1NHBUSkpwb1R6QkVUWGR3?=
 =?utf-8?Q?0+djz82wcU4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f52e633-7381-4d8a-9ebc-08d995290208
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3508.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 06:56:01.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgoswami@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1329
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 21-Oct-21 23:48, Hans de Goede wrote:
> [CAUTION: External Email]
> 
> Hi,
> 
> On 10/21/21 11:29, Sanket Goswami wrote:
>> Store the root port information in amd_pmc_probe() so that the
>> information can be used across multiple routines.
>>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> ---
>> Changes in v2:
>> - Store the rdev info in amd_pmc_probe() as suggested by Hans.
> 
> Thank you, but there are still some issues, see below.
> 
> 
>>  drivers/platform/x86/amd-pmc.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
>> index 55f14bdfdbfd..502f37eaba1f 100644
>> --- a/drivers/platform/x86/amd-pmc.c
>> +++ b/drivers/platform/x86/amd-pmc.c
>> @@ -119,6 +119,7 @@ struct amd_pmc_dev {
>>       u16 minor;
>>       u16 rev;
>>       struct device *dev;
>> +     struct pci_dev *rdev;
>>       struct mutex lock; /* generic mutex lock */
>>  #if IS_ENABLED(CONFIG_DEBUG_FS)
>>       struct dentry *dbgfs_dir;
>> @@ -482,6 +483,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
>>               return -ENODEV;
>>       }
>>
>> +     dev->rdev = rdev;
>>       dev->cpu_id = rdev->device;
>>       err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_LO);
>>       if (err) {
>> @@ -512,7 +514,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
>>       }
>>
>>       base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
>> -     pci_dev_put(dev->rdev);
> 
> The current code here actually reads:
> 
>         pci_dev_put(rdev);
> 
> Note (rdev) not (dev->rdev). I don't know what you based this on, this is weird.

rdev is already retrieved before doing this:
	     pci_dev_put(dev->rdev);

i.e.
in amd_pmc_probe()

rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
	if (!rdev || !pci_match_id(pmc_pci_ids, rdev)) {
		pci_dev_put(rdev);
		return -ENODEV;
	}

after this I am storing rdev in "dev->rdev"
i.e.
dev->rdev = rdev;

after this I am using "dev->rdev" at places where "rdev" was getting used earlier.
Do you see any problem?

> 
> Also there are a bunch of error-exits from amd_pmc_probe() which not all
> need a "pci_dev_put(rdev)" added to them before there "return ERROR;"
> statement.
> 
> It would be best to add:
> 
> err_pci_dev_put:
>         pci_dev_put(rdev);
>         return err;
> 
> Add the end off the function (after the return 0;) and replace all
> "return FOO" error-exits with:
> 
>                 err = <FOO>;
>                 goto err_pci_dev_put;
>         }
> 
Thank you, will take it as a separate patch in v3.


Thanks,
Sanket
