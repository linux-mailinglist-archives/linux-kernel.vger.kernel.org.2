Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E23F3A56
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 13:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhHULFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHULFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 07:05:43 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917B0C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 04:05:04 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i3-20020a056830210300b0051af5666070so11327267otc.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIsuP5B6epKwrQJOJlnUBuy15YQPt9k32BYomuaBXoQ=;
        b=hiXelST5fYjgpdD/cHzQLQeFB0/5PqMYphQ2vSl92DNed2nk2eE6DOtMlVArKp7l+I
         Ay9p9xYXVWL/A0ZiA8kne6Gda6VJKujK439bNpPYfCPkJkZSxyseZYmFfqybbULxMe6g
         AfhVGF1xH/miYGHdAzHK54O7ispBnNHfGPWlhsryLtoZkLt87ytfw/fOlWgV1QfV7OQ8
         hGYpkcsvOuBpISc7DsXeOGWEFJyWo1i0JViv/62zwwjrcU3IGQ2n2s43zJsT8at4wPJT
         SvnVJDPFFxf/BANQ/t6eyjz48Nj0ihM1ioEeoAXXLpJQqqtxImN6VBDEUNm5OINRqjjO
         zCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIsuP5B6epKwrQJOJlnUBuy15YQPt9k32BYomuaBXoQ=;
        b=hWHLb1Uvb2IGOHp+jZ+XwkUAAWV8uESf/pAZPlix5htRR2r1C+NB3ZPbBI7zLCn0Il
         eIzhdzJ2sT0Go7QWtGo6iV1ITbIZpBQnI508ijItjw0+qCjr53h6T8cF3vQoBo5YpNV1
         Hx9nXNlIqFSFNwuz3Fqz6+rV4CSCEKjESOr9iWcGeNqLYk8M4KHKvqUuNh7rV8/2AYEN
         J+W0YTsuAFDsVAgLdQxQ8jiomV7wIz7ez1yvLiSpAUjrVY8iFEREPE927S7OKIE22TaU
         KYZhDe2qEqhZPC5QcLdnz3culujOFG4NfAB6MsrQZ8tdbfb/ONmzmK/xVcm5QkvksEGD
         UpQA==
X-Gm-Message-State: AOAM533pnqma4m65ILY9Zs57IAsLUdno7iSnmlrU5ZIJjNmEcZYos/EG
        dqYHUbfQAP/WaP4qGepS8+J1W/v5yt56OoJli6XA5h0Ost4=
X-Google-Smtp-Source: ABdhPJyEfCsovquy3WXk0/XYOSuy4oMGmGIYUkjQXUvpcVjDcIS3VXszBlBrmc+zDqFt/fyfk8LCHvleg4bBu70WXgM=
X-Received: by 2002:a05:6808:2193:: with SMTP id be19mr6021421oib.102.1629543903875;
 Sat, 21 Aug 2021 04:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210820150719.67934-1-ogabbay@kernel.org> <20210820150719.67934-4-ogabbay@kernel.org>
In-Reply-To: <20210820150719.67934-4-ogabbay@kernel.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 21 Aug 2021 14:04:37 +0300
Message-ID: <CAFCwf12vkav1WcxEs0YnjA4t_h5uN13-roEK4OF-5DmQQzjHxg@mail.gmail.com>
Subject: Re: [PATCH 4/4] habanalabs: never copy_from_user inside spinlock
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 6:09 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> copy_from_user might sleep so we can never call it when we have
> a spinlock.
>
> Moreover, it is not necessary in waiting for user interrupt, because
> if multiple threads will call this function on the same interrupt,
> each one will have it's own fence object inside the driver. The
> user address might be the same, but it doesn't really matter to us,
> as we only read from it.
>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>  .../habanalabs/common/command_submission.c    | 35 +++++++------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
> index a97bb27ebb90..7b0516cf808b 100644
> --- a/drivers/misc/habanalabs/common/command_submission.c
> +++ b/drivers/misc/habanalabs/common/command_submission.c
> @@ -2740,14 +2740,10 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
>         else
>                 interrupt = &hdev->user_interrupt[interrupt_offset];
>
> -       spin_lock_irqsave(&interrupt->wait_list_lock, flags);
> -
> -       if (copy_from_user(&completion_value, u64_to_user_ptr(user_address),
> -                                                                       4)) {
> -               dev_err(hdev->dev,
> -                       "Failed to copy completion value from user\n");
> +       if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 4)) {
> +               dev_err(hdev->dev, "Failed to copy completion value from user\n");
>                 rc = -EFAULT;
> -               goto unlock_and_free_fence;
> +               goto free_fence;
>         }
>
>         if (completion_value >= target_value)
> @@ -2756,42 +2752,35 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
>                 *status = CS_WAIT_STATUS_BUSY;
>
>         if (!timeout_us || (*status == CS_WAIT_STATUS_COMPLETED))
> -               goto unlock_and_free_fence;
> +               goto free_fence;
>
>         /* Add pending user interrupt to relevant list for the interrupt
>          * handler to monitor
>          */
> +       spin_lock_irqsave(&interrupt->wait_list_lock, flags);
>         list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
>         spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
>
>  wait_again:
>         /* Wait for interrupt handler to signal completion */
> -       completion_rc =
> -               wait_for_completion_interruptible_timeout(
> -                               &pend->fence.completion, timeout);
> +       completion_rc = wait_for_completion_interruptible_timeout(&pend->fence.completion,
> +                                                                               timeout);
>
>         /* If timeout did not expire we need to perform the comparison.
>          * If comparison fails, keep waiting until timeout expires
>          */
>         if (completion_rc > 0) {
> -               spin_lock_irqsave(&interrupt->wait_list_lock, flags);
> -
> -               if (copy_from_user(&completion_value,
> -                               u64_to_user_ptr(user_address), 4)) {
> -
> -                       spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
> -
> -                       dev_err(hdev->dev,
> -                               "Failed to copy completion value from user\n");
> +               if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 4)) {
> +                       dev_err(hdev->dev, "Failed to copy completion value from user\n");
>                         rc = -EFAULT;
>
>                         goto remove_pending_user_interrupt;
>                 }
>
>                 if (completion_value >= target_value) {
> -                       spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
>                         *status = CS_WAIT_STATUS_COMPLETED;
>                 } else {
> +                       spin_lock_irqsave(&interrupt->wait_list_lock, flags);
>                         reinit_completion(&pend->fence.completion);
>                         timeout = completion_rc;
>
> @@ -2811,9 +2800,9 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
>  remove_pending_user_interrupt:
>         spin_lock_irqsave(&interrupt->wait_list_lock, flags);
>         list_del(&pend->wait_list_node);
> -
> -unlock_and_free_fence:
>         spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
> +
> +free_fence:
>         kfree(pend);
>         hl_ctx_put(ctx);
>
> --
> 2.17.1
>

Hi Greg,
Thanks for pointing this issue out. It slipped my CR (my bad).
I believe this fixes the problem and I've gone over the entire driver
and didn't see any other occurrence of this bug.

Oded
