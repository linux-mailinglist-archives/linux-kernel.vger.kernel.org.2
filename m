Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96A3404F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhCRLwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbhCRLvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616068312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgtsA5KUehMmtmf9kRkW1SBSeTOUxt617f5ZR2KNNlc=;
        b=VAIcaAl6mPFWRyF98AwQncZHnMOp/hxXSmgX0neC11DVR1ax0pbAXEknx8O2zbw4ThSUbn
        iUZPfsg5sAztjkItelDAGFMnlHXf8+T91kGV6RTPbXD8r4bwRhgPJsCf6CNqhDfUkXl9Aa
        JbedZ0EdXdPk3lHcqI0qCiXebajUPx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-dt9R1DmIPT26mo52n5ETBw-1; Thu, 18 Mar 2021 07:51:50 -0400
X-MC-Unique: dt9R1DmIPT26mo52n5ETBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9039107ACCA;
        Thu, 18 Mar 2021 11:51:48 +0000 (UTC)
Received: from krava (unknown [10.40.194.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6DE4010016F8;
        Thu, 18 Mar 2021 11:51:46 +0000 (UTC)
Date:   Thu, 18 Mar 2021 12:51:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 11/27] perf parse-events: Support hardware events
 inside PMU
Message-ID: <YFM+0e+mPL036gyY@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-12-yao.jin@linux.intel.com>
 <YEu9usdFl6VSnOQ7@krava>
 <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
 <YE+balbLkG5RL7Lu@krava>
 <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
 <YFC615nTdUR/aLw5@krava>
 <65624432-2752-8381-d299-9b48ec508406@linux.intel.com>
 <YFHUo1I8cYf502qJ@krava>
 <b0ec8d05-acbc-3021-2e74-684d119de2db@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ec8d05-acbc-3021-2e74-684d119de2db@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 08:17:52PM +0800, Jin, Yao wrote:

SNIP

> > > 
> > > For example,
> > > 
> > > perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -e '{cpu_atom/cycles/,cpu_atom/instructions/}'
> > > 
> > > This usage is common and reasonable. So I think we may need to support pmu style events.
> > 
> > sure, but we don't support 'cpu/cycles/' but we support 'cpu/cpu-cycles/'
> > why do you insist on supporting cpu_core/cycles/ ?
> > 
> > jirka
> > 
> 
> I'm OK to only support 'cpu_core/cpu-cycles/' or 'cpu_atom/cpu-cycles/'. But
> what would we do for cache event?
> 
> 'perf stat -e LLC-loads' is OK, but 'perf stat -e cpu/LLC-loads/' is not supported currently.

ugh, I keep forgetting those ;-)

> 
> For hybrid platform, user may only want to enable the LLC-loads on core CPUs
> or on atom CPUs. That's reasonable. While if we don't support the pmu style
> event, how to satisfy this requirement?
> 
> If we can support the pmu style event, we can also use the same way for
> cpu_core/cycles/. At least it's not a bad thing, right? :)

right, it's probably best to use the pmu/LLC-.../ for this,
I'll check the patch again

jirka

