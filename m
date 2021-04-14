Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B271335F9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351058AbhDNRhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:37:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:53592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350752AbhDNRhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:37:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618421815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqnsSjijlDG5mETYLx6fpmqZMJsm0kdSrlijsYb2gIA=;
        b=tOt8HYaznpNtfzYlBCt1743v9GFzCOSkq7kG21aRuvWJgkvndZaOARndMRilVmOz/ymyk9
        6vM/7Y9RbDT4xPFZc0Pvr+FTkH1B9mXhXORD7fwi5KLHXl+YWOq4q4ab8KW6eDXcjUEklY
        n5BxV9dWbWOWwlXitn/HWEFxtzkAYK0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81369B007;
        Wed, 14 Apr 2021 17:36:55 +0000 (UTC)
Date:   Wed, 14 Apr 2021 19:36:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Samo =?utf-8?B?UG9nYcSNbmlr?= <samo_pogacnik@t-2.net>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: How to handle concurrent access to /dev/ttyprintk ?
Message-ID: <YHcoNgbDyMbDKSf1@alley>
References: <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
 <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
 <YG24F9Kx+tjxhh8G@kroah.com>
 <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
 <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
 <ed5347ee800216fbbcb119ee3b5ad3070797fd1e.camel@t-2.net>
 <YHVnQfQ4zDt09RFe@alley>
 <157d81a5eb9e56e47e40c1cd652cdc7a915cb755.camel@t-2.net>
 <YHWrmuZ9tei0VTXN@alley>
 <e8726b52b576c04bf4dc41ccfd324ef8f29d17c9.camel@t-2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8726b52b576c04bf4dc41ccfd324ef8f29d17c9.camel@t-2.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-04-13 17:22:46, Samo Pogačnik wrote:
> Dne 13.04.2021 (tor) ob 16:32 +0200 je Petr Mladek napisal(a):
> > On Tue 2021-04-13 13:10:50, Samo Pogačnik wrote:
> > > Dne 13.04.2021 (tor) ob 11:41 +0200 je Petr Mladek napisal(a):
> > > > On Mon 2021-04-12 14:41:27, Samo Pogačnik wrote:
> > > > > Dne 12.04.2021 (pon) ob 19:39 +0900 je Tetsuo Handa napisal(a):
> > > > > > What is the intended usage of /dev/ttyprintk ?
> > > > > > 
> > > > > 
> > > > > The intended use of 'ttyprintk' is to redirect console to /dev/ttyprintk
> > > > > via the TIOCCONS ioctl. After successfull redirection, all console
> > > > > messages get "merged" with kernel messages and as such automatically
> > > > > processed
> > > > > (stored/transferred) by the syslog service for example.
> > > > 
> > > > The same can be achieved by /dev/kmsg that was created by systemd
> > > > developers.
> > > > 
> > > 
> > > 'kmsg' and 'ttyprintk' are different types of drivers and as such rather
> > > complementary than exclusive. The 'ttyprintk' being a tty driver allows 
> > > for a system wide automatic redirection of anything written to the
> > > console.
> > 
> > I might miss something. But how can one setup ttyprintk as the system
> > wide console? I do not see any code that would use ttyprintk
> > in struct console.
> > 
> 
> You can compile this simple code below and call:
> 
> # ./tioccons /dev/ttyprintk

Thanks a lot for the example.

My head is still spinning around it. I have troubles to update
my mental model around /dev/console with this use case.

My original model is that kernel or processes write into
/dev/console so that a human could see and read it
on the device attached to the console.

kernel is calling console->write() callback when showing new messages
on consoles. The write to the redirected /dev/console
makes the messages appear in the kernel log. It feels like
it should create an infinite loop. Except that it doesn't
work this way. Sigh.

Best Regards,
Petr
