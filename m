Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F13A28BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFJJxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhFJJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623318705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RdhTnY8CBsWUE1eAYYQ4ErpT7kg6Qn40XVEJmrjvGXA=;
        b=euw+wD4X2BogGdfEp5+XjGJ7LDZxVSwBK6LNbeN3CbA/uPYrw54BLN0emUPitHkOi2mE39
        M4V6wnE8r2G/LHvE4W7rv1cYT9AQ0Jeh5uKgevFjw0utc+/yDGlnQOpCNrxgaOYU9qJHji
        KsdmqJfZ5/gI1VjII2ifZnTRNyf5gbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-qkkhTQDtMDycQKDL5kxGnQ-1; Thu, 10 Jun 2021 05:51:44 -0400
X-MC-Unique: qkkhTQDtMDycQKDL5kxGnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DB881B2C999;
        Thu, 10 Jun 2021 09:51:42 +0000 (UTC)
Received: from krava (unknown [10.40.195.165])
        by smtp.corp.redhat.com (Postfix) with SMTP id 719505D9C6;
        Thu, 10 Jun 2021 09:51:38 +0000 (UTC)
Date:   Thu, 10 Jun 2021 11:51:38 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Disable NMI watchdog message on hybrid
Message-ID: <YMHgqnj2sihdbZHb@krava>
References: <20210609050600.7308-1-yao.jin@linux.intel.com>
 <YMEj6vuPcEnCz6tr@krava>
 <8faa16cf-561e-cd31-7fb2-bfad3ae27782@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8faa16cf-561e-cd31-7fb2-bfad3ae27782@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 09:04:57AM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 6/10/2021 4:26 AM, Jiri Olsa wrote:
> > > +static bool is_mixed_hybrid_group(struct evsel *counter)
> > > +{
> > > +	struct evlist *evlist = counter->evlist;
> > > +	struct evsel *pos;
> > > +
> > > +	evlist__for_each_entry(evlist, pos) {
> > > +		if (perf_pmu__is_hybrid(pos->pmu_name))
> > > +			return true;
> > > +	}
> > so we care if there's at least one hybrid event in the list right?
> > it can be all full with just hybrid events, but the function name
> > suggests it's mixed with normal events
> > 
> > jirka
> > 
> 
> Yes, that's right. We only care there is at least one hybrid event in the evlist.
> 
> So do we change the function name to evlist__has_hybrid_event?

sounds good, thanks
jirka

> 
> Thanks
> Jin Yao
> 

