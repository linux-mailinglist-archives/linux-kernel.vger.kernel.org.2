Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F9D4036E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348456AbhIHJ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhIHJ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:29:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279DC061575;
        Wed,  8 Sep 2021 02:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XkMsv0U5b8POCiXTPKYIykquQ4WRiqRp/+CywSEeQKM=; b=cvLwcnMFIGRllbKwXrEE+bZePC
        SYvAY+GPndlL+z/BcUJ5g7TXR6D+jeHVQwudTo2w1fts68ld4gkSXBWBDP8SDpbQo3/Gu1Ju2rxSa
        88VOQH2p6jhfjx6OjpoxugebWvkdYzRT+t3JOT83V/fEFHSXf6zkibnsgNIGH1X6RV5Zdo3kvZYeN
        JWNLj2Uo4fevyhsDOSzFQPF/YfDMDDcQccDOypH0pbyyPdXBPGqwUynNSVCuE66r0AE1txVfiYvYB
        zdYHsarQN8cplUpL3q+ADQW2Df6fofzCT0p8uI9x66u+CKrT0XAfYBoLEc78n80+fy6YfBczbiEsD
        JV9U0Csg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNtqG-008gZD-Tx; Wed, 08 Sep 2021 09:26:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0975F300454;
        Wed,  8 Sep 2021 11:26:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90263212EAB70; Wed,  8 Sep 2021 11:26:01 +0200 (CEST)
Date:   Wed, 8 Sep 2021 11:26:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, yao.jin@linux.intel.com, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, paulus@samba.org
Subject: Re: [PATCH 1/3] perf: Add macros to specify onchip L2/L3 accesses
Message-ID: <YTiBqbxe7ieqY2OE@hirez.programming.kicks-ass.net>
References: <20210904064932.307610-1-kjain@linux.ibm.com>
 <87ilzbmt7i.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilzbmt7i.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 05:17:53PM +1000, Michael Ellerman wrote:
> Kajol Jain <kjain@linux.ibm.com> writes:

> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index f92880a15645..030b3e990ac3 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -1265,7 +1265,9 @@ union perf_mem_data_src {
> >  #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
> >  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
> >  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
> > -/* 5-0xa available */
> > +#define PERF_MEM_LVLNUM_OC_L2	0x05 /* On Chip L2 */
> > +#define PERF_MEM_LVLNUM_OC_L3	0x06 /* On Chip L3 */
> 
> The obvious use for 5 is for "L5" and so on.
> 
> I'm not sure adding new levels is the best idea, because these don't fit
> neatly into the hierarchy, they are off to the side.
> 
> 
> I wonder if we should use the remote field.
> 
> ie. for another core's L2 we set:
> 
>   mem_lvl = PERF_MEM_LVL_L2
>   mem_remote = 1

This mixes APIs (see below), IIUC the correct usage would be something
like: lvl_num=L2 remote=1

> Which would mean "remote L2", but not remote enough to be
> lvl = PERF_MEM_LVL_REM_CCE1.
> 
> It would be printed by the existing tools/perf code as "Remote L2", vs
> "Remote cache (1 hop)", which seems OK.
> 
> 
> ie. we'd be able to express:
> 
>   Current core's L2: LVL_L2
>   Other core's L2:   LVL_L2 | REMOTE
>   Other chip's L2:   LVL_REM_CCE1 | REMOTE
> 
> And similarly for L3.
> 
> I think that makes sense? Unless people think remote should be reserved
> to mean on another chip, though we already have REM_CCE1 for that.

IIRC the PERF_MEM_LVL_* namespace is somewhat depricated in favour of
the newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields. Of
course, ABIs being what they are, we get to support both :/ But I'm not
sure mixing them is a great idea.

Also, clearly this could use a comment...

The 'new' composite doesnt have a hops field because the hardware that
nessecitated that change doesn't report it, but we could easily add a
field there.

Suppose we add, mem_hops:3 (would 6 hops be too small?) and the
corresponding PERF_MEM_HOPS_{NA, 0..6}

Then I suppose you can encode things like:

	L2			- local L2
	L2 | REMOTE		- remote L2 at an unspecified distance (NA)
	L2 | REMOTE | HOPS_0	- remote L2 on the same node
	L2 | REMOTE | HOPS_1	- remote L2 on a node 1 removed

Would that work?
