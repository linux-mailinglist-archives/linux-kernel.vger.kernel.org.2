Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C0241F7C3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355987AbhJAWvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhJAWve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:51:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D83D56105A;
        Fri,  1 Oct 2021 22:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633128590;
        bh=t1s5Id57UQAxfr4vIW95kmieylyQ7mBTVJfI5xisW74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XnfPheFNziBnMj2DmDmdbHL/zvjtXEdvRmI/mOCcR5vZ9H9Np6oRILbEO/31JPXQC
         ZHVTGn7boRDP3ntf/1Ep6dF1/dNyhsSE7A5M9XzvtvZ9QbTK7Gjq1kOCR5N2QsVZJh
         FKYX5z0F/+BbMMhXU9sNboruPxSXYSMwi8ozx+ZY=
Date:   Fri, 1 Oct 2021 15:49:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "Huang, Ying" <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2] mm/mempolicy: do not allow illegal
 MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind()
Message-Id: <20211001154949.98956c092734590e781ce672@linux-foundation.org>
In-Reply-To: <20211001215630.810592-1-eric.dumazet@gmail.com>
References: <20211001215630.810592-1-eric.dumazet@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Oct 2021 14:56:30 -0700 Eric Dumazet <eric.dumazet@gmail.com> wrote:

> From: Eric Dumazet <edumazet@google.com>
> 
> syzbot reported access to unitialized memory in mbind() [1]

I'm lazy.  What memory is being accessed-unintialized?

> Issue came with commit bda420b98505 ("numa balancing: migrate on
> fault among multiple bound nodes")

No cc:stable?  What's the worst-case user-visible impact here?


