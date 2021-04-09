Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE80C35946C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhDIFSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhDIFSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:18:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99EC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 22:18:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so6663182ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YFWCdm8gK/rxc5k1ld9Wf9KmQQO/U3GJZHseXv0RvhU=;
        b=blihwRCH6BPRaNb6n+4GjpRzJe0CLY+voSb/0Q6RtjNKxbyFuYxgiXJW8ZAD5xp8y/
         KVm2LokvqO+3o5TUyFf8bY5PV5xcwkglds0fmNpyeidH4JnLq/NDnyZKr9gZgKF1Y5MQ
         RnUpx4pGJY1U42VsARWS8CnFv8LNF8zmssAf7tjpgtLIxsPq33rqx1X6hg30wGNRE9FP
         ybInYJqEOjgQ3en+oyp+wHdFkTgAjFZwqG9b3qdGsdvz4EW3g2/O75VaLUmsuh4reeqg
         fA6Je1xnivfCdmwPoj2Sr5Oza3xW4vDu7XCNUyaUAtZeMrZ63yZNbrXrWs0lxHzABaWQ
         Wf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YFWCdm8gK/rxc5k1ld9Wf9KmQQO/U3GJZHseXv0RvhU=;
        b=Y8umLVNDXakd0+DTEf7vr2ef9kSH37IOmEqrFwA81A845MH/ozuFzgDI1+HMwhzDSS
         VRNGHPjqpjEPKQ1CNEqEimNC0F9QJzR9FyqVbaS4QrzQmqDixosmCxOH8gNBbr0B/z/f
         Uv+xoKMNgGsRcPpT2rP4RhiWkkbTLmxVbGeYYvqABIm8L7v5xTDEANdfRomeKF/UQpwi
         QUMI3v5cAviOOG8Zy/qj6udxJPniSO8b4y8Aab84kE9dQrbWL8WjcTt9nNt0BiCYJLj5
         zsbAwOXEnxW+ybYu1uHUioeazDWK9g8+a/G2T7lbbIOBGwTSDRrZPH0mXzn4ekcGg+t4
         ZDXg==
X-Gm-Message-State: AOAM531KcJpvf+95S3a/wk46G6hK2dX4zDGylUFsaKCdivghYEMlIOen
        dXdqUX1VksuTlH2dVHgocc7IsUP/FaXb1k5FUEutfg==
X-Google-Smtp-Source: ABdhPJyAYw1Bwp6jKS3SxG1Cpit61Ggd/8J/n4HfRANmqtGHieko6wg1KVMUr2Vgr1/f6WKlkLzH8EYHgXzT2zuWwVo=
X-Received: by 2002:a17:906:9605:: with SMTP id s5mr14703271ejx.287.1617945483617;
 Thu, 08 Apr 2021 22:18:03 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Apr 2021 10:47:52 +0530
Message-ID: <CA+G9fYtNAEwCk1WkA_25FVUrR0QJ2vt2Dh_w+m-QOSjb8f5TBQ@mail.gmail.com>
Subject: [next] drivers/cdrom/gdrom.c:586:61: error: 'rq' undeclared (first
 use in this function)
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next tag 20210408 architecture sh builds failed due to these errors.

# to reproduce this build locally:

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=sh
CROSS_COMPILE=sh4-linux-gnu- 'CC=sccache sh4-linux-gnu-gcc'
'HOSTCC=sccache gcc'


In file included from /builds/linux/include/linux/scatterlist.h:9,
                 from /builds/linux/include/linux/dma-mapping.h:10,
                 from /builds/linux/drivers/cdrom/gdrom.c:16:
/builds/linux/drivers/cdrom/gdrom.c: In function 'gdrom_readdisk_dma':
/builds/linux/drivers/cdrom/gdrom.c:586:61: error: 'rq' undeclared
(first use in this function)
  586 |  __raw_writel(page_to_phys(bio_page(req->bio)) + bio_offset(rq->bio),
      |                                                             ^~

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Regressions found on sh:
  - build/gcc-9-dreamcast_defconfig
  - build/gcc-10-dreamcast_defconfig
  - build/gcc-8-dreamcast_defconfig

--
Linaro LKFT
https://lkft.linaro.org
