Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303C135D081
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbhDLSmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:42:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbhDLSmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:42:15 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MNKuK-1lCpvV1qlm-00OnaS; Mon, 12 Apr 2021 20:41:55 +0200
Received: by mail-wr1-f49.google.com with SMTP id s7so13849850wru.6;
        Mon, 12 Apr 2021 11:41:55 -0700 (PDT)
X-Gm-Message-State: AOAM533SA37cqd3e2ReIgm0eclNhyvbE7lvq+fBTp+t6F8XKEdgBvrkm
        L7gMTQU0BcEaI08FSf1DDLC2ah6UkFYaagZEaDA=
X-Google-Smtp-Source: ABdhPJyl9ozm0Lk3BSMDxA0gevtHoth6mdEPg6RhJBS+HV0+ckK8znO7EM3K7u0TnFESQngQNEAr2dHrGE/Z/SU6yJQ=
X-Received: by 2002:a5d:6a11:: with SMTP id m17mr33915154wru.361.1618252915158;
 Mon, 12 Apr 2021 11:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210412161012.1628202-1-colin.king@canonical.com>
In-Reply-To: <20210412161012.1628202-1-colin.king@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Apr 2021 20:41:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2pSRu0OKDNrNJSdviRgcv8Lw1mwZr5opv=UbtHLps2oQ@mail.gmail.com>
Message-ID: <CAK8P3a2pSRu0OKDNrNJSdviRgcv8Lw1mwZr5opv=UbtHLps2oQ@mail.gmail.com>
Subject: Re: [PATCH][next] habanalabs/gaudi: Fix uninitialized return code rc
 when read size is zero
To:     Colin King <colin.king@canonical.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3rrTtg7LjheVpYkEOa9RH5Wn2Ghd47zXbMPLrHE+IM3LMrGOW95
 8jpDsIm+wtX+fKNz4JeFb9GqZY7HOn+lBZDbcQyyrOn3REg8VPyOL1gKWN4K2VdqeMMWWOB
 TOvj07xXgS65e6EhXJUhdoovP7E6krNzqdp/OJMgtRLLIdLKdnxUOAWszOCSSVtg7Bry1Ba
 YjNOr2I09fdyrNjVmeLiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ese25u6vl4k=:7U7gTxMlohvHng81P4IYFa
 CzB0YG2wYE+/altuAcXN+UI+r9PjRj7aNhgqF6qnOlm+QlQ4vtgFI0VgafOWMU0Tqg9YljDbY
 lBskMcc7nLvKC1sKOWxS2kgeVBvk/JpT+q9Xt/moYZpbqHfk6QjmlUmRT1ZFN5DV6fLp4Rk5U
 5vseaIUJnwZK829bbyZ4APd6rii8r6SjR6i32ALO28IF4rqQEyW1znvoRT0eAPdZZnJYF6Zxs
 ScilR6aVbc6pVC1/cNnJwH/ZDhTAFuAWqgjW+m6Ax/46KaH9SJZzBXh0nIxRU7mFWefqqFhUu
 ZU+0ofeO2WC2bzGKNcaLgb5ct4pNuIwB0JCAgGiWz2i/V9qtc5jYueYkY7iy8HFuZg5pU6kwz
 mxoB6ff1CibeZIjUci700vxoqghmyCdqnT6kn0aMEDpo5igeQSJn1BjmB4a7DLK7PYtAq73Hy
 flUcZRzCZIztAhPOyYfGPpcb+moBGbk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 6:11 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> In the case where size is zero the while loop never assigns rc and the
> return value is uninitialized. Fix this by initializing rc to zero.
>
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 639781dcab82 ("habanalabs/gaudi: add debugfs to DMA from the device")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 8730b691ec61..b751652f80a8 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -6252,7 +6252,7 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
>         dma_addr_t dma_addr;
>         void *kernel_addr;
>         bool is_eng_idle;
> -       int rc, dma_id;
> +       int rc = 0, dma_id;
>
>         kernel_addr = hdev->asic_funcs->asic_dma_alloc_coherent(
>                                                 hdev, SZ_2M,


In general, I don't like adding initializations during the declaration as that
tends to hide warnings for the cases where a later initialization is
missing. In this case it looks correct though.

Acked-by: Arnd Bergmann <arnd@arndb.de>
