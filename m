Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7836F37A551
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhEKK6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhEKK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:58:31 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:57:24 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id s131so3949417vka.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYmfwXsG48zZWU5U7rxLgbKWtiP87KC+qAsp9Yv86CY=;
        b=tdSjntsBc8q8UrVZ1DNb8hWHsQpD07kZ0UMqerZnEEgXahRAZxIz7WbgUxkGsORLTZ
         fQXWXcmOO11xZSlX9V1ex8LqolAh0is40kK9BOWbiFvWwHcVx+sMy7lamvC/ci15brrM
         n5FiklfSriU79jVLCBPHZGGZU1LS4xs6KQBpWn8Q55vnb3QDMlzDwDhy7+FRuUoU1zfN
         kbriAbMGLBBozoCvMiFxMZJbU6OqDuyibLsSFAyDzAwK3RCigc5jH99Nsd/8fznbVm97
         y84rGgHGdIz7EZWw8SiRTlI+vV/0MoZI2iOMSBULh0SYnaCJkuHmPCMG1Kos5yX1R6tq
         LdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYmfwXsG48zZWU5U7rxLgbKWtiP87KC+qAsp9Yv86CY=;
        b=il5Kr3h2bz5+pkXln4F5KS8FJ4ZUzFX+8pFO3KKTM4bbyZJuz6kvGZrGUxZc+730wi
         mJ86uQUc1wLwXXKsnsyaAQVoHCBh1B8qJdCxODRWuO7vDQg5xCNb3d7GCIUtBljfkAty
         Np40NI8HnhZ6YaZZaifGT/kGz7hakVLpLS1g1momw7zA+S9mteQoxV29ryB0PEK1se1i
         C47Am+YAMFmnONO6RYCLKcC46+ZPMaBfiqSVk/QfiGBOsq4wxexcNknK+MWRexKS0BO/
         nKbQzIO2HoNd/fL6qQ/RHIJgDxVc5MK9vUMbp/+8H/T7EFw5RNqp/FMGJmHYfOSi7zVj
         ZjtQ==
X-Gm-Message-State: AOAM530kNyB9SaVzTSG5pif3CdBMSbufGlQf8zpSQD2jZqjGC2CUQX3J
        mZ+Co8S70HnZmAymetZkeNKfyw9igYzFvrgK6pgk1Q==
X-Google-Smtp-Source: ABdhPJxGRhxgQp9RTnuj2Sox+dF3oLSzWEJMTy1f9HndDvF+5GAeP6XhiAN+2a4CiILtF8PZIftQ4ieLDvKyyj2Yxco=
X-Received: by 2002:a1f:1f81:: with SMTP id f123mr21341196vkf.6.1620730643353;
 Tue, 11 May 2021 03:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210507063528.tvlbu2cwnlczgbga@kewl-virtual-machine>
