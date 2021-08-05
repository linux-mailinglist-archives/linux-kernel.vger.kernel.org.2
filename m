Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352623E1CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbhHETwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhHETwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:52:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337A8C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:51:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m9so8651348ljp.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CH/S1vxA5I8GeZeVb6jLgVXcxKJTGgioM4LVcjLmIww=;
        b=sF9eufANix5PTHYDsMIpQJRgHz57CSFrOyr8yOntdCzOHJHuRdd6Kr211Rgoh9lUZj
         ANqjbrVZH5SEvSfCnqpANWoOrCxEkhRZSjJr9p9G8tFhvoI0cOMNI+36Ymic7Q4Ym2Y1
         74d5b6l/po0QTBNrwfPe2J90Ust/u30xsOJdKa+fuoWxmne9pCOt6T22Sr3QfGVASYtQ
         EW6GQSTiakWJF0HR9xXev2wP9/D5yWQ5wR0D0TXeHyK4DL4Mt9M3vSRSCmF//9rAMC4+
         Z2aEkNvmGCvc5UKPRpE0t5iXiCiQRhhrBS5G02mcux2Gy7vKvVFo0NSiFfCRukIW9xYv
         M8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CH/S1vxA5I8GeZeVb6jLgVXcxKJTGgioM4LVcjLmIww=;
        b=F/lAesZRe7RGDBvZZbtigw36XeBCJhg495P4RS6SkB3HQ6v/aLNp90+afdO5vxFnvb
         qQ5hSGt1SLSSwmUcPFfRN/AcBKxJYxj76AMAonvX07AFFoL7JvSPW2xF6sPSQQTqIBdl
         na0xM1j6YsXJ5BN2ozVQMkHV1E8fbqqEVEzvEGat/4rDDk0FBQp8b8BCqXmtM7BQ86T5
         vBj/xsaJUHFx3tkylTQh9FwDYY6vUQa7bvUbG02UGxxyEtcdyovpurCMVwJMkXOso+yL
         qowUJBbPx59J08Rtm/78VDtXFmRVd4yGJ4JinWN9pgTxszCJdkpjT8s8Lx6GQsBX8Ck2
         FWcA==
X-Gm-Message-State: AOAM533hH0Cbo5R82knuHjbk2h6TKJF6eYNb1EOn/OljHnH48SpBUnmC
        AYbIkrGOXlC1VJ0OBpl/ujMUtos94EMnhpShkkuSuA==
X-Google-Smtp-Source: ABdhPJyAVqp4dLfEEurCIL5rV06z2J2twMqwp9yzx4nkKVQIVFbTbWhEhGAohxhOMCzeCbqLPNdewFrW2gIO1hgQsc8=
X-Received: by 2002:a2e:a911:: with SMTP id j17mr4145550ljq.341.1628193115272;
 Thu, 05 Aug 2021 12:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210803223609.1627280-1-nathan@kernel.org> <20210805185807.3296077-1-nathan@kernel.org>
 <20210805185807.3296077-4-nathan@kernel.org>
In-Reply-To: <20210805185807.3296077-4-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 5 Aug 2021 12:51:44 -0700
Message-ID: <CAKwvOdkvtB0mimF-3c+jfOPrSGwWp98RZCK5+v3LGT3ZrajbaA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] staging: r8188eu: Remove pointless NULL check in rtw_check_join_candidate()
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

On Thu, Aug 5, 2021 at 11:58 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
> drivers/staging/r8188eu/core/rtw_mlme.c:1629:28: warning: address of
> array 'pmlmepriv->assoc_ssid.Ssid' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (pmlmepriv->assoc_ssid.Ssid && pmlmepriv->assoc_ssid.SsidLength) {
>             ~~~~~~~~~~~~~~~~~~~~~~^~~~ ~~
> 1 warning generated.
>
> Ssid is an array not at the beginning of a struct so its address cannot
> be NULL so remove the check.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index e3d5a721d25c..95b952871e67 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -1622,7 +1622,7 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
>         }
>
>         /* check ssid, if needed */
> -       if (pmlmepriv->assoc_ssid.Ssid && pmlmepriv->assoc_ssid.SsidLength) {
> +       if (pmlmepriv->assoc_ssid.SsidLength) {

Perhaps they meant to check `pmlmepriv->assoc_ssid.Ssid[0]` but the
length should probably reflect that anyways.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                 if (competitor->network.Ssid.SsidLength != pmlmepriv->assoc_ssid.SsidLength ||
>                     memcmp(competitor->network.Ssid.Ssid, pmlmepriv->assoc_ssid.Ssid, pmlmepriv->assoc_ssid.SsidLength))
>                         goto exit;
> --
> 2.33.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
