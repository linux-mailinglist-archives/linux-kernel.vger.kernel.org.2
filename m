Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026AE339EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 16:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhCMPTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 10:19:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233610AbhCMPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 10:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615648758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/v+ztDAiT2qTMgYbNwh5yVivPeIwGV034KSPfZ3A6A=;
        b=AnceavQdeRemh/j3lfCIgJHuLNulqEWSt/xF1FXjIOJhrDVW7GOtaG+VGWFj376nSja9Y8
        nRuTCamLosbzYbwH+I3e8F/vsd7N6ql2di7YKORjCUP6pDNTcet0NKrBe28NCSzQ4uFopV
        b+v7epjfnIkZ/ZqiSRaNQcbtCSz7MO4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-RkQinh-mNM66pnRKFLAfZg-1; Sat, 13 Mar 2021 10:19:17 -0500
X-MC-Unique: RkQinh-mNM66pnRKFLAfZg-1
Received: by mail-qt1-f197.google.com with SMTP id t5so19809420qti.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 07:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=e/v+ztDAiT2qTMgYbNwh5yVivPeIwGV034KSPfZ3A6A=;
        b=CW/u0FXI7do1LhhNYZJ+APH9Kr5LxBHteQ87KFC26nvOOwGb2nVuZSGRzcXuOuPdEr
         hjsVCs/L1Vj7zBFtbZqhGRrA1qruaghRSed1Qho2PeepdYiGZscgFso2qsefo/z+u4/X
         PIaYLFNTNpNpRcWXXVOtPmUhkxU838/3IswXMtdgNCkHbMflts8fHmwpS/UqnSIiuFzQ
         b2cy+cF3V5SC9Pjv6Toq5H9mSs1XIqaa4sEje7NT2eKF4GEw99tmbmfNBQNFcclzgP1Q
         P/sFQoPG8kqMVgkCLGjT6lCxNZoefBCt1CPYXPxm20lrb2Wv2zPKQ++9+P1Fb51yR0WX
         Ld4A==
X-Gm-Message-State: AOAM532AxoAOxgYzbErzarsWJLc1hDRPNF3S7MwTjJ1TXiJLyiReKBgx
        cG6bVKr4WA2a+0XcEZHAPMWaFEKxCwaShzGRkLA7HxOUrQEKtvRpkg1QdnOONHSm8+I519f+gve
        +QlYDAZ6NT3qPQFa+hmzZHLWU
X-Received: by 2002:a37:7ac3:: with SMTP id v186mr17072001qkc.211.1615648756467;
        Sat, 13 Mar 2021 07:19:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpP+zkeFFmhQSPf0jZeqRpCii6fiE8EmHHt3DeqJOzt/JcJ1FRVJifSNJfLFTivT5HTmp2sA==
X-Received: by 2002:a37:7ac3:: with SMTP id v186mr17071979qkc.211.1615648756220;
        Sat, 13 Mar 2021 07:19:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l12sm1013012qtx.77.2021.03.13.07.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 07:19:15 -0800 (PST)
Subject: Re: [PATCH v10 3/5] fpga: m10bmc-sec: expose max10 canceled keys in
 sysfs
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210312193623.326306-1-russell.h.weight@intel.com>
 <20210312193623.326306-4-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b5c62528-95df-b0e1-12be-e31d963ff548@redhat.com>
