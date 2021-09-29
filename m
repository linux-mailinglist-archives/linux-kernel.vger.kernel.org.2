Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7808541C074
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244725AbhI2ISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:18:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbhI2ISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:18:06 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5057E1FFCE;
        Wed, 29 Sep 2021 08:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632903383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LiYaoQBx4xYRMCl/EzqMVn7BbeTIDQPnPMXpYFLbLhM=;
        b=K3206gR3kgWJhSX9kg+1tP3QEkznQ8Wpgb6TwS78Pk9hM8kpxQD/+TIBoJtBocM4g3nIkR
        bXp+eG8DqlptbJbyoAqsDb4c1Nb052QQza146luBfvDH5BFUrmddSB4vs/LDSoCnfUuSAy
        WVX1P72dS3Gw2t4wT7v0VnP9iI7/cbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632903383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LiYaoQBx4xYRMCl/EzqMVn7BbeTIDQPnPMXpYFLbLhM=;
        b=v2fyc/PpOTD7yU7gOMSXG6uD88hLJulgqmDJvvLTKIQ0QQ3i6BPPkP3eEXVEY0GaEH/Crp
        mWszbVODrj0WhSAA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 9BC3B25D4F;
        Wed, 29 Sep 2021 08:16:22 +0000 (UTC)
Date:   Wed, 29 Sep 2021 09:16:20 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: removed useless update of p->recent_used_cpu
Message-ID: <20210929081620.GI3891@suse.de>
References: <20210928103544.27489-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210928103544.27489-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 12:35:44PM +0200, Vincent Guittot wrote:
> Since commit 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu"),
> p->recent_used_cpu is unconditionnaly set with prev.
> 
> 
> Fixes: 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
