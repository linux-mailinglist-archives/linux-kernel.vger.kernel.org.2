Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7C33C141
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhCOQJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:09:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:33848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhCOQJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:09:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615824570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQmRsMrJgayTSZHdwlDVYYq49TUgdJcRXxi2hq1NJPw=;
        b=SO2gSa2A19bgDx/1ooG3+n+l2xUkzD4Wvf3pkXitsLsS3IZsZxIgfq4f0cG6VIxUIjvZDL
        H4Iasfjyy7EjB9UnIlJqrxhIfpT9Rme1csUWCFN34mblMk9gYmsvSna06m6ro/PSX8vg3V
        40DxYfKndtRLNL03mSm9rJpQRK4KIdc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A425AE1F;
        Mon, 15 Mar 2021 16:09:30 +0000 (UTC)
Date:   Mon, 15 Mar 2021 17:09:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     zhou <xianrong_zhou@163.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@suse.de, willy@linux.intel.com, rostedt@goodmis.org,
        mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
        pankaj.gupta.linux@gmail.com, bhe@redhat.com, ying.huang@intel.com,
        iamjoonsoo.kim@lge.com, minchan@kernel.org,
        ruxian.feng@transsion.com, kai.cheng@transsion.com,
        zhao.xu@transsion.com, zhouxianrong@tom.com,
        zhou xianrong <xianrong.zhou@transsion.com>
Subject: Re: [PATCH] kswapd: no need reclaim cma pages triggered by unmovable
 allocation
Message-ID: <YE+Gs13F8nV1Z1/d@dhcp22.suse.cz>
References: <20210313083109.5410-1-xianrong_zhou@163.com>
 <64f8c03f-7fd9-2e03-6b90-67e2a5a45b9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f8c03f-7fd9-2e03-6b90-67e2a5a45b9d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-03-21 16:46:33, David Hildenbrand wrote:
> On 13.03.21 09:31, zhou wrote:
[...]
> > This optimization can avoid ~3% unnecessary isolations from cma
> > (cma isolated / total isolated) with configuration of total 100Mb
> > cma pages.
> 
> Can you say a few words about interaction with ZONE_MOVABLE, which behaves
> similar to CMA? I.e., does the same apply to ZONE_MOVABLE? Is it already
> handled?

No, the movable zone shouldn't be affected as the reclaim is zone aware.
The problem is that CMA doesn't belong to any particular zone. This is
something Joonsoo worked in the past and I believe following up on that
work has been recommended last time a similar/same approach like this
patch was proposed.
-- 
Michal Hocko
SUSE Labs
