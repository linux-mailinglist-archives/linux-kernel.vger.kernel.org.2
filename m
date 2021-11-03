Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98AC44486A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhKCSmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhKCSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:41:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C33C061205
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 11:39:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u17so3073061plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=byUxDp0FjH5oeRGoIzsWXKBjPUklMU9RIPovjmYXZfI=;
        b=bghTP/GJeWCvlhJ9RZ+xsiRC/4v/kwgePBgZv9T1YyDd1xY9pT8UF7KWZzN52NXSpT
         BQzdsefdFXH2t2RElQ/RZ1pay55BiGyQEXXD75dPQu1j13Zt9cpE6huxRwR4DxdeKwyA
         BrV8jCUOT6n4wvzNeZUvP7H57Di52ZpsFtT2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=byUxDp0FjH5oeRGoIzsWXKBjPUklMU9RIPovjmYXZfI=;
        b=2mmiQQY2m9YgXYEH5F7bzGrHZXySrX6oW5ZMWIovmuCgg0mv+Pzkwcjm0ng1DQ54Ad
         Ve9DB/NONS+64GzIcuxLWz6flk50ceByh+FRXTxIFDbt8kiaG6j+M67ZREqTqvyHu6Wy
         DH09SIPIeIWmivKz6y72au0MlWYpZsZ6M94DIrJCUtv4sweLTARZfCgOvN+uFijhIrST
         Lvtx9EvJGTVnPNO0XaS/kk+BUsDVywNjxmrzRw0ZlmrZsq3niy5nVuWK95JL/s7Uk14Z
         qKv0ihRSwwvAJv8sTsJo6+yJzoaxZfmrmEiKvZNxP4mBRFytC4PvrLIt18mSZ4XH0XcT
         69Eg==
X-Gm-Message-State: AOAM533ScjxoUJ5CPSsH+H6yUrZ2JDkSUKP0gqIyyv0Q3A+8/rAebILZ
        2N4NQpnpoX7fcfp0oFkZ7CgahA==
X-Google-Smtp-Source: ABdhPJxWFeAeFv4uvQrESsH3B0i9f/HeJH/tjBGi/NQlmXQmAcJnShbjzCc6yMtEul2bUEW0cghMJA==
X-Received: by 2002:a17:902:f2c2:b0:141:9ce8:930f with SMTP id h2-20020a170902f2c200b001419ce8930fmr37185850plc.68.1635964752364;
        Wed, 03 Nov 2021 11:39:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6sm1517090pjd.40.2021.11.03.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:39:12 -0700 (PDT)
Date:   Wed, 3 Nov 2021 11:39:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RESEND PATCH v2] string: uninline memcpy_and_pad
Message-ID: <202111031135.B2559A1B@keescook>
References: <20211102142518.3723655-1-linux@roeck-us.net>
 <202111031011.D0F16D78@keescook>
 <bc18aef2-17ee-dcbc-916c-952794adc658@roeck-us.net>
 <CAHk-=wiUtTkstJiEwsedWLaq3WdjfW8=0JD6v0qLAFSfzfWBaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUtTkstJiEwsedWLaq3WdjfW8=0JD6v0qLAFSfzfWBaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:34:05AM -0700, Linus Torvalds wrote:
> Kees - once you have gotten all compilers fixed and everybody using
> them, you can send a patch to make it inline again.

Fair enough. I've got a pile of changes underway that do touch a bunch
of these things, so yeah, we'll have pretty wide coverage soon enough.

> I estimate that is in about ten years or so.

Heh. Well, luckily, both GCC and Clang have been pretty responsive about
getting legitimate bugs[1] fixed, so I'm gonna aim for "less than 10
years". ;)

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101419

-- 
Kees Cook
