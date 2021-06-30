Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278E53B82C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhF3NTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhF3NTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:19:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD1C061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:17:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h4so2231114pgp.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fgdFcWlgoPypBIRoYUde3N58e9Twt3JB/QiM0lXDUWI=;
        b=RJFbHULSsaCe2wRav93soy+7dgaRoot7nNDKvGe754HFdzty/DNF19Bcuq/sZzsB7m
         kfYO3Ph5p/aW7ODv4rj1iGGZ+E1hDntDeZ6N8VCj15UtFJqIlviSZgLsPoRKORiBHntk
         IRT8ULCoWkFWyIQaogamNDT4YjjjtVKosyrIlu4+Le5nocHse11/b96jqr4mwlrLHgOj
         qatNwWNz+ktQYbAPA+30fpryZ1aDkFkglOqeLfLL29HLLRg5xKUV0zdJVzd8wAmmm6xD
         A48AR3p/O9qf8F/EiK22xuv68R6FUvZdLeh6EGQY0YDjiG+o8JyGtKMC2rivNb5HXw3r
         w9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fgdFcWlgoPypBIRoYUde3N58e9Twt3JB/QiM0lXDUWI=;
        b=C2UfKSr0fwUjAHnzVp80GnECcr1+0JXNgGK/t4pZifNz8kotbYaDe/dRZuu/wWbZ19
         QFo9bmb9JiaqF657/hmKkPZq7coNqh/CqW4dTC3OWxuk/Mpt/Q8YvYWjRb7nmGcM9Eer
         pytc61m/a1Z9kmKxisTcHDKg1a81U6xRsU1Y22FJyGv+ZtFBwCFUgfcanfSy90ovFTyQ
         eXuwZv+aQnhhCi1s75cIgHp5vI+/Y0eZ1UlL2D/QnpfRg1ZoHfk0dk15/rOZGSjVVOOB
         6Nn5vSl8QTFrGKRs0vMinoYK3kv6NgFolcwzYFRtK93oo5U5Guj6+Uaowit92j7nvW2v
         f4TQ==
X-Gm-Message-State: AOAM533N+EjznKjMw0qS/Ewpno7gyuZJKe3cmM6phqT4uRoSTg8l6Y2g
        5xEeddzs7XfSfZy0PQyv20TH
X-Google-Smtp-Source: ABdhPJwP08UOveU6IrebsAzxULeGoj7rDhUudmYe3gn3bDi3yRcY6TAhgxW2TZAG7ZmtikkGUFkRyA==
X-Received: by 2002:a63:5153:: with SMTP id r19mr34252156pgl.56.1625059021948;
        Wed, 30 Jun 2021 06:17:01 -0700 (PDT)
Received: from workstation ([120.138.13.102])
        by smtp.gmail.com with ESMTPSA id k8sm13349323pfa.142.2021.06.30.06.16.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jun 2021 06:17:01 -0700 (PDT)
Date:   Wed, 30 Jun 2021 18:46:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 00/10] MHI patches for v5.14 - Take 2
Message-ID: <20210630131656.GA18484@workstation>
References: <20210625123355.11578-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625123355.11578-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jun 25, 2021 at 06:03:45PM +0530, Manivannan Sadhasivam wrote:
> Hi Greg,
> 
> Please find the remaining MHI patches for v5.14. This series has the left over
> patches from the previous patchset and one new series that was reviewed a
> while ago and put on hold for Ack from Kalle Valo for ath11k.
> 
> Summary:
> 
> 1. Added validation for the channel ID read from event ring. If we get events
> from an invalid channel, we throw an error message and skip the event.
> 
> 2. Fixed the MHI wake routines used for the newer modems such as SDX55 and
> SDX65 by using no-op routines only for the older modems and then relying on
> the default routines provided by MHI stack for newer ones.
> 
> 3. Added support for processing the events based on the priorities. Earlier
> a fixed priority was used for all events.
> 
> 4. Added a dedicated flag to the MHI client transfer APIs for inbound
> buffer allocation by the MHI stack. Since this patch modifies the MHI
> client drivers under "net/", Ack has been collected from the netdev
> maintainer.
> 
> 5. Added support for Cinterion MV31-W modem in pci_generic controller:
> https://www.thalesgroup.com/en/markets/digital-identity-and-security/iot/iot-connectivity/products/iot-products/mv31-w-ultra-high
> 
> 6. Rearranged the setting of BHI/BHIe offsets for better validation of the
> register values read from MMIO
> 
> 7. Cleanup of the BHI/BHIe pointers by setting them to NULL to prevent access
> after power down.
> 
> 8. Added support for getting the MMIO register length from the controller
> drivers. This helps in validation of the read offsets from MMIO registers.
> Since this patch touches ath11k, Ack has been collected from Kalle Valo.
> 
> 9. With the help of above register length, added check for BHI/BHIe offsets.
> 

Is this series on your queue for 5.14?

Thanks,
Mani

> Thanks,
> Mani
> 
> Bhaumik Bhatt (8):
>   bus: mhi: pci_generic: Apply no-op for wake using sideband wake
>     boolean
>   bus: mhi: core: Validate channel ID when processing command
>     completions
>   bus: mhi: core: Set BHI/BHIe offsets on power up preparation
>   bus: mhi: core: Set BHI and BHIe pointers to NULL in clean-up
>   bus: mhi: Add MMIO region length to controller structure
>   ath11k: set register access length for MHI driver
>   bus: mhi: pci_generic: Set register access length for MHI driver
>   bus: mhi: core: Add range checks for BHI and BHIe
> 
> Loic Poulain (1):
>   bus: mhi: Add inbound buffers allocation flag
> 
> ULRICH Thomas (1):
>   bus: mhi: pci_generic: Add Cinterion MV31-W PCIe to MHI
> 
>  drivers/bus/mhi/core/init.c           | 61 +++++++++++++++++--------
>  drivers/bus/mhi/core/internal.h       |  2 +-
>  drivers/bus/mhi/core/main.c           | 26 +++++++----
>  drivers/bus/mhi/core/pm.c             | 28 ++----------
>  drivers/bus/mhi/pci_generic.c         | 65 +++++++++++++++++++++++----
>  drivers/net/mhi/net.c                 |  2 +-
>  drivers/net/wireless/ath/ath11k/mhi.c |  1 +
>  drivers/net/wwan/mhi_wwan_ctrl.c      |  2 +-
>  include/linux/mhi.h                   |  9 +++-
>  net/qrtr/mhi.c                        |  2 +-
>  10 files changed, 134 insertions(+), 64 deletions(-)
> 
> -- 
> 2.25.1
> 
