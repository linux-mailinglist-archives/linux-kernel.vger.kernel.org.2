Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4C33D495
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhCPNIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229756AbhCPNH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615900076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q8hZdBjy2biDGo/SRhHfsgZJyMCulHjJpjBBHBnHsVU=;
        b=e4wf1FgMNDE5pFRLiwbib6PTocGkK9l/lobWSdZP7BfCtYpum0eVF5ovxytrxpVSo3pVhe
        j9P9loVHeQZ84MfewMrbFmVZ2S+sZctX/PSnZ4lzkgOIQVkpNlhuCy3qvQSgGlW/cyyfRA
        y4CyA/OODKziPlf4glvoVUk72pff6sQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-27woSIwZOmieDc8eUNCEzA-1; Tue, 16 Mar 2021 09:07:54 -0400
X-MC-Unique: 27woSIwZOmieDc8eUNCEzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99714100D926;
        Tue, 16 Mar 2021 13:07:52 +0000 (UTC)
Received: from krava (unknown [10.40.193.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 92E2460C0F;
        Tue, 16 Mar 2021 13:07:50 +0000 (UTC)
Date:   Tue, 16 Mar 2021 14:07:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Align CSV output for summary mode
Message-ID: <YFCtpVNF8coCX3UR@krava>
References: <20210316072900.1739-1-yao.jin@linux.intel.com>
 <YFCtfXlaKbIeEMwk@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCtfXlaKbIeEMwk@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:07:12PM +0100, Jiri Olsa wrote:
> On Tue, Mar 16, 2021 at 03:29:00PM +0800, Jin Yao wrote:
> > perf-stat has supported the summary mode. But the summary
> > lines break the CSV output so it's hard for scripts to parse
> > the result.
> > 
> > Before:
> > 
> >   # perf stat -x, -I1000 --interval-count 1 --summary
> >        1.001323097,8013.48,msec,cpu-clock,8013483384,100.00,8.013,CPUs utilized
> >        1.001323097,270,,context-switches,8013513297,100.00,0.034,K/sec
> >        1.001323097,13,,cpu-migrations,8013530032,100.00,0.002,K/sec
> >        1.001323097,184,,page-faults,8013546992,100.00,0.023,K/sec
> >        1.001323097,20574191,,cycles,8013551506,100.00,0.003,GHz
> >        1.001323097,10562267,,instructions,8013564958,100.00,0.51,insn per cycle
> >        1.001323097,2019244,,branches,8013575673,100.00,0.252,M/sec
> >        1.001323097,106152,,branch-misses,8013585776,100.00,5.26,of all branches
> >   8013.48,msec,cpu-clock,8013483384,100.00,7.984,CPUs utilized
> >   270,,context-switches,8013513297,100.00,0.034,K/sec
> >   13,,cpu-migrations,8013530032,100.00,0.002,K/sec
> >   184,,page-faults,8013546992,100.00,0.023,K/sec
> >   20574191,,cycles,8013551506,100.00,0.003,GHz
> >   10562267,,instructions,8013564958,100.00,0.51,insn per cycle
> >   2019244,,branches,8013575673,100.00,0.252,M/sec
> >   106152,,branch-misses,8013585776,100.00,5.26,of all branches
> > 
> > The summary line loses the timestamp column, which breaks the
> > CVS output.
> > 
> > We add a column at the 'timestamp' position and it just says 'summary'
> > for the summary line.
> > 
> > After:
> > 
> >   # perf stat -x, -I1000 --interval-count 1 --summary
> 
> looks ok, but maybe make the option more related to CVS, like:
> 
>   --x-summary, --cvs-summary  ...? 
> 

and we'll need man page update for that

jirka

