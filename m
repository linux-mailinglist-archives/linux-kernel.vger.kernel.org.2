Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D078310AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhBELu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:50:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhBELrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:47:00 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612525555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ti1jxzZHJnqvrbdzPXpr0Nbir1Y8tKFvhkXHXVIDZIU=;
        b=Ub/u/zgqOw0kaxnlHvwYEz4fbOzb56rbGTCnApKFhNB5JGgRxMiLnirNTR3vjduHj2uHg1
        BtoRqFJ4FIKamp/CjvWpp4n/CptbQA/5o26Didtn6EmlWWwmuSbJBTqIuDqltki4FAc+8q
        ukyqNrBK8UYw7JXO6eya3trfK6GHyseoBJhfhnS2HJnNvAJ9NKb8DuGCx40HAOZZtOlQcl
        jN2ikc8fXUS2aGOLOy8GnZw0GaJjkCNi2xsn7/aAKm7x2QZ8OVMaL1XeJH6sqFSvEOekPE
        o68S5heYeCO89sAlbqCazDaikfUjO3Yuk2jq5WvouqnqOzN86REF7/3aB53Xhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612525555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ti1jxzZHJnqvrbdzPXpr0Nbir1Y8tKFvhkXHXVIDZIU=;
        b=4m7Ypp2/hMlhDYAxc4Hc+zTdQtRussu2yrFTB8HLYSTZFV2vUR36tROuh90zd5TSDF55o+
        nj/6a59HGBf4XMDA==
To:     Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] x86/hw_breakpoint: Prevent data breakpoints on __per_cpu_offset
In-Reply-To: <CALCETrXk_xp5+tZiTOGzFLk76Pc3gGsnO80UzmHf=ZoqrUgr5w@mail.gmail.com>
References: <20210204152708.21308-1-jiangshanlai@gmail.com> <CALCETrXk_xp5+tZiTOGzFLk76Pc3gGsnO80UzmHf=ZoqrUgr5w@mail.gmail.com>
Date:   Fri, 05 Feb 2021 12:45:54 +0100
Message-ID: <877dnmagb1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04 2021 at 16:11, Andy Lutomirski wrote:
> On Thu, Feb 4, 2021 at 6:26 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>> When FSGSBASE is enabled, paranoid_entry() fetches the per-CPU
>> GSBASE value via __per_cpu_offset or pcpu_unit_offsets.
>>
>> When data breakpoint is set on __per_cpu_offset[cpu] (read-write
>> operation), the specific cpu will be stuck in the infinite #DB loop.
>> RCU will try to send NMI to the specific cpu, but it is not working
>> either since NMI also relies on paranoid_entry().
>
> Should we consider having a .percpu..noinstr section and having
> objtool enforce this?

I think so.

Thanks,

        tglx
