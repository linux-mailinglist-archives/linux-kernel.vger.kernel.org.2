Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B947D428945
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhJKJBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhJKJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:01:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFCAC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:59:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e12so53733257wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bB6fj532wb+JO4nJ5BLn022sxf/qsNnxe1VlevforV4=;
        b=UsCdKQ9WMdeDfS/GLg+f8Mehv+uNFDorbyhYkzfi89yfitonIgNdXi+q5x9lGKzha2
         9p341Xn6t3ZR3x/PuKyq8iJUA+kmNJfl1AbaRJ3USGm8CpPl/k/nn0hsxTHaORrafeFk
         p7V+yd7el3144oP+z9C9tIBhn5RompqwYIeLC/CQKKxlX2uaSGddkhcPh84ebAeTPGJz
         OeaGTB4VELcko6/Pztw1fCNEvZw591Z89HM7SOy78uWMJzGr2JeYoGhQg8QnCua1J6fp
         Er1eiPvqJY3SCLx4Ih3GcF5KxIfX4GldEjrQDn0WZ8El4/JdJvJyJLpsigyBM11YNWDX
         F7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bB6fj532wb+JO4nJ5BLn022sxf/qsNnxe1VlevforV4=;
        b=MmlZm/Gud1+KkPK+g6P8xmitHWlMVJTu3WvRMwM67y7j1ghX34HljPyCPgxhDQ6d5q
         0xYF1cr3r/XtNUybdGhBq36XnmX49kh0g+GP+MBxGmxmwKsbpKTledPw+30m3TrWMPJo
         C16wdz1nQyw/p6g2FhYTEwhyNfxjoxVveugZvzA1LdJBHg7XhmQ+BW7dasOso0QPPH/L
         P7nILmr6VT/1Isb0UFTNcJ9w41yn4rFGEuq7OcqpKhFngmoxiXUkhSchhslnP5Oee1lo
         eE0Y/ZWAPiY2rN3puB0TP3fTyxeEcsiYU+fXW6vQ4QR2BSVmV6zJpfh6/OXgEjEQqVQR
         SNvA==
X-Gm-Message-State: AOAM532e/ZSNF+BCKr2UXSKeCvlJtw3Gh6EE926oLiSiQ24qpXkt10Dp
        /GlWZnOw0U+Zvk1DUnUb2FL3DNhF1i48aTanV3h+lA==
X-Google-Smtp-Source: ABdhPJx5c793M0enYYZiO/+67gFDHwQRiRQJK8uowb7v6iPYNSXpwhsBODazP+17mf4ruFPb99wLQogl0Y72H/nd4zY=
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr12150106wmq.5.1633942742048;
 Mon, 11 Oct 2021 01:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <202110082349.Bb8M3OPU-lkp@intel.com>
In-Reply-To: <202110082349.Bb8M3OPU-lkp@intel.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Mon, 11 Oct 2021 10:58:26 +0200
Message-ID: <CAJX1YtbZTNn8Y3zLnBvnBNX_1b14Y-RDnJovcHtGmLhiPV2xxw@mail.gmail.com>
Subject: Re: [axboe-block:perf-wip 13/20] drivers/block/rnbd/rnbd-clt.c:1226:27:
 error: initialization of 'int (*)(struct blk_mq_hw_ctx *, struct io_batch *)'
 from incompatible pointer type 'int (*)(struct blk_mq_hw_ctx *)'
To:     Jens Axboe <axboe@kernel.dk>, Jinpu Wang <jinpu.wang@ionos.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 5:14 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git perf-wip
> head:   ba7751cd7411b7aaffd07728bd7cd6eeb890865d
> commit: c5b891d342f43c8e486be3aeacd5ee61298d3561 [13/20] block: add a struct io_batch argument to fops->iopoll()
> config: h8300-randconfig-r004-20211008 (attached as .config)
> compiler: h8300-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=c5b891d342f43c8e486be3aeacd5ee61298d3561
>         git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>         git fetch --no-tags axboe-block perf-wip
>         git checkout c5b891d342f43c8e486be3aeacd5ee61298d3561
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=h8300
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> drivers/block/rnbd/rnbd-clt.c:1226:27: error: initialization of 'int (*)(struct blk_mq_hw_ctx *, struct io_batch *)' from incompatible pointer type 'int (*)(struct blk_mq_hw_ctx *)' [-Werror=incompatible-pointer-types]
>     1226 |         .poll           = rnbd_rdma_poll,
>          |                           ^~~~~~~~~~~~~~
>    drivers/block/rnbd/rnbd-clt.c:1226:27: note: (near initialization for 'rnbd_mq_ops.poll')
>    cc1: some warnings being treated as errors
> --
> >> drivers/nvme/host/tcp.c:2457:27: error: initialization of 'int (*)(struct blk_mq_hw_ctx *, struct io_batch *)' from incompatible pointer type 'int (*)(struct blk_mq_hw_ctx *)' [-Werror=incompatible-pointer-types]
>     2457 |         .poll           = nvme_tcp_poll,
>          |                           ^~~~~~~~~~~~~
>    drivers/nvme/host/tcp.c:2457:27: note: (near initialization for 'nvme_tcp_mq_ops.poll')
>    cc1: some warnings being treated as errors
>
>
> vim +1226 drivers/block/rnbd/rnbd-clt.c
>
> 2958a995edc946 Gioh Kim  2021-04-19  1221
> f7a7a5c228d45e Jack Wang 2020-05-11  1222  static struct blk_mq_ops rnbd_mq_ops = {
> f7a7a5c228d45e Jack Wang 2020-05-11  1223       .queue_rq       = rnbd_queue_rq,
> f7a7a5c228d45e Jack Wang 2020-05-11  1224       .complete       = rnbd_softirq_done_fn,
> 2958a995edc946 Gioh Kim  2021-04-19  1225       .map_queues     = rnbd_rdma_map_queues,
> 2958a995edc946 Gioh Kim  2021-04-19 @1226       .poll           = rnbd_rdma_poll,
> f7a7a5c228d45e Jack Wang 2020-05-11  1227  };
> f7a7a5c228d45e Jack Wang 2020-05-11  1228
>
> :::::: The code at line 1226 was first introduced by commit
> :::::: 2958a995edc94654df690318df7b9b49e5a3ef88 block/rnbd-clt: Support polling mode for IO latency optimization
>
> :::::: TO: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> :::::: CC: Jens Axboe <axboe@kernel.dk>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


Hi Jens,

Regarding the warning email from the Kernel test robot as above,
you might be able to fix it with the patch below.

The ib parameter is not used in rnbd_rdma_poll and it could generate
an unused variable warning
when compiling it. I think you could handle it as you fix other source code.

----------------------------------------------------- 8<
-----------------------------------------------
diff --git a/rnbd/rnbd-clt.c b/rnbd/rnbd-clt.c
index ea59999..be47f2f 100644
--- a/rnbd/rnbd-clt.c
+++ b/rnbd/rnbd-clt.c
@@ -1181,7 +1181,7 @@ static blk_status_t rnbd_queue_rq(struct
blk_mq_hw_ctx *hctx,
        return ret;
 }

-static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx)
+static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *ib)
 {
        struct rnbd_queue *q = hctx->driver_data;
        struct rnbd_clt_dev *dev = q->dev;
