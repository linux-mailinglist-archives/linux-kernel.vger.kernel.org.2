Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC3A37350C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 08:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhEEGr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 02:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhEEGr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 02:47:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ACAC061574;
        Tue,  4 May 2021 23:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wdfE8HD3DQ5c0KXK23VL9XKreqvNmN2d0ptpwD2Z47s=; b=GSRFi2XZnQoaBPi4P6SgL8Hr00
        L6WJjO7Sa6z/LZqCRnr3V/IEIzzzi3G/pKybnYNpJGooWIE0S1X5f+2zL8ycYF82Y4xk1CXn5A1Nx
        uQE/pPcxBi1NsIyr1qZPL5tDEMfMDXY1srlEgdywsUmvc1wKOxSSL2LoWGBviS3VxbtABQwXaf/JK
        BsNaS8k2rHlU1soaIyATgQNBOlqMdvaG1U2sC5gT3hEnDBowLr5DbVVPqodP0FTua+NSIZSKfChaG
        qK4lDu5WmUhH88SizOVl2odxeK9oyE84WvxdIGNOUTNNjy0RGISVbXvRVJ4/8ApjlzeF1WDg9RJU1
        sasJ09VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leBIb-000NAm-UN; Wed, 05 May 2021 06:46:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 867C23001CD;
        Wed,  5 May 2021 08:46:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23282234E713A; Wed,  5 May 2021 08:46:19 +0200 (CEST)
Date:   Wed, 5 May 2021 08:46:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class
 checking
Message-ID: <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
References: <20210505033945.1282851-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505033945.1282851-1-ak@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 08:39:45PM -0700, Andi Kleen wrote:
> From: Andi Kleen <andi@firstfloor.org>
> 
> The scheduler initialization code checks that the scheduling
> classes are consecutive in memory by comparing the end
> addresses with the next address.
> 
> Technically in ISO C comparing symbol addresseses outside different objects
> is undefined. With LTO gcc 10 tries to exploits this and creates an
> unconditional BUG_ON in the scheduler initialization, resulting
> in a boot hang.
> 
> Use RELOC_HIDE to make this work. This hides the symbols from gcc,
> so the optimizer won't make these assumption. I also split
> the BUG_ONs in multiple.

Urgh, that insanity again :/ Can't we pretty please get a GCC flag to
disable that?
