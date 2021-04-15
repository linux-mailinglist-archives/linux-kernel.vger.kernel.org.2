Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD10361301
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhDOTjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234784AbhDOTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618515569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fSuycjHGvUCAYxNcvsE+AvFJTxQvfPLp4Rwi2u3zkBA=;
        b=GWo9g/qoYTqH/LJLnWTTDK9zUTsSzMtXm/ldGpNFZBLAb5Wka5WELN+eqqgcSHSOMGrS7j
        SyuP3juF1dsOBT0uX7i+ISwbg/WwJ4U6plFU/2dOUgJLDxbuvnruTvZo/wRXVgNXW8wEyw
        9xCtDEkz1KOC4aeJkAaO0i9gl0gPQec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-OJYEruLGOG6o09rZtLR4Dg-1; Thu, 15 Apr 2021 15:39:25 -0400
X-MC-Unique: OJYEruLGOG6o09rZtLR4Dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BE368143FE;
        Thu, 15 Apr 2021 19:39:23 +0000 (UTC)
Received: from krava (unknown [10.40.196.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 399762AE98;
        Thu, 15 Apr 2021 19:39:21 +0000 (UTC)
Date:   Thu, 15 Apr 2021 21:39:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 12/27] perf parse-events: Support no alias assigned
 event inside hybrid PMU
Message-ID: <YHiWaDYzC9xEwLcp@krava>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-13-yao.jin@linux.intel.com>
 <YHgdixeqOu2NarkC@krava>
 <132fc848-7252-0d7f-4a5f-020e8f79012e@linux.intel.com>
 <YHhJeuYMA/0Jof55@krava>
 <7773d38a-4e1a-a610-367d-094f099d209d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7773d38a-4e1a-a610-367d-094f099d209d@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 10:53:33PM +0800, Jin, Yao wrote:

SNIP

> 
> With my current code,
> 
> static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
> 					 const char *str, char *pmu_name,
> 					 struct list_head *list)
> {
> 	struct parse_events_state ps = {
> 		.list           = LIST_HEAD_INIT(ps.list),
> 		.stoken         = PE_START_EVENTS,
> 		.pmu_name       = pmu_name,
> 		.idx            = parse_state->idx,
> 	};
> 	int ret;
> 
> 	ret = parse_events__scanner(str, &ps);
> 	perf_pmu__parse_cleanup();
> 
> 	if (!ret) {
> 		if (!list_empty(&ps.list)) {
> 			list_splice(&ps.list, list);
> 			parse_state->idx = ps.idx;
> 		}
> 	}
> 
> 	return ret;
> }
> 
> The new created evsels are added to the tail of list (ps.list) and ps.list
> is joined to the list (the parameter 'list').
> 
> If we want to reuse the __parse_events(), we may need to:
> 
> struct evlist *evlist = evlist__new();

there's the original evlist pointer passed to the initial parser
that we should use no?

> 
> __parse_events(evlist, str, NULL, NULL);
> Add the evsels in evlist to the tail of list (the parameter 'list')
> evlist__delete(evlist);
> 
> Is my understanding correct?
> 
> Yes, we have to change the interface of __parse_events() by adding a new
> parameter 'pmu_name', which will bring much more changes. I agree to make
> this change in follow-up patches.

let's check on this over the next version

thanks,
jirka

