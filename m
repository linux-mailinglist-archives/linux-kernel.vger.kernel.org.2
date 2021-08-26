Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85D3F82B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbhHZGrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbhHZGru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:47:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D19C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:47:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x16so1942024pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IfBQ9EQzqzyBufGLfayWB/BJYht5LPZwpL5oj1Hp0nE=;
        b=ko9rI9c02DG8tUV3UZ4LLccgE4AJB8nGYFDS6AJvgTUZUAFTvAVtZ0ZHp1A2xZF6Fl
         cKdhqouTOATo01CqdK27oiKOWDt0xxdqVpDIbYcZcIKSb7vOwK1+T2DhA3ZIrwLq4R9e
         6Ds3ub596c5L7iZNhK5LojA0pvQ3fDGUthgXidz1+G1ABqgFOfa9qaYKYO7/lrzHdYck
         DGX6I4sKPiOPgpf2WIiv2ODwYgArWUF9G+neuqKFxuwZn1qgAcuiV3VPAEvYRT1xjpfJ
         uGid1Aqg1Y5H0ZBIZHedHUeTG3I0/VkxMiTH03yT+hJTJDe2Xf7uqU7kvXEfs6o59Jqh
         dUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IfBQ9EQzqzyBufGLfayWB/BJYht5LPZwpL5oj1Hp0nE=;
        b=bIX2wRPsRVLdLSDqlKenRvNP0dd5Eb66MxrWeUTk68AeASj7Zo6VT8zzwA2PJAslZS
         sKOQhUzQoYfAUkt2aiF1VYivK1fM5Pou5Dsh5upN+7cEOM8uZCmKWbaoPgxkEeAiCdbW
         sVEE5EBgOv6D3ErG9RvB7e+ds+vCX/t3pf7NK/XJFm6F65jXuzViGgN81TXsqPTbgb1H
         3KBz9SdL8RBul/cc4He5NDeDgw3V5Oo0Sm2h3GUFDEaoGAvbyWbtFj+f/RwCdA0rUUgJ
         jpmCQxCb/x/glQOyGVm79d0Eldhqhn6sBjwRKSt/KxFSnPGOj8jlY0TePJeIhIWPctPM
         RkyA==
X-Gm-Message-State: AOAM5308SF92ZP5jwis3ys92YpD/BYzjEsUsBfcVbkQbTqyuRrouXq14
        8P+iGy52mtAE/d3Wf3eUryNoig==
X-Google-Smtp-Source: ABdhPJz1Q0tOaDM1WwAdmpawbok0FA0f+AvBAlnQ6E00NrGszhDhvia9YYddDR5U8DMb9twpGx8nWA==
X-Received: by 2002:aa7:8c44:0:b0:3f1:ec34:6438 with SMTP id e4-20020aa78c44000000b003f1ec346438mr2278174pfd.6.1629960423223;
        Wed, 25 Aug 2021 23:47:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h9sm8334865pjg.9.2021.08.25.23.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 23:47:02 -0700 (PDT)
Date:   Wed, 25 Aug 2021 23:47:02 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Aug 2021 23:47:00 PDT (-0700)
Subject:     Re: [PATCH 0/2] riscv: improve __ex_table section handling
In-Reply-To: <20210809012509.4983c1d6@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-1d66757a-1be0-4e46-8bbc-0568ceddfeb3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Aug 2021 10:25:09 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Enable BUILDTIME_TABLE_SORT to sort the exception table at build time
> then move exception table to RO_DATA segment.
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

This seems reasonable, but it's failing for some configurations (at 
least tinyconfig) saying there is no __ex_table.  I'm not entirely sure 
how that comes about, as we've got them for futexes and uaccess.

Maybe the right thing to do here is to fix scripts/sorttable.c so it can 
handle files with nothing to sort?  I think it's just as simple as a 
successful early out like this

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a2baa2fefb13..207ddeddb506 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -294,8 +294,9 @@ static int do_sort(Elf_Ehdr *ehdr,
                goto out;
        }
 #endif
+       /* If there is no __ex_table section there is no work do to. */
        if (!extab_sec) {
-               fprintf(stderr, "no __ex_table in file: %s\n", fname);
+               rc = 0;
                goto out;
        }

I'm not entirely sure though -- my logic is essentially just "there's no 
__ex_table, so there's nothing to sort, so just don't try".

All the configurations I can actually boot have an __ex_table, so I'm 
not sure how to test that.
