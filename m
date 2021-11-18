Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA53D455964
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 11:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbhKRKwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 05:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245691AbhKRKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:52:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tlV1fMCVKB3UbDKC2ZyZENKwFntoXJQhpiCvgQhgzx8=; b=agQ+L/WqP6NjK5qdbTpKJpHuQ/
        ZpFWEtL/8lEQTaD9NZYD4nHNmboeUBC/z5f6A/5ay5PI8nIQpYyWHZJy1qJwABn3mvLlW5oeRyfcu
        CLfpruq66hLktlAQn3qISvpHKxbFJid4hLM4ep1nFgfWeo5TGA7Geeef8aESyatQb062gI6sj7mqA
        g1FmpZkZ9JxIyu/vlmBhA5C6ejybI1TsJQKlG306FE1JajWtOSJaCtJeGs+4XYcDfKduKLXWg8arV
        O+aqHj+flyM/upWbw4od5jc9mlCMusXiSaBQkuEi8AUkOPu/fFVSgRwofjz/AjkKvWPMzAu0mk5Xb
        6okNMKIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnez5-008OOK-Uz; Thu, 18 Nov 2021 10:49:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBA9C30001B;
        Thu, 18 Nov 2021 11:49:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D14E22D03784D; Thu, 18 Nov 2021 11:49:39 +0100 (CET)
Date:   Thu, 18 Nov 2021 11:49:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     yajun.deng@linux.dev
Cc:     will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refcount: introduce refcount_is_one() helper function
Message-ID: <YZYvw/uOvjKnY/jM@hirez.programming.kicks-ass.net>
References: <YZYSdJh7xpkHJjoa@hirez.programming.kicks-ass.net>
 <20211118074200.GF174703@worktop.programming.kicks-ass.net>
 <20211118035328.5730-1-yajun.deng@linux.dev>
 <a4b7401c06d3baa5d3d0a43d7aa6c62c@linux.dev>
 <aecc489431c38f170097ae1eb37a7d22@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aecc489431c38f170097ae1eb37a7d22@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:34:44AM +0000, yajun.deng@linux.dev wrote:
> November 18, 2021 4:44 PM, "Peter Zijlstra" <peterz@infradead.org> wrote:
> 
> > On Thu, Nov 18, 2021 at 08:12:56AM +0000, yajun.deng@linux.dev wrote:
> > 
> >> November 18, 2021 3:42 PM, "Peter Zijlstra" <peterz@infradead.org> wrote:
> >> 
> >> On Thu, Nov 18, 2021 at 11:53:28AM +0800, Yajun Deng wrote:
> >> 
> >> There are many cases where it is necessary to determine if refcount is one,
> >> introduce refcount_is_one() helper function for these cases.
> >> 
> >> Give me one that is not racy?
> >> 
> >> The following determine refcount is one, 35 count.
> > 
> > Very good, now get me one that isn't broken :-)
> 
> Sorry, I didn't understand what is the 'isn't broken'。

What's the value of refcount_read() given that at any moment a
concurrent refcount_{inc,dec}() can happen?

If you can't know the current value (per the above) then what's the
value of knowing it was one some time ago?

Fundamentally using refcount_read() in control flow is broken, it's a
very bad anti-pattern.
