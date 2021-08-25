Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20B3F7231
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhHYJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:47:00 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:34614 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239726AbhHYJq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:46:58 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 8BF27B0021C; Wed, 25 Aug 2021 11:46:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 88FD5B00125;
        Wed, 25 Aug 2021 11:46:12 +0200 (CEST)
Date:   Wed, 25 Aug 2021 11:46:12 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 5/8] task isolation: sync vmstats conditional on
 changes
In-Reply-To: <20210824152646.822271769@fuller.cnet>
Message-ID: <alpine.DEB.2.22.394.2108251143270.317806@gentwo.de>
References: <20210824152423.300346181@fuller.cnet> <20210824152646.822271769@fuller.cnet>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021, Marcelo Tosatti wrote:

> Rather than syncing VM-stats on every return to userspace
> (or VM-entry), keep track of changes through a per-CPU bool.
>
> This improves performance when enabling task isolated
> for vcpu VMs.

And it adds overhead for each time the counters are updated. The static
check is not that bad but the per cpu reference causes an extra cacheline
hit in potentially performance sensitive vm code.

On the other hand: Once we have an indicator that the vmstats have been
updated then the checks for the need to perform a vmstat update can be
simplified using that percpu variable and made much faster.


