Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5644A3970F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhFAKKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:10:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59028 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhFAKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:10:33 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 306761FD2D;
        Tue,  1 Jun 2021 10:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622542131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k20dQdDrZBQgdj1Stp+JsXCNuIAKAaJIRdQZLUfTaAo=;
        b=Bu6hV+SeLHNwiCFRzZ7zKG26Zb0NRoFtZhLV1AiOsEMgkZxZYjyg1oOTNIoxzE/XjJA+NQ
        2Wf7h6snU8rYo7QS45aiMHbRT/2QsyZECrbPis//NbHcs/gsjqloT4R9t+KnPB8ZZ7O6ry
        FBs9PqrxkLpxRpyPnmqDi8yUbe7FCiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622542131;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k20dQdDrZBQgdj1Stp+JsXCNuIAKAaJIRdQZLUfTaAo=;
        b=9dm/f41xQT3PueXGRTr+xM3bqSRlwZfCVWcjS5Lt6Z37VnybA+4DF7LPuGrdACo4U8D8p9
        yqr58su+MEkx7dBg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9700A3B87;
        Tue,  1 Jun 2021 10:08:50 +0000 (UTC)
Date:   Tue, 1 Jun 2021 11:08:49 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm: thp: fix a double unlock bug
Message-ID: <20210601100849.GQ3672@suse.de>
References: <YLX8uYN01JmfLnlK@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YLX8uYN01JmfLnlK@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 12:24:09PM +0300, Dan Carpenter wrote:
> We're supposed to be holding the "vmf->ptl" spin_lock when we goto
> out_map.  The lock is dropped after if finishes cleaning up.
> 
> Fixes: 9aff7b33c74a ("mm: thp: refactor NUMA fault handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ouch.

Acked-by: Mel Gorman <mgorman@suse.de>

However, that git commit is not stable. Instead of Fixes: I would
suggest renaming the patch to "mm: thp: refactor NUMA fault handling
-fix" and replacing Fixes with "This patch is a fix to the mmotm patch
mm-thp-refactor-numa-fault-handling.patch". Andrew usually slots that
into the correct place in his quilt series and collapses the fixes before
sending to Linus which works better with bisection.

-- 
Mel Gorman
SUSE Labs
