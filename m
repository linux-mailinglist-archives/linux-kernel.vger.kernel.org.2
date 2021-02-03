Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38C030DF9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhBCQXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBCQXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:23:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B34FD64F7C;
        Wed,  3 Feb 2021 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612369381;
        bh=Kdpo/I2wBFFLsYnSyCw94HazmRebXtG8Ji6qeNEbRhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/vi7+60tsFfojVMNlOYm7gDvGnMpIkSkugLJlKmkcUYsqLta/1dF29vW/t/4Cj1Y
         bc2z/+TmFgyJNL0Wv3jvvxNEs6ieLUTh4RQlKcNBN+Iq7ojuls/bQ8o8AnsefLuKr6
         eVRGKIXMGORHBFxodWO5kzkbspBRb6Grplp+pAcx1w9KBH2AEC2+sjbAf2PvQHp+nv
         QZHkc4mapNhRqP2TinIjAP8bcM+bQiSA9p9H982Bvw7+YTsTzYiD2wU3cBhucBFKYj
         bI3+Ondur+rfc1BH/KBZxQJLTHpRGLEINTOc25cusIEwMBKXposNdljQMwbF8AbIvW
         x8MzE2J/8eEwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB86940513; Wed,  3 Feb 2021 13:22:58 -0300 (-03)
Date:   Wed, 3 Feb 2021 13:22:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jianlin Lv <Jianlin.Lv@arm.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, srikar@linux.vnet.ibm.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf probe: Added protection to avoid endless loop
Message-ID: <20210203162258.GF854763@kernel.org>
References: <20210203145702.1219509-1-Jianlin.Lv@arm.com>
 <20210204000814.7bebaeda0edb54f121159fbd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204000814.7bebaeda0edb54f121159fbd@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 04, 2021 at 12:08:14AM +0900, Masami Hiramatsu escreveu:
> On Wed,  3 Feb 2021 22:57:02 +0800
> Jianlin Lv <Jianlin.Lv@arm.com> wrote:
> 
> > if dwarf_offdie() return NULL, the continue statement forces the next
> > iteration of the loop without update variable off. It will cause an
> > endless loop in the process of traversing the compilation unit.
> > So added exception protection for loop CUs.
> > 
> 
> Thanks for the quick update!
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thank you,
> 
> > Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> > ---
> > v2: removed the statement that updates variable in the function argument.
> > ---
> >  tools/perf/util/probe-finder.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > index 76dd349aa48d..1b118c9c86a6 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -1187,8 +1187,10 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
> >  	while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL)) {
> >  		/* Get the DIE(Debugging Information Entry) of this CU */
> >  		diep = dwarf_offdie(dbg->dbg, off + cuhl, &pf->cu_die);
> > -		if (!diep)
> > +		if (!diep) {
> > +			off = noff;
> >  			continue;
> > +		}
> >  
> >  		/* Check if target file is included. */
> >  		if (pp->file)
> > @@ -1949,8 +1951,10 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
> >  
> >  		/* Get the DIE(Debugging Information Entry) of this CU */
> >  		diep = dwarf_offdie(dbg->dbg, off + cuhl, &lf.cu_die);
> > -		if (!diep)
> > +		if (!diep) {
> > +			off = noff;
> >  			continue;
> > +		}
> >  
> >  		/* Check if target file is included. */
> >  		if (lr->file)
> > -- 
> > 2.25.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo
