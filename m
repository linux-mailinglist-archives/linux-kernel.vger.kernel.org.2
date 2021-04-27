Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D7336C071
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhD0H41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:56:27 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:45119 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230348AbhD0H4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:56:24 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 622691C66F9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:55:40 +0100 (IST)
Received: (qmail 809 invoked from network); 27 Apr 2021 07:55:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.248])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Apr 2021 07:55:40 -0000
Date:   Tue, 27 Apr 2021 08:55:38 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix unsetting of "has_idle_cores" flag
Message-ID: <20210427075538.GF4239@techsingularity.net>
References: <1619456652-19143-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1619456652-19143-1-git-send-email-ego@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:34:12PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()"), in
> select_idle_cpu(), we check if an idle core is present in the LLC of the
> target CPU via the flag "has_idle_cores". We look for the idle core in
> select_idle_cores(). If select_idle_cores() isn't able to find an idle
> core/CPU, we need to unset the has_idle_cores flag in the LLC of the
> target to prevent other CPUs from going down this route.
> 
> However, the current code is unsetting it in the LLC of the current CPU
> instead of the target CPU. This patch fixes this issue.
> 
> Fixes: Commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
