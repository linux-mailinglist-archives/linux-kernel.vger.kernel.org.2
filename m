Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71920336F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhCKJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhCKJob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:44:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDE4164F4D;
        Thu, 11 Mar 2021 09:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615455871;
        bh=SaEIjM8sp4BLwWqGdZsQ+udzNVG7cu3QRpUq15na99g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkmM9L6l20aZWALR1j9F37d1oS1MH2iZnRT5Uufp9E4ugDu2LFp/7lOmJv0XlFuDO
         naPtrvYUoj4H3Rj5Y65s5Y6En5e+P+KnkKUVqiwNDkz23h5qpYs/n0Him0ZmWQonjE
         JZPDRq34COMnNuM+Od7+Ss9+1XcTm4FebnBcq35E=
Date:   Thu, 11 Mar 2021 10:44:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Li <dualli@chromium.org>
Cc:     devel@driverdev.osuosl.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        arve@android.com, Martijn Coenen <maco@google.com>,
        hridya@google.com, surenb@google.com, christian@brauner.io,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v1 1/3] binder: BINDER_FREEZE ioctl
Message-ID: <YEnmfM+VmVPUIZ4W@kroah.com>
References: <20210310225251.2577580-1-dualli@chromium.org>
 <20210310225251.2577580-2-dualli@chromium.org>
 <YEnH1qd527g/neY4@kroah.com>
 <CA+xfxX4tD30BJLgwLAoiMzF7xTC-4q1i0A5Znp3tJzyi3ATLzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+xfxX4tD30BJLgwLAoiMzF7xTC-4q1i0A5Znp3tJzyi3ATLzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:36:26AM -0800, Li Li wrote:
> On Wed, Mar 10, 2021 at 11:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Mar 10, 2021 at 02:52:49PM -0800, Li Li wrote:
> > >       if (target_proc) {
> > >               binder_inner_proc_lock(target_proc);
> > > +             target_proc->outstanding_txns--;
> > > +             WARN_ON(target_proc->outstanding_txns < 0);
> >
> > WARN_* is a huge crutch, please just handle stuff like this properly and
> > if you really need to, warn userspace (but what can they do about it?)
> >
> > You also just rebooted all systems that have panic-on-warn set, so if
> > this can be triggered by userspace, you caused a DoS of things :(
> >
> > So please remove all of the WARN_ON() you add in this patch series to
> > properly handle the error conditions and deal with them correctly.
> >
> > And if these were here just for debugging, hopefully the code works
> > properly now and you do not need debugging anymore so they can all just
> > be dropped.
> 
> When the target_proc is freed, there's no outstanding transactions already.
> The FREEZE ioctl from userspace won't trigger this. It's for debugging.

It's ok to test for this, to verify all is good, just do not reboot
people's machines if the test fails :)

thanks,

greg k-h
