Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDF637F691
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhEMLRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233287AbhEMLQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:16:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6325C611CA;
        Thu, 13 May 2021 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620904546;
        bh=7HQQIGZ6kdWE+1iDxTMukFID128I7VIccQaqVwQY+Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqET1CVOQKbacH5qKhhXfCwvyanBMDfn7m9UcqG2ULzBboNt3DKmVq3UBUeN7PS4X
         cY8O//QaLk32OZ67Tp///sLo+nNJR7JAo7dciQRWtb82NWel3VeqAgO29J8GcyGucS
         vvkMKZPCVt1py+7eKm3NXsuNVwFVuYGNXZPnZxcw=
Date:   Thu, 13 May 2021 13:15:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v3 02/14] intel_gna: add component of hardware operation
Message-ID: <YJ0KYRuZK3xn0bdO@kroah.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <20210513110040.2268-3-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513110040.2268-3-maciej.kwapulinski@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:00:28PM +0200, Maciej Kwapulinski wrote:
> +void gna_start_scoring(struct gna_private *gna_priv,
> +		       struct gna_compute_cfg *compute_cfg)
> +{
> +	u32 ctrl = gna_reg_read(gna_priv, GNA_MMIO_CTRL);
> +
> +	ctrl |= GNA_CTRL_START_ACCEL | GNA_CTRL_COMP_INT_EN | GNA_CTRL_ERR_INT_EN;
> +
> +	ctrl &= ~GNA_CTRL_COMP_STATS_EN;
> +	ctrl |= FIELD_PREP(GNA_CTRL_COMP_STATS_EN,
> +			compute_cfg->hw_perf_encoding & FIELD_MAX(GNA_CTRL_COMP_STATS_EN));
> +
> +	ctrl &= ~GNA_CTRL_ACTIVE_LIST_EN;
> +	ctrl |= FIELD_PREP(GNA_CTRL_ACTIVE_LIST_EN,
> +			compute_cfg->active_list_on & FIELD_MAX(GNA_CTRL_ACTIVE_LIST_EN));
> +
> +	ctrl &= ~GNA_CTRL_OP_MODE;
> +	ctrl |= FIELD_PREP(GNA_CTRL_OP_MODE,
> +			compute_cfg->gna_mode & FIELD_MAX(GNA_CTRL_OP_MODE));
> +
> +	gna_reg_write(gna_priv, GNA_MMIO_CTRL, ctrl);
> +
> +	dev_dbg(gna_dev(gna_priv), "scoring started...\n");

ftrace is your friend, no need for lines like this.

> +void gna_abort_hw(struct gna_private *gna_priv)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/* saturation bit in the GNA status register needs
> +	 * to be explicitly cleared.
> +	 */
> +	gna_clear_saturation(gna_priv);
> +
> +	val = gna_reg_read(gna_priv, GNA_MMIO_STS);
> +	dev_dbg(gna_dev(gna_priv), "status before abort: %#x\n", val);
> +
> +	val = gna_reg_read(gna_priv, GNA_MMIO_CTRL);
> +	val |= GNA_CTRL_ABORT_CLR_ACCEL;
> +	gna_reg_write(gna_priv, GNA_MMIO_CTRL, val);
> +
> +	ret = readl_poll_timeout(gna_priv->iobase + GNA_MMIO_STS, val,
> +				!(val & 0x1),
> +				0, 1000);
> +
> +	if (ret)
> +		dev_err(gna_dev(gna_priv), "abort did not complete\n");
> +}

If "abort_hw" can fail, then return an error.  What could a user do with
an error message in the kernel log like the above one?  The driver
obviously did not recover from it, so what can they do?

> --- /dev/null
> +++ b/include/uapi/misc/intel/gna.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/* Copyright(c) 2017-2021 Intel Corporation */
> +
> +#ifndef _UAPI_GNA_H_
> +#define _UAPI_GNA_H_
> +
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif

These C++ things should not be needed in kernel uapi header files,
right?

thanks,

greg k-h
