Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67DB3655EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhDTKMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhDTKMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:12:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB7AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QQd2Xer/ewGoPtVuQhn6GrjhNUVswfSRgD2AVdXjdtg=; b=YWbB2xkKXyEmsuQTUTkOwmO9lD
        PB1DWTW9LmG7ma9qWiZfJAQvfMK0LSmI3XTlTTS0o7xKx6HbsJDyh4hL0l8bpBJvrSniD9ciW+8Nl
        jDHj97mwiGlVpF6ezdazgb7F8ce0lXtLZUzyVtUORsYOFUswCJ3MFV2Ma5+frocq0b9pOlD6I6G8p
        n5CafQC2WeRkKr+VFIvTx+urGxyLnUmpA7HnU6FcyzoYObWru9l1GrQ1BkBEdfzIA4k2uI+Ur9Yza
        jum24ScjJ9xuWfNibyiYwXvgoRLmEvlesCGx2t4EtGwjQRyGuDTRrrRFPVzWpPFmb8TfyJQBnadae
        RKAaLtSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYnMJ-00Bqne-BO; Tue, 20 Apr 2021 10:11:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75F9B30013E;
        Tue, 20 Apr 2021 12:11:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C9302BDD7C9B; Tue, 20 Apr 2021 12:11:54 +0200 (CEST)
Date:   Tue, 20 Apr 2021 12:11:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     syzbot <syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] WARNING in kthread_is_per_cpu
Message-ID: <YH6o6gd4oqqs6sHr@hirez.programming.kicks-ass.net>
References: <000000000000a61f7705c050e601@google.com>
 <87im4ilddh.mognet@arm.com>
 <20210419184553.GA26214@worktop.programming.kicks-ass.net>
 <874kg2kpwd.mognet@arm.com>
 <YH6WJc825C4P0FCK@hirez.programming.kicks-ass.net>
 <87lf9duw8g.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf9duw8g.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 10:43:43AM +0100, Valentin Schneider wrote:
> On 20/04/21 10:51, Peter Zijlstra wrote:

> > I think free_kthread_struct() is ok, because a task at that point in its
> > lifetime cannot be also doing exec().
> >
> 
> What if it's one of those kthreads created by directly invoking
> kernel_thread()? AFAICT right now it's only umh, and that one does execve()
> so it ends up stripped of PF_KTHREAD. It could however go through an error
> path, i.e. not call exec, and exit, giving us:
> 
>   put_task_struct(p)
>   `\
>     free_task(p)
>     `\
>       if (tsk->flags & PF_KTHREAD)
>           free_kthread_struct(tsk);
>           `\
>             to_kthread(p)

I'm not following, at the point we hit free_task() it had better be dead
and p->flags had better be stable. Either it will, or will not, have
PF_KTHREAD.


