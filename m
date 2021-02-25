Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A69325094
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBYNfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhBYNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614260048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AS6EiwtZyyoU3dNAZrLEKhdhiP8jwGeoxh5a78NRZnI=;
        b=hlGjiIgIHegbdWEckhP+QUv5aEEf8qFlPV9XbUa5x7E+U3olVeg6bdWs452vMcrLj+4Zji
        nJWe3wuWYX6o32LMsqIHdeAtOTzQkn56gANwhbVAlaa2sEqiiTouaUYKIbvtFE8XMUpY/M
        DBxD5xKdsyGuuClgB/xj3pgzzIL0b4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-QaXpD2MkMz6NMm6sYYJKeA-1; Thu, 25 Feb 2021 08:34:04 -0500
X-MC-Unique: QaXpD2MkMz6NMm6sYYJKeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF8B6193578B;
        Thu, 25 Feb 2021 13:34:01 +0000 (UTC)
Received: from krava (unknown [10.40.194.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3609E5D6D7;
        Thu, 25 Feb 2021 13:33:58 +0000 (UTC)
Date:   Thu, 25 Feb 2021 14:33:57 +0100
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
Message-ID: <YDenRVGzh5Dv1pC2@krava>
References: <20210224074841.GD6114@xsang-OptiPlex-9020>
 <cabd8692-07ca-13c8-efb5-e088b4547f80@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cabd8692-07ca-13c8-efb5-e088b4547f80@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 04:06:23PM +0800, Jin, Yao wrote:
> Hi Chris, Arnaldo, Jiri,
> 
> We observe the parsing error for "software/xxx/" on some platforms.
> 
> For example,
> 
> # perf stat -e software/r1a/ -a -- sleep 1
> event syntax error: 'software/r1a/'
>                      \___ parser error
> Run 'perf list' for a list of valid events
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events
> 
> And perf test is failed too.
> 
> # perf test 6 -vv
> ...
> running test 4 'software/r1a/'failed to parse event 'software/r1a/', err 1, str 'parser error'
> event syntax error: 'software/r1a/'
>                      \___ parser error
> 
> running test 4 'software/r0x1a/'failed to parse event 'software/r0x1a/', err 1, str 'parser error'
> event syntax error: 'software/r0x1a/'
>                      \___ parser error
> ...
> 
> The issue should be the conflict between event "i915/software-gt-awake-time/" and pmu "software".
> 
> # perf list | grep i915/software
>   i915/software-gt-awake-time/                       [Kernel PMU event]
> 
> Perf supports the event format as "prefix-xxx-suffix", so the "software"
> string in "software-gt-awake-time" is added to perf_pmu_events_list as
> PMU_EVENT_SYMBOL_PREFIX. When parsing the string such as "software/xxx/",
> it’s parsed as PMU_EVENT_SYMBOL_PREFIX for "software", then it would error
> out in next processing.
> 
> So the easy way is to rename "software-gt-awake-time" to "gt-awake-time",
> right? Otherwise we have to hardcode something in perf tool.
> 
> What do you think of this issue and the solution?
> 
> BTW, as the robot reported, it's related to the commit 8c3b1ba0e7ea
> ("drm/i915/gt: Track the overall awake/busy time").

yes, I think you're right.. I'll try to reproduce and check on this

I'm still not clear why is that parsing fail if those 2 events are
distinguished by - and / ... but yep, we are asking for trouble in
here ;-)

I think we could either prioritaze one or add extra check when we
add prefix-xxx-suffix events and do not add ones that have conflict..
that seems like best solution to me now

thanks,
jirka

