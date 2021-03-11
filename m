Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6B53371C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhCKLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhCKLth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:49:37 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D0C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:49:36 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id b10so408123vkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8J99SnIHN40QUiCh4vdDv5XtXr5pbmjm/XVHbBVvsdo=;
        b=h8ZLqeB7M7wbPWxGDpPzKfQIuZJOHhG5As4FbvW0Yf0l9V0uLDCrQXDxPM1kZkevHe
         gKH2xuExf1aX5ktCcJFGF1FYQcI2oVicL4gNYiWPyhrbXk0+aMaAm1YgpsGLPArfP2Hq
         pRolEovwCCiNMCFeoq6NfmiLG9FG8oV3VwsA/AIExOxEOsRCzGdPLsWOQSzVESgbyDXa
         ma2C1jPVLKyk3mri8cXR+J3Uo/LdfN5/cyNgYTQy3tSdO/psFgUvNL3immA3AS81ZQY6
         xuAtBD74h0YpLmU2c/rjrg2K0hkzBLhZXIYsJusVcYd3kjTEmz7m+62wyvRv8F2NSeT/
         qCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8J99SnIHN40QUiCh4vdDv5XtXr5pbmjm/XVHbBVvsdo=;
        b=Abk540iw2AvGuLrxOfIsOvt2dWmczjhuPP46jj1wdLPtl1uKHpQrjp0/1InQETki/W
         ZB/Xa/v+hrHlMNvqxq2ZnzTbFGDaeERu8k669dNmKVE35Cjsi0LgO2dDDR4z+xXNn+wL
         WQ4nnXSm6uFDjY/AuG5/J64+AdxdWMAky87H7sM0mHY0QALJYa1RgVRl8+yuUHx9Na0u
         HIYKV5xrmeNaXPPXddDukxmPFv2z+gGn9d1ErHeJbGSjRYvoxL5ksZwHLB3hFihW9X5a
         e3gPThh1RWT3WUycFpkH+v4201581UgkuNA0Lvl9naWAUF9dSGRMGmk9dvlVxVm49En0
         401g==
X-Gm-Message-State: AOAM531nebhinqGXAShM8zVZouZNAedrzaVMkdjgMNs4CzLCq5RdlAqE
        5BiSvcQMYq8l3+eYtY9HsQENuUcjAHoY+g+z0z9HHA==
X-Google-Smtp-Source: ABdhPJx6dRR9fk/pnTw3aBPdfGpJrX8AMeRQ74wps29lBE0pAN6F0BFTtUFED9CQBE4m/6bTv6K1fofytFjXA13eo9k=
X-Received: by 2002:a1f:2e88:: with SMTP id u130mr4253740vku.15.1615463375690;
 Thu, 11 Mar 2021 03:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20210311174157.561dada9@xhacker.debian>
In-Reply-To: <20210311174157.561dada9@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Mar 2021 12:48:59 +0100
Message-ID: <CAPDyKFqYzJX1eP6VxSXWDPAAKj7NYu1+8YwTmtH1nFbzm+MRag@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: fix a typo in the comment of SDIO_SD_REV_3_00
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 at 10:42, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> I believe "Spev" is typo, should be "Spec".
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  include/linux/mmc/sdio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
> index e28769991e82..2a05d1ac4f0e 100644
> --- a/include/linux/mmc/sdio.h
> +++ b/include/linux/mmc/sdio.h
> @@ -82,7 +82,7 @@
>  #define  SDIO_SD_REV_1_01      0       /* SD Physical Spec Version 1.01 */
>  #define  SDIO_SD_REV_1_10      1       /* SD Physical Spec Version 1.10 */
>  #define  SDIO_SD_REV_2_00      2       /* SD Physical Spec Version 2.00 */
> -#define  SDIO_SD_REV_3_00      3       /* SD Physical Spev Version 3.00 */
> +#define  SDIO_SD_REV_3_00      3       /* SD Physical Spec Version 3.00 */
>
>  #define SDIO_CCCR_IOEx         0x02
>  #define SDIO_CCCR_IORx         0x03
> --
> 2.30.2
>
