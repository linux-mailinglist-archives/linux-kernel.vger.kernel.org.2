Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B4B307E11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhA1SeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhA1ScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:32:16 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBA1C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:31:36 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 11so4560223pfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=suAFFul/sTYclZVZXFYJfemeWOXNN1vPSZ2Xpd9nrA4=;
        b=b6Lwkjy/vcP4o/EqeXAlrQ3lEI7ZA4UObPSdcpbgI1lonbnkOXcbFQnLSWhE4IDYlg
         nycU0Jg68D4nM0ej8b3IQz8Eda4Y4i94WtV3bHbNoT7S+g7Y3f3AO2WyT+bs1oZXVWbP
         1nCXhoKYACbAdINvSY55L7VSeEXsFaixuYmHo3rrlrfis2kqFKQiS5D3xdJhqAnfI14/
         VKPnC4G7iN9NT61wtoUkQLG9NfmukRKw31BLUXz/NvIqFtxYcxxccR2dlPWXC1iUmjLi
         YaXVgEVNCu0+YnNcUgDwQ0/iVZoC5e8X3dY+V4TcNOry2RG6pkq7nAeyqE+epQUmi4ZJ
         5rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suAFFul/sTYclZVZXFYJfemeWOXNN1vPSZ2Xpd9nrA4=;
        b=FdYZEyVGuaKj8BoKc63eKDWe9seN1Zpx/4c2MEAfpuxjNAlrKcDnYpk2KlNZUK55us
         aqAVLdQ6QHWA1DX6W4BCzG4KyHzHp7wA6Jb406ZQ63v9Ni14xVNdSIvGHJGXztaHRG1t
         XUgijZ9NZau45kDTNDN9GfywzmCw1q5sXPSauVrestiGXsOkWaIfSzvfidqMVQS2IVuF
         9cYtvapXhhUmrAOMoasQ9/YcuU404AePie1WP4O62lb4JunoQGZBrJks3vOkDyWzu1np
         0G9puC14EwJQQs1Bs1beAkqQD9jwlkhaI1X7o3MzpQR2UAL4TdfnABxrPFs5gt0RBKhe
         79mg==
X-Gm-Message-State: AOAM530lV7dFeVmgkF+/DlDH66zl9pjdLZi7sHoYtYFuEfvCsT31wbsH
        BIodBZTnDnJPCdPOqEMymNcfmr4slZ0M6HCkVnhpJA==
X-Google-Smtp-Source: ABdhPJzB9JcxN/jciJDIZ2tVx3gVhVuNMec8Qn0Kxl9UEiO1fjgz/GZ1qn2GOdLfq2KBvG5BW5rd0jdVK23rb+1iEvk=
X-Received: by 2002:a65:4201:: with SMTP id c1mr779610pgq.10.1611858695379;
 Thu, 28 Jan 2021 10:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20210128065739.14124-1-candlesea@gmail.com>
In-Reply-To: <20210128065739.14124-1-candlesea@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Jan 2021 10:31:24 -0800
Message-ID: <CAKwvOdmviwYfLs4YOY3C0Hi6nw2JKPCW5kAGM_qPTOcrAUVQ5w@mail.gmail.com>
Subject: Re: [PATCH v3] lkdtm: fix memory copy size for WRITE_KERN
To:     Candle Sun <candlesea@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        candle.sun@unisoc.com, David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:58 PM Candle Sun <candlesea@gmail.com> wrote:
>
> From: Candle Sun <candle.sun@unisoc.com>
>
> Though do_overwritten() follows do_nothing() in source code, the final
> memory address order is determined by the compiler. We can't always
> assume address of do_overwritten() is bigger than do_nothing(). At least
> the Clang we are using places do_overwritten() before do_nothing() in the
> object. This causes the copy size in lkdtm_WRITE_KERN() is *really* big
> and WRITE_KERN test on ARM32 arch will fail.
>
> Get absolute value of the address subtraction for memcpy() size.

LGTM, thanks Candle!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> ---
> Changes in v3:
> - Clean some typo.
> - Remove one comment line.
> Changes in v2:
> - Use abs() in place of address comparison.
> ---
>  drivers/misc/lkdtm/perms.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 2dede2ef658f..c9227e08f97f 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -31,13 +31,12 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
>   * This just returns to the caller. It is designed to be copied into
>   * non-executable memory regions.
>   */
> -static void do_nothing(void)
> +static noinline void do_nothing(void)
>  {
>         return;
>  }
>
> -/* Must immediately follow do_nothing for size calculuations to work out. */
> -static void do_overwritten(void)
> +static noinline void do_overwritten(void)
>  {
>         pr_info("do_overwritten wasn't overwritten!\n");
>         return;
> @@ -113,7 +112,7 @@ void lkdtm_WRITE_KERN(void)
>         size_t size;
>         volatile unsigned char *ptr;
>
> -       size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
> +       size = (size_t)abs((uintptr_t)do_overwritten - (uintptr_t)do_nothing);
>         ptr = (unsigned char *)do_overwritten;
>
>         pr_info("attempting bad %zu byte write at %px\n", size, ptr);
> --
> 2.17.0
>


-- 
Thanks,
~Nick Desaulniers
