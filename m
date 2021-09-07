Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C61E40307C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbhIGV4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhIGV4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:56:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198FDC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 14:55:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631051740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4fv1aRgNP8PLL+WCds8qrwRs6Cs3q9c45kxTu9XL9U=;
        b=SN24QaiPzWzK+YlKf/P97WNFQBxFrxlttclQxbvvDtulbe956KqBZ3JwKXW0YbyDHbMPJZ
        IGgIpxanlgChJJApe/6VLo94Z5ZGRtdhl1IvtWnS1s0yOwasSwbSb6PbmGbJsA5xcTQd7+
        0TjofF6+r/q0eA/twhsKHGNZBnxqwzg6BS6VBTYiwtSdEzzRypyKbh0Zuz+75NIu3J92Ru
        KAZJgmoGaIzVuu2QHnHELrWq86r7i4RK1k9rFHGLacK2dD+pITNH+AzuMNpndd5yoFg0MM
        yDpUkrSGnjFaXpbyVCCOpWTKCHtrDvH9TqBpK2gagaNKu4v0ucojWkubo6phXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631051740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4fv1aRgNP8PLL+WCds8qrwRs6Cs3q9c45kxTu9XL9U=;
        b=vKszKdG5pmG1/JhgIIf4wKsm3KyiHBd/Mw6BlUiDnr/n+douNpOOlfgWqfziJ2DOEQjpqJ
        dhOav+FsBXwcOTCw==
To:     "Luck, Tony" <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: RE: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
In-Reply-To: <a883fe85b6b941b9bff44bc4b268bba1@intel.com>
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
 <874kaw9mpo.ffs@tglx> <e190b62e3f954cc1804a41149a842641@intel.com>
 <871r609m2i.ffs@tglx> <a883fe85b6b941b9bff44bc4b268bba1@intel.com>
Date:   Tue, 07 Sep 2021 23:55:40 +0200
Message-ID: <87v93c82zn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2021 at 21:13, Tony Luck wrote:

>>> Was it just the email post that was bad? I.e. are the patches in:
>>>
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu
>>>
>>> ok?  I just compiled that, should I boot it, or wait?
>>
>> Just the mail script went south. The git tree is fine.
>
> What else is in that tree?  My kernel doesn't boot (fails to find root filesystem device).
> Same .config boots Linus latest (HEAD= 0bcfe68b876 Revert "memcg: enable accounting for pollfd and select bits arrays")

Huch? That tree is based on 0bcfe68b876 and it just has those 20 patches
on top which should not at all interfere with your root filesystem
device. Let me verify.

Thanks,

        tglx
