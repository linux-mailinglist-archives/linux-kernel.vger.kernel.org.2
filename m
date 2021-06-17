Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4083ABA40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhFQRIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhFQRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:08:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A83BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:05:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k15so345046pfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spDOLTpTEkP0pQRlVnvSw7EzDBOy7ixf6KlEeu5zAFw=;
        b=gvFkjdJ8/nWFYJ6eh4eGwDZH3O/FzRYCKAixYJ+bNuEKuwuss5/DVmrjbX+uVysNvs
         i+qXxnRozSclnhV9Ko6zmIrYMI87h5HmYTek2HI51jvn+xNCD0bg4XrN4Yqp9qib8CR9
         CUbQjexgtNkQUUYY4uYwd9nqQU44N+MdMqNFnAuiyyvQF/75BrkWVJgcEymLk/Yr4jeG
         LXwy06acDKVCdG2uCzuuG+EAuw4cXh15bV4ak7aa62CQzu1ula2LAtWnB2igv14GYA4W
         lXzfTYxIUy2PbsQtOWmWpcG+YtKPZhkz3VQN8S2EtJE6uuvXzzN4PNXTSebZUa2p7xNz
         g78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spDOLTpTEkP0pQRlVnvSw7EzDBOy7ixf6KlEeu5zAFw=;
        b=Mgs+4NEnJXCO6/jryG0Dh7A+Hx4AghcYddS8JYd6cja8TNXgONUm/qxCBYi7pMBeQb
         +mqin0lM9PAaXgX7tZSYkm3YFztq9rb3+sOTlixGPysaREK4X+Vo526xI+ndVxp91hKj
         KTiH1nGhyqRwm8Go+TTXaG8dOhjDZgtNer7CZg6MM8H/2nN779Pth3JSwYG5dRD2UDjD
         xA2bC9nwJmlGvc/f8WM1tedyuYnwaGxJjVylj4HQCBG0J36eKzFNpSOhneRKSNaFC2sw
         SxVhe623frUlK47T/vuaLz7XcyFAbqzwf4Dhia5qpXgB1zIxC1vniPYr4QnOKw54seCg
         f88Q==
X-Gm-Message-State: AOAM533jHhk6kn1vE6qA49vrTaerzAOquFN1CZO6z9c3ooB9FFm7CwQh
        AGj21bko7L3w28nvbMRiqPE7
X-Google-Smtp-Source: ABdhPJwaG6/j71e6DUZJ1nF3XYcWFet57gwEKHoW0R5fI/eRI2bpxAbaOGhdC3lH0rW9KnnXYL+7tA==
X-Received: by 2002:a63:d117:: with SMTP id k23mr5831729pgg.60.1623949554810;
        Thu, 17 Jun 2021 10:05:54 -0700 (PDT)
Received: from workstation ([120.138.13.64])
        by smtp.gmail.com with ESMTPSA id nv1sm5562052pjb.43.2021.06.17.10.05.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jun 2021 10:05:54 -0700 (PDT)
Date:   Thu, 17 Jun 2021 22:35:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org
Subject: Re: [PATCH 0/5] PCI: endpoint: Add support for additional notifiers
Message-ID: <20210617170549.GA3075@workstation>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
 <9fd37c43-e2ab-f5b2-13dc-a23bd83d3c7b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fd37c43-e2ab-f5b2-13dc-a23bd83d3c7b@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 12:42:07AM +0530, Om Prakash Singh wrote:
> Hi Mani,
> Adding more notifier types will surely help but I believe the list is not
> exhaustive. What you are trying here is to pass various vendor-specific epc
> interrupts to EPF driver. That can be taken care by a single notifier
> interface as well, "pci_epc_custom_notify" from your implementation.

That's what I initially thought eventhough not all the notifiers are
vendor specific. But Kishon suggested to add notifiers for generic ones
such as BME, PME etc... and that sounded reasonable to me.

> This
> also requires to have pre-defined values of "data" argument to standardize
> the interface.
> 

No, I don't think we can standardize the arguments to "custom" notifier.
The custom notifier is supposed to deal with vendor specific events and
I don't see any benefit on standardizing it. I see it more like an
opaque driver_data field where we pass driver specific arguments.

Thanks,
Mani

> your thoughts?
> 
> Thanks,
> Om
> 
> On 6/16/2021 5:29 PM, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hello,
> > 
> > This series adds support for additional notifiers in the PCI endpoint
> > framework. The notifiers LINK_DOWN, BME, PME, and D_STATE are generic
> > for all PCI endpoints but there is also a custom notifier (CUSTOM) added
> > to pass the device/vendor specific events to EPF from EPC.
> > 
> > The example usage of all notifiers is provided in the commit description.
> > 
> > Thanks,
> > Mani
> > 
> > Manivannan Sadhasivam (5):
> >    PCI: endpoint: Add linkdown notifier support
> >    PCI: endpoint: Add BME notifier support
> >    PCI: endpoint: Add PME notifier support
> >    PCI: endpoint: Add D_STATE notifier support
> >    PCI: endpoint: Add custom notifier support
> > 
> >   drivers/pci/endpoint/pci-epc-core.c | 89 +++++++++++++++++++++++++++++
> >   include/linux/pci-epc.h             |  5 ++
> >   include/linux/pci-epf.h             |  5 ++
> >   3 files changed, 99 insertions(+)
> > 
> > --
> > 2.25.1
> > 
