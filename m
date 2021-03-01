Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83685329F3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573515AbhCBDXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbhCAU1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:27:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C36C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 12:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DvWGgpKtXTOvADzPXHriNsep/KrNhQRbYsqcSSnqiWA=; b=H8fTjyuEpILjyyECXnGLFnF0vf
        pJAnpav9KcLAdaqDQ5x6/JdLogJqwCBnRoEeOLW9sK63aFlS6JDsoFdNJGlZVzS7XiKaUouMro8vB
        4azhBWdbODada/n/EG8SCMW4el7x78lxG+0EFemCZ1iwJynojdxMGd+HAG+rmY2CBUUbOvFc5KmKE
        udalKg+pT4egJCnG5fQSgP9r/6DLmvWQ25BQpoU2y1V6bA3P79eK2pL4YhphP5q39kknMUK7FQcVU
        AZaSe4B1cUDxjAx2oeK6F3lBPEUWr3BFy28amEXG2I+fBGXsEUWxI3f46ILKpsC0SLyyPz9PbkcRc
        X9UhPYog==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGp7S-00GBhb-HS; Mon, 01 Mar 2021 20:26:23 +0000
Date:   Mon, 1 Mar 2021 20:26:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        vbabka@suse.cz, guro@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v2 3/3] mm: use PF_ONLY_HEAD for PG_active and
 PG_unevictable
Message-ID: <20210301202618.GT2723601@casper.infradead.org>
References: <20210224084807.2179942-1-yuzhao@google.com>
 <20210226091718.2927291-1-yuzhao@google.com>
 <20210226091718.2927291-4-yuzhao@google.com>
 <20210226121314.GB2723601@casper.infradead.org>
 <20210301115007.mgw5vthgjoibnjf4@box>
 <YD1HgmERg3/LuApe@google.com>
 <alpine.LSU.2.11.2103011215260.4616@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103011215260.4616@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 12:16:19PM -0800, Hugh Dickins wrote:
> On Mon, 1 Mar 2021, Yu Zhao wrote:
> > On Mon, Mar 01, 2021 at 02:50:07PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Feb 26, 2021 at 12:13:14PM +0000, Matthew Wilcox wrote:
> > > > On Fri, Feb 26, 2021 at 02:17:18AM -0700, Yu Zhao wrote:
> > > > > All places but one test, set or clear PG_active and PG_unevictable on
> > > > > small or head pages. Use compound_head() explicitly for that singleton
> > > > > so the rest can rid of redundant compound_head().
> > > > 
> > > > How do you know it's only one place?  I really wish you'd work with me
> > > > on folios.  They make the compiler prove that it's not a tail page.
> > > 
> > > +1 to this.
> > > 
> > > The problem with compound_head() is systemic and ad-hoc solution to few
> > > page flags will only complicate the picture.
> > 
> > Well, I call it an incremental improvement, and how exactly does it
> > complicate the picture?
> > 
> > I see your point: you prefer a complete replacement. But my point is
> > not about the preference; it's about presenting an option: I'm not
> > saying we have to go with this series; I'm saying if you don't want
> > to wait, here is something quick but not perfect.
> 
> +1 to this.

page folios are here and ready to go.  I'm doing another pass on them,
quantifying the improvements to text with each patch.  So far I'm
at 4357 bytes of text saved, in the first 10 patches (many of which
look as if they're not going to produce any savings).

Yu Zhao's patches seem risky.  The only way to know if any places have
been missed is by enabling CONFIG_DEBUG_VM_PGFLAGS, which we do not
recommend for production environments.

