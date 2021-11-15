Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28394450CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 18:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbhKORq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 12:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbhKORTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:19:51 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0D7C06122C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:13:24 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f9so22269176ioo.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2es5dbHXRJPkreWY9KX+HP22ehmWI1e8VyeSPUZii4=;
        b=oKeuZLodUAoDdRWVbHJJiXxXQNm2vFpXlYlgJwfX0fxFKVAkaq6H93Jm8MewHWtysM
         sdcA1kOK108oSD8naCwAfMuczfWMhTXGpka/jzUMOcCCxRp3o64hvduPw0YdNozz0H2/
         EeJlikZFNAg35BabEWnEAjtW5AC2cbAHWXZE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2es5dbHXRJPkreWY9KX+HP22ehmWI1e8VyeSPUZii4=;
        b=Ycu6qMyIwdECIBbOGd/MzZZ6GQwO77iWRfKxn4F2k+T0uw6B+xTclWzqhipM6zxWIf
         maQqutd6LbgvHDg7XdbgPHqUF/kA0qPtmGosfZsOe9UMaQ7wHIbb+8qFN/o1xQl00MZN
         EhJvzBKZrmxrV52BrDb3tN8R21u6UUJOR0KahOsV8FEdcQ1RWqN3I+BgBDb/zKotOysU
         qhzCcdGoVk89C4jtctVsNG0lj02QEpRpxnfpLX2V6PPuKequCauZkfzakmpvXmuQYu9p
         OkN/uHLL98cUFyjBCr5YyS9IJWdBUKZ0e4orVSuwjHa30vPOfuHNRfL4EGj287eI+G+L
         POJw==
X-Gm-Message-State: AOAM533nDPDkUrfUqeRwr6oe//D7kagfNu58KOobIEEsCCjG+1fYp4Wk
        P8eUs6CwjPp/aQyPnlt1emqG9T8dzbdwEA==
X-Google-Smtp-Source: ABdhPJxNb4t0wbkjojujH26fhlSPfzqsPS5Ddf3OkRALGRz7XvsUZ1r/0553Yh+uiVWBWNEvMIqO+w==
X-Received: by 2002:a6b:8ed4:: with SMTP id q203mr293553iod.200.1636996404268;
        Mon, 15 Nov 2021 09:13:24 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id l4sm10637487ilv.46.2021.11.15.09.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 09:13:24 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id m11so17502960ilh.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:13:23 -0800 (PST)
X-Received: by 2002:a92:6910:: with SMTP id e16mr313484ilc.190.1636996403030;
 Mon, 15 Nov 2021 09:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
In-Reply-To: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 15 Nov 2021 09:12:47 -0800
X-Gmail-Original-Message-ID: <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com>
Message-ID: <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Fix snapshot partial write lengths
To:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle bump.


On Fri, Oct 29, 2021 at 12:24 PM Evan Green <evgreen@chromium.org> wrote:
>
> snapshot_write() is inappropriately limiting the amount of data that can
> be written in cases where a partial page has already been written. For
> example, one would expect to be able to write 1 byte, then 4095 bytes to
> the snapshot device, and have both of those complete fully (since now
> we're aligned to a page again). But what ends up happening is we write 1
> byte, then 4094/4095 bytes complete successfully.
>
> The reason is that simple_write_to_buffer()'s second argument is the
> total size of the buffer, not the size of the buffer minus the offset.
> Since simple_write_to_buffer() accounts for the offset in its
> implementation, snapshot_write() can just pass the full page size
> directly down.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
>  kernel/power/user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 740723bb388524..ad241b4ff64c58 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
>                 if (res <= 0)
>                         goto unlock;
>         } else {
> -               res = PAGE_SIZE - pg_offp;
> +               res = PAGE_SIZE;
>         }
>
>         if (!data_of(data->handle)) {
> --
> 2.31.0
>
