Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2235422F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhDEMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 08:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhDEMul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 08:50:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A57F6139C;
        Mon,  5 Apr 2021 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617627035;
        bh=cE13Yu2kYVLgmEh7PJ7+VXS8j9N/E79t/n0hpAfzJcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zLPPgRM0q2V0+kdjF6J0/inNjeXuQ2T38WndJfHaPLLXzCG+qyijJ4+nw+sAToCtO
         jeornWCKCjHMKWrGaYPm8kFMnhLOCRhGcseGL83LO8vVoW6GtrWRiaaBnaSnOst8Y5
         OwJkoIyMVN34tOMhJ+QKr4pGLsEQ+xGbJCzjPMBw=
Date:   Mon, 5 Apr 2021 14:50:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@lwn.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] w1: ds2438: support for writing to offset register
Message-ID: <YGsHmCkHj6SwUqhD@kroah.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210405105009.420924-10-sampaio.ime@gmail.com>
 <YGru2+hI6fgE/v3J@kroah.com>
 <20210405124401.mvkoxs2girygv7f2@LuizSampaio-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405124401.mvkoxs2girygv7f2@LuizSampaio-PC.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 09:44:01AM -0300, Luiz Sampaio wrote:
> On Mon, Apr 05, 2021 at 01:04:59PM +0200, Greg KH wrote:
> > On Mon, Apr 05, 2021 at 07:50:09AM -0300, Luiz Sampaio wrote:
> > > Added a sysfs entry to support writing to the offset register on page1.
> > > This register is used to calibrate the chip canceling offset errors in the
> > > current ADC. This means that, over time, reading the IAD register will not
> > > return the correct current measurement, it will have an offset. Writing to
> > > the offset register if the two's complement of the current register while
> > > passing zero current to the load will calibrate the measurements. This
> > > change was tested on real hardware and it was able to calibrate the chip
> > > correctly.
> > > 
> > > Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
> > > ---
> > >  Documentation/w1/slaves/w1_ds2438.rst | 11 +++++-
> > >  drivers/w1/slaves/w1_ds2438.c         | 49 +++++++++++++++++++++++++++
> > >  2 files changed, 59 insertions(+), 1 deletion(-)
> > 
> > In this, and the previous patch, you added new sysfs files, but no
> > update to Documentation/ABI/ for them.  Please fix that up.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hello! I'm sorry about some errors, this is my first patch and I'm not sure about some things in the documentation. I really appreciate the responses and guidance.

No problem, again you should try wrapping your email lines :)

> The file I need to add to Documentation/ABI/ is going to be in testing or stable? And the file I need to create can be called, for instance, sysfs-driver-w1_ds2438?

stable I guess as you know this is what you want to do.

And the file name seems right, thanks.

greg k-h
