Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C39B4374F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhJVJqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhJVJqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A737B610EA;
        Fri, 22 Oct 2021 09:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634895826;
        bh=dReKDaKJwqW3Io2bve4J9VXECU2Jr66ov+QZ5vpHXXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=TAzoAt/+5wohwJmdHC32vbbltcslPkFnm0pw8jVFs8mGVLs0IRWuz5/AZMR+PAJlm
         r+WgFzNJ1bvzBWZw3i0xydoJrXpqN0F8Md7NqXQHiyyztIqEHw7I+0MgjbAdyhuZEA
         58uzEIFDBVZ2MaxhK79HgArwGhRkZ793G/Ll5NqsW+lZD0DdiAWaAgI7nXvGoynXW6
         GPADNCSOcAd2rnfcPZ2jWSjEocw3dnzbfgzaL86f7Efty6m5fx4807i586B8n7KHrA
         +3o0KT1CN9li14SArDyMGMRqkKlAv/o+jCjxmmHthKPVVdRq+z0e2T36IuVWkHMjo0
         Se1J5PFvctiEg==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, sjpark@amazon.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/damon/dbgfs: Optimize target_ids interface write operation
Date:   Fri, 22 Oct 2021 09:43:41 +0000
Message-Id: <20211022094341.3966-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <a23c6f23-cf6b-1833-5603-363c45df933f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 10:43:22 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> 
> On 2021/10/22 上午1:30, SeongJae Park wrote:
> > Hello Xin,
> >
> > On Fri, 22 Oct 2021 00:44:16 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> When we want to clear previously set target ids,
> >> For example, it works as below now:
> >>      # echo 42 > target_ids
> >>      # cat target_ids
> >>      42
> >>      # echo > target_ids
> >>      # cat target_ids
> >>
> >> But in 'dbgfs_target_ids_write', there is no need to
> >> execute other codes, except call 'damon_set_targets'
> >> to clear previously set target ids. So there adds
> >> the 'nr_targets' judgment, if the value is 0, just
> >> call 'damon_set_targets', and then return.
> > It's true that it executes some unnecessary code.  However, I unsure if that is
> > a problem, as the code that will be additionally executed in this case are
> > quite simple ones, and therefore not supposed to incur viewable overhead.
> > After all, this is not a performance critical path.
> 
> Thank you for your detailed explanation. I may not describe it clearly, 
> making you think that i am making this
> 
> modification to improve performance，I just want to avoid irrelevant code 
> execution, thank you so much.

I guess I didn't make my point clear enough, sorry.  My concern in this patch
is the fact that it is adding more code.  IMHO, as the code is already working
correctly and benefit of this change is quite subtle as you also agreed, adding
the code here doesn't seem worthy but only making it harder to maintain, to me.

If I'm missing something, please let me know.


Thanks,
SJ

[...]
