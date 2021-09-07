Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580D5402505
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbhIGIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:21:24 -0400
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:37865 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhIGIVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:21:19 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 9A655FAF3D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:20:12 +0100 (IST)
Received: (qmail 22356 invoked from network); 7 Sep 2021 08:20:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Sep 2021 08:20:12 -0000
Date:   Tue, 7 Sep 2021 09:20:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 00/33] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210907082010.GB3959@techsingularity.net>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2021 at 12:49:30PM +0200, Vlastimil Babka wrote:
> The RFC/v1 version also got basic performance screening by Mel that didn't show
> major regressions. Mike's testing with hackbench of v2 on !RT reported
> negligible differences [6]:
> 

FWIW, this version didn't show any major differences in terms of
performance and it didn't functionally fail either.

-- 
Mel Gorman
SUSE Labs
