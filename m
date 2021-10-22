Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B040437B19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhJVQut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:50:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:48049 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232190AbhJVQur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:50:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216255620"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216255620"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 09:48:11 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="553389108"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 09:48:10 -0700
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 184946362;
        Fri, 22 Oct 2021 09:48:09 -0700 (PDT)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 81C9336247C; Fri, 22 Oct 2021 09:50:35 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:50:35 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     mgross@linux.intel.com, Sanket Goswami <Sanket.Goswami@amd.com>,
        hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/x86: amd-pmc: Add support for AMD Smart
 Trace Buffer
Message-ID: <20211022165035.GE94023@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20211021093106.196989-1-Sanket.Goswami@amd.com>
 <20211021235753.GF63795@linux.intel.com>
 <b2d7cb80-a8dc-3951-252f-63ff413ed5b0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d7cb80-a8dc-3951-252f-63ff413ed5b0@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 12:12:57PM +0530, Shyam Sundar S K wrote:
> Hi Mark,
> 
> On 10/22/2021 5:27 AM, mark gross wrote:
> > On Thu, Oct 21, 2021 at 03:01:06PM +0530, Sanket Goswami wrote:
> >> STB (Smart Trace Buffer), is a debug trace buffer which is used to help
> >> isolate failures by analyzing the last feature that a system was running
> >> before hitting a failure. This nonintrusive way is always running in the
> >> background and trace is stored into the SoC.
> >>
> >> This patch provides mechanism to access the STB buffer using the read
> >> and write routines.
> > I don't see the write routine exported.
> 
> There is a function which does this job amd_pmc_write_stb()
> 
> OR
> 
> You mean to say EXPORT_SYMBOL() ?
Yup.  this looks like fancy memory to logging debug traces that will survive a
warmboot.  So why is the scope of writing such traces limited to just this
file?  Kindof looks like a useful debug hack done to solving a suspend/resume
crash.  Yet, you are tring to upstream it.  Shouldn't this be more generalized
if its going to be upstreamed?

--mark

> 
> > 
> >>
> >> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> >> ---
> >> Changes in v2:
> >> - Create amd_pmc_stb_debugfs_fops structure to get STB data.
> >> - Address review comments from Hans.
> >>
> >>  drivers/platform/x86/amd-pmc.c | 120 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 120 insertions(+)
> >>
> >> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> >> index 502f37eaba1f..df53c5996e2c 100644
> >> --- a/drivers/platform/x86/amd-pmc.c
> >> +++ b/drivers/platform/x86/amd-pmc.c
> >> @@ -33,6 +33,12 @@
> >>  #define AMD_PMC_SCRATCH_REG_CZN		0x94
> >>  #define AMD_PMC_SCRATCH_REG_YC		0xD14
> >>  
> >> +/* STB Registers */
> >> +#define AMD_PMC_STB_INDEX_ADDRESS	0xF8
> >> +#define AMD_PMC_STB_INDEX_DATA		0xFC
> >> +#define AMD_PMC_STB_PMI_0		0x03E30600
> >> +#define AMD_PMC_STB_PREDEF		0xC6000001
> >> +
> >>  /* Base address of SMU for mapping physical address to virtual address */
> >>  #define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
> >>  #define AMD_PMC_SMU_INDEX_DATA		0xBC
> >> @@ -80,6 +86,7 @@
> >>  #define SOC_SUBSYSTEM_IP_MAX	12
> >>  #define DELAY_MIN_US		2000
> >>  #define DELAY_MAX_US		3000
> >> +#define FIFO_SIZE		4096
> >>  enum amd_pmc_def {
> >>  	MSG_TEST = 0x01,
> >>  	MSG_OS_HINT_PCO,
> >> @@ -126,8 +133,14 @@ struct amd_pmc_dev {
> >>  #endif /* CONFIG_DEBUG_FS */
> >>  };
> >>  
> >> +static bool enable_stb;
> >> +module_param(enable_stb, bool, 0644);
> >> +MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
> >> +
> >>  static struct amd_pmc_dev pmc;
> >>  static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, bool set, u32 *data, u8 msg, bool ret);
> >> +static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
> > shouldn't this be exported as a kernel API to log stuff?  seems like a waist to
> > only log the pmc suspend resume status.
> 
> Agree. But currently there are no drivers *yet* who are consumers of STB
> in the context of APU. PMC is the only driver which is currently taking
> advantage of the STB mechanism which is quite useful in debugging the
> s2idle failures.
> 
> As per STB Spec, not all drivers are allowed to write to the STB buffer.
> 
> > 
> >> +static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
> >>  
> >>  static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
> >>  {
> >> @@ -156,6 +169,51 @@ struct smu_metrics {
> >>  	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
> >>  } __packed;
> >>  
> >> +static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
> >> +{
> >> +	struct amd_pmc_dev *dev = filp->f_inode->i_private;
> >> +	u32 *buf;
> >> +	int rc;
> >> +
> >> +	buf = devm_kmalloc(dev->dev, FIFO_SIZE * 4, GFP_KERNEL);
> > would it be more readable to use sizeof(u32)?
> > 
> >> +	if (!buf)
> >> +		return -ENOMEM;
> >> +
> >> +	rc = amd_pmc_read_stb(dev, buf);
> >> +	if (rc)
> >> +		goto out;
> >> +
> >> +	filp->private_data = buf;
> >> +
> >> +out:
> >> +	return rc;
> >> +}
> >> +
> >> +static ssize_t amd_pmc_stb_debugfs_read(struct file *filp, char __user *buf, size_t size,
> >> +					loff_t *pos)
> >> +{
> >> +	if (!filp->private_data)
> >> +		return -EINVAL;
> >> +
> >> +	return simple_read_from_buffer(buf, size, pos, filp->private_data,
> >> +				       FIFO_SIZE * 4);
> > would it be more readable to use sizeof(u32)?
> >> +}
> >> +
> >> +static int amd_pmc_stb_debugfs_release(struct inode *inode, struct file *filp)
> >> +{
> >> +	kfree(filp->private_data);
> >> +	filp->private_data = NULL;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +const struct file_operations amd_pmc_stb_debugfs_fops = {
> >> +	.owner = THIS_MODULE,
> >> +	.open = amd_pmc_stb_debugfs_open,
> >> +	.read = amd_pmc_stb_debugfs_read,
> >> +	.release = amd_pmc_stb_debugfs_release,
> > are you missing a write fop?  you commit comment talked about a write routine.
> 
> As per the STB spec no userspace should write to STB buffer. Hence we
> took a call not to include ".write" fop. But yes, userland can read the
> buffer any given time.
> 
> Rest of the comments will be addressed in the next revision.
> 
> Thanks,
> Shyam
