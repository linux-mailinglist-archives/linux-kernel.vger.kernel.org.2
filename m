Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBDE45561A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 08:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbhKRH4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 02:56:17 -0500
Received: from mail-vk1-f174.google.com ([209.85.221.174]:36544 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243953AbhKRH4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 02:56:10 -0500
Received: by mail-vk1-f174.google.com with SMTP id b192so3291824vkf.3;
        Wed, 17 Nov 2021 23:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsZfy0TOro1vfH8A3JIpHvIwPAiVrIi4MFkv4lGb5JM=;
        b=7J9yCDVPQSKxjpM+dNO0GOHeslHWoKA6FF288IeMyRzu+L3vmQO+w2XRGzi81P0dmX
         VQsMynI8/U4zD2axpQIW2sXkfCdvdf8Pearx++Bwl5Lg9G3Pz1fDYc+NgLgxe8ZKgrkV
         2X9S8znRaaXJSowTjl9EMJfZdTdvdCHrIwBPUQ2lmeuN2OTsB5UPbY1t0mjd7QCfOscG
         XrSVMj0bN5L+hQDOpDxuD0mYG6jnYDL5WJhap6ZOOHnqwWowumo3llgClxzbYDyZ5TNG
         IVAE3t1fuE5Qvt1zQ5UN6mz+ds0ELApnW42gdNh+9nVMihUZSOLrN9YWqblOTPWwJqU2
         xGgA==
X-Gm-Message-State: AOAM531YdmWb+ja6PXFK5AYGXfQ+mHJxVeiwAroqS35+fJ4bEm5jHIaz
        c7n3LNp6Nne2uaIOp2yhNZO43coGBL6e6w==
X-Google-Smtp-Source: ABdhPJxLvHJU8eG9FmdoeoG3GRR7Buc95kvZo/OhHVQayFmp4XNzIKM7kX/n/QC9yuUcgqqn7yNmFA==
X-Received: by 2002:a1f:aa48:: with SMTP id t69mr98697664vke.2.1637221990048;
        Wed, 17 Nov 2021 23:53:10 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 15sm1259860vkj.49.2021.11.17.23.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 23:53:09 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id b125so3268755vkb.9;
        Wed, 17 Nov 2021 23:53:09 -0800 (PST)
X-Received: by 2002:a05:6122:7d4:: with SMTP id l20mr4449881vkr.26.1637221989243;
 Wed, 17 Nov 2021 23:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20211117201459.1194876-1-nickrterrell@gmail.com> <20211117201459.1194876-3-nickrterrell@gmail.com>
In-Reply-To: <20211117201459.1194876-3-nickrterrell@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Nov 2021 08:52:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0JaSKG95ozPWQUhBBBgbGUMOrxdsA=N-q-Cm9-RoF7A@mail.gmail.com>
Message-ID: <CAMuHMdU0JaSKG95ozPWQUhBBBgbGUMOrxdsA=N-q-Cm9-RoF7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] lib: zstd: Don't inline functions in zstd_opt.c
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Nick Terrell <terrelln@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Nov 17, 2021 at 9:08 PM Nick Terrell <nickrterrell@gmail.com> wrote:
> `zstd_opt.c` contains the match finder for the highest compression
> levels. These levels are already very slow, and are unlikely to be used
> in the kernel. If they are used, they shouldn't be used in latency
> sensitive workloads, so slowing them down shouldn't be a big deal.
>
> This saves 188 KB of the 288 KB regression reported by Geert Uytterhoeven [0].
> I've also opened an issue upstream [1] so that we can properly tackle
> the code size issue in `zstd_opt.c` for all users, and can hopefully
> remove this hack in the next zstd version we import.
>
> Bloat-o-meter output on x86-64:
>
> ```
> > ../scripts/bloat-o-meter vmlinux.old vmlinux
> add/remove: 6/5 grow/shrink: 1/9 up/down: 16673/-209939 (-193266)
> Function                                     old     new   delta
> ZSTD_compressBlock_opt_generic.constprop       -    7559   +7559
> ZSTD_insertBtAndGetAllMatches                  -    6304   +6304
> ZSTD_insertBt1                                 -    1731   +1731
> ZSTD_storeSeq                                  -     693    +693
> ZSTD_BtGetAllMatches                           -     255    +255
> ZSTD_updateRep                                 -     128    +128
> ZSTD_updateTree                               96      99      +3
> ZSTD_insertAndFindFirstIndexHash3             81       -     -81
> ZSTD_setBasePrices.constprop                  98       -     -98
> ZSTD_litLengthPrice.constprop                138       -    -138
> ZSTD_count                                   362     181    -181
> ZSTD_count_2segments                        1407     938    -469
> ZSTD_insertBt1.constprop                    2689       -   -2689
> ZSTD_compressBlock_btultra2                19990     423  -19567
> ZSTD_compressBlock_btultra                 19633      15  -19618
> ZSTD_initStats_ultra                       19825       -  -19825
> ZSTD_compressBlock_btopt                   20374      12  -20362
> ZSTD_compressBlock_btopt_extDict           29984      12  -29972
> ZSTD_compressBlock_btultra_extDict         30718      15  -30703
> ZSTD_compressBlock_btopt_dictMatchState    32689      12  -32677
> ZSTD_compressBlock_btultra_dictMatchState   33574      15  -33559
> Total: Before=6611828, After=6418562, chg -2.92%
> ```
>
> [0] https://lkml.org/lkml/2021/11/14/189
> [1] https://github.com/facebook/zstd/issues/2862
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Nick Terrell <terrelln@fb.com>

Thanks for your patch!

Impact on lib/zstd/zstd_compress.ko for atari_defconfig:

    add/remove: 5/4 grow/shrink: 1/9 up/down: 15392/-167214 (-151822)

Nice!

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/lib/zstd/compress/zstd_opt.c
> +++ b/lib/zstd/compress/zstd_opt.c
> @@ -894,7 +906,7 @@ static void ZSTD_optLdm_processMatchCandidate(ZSTD_optLdm_t* optLdm, ZSTD_match_
>               */
>              U32 posOvershoot = currPosInBlock - optLdm->endPosInBlock;
>              ZSTD_optLdm_skipRawSeqStoreBytes(&optLdm->seqStore, posOvershoot);
> -        }
> +        }
>          ZSTD_opt_getNextMatchAndUpdateSeqStore(optLdm, currPosInBlock, remainingBytes);
>      }
>      ZSTD_optLdm_maybeAddMatch(matches, nbMatches, optLdm, currPosInBlock);

This change is unrelated. With that removed:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
