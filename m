Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3D40B562
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhINQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:55:31 -0400
Received: from mail-bn1nam07on2083.outbound.protection.outlook.com ([40.107.212.83]:8262
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229795AbhINQzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzXdQQx2psrJuFtgdnDExLkA+IA2f/QdxOm030pjRJ8JrUnvhPMn+euDV2/Z1hqNPkNIQOCBd9LFDCYu0mMDGnVYTuqyBDlzvWSO0mrD0XvAHEwvrg6tRTRNYLWHQuUNijtZkVTSRmRlKJD+rU6pZHQgIBs3BIrUjx6l4OdOif0Hl1J7oY3eq/Ry3Y9fq4CjGpy20sL/lYxGHzJ17uUVcYU9wxk2TCDfp20QrMLJkLiXsTz2oF+LTFBVYKGzKvRRvl9HcGi2KfLDGyaVAdYdp2QNpSNaFLBq6LYI+rQuiLatj+pw8U84YWmb+4mX1PLhs4wchIvhVfE+C1KdZ4lDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YuZC8ixHJr50Ip8tz1rAtMq+ONLYtWvzS2ZJdcMBT1o=;
 b=Q5JoSa/u3SSrsQ5inkjPkHd1SCu/i5DDAzCGoIHiZVXLOztMbZVB5/wTVj8hyGzVqMoOQ/P427OoAM4pLAZlIQHvB9MUcGtYI/LuKMWKsIjtxPCMRm39M3el/JRm0aqnAGAMG6qzmk5WLyKfO31ElYaxAr61ijYPDwvHgRIPqHjoMqxwIpweccYp2b0k2ZbAZr8+xvwCPkpUXaUOKAmlqEfamJV2sTHEzzLttSY+SVxRcSDdm5do1nFGL6W982SDvtWlUaJTeKkrx5jVavXIbRlful3AeUGqqjkHF5hB4Se4PgAOW9wFKpS1fkX2VrJ+5BzddL9JlOg9KL8Qk7R4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuZC8ixHJr50Ip8tz1rAtMq+ONLYtWvzS2ZJdcMBT1o=;
 b=LqIRRqlHE5nYUlYNzJB4JHNgft1tpIb1sXxeNIJX4hmyub8kDDVyDzPT+IowYuiBevnnZM/ca4YbocbFpr0sXy4b03oMq8mCW+lMw1mrpgZI9Q+XfJuXQ1V6RC/GZVdYKdmZ1mgCfOR2kxIbjOjtOZO4iQTcb7GU8YdluGxvWjY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 16:53:57 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%4]) with mapi id 15.20.4523.014; Tue, 14 Sep 2021
 16:53:57 +0000
Subject: Re: [PATCH] Export Idlemask values based on the APU
To:     Sanket Goswami <Sanket.Goswami@amd.com>, Shyam-sundar.S-k@amd.com,
        hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210914131406.1892-1-Sanket.Goswami@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <3decd0d4-8c72-cc4f-e3f5-965398041fa2@amd.com>
