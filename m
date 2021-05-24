Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8F38E37D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhEXJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhEXJms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3C876117A;
        Mon, 24 May 2021 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621849281;
        bh=5MMWvN7bssAO7WTG5yIeQV/YR8JwXVwiZ4jViKGuU6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDGEcWbozve4vWL05kciC3auc3TJg+d/RuIS7dHTXIoVCmsxxYHKs3kL/3nuvPQfJ
         lli01AAag/ZeXa12z2J9XsspgFN4bKZgwarPs1ewyuuT6ZqsemcKdzDDI6PoDLOyLi
         xMGMWPNAs+lu18D4aWOWNcVQA2j7NPsWPVlDAV7k=
Date:   Mon, 24 May 2021 11:41:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: remove return value of debugfs_create_bool()
Message-ID: <YKt0v2etlFzpvE9r@kroah.com>
References: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
 <CAMuHMdW42UAWRPWe09=0c=pkNLwwswoQHEbSHyXEjsfF6UZJdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW42UAWRPWe09=0c=pkNLwwswoQHEbSHyXEjsfF6UZJdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:11:32AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> Thanks for your patch!
> 
> On Fri, May 21, 2021 at 10:28 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > No one checks the return value of debugfs_create_bool(), as it's not
> > needed, so make the return value void, so that no one tries to do so in
> 
> Please explain in the patch description why it is not needed.

Because you just do not need it, like almost all other debugfs calls
now.

> > the future.
> >
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> > --- a/fs/debugfs/file.c
> > +++ b/fs/debugfs/file.c
> > @@ -836,20 +836,11 @@ static const struct file_operations fops_bool_wo = {
> >   * This function creates a file in debugfs with the given name that
> >   * contains the value of the variable @value.  If the @mode variable is so
> >   * set, it can be read from, and written to.
> > - *
> > - * This function will return a pointer to a dentry if it succeeds.  This
> > - * pointer must be passed to the debugfs_remove() function when the file is
> > - * to be removed (no automatic cleanup happens if your module is unloaded,
> 
> Why isn't the above no longer true?

Because there is no return value.

> Are we no longer allowed to remove individual debugfs entries?

It's not something that is almost ever needed.

> Do we always have to remove the whole parent directory and all its
> contents together?

For 99% of all debugfs usages, yes, that is true.

If you really do need the file dentry, there is still a call to create
it, and you can always query debugfs for the dentry after it is created
if you need it later on.

thanks,

greg k-h
