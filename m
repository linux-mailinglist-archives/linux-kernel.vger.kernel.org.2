Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A5332F82F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 05:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCFER5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 23:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhCFERm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 23:17:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87AC265005;
        Sat,  6 Mar 2021 04:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615004261;
        bh=JG/2e1lJh6g7lyOKj2exd139cipDVLRkA4E7ybz5KAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rzF4uYfPpwlkHigXs2pN/dKWzWnE03d6bQi/zAl81k8BdgRT/G9Diy7tZKpugJg6u
         7xqa778ijiP0W5PLnTzNSgNbEWjiFSObwYkAPBO0y1NlsCsce8GrSbt25Q2DKBRoDY
         D5uAH2iIcfGeklm9fZmJDwWaAQE5IzJbzndmWTsVAJRVexnWniJpETQcG7Q894YRub
         h+b4Q3Fzza4PgKEtxqAGLNKpl+fCTtKofzfZ7cNj2HLCj0e6z9dk0OLry/7saWamqJ
         YRrR1L1XSYTmemt197Fd35vi4obKf2YlZ+DaH9Tm6Gwh/RWJb4Qafi6BmC0AERemBs
         Uj2I9TTsReaDg==
Received: by mail-lf1-f49.google.com with SMTP id v9so8300370lfa.1;
        Fri, 05 Mar 2021 20:17:41 -0800 (PST)
X-Gm-Message-State: AOAM533O0hMEMmthhNujJxU/+bwkKu0KelS9HrzV3EtfNPzlisbrIc7P
        b+wyFb6KeUsEJRrN96vfI+0ekCp3frboMYcjqBo=
X-Google-Smtp-Source: ABdhPJz39jAeX+gKEfeE96e3+a7VxML1Q9mZmzhl9DwJu4HthFNyF+7vhmUW3RgOMzojnR1rJa4qIajmNoMYXKd1ddU=
X-Received: by 2002:a05:6512:2288:: with SMTP id f8mr7754188lfu.346.1615004259929;
 Fri, 05 Mar 2021 20:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20210306032314.3186-1-angkery@163.com>
In-Reply-To: <20210306032314.3186-1-angkery@163.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 6 Mar 2021 12:17:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTSx3AYyQ7Z4SD19LX1fygbauAdUFCnRS2aAuUX0XRUQA@mail.gmail.com>
Message-ID: <CAJF2gTTSx3AYyQ7Z4SD19LX1fygbauAdUFCnRS2aAuUX0XRUQA@mail.gmail.com>
Subject: Re: [PATCH] csky: fix typos
To:     angkery <angkery@163.com>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Junlin Yang <yangjunlin@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx,

Looks good to me, Signed-off-by.

On Sat, Mar 6, 2021 at 11:23 AM angkery <angkery@163.com> wrote:
>
> From: Junlin Yang <yangjunlin@yulong.com>
>
> fixes three typos found by codespell.
>
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> ---
>  arch/csky/include/asm/asid.h    | 2 +-
>  arch/csky/include/asm/barrier.h | 2 +-
>  arch/csky/include/asm/vdso.h    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/csky/include/asm/asid.h b/arch/csky/include/asm/asid.h
> index ac08b0f..6ff205a 100644
> --- a/arch/csky/include/asm/asid.h
> +++ b/arch/csky/include/asm/asid.h
> @@ -37,7 +37,7 @@ void asid_new_context(struct asid_info *info, atomic64_t *pasid,
>   * Check the ASID is still valid for the context. If not generate a new ASID.
>   *
>   * @pasid: Pointer to the current ASID batch
> - * @cpu: current CPU ID. Must have been acquired throught get_cpu()
> + * @cpu: current CPU ID. Must have been acquired through get_cpu()
>   */
>  static inline void asid_check_context(struct asid_info *info,
>                                       atomic64_t *pasid, unsigned int cpu,
> diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
> index 84fc600c..f4045dd 100644
> --- a/arch/csky/include/asm/barrier.h
> +++ b/arch/csky/include/asm/barrier.h
> @@ -64,7 +64,7 @@
>
>  /*
>   * sync:        completion barrier, all sync.xx instructions
> - *              guarantee the last response recieved by bus transaction
> + *              guarantee the last response received by bus transaction
>   *              made by ld/st instructions before sync.s
>   * sync.s:      inherit from sync, but also shareable to other cores
>   * sync.i:      inherit from sync, but also flush cpu pipeline
> diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
> index eb5142f..bdce581 100644
> --- a/arch/csky/include/asm/vdso.h
> +++ b/arch/csky/include/asm/vdso.h
> @@ -16,7 +16,7 @@ struct vdso_data {
>   * offset of 0, but since the linker must support setting weak undefined
>   * symbols to the absolute address 0 it also happens to support other low
>   * addresses even when the code model suggests those low addresses would not
> - * otherwise be availiable.
> + * otherwise be available.
>   */
>  #define VDSO_SYMBOL(base, name)                                                        \
>  ({                                                                             \
> --
> 1.9.1
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
