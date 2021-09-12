Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64060407BF5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhILFST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 01:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhILFSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 01:18:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE96C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 22:17:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r7so8914372edd.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 22:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=joknhrwptzMt0Qa8G/pJkdX8paSHxbwa4QtgcIWTarA=;
        b=a/limXqWwOtfT5eciR3wVVu7qSk3b/KCwoUyr21lcWQ6/FQsC5w9A58MMDTjOeXgoG
         mt0hE7ukUAgFSdaitxxarPudvvWnja0laQVIb/3sg9gkf0PExFi05PXnGackA7SeJiqa
         /dYis26NVQYPcmCgl4hQf01QjPeRROhADs7/dLHe5qw28U/uCXY5QqH0QpQZxvJmyG/+
         +rqCr3KcEEnB+olXKl/Ccyl63+vJWO7NBRdaqkzpThdpVv4bi8K3Ft6cvjkr3qmqqB0y
         QwURHCvbU6bOD0E1UA7XrwBbh+MpandHiXM5HrXVWvoWwf2B9HVBOpwpvGXdZKJZi3dd
         ijKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joknhrwptzMt0Qa8G/pJkdX8paSHxbwa4QtgcIWTarA=;
        b=kOk+wjfoF0UgDUYhHjcF7KiXFL/f+LCCgXxfsXbUH9/u/NR+DXMGj0p+e8DZ8UythO
         b/w5P1Ucn29MDVLUXOxDHppY4SuA7UzH+3PiUnNtOuGmfnqXBqa6HARSe8bl/NrMH93V
         3PHQwbIiDEF82/Afstuj3GVfY/TLIjNM3zH8pnn7Ogv9WnYMrA7UUM3AOCzPV8HFhgIy
         +T4pJsbtriS5YgWJRwgPqiQuEEjQqe8Le1Y933y6EY0PjRSogCOFw13cmblecjROsY+i
         J3K0B+aJirI9SP35FJxkZRzOqibEgv2xjSmkfEDRIU8erSeecMeIsWbXTtD0s9M5dvbt
         QiiQ==
X-Gm-Message-State: AOAM531PtbpKE8bHRu1pgNkt61/tlbk68jZ3GFCcg+HuJ7pZit9r3zqx
        tkiNDSXCWYl8AQx4aDoWwnvytj+xYKt19BdfJus=
X-Google-Smtp-Source: ABdhPJzjfQMIojU+ogiBMRMLY6W8jotdYEoZevd9RyrHq7fICBUbH7Dvnc4Um3KT4W5q3nl6xU/he+SC5g068In4728=
X-Received: by 2002:aa7:d592:: with SMTP id r18mr6422418edq.172.1631423823089;
 Sat, 11 Sep 2021 22:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210912025235.3514761-1-linux@roeck-us.net> <CAMo8BfJ8f+4AmBD1B7J9vOp0xQbB=zRW-NyGZP6gTPTA-74OPQ@mail.gmail.com>
 <49f8f332-a964-5b98-64c6-9fa5d028731a@roeck-us.net>
In-Reply-To: <49f8f332-a964-5b98-64c6-9fa5d028731a@roeck-us.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 11 Sep 2021 22:16:51 -0700
Message-ID: <CAMo8BfK0+G01bw9UQ=fgGy3fNV+69NwUcpAO3msX0+FU4zKttQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Increase size of gcc stack frame check
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 9:02 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/11/21 8:05 PM, Max Filippov wrote:
> > On Sat, Sep 11, 2021 at 7:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> xtensa frame size is larger than the frame size for almost all other
> >> architectures. This results in more than 50 "the frame size of <n> is
> >> larger than 1024 bytes" errors when trying to build xtensa:allmodconfig.
> >>
> >> Increase frame size for xtensa to 1536 bytes to avoid compile errors
> >> due to frame size limits.
> >>
> >> Cc: Chris Zankel <chris@zankel.net>
> >> Cc: Max Filippov <jcmvbkbc@gmail.com>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>   lib/Kconfig.debug | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >> index ed4a31e34098..afad11e57d6b 100644
> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -346,7 +346,7 @@ config FRAME_WARN
> >>          int "Warn for stack frames larger than"
> >>          range 0 8192
> >>          default 2048 if GCC_PLUGIN_LATENT_ENTROPY
> >> -       default 1536 if (!64BIT && PARISC)
> >> +       default 1536 if (!64BIT && (PARISC || XTENSA))
> >>          default 1024 if (!64BIT && !PARISC)
> >
> > Shouldn't that line also be changed to
> >    default 1024 if (!64BIT && !(PARISC || XTENSA))
> > ?
>
> I could do that, but I tested it and it looks like the evaluation
> is top-down, so it didn't seem necessary or useful. For example,
> the default value is 2048 for 32-bit systems (such as arm, riscv32,
> or i386) if GCC_PLUGIN_LATENT_ENTROPY is enabled, even though the
> line with the default of 1024 matches as well.

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
