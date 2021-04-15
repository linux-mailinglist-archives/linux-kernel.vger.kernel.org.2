Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66252361033
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhDOQbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:31:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC732C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:31:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p23so24116409ljn.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1c68GAsslZ29ILy/hAq4PKTci1jWy3eoAhYN5bcDknI=;
        b=L39UNpvvEEVyaaUZM1BPvSN/8jkX0FwrjhVW815znGAEEtsb9DStzqBCuB56kxdp4X
         +wxCjj/xJO+lCUSM3Bs5kKFirREt07vRFPK0WvkdaEV1/iQkGz8ZSf8qpig5/Y65bTDs
         //2QVAFJIQDWistly1sP0bUIhsoboe0pTIT72ru3X3Skeoi0N4cDYpSpmAKN7MftVT15
         +dw0mgXkxGkkyTuvSxVxquwIlObkOmSuwcbv/SkSC93Qr89DWoCMq6vO1hRWiFosA26C
         T2OMtLxw5ZQeCYF0pzkemvwWL0ehpbN2IyZONGeREikuAkIMMEwU+2sh9kMX97W4ZS5y
         kiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1c68GAsslZ29ILy/hAq4PKTci1jWy3eoAhYN5bcDknI=;
        b=goaXOAi/O0gYgHEcCQIeXQjPe2o8XPk5QXZGuuXjUU3zYnnbWjUdG8hxEV5kbk3bEn
         GPJXrEFTpuZuI2Bokn718jCYJNjyncSRGOUegQi+ejTYTBPnv4h4FF3/2MsrsLSDpq3h
         S/+35YiCTlVcAGrxJjs4L7ylUmnri0tF7CxRxdiRT/jYYLGoEqNKsQ2EM3gG7xgS2djP
         LgPOkG1zU9WxlHhm4DzA10P3wwE1+2ueo/nuMHlv26FAHCMWRPBrZikn2m72nROTMiKy
         vJsT4EDE0l0UArLIOUvaBKLdJABnvS/6MYhVTo0Wq0ocfpzSMXejn51X3Tc5kev4n39g
         kJfA==
X-Gm-Message-State: AOAM533+tSWYBdB5LD1abTCb0nPAW4Bbc20DdtMm9YLJJ3SCaYN6mQ5J
        qFhdz3NunqP7h+qqjsQ+D+VE0z7vgfH2Od55vSy+hE9vOSQ=
X-Google-Smtp-Source: ABdhPJwxH4n8OeuFIgmlVhv7TMkBsupTtrRj9EP6uoOhs2dxadpbtA/csZWJbmKXquP0elmZCkX8+i9H1m2gmGlzGx8=
X-Received: by 2002:a2e:90c2:: with SMTP id o2mr33947ljg.188.1618504259211;
 Thu, 15 Apr 2021 09:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210414181129.1628598-1-lee.jones@linaro.org> <20210414181129.1628598-3-lee.jones@linaro.org>
In-Reply-To: <20210414181129.1628598-3-lee.jones@linaro.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 15 Apr 2021 09:30:47 -0700
Message-ID: <CAHRSSEw94qmnRnSdadpFS62WLm7n+7tqSnjPKmaKYVaza2=v9g@mail.gmail.com>
Subject: Re: [PATCH 02/57] staging: android: ashmem: Supply description for 'new_range'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Robert Love <rlove@google.com>, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:11 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/staging/android/ashmem.c:189: warning: Function parameter or mem=
ber 'new_range' not described in 'range_alloc'
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Arve Hj=C3=B8nnev=C3=A5g" <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Robert Love <rlove@google.com>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/staging/android/ashmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/a=
shmem.c
> index d66a64e42273a..8ee4320a5dc6d 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -179,6 +179,7 @@ static inline void lru_del(struct ashmem_range *range=
)
>   * @purged:       Initial purge status (ASMEM_NOT_PURGED or ASHMEM_WAS_P=
URGED)
>   * @start:        The starting page (inclusive)
>   * @end:          The ending page (inclusive)
> + * @new_range:    The placeholder for the new range
>   *
>   * This function is protected by ashmem_mutex.
>   */
> --
> 2.27.0
>
