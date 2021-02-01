Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C86230B1A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhBAUea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:34:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhBAUe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612211579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xD5KWdsPSIjyMRVxXpYIVnm8ydnIHbfkatyPmbf37Cw=;
        b=gTMZlk5HZpUZHu3aJ9L4W0CHDx38zVsJw38W4rp8aYsKYv5PfCGU50djinOtAEjtSIHrHu
        0YBxq3h5d4VGQZXZERQ0vYVhpzjN5V0XN20ccnRRpCnIX+I6Xe93DLKC/U1zjpKT51L+KM
        vFLfIyU2PSb6p5oZfZWR8y1daYilhuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-RClHPraPNLejUdhPBjkY_g-1; Mon, 01 Feb 2021 15:32:55 -0500
X-MC-Unique: RClHPraPNLejUdhPBjkY_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14684801B12;
        Mon,  1 Feb 2021 20:32:54 +0000 (UTC)
Received: from krava (unknown [10.40.192.169])
        by smtp.corp.redhat.com (Postfix) with SMTP id C747F6E419;
        Mon,  1 Feb 2021 20:32:51 +0000 (UTC)
Date:   Mon, 1 Feb 2021 21:32:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/3] perf tools: Skip MMAP record synthesis for kernel
 threads
Message-ID: <YBhlcmCH2K3lI/YJ@krava>
References: <20210129054901.1705483-1-namhyung@kernel.org>
 <20210129054901.1705483-3-namhyung@kernel.org>
 <YBczqtjXRvnMRYjD@krava>
 <CAM9d7cj7E1u73ExFstFgQ9JMOFGM2KSrZs0zyUKte-C4VdBOjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj7E1u73ExFstFgQ9JMOFGM2KSrZs0zyUKte-C4VdBOjg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 01:54:32PM +0900, Namhyung Kim wrote:
> On Mon, Feb 1, 2021 at 7:48 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 02:49:00PM +0900, Namhyung Kim wrote:
> > > To synthesize information to resolve sample IPs, it needs to scan task
> > > and mmap info from the /proc filesystem.  For each process, it
> > > opens (and reads) status and maps file respectively.  But as kernel
> > > threads don't have memory maps so we can skip the maps file.
> > >
> > > To find kernel threads, check "VmPeak:" line in /proc/<PID>/status
> > > file.  It's about the peak virtual memory usage so only user-level
> > > tasks have that.  Also check "Threads:" line (which follows the VmPeak
> > > line whether or not it exists) to be sure it's read enough data - just
> > > in case of deeply nested pid namespaces or large number of
> > > supplementary groups are involved.
> >
> > I don't understand this Threads: check, could you please
> > show example where it's useful for the check?
> 
> Sure!
> 
> I think there's a chance that the status file actually has the VmPeak line,
> but it didn't read to the line for some reason.  In that case, we should
> not assume the task is a kernel thread.
> 
> So it needs to make sure whether there's no such line in the file
> or it just didn't read enough data.  To check the latter case, it
> searches the "Threads" line which follows the VmPeak always.

ah ok, there's limited buffer for the status file

we could call filename__read_str to read the whole file
and skip these checks.. but perhaps that'd be another
slowdown you trying to prevent

if you put that comment to the code, I'm ok with that

thanks,
jirka

