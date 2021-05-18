Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F85838822E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352334AbhERVgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244028AbhERVgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:36:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC553C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mgp8VIxRG3WR01A5wXzYm9aqAFHvu+NrxQhHQf3pQXA=; b=FCpC8gTKwh4qTrv8AtyZqv8Pfj
        69zVY3VeTFVQejhk+DWiDINdL3N3cvvZny8Nx0Kli0gfaKsExw9bvRxgpwPr/Ckf0eeESh/0sibRl
        ilO6VMrFuDIay7vBTYNbyNwe+QXh4CBFNmr044dbZTXeZ9uB73JzudZPJ8vJgXJdN5DHhRgJsiBpR
        fqKZDIMagu3IpYMFCcLvSQzkZFS0l01o2n1KZzpK7bbqvCyX7L51mepkVLVmKNq1hW9htDgCFGDLD
        6hqrr+m/gYd3u135eT5IpTXP2E8wXV6xST6AZSOTmaMY0pUGMAqMxn5/0x0bwVhkcQSXWqK9FqbCo
        gszftbKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lj7MX-00EMrX-Bd; Tue, 18 May 2021 21:34:51 +0000
Date:   Tue, 18 May 2021 22:34:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm/swap: simplify the code of find_get_incore_page()
Message-ID: <YKQy+fMIxQVTSjaW@casper.infradead.org>
References: <20210518135352.3705306-1-linmiaohe@huawei.com>
 <20210518135352.3705306-6-linmiaohe@huawei.com>
 <YKPQUjjdC3mP5f/P@casper.infradead.org>
 <20210518141304.c09cd8762e3f3d16a722444c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518141304.c09cd8762e3f3d16a722444c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 02:13:04PM -0700, Andrew Morton wrote:
> On Tue, 18 May 2021 15:33:54 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, May 18, 2021 at 09:53:52PM +0800, Miaohe Lin wrote:
> > > pagecache_get_page() can do find_subpage() for us if we do not specify
> > > FGP_HEAD. No functional change intended.
> > 
> > Please, no.  This interferes with the folio work.
> 
> In what way?  Can't the folio patches simply revert this or suitably
> alter it?

Of course, it's just software.  Anything can just be modified.  I don't
see the point of putting in a cleanup patch that creates a conflict with
important work.
