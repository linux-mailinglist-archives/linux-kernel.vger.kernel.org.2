Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3561143A453
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhJYUVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbhJYUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:21:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08494C0B18A5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=feiSu/V4M75PxXGyqNekfyG7331jHFrJV+X5N9qJi2U=; b=mfrmWqFYEO5Cc53hQGj5nf66Rf
        AiFAUaen0MEfEl37lAgmXxxLUYlc+Ux5/M814DgzzpY3XklmDgkQBR42DBT3Y+cDQ0X92QJzyyequ
        eRrce/W/2YkdQaAVQ827+O7s1ORPHiq10AoMtHkFkpvGWgorXxz2YUB1pA48jSPKOifGnFzLeVbv3
        43QMPCy9Cjoz7MtWqEyHUp07nIhMGn3P4GqJdgavdCue3f8RFTFTJuJPtKrkwxyY+/MunZVZt4rWn
        UXRXTenV4MzqCsxZmECbzHDhpjMEibVgmU80cjPmz+BWBG2EagBCL2TOFeN+hG1lmNotGXwgWjVc+
        qWI8u+Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf60S-00GO49-1g; Mon, 25 Oct 2021 19:52:32 +0000
Date:   Mon, 25 Oct 2021 20:51:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jordy Zomer <jordy@pwning.systems>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
Message-ID: <YXcKzKVX7NTAtvPh@casper.infradead.org>
References: <20211025181634.3889666-1-willy@infradead.org>
 <202110251225.D01841AE67@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110251225.D01841AE67@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:29:46PM -0700, Kees Cook wrote:
> On Mon, Oct 25, 2021 at 07:16:34PM +0100, Matthew Wilcox (Oracle) wrote:
> > Commit 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")
> > attempted to fix the problem of secretmem_users wrapping to zero and
> > allowing suspend once again.  Prevent secretmem_users from wrapping to
> > zero by forbidding new users if the number of users has wrapped from
> > positive to negative.  This stops a long way short of reaching the
> > necessary 4 billion users, so there's no need to be clever with special
> > anti-wrap types or checking the return value from atomic_inc().
> 
> I still prefer refcount_t here because it provides deterministic
> saturation, but the risk right now is so narrow ("don't hibernate"),
> I'm not going to fight for it. I think it'd be fine to use it initialized
> to 1, and have the removal check for == 0 as a failure state, which would
> deterministically cover the underflow case too.

I still think that's abusing the refcount_t pattern.  refcount_t should
be for ... reference counts.  Not these other things.
