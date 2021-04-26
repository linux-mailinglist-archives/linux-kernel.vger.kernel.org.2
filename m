Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03CD36ABA8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 06:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhDZEcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 00:32:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:28854 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhDZEc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 00:32:29 -0400
IronPort-SDR: 0ZUfbXTmRsluleBRqL5otCPl7oASFOJCiLXjkk3Se+O0EQoJ/bXvknAOjDcVXbsjPV3Iff+2hg
 inHpZw23A1ng==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="260231334"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="260231334"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 21:31:48 -0700
IronPort-SDR: dGPfFBtPdG+Yzvcxoqtv+MD61plgBZu1WrnXC/1TiFwkOVYV+iml19s6f5K/KGHB42cEqs+tcC
 nErdTUqT1C6A==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="429195229"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 21:31:48 -0700
Date:   Sun, 25 Apr 2021 21:31:47 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/5] perf report: Make --stat output more compact
Message-ID: <20210426043147.GU1401198@tassilo.jf.intel.com>
References: <20210423182813.1472902-1-namhyung@kernel.org>
 <20210423184647.GN1401198@tassilo.jf.intel.com>
 <CAM9d7ciy82RM4UDHeAXwu4p7nPSg58euNK=Kdb7E0mj06e10oQ@mail.gmail.com>
 <20210423202024.GO1401198@tassilo.jf.intel.com>
 <CAM9d7cjKdo6AKAL43-mp+hpx9m_8UU6j8Zy1RUZkLdh27bR_ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjKdo6AKAL43-mp+hpx9m_8UU6j8Zy1RUZkLdh27bR_ig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm.. do you want something like this?
> 
>              TOTAL events:      20064
>               MMAP events:        239   ( 1.2%)
>               COMM events:       1518   ( 7.6%)
>               EXIT events:          1   (0.0%)
>               FORK events:       1517   (7.6%)
>             SAMPLE events:       4015   (20.0%)
>              MMAP2 events:      12769   (63.6%)

Yes that's it.

Really shows how inefficient perf is for short measurement
periods.

-Andi
