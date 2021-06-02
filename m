Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C01398F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhFBPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhFBPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:55:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8156C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 08:53:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g18so2538828pfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hK//pmm54bRSlMW5uPr9yBPBLwqqIZOje1VFzEXMhoo=;
        b=lgA3PdFNrHmVePmAN7jOVeqL/cPa4cayr0E2O93hAmslWG2ZTldaoeZu+HS6n4JfFi
         i+Q1BMcR0emC9SefjzKqC75Ry7cJUISMuVpTqtKVF7zYBNTd1K8Aw5FJF3IrosRDCTaR
         cuoeFKpQBEmHNhy14AqRTmpR/2X3b0sYi5OCQZZM49VUSvQa3yUqULFIDYJOUizt+nAN
         ZvEaDdGdQ3UusuhmFuzsHl3Yswgw/o/PJXIqCGFXBsfuGT/bncnE6fKatr357a/Buij3
         5HEyYf08yLq9boaEWVOsE21B9jD3b9uDjV1or0YKQxzyIVYsKxA6B46L4cZSfYFtpFqQ
         9f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hK//pmm54bRSlMW5uPr9yBPBLwqqIZOje1VFzEXMhoo=;
        b=PZzDE6YmRD6x0Epf+n1pe0/bTxLvYXKkPU8u5oypbS8Fjaraw/GeQG+wa2O3R2W5fu
         wvnvkznk3Sh07AlwISHx80mWqLjzphpI07Kb6n+uYK9ARVC4qku3z7JfaL38HtIytKSX
         lVpycZ4XTFrM1/BRpXkRW+p9VH0UZ8upksxLR9pH5ulScwXGYIMO75pRbopwAK9jP8lZ
         mTag+sWX9HQELpwgn/3HEECe6LgPaqhSYuF9uj0zznmprSdqddYo971HPcmCtZwkpQLk
         lBqsW7DsV1Bqf0JLSGLHNIQWPMoib84Wo7lA8D4mT2EvCTY04crgr2z+50NJXyJFKJ/W
         nKEA==
X-Gm-Message-State: AOAM532GsIWK54cj8SsUJG4mbfTZjDzOaK0aTAE5Cp6NF+GqUogjNAAE
        fzJ6DwWJkDr57OumazFxelrAUg==
X-Google-Smtp-Source: ABdhPJyDWrXpw6Glo49poS8zDlgKlOOYNgMXCTaf1Yjo7W43HPIwlao36zxCg+IgztbOGGyNtPXhnQ==
X-Received: by 2002:a63:b907:: with SMTP id z7mr33618667pge.112.1622649205212;
        Wed, 02 Jun 2021 08:53:25 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p19sm48928pjv.21.2021.06.02.08.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:53:24 -0700 (PDT)
Date:   Wed, 2 Jun 2021 09:53:22 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] remoteproc: k3-r5: Add support for IPC-only mode for
 all R5Fs
Message-ID: <20210602155322.GB1795080@xps15>
References: <20210522000309.26134-1-s-anna@ti.com>
 <20210522000309.26134-5-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522000309.26134-5-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been thinking about this patch again...

