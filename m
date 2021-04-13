Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7E035E2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhDMPYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:24:44 -0400
Received: from smtp-good-out-4.t-2.net ([93.103.246.70]:53848 "EHLO
        smtp-good-out-4.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346700AbhDMPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:23:40 -0400
Received: from smtp-1.t-2.net (smtp-1.t-2.net [IPv6:2a01:260:1:4::1e])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FKTrk6SWNzTyy;
        Tue, 13 Apr 2021 17:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1618327398;
        bh=iTcQ2sTcmn98QMi8qBpLVKqPeR8uHdri8V0nrWRW6sw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=aGbbXrE5Vgme8YKaV9wgm+Y+GOMiaszb1Y6J9Zo0sU4ym3QbV5MUA/WcwmaqCarOf
         ivs7s+uXN27i38uqUiKwZVwTfhEdPgu8o6QvtgIRPLZYRLZa/LLzNSIxl+MZ7gj8xV
         +8UQ4spa8F9nfP4T/ec8pGHrblpXBqgyaZMTAFt0=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FKTrk6G8FzTg2xf;
        Tue, 13 Apr 2021 17:23:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dGgxBC9fHpe4; Tue, 13 Apr 2021 17:23:18 +0200 (CEST)
Received: from hpg3.u2up.net (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Tue, 13 Apr 2021 17:22:47 +0200 (CEST)
Message-ID: <e8726b52b576c04bf4dc41ccfd324ef8f29d17c9.camel@t-2.net>
Subject: Re: How to handle concurrent access to /dev/ttyprintk ?
From:   Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 13 Apr 2021 17:22:46 +0200
In-Reply-To: <YHWrmuZ9tei0VTXN@alley>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <YGx59PEq2Y015YdK@alley>
         <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
         <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
         <YG24F9Kx+tjxhh8G@kroah.com>
         <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
         <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
         <ed5347ee800216fbbcb119ee3b5ad3070797fd1e.camel@t-2.net>
         <YHVnQfQ4zDt09RFe@alley>
         <157d81a5eb9e56e47e40c1cd652cdc7a915cb755.camel@t-2.net>
         <YHWrmuZ9tei0VTXN@alley>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 13.04.2021 (tor) ob 16:32 +0200 je Petr Mladek napisal(a):
> On Tue 2021-04-13 13:10:50, Samo Pogačnik wrote:
> > Dne 13.04.2021 (tor) ob 11:41 +0200 je Petr Mladek napisal(a):
> > > On Mon 2021-04-12 14:41:27, Samo Pogačnik wrote:
> > > > Dne 12.04.2021 (pon) ob 19:39 +0900 je Tetsuo Handa napisal(a):
> > > > > What is the intended usage of /dev/ttyprintk ?
> > > > > 
> > > > 
> > > > The intended use of 'ttyprintk' is to redirect console to /dev/ttyprintk
> > > > via the TIOCCONS ioctl. After successfull redirection, all console
> > > > messages get "merged" with kernel messages and as such automatically
> > > > processed
> > > > (stored/transferred) by the syslog service for example.
> > > 
> > > The same can be achieved by /dev/kmsg that was created by systemd
> > > developers.
> > > 
> > 
> > 'kmsg' and 'ttyprintk' are different types of drivers and as such rather
> > complementary than exclusive. The 'ttyprintk' being a tty driver allows 
> > for a system wide automatic redirection of anything written to the
> > console.
> 
> I might miss something. But how can one setup ttyprintk as the system
> wide console? I do not see any code that would use ttyprintk
> in struct console.
> 

You can compile this simple code below and call:

# ./tioccons /dev/ttyprintk

... from now on all console output interleaves the kernel log  (you can check
dmesg or logs)

# ./tioccons /dev/console

... sets things back they were.

You will be able to recognize console messages by preceding "[U]" tag (meaning
User).

-------------------
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/ioctl.h>

int main(int argc, char **argv)
{
	int fd;

	if (argc != 2) {
		printf("Wrong usage!\n");
		exit(1);
	}

	if ((fd = open(argv[1], O_WRONLY)) == -1) {
		perror(argv[1]);
		exit(1);
	}

	if (ioctl(fd, TIOCCONS, NULL) == -1) {
		printf("ioctl: %s\n", strerror(errno));
		exit(1);
	}

	exit(0);
}
--------------------

best regards, Samo

