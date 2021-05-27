Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339CC3936D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhE0UKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235508AbhE0UKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DhMCEoC71DeYcLFzap4I0+HN6X7eTgKuNl1UamyyAJQ=;
        b=HTjGfuV3kF9csqOe0km2/YDte2askZRrbs8yQ2jH96jHt3gw3F2liZDHFWrs3BpmRZzexZ
        ZAtu7oLxdqroEmm+4Ixl0S//slpHcjDDbtZvuFGSq5QdsCdhSPF2BtekQ/klUQxS3kjiOj
        QDqWKAlP7i3Q1sxA/x97QJy6jPc5oS4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-1MCkriwiMOCDqdyrL_gPAw-1; Thu, 27 May 2021 16:09:04 -0400
X-MC-Unique: 1MCkriwiMOCDqdyrL_gPAw-1
Received: by mail-ot1-f70.google.com with SMTP id m6-20020a0568301e66b0290319b27baf50so657522otr.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhMCEoC71DeYcLFzap4I0+HN6X7eTgKuNl1UamyyAJQ=;
        b=LtN/tXBgIDgZ4YSuxWjhoAVS4dzKIiPod2tQy4MwlOYtGBslpmvMZrsGumKZxzLlO1
         tlLH3wwS+WNzPMDqvEAgoBLrLC7MIXRvZlhbj22Y7JsEl5VYC7sEyUstb5fCp7Gh1D0c
         vKHxyW6KXo4GBKN+ngzKytCgYRjo31cPZX65B6QjU8PG33431J0gT5vtdwkV99NXkjGb
         iJdEuQp7h+shyosPaJZre+xuhNuBlcQlhU2ATYz4XQWnVx7fJdCXtlpcJk1qWRON4Rek
         KUUtfAsWHwJCBpaUvmVJYiiEQHNpXAObsQJYrJYBQfnxVN1EdvNruZ6xQps98RSOSrob
         gs8w==
X-Gm-Message-State: AOAM533MKR27IjU5kz/zQAlqJJIPTDczW1B6Nzy7syGUlnVbm+k/Qs6h
        wONPduuTlLj6Nhj1bBzZs9YfHj2jRWqMt0uLBy0dkWXvKALIrllmh0Uq2NMYrAn/NqZAFP3MGV6
        FWwhdqNdg4CWJCOWdx8GAIr6n
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr4090548otq.303.1622146143238;
        Thu, 27 May 2021 13:09:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCkp4fHhNtfLrCKbdxUvriNHcn1UCGVTm1I6709kKfxlzFS68SW5CuZArK4ihyde9rOSg4vg==
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr4090517otq.303.1622146142935;
        Thu, 27 May 2021 13:09:02 -0700 (PDT)
Received: from localhost (cpe-70-95-20-182.san.res.rr.com. [70.95.20.182])
        by smtp.gmail.com with ESMTPSA id s85sm635380oos.4.2021.05.27.13.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:09:02 -0700 (PDT)
Date:   Thu, 27 May 2021 13:09:00 -0700
From:   Fernando Pacheco <fpacheco@redhat.com>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fpga: fix spelling mistakes
Message-ID: <20210527200900.GA875457@mail.gmail.com>
References: <20210519163056.1966690-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519163056.1966690-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:30:56AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Run the fpga subsystem through aspell.

