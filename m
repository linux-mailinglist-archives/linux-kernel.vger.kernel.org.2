Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39DE406B40
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhIJMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhIJMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:15:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7172C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 05:14:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m26so1719451pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 05:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:subject:message-id:mime-version:content-disposition;
        bh=sNHZqX51zHFqUb1YJWg9QJwyqCeOzXRPdRsjUY5I6Ag=;
        b=bC2Ym7PmBYdQuYL34sSgVk9+vw84Hqc1VxjQB+4q3j+c6PZgB2qbSoOm09EsEwDC3P
         3pqTBzd6W7biYNnnSCJT4zYdEqrA7OI7GaPXOA2HUKE5Dwhq+HoDMzBSQT023SB+qV96
         BcLZwzGabNcmim25SNVJsYwZnSb1/+GdtFJblqVlGLMaFvZZ6lmzYiNA/oD2Mp7jFXwm
         /9EyKQSolzAy/UeuSyi4+3jsOoFwQOWkdLpci+BaQ6v/gFJKDzCWdTPtzXqpcIVCVOS6
         Vx2zQKmzzw7e8V/zCDscHVkYZ0mBGG4hEgEMY3jpRl8M+PG9QSbkgIV1rjLernUWehZs
         uNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition;
        bh=sNHZqX51zHFqUb1YJWg9QJwyqCeOzXRPdRsjUY5I6Ag=;
        b=SsEPvTzmjJIFyJuIAcY5J1P/dMDxcZn9Kf8rkU+RRosjC9Iz4LHjYgNWmcuwJVZmd1
         hbSA9Hym7/6QFxRelS/Jl8Yh2Zz8LL9w8UFgzvhIhT7LwNb38/sJR9SETxUdmQ+qKyJb
         +DGx5QvF3V83Iu2M5r1UgxcgaxVmBmhQZJa0WSQL2/v9wVGw5Rdgc4SxqAuUMbn+mFIM
         fbiJ3+kbT/8x6y5cnzvSAw5NtskVwbcIwaXt33XGI188+srbCIBv3c6srEMUtc437jDF
         ImctF+E0qwbDwXI0xdICYTUMNEdkze0acGzhVpxiz1vEa38yM7GTZtS1HHpTvDo7bJ/p
         QeLQ==
X-Gm-Message-State: AOAM533D1T/bs/OKoaeiDJNC1kn94i0CtRSGRxJzpl7yDrZjDg+jH8IQ
        x1Wr+Ki8y8+GCwl9VQAx0iT6SquN9fc=
X-Google-Smtp-Source: ABdhPJwiHhAXDkoi0ZyNcUTMvHDAoy8ENP57u8sblZ675Ua2l23verVId7F2bB71NTzc7sSYpCIUrw==
X-Received: by 2002:aa7:8d10:0:b0:414:ab01:656c with SMTP id j16-20020aa78d10000000b00414ab01656cmr7591632pfe.13.1631276053097;
        Fri, 10 Sep 2021 05:14:13 -0700 (PDT)
Received: from ws2 (node-12h5.pool-101-51.dynamic.totinternet.net. [101.51.194.201])
        by smtp.gmail.com with ESMTPSA id k12sm5347866pjm.52.2021.09.10.05.14.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 05:14:12 -0700 (PDT)
From:   Andreas Bauer <andreas.bauer.nexus@gmail.com>
X-Google-Original-From: Andreas Bauer <Andreas.Bauer.Nexus@gmail.com>
Date:   Fri, 10 Sep 2021 19:14:07 +0700
To:     linux-kernel@vger.kernel.org
Subject: 9pnet_virtio missing dependency
Message-ID: <YTtMD6Zm0FeXIR7m@ws2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

While compiling a minimal qemu kernel 5.14.2 with 9p root fs, I encountered a
problem with the 9pnet_virtio code:

| [    0.553249] 9pnet: Installing 9P2000 support
[...]
| [    0.561547] 9pnet: -- v9fs_mount (1): 
| [    0.562156] 9pnet_virtio: no channels available for device /dev/root

9p_virtio_create() is called and the list of channels in this loop

|        list_for_each_entry(chan, &virtio_chan_list, chan_list) {

turns out to be empty. After instrumenting the code with a few more
debug outputs, it turns out p9_virtio_probe() is not called. I am 
not familiar enough with the code flow to see exactly where the
problem lies.

I think all relevant kernel options are enabled:

| $ cat .config | grep -Ei '9P|VIRTIO' | grep -v "^#" | sort
| CONFIG_9P_FS_POSIX_ACL=y
| CONFIG_9P_FS_SECURITY=y
| CONFIG_9P_FS=y
| CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
| CONFIG_BLK_MQ_VIRTIO=y
| CONFIG_HW_RANDOM_VIRTIO=y
| CONFIG_NET_9P_DEBUG=y
| CONFIG_NET_9P_VIRTIO=y
| CONFIG_NET_9P=y
| CONFIG_VIRTIO_BLK=y
| CONFIG_VIRTIO_CONSOLE=y
| CONFIG_VIRTIO_FS=y
| CONFIG_VIRTIO_INPUT=y
| CONFIG_VIRTIO_MEM=y
| CONFIG_VIRTIO_MENU=y
| CONFIG_VIRTIO_NET=y
| CONFIG_VIRTIO_PCI_LEGACY=y
| CONFIG_VIRTIO_PCI_LIB=y
| CONFIG_VIRTIO_PCI=y
| CONFIG_VIRTIO=y

It seems that there is a dependecy on some other kernel code that is neither
documented nor instrumented in config-logic.

When I compile a distribution kernel (i.e. almost everything compiled in) 
with "localyesconfig" the 9p root fs is found and mounted properly.

What code is missing?

Thanks,

Andreas
