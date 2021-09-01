Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5FC3FD1BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 05:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbhIAD1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 23:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbhIAD1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 23:27:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20800C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 20:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oAgnfSvnfESWGAK8QHbbE4+c2ZjvA7X34fzLdM1J34s=; b=mHfxkE++4EOW/MVei3iNYDbj09
        8oY7t0361fX7+XNPRVzdk5pASaQW4i/mGaxnnMTimsb85DO48cwCWrf59R3OkCpfFWEtcDbJh7kWE
        vbHKS/rKP3XyUMHsQHKy5mxIL19iyqysuK1IX0v25/MhB4I1+YrVZWPzl5XZN3D/WkWL1SsLMkn0r
        tdvO2KQPmP5pDGjRHyePO4Zc1bqVLkQuaJBURtGa+dNIeBj1Tx1LsPA0+FGex2egdSwVrVD33Aid1
        IvSsvRt724M/NQiA8Z0286+VAf/0TzCih4w421nzdp1TsQogM/eccFaRallebMASVMyi27X+u7x/w
        o3CL2g1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLGs1-001pbg-I7; Wed, 01 Sep 2021 03:25:06 +0000
Date:   Wed, 1 Sep 2021 04:25:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YS7yjcqA6txFHd99@casper.infradead.org>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
>     In the NUMA, we only have one page cache for each file. For the
> program/shared libraries, the
> remote-access delays longer then the  local-access.
> 
> So, is it possible to implement the per-node page cache for
> programs/libraries?

At this point, we have no way to support text replication within a
process.  So what you're suggesting (if implemented) would work for
processes which limit themselves to a single node.  That is, if you
have a system with CPUs 0-3 on node 0 and CPUs 4-7 on node 1, a process
which only works on node 0 or only works on node 1 will get text on the
appropriate node.

If there's a process which runs on both nodes 0 and 1, there's no support
for per-node PGDs.  So it will get a mix of pages from nodes 0 and 1,
and that doesn't necessarily seem like a big win.  I haven't yet dived
into how hard it would be to make mm->pgd a per-node allocation.

I have been thinking about this a bit; one of our internal performance
teams flagged the potential performance win to me a few months ago.
I don't have a concrete design for text replication yet; there have been
various attempts over the years, but none were particularly compelling.

By the way, the degree of performance win varies between different CPUs,
but it's measurable on all the systems we've tested on (from three
different vendors).
