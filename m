Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F3B3A4A49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFKUn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhFKUnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 241BC613C3;
        Fri, 11 Jun 2021 20:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623444086;
        bh=R8Zl1qBmczdl3vpHLy5t8k4S3Tbg49B4SLX/KCUE5Kg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KHKN85mnHbwlYByLvW3nNL2W/GAoC5/omJwkZLCQykr7ToYI97X9sBFbgdBjfzv9s
         9j6yUjoIY1uwr/sYgy4lh4mGVpexZ5P79ShEQiIwpaQy580RK+0zlGuki5ZrFWiSBG
         W66Aja9tNCuKaNK50ONckbidg38L653pCzoceiuQ=
Date:   Fri, 11 Jun 2021 13:41:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Martin Liu <liumartin@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tejun Heo <tj@kernel.org>, minchan@google.com,
        davidchao@google.com, jenhaochen@google.com,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kthread: Prevent deadlock when
 kthread_mod_delayed_work() races with kthread_cancel_delayed_work_sync()
Message-Id: <20210611134125.bdb08ba0d2b6b87dc60d446d@linux-foundation.org>
In-Reply-To: <YMMN5IoXyXqoRsBX@alley>
References: <20210610133051.15337-1-pmladek@suse.com>
        <20210610133051.15337-3-pmladek@suse.com>
        <20210610143030.f599946ec11e1eccde6af4f0@linux-foundation.org>
        <YMMN5IoXyXqoRsBX@alley>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 09:16:52 +0200 Petr Mladek <pmladek@suse.com> wrote:

> On Thu 2021-06-10 14:30:30, Andrew Morton wrote:
> > On Thu, 10 Jun 2021 15:30:50 +0200 Petr Mladek <pmladek@suse.com> wrote:
> > 
> > > The system might hang with the following backtrace:
> > 
> > Well that's not good.
> 
> Fortunately, the API users normally synchronize these operations
> another way. The race should never happen when the API is used
> a reasonable way,
> see https://lore.kernel.org/lkml/YKZLnTNOlUQ85F2s@alley/
> 
> > > Fixes: 9a6b06c8d9a220860468a ("kthread: allow to modify delayed kthread work")
> > > Reported-by: Martin Liu <liumartin@google.com>
> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > 
> > Was a -stable backport considered?
> 
> Good point! It would make sense to backport it. System hang is never
> good.
> 
> Could you please add Cc: stable@vger.kernel.org or should I resend the
> patchset?

I made that change to patches 1&2.  I don't think patch 3 need be
backported?
