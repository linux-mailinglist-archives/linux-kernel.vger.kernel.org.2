Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6936D1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhD1FnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhD1FnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:43:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A761C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 22:42:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i24so13078577edy.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3Mkur9mLYYzBDTie+MB3UI5+5H4sPNthy0DIOUyDXA=;
        b=VeESWxs/qCIM89mYsejS8yQkSMK3TJIPaq3pRwTV3M7PAm6NCZEBJt0VQyxW3PkZDF
         mcNWWNJyfGPPGMeKf0/cqZLIc7+PWb+rSoDiHy5tOAbDo337Gh0Rqpl8YIKxVl1J0F/g
         zTIkEUSHJgKO/WPqNzM00Vp2Q1PnVnaPrKCpoImwFV3SDwL6hTGV1gclobDeIEbt0Tum
         gITbupBeam6ASARaGJQg/o/ZSTpEs3q6UX2XysVR2D7nvEc4wKzXJMgh5KVofjuSdr13
         oon5nGeP4WkaGTC51F0n6aCjmPVCm55uxgE7iymCpqRYfjwO76igI2E6Cz+K9MAnAnll
         DTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3Mkur9mLYYzBDTie+MB3UI5+5H4sPNthy0DIOUyDXA=;
        b=L2gUdqKI+zrpdZR41YVPGrV4obKXYRmdlkna++h64enhbv8Q5TGnlP1jyG+BHugO06
         wS7sAzFmvTqsOUYy/xl35RWO2D2nTgPsv2zerSizA7nFGpKlEYIpsJed9fytrLmTkkL0
         /0MN8QOoUm0ILncwuAu0GFWiGjhlsK+2wunwgiBlxHj6ww2gkgpqWxLlp3n6Qr9fiU1q
         3C4knre4lwUUgZdhCAgGz4sCfD98YQrioq9jlxSGv1oYSa433LL19C27Erz3AiVMnhiV
         QXMf2fJ1p9O0oEAlD+f9ft+T+ZJoJsbueGKV2w29/igNXmjF3OM5W1XYc0y/ZVQetmmJ
         hDLQ==
X-Gm-Message-State: AOAM532OvlIgLFCW8gi6pMpAU68JRJHd4qNeNRmhHdlPFweIi6tNhH4A
        jciYSjgd/4UOR9WapN/6Nt1DJYWibQIDDbg7fluCSlpVWoY=
X-Google-Smtp-Source: ABdhPJz6VPKkKXsjABuakCjAlug81JoUbcJlIdX4uXn4jK9FpV/t3ROQK5C30cXMnDhTz9ANHsaxbJrvf+B8GC232iQ=
X-Received: by 2002:a05:6402:1d3b:: with SMTP id dh27mr8678214edb.220.1619588546889;
 Tue, 27 Apr 2021 22:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210412113315.91700-1-gi-oh.kim@ionos.com>
In-Reply-To: <20210412113315.91700-1-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Wed, 28 Apr 2021 07:41:51 +0200
Message-ID: <CAJX1YtbXnPVbkpddXQf4MZ3sopoidr0fZ8OkrQegoLoCevaNwQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: sysfs_streq works case insensitively
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 1:33 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> As the name shows, it checks the strings inputed from sysfs.
> It should work for both case-sensitive filesystem and
> case-insensitive filesystem. Therefore sysfs_streq should work
> case-insensitively.
>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> ---
>  lib/string.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/string.c b/lib/string.c
> index 7548eb715ddb..d0914dffdaae 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -688,7 +688,8 @@ EXPORT_SYMBOL(strsep);
>  #endif
>
>  /**
> - * sysfs_streq - return true if strings are equal, modulo trailing newline
> + * sysfs_streq - return true if strings are equal case-insentively,
> + *               modulo trailing newline
>   * @s1: one string
>   * @s2: another string
>   *
> @@ -696,10 +697,11 @@ EXPORT_SYMBOL(strsep);
>   * NUL and newline-then-NUL as equivalent string terminations.  It's
>   * geared for use with sysfs input strings, which generally terminate
>   * with newlines but are compared against values without newlines.
> + * And case does not matter for the sysfs input strings comparison.
>   */
>  bool sysfs_streq(const char *s1, const char *s2)
>  {
> -       while (*s1 && *s1 == *s2) {
> +       while (*s1 && tolower(*s1) == tolower(*s2)) {
>                 s1++;
>                 s2++;
>         }
> --
> 2.25.1
>

Hi Andrew,

I changed sysfs_streq to be case-insensitive as you requested.
Is there any progress?
