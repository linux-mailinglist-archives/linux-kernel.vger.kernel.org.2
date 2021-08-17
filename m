Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC2C3EE0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhHQAFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232889AbhHQAFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C6C760F22;
        Tue, 17 Aug 2021 00:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629158711;
        bh=2OJ0LsoSrf538Q5c/S7qJehWhX5paGixgZ1CKl5616E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fa5lZzolnJig0lmKA5WkVVmiGlNN0shn2RvzIKaY6XtOU8HF+5oMmf3sYKBt2IN0f
         aZVCWnWRF1M/bsSdXyBQhZREKKLzrG/kk3tdyGncsWfLoLtcyP/FKEQSK8oQjV/38L
         7b3kJ6kQDoqgEwNqcfDmlK/nxaFLHSoENmdQtIJQ=
Date:   Mon, 16 Aug 2021 17:05:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmflags.h: add missing __GFP_ZEROTAGS and
 __GFP_SKIP_KASAN_POISON names
Message-Id: <20210816170510.9d6afcd53c767397aba758ef@linux-foundation.org>
In-Reply-To: <20210816133502.590-1-rppt@kernel.org>
References: <20210816133502.590-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 16:35:02 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Add missing names of __GFP_ZEROTAGS and __GFP_SKIP_KASAN_POISON flags to
> __def_gfpflag_names.
> 
> Fixes: 013bb59dbb7c ("arm64: mte: handle tags zeroing at page allocation time")
> Fixes: c275c5c6d50a ("kasan: disable freed user page poisoning with HW tags")

"fixes" in what way?  ie, what problems were caused by the above commits?

> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -48,7 +48,9 @@
>  	{(unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
>  	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
>  	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
> -	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"}\
> +	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
> +	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"},	\
> +	{(unsigned long)__GFP_SKIP_KASAN_POISON,"__GFP_SKIP_KASAN_POISON"}\
>  
>  #define show_gfp_flags(flags)						\
>  	(flags) ? __print_flags(flags, "|",				\

I'm guessing that the tracing output was messed up in some fashion?


