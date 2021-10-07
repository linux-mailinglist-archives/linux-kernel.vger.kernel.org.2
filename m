Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3105E425B8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhJGTdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 15:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232829AbhJGTdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2884B610A1;
        Thu,  7 Oct 2021 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633635070;
        bh=HhBYKDk4QK9bVPwS4vHzeRTACL3GE5kSGSANE9D2jDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f/VRG6xnT6Dq+L4jU0SQ/soGHSTlTjZ//IS9sLzBRv7xdr0ozOPlFIBw9M/vZWbM+
         pAhgoWYfnVvlAHsBV2jAgVgqygOx+u2pOsxO7bZ6k3wkVQf2EyH6ueGpmEg7DVcqCl
         8OggsvvlADcMDGz51XHBamkZfn3Q2oEsOUCurqmI=
Date:   Thu, 7 Oct 2021 12:31:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Optimise put_pages_list()
Message-Id: <20211007123109.6a49c7c625e414acf7546c89@linux-foundation.org>
In-Reply-To: <20211007192138.561673-1-willy@infradead.org>
References: <20211007192138.561673-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Oct 2021 20:21:37 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Instead of calling put_page() one page at a time, pop pages off
> the list if their refcount was too high and pass the remainder to
> put_unref_page_list().  This should be a speed improvement, but I have
> no measurements to support that.  Current callers do not care about
> performance, but I hope to add some which do.

Don't you think it would actually be slower to take an additional pass
across the list?  If the list is long enough to cause cache thrashing. 
Maybe it's faster for small lists.

