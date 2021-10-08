Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961DD4265CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhJHIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:21:21 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:39906 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhJHIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:21:07 -0400
Received: by mail-vs1-f49.google.com with SMTP id o124so9657108vsc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gg7lBTIPit3lUNNJVWOU9jnb+0tJG1WIFFCc1E/oFJ4=;
        b=ztljTJMo239shqhDlpLvNhsQWBCFqrEbaZoIGCfkFmR4EfbPYIntEPYeSZ+sBH4w0Z
         mJ93swCyb5LXKdWrEauHXM2AVsxU0Hb/3/BI3XewLU3wbh6C0PIWSbTDsccRAr8fWAqo
         S5/JYsOHhKP3hXbsVM5pLKTL4sh2mkvMwMgdjR+7keEWeCTmfDssCwzG7i6J1s2T1dc+
         ILkUzOStTsvBCyYdgiHtXQCdiz0jlfOoiNtchSDzO62sEKKlgcPj+qPWbIb0lpok159R
         m11RfAP6cChgkaQyic43tQBBLxeq5VO42MSqsC9B8jOZ/7jlJ6gsuFAv8NDTh8EQZgeU
         o/mA==
X-Gm-Message-State: AOAM533mmpy/f0oEVA8iIwTyxFpGzeuXHtGtNzILBGPBcbRmqKJOWToR
        W5OdqGMkM7ZUQ7hmaVPxOZe3qBrtzkX6BXx4TDRLBM7lLws=
X-Google-Smtp-Source: ABdhPJyV1qjQefc4/emCH6ngN1yofbjJ6V6ktafpmynk+H+PV2tNLlkkd/RRxYPZ4X1Vaod27siWdrovs2hsngfOWi8=
X-Received: by 2002:a67:ac04:: with SMTP id v4mr9270948vse.50.1633681152262;
 Fri, 08 Oct 2021 01:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <202110080434.YH6r4WZv-lkp@intel.com>
In-Reply-To: <202110080434.YH6r4WZv-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Oct 2021 10:19:00 +0200
Message-ID: <CAMuHMdUoh0PbLDU1_Drce=cQorv6M47i4pLDE9DtSOmsYOD9AQ@mail.gmail.com>
Subject: Re: [axboe-block:nvme-passthru-wip 10/19] drivers/nvme/host/ioctl.c:47:19:
 error: cast to pointer from integer of different size
To:     kernel test robot <lkp@intel.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 12:12 AM kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git nvme-passthru-wip
> head:   9c18980ac90053bcdb21594eae48935d89bf389c
> commit: 5cc445dd8df6e06f3482711aa590170450364393 [10/19] nvme: wire-up support for async-passthru on char-device.
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=5cc445dd8df6e06f3482711aa590170450364393
>         git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>         git fetch --no-tags axboe-block nvme-passthru-wip
>         git checkout 5cc445dd8df6e06f3482711aa590170450364393
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/nvme/host/ioctl.c: In function 'nvme_pt_task_cb':
> >> drivers/nvme/host/ioctl.c:47:19: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>       47 |         ptcmd64 = (void __user *) bcmd->unused2[0];
>          |                   ^
>    drivers/nvme/host/ioctl.c:62:58: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>       62 |                 struct nvme_passthru_cmd __user *ptcmd = (void *)bcmd->unused2[0];
>          |                                                          ^
>    drivers/nvme/host/ioctl.c: In function 'nvme_ns_async_ioctl':
>    drivers/nvme/host/ioctl.c:472:29: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>      472 |         void __user *argp = (void __user *) bcmd->unused2[0];
>          |                             ^
>    cc1: all warnings being treated as errors
>
>
> vim +47 drivers/nvme/host/ioctl.c
>
>     39
>     40  static void nvme_pt_task_cb(struct io_uring_cmd *ioucmd)
>     41  {
>     42          struct uring_cmd_data *ucd;
>     43          struct nvme_passthru_cmd64 __user *ptcmd64 = NULL;
>     44          struct block_uring_cmd *bcmd;
>     45
>     46          bcmd = (struct block_uring_cmd *) &ioucmd->pdu;
>   > 47          ptcmd64 = (void __user *) bcmd->unused2[0];

Casts from u64 to a pointer on 32-bit need an intermediate cast to uintptr_t:

    ptcmd64 = (void __user *)(uintptr_t)bcmd->unused2[0];

Note that you can improve on the naming, as people may be surprised
discovering "unused2" is actually used ;-)

>     48          ucd = (struct uring_cmd_data *) nvme_ioucmd_data_addr(ioucmd);
>     49
>     50          if (ucd->meta) {
>     51                  void __user *umeta = nvme_to_user_ptr(ptcmd64->metadata);
>     52
>     53                  if (!ucd->status)
>     54                          if (copy_to_user(umeta, ucd->meta, ptcmd64->metadata_len))
>     55                                  ucd->status = -EFAULT;
>     56                  kfree(ucd->meta);
>     57          }
>     58          if (likely(bcmd->ioctl_cmd == NVME_IOCTL_IO64_CMD)) {
>     59                  if (put_user(ucd->result, &ptcmd64->result))
>     60                          ucd->status = -EFAULT;
>     61          } else {
>     62                  struct nvme_passthru_cmd __user *ptcmd = (void *)bcmd->unused2[0];
>     63
>     64                  if (put_user(ucd->result, &ptcmd->result))
>     65                          ucd->status = -EFAULT;
>     66          }
>     67          io_uring_cmd_done(ioucmd, ucd->status);
>     68  }
>     69
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
