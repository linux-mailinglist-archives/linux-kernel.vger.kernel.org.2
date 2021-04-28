Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83C836D31D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbhD1H3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231635AbhD1H3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619594920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2CACqZbC1apO90AhUtbyvUjTuAObwX0vY+3qkJD08HQ=;
        b=E9D/vgoZxDBU/cBbOIpA+OGhsf7SJDJ+t7x15929ej89Ad80MU1onKDNCWr5vinH88xfz6
        swErd2CrVY70OsHkzTbVI2SHd7krTMEj7w9/n/MBqtib2pomBHxt8fJME3KNndZtdc0pf7
        SOUMmc2UxdTEVm9dfV1djQuUEMC9kek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-oM-FBhMqOL-wolkt3HcbTg-1; Wed, 28 Apr 2021 03:28:36 -0400
X-MC-Unique: oM-FBhMqOL-wolkt3HcbTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5C848042A8;
        Wed, 28 Apr 2021 07:28:34 +0000 (UTC)
Received: from krava (unknown [10.40.193.167])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8D89E5D9F2;
        Wed, 28 Apr 2021 07:28:32 +0000 (UTC)
Date:   Wed, 28 Apr 2021 09:28:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 00/26] perf tool: AlderLake hybrid support series 1
Message-ID: <YIkOn9ZaTv87Kmjw@krava>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
 <YIgIiZVxOWdYTwef@krava>
 <d5309468-d6d6-ab8d-2f06-22b4f6e98917@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5309468-d6d6-ab8d-2f06-22b4f6e98917@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 09:57:40AM +0800, Jin, Yao wrote:

SNIP

> > >           1.003959036 seconds time elapsed
> > > 
> > > Note that, since the whole patchset for AlderLake hybrid support is very
> > > large (40+ patches). For simplicity, it's splitted into several patch
> > > series.
> > > 
> > > The patch series 1 only supports the basic functionality. The advanced
> > > supports for perf-c2c/perf-mem/topdown/metrics/topology header and others
> > > will be added in follow-up patch series.
> > > 
> > > The perf tool codes can also be found at:
> > > https://github.com/yaoj/perf.git
> > 
> > hi,
> > did you update the branch for v6? I think I can't see
> > the new update there
> > 
> > thanks,
> > jirka
> > 
> 
> I just pushed the latest updates to https://github.com/yaoj/perf.git. Sorry it's getting late.
> 
> Actually it's Arnaldo's tmp.perf/core branch. Arnaldo has applied the patch
> series on tmp.perf/core and with an update on "[PATCH v6 01/26] tools
> headers uapi: Update tools's copy of
>  linux/perf_event.h".

np, I used Arnaldo's branch for review

> 
> If there are more comments which need to be addressed, we will start from tmp.perf/core for v7.
> 
> Thanks
> Jin Yao
> 
> > > 
> > > Note that, this patch series is based on tmp.perf/core branch.
> > > 
> > > v6:
> > > ---
> > > - Rebase to tmp.perf/core branch.
> > > 
> > > - A minor update in v6 patch series.
> > > 
> > >    In '[PATCH v6 18/26] perf tests: Add hybrid cases for 'Parse event
> > >    definition strings' test', we add a test case for cache events with
> > >    pmu prefix.
> > > 
> > >    No other updates.

I can't test the functionality, but apart from that all seems fine
and non-hybrid stuff keeps working ;-)

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

