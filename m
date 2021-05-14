Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A697338094D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhENMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhENMUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:20:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD124C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4j6NAUINOO2iRcafPhFqTSB4UiIS5qPdm2W1b5MCFfo=; b=v/Btch9J/kbExn3R8m5BlhEMgM
        nEleQOuvkkgT8ka60BvyzSgCv6r4VrATcDO1UYG3G0S/DPt/GeMiF8m/jJLLnw5b5XNFjYfaDl8Ii
        GbMcgQeFIzeKIH+gn+Zmye9+ozbfTNtehdl7O6fRX6PUXlpLr/hU3FfObkJZjSCYIkvteTMTw1tfs
        KSWOwW+F/FVxdEasLWPSqRRatNsRgzoWQXI9TKvyOH4J6RIg5L8stpRzhcxk+8e5YUGtLclA0juhB
        USvUpAkMPSWX5tcBOmHbskfCMv5YzrQuUEvSG9PP7y2wmECHI66QP8frqj+RHkS6ETc6qTkkYrjEd
        gtslY/5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhWlL-00ALqZ-0H; Fri, 14 May 2021 12:18:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C803E30022A;
        Fri, 14 May 2021 14:17:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEE0820D74F30; Fri, 14 May 2021 14:17:49 +0200 (CEST)
Date:   Fri, 14 May 2021 14:17:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 26/94] Maple Tree: Add new data structure
Message-ID: <YJ5qbS2KJcVp+ocY@hirez.programming.kicks-ass.net>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> +static void mas_set_height(struct ma_state *mas)
> +{
> +	unsigned int new_flags = mas->tree->ma_flags;
> +
> +	new_flags &= ~MAPLE_HEIGHT_MASK;
> +	new_flags |= mas->depth << MAPLE_HEIGHT_OFFSET;
> +	mas->tree->ma_flags = new_flags;
> +}

This goes sideways when mas->depth is too large; I didn't quickly see an
assertion / range checks for mas->depth anywhere.
