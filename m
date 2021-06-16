Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C353A95C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhFPJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:17:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55134 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPJRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:17:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF15921A57;
        Wed, 16 Jun 2021 09:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623834945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dX6DjyqaOUD6/uVScM4KLnVbsOc9bUIcwflnPfRnYOM=;
        b=dMo9BI8VveElucxiW458kBj0/nkpuTT8unboI6i6NMRSke9ukFaJ0xBLXAwcMxjlGSjyZm
        LmVtAcW957TbxUwRkYJqHDTwe/bYMquEJfd81QayG/1zIqb+WV26saG9ylz3qKMZ68xv0O
        5w/JmuXd9wxlN0vMtHGcJ5MItPchq44=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8A909A3BAA;
        Wed, 16 Jun 2021 09:15:45 +0000 (UTC)
Date:   Wed, 16 Jun 2021 11:15:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Punit Agrawal <punitagrawal@gmail.com>,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Move EXPORT_SYMBOL() closer to vprintk definition
Message-ID: <YMnBQW2pInXyW3vv@alley>
References: <20210614235635.887365-1-punitagrawal@gmail.com>
 <8c16059d-6e58-a3e4-25ef-7e2bcabecd86@rasmusvillemoes.dk>
 <YMmggRL/htxFK2VY@alley>
 <YMmmhDQSX7gLmnN9@alley>
 <87im2ent74.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im2ent74.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-06-16 09:57:11, John Ogness wrote:
> On 2021-06-16, Petr Mladek <pmladek@suse.com> wrote:
> >>> Petr, as this is causing trouble for the -rt patchset, please
> >>> consider if this could make it to Linus before v5.13 release.
> >
> > Punit, John, would you mind when I queue this change for-5.14?  It
> > seems that, you, RT-guys already handled this, so it will not help
> > much if I sent it now. It does not look appropriate to send just a
> > single cosmetic fix few days before rc7.
> 
> Since this cosmetic problem was introduced during the 5.13 merge window,
> it would help if it is fixed before the 5.13 release. Obviously this is
> not a reason to have an rc7. But if there is going to be an rc7, I think
> this fix should be included.

OK, I have committed the patch into printk/linux.git, branch
for-5.13-fixup.

I am going to send the pull request later this week, most likely
tomorrow.

Best Regards,
Petr
