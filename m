Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF4C37B6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhELHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhELHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:31:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B42FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dotmu/QQ+HSHFf8dmCyDhgb3EWqVCx+Cik6AJBFesrg=; b=Cy3J6pdeklfrGpq34nZh/j30Fj
        hD5LBsBdpxhp9Wte0rETfUf0YCzRWfUxWNLHN4cxp9crs9GP2MZqOXFfomXlBDfIQDKwYjQjVS7Cw
        4PAxaXEbIoqYyz4mXGr/bhr1I5aP774E/siHhHfQ679KMltF73JCMbElxcW1GWffVCuPp05ibJs/1
        MtOtMZzBOCISdwyc1cQJHwerG+w9LDf7sjhvLO9Zkm09uJ9aHlQ+90LXk6kqFuqX2Nkvl/svwgLXj
        H7jnESS8pD1azMGdFGdrJ9sivfdMj1B4ZrRkQll+I9zhRoVIAxqs6G29fzen4GMZGzuisAg29kY91
        55rTr7xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgjIj-002FVP-Rz; Wed, 12 May 2021 07:29:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35E8A3001E1;
        Wed, 12 May 2021 09:28:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11A7520237F69; Wed, 12 May 2021 09:28:54 +0200 (CEST)
Date:   Wed, 12 May 2021 09:28:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Brian Cain <bcain@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 00/33] locking/atomic: convert all architectures to
 ARCH_ATOMIC
Message-ID: <YJuDtid8/IrajZ5T@hirez.programming.kicks-ass.net>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <CAK8P3a0pO=Jqbd503Kx-H_S1AzikcPjHT5=40ACZuxSF3dUFNQ@mail.gmail.com>
 <20210511092701.GB6152@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511092701.GB6152@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 10:27:01AM +0100, Mark Rutland wrote:
> > I'm happy to put this into the asm-generic tree once you have
> > collected enough Acks.
> 
> Great! Going via asm-generic sounds good to me. The kbuild test robot
> has found a few issues, so I'll probably have a v2 with those fixed and
> some acks accumulated.
> 
> Peter, does that make sense to you, or did you have reasons to want this
> to go via tip?

I was expecting this to to through tip/locking/core, and I think I
briefly talked to arnd about that on IRC, but whatever works I suppose.
