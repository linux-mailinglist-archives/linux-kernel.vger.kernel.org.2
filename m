Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9154C366DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbhDUOJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbhDUOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:09:36 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC565C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:09:02 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so13095413otp.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/xfVYKbQIjMYvYv97IJUu+dC6Jusglri6HfpQE3tf4=;
        b=dF45Zo6aW63N/ujT9AYHY2G3kdkdqFJFV44KKumEG0zyuoaQwVR1QWhT+qrHu3bAIF
         RWzKblJVDYmZ8Dt4LXMOrkGQa0YpzZkyifpxlZ2RoloavsSr+FJe6QL40+Kt77YsOgh9
         mQ4yGJC0wlZfIYu3b62WY4SF4q7UwxxYAiz794VlLoj2Iv/ppitF4ZBX6keBC5VmH/Nq
         k4XIbi9GGA1qVZmVLRqWZUFFNfXnQ8OA53v8N6Mx5Zl7zuHdSaxVYI9vIG3u6TdGNlvd
         owcOOLNKQeRkP/tZ0351K+/w3nH5ZqIn5+ICjrhPJDRdYz5c7rph7Ez/7Fn1XZKofbrf
         C2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/xfVYKbQIjMYvYv97IJUu+dC6Jusglri6HfpQE3tf4=;
        b=jW3j3QwcMrHeurIcFdQqxuOHrVLmkTwywVMIA+GMqNHhtxX3WsddD7P559zkk3XMjV
         55tYh0YNRyeAuWmcxcSK4ZWRMPdQN5oiOJPJNmCMeH8qZ5ya/iBP2IawXkDKS4lfijCm
         Dkm3R5bv6cXEurpOyf09a3zYzj3Ow6M5ZkAjPCD+JxkfmAG78xnZLvXZDYlbRithLeDT
         R6izNJgVDheQioSCkOdOETlYLEdOUYs/vgS3QcKN5cNWrWlFTjzboJUZ78sEC84cQm4j
         oZbDnd7YghvnHwNl/z+f83K3PJUPFVn+VcZdxNsrIYX5UQ0VRxzCXvRL1ZFua8n3uxry
         Jr3w==
X-Gm-Message-State: AOAM5304bzVl4Cg8HyNWnizZRNkqcBXzC9w3JEIyAZd4qi3Gkkgip6za
        iAcEETWDVGOrNoebtNWFGC/qVXbGZdiVYSzc7zx3Wwr6eRQujw==
X-Google-Smtp-Source: ABdhPJz3B+i4DoUhP/WFd40OwUeOqs0fJ4zjhL7jyJxXntYRDkYpWTgOvwsflxM5iKqZtXetPnDpwFW7/Ay+7jq7k6Q=
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr15180616ots.339.1619014142292;
 Wed, 21 Apr 2021 07:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210421135253.3435360-1-arnd@kernel.org>
In-Reply-To: <20210421135253.3435360-1-arnd@kernel.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 21 Apr 2021 17:08:35 +0300
Message-ID: <CAFCwf11r1v0nV-DvCJ71oSfL3yTXEXkUF6-YijJP0jD59LcAPQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix enum type mismatch
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ofir Bitton <obitton@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ohad Sharabi <osharabi@habana.ai>,
        Alon Mizrahi <amizrahi@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
Thanks for the fix but I already have a pending patch for rc1 that
fixes this issue.
See: https://lkml.org/lkml/2021/4/17/73

Oded

