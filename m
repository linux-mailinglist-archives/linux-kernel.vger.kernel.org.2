Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AAA336EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhCKJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:20:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:41710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231394AbhCKJUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:20:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615454410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ppLPHKZgOdvD8q1olTE2OHVSuWb2Yyu7oHswBfK/4o=;
        b=PKdWTFIsCC4tX0n6KUKWfu648sxdDnCzFyDM4J6VaCsMFVvOES1qh3DiAcsGS85XXzW8mv
        Ka/kzrGNAfSWT4fe5sP2rC7JwbO1XXngq9M/82faS/Oz9z2kGGKTvwlN8zdBp4YZkVBKbk
        PD3YDVNhWfi/K7eKG3L8zqwIGhYN+Uk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9682EAB8C;
        Thu, 11 Mar 2021 09:20:10 +0000 (UTC)
Date:   Thu, 11 Mar 2021 10:20:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YEngyd950bHqesez@alley>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEi47xUFix0Dg1Li@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEi47xUFix0Dg1Li@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-10 12:17:51, Chris Down wrote:
> Hey Petr,
> 
> Chris Down writes:
> >    $ head -1 vmlinux; shuf -n 5 vmlinux
> >    # <level[,flags]> filename:line function "format"
> >    <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
> >    <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
> >    <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
> >    <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
> >    <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
> 
> Regardless of any of the internals, how does this format look to you? I ask
> because the sooner we agree on the format, the sooner I can provide an
> interim version of this patch to internal customers, even if the eventual
> implementation changes a little :-)

It looks good to me.

I do not have any better idea. And I believe that the filename, line,
and function name might be useful.

Best Regards,
Petr
