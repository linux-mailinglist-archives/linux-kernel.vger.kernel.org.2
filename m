Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4753ABD31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhFQT7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFQT7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:59:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76204C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BPwCBaM2/rXap2bK8yH+/+88XwXW6S6pZJPqaJg7YAk=; b=hg8S7OiTDHQGGkZyhWRzI5ChBo
        QernoMDwF0ezvcw1n7+6xa5DlyFUCy/5u8rMKjbrdi+5WPVSDEowii9wpp46u+JLMiKaiIG1GJEi7
        cYFaw318ltqw+hmlmCiqtRSptC/LSnDIU7Q84cH6KqVb8t0VVeDETHgdUUWcJ9tjik0f2p4Jv3/pL
        k8siuykHzK9vQKI37WeErhPHkb0NaThoZhbq8UG89VWz2hCD2ndQ/Q8TH7jRbui+3Wi4PTaCj4efv
        j50EBh4zTLXcDRX+iopx8x9Ka0fPUHKY33Z4hq0CgEqIjYdRmzD2H44d1AIdK1uLWHHHRWzwavDja
        ua6oIkkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lty7j-009WLs-8T; Thu, 17 Jun 2021 19:56:27 +0000
Date:   Thu, 17 Jun 2021 20:56:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] percpu: optimize locking in pcpu_balance_workfn()
Message-ID: <YMuo55c9QM91pc9p@casper.infradead.org>
References: <20210617190322.3636731-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617190322.3636731-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 12:03:22PM -0700, Roman Gushchin wrote:
> +++ b/mm/percpu.c
> @@ -1980,6 +1980,9 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
>   * If empty_only is %false, reclaim all fully free chunks regardless of the
>   * number of populated pages.  Otherwise, only reclaim chunks that have no
>   * populated pages.
> + *
> + * CONTEXT:
> + * pcpu_lock (can be dropped temporarily)
>   */

What's the shouting all about?  I would write it like this:

 * Context: Process context.  Caller must hold pcpu_lock with interrupts
 * disabled.  This function may drop the lock and re-enable interrupts if
 * it needs to sleep, but will return with the lock held and interrupts
 * disabled.

