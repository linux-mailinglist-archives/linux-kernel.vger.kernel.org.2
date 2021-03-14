Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236C533A89F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCNWnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:43:16 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:37708 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCNWnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:43:05 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7349692009C; Sun, 14 Mar 2021 23:43:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6492192009B;
        Sun, 14 Mar 2021 23:43:03 +0100 (CET)
Date:   Sun, 14 Mar 2021 23:43:03 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: The killing of ideal_nops[]
In-Reply-To: <YEjuArPJsSYDaYeI@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.2103142340300.33195@angie.orcam.me.uk>
References: <20210309120519.7c6bbb97@gandalf.local.home> <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net> <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com> <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net> <YEiS8Xws0tTFmMJp@hirez.programming.kicks-ass.net>
 <YEiZXtB74cnsLTx/@hirez.programming.kicks-ass.net> <YEid+HQnqgnt3iyY@hirez.programming.kicks-ass.net> <20210310091324.0c346d5f@oasis.local.home> <YEjWryS/9uB2y62O@hirez.programming.kicks-ass.net> <CAADnVQKMRWMuAJEJBPADactdKaGx4opg3y82m7fy59rRmA9Cog@mail.gmail.com>
 <YEjuArPJsSYDaYeI@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021, Peter Zijlstra wrote:

> Below is the latest version which I just pushed out to my git tree so
> that the robots can have a go at it.

 Do you want me to quickly check it with a real i486, or is it already 
covered by said robots (NB I wouldn't trust QEMU with such stuff)?

  Maciej
