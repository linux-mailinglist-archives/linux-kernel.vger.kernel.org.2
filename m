Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64A83BC4E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 04:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGFCxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 22:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFCxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:53:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CFC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 19:50:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 62so11960176pgf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 19:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lIXqQi/VnPHzZeruihX8nLIui/MmMXv26mgdU/RgQ6M=;
        b=zZFIeq72Wp9m5jNgscZ9Bv9/G1lXEVNNwdHvYk0DF7nojW0FAE/2XWhHrUHiKciIcs
         u266cQvhJOQzJPkLZ3q+TiatY00UaxDxGF5yBHMZ5wE6FcbLIPJR/H/OTZ+Oi45+EV0B
         y4QMPrVYwp9pnzUFhq+hitiWvccthjY1iUDj22y8uNLJDIuF2bGIqEU9VGFG7dPCPRQ4
         n5ysiXl8UvIH5iQcMQZXix39x5zZXvoW7YPkMOVuwNYuNqvYtFUYXZvGmLf/KVHAGzfM
         UUXD7NYPZNQtt/aMwM4mA8KDnt99BJgzXMg9jLqqxWBvdledT01QV/ldWBA5iQ3janQt
         lQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lIXqQi/VnPHzZeruihX8nLIui/MmMXv26mgdU/RgQ6M=;
        b=tuuoRwwipemkU6x0+OnYh+uHl9JtGNilM0RnIhwVyt9FwP2mu8StlgS6EoCq9iWKYD
         7JlEzTyCfctNxXqwqp7f+azI7+wFKP5vXm8oUS6QJ0Pj45sGeXVb7c8eeQP024E0aGC/
         GctOmI2noQ5bvn+JzovjRaJljSm5TbfmfW7yZAukB6mlQuQ12VrOmQLFTFPh0KtocZD1
         JCduwSj5hoAHUE8ifJ0KvMu1MIqjqqgxn3/VBM7jA1gCPtgHdtm5lUv304yJNU2zYK/f
         teSuZ++aR9QfttnAcENsxsI4KKYBjITaCRglGwEEISfEFup2XcZXBuQfkvtw0QKijdbO
         Qb1w==
X-Gm-Message-State: AOAM531nFTew/CyijqeFoRuJbji6ckuBjUD7AYIskZu9D5qOiUFAPmEX
        s2vzMVIlb2hBqHPBif9VIo4x0Q==
X-Google-Smtp-Source: ABdhPJytLcRvjhxn91dZbgaia0xwZwtD1o/tV66+LCngqTZyrWehLbrRGf9o01tWGNXQ2V2v9O0+dQ==
X-Received: by 2002:a63:582:: with SMTP id 124mr18656741pgf.299.1625539853303;
        Mon, 05 Jul 2021 19:50:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q12sm16775395pgc.25.2021.07.05.19.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 19:50:52 -0700 (PDT)
Date:   Mon, 05 Jul 2021 19:50:52 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Jul 2021 18:41:59 PDT (-0700)
Subject:     Re: [PATCH] riscv: Introduce structure that group all variables regarding kernel mapping
In-Reply-To: <20210617135307.1972069-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-25d4bee5-acf1-41f3-8ce4-272faded7946@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 06:53:07 PDT (-0700), alex@ghiti.fr wrote:
> We have a lot of variables that are used to hold kernel mapping addresses,
> offsets between physical and virtual mappings and some others used for XIP
> kernels: they are all defined at different places in mm/init.c, so group
> them into a single structure with, for some of them, more explicit and concise
> names.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/asm/page.h      | 60 ++++++++++--------
>  arch/riscv/kernel/asm-offsets.c    |  2 +
>  arch/riscv/kernel/head.S           |  4 +-
>  arch/riscv/kernel/kexec_relocate.S |  4 +-
>  arch/riscv/kernel/machine_kexec.c  |  2 +-
>  arch/riscv/mm/init.c               | 98 +++++++++++-------------------
>  arch/riscv/mm/physaddr.c           |  2 +-
>  arch/riscv/mm/ptdump.c             |  2 +-
>  8 files changed, 78 insertions(+), 96 deletions(-)

There were some conflicts, but I've fixed them up and put it on 
for-next.

Thanks!
