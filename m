Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DEE30A42C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhBAJQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhBAJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:15:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C88C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3tjdZWZq03xU7S45RYn7/iMV9oUlIC3Za+A9whzx8O4=; b=g+kDcXC5sY6NNbrSwB+PTTIhEQ
        MCzg7SRDAvsEgZWpvGFg5ZagSMRx93K4G04egK4nx96D+sLgSIuS5hgQpKzvR2sLSljcv6EbTpxKA
        lN4wGQEd9g738WZgPr2MTfWvyhA9Sa1cVwWdN8Gvq6Rk6GXhdwebb9BJJInr1kC1IBaJjeT3lvziy
        Xu90EN3GH/QiNBT9CHYxuO7perPUE5x3ePkxepKAZZ/VtgPiQrxAgrp2Vcu6nFtZ8SpA63Vr1Xn7i
        DFoniN5WvmJGtaicYB0zOfSt5t3d44gThe43hf29lhQt/Yw4SBWeQrL9f9yHLjrWCQx0juwK3Dxyq
        JyJA808A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6VHm-00DZzI-8E; Mon, 01 Feb 2021 09:14:18 +0000
Date:   Mon, 1 Feb 2021 09:14:18 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 09/11] x86/fault: Rename no_context() to
 kernelmode_fixup_or_oops()
Message-ID: <20210201091418.GC3229269@infradead.org>
References: <cover.1612113550.git.luto@kernel.org>
 <5b0ad34afeeee15032393367b0945a5032903162.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0ad34afeeee15032393367b0945a5032903162.1612113550.git.luto@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:24:40AM -0800, Andy Lutomirski wrote:
> +		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);

>  	if (!user_mode(regs)) {
> -		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
> +		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);

These overly long lines are a little annoying..
