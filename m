Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20F73FC426
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbhHaIP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:15:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34926 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbhHaIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:15:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D42372217E;
        Tue, 31 Aug 2021 08:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630397670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P06mgBVhu7SToXRTIjbn4FFfskaKgBH5tX1DHYjs8SI=;
        b=SbN2cgNBwfZnQjRbiVXd7pzA7ET81U1BM8QQbbLsIsLQuYpgWq/8kLpZWZlTNDU5DwyvcC
        30BkeqmTQ5Lzveyef6vDydHSwdLuDoaz9okLQUitAFx2qZc2WmYP72eXSNZHRPFfvsqpiR
        8yqY/HkwITbmiD4NNFRkik97DZOIIy0=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 66F6FA3B8C;
        Tue, 31 Aug 2021 08:14:30 +0000 (UTC)
Date:   Tue, 31 Aug 2021 10:14:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        James Wang <jnwang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel hang during reboot when cmdline include a non-exist
 console device
Message-ID: <YS3k5TRf5oLLEdKu@alley>
References: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
 <YS2fZ1sknFYKtJFi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS2fZ1sknFYKtJFi@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the reporter into Cc.

On Tue 2021-08-31 12:17:59, Sergey Senozhatsky wrote:
> On (21/08/30 19:53), Linus Torvalds wrote:
> > 
> > There's a bugzilla for this, but let's just move it to reguilar email,
> > unless some of you want to track it that way.
> > 
> > The bugzilla entry says
> > 
> >   "When reboot， the capslock key of thinkpad x1 starts blinking"
> > 
> > which sounds like there's an oops that just isn't showing, quite
> > possibly because the console has already been shut down.
> > 
> > I didn't test this out, and would sincerely hope that somebody else is
> > willing to follow up on it since I'm in the busiest part of the merge
> > window.
> 
> [..]
> 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=214201
> 
> I think normally wrong/empty console boot argument should not cause
> problems. We have a huge number of devices that use console="", for
> instance. But on some hardware this triggers panic(), very early on.
> 
> I have the same symptoms on my laptop, and so far haven't been able
> to figure out how to track it down, but I need to re-start my investigation.

Sergey, I think that you talk about the crash where there is no registered
console and console_on_rootfs() fails to create stdin, stdout, and
stderr for the init process. As a result the kernel crashes
during boot.

But the bugreport says that the system booted. It crashed later during
reboot. It will likely be in the shutdown phase. It still might be still
be caused by the missing console. But we should rule out other
problems.

James, do you see the problem:

  1. When there is a real console registered. When you remove the
     wrong console= parameter.

  2. When using "reboot -f" so that the system reboots a dirty way
     without trying to shut down services.

Best Regards,
Petr
