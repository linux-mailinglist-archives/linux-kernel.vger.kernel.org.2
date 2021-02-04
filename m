Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F50030FEE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhBDUzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhBDUzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:55:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9A164E42;
        Thu,  4 Feb 2021 20:54:25 +0000 (UTC)
Date:   Thu, 4 Feb 2021 15:54:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <20210204155423.2864bf4f@gandalf.local.home>
In-Reply-To: <20210204204835.GA7529@amd>
References: <20210202201846.716915-1-timur@kernel.org>
        <20210204204835.GA7529@amd>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 21:48:35 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> > +	pr_warn("** Kernel memory addresses are exposed, which may       **\n");
> > +	pr_warn("** compromise security on your system.                  **\n");  
> 
> This is lies, right? And way too verbose.

Not really. More of an exaggeration than a lie. And the verbosity is to
make sure it's noticed by those that shouldn't have it set. This works well
for keeping trace_printk() out of production kernels. Why do you care
anyway, you are just debugging it, and it shouldn't trigger any bug reports
on testing infrastructure. That's why I like the notice. It gets the job
done of keeping people from using things they shouldn't be using, and
doesn't cause testing failures that a WARN_ON would.

-- Steve
