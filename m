Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDE644B525
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhKIWLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbhKIWLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:11:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D73C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JEZpK26Jp71HL0nxbMNgr323nD6hTVEerZISLVX9BkY=; b=Q1cJrjJI2yHP+T0dM5HtF7KWCg
        tzu1/s76r2oYU6Fwkdm/yXs15rFfrKI1JDSxhQ3ALNsFLBi+4cs78LSD60m5a03cMTaAwCO49uTtL
        qK1/hSlhMYAHBf25xfkdp2ZH3KhzDT/u0q5rWqkqbkI2yZcwgY4xxg9yIFsbkZVWNu/cQmUErWyT9
        QG30AD3VazOv2vnXE7hD/2qPIUTraSdIU6LunSWdD5puw6hAeWctuL3CTfU2yBq8a/tn74B0lRZfO
        mVT0mVuOitBGPNnknTn0OJrY9ljuJcrZevPNxTt1vkj+qXlmAuTwX07S0IZd50dDAKlHmMtwCMIKY
        T40zcOJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkZIF-001Ndz-0e; Tue, 09 Nov 2021 22:08:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2CB49862D2; Tue,  9 Nov 2021 23:08:37 +0100 (CET)
Date:   Tue, 9 Nov 2021 23:08:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v0 00/12] x86/mce: Correct the noinstr annotation
Message-ID: <20211109220837.GZ174703@worktop.programming.kicks-ass.net>
References: <20211104144035.20107-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104144035.20107-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 03:40:23PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi,
> 
> here's a first preliminary (it is based on some random 5.16-rc0 commit
> and is tested only in qemu) of the series which correct all the noinstr
> annotation of the #MC handler.
> 
> Since it calls a bunch of external facilities, the strategy is to mark
> mce-specific functions called by the #MC handler as noinstr and when
> they "call out" so to speak, to do a begin/end sandwich around that
> call.

Some things are obviously fine, like annotating away mce_panic(), I mean
we're going to panic, so who cares if instrumentation is going to make
it explode earlier.

But other things are non-obvious to me; in principle I'm thinking much
of #MC really doesn't want instrumentation because things are fragile
and the more 'crap' runs the more chance we'll trigger a second fail and
blow up the system, right?

Now, MCE code hasn't been 'architected' much, and as such seems to call
out to lots of code, so perhaps put in an explicit comment with
instrumentation_begin()'s you *know* are wrong, but are the best we can
do to shut things up -- for now.

That way we don't forget things are broken and need more work :-)
