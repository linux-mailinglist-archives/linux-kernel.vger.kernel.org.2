Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537D334D56C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC2Qtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230495AbhC2QtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617036549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+XW8BFkqJkHY7su7WDZchzg6BqwKBP+vsLSpzzKI1SE=;
        b=Gzn7WhMbecbHqHt1hYeQDrcrvTx38PBVyeqCa8glXwxL81T+q8t8DsIQJ6a45vLJDfFTYb
        qxcT5mMhHXQt9+SWIFTF2Iw4LhjY+NpM1mN5tYliBrZPQ+eBq0F7eR/yxIoC9qUu6xQYIk
        TiS/rExFmA8Nps3gv+xCvX1auNbI/ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-qYnpvJR5P6ChIpQW_XY2_A-1; Mon, 29 Mar 2021 12:49:04 -0400
X-MC-Unique: qYnpvJR5P6ChIpQW_XY2_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A69A61019623;
        Mon, 29 Mar 2021 16:49:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9EE2510027A5;
        Mon, 29 Mar 2021 16:49:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Mar 2021 18:49:03 +0200 (CEST)
Date:   Mon, 29 Mar 2021 18:49:01 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Mutual debugging of 2 processes can stuck in unkillable stopped
 state
Message-ID: <20210329164900.GB24849@redhat.com>
References: <f2f32ffa-52ad-ff67-19d8-95305a70a6f8@omprussia.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f32ffa-52ad-ff67-19d8-95305a70a6f8@omprussia.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29, Igor Zhbanov wrote:
>
> Mutual debugging of 2 processes can stuck in unkillable stopped state

can't reproduce and can't understand...

> Hi!
>
> When one process, let's say "A", is tracing the another process "B", and the
> process "B" is trying to attach to the process "A", then both of them are
> getting stuck in the "t+" state. And they are ignoring all of the signals
> including the SIGKILL,

Why do you think so? What is your kernel version?

"t" means TASK_TRACED, SIGKILL should wake it up and terminate.

> so it is not possible to terminate them without
> a reboot.
> 
> To reproduce:
> 1) Run two terminals
> 2) Attach with "strace -p ..." from the first terminal to the shell (bash) of
>    the second terminal.
> 3) In the second terminal run "exec strace -p ..." to attach to the PID of the
>    first strace.
> 
> Then you'll see that the second strace is hanging without any output. And the
> first strace will output following and hang too:
> ptrace(PTRACE_SEIZE, 11795, NULL,
>        PTRACE_O_TRACESYSGOOD|PTRACE_O_TRACEEXEC|PTRACE_O_TRACEEXIT
> 
> (The 11795 is the PID of the first strace itself.)
> 
> And in the process list you will see following:
> ps awux | grep strace
> user   11776  0.0  0.0  24752  2248 pts/3    t+   13:53   0:00 strace -p 11795
> user   11795  0.0  0.0  24752  3888 pts/1    t+   13:54   0:00 strace -p 11776

OK, may be they sleep in PTRACE_EVENT_EXIT? After you tried to send SIGKILL?

please show us the output from "cat /proc/{11795,11776}/stack". And
"cat /proc/{11795,11776}/status" just in case.

Oleg.

