Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3C3896F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhESTqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:46:18 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:36569 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhESTqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:46:18 -0400
Received: by mail-vs1-f45.google.com with SMTP id x2so1272775vss.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzHnfUg1666M53V2yggFr2S/ZKrY9fE36CiKlPgQZwo=;
        b=i0pdzaagWJzQRZMqweSN07S3sMzpNQnpmFPBC2uAAi9tLL3dYYyXGA8i9RI9ErC5Em
         EJL0YKJH1sNTjMe7yz0+txdLSU4TntR5o037vUJfc0gdeyUO2XaUw5gyPaeHN8Oz8sGc
         CYlAH+Rzw6GUFPSPe1AAH26UWOaxsz6KcQBoSP5otXrrIAyWP8LPyAL5jOZafgCgjESx
         oxzftJZqTG19pSWdmp6lqrBaNFIWJuBOHECh1knT3Pyx+/P0+wYVKRcGCHmh+6XzYfZl
         HmlJqcHT5+Oun3RUUiq6mDG39pup4DKiF5TdS8E7jzHGQS9fc+f05yge0M+ABeeFLcnj
         KspA==
X-Gm-Message-State: AOAM533rmKEYF6NnfYFhYBqJjHXM1P7l+PM/GZ6pAQmHiZ0X/FgnF6V3
        LwzWCilsVef1d8826LH0wZ6wIhivIc3s6x94ozM=
X-Google-Smtp-Source: ABdhPJz5lf1iSCtWGg5T5cyRjJahGfg7EhfK6ZgoFfGK4xLIPLQveJFRrIK0qJBzGGqlY+C0FQz1ieC03GUYWfFOD/8=
X-Received: by 2002:a67:fb52:: with SMTP id e18mr997473vsr.18.1621453497630;
 Wed, 19 May 2021 12:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <202105190411.YxwxfdYw-lkp@intel.com>
In-Reply-To: <202105190411.YxwxfdYw-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 May 2021 21:44:45 +0200
Message-ID: <CAMuHMdUBKS-CN6Y7vhk_=+33FO6M8NQ0KT0w=2Br+dpzQ4ce=g@mail.gmail.com>
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

On Wed, May 19, 2021 at 8:36 PM kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f
> commit: 222a8ab01698148c00c271cda82d96f4e6e7b0a8 ice: Enable RSS configure for AVF
> date:   4 weeks ago
> config: m68k-randconfig-r025-20210519 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=222a8ab01698148c00c271cda82d96f4e6e7b0a8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 222a8ab01698148c00c271cda82d96f4e6e7b0a8
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
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
>      844 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);

On m68k, integers are aligned to an address that is a multiple of 2 bytes.

struct virtchnl_proto_hdrs lacks explicit padding.
Patch sent: https://lore.kernel.org/lkml/20210519194350.1854798-1-geert@linux-m68k.org/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
