Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BACE3D7078
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhG0HiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:38:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37102 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbhG0HiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:38:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8E504200D1;
        Tue, 27 Jul 2021 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627371498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CgiQRPkDgLjaPWkkjWQpseQ0PaT2bHgPDPuLTNdvcZ8=;
        b=uoReRIZUx4hStU4yP+HIwVJqPmCi8Wy9QHFnl2p7YKynQ57E3YIohNFhSwOJgPflH8I6dQ
        eshxuWXXQp3VmvZTMgMiqdWvs45ugrSCBrNQyOCV58K/CCtdujjdCwLOCQ5MkbeNKQ0Hqy
        B8JkHsK3USoS3Ws4ZxO3s1gNHZPhYm4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5CFA4A3B85;
        Tue, 27 Jul 2021 07:38:18 +0000 (UTC)
Date:   Tue, 27 Jul 2021 09:38:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Qualys Security Advisory <qsa@qualys.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Make kvmalloc refuse to allocate more than 2GB
Message-ID: <YP+36aMegQBja/aC@dhcp22.suse.cz>
References: <20210721184131.2264356-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721184131.2264356-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-07-21 19:41:31, Matthew Wilcox wrote:
> It's generally dangerous to allocate such large quantities of memory
> within the kernel owing to our propensity to use 'int' to represent
> a length.  If somebody really needs it, we can add a kvmalloc_large()
> later, but let's default to "You can't allocate that much memory".

I do agree that limiting kvmalloc allocation size is a reasonable thing
to do but I do not really see why we should remove the check from
seq_buf_alloc. Implicitly relying on kvmalloc to workaround a bug that
was in seq_buf code seems like a step backwards to me.
-- 
Michal Hocko
SUSE Labs
