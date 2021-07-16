Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC13CB1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 07:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhGPFWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 01:22:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhGPFWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:22:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E5FB022B14;
        Fri, 16 Jul 2021 05:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626412765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BD+bwgJlKaDPTTvGC7chlbRZwU3e79262cqlfKCLm0g=;
        b=PYB05WVjUHS/DEdLxHN1PnWD2keEb+Yt2r9KUzP/rPypZgl+CIbN0SOKRPWgEfTddILJl1
        k1lFIgGcFo9p5BenOV5wl/v+ZyJ3rBZnp4k49kROr26XfPHIfUAWQv5eEU+d0ECeam0ewB
        LcLYR1c4Yvq+QqmOii/ujH/0FadRVHc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 260E0A3BB0;
        Fri, 16 Jul 2021 05:19:25 +0000 (UTC)
Date:   Fri, 16 Jul 2021 07:19:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     minyard@acm.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] oom_kill: oom_score_adj broken for processes with small
 memory usage
Message-ID: <YPEW3H+W/uiRYIfn@dhcp22.suse.cz>
References: <20210701125430.836308-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701125430.836308-1-minyard@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-07-21 07:54:30, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> If you have a process with less than 1000 totalpages, the calculation:
> 
>   adj = (long)p->signal->oom_score_adj;
>   ...
>   adj *= totalpages / 1000;
> 
> will always result in adj being zero no matter what oom_score_adj is,
> which could result in the wrong process being picked for killing.
> 
> Fix by adding 1000 to totalpages before dividing.

Yes, this is a known limitation of the oom_score_adj and its scale.
Is this a practical problem to be solved though? I mean 0-1000 pages is
not really that much different from imprecision at a larger scale where
tasks are effectively considered equal.

I have to say I do not really like the proposed workaround. It doesn't
really solve the problem yet it adds another special case.
-- 
Michal Hocko
SUSE Labs
