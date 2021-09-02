Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368BD3FED60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbhIBMD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhIBMDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:03:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD4FC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SPg7cADjdndvoq8PuHYugiksgDU+yBgg7m/+ju3m9a8=; b=lPjGE2hWaENgwwPjjBicsVqKFR
        8VWUbzXhCtP8FkxEroSIomITpLoIPllTaTxbEqPYEVL2K2Y/B6fOPtSCXpGQ8gHPjcCWzSageM+lm
        o8CuZknze0Oc90xEj7/A8015xmL85riu9tANIWrnxd/AGpZIPeZloAoG65ubVBTpPhmonjspW2gPV
        3KV8UTHj7peoyH4Ds+/ItX3ZQPg/8jb0ejhSl/POuE5Hb0TfNcVO8htsd7PF0XbxdXe4+a0EQBS1k
        9ih/uyjQb/s6j+cJccCXcDOVRuH1qnIenCKdg3UZp/TVC8Rd0ypEgfjfEfP7dxSAJRnb/rtY5FjJu
        18uyGC1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLlQT-0007B8-DU; Thu, 02 Sep 2021 12:02:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA89430029F;
        Thu,  2 Sep 2021 14:02:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4F70285E1143; Thu,  2 Sep 2021 14:02:38 +0200 (CEST)
Date:   Thu, 2 Sep 2021 14:02:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 22/24] x86/entry: Implement and use do_paranoid_entry()
 and paranoid_exit()
Message-ID: <YTC9Xv5K6npINezG@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-23-jiangshanlai@gmail.com>
 <YTCoenvIaHjLQmAC@hirez.programming.kicks-ass.net>
 <465e2f89-402d-6f05-ab36-46a6f005f2b3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465e2f89-402d-6f05-ab36-46a6f005f2b3@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 06:42:16PM +0800, Lai Jiangshan wrote:
> On 2021/9/2 18:33, Peter Zijlstra wrote:
> > On Wed, Sep 01, 2021 at 01:50:23AM +0800, Lai Jiangshan wrote:
> > 
> > > +	call	do_paranoid_entry
> > >   	ret
> > 
> > That's normally spelled like:
> > 
> > 	jmp do_paranoid_entry
> > 
> > But the same comment as for error_entry but more; pretty much all that's
> > left in asm is things like:
> > 
> > 
> > 	call paranoid_entry;
> > 
> > 	# setup args
> > 	call \cfunc
> > 
> > 	call paranoid_exit
> > 
> > which seems like prime material to also pull into C to avoid the
> > back-and-forth thing. In fact, why can't you call paranoid_entry/exit
> > from \cfunc itself? The IDT macros should be able to help.
> > 
> 
> It sounds better.
> 
> I should have moved the code of pushing pt_regs out of paranoid_entry(),
> so that I could also have seen this.
> (and we don't need do_paranoid_entry(), paranoid_entry() itself can be in C)
> 
> The \cfunc would need to be marked as entry_text, right?

Yes I think so. The distinction between .entry.text and .noinstr.text is
that the former it mapped into the userspace mapping, while the latter
is not. Seeing how the PTI swizzling still has to happen when calling
cfunc, that had bettern be .entry.text.

If we care about a strict minimum of .entry.text the IDT macros can
generate a noinstr function to be called the moment we've done the PTI
munging I suppose.
