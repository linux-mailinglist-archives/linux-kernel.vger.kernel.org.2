Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6078141C042
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbhI2IIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:08:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46450 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbhI2IIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:08:05 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 79107223AA;
        Wed, 29 Sep 2021 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632902784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TSI5m2XtJxwQsHbZ7fT2hgL1JimUqhFMlSOa0hMeAqE=;
        b=nQ3zyjNRAQHSP7HZvghcO8YhihnkTugPkyO4+m1D1AtVucXIcbIn85IkBuMPrCbZ1Zla1K
        hcrft2nq4jFNhlnTX2AYvua+B3k5AGCOoHBP48VjH6uMHEyXMiUO79tiANKXW9eROrUGZw
        p+7+r9TLr8JQA4tFm8gjL1iTgzkAjWQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 45AAC25D50;
        Wed, 29 Sep 2021 08:06:24 +0000 (UTC)
Date:   Wed, 29 Sep 2021 10:06:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: Replace shrinker_rwsem trylocks with SRCU
 protection
Message-ID: <YVQef1zSQ15JNnXP@dhcp22.suse.cz>
References: <20210927074823.5825-1-sultan@kerneltoast.com>
 <YVGClLWLXO8AWaEk@dhcp22.suse.cz>
 <YVH3J+bIGmCLVr0e@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVH3J+bIGmCLVr0e@sultan-box.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-09-21 09:53:59, Sultan Alsawaf wrote:
> On Mon, Sep 27, 2021 at 10:36:36AM +0200, Michal Hocko wrote:
> > Can you be more specific about those scenarios please?
> 
> I see frequent tmpfs mounts/unmounts in Android which result in lots of
> superblocks being created and destroyed, and each superblock has its own
> shrinker.

This is an important detail to mention in the changelog. Including some
details about the scale of the problem.

> > I have a vague recollection that this approach has been proposed in the
> > past. Have you checked previous attempts?
> 
> I wasn't aware that there were previous attempts. Is this [1] the previous
> attempt you're thinking of? It seems like the thread just died out. Was the main
> gripe that always enabling CONFIG_SRCU increased the kernel's size too much when
> tinyfication was desired?

There were more discussions. I have also found https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
My memory is quite dim and I do not have time to re-read those
discussions again right now. But if I remember correctly the last one
has died out because a deeper evaluation between the SRCU and rw
semaphores was required.

> Sultan
> 
> [1] https://lore.kernel.org/all/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/

-- 
Michal Hocko
SUSE Labs
