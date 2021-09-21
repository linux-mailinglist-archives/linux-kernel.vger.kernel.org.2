Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF241354B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhIUO3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhIUO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:29:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TjymtK4Uye3NIhYBiQcIsrxWTzAB+926rKoA7a0oIl4=; b=nJH/ZHUc056KnYDUhZ79RhbyLH
        9b9XF3BRAv73fmIPFatTDQN/Y3+AaF2XHCtLDbKzj6FbO2ov3tvsT+OdPk3/yHS6WxO4wIzW+3rlj
        DxZLVOH5Z5yM1Wor9ga6Hnwqtdulifue2U8D0QDs8X1A8fgMq3MzNBsgiXLNff+E7sKQIH+YpzcWd
        xL1DQpyfeIyWByjCxv9UAdajFUR4xdK6tT8AK4LrI5qv8Av+XvAmKLSVK9idzgSfBdXOX8bgQrCVL
        a/y6Kqv8wUzoxdRJ3BpG7Ely0F1WICsadHA6fbxSwfNP0l4hgKyluHmIN2JFr29DA4t/7tO7ttxwx
        s11nPe6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSgcQ-003s8S-WF; Tue, 21 Sep 2021 14:19:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B137C3000A9;
        Tue, 21 Sep 2021 16:19:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EA762019DA07; Tue, 21 Sep 2021 16:19:31 +0200 (CEST)
Date:   Tue, 21 Sep 2021 16:19:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     sxwjean@me.com, x86@kernel.org, linux-mm@kvack.org,
        Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Balbir Singh <sblbir@amazon.com>, Jens Axboe <axboe@kernel.dk>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Metzmacher <metze@samba.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Use generic code for virtual address of
 randomization of x86
Message-ID: <YUnp8wxRTPriAaD9@hirez.programming.kicks-ass.net>
References: <20210921110252.2593542-1-sxwjean@me.com>
 <4EB3D825-264D-447A-8C55-FA0CE8BC31F6@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EB3D825-264D-447A-8C55-FA0CE8BC31F6@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 06:24:07AM -0700, Kees Cook wrote:
> 
> 
> On September 21, 2021 4:02:50 AM PDT, sxwjean@me.com wrote:
> >From: Xiongwei Song <sxwjean@gmail.com>
> >
> >Hello,
> >
> >The two patches are to use generic code for randomization of virtual
> >address of x86. Since the basic code logic of x86 is same as generic
> >code, so no need to implement these functions on x86, please see the
> >details in comments of patch 2.
> 
> Hi!
> 
> The other patches do not seem to have arrived; I only see 0/2.

They were only sent to the list for some weird raisin. Operator error
perhaps.
