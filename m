Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985273F49F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhHWLkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:40:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:29973 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234997AbhHWLkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:40:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="217086595"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="217086595"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 04:39:58 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="525912573"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.226.70]) ([10.249.226.70])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 04:39:56 -0700
Subject: Re: [GSoC] Multi-threading in perf: Final Report
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <3c4f8dd64d07373d876990ceb16e469b4029363f.camel@gmail.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <b7a9f309-9765-2a64-026e-efa835989add@linux.intel.com>
Date:   Mon, 23 Aug 2021 14:39:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3c4f8dd64d07373d876990ceb16e469b4029363f.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.2021 12:41, Riccardo Mancini wrote:
> Hi,
> 
> this is the final report of my project "Multi-threading in perf",
> developed as part of the Google Summer of Code with the Linux Foundation.
> https://summerofcode.withgoogle.com/projects/#4670070929752064
<SNIP>
> 
> Review activity:
> PATCHSET Introduce threaded trace streaming for basic perf record operation
>   Link: https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
>   Contribution: helped in fixing some bugs, performed extensive testing

Hi Riccardo,

Thank you very much for the deep review and extensive testing of
this patchset, it was very helpful and allowed us to improve
the quality of the feature used in our product.

Good luck,
Alexey

> PATCHSET perf tools: Add PMU alias support
>   Link: https://lore.kernel.org/lkml/20210729070619.20726-1-yao.jin@linux.intel.com/
>   Link: https://lore.kernel.org/lkml/20210729070619.20726-1-yao.jin@linux.intel.com/
>   Contribution: helped in fixing some memory bugs
> 
> 
