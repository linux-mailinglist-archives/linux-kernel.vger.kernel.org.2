Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C34442030A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJCRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhJCRL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:11:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D0C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 10:10:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w14so232330pll.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=OJdswbT3ZqjLgBifGpj0LGkCKXP0UYWP5Cht8DvndvQ=;
        b=VVxXvV3ro+D5TyClKdhgFlN8qhdxf04ShtskLFYnbArL8EaNvFkXJd2SkKiuK6cryV
         9XNy0FGOJUXgI4KEkuFgfrHcog6RknEwKcujCt59wNmwAtUgQcBxKPBI3AA+3VDkJKLO
         Hg9JRooWIRRY6J14uiD28mAaBMIaThQCek/BvWZGrJsqEkrQoD9v9v/V3sL8biu74MKd
         16egOo1IsMJiBvScovr/eSnXbaUFGl++9eW81Y9HRVcqE7b7bU9s1S/WUbRsGAFzGUi+
         1tZ3PUuQLJUGGjpGM37StetsEw1WlJuSNcqiTRRcVAaA7vLEVeU5be49vo8ZF2fWlTkF
         bKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OJdswbT3ZqjLgBifGpj0LGkCKXP0UYWP5Cht8DvndvQ=;
        b=EaGnCPT+pCqdf64WiacpocF16wsq03x1blUzQ7ivIMbWCYI2s2coTDcjWcDcbD/CXJ
         6GqEH9G1Ws+95NRapKyNbj4uh8pOgrmQBSIARk9IwWaPvD7aXKU0LLfJtBMFqLnMObpi
         g5HFBPpcG/lpTWui4QCZpyUnj/qoF0O2lX8tfxAjZWTeVVIv9b4ZRhAaAcA+KjSnKxpz
         ytTUUOuxwpGrTV9gPA/ZpStl2thVqlB/IRDiqmROsqGYd8jOcFhp5ku3Yx6ixQN2oP+w
         X3xy8J4zbrWVqEsdBiW2O37UKnzrZUzQKdiCQoU++Bqy2efIZqpgOHp2G5jxPoNluNzX
         mhkw==
X-Gm-Message-State: AOAM532onDADnPiTM5bLsxQLHX0THUJClQawEvkf6ToGKJcj99+9qFY2
        7l6F1lpYOiSDeZbxuhaW7RCJTA==
X-Google-Smtp-Source: ABdhPJzSbGehakM8MZhnYxpRFdvHcXi0hnC5QqYw2v0jmiYMRhVoU5wwJX68eqbE8FY69EH9lBZ1Rg==
X-Received: by 2002:a17:902:6804:b0:13e:38d2:cdd8 with SMTP id h4-20020a170902680400b0013e38d2cdd8mr20739983plk.54.1633281008691;
        Sun, 03 Oct 2021 10:10:08 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id mv9sm1969552pjb.10.2021.10.03.10.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 10:10:07 -0700 (PDT)
Date:   Sun, 03 Oct 2021 10:10:07 -0700 (PDT)
X-Google-Original-Date: Sun, 03 Oct 2021 10:06:47 PDT (-0700)
Subject:     Re: [PATCH] riscv: config: enable default defconfig to boot Hifive Unmatched
In-Reply-To: <20210907235315.567614-1-vgupta@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, bin.meng@windriver.com,
        sagar.kadam@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, vgupta@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vgupta@kernel.org
Message-ID: <mhng-8685d7c9-0e74-42dd-9ce9-8b369e1c41c4@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Sep 2021 16:53:15 PDT (-0700), vgupta@kernel.org wrote:
> We need just a few options related to NLS when mouting boot partition
> for Unmatched to boot off of mainline kernels.
>
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
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

Thanks, but it looks like someone else already sent these same config 
enables.
