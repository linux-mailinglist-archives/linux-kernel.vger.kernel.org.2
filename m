Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137A03A10C6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhFIKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhFIKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:01:34 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47562C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 02:59:40 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c11so30906649ljd.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VU9NxlTxI6RSkxw6tvgV5z3t/ysaeFQxXfksToOwW18=;
        b=XdlwuXVIHAqyX/dYnfnFhPrOEtblNWpTNalxKuzxbtmlQla8K1FKw1xGx0KUCSsjyM
         LHEcJfxueEq74pMSguJ/gwmu0qKeuwQEH0wt6omaYGb+bhZzGBliVhqqYFmV5WRwRMBW
         WQ/KGuEMPwerlHG84QzM3QN5rS3ttjTHB/NjPbdGcAaZ/Qxd+/royNrzU3nL1dJPqwB7
         T0Zh37PWLQhPQAmKAnMRWvTqJghMSdZjw9Ttq1etJtDNFkfNAT+qGBw1jHRIVDr2y22L
         tuhTZsFI7K4tz+Kn0LnjeDJXpjckNQgMFUQVOllIXD7EQhh7OAoQjyJLTaEU8rNuIrRQ
         O+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VU9NxlTxI6RSkxw6tvgV5z3t/ysaeFQxXfksToOwW18=;
        b=CivOCq9ZkxCtxz+VvMcz80MAsvZUz3Fj4GUAelAEuYNXJo/AStLMF8zQfvcLD1Mr7h
         wvZ0OlodKzBWA24u5YlBgYnmM/DGwkszbMjxYiE8fszpr76+Ogaga/HF1kjm2l1ZFTz5
         fS7Vh5VX1Fa0fyaEA5cFDNKk5RnWB2pbFKmO4fio1DnwYOmdhyQVTc7P+cZtAYuwv7ni
         fuK/dk+n2f2phQzWMKjR9GurcTz/wZNss6oa1MwyydDZttZ98W/5U7vy5uYannYSb/C/
         AP8hOr0vBVbSGk4NPs72hAKaTtSzKqFd4sfshbi5mJBPx1wkOuCc1pGv7E8zdcpEWnsu
         mcWA==
X-Gm-Message-State: AOAM531R4RllN2MrmEXngcoPcaHJ1GWrm1z0ICijOkF72nDinmHwiMCy
        rZxFCuWemM54s83+RG3lMIBtzQ==
X-Google-Smtp-Source: ABdhPJyZlcIBRL9d2yZNMHgch7D5QXLPUMMCWP1eM7YcWmV2MH+NwuLvc79yy9egtcqUx0T7Ajalgw==
X-Received: by 2002:a2e:a16e:: with SMTP id u14mr20973564ljl.343.1623232778569;
        Wed, 09 Jun 2021 02:59:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a22sm272105ljm.13.2021.06.09.02.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 02:59:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 136C410265B; Wed,  9 Jun 2021 12:59:53 +0300 (+03)
Date:   Wed, 9 Jun 2021 12:59:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xu Yu <xuyu@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hughd@google.com,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
Subject: Re: [PATCH v2] mm, thp: use head page in __migration_entry_wait
Message-ID: <20210609095953.s6bgfjnwkwvjhfo3@box.shutemov.name>
References: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
 <20210608120026.ugfh72ydjeba44bo@box.shutemov.name>
 <YL9jVYgWYBydOYst@casper.infradead.org>
 <20210608125838.6ixdlz3t334gjnp7@box.shutemov.name>
 <YL9yG/zXqSu+U47y@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9yG/zXqSu+U47y@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 02:35:23PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 08, 2021 at 03:58:38PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Jun 08, 2021 at 01:32:21PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jun 08, 2021 at 03:00:26PM +0300, Kirill A. Shutemov wrote:
> > > > But there's one quirk: if split succeed we effectively wait on wrong
> > > > page to be unlocked. And it may take indefinite time if split_huge_page()
> > > > was called on the head page.
> > > 
> > > Hardly indefinite time ... callers of split_huge_page_to_list() usually
> > > unlock the page soon after.  Actually, I can't find one that doesn't call
> > > unlock_page() within a few lines of calling split_huge_page_to_list().
> > 
> > I didn't check all callers, but it's not guaranteed by the interface and
> > it's not hard to imagine a future situation when a page got split on the
> > way to IO and kept locked until IO is complete.
> 
> I would say that can't happen.  Pages are locked when added to the page
> cache and are !Uptodate.  You can't put a PTE in a process page table
> until it's Uptodate, and once it's Uptodate, the page is unlocked.  So
> any subsequent locks are transient, and not for the purposes of IO
> (writebacks only take the page lock transiently).

Documentation/filesystems/locking.rst:

	Note, if the filesystem needs the page to be locked during writeout, that
	is ok, too, the page is allowed to be unlocked at any point in time
	between the calls to set_page_writeback() and end_page_writeback().

I probably misinterpret what is written here. I know very little about
writeback path.

> > The wake up shouldn't have much overhead as in most cases split going to
> > be called on the head page.
> 
> I'm not convinced about that.  We go out of our way to not wake up pages
> (eg PageWaiters), and we've had some impressively long lists in the past
> (which is why we now have the bookmarks).

Maybe we should be smarter on when to wake up, I donno.

I just notice that with the change we have /potential/ to wait long time
on the wrong page to be unlocked. split_huge_page() interface doesn't
enforce that the page gets split soon after split is complete.

-- 
 Kirill A. Shutemov
