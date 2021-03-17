Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD9A33E8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCQFIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhCQFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:08:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A9BC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:08:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id l3so294060pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0skOxIz4xhfCTZ0VNwqsfY6NBbJN3e7Av5/rXN6cj/0=;
        b=dKAlbnzTgqbs9DMRjCdE4no8gsnOj57DaFLf50xhlLPr77tjH2ztzS5KJ2R2PKrIV+
         4SRXbqqko/0e/TzfSTXWKpU3PxKB/98Z0/cMhWk3b7gfJpYKNLMie4EYWKQRQxQ/E9re
         /xhgOy3MgIb9cOBeOwQdnE09OBEeUgzMQLVi6eqj2rkp3D3jELn4HLsEVxugA/Z+B63B
         AH0nKpVPI0MG2n3qDZEi2jvbEirfsLiLnaRrIxRGfQ2DYUAQajiJiqdwdjQ2IxfA3ZQO
         t3XoGsKL4UwfeeDicgryOAe/r0iXyH6Hvm/722NVKrHtMJ/+D/QGxBSfq5/Qn+6F7uJ8
         CHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0skOxIz4xhfCTZ0VNwqsfY6NBbJN3e7Av5/rXN6cj/0=;
        b=uPhi7k9hUgnRvrjG7AtqhaSup2mhLdRqIpyPG0qwTZ1hG+gJA8xiQ1xLEj+dT2rkym
         t635jSfkL+Dfd1UaAPndsUb81ooSGHm/JusX13wEqteh+kIZk5JNjrCuNGV9m0cbBaQm
         QTEJFzF+uE5SHf8jTxrdDqXKPvX9pnPmnVKmAoRLddHQg8ZDibqaadIrUXHQvMp+Dcre
         JyYeKZY3xDaD9bO47m+qJiZZlHv8HNFWs1iDO632tiCRQKL/Vz7XmA9ebNmVqkabvs9m
         C1tsFYJ1yEK5UPKV1nKJRx1k4ZBBhI42bFdHrfVl14t2qKnrScqSbnk8vSPbQ0PbmCMM
         igLQ==
X-Gm-Message-State: AOAM531x6eTqin8HfoV2tDWigU7SagXNabGZtaEsGqUZ743itDJS+x/Z
        MG2yo6KqyZjq+WC1skUHDLe82w==
X-Google-Smtp-Source: ABdhPJxyF6choZsOEthrs6FkxV0u4DcptNNowEAldsfR7i5nVLXhWCspGoXV1Sy33c0Ua8caUUL7Zg==
X-Received: by 2002:aa7:8389:0:b029:209:da1c:17b5 with SMTP id u9-20020aa783890000b0290209da1c17b5mr2604704pfm.29.1615957694242;
        Tue, 16 Mar 2021 22:08:14 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h7sm18589926pfo.45.2021.03.16.22.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 22:08:13 -0700 (PDT)
Date:   Tue, 16 Mar 2021 22:08:13 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 22:07:36 PDT (-0700)
Subject:     Re: [PATCH v6 1/2] RISC-V: Don't print SBI version for all detected extensions
In-Reply-To: <20210315110500.802897-2-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-15799b77-832f-49f3-ac18-af2ec08eebf5@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 04:04:59 PDT (-0700), Anup Patel wrote:
> The sbi_init() already prints SBI version before detecting
> various SBI extensions so we don't need to print SBI version
> for all detected SBI extensions.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/sbi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f4a7db3d309e..c0dcebdd30ec 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -577,19 +577,19 @@ void __init sbi_init(void)
>  			sbi_get_firmware_id(), sbi_get_firmware_version());
>  		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
>  			__sbi_set_timer = __sbi_set_timer_v02;
> -			pr_info("SBI v0.2 TIME extension detected\n");
> +			pr_info("SBI TIME extension detected\n");
>  		} else {
>  			__sbi_set_timer = __sbi_set_timer_v01;
>  		}
>  		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
>  			__sbi_send_ipi	= __sbi_send_ipi_v02;
> -			pr_info("SBI v0.2 IPI extension detected\n");
> +			pr_info("SBI IPI extension detected\n");
>  		} else {
>  			__sbi_send_ipi	= __sbi_send_ipi_v01;
>  		}
>  		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
>  			__sbi_rfence	= __sbi_rfence_v02;
> -			pr_info("SBI v0.2 RFENCE extension detected\n");
> +			pr_info("SBI RFENCE extension detected\n");
>  		} else {
>  			__sbi_rfence	= __sbi_rfence_v01;
>  		}

Thanks.  I'm just putting this one on for-next so you don't have to carry
around the diff.
