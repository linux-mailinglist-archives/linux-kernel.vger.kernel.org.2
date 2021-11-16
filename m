Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B75452D84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhKPJGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:06:41 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:48828 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhKPJGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:06:14 -0500
Received: by mail-il1-f197.google.com with SMTP id h11-20020a92c26b000000b0026c4b63618fso12319666ild.15
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=JjIlgPx0diT6MInIeoW70Y3Q/6OGG9FI1X6aaaJjitc=;
        b=uZ0rQOU0Yn8MB1NtCVijhSIB3hsR9pxFJuldiVKpwYRGUgQYFIRaCKEjq8dk8takLm
         LENkV0AS1qc1IxutKDR0Mwgl+H+yCxsZHHbyllJTR6HMUdX5ryJTtGOH3KpjFaCxfd4O
         aCjCLOGEEGhBg/GohTdlBCIjLcRUdtv+9tCbJrC15pj6K+pUQNw5dM4X8I9yZ4JiE3UF
         BQdtmLauTEGp0wrjDPjRhzI7/trd/pUqVEyU+s88A+E+3nGUZUy5wU4GcmjsbG86+jJ2
         rg/pzqEqlRzn+AfaNM+MPnpw92QLdU7GEUUfvt5Y+LwG8teh4fVdFbY6nTv/1fJcjSFX
         EM2Q==
X-Gm-Message-State: AOAM530gwDhTdxUBWpT17i889lt/j65FXvjN1AoNmi4Y7UyptbUFmOmi
        vDpvOB/9AMVRnqAoo/4+hUkWnqAUi1ixwuA+EU+nZFDmLTv1
X-Google-Smtp-Source: ABdhPJyhMDl6OmQZWIVbEC5s7Jf8QwL1TX0raRcp2KHX67EixQtZu9ypaNLLKlzG5rwX4sG4hyRxUGpJSq5Qe+YXvYBA5ZGbXv+g
MIME-Version: 1.0
X-Received: by 2002:a05:6638:358b:: with SMTP id v11mr4054680jal.53.1637053395825;
 Tue, 16 Nov 2021 01:03:15 -0800 (PST)
Date:   Tue, 16 Nov 2021 01:03:15 -0800
In-Reply-To: <7655311.pJQ0NNsvTN@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022f93a05d0e432f3@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
From:   syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     elver@google.com, fmdefrancesco@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday, November 16, 2021 9:53:53 AM CET Fabio M. De Francesco wrote:
>> On Tuesday, November 16, 2021 9:09:11 AM CET syzbot wrote:
>> > Hello,
>> > 
>> > syzbot has tested the proposed patch but the reproducer is still 
> triggering 
>> an issue:
>> > BUG: sleeping function called from invalid context in __might_resched
>> > [...]
>> 
>> The reproducer is still triggering an issue, but this time it looks like it 
>> is triggered by a different path of execution.
>> 
>> The same invalid "in_interrupt()" test is also in con_flush_chars().
>> 
>> Let's try to remove it too...
>> 
>> My first idea would be to replace "if (in_interrupt())" with the same 
>> "preempt_count() || irqs_disabled()" I used in do_con_write(). However I 
>> noticed that both do_con_write() and con_flush_chars() are only called from 
>> inside con_write() (which, aside from calling those functions, does nothing 
>> else).
>> 
>> So why not remove the if (in_interrupt()) from both them and use if 
>> (preempt_count() || irqs_disabled()) just once in con_write()?
>> 
>> I think this should be the right solution, but I prefer to go one step at a 
>> time.
>> 
>> Therefore, I'll (1) use the same (redundant, if it was used in con_write()) 
>> test also in con_flush_chars(), (2) wait for Syzbot to confirm that it 
> fixes 
>> the bug, and (3) wait for maintainers review and suggestions about whether 
> or 
>> not moving those tests one level upper.
>> 
>> #syz test:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> 
>> ---
>> Fabio M. De Francesco
>
> Don't know exactly what happened, so let's retry the test...
>
> #syz test: 

want 2 args (repo, branch), got 1

> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
