Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0757435C448
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhDLKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239563AbhDLKoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:44:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF2C861352;
        Mon, 12 Apr 2021 10:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618224252;
        bh=jaUjw9jdCoa/kW2ss/w164O+JcnoSqFLMQ7dJlya/ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6TxLJVU/L0NhiWT7GLa1oR8VBCImnSQEobywA4JrG8yybgcizA8b9D5woArzhzNU
         FVP7djuJ0GofpO8Q5t7LWXocQ7bl7fqOmZCjwLgiZMwfq7dbZxlcA5qbDgARDpAW16
         kfIRpxMB408IVZWLbcM6NL1sUPSEysIfbZvU4vVo=
Date:   Mon, 12 Apr 2021 12:44:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Samo Pogacnik <samo_pogacnik@t-2.net>,
        Petr Mladek <pmladek@suse.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: How to handle concurrent access to /dev/ttyprintk ?
Message-ID: <YHQkeZVs3pmyie9e@kroah.com>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
 <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
 <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
 <YG24F9Kx+tjxhh8G@kroah.com>
 <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
 <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 07:39:04PM +0900, Tetsuo Handa wrote:
> What is the intended usage of /dev/ttyprintk ?
> 
> It seems that drivers/char/ttyprintk.c was not designed to be opened by
> multiple processes. As a result, syzbot can trigger tty_warn() flooding
> enough to fire khungtaskd warning due to tty_port_close().
> 
> Do we need to allow concurrent access to /dev/ttyprintk ?
> If we can't change /dev/ttyprintk exclusively open()able by only
> one thread, how to handle concurrent access to /dev/ttyprintk ?

Like any tty port, if you have multiple accesses, all bets are off and
hilarity ensues.  Just don't do that and expect things to be working
well.

And trying to "open exclusive only" just does not work, the kernel can
not enforce that at all, sorry.  Any driver that you see trying to do
that is trivial to work around in userspace, making the kernel code
pointless.

That being said, triggering warning messages is not good, we should fix
that where possible as what's preventing any other tty device from doing
the same?

thanks,

greg k-h
