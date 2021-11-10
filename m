Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB944BCF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhKJIiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhKJIiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:38:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA0C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KQBIHvBKZon1pqxOOwdJjiEbS3m4taieQQby82kVzNc=; b=WRxzj2U3//CGR6XyeLIMQV8vP6
        OiTvd1NKXm0Mbmv6ihvPx7MwDoKEOa6moTZ/y1RwImMjEnWtnCRt9KJFoDOPL8oXe8YKrUYQrJxqe
        9VHVHxE9Ta1G8zV3113f728+Z8oP4hf3qICWpPcIA04GHp6o30DV/20nuXUx/Ow41O4m9umVoeIo7
        PdijSYweOJNy8swxRjq0UttMeS6+p0IBiOlnmoZC2qW6d8uB3bPkdQhCVjXdHoTWQuND3wVnTOiWc
        CF3DIsU1Tz2DZQPM0kXst3gv8p+b3GFzOxLJWCHcC1G4xGh+uGwiQZPKUTh6GJATVhFZ6boEfHF7U
        VkwKN/vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkj55-00FEzb-NZ; Wed, 10 Nov 2021 08:35:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3561430003C;
        Wed, 10 Nov 2021 09:35:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6913212EE584; Wed, 10 Nov 2021 09:35:41 +0100 (CET)
Date:   Wed, 10 Nov 2021 09:35:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, jpoimboe@redhat.com,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org
Subject: Re: [PATCH 2/2] jump_label: refine placement of static_keys
Message-ID: <YYuEXQ7Ur9f88pCw@hirez.programming.kicks-ass.net>
References: <20211110010906.1923210-1-eric.dumazet@gmail.com>
 <20211110010906.1923210-3-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110010906.1923210-3-eric.dumazet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:09:06PM -0800, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> With CONFIG_JUMP_LABEL=y, "struct static_key" content is only
> used for the control path.
> 
> Marking them __read_mostly is only needed when CONFIG_JUMP_LABEL=n.
> Otherwise we place them out of the way to increase data locality.
> 
> This patch adds __static_key to centralize this new policy.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  arch/x86/kvm/lapic.c       |  4 ++--
>  arch/x86/kvm/x86.c         |  2 +-
>  include/linux/jump_label.h | 25 +++++++++++++++++--------
>  kernel/events/core.c       |  2 +-
>  kernel/sched/fair.c        |  2 +-
>  net/core/dev.c             |  8 ++++----
>  net/netfilter/core.c       |  2 +-
>  net/netfilter/x_tables.c   |  2 +-
>  8 files changed, 28 insertions(+), 19 deletions(-)
> 

Hurmph, it's a bit cumbersome to always have to add this __static_key
attribute to every definition, and in fact you seem to have missed some.

Would something like:

	typedef struct static_key __static_key static_key_t;

work? I forever seem to forget the exact things you can make a typedef
do :/
