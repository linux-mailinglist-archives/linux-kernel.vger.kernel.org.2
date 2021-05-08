Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0427D377493
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhEHXVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 19:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEHXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 19:21:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9559C061573
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MgGM9LaDhzqC2AUWraDRKJjmwAHl2LHVlB1VPC4+S+w=; b=HHideBd3E0a6pv3Cr6H1zLetvE
        P5c/OKmy5+xtQcVqDqs5FHRAhi6WBRCg4yrNjRFcTND4Y44mYPcEirPGw3LUVGH2aM15unXtBOm7r
        ybV4Hc1ASGae7IFSg2cDJIZ+7I18HWvCPQKWT+amufcWaFY3h1XU65JCKG0FMiLSfLWmCpoeRjflX
        uTWVjAc7P8qzUvu4cQ/bGgq0zZ50oVmjsOpyl5hsQ5I9ROZTHxZQtxS3jT1FyRLk826sVjswWs3s2
        eueSYTwnhHKGsM+fSxW3RmiUq/Z2GIkhbjwruFLppyJw4a+PlHxesDECMNbqgQ1FWm5A9JEdCxbvz
        3RQD9yhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lfWEW-004dVU-9G; Sat, 08 May 2021 23:19:43 +0000
Date:   Sun, 9 May 2021 00:19:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmalloc_index: remove case when size is more than
 32MB
Message-ID: <YJccjBMBiwLqFrB8@casper.infradead.org>
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508221328.7338-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 07:13:28AM +0900, Hyeonggon Yoo wrote:
> the return value of kmalloc_index is used as index of kmalloc_caches,

it doesn't matter.  every few weeks somebody posts a patch to "optimise"
kmalloc_index, failing to appreciate that it's only ever run at compile
time because it's all under __builtin_constant_p().
