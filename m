Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2028135B702
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 23:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbhDKV1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 17:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhDKV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:27:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7307C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:27:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso7652047pji.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PVNDzZJZyebCsZPn5zFminUc1ykkQL3Oq73CobiugXo=;
        b=daGbgO06FD0y3yZqFkPlkbxG30REc1PCqGB45ldOYzvfq7QFgqlmMDE5C8RjJIGvh6
         7UO+61A9xXkRYjS/XiaDTJ3FlNJV0NAqJfgXc1Xh71CYEn7DqL7dA5ueSFBUarxYY0x0
         I+p1Z2kKArDrrwLu9HOyTZuBuj9HxhC1X1zmJK3EgtZbvR4cdlocolO8fWIHLtT6I+DV
         nZi6u5UqAF6I/44y9X07nM3yYpa0c4x3Dx4yyM0uLYxCq16igwAFYCyl090PA1A+sG3p
         wk48FgH5+GGRkm4kG8YjhCdHJgFiBMWWJKDyWDXXqQslHuaHLZciy5+z46Y1zGsiecFA
         OMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PVNDzZJZyebCsZPn5zFminUc1ykkQL3Oq73CobiugXo=;
        b=HOSsvoyS6HwNJyjIUO5OZ7e6Qu47LjK/Tt6eZbluSZTBWYzvgAmLTgGHS1YS+nFyRS
         IfV1oaPBbTPl4BuPhZTZirAugT3SW90rt1VxBSuNkXYPIQ7VapI1OmigkfdXaiZK5rX6
         wv2k97pF1s2+jdclyEl9x3s8wbg2R7bFQeE+dDNpRZlhIuaB8EnK5MdJTGXa3lHYTgFi
         F7lNUWuqPblC3aIPHlQ8OUgwDinZGTsLOZTB+CzR3T0lVpg2SvKNhdUNbZvtAygYDSX9
         Fdtb+N1ParS88RP3VwPZlLvEoXoUEnsLmbLmk+2ukQ9mDxjebuTfU2bYWF/cKwQ5mEBY
         8RuQ==
X-Gm-Message-State: AOAM530bRE77nze/wUT7UgW84ClLdf7j/ne+Crfv5O2IyEwTuJ4sLbYi
        6faDxoXI9C7z35/W6bRJHg4j8w==
X-Google-Smtp-Source: ABdhPJwiwdBQAdhDHFHwQCGnLzB0bUJmt+unt3I8hrFL8qAfHwOTT+mw9YnciK4YJQsdSdoUScIMxQ==
X-Received: by 2002:a17:902:9a0a:b029:e6:bf00:8a36 with SMTP id v10-20020a1709029a0ab02900e6bf008a36mr23328948plp.51.1618176453013;
        Sun, 11 Apr 2021 14:27:33 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v126sm7943215pfv.138.2021.04.11.14.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 14:27:32 -0700 (PDT)
Date:   Sun, 11 Apr 2021 14:27:32 -0700 (PDT)
X-Google-Original-Date: Sun, 11 Apr 2021 14:27:00 PDT (-0700)
Subject:     Re: [PATCH 0/3] Fix CONFIG_FUNCTION_TRACER with clang
In-Reply-To: <20210325223807.2423265-1-nathan@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, nathan@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nathan@kernel.org
Message-ID: <mhng-fbfe4121-4626-4641-b596-d027d6cfc50c@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 15:38:04 PDT (-0700), nathan@kernel.org wrote:
> Hi all,
>
> This series fixes function tracing with clang.
>
> Patch 1 adjusts the mcount regex in scripts/recordmcount.pl to handle
> the presence of PLT relocations, which happen with clang. Without this,
> the mcount_loc section will not be created properly.
>
> Patch 2 adds a workaround for clang less than 13.0.0 in relation to the
> mcount symbol name, which was "mcount" rather than "_mcount". This was
> written as a separate patch so that it can be reverted when the minimum
> clang version is bumped to clang 13.0.0.
>
> Patch 3 avoids a build error when -fpatchable-function-entry is not
> available, which is the case with clang less than 13.0.0. This will make
> dynamic ftrace unavailable but all of the other function tracing should
> work due to the prescence of the previous patch.
>
> I am hoping this series can go in as fixes for 5.12, due to patch 3, but
> if not, they can always be backported (patches 1 and 2 are already
> marked for stable).
>
> This series has been build tested with gcc-8 through gcc-10 and clang-11
> through clang-13 with defconfig and nommu_virt_defconfig plus
> CONFIG_FTRACE=y and CONFIG_FUNCTION_TRACER=y then boot tested under
> QEMU.
>
> Cheers,
> Nathan
>
> Nathan Chancellor (3):
>   scripts/recordmcount.pl: Fix RISC-V regex for clang
>   riscv: Workaround mcount name prior to clang-13
>   riscv: Select HAVE_DYNAMIC_FTRACE when -fpatchable-function-entry is
>     available
>
>  arch/riscv/Kconfig              |  2 +-
>  arch/riscv/include/asm/ftrace.h | 14 ++++++++++++--
>  arch/riscv/kernel/mcount.S      | 10 +++++-----
>  scripts/recordmcount.pl         |  2 +-
>  4 files changed, 19 insertions(+), 9 deletions(-)

Thanks, these are on for-next.
