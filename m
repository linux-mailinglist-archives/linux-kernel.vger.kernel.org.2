Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5983B3462DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhCWP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhCWP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:28:38 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD73C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:28:37 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id k25so17376393oic.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=01Q0ruAgwKc8bAW5HMlMo1t4e9rGUfQVWgyknJBWak4=;
        b=ndyIP0EF5slZHT/EPhtD9l29v93CuNkMZVCq1YivvRM6ECxcEP1W6Qc9nLpIDquJTq
         lzlGq78DbYGyEDaaRW6xAXVhSxZK5gdoDxBuMJ3oSO2c0e82uvuMiNwklJCb/6IZuKhC
         Pn+yUT4/oQ8e2Rqr84cn639o6cOXkpuy0dvI09YAAZVM+dLQNVnfphn1gRH4zY6muTkG
         YsC6/HoH4p1RiPeGgE2XDbEwZ7F4j+FzCPy9209PqxZmW6h/UVcHL7Z03fV/6UO7Q5vt
         ScnbP351X1ng5WKdWKsLs2sQg3ufQi83/o+80NqweNBlX2TZqVkH2moXLdUDSc4C2NmG
         +qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=01Q0ruAgwKc8bAW5HMlMo1t4e9rGUfQVWgyknJBWak4=;
        b=b8JTa1FtWXdt+9siT5UHIEkiCh/RJS0AReg5VwpuoZulhQZxfuxe+ftM8Nq40yItzJ
         Bb1GWkJiqFk+c05KYpderst1H/goeiREy3eKiEBEM+jfU31iCnTjjsi1AQMVS+fNUcPm
         4QP/hwWFbg4hIpDlfudTxH2NJPS3WFTbLLfwneovqpnkX/sbtIGWE88t52D8VZLK9SIL
         1Kx2J39fK2iowhb4XeWZtThvBB2LXWBytfGQOr5/ADxmQz6m1PlQcv8Mb9LCGdDueUhs
         oHLeIZt1pE27jpNZ4kvxSMUCFPdKiNkHTs7O/Zocd+LyrBgfP9qt3HxlDoSMAGB80Udc
         a+ng==
X-Gm-Message-State: AOAM532sOaXeJlXwz9VaETFXFG7hQX0ch3Fku8fzrKiVkU/2Q8Mj56ff
        wmB4JIPxyLfxToS0/QsS4H5Ei6Vc2qKKtg==
X-Google-Smtp-Source: ABdhPJyPSuUhTF8WRdKSbqhk3M1FQHZsj6X0tA6ZudKa6D1aTxYFFjqClxhvKGJfXUEDmJmK3wCLKQ==
X-Received: by 2002:aca:4dd3:: with SMTP id a202mr3736583oib.13.1616513317083;
        Tue, 23 Mar 2021 08:28:37 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h12sm814409ote.75.2021.03.23.08.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:28:36 -0700 (PDT)
Date:   Tue, 23 Mar 2021 10:28:34 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nitin Rawat <nitirawa@codeaurora.org>
Cc:     asutoshd@codeaurora.org, cang@codeaurora.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, adrian.hunter@intel.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] scsi: ufs-qcom: configure VCC voltage level in
 vendor file
Message-ID: <20210323152834.GH5254@yoga>
References: <1616363857-26760-1-git-send-email-nitirawa@codeaurora.org>
 <1616363857-26760-4-git-send-email-nitirawa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616363857-26760-4-git-send-email-nitirawa@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 21 Mar 16:57 CDT 2021, Nitin Rawat wrote:

> As a part of vops handler, VCC voltage is updated
> as per the ufs device probed after reading the device
> descriptor. We follow below steps to configure voltage
> level.
> 
> 1. Set the device to SLEEP state.
> 2. Disable the Vcc Regulator.
> 3. Set the vcc voltage according to the device type and reenable
>    the regulator.
> 4. Set the device mode back to ACTIVE.
> 

When we discussed this a while back this was described as a requirement
from the device specification, you only operate on objects "owned" by
ufshcd and you invoke ufshcd operations to perform the actions.

So why is this a ufs-qcom patch and not something in ufshcd?

Regards,
Bjorn

> Signed-off-by: Nitin Rawat <nitirawa@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufs-qcom.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index f97d7b0..ca35f5c 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -21,6 +21,17 @@
>  #define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
>  	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
> 
> +#define	ANDROID_BOOT_DEV_MAX	30
> +static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
> +
> +/* Min and Max VCC voltage values for ufs 2.x and
> + * ufs 3.x devices
> + */
> +#define UFS_3X_VREG_VCC_MIN_UV	2540000 /* uV */
> +#define UFS_3X_VREG_VCC_MAX_UV	2700000 /* uV */
> +#define UFS_2X_VREG_VCC_MIN_UV	2950000 /* uV */
> +#define UFS_2X_VREG_VCC_MAX_UV	2960000 /* uV */
> +
>  enum {
>  	TSTBUS_UAWM,
>  	TSTBUS_UARM,
> @@ -1293,6 +1304,45 @@ static void ufs_qcom_print_hw_debug_reg_all(struct ufs_hba *hba,
>  	print_fn(hba, reg, 9, "UFS_DBG_RD_REG_TMRLUT ", priv);
>  }
> 
> +  /**
> +   * ufs_qcom_setup_vcc_regulators - Update VCC voltage
> +   * @hba: host controller instance
> +   * Update VCC voltage based on UFS device(ufs 2.x or
> +   * ufs 3.x probed)
> +   */
> +static int ufs_qcom_setup_vcc_regulators(struct ufs_hba *hba)
> +{
> +	struct ufs_dev_info *dev_info = &hba->dev_info;
> +	struct ufs_vreg *vreg = hba->vreg_info.vcc;
> +	int ret;
> +
> +	/* Put the device in sleep before lowering VCC level */
> +	ret = ufshcd_set_dev_pwr_mode(hba, UFS_SLEEP_PWR_MODE);
> +
> +	/* Switch off VCC before switching it ON at 2.5v or 2.96v */
> +	ret = ufshcd_disable_vreg(hba->dev, vreg);
> +
> +	/* add ~2ms delay before renabling VCC at lower voltage */
> +	usleep_range(2000, 2100);
> +
> +	/* set VCC min and max voltage according to ufs device type */
> +	if (dev_info->wspecversion >= 0x300) {
> +		vreg->min_uV = UFS_3X_VREG_VCC_MIN_UV;
> +		vreg->max_uV = UFS_3X_VREG_VCC_MAX_UV;
> +	}
> +
> +	else {
> +		vreg->min_uV = UFS_2X_VREG_VCC_MIN_UV;
> +		vreg->max_uV = UFS_2X_VREG_VCC_MAX_UV;
> +	}
> +
> +	ret = ufshcd_enable_vreg(hba->dev, vreg);
> +
> +	/* Bring the device in active now */
> +	ret = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
> +	return ret;
> +}
> +
>  static void ufs_qcom_enable_test_bus(struct ufs_qcom_host *host)
>  {
>  	if (host->dbg_print_en & UFS_QCOM_DBG_PRINT_TEST_BUS_EN) {
> @@ -1490,6 +1540,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
>  	.device_reset		= ufs_qcom_device_reset,
>  	.config_scaling_param = ufs_qcom_config_scaling_param,
>  	.program_key		= ufs_qcom_ice_program_key,
> +	.setup_vcc_regulators	= ufs_qcom_setup_vcc_regulators,
>  };
> 
>  /**
> --
> 2.7.4
> 
