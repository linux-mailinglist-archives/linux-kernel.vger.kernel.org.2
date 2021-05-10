Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8C379513
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhEJRLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232170AbhEJRLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620666620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5a10T/ZaFPtR9BZMJXVz29fUUMM/RHMW9UzZSvPvEnA=;
        b=euasDf1dlZUiLy5dmbApfnarw0d9WWdipIEYHGSUivndmZe0IAeJZf5HPdD5E36c7k1pi9
        uccS9jFDQzz4TcvGufFDG6neQu1ryq+SR9L06+iDbq/DEUuic5m7B6UFvyt5YvhTowHZGz
        AU/BK7NdczWraS1laVbIgQ1c1lDub3c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-TPI_HNDXMpeuFRlo1_wyXw-1; Mon, 10 May 2021 13:10:16 -0400
X-MC-Unique: TPI_HNDXMpeuFRlo1_wyXw-1
Received: by mail-qk1-f200.google.com with SMTP id s123-20020a3777810000b02902e9adec2313so12155773qkc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5a10T/ZaFPtR9BZMJXVz29fUUMM/RHMW9UzZSvPvEnA=;
        b=bRfHlg9jzjePU/kts2t+DnBnyL/1tesZ0I2BcpNSmBYCPL4bXgNLU0fTphpj/mJr0A
         xXR1kjCC4065ZtNa/0R+g6pvnnpMPtCk62iVYr5CWwpxb94vzwqyNVgrbznQ92vImipM
         CumLnx9ZYHBi3A6YrTjYNetm+VOckq7+DLFELRgdXAT/jPBAYvg/g+z96V6SSsdoPHQf
         OL22mJzOazBizIZtB5DwNN36MzAQ0phXb/CMKOB35Yijq9BSUW9ndMhhNnFYwWpMQX4e
         Qbl4fri1usEOsbvn3kKATGs/YSY6hlyttVvdqh4eHWYz2MNpETVgNrTN3aFFFQzrIpzP
         Fqtg==
X-Gm-Message-State: AOAM532pct1n56me3poOVShvr4xXYhqj5YN2I01V1fq3it5UMPIfehM0
        GNZXLp6dz/pFWr1PsMpP9/2iVL2i9NRoxGJiTbddaGPpTF5rcf1As6yWs6BJMT563gvg/E6rj7V
        HvrIog/fjZ9kAZUVMP1jwiFAI
X-Received: by 2002:a05:622a:44:: with SMTP id y4mr317799qtw.258.1620666615853;
        Mon, 10 May 2021 10:10:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHTQ8cRfSaixYdfJ6l8K+i1DJrpfBFTlFrPntL4EejkU1cFSvkOTqNXyJgIA0A5f7exUARsw==
X-Received: by 2002:a05:622a:44:: with SMTP id y4mr317769qtw.258.1620666615619;
        Mon, 10 May 2021 10:10:15 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z4sm11877972qtv.7.2021.05.10.10.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 10:10:15 -0700 (PDT)
Subject: Re: [PATCH v12 4/5] fpga: m10bmc-sec: add max10 secure update
 functions
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210503214042.316836-1-russell.h.weight@intel.com>
 <20210503214042.316836-5-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8a69d0c7-f439-84df-9217-13635d4635d0@redhat.com>
