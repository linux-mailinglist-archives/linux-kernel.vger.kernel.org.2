Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05940FF9A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhIQSuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhIQSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:50:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A62C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:48:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h17so33532942edj.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cpak71tpwGIH8sDgLDrdJbMzVDQHoqt6rJZasCMwdzc=;
        b=PPZqYKySWRBXLCmQqLignaVRzeemkJWbOSVm4Nk3LB3/dwYqxZT99gFitFC859Cqmo
         5dHLqIWjBbL09xTf3eNTCSAzEfwW62QnHoObFrYVOWn0PPzzY6lksRvKhahbrO9bPfvT
         /jfwN2l8iu/pKIRl254LqCHUDuwZMUECiAh00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cpak71tpwGIH8sDgLDrdJbMzVDQHoqt6rJZasCMwdzc=;
        b=mYL3x0p0zvq6gRP5b0SCea+5b2Yz1JD4k9g2iYh6ZiDxy7g0APEI2ADcPMf5nvEDVx
         nsXmhirs0bdJu19D3hvG/oWISg8UPhcCrvjA721yc52S8kzdGUGajFe2XU2ySF2ROz+o
         RZVy+lKmprl9up93XpK8ZOrGrIhpbP55O7U9cylG4w7T3u8WF45RqWPisWDwRdixGLc7
         wSAUcdapPC0cLYv6dKCOBYQfAYb85B0Mn46DzEhDh+MtCkJ0LCtTva7U26WR5x8uLPof
         jypre9rRNKUTsf04Fs4xAgYD3dSlD/yhk3Gqqp+XzVyPG2iaUnKf1QlD5YGnbrPmG/nz
         KRbQ==
X-Gm-Message-State: AOAM531I8gj0TL22po1xcwUvHHPslElmrMg6fBq76W8ZcmVlZ9Z7M3Lz
        FeucaPsmVs5qAHj2x9pKnZ1/UoqoKQjojQkG/Q4=
X-Google-Smtp-Source: ABdhPJxE+1zxO/YJglL939bQyHQb+motttSfKITSckSUBR+/CYzDfVvAukAn5jPT7yzgLDU6CSlpXg==
X-Received: by 2002:a17:906:4dd5:: with SMTP id f21mr13726456ejw.106.1631904528020;
        Fri, 17 Sep 2021 11:48:48 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id g9sm2670865ejo.60.2021.09.17.11.48.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 11:48:47 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id t8so9685570wri.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:48:47 -0700 (PDT)
X-Received: by 2002:a19:ae15:: with SMTP id f21mr9099719lfc.402.1631904049054;
 Fri, 17 Sep 2021 11:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-6-brendanhiggins@google.com> <202109170856.8DDB49112D@keescook>
In-Reply-To: <202109170856.8DDB49112D@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 11:40:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whck4RtO7yp-jKK8QQc0bCDZBkdHc=3pGiFsFjwnQ+-mw@mail.gmail.com>
Message-ID: <CAHk-=whck4RtO7yp-jKK8QQc0bCDZBkdHc=3pGiFsFjwnQ+-mw@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] mmc: sdhci-of-aspeed: build kunit tests without
 structleak plugin
To:     Kees Cook <keescook@chromium.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rafael Wysocki <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> This isn't a stand-alone test object, so I'm less excited about
> disabling STRUCTLEAK here.

Yeah, please don't do this for things that aren't pure tests. You're
now disabling security measures (even if I hate the gcc plugins and
hope they will go away).

             Linus
