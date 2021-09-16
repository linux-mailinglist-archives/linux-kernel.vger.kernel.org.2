Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5622440DA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhIPNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:02:24 -0400
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:59143
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239847AbhIPNCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xar3CK4pIRudQ2VxMtu+tS3UTOf9v2gt+ady8NaWeIiuj/DdG0HjwUdmUAQUI4kdQxm2jHSFkkQzyb0re/4GrfCu1kklgtAKIBpdweV+0ZL5Zwe2RWG88ODJE7SvH3R2D3yV39LAegl8aJIZ6OBRg0Qn7Uu1XW1kAxMv1v3fbmov1a6XkCSunM8FKDGQdcLS0tkdSW19iwqaInbG4b2HyZ2wpTmZShjKkXUUiQ7aXWlopuexgT1tC2N2OBjlkGojQwsT98Zk3mUwzjvuCukQeLHsAb0zWnIrRzQQa3nbnd+YBKhfR9nt/JXYTEt0KzoV0AkMXgQpDtarpMdpUPVwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8OgbBZa96r4hvB9dl/HGgWF3jIUYpWfwVKdaXiIpIhQ=;
 b=lRX1ttyub+khc70YBf6p51JtaHwBwIzE7vQrb4LC3cVWkipoO9vd7EwIGUGA7mzzz9r1NQi3t9MpoPGw7+IV7IoYkNGsoeN4QNe2zalpoaj+OfAC4hu2SkqXt0tZlvVy/6/K/tK1Xh7OajKbfh3RCm0F/lnO4NEkgzdjjhBMoNAkbnfnT7Dama8c7zvIOJJx9P3WEj3W/zZDBXHXewLOo7QsoEpkLPm25D7BTTpSnFGreVQn5n7YfXdN5z4tjYzWKz2+bTxoNaHAU1Ets/q8aHG5EFAVzd9IkxzTAidH0RjOibcGEivsPhyBTh1qlMedwzr998kx51jyc5yLJv8oJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OgbBZa96r4hvB9dl/HGgWF3jIUYpWfwVKdaXiIpIhQ=;
 b=4B3lco98tiMpsGhYpoU/vOEp7qxKVXulJ+fQRXSnO3MBNgVDgyQdKyCzmRz96SoqbO/ueBOaREjiXo3I03NI7Wmfzm2xxWf3l+zz00FNjdjleeLg68brxuKxoTtg2NFagR0CE9BzP9Z+2jNJGPy+yBLL0YYSLqzhmX1OVLiYI1w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 13:01:01 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::888b:8deb:3f8b:8d61]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::888b:8deb:3f8b:8d61%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 13:01:01 +0000
Subject: Re: [PATCH v2] platform/x86: amd-pmc: Export Idlemask values based on
 the APU
