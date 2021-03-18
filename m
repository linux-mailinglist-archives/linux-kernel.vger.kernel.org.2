Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839F93406BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhCRNTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhCRNTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:19:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9023F64F01;
        Thu, 18 Mar 2021 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616073563;
        bh=qio+VG0MxRKIn/2N7rSfl7+Dp9HthtsKyasWA1ZDYa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fp5klo7BbFW0vVOZeB7QNEgAY7TAtErwb49BD2i91tyZqc1S1Nn90GyrNhIppEft6
         cTK7aa1zCpFJyeuy4ML3OiAxhSng16pkp/+wk2K5AMe9j9sN6csaLCmb1UIj6qHymj
         HW0q1qiyN2dHMp76f449qcCj7+XHyRtECDV4QyNAd2YLgd6BaJq0f89aXEnLu8N9Ig
         ikvLh62MbRL885qWS6Qbr5KetVmTbEkqA3QFtIxrnZJt8Z3u7iRE8Tt5aUldW10hjk
         neX3kBavLs3Bh3tlwmy5fMOSXCkbp7uPgwC+dQOZl4J0/oiVJYcmgV8H1a0APo01R3
         8kwxsPhUucc2g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 822C840647; Thu, 18 Mar 2021 10:19:21 -0300 (-03)
Date:   Thu, 18 Mar 2021 10:19:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/3] perf test: Remove unused argument
Message-ID: <YFNTWULxjCW764Rt@kernel.org>
References: <20210317005505.2794804-1-irogers@google.com>
 <YFNPPUK9nE6khx9/@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFNPPUK9nE6khx9/@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 18, 2021 at 02:01:49PM +0100, Jiri Olsa escreveu:
> On Tue, Mar 16, 2021 at 05:55:03PM -0700, Ian Rogers wrote:
> > Remove unused argument from daemon_exit.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> for the patchset
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, added to the csets I had applied already in my local repo.

- Arnaldo
