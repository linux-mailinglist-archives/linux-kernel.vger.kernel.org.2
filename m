Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A03790DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbhEJOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237031AbhEJOcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:32:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A2D0611F0;
        Mon, 10 May 2021 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620657075;
        bh=J00+jLQSmHK4tXHXw9Obmf4p8yp9IGxCpWdDWVY67f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuZnKSj4VmKw9ryAeD+ztwGR9KOU9XSSMgNpqAmfzRBD6wh+VFeRlvxV03ccO8VjJ
         wEVozZMC2Y8WyNOD+b+8fCAXDmM6IGrFjbAlN57xnnM2ci1kZuwf50Xtud+3Swd//M
         rPLm8pg3GbO0xoOtDimTh1QCXk0/QMviuRvXRCEA=
Date:   Mon, 10 May 2021 16:31:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] habanalabs fixes for 5.13-rc2
Message-ID: <YJlDsZMuPs8U1kD9@kroah.com>
References: <20210508083931.GA21544@CORE.localdomain>
 <YJZPCMnB7/sktOF1@kroah.com>
 <CAFCwf11uA7PscSpkQ7BD+FW7+dFy1_GoeaPJSLDS_VnQKhoa6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11uA7PscSpkQ7BD+FW7+dFy1_GoeaPJSLDS_VnQKhoa6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 11:46:14AM +0300, Oded Gabbay wrote:
> On Sat, May 8, 2021 at 11:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, May 08, 2021 at 11:39:31AM +0300, Oded Gabbay wrote:
> > > Hi Greg,
> > >
> > > This pull request contains a number of important fixes for 5.13-rc2.
> > > Mainly fixes to support our new F/W with enhanced security features,
> > > but also additional bugs.
> > > See details in the tag message below.
> >
> > Does this include the stuff in your previous pull request?  Should I
> > drop that one from my queue or do both?
> >
> > I will be waiting until after 5.13-rc1 before I can take any of these...
> >
> > thanks,
> >
> > greg k-h
> 
> Yes, it includes that one. For some reason, lkml didn't show me that
> the previous email was sent so I thought there was again a problem in
> the mail server.
> And therefore, I've sent this one again with 1 additional fix compared
> to the previous one.
> So you can drop the previous one.

Ok, now dropped the old one and pulled in this one, thanks!

greg k-h
