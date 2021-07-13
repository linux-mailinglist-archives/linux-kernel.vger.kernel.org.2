Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B703C7032
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbhGMMRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:17:01 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:45127 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235968AbhGMMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:17:00 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 96B35FAD85
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:14:09 +0100 (IST)
Received: (qmail 32481 invoked from network); 13 Jul 2021 12:14:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Jul 2021 12:14:09 -0000
Date:   Tue, 13 Jul 2021 13:14:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc: correct return value when failing at
 preparing
Message-ID: <20210713121408.GC3809@techsingularity.net>
References: <20210709102855.55058-1-yanfei.xu@windriver.com>
 <20210709122225.GZ3840@techsingularity.net>
 <98c83852-6745-bf57-2415-696edea89704@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <98c83852-6745-bf57-2415-696edea89704@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 02:58:02PM +0800, Xu, Yanfei wrote:
> 
> 
> On 7/9/21 8:22 PM, Mel Gorman wrote:
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > On Fri, Jul 09, 2021 at 06:28:54PM +0800, Yanfei Xu wrote:
> > > If the array passed in is already partially populated, we should
> > > return "nr_populated" even failing at preparing arguments stage.
> > > 
> > > Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> > 
> > ff4b2b4014cb ("mm/page_alloc: correct return value of populated elements if bulk array is populated")
> > 
> 
> This is a different return location from you posted.
> 

You're right, I'll pick this up and stage it with a series of patches
that should have gone in during the merge window but were too late.

Thanks.

-- 
Mel Gorman
SUSE Labs
