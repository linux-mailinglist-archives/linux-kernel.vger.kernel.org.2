Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00CC3D7888
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhG0Oc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:32:27 -0400
Received: from foss.arm.com ([217.140.110.172]:39704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhG0Oc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:32:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 745FE1FB;
        Tue, 27 Jul 2021 07:32:25 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAC6A3F66F;
        Tue, 27 Jul 2021 07:32:23 -0700 (PDT)
Date:   Tue, 27 Jul 2021 15:32:21 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 1/2] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <20210727143221.w3dxsc7ovc6cnce5@e107158-lin.cambridge.arm.com>
References: <20210719161656.3833943-1-qperret@google.com>
 <20210719161656.3833943-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210719161656.3833943-2-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/21 17:16, Quentin Perret wrote:
> The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> active task to maintain the last uclamp.max and prevent blocked util
> from suddenly becoming visible.
> 
> However, there is an asymmetry in how the flag is set and cleared which
> can lead to having the flag set whilst there are active tasks on the rq.
> Specifically, the flag is cleared in the uclamp_rq_inc() path, which is
> called at enqueue time, but set in uclamp_rq_dec_id() which is called
> both when dequeueing a task _and_ in the update_uclamp_active() path. As
> a result, when both uclamp_rq_{dec,ind}_id() are called from
> update_uclamp_active(), the flag ends up being set but not cleared,
> hence leaving the runqueue in a broken state.
> 
> Fix this by clearing the flag in update_uclamp_active() as well.
> 
> Fixes: e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
> Reported-by: Rick Yiu <rickyiu@google.com>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---

I've put a note that handling of this flag needs to be improved for the future.
But for now and FWIW, this LGTM:

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks!

--
Qais Yousef
