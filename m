Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848EF389FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhETIXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETIXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:23:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 706FD60FDB;
        Thu, 20 May 2021 08:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621498902;
        bh=oWxI169wjo2M8TXbBtnWbk/CC+L/aPQaBjR392b98q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtLMNXiVjiEK+Dph+zxyljcXqY595W4KwG1mako/NR+gZoWAzlpd+SBHfUuLkUtaw
         M7FzRLyftRzcOpAxTKgl2IrqrRb0Y7OGo+zgaRUvM/mfFHx4wkxj9cc5XfbQkqg/86
         Eu4NQPjMUIU2Mtd2VG8SGVDgtEY3So3/6up2xxC+JGF1MBdmp1JFdJ0eTRNtf+DdMJ
         yLO8N1v2YbgPvt4oZNPRAoTPyD30God8QmAS+OQekZsvw6uHFhZ8ufiQ3On5F+nwDJ
         LmnVhc/OZZjnIuNZgXqUood6bcTwp/lPZZIyMO8RG6YK7fKl0ed3euZ/haAUg0HUx/
         hgNYYOa8yWTjw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljdw5-0001rd-1N; Thu, 20 May 2021 10:21:41 +0200
Date:   Thu, 20 May 2021 10:21:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH 6/9] tty: hvc_console: Fix coding style issues of block
 comments
Message-ID: <YKYcFfKiHT39Gyey@hovoldconsulting.com>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
 <1621233433-27094-7-git-send-email-tanxiaofei@huawei.com>
 <YKJ6ZjT8o5xJmBCr@hovoldconsulting.com>
 <e88b6fcd-bfe1-9812-905a-862825f420ce@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88b6fcd-bfe1-9812-905a-862825f420ce@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 12:01:22PM +0800, Xiaofei Tan wrote:
> Hi Johan,
> 
> Thanks for reviewing this patch.
> 
> On 2021/5/17 22:15, Johan Hovold wrote:
> > On Mon, May 17, 2021 at 02:37:10PM +0800, Xiaofei Tan wrote:
> >> Fix coding style issues of block comments, reported by checkpatch.pl.
> >> Besides, add a period at the end of the sentenses.
> >>
> >> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> >> ---
> >>  drivers/tty/hvc/hvc_console.c | 15 ++++++++++-----
> >>  1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> >> index 39018e5..a61cdf0 100644
> >> --- a/drivers/tty/hvc/hvc_console.c
> >> +++ b/drivers/tty/hvc/hvc_console.c
> >> @@ -177,7 +177,8 @@ static void hvc_console_print(struct console *co, const char *b,
> >>  			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
> >>  			if (r <= 0) {
> >>  				/* throw away characters on error
> >> -				 * but spin in case of -EAGAIN */
> >> +				 * but spin in case of -EAGAIN.
> >> +				 */
> >
> > How is this an improvement? First, the multi-line comment style is
> >
> > 	/*
> > 	 * ...
> > 	 */
> >
> 
> Yes, mostly we use this style. I can follow it if new version is needed.

This is the preferred style outside of networking.

> BTW, How about add the '/*' check into checkpatch.pl?

Checkpatch already has too many checks IMO and I'm a bit surprised that
it doesn't check this already. Perhaps it's because you used the -f to
run checkpatch on in-kernel code, which you should not.

> > Second, that sentence is not capitalised so why do add a period?
> >
> 
> How about capitalize the sentence, or just remove the period ?

How about just leaving this unchanged?

> > Third, why are you sending checkpatch.pl cleanups for files outside of
> > staging?
> >
> 
> I'm sorry, Is this a rule, or kind of tradition? I've never heard of 
> this before.

Many subsystems reject pure style changes unless you're also doing some
real changes to the code in question. This is a good default rule, even
if some maintainers may occasionally accept churn like this.

You appear to be paid to do kernel work. Why don't you start fixing bugs
or help out reviewing new code instead of sending trivial patches like
this? We can always need another hand.

But if all you you want is to increase your company patch count then
please go work in drivers/staging where most trivial style changes are
currently accepted.

> > Unless doing some real changes to the files in question as well this is
> > mostly just churn and noise that makes it harder to backport fixes and
> > do code forensics for no real gain.
> 
> I'm not sure. But if cleanup patches have made it hard to backport fixes 
> and do code forensics, then the code quality may not be
> good enough.

No, that has nothing to do with code quality, it's just that you
introduce noise in the logs and do pointless changes of context which
makes it harder to use tools like git blame and makes backporting harder
for no good reason.

Johan
