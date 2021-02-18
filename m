Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D932F31E849
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhBRJkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBRI3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:29:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F7C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RfS/xwugVAB60Gpu5dsxGPU86f5MbDlTGh7bMRSZbIg=; b=G0+H8sGH+PJpyTg8/JqHpCkvZ0
        8YVmoBoWZ5ad6kYeBd/2nXAvNEpLK26sOCh4EnFTJGK4/wZCqccn32Y78TrXC6p1J4Z/DTSwFkpqI
        1HQcz1s7SJLfkwbW2nvgA6LYtFx2PHjUdjXiUr7QUUPjcjSGt9Gs9B3i0eYbCUxEROsn5ER5LKDC1
        fvqz5Ay06PXFiarsN4XIyPzXVLiIuxZkJDMSUPb00N4jQ3yEeAfrJZvGTsFCGlJrYADhj0zIStPB1
        bB0dp9PA+x0B7ZBYU+ngMHKR8GC+IMw0hT+GlgJtyc+zC750mcrGBrmvJzJtBE8J77uJkuECPtIy2
        mLPy21Ug==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCefj-001QaZ-2c; Thu, 18 Feb 2021 08:28:28 +0000
Date:   Thu, 18 Feb 2021 08:28:27 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 3/8] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Message-ID: <20210218082827.GA340059@infradead.org>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-4-namit@vmware.com>
 <20210218081624.GA337128@infradead.org>
 <29878BDA-1B02-4EAB-A7D3-5FEFCC73B2BE@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29878BDA-1B02-4EAB-A7D3-5FEFCC73B2BE@vmware.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:24:23AM +0000, Nadav Amit wrote:
> In general, thanks for the feedback (I will reply after I follow your
> feedback). I do have a general question - I thought it was decided that
> clarity should be preferred over following the 80-column limit. Please let
> me know if I misunderstood.

To quote the coding style document:

"The preferred limit on the length of a single line is 80 columns.

Statements longer than 80 columns should be broken into sensible chunks,
unless exceeding 80 columns significantly increases readability and does
not hide information."

While a lot of the decisions are subjective, just spilling over for no
good reason does not significantly improve readability in general.
