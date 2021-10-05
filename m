Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09703422F99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhJESFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:05:44 -0400
Received: from mail-sn1anam02on2053.outbound.protection.outlook.com ([40.107.96.53]:9294
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232861AbhJESFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:05:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwFWC9F1T04AHUmayZl/QqG2UFX56MoV3hGQbmkhVF45KmNYN6p6tar59nEeqwSnRChWtfJaUpI41cSHjw58o7EsG6L2BrGICBGNhR7r7KRQUCjoNJdrW7DVzy9kzOGuVelWFfap+tfMIMGgYeVBeNb4In83ludZu1bVQiVQAI+xQTcPYa9qVnG8in3KW176vIKAuhJbPPDRh+tpNvbL4TLqn71nZu2syqLVrH19W44EsIqM0TaGbOfbBYMiZA0hrGy7iQiE2q9Q3aSa3uHjlEPhcCYV3bB286zjhaLpswSzX6ZXWL3ZnFqeOs0qnmdM+qHZ8B7o9N84aMje88+bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvPxuNFjNkPFaCv3QlSlPmy45ax3BmBhHigJWTGlYKo=;
 b=mYJUYMmbd3uDVSiEGTq6tkYFSf3yGIVuScbAydOYRJ9i4oEpRSTcNvBKH81Sl8BBtFHqYvmAPqi2lLkfqaIKTci2zhMlDhBS1pcNAKdldcn0HFeagimwUD6QjGp+lbsQRDTJ38McYroykh7boTx5F+Zl+EP5EN7Iy/EnLKmNmC0x+IjO54A9NNYM3I6vUSeFrDC+CmMlo0SznCK5agpUZNnNbUyDG6E+vlA6Va6gMaMvZvmcxzeR26kHEjUsPQP/7lpTcahQwrqYzkSBLAV27bGY18Sn28VHNPB+ggInAxJsIbDHNNEzfs74ZK5fq5XK4DfC178b2uv+NFOG1tdHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvPxuNFjNkPFaCv3QlSlPmy45ax3BmBhHigJWTGlYKo=;
 b=rwKonLb2PnKXVcefKS1Uy2ObwNU1d0MSFtN56j4631zlR3UKOF0krmcE6HcQ4xJvQtZWLr3of7TvHnDcbk0F0OSVHte88Ss6X6xWwIFcmewLiTuhmj1nAjbkGWCdaeLmpMPjmRkEaQv56AjkD+zu13X4kOv4jo4KRVG75wwDNuQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Tue, 5 Oct
 2021 18:03:45 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%5]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 18:03:45 +0000
Subject: Re: [PATCH] platform/x86: amd-pmc: Add support for AMD Smart Trace
 Buffer
To:     Sanket Goswami <Sanket.Goswami@amd.com>, Shyam-sundar.S-k@amd.com,
        hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211005155641.2308-1-Sanket.Goswami@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <e9ec0ab4-8e4a-8824-fd03-fe001009c9b4@amd.com>
