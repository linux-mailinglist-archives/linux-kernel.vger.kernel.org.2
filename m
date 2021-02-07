Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534B931212C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 04:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBGDc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 22:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhBGDcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 22:32:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E9D664E7F;
        Sun,  7 Feb 2021 03:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612668732;
        bh=5q+3AseSjJ73gfEyHtsH1AwnHP9+QRAn8sefYBlZhgo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tfdpc0fROte/2EfA4jbpqvHuJLpo8gT6MeZUZ6stzvHGQPxMssEYJzyZYzhN1OyEI
         6e9nAo8d9OjTbMeVgKRRo6ngB+NY+CLcPj8ITHJYRvq/uFHKWaBACDBDKo+LINftQG
         Iykvb8cWFZsSDZrZ1q+kZRmBvvhb9U/ELeO7Ucuo4sF+8QRtPyo3NJ5V/gCpWxiNl3
         evrNhmRn929MP/mkSzvs1HHTjHVF9ch5aXW+ud4mGuVzynbwU3OwqC3ssVjt5ZiYCc
         p+c+lGi3HWbfu58DcJ2kl8UA6d7oN3q+hgSJp8QPqtVOhol85dgF/eVrbFKamahMfy
         E8Ic+Jj0N8RBg==
Received: by mail-lj1-f179.google.com with SMTP id c18so12499511ljd.9;
        Sat, 06 Feb 2021 19:32:12 -0800 (PST)
X-Gm-Message-State: AOAM532Pgw+vi0SBVjC4t8pAtVN97DJmweV+mzP178O+cQPAUXFlAhb5
        el6rBZouXl6zeXq/SgmrEa8sFBzcqNu0+hQqWB4=
X-Google-Smtp-Source: ABdhPJxeX1WqQ4nGoVWb+bT7A7kxtIVu0Xd4yP+o4w8tUS+Z+GDdW96VnaC1q8rPqHW9zJyiE/xRNZ7u0+YiMF8XvhM=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr7004902ljk.285.1612668730907;
 Sat, 06 Feb 2021 19:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20210204074609.3553018-1-guoren@kernel.org> <20210204074609.3553018-2-guoren@kernel.org>
 <c36b816b-6d80-9542-45fc-507c5cc302fb@linaro.org>
In-Reply-To: <c36b816b-6d80-9542-45fc-507c5cc302fb@linaro.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 7 Feb 2021 11:31:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
Message-ID: <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drivers/clocksource: Fixup csky,mptimer compile
 error with CPU_CK610
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Feb 4, 2021 at 4:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 04/02/2021 08:46, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The timer-mp-csky.c only could support CPU_CK860 and it will
> > compile error with CPU_CK610.
> >
> > It has been selected in arch/csky/Kconfig.
>
> It would be better if you fix the root cause of the compilation error.
The timer-mp-csky.c has used specific instructions which only
supported by CK860 and timer-mp-csky.c is only design for CK860.

In arch/csky/Konfig we only select it with CK860.
        select CSKY_MPINTC if CPU_CK860
        select CSKY_MP_TIMER if CPU_CK860

So here let's select timer-mp-csky.c in arch/csky/Kconfig, not in
drivers/clocksource/Kconfig.


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
