Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A323E3565
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhHGNCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 09:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhHGNB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 09:01:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E92C610E7;
        Sat,  7 Aug 2021 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628341298;
        bh=4vxNbY3Ec6UC/WonzfId91h9p1F2zYpXluPhIIJ7H8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7fuZgg6ptdvsPAa5n0IaNDMo9IF7mfiQNTgOrZpSDQ2wB6LVZKM7nhgxwFvNvcIx
         dXuUZv+wyWmr6fDQ2eGBP4os1VOy62DPTvXgyUQR5Xunpsrh3tvvZ5CCTEqj4Yj1uv
         oxY+lW6aEyM5NTeRv+svd/1D1so2dFxPa+or23M8=
Date:   Sat, 7 Aug 2021 15:01:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] slimbus: patches (set 1) for 5.15
Message-ID: <YQ6EMKD0gOIJn+FL@kroah.com>
References: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
 <YQ03FPyxF8DFlwI7@kroah.com>
 <71200533-db05-157f-480a-d64812e1d9c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71200533-db05-157f-480a-d64812e1d9c2@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021 at 11:48:48AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 06/08/2021 14:20, Greg KH wrote:
> > On Fri, Aug 06, 2021 at 10:16:35AM +0100, Srinivas Kandagatla wrote:
> > > Hi Greg,
> > > 
> > > Recently runtime pm testing on slimbus reveled that its
> > > totally broken on SlimBus ngd drivers.
> > > 
> > > Below are the fixes to get it back working.
> > > 
> > > - One of the reason begin incorrect device pointer used for
> > > runtime pm and in some places
> > > 
> > > - Second one was to do with unable to validate transaction id
> > >   which resulted in negative runtime pm count.
> > > 
> > > - Other fix was to do with resetting dma addresses once ngd
> > > controller is power-cycled.
> > > 
> > > With all these fixed runtime pm is now fully functional on NGD
> > > controllers.
> > > 
> > > Currently I marked them all with Cc: <stable@vger.kernel.org>
> > > as these all patches are required to fix runtime pm on SlimBus
> > > NGD controller.
> > > 
> > > Can you please queue them up for 5.15.
> > 
> > Why do you want these for 5.15-rc1 when you need them to fix problems in
> > 5.14?  Shouldn't they go into 5.14-final?
> 
> Yes, these should go to other stable trees aswell.
> I assumed that Fixes tag will automatically backport those patches.

Yes, but that can not happen until they hit Linus's tree, which would
not be until 5.15-rc1.  Do you want to delay until that long from now?

How about splitting this into 2 patch series, one that you want to see
get into 5.14-final, and one for 5.15-rc1.

thanks,

greg k-h
