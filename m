Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F074458CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhKDRmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231667AbhKDRmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:42:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 523B360E90;
        Thu,  4 Nov 2021 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636047606;
        bh=IcgAGLN2juO/X4PpyOuhrmT+wzS1AUDVoeN1jSoWPqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoXEayTjhWctFyFrvTPZ2EBv+GD8iyOPNiVjaxv3/O3PRvG8B7HqeKnJO/WfMVWOi
         7tEmGg0emfDTfh11Ea7WSzKEu0k+tmEXyHr58hPL5WrUa48L2fJCcQnfdXDDPb3V2C
         cFKJ5JNXC3gr8Nf8msT1XFKtymFjGO6Q9k2uB8hwQCGh4lL7hPyZYmxtYdupy/avOH
         6ZlbsM01TLSfBzCCY+SjPgCodKhhf/uAuUkxYSyIEu2pBRM64nBLjTZGUbpDcqFGLQ
         qO/REcKfJ0OSLF1UF+qJLfIXuRmsVl4ucu1xk7e2F6fS218BezaCxXaxNEIyglew4A
         /pFegIJCH0O1g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35A1F410A1; Thu,  4 Nov 2021 14:40:03 -0300 (-03)
Date:   Thu, 4 Nov 2021 14:40:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YYQa8xeUuaRqyTDD@kernel.org>
References: <20211029224929.379505-1-namhyung@kernel.org>
 <YYFGxwFMvTRN5KBI@krava>
 <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com>
 <YYI5EwCjBojR+1QW@krava>
 <CABPqkBSHo3Gznor1e8M_Ue0XO8Z-HZt326q8N9kLWz4+jKkt-w@mail.gmail.com>
 <YYJzPkcUz2pcuspX@kernel.org>
 <CABPqkBQkqehAvpfJk77WZpXezrVO6cAj=9ktKFgL=C_m84_Dgg@mail.gmail.com>
 <YYL5FaKQ1ZvGwd08@kernel.org>
 <CABPqkBTr10pcbY0v5mM23PKDWdWg3CNywH4HLSGfy4ab8d6+=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTr10pcbY0v5mM23PKDWdWg3CNywH4HLSGfy4ab8d6+=g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 03, 2021 at 03:29:50PM -0700, Stephane Eranian escreveu:
> On Wed, Nov 3, 2021 at 2:03 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Wed, Nov 03, 2021 at 10:35:04AM -0700, Stephane Eranian escreveu:
> > > On Wed, Nov 3, 2021 at 4:32 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > Em Wed, Nov 03, 2021 at 12:44:12AM -0700, Stephane Eranian escreveu:
> > > > > On Wed, Nov 3, 2021 at 12:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > > > If the pmu doesn't support host/guest filtering, pmu/bla1/G
> > > > > > > may count something.  Not sure if it's better to error out.
> > > > > > > But the cycles:G and instructions:G should result in 0
> > > > > > > in case there's no VM running.

> > > > > > hm, I think if pmu doesn't support host/guest filtering then
> > > > > > I think 'pmu/bla1/G' should error, no? better no number than
> > > > > > bad number

> > > > > Yes, it should in my opinion.

> > > > Yeah, I thought about this yesterday (holiday here).

> > > Otherwise you create the illusion that you are monitoring in guest
> > > mode when you are not.

> > > The question is: how can the tool know which modifiers are supported
> > > per pmu model?

> > As things stand kernel-wise, we should just do capability querying, i.e.
> > if the user asks for a feature not available for a specific PMU, we
> > should refuse and provide a helpful error message to the user.

> > If the PMUs in the kernel had some kind of mask that stated what of the
> > 'struct perf_event_attr' selectable features are supported, then we
> > would just be able to avoid bothering the kernel asking for unsupported
> > stuff.

> I think we could add something like that in the sysfs entry for each
> PMU instance.
> that would avoid all these perf_event_open() calls and trying to
> decipher the error
> code.

That would speed up these checks with newer kernels, yeah, with older
kernels we'd fall back to what we have now + bailing out in the current
case (PMUs not supporting exclude_guest).

- Arnaldo
 
> > Just for exclude_guest we don't even need to have
> > evsel->pmu->missing_features.exclude_guest, as this is a hard error, no
> > point in caching previous capability queries.
