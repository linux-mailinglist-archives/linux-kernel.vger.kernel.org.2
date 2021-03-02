Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7732ADB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359847AbhCBWEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:04:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:37180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581968AbhCBTey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:34:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614713602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDes2H1CLvjMd2EGxicQfjb6b9DPmrsoQh5uhzFwDuM=;
        b=MqZU1cNDvwsKmZ+OWErdi1wV6ydXrsiPLTF+TWxlpaLX16KeubxfavPx0/FSJGW02TCdSv
        tkLpU0kXDzFErUhU9PcE9FzOu2u1ALs0TBZG/6qcOZNC1wrql6AITayqSh5/KY2h8aTs9f
        30UlSkNaE0x+hd8maiF9IPawZCMBqfU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26717ABF4;
        Tue,  2 Mar 2021 19:33:22 +0000 (UTC)
Date:   Tue, 2 Mar 2021 20:33:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: fix kernel stack account
Message-ID: <YD6TAMSafzrnl+Qj@dhcp22.suse.cz>
References: <20210302073733.8928-1-songmuchun@bytedance.com>
 <YD6I+DLH0SLnSgo8@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD6I+DLH0SLnSgo8@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-03-21 10:50:32, Roman Gushchin wrote:
> On Tue, Mar 02, 2021 at 03:37:33PM +0800, Muchun Song wrote:
> > The alloc_thread_stack_node() cannot guarantee that allocated stack pages
> > are in the same node when CONFIG_VMAP_STACK. Because we do not specify
> > __GFP_THISNODE to __vmalloc_node_range(). Fix it by caling
> > mod_lruvec_page_state() for each page one by one.
> 
> Hm, I actually wonder if it makes any sense to split the stack over multiple
> nodes? Maybe we should fix this instead?

While this is not really ideal I am not really sure it is an actual
problem worth complicating the code. I am pretty sure this would grow
into more tricky problem quite quickly (e.g. proper memory policy
handling).
-- 
Michal Hocko
SUSE Labs
