Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07E1326CA8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 11:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhB0KSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 05:18:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230101AbhB0KSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 05:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614421029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjufiwGvpDY3FvW/wkOJAhDq3dmJIb+UQaarGFdLFUg=;
        b=NRr8PTfgPt5Wud9OVXkk6xQW2aS2hDLtX8z2sj1UsXepn+faF5Yy1Cp+UYfI9e+UXANMMP
        yHJFk0xKNxk+aQHyNgHDViD4RbCCjzUovTVDFO10nJjgXaomuhIZfDQW48KDbnfe5CBldn
        fBZVQ7cu3rngTr+YOMD2sbDWgxldLGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-fcbkIT_BP7GXFb8XX3L5tA-1; Sat, 27 Feb 2021 05:17:07 -0500
X-MC-Unique: fcbkIT_BP7GXFb8XX3L5tA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74FDE10066EE;
        Sat, 27 Feb 2021 10:17:05 +0000 (UTC)
Received: from krava (unknown [10.40.192.60])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3175E5D9CA;
        Sat, 27 Feb 2021 10:17:01 +0000 (UTC)
Date:   Sat, 27 Feb 2021 11:17:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Nicholas Fraser <nfraser@codeweavers.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH] perf buildid-cache: Add test for PE executable
Message-ID: <YDocHWwa6wCyFG1c@krava>
References: <790bfe67-2155-a426-7130-ae7c45cb055b@codeweavers.com>
 <YDgJ+JTiOsGX288R@krava>
 <YDmImAQ1Lloa2d5y@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDmImAQ1Lloa2d5y@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 08:47:36PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 25, 2021 at 09:35:04PM +0100, Jiri Olsa escreveu:
> > On Wed, Feb 24, 2021 at 02:59:16PM -0500, Nicholas Fraser wrote:
> > > From 9fd0b3889f00ad13662879767d833309d8a035b6 Mon Sep 17 00:00:00 2001
> > > From: Nicholas Fraser <nfraser@codeweavers.com>
> > > Date: Thu, 18 Feb 2021 13:24:03 -0500
> > > Subject: [PATCH] perf buildid-cache: Add test for PE executable
> > > 
> > > This builds on the previous changes to tests/shell/buildid.sh, adding
> > > tests for a PE file. It adds it to the build-id cache manually and, if
> > > Wine is available, runs it under "perf record" and verifies that it was
> > > added automatically.
> > > 
> > > If wine is not installed, only warnings are printed; the test can still
> > > exit 0.
> > > 
> > > Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> > 
> > works nicely now, thanks
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> Thanks for checking it, but if you did a review, i.e. if you looked at
> the code, made suggestions, the submitter acted upon those changes, you
> looked again, etc, shouldn't this be a more appropriate:
> 
> Reviewed-by: Jiri Olsa <jolsa@redhat.com>
> 
> ?
> 
> I think we need to make these tags reflect more what really happened,
> i.e. if you just glanced over and thought, quickly, that it seems
> okayish, then Acked-by is what we should use, but if you gone thru the
> trouble of actually _looking hard_ at it, sometimes multiple times, then
> we should really use Reviewed-by and not take that lightly.

ah right, I slipped to using ack regardles the effort ;-)
I'll try to kick myself to use reviewed where appropriate

for this one:

Reviewed-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

