Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9404A310168
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhBEAMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:12:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231690AbhBEAMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:12:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EF1664FB5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 00:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612483927;
        bh=sHTFV9b2Xy97POSEoAWGbpB05Ns0HWHrWU/y4Hz5OG8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q2xEU0b1+kqF12gJgLfa0cuGGTTkqw69N7zafzM7OLLbESOjE3Lj1ldXh+2EWHTsA
         h/HOBUUMEEhERJV1nZh1q0Qv91OchVA4GDtkywMIF7SQc14m011iO8PkbhKGCfPHh7
         6E0sWIJLnc4yAlOJKQ2McxmxtumEu6nfjRvZK9RO2y0HQfv56alzv6AqwI/GK3grEs
         bnMjjptRMECNIUaX+r4nm5FwRc7VtH8opK4KfPeNhz/KIne8zyQVfC35lbKbF7HwUy
         raKWujFJZNkWMC+ZRmUbc7WoZUic0s9lBIc2wi72QwDZ0hOCb9R0c9XU2K2yX/DGy5
         hKQ7eIhWJQTUg==
Received: by mail-ed1-f49.google.com with SMTP id y8so6618249ede.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:12:07 -0800 (PST)
X-Gm-Message-State: AOAM532NLBt2o3NBxsuJk+AJk3U2XUMMIIGLg2XQQ0c62X7SbUZStFsy
        z7DgMHJrdJCgrkf5VOPdB0XBxMcnUiHK9cW5M/K5Bg==
X-Google-Smtp-Source: ABdhPJw0XwtXDDTt8eLd2OrTj22fo+izXU7Io4pAy2/YfxbWFOmP49dObxq2JlBkrxA63JuJecxH2gC6AShWGHj2iG4=
X-Received: by 2002:a05:6402:1641:: with SMTP id s1mr1078941edx.238.1612483926090;
 Thu, 04 Feb 2021 16:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20210204152708.21308-1-jiangshanlai@gmail.com>
In-Reply-To: <20210204152708.21308-1-jiangshanlai@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Feb 2021 16:11:54 -0800
X-Gmail-Original-Message-ID: <CALCETrXk_xp5+tZiTOGzFLk76Pc3gGsnO80UzmHf=ZoqrUgr5w@mail.gmail.com>
Message-ID: <CALCETrXk_xp5+tZiTOGzFLk76Pc3gGsnO80UzmHf=ZoqrUgr5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/hw_breakpoint: Prevent data breakpoints on __per_cpu_offset
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 6:26 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> When FSGSBASE is enabled, paranoid_entry() fetches the per-CPU
> GSBASE value via __per_cpu_offset or pcpu_unit_offsets.
>
> When data breakpoint is set on __per_cpu_offset[cpu] (read-write
> operation), the specific cpu will be stuck in the infinite #DB loop.
> RCU will try to send NMI to the specific cpu, but it is not working
> either since NMI also relies on paranoid_entry().

Should we consider having a .percpu..noinstr section and having
objtool enforce this?
