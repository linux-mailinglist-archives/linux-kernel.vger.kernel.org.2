Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D40637B6D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhELH22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhELH2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:28:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F292611F1;
        Wed, 12 May 2021 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620804436;
        bh=7DtgQM0zHrMALUkeiBsDilxoDEgNzTco/1t5D1d6YFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jU9/5WXu7LKNkNrsgUBmx0wSRqZG3Fg3/NyXhpgaHiWlBhLOQGn28u6sjQ2VUtR8U
         4stDi3Xl4PlF4Ihpo0av0i6cki7Lke9IT8CD1T4sJtEhtvxcsff+rB3ZUcCFxAupsK
         pgar8pE8TaULeFlJmBHjo5vVHzIIyKaGqySj+UCI=
Date:   Wed, 12 May 2021 09:27:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guy Zadicario <guy.zadicario@intel.com>
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net,
        alexander.shishkin@linux.intel.com, andriy.shevchenko@intel.com,
        yochai.shefi-simchon@intel.com
Subject: Re: [PATCH 00/15] misc: nnpi: New PCIe driver for Intel's NNP-I pcie
 device
Message-ID: <YJuDUXennxtR5rCZ@kroah.com>
References: <20210512071046.34941-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512071046.34941-1-guy.zadicario@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 10:10:31AM +0300, Guy Zadicario wrote:
> Hi,
> 
> The following series is a driver for a new PCIe device from Intel named NNP-I
> (Nirvana Neural Processor for Inference). NNP-I is a PCIe connected compute
> device used for acceleration of AI deep learning inference applications in the
> data-center.
> 
> The reason that this driver should be in the kernel is that it aims to serve
> multiple users and user-space applications which might share the same NNP-I
> card. Workloads from multiple applications can be processed simultanously by
> the NNP-I card if enough compute resources exist.
> 
> Overview of the NNP-I device, driver structure and ABIs used in the driver is in
> patch#1, which adds the info as a document as it might be a useful info for
> anyone trying to understand the driver even past review.
> 
> In order to ease the review process, there will be multiple series for the
> entire driver code. This is the first series, and it implements everything
> necessary to initialize the NNP-I device and allow a user-space inference
> application to use it. Other features, which are mostly related to maintenance,
> device status visibility and error-handling, will be submitted on the next stage.
> 
> A basic user-space library and test application which illustrates the flow of
> an NNP-I inference application can be found here: https://github.com/IntelAI/nnpi-host
> (This series is enough for the test application to run)
> 
> This patchset has gone through internal review inside Intel, the summary of the
> change log from the internal review follows.
> 
> I would appreciate any feedback, questions or comments to this series.
> 
> Changes in v22:

Why is "v22" not in the [PATCH...] part of the subjects here?

And has there really been 21 other series posted to lkml for this?

thanks,

greg k-h
