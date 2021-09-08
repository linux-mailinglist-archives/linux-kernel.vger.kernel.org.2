Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F85403A85
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349418AbhIHNXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhIHNXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:23:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C7C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:22:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQHxRj5p+M9h78bICTgDQtDzAALXUe3Hy9hrDBJqusQ=;
        b=kc6UuPXPBYNJ7KRiB8c0gsc1JDjLPsu6tiNCk5Bqy8FLgCbBaCYH7LiEqSFxhkq2T5I8np
        CyPaqKrcNGFYnriWcVnwLwfyJD5F9s51kLNrf5J6baHsFx4sTrUsOc8p+hzeyAhF2MV23N
        0FN8a6ucrztWELfQCWDlpntoOhzqffErrfF/5SI7sln+L8TsyeoXnHHrH72rlaP8Cc3wmF
        MukR3kSsw9i0gL+oUky3L6XirXT8NU8OoUaT5D/59aKilwZp+qVP3SQLfkevz5ZDpXSiKV
        TmQxrJQZMuYLmwx3BmPb8JOWDA+vIslEYm0vZCkwmK2V92mn15LtHKUUhOU9cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQHxRj5p+M9h78bICTgDQtDzAALXUe3Hy9hrDBJqusQ=;
        b=4Vt8yrrWj+1gnqyYazEtNJusp2dJelYJ8loRh521Xr2wl6qO7A2yttbjqJzwMyS3sBdxLE
        v2gF5YKv5FcU1hAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: Re: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
In-Reply-To: <CAHk-=wgyHMJrNWdKsCDnjh72_pFaDWX+1D=oB4aT1CaTycbyzg@mail.gmail.com>
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
 <874kaw9mpo.ffs@tglx> <e190b62e3f954cc1804a41149a842641@intel.com>
 <871r609m2i.ffs@tglx> <a883fe85b6b941b9bff44bc4b268bba1@intel.com>
 <87v93c82zn.ffs@tglx> <87sfyg8118.ffs@tglx>
 <CAHk-=wgDBJY4NGRCbEfjRMW9NRa_8vATkVk0muFFvpgixG=Keg@mail.gmail.com>
 <CAHk-=wgyHMJrNWdKsCDnjh72_pFaDWX+1D=oB4aT1CaTycbyzg@mail.gmail.com>
Date:   Wed, 08 Sep 2021 15:22:41 +0200
Message-ID: <875yvb8an2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2021 at 16:22, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 4:20 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Germany has more ISDN connections than anywhere else in the world! How
>> can you possibly complain?
>
> Actually, I take that back. Apparently DT finally got rid of it last
> year. My bad.

That's the problem actually. ISDN was slow but very reliable.

Thanks,

        tglx