On Fri, May 21, 2021 at 07:03:07PM -0500, Suman Anna wrote:
> Add support to the K3 R5F remoteproc driver to configure all the R5F
> cores to be either in IPC-only mode or the traditional remoteproc mode.
> The IPC-only mode expects that the remote processors are already booted
> by the bootloader, and only performs the minimum steps required to
> initialize and deinitialize the virtio IPC transports. The remoteproc
> mode allows the kernel remoteproc driver to do the regular load and
> boot and other device management operations for a R5F core.
> 
> The IPC-only mode for a R5F core is detected and configured at driver
> probe time by querying the System Firmware for the R5F power and reset
> state and/or status and making sure that the R5F core is indeed started
> by the bootloaders, otherwise the device is configured for remoteproc
> mode.
> 
> Support for IPC-only mode is achieved through .attach(), .detach() and
> .get_loaded_rsc_table() callback ops and various other flags in both
> remoteproc core and the K3 R5F remoteproc driver. The resource table
> follows a design-by-contract approach and is expected to be at the base
> of the DDR firmware region reserved for each remoteproc, it is mostly
> expected to contain only the virtio device and trace resource entries.
> 
> NOTE:
> The driver cannot configure a R5F core for remoteproc mode by any
> means without rebooting the kernel if that R5F core has been started
> by a bootloader.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 215 +++++++++++++++++++++++
>  1 file changed, 215 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index e7e1ca71763e..66f0654f0860 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -151,6 +151,7 @@ struct k3_r5_core {
>   * @core: cached pointer to r5 core structure being used
>   * @rmem: reserved memory regions data
>   * @num_rmems: number of reserved memory regions
> + * @ipc_only: flag to indicate IPC-only mode
>   */
>  struct k3_r5_rproc {
>  	struct device *dev;
> @@ -161,6 +162,7 @@ struct k3_r5_rproc {
>  	struct k3_r5_core *core;
>  	struct k3_r5_mem *rmem;
>  	int num_rmems;
> +	bool ipc_only;
>  };
>  
>  /**
> @@ -440,6 +442,10 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
>  	bool mem_init_dis;
>  	int ret;
>  
> +	/* IPC-only mode does not require the cores to be released from reset */
> +	if (kproc->ipc_only)
> +		return 0;
> +
>  	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl, &stat);
>  	if (ret < 0)
>  		return ret;
> @@ -503,6 +509,10 @@ static int k3_r5_rproc_unprepare(struct rproc *rproc)
>  	struct device *dev = kproc->dev;
>  	int ret;
>  
> +	/* do not put back the cores into reset in IPC-only mode */
> +	if (kproc->ipc_only)
> +		return 0;
> +
>  	/* Re-use LockStep-mode reset logic for Single-CPU mode */
>  	ret = (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
>  	       cluster->mode == CLUSTER_MODE_SINGLECPU) ?
> @@ -538,6 +548,12 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  	u32 boot_addr;
>  	int ret;
>  
> +	if (kproc->ipc_only) {
> +		dev_err(dev, "%s cannot be invoked in IPC-only mode\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
>  	ret = k3_r5_rproc_request_mbox(rproc);
>  	if (ret)
>  		return ret;
> @@ -604,9 +620,16 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  {
>  	struct k3_r5_rproc *kproc = rproc->priv;
>  	struct k3_r5_cluster *cluster = kproc->cluster;
> +	struct device *dev = kproc->dev;
>  	struct k3_r5_core *core = kproc->core;
>  	int ret;
>  
> +	if (kproc->ipc_only) {
> +		dev_err(dev, "%s cannot be invoked in IPC-only mode\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +

It would be much cleaner to simply not provide any of the above functions to
rproc_ops when in IPC only mode. 

>  	/* halt all applicable cores */
>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP) {
>  		list_for_each_entry(core, &cluster->cores, elem) {
> @@ -635,6 +658,85 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  	return ret;
>  }
>  
> +/*
> + * Attach to a running R5F remote processor (IPC-only mode)
> + *
> + * The R5F attach callback only needs to request the mailbox, the remote
> + * processor is already booted, so there is no need to issue any TI-SCI
> + * commands to boot the R5F cores in IPC-only mode.
> + */
> +static int k3_r5_rproc_attach(struct rproc *rproc)
> +{
> +	struct k3_r5_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	int ret;
> +
> +	if (!kproc->ipc_only || rproc->state != RPROC_DETACHED) {
> +		dev_err(dev, "R5F is expected to be in IPC-only mode and RPROC_DETACHED state\n");
> +		return -EINVAL;
> +	}

Not sure this condition is needed since this can only be called by the core if
state == RPROC_DETACHED, same for k3_r5_rproc_detach() below.  And because we are
in k3_r5_rproc_attach/detach() we can only be in IPC only mode, which means that
k3_r5_proc::ipc_only mode shouldn't be needed.

> +
> +	ret = k3_r5_rproc_request_mbox(rproc);
> +	if (ret)
> +		return ret;
> +
> +	dev_err(dev, "R5F core initialized in IPC-only mode\n");
> +	return 0;
> +}
> +
> +/*
> + * Detach from a running R5F remote processor (IPC-only mode)
> + *
> + * The R5F detach callback performs the opposite operation to attach callback
> + * and only needs to release the mailbox, the R5F cores are not stopped and
> + * will be left in booted state in IPC-only mode.
> + */
> +static int k3_r5_rproc_detach(struct rproc *rproc)
> +{
> +	struct k3_r5_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +
> +	if (!kproc->ipc_only || rproc->state != RPROC_ATTACHED) {
> +		dev_err(dev, "R5F is expected to be in IPC-only mode and RPROC_ATTACHED state\n");
> +		return -EINVAL;
> +	}
> +
> +	mbox_free_channel(kproc->mbox);
> +	dev_err(dev, "R5F core deinitialized in IPC-only mode\n");
> +	return 0;
> +}
> +
> +/*
> + * This function implements the .get_loaded_rsc_table() callback and is used
> + * to provide the resource table for the booted R5F in IPC-only mode. The K3 R5F
> + * firmwares follow a design-by-contract approach and are expected to have the
> + * resource table at the base of the DDR region reserved for firmware usage.
> + * This provides flexibility for the remote processor to be booted by different
> + * bootloaders that may or may not have the ability to publish the resource table
> + * address and size through a DT property.
> + */
> +static struct resource_table *k3_r5_get_loaded_rsc_table(struct rproc *rproc,
> +							 size_t *rsc_table_sz)
> +{
> +	struct k3_r5_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +
> +	if (!kproc->rmem[0].cpu_addr) {
> +		dev_err(dev, "memory-region #1 does not exist, loaded rsc table can't be found");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/*
> +	 * NOTE: The resource table size is currently hard-coded to a maximum
> +	 * of 256 bytes. The most common resource table usage for K3 firmwares
> +	 * is to only have the vdev resource entry and an optional trace entry.
> +	 * The exact size could be computed based on resource table address, but
> +	 * the hard-coded value suffices to support the IPC-only mode.
> +	 */
> +	*rsc_table_sz = 256;
> +	return (struct resource_table *)kproc->rmem[0].cpu_addr;
> +}
> +
>  /*
>   * Internal Memory translation helper
>   *
> @@ -709,8 +811,11 @@ static const struct rproc_ops k3_r5_rproc_ops = {
>  	.unprepare	= k3_r5_rproc_unprepare,
>  	.start		= k3_r5_rproc_start,
>  	.stop		= k3_r5_rproc_stop,
> +	.attach		= k3_r5_rproc_attach,
> +	.detach		= k3_r5_rproc_detach,
>  	.kick		= k3_r5_rproc_kick,
>  	.da_to_va	= k3_r5_rproc_da_to_va,
> +	.get_loaded_rsc_table = k3_r5_get_loaded_rsc_table,
>  };
>  
>  /*
> @@ -1014,6 +1119,109 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
>  	}
>  }
>  
> +/*
> + * This function checks and configures a R5F core for IPC-only or remoteproc
> + * mode. The driver is configured to be in IPC-only mode for a R5F core when
> + * the core has been loaded and started by a bootloader. The IPC-only mode is
> + * detected by querying the System Firmware for reset, power on and halt status
> + * and ensuring that the core is running. Any incomplete steps at bootloader
> + * are validated and errored out.
> + *
> + * In IPC-only mode, the driver state flags for ATCM, BTCM and LOCZRAMA settings
> + * and cluster mode parsed originally from kernel DT are updated to reflect the
> + * actual values configured by bootloader. The driver internal device memory
> + * addresses for TCMs are also updated.
> + */
> +static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
> +{
> +	struct k3_r5_cluster *cluster = kproc->cluster;
> +	struct k3_r5_core *core = kproc->core;
> +	struct device *cdev = core->dev;
> +	bool r_state = false, c_state = false;
> +	u32 ctrl = 0, cfg = 0, stat = 0, halted = 0;
> +	u64 boot_vec = 0;
> +	u32 atcm_enable, btcm_enable, loczrama;
> +	struct k3_r5_core *core0;
> +	enum cluster_mode mode;
> +	int ret;
> +
> +	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
> +
> +	ret = core->ti_sci->ops.dev_ops.is_on(core->ti_sci, core->ti_sci_id,
> +					      &r_state, &c_state);
> +	if (ret) {
> +		dev_err(cdev, "failed to get initial state, mode cannot be determined, ret = %d\n",
> +			ret);
> +		return ret;
> +	}
> +	if (r_state != c_state) {
> +		dev_warn(cdev, "R5F core may have been powered on by a different host, programmed state (%d) != actual state (%d)\n",
> +			 r_state, c_state);
> +	}
> +
> +	ret = reset_control_status(core->reset);
> +	if (ret < 0) {
> +		dev_err(cdev, "failed to get initial local reset status, ret = %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
> +				     &stat);
> +	if (ret < 0) {
> +		dev_err(cdev, "failed to get initial processor status, ret = %d\n",
> +			ret);
> +		return ret;
> +	}
> +	atcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_ATCM_EN ?  1 : 0;
> +	btcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_BTCM_EN ?  1 : 0;
> +	loczrama = cfg & PROC_BOOT_CFG_FLAG_R5_TCM_RSTBASE ?  1 : 0;
> +	if (cluster->soc_data->single_cpu_mode) {
> +		mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
> +				CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
> +	} else {
> +		mode = cfg & PROC_BOOT_CFG_FLAG_R5_LOCKSTEP ?
> +				CLUSTER_MODE_LOCKSTEP : CLUSTER_MODE_SPLIT;
> +	}
> +	halted = ctrl & PROC_BOOT_CTRL_FLAG_R5_CORE_HALT;
> +
> +	/*
> +	 * IPC-only mode detection requires both local and module resets to
> +	 * be deasserted and R5F core to be unhalted. Local reset status is
> +	 * irrelevant if module reset is asserted (POR value has local reset
> +	 * deasserted), and is deemed as remoteproc mode
> +	 */
> +	if (c_state && !ret && !halted) {
> +		dev_err(cdev, "configured R5F for IPC-only mode\n");
> +		kproc->rproc->state = RPROC_DETACHED;
> +		kproc->rproc->detach_on_shutdown = true;
> +		kproc->ipc_only = true;
> +		ret = 1;
> +	} else if (!c_state) {
> +		dev_err(cdev, "configured R5F for remoteproc mode\n");
> +		ret = 0;
> +	} else {
> +		dev_err(cdev, "mismatched mode: local_reset = %s, module_reset = %s, core_state = %s\n",
> +			!ret ? "deasserted" : "asserted",
> +			c_state ? "deasserted" : "asserted",
> +			halted ? "halted" : "unhalted");
> +		ret = -EINVAL;
> +	}
> +
> +	/* fixup TCMs, cluster & core flags to actual values in IPC-only mode */
> +	if (ret > 0) {
> +		if (core == core0)
> +			cluster->mode = mode;
> +		core->atcm_enable = atcm_enable;
> +		core->btcm_enable = btcm_enable;
> +		core->loczrama = loczrama;
> +		core->mem[0].dev_addr = loczrama ? 0 : K3_R5_TCM_DEV_ADDR;
> +		core->mem[1].dev_addr = loczrama ? K3_R5_TCM_DEV_ADDR : 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  {
>  	struct k3_r5_cluster *cluster = platform_get_drvdata(pdev);
> @@ -1054,6 +1262,12 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  		kproc->rproc = rproc;
>  		core->rproc = rproc;
>  
> +		ret = k3_r5_rproc_configure_mode(kproc);
> +		if (ret < 0)
> +			goto err_config;
> +		if (ret)
> +			goto init_rmem;
> +
>  		ret = k3_r5_rproc_configure(kproc);
>  		if (ret) {
>  			dev_err(dev, "initial configure failed, ret = %d\n",
> @@ -1061,6 +1275,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  			goto err_config;
>  		}
>  
> +init_rmem:
>  		k3_r5_adjust_tcm_sizes(kproc);
>  
>  		ret = k3_r5_reserved_mem_init(kproc);
> -- 
> 2.30.1
> 
