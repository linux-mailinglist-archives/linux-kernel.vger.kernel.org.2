Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619EE457059
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhKSOMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235201AbhKSOMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:12:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0830161057;
        Fri, 19 Nov 2021 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637330980;
        bh=KMzNwLaxjnkt64ky49CGmDaUCXBp94H6T0qg9iTpaxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JCd66FlE3Umtd6RRqOP4H/+Uk0Dzers9hvpqG/cGkwER82arj2OC7UqGAIutzMN04
         /wLvbiHUQ2BDoSLl+yepSXCDqN4jK/jMb+AATHGRiGGWaDLedIcS2fWZ+VIdYv4zJ4
         RCuopZ5aJACUXOPUTpMK0PAZEBuD0TbPOSdhdlTHE4fqkRx5osx9Wme8NZAA/biNGu
         JFCZvVXNOMkytDk8UYo9goZWKXhFk0NvhATK0rui0j+vazqqru+lhDW3Ftl6EQ6N6h
         dj28YC7vxhcXwxeptf6kT3ViC2P25UZ72kn2DecLxSYRhyDekx6iS32x1IZIpUfsho
         Uvp4WzWSor/IA==
Date:   Fri, 19 Nov 2021 23:09:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v5 3/4] trace/objtrace: Add testcases for objtrace
 trigger parsing
Message-Id: <20211119230936.76337b13cd0fd15d66d437b8@kernel.org>
In-Reply-To: <20211113120632.94754-3-xiehuan09@gmail.com>
References: <20211113120632.94754-1-xiehuan09@gmail.com>
        <20211113120632.94754-3-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 20:06:31 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

Please add a patch description here.

> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  .../ftrace/test.d/trigger/trigger-objtrace.tc | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> new file mode 100644
> index 000000000000..4efcd7eee694
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test objtrace-trigger
> +# requires: kprobe_events

Hmm, didn't you add something for this in <tracefs>/README?
Instead of checking trigger file, I recommend to update 

There is a text data in the kernel/trace/trace.c;
static const char readme_msg[] =
...
        "\t   trigger: traceon, traceoff\n"
        "\t            enable_event:<system>:<event>\n"
        "\t            disable_event:<system>:<event>\n"
#ifdef CONFIG_HIST_TRIGGERS
        "\t            enable_hist:<system>:<event>\n"
        "\t            disable_hist:<system>:<event>\n"
#endif

You can add somewhere near there as 

#ifdef CONFIG_TRACE_OBJECT
        "\t            objtrace:add:..." // fill syntax.
#endif

And then, you can write the pattern in the requires line, like

# requires: kprobe_events "objtrace":README

Thank you,

> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +echo 'p bio_add_page arg1=$arg1' > kprobe_events
> +
> +FEATURE=`grep objtrace events/kprobes/p_bio_add_page_0/trigger`
> +if [ -z "$FEATURE" ]; then
> +    echo "objtrace trigger is not supported"
> +    exit_unsupported
> +fi


> +
> +echo "Test objtrace trigger"
> +echo 'objtrace:add:0x28(arg1):u32:1 if comm == "cat"' > \
> +	events/kprobes/p_bio_add_page_0/trigger
> +if [ -z $? ]; then
> +	fail "objtrace trigger syntax error"
> +fi
> +
> +echo "Test objtrace semantic errors"
> +
> +# Being lack of type size
> +! echo 'objtrace:add:0x28(arg1):1' > events/kprobes/p_bio_add_page_0/trigger
> +# Being lack of objtrace command
> +! echo 'objtrace:0x28(arg1):u32:1' > events/kprobes/p_bio_add_page_0/trigger
> +# Bad parameter name
> +! echo 'objtrace:add:argx:u32:1' > events/kprobes/p_bio_add_page_0/trigger
> +
> +echo "reset objtrace trigger"
> +
> +echo '!objtrace:add:0x28(arg1):u32' > \
> +	events/kprobes/p_bio_add_page_0/trigger
> +echo '-:p_bio_add_page_0' >> ./kprobe_events
> +
> +exit 0
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
