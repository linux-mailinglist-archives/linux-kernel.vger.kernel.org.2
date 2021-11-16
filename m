Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C454534C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbhKPPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:01:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhKPPBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:01:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9AF361A6C;
        Tue, 16 Nov 2021 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637074726;
        bh=jo6zLqudPIyFlh8R9gmIDryAEsXB/sV64HAyB/S+NCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6kLKMEXOcIJNSeBAFX2rdtHyat23MgoG8BNJ944IjjATuPyLbBB+wEzTsV7hcyOr
         hzcxDkOyk85GqBNxKmWfhP3tdjwmQ4J7/PNKCFhbuEv9nD03eyoc4kMe9PwUf4nTh3
         qhg2YJraGy2XB4EkGK49Y786gDq2Ou3krRveJi+A=
Date:   Tue, 16 Nov 2021 15:58:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] vt: Fix sleeping functions called from atomic context
Message-ID: <YZPHJE2R4VCQ20Za@kroah.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116144937.19035-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 03:49:37PM +0100, Fabio M. De Francesco wrote:
> Fix two sleeping functions called from atomic context by doing immediate
> return to the caller if !preemptible() evaluates 'true'. Remove two
> in_interrupt() tests because they are not suited for being used here.
> 
> Since functions do_con_write() and con_flush_chars() might sleep in
> console_lock(), it must be assured that they are never executed in
> atomic contexts.
> 
> This issue is reported by Syzbot which notices that they are executed
> while holding spinlocks and with interrupts disabled. Actually Syzbot
> emits a first report and then, after fixing do_con_write(), a second
> report for the same problem in con_flush_chars() because these functions
> are called one after the other by con_write().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 7359c3e80d63..508f8a56d361 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
>  	struct vt_notifier_param param;
>  	bool rescan;
>  
> -	if (in_interrupt())
> +	if (!preemptible())
>  		return count;

Very odd, what code is calling these functions to trigger this check?
Shouldn't the caller be fixed instead?

What changed to suddenly cause this to show up?

Given that this check has been here for a _very_ long time, changing it
now without finding out the root cause is probably not a good idea.

thanks,

greg k-h
