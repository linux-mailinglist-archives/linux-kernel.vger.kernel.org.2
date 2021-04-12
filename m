Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7183C35C6BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbhDLMuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:50:24 -0400
Received: from smtp-good-out-4.t-2.net ([93.103.246.70]:58932 "EHLO
        smtp-good-out-4.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbhDLMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:50:23 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 08:50:22 EDT
Received: from smtp-1.t-2.net (smtp-1.t-2.net [IPv6:2a01:260:1:4::1e])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FJpK41DD6z1VPs;
        Mon, 12 Apr 2021 14:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1618231320;
        bh=an0I2Pi77+7RFQeYVkdJg3pvIoAezOsYDpfl+GxO9Q0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=r3XN6zbfILHQ+PiBr06WKJ3LmzmL/v92jsxQW7h6stnXhR4VYzk42A+hzdfadJRu4
         cYnYIR3wqM+XRq6W+aFY5A6jZZT3KA1Z9DrboBzULiBanHqpP8ApipR0e7irrufr/U
         +rwCPbJm4x9A/Lna4BH+6k9HKxndqsD1F54jvsAw=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FJpK413JKzTmgvW;
        Mon, 12 Apr 2021 14:42:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z6KjXUtJEyly; Mon, 12 Apr 2021 14:41:59 +0200 (CEST)
Received: from hpg3.u2up.net (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Mon, 12 Apr 2021 14:41:28 +0200 (CEST)
Message-ID: <ed5347ee800216fbbcb119ee3b5ad3070797fd1e.camel@t-2.net>
Subject: Re: How to handle concurrent access to /dev/ttyprintk ?
From:   Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 12 Apr 2021 14:41:27 +0200
In-Reply-To: <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <YGx59PEq2Y015YdK@alley>
         <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
         <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
         <YG24F9Kx+tjxhh8G@kroah.com>
         <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
         <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 12.04.2021 (pon) ob 19:39 +0900 je Tetsuo Handa napisal(a):
> What is the intended usage of /dev/ttyprintk ?
> 

The intended use of 'ttyprintk' is to redirect console to /dev/ttyprintk
via the TIOCCONS ioctl. After successfull redirection, all console
messages get "merged" with kernel messages and as such automatically processed
(stored/transferred) by the syslog service for example.

best regards, Samo


