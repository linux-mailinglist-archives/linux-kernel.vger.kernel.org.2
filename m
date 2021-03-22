Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA5343FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCVLf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCVLf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:35:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED2461990;
        Mon, 22 Mar 2021 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616412925;
        bh=/XcKyZO8ktAMae1kWUPf6hkhJw692MVAaY1m5s5EAd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XL95h2dqm5YF/Qf5LnzbbWIksuqDpO5hXfmtsY6zuRm03b7b4XhJyoVqTqxgGqpT0
         kqR5LawUUl2tLQow+Go6+bxgSU7fYodMQrT0eu8aCQmNhJAj89S+taVn98A70rY+/7
         udPERza4JB1lhdVRUxoY3HHojUllAs8iemPJD31s=
Date:   Mon, 22 Mar 2021 12:35:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devcoredump: avoid -Wempty-body warnings
Message-ID: <YFiA+2/kgOWOyWHP@kroah.com>
References: <20210322102002.28990-1-arnd@kernel.org>
 <YFhxhyXLyTqp4ppH@kroah.com>
 <CAK8P3a2B4X98VMy-1E=mNX+96Dmika8Y-YdTn5E-_uWqK9JnWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2B4X98VMy-1E=mNX+96Dmika8Y-YdTn5E-_uWqK9JnWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 12:22:11PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 22, 2021 at 11:29 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Mar 22, 2021 at 11:19:53AM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > +      * These should normally not fail, but there is no problem
> > > +      * continuing without the links, so just warn instead of
> > > +      * failing.
> > > +      */
> > > +     WARN_ON_ONCE(sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > > +                                    "failing_device"));
> > >
> > > -     if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> > > -                           "devcoredump"))
> > > -             /* nothing - symlink will be missing */;
> > > +     WARN_ON_ONCE(sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> > > +                                    "devcoredump"));
> >
> > We do not want to reboot machines that have panic-on-warn set,
> 
> Fair enough.
> 
> > so if this really needs a trace dump, please do that instead...
> 
> I don't think the backtrace is needed here, if it ever happens it's either
> going to be -ENOMEM or completely reproducible. I can instead
> do the cast to (void) that Linus suggested, or a simple if(...) dev_warn()
> or dev_warn_once() to have some indication of the failure.

dev_warn() should be fine I think.

thanks,

greg k-h
