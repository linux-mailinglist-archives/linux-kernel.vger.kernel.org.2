Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943493A3F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhFKJum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhFKJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C681F613D0;
        Fri, 11 Jun 2021 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623404918;
        bh=swJnTe4V9Mx/mZfpprQNdMIh0tMmmeszgr+WJIbehO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOZuaYvx/WFMuxjLr/QHY6F0MEPfMdOuBxXRPKbNBV24Dl4o6R7B8xSSjq5fTodGf
         OZQIAqwIhT5Iou9opl6zIAaXoNNNT8zA8uIpiVmQqTRxd+jrSzZfHZujDTAEovNYZe
         +he3556fqxhmU8jgPGbI4G8ehCen0l80gMFkONlA=
Date:   Fri, 11 Jun 2021 11:48:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 4/9] nvmem: sprd: Fix an error message
Message-ID: <YMMxc4UrmMN2AUef@kroah.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-5-srinivas.kandagatla@linaro.org>
 <YMMlRq250A53CDaM@kroah.com>
 <a34f8a9d-c9e7-5c2d-521f-13677cfd7ccb@linaro.org>
 <YMMqPlknDF+k466x@kroah.com>
 <YMMwteJ5XvDST+zH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMMwteJ5XvDST+zH@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 11:45:25AM +0200, Greg KH wrote:
> On Fri, Jun 11, 2021 at 11:17:50AM +0200, Greg KH wrote:
> > On Fri, Jun 11, 2021 at 10:05:40AM +0100, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 11/06/2021 09:56, Greg KH wrote:
> > > > On Fri, Jun 11, 2021 at 09:33:43AM +0100, Srinivas Kandagatla wrote:
> > > > > From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > > 
> > > > > 'ret' is known to be 0 here.
> > > > > The expected error status is stored in 'status', so use it instead.
> > > > > 
> > > > > Also change %d in %u, because status is an u32, not a int.
> > > > > 
> > > > > Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
> > > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > > Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > > > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > > > ---
> > > > >   drivers/nvmem/sprd-efuse.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> > > > > index 5d394559edf2..e3e721d4c205 100644
> > > > > --- a/drivers/nvmem/sprd-efuse.c
> > > > > +++ b/drivers/nvmem/sprd-efuse.c
> > > > > @@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
> > > > >   	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
> > > > >   	if (status) {
> > > > >   		dev_err(efuse->dev,
> > > > > -			"write error status %d of block %d\n", ret, blk);
> > > > > +			"write error status %u of block %d\n", status, blk);
> > > > 
> > > > Shouldn't this be %pe and not %u?
> > > 
> > > This is not error pointer its status value read back from a register.
> > > 
> > > I think %u should be good here.
> > 
> > Argh, you are right, my fault.  For some reason I thought this worked
> > for integers as well.  Don't we have such a printk modifier somewhere to
> > turn error values into strings?  Let me dig...
> 
> Ah, errname() will do it.
> 
> Looks like no one uses it, so nevermind, sorry for the noise.  I'll go
> apply this one now.

Does not apply to my tree :(

