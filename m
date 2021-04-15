Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82D0360342
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhDOHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOHZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:25:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C154BC061574;
        Thu, 15 Apr 2021 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qIUuzFbM5Xu+iHP+ZYetd8xb2tkbqd4x6+aFiWRS990=; b=BxvxQo5kHKlbeo6LBzqzVUuR7y
        E8nyNJVa/LsIQg1XXQmrG+9IQ26U2jgSj3WP+T1sLkHoGdYWod8YIWPLFZcss7xTiU5wJZlXUI/3A
        lfskGSgjCWhuNYWrMstBdAVbku/FURyQAhY9VAg7mQBGQjeK7Hdmxw7THxScyf35kqPX+4eO0uMBI
        TV+WqJ5IuVMMMqwMhop+O+lMlb3Gd4qVY/sLLBOtWpHAFPPt3ma0GoDo49TLjr/qNX2DBeQxWKO39
        /SsV9Mx6EFw9O5x0uJJ7F2SKRjHWzPpaxslfs6eLcg6dFpfAYflLMq4dx4gkkgTP1kI91cAw/6DK7
        2mz1yxLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWwMl-008C72-5N; Thu, 15 Apr 2021 07:24:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7F76300209;
        Thu, 15 Apr 2021 09:24:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B22EC20BF5EFA; Thu, 15 Apr 2021 09:24:41 +0200 (CEST)
Date:   Thu, 15 Apr 2021 09:24:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] objtool: prevent memory leak in error paths
Message-ID: <YHfqOVf1hGlbWjLP@hirez.programming.kicks-ass.net>
References: <20210413204511.GA664936@LEGION>
 <20210414084709.GT6021@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414084709.GT6021@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:47:09AM +0300, Dan Carpenter wrote:
> On Wed, Apr 14, 2021 at 01:45:11AM +0500, Muhammad Usama Anjum wrote:
> > Memory allocated by sym and sym->name isn't being freed if some error
> > occurs in elf_create_undef_symbol(). Free the sym and sym->name if error
> > is detected before returning NULL.
> > 
> > Addresses-Coverity: ("Prevent memory leak")
> > Fixes: 2f2f7e47f052 ("objtool: Add elf_create_undef_symbol()")
> > Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> > ---
> > Only build has been tested.
> > 
> 
> Just ignore leaks from the tools/ directory.  These things run and then
> exit and all the memory is freed.  #OldSchoolGarbageCollector

Mostly true; but I suspect tools/perf might care, it has some longer
running things in.
