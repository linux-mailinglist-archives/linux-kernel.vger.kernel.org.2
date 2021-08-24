Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3593F68C6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhHXSHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232943AbhHXSG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:06:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97D836113A;
        Tue, 24 Aug 2021 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629828372;
        bh=u8wj0I1xjKqUxJghL/zTMAbA6AlVct5UaAjQ/CovUb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJvxwmQWL52MYYQ8yccd9DRYr/QrNi3W2lFAI7t9u/567yw0P0DcCXF/J5MGwl6HH
         m7h9DjO+vGROgTU84NNJ143vRq91HJWjf3QiuVVCqMSLBLwvdvVLF+NTPPz9Qms0Gx
         QFwrKEHoc4Apx9KK/O6jUPRlCWH1uZ5cxTkQXbQg8nYMgtHIYamZBSBXMMdRIqFnJq
         Q5wBaQ4RaLPr6wsa23xN1EnWBt6rUdwDA1MMC/71fooIHyBpH5TlErnkNB+zEuuIBi
         5ZtZgYm4BcXotu+rnF4d2POK7Jnr5lMX/m0XIe/jsNItd4uQRm2sxwdVQ1FHoINyUc
         IB9Sh1V16jscw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ACF274007E; Tue, 24 Aug 2021 15:06:09 -0300 (-03)
Date:   Tue, 24 Aug 2021 15:06:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] libperf tests: Fix verbose printing
Message-ID: <YSU1ETebS3xtCJFG@kernel.org>
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
 <20210820093908.734503-3-nakamura.shun@fujitsu.com>
 <YSQEghUuFobZN5T+@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSQEghUuFobZN5T+@robh.at.kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 23, 2021 at 03:26:42PM -0500, Rob Herring escreveu:
> On Fri, Aug 20, 2021 at 06:39:07PM +0900, Shunsuke Nakamura wrote:
> > libperf's verbose printing checks the -v option every time the macro _T_ START
> 
> __T_START
> 
> > is called.
> > 
> > Since there are currently four libperf tests registered, the macro _T_ START is
> > called four times, but verbose printing after the second time is not output.
> > 
> > Resets the index of the element processed by getopt() and fix verbose printing
> > so that it prints in all tests.
> > 
> > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > ---
> >  tools/lib/perf/include/internal/tests.h | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, applied.

Waiting for the conclusion on the discussion for the other two patches.

- Arnaldo

