Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007A33C2366
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGIM2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:28:47 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:51231 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhGIM2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:28:46 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id AD24BFB3D1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 13:26:02 +0100 (IST)
Received: (qmail 31164 invoked from network); 9 Jul 2021 12:26:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jul 2021 12:26:02 -0000
Date:   Fri, 9 Jul 2021 13:26:01 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_alloc: avoid counting event if no successful
 allocation
Message-ID: <20210709122601.GA3840@techsingularity.net>
References: <20210709102855.55058-1-yanfei.xu@windriver.com>
 <20210709102855.55058-2-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210709102855.55058-2-yanfei.xu@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 06:28:55PM +0800, Yanfei Xu wrote:
> While the nr_populated is non-zero, however the nr_account might be
> zero if allocating fails. In this case, not to count event can save
> some cycles.
> 

The much more likely path is that nr_account is positive so we avoid a
branch in the common case.

> And this commit extract the check of "page_array" from a while
> statement to avoid unnecessary checks for it.
> 

I'm surprised the compiler does not catch that page_array is invariant
for the loop. Did you check if gcc generates different code is page_array
is explicitly checked once instead of putting it in the loop?

-- 
Mel Gorman
SUSE Labs
