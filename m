Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2720835F16B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhDNKWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhDNKWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:22:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E1F46117A;
        Wed, 14 Apr 2021 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618395744;
        bh=KA6724okTE2CpHULyMpW1ZjVGtQMPmErIzkHAUK2lpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GyC9pnwLIyRCZDbrXCzGwl8JmZZb8X8qvicfrOBnodAqH7lI3CMFa7FsY144pZ+Xh
         6Cwuck3RvnsZn9s4K39RFGhLqGTjC4nWmNb2mBou6zssFJC7vpKN7Arl+M/dTVkDPD
         lxvVxFnb1ti5cpp/1CqznNnDrPygvNGtBFUPILca30MvCJFnjNN4qv/dj038IL0s+Z
         NRJST/Xww2F765ocnykFPiGQ6fg47Pl5ljR8dWl1MQRWCOn9CNMlOiSF2IHGuwX8/b
         EjnKrGgZAGSsEJOxMt8C7Or6gIORKacPJSyPo1DN0iYyGuh4bK55zInTdwvvw59m7v
         tku9hYRo48jhA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A14FC40647; Wed, 14 Apr 2021 07:22:19 -0300 (-03)
Date:   Wed, 14 Apr 2021 07:22:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v7 2/4] libperf: Add evsel mmap support
Message-ID: <YHbCWytH5ek0C/an@kernel.org>
References: <20210413171606.1825808-1-robh@kernel.org>
 <20210413171606.1825808-3-robh@kernel.org>
 <YHXlXMd2Bp+90851@kernel.org>
 <CAL_JsqJfCNuvavU1xVUBxRFDopfsLW+E0kZXH8oZ2pmCDybPpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJfCNuvavU1xVUBxRFDopfsLW+E0kZXH8oZ2pmCDybPpA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 13, 2021 at 02:07:57PM -0500, Rob Herring escreveu:
> On Tue, Apr 13, 2021 at 1:39 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > --- a/tools/lib/perf/evsel.c
> > > +int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> > > +{
> > > +     int ret, cpu, thread;
> > Where is the counterpart?
> 
> I was assuming implicitly unmapped when closing the fd(s), but looks
> like it's when exiting the process only.
> 
> I.e. perf_evsel__munmap(), and it should be
> > called if perf_evsel__mmap() fails, right?
> 
> If perf_evsel__mmap() fails, the caller shouldn't have to do anything
> WRT mmap, right? But if the perf_mmap__mmap() call fails, we do need
> some internal clean-up. I'll fix both.

You're right, thanks!

- Arnaldo