On Wed, Apr 21, 2021 at 4:53 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The definition of these two arrays does not match the type of the
> enums in them:
>
> drivers/misc/habanalabs/goya/goya.c:136:21: error: implicit conversion from 'enum goya_pll_index' to 'enum pll_index' [-Werror=enum-conversion]
>   136 |         [CPU_PLL] = GOYA_CPU_PLL,
> drivers/misc/habanalabs/gaudi/gaudi.c:126:21: error: implicit conversion from 'enum gaudi_pll_index' to 'enum pll_index' [-Werror=enum-conversion]
>   126 |         [CPU_PLL] = GAUDI_CPU_PLL,
>
> Remove the enum and just use literal numbers, which avoids the
> warning and is more concise without really losing any information.
>
> Fixes: e8f9392a5c7f ("habanalabs: support legacy and new pll indexes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 38 ++++++++-------------------
>  drivers/misc/habanalabs/goya/goya.c   | 29 ++++++--------------
>  2 files changed, 19 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index b751652f80a8..69bd7ff694f8 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -105,34 +105,18 @@
>
>  #define GAUDI_PLL_MAX 10
>
> -/*
> - * this enum kept here for compatibility with old FW (in which each asic has
> - * unique PLL numbering
> - */
> -enum gaudi_pll_index {
> -       GAUDI_CPU_PLL = 0,
> -       GAUDI_PCI_PLL,
> -       GAUDI_SRAM_PLL,
> -       GAUDI_HBM_PLL,
> -       GAUDI_NIC_PLL,
> -       GAUDI_DMA_PLL,
> -       GAUDI_MESH_PLL,
> -       GAUDI_MME_PLL,
> -       GAUDI_TPC_PLL,
> -       GAUDI_IF_PLL,
> -};
> -
> +/* compatibility with old FW (in which each asic has unique PLL numbering */
>  static enum pll_index gaudi_pll_map[PLL_MAX] = {
> -       [CPU_PLL] = GAUDI_CPU_PLL,
> -       [PCI_PLL] = GAUDI_PCI_PLL,
> -       [SRAM_PLL] = GAUDI_SRAM_PLL,
> -       [HBM_PLL] = GAUDI_HBM_PLL,
> -       [NIC_PLL] = GAUDI_NIC_PLL,
> -       [DMA_PLL] = GAUDI_DMA_PLL,
> -       [MESH_PLL] = GAUDI_MESH_PLL,
> -       [MME_PLL] = GAUDI_MME_PLL,
> -       [TPC_PLL] = GAUDI_TPC_PLL,
> -       [IF_PLL] = GAUDI_IF_PLL,
> +       [CPU_PLL] = 0,
> +       [PCI_PLL] = 1,
> +       [SRAM_PLL] = 2,
> +       [HBM_PLL] = 3,
> +       [NIC_PLL] = 4,
> +       [DMA_PLL] = 5,
> +       [MESH_PLL] = 6,
> +       [MME_PLL] = 7,
> +       [TPC_PLL] = 8,
> +       [IF_PLL] = 9,
>  };
>
>  static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index e27338f4aad2..0a8cf00b5f45 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -118,28 +118,15 @@
>  #define IS_MME_IDLE(mme_arch_sts) \
>         (((mme_arch_sts) & MME_ARCH_IDLE_MASK) == MME_ARCH_IDLE_MASK)
>
> -/*
> - * this enum kept here for compatibility with old FW (in which each asic has
> - * unique PLL numbering
> - */
> -enum goya_pll_index {
> -       GOYA_CPU_PLL = 0,
> -       GOYA_IC_PLL,
> -       GOYA_MC_PLL,
> -       GOYA_MME_PLL,
> -       GOYA_PCI_PLL,
> -       GOYA_EMMC_PLL,
> -       GOYA_TPC_PLL,
> -};
> -
> +/* compatibility with old FW (in which each asic has unique PLL numbering */
>  static enum pll_index goya_pll_map[PLL_MAX] = {
> -       [CPU_PLL] = GOYA_CPU_PLL,
> -       [IC_PLL] = GOYA_IC_PLL,
> -       [MC_PLL] = GOYA_MC_PLL,
> -       [MME_PLL] = GOYA_MME_PLL,
> -       [PCI_PLL] = GOYA_PCI_PLL,
> -       [EMMC_PLL] = GOYA_EMMC_PLL,
> -       [TPC_PLL] = GOYA_TPC_PLL,
> +       [CPU_PLL] = 0,
> +       [IC_PLL] = 1,
> +       [MC_PLL] = 2,
> +       [MME_PLL] = 3,
> +       [PCI_PLL] = 4,
> +       [EMMC_PLL] = 5,
> +       [TPC_PLL] = 6,
>  };
>
>  static const char goya_irq_name[GOYA_MSIX_ENTRIES][GOYA_MAX_STRING_LEN] = {
> --
> 2.29.2
>
