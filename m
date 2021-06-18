Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B224E3ABFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 02:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhFRAIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 20:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhFRAIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 20:08:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 340EE61369;
        Fri, 18 Jun 2021 00:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623974763;
        bh=jLmwqbg1nf5vjziJwAdKMPZsBWmEUxARXi45U7jKl2w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OoN2DxDZHlw2Vn533AGJ/KJZmC0SXvgBWu++dM+4iIsaFCLkwjVRFRbxLOA/kysw8
         MwZba+zARl1RnL/fZ+byxqL4SIV7PIx4OYeUzdk01K+ou7rg3tLD1x1hizXV1rqNcp
         JrCUC8D/XkDYmlpEcjd1V/PZRJ94VnUuBfnGgfmO3E+G3wa7bIzPWiYtOhS9/taZbs
         SBuRaHK5mpFAtB2M42WwXi8gIctLq+JegQhd2e7UCFKrcTokR4KennZSW397UTXGQc
         MXsITysuFarlEYON3Nfqx5eegnkb3d0nZqlHcq/uXkytHXjm+JkG5ViQGYqr5dVEfu
         liH9e7RSsefWQ==
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
To:     paulmck@kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        the arch/x86 maintainers <x86@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <20210617150214.GX4397@paulmck-ThinkPad-P17-Gen-1>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <a2df9a2c-520c-55aa-dd48-a4e8fa861bde@kernel.org>
Date:   Thu, 17 Jun 2021 17:06:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617150214.GX4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/21 8:02 AM, Paul E. McKenney wrote:
> On Wed, Jun 16, 2021 at 10:32:15PM -0700, Andy Lutomirski wrote:
>> I would appreciate everyone's thoughts as to whether this scheme is sane.
>>
>> Paul, I'm adding you for two reasons.  First, you seem to enjoy bizarre locking schemes.  Secondly, because maybe RCU could actually work here.  The basic idea is that we want to keep an mm_struct from being freed at an inopportune time.  The problem with naively using RCU is that each CPU can use one single mm_struct while in an idle extended quiescent state (but not a user extended quiescent state).  So rcu_read_lock() is right out.  If RCU could understand this concept, then maybe it could help us, but this seems a bit out of scope for RCU.
> 
> OK, I should look at your patch, but that will be after morning meetings.
> 
> On RCU and idle, much of the idle code now allows rcu_read_lock() to be
> directly, thanks to Peter's recent work.  Any sort of interrupt or NMI
> from idle can also use rcu_read_lock(), including the IPIs that are now
> done directly from idle.  RCU_NONIDLE() makes RCU pay attention to the
> code supplied as its sole argument.
> 
> Or is your patch really having the CPU expect a mm_struct to stick around
> across the full idle sojourn, and without the assistance of mmgrab()
> and mmdrop()?

I really do expect it to stick around across the full idle sojourn.
Unless RCU is more magical than I think it is, this means I can't use RCU.

--Andy
