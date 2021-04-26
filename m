Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C087A36BB42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhDZVfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233464AbhDZVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619472886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=03TKKwj7058DR07A93Ekn5vbCIyLZWTmg1O7UnNvmc0=;
        b=ai4px1UvzOA4o5Drxa8/+hCuOvNvz0lyLx0UQdzjsOOyWB68cUOv+SZo9zxCYcCDZdXN81
        8CzSIpjxsDlGcGffAkMd/od/eHjjCp8TdCRPsRj4KR72x9ZhID2Rc0FP4EH8go1lTNPIny
        qBg4j1aKXgFwIaQIHTOkhb4wdajHrxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355--Rs3JjTJOw6jyvQDOGJ0rw-1; Mon, 26 Apr 2021 17:34:42 -0400
X-MC-Unique: -Rs3JjTJOw6jyvQDOGJ0rw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FFEF83DD22;
        Mon, 26 Apr 2021 21:34:41 +0000 (UTC)
Received: from krava (unknown [10.40.193.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id DFCA918BAA;
        Mon, 26 Apr 2021 21:34:38 +0000 (UTC)
Date:   Mon, 26 Apr 2021 23:34:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 12/26] perf parse-events: Support event inside hybrid
 pmu
Message-ID: <YIcx7UtQnr+vc+qf@krava>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
 <20210423053541.12521-13-yao.jin@linux.intel.com>
 <YIWWISXCQl7fPUFo@krava>
 <cea88d03-f3bf-d9cd-57be-ad3f45d82eb1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cea88d03-f3bf-d9cd-57be-ad3f45d82eb1@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 08:56:28AM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 4/26/2021 12:17 AM, Jiri Olsa wrote:
> > On Fri, Apr 23, 2021 at 01:35:27PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > +static int parse_events__inside_hybrid_pmu(struct parse_events_state *parse_state,
> > > +					   struct list_head *list, char *name,
> > > +					   struct list_head *head_config)
> > > +{
> > > +	struct parse_events_term *term;
> > > +	int ret = -1;
> > > +
> > > +	if (parse_state->fake_pmu || !head_config || list_empty(head_config) ||
> > > +	    !perf_pmu__is_hybrid(name)) {
> > > +		return -1;
> > > +	}
> > > +
> > > +	/*
> > > +	 * More than one term in list.
> > > +	 */
> > > +	if (head_config->next && head_config->next->next != head_config)
> > > +		return -1;
> > > +
> > > +	term = list_first_entry(head_config, struct parse_events_term, list);
> > > +	if (term && term->config && strcmp(term->config, "event")) {
> > 
> > so 'event' is set only for HW events, I don't see it being for other
> > types.. also should the check be !strcmp ?
> > 
> 
> For some HW events, such as branch-instructions, branch-misses and other HW
> events which are defined under /sys/devices/cpu_core/events, the
> term->config is "event". For these events, we don't need to do the second
> parsing. So I just use 'strcmp(term->config, "event")' to avoid the second
> parsing.

ah ok.. I thought it's the other way round


> 
> If we check with !strcmp, the second parsing will be executed but the result
> after parsing should be empty.
> 
> > also please add some tests for cache events with pmu syntax
> > 
> 
> OK, I will add new test case for that.

thanks,
jirka

