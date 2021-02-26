Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541D32630A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhBZNBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhBZNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:01:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F32C06174A;
        Fri, 26 Feb 2021 05:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E1qg03c0wEH1kCwm5wPTWr/kyq0GtF85jeiLNtREXMs=; b=ApzP7RAGkaSc8CkybIYXx6AF20
        JnUr9mAz2jfz9WLfYOVXb4tyypH5D6uljEkt8Lo8+PCPwhlXhRD8h/erwo3LYC0xHdDgaX81Z59om
        o0EGVOdUdGmZgKaHrAfXRRAC+qBw7Sga8xaZ4NvZw3pKtoNZks/RE0jgxJzoKmoi0EkF0EuoiXc3V
        geu9HSi18UBVgLUxXa6l2SxAVkJ/BWQT2YldfhI0c9afXCyfEPl02PiUwF1bxZaQoFGwEbYDXSZD7
        mSRzPxnA+pQM1NbQb4BwGT8nmt+sIemSRVjEEofT2/kcBOndKF0PDT5DoRm2rpp8FZKn22jSC1j6w
        H24Yq20A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFcjN-00C1lT-Fa; Fri, 26 Feb 2021 13:00:32 +0000
Date:   Fri, 26 Feb 2021 13:00:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ia64: Depend on non-static printk for cmpxchg debug
Message-ID: <20210226130029.GC2723601@casper.infradead.org>
References: <YCflN5zTvo5mxvKY@chrisdown.name>
 <YDjt/lI82VzZcCgq@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDjt/lI82VzZcCgq@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:47:58PM +0000, Chris Down wrote:
> >    ./include/linux/printk.h:219:5: error: static declaration of 'printk' follows non-static declaration
> >    219 | int printk(const char *s, ...)
> > 	|     ^~~~~~
> >    ./arch/ia64/include/uapi/asm/cmpxchg.h:142:14: note: previous declaration of 'printk' was here
> >    142 |   extern int printk(const char *fmt, ...);  \
> > 	|              ^~~~~~
> > 
> > Make CONFIG_IA64_DEBUG_CMPXCHG dependent on CONFIG_PRINTK to avoid this.

Why not just fix it?

diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
index 5d90307fd6e0..d955a8e3ebde 100644
--- a/arch/ia64/include/uapi/asm/cmpxchg.h
+++ b/arch/ia64/include/uapi/asm/cmpxchg.h
@@ -139,7 +139,7 @@ extern long ia64_cmpxchg_called_with_bad_pointer(void);
 do {									\
 	if (_cmpxchg_bugcheck_count-- <= 0) {				\
 		void *ip;						\
-		extern int printk(const char *fmt, ...);		\
+		int printk(const char *fmt, ...);			\
 		ip = (void *) ia64_getreg(_IA64_REG_IP);		\
 		printk("CMPXCHG_BUGCHECK: stuck at %p on word %p\n", ip, (v));\
 		break;							\
