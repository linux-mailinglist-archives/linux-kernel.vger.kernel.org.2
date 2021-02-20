Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4494232064B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 17:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBTQtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 11:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTQtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 11:49:39 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6599C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 08:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=46TCTgnZodiU01OXPfDGErt7ZNsroSjj4AQbXDSDo1E=; b=MXaFW5FGWF1P7ZebLeeNz7/SFM
        cRtlJXrjGvi+zO2ZHvw/+DPg4JbZjTu120D4PqPPqeErPHsiAUz2oFMuZYboCEe0SpJDiP05twOt2
        cOn/+kGpLNapMrI1aa3QvYX9vWq40aSwt+itVmxC35gjC3un1HB79P9IEmYuu1tJlX30w0djsFeJA
        TLFAO98q77HgBKbNGQ55eeM97EZqn6hHkES27VlIoxfWphTOQbPuPacaww1LsmyP05s8KGoiAB5+p
        oIoicnVuPFLFrEQASUlKfr/PhHFw8kqxcFK6mKBKotY3W/xv9OgH2Dx7iMUZgqMb2oaLjIyE5R0Hp
        9yeca7+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDVR3-0003Qx-BQ; Sat, 20 Feb 2021 16:48:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE8E9300DB4;
        Sat, 20 Feb 2021 17:48:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FB782021555E; Sat, 20 Feb 2021 17:48:46 +0100 (CET)
Date:   Sat, 20 Feb 2021 17:48:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        pjt@google.com, mbenes@suze.cz, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <YDE9bmaO4tOZ/HWn@hirez.programming.kicks-ass.net>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
 <20210219215530.ivzzv3oavhuip6un@treble>
 <20210219220158.GD59023@worktop.programming.kicks-ass.net>
 <20210220003920.GG26778@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220003920.GG26778@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 01:39:20AM +0100, Borislav Petkov wrote:
> On Fri, Feb 19, 2021 at 11:01:58PM +0100, Peter Zijlstra wrote:
> > We could, but it so happens Joerg is also wanting negative features. 
> 
> Juergen.

Argh! I should stick to jgross. Sorry.

> > So I was thikning that perhaps we can convince Boris they're not
> > really all that aweful after all :-)
> 
> Well, I'm not crazy about this, TBH - I totally agree with Josh:
> 
> "with objtool generating code, it's going to be a maze to figure out
> where the generated code is coming from"
> 
> and without a real good reason to do this, what's the point? I know,
> because we can. :-)

Well:

 - straight line execution is always better than a round-trip to
   somewhere else, no matter how trivial.
 - supposely EIBRS (yeah, I know, there's a paper out there) should
   result in no longer using retpolines.
 - I really, as in _REALLY_ don't want to do a CET enabled retpoline
 - IOW, retpolines should be on their way out (knock on wood)
 - doing this was fun :-)
 - this stuff was mostly trivial make work stuff I could do with a head
   full of snot and a headache.
 - if we had negative alternatives objtool doesn't need to actually
   rewrite code in this case. It could simply emit alternative entries
   and call it a day.
 - objtool already rewrites code
 - I have more cases for objtool to rewrite code (I'll see if I can
   rebase and post that this weekend -- no promises).
 - also https://lkml.kernel.org/r/20200625200235.GQ4781@hirez.programming.kicks-ass.net

