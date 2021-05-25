Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE8038FBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhEYHtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhEYHtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:49:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFE486128B;
        Tue, 25 May 2021 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621928893;
        bh=P+PllHqMuh+hS59i4iVdppeAUj9XXQuHIklVnWcWX94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0zyZYtFD7ZgbFRIhaW5NyiomeCGZjHh3SKhOPLveqKrAnP4jT03OervbSUj2n4kNT
         k3qyHG8q6rFPZ8Y9oR1T0ZYGMfV4HfkATmReSzl7M5i4Q1GKbNoVj3bTmoBYnmafyI
         tIuv6FWCbvIHtz2zacr4Y4zOKW/1mXCBmEW5B/0g=
Date:   Tue, 25 May 2021 09:48:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: remove return value of debugfs_create_bool()
Message-ID: <YKyrusKNbH+8tpcY@kroah.com>
References: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
 <CAMuHMdW42UAWRPWe09=0c=pkNLwwswoQHEbSHyXEjsfF6UZJdw@mail.gmail.com>
 <YKt0v2etlFzpvE9r@kroah.com>
 <CAMuHMdWL=Jy-PHMU3NTuc2YT=oK7gGGrrj008_k0ATivPsPc8w@mail.gmail.com>
 <YKt9Z82KbBQZIWVl@kroah.com>
 <CAMuHMdXbSyresZNUqq-g4=HNFXqtj2QkPpN1s0LRjmOnNPxn8w@mail.gmail.com>
 <YKuedipmEjIW91Jr@kroah.com>
 <CAMuHMdUhSKFrcaiB0KHsgg1=4_RX3XjUpzMV=Y=RxErRmsn=sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUhSKFrcaiB0KHsgg1=4_RX3XjUpzMV=Y=RxErRmsn=sA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 09:26:42AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Mon, May 24, 2021 at 2:39 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, May 24, 2021 at 01:44:38PM +0200, Geert Uytterhoeven wrote:
> > > On Mon, May 24, 2021 at 12:18 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Mon, May 24, 2021 at 11:51:42AM +0200, Geert Uytterhoeven wrote:
> > > > > On Mon, May 24, 2021 at 11:41 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > On Mon, May 24, 2021 at 11:11:32AM +0200, Geert Uytterhoeven wrote:
> > > > > > > On Fri, May 21, 2021 at 10:28 PM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > No one checks the return value of debugfs_create_bool(), as it's not
> > > > > > > > needed, so make the return value void, so that no one tries to do so in
> > > > > > >
> > > > > > > Please explain in the patch description why it is not needed.
> > > > > >
> > > > > > Because you just do not need it, like almost all other debugfs calls
> > > > > > now.
> > > > >
> > > > > Why do I just not need it?
> > > >
> > > > Let me flip it around, why do you need it?  There are no in-kernel users
> > > > of the return value anymore so what code requires this pointer now?
> > >
> > > There still are a few users of other members in the family, and some
> > > of them are meant to be removed without removing the full parent
> > > directory.  Having all debugfs_create_*() functions behave the same
> > > is a bonus.
> >
> > I agree, and we are almost there, all that is left is:
> >         debugfs_create_blob()
> >         debugfs_create_file()
> >         debugfs_create_file_unsafe()
> > for creating debugfs files.
> >
> > There is still:
> >         debugfs_create_dir()
> >         debugfs_create_symlink()
> >         debugfs_create_automount()
> > for non-file creations that do not return void.
> >
> > The majority of the debugfs_create_* functions now do not return
> > anything.
> >
> > > But if other people are fine with having to call
> > > debugfs_remove(debugfs_lookup(...)), well, let it be like that...
> >
> > It saves at least a static variable, so what's not to like?  :)
> 
> Which is more than offset by the cost of the new debugfs_lookup() call...

Not when people were keeping a dentry-per-entry in lots of structures.
That's from the heap, this dentry pointer sits on the stack, or if we
are lucky, only in a register :)

thanks,

greg k-h
