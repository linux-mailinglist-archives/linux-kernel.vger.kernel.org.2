Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8792343C080
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 05:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhJ0DH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 23:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbhJ0DHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 23:07:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17376C061570;
        Tue, 26 Oct 2021 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2QEJl6ydeEpfVKPrusTfke/4wYUwA/hZSkA+vyln7I4=; b=tWHS4LISDxbKziMnxAcTz+Mcs+
        SOQRHzJMYyj2jwxGsZL8mQS8UGJhSFqDucTtCx23L7GkfDKrQt3XJw7UyC4DP+jn381BlRnbI/Ojj
        3xjGmUHs6jBwtinLLrdkUs8uOPzvwHcBqJZ745+eoJ2hyMJ2M18lXh8x/b4nOYfdBdlLJhTwlsM9U
        28qKZnMC9XgIVzmW4X9vMMLoeoD3chIRIuNgiOmOFPbVamvi/Jocg1BFWuBf1SSKWqTkRnulsnShJ
        DWI2AmaSc+1f4SmiSuwz2LrSCaToOKGi34n6AWQEreGWZXYb0QyrxeBCLTXvLSBNZuIzo6b1w3a2f
        niCz7ykA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfZF5-00HLvL-C4; Wed, 27 Oct 2021 03:04:56 +0000
Date:   Wed, 27 Oct 2021 04:04:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
Subject: Re: [RFC 1/8] mm: add overflow and underflow checks for
 page->_refcount
Message-ID: <YXjByyquuaN3ZKRq@casper.infradead.org>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-2-pasha.tatashin@soleen.com>
 <YXhbq/6OIpIAr7Tx@casper.infradead.org>
 <CA+CK2bCZO5J-NRqavWFKXt+yB1u17dFA9VrW48HLBepiQLJtcA@mail.gmail.com>
 <CA+CK2bBP_XJXN+wM=hmRO3C7x2Fi_SnbT_J0fU9xH0vnxU_Omg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBP_XJXN+wM=hmRO3C7x2Fi_SnbT_J0fU9xH0vnxU_Omg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 09:21:29PM -0400, Pasha Tatashin wrote:
> I think we can do that by using:
> atomic_fetch_*() and check for overflow/underflow after operation. I
> will send the updated series soon.

Please include performance measurements.  You're adding code to some hot
paths.
