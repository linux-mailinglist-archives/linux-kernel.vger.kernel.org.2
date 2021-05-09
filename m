Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B53774C4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 02:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhEIAx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 20:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhEIAxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 20:53:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC323613CE;
        Sun,  9 May 2021 00:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620521571;
        bh=I+ULvUA2SVwFHZH9HWeMYfUMaA+O9efbhdprZAZ8ljU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AsHaHyqlwUrUE2VrlrVGxgNSyj2yKaxncBP/jvOLQhAHJI8HINCtirtWEGY4ngAXF
         ihusQAyNUgXVmaHuoQ9r0a0P/KQpMvux1ViKhlr1+yt3+ZluDMFlbFweeRrvdfG6L5
         SUP5VLdSwuaU+OJZprxXJz2LAYX/nwc500eYyRL4=
Date:   Sat, 8 May 2021 17:52:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     pmladek@suse.com, mingo@kernel.org, bo.he@intel.com,
        yanmin_zhang@linux.intel.com, psodagud@quicinc.com,
        dvyukov@google.com, elver@google.com, linux-kernel@vger.kernel.org,
        ryabinin.a.a@gmail.com, he@google.com
Subject: Re: [PATCH v2 1/2] printk: introduce dump_stack_lvl()
Message-Id: <20210508175250.d28548e312bfae4c8d779e2d@linux-foundation.org>
In-Reply-To: <20210506105405.3535023-1-glider@google.com>
References: <20210506105405.3535023-1-glider@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 May 2021 12:54:04 +0200 Alexander Potapenko <glider@google.com> wrote:

> dump_stack() is used for many different cases, which may require a log
> level consistent with other kernel messages surrounding the dump_stack()
> call.
> Without that, certain systems that are configured to ignore the default
> level messages will miss stack traces in critical error reports.
> 
> This patch introduces dump_stack_lvl() that behaves similarly to
> dump_stack(), but accepts a custom log level.
> The old dump_stack() becomes equal to dump_stack_lvl(KERN_DEFAULT).
> 
> A somewhat similar patch has been proposed in 2012:
> https://lore.kernel.org/lkml/1332493269.2359.9.camel@hebo/
> , but wasn't merged.

Um yeah, I dropped the ball on that one, didn't I?  I suspect pretty
much all dump_stack() callsites should be using this.

