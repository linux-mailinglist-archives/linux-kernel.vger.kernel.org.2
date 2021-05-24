Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28DB38E3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhEXKTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232527AbhEXKTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BBEA6101B;
        Mon, 24 May 2021 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621851497;
        bh=kl7sG6c7b2n95LuOe6JfZLESMIGEmvEGrH4zp+8NCIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NO5v25JENZH5C6hvW/L9noqqQxupk5pWd7AAGsTG0BoNUQXKqlrKg1ZXkYC+EdW6C
         IyJa2tkGUJjE34dGgoUXZk+1l9+hvk2sDzDjnKl/KkO93ONmBkjsqMOSDo4dYhXuia
         3wn8nQnD6taBoXrUT/mMz8tZq2TFNdFnVktwv/xA=
Date:   Mon, 24 May 2021 12:18:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: remove return value of debugfs_create_bool()
Message-ID: <YKt9Z82KbBQZIWVl@kroah.com>
References: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
 <CAMuHMdW42UAWRPWe09=0c=pkNLwwswoQHEbSHyXEjsfF6UZJdw@mail.gmail.com>
 <YKt0v2etlFzpvE9r@kroah.com>
 <CAMuHMdWL=Jy-PHMU3NTuc2YT=oK7gGGrrj008_k0ATivPsPc8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWL=Jy-PHMU3NTuc2YT=oK7gGGrrj008_k0ATivPsPc8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:51:42AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Mon, May 24, 2021 at 11:41 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, May 24, 2021 at 11:11:32AM +0200, Geert Uytterhoeven wrote:
> > > On Fri, May 21, 2021 at 10:28 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > No one checks the return value of debugfs_create_bool(), as it's not
> > > > needed, so make the return value void, so that no one tries to do so in
> > >
> > > Please explain in the patch description why it is not needed.
> >
> > Because you just do not need it, like almost all other debugfs calls
> > now.
> 
> Why do I just not need it?

Let me flip it around, why do you need it?  There are no in-kernel users
of the return value anymore so what code requires this pointer now?

The goal of removing these dentry pointers was that users were somehow
using the return value to determine code paths (like erroring out of
files were not created).  Debugfs code working or not working should
never matter, this is only for debugging features and we had a number of
cases where if debugfs was acting up, other "real" things would stop
working.

Yes, there are a few exceptions that some of the perf/trace people point
out, and they still check the return value of creating individual
debugfs files for good reasons.  But for any driver or a "normal" kernel
subsystem, they should not be doing that as it's wasteful and pointless.

debugfs is supposed to be "simple" and almost "fire and forget" as
possible.  By removing the ability to check return values, it helps
achieve this as I have seen all sorts of errors when trying to check the
return values of debugfs calls, mostly where people were thinking they
were checking for an error, yet they really were not.

So for the past few years, I've been slowly cleaning this all up,
removing the ability to get using the debugfs api wrong, which is the
end-goal here.  By allowing a return value to be forced to be checked,
developers have the ability to get it wrong (and they did.)

> > If you really do need the file dentry, there is still a call to create
> > it, and you can always query debugfs for the dentry after it is created
> 
> ... and will have to duplicate debugfs_create_bool() and friends, but
> with a return value.  This may introduce bugs, and will complicate
> maintenance, as any change to debugfs_create_bool() means all those
> copies need to be found and updated, too.

There are no in-kernel users that need to check this return value, so
what code are we talking about here?

thanks,

greg k-h
