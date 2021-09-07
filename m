Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC66403123
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbhIGWjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:39:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhIGWjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:39:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631054276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idM7CuqjEIENw8qz0JkV2CB+MUZUqYYO3+gVHN0dWxo=;
        b=38yxm453JjgRqmxT7+dy0CBZKJs9TQLZHyOGl6OL/sNDez5P/sV08VAFdGpCwQtq6SCq4k
        Qeu5sDECx488XmwsrwjtpxxGAtOinPoRK/jUSX7N+jSz5TV0q4lr8IpUmF4g6MsHwE8s4T
        NoPUwtH5eJMzfC4LO4kKY6JGYFRMTy5Ivwyyny9mLHSB+vTKJNoQTXMYAn5tbe83AL+ri3
        OCduQUsd/gvYxfHdcDOPszvq0woYsSijwPnomx4YNku1Wz+EmhObXy0y2IuKq7qPEnGEyv
        3lUheVX+ZArqJjsXdIml/zAT25HdCXAk+gVNBi1VUNCuE+BoH4sBqYD8DFam9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631054276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idM7CuqjEIENw8qz0JkV2CB+MUZUqYYO3+gVHN0dWxo=;
        b=eC5cW8brmkipurog8Nz/c4jLan7dHIj5j0QPydDI4qZcK8U+xZJLPacRJ9PAieZ4pxaKw5
        keDSmjV+ofsINrCA==
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
In-Reply-To: <87v93c82zn.ffs@tglx>
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
 <874kaw9mpo.ffs@tglx> <e190b62e3f954cc1804a41149a842641@intel.com>
 <871r609m2i.ffs@tglx> <a883fe85b6b941b9bff44bc4b268bba1@intel.com>
 <87v93c82zn.ffs@tglx>
Date:   Wed, 08 Sep 2021 00:37:55 +0200
Message-ID: <87sfyg8118.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2021 at 23:55, Thomas Gleixner wrote:
> On Tue, Sep 07 2021 at 21:13, Tony Luck wrote:
>
>>>> Was it just the email post that was bad? I.e. are the patches in:
>>>>
>>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu
>>>>
>>>> ok?  I just compiled that, should I boot it, or wait?
>>>
>>> Just the mail script went south. The git tree is fine.
>>
>> What else is in that tree?  My kernel doesn't boot (fails to find root filesystem device).
>> Same .config boots Linus latest (HEAD= 0bcfe68b876 Revert "memcg: enable accounting for pollfd and select bits arrays")
>
> Huch? That tree is based on 0bcfe68b876 and it just has those 20 patches
> on top which should not at all interfere with your root filesystem
> device. Let me verify.

I lost connection to my test machines. Will continue tomorrow morning.

/me mumbles unprintable curses about living in a developing country...

Thanks,

        tglx
