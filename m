Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526C038CE71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhEUUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhEUUAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:00:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C47F2613E9;
        Fri, 21 May 2021 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621627137;
        bh=sYtJ34rQzfKqTQGaf9eGQyLJQSxp3CXvjwj1CofMlEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwV1iKFE1dEjAxVX3YJpk8hoh5FqhWGxVH4scPIsdiRExKEM514dvLfuCU1Qc4liy
         qKFn9D63kIl1+bJBhK5KygejE79ELg7s9apt5byyjpoHlx2hlDubOlFT9tA9u91kU/
         57LkY2pNNA6cC+oxX1AmRB2gC/DY4rQWqVQ4MojPTajpxfHQUThpcjqub4AYJChYI5
         pLcZe36/efZ5B0r7EUdyA1dvVUyuZGDJrwBmA5kVteMT7tyAMJRk2n/lHSMbctoSzk
         yopAyMlAnjwYJ9FzAF9AmdumbjvWcYUY0DXaC9nDlOHE15x/iwVSLg3pDO1q/Ix26N
         rgFHWNV7/3ZVw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FCB24011C; Fri, 21 May 2021 16:58:55 -0300 (-03)
Date:   Fri, 21 May 2021 16:58:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Matt Fleming <matt.fleming@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tests: Drop __maybe_unused on x86 test
 declarations
Message-ID: <YKgQ/+JExJSezFHg@kernel.org>
References: <20210513174614.2242210-1-robh@kernel.org>
 <20210513174614.2242210-2-robh@kernel.org>
 <YJ48xSO7fnj4wmtj@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ48xSO7fnj4wmtj@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 14, 2021 at 11:03:01AM +0200, Jiri Olsa escreveu:
> On Thu, May 13, 2021 at 12:46:14PM -0500, Rob Herring wrote:
> > Function declarations don't need __maybe_unused annotations, only the
> > implementations do. Drop them on the perf x86 tests.
> 
> for both patches:
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

