Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6915D3E07BE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbhHDSiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbhHDSiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:38:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E760C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:38:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c24so2779165lfi.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3rdKtAtmpUfyg0lATOCk0JofX75VMc/F9YVDgzTlmo=;
        b=hL3kh7fJ702qfHXGRmuNiz3WpbcUAIrGJjPnBX5dl7IcYmyfOdz543UZqWDT9auUXu
         +VKOuEoya/RW3soo5yomR07LY2DsOXiifZCXUkIY4JBqSOvAdGB29LKMpJPtxEgPSUHR
         H++B0VlI83gfkmknd9OB6FSzqh5klIS5f4O0o4yySG8tzcz11ZqasKTe2ESGVrsYod1Z
         xm8x2moPh0FqBv8qLK9+EW15OlH9eSsWWrQsnVQLnXhNgf2SjdRb/Knf6kdg46Wt+QCC
         mAJLezw1X8dPuqC2g7ftR97cJZOagQQb3QqKIBdHNQkU6GCqg63/eg30usVvtY6OJ2L+
         FNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3rdKtAtmpUfyg0lATOCk0JofX75VMc/F9YVDgzTlmo=;
        b=Z6cbP8IkwyE+5/SNtihLeS9rBfsq7vVEc43tRipfR4ewtSdXwjC4mEEGymSj5JqU2N
         RTndjnaMjv/3agGHah3JzeC4RG3aqcGStxYdk31LYUH3I+380h/sTdF3zmXZw0bRh+Ic
         CE0CZvzYB7u/OJUqWM0gysUXGEVOV8FxiCPzXDfCcV6mLdQ4o5F9e63yav0sweRk2yYE
         WcFr/pZD+RJD5mV3iz+7U2G4ZBWwiQPxeCRL82nZKnIFfxdPXU1Z0fasIndEoXHehrpr
         7ruG5bJDNqWXw374+c3JKHA9lpSUF3ZyqhJ3hm90y8IASDNHnecKZxSmLELw8zPb5AYZ
         wGUw==
X-Gm-Message-State: AOAM533Jml1foQavLOB8UmfmDUfvbObs5s9/RSGJTwO3pkP983LzOZm1
        MOuMS0AD6c8tjGrH8GX++wJBJM4vjvrNAc22ULN93NF4iuGfffTe
X-Google-Smtp-Source: ABdhPJwmIgOGB5O+9dimurF7YRRNX7IZEMgxHnqzHkVp9BaLqeko7Y4HJz1/6ayQ0E/T76/BZdQ9QGAMvx4jBBfRMII=
X-Received: by 2002:a05:6512:2215:: with SMTP id h21mr413449lfu.543.1628102286318;
 Wed, 04 Aug 2021 11:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210803223609.1627280-1-nathan@kernel.org> <20210803223609.1627280-4-nathan@kernel.org>
In-Reply-To: <20210803223609.1627280-4-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Aug 2021 11:37:55 -0700
Message-ID: <CAKwvOdkehOWitL+o4s2jWiPk0eTmcjrntiw2rLbpiGynTqSfRw@mail.gmail.com>
Subject: Re: [PATCH 3/4] staging: r8188eu: Remove self assignment in get_rx_power_val_by_reg()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 3:36 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
> drivers/staging/r8188eu/hal/rtl8188e_rf6052.c:344:13: warning:
> explicitly assigning value of variable of type 'u32' (aka 'unsigned
> int') to itself [-Wself-assign]
>                         writeVal = writeVal;
>                         ~~~~~~~~ ^ ~~~~~~~~
> 1 warning generated.
>
> Remove this branch as it is useless.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> index 335b120ce603..77889dc05858 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> @@ -340,8 +340,6 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
>                 /*  This mechanism is only applied when Driver-Highpower-Mechanism is OFF. */
>                 if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_BT1)
>                         writeVal = writeVal - 0x06060606;
> -               else if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_BT2)
> -                       writeVal = writeVal;

Hopefully the author didn't mean to subtract another magic constant
like they did above. This also eliminates the last use of
TxHighPwrLevel_BT2, but it's probably ok to keep the define in
drivers/staging/r8188eu/include/odm.h.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                 *(pOutWriteVal+rf) = writeVal;
>         }
>  }
> --
> 2.33.0.rc0


-- 
Thanks,
~Nick Desaulniers
