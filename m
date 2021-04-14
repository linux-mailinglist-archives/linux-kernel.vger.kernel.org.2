Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159C735F496
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347023AbhDNNNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244296AbhDNNNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:13:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67C826117A;
        Wed, 14 Apr 2021 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618405996;
        bh=zNA9BW02865jD8k52Q6N54fwSyrlqUjrgA0nHCv2pkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyEbhgQI0xBf5abd0ytIk3pw4a3AXrGR++kM9+ipEhfY2pDEh08X+ZwDGoCr7wyTi
         Q3qWH3xz2LREosENHfPJzj8F59xQq1wlt/zJgvI7OOjCGQiQ8a2RxwQ2tfVQEe1PNz
         Pzp6884eIBPqAp05rTqPI4MyOXj2mrxXexdDg4ok8jWNxc7HZ9fhWxgmKdSNNagwte
         7+lKmghLwD7mk+FQNVh0Bffn0Fqjzfdc4JcHrRkNLYEUUfZ3xA53qUzjdSRXO1hX02
         o4PUWEN1r/cdk0C+oi2FVeNPTg4cMEgQWvl5JCVQC136ooMDpzb37tb0tsCvaARAFv
         ZYZ6ro/Rlkpcg==
Date:   Wed, 14 Apr 2021 16:13:14 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Simplify alloc_insn_page() with
 __vmalloc_node_range
Message-ID: <YHbqaiEYXpGZq3Cd@kernel.org>
References: <20210413180231.19b72601@xhacker.debian>
 <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
 <20210414152728.418a41fb@xhacker.debian>
 <20210414172258.e44302c4524644b92ce106ec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414172258.e44302c4524644b92ce106ec@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 05:22:58PM +0900, Masami Hiramatsu wrote:
> Hi Jisheng,
> 
> On Wed, 14 Apr 2021 15:27:28 +0800
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
> \
> > > 
> > > On Tue, 13 Apr 2021 18:03:24 +0800
> > > Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> > >   
> > > > Use the __vmalloc_node_range() to simplify x86's alloc_insn_page() 
> > > > implementation.  
> > > 
> > > Have you checked this is equivarent to the original code on all 
> > > architecture? IIRC, some arch has a special module_alloc(),  
> > 
> > > Indeed, this isn't equivarent to the original code. FWICT, the differences on x86 are:
> > 
> > > 1) module_alloc() allocates a special vmalloc range
> > > 2) module_alloc() randomizes the return address via. module_load_offset()
> > > 3) module_alloc() also supports kasan instrumentation by kasan_module_alloc()
> > 
> > > But I'm not sure whether the above differences are useful for kprobes ss
> > > insn slot page or not. Take 1) for example, special range in module_alloc
> > > is due to relative jump limitation, modules need to call kernel .text. does
> > > kprobes ss ins slot needs this limitation too?
> > 
> > Oops, I found this wonderful thread:
> > https://www.lkml.org/lkml/2020/7/28/1413
> > 
> > So kprobes ss ins slot page "must be in the range of relative branching only
> > for x86 and arm"
> 
> Yes, at this moment. (Not sure we can introduce similar feature on other arch too)
> 
> > 
> > And Jarkko's "arch/x86: kprobes: Remove MODULES dependency" series look
> > much better. The last version is v5, I'm not sure whether Jarkko will
> > send new version to mainline the series.
> 
> I hope so. If module_alloc() itself is implemented on the generic text_alloc(),
> I can replace the module_alloc() with text_alloc(). 

I can of course look into this too. Right now in two vacation coming back
end of this month.

/Jarkko
