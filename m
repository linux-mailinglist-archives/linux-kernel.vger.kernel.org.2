Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0983648E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhDSRQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhDSRQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:16:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79E0C611F0;
        Mon, 19 Apr 2021 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618852551;
        bh=8KyYHrpSSLZ6bzyctVHE3NpW0Q8UJehavMJQewTSjQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMQfD3Jv2VKCkamBmuh6Df5UtWFjpD44ZXsp4C26QcuDgR/ZPXSuZy7joN+k2GR71
         f7LpvyVMkAdCu+XXopx7ISNraTUQxaJaBwKcqlSkZlAA5WVboWoCWZPlpetDkM1nte
         krP7/ia6qw5f7sfILmQRKy/Ez8QsbHL/Tjlzv0U1p5dfVe6XpkwQrQhaFzTBQdwRCf
         tyDZa8EfdfReF+vaZjgKzAyf4tX1CJY9XFdtFM3SA4SupSCBm+mc1iK8Z8jLLSUxOu
         Sa7QRfiajQVflf8FGTSt60COO6QgZHSyoO+JrBI9v85GS4zZ9jU6ULENttDG2Na1Ap
         LpIxfIQnDS4zQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E385D40647; Mon, 19 Apr 2021 14:15:48 -0300 (-03)
Date:   Mon, 19 Apr 2021 14:15:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Muhammad Usama Anjum <musamaanjum@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com
Subject: Re: [PATCH] objtool: prevent memory leak in error paths
Message-ID: <YH26xMfn04KATRow@kernel.org>
References: <20210413204511.GA664936@LEGION>
 <20210414084709.GT6021@kadam>
 <YHfqOVf1hGlbWjLP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHfqOVf1hGlbWjLP@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 15, 2021 at 09:24:41AM +0200, Peter Zijlstra escreveu:
> On Wed, Apr 14, 2021 at 11:47:09AM +0300, Dan Carpenter wrote:
> > On Wed, Apr 14, 2021 at 01:45:11AM +0500, Muhammad Usama Anjum wrote:
> > > Memory allocated by sym and sym->name isn't being freed if some error
> > > occurs in elf_create_undef_symbol(). Free the sym and sym->name if error
> > > is detected before returning NULL.
> > > 
> > > Addresses-Coverity: ("Prevent memory leak")
> > > Fixes: 2f2f7e47f052 ("objtool: Add elf_create_undef_symbol()")
> > > Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> > > ---
> > > Only build has been tested.
> > > 
> > 
> > Just ignore leaks from the tools/ directory.  These things run and then
> > exit and all the memory is freed.  #OldSchoolGarbageCollector
> 
> Mostly true; but I suspect tools/perf might care, it has some longer
> running things in.

Yes, and now we have 'perf daemon' that is long running.

- Arnaldo
