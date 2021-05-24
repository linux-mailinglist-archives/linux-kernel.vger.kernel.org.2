Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9F38E6BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhEXMkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232401AbhEXMkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:40:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B13D61151;
        Mon, 24 May 2021 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621859960;
        bh=l3xPe2lhWHIYK4wV1oJwSCUElmD5vjU5CFzuStu8lxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2wJBep5R8C3C/wAZz+goJYRT6DFlF3WoM/Khzte2qhHrEp3TeXfBBKDWCvsiejLl
         4+P3Lh/E9boZdhuPRguUmnw6MC8yr2v9tmg+WPqF1hSxYdJtgr1sYOYJMTXHcU6xbZ
         ycDCrflXagO/C9+ZORvyN1M3X9QrTRM7XnAC3HfE=
Date:   Mon, 24 May 2021 14:39:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: remove return value of debugfs_create_bool()
Message-ID: <YKuedipmEjIW91Jr@kroah.com>
References: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
 <CAMuHMdW42UAWRPWe09=0c=pkNLwwswoQHEbSHyXEjsfF6UZJdw@mail.gmail.com>
 <YKt0v2etlFzpvE9r@kroah.com>
 <CAMuHMdWL=Jy-PHMU3NTuc2YT=oK7gGGrrj008_k0ATivPsPc8w@mail.gmail.com>
 <YKt9Z82KbBQZIWVl@kroah.com>
 <CAMuHMdXbSyresZNUqq-g4=HNFXqtj2QkPpN1s0LRjmOnNPxn8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXbSyresZNUqq-g4=HNFXqtj2QkPpN1s0LRjmOnNPxn8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 01:44:38PM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Mon, May 24, 2021 at 12:18 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, May 24, 2021 at 11:51:42AM +0200, Geert Uytterhoeven wrote:
> > > On Mon, May 24, 2021 at 11:41 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Mon, May 24, 2021 at 11:11:32AM +0200, Geert Uytterhoeven wrote:
> > > > > On Fri, May 21, 2021 at 10:28 PM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > No one checks the return value of debugfs_create_bool(), as it's not
> > > > > > needed, so make the return value void, so that no one tries to do so in
> > > > >
> > > > > Please explain in the patch description why it is not needed.
> > > >
> > > > Because you just do not need it, like almost all other debugfs calls
> > > > now.
> > >
> > > Why do I just not need it?
> >
> > Let me flip it around, why do you need it?  There are no in-kernel users
> > of the return value anymore so what code requires this pointer now?
> 
> There still are a few users of other members in the family, and some
> of them are meant to be removed without removing the full parent
> directory.  Having all debugfs_create_*() functions behave the same
> is a bonus.

I agree, and we are almost there, all that is left is:
	debugfs_create_blob()
	debugfs_create_file()
	debugfs_create_file_unsafe()
for creating debugfs files.

There is still:
	debugfs_create_dir()
	debugfs_create_symlink()
	debugfs_create_automount()
for non-file creations that do not return void.

The majority of the debugfs_create_* functions now do not return
anything.

> But if other people are fine with having to call
> debugfs_remove(debugfs_lookup(...)), well, let it be like that...

It saves at least a static variable, so what's not to like?  :)

thanks,

greg k-h
