Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9845D4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347338AbhKYGiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347627AbhKYGgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:36:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A62FC0613F8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:32:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so9207662wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drz3+1/lxGxb1snGH+uLzFz+KStB/L2QdGu/80IF35o=;
        b=plpjKQNGmQVqlY2pTqUIDVpiaSI5FPXQ5h0iLTJBEB1ZFwSa8C1+zdTgsG2EaXDefI
         MiJ+9D7EQVINfKmMAQj/qGcm/ZIQxP2rkYctuQqN9xO9Yv4jrVVEGuepKhoKEhMwy+oi
         dkDpOPupfVwznnNElnNZQ729n6d2s2fwlK50e59Wh8e+E5LBq5DQXiF2VaEyLP6GR7uf
         k1xjoOJHcCLJw4mIJxajzbt2HM4X0bXuhzxw8CQOqQsOBYO52EPH0Hti3a1wSh10tmbR
         egGA4sFlc9xWGDl6oN84ro7ECjWf0Dg0EKuuqnQ1fRgZ/tJtzn+RmYF1ITaYrZS0tGuk
         AqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drz3+1/lxGxb1snGH+uLzFz+KStB/L2QdGu/80IF35o=;
        b=3ZVvhQ7eFHCsLk6udSWebQszL31nBnsJgBf4TD5RoT6sVUnqWZ9JE4Z7WE8y+CYKAY
         biFdtwy80Dvea7FJ7EazYuorlM9v8y9RpbY3AOhPo1L0rpromcepieCV2I4P7rUdUa2X
         qHWsKzPrWrfln25fAX+PaEoDallgC2Ec9TaFvh+GaB55k5thivnbP1Va7VM/nfws9Jq7
         lPldGy71xdpZkgKe8OQeBUxwETfSa/8M6v7qmr7eQ98gjVWADUH6axigks4fWOoQmkLX
         UlMh4YRuf3kbPxRu28XlprqRGWKeilBuv3ecRYwBhcHNylvfFAPskKvDCsyyq0Uz43UM
         uG+g==
X-Gm-Message-State: AOAM530hv84cyhaWV15HKkGN/jXppW2opfY/xeAwrxrVSDGJSfKzk73B
        8FTx77VFimhT5ur7krK6ikIw5C6SQbzUIaKpGSZOSw==
X-Google-Smtp-Source: ABdhPJwKrJcgQtDWIAChMLG1FrayYrmfAzaAwzQjhx8O2fh/5bl8UjxquXGQrZ8EUbt0TGzNdE2xCsEBeN4Ofe4yI5E=
X-Received: by 2002:adf:fb86:: with SMTP id a6mr3872989wrr.35.1637821953434;
 Wed, 24 Nov 2021 22:32:33 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
 <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com>
 <CAFUsyfL3RF-UC-HBUcbRn0e5S3URo9gpz5V85buF8C7xVb6K7w@mail.gmail.com> <CAFUsyfLz89DrkvTwDTDqNCHVbBzk1QgEKu0+PuwBoF=Y6me7cQ@mail.gmail.com>
In-Reply-To: <CAFUsyfLz89DrkvTwDTDqNCHVbBzk1QgEKu0+PuwBoF=Y6me7cQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Nov 2021 22:32:21 -0800
Message-ID: <CANn89iLYHkyaLawrZJYuRETx63c0QWQ0kLGysPbGpWj2+C5Jfw@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>,
        linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 9:09 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
>
>
> Although I see slightly worse performance with aligned `buff`  in
> the branch-free approach. Imagine if non-aligned `buff` is that
> uncommon might be better to speculate past the work of `ror`.

Yes, no clear win here removing the conditional (same cost really),
although using a ror32() is removing the from32to16() helper and get
rid of one folding.

I will formally submit this change, thanks !

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..cf4bd3ef66e56c681b3435d43011ece78438376d
100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -11,16 +11,6 @@
 #include <asm/checksum.h>
 #include <asm/word-at-a-time.h>

-static inline unsigned short from32to16(unsigned a)
-{
-       unsigned short b = a >> 16;
-       asm("addw %w2,%w0\n\t"
-           "adcw $0,%w0\n"
-           : "=r" (b)
-           : "0" (b), "r" (a));
-       return b;
-}
-
 /*
  * Do a checksum on an arbitrary memory area.
  * Returns a 32bit checksum.
@@ -41,6 +31,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
        if (unlikely(odd)) {
                if (unlikely(len == 0))
                        return sum;
+               temp64 = ror32((__force u32)sum, 8);
                temp64 += (*(unsigned char *)buff << 8);
                len--;
                buff++;
@@ -129,10 +120,8 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 #endif
        }
        result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
-       if (unlikely(odd)) {
-               result = from32to16(result);
-               result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
-       }
+       if (unlikely(odd))
+               result = ror32(result, 8);
        return (__force __wsum)result;
 }
 EXPORT_SYMBOL(csum_partial);