Date:   Sat, 13 Mar 2021 07:19:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312193623.326306-4-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/12/21 11:36 AM, Russ Weight wrote:
> Extend the MAX10 BMC Secure Update driver to provide sysfs
> files to expose the canceled code signing key (CSK) bit
> vectors. These use the standard bitmap list format
> (e.g. 1,2-6,9).
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v10:
>   - Changed the path expressions in the sysfs documentation to
>     replace the n3000 reference with something more generic to
>     accomodate other devices that use the same driver.
> v9:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - Previously patch 4/6, otherwise no change
> v7:
>   - Updated Date and KernelVersion in ABI documentation
> v6:
>   - Added WARN_ON() call for (size / stride) to ensure
>     that the proper count is passed to regmap_bulk_read().
> v5:
>   - No change
> v4:
>   - Moved sysfs files for displaying the code-signing-key (CSK)
>     cancellation vectors from the FPGA Security Manger class driver
>     to here. The m10bmc_csk_vector() and m10bmc_csk_cancel_nbits()
>     functions are removed and the functionality from these functions
>     is moved into a show_canceled_csk() function for for displaying
>     the CSK vectors.
>   - Added ABI documentation for new sysfs entries
> v3:
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>     driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions are now called directly.
>   - Renamed get_csk_vector() to m10bmc_csk_vector()
> v2:
>   - Replaced small function-creation macros for explicit function
>     declarations.
>   - Fixed get_csk_vector() function to properly apply the stride
>     variable in calls to m10bmc_raw_bulk_read()
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
> ---
>  .../testing/sysfs-driver-intel-m10-bmc-secure | 24 ++++++++++
>  drivers/fpga/intel-m10-bmc-secure.c           | 48 +++++++++++++++++++
>  2 files changed, 72 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> index 598db1116d34..93ad4de9b941 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> @@ -28,6 +28,30 @@ Description:	Read only. Returns the root entry hash for the BMC image
>  		underlying device supports it.
>  		Format: "0x%x".
>  
> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/sr_canceled_csks

This is fine.

Reviewed-by: Tom Rix <trix@redhat.com>

> +Date:		April 2021
> +KernelVersion:  5.13
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the static region. The standard bitmap
> +		list format is used (e.g. "1,2-6,9").
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/pr_canceled_csks
> +Date:		April 2021
> +KernelVersion:  5.13
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the partial reconfiguration region. The
> +		standard bitmap list format is used (e.g. "1,2-6,9").
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/bmc_canceled_csks
> +Date:		April 2021
> +KernelVersion:  5.13
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the BMC.  The standard bitmap list format
> +		is used (e.g. "1,2-6,9").
> +
>  What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/flash_count
>  Date:		April 2021
>  KernelVersion:  5.13
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index ecd63c13cb2d..87e16c146569 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -79,6 +79,51 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>  
> +#define CSK_BIT_LEN		128U
> +#define CSK_32ARRAY_SIZE	DIV_ROUND_UP(CSK_BIT_LEN, 32)
> +
> +static ssize_t
> +show_canceled_csk(struct device *dev, u32 addr, char *buf)
> +{
> +	unsigned int i, stride, size = CSK_32ARRAY_SIZE * sizeof(u32);
> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> +	DECLARE_BITMAP(csk_map, CSK_BIT_LEN);
> +	__le32 csk_le32[CSK_32ARRAY_SIZE];
> +	u32 csk32[CSK_32ARRAY_SIZE];
> +	int ret;
> +
> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +
> +	WARN_ON(size % stride);
> +	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk_le32,
> +			       size / stride);
> +	if (ret) {
> +		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
> +			addr, size / stride, ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < CSK_32ARRAY_SIZE; i++)
> +		csk32[i] = le32_to_cpu(((csk_le32[i])));
> +
> +	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
> +	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> +	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> +}
> +
> +#define DEVICE_ATTR_SEC_CSK_RO(_name, _addr) \
> +static ssize_t _name##_canceled_csks_show(struct device *dev, \
> +					  struct device_attribute *attr, \
> +					  char *buf) \
> +{ return show_canceled_csk(dev, _addr, buf); } \
> +static DEVICE_ATTR_RO(_name##_canceled_csks)
> +
> +#define CSK_VEC_OFFSET 0x34
> +
> +DEVICE_ATTR_SEC_CSK_RO(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET);
> +DEVICE_ATTR_SEC_CSK_RO(sr, SR_PROG_ADDR + CSK_VEC_OFFSET);
> +DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
> +
>  #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
>  
>  static ssize_t flash_count_show(struct device *dev,
> @@ -119,6 +164,9 @@ static struct attribute *m10bmc_security_attrs[] = {
>  	&dev_attr_bmc_root_entry_hash.attr,
>  	&dev_attr_sr_root_entry_hash.attr,
>  	&dev_attr_pr_root_entry_hash.attr,
> +	&dev_attr_sr_canceled_csks.attr,
> +	&dev_attr_pr_canceled_csks.attr,
> +	&dev_attr_bmc_canceled_csks.attr,
>  	NULL,
>  };
>  

