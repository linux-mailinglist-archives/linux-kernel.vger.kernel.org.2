Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557E1403638
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348264AbhIHImP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhIHImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:42:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7B0C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 01:41:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g74so1073815wmg.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swzOBGGEeSOLbaV3bgBNypely5RCn/ltgg/Tjjz+7q4=;
        b=RoGmcJAUTIEbU7PRqkzJQfLbMY+zBD6eEYpzCVBJwNnDtKxdjXUH1yTFLRIc6YBLL1
         I/+JlJatTvpvAO1KUUXRevSZkberTqwho8gU0dlRc1xUh6SU6yhrCLYahK2/uKL9FwTB
         1qYpXisaIbevKBJ/6yITQKJN/yR/qiBeONOLCFyZ35N4H0LB21xKNjhWxkKE6bQlrjEW
         DIANhZn3wJUlfYGc5pAhfnCZmH0K2IaKcvof0xS1loqBzR4Ue4PAaN3px4nj0jqHAUbC
         xdm2bU++zK+2L9V/gMqDPlQAyKcQQhUSNcPK0vCUnxQyPvVeIS/0unnaG6HwyfYDfW9G
         Lq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swzOBGGEeSOLbaV3bgBNypely5RCn/ltgg/Tjjz+7q4=;
        b=FurGQ98E/ViMNmRfHPPyVbdAUikYO+6r2qHu4AyCgHwKuU84NN72OCZfUb+Bv934u+
         uBScLP9cQffbrw+fm4/geK7ZFysT5SUmNDcNKVMo0n23BjKKjE9SeBc/5uxN383fkDZD
         ZO37Drk3yn/B6CeOwXiUTvLLUymDUZwl0lH2l3ogxAZKIQxSvcDgGFFfk8wrxE8piuQZ
         u2TX1RA+yJ34UvWtTRb5ESfWeXn2lHz3X7f4awD5jsanGY+fdlOTk91l2I8FmbqsBMx7
         kJFTpMGOKOvaPlLwijgOSD5aT/JJ5useI2wfFQm1n3g+gUZ8JiHltxRWW859zpNdU7pU
         r4rQ==
X-Gm-Message-State: AOAM531O4SfAs+VjanrJ6+lFU+8rNNUA0iZFse3k+MzTCgXCU///kBXu
        CuCqT1qzWru7u9pMHsoXjumiFSQuh9zdKk76iA346g==
X-Google-Smtp-Source: ABdhPJy1oTHHq9WreaGjJg+1ajsF9aD03TpgwbXXY1CEyaJiEna6NBZwcIPCYOtnw+tRmnR7qekrF4d9uVin+sUJW1M=
X-Received: by 2002:a1c:2705:: with SMTP id n5mr2332855wmn.176.1631090458879;
 Wed, 08 Sep 2021 01:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210907235315.567614-1-vgupta@kernel.org>
In-Reply-To: <20210907235315.567614-1-vgupta@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 8 Sep 2021 14:10:47 +0530
Message-ID: <CAAhSdy3SRFkPmJu_2wQ+g9wi1i313np75719SXA1yNSbG2jupw@mail.gmail.com>
Subject: Re: [PATCH] riscv: config: enable default defconfig to boot Hifive Unmatched
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Heinrich

On Wed, Sep 8, 2021 at 5:23 AM Vineet Gupta <vgupta@kernel.org> wrote:
>
> We need just a few options related to NLS when mouting boot partition
> for Unmatched to boot off of mainline kernels.
>
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>

This is exactly same as what Heinrich posted a month back.
https://www.spinics.net/lists/kernel/msg4041633.html

Regards,
Anup

> ---
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 1f2be234b11c..fc9a4e0a9500 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -108,6 +108,8 @@ CONFIG_NFS_V4_1=y
>  CONFIG_NFS_V4_2=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_9P_FS=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_ISO8859_1=y
>  CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
> --
> 2.30.2
>
