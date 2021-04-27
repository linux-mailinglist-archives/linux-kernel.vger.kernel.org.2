Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0515336C7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhD0O0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0OZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:25:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38A5161158;
        Tue, 27 Apr 2021 14:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619533513;
        bh=49OcEmMQfLcBMjyn45iNrx4hOqFUGuRBSYnNHAatN9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5yezhmQ2zYxF1WUD6bU2YiGybS6foqbASjZausVvm5s/HCd5xIN9MOpJcIqRX0n6
         70e2uo0zDoRGj9W9RfSw0XntjQeZZ4uq3ncGsFpYuKtV3ZiPmw4WXVDf6DSPMmKfiT
         lGgKPltuiqGHW228tXF7yAUAqlrgzZadsrQsqg4I=
Date:   Tue, 27 Apr 2021 16:25:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roland Dreier <roland@kernel.org>
Cc:     jgg@mellanox.com, linux-kernel@vger.kernel.org, wu000273@umn.edu
Subject: Re: [PATCH 044/190] Revert "RDMA/pvrdma: Fix missing pci disable in
 pvrdma_pci_probe()"
Message-ID: <YIgexw4zOuoNKPB5@kroah.com>
References: <20210421130105.1226686-45-gregkh@linuxfoundation.org>
 <20210421192517.1327240-1-roland@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421192517.1327240-1-roland@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 12:25:17PM -0700, Roland Dreier wrote:
> This is a really weird one because the patch actually looks correct
> and the revert looks wrong??
> 
> 	ret = pci_enable_device(pdev);
> 
> [...dbg statements...]
> 
> 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
> 	    !(pci_resource_flags(pdev, 1) & IORESOURCE_MEM)) {
> 		dev_err(&pdev->dev, "PCI BAR region not MMIO\n");
> 		ret = -ENOMEM;
> 		goto err_disable_pdev;
> 	}
> 
>  - R.

git revert sometimes does odd things :)

I'll go drop this from the tree, thanks.

greg k-h
