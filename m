Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1FB375563
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhEFOIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhEFOIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:08:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF806C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 07:07:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c17so5221849pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYJF+CvXD3aBnAOU+Y0IFXIVYLLmux02f20vgzqn8HA=;
        b=F5/9Nqm/pfsKawCWoQRSLLilxxv4BIUx9YKwg7Xa48SlvX87tDXvKQOeFDoEy7ZSay
         SRU6t8H9DgJgp3Kbu6LtHLI0rFljPgRy8nwXLF8KH3k9VPfzUlK9wO81rZEG1ltrfK6M
         wkCLYzy8i3Cw9lsdvowJH6bXQAmkFcoRkbLOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYJF+CvXD3aBnAOU+Y0IFXIVYLLmux02f20vgzqn8HA=;
        b=o5MTGrzcEaIyzIKg20M3pH/K0KTd/awd7qE/wKGjmPEljIBOHP7SrtQ7V6uAjeswO/
         Hx52bM03ntLWLjUQ+HFd1ujaaB3xL8TCPjFuwwfrAHGKXPx/VvnSp1lbjABgZooujNV5
         FG8TEb1LDXkIplYVa2JrWY43ejvDl5sOTSmNd4HhM/FsMfpIwQ/beyjd9ErCxiH9QIvx
         blzbU7e95MdkqYSI39naUJ6BtR+qqhfmi5FPFu0WEmVGqgshKSepBpkizRdWupb5hiED
         Yp77YLQeEWMrDgpEEsl5WLaRoroCRuk0V3x0WxLmihph9hWiL31QPQHauXUX4KYWPN0X
         854w==
X-Gm-Message-State: AOAM532FJp2XoRdmN0GJVMMHrVY0gJ9PYe5IHJpRYFYx55YonRuBIut0
        QBCVohzeRcRFdQkI04oz2CHb1w==
X-Google-Smtp-Source: ABdhPJzZIZMveJcinDNL9FXFLEAxnZs+j5CTquso3wImVAZqo9hpD+3ZLETj8pci5tWzCHgeAZfs+Q==
X-Received: by 2002:a65:4106:: with SMTP id w6mr4512760pgp.420.1620310045377;
        Thu, 06 May 2021 07:07:25 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:421f:8358:b929:bc6d])
        by smtp.gmail.com with ESMTPSA id t19sm2267387pjs.23.2021.05.06.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:07:24 -0700 (PDT)
Date:   Thu, 6 May 2021 23:07:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linuxarm@huawei.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJP4F1UIt/eRZ96s@google.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJPxj83F1sBjHHAE@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for Cc-ing Petr

On (21/05/06 15:39), Petr Mladek wrote:
> 
> Many printk messages might get accumulated when consoles were suspended.
> They are proceed when console_unlock() is called in resume_console().
> 
> The possibility to pass the console lock owner was added to reduce the risk
> of softlockup when too many messages were handled in an atomic context.
> 
> Now, resume_console() is always in a preemptible context that is safe
> to handle all accumulated messages. The possibility to pass the console
> lock owner actually makes things worse. The new owner might be in an atomic
> context and might cause softlockup when processing all messages accumulated
> when the console was suspended.
> 
> Create new console_unlock_preemptible() that will not allow to pass
> the console lock owner. As a result, all accumulated messages will
> be proceed in the safe preemptible process.

If we have a lot of pending messages in the logbuf, then there is
something chatty - some context (task, irq) or maybe several contexts.
And those contexts can continue adding messages, while we print them
_exclusively_ from preemptible context only. without ever throttling down
printk() callers - something that console_owner spinning and handover
does for us. And those printk() callers can even preempt
console_unlock_preemptible() and cause delays and lost messages.

In this regard, I'm afraid, console_unlock_preemptible() is somewhat
similar, IMHO, to the solution which we reverted - removal of
preempt_disable() before console_unlock() in vprintk_emit().


How about this.

Can we count the number of lines that we print from the `current` context
in console_unlock() and if after N messages there is no console_lock waiter
waiting for the `current` to handover console lock ownership, then create
one: schedule IRQ work that will become a console lock owner, spin on
console lock and call console_unlock() once it acquired the ownership.
That 'artificial' console lock owner will do the same - print N
messages, if nothing wants to become a console lock owner then it'll
queue another IRQ work.
