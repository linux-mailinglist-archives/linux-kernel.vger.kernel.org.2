Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3C836B38C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhDZMyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233506AbhDZMyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:54:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B404F6101C;
        Mon, 26 Apr 2021 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619441601;
        bh=XP6V8WLfk/IYQoiDyR+sBWHoz1XSEonoi2ElBSLzOiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PK9WGFtsvPdFRa4NWm3H1olA57WQGtdSXd6JX6aijtAdDDGbuIOaIBn4E21I3w4tV
         dwrDfdXcs68Vxo9JQ71zr4jfKTOjd/sUX5P4vR505Gleij7m7liXbJN431fzLRHjAg
         ba2AWvfRAEwkWTS4ipcz+kHpPHJcl/1/jb/Fgxd8Ikl7aGmTXcEX4nNOOy79SFg6HM
         X+OtZYZBoiES+UNUXeZBkrE74JrbTqyOPtlvW7tm8Ot8DRw6LDZ1lA6F1xHoa9tBLz
         Xyi1Blw6rUmW5w0jjKkhWXPMRGV24bNkNwtDXUMLQJ+JaU75jpV/XL92GeQqL/r0Ld
         seee8mmtBH1WQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0CBDE40647; Mon, 26 Apr 2021 09:53:18 -0300 (-03)
Date:   Mon, 26 Apr 2021 09:53:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/5] perf report: Make --stat output more compact
Message-ID: <YIa3vXJrVwN44mjx@kernel.org>
References: <20210423182813.1472902-1-namhyung@kernel.org>
 <20210423184647.GN1401198@tassilo.jf.intel.com>
 <CAM9d7ciy82RM4UDHeAXwu4p7nPSg58euNK=Kdb7E0mj06e10oQ@mail.gmail.com>
 <20210423202024.GO1401198@tassilo.jf.intel.com>
 <CAM9d7cjKdo6AKAL43-mp+hpx9m_8UU6j8Zy1RUZkLdh27bR_ig@mail.gmail.com>
 <20210426043147.GU1401198@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426043147.GU1401198@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 25, 2021 at 09:31:47PM -0700, Andi Kleen escreveu:
> > Hmm.. do you want something like this?

> >              TOTAL events:      20064
> >               MMAP events:        239   ( 1.2%)
> >               COMM events:       1518   ( 7.6%)
> >               EXIT events:          1   (0.0%)
> >               FORK events:       1517   (7.6%)
> >             SAMPLE events:       4015   (20.0%)
> >              MMAP2 events:      12769   (63.6%)
 
> Yes that's it.
 
> Really shows how inefficient perf is for short measurement
> periods.

Brainstorming a bit:

Yeah, I wonder if we could have a new mode where 'perf daemon' collects
the !SAMPLE records and then a 'perf record' would collect just
PERF_RECORD_SAMPLEs, and then 'perf report' would merge things up.

A perf.data file cap for the 'perf daemon' would mean that when a 'perf
report' result looks interesting, one could press a hotkey and generate
a complete perf.data file with the !SAMPLE records needed to have it
self sufficient.

Additionally maybe we could have 'perf daemon' providing a interface to
resolve samples, returning unresolved ones for older stuff.

wdyt?

- Arnaldo
