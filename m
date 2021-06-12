Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F333A4D47
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 09:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFLHLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 03:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFLHLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 03:11:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35D3A61249;
        Sat, 12 Jun 2021 07:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623481763;
        bh=qpopxrhB7/n8po7l7amxHfzs4lB/k5A/1bGo3DagKVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3kDxCmWWliMocij9xAnRmaz4aeiBWsXeGAitQ+mtTcXUZvzQ3tvbypCLrJ4R+U8c
         et29162Yqdal1B+4gJ3PwmHCoHBRQUsTr+x+KYfo2gaUw3pDU0AtoxlMaUO307SUzK
         AVZlhBnnZoDAydSmEAKD2k3unCMXEtZ7DA/N35WFCA+VyR6Et0pXDMBBtkVK9t9LlJ
         hW476C09luQmT7O9mDuaJKrSAhqEe4xP3GFqfoQ/79BCmAG/ZIhefH3EUVke9w8doS
         6OYDvEc8ocKChuBxihbxrzejeBmh3+NrUJ2cUc6rFh65Kgv4n5i+bICiiDHwWDoHBD
         UfJbvsZu053LQ==
Date:   Sat, 12 Jun 2021 12:39:14 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     hemantk@codeaurora.org, loic.poulain@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: pci-generic: Add missing
 'pci_disable_pcie_error_reporting()' calls
Message-ID: <20210612070914.GD22149@thinkpad>
References: <f70c14701f4922d67e717633c91b6c481b59f298.1623445348.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f70c14701f4922d67e717633c91b6c481b59f298.1623445348.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 11:03:50PM +0200, Christophe JAILLET wrote:
> If an error occurs after a 'pci_enable_pcie_error_reporting()' call, it
> must be undone by a corresponding 'pci_disable_pcie_error_reporting()'
> call
> 
> Add the missing call in the error handling path of the probe and in the
> remove function.
> 
> Fixes: b012ee6bfe2a ("mhi: pci_generic: Add PCI error handlers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Cced stable and applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/pci_generic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
> index 7c810f02a2ef..d84b74396c6a 100644
> --- a/drivers/bus/mhi/pci_generic.c
> +++ b/drivers/bus/mhi/pci_generic.c
> @@ -665,7 +665,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	err = mhi_register_controller(mhi_cntrl, mhi_cntrl_config);
>  	if (err)
> -		return err;
> +		goto err_disable_reporting;
>  
>  	/* MHI bus does not power up the controller by default */
>  	err = mhi_prepare_for_power_up(mhi_cntrl);
> @@ -699,6 +699,8 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mhi_unprepare_after_power_down(mhi_cntrl);
>  err_unregister:
>  	mhi_unregister_controller(mhi_cntrl);
> +err_disable_reporting:
> +	pci_disable_pcie_error_reporting(pdev);
>  
>  	return err;
>  }
> @@ -721,6 +723,7 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>  		pm_runtime_get_noresume(&pdev->dev);
>  
>  	mhi_unregister_controller(mhi_cntrl);
> +	pci_disable_pcie_error_reporting(pdev);
>  }
>  
>  static void mhi_pci_shutdown(struct pci_dev *pdev)
> -- 
> 2.30.2
> 
