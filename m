Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9822C3FF466
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347452AbhIBT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347444AbhIBT4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:56:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D3AB610E6;
        Thu,  2 Sep 2021 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1630612502;
        bh=u1LDk6LXB1cLhxmqq/ctqJJhBVTlHtBjyCz5pir16ls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B3fZwAuXRu1ZLFQygZRdiRTy9Dq4BQw+RoOwktrTqff5Mf7qBngPCh8Neh97LWM8V
         WPOTOLDckDj3hZvXBmlI5iBwEkXM88U6zKe3FL8D0N+69bldLif7a2Mxd0Ph/1Tq2w
         jWbNS5Gl3Hh2HrpKqasiaq2awVGc73Df/y/6aUjE=
Date:   Thu, 2 Sep 2021 12:55:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cminyard@mvista.com
Cc:     Michal Hocko <mhocko@suse.com>, minyard@acm.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_kill: oom_score_adj broken for processes with small
 memory usage
Message-Id: <20210902125501.c83101f27f1a02c58188e3f3@linux-foundation.org>
In-Reply-To: <20210716122547.GI3431@minyard.net>
References: <20210701125430.836308-1-minyard@acm.org>
        <YPEW3H+W/uiRYIfn@dhcp22.suse.cz>
        <20210716122547.GI3431@minyard.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 07:25:47 -0500 Corey Minyard <cminyard@mvista.com> wrote:

> On Fri, Jul 16, 2021 at 07:19:24AM +0200, Michal Hocko wrote:
> > On Thu 01-07-21 07:54:30, minyard@acm.org wrote:
> > > From: Corey Minyard <cminyard@mvista.com>
> > > 
> > > If you have a process with less than 1000 totalpages, the calculation:
> > > 
> > >   adj = (long)p->signal->oom_score_adj;
> > >   ...
> > >   adj *= totalpages / 1000;
> > > 
> > > will always result in adj being zero no matter what oom_score_adj is,
> > > which could result in the wrong process being picked for killing.
> > > 
> > > Fix by adding 1000 to totalpages before dividing.
> > 
> > Yes, this is a known limitation of the oom_score_adj and its scale.
> > Is this a practical problem to be solved though? I mean 0-1000 pages is
> > not really that much different from imprecision at a larger scale where
> > tasks are effectively considered equal.
> 
> Known limitation?  Is this documented?  I couldn't find anything that
> said "oom_score_adj doesn't work at all with programs with <1000 pages
> besides setting the value to -1000".
> 
> > 
> > I have to say I do not really like the proposed workaround. It doesn't
> > really solve the problem yet it adds another special case.
> 
> The problem is that if you have a small program, there is no way to
> set it's priority besides completely disablling the OOM killer for
> it.
> 
> I don't understand the special case comment.  How is this adding a
> special case?  This patch removes a special case.  Small programs
> working different than big programs is a special case.  Making them all
> work the same is removing an element of surprise from someone expecting
> things to work as documented.
> 

Can we please get this resolved one way or the other?
