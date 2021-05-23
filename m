Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D8438DB65
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhEWOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 10:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhEWOUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 10:20:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B11561104;
        Sun, 23 May 2021 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621779551;
        bh=iJmVSorCtJ3GIrpVKoh6E8rF2CK1v8t0CApB+AGLtgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H51FVJC6WThtT3dv+DsyDEskwALnzs/XkMVVBkmMh25Mr2xceGGMv2kOewKrvUGk4
         4SaqYadEenAKZIxR1j3OtGV55XNXH1QEfNipwHZozsbBUF/1CcOHqU6Lv++8/nMvvD
         z3VouosYj48ljpOCujpXjGqckIAY05vZtnsRgMKC/UEPXPrxn6GtsUIc/wgRmZkDAe
         LxxwgWP57zitSQGpMBmjdL7TU+INL2NrUEK3rc/AAwZu1VDZXzXaxkWMs8BqWzkaGc
         XIwtc+KpEueVryLs8wYpAzC8Zx/08czCUcnRk0DbO/ome+h68V4pKVlwrteyT+mZuv
         Wv0sCtB+eaMTQ==
Date:   Sun, 23 May 2021 23:19:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tools/bootconfig: Fix error return code in
 apply_xbc()
Message-Id: <20210523231906.943ac0367c1c469420f8f812@kernel.org>
In-Reply-To: <20210514183238.07b96338@gandalf.local.home>
References: <20210508034216.2277-1-thunder.leizhen@huawei.com>
        <20210514183238.07b96338@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 18:32:38 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 8 May 2021 11:42:16 +0800
> Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
> > Fix to return a negative error code from the error handling case instead
> > of 0, as done elsewhere in this function.
> > 
> > Fixes: a995e6bc0524 ("tools/bootconfig: Fix to check the write failure correctly")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Masami, care to ack this?

Oops, I missed this patch. Sorry.

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> -- Steve
> 
> > ---
> >  tools/bootconfig/main.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> > index 7362bef1a368..6cd6080cac04 100644
> > --- a/tools/bootconfig/main.c
> > +++ b/tools/bootconfig/main.c
> > @@ -399,6 +399,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
> >  	}
> >  	/* TODO: Ensure the @path is initramfs/initrd image */
> >  	if (fstat(fd, &stat) < 0) {
> > +		ret = -errno;
> >  		pr_err("Failed to get the size of %s\n", path);
> >  		goto out;
> >  	}
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
