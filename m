Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A223B5A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhF1I2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhF1I2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:28:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56C5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bBOOAJZmb1MGQkBOhTr3Y7C4iASxBA5CQqatO8OKvkU=; b=IcEY+/vJyPW5mfpsonXxEzgnK2
        ij2cjBwdvkFvDpKT0mwZmUi1tZbHxGz0K4oI6cmwke1DT62/JaCr7pB6BSOLJAX1D/tVjkOouDAOR
        azyo8Erh9WYzCWTBPA7tNyhFRwvALHIAwddq2XtH94udA/1OcPY+W6OwLOfPjAV86OITTrXfG/mfp
        f2mTpaPvkdIFLmqb5I1jwTQ0gHno895wsth7lUaQNgsIMXPfLVM14Fk/NNripoW65fF0QCMRHM7Ak
        D6jD95Cp7/u1V+FHmN+Zx7zV4G8Q4XH4sh4RM3FOip4LOEISeGUE+mMO3bv1GAObXLcgGJH/1pNc3
        +zD31TVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxmZL-002k7t-Ll; Mon, 28 Jun 2021 08:24:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00C153001DC;
        Mon, 28 Jun 2021 10:24:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D71FF2028DBF2; Mon, 28 Jun 2021 10:24:38 +0200 (CEST)
Date:   Mon, 28 Jun 2021 10:24:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Forney <mforney@mforney.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] objtool: Check for gelf_update_rel[a] failures
Message-ID: <YNmHRi+00RAAUmEt@hirez.programming.kicks-ass.net>
References: <20210509000103.11008-1-mforney@mforney.org>
 <CAGw6cBv2NBCDrZb7ZnmAhZOJ_EwgW6tR-8AfY2v=T9OkD=6O8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGw6cBv2NBCDrZb7ZnmAhZOJ_EwgW6tR-8AfY2v=T9OkD=6O8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:52:07AM -0700, Michael Forney wrote:
> On 2021-05-08, Michael Forney <mforney@mforney.org> wrote:
> > Otherwise, if these fail we end up with garbage data in the
> > .rela.orc_unwind_ip section, leading to errors like
> >
> >   ld: fs/squashfs/namei.o: bad reloc symbol index (0x7f16 >= 0x12) for
> > offset 0x7f16d5c82cc8 in section `.orc_unwind_ip'
> >
> > Signed-off-by: Michael Forney <mforney@mforney.org>
> 
> Ping on these patches.

Josh, I forever forget which libelf versions we're supposed to support,

But these patches do look reasonable to me, wdyt?
