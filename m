Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D3359831
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhDIIoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:44:54 -0400
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:36961 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhDIIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:44:52 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id 56CBF1C37A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:44:39 +0100 (IST)
Received: (qmail 9048 invoked from network); 9 Apr 2021 08:44:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2021 08:44:38 -0000
Date:   Fri, 9 Apr 2021 09:44:36 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>, jslaby@suse.cz,
        Neil Brown <neilb@suse.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mike Christie <michaelc@cs.wisc.edu>,
        Eric B Munson <emunson@mgebm.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem in pfmemalloc skb handling in net/core/dev.c
Message-ID: <20210409084436.GK3697@techsingularity.net>
References: <CAJht_ENNvG=VrD_Z4w+G=4_TCD0Rv--CQAkFUrHWTh4Cz_NT2Q@mail.gmail.com>
 <20210409073046.GI3697@techsingularity.net>
 <CAJht_EPXS3wVoNyaD6edqLPKvDTG2vg4qxiGuWBgWpFsNhB-4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAJht_EPXS3wVoNyaD6edqLPKvDTG2vg4qxiGuWBgWpFsNhB-4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 01:33:24AM -0700, Xie He wrote:
> On Fri, Apr 9, 2021 at 12:30 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Under what circumstances do you expect sk_memalloc_socks() to be false
> > and skb_pfmemalloc() to be true that would cause a problem?
> 
> For example, if at the time the skb is allocated,
> "sk_memalloc_socks()" was true, then the skb might be allocated as a
> pfmemalloc skb. However, if after this skb is allocated and before
> this skb reaches "__netif_receive_skb", "sk_memalloc_socks()" has
> changed from "true" to "false", then "__netif_receive_skb" will see
> "sk_memalloc_socks()" being false and "skb_pfmemalloc(skb)" being
> true.
> 
> This is a problem because this would cause a pfmemalloc skb to be
> delivered to "taps" and protocols that don't support pfmemalloc skbs.

That would imply that the tap was communicating with a swap device to
allocate a pfmemalloc skb which shouldn't happen. Furthermore, it would
require the swap device to be deactivated while pfmemalloc skbs still
existed. Have you encountered this problem?

-- 
Mel Gorman
SUSE Labs
