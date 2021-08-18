Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE73F0AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhHRR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:59:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51598 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhHRR7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:59:00 -0400
Received: from zn.tnic (p200300ec2f0cc30025743e574fa309df.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:2574:3e57:4fa3:9df])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B8431EC04D6;
        Wed, 18 Aug 2021 19:58:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629309500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AFLaBaNpzHVbJbyU9w9pbzBVwCiTKlHLGR5SGWofGM4=;
        b=QK8Dumn0giR8AZ7+SsGNxxKkSwyxqOONiHxfZC2joy9FkL6Mqn3nAuvPq6U+Kq1Uaf6x1o
        m+vayiiHc4/O+MO8+q3AVykBezkpgp0SAsSc5zXT7C2CycIb28d1cXgtQ7ZJBw6z8I++Ua
        HKvsEmE4u0O38lCSU2S7z3Bb4xZtBec=
Date:   Wed, 18 Aug 2021 19:59:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     torvic9@mailbox.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
Message-ID: <YR1KDD/azm1IDr9u@zn.tnic>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
 <YRwBs89eogLJEiRn@zn.tnic>
 <1708009975.124311.1629299321026@office.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1708009975.124311.1629299321026@office.mailbox.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 05:08:40PM +0200, torvic9@mailbox.org wrote:
> I ran some quick checks and benchmarks, and your doubts seem to be
> justified. A 5.14-rc6 kernel compiled with the default 'generic' and
> one built with 'x86-64-v3' even have the exact same uncompressed file
> size. Benchmarks were inconclusive as well.

Lemme preface this with a IMHO:

Yeah, those -march machine-specific compiler switches don't really
show any perf improvements for kernels because, well, if you look at
the instruction stream a kernel executes, there's not really a whole
lot left to optimize after -O2.

Also, the percentage of time a machine spends in the kernel should be a
lot smaller (orders of magnitude) than in userspace - the operative word
being *should* here :-) - so there really isn't anything to optimize.

Not to say that there aren't a gazillion other places in the kernel that
could use more eyes and testing. ^Hint hint^

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
