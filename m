Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266AF35DD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345274AbhDMLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:11:45 -0400
Received: from smtp-good-out-4.t-2.net ([93.103.246.70]:41730 "EHLO
        smtp-good-out-4.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbhDMLLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:11:43 -0400
Received: from smtp-1.t-2.net (smtp-1.t-2.net [84.255.208.30])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FKNG22kGVz24lX;
        Tue, 13 Apr 2021 13:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1618312282;
        bh=X6WxLRtSRDcr+IOn7tANZ9XKF17UlUnxUdkTe92hqM4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=SRF8yDMDIaY19ZzZ02DgtoVzqGcf6dbOKpV0+FGjPzJfb5m0YqdyU3GbLbkpHWe7R
         xfO0U891SR+HTGAQhP/4T6qoA54QfU/MhHZ6jjE3uK+GzGPaMqk9rsophVb9mrkObK
         WUw8wHDu6iYwAl5/zKnoDQnheRUXy9R/zuAT4PwU=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FKNG22YWXzTcsPj;
        Tue, 13 Apr 2021 13:11:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z9peypk7IhMd; Tue, 13 Apr 2021 13:11:22 +0200 (CEST)
Received: from hpg3.u2up.net (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Tue, 13 Apr 2021 13:10:50 +0200 (CEST)
Message-ID: <157d81a5eb9e56e47e40c1cd652cdc7a915cb755.camel@t-2.net>
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
Date:   Tue, 13 Apr 2021 13:10:50 +0200
In-Reply-To: <YHVnQfQ4zDt09RFe@alley>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <YGx59PEq2Y015YdK@alley>
         <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
         <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
         <YG24F9Kx+tjxhh8G@kroah.com>
         <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
         <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
         <ed5347ee800216fbbcb119ee3b5ad3070797fd1e.camel@t-2.net>
         <YHVnQfQ4zDt09RFe@alley>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 13.04.2021 (tor) ob 11:41 +0200 je Petr Mladek napisal(a):
> On Mon 2021-04-12 14:41:27, Samo Pogačnik wrote:
> > Dne 12.04.2021 (pon) ob 19:39 +0900 je Tetsuo Handa napisal(a):
> > > What is the intended usage of /dev/ttyprintk ?
> > > 
> > 
> > The intended use of 'ttyprintk' is to redirect console to /dev/ttyprintk
> > via the TIOCCONS ioctl. After successfull redirection, all console
> > messages get "merged" with kernel messages and as such automatically
> > processed
> > (stored/transferred) by the syslog service for example.
> 
> The same can be achieved by /dev/kmsg that was created by systemd
> developers.
> 
'kmsg' and 'ttyprintk' are different types of drivers and as such rather
complementary than exclusive. The 'ttyprintk' being a tty driver allows 
for a system wide automatic redirection of anything written to the console.
On the other hand 'kmsg' is probably better suited for a per process
output redirection/injection of its output into kernel messages.

Maybe i am wrong, but 'systemd' could also find 'ttyprintk' usefull?

best regards, Samo



