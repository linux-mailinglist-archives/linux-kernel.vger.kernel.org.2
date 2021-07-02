Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AB3B9A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbhGBBWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbhGBBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:22:08 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0A1C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 18:19:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GGHLB622kz9sRf;
        Fri,  2 Jul 2021 11:19:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1625188773; bh=VFIGdRKCJvgeACmd5nk9f13+KDVmVzSnIzMWi3Jxn5Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gB9eIdn/6nE0I+uBVLoKj33dhmVaovyTRAKENPRatU69jAGVxTVCJuswWca/qEVON
         oRUYMouHATU06xauQ2tULNKU3pVoMF6yiSpCgX8WcKo7rD73YQnUCbAEhOjcniSuhX
         YKYOwkf0KJ8i6gIxSSma2krd3Qw8FAi11oxNv8ZXdt5Q1ESro3vkTQ6XUbLboIXobi
         bGo6GEs3xHlB5jZAwOUHDBdbDIM67q5kxdxGXojPRxj9WnfNXCaiSgzbwUrETk/Icl
         vWxJaQr/Y5goDVresyV30FSPE8dddkPGQa24ZmN++tLkx2OHwg/uWdPMFbawJNZ1wj
         GmHfvvo/+oiqg==
Message-ID: <60a148d7c63510cbf31f3517dcb097c77d4ecd7c.camel@ozlabs.org>
Subject: Re: [PATCH v2] sched: Use BUG_ON
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Jul 2021 09:19:27 +0800
In-Reply-To: <20210701141130.940-1-wangborong@cdjrlc.com>
References: <20210701141130.940-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> The BUG_ON macro simplifies the if condition followed by BUG, so that
> we can use BUG_ON instead of if condition followed by BUG.

[...]

> -       if (spu_acquire(ctx))
> -               BUG();  /* a kernel thread never has signals pending */
> +       /* a kernel thread never has signals pending */
> +       BUG_ON(spu_acquire(ctx));

I'm not convinced that this is an improvement; you've combined the
acquire and the BUG into a single statement, and now it's no longer
clear what the comment applies to.

If you really wanted to use BUG_ON, something like this would be more
clear:

	rc = spu_acquire(ctx);
	/* a kernel thread never has signals pending */
	BUG_ON(rc);

but we don't have a suitable rc variable handy, so we'd need one of
those declared too. You could avoid that with:

	if (spu_acquire(ctx))
		BUG_ON(1); /* a kernel thread never has signals pending */

but wait: no need for the constant there, so this would be better:

	if (spu_acquire(ctx))
		BUG(); /* a kernel thread never has signals pending */

wait, what are we doing again?

To me, this is a bit of shuffling code around, for no real benefit.

Regards,


Jeremy

