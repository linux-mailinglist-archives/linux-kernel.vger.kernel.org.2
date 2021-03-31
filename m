Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C034699E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhCWULA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhCWUKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:10:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99072619D1;
        Tue, 23 Mar 2021 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616530229;
        bh=eF11GWOPZSFreRAgMW+T3UYnIlYGnfdKJg4BzHOzcU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8m/hQnjh7eWFcqMAwYSuTnNAMFatsH8dCFMNesV3dLmeD3ADwFrmMa9cSqGunngC
         qc4AQPgTrZcXe/qlUPj0ah9IlglIoSW+H+4+yhT5wFp6DiIZzT7H+f/3DPJEunUhCM
         Ix4LjT77ZUmKDMeK9Ovf7IY3BtRhF8X8z8r15n1qehd6IZ8C5R7X/XyzhrL9xIKme9
         aLYI+hLfL0D5qR5PPc7MD+X4Bmjz1HxqeOUig3MVb8Q0VWdkS3ixVjQ4ysixqN7y1g
         Vg60IMl2szmI5Bf5p3K6KhH3l/adY8gRM6TDJM63IA9KulDQa7JlBPYPHj0s35SYc7
         1QU1Du/EidLbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88F6640647; Tue, 23 Mar 2021 17:10:26 -0300 (-03)
Date:   Tue, 23 Mar 2021 17:10:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix various typos in comments
Message-ID: <YFpLMsAhFu1QaDMC@kernel.org>
References: <20210321113734.GA248990@gmail.com>
 <20210323161010.GB61903@gmail.com>
 <YFosnQJEhsRwEMS3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFosnQJEhsRwEMS3@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 23, 2021 at 02:59:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 23, 2021 at 05:10:10PM +0100, Ingo Molnar escreveu:
> > 
> > Here's the delta between -v1 and -v2, in case you already have -v1 or 
> > want to review the changes only:
> 
> I had not pushed out it, so I just replaced v1 with v2, thanks.

So the first hunk has a problem, I'm fixing it up :-)

- Arnaldo
 
> > +++ b/tools/perf/arch/arm64/util/machine.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +/ SPDX-License-Identifier: GPL-2.0
> >  
> >  #include <inttypes.h>
> >  #include <stdio.h>
> > @@ -6,11 +6,11 @@
> >  #include "debug.h"
> >  #include "symbol.h"
