Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393D6316256
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBJJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBJJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:31:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42432C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xY0hkqiKqnJQrakw6J8JZNYRgYTVBcbM/Rzktro6Llw=; b=OWitRgZasw1Xq5eAW+kBJ7qZBE
        UKOvKbARKPkrVnypsXIrGZyEgAtrt8U3MOtdJJ+Uihw0bIInnHxeDOHQ02rAQ6XT1Rlx00ztpyq6s
        3RGR3do0ITa/bwn9KWF6W6qVFEYSOhm/YcX9lsKTPIvmorA/OB6Pvwc8enGSYlDGfAtfeYhlr3xer
        nDzWMVuSKOTVRwEN7xSFnbUcVHt4gjBxXWW+fA/SP3aE3MWreBvoBm/aYQSXBHlaW1+P56ivRcI/0
        MUC+2eqx4UI4xooUERvEeSSU6YZ3+qWmbNzfmQDREUidXdBEvPd3zGjcx25woWNZwgPnEmUqRHEVC
        Bl+72zAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9lq0-0005WC-3t; Wed, 10 Feb 2021 09:31:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5706301EFB;
        Wed, 10 Feb 2021 10:31:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2190202761A3; Wed, 10 Feb 2021 10:31:06 +0100 (CET)
Date:   Wed, 10 Feb 2021 10:31:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2.1 2/3] objtool,x86: Additionally decode: mov %rsp,
 (%reg)
Message-ID: <YCOn2uzMFnT4Y/yp@hirez.programming.kicks-ass.net>
References: <20210209091600.075402197@infradead.org>
 <20210209093521.924097404@infradead.org>
 <YCOiowWtr8XTT+mN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCOiowWtr8XTT+mN@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:08:51AM +0100, Peter Zijlstra wrote:
> +				/* skip nontrivial SIB */
> +				if (modrm_rm == 4 && sib != 0x24)
> +					break;

Hmm,, maybe that should be:

	if (modrm_rm == 4 && !(sib == 0x24 && rex_b == rex_x))

Because what we have is that once we have a SIB byte, rex_b is for
sib_base and rex_x is always sib_index, and we need to ensure that
sib_base == sib_index for the trivial case.


/me changes...
