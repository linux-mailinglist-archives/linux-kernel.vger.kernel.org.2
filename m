Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F02362095
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbhDPNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235445AbhDPNLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8062061153;
        Fri, 16 Apr 2021 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618578689;
        bh=H5tvqGKtsytmfz9hrh5Tz3t3yEGosI9S7z/zgAa6I5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzdoGw1lcLOWBafrJ2vv0zLT1VF1BjVcGl4k9Xu/VZiu/6PadIksHw49WhkCMRhjw
         NGaXYhbyks/bTcBS7aeR3vWTH5TRknBPyCs5E64N/jrRlDYJ8KbitTu37do3e25ISF
         JwdObOyySYAdVXSH56NnXIlmD1dTrAXWgGRda8Un12mS7Onc27+U2NpS03002Ly3Eh
         uSFVs4RHep5eelQ5xVHAN62uH4CgMfuA2OqUU3KvdJCL1x56X04kLWre4S/3Rd8Fyd
         RAN9lmEuDcnZhFM07b99P4NTF+NJ+oRhHhToBjz44xL9o8LgAgNHmmVPY5WLfjHATA
         ZD5oe7T417Z6w==
Date:   Fri, 16 Apr 2021 16:11:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Simplify alloc_insn_page() with
 __vmalloc_node_range
Message-ID: <YHmM/ZWaO95o6cZo@kernel.org>
References: <20210413180231.19b72601@xhacker.debian>
 <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
 <20210414152728.418a41fb@xhacker.debian>
 <YHbqN0B5QnpWtzc/@kernel.org>
 <20210416150616.027f5bae@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416150616.027f5bae@xhacker.debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:06:16PM +0800, Jisheng Zhang wrote:
> On Wed, 14 Apr 2021 16:12:23 +0300 Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> 
> > > So kprobes ss ins slot page "must be in the range of relative branching only
> > > for x86 and arm"
> > >
> > > And Jarkko's "arch/x86: kprobes: Remove MODULES dependency" series look
> > > much better. The last version is v5, I'm not sure whether Jarkko will
> > > send new version to mainline the series.  
> > 
> > Ya, I got really busy with upstreaming SGX. That's why this was left out
> > (but luckily SGX got finally into upstream).
> > 
> > Thanks for reminding. Any motivation to pick it up and continue where I
> > left of?
> > 
> 
> I can try, I will try to send patches once next rc1 is released.
> 
> thanks

Alright, thanks. Be sure to CC me, I'm happy to test them in my
environment.

/Jarkko
