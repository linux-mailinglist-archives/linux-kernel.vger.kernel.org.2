Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9593C3F821B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 07:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhHZFiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 01:38:10 -0400
Received: from verein.lst.de ([213.95.11.211]:58081 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhHZFiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 01:38:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22FC06736F; Thu, 26 Aug 2021 07:37:20 +0200 (CEST)
Date:   Thu, 26 Aug 2021 07:37:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] mm: don't allow executable ioremap mappings
Message-ID: <20210826053719.GA17085@lst.de>
References: <20210824091259.1324527-1-hch@lst.de> <20210824091259.1324527-3-hch@lst.de> <1629945413.hwbzjjtfbl.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629945413.hwbzjjtfbl.astroid@bobo.none>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 12:46:34PM +1000, Nicholas Piggin wrote:
> I can't see why this is a problem. powerpcs can but it seems like a bad 
> idea anyway.
> 
> Any point to a WARN_ON or return -EINVAL? Hmm, maybe that doesn't work 
> for archs that don't support NX. We could add a check for ones that do 
> support it though... But that's for another patch.

This is the same as we do for regular vmap.  I can't remember why we
decided on this particular approach, as it's been a while.
