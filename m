Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064163FF8AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 03:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347018AbhICBo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhICBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 21:44:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB33C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=thtGYqZ0DakkE8JK0/MwinDZlqRB0FWqqYnSaIBuUWI=; b=Af8YOyBQTqHQdOVI4oDU63HHVB
        Tou7+9iVzE2V4PwtBA4/uNfouZvI6LpHKIJeBXnk/N+FLyfI0oBxSKFPJNBmp7+2ozg/trGlTlqaI
        9Mza0WWqFpxZ0tbrLPdCNzqAPMxmLXs1RecLno1pyX89i6ep1Y/pwDrjMTvEtx1KEbJzDwmLIj/IF
        UcXG2fUkyBFzLXulLJflnytQPRWD5VNX4lePXMmwVP+rWDpOdwr6HgzrGcFvKnjQKul0u1Gi3MeZb
        xOpqMx5tglBsTY/meHMtUJnsB6aTPKnjMAUPESxFEDhpjiL/mlFjMGg41SH0mNWUhYfmg0PPWo4cH
        3/QR15+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLyE0-0042jW-BY; Fri, 03 Sep 2021 01:43:00 +0000
Date:   Fri, 3 Sep 2021 02:42:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mmap_lock: Change trace and locking order
Message-ID: <YTF9jE+GXId/tp0o@casper.infradead.org>
References: <20210903013521.1802774-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903013521.1802774-1-Liam.Howlett@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 01:35:31AM +0000, Liam Howlett wrote:
> Print to the trace log before releasing the lock to avoid racing with
> other trace log printers of the same lock type.

Aren't you missing mmap_read_unlock_non_owner()?
