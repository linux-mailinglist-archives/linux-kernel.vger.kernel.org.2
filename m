Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C733AD9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCOIeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCOIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:34:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6304BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WP1+kEkpWwIMY5F3rN8QbOxecZIRGyIBEVF6fseXUyc=; b=oG/MR5mHInuZm06IaaEF9C3ooY
        1EHe6COHJvwunM+nF3iBhVqu5Cp3giiLFjhumRzLED+yCcBzRf8CqOGcTDhowPulgv9wqfrhAbhTl
        IUtjfdPtJeQgtVBz9SIlAW6DcQC1y5ekrvptOok+rLbRC9kjlN5r43EAo2JTd2I6weegO0jqVIOo3
        kmZ084P+mh9/6FZGZzkxv3t6l0Fz502+QECdEGhEC2A/6rZ9ob+Byuu/3YA3BwAKc28IR0r847XLd
        npIGe2Pp29DVAout1jP7vl/y+FwGC6A7ipZqV1wbnhxeTZ7qBt5Aip+fgZ4+6pwJ41e3F9q/CsmFW
        +2/vluhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLifa-00HS2O-Rg; Mon, 15 Mar 2021 08:33:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 478AA303205;
        Mon, 15 Mar 2021 09:33:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B29623CC228C; Mon, 15 Mar 2021 09:33:45 +0100 (CET)
Date:   Mon, 15 Mar 2021 09:33:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
Message-ID: <YE8b6dgsEG4OU0ay@hirez.programming.kicks-ass.net>
References: <161573639668.27979.17827928369874291298.tglx@nanos>
 <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 01:15:25PM -0700, Linus Torvalds wrote:
> On Sun, Mar 14, 2021 at 8:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >  - A fix for the static_call mechanism so it handles unaligned
> >    addresses correctly.
> 
> I'm not disputing the fix in any way, but why weren't the relocation
> info and function start addresses mutually aligned?
> 
> Are we perhaps missing some .align directive somewhere?
> 
> Or am I missing something?

So I considered looking into that, but since carrying the flag on the
absolute address is always correct I figured it was the more robust fix.

I suppose I can try and figure out where alignment went wobbly.
