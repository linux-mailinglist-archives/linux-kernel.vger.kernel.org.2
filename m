Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE393D3265
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 05:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhGWDP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbhGWDP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:15:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1D7C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 20:56:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g8so11726031lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 20:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CILyKiyZ9Cyy/Achhyq3C7m86Us0H0wmdQwbCBhk7s=;
        b=VwtvKVgL5/N4lanX2A2VRo1qXku2gUfEVD2s/U5WlPiq9OFziJ+BtHZMXR/MRdv16y
         /1L63/rJZ41A0Wl77mLrcCV6BaW9dTV6A8qol6JfhV254/wpSpEvo1JFbMisVS4vwo9x
         XcEzjBUTVDmWl3+Jv4LwacjbtdtJ4BliaISdwDNxazEY9OVmqnDShwSsyaDByuRNcijc
         jOVGddAudOJzm8EpZFNF9YfFbsIcP1LxWFgmHTNAqAh5Wy9aPiN2WrytSS+DiF/blwx2
         QRwRQxcg8Ku1g+3Bzs5PjRcC1qn9EWV5/Zjrl2C8BYQrU7Q7zsYP0QoF5I/mSa089ThI
         I3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CILyKiyZ9Cyy/Achhyq3C7m86Us0H0wmdQwbCBhk7s=;
        b=eJOeYoJ9hEp1XRydApUVMjI/t7cpnvFfJuAOEbLIzJyl3oWAsCFMk9nFidosAkU4q+
         4t3aE1xqWzgwNt7ZY9wGjXweZa70xML5aW3dYG2uefbLQ8nxYX0fUNpALKCKuZW/ael+
         hPImcbThIyhWeOctNsjrCv6rScgfiiFB0hl9vnDRMK8zQ8u0cKfQplcsY8ljtm7CcCIi
         UGSE9jX+y5+yxRPEo0MWz8mE33wB6UU3dui1pgqParObo0kU4j1+RNhUUFg7v9OwrHm6
         Ea8d3ZNEMeBYoaL4rSKgPmXAtxhX7EUbz0b4HzTwox5UkUx41JciSBKQIvhfM7R8Creo
         zguA==
X-Gm-Message-State: AOAM5307fzRCgzjgzukRCSvPboQbqOrMuGEePO0cScZYJ55LOwTWkuu2
        /67k+FVQN/Esf4Ntio+QOb1HXbf4BocfIxlYvyA=
X-Google-Smtp-Source: ABdhPJxQCkbhChbxfF8wgnof5n2r5pMNP76Vlr2+k91tH7qvXsi7ccr+B1Bssgyt3RPfcUTXpvPQ5LS9+oTH3Ig/alQ=
X-Received: by 2002:a19:f018:: with SMTP id p24mr1771467lfc.162.1627012559512;
 Thu, 22 Jul 2021 20:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210723034622.1820891-1-liuchao12@xiaomi.com>
In-Reply-To: <20210723034622.1820891-1-liuchao12@xiaomi.com>
From:   Chao Liu <chaoliu719@gmail.com>
Date:   Fri, 23 Jul 2021 11:55:48 +0800
Message-ID: <CAKaaq-XC8v25_vHwtHgob5QZ+FW5t2mvopTGO7fB1XViyoqNrQ@mail.gmail.com>
Subject: Re: [PATCH] resize.f2fs: add option to manually specify new overprovision
To:     chao@kernel.org, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to add the f2fs-dev label. I will send it again later.

On Fri, Jul 23, 2021 at 11:46 AM Chao Liu <chaoliu719@gmail.com> wrote:
>
> Make.f2fs supports manually specifying overprovision, and we expect
> resize.f2fs to support it as well.
>
> This change add a new '-o' option to manually specify overprovision.
>
> Signed-off-by: Chao Liu <liuchao12@xiaomi.com>
> ---
>  fsck/main.c   | 8 ++++++--
>  fsck/resize.c | 9 ++++++++-
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fsck/main.c b/fsck/main.c
> index 260ff29..06253e2 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -124,7 +124,8 @@ void resize_usage()
>         MSG(0, "[options]:\n");
>         MSG(0, "  -d debug level [default:0]\n");
>         MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
> -       MSG(0, "  -s safe resize (Does not resize metadata)");
> +       MSG(0, "  -o overprovision percentage [default:auto]\n");
> +       MSG(0, "  -s safe resize (Does not resize metadata)\n");
>         MSG(0, "  -t target sectors [default: device size]\n");
>         MSG(0, "  -V print the version number and exit\n");
>         exit(1);
> @@ -529,7 +530,7 @@ void f2fs_parse_options(int argc, char *argv[])
>  #endif
>         } else if (!strcmp("resize.f2fs", prog)) {
>  #ifdef WITH_RESIZE
> -               const char *option_string = "d:fst:iV";
> +               const char *option_string = "d:fst:io:V";
>
>                 c.func = RESIZE;
>                 while ((option = getopt(argc, argv, option_string)) != EOF) {
> @@ -563,6 +564,9 @@ void f2fs_parse_options(int argc, char *argv[])
>                         case 'i':
>                                 c.large_nat_bitmap = 1;
>                                 break;
> +                       case 'o':
> +                               c.new_overprovision = atof(optarg);
> +                               break;
>                         case 'V':
>                                 show_version(prog);
>                                 exit(0);
> diff --git a/fsck/resize.c b/fsck/resize.c
> index 78d578e..85a53c5 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -146,7 +146,9 @@ safe_resize:
>                                                 get_sb(segs_per_sec));
>
>         /* Let's determine the best reserved and overprovisioned space */
> -       c.new_overprovision = get_best_overprovision(sb);
> +       if (c.new_overprovision == 0)
> +               c.new_overprovision = get_best_overprovision(sb);
> +
>         c.new_reserved_segments =
>                 (2 * (100 / c.new_overprovision + 1) + 6) *
>                                                 get_sb(segs_per_sec);
> @@ -476,6 +478,11 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
>         set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
>                                                 get_cp(rsvd_segment_count));
>
> +       MSG(0, "Info: Overprovision ratio = %.3lf%%\n", c.new_overprovision);
> +       MSG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
> +                                       get_cp(overprov_segment_count),
> +                                       c.new_reserved_segments);
> +
>         free_segment_count = get_free_segments(sbi);
>         new_segment_count = get_newsb(segment_count_main) -
>                                         get_sb(segment_count_main);
> --
> 2.32.0
>