In-Reply-To: <20210507063528.tvlbu2cwnlczgbga@kewl-virtual-machine>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:45 +0200
Message-ID: <CAPDyKFqyu3fDarFyyL+nUx9OCaeoXt8MdwGNvJn5NT6zAH5sFA@mail.gmail.com>
Subject: Re: [PATCH] drivers: memstick: core:ms_block.c: Fix alignment of
 block comment
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Colin King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 at 08:35, Shubhankar Kuranagatti
<shubhankarvk@gmail.com> wrote:
>
> A * has been added to subsequent lines of block comment
> The closing */ has been shifted to a new line
> A new line has been give after declaration
> This is done to maintain code uniformity.
>
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 37 +++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 8004dd64d09a..d971acd98236 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -129,7 +129,7 @@ static int msb_sg_compare_to_buffer(struct scatterlist *sg,
>   * Each zone consists of 512 eraseblocks, out of which in first
>   * zone 494 are used and 496 are for all following zones.
>   * Therefore zone #0 hosts blocks 0-493, zone #1 blocks 494-988, etc...
> -*/
> + */
>  static int msb_get_zone_from_lba(int lba)
>  {
>         if (lba < 494)
> @@ -348,8 +348,9 @@ static int h_msb_read_page(struct memstick_dev *card,
>         switch (msb->state) {
>         case MSB_RP_SEND_BLOCK_ADDRESS:
>                 /* msb_write_regs sometimes "fails" because it needs to update
> -                       the reg window, and thus it returns request for that.
> -                       Then we stay in this state and retry */
> +                * the reg window, and thus it returns request for that.
> +                * Then we stay in this state and retry
> +                */
>                 if (!msb_write_regs(msb,
>                         offsetof(struct ms_register, param),
>                         sizeof(struct ms_param_register),
> @@ -368,7 +369,8 @@ static int h_msb_read_page(struct memstick_dev *card,
>         case MSB_RP_SEND_INT_REQ:
>                 msb->state = MSB_RP_RECEIVE_INT_REQ_RESULT;
>                 /* If dont actually need to send the int read request (only in
> -                       serial mode), then just fall through */
> +                * serial mode), then just fall through
> +                */
>                 if (msb_read_int_reg(msb, -1))
>                         return 0;
>                 fallthrough;
> @@ -702,7 +704,8 @@ static int h_msb_parallel_switch(struct memstick_dev *card,
>
>         case MSB_PS_SWICH_HOST:
>                  /* Set parallel interface on our side + send a dummy request
> -                       to see if card responds */
> +                 * to see if card responds
> +                 */
>                 host->set_param(host, MEMSTICK_INTERFACE, MEMSTICK_PAR4);
>                 memstick_init_req(mrq, MS_TPC_GET_INT, NULL, 1);
>                 msb->state = MSB_PS_CONFIRM;
> @@ -821,6 +824,7 @@ static int msb_mark_page_bad(struct msb_data *msb, int pba, int page)
>  static int msb_erase_block(struct msb_data *msb, u16 pba)
>  {
>         int error, try;
> +
>         if (msb->read_only)
>                 return -EROFS;
>
> @@ -997,6 +1001,7 @@ static int msb_write_block(struct msb_data *msb,
>                         u16 pba, u32 lba, struct scatterlist *sg, int offset)
>  {
>         int error, current_try = 1;
> +
>         BUG_ON(sg->length < msb->page_size);
>
>         if (msb->read_only)
> @@ -1045,11 +1050,12 @@ static int msb_write_block(struct msb_data *msb,
>                 error = msb_run_state_machine(msb, h_msb_write_block);
>
>                 /* Sector we just wrote to is assumed erased since its pba
> -                       was erased. If it wasn't erased, write will succeed
> -                       and will just clear the bits that were set in the block
> -                       thus test that what we have written,
> -                       matches what we expect.
> -                       We do trust the blocks that we erased */
> +                * was erased. If it wasn't erased, write will succeed
> +                * and will just clear the bits that were set in the block
> +                * thus test that what we have written,
> +                * matches what we expect.
> +                * We do trust the blocks that we erased
> +                */
>                 if (!error && (verify_writes ||
>                                 !test_bit(pba, msb->erased_blocks_bitmap)))
>                         error = msb_verify_block(msb, pba, sg, offset);
> @@ -1493,6 +1499,7 @@ static int msb_ftl_scan(struct msb_data *msb)
>  static void msb_cache_flush_timer(struct timer_list *t)
>  {
>         struct msb_data *msb = from_timer(msb, t, cache_flush_timer);
> +
>         msb->need_flush_cache = true;
>         queue_work(msb->io_queue, &msb->io_work);
>  }
> @@ -1673,7 +1680,8 @@ static int msb_cache_read(struct msb_data *msb, int lba,
>   * This table content isn't that importaint,
>   * One could put here different values, providing that they still
>   * cover whole disk.
> - * 64 MB entry is what windows reports for my 64M memstick */
> + * 64 MB entry is what windows reports for my 64M memstick
> + */
>
>  static const struct chs_entry chs_table[] = {
>  /*        size sectors cylynders  heads */
> @@ -1706,8 +1714,9 @@ static int msb_init_card(struct memstick_dev *card)
>                 return error;
>
>         /* Due to a bug in Jmicron driver written by Alex Dubov,
> -        its serial mode barely works,
> -        so we switch to parallel mode right away */
> +        * its serial mode barely works,
> +        * so we switch to parallel mode right away
> +        */
>         if (host->caps & MEMSTICK_CAP_PAR4)
>                 msb_switch_to_parallel(msb);
>
> @@ -2033,6 +2042,7 @@ static blk_status_t msb_queue_rq(struct blk_mq_hw_ctx *hctx,
>  static int msb_check_card(struct memstick_dev *card)
>  {
>         struct msb_data *msb = memstick_get_drvdata(card);
> +
>         return (msb->card_dead == 0);
>  }
>
> @@ -2333,6 +2343,7 @@ static struct memstick_driver msb_driver = {
>  static int __init msb_init(void)
>  {
>         int rc = memstick_register_driver(&msb_driver);
> +
>         if (rc)
>                 pr_err("failed to register memstick driver (error %d)\n", rc);
>
> --
> 2.17.1
>