Date:   Tue, 5 Oct 2021 13:03:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211005155641.2308-1-Sanket.Goswami@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR1401CA0004.namprd14.prod.outlook.com
 (2603:10b6:405:4b::14) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.34.155] (165.204.84.11) by BN6PR1401CA0004.namprd14.prod.outlook.com (2603:10b6:405:4b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 5 Oct 2021 18:03:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e039d9-b552-4d14-b273-08d9882a793b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45733F92492152F0BC037617E2AF9@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hnUt2WNuaPVzj341F8Kzy9NLNaSUOO+wBUaFu2G52ut/UUnddjAoIvJfTpyKBa75pZlOqN3EF0Cba0PmiMwWsgJoAkCh2oLIE+s46nc1kLl0ZWaTbh6qXR9lXlDjyv1KbpLT7MIgPETt3r8Jb5gP+F+umpy37Vl19Je5/AMk/kPIraUmP6Cl2XMEDXQZjicXNbXbMeETuWxh8eRm9neA5yvDN248m2XyBtogRSqXLbTghJ3Y2I67VPFijwYfSNdlXXdGTLdjHGaAFQ1QSbP7HVkzumggQhK9BEvp4j+y9Vko8jdKoK/Zi4JF8DZA+xeBga3lFcqnmmdxow+isEtjc+t5ZvfbRXHmZHRc4zQJaMRa1Y+WAtQ2C1puwNvxIy+vtKb9PfeRka+VWgKizq57GGCZC2HdmjmPAFo8J07UCwPQzKVRhHlM9qJf2EHPIqWsmcdzERWUuWlgrO/aeTD+3k6vU97i2Lhf40Y0IN6QQZOcT5ICHL/8A6v659TpeBVvKDZMNsRU/Akv+7ll8LO4ycjltR7KroZiZcN7N5M2aUhxgiI8+IX3+YfUfhSxFDIdsJNVjL72duqclRLCSjwQ4g83hgj0LrLsedIWrjOkKvKD7DOeFPwyfcP0VnDmq4b9dnHJ9GFb+bYg2wPkq8Bp28qx/UIlshSNQ3v++RDSRM1ynO6MUNNn0iJqyNED3qMZycwkQoZHlHdW+/6sqCUM61kd+hbnwgF0V+LRnwWDeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(5660300002)(16576012)(6486002)(31696002)(36756003)(2616005)(31686004)(8676002)(8936002)(86362001)(186003)(53546011)(316002)(26005)(83380400001)(2906002)(66556008)(4326008)(38100700002)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGZOeGNBK0hDRXBqcSsyelRjU0lzUmV6amtJTW0rdS9WeDc0WkkxUVFsMk1a?=
 =?utf-8?B?N1ZxMUNUUDFPZEpjb2NZOW1SaWl0QWJLRWx0KzczaENKLy9tQXVCVzQ4MHlX?=
 =?utf-8?B?NkJWSFdWQWUrOFlvTWwyU3FNYnVLNFBuQjFDQjZ2enQ4TVlBbEFlNmNZbG12?=
 =?utf-8?B?OU5paXNoTCtsMDhlUEVsMnlQOE9uNDJmak1KTXhyN2NvUXB1TzNwQW5ONGly?=
 =?utf-8?B?OXNVdDdINlZLOSt0R0U2ODhSTGNNT0NiOENneDVRaXAwQ3F1WG1kckF6bHY2?=
 =?utf-8?B?eEt4TkV3ams2NTMyRlNiNER4R05EQUVaeFpOSXZRbDg1VXhFWk9LbWNKck1X?=
 =?utf-8?B?RUIwZTZYNzhpVGFhU3Qzd2dkNlhCWlFBL1RQZXVERG9mTmNQSkhVa3E3ZERP?=
 =?utf-8?B?c24zdmoyTC85dTVwT3lFWVJnUng4QlFLenZGTXRHbmhTMit2VVdvcUJNcU94?=
 =?utf-8?B?a2ErcDlkOHVWQTlweUs4WS9hQ21yMnNZWTZCOW8wNVQ0UkpJSHZjWVpvM3ZE?=
 =?utf-8?B?M3dEVis1TGVvazRHUW9kRTArV0dIUWpBRGpiblN4L3BJWFlFMlNzNVEwQTFx?=
 =?utf-8?B?ZkhlTmN4RkUxZDk0UmNXQ2V6aHNpVzRwQ2RNbjU4SmwxQW1LTFFaaE1sRmRw?=
 =?utf-8?B?YnFtcDhHQitqTW1CNVF1a0w3M2Q4a2VHY0JTRkRSZnIyVmN2blc1ZThtOUx6?=
 =?utf-8?B?RHpxazdRM3BmS0kwMGd0WjBIRW5DeEpIREI4UzkwQ1g2b29EVDl5UnE2S1ln?=
 =?utf-8?B?Z1VCZzhLWlpiRlA3MUorZEc0YUNXaXdaM1g0WXd4THJncGNMVGlnbFNWUVJq?=
 =?utf-8?B?OXgyWjF4c1d4WE56TEZHd3R4cFpyVTN3UGZmV1pPS0cyaG9xWEVBRmN1SHla?=
 =?utf-8?B?OERXZ3BwblpJZFVNKzB2aUJEcXoyKzc1MzVZSUVTNE1iakNlcHE2VEZNTytK?=
 =?utf-8?B?VHVNOFdxbnF5ZDRqSXZiOVJrVkMxTDNQOHoxQ3ZCNWlBOWlWRzAxRXdOcmRo?=
 =?utf-8?B?OEdGL0xWUHplaFdDWHEwMWd5R0dTdkJ4L2pzNjVPdndPTXJuT0NGOExOUGxy?=
 =?utf-8?B?OXhFZkV6cWFXZlQwOFlsSFpTY3NReTR2VWFZZDRGdm1CMjAvc2lGc0wyUi9s?=
 =?utf-8?B?Qzd0VWFJVFY0VE9JUEgyS0F6ai9FVjJQSnNhRlV5S0k3eUluRzIxdG9oQXF5?=
 =?utf-8?B?OW84VkxKbzJ6bUdnenkyN2F3bTFpcFpuYlRmVWpNQzVBWm00NUtTZGkzU3lt?=
 =?utf-8?B?a0V3VUFONmx1Q2h2TXVaRmNnSHdWVUdIRUhBNkU2d25tTzZML2hGeWhMZkpF?=
 =?utf-8?B?M3dkTS9PaFN4RVNTN2YzUW5XNDE5Z3A2bkE2V2E2aDFoeSs1UlBrbFhCVFJh?=
 =?utf-8?B?OXRnekdQbXF4VG1rNW9LRnhhQ1BvQXU3eXhnYnFUdkQ1VXByN1J1eE53Q21Z?=
 =?utf-8?B?Q3ozS0gyeUxoSHlGVktReFNoYjFueWkxSDV4QjM4UFZ0dmYwUHplM3o2aGkr?=
 =?utf-8?B?SG03cTFmbWJ0N3hlRFFVMWhtWGdGTVcvVytpcHhXSlg0aHVQYmk3T1Y3cmEw?=
 =?utf-8?B?eU0zTHZlZVRSVGYrY1lUM0ZpcFVqZlNieDdrbEROeGRHUXR6UGo0SWkwTTN4?=
 =?utf-8?B?Tlp4MXBMVjhwRUdKUEJyeFVRSWdjeDliK1RvT2lNY2dLYkIrMlUvZVh0eEVa?=
 =?utf-8?B?NkE5dW1QZVpZK2F6emNUcWlkeWlmZVNjaHo5bUFrYnFlWWxpSEY5SzZ1dENi?=
 =?utf-8?Q?YvnPWsMZwELpQs4PV0Nsk5ZqiAlP6gu8k3Ma29l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e039d9-b552-4d14-b273-08d9882a793b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 18:03:45.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7NglGCtIT5DWnpn7wsS262cMq8Sj+1kLVtF0nOqmDqjEE2EsDa2YITxEpogtPHZ8bBFpbR0DqMVyVLng9c1qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2021 10:56, Sanket Goswami wrote:
> STB (Smart Trace Buffer), is a debug trace buffer which is used to help
> isolate failures by analyzing the last feature that a system was running
> before hitting a failure. This nonintrusive way is always running in the
> background and trace is stored into the SoC.
> 
> This patch provides mechanism to access the STB buffer using the read and
> write routines.

This is a great feature to add, thanks a lot for submitting it.

I think it may be especially useful for some of the low failure rate 
s2idle issues that we have been tracking on AMD's Gitlab tracker.

> 
> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> ---
>   drivers/platform/x86/amd-pmc.c | 110 +++++++++++++++++++++++++++++++++
>   1 file changed, 110 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 7b44833290df..c853b22cad6a 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -33,6 +33,12 @@
>   #define AMD_PMC_SCRATCH_REG_CZN		0x94
>   #define AMD_PMC_SCRATCH_REG_YC		0xD14
>   
> +/* STB Registers */
> +#define AMD_PMC_STB_INDEX_ADDRESS	0xF8
> +#define AMD_PMC_STB_INDEX_DATA		0xFC
> +#define AMD_PMC_STB_PMI_0		0x03E30600
> +#define AMD_PMC_STB_PREDEF		0xC6000001
> +
>   /* Base address of SMU for mapping physical address to virtual address */
>   #define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
>   #define AMD_PMC_SMU_INDEX_DATA		0xBC
> @@ -80,6 +86,7 @@
>   #define SOC_SUBSYSTEM_IP_MAX	12
>   #define DELAY_MIN_US		2000
>   #define DELAY_MAX_US		3000
> +#define FIFO_SIZE		4096
>   enum amd_pmc_def {
>   	MSG_TEST = 0x01,
>   	MSG_OS_HINT_PCO,
> @@ -119,13 +126,21 @@ struct amd_pmc_dev {
>   	u16 minor;
>   	u16 rev;
>   	struct device *dev;
> +	struct pci_dev *rdev;
>   	struct mutex lock; /* generic mutex lock */
>   #if IS_ENABLED(CONFIG_DEBUG_FS)
>   	struct dentry *dbgfs_dir;
>   #endif /* CONFIG_DEBUG_FS */
>   };
>   
> +static u32 stb_data[FIFO_SIZE];
> +static bool enable_stb;
> +module_param(enable_stb, bool, 0644);
> +MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
> +
>   static struct amd_pmc_dev pmc;
> +static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
> +static int amd_pmc_read_stb(struct amd_pmc_dev *dev);
>   static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, bool set, u32 *data, u8 msg, bool ret);
>   
>   static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
> @@ -254,6 +269,20 @@ static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>   }
>   DEFINE_SHOW_ATTRIBUTE(amd_pmc_idlemask);
>   
> +static int stb_read_show(struct seq_file *seq, void *unused)
> +{
> +	struct amd_pmc_dev *pdev = seq->private;
> +	int i;
> +
> +	amd_pmc_read_stb(pdev);
> +
> +	for (i = 0; i < FIFO_SIZE; i += 4)
> +		seq_hex_dump(seq, "", DUMP_PREFIX_NONE, 16, 1, &stb_data[i], 16, true);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(stb_read);
> +
>   static void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
>   {
>   	debugfs_remove_recursive(dev->dbgfs_dir);
> @@ -268,6 +297,10 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
>   			    &s0ix_stats_fops);
>   	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
>   			    &amd_pmc_idlemask_fops);
> +	/* Enable STB only when the module_param is set */
> +	if (enable_stb)
> +		debugfs_create_file("stb_read", 0644, dev->dbgfs_dir, dev,
> +				    &stb_read_fops);
>   }
>   #else
>   static inline void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
> @@ -429,6 +462,9 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
>   	if (rc)
>   		dev_err(pdev->dev, "suspend failed\n");
>   
> +	if (enable_stb)
> +		amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
> +
>   	return rc;
>   }
>   
> @@ -449,6 +485,10 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
>   	/* Dump the IdleMask to see the blockers */
>   	amd_pmc_idlemask_read(pdev, dev, NULL);
>   
> +	/* Write data incremented by 1 to distinguish in stb_read */
> +	if (enable_stb)
> +		amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
> +
>   	return 0;
>   }
>   
> @@ -465,6 +505,76 @@ static const struct pci_device_id pmc_pci_ids[] = {
>   	{ }
>   };
>   
> +static int amd_pmc_get_root_port(struct amd_pmc_dev *dev)
> +{
> +	dev->rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (!dev->rdev || !pci_match_id(pmc_pci_ids, dev->rdev)) {
> +		pci_dev_put(dev->rdev);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
> +{
> +	int rc;
> +
> +	rc = amd_pmc_get_root_port(dev);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_write_config_dword(dev->rdev, AMD_PMC_STB_INDEX_ADDRESS, AMD_PMC_STB_PMI_0);
> +	if (rc) {
> +		dev_err(dev->dev, "failed to write addr in stb: 0x%X\n",
> +			AMD_PMC_STB_INDEX_ADDRESS);
> +		pci_dev_put(dev->rdev);
> +		return pcibios_err_to_errno(rc);
> +	}
> +
> +	rc = pci_write_config_dword(dev->rdev, AMD_PMC_STB_INDEX_DATA, data);
> +	if (rc) {
> +		dev_err(dev->dev, "failed to write data in stb: 0x%X\n",
> +			AMD_PMC_STB_INDEX_DATA);
> +		pci_dev_put(dev->rdev);
> +		return pcibios_err_to_errno(rc);
> +	}
> +
> +	return 0;
> +}
> +
> +static int amd_pmc_read_stb(struct amd_pmc_dev *dev)
> +{
> +	u32 cnt = 0, value;
> +	int i, err;
> +
> +	err = amd_pmc_get_root_port(dev);
> +	if (err)
> +		return err;
> +
> +	err = pci_write_config_dword(dev->rdev, AMD_PMC_STB_INDEX_ADDRESS, AMD_PMC_STB_PMI_0);
> +	if (err) {
> +		dev_err(dev->dev, "error writing addr to stb: 0x%X\n",
> +			AMD_PMC_STB_INDEX_ADDRESS);
> +		pci_dev_put(dev->rdev);
> +		return pcibios_err_to_errno(err);
> +	}
> +
> +	for (i = 0; i < FIFO_SIZE; i++) {
> +		err = pci_read_config_dword(dev->rdev, AMD_PMC_STB_INDEX_DATA, &value);
> +		if (err) {
> +			dev_err(dev->dev, "error reading data from stb: 0x%X\n",
> +				AMD_PMC_STB_INDEX_DATA);
> +			pci_dev_put(dev->rdev);
> +			return pcibios_err_to_errno(err);
> +		}
> +
> +		stb_data[cnt++] = value;
> +	}
> +
> +	return 0;
> +}
> +
>   static int amd_pmc_probe(struct platform_device *pdev)
>   {
>   	struct amd_pmc_dev *dev = &pmc;
> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
