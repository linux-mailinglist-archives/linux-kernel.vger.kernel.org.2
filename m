Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9BB320E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 00:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBUXIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 18:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhBUXIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 18:08:17 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 15:07:36 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id y7so50784507lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 15:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9CZc6j54KVkhNtnlVAPjyH9O60vJPCOdPJohXtM448=;
        b=VJE0KaWIqLNIiVJZbdHs7iPeShk8LirvoiZO0J4hrm9nUuO13brxoUpPUVYVGEp5Yc
         z2DLPU/lGPdy0+JV8Sh+xoVbZsY236mVW2P/emeJPhXbdj98+0x08/R9XeqZDRD29nEK
         NN/0xcVdF7ZYkPc7TtkjCNnUSVwu7OYjs1Cio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9CZc6j54KVkhNtnlVAPjyH9O60vJPCOdPJohXtM448=;
        b=ifNaSEgbnmeRbENUE/HE0Q2omDH98E1aPmZf3NkG6Bw1qIhBFqtcYTwIvh04EVN94I
         wCb9vJoWT4YQCmm/NeHEdvAZCeD0mEAKNqlVyGvwnwJ5wURWqLUqp9/EM3Evn3TfN1DP
         SB2tlSkyWuN0UaWyQ9kiu3ZA3dE3H9RNGJadlgh8oDSMv0OFbS6a0UIbELfigYq23aIm
         zbc1WUJJR22BM4S5WDMk6mLQ4qPeibYAowHD58Ycw4XvZn1eF3S7270YD95pEOF8hPXO
         t2D1CTLlkzmtqVnPrkSS2cNcZVohovyt/x4jI4W6Ji6GQxVf5943IeFtNt0ahBeDNyFv
         r8Lg==
X-Gm-Message-State: AOAM533az3/HCVMyoDSo68eMShO5gmyL3TfKDHm/ofBH6RVqcSR+Ow7q
        me7vqEMlpFtSTMjfJPngG7zhYg8wylgcCA==
X-Google-Smtp-Source: ABdhPJwizjQ9tETQ68XIXrNjwA9kKU2BP5ew56MR4wse1Dl+JQmcryQxtZhcS+s1lVMdCTwZiqGgCA==
X-Received: by 2002:a05:6512:228b:: with SMTP id f11mr12509687lfu.78.1613948854665;
        Sun, 21 Feb 2021 15:07:34 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id k5sm143541ljb.79.2021.02.21.15.07.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 15:07:34 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id o16so48252963ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 15:07:33 -0800 (PST)
X-Received: by 2002:a05:651c:112:: with SMTP id a18mr12843554ljb.465.1613948853595;
 Sun, 21 Feb 2021 15:07:33 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txd-x1NKWK9BBqVTDNOR00zNqcXgs76YJrDfL94eMLYqQ@mail.gmail.com>
In-Reply-To: <CAPM=9txd-x1NKWK9BBqVTDNOR00zNqcXgs76YJrDfL94eMLYqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Feb 2021 15:07:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgiPxXzRNnfaXk7ozSWSu7fFU--kTmVjkDaTB05wwUk_g@mail.gmail.com>
Message-ID: <CAHk-=wgiPxXzRNnfaXk7ozSWSu7fFU--kTmVjkDaTB05wwUk_g@mail.gmail.com>
Subject: Re: [git pull] drm for 5.12-rc1
To:     Dave Airlie <airlied@gmail.com>, Kevin Wang <kevin1.wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:06 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Let me know if there are any issues,

gcc was happy, and I obviously already pushed out my merge, but then
when I did my clang build afterwards, it reports:

  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:764:2: warning:
variable 'structure_size' is used uninitialized whenever switch
default is taken [-Wsometimes-uninitialized]
          default:
          ^~~~~~~
  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:770:23: note:
uninitialized use occurs here
          memset(header, 0xFF, structure_size);
                               ^~~~~~~~~~~~~~

and clang is very very right. That "default" case is completely
broken, and will generate a randomly sized memset. Not good.

Presumably that default case never happens, but if so it shouldn't exist.

Perhaps better yet, make the "default" case just do a "return" instead
of a break. Breaking out of the switch statement to code that cannot
possibly work is all kinds of mindless.

Kevin/Alex? This was introduced by commit de4b7cd8cb87
("drm/amd/pm/swsmu: unify the init soft gpu metrics function")

              Linus
