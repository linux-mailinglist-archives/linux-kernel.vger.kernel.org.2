Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29CF326CAC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 11:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhB0KXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 05:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230112AbhB0KXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 05:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614421296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4boTmbFJLEQoptrKt5kEwfXa9GVrbVMebNjaAMdkPc=;
        b=gddGb0cMeBXBiB6XfDWOQHuOqI/+HM5BOoxJ+Zz7GIpnSMKXzDa+fSM/29Bkzgvn076Z8q
        VZVIlEuEu/C62FUJK2esNBisfna4KxLYzD3T9MRmrlflTwIM/dKCAtldD1VdF/vuWLeHmD
        zUMS0mSx4RXNNV/2gZFoHmFVU9GKASI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-8AefJaDjPZCZ1x8kNTmRbg-1; Sat, 27 Feb 2021 05:21:32 -0500
X-MC-Unique: 8AefJaDjPZCZ1x8kNTmRbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACFC18018A1;
        Sat, 27 Feb 2021 10:21:30 +0000 (UTC)
Received: from krava (unknown [10.40.192.60])
        by smtp.corp.redhat.com (Postfix) with SMTP id 17F9418AAB;
        Sat, 27 Feb 2021 10:21:25 +0000 (UTC)
Date:   Sat, 27 Feb 2021 11:21:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>,
        "Yi, Ammy" <ammy.yi@intel.com>
Subject: Re: [drm/i915/gt] 8c3b1ba0e7:
 perf-sanity-tests.Parse_event_definition_strings.fail
Message-ID: <YDodJb4CXDT8VemG@krava>
References: <20210224074841.GD6114@xsang-OptiPlex-9020>
 <cabd8692-07ca-13c8-efb5-e088b4547f80@linux.intel.com>
 <YDenRVGzh5Dv1pC2@krava>
 <YDfph8b9p8sSk1AF@krava>
 <YDfxgfi5DBDMFgwu@krava>
 <YDf0fP8XmnTrkIT8@krava>
 <d416a908-6a54-5e4c-e377-dc9d2b778941@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d416a908-6a54-5e4c-e377-dc9d2b778941@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 08:41:26AM +0800, Jin, Yao wrote:

SNIP

> > +				SET_SYMBOL(prefix, PMU_EVENT_SYMBOL);
> >   				len++;
> >   			}
> >   		}
> >   	}
> > +
> > +	/* unlikely, but still.. */
> > +	if (!len)
> > +		goto err;
> > +	perf_pmu_events_list_num = len;
> > +
> >   	qsort(perf_pmu_events_list, len,
> >   		sizeof(struct perf_pmu_event_symbol), comp_pmu);
> > 
> 
> Thanks so much for the patch! It works with my tests.
> 
> # ./perf test 6
>  6: Parse event definition strings                                  : Ok
> 
> # ./perf stat -e software/r1a/ -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>    <not supported>      software/r1a/
> 
>        1.000940433 seconds time elapsed
> 
> In theory, do we also need to check suffix as well? I think returning
> PMU_EVENT_SYMBOL_SUFFIX may also confuse the parser. But yes, we don't have
> this case now.

yep, let's wait for use case ;-) you can't have suffix
without prefix, and that's the one failing, so I think
we are fine

thanks,
jirka

