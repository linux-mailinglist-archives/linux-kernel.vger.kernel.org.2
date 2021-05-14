Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB6380904
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhENL4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhENL4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:56:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C9C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n2JbRGWNEA370w8zAVffROcBjetH7P2OexCk1hMxyV8=; b=bl6Uz0GraV8CDcLOMtkK29QPC1
        QGTey8qSWuEdMXbsMn0grslnDO6nHdHC2GFjGP1+V7VaSTAUvHnNRpJSJrKFILi25wN1+kEguFg97
        nQPnJXhF0OLl4f/e5VTFVA5x7hWetxIUvJKhZ1xiyBBuge0IdJ94cSX71imVK9HbZOuS9aHN5Kbtu
        wd2r/2MVt2A/vIiPS+ob4y7NlqXRV81gzswaNIwEzYDLMuEsOKeYu37yUStl/BhdP0ue8SBOQfDDx
        7CFZMq7d+Q0GW76DVu1C7QKJB60+G6LQVdrnCllm8xBYjMDZCLXRjrqB2VD1J8U37ebkFQZHq3tHt
        Qbbvqo2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhWP8-007yfY-0e; Fri, 14 May 2021 11:54:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2015730022A;
        Fri, 14 May 2021 13:54:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0553620829F97; Fri, 14 May 2021 13:54:52 +0200 (CEST)
Date:   Fri, 14 May 2021 13:54:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Message-ID: <YJ5lDF4qGy8OaOJ/@hirez.programming.kicks-ass.net>
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
> +static inline void mas_set_range(struct ma_state *mas, unsigned long start,
> +		unsigned long last)
> +{
> +	       mas->index = start;
> +	       mas->last = last;
> +	       mas->node = MAS_START;
> +}

Your indenting went wobbly :-)

Also, I personally prefer this style:

static inline void
mas_set_range(struct ma_state *mas, unsigned long start, unsigned long last)
{
	mas->index = start;
	mas->last = last;
	mas->node = MAS_START;
}

And I'm a big proponent of at the very least keeping line-breaks aligned
to '(', like:

static inline void mas_set_range(struct ma_state *mas, unsigned long start,
				 unsigned long last)
{
	mas->index = start;
	mas->last = last;
	mas->node = MAS_START;
}

Which you can get vim to do by using: set cino=(0:0


