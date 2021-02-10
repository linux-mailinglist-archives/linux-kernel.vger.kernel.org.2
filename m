Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D013172A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhBJVrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbhBJVrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:47:15 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29DCC061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:46:34 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p186so3572914ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYDFwgJG+B9JGjyghuiLmPAsWot/rZ7zHMMlK8N94XM=;
        b=FYu+PGpX66lOPjmBR15vH14/+3I2bBolaYSuBF53mdi7o0QgVD8Jaj5OHVV/zXPzPH
         xJ50dqHKcSCQW/NAFFjZ9YZ+W4zN1kh5x/+pDUhPTMPlMS83M5xTS9tSdrhMQC4pvi4Y
         FvO+o332u9lDYIn9ZG9QbOxj+KFidrc780MjPkV3IPXmnTm1dfrlwAZiq7bkTRwqEvRD
         RLVDu0UO0x6LKX3hLEySMgBIV6N6kijRHmkC28iqvtVweoWRqzfXneC3n30cmIwWO3I5
         d82HtLP0PKtPmN37rXxlwvCn95eJNfsG3W8bvuJJbSre7V6VY58acQJfozaHqT8QxvMo
         UKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYDFwgJG+B9JGjyghuiLmPAsWot/rZ7zHMMlK8N94XM=;
        b=DZ4L9Kr3XPsrSFwkm1ju6btnm5N/GJKPtWiUqTIc3VtgE3uFgIRb4wUayJNAk+8Gpz
         K7KcB+OF1YEoC9mx++6jyD1/9xeoGbal8t6L+orQ8DJpKHxgbSoLNDwF2+8ya2mLWVTC
         JCwOoK47bF9tc/Xo9STokK3Uo1LLDQuDyE/bIYbqsFpX31Paoa1whVFvmlN7cy+mk3JK
         ycTqw7iyZ0P+iMGpjvOKc7ItCae+hW/b6pLt3+yBV/uv4RtGBOYbXIXkbLaKp9IVbs7t
         3Ssx8IhCQprHRxpgt+fidvg9VgK9uwBOgd85wIHkFFvnGazqRSyk8zPydzfxKLV5qoBT
         b4wQ==
X-Gm-Message-State: AOAM533LmRrIrNyA5CFvjvVfmO5Wk+JDbUXS4P7Do9btbO4/JVEamhZw
        Dnsupfp5w0UVxlIusAO2ZiFtV+zTq4zZIk+aGh0=
X-Google-Smtp-Source: ABdhPJzoJWAiVdeO33Ss0CW5o8aEyXO20Oib+FtkFREf/iJ2uvvkOXw9U0s5Yq8+S9QMTCEw1UHIxM4V2T6lSFnOqRA=
X-Received: by 2002:a25:a125:: with SMTP id z34mr6993996ybh.22.1612993594224;
 Wed, 10 Feb 2021 13:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
 <20210208190735.ibq44r5pc4cwzt7j@linutronix.de> <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de> <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de>
In-Reply-To: <20210209090112.lewvvhnc2y7oyr27@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 10 Feb 2021 22:46:23 +0100
Message-ID: <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Remove in_interrupt() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Tue, Feb 9, 2021 at 10:01 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> If I post series with more than just one patch I have a cover letter
> including:

Yeah, it is a bit confusing when reading without the context (it is
hard to keep up with everything going on unless you work full-time on
it :-)

> since this patch was small, simple and removing not required code I kept
> it out. Is this enough information for you?

If you don't mind, please add a quick sentence like (I can do it on my
side too):

    `in_interrupt()` and related context checks are being removed
    from non-core code.

Plus the tag:

    Link: https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/

> The information is not wrong, it doesn't say you have to use it it your
> driver. It also does not mention that you should not. I will look into
> this.

Thanks!

Cheers,
Miguel