Date:   Tue, 14 Sep 2021 11:53:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210914131406.1892-1-Sanket.Goswami@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:806:d2::14) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by SA0PR11CA0069.namprd11.prod.outlook.com (2603:10b6:806:d2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 16:53:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eda070f6-e441-491e-ac05-08d977a03e2e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2685CC2A1E1E80595F0E3423E2DA9@SN6PR12MB2685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHuPh2gEo4BJWF5gpGh0T2izJZoHdvLuAALrHQenY2SwIqUA3Wk71ilWyGxZBitME9sVwRaFpXFxDL0uvUN1q3WwaHJqUf3rOw4S6H9b8gGRvIb4ZHWV5e9AnjJaxpH3bVojHQ/uO04xAtSG4kiHDPkRkn2eicyGjLcSqtzfxN6VMQU7pKkLMKE3Ps+lQi17pyEV9cUw6I5lIYl9KsBRTthMRYYuzBaUET9KV/F8TKTgX1wa7zJfxrOlcmBAOrnVqWQePHb6g03lh3KVOQkAtaSbD77fZDVF/SrGmgwADhnhZ5jR/xPKaEFuo6u6aMLP/CBTkzzR7IMSWmNo05BvVDgMz8TGuy2On7wDFm1yU97B/BzoH5Sw9m2Srwg90x1/2kY6bcG4C/7UNMwGl4fbUBsiqydqwllkIX99LY0FTujz59Wo68gizXOCdHhTAClzYgJ8tgioHMLdXvIC0dr/rSgzaF5GM4I3BEFWoudPxOaQKRQo2HQLjveKcG3mWzH+2wGAER43IE/8h8nzJmWWHWh0NhzJ3JG3QlO7I1gp0u9LbBAjbsgiJta049E1CPdcvLo1EZD4tQad8nN9cOtTcroiounnQc4rbjR24CzXIdLyu0NLOdtfAK6VVcPD719SnsZZY/4+IuU6rgOlgkhuuByd6PfcEKRzcGl35amkhgQvXXWid1KpUpLb7fwcUpG9EzPTPNp2GbCBc8e3V5sGTbYyVtRs7hRI1q8xO9VhX86DR2fOJeGXEjz8A0IIBvwa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(66556008)(66476007)(66946007)(316002)(5660300002)(31696002)(53546011)(2906002)(6486002)(38100700002)(186003)(26005)(4326008)(8676002)(86362001)(31686004)(16576012)(478600001)(2616005)(956004)(83380400001)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXVFVllCZ1hCNXVNRWxCM0I2VktSVXgzeStnSmIvOWw2OTdJcU8zcGRVTTU5?=
 =?utf-8?B?TDdXcVpCTWVaS3hocW5rajlNcy9rcVVxMndtTGFoMzN5dTRrS3VuaEtHM0lO?=
 =?utf-8?B?cDN2Ni8xUDRMM3JnRXJSR2RnK0RqUDBmeVZYOWU2TXhtTVZDblRzVWZkcHha?=
 =?utf-8?B?elhNSDc2VjF6WUU4dmM3MGIvZjhxbkE0VUtNY1puN1ord2xwaDlTSmUrTndi?=
 =?utf-8?B?eW9SVTNmbFJielROSytmemVTdlQ5bWZBblkrUkE0QVNVNHVWTkF1S25JZnh5?=
 =?utf-8?B?N0lXWkFneVNIc3dNajlwbGFKUXBOOSsyVWdqQzh5UWVRSm9EUUp6NUVGdVhQ?=
 =?utf-8?B?ZzBndGE4TjhTRU9xZVVway9wcjN1aTlHeWErOFFSU1NQTXBtSTh6MEU2b2RH?=
 =?utf-8?B?eHN3cWpjQUhQaTF4WkRIM3FFWEdtRzhZWU9kcTBxaWlaMmY5a0xWZFEycGF1?=
 =?utf-8?B?WTdXeEQxYUQyaXR0MndId1JDcU1NV1BPclV0WnRyMTZXK1p6azkxcFZBZFQ1?=
 =?utf-8?B?V2Y3VE1PTkM5STBFTDdDbG1JbzBzOW1OaHJsRXg5M04vcXRZWkFJUElIODln?=
 =?utf-8?B?S3ppS3M0NnJTdnVkL2FYdC9Cc2VaZG1zUlo0U2FUWEQzQjZCcnMraTFza2VO?=
 =?utf-8?B?bVFIQ1E2by95aWpsK2VwSndFVUpYZVNUaHozSHRPeG9zRHdWdXZ0dU41VkYz?=
 =?utf-8?B?LzZJdXlnejNGdkxydkowVHJ4RTdjdFFaVXlHNWFWUDNkUUkySE0xdm10OG5L?=
 =?utf-8?B?cDExZkhYMCs5cjAyM050dWU3TFNnKzhrYit1WStJMlM0RzY4aDIzcXd5TjdW?=
 =?utf-8?B?U2M0T0YyVXcyUUpTYWRPOWJHZ3cvcWhFUzdXOWxEdVVYdkdlV2JBTkwyWUt5?=
 =?utf-8?B?eG9XdDE5T3pqUGpEY1BabEFkM2pHRGIrTWVJbnVRcDZ3RlQvcjQ3TVNTUGZB?=
 =?utf-8?B?V2IzWCttdFdnZmF2RzNoc2IxaHVNSTMyeTFIYVdWc0dBbHJXRDlYTUZBblFz?=
 =?utf-8?B?YWNlTk5aWDJ0QmRMaUNURXIrWjhyc3RSOStoS2xqempOM05SUEl2NURuVnhN?=
 =?utf-8?B?VUVQT3dlKzFyV21RakdkYWhWNmZUelBDNTlzR1VmY1VCNVAvbzFZbTdtdjlI?=
 =?utf-8?B?TjdHYnp0akg3YWUyMVI3aFlkVnlvc25jN01KdUx5T0VoSW9lc1NsdnN2MUh5?=
 =?utf-8?B?akd5bmpja1JuSkJTNjE4MDdZY0w2Yy81QUE5cWNNc21adVA5Qk9NQ2tpQ2g5?=
 =?utf-8?B?MDgrYmxvbUlhUHhJcktIWWx6QUdrMEVVLytGL2RuRStySHdxTkk0QWtYU2sz?=
 =?utf-8?B?Y1pWYUgwVGZBbHIxU2RHN3oyQnhjb2JTNGZQUjRkSEp2YWpoUjdDZmUwTis0?=
 =?utf-8?B?VEJsdW00TTUzdStRNTVCbzB3MkMwUjIvclp5bGx1VThQUU05RWVXNUNHam1a?=
 =?utf-8?B?M0xaOG9ZYWJPRVNkY3lqR2ptUUVPeWlqOTRxaVZFM0N2Z2I5VktDREdrdnVq?=
 =?utf-8?B?QnQxMjZlNmVNc0RwTkNoU21mRG9pV2NoZHlMVnQ1NE10SUQ4VmxYZzJCQ1Vm?=
 =?utf-8?B?dkZTSDExcFZMcmV4enlTclN3b2VTdlY4VlhqU3UvYjNxYkVEWnNBNjN6T0c1?=
 =?utf-8?B?YTBUZjB4c2FDeWMyYmovNUJmSUIrdThFYitON3ZYblFZOWY3Tkg5L2k3N3VB?=
 =?utf-8?B?RkpNKzA5c1pTUWVTUTM5ekN3ODlqNUU5Q2kydDV0NWtpMGlTNG82TDh2ajQ0?=
 =?utf-8?Q?dbsscEcOKvEUrm000GOTt7KRBEp+EWHuPyY8C4O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda070f6-e441-491e-ac05-08d977a03e2e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 16:53:57.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbvlhcTalu2HVh+r53iLGAje+BZ5+sLCtE42zqpIVU9jmrc0uB0zX2u1gWvXPKj8FR0vtElkN76Wmo1GcPDa1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sanket,

Thanks for this!  I think it will be quite useful.

On 9/14/2021 08:14, Sanket Goswami wrote:
> IdleMask is the metric used by the PM firmware to know the status of each
> of the Hardware IP blocks monitored by the PM firmware.

Although reading runtime Idle mask from debugfs is useful for 
determining runtime power consumption blockers, I think it may also be 
useful to check before OS_HINT is sent as a debugging tactic.
The value in the mask can then be stored in an integer and/or:

1. Read out with debugfs later (maybe as output during part of reading 
smu_fw_info or even a second line of amd_pmc_idlemask along the lines of 
"last s0i3 mask").
2. Output with dev_dbg to allow turning it on with dynamic debugging and 
catching in kernel logs.

I think the second flow is actually the most valuable.  Users who have 
rare failures could be asked to turn on dynamic debugging for that 
single line and then compare the IdleMask between a good and bad suspend.

> 
> Knowing this value is key to get the information of s2idle suspend/resume
> status. This value is mapped to PMC scratch registers, retrieve them
> accordingly based on the CPU family and the underlying firmware support.
> 
> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> ---
>   drivers/platform/x86/amd-pmc.c | 57 ++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 3481479a2942..e2e55e5bea22 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -29,6 +29,10 @@
>   #define AMD_PMC_REGISTER_RESPONSE	0x980
>   #define AMD_PMC_REGISTER_ARGUMENT	0x9BC
>   
> +/* PMC Scratch Registers */
> +#define AMD_PMC_SCRATCH_REG_CZN		0x94
> +#define AMD_PMC_SCRATCH_REG_YC		0xD14
> +
>   /* Base address of SMU for mapping physical address to virtual address */
>   #define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
>   #define AMD_PMC_SMU_INDEX_DATA		0xBC
> @@ -110,6 +114,10 @@ struct amd_pmc_dev {
>   	u32 base_addr;
>   	u32 cpu_id;
>   	u32 active_ips;
> +/* SMU version information */
> +	u16 major;
> +	u16 minor;
> +	u16 rev;
>   	struct device *dev;
>   	struct mutex lock; /* generic mutex lock */
>   #if IS_ENABLED(CONFIG_DEBUG_FS)
> @@ -201,6 +209,53 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
>   }
>   DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
>   
> +static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
> +{
> +	int rc;
> +	u32 val;
> +
> +	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
> +	if (rc)
> +		return rc;
> +
> +	dev->major = (val >> 16) & GENMASK(15, 0);
> +	dev->minor = (val >> 8) & GENMASK(7, 0);
> +	dev->rev = (val >> 0) & GENMASK(7, 0);
> +
> +	dev_dbg(dev->dev, "SMU version is %u.%u.%u\n", dev->major, dev->minor, dev->rev);
> +
> +	return 0;
> +}
> +
> +static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)

