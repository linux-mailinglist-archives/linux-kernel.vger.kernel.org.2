Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2B35C27B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbhDLJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbhDLJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:23:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2C1C06136E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xSaLg0d5BnzMi4b4UK7QvM6+0Er5HobHZZa5u8XChI0=; b=J+wc8GvEHNZmuOhAFfHW4OCaFN
        MeoKZQIBEjEtLQAdhLso6IiRKRyH4zYgQLoEzlnihDBZk5DwXSg1WhEQCKsIsU5QTptf5PHVZPey3
        xgyfjjrxvYuKhNue+/PLZVvil6Jzc2UstFi/bSg0ArGAu0Hmsf5HZ/a4OzYaVJ3NOeoUK8w+pDtWK
        URykpFynzzwRFZ+xq6EEIiDw9O7flo9ap+c1tMKW+j34Ujp5MOyrFPRycmxUvd3pDiTFG5AExmX98
        3BYcv35I8jj0nh3QmkGn1JbfChn08Z65PNINCd91jBWD50kCNOaot8kqgOc7OC4Sk2YZ9NtPTZa9y
        JPTz5x9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVskP-006GEn-So; Mon, 12 Apr 2021 09:20:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58982300033;
        Mon, 12 Apr 2021 11:20:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DE4720224201; Mon, 12 Apr 2021 11:20:45 +0200 (CEST)
Date:   Mon, 12 Apr 2021 11:20:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org
Subject: Re: [PATCH 2/7] xen/gntdev,x86: Remove apply_to_page_range() use
 from module
Message-ID: <YHQQ7YsBbtXl0+Ml@hirez.programming.kicks-ass.net>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.635125063@infradead.org>
 <20210412082640.GB4372@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412082640.GB4372@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:26:40AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 12, 2021 at 10:00:14AM +0200, Peter Zijlstra wrote:
> > Instead of relying on apply_to_page_range() being available to
> > modules, move its use into core kernel code and export it's
> > application.
> 
> This doesn't exactly look great, but at least it contains the damage..

That was just about as far as I got...

> > NOTE: ideally we do: use_ptemod = !auto_translate_physmap &&
> > gnttab_map_avail_bits and remove this hack.
> 
> Given how much pain the !auto_translate_physmap case causes all over
> the kernel I wonder what a realistic timeline might be for dropping
> support for this case might be..

I've no experience with any of that; it looks absolutely disguisting,
all of it. I figured that's part of the Xen 'charm' :-)
