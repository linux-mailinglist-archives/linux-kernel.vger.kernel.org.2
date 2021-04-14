Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB735EF78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350009AbhDNIXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348116AbhDNIXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:23:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBA25613B1;
        Wed, 14 Apr 2021 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618388583;
        bh=Km7I9PdJFzfGIP73XKM9CEP0KFnUi+R5roL2Xwtps8g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rXaoy70oH0V5AucEU164eRq04UniZC9Si92KuwTd+eoB4bC8qYqvikks9LGa/i4QG
         Oq8gn+rjfXwmn9DuYD1sJD4fTlbzlVrWC3ZGJMx6bWW+Bu0Flndp+LNLTBfR3N4+c+
         McIRdgYoNU98q6mYsxTljrOBzLr3f7kBbnKmgtHBFTCn75ByXP6Rlgx1lMF5GhpaDG
         E0gvDsByUBpjysWGydNQE9ZKKGBAKuKfU9l0OAK80XZCvoYlVx2AVihd4ZO15DovC8
         gIE2LSSfYq/a1npc+8oxeG+p0mk0tmUac4xJRkhsW0UDd4Ub/o8ezxsB8cTeU8N67g
         Z/9jGc2X9hzjg==
Date:   Wed, 14 Apr 2021 17:22:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Simplify alloc_insn_page() with
 __vmalloc_node_range
Message-Id: <20210414172258.e44302c4524644b92ce106ec@kernel.org>
In-Reply-To: <20210414152728.418a41fb@xhacker.debian>
References: <20210413180231.19b72601@xhacker.debian>
        <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
        <20210414152728.418a41fb@xhacker.debian>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Wed, 14 Apr 2021 15:27:28 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

\
> > 
> > On Tue, 13 Apr 2021 18:03:24 +0800
> > Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> >   
> > > Use the __vmalloc_node_range() to simplify x86's alloc_insn_page() 
> > > implementation.  
> > 
> > Have you checked this is equivarent to the original code on all 
> > architecture? IIRC, some arch has a special module_alloc(),  
> 
> > Indeed, this isn't equivarent to the original code. FWICT, the differences on x86 are:
> 
> > 1) module_alloc() allocates a special vmalloc range
> > 2) module_alloc() randomizes the return address via. module_load_offset()
> > 3) module_alloc() also supports kasan instrumentation by kasan_module_alloc()
> 
> > But I'm not sure whether the above differences are useful for kprobes ss
> > insn slot page or not. Take 1) for example, special range in module_alloc
> > is due to relative jump limitation, modules need to call kernel .text. does
> > kprobes ss ins slot needs this limitation too?
> 
> Oops, I found this wonderful thread:
> https://www.lkml.org/lkml/2020/7/28/1413
> 
> So kprobes ss ins slot page "must be in the range of relative branching only
> for x86 and arm"

Yes, at this moment. (Not sure we can introduce similar feature on other arch too)

> 
> And Jarkko's "arch/x86: kprobes: Remove MODULES dependency" series look
> much better. The last version is v5, I'm not sure whether Jarkko will
> send new version to mainline the series.

I hope so. If module_alloc() itself is implemented on the generic text_alloc(),
I can replace the module_alloc() with text_alloc(). 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
