Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F047530E4F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhBCVaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhBCVaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:30:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B2BC64F6C;
        Wed,  3 Feb 2021 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612387778;
        bh=hw9ktotRg4PGonFJG6TeRtVrQo/XWuiMTuLTnRrsfY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxd8jM3+EO6kGFctu889SBhm0FQsE1cnabWnN43NbDbpJXnlAb7GDYYCrdIyTyC9/
         JRKebWcbhoZpQw7CkPhKSWUlica97QuD4QSddiPxW3vyS5KdLaame1i6cNRoam2HPQ
         oLXziX3ZLrgv3EcD+ta7YvZJPnN892MgPaQLVzUKauUbvU0A+KxgaU1OKrMYHJKhEo
         gaxpNGL32xO+XcmtMl4XeE+rv+YWtBB2sSuJ306+cCM15YUeO+3gIBDBYkEvCD/zAX
         ckyZeKI1pOLvenr/ajrY0WqhdIx9xOGLMUVeKSPKu7X9IweL7I5GOKdzfIqSjgEvR8
         f7tpCthpLe+Qw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CE45740513; Wed,  3 Feb 2021 18:29:35 -0300 (-03)
Date:   Wed, 3 Feb 2021 18:29:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 5/9] perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT
Message-ID: <20210203212935.GX854763@kernel.org>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-6-git-send-email-kan.liang@linux.intel.com>
 <20210203203105.GJ854763@kernel.org>
 <3429f643-c0a1-320b-035f-24406d0b8f7d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3429f643-c0a1-320b-035f-24406d0b8f7d@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 03, 2021 at 04:19:34PM -0500, Liang, Kan escreveu:
> 
> 
> On 2/3/2021 3:31 PM, Arnaldo Carvalho de Melo wrote:
> > > --- a/tools/perf/util/perf_event_attr_fprintf.c
> > > +++ b/tools/perf/util/perf_event_attr_fprintf.c
> > > @@ -35,7 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
> > >   		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
> > >   		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
> > >   		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
> > > -		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE),
> > > +		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(WEIGHT_STRUCT),
> > I have CODE_PAGE_SIZE in my perf/core branch, was this somehow removed?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=c1de7f3d84ca324c7cda85c3ce27b11741af2124
> > 
> > I see, you did this patchkit on top of upstream, that has just
> > DATA_PAGE_SIZE, while my perf/core branch has CODE_PAGE_SIZE. I'm
> > adjusting it, please next time do tooling development on acme/perf/core.
> 
> Sorry, I will rebase the patchset on acme/perf/core.

No need. Look at tmp.perf/core, please test it, its all already adjusted
there.

- Arnaldo
