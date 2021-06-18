Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD6A3AC55A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhFRHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 03:55:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37194 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbhFRHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:55:45 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDDED21AF1;
        Fri, 18 Jun 2021 07:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624002815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvivQRnbw0lq6DwS0bzrS7/TCENjmTPFP8+H7Q1VDjM=;
        b=RylMVhSJDCZ4vYAKct7MP45fy/0v8eXlt6fJ9GyAOWM8TtTkVm9ikFHwe8B7TZOPAu4jhr
        bEiZE2C0eHuh5zIYsfzy+Bl9CQYH2qWLWGLaVnLQFtI1mF/DpX2dS/8yeYLCx31RDjf+Mv
        J0R2uux6U559FszYSQSUsuVQ1hlF2AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624002815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvivQRnbw0lq6DwS0bzrS7/TCENjmTPFP8+H7Q1VDjM=;
        b=gNbjBM021OmwoYdiVo8jhqJECQU7QIsvLkKaS1cS7dmi9EqM2DaD8d2OkKMPEhDUNap8bo
        EcNSVqbUct3OYaBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 20034118DD;
        Fri, 18 Jun 2021 07:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624002815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvivQRnbw0lq6DwS0bzrS7/TCENjmTPFP8+H7Q1VDjM=;
        b=RylMVhSJDCZ4vYAKct7MP45fy/0v8eXlt6fJ9GyAOWM8TtTkVm9ikFHwe8B7TZOPAu4jhr
        bEiZE2C0eHuh5zIYsfzy+Bl9CQYH2qWLWGLaVnLQFtI1mF/DpX2dS/8yeYLCx31RDjf+Mv
        J0R2uux6U559FszYSQSUsuVQ1hlF2AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624002815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvivQRnbw0lq6DwS0bzrS7/TCENjmTPFP8+H7Q1VDjM=;
        b=gNbjBM021OmwoYdiVo8jhqJECQU7QIsvLkKaS1cS7dmi9EqM2DaD8d2OkKMPEhDUNap8bo
        EcNSVqbUct3OYaBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id xR5rBP9QzGD2TgAALh3uQQ
        (envelope-from <osalvador@suse.de>); Fri, 18 Jun 2021 07:53:35 +0000
Date:   Fri, 18 Jun 2021 09:53:33 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH -V8 04/10] mm/migrate: make migrate_pages() return
 nr_succeeded
Message-ID: <20210618075328.GA23470@linux>
References: <20210618061537.434999-1-ying.huang@intel.com>
 <20210618061537.434999-5-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618061537.434999-5-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 02:15:31PM +0800, Huang Ying wrote:
> From: Yang Shi <yang.shi@linux.alibaba.com>
> 
> The migrate_pages() returns the number of pages that were not migrated,
> or an error code.  When returning an error code, there is no way to know
> how many pages were migrated or not migrated.
> 
> In the following patch, migrate_pages() is used to demote pages to PMEM
> node, we need account how many pages are reclaimed (demoted) since page
> reclaim behavior depends on this.  Add *nr_succeeded parameter to make
> migrate_pages() return how many pages are demoted successfully for all
> cases.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>

I thought we all agreed on making nr_succeed an optional argument [1].
It reduced the churn quite a lot.

[1] https://patchwork.kernel.org/comment/24104453/


-- 
Oscar Salvador
SUSE L3
