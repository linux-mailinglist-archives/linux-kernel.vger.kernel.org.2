Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1235D464
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhDMARh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 20:17:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhDMARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 20:17:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618273035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rymwp/afC9oy7xAETjFGp8TpdTqrd4IB3gAvmS3B298=;
        b=SDDDu++iBzWZnqRanhVSVoy0WgGOaHHQlkrZrmQELSJJ3Mpq+XezkodyL7II2fam+QoB/4
        6xw7zBELWcw/oDKwXgPL9V4Nc2vC+yYlqergCBt9fWfAKL5jS0pENkhJf1AJKHlfcorHg0
        oGNQrvS2ooIiVDp3yoQJBKEOPKKxYGZ3y1dRM8WaBZflgdPlKomZ7tFLGNrhs/1nbgwf55
        mPVKVU8psTtt975GcspHTAxCNzn9UMuP4H3jA4tCvPAa+Z2M14bax+jzZCIji7kxiXHMBV
        mZwkDRsiJJdEwyYWEsJOWAqZERBB2oj+huxA3MegS7Ln8gpKw8YNBq9MsAqYLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618273035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rymwp/afC9oy7xAETjFGp8TpdTqrd4IB3gAvmS3B298=;
        b=VC3bSWSw/M1Ncveu5kWXfZk7We4D1AXH/StVgDo61WZR59JR3wMvRLn5KGVVPTV6nUImJd
        JRJ5dtyf2ygw4xDA==
To:     Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com> <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com> <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
Date:   Tue, 13 Apr 2021 02:17:15 +0200
Message-ID: <87a6q3yr5g.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12 2021 at 19:46, Len Brown wrote:
> On Mon, Apr 12, 2021 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:
>> Even putting aside all kernel and ABI issues, is it actually a good
>> idea for user libraries to transparently use these new features?  I'm
>> not really convinced.  I think that serious discussion among userspace
>> people is needed.
>
> At the risk of stating the obvious...
> Intel's view is that libraries that deliver the most value from the
> hardware are a "good thing",
> and that anything preventing libraries from getting the most value
> from the hardware is a "bad thing":-)

Sure, and as a consequence the kernel is the problem when creative
libraries cause wreckage along the way.

I'm fine with that as long the kernel has a way to detect that and can
kill the offending application/library combo with an excplicit
-SIG_NICE_TRY.

Thanks,

        tglx

