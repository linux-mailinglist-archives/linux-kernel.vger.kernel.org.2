Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814833450B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhCVU1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232319AbhCVU0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:26:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2EBC6192D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616444799;
        bh=TCgVn6BB3w6F4s/+//BYt84HxccYqGXxV6srV5MngiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fJr+bvd1OLPpHacH3GgE974NurUFyyS4cAhx9PpZakHdWqO3ribpjJ+1j3A2XTiiE
         M0T++nbsbN98mKyTLcrDQgbPIHb7ICF6sArPQKHtfjEkyXeurFqUoAZAZBPfmURmTA
         Uy9QdfoPYUiFCAMq1gZWqxKZon1jyItL6bn3OKfRefI8vsI8teOLbUUR43O/6+xuw2
         n3fsnTxEiWl3PAtrGeXVKuI9IkLhA0ITfNQKh7xm+Pyw33J++UwokSC7i3qLhxkah5
         UqoMVVDDdJC+CBrNZRaYVUVEtVDeOohUW9qQM5M8jIpce3rJgWffX7EywvNgT1NWsu
         UYF4xCkGva6Ng==
Received: by mail-oo1-f44.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so4429015ool.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:26:38 -0700 (PDT)
X-Gm-Message-State: AOAM532NGMfLUqy2TNeK/CA1ldqSH7Nd8vfQaDmpSUzth271eYIvrI0c
        OUZI2dn3klmjcVdoQTCiDQq6qG4Cba3awvFTnO4=
X-Google-Smtp-Source: ABdhPJzLQ+qBxdCWCS2mJch1YEGt0KrEHYPlaw8sRsh2gak7YjJqhkOeJMaLBj9XQzdpKHIIP0oj6HLgGkjGyYtNyaQ=
X-Received: by 2002:a4a:244d:: with SMTP id v13mr998106oov.66.1616444798370;
 Mon, 22 Mar 2021 13:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210322164308.827846-1-arnd@kernel.org> <CAD=FV=WY6yxx+vkH+UU4VYei29xBftdnyRBE1OpEELmJ-kLfFg@mail.gmail.com>
 <CAK8P3a33qv79GedMCwA=GFBWYCMB2fYrq2QmGpN3TWfqgg8j2A@mail.gmail.com>
 <CAD=FV=WaOFJEnZ=b+UTaTXDWMs8JOeBw1gRFYrtSJK-+CXGPyw@mail.gmail.com> <1bdabbff-8e3f-60dd-145d-af2dc45c1da5@windriver.com>
In-Reply-To: <1bdabbff-8e3f-60dd-145d-af2dc45c1da5@windriver.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 22 Mar 2021 21:26:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0URcb4ZcaTo9cBuey28EqHu_3EHBpcDAZDAt8Rde5RJA@mail.gmail.com>
Message-ID: <CAK8P3a0URcb4ZcaTo9cBuey28EqHu_3EHBpcDAZDAt8Rde5RJA@mail.gmail.com>
Subject: Re: [PATCH] kgdb: fix gcc-11 warning on indentation
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 9:14 PM Jason Wessel <jason.wessel@windriver.com> wrote:
>
> The original board this was developed with was a 32bit eeepc.
>
> The intent was that when v2printk() was called for a verbose > 1
> condition the touch_nmi_watchdog() was called.   The test case
> where a whole lot of single steps are executed sequentially was not
> letting the watchdog get reset by the normal kernel routine.
> The serial port was so slow it was pretty easy to hit this problem
> and it would just power cycle itself.
>
> The original intent would have bee:
>
> #define v2printk(a...) do {             \
>         if (verbose > 1) {              \
>                 printk(KERN_INFO a);    \
>                 touch_nmi_watchdog();   \
>         }                               \
> } while (0)

Ok, thanks for sharing how the code was intended to work. I'll let
you all come up with a decision on what should be done about it
now, I'm happy to send one or two patches to address both the
compiler warning, and the original mistake.

My feeling is it would be best to address the warning first,
pretty much with the patch I sent here, and to change the
behavior as a second patch.

That way the gcc-11 warning can be silenced in stable kernels by
backporting the first patch, while the second patch can be tried
out in new kernels first and might not get backported because the
existing behavior is not harmful.

> I'd guess this probably not the first time gcc-11 is finding brace
> imbalances.

There were only a handful of new -Wmisleading-indentation warnings
for gcc-11, the older compilers already caught every instance in normal
functions, while gcc-11 improved on finding them in macros as well.

       Arnd
