Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3A32067A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 18:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBTRjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 12:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 12:39:48 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9FFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 09:39:07 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDWDR-00GNt7-LN; Sat, 20 Feb 2021 17:38:49 +0000
Date:   Sat, 20 Feb 2021 17:38:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in iov_iter_revert (2)
Message-ID: <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk>
References: <0000000000001fb73f05bb767334@google.com>
 <0000000000000ca18b05bbc556d6@google.com>
 <CAHk-=wiEBTD884i-U9DU7aDdRxXuz66Q1r-rKTiJUzZoYFgp+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEBTD884i-U9DU7aDdRxXuz66Q1r-rKTiJUzZoYFgp+g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 08:56:40AM -0800, Linus Torvalds wrote:
> Al,
>  This is the "FIXME! Have Al check this!" case in do_tty_write(). You were
> in on that whole discussion, but we never did get to that issue...
> 
> There are some subtle rules about doing the iov_iter_revert(), but what's
> the best way to do this properly? Instead of doing a copy_from_iter() and
> then reverting the part that didn't fit in the buffer, doing a
> non-advancing copy and then advancing the amount that did fit, or what?
> 
> I still don't have power, so this is all me on mobile with html email
> (sorry), and limited ability to really look closer.
> 
> "Help me, Albi-wan Viro, you're my only hope"

Will check...  BTW, when you get around to doing pulls, could you pick
the replacement (in followup) instead of the first pull request for
work.namei?  Jens has caught a braino in the last commit there...
