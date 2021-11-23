Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09B459F04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhKWJQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:16:16 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:45121 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhKWJQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:16:15 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 432941C39D7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:13:06 +0000 (GMT)
Received: (qmail 32180 invoked from network); 23 Nov 2021 09:13:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Nov 2021 09:13:06 -0000
Date:   Tue, 23 Nov 2021 09:13:04 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: mm: LTP/memcg testcase regression induced by
 8cd7c588decf..66ce520bb7c2 series
Message-ID: <20211123091304.GC3366@techsingularity.net>
References: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 11:57:20AM +0100, Mike Galbraith wrote:
> Greetings,
> 
> FYI, something in this series causes LTP controllers::memcg_regression
> testcase to hang forever.  Verified via brute force revert of the lot.
> 
> After letting box moan for 4.5 hours, I poked ^C repeatedly, but runltp
> didn't exit/recover gracefully, and ps hung, so I nuked the box.  All
> memcg_test_1 instances were stuck in reclaim_throttle().
> 

I'll see can I reproduce this but do you know offhand what the test is
doing and what the expected outcome is? A possibility is that this is a
test that is driving the machine near OOM (or at least memcg OOM) and
getting throttled instead of getting killed.

-- 
Mel Gorman
SUSE Labs
