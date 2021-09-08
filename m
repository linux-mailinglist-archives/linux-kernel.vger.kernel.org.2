Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5200B4033AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 07:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhIHFQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 01:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhIHFQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 01:16:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E23C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 22:14:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631078097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QqW5xA+TX1dcVDvVzstFqcCZnje9NHJk8BbDlw9cLWo=;
        b=0pjGLz44tFWJFn5RTSW8j9xwtPuGGlA1TWZD5ClImc6C+anZoInZoZYd5JPEfVB+X80mi4
        ttmui4CpoY5QVPZzh28keWwPFi9omvWUql2LN8YuSEuw5Ms0d689KBvvX0iOxlq0B4qGJ2
        U0j0LElZ0Q5q31ma4JA9o0lC1LAEzhdahVIRGqWF8MXtwPT5FTbAisOrwYts8VNTS1/GMm
        9EyMyhXSQKzusl8N4LiGP7xLZRNGwTpajoEiZDBISOAf6FY1OexFvT9imQVyqCKxDFnTeM
        3dSL44KCD+uFh/J0krq/m5VphgzP89KjyKihKwjV+bJErGUQRSxh8Wm3TosRHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631078097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QqW5xA+TX1dcVDvVzstFqcCZnje9NHJk8BbDlw9cLWo=;
        b=Df/eS6ewKxHpsZ7dug61lRbFvNTP8bdqeDZ9ozoPcCfLyqxd94ySoai47AzhYD17y5+WUj
        vJasRZ6ciHdlVWAg==
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
In-Reply-To: <cf9a841219904c048983fe2aee578761@intel.com>
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
 <874kaw9mpo.ffs@tglx> <e190b62e3f954cc1804a41149a842641@intel.com>
 <871r609m2i.ffs@tglx> <a883fe85b6b941b9bff44bc4b268bba1@intel.com>
 <87v93c82zn.ffs@tglx> <87sfyg8118.ffs@tglx>
 <cf9a841219904c048983fe2aee578761@intel.com>
Date:   Wed, 08 Sep 2021 07:14:56 +0200
Message-ID: <87pmtj8x7z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08 2021 at 04:06, Tony Luck wrote:

>>> Huch? That tree is based on 0bcfe68b876 and it just has those 20 patches
>>> on top which should not at all interfere with your root filesystem
>>> device. Let me verify.
>>
>> I lost connection to my test machines. Will continue tomorrow morning.
>
> To save you some time I ran a bisect. It says the wheels fall off the bus at
> patch 13/2

Yes, but that's not the real culprit. That's just the messenger.

