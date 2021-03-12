Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D23390E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhCLPMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231337AbhCLPLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:11:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3577564FD9;
        Fri, 12 Mar 2021 15:11:49 +0000 (UTC)
Date:   Fri, 12 Mar 2021 10:11:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Cao jin <jojing64@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org, vbabka@suse.cz
Subject: Re: [PATCH] bootconfig: Update prototype of setup_boot_config()
Message-ID: <20210312101147.26624a59@gandalf.local.home>
In-Reply-To: <20210312104423.a90e3ea4887e496fe7da8be1@kernel.org>
References: <20210311085213.27680-1-jojing64@gmail.com>
        <20210311185021.cd7a42057c8500755e3732a7@kernel.org>
        <20210311090439.394c5293@gandalf.local.home>
        <20210312104423.a90e3ea4887e496fe7da8be1@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 10:44:23 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Why is this using boot_command_line instead of what is passed in, which
> > might be different?  
> 
> I think you may know the reason...
> 
> commit f61872bb58a1cd8f0422aab1940eeee8be579d38
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Fri Feb 7 19:07:37 2020 -0500
> 
>     bootconfig: Use parse_args() to find bootconfig and '--'
> ...
> -       p = strstr(cmdline, "bootconfig");
> -       if (!p || (p != cmdline && !isspace(*(p-1))) ||
> -           (p[10] && !isspace(p[10])))
> +       strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> +       parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> +                  bootconfig_params);

I knew I shouldn't have trusted that code, based on the author :-p

> +
> +       if (!bootconfig_found)
> 
> I guess since the boot_command_line has fixed length, it is safer to
> allocate fixed length memory for tmp_cmdline. Is that correct?

Yeah, I guess it would be safer. If an arch wants to add bootconfig options
in the setup code, it could then modify how this works in the future. No
need to worry about it now.

Thanks for the review, I'll take this patch then.

-- Steve
