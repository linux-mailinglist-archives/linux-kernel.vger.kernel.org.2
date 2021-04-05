Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692D13546B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhDEST0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhDESTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:19:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3107C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4dAj4hbKO4o0Nvf/Cfrivun8zn0T3Dz0SUzA27d7JhI=; b=HXwRjnV7dgC5kgsmOPwpACzNbC
        DQTxl3HgSgxd29GQrJcqgV9D38jJ7IcR6m+N8EYGiKIhy4DkFCRJi3TAHZwERDMwHt+buH2FdDapX
        +nJZhV9Fl+N29OWPDI7cMtIeXKRNCo9oTkiP7jEjXV4mYN1wMSTYZWGYGC30cbP2/j3HWdDqAmnE2
        SjfIzjvf3QN88o+W+gl2pncVH96ejZkSrVdYV8dEQgoOWqBhBuepZzRnIQdHYd9ydBZUqmzvUJKPu
        van7sTTbSJ4yY/sGcu6xRxr7dFdrz8+Qg1KLpyDQO4Uy08f04YXJvKkFH19ShxQ7KWTwNB75TlRIL
        +KDqLWHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTToQ-00Bj7Y-Ar; Mon, 05 Apr 2021 18:19:01 +0000
Date:   Mon, 5 Apr 2021 19:18:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: move page_rmapping() and page_anon_vma() to
 mm/internal.h
Message-ID: <20210405181858.GJ2531743@casper.infradead.org>
References: <20210405151355.9867-1-rppt@kernel.org>
 <20210405151355.9867-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405151355.9867-2-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 06:13:54PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The functions page_rmapping() and page_anon_vma() are not used outside core
> mm. Move their declaration from include/linux/mm.h to mm/internal.h
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

This has purely textual conflicts with the folio series, but no conceptual
conflicts.  I generally approve of moving things out of mm.h, so

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
