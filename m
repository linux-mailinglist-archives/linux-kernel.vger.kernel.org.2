Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E103D0417
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 23:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhGTVLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 17:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhGTVLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 17:11:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8B0360FF2;
        Tue, 20 Jul 2021 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626817910;
        bh=m8eVZNZkcZOgNel/6J+bsidUmvY+963qvcwLw6c7K18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xti7+Uo9TDgKQBMvmY5Dtg7rSHSbfxh4UQ+0kKI0uEZGqrqHF7vJNa/FFGKw1/mEq
         bUpgS2N9453O175LjVlMreo2FR1kX6DsxVf/Ap1efaPfpoKz3RCLhE0BJqgiMPWLNm
         lXLe/tQdJCHxfLySgMQVZiTOGUUwxG1vxKopjzPs=
Date:   Tue, 20 Jul 2021 14:51:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrey Vagin <avagin@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] prctl: allow to setup brk for et_dyn executables
Message-Id: <20210720145148.cdcfa3210e39e88a591af12b@linux-foundation.org>
In-Reply-To: <20210121221207.GB2174@grain>
References: <20210121221207.GB2174@grain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 01:12:07 +0300 Cyrill Gorcunov <gorcunov@gmail.com> wrote:

> Keno Fischer reported that when a binray loaded via
> ld-linux-x the prctl(PR_SET_MM_MAP) doesn't allow to
> setup brk value because it lays before mm:end_data.
> 
> For example a test program shows
> 
>  | # ~/t
>  |
>  | start_code      401000
>  | end_code        401a15
>  | start_stack     7ffce4577dd0
>  | start_data	   403e10
>  | end_data        40408c
>  | start_brk	   b5b000
>  | sbrk(0)         b5b000
> 
> and when executed via ld-linux
> 
>  | # /lib64/ld-linux-x86-64.so.2 ~/t
>  |
>  | start_code      7fc25b0a4000
>  | end_code        7fc25b0c4524
>  | start_stack     7fffcc6b2400
>  | start_data	   7fc25b0ce4c0
>  | end_data        7fc25b0cff98
>  | start_brk	   55555710c000
>  | sbrk(0)         55555710c000
> 
> This of course prevent criu from restoring such programs.
> Looking into how kernel operates with brk/start_brk inside
> brk() syscall I don't see any problem if we allow to setup
> brk/start_brk without checking for end_data. Even if someone
> pass some weird address here on a purpose then the worst
> possible result will be an unexpected unmapping of existing
> vma (own vma, since prctl works with the callers memory) but
> test for RLIMIT_DATA is still valid and a user won't be able
> to gain more memory in case of expanding VMAs via new values
> shipped with prctl call.

So...  do you recall why you added that test originally?

This is under prctl(CAP_SET_MM), yes?  What capabilities does this
require?