Reviewed-by: Fernando Pacheco <fpacheco@redhat.com>

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  Documentation/fpga/dfl.rst    | 4 ++--
>  drivers/fpga/altera-cvp.c     | 2 +-
>  drivers/fpga/dfl-fme-pr.c     | 2 +-
>  drivers/fpga/dfl-n3000-nios.c | 2 +-
>  drivers/fpga/dfl.h            | 2 +-
>  drivers/fpga/fpga-bridge.c    | 4 ++--
>  drivers/fpga/zynq-fpga.c      | 6 +++---
>  include/linux/fpga/fpga-mgr.h | 2 +-
>  8 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index f3a1223f2517e..ccc33f199df2a 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -10,7 +10,7 @@ Authors:
>  - Xu Yilun <yilun.xu@intel.com>
>  
>  The Device Feature List (DFL) FPGA framework (and drivers according to
> -this framework) hides the very details of low layer hardwares and provides
> +this framework) hides the very details of low layer hardware and provides
>  unified interfaces to userspace. Applications could use these interfaces to
>  configure, enumerate, open and access FPGA accelerators on platforms which
>  implement the DFL in the device memory. Besides this, the DFL framework
> @@ -205,7 +205,7 @@ given Device Feature Lists and create platform devices for feature devices
>  also abstracts operations for the private features and exposes common ops to
>  feature device drivers.
>  
> -The FPGA DFL Device could be different hardwares, e.g. PCIe device, platform
> +The FPGA DFL Device could be different hardware, e.g. PCIe device, platform
>  device and etc. Its driver module is always loaded first once the device is
>  created by the system. This driver plays an infrastructural role in the
>  driver architecture. It locates the DFLs in the device memory, handles them
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4e0edb60bfba6..ccf4546eff297 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -346,7 +346,7 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	}
>  
>  	if (val & VSE_CVP_STATUS_CFG_RDY) {
> -		dev_warn(&mgr->dev, "CvP already started, teardown first\n");
> +		dev_warn(&mgr->dev, "CvP already started, tear down first\n");
>  		ret = altera_cvp_teardown(mgr, info);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index 1194c0e850e07..d61ce9a188792 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -148,7 +148,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  
>  	/*
>  	 * it allows userspace to reset the PR region's logic by disabling and
> -	 * reenabling the bridge to clear things out between accleration runs.
> +	 * reenabling the bridge to clear things out between acceleration runs.
>  	 * so no need to hold the bridges after partial reconfiguration.
>  	 */
>  	if (region->get_bridges)
> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
> index 7a95366f6516f..9ddf1d1d392f3 100644
> --- a/drivers/fpga/dfl-n3000-nios.c
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -461,7 +461,7 @@ static int n3000_nios_poll_stat_timeout(void __iomem *base, u64 *v)
>  	 * We don't use the time based timeout here for performance.
>  	 *
>  	 * The regbus read/write is on the critical path of Intel PAC N3000
> -	 * image programing. The time based timeout checking will add too much
> +	 * image programming. The time based timeout checking will add too much
>  	 * overhead on it. Usually the state changes in 1 or 2 loops on the
>  	 * test server, and we set 10000 times loop here for safety.
>  	 */
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2b82c96ba56c7..dac9c3d45e6c3 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -232,7 +232,7 @@ struct dfl_feature_irq_ctx {
>   * @id: sub feature id.
>   * @resource_index: each sub feature has one mmio resource for its registers.
>   *		    this index is used to find its mmio resource from the
> - *		    feature dev (platform device)'s reources.
> + *		    feature dev (platform device)'s resources.
>   * @ioaddr: mapped mmio resource address.
>   * @irq_ctx: interrupt context list.
>   * @nr_irqs: number of interrupt contexts.
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 6510c7803a784..d31eec32eb426 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -230,7 +230,7 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
>   *
>   * Get an exclusive reference to the bridge and and it to the list.
>   *
> - * Return 0 for success, error code from of_fpga_bridge_get() othewise.
> + * Return 0 for success, error code from of_fpga_bridge_get() otherwise.
>   */
>  int of_fpga_bridge_get_to_list(struct device_node *np,
>  			       struct fpga_image_info *info,
> @@ -260,7 +260,7 @@ EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
>   *
>   * Get an exclusive reference to the bridge and and it to the list.
>   *
> - * Return 0 for success, error code from fpga_bridge_get() othewise.
> + * Return 0 for success, error code from fpga_bridge_get() otherwise.
>   */
>  int fpga_bridge_get_to_list(struct device *dev,
>  			    struct fpga_image_info *info,
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 07fa8d9ec6750..9b75bd4f93d8e 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -192,7 +192,7 @@ static void zynq_step_dma(struct zynq_fpga_priv *priv)
>  
>  	/* Once the first transfer is queued we can turn on the ISR, future
>  	 * calls to zynq_step_dma will happen from the ISR context. The
> -	 * dma_lock spinlock guarentees this handover is done coherently, the
> +	 * dma_lock spinlock guarantees this handover is done coherently, the
>  	 * ISR enable is put at the end to avoid another CPU spinning in the
>  	 * ISR on this lock.
>  	 */
> @@ -267,7 +267,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  		ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
>  		if (!(ctrl & CTRL_SEC_EN_MASK)) {
>  			dev_err(&mgr->dev,
> -				"System not secure, can't use crypted bitstreams\n");
> +				"System not secure, can't use encrypted bitstreams\n");
>  			err = -EINVAL;
>  			goto out_err;
>  		}
> @@ -344,7 +344,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  
>  	/* set configuration register with following options:
>  	 * - enable PCAP interface
> -	 * - set throughput for maximum speed (if bistream not crypted)
> +	 * - set throughput for maximum speed (if bistream not encrypted)
>  	 * - set CPU in user mode
>  	 */
>  	ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 2bc3030a69e54..3a32b8e201857 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -110,7 +110,7 @@ struct fpga_image_info {
>   * @initial_header_size: Maximum number of bytes that should be passed into write_init
>   * @state: returns an enum value of the FPGA's state
>   * @status: returns status of the FPGA, including reconfiguration error code
> - * @write_init: prepare the FPGA to receive confuration data
> + * @write_init: prepare the FPGA to receive configuration data
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
>   * @write_complete: set FPGA to operating state after writing is done
> -- 
> 2.26.3
> 

