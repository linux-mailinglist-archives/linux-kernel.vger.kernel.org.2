Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04243FFB46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhICHux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:50:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55824 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhICHuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:50:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 705962248C;
        Fri,  3 Sep 2021 07:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630655391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBV68o6W11adCnQjCz2zAGQ8TYTKxVH5j7R83gTy6LY=;
        b=gppXaYNxMCM4jRCFUJ+Ofe/DSMhM46QMsnlS3Jm9GZk4sXFX1LihMw6t3Usg/oQydX+Mkn
        xLk87JN4tecJ6GTJlqBRUapceTbdf43ixYsaeCpO0KVl9SjCXoZAAtlzWRZPzAKxW/WEFt
        BFyaBYQzoVg8aBaja0TFtTu8IY272dY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 109DFA3B97;
        Fri,  3 Sep 2021 07:49:51 +0000 (UTC)
Date:   Fri, 3 Sep 2021 09:49:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cminyard@mvista.com, minyard@acm.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_kill: oom_score_adj broken for processes with small
 memory usage
Message-ID: <YTHTnvSh7WRNHG/n@dhcp22.suse.cz>
References: <20210701125430.836308-1-minyard@acm.org>
 <YPEW3H+W/uiRYIfn@dhcp22.suse.cz>
 <20210716122547.GI3431@minyard.net>
 <20210902125501.c83101f27f1a02c58188e3f3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902125501.c83101f27f1a02c58188e3f3@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-09-21 12:55:01, Andrew Morton wrote:
> On Fri, 16 Jul 2021 07:25:47 -0500 Corey Minyard <cminyard@mvista.com> wrote:
> 
> > On Fri, Jul 16, 2021 at 07:19:24AM +0200, Michal Hocko wrote:
> > > On Thu 01-07-21 07:54:30, minyard@acm.org wrote:
> > > > From: Corey Minyard <cminyard@mvista.com>
> > > > 
> > > > If you have a process with less than 1000 totalpages, the calculation:
> > > > 
> > > >   adj = (long)p->signal->oom_score_adj;
> > > >   ...
> > > >   adj *= totalpages / 1000;
> > > > 
> > > > will always result in adj being zero no matter what oom_score_adj is,
> > > > which could result in the wrong process being picked for killing.
> > > > 
> > > > Fix by adding 1000 to totalpages before dividing.
> > > 
> > > Yes, this is a known limitation of the oom_score_adj and its scale.
> > > Is this a practical problem to be solved though? I mean 0-1000 pages is
> > > not really that much different from imprecision at a larger scale where
> > > tasks are effectively considered equal.
> > 
> > Known limitation?  Is this documented?  I couldn't find anything that
> > said "oom_score_adj doesn't work at all with programs with <1000 pages
> > besides setting the value to -1000".
> > 
> > > 
> > > I have to say I do not really like the proposed workaround. It doesn't
> > > really solve the problem yet it adds another special case.
> > 
> > The problem is that if you have a small program, there is no way to
> > set it's priority besides completely disablling the OOM killer for
> > it.
> > 
> > I don't understand the special case comment.  How is this adding a
> > special case?  This patch removes a special case.  Small programs
> > working different than big programs is a special case.  Making them all
> > work the same is removing an element of surprise from someone expecting
> > things to work as documented.
> > 
> 
> Can we please get this resolved one way or the other?

As I've already said, I do not see this practical enough problem to
warrant special treatment. Do we really care about controlling the oom
behavior for tasks with <4MB of memory?

I fully agree that the current situation is not ideal. The whole
oom_score* API sucks but here we are with an user API that is
effectivelly impossible to fix properly.

-- 
Michal Hocko
SUSE Labs
