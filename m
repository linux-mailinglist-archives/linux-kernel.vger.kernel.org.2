Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247F43F0597
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhHROEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238668AbhHROE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:04:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3590B61051;
        Wed, 18 Aug 2021 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629295431;
        bh=OtHThCXmHDiPy0w6lt1fEL2vmZQbCKRBjm4W84idpsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rx5TKLHCisM/jt55skOkrCVNfntYjFdCbIbtDzpTNmpkAOX3ImgebHL812XZe9ulp
         H3rzMUDDOc7Hn90T6JvADqe0HfCHjXI1gELcST56HOlqVKFtco9drONZmebFDHtXrC
         LLoRvnCDGEj6p6Z8VRpRN06sCWJhksk9xWclybp8=
Date:   Wed, 18 Aug 2021 16:03:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phi Nguyen <phind.uet@gmail.com>
Cc:     jirislaby@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: Fix data race between tiocsti() and flush_to_ldisc()
Message-ID: <YR0TRf+283ujBxbv@kroah.com>
References: <20210807190513.3810821-1-phind.uet@gmail.com>
 <YRYgSZwivcPPMhrS@kroah.com>
 <7323d825-f596-223b-a063-7539a6a57107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7323d825-f596-223b-a063-7539a6a57107@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 02:35:53AM +0800, Phi Nguyen wrote:
> On 8/13/2021 3:33 PM, Greg KH wrote:
> > > 
> > > Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> > > Reported-by: syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
> > > ---
> > >   drivers/tty/tty_io.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > > index e8532006e960..746fe13a2054 100644
> > > --- a/drivers/tty/tty_io.c
> > > +++ b/drivers/tty/tty_io.c
> > > @@ -2307,8 +2307,10 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
> > >   	ld = tty_ldisc_ref_wait(tty);
> > >   	if (!ld)
> > >   		return -EIO;
> > > +	tty_buffer_lock_exclusive(tty->port);
> > >   	if (ld->ops->receive_buf)
> > >   		ld->ops->receive_buf(tty, &ch, &mbz, 1);
> > > +	tty_buffer_unlock_exclusive(tty->port);
> > 
> > Did this fix the syzbot reported issue?
> > 
> > thanks,
> > 
> > greg k-h
> > Yes, this fixed the syzbot reported issue.
> 
> The lock is grabbed in flush_to_ldisc() and paste_selection().
> Actually, I follow the document in tty_buffer.c, where it say the callers to
> receive_buff() other than flush_to_ldisc() need to exclude the kworker from
> concurrent use of the line discipline.
> 
> And function tiocsti() has the following comment:
> /* FIXME: may race normal receive processing */
> that why I add lock in this function.

As you are fixing this FIXME, please remove it in this patch, otherwise
we will not know it is resolved :)

Can you add that to the change and submit a new version?

Also, this should go to stable kernels, right?  Any idea how far back?

thanks,

greg k-h
