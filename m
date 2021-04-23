Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64658369A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbhDWSr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:47:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:37212 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232591AbhDWSrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:47:25 -0400
IronPort-SDR: WQJXGoKflDZRWkUT4kw3ro9CnStVRM2p6yMLxjcLnUoJC/OoVECexxAzaF78ig/fzcOLHeceyM
 pxPUtjphkk6w==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183247373"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183247373"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:46:48 -0700
IronPort-SDR: j6qE5DPZ4dbQuw88nTbYLxI+3MusxWaPDGnlnuVW9mnJG7QRqKfft3RsBv83cAuyoNJQNrucD5
 wCU8EQsql0Tg==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="535624209"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:46:48 -0700
Date:   Fri, 23 Apr 2021 11:46:47 -0700
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
Message-ID: <20210423184647.GN1401198@tassilo.jf.intel.com>
References: <20210423182813.1472902-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423182813.1472902-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So I added --skip-empty (and --no-skip-empty automatically) to suppres
> the 0 output and add the event stats like below.

I doubt we need the option for this.

But if you change it I would add the percentages after the absolute values.

-Andi
