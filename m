Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356F53B2E12
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFXLrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhFXLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624535095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oYouGLiTt3rwLbDeYQDI9r+Q+6zYi6iD1xb2Cn1pvdA=;
        b=N9wwO8Ez+E5Tgk5M3BgYPFrcoN0+kopxspRvIrEA3djxD9HGzkXW/CBLH8/HYNuGovZdfn
        xoC9wR0De0r14Y1Xz3dTvVFwhlaAd6+QcYiOR/KIousUOegKwyqJto8XXWNIzgDgncoPsi
        kkOJtxe6ugaPpfhk/nLVb/vfeMBjKFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-bIxyDc2uPny7-kG0n1y_kw-1; Thu, 24 Jun 2021 07:44:52 -0400
X-MC-Unique: bIxyDc2uPny7-kG0n1y_kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DB8B802920;
        Thu, 24 Jun 2021 11:44:50 +0000 (UTC)
Received: from Diego (unknown [10.40.208.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E92636090F;
        Thu, 24 Jun 2021 11:44:46 +0000 (UTC)
Date:   Thu, 24 Jun 2021 13:44:43 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Namhyung Kim <namhyung@kernel.org>
cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [RFC 00/10] perf: Add build id parsing fault detection/fix
In-Reply-To: <CAM9d7chs=4mdRG389G8eDzeKmvB7PDuWp7mxd_ScuFiy0hYt3g@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.2106241339140.27231@Diego>
References: <20210622153918.688500-1-jolsa@kernel.org> <YNIgXkH1xaF7H3Tr@kernel.org> <CAP-5=fU=AAJ0_s1orsF=OCO0=bSmr9BhAmtN251bU_pf0ZFJ6Q@mail.gmail.com> <YNIobHgfVbiiNscn@kernel.org> <YNJT0wvghSZzPJ8Y@krava>
 <CAM9d7chs=4mdRG389G8eDzeKmvB7PDuWp7mxd_ScuFiy0hYt3g@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021, Namhyung Kim wrote:
> Hi Jiri,
> 
> Thanks for your work!
> 
> On Tue, Jun 22, 2021 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Jun 22, 2021 at 03:14:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Jun 22, 2021 at 10:47:54AM -0700, Ian Rogers escreveu:
> > > > On Tue, Jun 22, 2021 at 10:39 AM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > Em Tue, Jun 22, 2021 at 05:39:08PM +0200, Jiri Olsa escreveu:
> > > > > > hi,
> > > > > > this *RFC* patchset adds support to detect faults during
> > > > > > mmap2's build id parsing and a way to fix such maps in
> > > > > > generated perf.data.
> > > > > >
> > > > > > It adds support to record build id faults count for session
> > > > > > and store it in perf.data and perf inject support to find
> > > > > > these maps and reads build ids for them in user space.
> > > > >
> > > > > > It's probably best explained by the workflow:
> > > > > >
> > > > > >   Record data with --buildid-mmap option:
> > > > > >
> > > > > >     # perf record --buildid-mmap ...
> > > > > >     ...
> > > > > >     [ perf record: Woken up 1 times to write data ]
> > > > > >     [ perf record: Failed to parse 4 build ids]
> > > > > >     [ perf record: Captured and wrote 0.008 MB perf.data ]
> > > > > >
> > > > > >   Check if there's any build id fault reported:
> > > > > >
> > > > > >     # perf report --header-only
> > > > > >     ...
> > > > > >     # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED
> > > > > >
> > > > > >   There is, check the stats:
> > > > > >
> > > > > >     # perf report --stat
> > > > > >
> > > > > >     Aggregated stats:
> > > > > >              TOTAL events:        104
> > > > > >                       ....
> > > > > >            BUILD_ID fails:          4  (14.3%)
> > > > > >
> > > > > >   Yep, let's fix it:
> > > > > >
> > > > > >     # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data
> > > > >
> > > > > Can we make it possible to automate this with --fixup-buildids or a
> > > > > perfconfig 'record' knob?
> > > > >
> > > > > This would entail requesting that build-ids that _fail_ be sent to the
> > > > > side-band thread we have in 'perf record', this way we wouldn't have to
> > > > > traverse the whole perf.data file, be it with 'perf-record' at the end
> > > > > of a session with faulty build ids, or in a similar fashion using 'perf
> > > > > inject' as you suggest.
> > > > >
> > > > > I even think that we can have all these modes and let the user to decide
> > > > > how important is this for them and how convenient they want the whole
> > > > > process to be.
> >
> > right, that might be good to decide first.. because as I said,
> > I never hit faulted build id, so it probably needs the special
> > setup you guys are using.. could you try on your setup and check
> > how many faulted build ids you see?
> 
> Did you check data mmaps?  It might be easy to get faults
> from data files and we don't know if it's an ELF or not
> before reading the ELF header in the first page.

Hi. Long ago, I have noticed samples pointing to purely data files,
such as if the program execution was sampled just in the middle of
them. However, these files couldn't certainly contain any executable
code... It was quite hard to reproduce this.

Maybe what Namhyung says might have been a culprit for it? Just an
idea...

Michael
> 
> I'm not sure if we can limit it to exec mappings, there might
> be data-only DSOs and we may want to symbolize them too.
> 
> Thanks,
> Namhyung
> 
> 

