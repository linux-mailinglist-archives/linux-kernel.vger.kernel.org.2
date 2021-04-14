Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650E835F398
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbhDNMYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233608AbhDNMX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:23:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A7B8610E8;
        Wed, 14 Apr 2021 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618403016;
        bh=ejxy4q3sSahatH8vdDiqoQbOtWYbhYG/2qGRldnU3IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n8p8ZlwF44hh6p65FK2THhz5oiR/3biYiPwclpdQdI5lxd7xDGkx/+r+23aZrv5BC
         jLO+Q+gdiRASObneUBFUiXr06CwGutUmmXxZUJdrIttdDAvUNonWk094SftUAIpdQI
         GEUaUNFnHlRwxzun7gLt6QObgoZJXc+hP0bKSLEHR8jFb2knEJPJi2eS96g6PXxNqX
         WzC/Qzt2xWkv/iSV9L9t1GwJ8KC+WnfFuMBVVf8DC9/+kr1YQ1dagX5FkBd2IklZuM
         4x8CQHQCdi57+W5qMCmsztrOIdKSJdCcP3TF7g+nsQiaZ/6mBfCmfcLo5SW6WG5zQ4
         3An5fRRiVjlUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F9FE40647; Wed, 14 Apr 2021 09:23:33 -0300 (-03)
Date:   Wed, 14 Apr 2021 09:23:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Yao Jin <yao.jin@linux.intel.com>, gustavoars@kernel.org,
        mliska@suse.cz, linux-kernel <linux-kernel@vger.kernel.org>,
        zhangjinhao2@huawei.com, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7] perf annotate: Fix sample events lost in stdio mode
Message-ID: <YHbexV5LtJWMqJra@kernel.org>
References: <20210319123527.173883-1-yangjihong1@huawei.com>
 <33ba152e-b8ef-3057-744a-51cb8c478ff2@huawei.com>
 <CAM9d7cjT-Q8RBprzG=hwdxrgVpzf3RwECuJ1UvbQYpQ47migbg@mail.gmail.com>
 <YF3OXfzl7FEV50Ir@kernel.org>
 <27703989-e510-c964-2af7-ef0a5611f8cf@huawei.com>
 <CAM9d7chhFnYyUv++RzJRXomHq0vZN2LrbCAOBPg67MDeg6saOw@mail.gmail.com>
 <555b7a2d-13c8-e840-e62b-cf0ad7d084a9@huawei.com>
 <12d269ad-80f9-3893-f3c4-d12fcdbfecda@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12d269ad-80f9-3893-f3c4-d12fcdbfecda@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 12, 2021 at 03:22:29PM +0800, Yang Jihong escreveu:
> On 2021/3/31 10:18, Yang Jihong wrote:
> > On 2021/3/30 15:26, Namhyung Kim wrote:
> > > On Sat, Mar 27, 2021 at 11:16 AM Yang Jihong <yangjihong1@huawei.com> wrote:
> > > > On 2021/3/26 20:06, Arnaldo Carvalho de Melo wrote:
> > > > > So it seems to be working, what am I missing? Is this strictly non
> > > > > group related?

> > > > Yes, it is non group related.
> > > > This problem occurs only when different events need to be recorded at
> > > > the same time, i.e.:
> > > > perf record -e branch-misses -e branch-instructions -a sleep 1

> > > > The output results of perf script and perf annotate do not match.
> > > > Some events are not output in perf annotate.

> > > Yeah I think it's related to sort keys.  The code works with a single
> > > hist_entry for each event and symbol.  But the default sort key
> > > creates multiple entries for different threads and it causes the
> > > confusion.

> > Yes, After revome zfree from hists__find_annotations, the output of perf
> > annotate is repeated, which is related to sort keys.

> > The original problem is that notes->src may correspond to multiple
> > sample events. Therefore, we cannot simply zfree notes->src to avoid
> > repeated output.

> > Arnaldo, is there any problem with this patch? :)

> PING :)
> Is there any problem with this patch that needs to be modified?

I continue having a feeling this is kinda a bandaid, i.e. avoid the
problem, and since we have a way to work this when using a group, I fail
to see why it couldn't work when not grouping events.

But since I have no time to dive into this and Namhyung is ok with it,
I'll merge it now.

- Arnaldo
