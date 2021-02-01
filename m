Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58F930A414
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhBAJKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbhBAJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:10:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5202C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9yzCjegvphyHKQtcc4XtyEBwvus4qWtbMG0GSfGCid4=; b=OBDi9LMmWpf2HU4rvIDFnwdRC4
        2hcv6AM9DaWiZ0AedpjNIdtgchaF3xV8K7W8WfqiABRTmss08+mG8s/midjGnrmKRdYvKAvHEnlcx
        6r0DvF8aDdt1/C7qeVD80oU2i1mghRDmzn7jAg6decZygDFWPRQ8refs7VPFPge1MCHZ3cDOCzhSD
        FDO+CXWDtLRw15D1G0barDHI0T9mYX6aUfNkL+SjNtzTyMiTpzJRkwsF2R+GwZ6AMmHlIEiFhb+CD
        /IdEgiR3HXkF7T2l3Nq1SAiNAj4sFbmARwkXNdJxdNhEIB53shsM2Dtwv1kkIUbqZ+iddf5K89WbN
        pVTClI/g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6VCK-00DZh1-7m; Mon, 01 Feb 2021 09:08:40 +0000
Date:   Mon, 1 Feb 2021 09:08:40 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 06/11] x86/fault: Improve kernel-executing-user-memory
 handling
Message-ID: <20210201090840.GB3229269@infradead.org>
References: <cover.1612113550.git.luto@kernel.org>
 <05e787a0d0661d0bfb40e44db39bf5ead5f7e4ef.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e787a0d0661d0bfb40e44db39bf5ead5f7e4ef.1612113550.git.luto@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:24:37AM -0800, Andy Lutomirski wrote:
>  #if defined(CONFIG_X86_64) && defined(CONFIG_CPU_SUP_AMD)
> +	if (likely(boot_cpu_data.x86_vendor != X86_VENDOR_AMD
> +		   || boot_cpu_data.x86 != 0xf))

Same nitpick as for the other patch.  Maybe we wan a little inline
helper for the specific erratum that includes the vendor and family
checks in adddition to using IS_ENABLED for the config options?
