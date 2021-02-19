Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4431F5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBSIZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSIZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:25:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8981564ECA;
        Fri, 19 Feb 2021 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613723111;
        bh=vAB2VObCR2rKd1B0FQIfarguQ4GHbrFPlctGsXxoTFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGsQ2K6AA0wDclFL32XdYT9ThrLMo35dM7y+P+dmwWSnnI0huiCIrKWNTPCLxJuDh
         zazk8dkMVmVdtxfTaVnYqIU/+G+GxdtW8xFskdFpjG89CeVHepQqVnsghzTxyjlcrY
         sTq8zBUsklgxRxIC/YZACF6YvbKUOlKqp6RU1zW0=
Date:   Fri, 19 Feb 2021 09:25:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Willy Tarreau <w@1wt.eu>, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC915N/9YNqePueL@kroah.com>
References: <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com>
 <YC6ptKgsMh20tmu6@kroah.com>
 <20210218182050.GB15217@1wt.eu>
 <YC6zq3u2jciI2gyZ@kroah.com>
 <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:16:50PM -0800, Scott Branden wrote:
> On 2021-02-18 10:36 a.m., Greg Kroah-Hartman wrote:
> > On Thu, Feb 18, 2021 at 07:20:50PM +0100, Willy Tarreau wrote:
> >> On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
> >>> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
> >>>> As a company, we are most likely shooting ourselves in the foot by not
> >>>> having a point of coordination with the Linux Foundation and key people
> >>>> like you, Greg and other participants in the stable kernel.
> >>>
> >>> What does the LF have to do with this?
> >>>
> >>> We are here, on the mailing lists, working with everyone.  Just test the
> >>> -rc releases we make and let us know if they work or not for you, it's
> >>> not a lot of "coordination" needed at all.
> >>>
> >>> Otherwise, if no one is saying that they are going to need these for 6
> >>> years and are willing to use it in their project (i.e. and test it),
> >>> there's no need for us to maintain it for that long, right?
> >>
> >> Greg, please remember I expressed I really need them for slightly more than
> >> 3 years (say 3.5-4) :-) I'm fine with helping a bit more as time permits if
> >> this saves me from having to take over these kernels after you, like in the
> >> past, but I cannot engage on the regularity of my availability.
> > 
> > Ok, great!
> > 
> > That's one person/company saying they can help out (along with what CIP
> > has been stating.)
> > 
> > What about others?  Broadcom started this conversation, odd that they
> > don't seem to want to help out :)
> Greg, I'm sorry but I'm not in a position to provide such a commitment.

Ok, who at Broadcom do I need to talk to to get that type of commitment?

> My original question arose because the 5.10 kernel is declared as 2 years LTS while older LTS kernels are now 6 years.
> One problem this has created is requests to provide silicon support in an older kernel version (for a new project) rather than starting from a newer kernel version that more properly supports the (silicon and non-silicon) features.  

Sounds like your development model is broken, again, who do I need to
talk to in order to help you all fix this?

thanks,

greg k-h