To:     Sanket Goswami <Sanket.Goswami@amd.com>, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <20210916124002.2529-1-Sanket.Goswami@amd.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Message-ID: <de42f717-4cb1-6056-bec1-b46271bbcab8@amd.com>
Date:   Thu, 16 Sep 2021 18:30:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210916124002.2529-1-Sanket.Goswami@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::20) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
Received: from [10.252.89.180] (165.204.159.242) by BMXPR01CA0034.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 13:00:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7730e8a2-691a-4783-009e-08d979120893
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5288E2E020A78A794B75CD079ADC9@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pg5nahqxvZqyum/A1V1Tcd7FQ7GmPEG3PBhmqyFyudybioJY9dqnPW8pKeaubnS639S1O8zjlXtDi2GGkIhgbRqZTU/FI9jDjmXlMsbYiCFs8HRRNyBfNMtlDyUqS1osAboWG4HG0CKo22Yf0zACcWqPHZ8fLxlW8+qthIROIYJrxqrO6URiJVTeeVim00dREGnDYph0jKu6rZrm1A6B1yV96Y6fl4m121MQGc7SYcAfEpOS8ei1DID5hwXAUV9cblPwZKxCQu4f4c3KZBtaAL7REi7EVGTp1vlfrc6D3SfS4qEtf6MjSkvieGFbbktGp4a4LNWv8IneloirkTtwTZNUile1AQTBgWSIvQU66uTYThr7LHdMfhDBcUa62SEAoU9XQAtef1PhOYsif+El8X5o5EqIyYm5iU/d4rFck7158Y+WrAvg6FfYQKCrY7mvjHeTIu0yej6/ulQkPAlTlxBslVSIlQDYVna8PnErUU02XNluDjuuSbCPbMHBYLTbVtFeZqgyOAI2JAfbQe+HKDUmLv3UdNyw1+mYyfjblwArRHGf5uShAVUWQ4kZnMHwSxGdubq+RJpXDFXNxZ+D04vZm0KYsPlC3xp6m2036nxiAVBMpWuN8BqU/QMXrEV5BNc2V1GbO5gBWXZ13ybkRbFSBFqyWry3hmGrB48iJqEICXDF6qYr99E5GjcuQgnhsamzvAlHP+JposP8Krs10K3u3INlaVkVCB2AjXoJ8eQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(31696002)(6666004)(86362001)(6486002)(66556008)(4326008)(478600001)(83380400001)(316002)(53546011)(36756003)(16576012)(2906002)(186003)(5660300002)(8936002)(2616005)(26005)(8676002)(956004)(31686004)(66946007)(66476007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak1rYTU5cnY1bS9zYzBnS3ZnMUhYOGJSR2FXSm5XSUphajZyOU9rVWd1Z0tY?=
 =?utf-8?B?eStTbjYwZUZnYlMzOHN2R0FQdTg3REM5ZUJEcnJReEZPKzBNc2hmbFU4RUhY?=
 =?utf-8?B?QlZuWjliM01HYnVSM1duRG5xR1RsNTU0S29ibkQ0ZStzNlpTN3V6eVZtNys1?=
 =?utf-8?B?aHNCRVBhdXBZOWlmUHNoWVp1Rmwrcy9seUtDcWFjVEEwei92Uk1neW5GaU1G?=
 =?utf-8?B?aGd6L3plUFlhbThwUXRvc3Q2TmJkYnpuZjVDdys4MCtPT0tvaXQwT1duNW5w?=
 =?utf-8?B?WmFSKzBiR0NxUTdQa2JHbHVPZXBXZEs2MExrNjR1enpMd0FXa05ZOW80bkNQ?=
 =?utf-8?B?Zm9yQ1VudEx5czkydkY4RXFGNzI0L0lmRXdWNGhmTTBKbnlIVk9yNndPNXJ1?=
 =?utf-8?B?ditMbjVVMXZYZDRpSU9KNkVLWDk3eHdwOVVqNUxDOUJWMmVqSVFzeEpUODJI?=
 =?utf-8?B?aWNKMGZ3TmhVbXJOdHZiZVRKK1JZY2ZZeERjblkwSEN6ekdsQVdIK3hTZCtL?=
 =?utf-8?B?cXFFRXhydEF6Rk9rbXd5Z2hRU0wxRTBwZkxSb2t1ajRydEplWXdLMzBCUHBo?=
 =?utf-8?B?ZGZKdXhORDlzSm9QRXNweXhxeVJxMUh2ekQ0cFJjTDMxeUJTaERJdGprbnA4?=
 =?utf-8?B?TnF2ZndWc3JsenN2dERrVGx3QkcwdnU1Uk93TWF6RjZ5OHNmK3FOMlVmcXZ5?=
 =?utf-8?B?NDBZNE9haDY1RjZneXZNMXBkNnhDSnZJdWNGN1BFSitmM0drSm1OYTJMRjhi?=
 =?utf-8?B?K3Y2NjUvZEw3ZHh2ekVCRDEwWk5XSldFOTNkempYMHl0UXdtUEFnYURpNXpX?=
 =?utf-8?B?MHBZckEwWHdTK0d2bHlIRGlScVBOcEhmK3JuMzdTZGkreXNyNy90ZmdLZGlu?=
 =?utf-8?B?SjhHN1d2RHVaTEVJc1RTaG5qT1dPT1kwODdBWi83aVU2Q1Q0RTF6eW5yUzdj?=
 =?utf-8?B?bVRTUFcwWmhreEtiV0VBN29IejN0R2FxVXhSVGo3L2pFajBhVWs4N2JzdU9o?=
 =?utf-8?B?bVNDWkczd0dyL2NoeW1zWHJlamVWbXlGUmJ0b3ZmWDNPaVQvWEd0cHpyYWdU?=
 =?utf-8?B?MnZrU25EUmRNVWZBQ1BoS0o5Z2ovN1VzY25KN1lMYTVZNzJaUEErMU5tQ0FB?=
 =?utf-8?B?K2VZMTB6VUdMaGw3TTFzS2VMVjlocVdNS1ZhUnE2SlpZd1YzdVV2MjJmZVI2?=
 =?utf-8?B?cG1JWFlJVTZXR2lLemZnYk13eWNyWjZyS1BwWU9PYVVneFRKRGxGOGlHeXFw?=
 =?utf-8?B?RGVDSVlkbUxSMDdORTJsOWFmcTB1WmlxS2V0bzJPVGtOVFVMTXBCcjVhS0NK?=
 =?utf-8?B?NXlSN2hUaWNIOExiZVBaaTNiQTVORVVYWlpGdEw2Vy90cXdNaTFaRlJQRlVQ?=
 =?utf-8?B?dXZaMFVSOU5LRWlyVTgwc2VIc3RoOXhzYVNXSzNnT1o0aXZIZ0ZuTkl6Mkk5?=
 =?utf-8?B?TEdkZnhOYnlZb2ltbEY0RU82M2g2UWJlUTAvenRWQnlHeHpXaUtYYjdMTm1Q?=
 =?utf-8?B?Zm9qNzQzQnFzZmNMNkpuSGw4b0RqWHNUcjJmWFp0MmZlc1RJKzdJRUJQancv?=
 =?utf-8?B?ZEcvaU82V0I2dGF4bGxUK1l0MFp6ajdTcjF5N2hGUEx3SU9rTlJzZmRVVkM0?=
 =?utf-8?B?STFWeUdmZ0E2andaeXVnUXNjcVk0Z1BqVEpHYW9IbHF6Q284akRFRkFMdkxC?=
 =?utf-8?B?VW1zQ0hORndwWGhnN0tSa2ZaVVhGb0pBTFFrdmtmeXozRlVvanVEcmlRSHdQ?=
 =?utf-8?Q?/4IrrDahJMYF4vHVT+fMIKumvq6Jx4mrP8XQFQn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7730e8a2-691a-4783-009e-08d979120893
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 13:01:01.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnyOXovknU9dMzUMNZUcupbTLrEmhtprS/yGPG2kyR5FhIgiTGYs+6gKiXx+g1Oan39aJWv5Bj7Wvz8lGTmoqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mario

On 9/16/2021 6:10 PM, Sanket Goswami wrote:
> IdleMask is the metric used by the PM firmware to know the status of each
> of the Hardware IP blocks monitored by the PM firmware.
> 
> Knowing this value is key to get the information of s2idle suspend/resume
> status. This value is mapped to PMC scratch registers, retrieve them
> accordingly based on the CPU family and the underlying firmware support.
> 
> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> ---
> Changes in v2:
> - Add separate routine amd_pmc_idlemask_read to get the value.
> - Address review comments from Mario.
> 
>  drivers/platform/x86/amd-pmc.c | 76 ++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 3481479a2942..0c970f613e09 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -29,6 +29,10 @@
>  #define AMD_PMC_REGISTER_RESPONSE	0x980
>  #define AMD_PMC_REGISTER_ARGUMENT	0x9BC
>  
> +/* PMC Scratch Registers */
> +#define AMD_PMC_SCRATCH_REG_CZN		0x94
> +#define AMD_PMC_SCRATCH_REG_YC		0xD14
> +
>  /* Base address of SMU for mapping physical address to virtual address */
>  #define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
>  #define AMD_PMC_SMU_INDEX_DATA		0xBC
> @@ -110,6 +114,10 @@ struct amd_pmc_dev {
>  	u32 base_addr;
>  	u32 cpu_id;
>  	u32 active_ips;
> +/* SMU version information */
> +	u16 major;
> +	u16 minor;
> +	u16 rev;
>  	struct device *dev;
>  	struct mutex lock; /* generic mutex lock */
>  #if IS_ENABLED(CONFIG_DEBUG_FS)
> @@ -201,6 +209,66 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
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
> +static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
> +				 struct seq_file *s)
> +{
> +	u32 val;
> +
> +	switch (pdev->cpu_id) {
> +	case AMD_CPU_ID_CZN:
> +		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_CZN);
> +		break;
> +	case AMD_CPU_ID_YC:
> +		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_YC);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (dev)
> +		dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
> +
> +	if (s)
> +		seq_printf(s, "SMU idlemask : 0x%x\n", val);
> +
> +	return 0;
> +}
> +
> +static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
> +{
> +	struct amd_pmc_dev *dev = s->private;
> +	int rc;
> +
> +	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
> +		rc = amd_pmc_idlemask_read(dev, NULL, s);
> +		if (rc)
> +			return rc;
> +	} else {
> +		seq_puts(s, "Unsupported SMU version for Idlemask\n");
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(amd_pmc_idlemask);
> +
>  static void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
>  {
>  	debugfs_remove_recursive(dev->dbgfs_dir);
> @@ -213,6 +281,8 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
>  			    &smu_fw_info_fops);
>  	debugfs_create_file("s0ix_stats", 0644, dev->dbgfs_dir, dev,
>  			    &s0ix_stats_fops);
> +	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
> +			    &amd_pmc_idlemask_fops);
>  }
>  #else
>  static inline void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
> @@ -349,6 +419,8 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
>  	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_RESET, 0);
>  	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_START, 0);
>  
> +	/* Dump the IdleMask before we send hint to SMU */
> +	amd_pmc_idlemask_read(pdev, dev, NULL);
>  	msg = amd_pmc_get_os_hint(pdev);
>  	rc = amd_pmc_send_cmd(pdev, 1, NULL, msg, 0);
>  	if (rc)
> @@ -371,6 +443,9 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
>  	if (rc)
>  		dev_err(pdev->dev, "resume failed\n");
>  
> +	/* Dump the IdleMask to see the blockers */
> +	amd_pmc_idlemask_read(pdev, dev, NULL);
> +
>  	return 0;
>  }
>  
> @@ -457,6 +532,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
>  	if (err)
>  		dev_err(dev->dev, "SMU debugging info not supported on this platform\n");
>  
> +	amd_pmc_get_smu_version(dev);
>  	platform_set_drvdata(pdev, dev);
>  	amd_pmc_dbgfs_register(dev);
>  	return 0;
> 

Looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
