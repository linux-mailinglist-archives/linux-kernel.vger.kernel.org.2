Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0B40DB19
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbhIPNXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:23:45 -0400
Received: from mail-bn8nam08on2049.outbound.protection.outlook.com ([40.107.100.49]:7250
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240084AbhIPNXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:23:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJyAYoWTDEkC4QUSqR4Q0aBDd2v20lmaQBAlLdzCMyS5U59FZ82yoAk3OvB0oJ8l3npZxigvF/DmGL8vVQ5UPq5NAIwfnSbX37+Xzj0Zkqu9huHywONrMpvvvjGOC/rFNNdncBrx9jMAbfQFNMF6OSSot69RbblRw+dEuK32+slkTE8XGmJDlx6Hb63KAlNbBd8Jz6d1Q7v0cWaLlEbR05zWwD4q8QXmMCkDkHxCNeOxdyu7G28uHx61Sr56A/wq+0IDxjRSWMymqbHpIN/QvmXjFx05M36QEJEieFEIpqtji8Y/Gc05bon9xuZkIuz+wIDXVByfOn3UiNugCP5Ojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5ug+1bv/qsY27Qlf/34L6qa+5mtU5laCu5zlHixo+xQ=;
 b=hGbLuRLf2bWxWHDAx9SMtiqjiNXZGp7Sgsjqc0Hq73PAya5VLPvoitRloUYdY6rezsDD30vJxMR8WkTjKA7RtpMc+djRGmRVCt0MPqXcvMN/UiBWIW3fNvqxJ3dCW3cw2fw/C5L0h99v79Dewc1ZU7wJ4dVUEPBVwA6bcIJHLwwT2M5bpUa55P8FN1YkCcod86pC4xdswhxopSS4ech4AjiZQ8C1zO7XQXRVDLkLup078T6gdtBu9UumdHICL4MnCfNh928jVoTfYUMZhtL9lfSpjJzuGjPbTagh7ifEP313S/y/sxi4cSCwGaW8rf9mHCNpw+jmBT7kKNS5p8h99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ug+1bv/qsY27Qlf/34L6qa+5mtU5laCu5zlHixo+xQ=;
 b=n0s8e+XAilBbJCATBvNF0ULKWque4xA6WYIPYum/ZZGtf2qqsd7iNBe33Xmm9ExrOd5lEyueV4c2rgvkrOhR6fZ6xJdRXW0bMk391/IR5A6/dev7Rlz51soPM8ulDh0vf6OFBsfmnDARWFVqbkJfVnDCefXn++aBX4OEX4Z+WBU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 13:22:18 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%4]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 13:22:17 +0000
Subject: Re: [PATCH v2] platform/x86: amd-pmc: Export Idlemask values based on
 the APU
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210916124002.2529-1-Sanket.Goswami@amd.com>
 <de42f717-4cb1-6056-bec1-b46271bbcab8@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <89d803d0-cd74-0af8-6920-4665d4f1f105@amd.com>
