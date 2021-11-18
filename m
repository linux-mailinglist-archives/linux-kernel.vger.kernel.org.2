Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF83A455616
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 08:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbhKRHyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 02:54:09 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:43645 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbhKRHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 02:53:32 -0500
Received: by mail-vk1-f173.google.com with SMTP id f7so3257294vkf.10;
        Wed, 17 Nov 2021 23:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fvf9IHoTjOVlxPhBDqizDh4T7hHOnvCceGRp3XgLv0=;
        b=neFbh92ag5xutXWkcBwCEVUKJr0T1lHo+wASbx/Ou1629oZ4oZu0ZV0uR9QW7HucST
         zT0DleC2B4xzjLKXTF173Le69chTaaLPzeaXO3t//nS8l+cE7MUiyMJHoDvMkqdNmI8S
         kNLYyZV30evu6CCv490OGBdqfwQE3o6/FcsjwkL7WkLjx2A3W3Hnv0EaYOMKZ6HgDs+t
         p6sB4FVStLWKQTCjyz63oTWwODHQz3DOqZauW9qdim4JVzvLZPTzu+Aviy7U2rltzODY
         9aDvzfadkKcaqAgNip/Jls5JMm0ypzVbzBWfayi0sMCZiJreIOehWt94Ckd0dLIIz3kY
         3uAw==
X-Gm-Message-State: AOAM530UVw34fISCF7N8QaRy3lMBvAms9jfFG7QGz6gaDVnA++oMngEx
        G+fFahP/XL/TlefvLby1GiHhMZ9evn9g5w==
X-Google-Smtp-Source: ABdhPJxJuLpIvOR4MbFNwSH60xeMJ9wDAykt6IhVe92btZ8D3Up3/zYSy30cxImJ9OlfEexes4SlsA==
X-Received: by 2002:a05:6122:1796:: with SMTP id o22mr100975924vkf.23.1637221832634;
        Wed, 17 Nov 2021 23:50:32 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id v8sm1200574vkc.52.2021.11.17.23.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 23:50:32 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id l24so11806061uak.2;
        Wed, 17 Nov 2021 23:50:31 -0800 (PST)
X-Received: by 2002:a9f:248b:: with SMTP id 11mr33653990uar.14.1637221831518;
 Wed, 17 Nov 2021 23:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20211117201459.1194876-1-nickrterrell@gmail.com> <20211117201459.1194876-2-nickrterrell@gmail.com>
In-Reply-To: <20211117201459.1194876-2-nickrterrell@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Nov 2021 08:50:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWts1kh8koe7y9CLqRX3DoF_Lnm9o7M=TULJhJDPGKnkw@mail.gmail.com>
Message-ID: <CAMuHMdWts1kh8koe7y9CLqRX3DoF_Lnm9o7M=TULJhJDPGKnkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lib: zstd: Fix unused variable warning
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Nick Terrell <terrelln@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Nov 17, 2021 at 9:08 PM Nick Terrell <nickrterrell@gmail.com> wrote:
> The variable `litLengthSum` is only used by an `assert()`, so when
> asserts are disabled the compiler doesn't see any usage and warns.
>
> This issue is already fixed upstream by PR #2838 [0]. It was reported
> by the Kernel test robot in [1].
>
> Another approach would be to change zstd's disabled `assert()`
> definition to use the argument in a disabled branch, instead of
> ignoring the argument. I've avoided this approach because there are
> some small changes necessary to get zstd to build, and I would
> want to thoroughly re-test for performance, since that is slightly
> changing the code in every function in zstd. It seems like a
> trivial change, but some functions are pretty sensitive to small
> changes. However, I think it is a valid approach that I would
> like to see upstream take, so I've opened Issue #2868 to attempt
> this upstream.
>
> [0] https://github.com/facebook/zstd/pull/2838
> [1] https://lore.kernel.org/linux-mm/202111120312.833wII4i-lkp@intel.com/T/
> [2] https://github.com/facebook/zstd/issues/2868
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nick Terrell <terrelln@fb.com>

Thanks for your patch!

> --- a/lib/zstd/compress/zstd_compress_superblock.c
> +++ b/lib/zstd/compress/zstd_compress_superblock.c
> @@ -411,6 +411,8 @@ static size_t ZSTD_seqDecompressedSize(seqStore_t const* seqStore, const seqDef*
>      const seqDef* sp = sstart;
>      size_t matchLengthSum = 0;
>      size_t litLengthSum = 0;
> +    /* Only used by assert(), suppress unused variable warnings in production. */
> +    (void)litLengthSum;

The Linux way-to do this is to add __maybe_unused.
But perhaps you don't want to introduce that in the upstream codebase.

>      while (send-sp > 0) {
>          ZSTD_sequenceLength const seqLen = ZSTD_getSequenceLength(seqStore, sp);
>          litLengthSum += seqLen.litLength;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
