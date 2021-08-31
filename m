Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E123FC419
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbhHaIFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240107AbhHaIFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:05:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECDF060C3E;
        Tue, 31 Aug 2021 08:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630397079;
        bh=wXVBu5cIAqViHuUo98SN1Hv5WEa9G+MyGPsG6GUkU8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LSFNcxNYVNd8bmVA4QwssoN1SWObykevJLk4aftNSTKlpFAGokawFGwfKS2ZVismq
         UKnMjYRd6ZQbwKcZI+ka4bGxDC9WYv3DWy4UItrpnt/8CaNBnfcLwHAMQEUYNdQX45
         /C4ql1FAx6wwywTK/EDuw2PyXpHHyT4Veblc14Hz/kJgv5NXMsMbl/BZls/nwHHKef
         bCg0EzPymdpzFU1rTtpHRv2XvhK4m+oP76CWBfTgW4PQVoJ0gRQXd/68q8tSC4T96A
         LKHjDr17k6tAcRVrHSl6PxE975O6ko/j7d57AT/cy/9IoOdRjC7PLGDtptEbJvl5e6
         XpHntf8X59Jgw==
Date:   Tue, 31 Aug 2021 17:04:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Julio Faracco <jcfaracco@gmail.com>, rostedt@goodmis.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Fix missing return check of
 xbc_node_compose_key function
Message-Id: <20210831170437.2edec726afc4731f481e7c5f@kernel.org>
In-Reply-To: <20210831164046.b62e20443e2a1852d91b87bb@kernel.org>
References: <20210831033256.5973-1-jcfaracco@gmail.com>
        <20210831164046.b62e20443e2a1852d91b87bb@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 31 Aug 2021 16:40:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 31 Aug 2021 00:32:56 -0300
> Julio Faracco <jcfaracco@gmail.com> wrote:
> 
> > The function `xbc_show_list should` handle the keys during the
> > composition. Even the errors returned by the compose function. Instead
> > of removing the `ret` variable, it should save the value and show the
> > exact error. This missing variable is causing a compilation issue also.
> > 
> 
> Oops, good catch! Hmm, I missed some intermediate patch for some commit.
> Let me check.

OK, I found this is a bug introduced when mergeing the patch.

This bug has been introduced by
[1] commit e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")

However the original post of the patch (Linked from the above commit)

https://lkml.kernel.org/r/162262194685.264090.7738574774030567419.stgit@devnote2

seems correct, because 'ret' local variable exists in xbc_show_list().
However, this 'ret' has been removed in Apr, by 

[2] commit 30d103f2d460 ("tools/bootconfig: Simplify expression")

So I think it is merge timing issue... When I wrote [1], [2] was not
on my working tree (I forgot it, sorry). But when we merge [1], 
[2] was Steve's tree, and caused this issue.

Anyway, thank you for reporting!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Cc: stable@vgar.kernel.org

Thank you!

> 
> > Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> > ---
> >  tools/bootconfig/main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> > index f45fa992e01d..fd67496a947f 100644
> > --- a/tools/bootconfig/main.c
> > +++ b/tools/bootconfig/main.c
> > @@ -111,9 +111,11 @@ static void xbc_show_list(void)
> >  	char key[XBC_KEYLEN_MAX];
> >  	struct xbc_node *leaf;
> >  	const char *val;
> > +	int ret;
> >  
> >  	xbc_for_each_key_value(leaf, val) {
> > -		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0) {
> > +		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
> > +		if (ret < 0) {
> >  			fprintf(stderr, "Failed to compose key %d\n", ret);
> >  			break;
> >  		}
> > -- 
> > 2.31.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