Date:   Mon, 10 May 2021 10:10:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503214042.316836-5-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/3/21 2:40 PM, Russ Weight wrote:
> Extend the MAX10 BMC Secure Update driver to include
> the functions that enable secure updates of BMC images,
> FPGA images, etc.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v12:
>    - Updated Date and KernelVersion fields in ABI documentation
>    - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
>      no longer has a size parameter, and the block size is determined
>      in this (the lower-level) driver.
> v11:
>    - No change
> v10:
>    - No change
> v9:
>    - No change
> v8:
>    - Previously patch 5/6, otherwise no change
> v7:
>    - No change
> v6:
>    - Changed (size / stride) calculation to ((size + stride - 1) / stride)
>      to ensure that the proper count is passed to regmap_bulk_write().
>    - Removed unnecessary call to rsu_check_complete() in
>      m10bmc_sec_poll_complete() and changed while loop to
>      do/while loop.
> v5:
>    - No change
> v4:
>    - No change
> v3:
>    - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>    - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>      driver"
>    - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>      underlying functions are now called directly.
>    - Changed calling functions of functions that return "enum fpga_sec_err"
>      to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
> v2:
>    - Reworked the rsu_start_done() function to make it more readable
>    - Reworked while-loop condition/content in rsu_prog_ready()
>    - Minor code cleanup per review comments
>    - Added a comment to the m10bmc_sec_poll_complete() function to
>      explain the context (could take 30+ minutes to complete).
>    - Added m10bmc_ prefix to functions in m10bmc_iops structure
>    - Moved MAX10 BMC address and function definitions to a separate
>      patch.
> ---
>   drivers/fpga/intel-m10-bmc-secure.c | 310 +++++++++++++++++++++++++++-
>   1 file changed, 309 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 87e16c146569..9d45312001a3 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -180,7 +180,315 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>   	NULL,
>   };
>   
> -static const struct fpga_sec_mgr_ops m10bmc_sops = { };
> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
> +{
> +	u32 auth_result;
> +
> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
> +
> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
> +}
> +
> +static enum fpga_sec_err rsu_check_idle(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return FPGA_SEC_ERR_RW_ERROR;
> +
> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_BUSY;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
> +}
> +
> +static inline bool rsu_start_done(u32 doorbell)
> +{
> +	u32 status, progress;
> +
> +	if (doorbell & DRBL_RSU_REQUEST)
> +		return false;
> +
> +	status = rsu_stat(doorbell);
> +	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
> +		return true;
> +
> +	progress = rsu_prog(doorbell);
> +	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
> +		return true;
> +
> +	return false;
> +}
> +
> +static enum fpga_sec_err rsu_update_init(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell, status;
> +	int ret;
> +
> +	ret = regmap_update_bits(sec->m10bmc->regmap,
> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
> +				 DRBL_RSU_REQUEST |
> +				 FIELD_PREP(DRBL_HOST_STATUS,
> +					    HOST_STATUS_IDLE));
> +	if (ret)
> +		return FPGA_SEC_ERR_RW_ERROR;
> +
> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				       doorbell,
> +				       rsu_start_done(doorbell),
> +				       NIOS_HANDSHAKE_INTERVAL_US,
> +				       NIOS_HANDSHAKE_TIMEOUT_US);
> +
> +	if (ret == -ETIMEDOUT) {
> +		log_error_regs(sec, doorbell);

A general issue.

Would logging the error be better for all the error cases ?

> +		return FPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret) {
> +		return FPGA_SEC_ERR_RW_ERROR;
> +	}
> +
> +	status = rsu_stat(doorbell);
> +	if (status == RSU_STAT_WEAROUT) {
> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
> +		return FPGA_SEC_ERR_WEAROUT;
> +	} else if (status == RSU_STAT_ERASE_FAIL) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
> +}
> +
> +static enum fpga_sec_err rsu_prog_ready(struct m10bmc_sec *sec)
> +{
> +	unsigned long poll_timeout;
> +	u32 doorbell, progress;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return FPGA_SEC_ERR_RW_ERROR;
> +
> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
> +		msleep(RSU_PREP_INTERVAL_MS);
> +		if (time_after(jiffies, poll_timeout))
> +			break;

It is possible to sleep past when the doorbell state changes.

If you moved this timeout check to the bottom of the loop, this case 
would be better covered.

> +
> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +		if (ret)
> +			return FPGA_SEC_ERR_RW_ERROR;
> +	}
> +
> +	progress = rsu_prog(doorbell);
> +	if (progress == RSU_PROG_PREPARE) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_TIMEOUT;
> +	} else if (progress != RSU_PROG_READY) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
> +}
> +
> +static enum fpga_sec_err rsu_send_data(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = regmap_update_bits(sec->m10bmc->regmap,
> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				 DRBL_HOST_STATUS,
> +				 FIELD_PREP(DRBL_HOST_STATUS,
> +					    HOST_STATUS_WRITE_DONE));
> +	if (ret)
> +		return FPGA_SEC_ERR_RW_ERROR;
> +
> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				       doorbell,
> +				       rsu_prog(doorbell) != RSU_PROG_READY,
> +				       NIOS_HANDSHAKE_INTERVAL_US,
> +				       NIOS_HANDSHAKE_TIMEOUT_US);
> +
> +	if (ret == -ETIMEDOUT) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret) {
> +		return FPGA_SEC_ERR_RW_ERROR;
> +	}
> +
> +	switch (rsu_stat(doorbell)) {
> +	case RSU_STAT_NORMAL:
> +	case RSU_STAT_NIOS_OK:
> +	case RSU_STAT_USER_OK:
> +	case RSU_STAT_FACTORY_OK:
> +		break;
> +	default:
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
> +}
> +
> +static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
> +{
> +	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
> +		return -EIO;
> +
> +	switch (rsu_stat(*doorbell)) {
> +	case RSU_STAT_NORMAL:
> +	case RSU_STAT_NIOS_OK:
> +	case RSU_STAT_USER_OK:
> +	case RSU_STAT_FACTORY_OK:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (rsu_prog(*doorbell)) {
> +	case RSU_PROG_IDLE:
> +	case RSU_PROG_RSU_DONE:
> +		return 0;
> +	case RSU_PROG_AUTHENTICATING:
> +	case RSU_PROG_COPYING:
> +	case RSU_PROG_UPDATE_CANCEL:
> +	case RSU_PROG_PROGRAM_KEY_HASH:
> +		return -EAGAIN;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum fpga_sec_err m10bmc_sec_prepare(struct fpga_sec_mgr *smgr)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	enum fpga_sec_err ret;
> +
> +	if (smgr->remaining_size > M10BMC_STAGING_SIZE)
> +		return FPGA_SEC_ERR_INVALID_SIZE;
> +
> +	ret = rsu_check_idle(sec);
> +	if (ret != FPGA_SEC_ERR_NONE)
> +		return ret;
> +
> +	ret = rsu_update_init(sec);
> +	if (ret != FPGA_SEC_ERR_NONE)
> +		return ret;
> +
> +	return rsu_prog_ready(sec);
> +}
> +
> +#define WRITE_BLOCK_SIZE 0x4000 /* Update remaining_size every 0x4000 bytes */
> +
> +static enum fpga_sec_err
> +m10bmc_sec_write_blk(struct fpga_sec_mgr *smgr, u32 offset)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	u32 doorbell, blk_size;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret) {
> +		return FPGA_SEC_ERR_RW_ERROR;
> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	blk_size = min_t(u32, smgr->remaining_size, WRITE_BLOCK_SIZE);
> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
> +				M10BMC_STAGING_BASE + offset,
> +				(void *)smgr->data + offset,
> +				(blk_size + stride - 1) / stride);
> +
> +	if (ret)
> +		return FPGA_SEC_ERR_RW_ERROR;
> +
> +	smgr->remaining_size -= blk_size;
> +	return FPGA_SEC_ERR_NONE;
> +}
> +
> +/*
> + * m10bmc_sec_poll_complete() is called after handing things off to
> + * the BMC firmware. Depending on the type of update, it could be
> + * 30+ minutes before the BMC firmware completes the update. The
> + * smgr->driver_unload check allows the driver to be unloaded,
> + * but the BMC firmware will continue the update and no further
> + * secure updates can be started for this device until the update
> + * is complete.
> + */
> +static enum fpga_sec_err m10bmc_sec_poll_complete(struct fpga_sec_mgr *smgr)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	unsigned long poll_timeout;
> +	enum fpga_sec_err result;
> +	u32 doorbell;
> +	int ret;
> +
> +	result = rsu_send_data(sec);
> +	if (result != FPGA_SEC_ERR_NONE)
> +		return result;
> +
> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
> +	do {
> +		msleep(RSU_COMPLETE_INTERVAL_MS);
> +		ret = rsu_check_complete(sec, &doorbell);
> +		if (smgr->driver_unload)
> +			return FPGA_SEC_ERR_CANCELED;
> +	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
> +
> +	if (ret == -EAGAIN) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret == -EIO) {
> +		return FPGA_SEC_ERR_RW_ERROR;
> +	} else if (ret) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
> +}
> +
> +static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return FPGA_SEC_ERR_RW_ERROR;
> +
> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
> +		return FPGA_SEC_ERR_BUSY;
> +
> +	ret = regmap_update_bits(sec->m10bmc->regmap,
> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				 DRBL_HOST_STATUS,
> +				 FIELD_PREP(DRBL_HOST_STATUS,
> +					    HOST_STATUS_ABORT_RSU));
> +
> +	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;

I do not like tristate in return statements.

Can you change this to something like

if (ret)

   return FPGA_SEC_ERR_RW_ERROR

return FPGA_SEC_ERR_NONE

Tom

> +}
> +
> +static const struct fpga_sec_mgr_ops m10bmc_sops = {
> +	.prepare = m10bmc_sec_prepare,
> +	.write_blk = m10bmc_sec_write_blk,
> +	.poll_complete = m10bmc_sec_poll_complete,
> +	.cancel = m10bmc_sec_cancel,
> +};
>   
>   static int m10bmc_secure_probe(struct platform_device *pdev)
>   {

