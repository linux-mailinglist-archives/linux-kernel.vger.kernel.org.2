Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEBE338346
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 02:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhCLBo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 20:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhCLBo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 20:44:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1036864F89;
        Fri, 12 Mar 2021 01:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615513467;
        bh=oI6xr1uEdFkZ9NiuSFcqzMpMKe8riaJN13hZ37tkTAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ys/WD24HMmeIwrSnWzKYbBmqfqWv5wEtWz73pIPxTAN4lFKxbNMlJypB6F+JP1MQl
         8W32Wd2+C/LyBtoTn4CgJjWql8leCaIn4hHH0VCQpT75wR6kQ1VboWWol7Dfkdklml
         3oNaHnqgjOBVjbkAfKW0LzCDHIvi6SeUiTZUb+OvfIDGBTLmgTN6kNhU7AwyOpGbAZ
         xcSM5OlME/RnE+QnjDIUTUM9q7JRpkmFkCKrp+G5uEF7LwCjpkjvTgquE/D2Q3fxyV
         UD7rB6gHurMO+CjJWVU91x28yQ6fSl/ckeTuw49Z0H7FWxtawJGBkc3GZ+4ekiONKj
         b7caG5dDs3gpg==
Date:   Fri, 12 Mar 2021 10:44:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Cao jin <jojing64@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org, vbabka@suse.cz
Subject: Re: [PATCH] bootconfig: Update prototype of setup_boot_config()
Message-Id: <20210312104423.a90e3ea4887e496fe7da8be1@kernel.org>
In-Reply-To: <20210311090439.394c5293@gandalf.local.home>
References: <20210311085213.27680-1-jojing64@gmail.com>
        <20210311185021.cd7a42057c8500755e3732a7@kernel.org>
        <20210311090439.394c5293@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 11 Mar 2021 09:04:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 11 Mar 2021 18:50:21 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 11 Mar 2021 16:52:13 +0800
> > Cao jin <jojing64@gmail.com> wrote:
> > 
> > > Parameter "cmdline" has no use, drop it.  
> > 
> > OK, this looks good to me.
> 
> Why is this using boot_command_line instead of what is passed in, which
> might be different?

I think you may know the reason...

commit f61872bb58a1cd8f0422aab1940eeee8be579d38
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Fri Feb 7 19:07:37 2020 -0500

    bootconfig: Use parse_args() to find bootconfig and '--'
...
-       p = strstr(cmdline, "bootconfig");
-       if (!p || (p != cmdline && !isspace(*(p-1))) ||
-           (p[10] && !isspace(p[10])))
+       strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+       parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
+                  bootconfig_params);
+
+       if (!bootconfig_found)

I guess since the boot_command_line has fixed length, it is safer to
allocate fixed length memory for tmp_cmdline. Is that correct?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
