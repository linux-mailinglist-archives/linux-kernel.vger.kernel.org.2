Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B43D435B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJUG5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhJUG5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:57:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7807C6135E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634799326;
        bh=34zpGNXpzvVCbYQ1aEikfdAFYF+0jvNvk3BDxBNPokA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MKcYeLNVHGX+I4hOjUzVVl14PYQdcj2GJFS8XP/x38TFmXNDlELcZMKCa1la7vU1U
         Stn5BVdLdlyJTbToHTwAe64JYeMYqZLvvJTHbQxKJZhwpADyn9HL3FJMyAf56Ce5jd
         1UOjtPMhwvP4xbkKW6hQ2yDesR0oKGLGIi+aVgTjImq3nS5zTNngKtAmWX3Qi1bTEz
         kNuZLEGYsqVUW7Cn7w8d/FDbZDZBEw5pjqgLythp+2Zh1WCsDMvMCKrDMT3LU4g6yj
         VdF2O0pKQdP7wCEmpQdCGXwix1mcFKQhDoQArmrzOfb9Q6pdzbmWXIiydGJ5B1I8t1
         7IQH881FezObw==
Received: by mail-wm1-f44.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so13288172wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:55:26 -0700 (PDT)
X-Gm-Message-State: AOAM5317R5bCDyjGiIiKaDBo3jdZska8e+VGsqBPmhtqMTQ3I659VvGq
        T/Lb8TzeVQvOh5FgonwFB9xA6YpbxPqJSBgqnJg=
X-Google-Smtp-Source: ABdhPJzn1dt269iT+Q+EyDaq5VPrY1mkBxgu8/HoFco/P3uBmivFdK4zhEqqqTrwjewpHuzyiVau24mWLDh7p4XjsZ8=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr4590078wmg.35.1634799325010;
 Wed, 20 Oct 2021 23:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <202110051030.J3Ub7djT-lkp@intel.com>
In-Reply-To: <202110051030.J3Ub7djT-lkp@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Oct 2021 08:55:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3uOV=AMmOTP09rBhyq2zJutDJiof-4uQ-7MbX9xyVivg@mail.gmail.com>
Message-ID: <CAK8P3a3uOV=AMmOTP09rBhyq2zJutDJiof-4uQ-7MbX9xyVivg@mail.gmail.com>
Subject: Re: [ardb:arm-vmap-stacks 5/20] arch/arm/mm/context.c:112:28: error:
 no member named 'task' in 'struct thread_info'
To:     kernel test robot <lkp@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 4:03 AM kernel test robot <lkp@intel.com> wrote:
>

> All errors (new ones prefixed by >>):
>
> >> arch/arm/mm/context.c:112:28: error: no member named 'task' in 'struct thread_info'
>            pid = task_pid_nr(thread->task) << ASID_BITS;
>                              ~~~~~~  ^
>    1 error generated.

I ran into this as well on my randconfig builds, though it happens very rarely.

Apparently CONFIG_THREAD_INFO_IN_TASK is incompatible with
CONFIG_PID_IN_CONTEXTIDR, but should be easy to fix by changing that
one line to do the right thing.

       Arnd
