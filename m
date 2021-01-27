Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086F2305391
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhA0GwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhA0GtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 01:49:19 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FDAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 22:48:37 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id d6so788462ilo.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 22:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=J2/ysAQ1CA7Y4zWr9mMw+fT9bYLcUQtcZt+Uu48Rw9Q=;
        b=a7QyW50sBxVF5wcsK/qUdKaCKyJ8sz95DHmqZKFlbF1toIrO8pyqn3KwnzwapuSuS0
         k+6QtgvFphfOpC9SRILCV+D695zQBgdUyWAQmG0Ypg10Vd5hUPObjEef+2JxNuwLQbfo
         5GkMaixD3YEyIPR3+I5JJqSaF4h9FQ8yGZPeRhf+LO0E0wrReOjI/p9a0kPY9maftz6W
         J2lLF2Zrbos4uJ2u6LTmYqCwgMt/SCGUsycyzI0M19sluhA8L/slyxbTr4uSRmP9qArb
         lF9QMyqZLwpjsVDx8P9PqfUhHf3hjOo+ymgSC+10aCeNEpKntqN5NPoiQqlpCjY6kcg2
         +5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=J2/ysAQ1CA7Y4zWr9mMw+fT9bYLcUQtcZt+Uu48Rw9Q=;
        b=brzv4kQw0xFTVBI8mB8wmCMjoU/e88TCLnZdnG4X0C/ABTxAO+KhHZwsX68rmr8WYQ
         h+c1W0yjcmqZdNtvGiuMHNpPxh4t7DfdWOvO7qMOciYLvoCI+AhImUQBdksHrP5iNiRi
         uAmRVF7xZglzQVODYqA0N+MS1zrnFVFb6J/U71W7SnDBA5OKUGtPpJICoUrtjGB3QJLs
         fsYRsPVm0Z0sUDL++N8n1Stwp3xRiUovnAfoHLWGj2AMTpyXDixeq3T7JT/unq0E3XM+
         a1FCWFF6PqaGjR3EX9FawV27VEXFjHeQ+vjTkHLItEpV+0JVdi0L9emVLBpOeyX0Wp+R
         dU4w==
X-Gm-Message-State: AOAM530I+sx3Wa7p1hHjSmQYupe2WYHCV50CsD4UPQ1pyudGY8tq0ID5
        lWEH/XokwYkAG2LPD0sOvFuDGPsX6sg3jkl2Rf8=
X-Google-Smtp-Source: ABdhPJwOT5qYC2Sj6qhw0AMw4OqJni0OnHoXxVtkdqKOtBSqHdi020sBm8OwjO2rtDkep8StKevhdaGe8w2Heo1rX9Q=
X-Received: by 2002:a05:6e02:d0:: with SMTP id r16mr7521211ilq.112.1611730117258;
 Tue, 26 Jan 2021 22:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20210126212730.2097108-1-nathan@kernel.org> <CAKXUXMwErhv-vt1LC6a79yJ2oukDkPa1BnijDXpdwYu1RK3z=A@mail.gmail.com>
In-Reply-To: <CAKXUXMwErhv-vt1LC6a79yJ2oukDkPa1BnijDXpdwYu1RK3z=A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 27 Jan 2021 07:48:26 +0100
Message-ID: <CA+icZUXeVYFJx_McagTz433GjgnvuLKOdtx1Nkit9huWevP-Rw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS/.mailmap: Use my @kernel.org address
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 6:07 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Tue, Jan 26, 2021 at 10:27 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Use my @kernel.org for all points of contact so that I am always
> > accessible.
> >
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>
> Congrats, Nathan. You deserve it for all the warning fixes, reports,
> maintenance, CI, reviews and much more stuff you are doing.
>

+1

Congrats Nathan.

- Sedat -
