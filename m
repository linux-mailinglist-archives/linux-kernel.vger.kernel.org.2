Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7B83A03B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbhFHTUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:20:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49748 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhFHTIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:08:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623179201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=viCMplLLhzMP7KufDq369MshSO3Bi55bAeU/CYPvR+w=;
        b=eWHfJcMU1GgcTrF83DNqnHWRZLGiCp/oLGCLSmRArJYN+klgiMpaMfpLDlbg1Nk77j2Uqk
        rBCTmZy7CChtiT8i9/65DGlVe7eDMGvVL6yQSf5Q8h5BMisiT2GvY0oth27FDv3ikNoesc
        UG2nfBZ5b1gl9CyMJdwhN2Sw2NhuO8T++t1AO+Zqs0htxUnmHLFC+cb83YqkLXjQBZBliw
        m+SWX86Ykg/L5CMlRPYeDD89EXr33zvL/XoOlVzwR8YpTKmnMdxCmfVaHLUt0EQjUD3ETL
        V5pJ6yblz/s87n6Ntdtxz3CiPgAQfRnpqIekijPpi50garSO6vFG+Wc6qOrKrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623179201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=viCMplLLhzMP7KufDq369MshSO3Bi55bAeU/CYPvR+w=;
        b=17p276+cfTNn45z1cJ1VfH0wAHZyHUk/JxQJbwfa51cotwojzi+mC1gvLnyro3zrRKqDiu
        W+Scwt4kC9dQDlCg==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [patch V3 4/6] x86/pkru: Make PKRU=0 actually work
In-Reply-To: <80208a08-eee7-5725-d9ce-7b11fc5b2ab1@intel.com>
References: <20210608143617.565868844@linutronix.de> <20210608144346.045616965@linutronix.de> <80208a08-eee7-5725-d9ce-7b11fc5b2ab1@intel.com>
Date:   Tue, 08 Jun 2021 21:06:41 +0200
Message-ID: <87wnr4xjjy.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08 2021 at 09:06, Dave Hansen wrote:
> On 6/8/21 7:36 AM, Thomas Gleixner wrote:
>> When user space brings PKRU into init state, then the kernel handling is
>> broken:
>
> Nit: while setting PKRU=0 _can_ trigger this issue (on AMD), the
> underlying problem is truly with the init state and not simply with any
> wrpkru(0).  IOW, I like the changelog better than the subject.
>
> Maybe something like this would be more precise:
>
> 	x86/pkru: Write hardware init value to PKRU when xstate is init

Indeed.
