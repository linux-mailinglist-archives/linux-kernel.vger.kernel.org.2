Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61924316811
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhBJNdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhBJNdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:33:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CE3D64E16
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612963956;
        bh=67zKQD2KM75eGx35o/MSJcJksqT5rW9r/UKnaw9Bk7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oizrbogHwx/wSl3QZ/A6L6hqtVlTK/wx1SKV/BL2epauNUBfqSk3olmX6GMhJlOqW
         rI/AUlpO4hsHMnvcq+IUETqOUx5eSEBq54GTd7SMkpyKxf8AWxTqrfjSlF0LOlGJwL
         2jHUUbfLQnnr0H/rVJPDt0cv29SQzr0hVrzKEZXEvf1RnARkH6a3GIdIh9H1MYiA27
         2HHQsBoIbBQS7KtQO7Xy4LPH/Y5hQt7HgFM3pycpaWpPCO/OoVODbHbPoOKJEaEcvh
         J22xunSWppvJJ1nTkeRpztH767EHhblQUn9zVMH/m3eojMAgpLxthsSsa8I2wQ8VCq
         GVkSsnJKY1f7Q==
Received: by mail-oi1-f171.google.com with SMTP id k204so1997147oih.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:32:36 -0800 (PST)
X-Gm-Message-State: AOAM5321sGKevNxgWTBJIKPQt6rh9NCFLnJWnd16DWwMkE16jU9BeM6H
        WMmPnfbzT+AVf395mBcDv+HLV0Nkoc20FDCIW8A=
X-Google-Smtp-Source: ABdhPJwxA7ofv7xxiJ1HmHQ5p00YdK//OA4Wn256QwYaT1EM1s61zip8ts4vJhVfzwxTDoNBEiw6BBvSY/HYKtpKCq8=
X-Received: by 2002:aca:2117:: with SMTP id 23mr2085930oiz.4.1612963955644;
 Wed, 10 Feb 2021 05:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20210210103908.1720658-1-hikalium@google.com>
In-Reply-To: <20210210103908.1720658-1-hikalium@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 10 Feb 2021 14:32:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ViL91_uEtOwuvTi34A9gMPF-+82eOLNKh8knt+h811A@mail.gmail.com>
Message-ID: <CAK8P3a1ViL91_uEtOwuvTi34A9gMPF-+82eOLNKh8knt+h811A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce a way to adjust CLOCK_BOOTTIME from
 userspace for VM guests
To:     Hikaru Nishida <hikalium@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        suleiman@google.com, Alexander Graf <graf@amazon.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 11:39 AM Hikaru Nishida <hikalium@chromium.org> wrote:
> From: Hikaru Nishida <hikalium@chromium.org>
>
> We'd like to add a sysfs interface that enable us to advance
> CLOCK_BOOTTIME from userspace. The use case of this change is that
> adjusting guest's CLOCK_BOOTTIME as host suspends to ensure that the
> guest can notice the device has been suspended.
> We have an application that rely on the difference between
> CLOCK_BOOTTIME and CLOCK_MONOTONIC to detect whether the device went
> suspend or not. However, the logic did not work well on VM environment
> since most VMs are pausing the VM guests instead of actually suspending
> them on the host's suspension.
> With following patches, we can adjust CLOCK_BOOTTIME without actually
> suspending guest and make the app working as intended.
> I think this feature is also useful for other VM solutions since there
> was no way to do this from userspace.
>
> As far as I checked, it is working as expected but is there any concern
> about this change? If so, please let me know.

I think the correct internal interface to call would be
timekeeping_inject_sleeptime64(), which changes boottime in a
safe way.

Not sure what should call it, but kvmclock as Alex suggested might
be the right place.

         Arnd
