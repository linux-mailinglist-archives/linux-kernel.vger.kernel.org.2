Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336C133F738
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhCQRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhCQRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:38:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99930C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=pZHDH61F8JDjBQFmRm72X0kh02M7l+vzZpTz7WHgynw=; b=kW4Pg5/PGWdAuAzU9py/WjcYe2
        zTe/qUl/1Cb147587G5BgiJDnsLBINkeb3vBjdk5goVnh+/VKKE5SLii07UR7loKOFyoYI7gFCSlb
        dryOO82jM3Oc3UaNUnCI1pr1waljx35xnhuPNlo6dPRkN82Y6GOSU71JcwJjzoLMeqKr5XFZNobfH
        /yIvXaKBCEch0G1+j+z2R3vJTbXcz1bbXn82msvwjB0XV+siY9yFa3ClRubqEAgGndioUwYaxhGgT
        e+p2fS+Sh2GsU3k/g1/z9lfj3ME8xG7/kJDS2Fd+3XKne7dd+JvP7bL+60LdlkDnkte+WgcqYEBjz
        8rxHJPyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMa6z-001vOX-KV; Wed, 17 Mar 2021 17:37:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD57A3050F0;
        Wed, 17 Mar 2021 18:37:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6178203D90CA; Wed, 17 Mar 2021 18:37:36 +0100 (CET)
Date:   Wed, 17 Mar 2021 18:37:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ingo Molnar <mingo@kernel.org>, He Ying <heying24@huawei.com>,
        frederic@kernel.org, paulmck@kernel.org, clg@kaod.org,
        qais.yousef@arm.com, johnny.chenyi@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] smp: kernel/panic.c - silence warnings
Message-ID: <YFI+YMo7zml+spKc@hirez.programming.kicks-ass.net>
References: <20210316084150.75201-1-heying24@huawei.com>
 <20210317094908.GB1724119@gmail.com>
 <9691919b-d014-7433-3345-812c9b19a677@csgroup.eu>
 <YFH0sDpUIUmdpNkQ@hirez.programming.kicks-ass.net>
 <fa3f9880-eb05-f18e-ae7f-4735209f4c94@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa3f9880-eb05-f18e-ae7f-4735209f4c94@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 06:17:26PM +0100, Christophe Leroy wrote:
> 
> 
> Le 17/03/2021 à 13:23, Peter Zijlstra a écrit :
> > On Wed, Mar 17, 2021 at 12:00:29PM +0100, Christophe Leroy wrote:
> > > What do you mean ? 'extern' prototype is pointless for function prototypes
> > > and deprecated, no new function prototypes should be added with the 'extern'
> > > keyword.
> > > 
> > > checkpatch.pl tells you: "extern prototypes should be avoided in .h files"
> > 
> > I have a very strong preference for extern on function decls, to match
> > the extern on variable decl.
> 
> You mean you also do 'static inline' variable declarations ?

That's a func definition, not a declaration. And you _can_ do static
variable definitions in a header file just fine, although that's
typically not what you'd want. Although sometimes I've seen people do:

static const int my_var = 10;

inline is an attribute that obviously doesn't work on variables.

> Using the extern keyword on function prototypes is superfluous visual
> noise so suggest removing it.

I don't agree; and I think the C spec is actually wrong there (too).

The thing is that it distinguishes between a forward declaration of a
function in the same TU and an external declaration for a function in
another TU.

That is; if I see:

void ponies(int legs);

I expect that function to be defined later in the same TU. IOW it's a
forward declaration. OTOH if I see:

extern void ponies(int legs);

I know I won't find it in this TU and the linker will end up involved.

Now, the C people figured that distinction was useless and allowed
sloppiness. But I still think there's merrit to that. And as mentioned
earlier, it is consistent with variable declarations.
