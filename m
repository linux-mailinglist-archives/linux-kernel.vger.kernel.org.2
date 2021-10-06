Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3594242488B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbhJFVMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 17:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239541AbhJFVMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 17:12:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EAD161186;
        Wed,  6 Oct 2021 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633554620;
        bh=AyfAidFc+fPiL3PyHanqQrP9fWf4NqcPnlfUg6FWUhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6XPKGM1CtkABd/h4ITyoGAaxddPCnmf/0qbLgKXq0JQp5sGq//mqPgAJn4Q4TspW
         o/4eIJGDL5L28wNHzd2I4sK1xITpK45UMn/zttKU73oE6CTJkQQINsZ3z730CnwNg0
         Oxu5ZEMu8nfyeqoZN+keXuNDGFMWpIPxnwuXHaQZXjYIbsROdTbDdKk0jq9qd2mYZP
         DNBse0yMaZxRw4+i324damckRxT6FLzQeayTN628HmErsVjQu6iVdx3HqMSXMtDz4L
         gqwESumB1A1XHW8yvshpqd2fgrUrZpPMZyJcLxWJIpC512jOEUlfpVpGY5+bB+5nJ5
         LP9Nijur0XiWw==
Date:   Wed, 6 Oct 2021 16:14:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211006211426.GA916113@embeddedor>
References: <20211005053922.GA702049@embeddedor>
 <20211005111714.18ebea2b@gandalf.local.home>
 <20211005161812.GA768055@embeddedor>
 <20211005123522.244281e6@gandalf.local.home>
 <20211005165027.GA797862@embeddedor>
 <20211005150807.03da5e54@gandalf.local.home>
 <20211005193557.GA881195@embeddedor>
 <20211005200935.2429ec2c@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005200935.2429ec2c@rorschach.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 08:09:35PM -0400, Steven Rostedt wrote:
> On Tue, 5 Oct 2021 14:35:57 -0500
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > On Tue, Oct 05, 2021 at 03:08:07PM -0400, Steven Rostedt wrote:
> > [..]
> > > Or did you not remove your patch first?  
> > 
> > Yep; that was the problem. 
> > 
> > I now applied it to a clean tree and the warnings went away.
> > 
> > However, I'm a bit concerned about the following Jann's comments:
> 
> I should have replied back then, but I'll do that now (and added Jann
> to the CC) 
> 
> > 
> > "the real issue here is that ftrace_func_t is defined as a fixed
> > type, but actually has different types depending on the architecture?
> > If so, it might be cleaner to define ftrace_func_t differently
> > depending on architecture, or something like that?"[1]
> 
> It's not dependent on the architecture. It's dependent on what the
> architecture has implemented. There's nothing limiting the arch to use
> the normal method, except that nobody implemented the updates.
> 
> As I changed the core API, it affected the architectures, and since I
> don't know how to update all the architectures that use that API, and
> do not have the hardware to test it, I made it so architectures can
> slowly be updated when their maintainers get time to. This was years
> ago, and not much has been done.
> 
> > 
> > "Would it not be possible to have two function types (#define'd as the
> > same if ARCH_SUPPORTS_FTRACE_OPS), and then ensure that ftrace_func_t
> > is only used as ftrace_asm_func_t if ARCH_SUPPORTS_FTRACE_OPS?"[2]
> > 
> > "Essentially my idea here is to take the high-level rule "you can only
> > directly call ftrace_func_t-typed functions from assembly if
> > ARCH_SUPPORTS_FTRACE_OPS", and encode it in the type system. And then
> > the compiler won't complain as long as we make sure that we never cast
> > between the two types under ARCH_SUPPORTS_FTRACE_OPS==0."[3]
> > 
> > So, is this linker approach really a good solution to this problem? :)
> > 
> > What's the main problem with what Jann suggests?
> 
> The main issue is I want no more #ifdef's in the main code. There's too
> many already and it makes it difficult to maintain. I want to get rid
> of them, not add more. So anything that adds more #ifdef's to the main
> code, I will NACK.
> 
> Which I guess leaves us with either the linker trick, or having all
> the archs get updated to support the latest ftrace features, and we can
> remove the current #ifdefs.

OK. Are you going to apply your patch any time soon? So, I can go and
enable -Wcast-function-type in my -next tree. :)

Thanks
--
Gustavo
