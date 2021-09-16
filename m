Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3140DB38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbhIPNbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240139AbhIPNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631798991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B45Nb5b2pHBXTP1aK55Tj11ZLio8hUXD9cZZE+FyXvI=;
        b=L2JzvtVYzhXSqtnb0GyEAL69TbuQ6V9iwTEcaT4ET7zA/GMXltO6Aj2T0lXiSGp3f1J0oS
        1zsKe9JI8CTb0Qo4AKcrzSz8PM1qVux0D1TycSVZY/8cx6IgWCc5mcd4PNEDNbv2o/5IQL
        AJcHKJpFsxT78EO/zFF66Yw2oJrZoUk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-a5InQ4sVNluspDx5QOr-KQ-1; Thu, 16 Sep 2021 09:29:50 -0400
X-MC-Unique: a5InQ4sVNluspDx5QOr-KQ-1
Received: by mail-ed1-f71.google.com with SMTP id h24-20020a50cdd8000000b003d8005fe2f8so1339428edj.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B45Nb5b2pHBXTP1aK55Tj11ZLio8hUXD9cZZE+FyXvI=;
        b=oCNQBlOTnVbGC/IPi/T9SixP2aaE5TamxqqcOsACvM/5k5Q3c/xlda57m7OmR6rl2D
         c3s7mS/Xv1rS5+gUQNukNof1j1hAohbIwFpFdVQrS+wuE+YT0uoC300ACEqh/4ax8qxo
         WNio0rbs16AUyAgewW97TLtyxzTRog4HxCy6mWTHcIaZW7003pKTQ4J1A07hDaImQrLj
         BDowO5We55p6yf9zFQ66S8c6mJP6LZmdu/fqhrSVVJVDFkpLDkRuYD3PWFPUQZEOKjTr
         CdluFDC+lhVGxODyHECWdAA/QqqKh0NIAT1fIcAvDG9PwdTkDxuMLymWlPXmsQ+2KXEu
         vCbg==
X-Gm-Message-State: AOAM5323S3z4ctN2I8FsYIAF6trZSXpd1HeBnUTzKYCw+h+UpKSuTl/N
        dmPcdAHFYtS6qr45JEDKKe8WdY0IF6/eg+8lFbefBXcKG+wowno3whmiQ8eJveT/UhBBe0lbk5k
        abR8svajW8a11jnVBoivf8LGljkPZAGyBgKdNHadtnPLfd6QrfhKCD/v2OZPZ1ecazYpZ1pbyUM
        9Q
X-Received: by 2002:a05:6402:198:: with SMTP id r24mr6536646edv.93.1631798989009;
        Thu, 16 Sep 2021 06:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVk4Ac7JAJT42Y2nqfTaSvHFwNJaZTXT9GdyNDwz9TorLyX3pKvN/laAJgsJrMFCxiYt2WOQ==
X-Received: by 2002:a05:6402:198:: with SMTP id r24mr6536616edv.93.1631798988753;
        Thu, 16 Sep 2021 06:29:48 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id j2sm1440660edt.0.2021.09.16.06.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:29:48 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: amd-pmc: Export Idlemask values based on
 the APU
To:     Sanket Goswami <Sanket.Goswami@amd.com>, Shyam-sundar.S-k@amd.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210916124002.2529-1-Sanket.Goswami@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <652baa5c-cb1d-ddd6-c87a-c4a5d91c0217@redhat.com>
Date:   Thu, 16 Sep 2021 15:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916124002.2529-1-Sanket.Goswami@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/21 2:40 PM, Sanket Goswami wrote:
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

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my


local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

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

