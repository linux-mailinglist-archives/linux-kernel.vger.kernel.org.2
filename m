Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377783E2BEC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhHFNuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhHFNt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:49:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67A6261181;
        Fri,  6 Aug 2021 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628257784;
        bh=88aH7vwRZR57VNS2gSeb3nCVZl5AOjF3DDyAIdp5Osg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CLZFUN4+Ma5Ta2YVgdBbjtnobCA0heaTVbi+1qZmXg8zbCdyZHeJbaxdfP0e+hWoE
         dhJVDRKvWgGwBPMrEtxeFLKyYLdOnaCBKnYYEt8Wr7iFxXHwEHZY/niMeIR/b8EKQB
         nIWBz6H8yiGT2LRKzbW+aAWYC4PPRBIXWBmAbb2+ie2j55udWLjAc19GtP4YaQ3zGO
         3rrJLPKP25aP3JyYrz0y+VJnwO/S7s9n6ox22wHU7Qg2mL2zYSvBKHX1XumltMSihI
         cu5nPebyT2EYeGStgS140BxJOeFoSFvNf5PTQ7RzquTeDX6vs5UnJIWojqvOc7Fanj
         cwLSQlcZxjUzA==
Date:   Fri, 6 Aug 2021 22:49:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] init: Suppress wrong warning for bootconfig cmdline
 parameter
Message-Id: <20210806224941.6e28a3f8854f595f171b717d@kernel.org>
In-Reply-To: <20210805152221.33ssjh6qvgbj2pt5@halaneylaptop>
References: <162812945097.77369.1849780946468010448.stgit@devnote2>
        <20210805152221.33ssjh6qvgbj2pt5@halaneylaptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, 5 Aug 2021 10:22:21 -0500
Andrew Halaney <ahalaney@redhat.com> wrote:

> On Thu, Aug 05, 2021 at 11:10:51AM +0900, Masami Hiramatsu wrote:
> > Since the 'bootconfig' command line parameter is handled before
> > parsing the command line, it doesn't use early_param(). But in
> > this case, kernel shows a wrong warning message about it.
> > 
> > [    0.013714] Kernel command line: ro console=ttyS0  bootconfig console=tty0
> > [    0.013741] Unknown command line parameters: bootconfig
> > 
> > To suppress this message, add a dummy handler for 'bootconfig'.
> > 
> > Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  init/main.c |    9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/init/main.c b/init/main.c
> > index f5b8246e8aa1..8d97aba78c3a 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -397,6 +397,12 @@ static int __init bootconfig_params(char *param, char *val,
> >  	return 0;
> >  }
> >  
> > +static int __init warn_bootconfig(char *str)
> > +{
> > +	/* The 'bootconfig' has been handled by bootconfig_params(). */
> > +	return 0;
> > +}
> > +
> >  static void __init setup_boot_config(void)
> >  {
> >  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> > @@ -475,9 +481,8 @@ static int __init warn_bootconfig(char *str)
> >  	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
> >  	return 0;
> >  }
> > -early_param("bootconfig", warn_bootconfig);
> > -
> >  #endif
> > +early_param("bootconfig", warn_bootconfig);
> >  
> >  /* Change NUL term back to "=", to make "param" the whole string. */
> >  static void __init repair_env_string(char *param, char *val)
> > 
> 
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> 
> Thanks Masami, this is one of the corner case command line parameters
> that I was trying to highlight when I made the original commit (but I
> didn't catch this one).

But if there are other parameters which also depends on kconfig?
This actually depends on CONFIG_BOOT_CONFIG=y. I guess there are
other parameters which are also depends on kconfig.
(and usually, developers doesn't change their grub.conf when he install
 a new kernel)

> 
> I _think_ the only other one is dyndbg based on some grepping. I'm
> debating if it makes sense to do something similar there or to actually
> use a callback to do some of the work it needs in stealing from the CLI.
> 
> For this case though I don't see how you could do anything other than
> what you've done here -- you can't modify the params once we've started
> processing, and that's what bootconfig needs to do.

Actually, if CONFIG_BOOT_CONFIG=y, "bootconfig" is handled before preparing
cmdline strings, because it will copy (append) additional cmdline args
from the bootconfig to the cmdline.
I can remove the "bootconfig" string too. But I think it is better to keep
it in the cmdline so that users can ensure what he passed to the kernel.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
