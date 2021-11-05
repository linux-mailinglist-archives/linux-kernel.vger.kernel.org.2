Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA6446A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhKEUxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhKEUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:53:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12141C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:51:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s24so16910103lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsqXxMPAEyayuWYNn2cn31F1D2jcff0K1QvBSthWMBM=;
        b=qOxV+6+MFUFLS2PS7gWTFOb+5OBR+cqySkvjy3obIuGHjHYU2+OPa1v0oH5ar3Momb
         1SfH9k7CtbWT3EoxFjVodUnvjUC7Sbd62Yd+tv89a35AM2Q477zcUc+DozAS/Lv/mS1y
         lPjneQGIlCtLwO6x6p+kHAIBo8KsK7JvzjcYBekIJDr5SvANWAhocb6d403cSVlvN9QE
         q691o0BWYl49mrnOtyAlBN8sa2c4x1HZTJezZCORUEHVarGNWj+9TGwDAqPQlnBVwyA9
         YMAgDh4A6AkxZeDLvFZC4h+oDYaqFL2h+lf/eYcRrNHxUzwl7RsJ5sTteaxm4LXmEV+V
         PFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsqXxMPAEyayuWYNn2cn31F1D2jcff0K1QvBSthWMBM=;
        b=KH9kQL+e4sYGO8VVfSfzsj9v1o+Qz8uwUjlOvltIkq5OGeahJlLxaC7FeUaSGDUL7O
         4A7PpRNE4mvA99pdmNkZkQM0u4tsNA3s5aPNC5Icf2Y5tT5Qoxw7pAof6T7qJb4yKcxh
         tHbGUQHFEE0Em33x33Pq4noteh1EA03ciqhAbWhbQZJBl3VlY8N2MXBsyoh+P6JeaG1K
         ZaSkHzKvuMI58AqJFRbAcXskxc9bq/KkAWDT8cGSS/SIGqdsYIxJsIU0edhpRDsDAWyE
         1avOTQWNxC9pzqWIDpL6fXRPbcdbKoxMlTiSsYEIHYccKXkN7jofRvQ4ou8WmVfBxuaS
         U1zw==
X-Gm-Message-State: AOAM532IquaAKF4yYnzXNRg7o8EDQpiTwLJdLFdTIEpZQepmbcEK/MFW
        h8k5WSFtHqK4q81/BjcN8K1WmlEtA6Svc1y7Vxgs3g==
X-Google-Smtp-Source: ABdhPJyscGR2faQ3WY30fi9rHtfREOCPhjZDAaOuuO8TE7pOhp1KBS3rpUKQlf4rPXLm+5TIIpFu3wdMSSP1pETACTo=
X-Received: by 2002:a2e:750e:: with SMTP id q14mr64510854ljc.338.1636145469249;
 Fri, 05 Nov 2021 13:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211105163137.3324344-1-anders.roxell@linaro.org>
 <20211105163137.3324344-2-anders.roxell@linaro.org> <CAKwvOd=rRntVgYdqEeb=JAYo2iC-wVB3dkQWNvwdZdrYgt2s7Q@mail.gmail.com>
 <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
In-Reply-To: <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:50:58 -0700
Message-ID: <CAKwvOdm=a7w0cQdynY2i5ST=xrfjzXVZcUniAoEyqC21oKPQsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: timens: exec: use 'labs()' over 'abs()'
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 1:45 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Nov 5, 2021 at 9:35 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Nov 5, 2021 at 9:31 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > When building selftests/timens with clang, the compiler warn about the
> > > function abs() see below:
> > >
> > > exec.c:33:8: error: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
> > >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> > >                             ^
> > > exec.c:33:8: note: use function 'labs' instead
> > >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> > >                             ^~~
> > >                             labs
> >
> > Careful.
> >
> > Isn't the tv_sec member of `struct timespec` a `time_t` which is 32b
> > on 32b hosts and 64b on 64b hosts? If I'm recalling that correctly,
> > then this patch results in a harmless (though unnecessary) sign
> > extension for 32b targets. That should be fine, but someone like Arnd
> > should triple check if my concern is valid or not.
>
> It could actually be 'int', 'long' or 'long long' depending on the architecture
> and C library. Maybe we need a temporary variable of type 'long long'
> to hold the difference, and pass that to llabs()?

Yeah, that SGTM. Thanks for the review!
-- 
Thanks,
~Nick Desaulniers
