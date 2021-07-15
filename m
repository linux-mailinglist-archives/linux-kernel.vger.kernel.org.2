Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77AC3C99B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhGOHja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:39:30 -0400
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:57045 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhGOHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:39:29 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id 9AF3A1C4EF3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:36:35 +0100 (IST)
Received: (qmail 20263 invoked from network); 15 Jul 2021 07:36:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Jul 2021 07:36:35 -0000
Date:   Thu, 15 Jul 2021 08:36:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
Message-ID: <20210715073633.GN3809@techsingularity.net>
References: <20210713135625.7615-1-mgorman@techsingularity.net>
 <20210713135625.7615-5-mgorman@techsingularity.net>
 <YO/XDUoj1N7tlZKa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YO/XDUoj1N7tlZKa@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 07:34:53AM +0100, Christoph Hellwig wrote:
> On Tue, Jul 13, 2021 at 02:56:25PM +0100, Mel Gorman wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> > 
> > This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.
> > 
> > Fix an unresolved symbol error when CONFIG_DEBUG_INFO_BTF=y:
> 
> I still fundamentally disagreed with this "fix".  Whatever code requires
> a function to be non-static without a prototype and reference is
> completely fucked up beyond rescue and needs to be disabled util
> it can be fixed instead of worked around like this.

I'm definitely not happy with the fix but the breakage was unintentional
and given that it was done for a W=1 warning, the patch was low priority
and I felt that users that do error injection to stress failure paths at
least had some value. If I was fixing something important, I would feel
differently and we've slammed patches before that fixed warnings while
introducing worse problems. I'm still hoping that BTF gets fixed because
it's the right thing to do.

-- 
Mel Gorman
SUSE Labs
