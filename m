Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C931DF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhBQSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:21:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234808AbhBQSVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:21:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B36AA64DF0;
        Wed, 17 Feb 2021 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613586030;
        bh=xosJfoge81by3BYeZb2BoEL7cWV/x/vgPk2izqwuAZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj2t1HHtNyczeFLSBZQVclCqIe86YlKOb34527u7Ubh9gW4tGXMoDbVuT2G9tc6TA
         ylHXAMpYg0evPXK7Di8m01FWseDcunc/eYsBIhEm3M5//HwXggOlDzZHl8u+NkL4oZ
         CLfwnGhurIAqmUGnSBRITEy1fvbzdsz+k8O1+Uf6wiFNzm/S6KedXw/GeE5Y3DaIGX
         r835qzkDGlyyt1Nj0m0Gaj7dBUb7yPlCN+45A7xyAP1z/tvigjrf7Cg4YJn2ea/1Tt
         +VAGD2C+Rw81AbiRs7PrJiSv61n/YolkqWsMgjtYtDAPyG/qh6y3Pfs8EGERK740yS
         QiLjVCy+w8WyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A647540CD9; Wed, 17 Feb 2021 15:20:28 -0300 (-03)
Date:   Wed, 17 Feb 2021 15:20:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf metricgroup: remove unneeded semicolon
Message-ID: <YC1ebB5NfPUcmWO5@kernel.org>
References: <1612165277-95878-1-git-send-email-yang.lee@linux.alibaba.com>
 <CAM9d7ci4X9kbHN1voPvT6HR+b8g16LsQKzfbOG5Cq+H2XBt0QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci4X9kbHN1voPvT6HR+b8g16LsQKzfbOG5Cq+H2XBt0QA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 16, 2021 at 04:34:25PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Mon, Feb 1, 2021 at 4:41 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
> >
> > Eliminate the following coccicheck warning:
> > ./tools/perf/util/metricgroup.c:382:3-4: Unneeded semicolon
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/util/metricgroup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index e6d3452..26c990e 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -379,7 +379,7 @@ static int metricgroup__setup_events(struct list_head *groups,
> >                                 metric_refs[i].metric_expr = ref->metric_expr;
> >                                 i++;
> >                         }
> > -               };
> > +               }
> >
> >                 expr->metric_refs = metric_refs;
> >                 expr->metric_expr = m->metric_expr;
> > --
> > 1.8.3.1
> >

-- 

- Arnaldo
