Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEDD4031D8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhIHAf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhIHAf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:35:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7E9661130;
        Wed,  8 Sep 2021 00:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631061259;
        bh=gZCHoiyYvJOBDFgLE8Co+IeXpF52HOMnDjNNoPUEA48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fbsq7p+sBQ3L9lIV6HWb/jYT/SlisewLFImb7YXg4R2ZKBjoyhpQOcq1Syknu/M+H
         daU9GL0776U3rzkQvcq0x8a/mi/hHxagKU/IYHd7KnLqaci5rLyP6oukUWA9TzIIek
         NK0b76mRxAZPAjvXSsHh0axj3LHeg/nKPT8jSg6GvV6PojKN1eoemghoV6aHSZbJnk
         EFff3A20AB1DFERqoQ9VbshVsidbvYHDxRe++x0G3xOYtFavlCfz2db3dNNU70hyyL
         HCG2fqi+X2O6waheLYbZlm3g13bVcKcL99AVm9AQkQhcAzPqMKMRLYvoaC69OCDt9A
         swk0eQUtWEFRQ==
Date:   Wed, 8 Sep 2021 09:34:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RESEND PATCH] tools/bootconfig: Fix a compilation issue with
 missing variable
Message-Id: <20210908093417.6eb7244e6d5d7e8b75ab4850@kernel.org>
In-Reply-To: <20210908091346.65e6c4c58bc31676e942ccb2@kernel.org>
References: <20210907230710.1189193-1-punitagrawal@gmail.com>
        <20210908091346.65e6c4c58bc31676e942ccb2@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 09:13:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Punit,
> 
> This has been fixed by Julio's patch and we are waiting for merge.
> 
> https://lore.kernel.org/all/20210831033256.5973-1-jcfaracco@gmail.com/T/#u

Sorry, I missed thank you message on my previous message.
That's my bad point...

Anyway thanks for the report!


> 
> Thank you,
> 
> On Wed,  8 Sep 2021 08:07:10 +0900
> Punit Agrawal <punitagrawal@gmail.com> wrote:
> 
> > While looking to build bootconfig tool in order to debug a kernel boot
> > time issue I noticed that tool fails to compile. The broken changes
> > were introduced by commit e5efaeb8a8f5 ("bootconfig: Support mixing a
> > value and subkeys under a key").
> > 
> > Fix the compile issue by introducing a "ret" variable to track the
> > return value from xbc_node_compose_key().
> > 
> > Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
> > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > ---
> > 
> > (Apologies for the resend. I fat-fingered the email address for lkml)
> > 
> > Hi Masami,
> > 
> > I am not sure what went wrong but the patch in the lore link[0]
> > doesn't match the end result (bad merge?). You may want to recheck the
> > other changes to make sure it all looks sane.
> > 
> > Regards,
> > Punit
> > 
> > [0] https://lkml.kernel.org/r/162262194685.264090.7738574774030567419.stgit@devnote2
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
> > 2.32.0
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
