Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E08426CA3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhJHOTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJHOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:19:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9A5C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YCLCraNpJQopiImw5TcsXBoafdL7BcjfipkPlCfzlkg=; b=eRE5gRsvKuM1D1DasQG2Z7nq3S
        /u3YTf6hFL2Zju02FZ05H3bFRegRzqCjEP6Ed8daYVtcNqRud7SunJzVnxyL1EoJ6AfFVbCpqVDnf
        y4reX0allRGNPb2kH21tnsnRKU0jpMtOa/HkXAvK4hF3pw9WWWfERfGbBsSSd2IN4qJyqIcgq+pVt
        ll5hMrsD8xzmGDQ4AnAud5PtCPmcD81hiR7OyqF+NydWhHbmTk688WD2mFnZEk7AzyguFNYEGuN4P
        XuRAzTs8jvwu09qNqR6b+uvXERjNlDlduq9ZswjOI+l06v+0YeOGA79iZbZWpQrvX7HxYMIJsPgTZ
        2cKWJfhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYqgU-003ITa-Qn; Fri, 08 Oct 2021 14:17:17 +0000
Date:   Fri, 8 Oct 2021 15:17:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, anthony.yznaga@oracle.com
Subject: Re: [PATCH v2] mm: Optimise put_pages_list()
Message-ID: <YWBS6iJr/4RJ+hNE@casper.infradead.org>
References: <20211007192138.561673-1-willy@infradead.org>
 <20211007123109.6a49c7c625e414acf7546c89@linux-foundation.org>
 <YV9eueky+lBfSWA3@casper.infradead.org>
 <20211007163554.d9088a65f0e293e2bd906a56@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007163554.d9088a65f0e293e2bd906a56@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 04:35:54PM -0700, Andrew Morton wrote:
> On Thu, 7 Oct 2021 21:55:21 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > My first response is an appeal to authority -- release_pages() does
> > this same thing.  Only it takes an array, constructs a list and passes
> > that to put_unref_page_list().  So if that's slower (and lists _are_
> > slower than arrays), we should have a put_unref_page_array().
> 
> And put_unref_page_list() does two passes across the list!
> 
> <quietly sobs>
> 
> Here is my beautiful release_pages(), as disrtibuted in linux-2.5.33:

I think that looks much better!

> I guess the current version is some commentary on the aging process?

I blame the guy who sent cc59850ef940 to Linus back in 2011 ...

I think Anthony was going to look into this and perhaps revert us to
a pagevec_free() interface.
