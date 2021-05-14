Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845AF380791
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhENKmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhENKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:42:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444EBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yRCuqqPIMRguH3qnULRLBKTTnDt1qnlVIzNoYoxTQQw=; b=SjYjoZzsDHTolqv6Sc4mVujvFn
        AwVD75tfy6NJuw3BMqfCGZj4RaMA8NeoQbuC8/YvPpaC2f+AM2aeQ2ESYtaWQcl8M7RH9o/Hs80xx
        OUBimEyA4rjeeDY62FrJlI6j6O4Gx5YgwnZtr6nGFys7PJVsaq5A2PGhTv0z4XtGmw2MqSt0e24jC
        x6FjUnFnMSDUfeCOdN8LexvQqTwBIJpg+WJtsUfoSD3wFHeACuH4y4W/+TKY4Qleb7+8q+cDicGS4
        D7U3x6CFZ76ENRosPS9JJSDSuNLuJY5FrYnS83MxstMrPlh6XDZCi1HVazducDLx9IGbC2KMpYxkN
        jGw+xK9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhVFR-007na5-8B; Fri, 14 May 2021 10:40:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F197030001C;
        Fri, 14 May 2021 12:40:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5BC020829F97; Fri, 14 May 2021 12:40:45 +0200 (CEST)
Date:   Fri, 14 May 2021 12:40:45 +0200
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
Message-ID: <YJ5TrReBMXwCqJFE@hirez.programming.kicks-ass.net>
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

> +/* Flags:
> + * MAPLE_ALLOC_RANGE	Use allocation ranges (tracks gaps) in this tree
> + * MAPLE_USE_RCU	Operate in read/copy/update mode for multi-readers.
> + * MAPLE_HEIGHT_OFFSET	The position of the tree height in the flags
> + * MAPLE_HEIGHT_MASK	The mask for the maple tree height value.
> + */

Regular comment style would be:

/*
 * Flags:
 ...
 */

> +#define MAPLE_ALLOC_RANGE	1	// Bit 0
> +#define MAPLE_USE_RCU		2	// Bit 1
> +#define	MAPLE_HEIGHT_OFFSET	2	// Bit 2
> +#define	MAPLE_HEIGHT_MASK	60	// Bits 2-5

Can we pretty please keep masks in hex, like:

#define MAPLE_HEIGHT_MASK	0x3c

Because then it's instantly obvious is it bits 2-5.

