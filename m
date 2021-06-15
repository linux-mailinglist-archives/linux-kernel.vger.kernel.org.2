Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE1F3A85B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhFOP6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhFOP4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:56:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC0136142E;
        Tue, 15 Jun 2021 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623772458;
        bh=r0ldxIgnVptKvktdaumFeqndWM3HUh9JGLZIgdw7Ze0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbsqM6WmkalyEE4zfkMUNbxuOz9T7wdg/X+rk2W82im0zXLxu1fNUSyK2WKTsVYQm
         Gv7nOzd/sPaM6yJdQp2MoxXMFK2ubb/akBfr2ldz3K5TZtaqxlh3ukQAo7WKDxe28I
         rDLl6Yaa+UZF02sS/trIa5uffQJ7fBt/jTHUVTxs=
Date:   Tue, 15 Jun 2021 17:54:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guy Zadicario <guy.zadicario@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Shefi-simchon, Yochai" <yochai.shefi-simchon@intel.com>
Subject: Re: [PATCH v2 00/15] misc: nnpi: New PCIe driver for Intel's NNP-I
 pcie device
Message-ID: <YMjNKAojoGsQ8Z9J@kroah.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
 <YJ4121X/fkSkeHaj@kroah.com>
 <20210615145755.GA25911@aipg-stp-03.iil.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615145755.GA25911@aipg-stp-03.iil.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 05:58:09PM +0300, Guy Zadicario wrote:
> On Fri, May 14, 2021 at 11:33:31AM +0300, Greg KH wrote:
> > On Thu, May 13, 2021 at 11:57:10AM +0300, Guy Zadicario wrote:
> > > Hi,
> > > 
> > > The following series is a driver for a new PCIe device from Intel named NNP-I
> > > (Nirvana Neural Processor for Inference). NNP-I is a PCIe connected compute
> > > device used for acceleration of AI deep learning inference applications in the
> > > data-center.
> > 
> > How does this differ from the "intel_gna" driver being proposed here:
> > 	https://lore.kernel.org/linux-doc/20210513110040.2268-1-maciej.kwapulinski@linux.intel.com/
> > 
> > Please work together to come up with a unified userspace api for these
> > devices, and hopefully, shared kernel code as well.
> > 
> Ok, after consulting, we will try to share api and some kernel code
> between the two drivers.
> 
> The plan is to suggest a common framework for both devices
> and let each device driver register with that framework,
> some functionality will be common and some will be device driver
> specific (same model as drm for gpus). At first I think the common part
> will be small and will deal only with host memory management, later,
> it might grow, if/when some other drivers will adopt it as well.
> 
> We will first change the NNP-I driver to use this framework.
> The GNA driver will wait for this API to be accepted and only then will
> adopt it and request to upstream.

Great, can you also look into what it would take to move the habanna
code to this new api as well?  A new api doesn't mean much if there is
only one user :)

thanks,

greg k-h
