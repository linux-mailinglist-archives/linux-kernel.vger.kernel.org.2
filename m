Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9975845E6EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhKZEqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbhKZEoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637901652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KXDnhWi2lUYPDK6SyEW/Lwdc8ugbHrrHb9AhpqrT7Ds=;
        b=a1ZDuy2e8F+97Qy5Na5eBI2qWjr0uja5/AW2ILq26Tr2FoJq93thrHcPaXpBXa3jHF04L8
        mm8iAbZKmTp2lYBVzwFAHj4mlfjPsNSjb5aJ1yyyoC3xDMdJvT3i9wudrJzOEkgZl+DTYe
        DSXF0ZebIi+4V+XBPFw3hgTplz0PZks=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-TMWfBDz1Mv2e8tqPM5i9Og-1; Thu, 25 Nov 2021 23:40:51 -0500
X-MC-Unique: TMWfBDz1Mv2e8tqPM5i9Og-1
Received: by mail-lj1-f198.google.com with SMTP id a7-20020a05651c210700b00219132ab503so2710106ljq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 20:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXDnhWi2lUYPDK6SyEW/Lwdc8ugbHrrHb9AhpqrT7Ds=;
        b=rTr5ugMURN6Zn5VXyu2Ba3x4ufpQOc6Pw9cqWVmqPR9+vwLX3s0CC0hQxmh6z1oTLF
         GFGoygLFkZt7qiHAV3lM1cEAoVp38ErmsHqSSbdoa5yvUfR3bmjQXH0F1989/A+7i790
         TRIjXHfXOrtG8A2M2XeP02VzuZOKaH7lRzRxltsYDblvjpW9jWemucoDw1MqxJNRRDhR
         FI7y+2iAjCBzStARo3t4GG7RvE/XFAYdUQwr/AKyWc5lJxRv7J1bgt7Nu76Ek2yNl40F
         j8aEJO4trOk5zCGs742lo63l6VhFJP1sCSD+DhaK38jDvPSyMBLTIhRqz2HnO9oP+f8Q
         iCxw==
X-Gm-Message-State: AOAM531VMZ0ZdFP3qpjRZpDSc1ERJJub8X5GAL+yIZxmJ0Hf1fBZTAvy
        XCU+nG4Wcr1dHs8h0C4Szk98k/lpz9ecwopb4HHVZY+dtL77gpjWejEQUYpImZIwSRCENeN4b+v
        eOY1eYLhW00xkmtO2OZ02spbKmSPh0zjskkg9vu1b
X-Received: by 2002:a2e:2ac1:: with SMTP id q184mr29135775ljq.420.1637901649403;
        Thu, 25 Nov 2021 20:40:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9I5mU3QuZFkDuRPx0Xw0T8Go262yO+nZT2CPCiRrJPdz2yhCYrQfj1jDQiyWXOOYvCeOvH2AKgtNQcLIDrW8=
X-Received: by 2002:a2e:2ac1:: with SMTP id q184mr29135753ljq.420.1637901649134;
 Thu, 25 Nov 2021 20:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20211125063034.12347-1-jasowang@redhat.com> <202111252001.Z5tli1Np-lkp@intel.com>
In-Reply-To: <202111252001.Z5tli1Np-lkp@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 26 Nov 2021 12:40:38 +0800
Message-ID: <CACGkMEuOGR9K4Nq++EG9RzE3F7G6Rj9P0kkOyrJHm=K-Vap9Ow@mail.gmail.com>
Subject: Re: [PATCH] virtio-mmio: harden interrupt
To:     kernel test robot <lkp@intel.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 8:08 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Jason,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.16-rc2 next-20211125]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

Will fix this in V2.

Thanks

>
> url:    https://github.com/0day-ci/linux/commits/Jason-Wang/virtio-mmio-harden-interrupt/20211125-143334
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5f53fa508db098c9d372423a6dac31c8a5679cdf
> config: mips-buildonly-randconfig-r003-20211125 (https://download.01.org/0day-ci/archive/20211125/202111252001.Z5tli1Np-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://github.com/0day-ci/linux/commit/e19a8a1a95bd891090863b2d6828b8dc55d3633f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Jason-Wang/virtio-mmio-harden-interrupt/20211125-143334
>         git checkout e19a8a1a95bd891090863b2d6828b8dc55d3633f
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/virtio/virtio_mmio.c:105:6: warning: no previous prototype for function 'vm_disable_cbs' [-Wmissing-prototypes]
>    void vm_disable_cbs(struct virtio_device *vdev)
>         ^
>    drivers/virtio/virtio_mmio.c:105:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void vm_disable_cbs(struct virtio_device *vdev)
>    ^
>    static
> >> drivers/virtio/virtio_mmio.c:121:6: warning: no previous prototype for function 'vm_enable_cbs' [-Wmissing-prototypes]
>    void vm_enable_cbs(struct virtio_device *vdev)
>         ^
>    drivers/virtio/virtio_mmio.c:121:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void vm_enable_cbs(struct virtio_device *vdev)
>    ^
>    static
>    2 warnings generated.
>
>
> vim +/vm_disable_cbs +105 drivers/virtio/virtio_mmio.c
>
>    103
>    104  /* disable irq handlers */
>  > 105  void vm_disable_cbs(struct virtio_device *vdev)
>    106  {
>    107          struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>    108          int irq = platform_get_irq(vm_dev->pdev, 0);
>    109
>    110          /*
>    111           * The below synchronize() guarantees that any
>    112           * interrupt for this line arriving after
>    113           * synchronize_irq() has completed is guaranteed to see
>    114           * intx_soft_enabled == false.
>    115           */
>    116          WRITE_ONCE(vm_dev->intr_soft_enabled, false);
>    117          synchronize_irq(irq);
>    118  }
>    119
>    120  /* enable irq handlers */
>  > 121  void vm_enable_cbs(struct virtio_device *vdev)
>    122  {
>    123          struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>    124          int irq = platform_get_irq(vm_dev->pdev, 0);
>    125
>    126          disable_irq(irq);
>    127          /*
>    128           * The above disable_irq() provides TSO ordering and
>    129           * as such promotes the below store to store-release.
>    130           */
>    131          WRITE_ONCE(vm_dev->intr_soft_enabled, true);
>    132          enable_irq(irq);
>    133          return;
>    134  }
>    135
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

