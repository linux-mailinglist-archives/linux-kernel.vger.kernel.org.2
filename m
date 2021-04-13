Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779FD35D848
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbhDMGzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbhDMGzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:55:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C49C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rl7Av8z9Mb3AhGc2I2b/HfzYNKQlfkZtLSkmthxZ3Cs=; b=oXena5QrQsAuq/lXovE/vdznzG
        Zbnw2r9xxmldDA6+M9jB/+SFl853WgrhtbLlh7a+sWTsFgAEDytibwY8ygQJwRnj44+OSwPpQlAhB
        wLRDFznR8fpfuV7KYpgr20R93SPHj7ah/oFpN2O8fWd8+1X/hZLFDqIeNR6S1wQ1+//pSsxqJHO2C
        /+gfU1cAMp8iuXFAPdisVwcT0QDxckiECBBoWtjD94zP99pTR2jiaQ/lYsHrb20tTQAjHatpWRBIv
        xBgjcCOkLTBJf8PSKJz8TiitpXrQuOEwgajMbT2zHmaZZfcRqAhkJXL+cqsZRJoZv3X9nSV+A9o1R
        eVq7xOXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWCwU-008RVy-9U; Tue, 13 Apr 2021 06:54:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E7E2C300036;
        Tue, 13 Apr 2021 08:54:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8DCC2C4B2093; Tue, 13 Apr 2021 08:54:33 +0200 (CEST)
Date:   Tue, 13 Apr 2021 08:54:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 6/7] i915: Convert to verify_page_range()
Message-ID: <YHVAKeYh04y5w7ia@hirez.programming.kicks-ass.net>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.902470568@infradead.org>
 <202104121306.3A73BEB0A5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104121306.3A73BEB0A5@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 01:08:38PM -0700, Kees Cook wrote:
> On Mon, Apr 12, 2021 at 10:00:18AM +0200, Peter Zijlstra wrote:
> > @@ -1249,14 +1249,14 @@ static int check_absent_pte(pte_t *pte,
> >  
> >  static int check_present(unsigned long addr, unsigned long len)
> >  {
> > -	return apply_to_page_range(current->mm, addr, len,
> > -				   check_present_pte, (void *)addr);
> > +	return verify_page_range(current->mm, addr, len,
> > +				 check_present_pte, (void *)addr);
> 
> For example, switch to returning bad addr through verify_page_range(),
> or have a by-reference value, etc:
> 
> 	unsigned long failed;
> 
> 	failed = verify_page_range(current->mm< addr, len, check_present_pte);
> 	if (failed) {
>   		pr_err("missing PTE:%lx\n",
>   		       (addr - failed) >> PAGE_SHIFT);

OK, lemme try that.
