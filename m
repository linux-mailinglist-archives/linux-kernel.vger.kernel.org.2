Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE67432868
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhJRU0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:26:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400FC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:24:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p16so2390173lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=har/4/PWCEMpvFWOprxG/fUyVmDaaJDKHIOQGS8ro1Y=;
        b=RC1Rv/7TptVAnpkImcwF4xhmo0n6qZszmDbsH02tz700VcnBX+keKWXyZLeDSNdQeg
         QofqJbxydbk5MT1p9KQzLevm2K0uArGlXyBgW94Npszr4ggM4yxsxNsqHgPeIsA0yi1J
         nZdFIma4dyZqhnveC+zuxxVnvmpz3I82nv26Yo/STGZzT5A/Z4RmKbYj3b/eH9zz+eal
         i2WoC5O4wrSBwucaOpg2frFyjtNucQA1XObeUmSvVddELtsuI1kEqAzBMIwV4AP/l3Bx
         N8FHIxAgUXqad6hmzoNxzcrDsv1CQI4KzKDGfRzn0SolIlxIdffWuwl+gwL9Au6VTxdX
         xrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=har/4/PWCEMpvFWOprxG/fUyVmDaaJDKHIOQGS8ro1Y=;
        b=ftM0wO0zbO2LHNRjJv/RdeGAyx1H0CrvWevR3ArdTTgF6FA9vxA5FoGhepSXhJTY7T
         kuhBqO9MOQPZ0MsAS6jPkKuTzLtAvT7bbD0XISIzdL8q6F1IXteUkzaH8y+DUkUVK9QX
         YxBPDNijVdGg1qqZJdTf2hiqlYpCymmeXGg0EBYm75zTm5keJjeu23EaTpm/sxMSbJ4Y
         XJX65g8iUqvy6zXjY5Lx/cQRCvvToUdVDJgfgKsQsnA3eh7jc7p/4LFXtgpWjNb8qrHm
         mxQxDxCm/rBP7eTFKhZ5VhddFHgAs1vNpK42lJ5A57IEXIkpe7D9aL4lUToptbehbn+6
         UcmA==
X-Gm-Message-State: AOAM532ypeP6Zucaw3iJSfMjVh89xJ68nJwqvj7LL8XxDE+kTw8LrilZ
        r5+fNeuOlis6eXXKI6OdkvuOhQcvsJ9mJiu5XSG03w==
X-Google-Smtp-Source: ABdhPJzN5CnBieZu138lO+MKY18OyxyMgt6Xi8QmLZNGOYuis8q2+HoLn/+zrwQAVMqxgws+jp75ootjmnQtp4JKMDQ=
X-Received: by 2002:a05:6512:4c7:: with SMTP id w7mr1953520lfq.444.1634588676542;
 Mon, 18 Oct 2021 13:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211014215703.3705371-1-nathan@kernel.org>
In-Reply-To: <20211014215703.3705371-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Oct 2021 13:24:25 -0700
Message-ID: <CAKwvOd=gqDM=i=RRSgPEtkqYEDBod8C=FTf1SZ1V4U4KMLgGJA@mail.gmail.com>
Subject: Re: [PATCH] staging: wlan-ng: Avoid bitwise vs logical OR warning in hfa384x_usb_throttlefn()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 2:57 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A new warning in clang points out a place in this file where a bitwise
> OR is being used with boolean expressions:
>
> In file included from drivers/staging/wlan-ng/prism2usb.c:2:
> drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
>             ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
>             ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: note: cast one or both operands to int to silence this warning
> 1 warning generated.
>
> The comment explains that short circuiting here is undesirable, as the
> calls to test_and_{clear,set}_bit() need to happen for both sides of the
> expression.
>
> Clang's suggestion would work to silence the warning but the readability
> of the expression would suffer even more. To clean up the warning and
> make the block more readable, use a variable for each side of the
> bitwise expression.

Sure. Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1478
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/staging/wlan-ng/hfa384x_usb.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
> index 59aa84d1837d..938e11a1a0b6 100644
> --- a/drivers/staging/wlan-ng/hfa384x_usb.c
> +++ b/drivers/staging/wlan-ng/hfa384x_usb.c
> @@ -3778,18 +3778,18 @@ static void hfa384x_usb_throttlefn(struct timer_list *t)
>
>         spin_lock_irqsave(&hw->ctlxq.lock, flags);
>
> -       /*
> -        * We need to check BOTH the RX and the TX throttle controls,
> -        * so we use the bitwise OR instead of the logical OR.
> -        */
>         pr_debug("flags=0x%lx\n", hw->usb_flags);
> -       if (!hw->wlandev->hwremoved &&
> -           ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
> -             !test_and_set_bit(WORK_RX_RESUME, &hw->usb_flags)) |
> -            (test_and_clear_bit(THROTTLE_TX, &hw->usb_flags) &&
> -             !test_and_set_bit(WORK_TX_RESUME, &hw->usb_flags))
> -           )) {
> -               schedule_work(&hw->usb_work);
> +       if (!hw->wlandev->hwremoved) {
> +               bool rx_throttle = test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
> +                                  !test_and_set_bit(WORK_RX_RESUME, &hw->usb_flags);
> +               bool tx_throttle = test_and_clear_bit(THROTTLE_TX, &hw->usb_flags) &&
> +                                  !test_and_set_bit(WORK_TX_RESUME, &hw->usb_flags);
> +               /*
> +                * We need to check BOTH the RX and the TX throttle controls,
> +                * so we use the bitwise OR instead of the logical OR.
> +                */
> +               if (rx_throttle | tx_throttle)
> +                       schedule_work(&hw->usb_work);
>         }
>
>         spin_unlock_irqrestore(&hw->ctlxq.lock, flags);
>
> base-commit: 6ac113f741a7674e4268eea3eb13972732d83571
> --
> 2.33.1.637.gf443b226ca
>


-- 
Thanks,
~Nick Desaulniers