Date:   Thu, 16 Sep 2021 08:22:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <de42f717-4cb1-6056-bec1-b46271bbcab8@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:805:106::28) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.236.185.111] (165.204.77.1) by SN6PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:805:106::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.1 via Frontend Transport; Thu, 16 Sep 2021 13:22:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f010ea3d-f2af-4da1-313b-08d979150186
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4431D3BBECC4EBCD1CDE7E61E2DC9@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VB8mOjsgIQ+xoVkikR2fDxtyy0R4Ee0q1IlU1Dye1J8yR1wv5PqoCHWOgMmOzSiX+jk10mhKAjMxC+G/CsnUxdgXYtMiXLQ7dajYDHw3GdRZmQlXKZFaLwzm4cimVN36F8+lTYgt54YlrwVkyhhHbv4AreNeVHFJ22AOu/U3nIM8PjLUxShPjJY0f6xacwwdT9mdV69gsgyH3HChLmRWof2/XxuE96wqxPU7TmnApqgX6s0FsByCq3WsfdMRFGXD/dst2GXzaO8uMQa5BJ0hv5wa2UnNKeBP7ey5Zj6ctW812ZxW1Hmxv0Xjil4YqNoNZxV99RG9PPwCW8xjxYwX1fxrH1PSwuq7Yq2HcewAXBzeOziftniKZtPcQL33mhI7EXZudWs7qROx7xUCCTkFdM2fJEayIg2aNxT6EkcKNts49gpFkCaS/DLduTBMo35YqFQQ8SkJbbPjIVDCd+7fSNpqpEnEq55voohwniVt5Vbf8Uf3oAQV/WhOB1wdX2QuWd1niG+S7MLq+qF3fZF6D9Kw9vxIUuB3XgGuXzW09QuQx8oEtQBy5vCHRyNFwuroreNiTJ2VWqCKmPEJAeNoKMm/WxxMvPUqxXJXVmNQ3H30lYl4fT/8MRBfHMEVYzJQi/QA8esMmjVJq8Gb/IAqEecd+caHgTg2xH7+q1DHqlCQcBVTNDUUI4YS5NhF5FQQwoGhV0A8BTF4mL90tmpwk9ec+zyZtRTCrIprXP+LbY7wdSB3MGQvU5F0/uH3PEQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39850400004)(346002)(136003)(316002)(8676002)(26005)(2906002)(83380400001)(16576012)(4326008)(8936002)(86362001)(31696002)(478600001)(53546011)(110136005)(36756003)(66476007)(66556008)(6486002)(2616005)(38100700002)(5660300002)(31686004)(956004)(66946007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnQxa3FEdnpoRnd3emdSRDQ3eHpUSU1KMytVRlo5WHNyT3lOWXJVWlFtTkZj?=
 =?utf-8?B?dkt6ODIycEgzUjRBanZ2dTYxbG5TUnN6ZEpGNDcxQnRLTkxaMnBFNWIxRHkw?=
 =?utf-8?B?ZTRqR2piZWsxbVNHUlIxeTNwYzVNTFF3VzJjNlJFd01FSWdiMlJNWWp1QWZh?=
 =?utf-8?B?dTliWmRoQmdwUDhEOG9zV3ZWZ1RuWTgrcEI3R2ZCSDFXeHRXeGd3dUtNUFFP?=
 =?utf-8?B?N3NyQXRGMzIzRkFBdlc0TTQzQ0Ruaitzc2l0SnR0YjgyZ0lpaUN4NHBYbnBW?=
 =?utf-8?B?aTRFbG1jVFBwR3FnWFQxT2NNRHp1UTYzUGpRdDg0Y1YweTlmMlJ0bmVtb3JL?=
 =?utf-8?B?UjhNRFRVS25pUDFYRDI1YXc2Z2R5THhaS3ZDcWtkWUVyMFJna0t2ZDQ0N0Jr?=
 =?utf-8?B?ci9PNWhpVHQ4UkxSVXlxNHZBTW5oVFdnZ213eDFUdkdhUkVxYjlIejVCdTlU?=
 =?utf-8?B?UnNENW1Md0V3M1Q2WmlQOWNJYXpua005SzNlSEtqUjVHbzc1dDVpcDJlc2xB?=
 =?utf-8?B?QzFuTjdtSS9OeFZ4d1NMOVcxc3N6RHBaczFSdDVMQnF6bjRSVjA1ZnBxTzF0?=
 =?utf-8?B?ZUlUNWN2L2J5SVpFbVB6WlJsNFcrVTErNkYvRko4YVVtR3hNeW4zei9sTURq?=
 =?utf-8?B?QjBQUXB3OEFuckxvd0lhQU1KMExaTC9vcUJodkFVdUhaTU96ZXpzY0tScWdF?=
 =?utf-8?B?SG9BQlJ0MjZROGEwUWVWV0hiWWdNWjNocmg2ZjQwYmhJdVJTREhMZ0M3bVpG?=
 =?utf-8?B?SGVKeFdIT3Nnc3RBUDF1RlN0UG9Tdytncy9PUEI4bU13dFpRc1ExN3lyVHdR?=
 =?utf-8?B?d3E5ZmtzNXNLV2JFbitUTkpEa0lIYVA3SDByQ1lWS3RkZGRWUmoySFFqRGNp?=
 =?utf-8?B?NUVWcG56MjJHUVlKTlRvUG8xcEUyN2NHYTZyOE8ydCtDRWZka2Y1c290cTNQ?=
 =?utf-8?B?ZkdrWi9YRnhqTDlmeEhlUXN1Y1R0ZGdjYkN0YjdqaWIvSDNHNTV4V1dJMUNG?=
 =?utf-8?B?WURDMS9rNGpNNHZZb1lhNXlrZ3doMjNPNC9FSmEwaVpESmpHeVBHT3JUNTlS?=
 =?utf-8?B?RGxCdytRcFI5Uk43NkpLZDlxVjA5aitrZnlzZVJOTzZjZ0JVUkdpV2krOVdL?=
 =?utf-8?B?aHpUZ0c2cEswNEpINUcxTkRCMStneFp6WjNvM2lGMDFBSUtYRkhvdzRQM3M2?=
 =?utf-8?B?T3RhZEQxcUhud3dQbjF3aTZzaVA4NG9YYW1kVmt0R3lVWk9hclNPaFZOSVZr?=
 =?utf-8?B?TW9lQkVqRk5lWmt5YktHVFpBTEh5dmpEOUYrYVkxMjVvc215S0NGbnpldmNW?=
 =?utf-8?B?TTh4YlZRMWJGQnFyTW5NR2ZUb3Zsc0MvVk5ETGVrZnczelFQWjQ5eUhSY0xr?=
 =?utf-8?B?a2ZUdjF0ZjdkdUpzTm94TEJlNTUvWDZoM3pMblBjR3ovWGdjTUFrOEpGRTlG?=
 =?utf-8?B?eUlRdUhJQk5YdkNSRWtTTlVRaCtRVCtQajRJL1huTEVYbWt5Nk1uSVVab3Nk?=
 =?utf-8?B?bFJmSVRlWFAySWd0QnJPaFZUREw5b25NVytzRTdiMGt3TEgwSHNkMXF0d3Rh?=
 =?utf-8?B?bDZHc1MzNEFLRnJKL3RMNFROcVdtcGVIaE9LMWJhMCs2Nm8wK3RWV2VHSnk5?=
 =?utf-8?B?K09LdlgxYVJRYm1tVXYxMjMzTmV6a2Zia2JhNDJqSGVaaFRCSUdCREc2Y2Rw?=
 =?utf-8?B?T1VtNTFuWGFucmRFYjZveDBZdmFGbms4VkhEejNpcHpRTnhwOVVweWhRSE9Y?=
 =?utf-8?Q?Mosj/qxAEZKQstarSXxyuvXdfGU2uLzN/aEd5Hl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f010ea3d-f2af-4da1-313b-08d979150186
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 13:22:17.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5T19h4cpQ5xmxZCO2nYtuAIZpuRvi/i9vCXDCAT/zDj2D/GHV11RIlhXlqS/VSvB9cOXdH/UvSfGkO5DAvIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/2021 08:00, Shyam Sundar S K wrote:
> +Mario
> 
> On 9/16/2021 6:10 PM, Sanket Goswami wrote:
>> IdleMask is the metric used by the PM firmware to know the status of each
>> of the Hardware IP blocks monitored by the PM firmware.
>>
>> Knowing this value is key to get the information of s2idle suspend/resume
>> status. This value is mapped to PMC scratch registers, retrieve them
>> accordingly based on the CPU family and the underlying firmware support.
>>
>> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> ---
>> Changes in v2:
>> - Add separate routine amd_pmc_idlemask_read to get the value.
>> - Address review comments from Mario.
>>
>>   drivers/platform/x86/amd-pmc.c | 76 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
>> index 3481479a2942..0c970f613e09 100644
>> --- a/drivers/platform/x86/amd-pmc.c
>> +++ b/drivers/platform/x86/amd-pmc.c
>> @@ -29,6 +29,10 @@
>>   #define AMD_PMC_REGISTER_RESPONSE	0x980
>>   #define AMD_PMC_REGISTER_ARGUMENT	0x9BC
>>   
>> +/* PMC Scratch Registers */
>> +#define AMD_PMC_SCRATCH_REG_CZN		0x94
>> +#define AMD_PMC_SCRATCH_REG_YC		0xD14
>> +
>>   /* Base address of SMU for mapping physical address to virtual address */
>>   #define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
>>   #define AMD_PMC_SMU_INDEX_DATA		0xBC
>> @@ -110,6 +114,10 @@ struct amd_pmc_dev {
>>   	u32 base_addr;
>>   	u32 cpu_id;
>>   	u32 active_ips;
>> +/* SMU version information */
>> +	u16 major;
>> +	u16 minor;
>> +	u16 rev;
>>   	struct device *dev;
>>   	struct mutex lock; /* generic mutex lock */
>>   #if IS_ENABLED(CONFIG_DEBUG_FS)
>> @@ -201,6 +209,66 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
>>   
>> +static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
>> +{
>> +	int rc;
>> +	u32 val;
>> +
>> +	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
>> +	if (rc)
>> +		return rc;
>> +
>> +	dev->major = (val >> 16) & GENMASK(15, 0);
>> +	dev->minor = (val >> 8) & GENMASK(7, 0);
>> +	dev->rev = (val >> 0) & GENMASK(7, 0);
>> +
>> +	dev_dbg(dev->dev, "SMU version is %u.%u.%u\n", dev->major, dev->minor, dev->rev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
>> +				 struct seq_file *s)
>> +{
>> +	u32 val;
>> +
>> +	switch (pdev->cpu_id) {
>> +	case AMD_CPU_ID_CZN:
>> +		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_CZN);
>> +		break;
>> +	case AMD_CPU_ID_YC:
>> +		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_YC);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (dev)
>> +		dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
>> +
>> +	if (s)
>> +		seq_printf(s, "SMU idlemask : 0x%x\n", val);
>> +
>> +	return 0;
>> +}
>> +
>> +static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>> +{
>> +	struct amd_pmc_dev *dev = s->private;
>> +	int rc;
>> +
>> +	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
>> +		rc = amd_pmc_idlemask_read(dev, NULL, s);
>> +		if (rc)
>> +			return rc;
>> +	} else {
>> +		seq_puts(s, "Unsupported SMU version for Idlemask\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(amd_pmc_idlemask);
>> +
>>   static void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
>>   {
>>   	debugfs_remove_recursive(dev->dbgfs_dir);
>> @@ -213,6 +281,8 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
>>   			    &smu_fw_info_fops);
>>   	debugfs_create_file("s0ix_stats", 0644, dev->dbgfs_dir, dev,
>>   			    &s0ix_stats_fops);
>> +	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
>> +			    &amd_pmc_idlemask_fops);
>>   }
>>   #else
>>   static inline void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
>> @@ -349,6 +419,8 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
>>   	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_RESET, 0);
>>   	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_START, 0);
>>   
>> +	/* Dump the IdleMask before we send hint to SMU */
>> +	amd_pmc_idlemask_read(pdev, dev, NULL);
>>   	msg = amd_pmc_get_os_hint(pdev);
>>   	rc = amd_pmc_send_cmd(pdev, 1, NULL, msg, 0);
>>   	if (rc)
>> @@ -371,6 +443,9 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
>>   	if (rc)
>>   		dev_err(pdev->dev, "resume failed\n");
>>   
>> +	/* Dump the IdleMask to see the blockers */
>> +	amd_pmc_idlemask_read(pdev, dev, NULL);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -457,6 +532,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
>>   	if (err)
>>   		dev_err(dev->dev, "SMU debugging info not supported on this platform\n");
>>   
>> +	amd_pmc_get_smu_version(dev);
>>   	platform_set_drvdata(pdev, dev);
>>   	amd_pmc_dbgfs_register(dev);
>>   	return 0;
>>
> 
> Looks good to me.
> 
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 

Looks good to me too, thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

