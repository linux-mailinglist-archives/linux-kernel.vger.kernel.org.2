Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2740B3FCB08
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhHaPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhHaPsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:48:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C75C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 08:47:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2921721wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MJc3RpVbyMG8T0VfQf1H3doXXOiGLerg/UE1JIfxREM=;
        b=WIf4R/DWqUqmcItXnJu4pdhrxBk1bx1dEwvm6VitmDix+JMqEkRUE7v73QElBV6F57
         eecBv/Nu1lbTb82xP5wYUqUSHdmth3Cn4/UG38w9y+KDfOrtlGVTPVGmjus/q1exEt0g
         IcZGtGuFfP38Ak6wAxIV4sEnfOxQIod365+pdVTHlz47GuDyiTdjbE09Wb1bRjZ8n7fe
         cfz0Dk2bcx50asoGDjh2VfSwJOvJWa0BwvenaoP8C0SxN5v6qCmi16gYpcFs1zLRB5ys
         yZrO71hzjbzKWNz1QAoEIFsAulIuKgk0J+ozwzEXae4V1PTh4fTXs/q3WMukyZX5dR2W
         o5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MJc3RpVbyMG8T0VfQf1H3doXXOiGLerg/UE1JIfxREM=;
        b=UgqAW/AVOdFNlGSyMkTI2364dUx1QvqzM/QQHRop1IENNYo4ryYLP/FB7POwVgwNKp
         cVf95Z0jujg6L21/ip8HVlnlckrIlOKwMWeIrjpG/V+nJvD2sQsX8oR3BelrClKdV27v
         f1l1kw/66shRQ0+DTpid3fZ/Ll0Vr+yOBvlxuhaW8dZbWvGQWH0YRCio6mrtsSbXVH6s
         pUEWmxZzl0gKS3Y7O6hw11E+q1IFQy2jfNGa1F+ntUAxPhDgpkScSejeUoW59wTPL4PY
         ESuu1CScmEKezb4lsKJ3+ER82khXchjNKypSUWumQWeQg/nqtxXsloVNa6Fwsl0O1Vmw
         sngg==
X-Gm-Message-State: AOAM533XtIxWYMQKVCGQfHp3Q47fz1W7kEpsLFc3sBdc31XWAq91kxMM
        dXEzYA0umwYO1bDohyP0t5nlRw==
X-Google-Smtp-Source: ABdhPJwVwCzqBm9078cg5gCKPbY+Ow3G6ETI4jTg2xYqztpMNKJYy3ALiiH7FHrktnwVChEevD9sdg==
X-Received: by 2002:a05:600c:4048:: with SMTP id j8mr4774506wmm.173.1630424865576;
        Tue, 31 Aug 2021 08:47:45 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:3729:c12:7ee0:e9bc])
        by smtp.gmail.com with ESMTPSA id e13sm18179175wra.40.2021.08.31.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 08:47:44 -0700 (PDT)
Date:   Tue, 31 Aug 2021 17:47:37 +0200
From:   Marco Elver <elver@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        kernel test robot <oliver.sang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [mm] f9ce0be71d:
 BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page
Message-ID: <YS5PGac+2NTGFlwa@elver.google.com>
References: <20210826144157.GA26950@xsang-OptiPlex-9020>
 <20210827154232.rrpetqsh5xxklkej@box.shutemov.name>
 <20210831131313.GC31712@willie-the-truck>
 <CANpmjNOEstBLc9tbofcM=hfkYsmQFLBzq3i=L58fPpgg1vHgPw@mail.gmail.com>
 <20210831140749.GA31886@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831140749.GA31886@willie-the-truck>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 03:07PM +0100, Will Deacon wrote:
> On Tue, Aug 31, 2021 at 03:38:17PM +0200, Marco Elver wrote:
> > On Tue, 31 Aug 2021 at 15:13, Will Deacon <will@kernel.org> wrote:
> > > > > [  184.717904][ T1873] ==================================================================
> > > > > [  184.718938][ T1873] BUG: KCSAN: data-race in next_uptodate_page / unlock_page
> > > > > [  184.719828][ T1873]
> > > > > [  184.720103][ T1873] write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
> > > > > [  184.721024][ T1873]  unlock_page+0x102/0x1b0
> > > > > [  184.721533][ T1873]  filemap_map_pages+0x6c6/0x890
> > > > > [  184.722102][ T1873]  handle_mm_fault+0x179c/0x27f0
> > > > > [  184.722672][ T1873]  do_user_addr_fault+0x3fb/0x830
> > > > > [  184.723263][ T1873]  exc_page_fault+0xc3/0x1a0
> > > > > [  184.723845][ T1873]  asm_exc_page_fault+0x1e/0x30
> > > > > [  184.724427][ T1873]
> > > > > [  184.724720][ T1873] read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
> > > > > [  184.725575][ T1873]  next_uptodate_page+0x456/0x830
> > > > > [  184.726161][ T1873]  filemap_map_pages+0x728/0x890
> > > > > [  184.726747][ T1873]  handle_mm_fault+0x179c/0x27f0
> > > > > [  184.727332][ T1873]  do_user_addr_fault+0x3fb/0x830
> > > > > [  184.727905][ T1873]  exc_page_fault+0xc3/0x1a0
> > > > > [  184.728440][ T1873]  asm_exc_page_fault+0x1e/0x30
> > > > > [  184.729027][ T1873]
> > > > > [  184.729313][ T1873] Reported by Kernel Concurrency Sanitizer on:
> > > > > [  184.730019][ T1873] CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1
> > > > > [  184.731103][ T1873] ==================================================================
> > > >
> > > > Line annotation would be helpful.
[...]
> > Thoughts?
> 
> I wasn't complaining about the report! It's more that without line numbers
> we're struggling a bit to figure out where the race is. All the page-flag
> tests on the reader side should be using test_bit(), but the report above
> doesn't seem to think that the read is marked. Given your series adding
> CONFIG_KCSAN_PERMISSIVE and the fact that you try to triage these things, I
> thought maybe you've seen this before and might be able to point at the race
> (which is hopefully benign, but it's annoying when you can't spot it!).

