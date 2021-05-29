Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B42394C1A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhE2MBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 08:01:13 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:39808 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2MBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 08:01:12 -0400
Received: by mail-ua1-f54.google.com with SMTP id f20so3668706uax.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 04:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBqDKANDuYIv1fmJy0kOtLnPqcHSsIvvwpPjjPB2kis=;
        b=eolhCgwN8bTUOWJPf5uoqmWRG0Z7LBkiY3PQQZuSqKSbnNfNHHvHuWZm+tHMh40x+j
         Ij3m67oKo2L0P+4XI4GXWUvLuh1+etDaYz4vUSD7a5ec7I8UCsMnQYQw4CY69C+0aT1J
         zUFvOFOOKmKNMkdfqoTdU/M7mlrXddxf69gzQ8ACdg/mjZ0+aAGvhNwW/nTcgF6U4fth
         gxGAQtRR8S8K7By6EmGhufKvWhsjPgB/dsetsbrIdgZdLNFfzTRdismAIDlnBxuEB78y
         SYCcDbuikV4WOgZI0yNIxHXe/Rjl88cJ9nktRiU6/SGLErSfJJT8AITcP8be7iGtiYJS
         Ampg==
X-Gm-Message-State: AOAM530bzAmNS2GCR50z1mure8BWu3T6FlNkQ/TDloz4+/8PB1PM9n9z
        IrLyo1B+9EHGP+D1Cc8my4zKrXR3DrgMRcQqhWnBXsNYITM=
X-Google-Smtp-Source: ABdhPJwPEu7DR9pauy++8Ai97mNxeKCkKBxjL2XsakIMfVrQrx7zQmQj7xd06djOtKPLA30afe5FVTrTsWB+sX6w7tk=
X-Received: by 2002:a05:6122:692:: with SMTP id n18mr4783503vkq.1.1622289575421;
 Sat, 29 May 2021 04:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <202105290646.Ov4yx6Pr-lkp@intel.com>
In-Reply-To: <202105290646.Ov4yx6Pr-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 29 May 2021 13:59:23 +0200
Message-ID: <CAMuHMdXZumxTDSG5yx0K8c1SfgodDPm6xCtb+Tb8B5U3HUyT5w@mail.gmail.com>
Subject: Re: include/linux/avf/virtchnl.h:852:33: error: enumerator value for
 'virtchnl_static_assert_virtchnl_rss_cfg' is not an integer constant
To:     kernel test robot <lkp@intel.com>
Cc:     Qi Zhang <qi.z.zhang@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jia Guo <jia.guo@intel.com>,
        Haiyue Wang <haiyue.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 12:26 AM kernel test robot <lkp@intel.com> wrote:
> FYI, the error/warning still remains.

Fix available for 10 days:
https://lore.kernel.org/lkml/20210519194350.1854798-1-geert@linux-m68k.org/

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5ff2756afde08b266fbb673849899fec694f39f1
> commit: 222a8ab01698148c00c271cda82d96f4e6e7b0a8 ice: Enable RSS configure for AVF
> date:   5 weeks ago
> config: m68k-randconfig-s031-20210528 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=222a8ab01698148c00c271cda82d96f4e6e7b0a8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 222a8ab01698148c00c271cda82d96f4e6e7b0a8
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
>                     from drivers/net/ethernet/intel/i40e/i40e.h:41,
>                     from drivers/net/ethernet/intel/i40e/i40e_main.c:11:
>    include/linux/avf/virtchnl.h:153:36: warning: division by zero [-Wdiv-by-zero]
>      153 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
>          |                                    ^
>    include/linux/avf/virtchnl.h:844:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
>      844 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/avf/virtchnl.h:844:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_proto_hdrs' is not an integer constant

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
