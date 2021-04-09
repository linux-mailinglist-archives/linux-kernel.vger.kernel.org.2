Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226E435A1C0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhDIPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhDIPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:12:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C582C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:12:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b4so10234518lfi.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cjPyAVeoyKs/BJVrTfgcsuPwG3n5h8l8AkpiqD0Yok=;
        b=fL4UvF3Mormy3B8XnEQTzwwQUiNjYqdK6JtsLu/2UKCfCY7oEzvCCEC8cFtw4CFXlw
         tbc/yoNlYSiyq2cyichqo7FRg9n5ZndydJFgpBOb0k/Ay3r7/jVK4SOnN4ibk2nZCpkX
         1xF+itPSTEsStf5ea5aAjrVTwOPJaNrqJYqBPFcXhfcoeA+LMnkmbTmhWcyINm5pUu0J
         zXT+FEJdQQNziDzHUjNKplBmzPy4CTwUUwSoPrs6ojVuHPQnaYEedB/J6GY+yFUv3gEB
         NwW4H3Yl+5C124lS5euXkCSUHbJ5ztVnlzfngkdcQcVnad23pwMnm0v1w9ccrv3Vb2aR
         bGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cjPyAVeoyKs/BJVrTfgcsuPwG3n5h8l8AkpiqD0Yok=;
        b=Vawc/43I1wiytU6CgSN7Nvd2fy88pKn1HS9XvnBbs6aFJsBtkK6s2wmvcB57yXLc5R
         sKIH11irfqZAsVTu+sguoZiCmrMEaT3MPRZUoha9+wV70TgzZyocCjU3VB1jcYADXvZY
         UUVTU3EQwQMphCypnCWK+Zr2Nl+3oX478MSeEEk3CD1DjGakKcXiUw6tLC+m3+r2RvQd
         rg+SqCwMabtWRHaWWCNdXFeg9+H6wWPUkcereJTFHaZPFLvgtno6kFlu1EZ5KTVANYP7
         Mo3+rOML7L+jhriyJDF7ju1yeOcW7WXwOC8sWvJSALC/vv+I4vvaZ+plAVtOf9emIEvJ
         tfDw==
X-Gm-Message-State: AOAM532wntFjSE02sx4JIUiNnB/WXUCLpMefqoheXDTwPxIEYrdnz1Ln
        pz4K2feOpQgJbmIv5fmdwVu/+CFqdvRivDJ1MxIhew==
X-Google-Smtp-Source: ABdhPJwsHZoVY7qlq7NbCebva/XKPpIsDOVrIJDyoE19v6sAhvg+bFHPHExjBfj11XWbm3jxs1PUIbtSJBuVhTUB09I=
X-Received: by 2002:a05:6512:68b:: with SMTP id t11mr10439447lfe.597.1617981140059;
 Fri, 09 Apr 2021 08:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <1617961246-4502-1-git-send-email-hangl@codeaurora.org> <1617961246-4502-2-git-send-email-hangl@codeaurora.org>
In-Reply-To: <1617961246-4502-2-git-send-email-hangl@codeaurora.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 9 Apr 2021 08:12:07 -0700
Message-ID: <CAHRSSExq9=-+3ck7-pm6igV77szy0tjv29bu_-0cK5xbq-s7Ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] binder: fix the missing BR_FROZEN_REPLY in binder_return_strings
To:     Hang Lu <hangl@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>, rdunlap@infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Li Li

On Fri, Apr 9, 2021 at 2:42 AM Hang Lu <hangl@codeaurora.org> wrote:
>
> Add BR_FROZEN_REPLY in binder_return_strings to support stat function.
>
> Fixes: ae28c1be1e54 ("binder: BINDER_GET_FROZEN_INFO ioctl")
> Signed-off-by: Hang Lu <hangl@codeaurora.org>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c          | 3 ++-
>  drivers/android/binder_internal.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index e1a484a..be34da3 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5559,7 +5559,8 @@ static const char * const binder_return_strings[] = {
>         "BR_FINISHED",
>         "BR_DEAD_BINDER",
>         "BR_CLEAR_DEATH_NOTIFICATION_DONE",
> -       "BR_FAILED_REPLY"
> +       "BR_FAILED_REPLY",
> +       "BR_FROZEN_REPLY",
>  };
>
>  static const char * const binder_command_strings[] = {
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 2872a7d..a507166 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -155,7 +155,7 @@ enum binder_stat_types {
>  };
>
>  struct binder_stats {
> -       atomic_t br[_IOC_NR(BR_FAILED_REPLY) + 1];
> +       atomic_t br[_IOC_NR(BR_FROZEN_REPLY) + 1];
>         atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
>         atomic_t obj_created[BINDER_STAT_COUNT];
>         atomic_t obj_deleted[BINDER_STAT_COUNT];
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
