Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5583D8D09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhG1LuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:50:12 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:52001 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234869AbhG1LuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:50:10 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 338B8C0C9B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 12:50:08 +0100 (IST)
Received: (qmail 19191 invoked from network); 28 Jul 2021 11:50:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jul 2021 11:50:08 -0000
Date:   Wed, 28 Jul 2021 12:50:06 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mika.penttila@gmail.com, linux-kernel@vger.kernel.org,
        lirongqing@baidu.com, pbonzini@redhat.com, mingo@redhat.com,
        kvm@vger.kernel.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] is_core_idle() is using a wrong variable
Message-ID: <20210728115006.GC3809@techsingularity.net>
References: <20210722063946.28951-1-mika.penttila@gmail.com>
 <YQE0P9PLd3Uib7eu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YQE0P9PLd3Uib7eu@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 12:41:03PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 22, 2021 at 09:39:46AM +0300, mika.penttila@gmail.com wrote:
> > From: Mika Penttilä <mika.penttila@gmail.com>
> > 
> > is_core_idle() was using a wrong variable in the loop test. Fix it.
> > 
> > Signed-off-by: Mika Penttilä <mika.penttila@gmail.com>
> 
> Thanks!
> 
> ---
> Subject: sched/numa: Fix is_core_idle()
> From: Mika Penttilä <mika.penttila@gmail.com>
> Date: Thu, 22 Jul 2021 09:39:46 +0300
> 
> From: Mika Penttilä <mika.penttila@gmail.com>
> 
> Use the loop variable instead of the function argument to test the
> other SMT siblings for idle.
> 
> Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
> Signed-off-by: Mika Penttilä <mika.penttila@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20210722063946.28951-1-mika.penttila@gmail.com

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
