Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD413E2C52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhHFOQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 10:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhHFOQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:16:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE0FB60F70;
        Fri,  6 Aug 2021 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628258912;
        bh=otvifW3xuj3B4TbnY2aktT6wmqvq7z7n4tu/BZ1ekoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W9L8pHADZKMQlUIiowXrITQEUg3DWLf5eDELL+HZ8D+rNa9ZE4UGKD+7npvGbFGg9
         +8iYXJLBfhD386uFMZE1J+PfK/yQWc27mjr3Hm/f8PSfjjzs8pJHtVIeMMvXdChobd
         chGI1sDGmxhp6bWTYShzetTla+wZxQDbikUe1N3vbWrLiThgxeAwmcum3ve3WutLXX
         AR3vcVZjcADF4PpCBDJ+WomIqAZWGHAwRjnGd8CIjNiXVCifE2o9sBWzWwqYuHPihP
         YPnPZ1cV1V9jGft4JaDqW6WnvvpMFXdxlTh8gptojNE0yZQ1OIOcTG8ElQ4KJrrUa5
         /FDg1sZHlZ4/g==
Date:   Fri, 6 Aug 2021 23:08:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] init: Suppress wrong warning for bootconfig cmdline
 parameter
Message-Id: <20210806230830.f47cd5c524fc97ac3fb659cb@kernel.org>
In-Reply-To: <20210806224941.6e28a3f8854f595f171b717d@kernel.org>
References: <162812945097.77369.1849780946468010448.stgit@devnote2>
        <20210805152221.33ssjh6qvgbj2pt5@halaneylaptop>
        <20210806224941.6e28a3f8854f595f171b717d@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 22:49:41 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Andrew,
> 
> On Thu, 5 Aug 2021 10:22:21 -0500
> Andrew Halaney <ahalaney@redhat.com> wrote:
> 
> > On Thu, Aug 05, 2021 at 11:10:51AM +0900, Masami Hiramatsu wrote:
> > > Since the 'bootconfig' command line parameter is handled before
> > > parsing the command line, it doesn't use early_param(). But in
> > > this case, kernel shows a wrong warning message about it.
> > > 
> > > [    0.013714] Kernel command line: ro console=ttyS0  bootconfig console=tty0
> > > [    0.013741] Unknown command line parameters: bootconfig
> > > 
> > > To suppress this message, add a dummy handler for 'bootconfig'.
> > > 
> > > Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  init/main.c |    9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/init/main.c b/init/main.c
> > > index f5b8246e8aa1..8d97aba78c3a 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -397,6 +397,12 @@ static int __init bootconfig_params(char *param, char *val,
> > >  	return 0;
> > >  }
> > >  
> > > +static int __init warn_bootconfig(char *str)
> > > +{
> > > +	/* The 'bootconfig' has been handled by bootconfig_params(). */
> > > +	return 0;
> > > +}
> > > +
> > >  static void __init setup_boot_config(void)
> > >  {
> > >  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> > > @@ -475,9 +481,8 @@ static int __init warn_bootconfig(char *str)
> > >  	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
> > >  	return 0;
> > >  }
> > > -early_param("bootconfig", warn_bootconfig);
> > > -
> > >  #endif
> > > +early_param("bootconfig", warn_bootconfig);
> > >  
> > >  /* Change NUL term back to "=", to make "param" the whole string. */
> > >  static void __init repair_env_string(char *param, char *val)
> > > 
> > 
> > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > 
> > Thanks Masami, this is one of the corner case command line parameters
> > that I was trying to highlight when I made the original commit (but I
> > didn't catch this one).
> 
> But if there are other parameters which also depends on kconfig?
> This actually depends on CONFIG_BOOT_CONFIG=y. I guess there are
> other parameters which are also depends on kconfig.
> (and usually, developers doesn't change their grub.conf when he install
>  a new kernel)

Ah, sorry. I misunderstood. With your patch, the kernel can notice that 
the kernel may not be correctly configured too.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
