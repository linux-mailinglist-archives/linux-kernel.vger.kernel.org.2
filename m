Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14845358BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhDHSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232086AbhDHSDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:03:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC08061108;
        Thu,  8 Apr 2021 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617905015;
        bh=TVPVQSOPkrjYMm2nIE0o8xyEhW/gHJq9F1FdtxW2nU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2XEgsOT2CCzg9QwpwFv4rtcCHNbgTkAZHAO72l2GDkn1NymQmwgiaBq1sDz7L4yJw
         yfK3TMiamAUFmOdNNPGVt8xzxm5TuzueWnvtub8Db79Qe6zzohr2ZWpinKb7yL/Kle
         5f83XrXzd2qZQExuNjHm9zlxj8FHW2+DOdab5dP4=
Date:   Thu, 8 Apr 2021 20:03:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 05/13] tty: remove tty_warn()
Message-ID: <YG9FdNDuEZjv2x+B@kroah.com>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
 <20210408125134.3016837-6-gregkh@linuxfoundation.org>
 <92b1f39d-9c9c-c319-a351-f3cb9a1c0497@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b1f39d-9c9c-c319-a351-f3cb9a1c0497@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:47:21PM +0900, Tetsuo Handa wrote:
> On 2021/04/08 21:51, Greg Kroah-Hartman wrote:
> > Remove users of tty_warn() and replace them with calls to dev_warn()
> > which provides more information about the tty that has the error and
> > uses the standard formatting logic.
> 
> Ouch. This series would be good for clean up, but this series might be
> bad for handling lockdep warning syzbot is reporting.

Again, we can worry about lockdep stuff for the real places where it
matters, which should not have been the same place as all of these were
used (they were used very infrequently.)

> Since tty_warn() is using plain printk(), we can avoid lockdep warning by
> using printk_deferred(). If we use dev_warn() instead, we need to modify
> __dev_printk() to use printk_deferred(), which means that all dev_*() users
> are affected by this change.

I don't want to use printk_deffered() if at all possible, let's let the
printk developers fix up their implementation which should make that
change not needed.

And worst case, take the few places that really really really need it,
and call printk_deferred() so it's obvious what we are doing.

> Also, we need to modify dev_printk_emit()/dev_vprintk_emit() callers to embed
> loglevel into the format string so that we pass LOGLEVEL_SCHED to vprintk_emit() ...
> maybe just change from "if (!in_sched)" to "if (!in_sched && !dev_info)" instead ?

Huh?  No.

> Also, dev_vprintk_emit() need to start calling defer_console_output()
> after returning from vprintk_emit() in order to behave like printk_deferred().

Again, no.  If we really need to deferr a printk, let's call that, but
that should not be the case for all of the places these macros were
used.

thanks,

greg k-h
