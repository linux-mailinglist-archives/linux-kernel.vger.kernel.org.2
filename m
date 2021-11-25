Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FB245D3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 05:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbhKYEOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 23:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhKYEMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 23:12:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 20:08:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c4so8535617wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 20:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhmezBzGHBM966KHo0JNvvbe7U7qNQlNKJfr5b7/rKU=;
        b=ByCMfhXbeRYRx8LaoTVGhPIU6H8FQJfAlO5GGNf1Ego9oNSpF70gTxuy4GMiA8dSln
         3i3arLwNDKFRBsy5rahMMLkw8DCjgdFqtXZGGzNUc+NrhRldQfJ+vd4JO4ETdRhqHdfz
         Qda7m9yavOfdF0EuKyI1o0fm0dv1+lXQWQnKeHbKPmEYj+S66nzmmuf7/oKoTYAPsgQ5
         x1hGxjLwf/7SlhVjYey6jdRTL/tN19y7dGRSWCmNMXzCwIwNjx/FKCGMd/KdSsG+kEYY
         pFUb/+TyA4OEfw17qsKWCV81JY7JnExG4cWB/12rgjeF4zx3kwTspTqvVgq32LHmSdNf
         jsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhmezBzGHBM966KHo0JNvvbe7U7qNQlNKJfr5b7/rKU=;
        b=qM2dVimnemJMRq/RxY7T7UDwso0S2jbmDzQYin9qEvx1VMi7Owx6KMIGIOrAf9nDet
         PNocM3LP7nudycmPt9hiSESOCdcyHyKlYzdYoIR/QgAzj7PsG1+cg3UAF7axZUvUSZ3K
         LeLrHvEX6tEpY4FL7OkFnnfcg0O0eApY8c2C1pu/q4ZCizEpvp070pbO4CJIJuapFN3J
         6v2aKElWHhhqg9Ez5fAnjd6AQVZxBk8mUZTMNr//dyKvPZqf4d3pwavmNZijheTTdleP
         Wa4Inta9KqYQ4zfQXKTy9kQZSTkgtgg1IcjRzXsIsS73ionMwS+MwA8jeoleV2/Ns2eI
         G8cQ==
X-Gm-Message-State: AOAM533hm0skKUiPTevPMrYw4pfkpoZH5Op3Gr7wk3/fE5HtOReQ1QRv
        UuUP4FICoBn9ePFUwoftdwIg5rFtj8qcTJ41078c/w==
X-Google-Smtp-Source: ABdhPJxC66OXY9eTZER3Y0TBo6wr6vDqfDc4WfzIS441rjXjHx6MA8X9WsToQ1h2EEy+GHI09OygN5WbcqwyP7wKH7I=
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr3133197wrx.352.1637813333299;
 Wed, 24 Nov 2021 20:08:53 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com> <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
In-Reply-To: <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Nov 2021 20:08:41 -0800
Message-ID: <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
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

On Wed, Nov 24, 2021 at 8:00 PM Eric Dumazet <edumazet@google.com> wrote:

>
> It is an issue in general, not in standard cases because network
> headers are aligned.
>
> I think it came when I folded csum_partial() and do_csum(), I forgot
> to ror() the seed.
>
> I suspect the following would help:
>
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..ee7b0e7a6055bcbef42d22f7e1d8f52ddbd6be6d
> 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>         if (unlikely(odd)) {
>                 if (unlikely(len == 0))
>                         return sum;
> +               temp64 = ror32((__force u64)sum, 8);
>                 temp64 += (*(unsigned char *)buff << 8);
>                 len--;
>                 buff++;
>
>

It is a bit late here, I will test the following later this week.

We probably can remove one conditional jump at the end of the function

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..15986ad42ed5ccb8241ff467a34188cf901ec98e
100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -41,9 +41,11 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
        if (unlikely(odd)) {
                if (unlikely(len == 0))
                        return sum;
+               temp64 = ror32((__force u64)sum, 8);
                temp64 += (*(unsigned char *)buff << 8);
                len--;
                buff++;
+               odd = 8;
        }

        while (unlikely(len >= 64)) {
@@ -129,10 +131,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 #endif
        }
        result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
-       if (unlikely(odd)) {
-               result = from32to16(result);
-               result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
-       }
+       ror32(result, odd);
        return (__force __wsum)result;
 }
 EXPORT_SYMBOL(csum_partial);
