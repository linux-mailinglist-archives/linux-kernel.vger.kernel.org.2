Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86F335DB71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhDMJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:41:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:37882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhDMJlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:41:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618306882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZbiWEY1ZGa88fflkVy9Zsq5S0LAQAGZzATGFIfnvo24=;
        b=r01TZ0Gyikr6o0kpHPaxvRi7/n4JWcOw4PzjCrp0O65q9AtvYJaYcaN0TVyDZ/GKzRV3H1
        knnOWELXJ7/7G42jVdXZmWabufuoNUAnjulGNfIGHQK8yIH4AeLAoLyZgPSAjI39fvoXk1
        c7gwGpf9p5jnZmCeCIdTaSzWTiVWy2E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 530B3B130;
        Tue, 13 Apr 2021 09:41:22 +0000 (UTC)
Date:   Tue, 13 Apr 2021 11:41:21 +0200
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
Message-ID: <YHVnQfQ4zDt09RFe@alley>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
 <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
 <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
 <YG24F9Kx+tjxhh8G@kroah.com>
 <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
 <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
 <ed5347ee800216fbbcb119ee3b5ad3070797fd1e.camel@t-2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed5347ee800216fbbcb119ee3b5ad3070797fd1e.camel@t-2.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-04-12 14:41:27, Samo Pogačnik wrote:
> Dne 12.04.2021 (pon) ob 19:39 +0900 je Tetsuo Handa napisal(a):
> > What is the intended usage of /dev/ttyprintk ?
> > 
> 
> The intended use of 'ttyprintk' is to redirect console to /dev/ttyprintk
> via the TIOCCONS ioctl. After successfull redirection, all console
> messages get "merged" with kernel messages and as such automatically processed
> (stored/transferred) by the syslog service for example.

The same can be achieved by /dev/kmsg that was created by systemd
developers.

systemd is able to flood the kernel buffer and consoles.
It can be protected by ratelimiting, see the commit
750afe7babd117daabebf ("printk: add kernel parameter
to control writes to /dev/kmsg").

/dev/kmsg ratelimit is a "must-to-have". systemd enables debug
messages using the same "debug" parameter passed on the kernel
commandline. The ratelimit allows to see the kernel messages.

Note that the ratelimit is enabled by default by kernel. But it
it disabled by default by systemd. So, it is effectively disabled
by default.

It might be possible to add retalimiting also for /dev/ttyprintk.
But does it make sense just because of an artifical test case?


History:

/dev/ttyprintk has been added in v2.6.37 (2010)  by commit 24b4b67d17c308aaa956b
("add ttyprintk driver")

/dev/kmsg has been add in v3.5-rc1 (2012) by commit e11fea92e13fb91c50ba
("kmsg: export printk records to the /dev/kmsg interface")

Another solution might be to obsolete /dev/ttyprintk by /dev/kmsg.
We have to preserve /dev/kmsg because of systemd.
Is anyone really using /dev/ttyprintk these days?

Best Regards,
Petr