If you follow my suggestion in the commit message I would think you 
should make this a new function that is amd_pmc_idlemask_read that is 
called both when reading from the debugfs attribute as well as during 
s0i3 entry.  When called from s0i3 entry the value can be stored to 
something like dev->last_idle_mask.

> +{
> +	struct amd_pmc_dev *dev = s->private;
> +	u32 val;
> +
> +	amd_pmc_get_smu_version(dev);

The SMU version doesn't change during runtime and furthermore the values 
are cached into dev->major, dev->minor, dev->rev.

Wouldn't it make more sense to read the SMU version during 
`amd_pmc_probe` rather than every time the idle mask is read?

> +
> +	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
> +		switch (dev->cpu_id) {
> +		case AMD_CPU_ID_CZN:
> +			val = amd_pmc_reg_read(dev, AMD_PMC_SCRATCH_REG_CZN);
> +			seq_printf(s, "SMU idlemask: 0x%x\n", val);
> +			break;
> +		case AMD_CPU_ID_YC:
> +			val = amd_pmc_reg_read(dev, AMD_PMC_SCRATCH_REG_YC);
> +			seq_printf(s, "SMU idlemask: 0x%x\n", val);
> +			break;
> +		default:
> +			seq_puts(s, "SMU idlemask: Unsupported CPU ID\n");
> +			break;
> +		}
> +	} else {
> +		seq_puts(s, "Unsupported SMU version for Idlemask\n");
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(amd_pmc_idlemask);
> +
>   static void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
>   {
>   	debugfs_remove_recursive(dev->dbgfs_dir);
> @@ -213,6 +268,8 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
>   			    &smu_fw_info_fops);
>   	debugfs_create_file("s0ix_stats", 0644, dev->dbgfs_dir, dev,
>   			    &s0ix_stats_fops);
> +	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
> +			    &amd_pmc_idlemask_fops);
>   }
>   #else
>   static inline void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
> 

