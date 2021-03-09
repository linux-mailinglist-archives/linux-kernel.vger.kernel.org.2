Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D4332189
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCIJDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCIJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:02:28 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1141C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 01:02:27 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id c44so4271417uad.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 01:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sssySl0JVi+jBXZFxuWDq2kypNNSm148y4r47Euw4YM=;
        b=AsGzH1MMqc8CDZt9a0Do3IMClW3xqLU2GevRxpPuYfzRD8JJr+9FaKOBoKrcsXZBSU
         RKIC7PzMiuHKzEKhCt/9WRlgLEtkYs/34OxLOBHj8+n19oJfZX8Nnn2gvSdW7s6SlkAK
         XMwV1lGClGFC80zICWXoblreQ1aYelNiih6Gx/0FlJuhplVsbBP2Po9Uhu0mJelH3NjA
         EHgdq9SRJuCcY3nyPYtt5FODNxiYPa19tR9l1QeuCSesjAOkcydr05vQl3aAl7fEZIbM
         iLyLrbQ0DMtDmcByRBlEtxlEt+1yEF2lDxDm0AgakOIENPpE+IjovZnqBkYxXgayZ4Wo
         O7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sssySl0JVi+jBXZFxuWDq2kypNNSm148y4r47Euw4YM=;
        b=in0b4X/GQSYx/Wwrp5aIDoYEeZ7IODERG8KS1GicWcwDJfiZSSAdjtef3y/2fNAQME
         yh3Jh2e+M/G0YXiiVk/rZYydb4arzhSI8uip8OjUQ8xqT7bPTBOZ/zxVLhwXasvuid/T
         p0+uTg4k1X0jWR0S/1dvYELkUlH9OzmCn3vKIShgijn31FfR9BLHlbAawqvep4Tjm0uq
         opD6efmr5cZ6QEzBroVqQTuN5uaSkIsmF4Oqxv/R5B6Bf8qOVTkHveNwMLHyIMhCEPnY
         9uZ57UPBjua62UNK6UgUe4trhD8YJcONm5qpuQqxlQehKCGjJwuhmqVJEhXnggE6NfJY
         Iadg==
X-Gm-Message-State: AOAM5317/eM3tbxwu4MmBej0ewNAUQmLl5yCbSeIqfYicgZMN5vEGx+4
        I5uSl8rpOLNT1PVFmI0xJ7KJMXnVuOELwW5PK1XWFA==
X-Google-Smtp-Source: ABdhPJwKHqIif2rFtWqqp7PjT4VBd442T+0y6eF98qpBCyS8psQLLgDYTXZcYTAAXYKCfsUcSd2rEGYzGxTczr/wDVI=
X-Received: by 2002:ab0:7a68:: with SMTP id c8mr4714930uat.104.1615280546955;
 Tue, 09 Mar 2021 01:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20210305021445.3435-1-baijiaju1990@gmail.com>
In-Reply-To: <20210305021445.3435-1-baijiaju1990@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 10:01:50 +0100
Message-ID: <CAPDyKFpqrjfinrM3a=-p+OxzCzKsWNDS4GpaF7E0Pbb5uiTL=w@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: fix error return code of mspro_block_resume()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, trix@redhat.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 at 03:14, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> When mspro_block_init_card() fails, no error return code of
> mspro_block_resume() is assigned.
> To fix this bug, rc is assigned with the return value of
> mspro_block_init_card(), and then rc is checked.
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/mspro_block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index afb892e7ffc6..cf7fe0d58ee7 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -1382,7 +1382,8 @@ static int mspro_block_resume(struct memstick_dev *card)
>
>         new_msb->card = card;
>         memstick_set_drvdata(card, new_msb);
> -       if (mspro_block_init_card(card))
> +       rc = mspro_block_init_card(card);
> +       if (rc)
>                 goto out_free;
>
>         for (cnt = 0; new_msb->attr_group.attrs[cnt]
> --
> 2.17.1
>
