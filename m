Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9241E877
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352535AbhJAHkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231226AbhJAHkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:40:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F90A6134F;
        Fri,  1 Oct 2021 07:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633073900;
        bh=m63g2BPNq+7f3v5+4Cuh7P1VNmaaZbNoajOLjNh6tZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJFZxLo66fpnq7oCxMI4zDtR7CY81061P6TnVM13+w0LUDDSI4sfeGlOG1lFDMQHQ
         e533PYsb8yb1TakxjqnA6grteDjY7onMw+xTRvnagUqhVa/hY4y8qf9YHzM9fsey6I
         bwv1uWUAmFx4hBHxzQuJgiXsxzznf6C1C6VuT8ao=
Date:   Fri, 1 Oct 2021 09:38:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] dyndbg updates for 5.15-rcX
Message-ID: <YVa66i8xoRAu6/NZ@kroah.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
 <YVVTxZDkGUk7dGLp@kroah.com>
 <CAJfuBxxhoEs6z+HQ-ts55TbzfuVvxh=YPtEjqnqB6ZOOgiiMBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxxhoEs6z+HQ-ts55TbzfuVvxh=YPtEjqnqB6ZOOgiiMBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 03:33:44PM -0600, jim.cromie@gmail.com wrote:
> On Thu, Sep 30, 2021 at 12:06 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 29, 2021 at 12:37:29PM -0600, Jim Cromie wrote:
> > > Hi Jason, Greg,
> > >
> > > Heres a set of "maintenance" patches distilled out of other work.  Its
> > > almost all tweaks to verbose output, except for 1st, which changes a
> > > strcmp to == because its true, and useful going forward.
> > >
> > > Jim Cromie (6):
> > >   dyndbg: recode for stronger precondition
> > >   dyndbg: show module in vpr-info in dd-exec-queries
> > >   dyndbg: rationalize verbosity
> > >   dyndbg: use alt-quotes in vpr-infos, not those user might use
> > >   dyndbg: vpr-info on remove-module complete, not starting
> > >   dyndbg: no vpr-info on empty queries
> > >
> > >  .../admin-guide/dynamic-debug-howto.rst       |  2 +-
> > >  lib/dynamic_debug.c                           | 47 ++++++++++---------
> > >  2 files changed, 26 insertions(+), 23 deletions(-)
> >
> > Are these real bug fixes that have to get into 5.15-final?  They seem
> > like 5.16-rc1 patches instead.
> >
> 
> not real bug fixes.
> I thought maybe theyre low-risk enough, maybe on rc1+, but I was late.

Then please do not force me to be the one to push back, you know the
development model...

> I'll try to hit the window right for 5.16

So do you want me to pick these up now for my -next branch to get proper
testing in time for 5.16-rc1?

thanks,

greg k-h
