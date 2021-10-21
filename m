Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C333435E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhJUJsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:48:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhJUJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:48:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D8FFD1FDA8;
        Thu, 21 Oct 2021 09:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634809583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0lwLfCstIphgXtUacpoF59TciIXxsGmnHeCvpob+Lo=;
        b=IQoA3njDVRHZc2FEWC6PUzeolrZZjrkhVQrR50zsm0oK0mG7C6Gf9GYZrhtejnMyAGJ2Xu
        bas+9N1vRy0362Tr9upDY2oRJuaROdcjEGxZlpfM1lhVQspTWvKPML+OyC5V0ApuMYJ9oR
        IOy7t3B5jfa7c4QUBkjDKRMuGtXJihQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634809583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0lwLfCstIphgXtUacpoF59TciIXxsGmnHeCvpob+Lo=;
        b=11EfSLWriAORNeSEZKnRzbUiqIDRFrl9EnXMfU/SChC/HbzESw79aRZWx6Y9ofZBGn9JqW
        t4Hvxvj5jwaHqcBA==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3F790A3B85;
        Thu, 21 Oct 2021 09:46:23 +0000 (UTC)
Date:   Thu, 21 Oct 2021 10:46:21 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 4/5] sched/fair: Remove sysctl_sched_migration_cost
 condition
Message-ID: <20211021094621.GE3891@suse.de>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211019123537.17146-5-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:35:36PM +0200, Vincent Guittot wrote:
> With a default value of 500us, sysctl_sched_migration_cost is
> significanlty higher than the cost of load_balance. Remove the
> condition and rely on the sd->max_newidle_lb_cost to abort
> newidle_balance.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
