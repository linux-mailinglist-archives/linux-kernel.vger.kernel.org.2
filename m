Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F63347982
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbhCXNXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235190AbhCXNW0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:22:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24B0861A0B;
        Wed, 24 Mar 2021 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616592146;
        bh=GcSGNS86IPXuekaXg9ipptP0xu07BYVN32Dn3lAw5Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SklqiAhLUjox0olCmABDVLAnSBUJ5s6OGmyU3Kk2YFNhthajh1NGNcWVk/jpBBPSe
         p0L6FZD84SRaOSlNJ1UAvqx8FTRJNgeTqdN1JEOef6ScdX3xr3kd+8lUWBr3sOU09x
         MqKLfDr2Y7Y6+Fm+JJ0y8VDKvp8evQz3ky3wuqOdJUSLcXj0M9KJYU6PRUzLDgtNI7
         3r9Jnssoqz9bWgDGJpqTqoxHpQgHwJiDJD3Hiq2f+b/ZzydcVdXOqs+Li3Hj3muMV8
         MDBWISshSRa3gMw6JBtKZLESNH4PETakz5JwIvEHj9yXBXUTsMqfb/L1XLHmBCMUti
         xSO7B2BBssHSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 026CF40647; Wed, 24 Mar 2021 10:22:23 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:22:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/2] perf stat: Align CSV output for summary mode
Message-ID: <YFs9D0+bLpnN4rs5@kernel.org>
References: <20210319070156.20394-1-yao.jin@linux.intel.com>
 <YFkJBD2laOM23pbk@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFkJBD2laOM23pbk@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 22, 2021 at 10:15:48PM +0100, Jiri Olsa escreveu:
> On Fri, Mar 19, 2021 at 03:01:55PM +0800, Jin Yao wrote:
> 
> SNIP
> 
> >   102107,,branch-misses,8012781751,100.00,4.15,of all branches
> > 
> > This option can be enabled in perf config by setting the variable
> > 'stat.no-cvs-summary'.
> > 
> >   # perf config stat.no-cvs-summary=true
> > 
> >   # perf config -l
> >   stat.no-cvs-summary=true
> > 
> >   # perf stat -x, -I1000 --interval-count 1 --summary
> >        1.001330198,8013.28,msec,cpu-clock,8013279201,100.00,8.013,CPUs utilized
> >        1.001330198,205,,context-switches,8013308394,100.00,25.583,/sec
> >        1.001330198,10,,cpu-migrations,8013324681,100.00,1.248,/sec
> >        1.001330198,0,,page-faults,8013340926,100.00,0.000,/sec
> >        1.001330198,8027742,,cycles,8013344503,100.00,0.001,GHz
> >        1.001330198,2871717,,instructions,8013356501,100.00,0.36,insn per cycle
> >        1.001330198,553564,,branches,8013366204,100.00,69.081,K/sec
> >        1.001330198,54021,,branch-misses,8013375952,100.00,9.76,of all branches
> >   8013.28,msec,cpu-clock,8013279201,100.00,7.985,CPUs utilized
> >   205,,context-switches,8013308394,100.00,25.583,/sec
> >   10,,cpu-migrations,8013324681,100.00,1.248,/sec
> >   0,,page-faults,8013340926,100.00,0.000,/sec
> >   8027742,,cycles,8013344503,100.00,0.001,GHz
> >   2871717,,instructions,8013356501,100.00,0.36,insn per cycle
> >   553564,,branches,8013366204,100.00,69.081,K/sec
> >   54021,,branch-misses,8013375952,100.00,9.76,of all branches
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> LGTM, for patchset:
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

After doing the s/cvs/csv/ changes, applied.

- Arnaldo
