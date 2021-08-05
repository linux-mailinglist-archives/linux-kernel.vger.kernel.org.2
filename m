Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333ED3E17A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbhHEPKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhHEPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:10:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D0C061765;
        Thu,  5 Aug 2021 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eSJtsF6Jeti9fhWnHbLl2fELMn0F+2fN4MBTm3vWTW0=; b=MlcIUmoXpg52Stjx4LMJuW97mw
        C2qZUotjUrwxXQShT5OTm1MEIacvPBuJxY78NRoO/UUbmvLYE8ntiPRjgn8VPaXlQTYTFQbNIQ7Pr
        9xeBsNOuh1g8ha+eJgwu76QV/UpoeEAhDbFFBznTYi8u9PETyyAsLNc3amnANgMXarEBdpcZTJJw4
        Q0lghQDit4CRVN9CThoiSDTLPv2z2xs4f/sKCTBp5Hhjom9WncXuYqJaaEQ1YMETq48ssLN/w+897
        +NohM/qzPW7fnt5D3c9O1ABDUxbx45gq8QRChsNADCGukjTEnDXYxuolSgMosWTnsM61I1TiyJou4
        Td/0XmYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBf0d-0065gm-6d; Thu, 05 Aug 2021 15:10:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7B4830027B;
        Thu,  5 Aug 2021 17:10:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC1A4299CE2A6; Thu,  5 Aug 2021 17:10:08 +0200 (CEST)
Date:   Thu, 5 Aug 2021 17:10:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dbueso@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mete Polat <metepolat2000@gmail.com>,
        Jesper Nilsson <jesper@jni.nu>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] rbtree: remove unneeded explicit alignment in struct
 rb_node
Message-ID: <YQv/UGiAddAS1T77@hirez.programming.kicks-ass.net>
References: <20210805133213.700-1-lukas.bulwahn@gmail.com>
 <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
 <50ad4c8b848bd371b4b42959167ef03d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ad4c8b848bd371b4b42959167ef03d@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 08:02:28AM -0700, Davidlohr Bueso wrote:
> On 2021-08-05 07:02, Arnd Bergmann wrote:
> > The revert would appear to change the alignment to 16 bits instead
> > of 32 bits on m68k as well (not 8 bits as on cris), but I don't know if
> > that
> > can cause problems there.
> 
> Yeah I tried this a while back and it broke m68k, so it was a no go:
> 
> https://lore.kernel.org/lkml/CAMuHMdXeZvJ0X6Ah2CpLRoQJm+YhxAWBt-rUpxoyfOLTcHp+0g@mail.gmail.com/

I'm still thinking that any architecture that doesn't respect natural
alignment is playing with fire. For giggles we should put a runtime
alignment check in READ_ONCE() and see what goes *bang*.
