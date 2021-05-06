Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A037500D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhEFHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhEFHWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:22:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0242C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 00:21:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i190so4409285pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lbxT9JE2Zk0VsYZm9R/5bovS6f3gMaWpUE1yp11zmUE=;
        b=Rgfu2TxC+4wdMxzX+gXPdo/LNPnY1TASuOKSaupHg1sIF+v2qlg1kzdXCWIskOiVIV
         9+26gI8AHn693ycr+FVZAmV3ePWk+yYjCmhhuwd8VYEZWTFHXiJ5JBnkaNUVj6mHUi+e
         C9B7YlckwiYcDoPxVRwGAzqdcPj1tTylTdHLHoILgQv7zh1JJrul0OIjiYPBKVjJl1fa
         Yh+EW8GMFU7VeLIL+ROG2hiOOkoHu0+Ub+JaVuxbSHvlOvt9ir/anVuYdkD13qxAmQW/
         SQCp3rSBvJc5YSZj7R8YZ/ucsdAtkH6awkzK6sU/SY/Do86Oa6YYr5CXwc9ifoqSCM/O
         X2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lbxT9JE2Zk0VsYZm9R/5bovS6f3gMaWpUE1yp11zmUE=;
        b=cZDktlIxj/bNL8+VotM7cgBjhq8omQ3q+ZzVJUNhcHfgKnAclu1+PgL+FCum4NzYa2
         UtGa632ctYqQdKFdy9e3vTm4N7F4mz1wuS6RFKQKMnbmJhhPJMXJotozGdqjaV5isyuH
         MBq1EJX2keEDbPSr7AeKmt0I6sbCwUSgwEYjerBj05q+elpknKJQ4EZn+qC/zwfOFMur
         /DQ1ipZGOE88lt1W7KhF3zL6VAIM0WU7vMXxeG25exJy6D8zAsJHXJ0qRp3x8xSY1NVo
         8vXR/RTPNcPABNHbwbVpU1ojW6pT1RjwB7NhYu5+8VhfKUFmewp1PKkaChe3t6IKX75u
         UWvQ==
X-Gm-Message-State: AOAM533PdIvVlhq9F8syrxpc0XG3jSs/Y61MaBhJBgEZpYA9cMMcSsHH
        7EC1f7FR69mJEAzNqSsIVjlLdA==
X-Google-Smtp-Source: ABdhPJxI+IbNREub46SVx4m/dhNt5IU46jqy3805QxMVFQFVN6ypsSmat4roE2oFBU3yTep/kDNcgA==
X-Received: by 2002:a62:f84a:0:b029:245:17e4:bde2 with SMTP id c10-20020a62f84a0000b029024517e4bde2mr2970540pfm.64.1620285667383;
        Thu, 06 May 2021 00:21:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l10sm1254085pfc.125.2021.05.06.00.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:21:06 -0700 (PDT)
Date:   Thu, 06 May 2021 00:21:06 -0700 (PDT)
X-Google-Original-Date: Thu, 06 May 2021 00:21:04 PDT (-0700)
Subject:     Re: [PATCH -next 0/4] THP supprt for RISCV
In-Reply-To: <20210430082850.462609-1-sunnanyong@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunnanyong@huawei.com
Message-ID: <mhng-928f0261-e0ef-4cf8-954e-8cd950cc32fb@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 01:28:46 PDT (-0700), sunnanyong@huawei.com wrote:
> This series brings transparent huge pages to RISCV on 64-bit.
>
> I have tested these testcases of vm selftest under qemu-riscv64:
> khugepaged
> split_huge_page_test
> transhuge-stress
>
> Nanyong Sun (4):
>   riscv: mm: add _PAGE_LEAF macro
>   riscv: mm: make pmd_bad() check leaf condition
>   riscv: mm: add param stride for __sbi_tlb_flush_range
>   riscv: mm: add THP support on 64-bit
>
>  arch/riscv/Kconfig                    |   1 +
>  arch/riscv/include/asm/pgtable-64.h   |   3 +-
>  arch/riscv/include/asm/pgtable-bits.h |   5 +
>  arch/riscv/include/asm/pgtable.h      | 164 +++++++++++++++++++++++++-
>  arch/riscv/mm/tlbflush.c              |  17 ++-
>  5 files changed, 178 insertions(+), 12 deletions(-)

Thanks.  These were too late for the current merge window.  We still 
have some stuff in flight, I'll take a look after things calm down a 
bit.
