Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9829545A6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhKWP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhKWP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:59:18 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BCCC061574;
        Tue, 23 Nov 2021 07:56:10 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso3756902otf.0;
        Tue, 23 Nov 2021 07:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=d7UN/gtMFD0+CfntgagBDCU3OFGLUJ14fJxOZRpFpSs=;
        b=jBTtlGU7wUCAayGuVcs+MGhonZwixiA3mxfhySHHgJi/8js6jxNFutgeP6ZeDFy6eo
         bRueqSE3q+ttWrdA38y5gt5cpRs8Cg8Iu+M6brzgIFtpgDKUVBS7EINqqEOluy4uNYaJ
         WipHeonFnSQKbMcReO55R/3Zc3BGfjy6Hg8xUl2iyvegzRBwrYGXr5INsmMAl/YXYyVE
         yZTPbTOvNIfNrJZBKsRwacNVDCI24aje4MfbTFZ16zD8A/ALpa2txk5sUScm11yKyg5G
         Yti0eh4bHUNgWczNpkAj9WUIputVNJ677alE28Mhq/vg7JyIQcJBZT2NzvBVTVWwVeeo
         q07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=d7UN/gtMFD0+CfntgagBDCU3OFGLUJ14fJxOZRpFpSs=;
        b=L0GCv+HgZ6OLr0kxTWlfTahm3Lwj2Qzxx2pAS10EMVXLYUGwKnEpRxuNMmuvIyIRoT
         m+PxU1w0c0tpL+kMCh3i/MberNkHb30CtgtCJVdHPUikEulAnE/ql/04pDoMsMyUCy6J
         awWS+D80beHUbJ8/nPTrZSyqD4secbIOng4uOhtCG/Ot9OyX5BOQRgTpulM2n8TbmnSV
         A+9yvv7I9PACdsZ218EHJFvKgmudJLz8xd2wL74gE8nbToFug+M2RGwMhw0vgJfrlFnA
         E5Ln32RdHooUYZ19ublT8M+MJIC6QOuB2jy9yr50c4wFtK+2qFFAli/UQjOzWqtFK4MH
         8BOA==
X-Gm-Message-State: AOAM5309t3KneY/QGrv4qkUQIQ0Xvl9b++wEV0qeLLwXfwQdxwKrSK1z
        lDJKWLgWoZ3wtKqxs9PwJUM=
X-Google-Smtp-Source: ABdhPJzHGnMWkUtLsG4O+tAtmQGUp8qFfdDduM22WfEJrNkViM5QUIW5SQvrPEoueCL+oyG1ETpS8g==
X-Received: by 2002:a9d:749a:: with SMTP id t26mr5694122otk.96.1637682970071;
        Tue, 23 Nov 2021 07:56:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k4sm2558888oij.54.2021.11.23.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:56:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 Nov 2021 07:56:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH v4 11/13] hwmon: peci: Add dimmtemp driver
Message-ID: <20211123155608.GA2258206@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 03:07:04PM +0100, Iwona Winiarska wrote:
> Add peci-dimmtemp driver for Temperature Sensor on DIMM readings that
> are accessible via the processor PECI interface.
> 
> The main use case for the driver (and PECI interface) is out-of-band
> management, where we're able to obtain thermal readings from an external
> entity connected with PECI, e.g. BMC on server platforms.
> 
> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---

[ ... ]

> +static int check_populated_dimms(struct peci_dimmtemp *priv)
> +{
> +	int chan_rank_max = priv->gen_info->chan_rank_max;
> +	int dimm_idx_max = priv->gen_info->dimm_idx_max;
> +	u32 chan_rank_empty = 0;
> +	u64 dimm_mask = 0;
> +	int chan_rank, dimm_idx, ret;
> +	u32 pcs;
> +
> +	BUILD_BUG_ON(BITS_PER_TYPE(chan_rank_empty) < CHAN_RANK_MAX);
> +	BUILD_BUG_ON(BITS_PER_TYPE(dimm_mask) < DIMM_NUMS_MAX);
> +	if (chan_rank_max * dimm_idx_max > DIMM_NUMS_MAX) {
> +		WARN_ONCE(1, "Unsupported number of DIMMs - chan_rank_max: %d, dimm_idx_max: %d",
> +			  chan_rank_max, dimm_idx_max);
> +		return -EINVAL;
> +	}
> +
> +	for (chan_rank = 0; chan_rank < chan_rank_max; chan_rank++) {
> +		ret = peci_pcs_read(priv->peci_dev, PECI_PCS_DDR_DIMM_TEMP, chan_rank, &pcs);
> +		if (ret) {
> +			/*
> +			 * Overall, we expect either success or -EINVAL in
> +			 * order to determine whether DIMM is populated or not.
> +			 * For anything else we fall back to deferring the
> +			 * detection to be performed at a later point in time.
> +			 */
> +			if (ret == -EINVAL) {
> +				chan_rank_empty |= BIT(chan_rank);
> +				continue;
> +			}
> +
> +			return -EAGAIN;
> +		}
> +
> +		for (dimm_idx = 0; dimm_idx < dimm_idx_max; dimm_idx++)
> +			if (__dimm_temp(pcs, dimm_idx))
> +				dimm_mask |= BIT(chan_rank * dimm_idx_max + dimm_idx);
> +	}
> +
> +	/*
> +	 * If we got all -EINVALs, it means that the CPU doesn't have any
> +	 * DIMMs. Unfortunately, it may also happen at the very start of
> +	 * host platform boot. Retrying a couple of times lets us make sure
> +	 * that the state is persistent.
> +	 */
> +	if (chan_rank_empty == GENMASK(chan_rank_max - 1, 0)) {
> +		if (priv->no_dimm_retry_count < NO_DIMM_RETRY_COUNT_MAX) {
> +			priv->no_dimm_retry_count++;
> +
> +			return -EAGAIN;
> +		} else {
> +			return -ENODEV;
> +		}

Static analyzers will complain "else after return is unnecessary".

Guenter
