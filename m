Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C03E9B50
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhHKXud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHKXuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:50:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A208BC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:50:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso7764426pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWMH3PAZAv4+GfGaXs+oiFyMUncS1K0IUlvwZ19DPTY=;
        b=bAHTHIB0S8t5JP0/xnmGPJUG3eA6pFDe+sC32aFryY5J4JP13QgIZOUd5JIuZYPTEe
         AgmWgxnTMW7Uyg+rz77mN7xoZy/svlKW55kIpnCizYO+tOnR+TAvILJiaCi56aAQ0mY4
         Wjt2PPapVUVJgyo/a9NbV/kvjKVrhHEThh/FCqkqLIa803giAKyy4BGVAJWaIb07uvUX
         VKOkACa5/uKr6jT47s5VL+upD5nFny/lQnWJs570hfyHztRBa2DqH4WoGPonN1pR/plt
         91DujdEkt0x2AkN9uPNfKsreGmfKjUfPbmWSz073VP+YOm8zq4WwRQXsczJUYlG3Cab4
         Y+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWMH3PAZAv4+GfGaXs+oiFyMUncS1K0IUlvwZ19DPTY=;
        b=Epn/qMB6YyvQUZFY+MzPoopgj1SoOfKAiS0JwHF8R7meO69rpkhg6c82erjAqIze/9
         4bt6Q0NzDBQ0VBLks17OvLqe8+2N2DTq9LZPgPHUjy9xIsD4BWpL/4h6nrH17BztjWpH
         yLX/lcfctGc4mPzWPVzVGms3hOehekU8eLb2Tw9n59qyEQr4oLYRJ2KjNncLmXLosSoJ
         WE2VkuCD8eXqUfqSyply36ucVtotjFvJSkz9s/yCKzyEa663UUJr+MPc7TaaGyBISqao
         e3/OaITTPh29OIDdnImCdoe3BkizLcCSLQyx4nkdp8L5jDsP0Qs/+ta8pN+mtN8jLng2
         /FHQ==
X-Gm-Message-State: AOAM533uvj01Qfsrk2NqaTLMJaYs5LYWlxKPIbIp2VrLbwOxqrCEoEwC
        IfgWGHoa34tuPJc4rLHsUnCU0hsb51VpYaIIrCw5wQ==
X-Google-Smtp-Source: ABdhPJzPyRs+oWgbMbNXOaBBE90nenU0GBlkAf1I4jaw+EF4bTu41rtzPc0sNxm9DuXwkbmIjwJ2LKQhLIDnaW+9eqc=
X-Received: by 2002:aa7:90d4:0:b029:3b3:2746:5449 with SMTP id
 k20-20020aa790d40000b02903b327465449mr1263455pfk.81.1628725808142; Wed, 11
 Aug 2021 16:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210811201450.31366-1-martin@kaiser.cx>
In-Reply-To: <20210811201450.31366-1-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 12 Aug 2021 00:49:57 +0100
Message-ID: <CAA=Fs0kjxzObRFYU30KhAu_GxA9oZ2R45MHCA-oD3NoFqW88vA@mail.gmail.com>
Subject: Re: [PATCH 1/5] staging: r8188eu: remove unused efuse hal components
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:15, Martin Kaiser <martin@kaiser.cx> wrote:
>
> struct hal_data_8188e contains some components related to efuses which
> are not used for rl8188eu.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/include/rtl8188e_hal.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index ea879572d6e1..3939bf053de1 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -263,9 +263,6 @@ struct hal_data_8188e {
>         u8      bAPKThermalMeterIgnore;
>
>         bool    EepromOrEfuse;
> -       /* 92C:256bytes, 88E:512bytes, we use union set (512bytes) */
> -       u8      EfuseMap[2][HWSET_MAX_SIZE_512];
> -       u8      EfuseUsedPercentage;
>         struct efuse_hal        EfuseHal;
>
>         u8      Index24G_CCK_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
> --
> 2.20.1
>

Dear Martin,

Looks good.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
