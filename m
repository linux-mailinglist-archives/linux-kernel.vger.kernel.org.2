Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7943F0788
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbhHRPJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239533AbhHRPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:09:26 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AA2C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:08:51 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4GqWWM6PTXzQkcq;
        Wed, 18 Aug 2021 17:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1629299321; bh=ICYoRp5pZT
        VsuHWOrKUSHnzVcWuzrw6IK6MmTdXZbuU=; b=mBZoSz8Gn+96f2gAmC0nFyI7d0
        DzCR1NxUS3zAtBL+kBHtovbnmAibZXBlX2QV/URiI3rPZmq+mGy0gpZQ/f8lMy6u
        F4aHP6cQrd9iQ7REBPOzAyuEx9yV2/+kNGtl76GSzk1T2WXyV3zRK1ofjnGrCb7z
        fh9j2GO+eqVrieVXPrZfhwcejjYQ4M1bBhHQZu8FkcnhdpBslAId42I8+tLzlPBW
        o2kKXncIPGY/Whc07vfdqzYP8O2iaWO+BpCZg4JGi0DOOK3QGLUGS7jizDdTF+c7
        uHByKucpo0/ZDFFw00Ai+fKRWnidnEPhjci5BgD8It2peOv6ve6FbhgcyT1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629299325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDnhRncZEBK7QOE1PSqSdUR/el9JR/iDyYbLw5ADBrw=;
        b=rvVYonya2wwM6dh9b2aJdKN0DxcuOPeqIKqHQ6f9xaHxOgjwLDckJAwUeY+iteFWBhxRuU
        0UOjVDsrZTK6oeDvukWgBHx1rLVTkXDnSTJImh2heBfOXKdx2n88lVGiHtEr1moYF5rtIQ
        3BD2ATPHsgzr5GD8fJ3z/VHWgw8qoXCTw/dkWwF/477rZuTHgfZCEN96xZxuI4scv49pPw
        O/Ej1iXSl2vbK8NwAs14E6xkfhSYK5hlKG05xICPQWqy4PZda9Qlnce7JoCAUliUTRBtl2
        sYBPtVT/ziem6BmzyxlxqAhm1ZIiOi5rQMjYuGgzpCGBt6//WRoOPD6VGTnLew==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id z8NIfc79jt6B; Wed, 18 Aug 2021 17:08:41 +0200 (CEST)
Date:   Wed, 18 Aug 2021 17:08:40 +0200 (CEST)
From:   torvic9@mailbox.org
To:     Borislav Petkov <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Message-ID: <1708009975.124311.1629299321026@office.mailbox.org>
In-Reply-To: <YRwBs89eogLJEiRn@zn.tnic>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
 <YRwBs89eogLJEiRn@zn.tnic>
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: B96591838
X-Rspamd-UID: b07b87
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Borislav Petkov <bp@alien8.de> hat am 17.08.2021 20:36 geschrieben:
> 
>  
> On Tue, Aug 17, 2021 at 04:24:48PM +0200, torvic9@mailbox.org wrote:
> > Add new generic x86-64 CPU tunings introduced with recent versions of
> > gcc and clang, as documented in x86-64-psABI [1].
> > 
> > This is taken straight from graysky's CPU optimization patch with minor
> > modifications [2].
> > 
> > [1] https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb7e9a6b9396884b67c7c
> > [2] https://github.com/graysky2/kernel_compiler_patch
> > 
> > Signed-off-by: Tor Vic <torvic9@mailbox.org>
> > ---
> >  arch/x86/Kconfig.cpu  | 26 +++++++++++++++++++++++++-
> >  arch/x86/Makefile.cpu |  6 ++++++
> >  2 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> > index 814fe0d349b0..a2c872aa5a0b 100644
> > --- a/arch/x86/Kconfig.cpu
> > +++ b/arch/x86/Kconfig.cpu
> > @@ -294,6 +294,30 @@ config GENERIC_CPU
> >  	  Generic x86-64 CPU.
> >  	  Run equally well on all x86-64 CPUs.
> >  
> > +config GENERIC_CPU_V2
> > +	bool "Generic-x86-64-v2"
> > +	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> > +	depends on X86_64
> > +	help
> > +	  Generic x86-64 CPU.
> > +	  Run equally well on all x86-64 CPUs with min support of x86-64-v2.
> > +
> > +config GENERIC_CPU_V3
> > +	bool "Generic-x86-64-v3"
> > +	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> > +	depends on X86_64
> > +	help
> > +	  Generic x86-64-v3 CPU with v3 instructions.
> > +	  Run equally well on all x86-64 CPUs with min support of x86-64-v3.
> > +
> > +config GENERIC_CPU_V4
> > +	bool "Generic-x86-64-v4"
> > +	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> > +	depends on X86_64
> > +	help
> > +	  Generic x86-64 CPU with v4 instructions.
> > +	  Run equally well on all x86-64 CPUs with min support of x86-64-v4.
> 
> Every once in a while, patches like that pop up without any real numbers
> advocating for the additional and perhaps unnecessary complexity.
> 
> If those -march switches don't bring any measureable improvements - and
> I highly doubt they do - you shouldn't waste time with submitting them.

Borislav,
I ran some quick checks and benchmarks, and your doubts seem to be justified.
A 5.14-rc6 kernel compiled with the default 'generic' and one built with
'x86-64-v3' even have the exact same uncompressed file size.
Benchmarks were inconclusive as well.
So I will only resubmit the first patch of this series, with the changes
suggested by Masahiro and Christoph.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
