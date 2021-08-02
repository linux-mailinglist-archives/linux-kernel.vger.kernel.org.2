Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE43DD148
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhHBHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232173AbhHBHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627889759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SCaO3zZA1UHyau/ywC+87QC/FW7k2c/cSKHE04W5tzg=;
        b=eo/vnmW/L1BAeMY5vByqVqGdb46ajkelnYXqqsNPmaxv4mKnFcWoB7nfT/IcY/eGlRw97B
        aIAOzbXOynXyjD9ieSMEaIe9EwvCgJMkfXp8NJQt9v8zmmijr+c4u23rqIB6DA8XSiwir3
        /W+EX8YwS7Rsvtebx70C57q06HbRwBs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-4fxFYqDQPc--TkEdo59qug-1; Mon, 02 Aug 2021 03:35:57 -0400
X-MC-Unique: 4fxFYqDQPc--TkEdo59qug-1
Received: by mail-ed1-f72.google.com with SMTP id y39-20020a50bb2a0000b02903bc05daccbaso8258830ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 00:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SCaO3zZA1UHyau/ywC+87QC/FW7k2c/cSKHE04W5tzg=;
        b=WAMzuEYoVLHHwGdAS6sM6LSya/SxTLffJNxoofWRavTqhvAO3ODI0YPmRRMdk+u4lp
         h4irxV9lMV+w9lrFF2h1PQrlZphTR74X93z//pXRaTzfJ7SQ8AxKL89ohw0+6rmRndWz
         3kdSHqG/jzVMvfFlPjnY9U2U0tF0zFMHlpPtsjGUyt6QwJ8V3pmwIg1ZFSJZSSy2JD00
         NxlUzDszwcziMIDzbcWr2dqr7wid6VONAT18ngr9agN1b0iMK7kF7tDtmr7djan4n8+D
         jVTPn2DPMIAhHgYRGr1sNzj5o7rccoxS0SpWHYy33S/6q1NQXmMnj3OBnP8/iCm+2QTe
         Ethw==
X-Gm-Message-State: AOAM530NID6CsAhH1L8M8v6QNHYmahp5oDeKr/HzFnG63dTQYFaYFLSH
        1iaNVTh5/cm6LPthhSCX5LVsVTpgFzOhQC9HGFyCu2vpR8SU7EsWylCnsxZegE/BhmOCFy3uRcH
        XcYQkf8S7RrlrwIGxCSXIghtw
X-Received: by 2002:a50:ed14:: with SMTP id j20mr17333297eds.323.1627889756770;
        Mon, 02 Aug 2021 00:35:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzhnqWfoh5Qj8yOMyS6ItNUUir0U9bB3y02Y7YIrkd17NY9qYSb02LV41rvtGryHpwfi4WuQ==
X-Received: by 2002:a50:ed14:: with SMTP id j20mr17333280eds.323.1627889756565;
        Mon, 02 Aug 2021 00:35:56 -0700 (PDT)
Received: from localhost.localdomain (an-19-190-136.service.infuturo.it. [151.19.190.136])
        by smtp.gmail.com with ESMTPSA id y23sm4139350ejp.115.2021.08.02.00.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 00:35:55 -0700 (PDT)
Date:   Mon, 2 Aug 2021 09:35:50 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, Mark Simmons <msimmons@redhat.com>
Subject: Re: [PATCH] sched/rt: Fix double enqueue caused by rt_effective_prio
Message-ID: <YQegVmIoVGOjt4w+@localhost.localdomain>
References: <20210701091431.256457-1-juri.lelli@redhat.com>
 <YObOIwH7MbfagklQ@hirez.programming.kicks-ass.net>
 <YObS2Rudg4osS7Ic@hirez.programming.kicks-ass.net>
 <YOgJzqOrVHUvCpch@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOgJzqOrVHUvCpch@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 09/07/21 10:33, Juri Lelli wrote:
> Hi Peter,
> 
> On 08/07/21 12:26, Peter Zijlstra wrote:
> > On Thu, Jul 08, 2021 at 12:06:27PM +0200, Peter Zijlstra wrote:
> > > Slightly larger patch, but perhaps a little cleaner.. still pondering if
> > > we can share a little more between __sched_setscheduler() and
> > > rt_mutex_setprio().
> > 
> > Best I can seem to come up with...
> 
> Thanks for the non-lazy version of the fix!
> 
> Makes sense to me and it looks good from quick testing. I'll be doing
> more extensive testing and ask Mark (cc-ed) to help with that. :)
> 
> We'll report back soon-ish.

So, yeah it took a while (mostly my pto :), apologies.

However, we managed to confirm your fix works great!

May I leave posting it again with changelog etc to you, or would you
like I do that (making you the author)?

Thanks,
Juri

