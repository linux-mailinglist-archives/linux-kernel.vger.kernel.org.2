Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF143CBCD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbhJ0OUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242439AbhJ0OTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:19:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD57960EFE;
        Wed, 27 Oct 2021 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635344209;
        bh=9CwInhuf7c9K04VlI+RPAS45TXW08xLWS0gihD9jCW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gGcZD48eVgqlLBpvwTJ1EC1lvF6tyV7lxVZ5g+kUcM7851x9reWLu5SNJiQ7WVHNQ
         Fskql11MIXN3SpoUxtmL9osT6mzHLDFMMhF8hQ3EKm4Kzr/ycWHTzI/9hB1CMLwoYD
         fwSvJbu21jiZ+xwHYmeKquqWxDv/jKqLxhCKdUxtPHIh4gF277WH73C3ShX597/0Be
         9lh0IEB75lvHf+lDrJFeH7cvBBMSbdFt7Z+Mc+RFnLxwg4NigTuDczXQGLTLb6v+lN
         EiB7nmprS7qVg8WLWrFTpw9sEGp2FK9r1ie1ggZWuU9B3LpzZ5wl/wPO0NwliNDDMn
         tMT75tmce68zQ==
Date:   Wed, 27 Oct 2021 23:16:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Fix to initialize 'ret' local variable
Message-Id: <20211027231646.cf5333aa08f70fe7f167e4d5@kernel.org>
In-Reply-To: <20211027100126.58769bf9@gandalf.local.home>
References: <163534286875.793799.13298849524607405594.stgit@devnote2>
        <20211027100126.58769bf9@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 10:01:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 27 Oct 2021 22:54:28 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix xbc_parse_tree() to initialize the 'ret' local variable
> > before referring in the loop.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Andrew Morton <akpm@linux-foundation.org>
> > Fixes: f3668cde8562 ("bootconfig: Split parse-tree part from xbc_init")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Heh, I just sent the exact same thing. But you have the wrong fixes tag I
> believe. As that change just moved the code, but the original location had
> the same issue I believe.

No, the original code uses the 'ret' for checking strlen().

+int __init xbc_init(char *buf)
+{
+       char *p, *q;
+       int ret, c;
+
+       if (xbc_data)
+               return -EBUSY;
+
+       ret = strlen(buf);
+       if (ret > XBC_DATA_MAX - 1 || ret == 0)
+               return -ERANGE;
+

OK, but my tag is also wrong, since this strlen() has been removed by
commit bdac5c2b243f ("bootconfig: Allocate xbc_data inside xbc_init()")

So the correct tag is 

Fixes: bdac5c2b243f ("bootconfig: Allocate xbc_data inside xbc_init()")

> 
> I'm fine taking yours instead. But I'd like to update the text explaining
> how the ret can be uninitialized and what happens if we set it to zero.

Yeah, I'm also good for both, but the Fixes tag must be updated.

Thank you,

> 
> -- Steve
> 
> 
> > ---
> >  lib/bootconfig.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > index a10ab25f6fcc..70e0d52ffd24 100644
> > --- a/lib/bootconfig.c
> > +++ b/lib/bootconfig.c
> > @@ -836,7 +836,7 @@ static int __init xbc_verify_tree(void)
> >  static int __init xbc_parse_tree(void)
> >  {
> >  	char *p, *q;
> > -	int ret, c;
> > +	int ret = 0, c;
> >  
> >  	last_parent = NULL;
> >  	p = xbc_data;
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
