Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655C5316FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhBJTKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhBJTKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:10:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oU0lY//YSetaDAVE+2wXzJ+BNqTPO72o3WHUJoCasNk=; b=n6398qgjPSCbWDYTPC7AOLwIVu
        xzXJSyD24HAY8Po70+gVOO4L/qdxOS9rJaSixjyxcBxaQlMWTZbp2FnQT/FQbjlLCyVZ8yviwoFiM
        f7oG33x5EFeLCg/hTtUXBjW6tMjjXG4ZnBz6gmOEICWGnNj4IinsL/Llji+p4cm7iiMMlTRthKTgC
        WoHpUPCaDJ+WlQ3RmzKqkAjS9nPVRfXbwnHeLKU+0zfw6cmzA7Uo/KrHICUtYTHT7BkHyPnnhrlpN
        IIPmn6OEkO0nWY9F35+oABFVVYYPWpVlmJ+DebdVWVKZs5bdRZUSdWMGgJVwdhzIEXrCk/RCBVAyt
        C/448iNQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9urW-009GpQ-7V; Wed, 10 Feb 2021 19:09:18 +0000
Date:   Wed, 10 Feb 2021 19:09:18 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC][PATCH] kprobes: Remove kprobe::fault_handler
Message-ID: <20210210190918.GA2208287@infradead.org>
References: <cover.1612924255.git.luto@kernel.org>
 <YCPmL45wQSyWLmst@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCPmL45wQSyWLmst@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:57:03PM +0100, Peter Zijlstra wrote:
> 
> Somewhat related.. I had this pending.
> 
> ---
> Subject: kprobes: Remove kprobe::fault_handler
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Feb 2 10:43:41 CET 2021
> 
> The reason for kprobe::fault_handler(), as given by their comment:
> 
>  * We come here because instructions in the pre/post
>  * handler caused the page_fault, this could happen
>  * if handler tries to access user space by
>  * copy_from_user(), get_user() etc. Let the
>  * user-specified handler try to fix it first.
> 
> If just plain bad. Those other handlers are ran from non-preemptible
> context and had better use _nofault() functions. Also, there is no
> upstream usage of this.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
