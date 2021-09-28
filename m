Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2741BA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbhI1Whh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:37:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38606 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhI1Whg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:37:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632868555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fULWRZbXDoeuHdTJA34n3iLzjideoJPc2e155xtntU8=;
        b=sRrIKVASeb9xU16cxD33if3ZDLLNEskK0j5xqscqOgXlyJ3o+KFLLouzoO5MccN+ohiAGW
        cLWmdlM9CmsYHNhVfikpBye5wZYqRYsVyFManrEFZf8XVS9fs4IPk0jdwcclm1OaAzbv2W
        3ZDqH2mNHx2Ps19ijsWHKfdqt9mfJBqbF2CWOqiVkKNgEOX5c/cg0OAduujiAUzwV1NatJ
        jO2PKKu/G4GN7+2ROGU82rpEXNZvw5ocCnf5GgKDy5yEVhByfIJueX99qvOMWMNi19Ts6D
        /05sp1Yvw0CJOpxD9j+QQmtmUBm0yBLKoqf0SCH/0Ltq0/3Lqb8yDtcCFPuXTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632868555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fULWRZbXDoeuHdTJA34n3iLzjideoJPc2e155xtntU8=;
        b=C4VHw/v6zG4/YkFbUY2ERpLq0cARW/yYh7Htpu8qk3do+vbjJWn3NNxT1kAHY10sLa/K3X
        00fwvEwu1weIXaAA==
To:     Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 2/3] rcu: Fix rcu_dynticks_curr_cpu_in_eqs() vs noinstr
In-Reply-To: <20210928084217.987503713@infradead.org>
References: <20210928084020.819856223@infradead.org>
 <20210928084217.987503713@infradead.org>
Date:   Wed, 29 Sep 2021 00:35:54 +0200
Message-ID: <87bl4c9vlh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28 2021 at 10:40, Peter Zijlstra wrote:

>   vmlinux.o: warning: objtool: rcu_nmi_enter()+0x36: call to __kasan_check_read() leaves .noinstr.text section
>
> noinstr cannot have atomic_*() functions in because they're explicitly
> annotated, use arch_atomic_*().
>
> Fixes: 2be57f732889 ("rcu: Weaken ->dynticks accesses and updates")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
