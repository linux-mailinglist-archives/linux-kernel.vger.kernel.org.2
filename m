Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E710321B83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhBVPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhBVPcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:32:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B53064EC3;
        Mon, 22 Feb 2021 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614007894;
        bh=O5oVzXeXDcQjdSLsH3D0UHdDHpNIqdFtFj8TS0MdwGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fpt8P6UnaBTUcspIelbCF3zsXvfFuavDZmasUK6CVpmHCZYM2fkHM5FxIttitqStG
         tXSBSBo3rmImvopkJDQaO9eA+Pr8tGiomW7+W5ufzCJHzY6D9yN0U9f1FkAUCRuw0j
         sj39KPcN3xx67aAgMZyf36nIq0w85O+xVArkmD7U=
Date:   Mon, 22 Feb 2021 15:24:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        cgardner@digitalocean.com, pmccormick@digitalocean.com
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YDO+nl6aI/Gl1LPd@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <20210222140052.GA1520276@breakout>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222140052.GA1520276@breakout>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 08:00:52AM -0600, Nishanth Aravamudan wrote:
> Hi Greg,
> 
> On 26.01.2021 [08:29:25 +0100], Greg Kroah-Hartman wrote:
> > On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
> > > Hi All,
> > > 
> > > The 5.10 LTS kernel being officially LTS supported for 2 years
> > > presents a problem: why would anyone select a 5.10 kernel with 2
> > > year LTS when 5.4 kernel has a 6 year LTS.
> 
> <snip>
> 
> > > If 5.10 is "actually" going to be supported for 6 years it would be
> > > quite valuable to make such a declaration.
> > > https://www.kernel.org/category/releases.html
> > 
> > Why?  What would that change?
> > 
> > Ok, seriously, this happens every year, and every year we go through
> > the same thing, it's not like this is somehow new, right?
> > 
> > I want to see companies _using_ the kernel, and most importantly,
> > _updating_ their devices with it, to know if it is worth to keep
> > around for longer than 2 years.  I also, hopefully, want to see how
> > those companies will help me out in the testing and maintenance of
> > that kernel version in order to make supporting it for 6 years
> > actually possible.
> > 
> > So, are you planning on using 5.10?  Will you will be willing to help
> > out in testing the -rc releases I make to let me know if there are any
> > problems, and to help in pointing out and backporting any specific
> > patches that your platforms need for that kernel release?
> > 
> > When I get this kind of promises and support from companies, then I am
> > glad to bump up the length of the kernel support from 2 to 6 years,
> > and I mark it on the web site.  Traditionally this happens in
> > Febuary/March once I hear from enough companies.  Can I count on your
> > support in this endeavor?
> 
> I am very sorry for the long delay on my end (I had privately e-mailed
> Greg on January 28) -- DigitalOcean also intends to provide feedback and
> testing on the 5.10 series. We intend to use it as the basis for our
> next-next kernel and are very invested in ensuring the stability and
> performance of the kernel.

Great!  If you need me to add your cc: to the -rc release announcements
so that you have an easy email to respond to, just let me know and I can
do so.

Any ideas when the testing will start happening?  There's a 5.10-rc
release out there right now if you want to start today :)

thanks,

greg k-h
