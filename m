Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009A33D2499
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhGVMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 08:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232151AbhGVMrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:47:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E95560FEE;
        Thu, 22 Jul 2021 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626960489;
        bh=l67UetnxqFdjROTyaLXIKzADYZefAq1fW4lD9rhDbJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1c+Z/hIuXWavmOwXHO81rf8igLrlzmVrY9VnJ1il42bzeoEH0l5TY9c66FxoLHwNj
         4d7lVuw8CYRjkzhfOodW18pkLzD+YDB9MIGojymxycTfn6MyYTv6dAwUgrpEIzpoca
         isZGGeF7oXBBxZAypDx/G3bcaGE8XDTO/wfQ8sHA=
Date:   Thu, 22 Jul 2021 15:28:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
Message-ID: <YPlyZsuRJpkUwWiJ@kroah.com>
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
 <20210720090035.GB1406@agape.jhs>
 <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net>
 <YPfRf8dgFd+u5hzm@equinox>
 <0c2d97fa-e1e1-3564-98b8-37d5b9a1a9cb@lwfinger.net>
 <20210721182836.GX1931@kadam>
 <ed7b7d93-f754-dce9-ca4f-425e49c972ba@lwfinger.net>
 <CAA=Fs0nvhxEhJhCTWH_KkYyB3Jz7Pi-t2a+6zL3K=O-_3-sLGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=Fs0nvhxEhJhCTWH_KkYyB3Jz7Pi-t2a+6zL3K=O-_3-sLGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:44:10AM +0100, Phillip Potter wrote:
> On Wed, 21 Jul 2021 at 20:18, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> >
> > On 7/21/21 1:28 PM, Dan Carpenter wrote:
> > > You're obviously not a Realtek employee, but what are they doing for
> > > wireless drivers these days?
> >
> > You are correct in that I am not a Realtek employee, nor do I have any knowledge
> > of the internals of any of their chips. I do have a close working arrangement
> > with the head of their PCI driver development, and I have gotten free samples of
> > some of their chips. I am a volunteer that is interested in providing drivers
> > for the devices in new laptops with wireless chips that do not yet have a Linux
> > driver in the kernel. I also provide relatively modern drivers for older USB
> > devices through GitHub repos.
> >
> >  From what I know, the PCI group at Realtek is mainly working on new 802.11ac
> > devices, but are leaving some hooks for the USB and SDIO equivalents of those
> > chips (RTL8822BE, RTL8822CE, RTL8821CE, RTL8723DE, and RTL8852AE). These drivers
> > are either in the drivers/net/wireless tree of the kernel, or are under review
> > for such inclusion.
> >
> > I have no current contact with the USB part of their driver development.
> >
> > Larry
> >
> >
> Dear Larry,
> 
> Thank you for this info, it's very useful. Are you saying that in its
> current state the GitHub driver would not even be accepted into
> staging in your opinion? I am happy to continue improving it, but in
> my mind this should probably be done publicly, within the kernel tree.
> Not sure what others think but if there is general consensus then I
> can submit this new version to staging and integrate within build
> framework etc, then we can start improving it and getting it ready to
> move beyond that. Sounds like your driver is further along the path,
> and we should be using it, but I'm interested in what others think of
> course.

If the code looks "better", I have no objection to just adding it to
drivers/staging/ and deleting the existing one here, so that everyone
can work on this together in one single place.

Larry, any objection to that?

thanks,

greg k-h
