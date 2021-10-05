Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348BF4230CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhJETdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 15:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhJETdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B3C261027;
        Tue,  5 Oct 2021 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633462314;
        bh=CdT8WVDbXzXBkotXEbD6Lg3bwGfVO6pbEPcBZnCnbhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfBfmVV8HwnVrRk5ailM2fxdPVxAfrX48NcCAqS1yOjsisVWkfGAH466DxkVufSB8
         QzgCeIYSS6cN70adEhJgob7sELUblvoS6Tr4x/KB/5NAhzW2HStPQl3tc+4alobjAv
         YxzhzCIadKSSOvqsSKhfdlJKD+pvqgQlX43H81VWUNBaLJIu+8lg/Ta1VmxwAgfuXn
         OKoNIQcwaBAfpCbwKVNW760VMwlIVb9FdrfIIoxZe5cL2JSO9tKDAgSIfX34tc0Lsu
         oFYFwVY2EERo67m4BuZMBR45X2fE6SxrY2BTLSQLsg2W79Hv0Effb+eSqNuRNoma2n
         iGP1DR4RKM6Cw==
Date:   Tue, 5 Oct 2021 14:35:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211005193557.GA881195@embeddedor>
References: <20211005053922.GA702049@embeddedor>
 <20211005111714.18ebea2b@gandalf.local.home>
 <20211005161812.GA768055@embeddedor>
 <20211005123522.244281e6@gandalf.local.home>
 <20211005165027.GA797862@embeddedor>
 <20211005150807.03da5e54@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005150807.03da5e54@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 03:08:07PM -0400, Steven Rostedt wrote:
[..]
> Or did you not remove your patch first?

Yep; that was the problem. 

I now applied it to a clean tree and the warnings went away.

However, I'm a bit concerned about the following Jann's comments:

"the real issue here is that ftrace_func_t is defined as a fixed
type, but actually has different types depending on the architecture?
If so, it might be cleaner to define ftrace_func_t differently
depending on architecture, or something like that?"[1]

"Would it not be possible to have two function types (#define'd as the
same if ARCH_SUPPORTS_FTRACE_OPS), and then ensure that ftrace_func_t
is only used as ftrace_asm_func_t if ARCH_SUPPORTS_FTRACE_OPS?"[2]

"Essentially my idea here is to take the high-level rule "you can only
directly call ftrace_func_t-typed functions from assembly if
ARCH_SUPPORTS_FTRACE_OPS", and encode it in the type system. And then
the compiler won't complain as long as we make sure that we never cast
between the two types under ARCH_SUPPORTS_FTRACE_OPS==0."[3]

So, is this linker approach really a good solution to this problem? :)

What's the main problem with what Jann suggests?

Thanks!
--
Gustavo

[1] https://lore.kernel.org/all/CAG48ez2pOns4vF9M_4ubMJ+p9YFY29udMaH0wm8UuCwGQ4ZZAQ@mail.gmail.com/
[2] https://lore.kernel.org/all/CAG48ez04Fj=1p61KAxAQWZ3f_z073fVUr8LsQgtKA9c-kcHmDQ@mail.gmail.com/#t
[3] https://lore.kernel.org/all/CAG48ez1LoTLmHnAKFZCQFSvcb13Em6kc8y1xO8sNwyvzB=D2Lg@mail.gmail.com/
