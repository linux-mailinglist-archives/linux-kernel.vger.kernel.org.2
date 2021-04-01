Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA9350B64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 02:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhDAAtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 20:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232634AbhDAAtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 20:49:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A8F161056;
        Thu,  1 Apr 2021 00:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617238149;
        bh=KSTwLAkBbg0j1W8NI286ja8c2IeVg8GKiXXMlAe5em4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FXF5IMemT/0zbTd4HP1iZvjoMCEzu9Owm4J4i5Mh/uBUIadIF8wSAsT4qNZ526jZz
         ViCdry72YFNwUHCYfLuib5oe8tHUj7X+okMUrxCqV3QpTYObFHYZ4JtAYGzLWI4HKz
         SF1S3CC9RhIdm7vubs6EccQQRqYDDuqZG8iC19D4=
Date:   Wed, 31 Mar 2021 17:49:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        linux-ia64@vger.kernel.org, "Dmitry V . Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] ia64: fix user_stack_pointer() for ptrace()
Message-Id: <20210331174908.4655f2a41a7b1bbec36fae47@linux-foundation.org>
In-Reply-To: <20210331084447.2561532-1-slyfox@gentoo.org>
References: <20210331084447.2561532-1-slyfox@gentoo.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 09:44:47 +0100 Sergei Trofimovich <slyfox@gentoo.org> wrote:

> ia64 has two stacks:
> - memory stack (or stack), pointed at by by r12
> - register backing store (register stack), pointed at
>   ar.bsp/ar.bspstore with complications around dirty
>   register frame on CPU.
> 
> In https://bugs.gentoo.org/769614 Dmitry noticed that
> PTRACE_GET_SYSCALL_INFO returns register stack instead
> memory stack.
> 
> The bug comes from the fact that user_stack_pointer() and
> current_user_stack_pointer() don't return the same register:
> 
>   ulong user_stack_pointer(struct pt_regs *regs) { return regs->ar_bspstore; }
>   #define current_user_stack_pointer() (current_pt_regs()->r12)
> 
> The change gets both back in sync.
> 
> I think ptrace(PTRACE_GET_SYSCALL_INFO) is the only affected user
> by this bug on ia64.
> 
> The change fixes 'rt_sigreturn.gen.test' strace test where
> it was observed initially.
> 

I assume a cc:stable is justified here?

The bug seems to have been there for 10+ years, so there isn't a lot of
point in looking for the Fixes: reference.
