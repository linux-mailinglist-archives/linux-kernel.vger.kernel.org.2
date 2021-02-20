Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5EF3206ED
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBTTau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 14:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:30:49 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9277C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 11:30:08 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDXwz-00GPTD-HA; Sat, 20 Feb 2021 19:29:57 +0000
Date:   Sat, 20 Feb 2021 19:29:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in iov_iter_revert (2)
Message-ID: <YDFjNRv+DNL/Xh8W@zeniv-ca.linux.org.uk>
References: <0000000000001fb73f05bb767334@google.com>
 <0000000000000ca18b05bbc556d6@google.com>
 <CAHk-=wiEBTD884i-U9DU7aDdRxXuz66Q1r-rKTiJUzZoYFgp+g@mail.gmail.com>
 <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:38:49PM +0000, Al Viro wrote:
> On Sat, Feb 20, 2021 at 08:56:40AM -0800, Linus Torvalds wrote:
> > Al,
> >  This is the "FIXME! Have Al check this!" case in do_tty_write(). You were
> > in on that whole discussion, but we never did get to that issue...
> > 
> > There are some subtle rules about doing the iov_iter_revert(), but what's
> > the best way to do this properly? Instead of doing a copy_from_iter() and
> > then reverting the part that didn't fit in the buffer, doing a
> > non-advancing copy and then advancing the amount that did fit, or what?
> > 
> > I still don't have power, so this is all me on mobile with html email
> > (sorry), and limited ability to really look closer.
> > 
> > "Help me, Albi-wan Viro, you're my only hope"
> 
> Will check...  BTW, when you get around to doing pulls, could you pick
> the replacement (in followup) instead of the first pull request for
> work.namei?  Jens has caught a braino in the last commit there...

It turned out to be really amusing.  What happens is write(fd, NULL, 0)
on /dev/ttyprintk, with N_GSM0710 for ldisc (== "pass the data as
is to tty->op->write()".  And that's the first write since opening
that sucker, so we end up with
        /* write_buf/write_cnt is protected by the atomic_write_lock mutex */
        if (tty->write_cnt < chunk) {
                unsigned char *buf_chunk;

                if (chunk < 1024)
                        chunk = 1024;

                buf_chunk = kmalloc(chunk, GFP_KERNEL);
                if (!buf_chunk) {
                        ret = -ENOMEM;
                        goto out;
                }
                kfree(tty->write_buf);
                tty->write_cnt = chunk;
                tty->write_buf = buf_chunk;
        }
doing nothing - ->write_cnt is still 0 and ->write_buf - NULL.  Then
we copy 0 bytes from source to ->write_buf(), which reports that 0
bytes had been copied, TYVM.  Then we call
                ret = write(tty, file, tty->write_buf, size);
i.e.
                ret = gsm_write(tty, file, NULL, 0);
which calls
	tpk_write(tty, NULL, 0)
which does
	tpk_printk(NULL, 0);
and _that_ has a very special semantics:
        int i = tpk_curr;

        if (buf == NULL) {
                tpk_flush();
                return i;
        }  
i.e. it *can* return a positive number that gets propagated all way
back to do_tty_write().  And then you notice that it has reports
successful write of amount other than what you'd passed and tries
to pull back.  By amount passed - amount written.  With iov_iter_revert()
saying that some tosser has asked it to revert by something close to
~(size_t)0.

IOW, it's not iov_iter_revert() being weird or do_tty_write() misuing it -
it's tpk_write() playing silly buggers.  Note that old tree would've
gone through seriously weird contortions on the same call:
	// chunk and count are 0, ->write_buf is NULL
        for (;;) {
                size_t size = count;
                if (size > chunk)
                        size = chunk;
                ret = -EFAULT;
                if (copy_from_user(tty->write_buf, buf, size))
                        break;
                ret = write(tty, file, tty->write_buf, size);
                if (ret <= 0)
                        break;
                written += ret;
                buf += ret;
                count -= ret;
                if (!count)
                        break;
                ret = -ERESTARTSYS;
                if (signal_pending(current))
                        break;
                cond_resched();
        }
and we get written = ret = small positive, count = - that amount,
buf = NULL + that mount.  On the next iteration size = 0 (since
chunk is still 0), with same no-op copy_from_user() of 0 bytes,
then gsm_write(tty, file, NULL, 0) and since tpk_flush() zeroes
tpk_curr we finally get 0 out of tpk_printk/tpk_write/gsm_write
and bugger off on if (ret <= 0).  Then we have the value in written
returned.

So yeah, this return value *was* returned to userland.  Except that
if we had done any writes before that, we'd find ->write_buf
non-NULL and the magical semantics of write(fd, NULL, 0) would
*not* have triggered - we would've gotten zero.

Do we want to preserve that weirdness of /dev/ttyprintk writes?
That's orthogonal to the iov_iter uses in there.
