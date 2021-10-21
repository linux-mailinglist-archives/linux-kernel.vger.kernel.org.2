Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB13E436E93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhJUX5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:57:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:7635 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhJUX5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:57:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="252686400"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="252686400"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:55:27 -0700
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445050920"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:55:27 -0700
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 665A56362;
        Thu, 21 Oct 2021 16:55:26 -0700 (PDT)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id CEA7A361DAB; Thu, 21 Oct 2021 16:57:53 -0700 (PDT)
Date:   Thu, 21 Oct 2021 16:57:53 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Sanket Goswami <Sanket.Goswami@amd.com>
Cc:     Shyam-sundar.S-k@amd.com, hdegoede@redhat.com,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/x86: amd-pmc: Add support for AMD Smart
 Trace Buffer
Message-ID: <20211021235753.GF63795@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20211021093106.196989-1-Sanket.Goswami@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021093106.196989-1-Sanket.Goswami@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:01:06PM +0530, Sanket Goswami wrote:
> STB (Smart Trace Buffer), is a debug trace buffer which is used to help
> isolate failures by analyzing the last feature that a system was running
> before hitting a failure. This nonintrusive way is always running in the
> background and trace is stored into the SoC.
> 
> This patch provides mechanism to access the STB buffer using the read
> and write routines.
I don't see the write routine exported.

> 
> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> ---
> Changes in v2:
> - Create amd_pmc_stb_debugfs_fops structure to get STB data.
> - Address review comments from Hans.
> 
>  drivers/platform/x86/amd-pmc.c | 120 +++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 502f37eaba1f..df53c5996e2c 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -33,6 +33,12 @@
>  #define AMD_PMC_SCRATCH_REG_CZN		0x94
>  #define AMD_PMC_SCRATCH_REG_YC		0xD14
>  
> +/* STB Registers */
> +#define AMD_PMC_STB_INDEX_ADDRESS	0xF8
> +#define AMD_PMC_STB_INDEX_DATA		0xFC
> +#define AMD_PMC_STB_PMI_0		0x03E30600
> +#define AMD_PMC_STB_PREDEF		0xC6000001
> +
>  /* Base address of SMU for mapping physical address to virtual address */
>  #define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
>  #define AMD_PMC_SMU_INDEX_DATA		0xBC
> @@ -80,6 +86,7 @@
>  #define SOC_SUBSYSTEM_IP_MAX	12
>  #define DELAY_MIN_US		2000
>  #define DELAY_MAX_US		3000
> +#define FIFO_SIZE		4096
>  enum amd_pmc_def {
>  	MSG_TEST = 0x01,
>  	MSG_OS_HINT_PCO,
> @@ -126,8 +133,14 @@ struct amd_pmc_dev {
>  #endif /* CONFIG_DEBUG_FS */
>  };
>  
> +static bool enable_stb;
> +module_param(enable_stb, bool, 0644);
> +MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
> +
>  static struct amd_pmc_dev pmc;
>  static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, bool set, u32 *data, u8 msg, bool ret);
> +static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
shouldn't this be exported as a kernel API to log stuff?  seems like a waist to
only log the pmc suspend resume status.

> +static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
>  
>  static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
>  {
> @@ -156,6 +169,51 @@ struct smu_metrics {
>  	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
>  } __packed;
>  
> +static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
> +{
> +	struct amd_pmc_dev *dev = filp->f_inode->i_private;
> +	u32 *buf;
> +	int rc;
> +
> +	buf = devm_kmalloc(dev->dev, FIFO_SIZE * 4, GFP_KERNEL);
would it be more readable to use sizeof(u32)?

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	rc = amd_pmc_read_stb(dev, buf);
> +	if (rc)
> +		goto out;
> +
> +	filp->private_data = buf;
> +
> +out:
> +	return rc;
> +}
> +
> +static ssize_t amd_pmc_stb_debugfs_read(struct file *filp, char __user *buf, size_t size,
> +					loff_t *pos)
> +{
> +	if (!filp->private_data)
> +		return -EINVAL;
> +
> +	return simple_read_from_buffer(buf, size, pos, filp->private_data,
> +				       FIFO_SIZE * 4);
would it be more readable to use sizeof(u32)?
> +}
> +
> +static int amd_pmc_stb_debugfs_release(struct inode *inode, struct file *filp)
> +{
> +	kfree(filp->private_data);
> +	filp->private_data = NULL;
> +
> +	return 0;
> +}
> +
> +const struct file_operations amd_pmc_stb_debugfs_fops = {
> +	.owner = THIS_MODULE,
> +	.open = amd_pmc_stb_debugfs_open,
> +	.read = amd_pmc_stb_debugfs_read,
> +	.release = amd_pmc_stb_debugfs_release,
are you missing a write fop?  you commit comment talked about a write routine.


> +};
> +
>  static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
>  				 struct seq_file *s)
>  {
> @@ -269,6 +327,10 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
>  			    &s0ix_stats_fops);
>  	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
>  			    &amd_pmc_idlemask_fops);
> +	/* Enable STB only when the module_param is set */
> +	if (enable_stb)
> +		debugfs_create_file("stb_read", 0644, dev->dbgfs_dir, dev,
> +				    &amd_pmc_stb_debugfs_fops);
>  }
>  #else
>  static inline void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
> @@ -430,6 +492,9 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
>  	if (rc)
>  		dev_err(pdev->dev, "suspend failed\n");
>  
> +	if (enable_stb)
> +		amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
> +
>  	return rc;
>  }
>  
> @@ -450,6 +515,10 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
>  	/* Dump the IdleMask to see the blockers */
>  	amd_pmc_idlemask_read(pdev, dev, NULL);
>  
> +	/* Write data incremented by 1 to distinguish in stb_read */
> +	if (enable_stb)
> +		amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
> +
>  	return 0;
>  }
>  
> @@ -466,6 +535,57 @@ static const struct pci_device_id pmc_pci_ids[] = {
>  	{ }
>  };
>  
> +static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
> +{
> +	int rc;
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
> +static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
> +{
> +	int i, err;
> +	u32 value;
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
> +		*buf++ = value;
> +	}
> +
> +	return 0;
> +}
> +
>  static int amd_pmc_probe(struct platform_device *pdev)
>  {
>  	struct amd_pmc_dev *dev = &pmc;
> -- 
> 2.25.1
> 