Hmm, I was sure I could find it in either closed or still open syzbot
reports, but sadly I couldn't find anything. :-/

The next best thing was to take the same kernel version, same Clang
version, and same config in the hopes the generated functions of
interest are identical. If I take the report and symbolize it with what
I've built, I get:

| ==================================================================
| BUG: KCSAN: data-race in next_uptodate_page / unlock_page
|
| write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
|  instrument_atomic_write include/linux/instrumented.h:87 [inline]
|  clear_bit_unlock_is_negative_byte include/asm-generic/bitops/instrumented-lock.h:74 [inline]
|  unlock_page+0x102/0x1b0 mm/filemap.c:1465
|  filemap_map_pages+0x6c6/0x890 mm/filemap.c:3057
|  do_fault_around mm/memory.c:3904 [inline]
|  do_read_fault mm/memory.c:3918 [inline]
|  do_fault mm/memory.c:4051 [inline]
|  handle_pte_fault mm/memory.c:4302 [inline]
|  __handle_mm_fault mm/memory.c:4437 [inline]
|  handle_mm_fault+0x179c/0x27f0 mm/memory.c:4535
|  do_user_addr_fault+0x3fb/0x830 arch/x86/mm/fault.c:1393
|  handle_page_fault arch/x86/mm/fault.c:1450 [inline]
|  exc_page_fault+0xc3/0x1a0 arch/x86/mm/fault.c:1506
|  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:580
|
| read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
|  PagePoisoned include/linux/page-flags.h:204 [inline]
|  PageReadahead include/linux/page-flags.h:382 [inline]
|  next_uptodate_page+0x456/0x830 mm/filemap.c:2975
|  next_map_page mm/filemap.c:3010 [inline]
|  filemap_map_pages+0x728/0x890 mm/filemap.c:3066
|  do_fault_around mm/memory.c:3904 [inline]
|  do_read_fault mm/memory.c:3918 [inline]
|  do_fault mm/memory.c:4051 [inline]
|  handle_pte_fault mm/memory.c:4302 [inline]
|  __handle_mm_fault mm/memory.c:4437 [inline]
|  handle_mm_fault+0x179c/0x27f0 mm/memory.c:4535
|  do_user_addr_fault+0x3fb/0x830 arch/x86/mm/fault.c:1393
|  handle_page_fault arch/x86/mm/fault.c:1450 [inline]
|  exc_page_fault+0xc3/0x1a0 arch/x86/mm/fault.c:1506
|  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:580
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1
| ==================================================================

And looking at the preprocessed source, this makes sense, because
PageReadahead clearly includes a call to PagePoisoned with the given
config.

My guess is that the below patch would be appropriate here?

(LKP folks: I'd still like bots to enable CONFIG_KCSAN_PERMISSIVE=y,
 just to keep the volume of reports down for now.)

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 31 Aug 2021 17:27:27 +0200
Subject: [PATCH] mm: fix data race in PagePoisoned()

PagePoisoned() accesses page->flags which can be updated concurrently:

  | BUG: KCSAN: data-race in next_uptodate_page / unlock_page
  |
  | write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
  |  instrument_atomic_write           include/linux/instrumented.h:87 [inline]
  |  clear_bit_unlock_is_negative_byte include/asm-generic/bitops/instrumented-lock.h:74 [inline]
  |  unlock_page+0x102/0x1b0           mm/filemap.c:1465
  |  filemap_map_pages+0x6c6/0x890     mm/filemap.c:3057
  |  ...
  | read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
  |  PagePoisoned                   include/linux/page-flags.h:204 [inline]
  |  PageReadahead                  include/linux/page-flags.h:382 [inline]
  |  next_uptodate_page+0x456/0x830 mm/filemap.c:2975
  |  ...
  | CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1

To avoid the compiler tearing or otherwise optimizing the access, use
READ_ONCE() to access flags.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a68af80649a4..70bf0ec29ee3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -236,7 +236,7 @@ static __always_inline int PageCompound(struct page *page)
 #define	PAGE_POISON_PATTERN	-1l
 static inline int PagePoisoned(const struct page *page)
 {
-	return page->flags == PAGE_POISON_PATTERN;
+	return READ_ONCE(page->flags) == PAGE_POISON_PATTERN;
 }
 
 #ifdef CONFIG_DEBUG_VM
-- 
2.33.0.259.gc128427fd7-goog

