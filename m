Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9576435F495
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346792AbhDNNNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233652AbhDNNMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:12:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A685C61132;
        Wed, 14 Apr 2021 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618405946;
        bh=rBpwZWHONd/pVnqDvMG+U/0SeZ4Pw7B4WEWon7jG2Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOj77SGYaroWYhk4SYOtl/kHErlyYsfASXsCKn5chVa/5239+Jjp4g/rqqvOShbxk
         6jRHB7aj3eCfnd8bzULlQeMNmkbDRDwOxCtfMA6ExWPAUeYIw+YmTkvkwDfOmDGE/D
         wbf/WxP56ZSOK5WeH7kM2OMZEMNXk0iYk6UVw6peA+3DBy7/nx//M8K0pLK1OJU5u1
         CemzRIptuE7oUvFESUCJUb06ShEBBfF+xLd5Ho6VvmQCaIM2BZgA0IGI2wc6/KCqb/
         0qP1gs/EP2VRqyCE7/Nomcg4cnRhmi08NooBcSCcy/0ZM6Bykbmy2+pcrmoJo48Xho
         d/Ec85ANpSLXA==
Date:   Wed, 14 Apr 2021 16:12:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Simplify alloc_insn_page() with
 __vmalloc_node_range
Message-ID: <YHbqN0B5QnpWtzc/@kernel.org>
References: <20210413180231.19b72601@xhacker.debian>
 <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
 <20210414152728.418a41fb@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414152728.418a41fb@xhacker.debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 03:27:28PM +0800, Jisheng Zhang wrote:
> Jisheng Zhang wrote:
> 
> > 
> > 
> > Hi,  
> 
> Hi
> 
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
> 
> And Jarkko's "arch/x86: kprobes: Remove MODULES dependency" series look
> much better. The last version is v5, I'm not sure whether Jarkko will
> send new version to mainline the series.

Ya, I got really busy with upstreaming SGX. That's why this was left out
(but luckily SGX got finally into upstream).

Thanks for reminding. Any motivation to pick it up and continue where I
left of?

/Jarkko
