Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0831C825
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhBPJdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBPJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:33:08 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED80C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:32:27 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id f4so9810487ybk.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGwKySOQn+QZLA3kl46oI1OI2cd4E0l7i8tkigky6/o=;
        b=Hqyve0rfwuAtKaL3EVqxuc3QOJrJSYy3cFjeKwSwsk5/v7UZig+gD/hqNXtnUXZgA3
         PXzxFY2J/hLcjF4QAzlwqgS0l5q8Qg6qs28xz+h6y0C9y+TPWzE11BEjvmq8UBgZOXhi
         xKCPLABRyauXBmjZrENmHvSOsodNEfNcWvsuOPvQ5CZG6edYRNntiEx4+GjQwueerVrg
         FUMRgGnVNDrw9+DsfCeKnNaXewpPgYnDX+csjGqQxfeqSkW9R8VZ3YLeQxMlUw3Nmcay
         8q5n2AaGbwB/RZGmyj8ciCpDVmpaYaiDdt1NpjaS6hR6bIYEeRGu/rrW98aGZqAvGBms
         ihbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGwKySOQn+QZLA3kl46oI1OI2cd4E0l7i8tkigky6/o=;
        b=ACFjXnhBzUKec2ZHoA25jlXTdvZnGppBV3O36uzIik+3IhdkB2W/1D0gNhUJW7NtCZ
         VQyND/yWEydVGNriFvvJtup+35MmvYUWTitjMvbyWVCP8d6fom7LKcIYdGJ6s93bp6bc
         1eVtDdoIYn9YAmWETi90VzUAh10QfxbpziGdDzdCyzpVUdjINV5CKg3RL1JsU1bsobIB
         GEKdIZSQQcmb8zSZJ3oal3UsDlrN7u777VreYdoqS3LkLgbdZbC/U1oXIqhspYU1OE/v
         19V3ssD/Ig0FNoFAH/NBYlpAh7B51n09HO0CLHBwY3bYREQ4u66JKavRVRBkkW7RVUrY
         iofA==
X-Gm-Message-State: AOAM532cJLE7u6DOvGv9cly9YClDfLW6mklHj1GV08CuZ5+KSfNGqCFe
        Z/GcdS1z/vTNZlhWVOXw/d89TMqy649iibAPVre+w2RJ1yZtrQ==
X-Google-Smtp-Source: ABdhPJx5oH48KHDeZy3xbRhosLy5Ma1IJhyfcCndChgrkUctXlX1UW0pm/0xNs610xZAj3xUil2YMjFo82rk1wWBkOI=
X-Received: by 2002:a25:cdc5:: with SMTP id d188mr906282ybf.422.1613467946635;
 Tue, 16 Feb 2021 01:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
 <20210208190735.ibq44r5pc4cwzt7j@linutronix.de> <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de> <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de> <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
 <20210213165040.vzzieegx4aliyosd@linutronix.de>
In-Reply-To: <20210213165040.vzzieegx4aliyosd@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 16 Feb 2021 10:32:15 +0100
Message-ID: <CANiq72mkkSfbnNM_mmXE-TNKO1orsAeyByMKFy1N6hm+EBA40A@mail.gmail.com>
Subject: Re: [PATCH v3] auxdisplay: Remove in_interrupt() usage.
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

On Sat, Feb 13, 2021 at 5:50 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> charlcd_write() is invoked as a VFS->write() callback and as such it is
> always invoked from preemptible context and may sleep.

Can we put this sentence as a comment in the code, right before the
call to cond_resched()?

> charlcd_puts() is invoked from register/unregister callback which is
> preemtible. The reboot notifier callback is also invoked from

Same for this one.

In addition, somehow the spelling fixes got lost from the previous version.

Same for the "code quotes": some have no quotes, others have `` or `'.
No big deal, I can fix it on my side if needed, but just letting you
know! :-)

Thanks!

Cheers,
Miguel
