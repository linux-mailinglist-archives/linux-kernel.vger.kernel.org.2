Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2CC40755D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhIKHLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 03:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbhIKHLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 03:11:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C82C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 00:10:38 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 22so4683207qkg.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 00:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TLUu2TW17WePa2uT7aMSXI4fMfRRRl6A0I6wwN4rBLA=;
        b=yhx60stAL79tINsIZNq9HvW3r8zJl+z+dpiQaAYzrplcIYXLVNToDqax1pkRnoMVLt
         BZzG0bqy77XPfXRAb7jMFiKPUdAtFQsXWi7V/0eqZzHuadZs02j1N5oOlYysMT/S52lb
         N9I61ZzHH945yLGD0wlrEHCx+kncV3JNWy6VXnrD5L3K0vnpOQXW5mJc+82i0/z6k/lS
         4DqAYCx92MA+W+yVo75EKUiu4dCd/K4GSMUOeZ6pbPYQxiUYDN8QypEQ1gXGXwMRc5hk
         YCf2vVsxMw9Kis8tB2QiplXHEokVImQ7Pf+P7A2nIE6THBsfTkKKRwQHBlXQN/gHpu2R
         3W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TLUu2TW17WePa2uT7aMSXI4fMfRRRl6A0I6wwN4rBLA=;
        b=Gqa6TdyUByR8CWtMerDiY4ksxlR/ocrpJ3vDFm63noHf4M5Vinj/YB2dFbED77kwUV
         qPrrHpiEPMr1PJr9Pr2PTLIpNl4uv4pFky7xv58MBaIO2pxqFCDUEOn6JPhXBgg1rfgC
         FLCxnMUzXAclvgbrWYxD9noslLg+5xM+jTuEqqqap3GjdEmICvm+kwBWC8bC4Wvu8EDE
         86urk56+bpXtL2Z8WH47xYPS2nhbCBg3PXy3d5yD0FBvzUt6JH0Ulvjr1mv9WjLk3CBE
         k+UUl07YyijcndQUoO6b//araenikERwaY8C3h0xNnFTMvQcqkJo3a04ZbqNwIikDyy0
         DgbQ==
X-Gm-Message-State: AOAM530UulmNEXWx36gc07tbGTasqKEumE3gHfg/nlNhSOrL7Iz5/7sy
        iZoEDKzqO4ybnGHBZTzCppoWkw==
X-Google-Smtp-Source: ABdhPJwfIJDzi6ZwZlGwHW0B+569UQ/uXsNddAkoflOOoDFHk/10nZFVm1aGp63owpHyXX26vlh8Ig==
X-Received: by 2002:a05:620a:21dc:: with SMTP id h28mr1006816qka.198.1631344237711;
        Sat, 11 Sep 2021 00:10:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w11sm711653qkp.49.2021.09.11.00.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 00:10:37 -0700 (PDT)
Date:   Sat, 11 Sep 2021 00:10:37 -0700 (PDT)
X-Google-Original-Date: Sat, 11 Sep 2021 00:09:03 PDT (-0700)
Subject:     Re: [PATCH v2 0/2] riscv: improve __ex_table section handling
In-Reply-To: <20210826220952.77a68a9e@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-a8170a93-117d-4496-b3ff-eb003540d54a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 07:09:52 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Enable BUILDTIME_TABLE_SORT to sort the exception table at build time
> then move exception table to RO_DATA segment.
>
> Since v1:
>   - Only enable BUILDTIME_TABLE_SORT for MMU. Thank Palmer for catching
>     tinyconfig case.
>
> Jisheng Zhang (2):
>   riscv: Enable BUILDTIME_TABLE_SORT
>   riscv: Move EXCEPTION_TABLE to RO_DATA segment
>
>  arch/riscv/Kconfig                  | 1 +
>  arch/riscv/kernel/vmlinux-xip.lds.S | 1 -
>  arch/riscv/kernel/vmlinux.lds.S     | 4 ++--
>  scripts/sorttable.c                 | 1 +
>  4 files changed, 4 insertions(+), 3 deletions(-)

Thanks, this is on for-next.
