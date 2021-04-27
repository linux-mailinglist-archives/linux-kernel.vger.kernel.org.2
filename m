Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6436C522
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbhD0LdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhD0LdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:33:02 -0400
Received: from smtp-good-out-4.t-2.net (smtp-good-out-4.t-2.net [IPv6:2a01:260:1:4::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B349AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:32:18 -0700 (PDT)
Received: from smtp-1.t-2.net (smtp-1.t-2.net [84.255.208.30])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FV03h0vX3z2Tf6;
        Tue, 27 Apr 2021 13:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1619523136;
        bh=alqpYjPSfwcLhvYfFxu1f1GHEI7BbIhIMLsPyKZU6NM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ddE1vrJQCbpcdoEqBLgm9klGsRx2naLM+lQPqYq44zwBMH+2DbHN7SUbmvGU4X7Rm
         XbbtZhrcLTWQd0vFX6+/gz0hv0wjc71d+Y4DORbQt6tBerG9IlXnZsSpze5d1HdmW2
         PAouCvtgRHG95PJoToNuQpNoUTSBmrO6UodBU1/E=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FV03h0khCzTpmnP;
        Tue, 27 Apr 2021 13:32:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1DyX3xO1zzm1; Tue, 27 Apr 2021 13:32:15 +0200 (CEST)
Received: from hp450g3 (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Tue, 27 Apr 2021 13:31:30 +0200 (CEST)
Message-ID: <625994732c8eda9f36320192fb991cf89b5c1fa9.camel@t-2.net>
Subject: Re: [PATCH] ttyprintk: Add TTY hangup callback.
From:   Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Tue, 27 Apr 2021 13:31:30 +0200
In-Reply-To: <YIfiiGVJqkWV/IDa@alley>
References: <17e0652d-89b7-c8c0-fb53-e7566ac9add4@i-love.sakura.ne.jp>
         <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
         <699d0312-ee68-8f05-db2d-07511eaad576@kernel.org>
         <ba5907e12a30ed8eb3e52a72ea84bf4f72a4c801.camel@t-2.net>
         <33461bad-ef57-9036-135d-95a60a8c88d5@i-love.sakura.ne.jp>
         <07c3c9015491ca9b42362098d5e90ca7480cf5ed.camel@t-2.net>
         <e7010c9e-1ac2-55a7-b505-802e03f13362@i-love.sakura.ne.jp>
         <9e8805a98d6c0d0f20e563c8e4db98b595826c13.camel@t-2.net>
         <YIaPQzktArmoWbLr@alley>
         <d4d0603716e5cb99a7a9a93d4f767278ac318557.camel@t-2.net>
         <YIfiiGVJqkWV/IDa@alley>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 27.04.2021 (tor) ob 12:08 +0200 je Petr Mladek napisal(a):
> 
> I guess that you mean TPK_PREFIX + "[U] ".
yes

> 
> But you could do this already in tpk_write(). I mean that you could
> parse the given buffer, copy each line to a temporary buffer,
> and call printk(TPK_PREFIX "[U] %s\n", tmp_buf).
> 
> Why is it postponed to tpk_close()?
> 
> IMHO, the printk() in tpk_write() might simplify the logic a bit.
The string received in tpk_write() has no guaranties, that it represents a
complete output line. It has to be treated as a sub-string of a potentially
multi-line massage produced by the userspace code/process. 

The tpk_close() only produces additional output (flush), if the last tpk_write()
string does not end with some end-of-line indication.

> 
> 
> > > 
> > > If you call printk() directly, the caller_id would be from the process
> > > that really wrote the data/message.
> > 
> > It can be a kernel-code originating message printk-ed on behalf of a user
> > task
> > or a kernel-code originating message on behalf of a kernel task. Or it may
> > be a
> > user-code originating message on behalf of its task, when printk-ed via
> > ttyprintk.
> 
> Exactly. Now, I am not sure if you think that this good or bad.
> 
> IMHO, it is much better to use caller_id of the process/context that
> wrote the data/message instead of the process that caused the final
> tpk_close().
> 
IMHO, it is good that output provides info about all the above cases and
especially that particular output is not produced by the kernel code itself.

best regards, samo

