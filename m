Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CA3B5B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhF1JZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhF1JZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:25:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29B9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=31rJk3sm8vQTlY7chBzGE5Fu98PGj3cHQHUz4LEqPFI=; b=VLYbBS7fOKlu/aqFAHwKNlkp1M
        OPr22KtMzyT5sB36Z6Np0RqumhLALlOCoMgftXnM1JuSLgf5/8tzf3GsuXLssrG99kqiFfQMF366c
        nxpMw0z9HpciSTVESiLgaAZbv8xG4m4/f4JHoIrtqUMju0Zfsh4ZsuOGRJMgD2WI4TjcoGeSaw8AV
        MtmbSRr9TICxPnfzukRo42LpVkYwA9SBKCG1INM4CZkx8UlnGeYGBdbd5uMylcoFFo/f+xUZKyGay
        ldoM0sGkOGnJ5olxlfXTThwiDBG1QKNFBWe+dsRGj1eoCT2KVk/CRRyCNpa84y13XWRefzt3O8A1H
        BawXjSXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxnTD-00CWD7-KY; Mon, 28 Jun 2021 09:22:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FA2B300242;
        Mon, 28 Jun 2021 11:22:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1F4F20424B47; Mon, 28 Jun 2021 11:22:20 +0200 (CEST)
Date:   Mon, 28 Jun 2021 11:22:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liu, Yujie" <yujie.liu@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: Re: [LKP] Re: [jump_label, x86]  e7bf1ba97a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <YNmUzDjX6sECp37P@hirez.programming.kicks-ass.net>
References: <20210623022826.GA20282@xsang-OptiPlex-9020>
 <YNLtSKUtqxqPxmGP@hirez.programming.kicks-ass.net>
 <SJ0PR11MB5598608507B7EB38983113BCFB079@SJ0PR11MB5598.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5598608507B7EB38983113BCFB079@SJ0PR11MB5598.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 06:32:25AM +0000, Liu, Yujie wrote:
> > > [  222.094341] BUG: unable to handle page fault for address:
> > > ffffffff83ccffe0
> > 
> > I *think* the below might help, can you try?
> 
> Hi Peter Z,
> 
> We try to apply the patch on commit e7bf1ba97afdd (jump_label, x86: Emit short JMP)
> A new BUG appeared before reaching the BUG reported in previous mail.
> Full dmesg in attachment.

> > @@ -555,6 +558,7 @@ static int __jump_label_mod_text_reserved(void *start, void *end)
> >  	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
> >  	if (!try_module_get(mod))
> >  		mod = NULL;
> > +	init = mod->state == MODULE_STATE_COMING;
> >  	preempt_enable();
> > 
> >  	if (!mod)

*groan*, I'm an idiot... There's an obvious NULL pointer deref right
there.

Let me try locally first before I send yet another dud.
