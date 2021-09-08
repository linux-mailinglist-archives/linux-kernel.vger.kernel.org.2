Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320E84031F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbhIHAm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhIHAmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:42:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6025610F8;
        Wed,  8 Sep 2021 00:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631061707;
        bh=Fl9d5jER6uMrXU9jHladZH9Uwk2Mr6sLfLmbn/RQy/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UTB+ym435pG8mH7eVVt2vO9vk0m5q4ROk1YaYTUchQFO9rVAzejCBB443NvaKoa/c
         rKgvuHhh5qFB4Q2nCns4YHN50qT9eSyCrfTr5vCm6CRPiz3nbYO6GEJjC7wzOrYLJa
         YUEjHRGY6z6JXFQHdUcD+rbl2PIcX8SyxEYeowtRj5xXfVqX76uXyH0HzJs2fAyA8R
         qx+1dV/U6YfJMFYC4e32vGZTiU6mxMNdA2/8/8KFSmrr6WU8aIDYl5MzjtsAzTusj4
         t4j1AjKfbIyqnjXoRV6OKLvRk/D+3HDvXWLhK5YmS6lWQqi9rqFkjLjsCP4wGtcYmm
         pvLVaHVp4CRFQ==
Date:   Wed, 8 Sep 2021 09:41:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] tools/bootconfig: Fix a compilation issue with
 missing variable
Message-Id: <20210908094145.babedcd252d8e8caf0e2f2ad@kernel.org>
In-Reply-To: <20210907202400.330f4ea4@rorschach.local.home>
References: <20210907230710.1189193-1-punitagrawal@gmail.com>
        <20210907202400.330f4ea4@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021 20:24:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  8 Sep 2021 08:07:10 +0900
> Punit Agrawal <punitagrawal@gmail.com> wrote:
> 
> > While looking to build bootconfig tool in order to debug a kernel boot
> > time issue I noticed that tool fails to compile. The broken changes
> > were introduced by commit e5efaeb8a8f5 ("bootconfig: Support mixing a
> > value and subkeys under a key").
> > 
> > Fix the compile issue by introducing a "ret" variable to track the
> > return value from xbc_node_compose_key().
> > 
> > Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
> > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > ---
> > 
> > (Apologies for the resend. I fat-fingered the email address for lkml)
> 
> And I'm resending my reply to have it recorded as well.
> 
> > 
> > Hi Masami,
> > 
> > I am not sure what went wrong but the patch in the lore link[0]
> > doesn't match the end result (bad merge?). You may want to recheck the
> > other changes to make sure it all looks sane.
> 
> 
> Thanks for reporting this. This is strange. Especially since it's all
> scripts that are used to import these.
> 
> I do remember doing a rebase to fix some issues in another unrelated
> patch. I wonder if I accidentally messed this up during that rebase :-/
> 
> I'll have to investigate this.
> 
> I'll checkout the tree before the affected patch, and reapply the
> changes from my scripts to see if it wasn't my script that broke.
> 
> Again, thanks for reporting this!

Hi Steve,

I've investigated that why this happens here.

https://lore.kernel.org/all/20210831033256.5973-1-jcfaracco@gmail.com/T/#m52f43f6deb874ee726b10ce25ba53e44697a275a

This seems a timing issue. I acked a "simplify" patch April, and
the I wrongly worked on the linus tree for "mixing a value and subkeys"
and send it to you June. At last, those 2 conflicted on your branch and
your merge script might just merge it.
Actually, what Punit and Julio did is reverting 

commit 30d103f2d460 ("tools/bootconfig: Simplify expression")

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
