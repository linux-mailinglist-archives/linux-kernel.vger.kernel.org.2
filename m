Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5398C3F7D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHYVST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhHYVSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:18:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A661C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:17:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so1805532lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAlJBNQn16JjUkHYdCuHXibhY5cJqMeU9e15H1wH+kQ=;
        b=Twvb5JwGXq7g8xGxqMloGmKOTKjL4Cpr7Hrkzmdj1rM9cAtIDoJQlHk/FubuEVlXUS
         3YA89nJqolCmBl0X+218EiNXgod3K2tHKBNueNTJp2dhWHaoQEjCYliDGM3Jp+P8jrp1
         U6incOxlb5XMQ5WLp+xztlf+F7edMQ0aSrHv9TPi+Ll75CedhDDQBSBjY3vID9LJG8lU
         IceClHUlaGxSZPYAuCqKx7xqyW9uslzP4Lp0rDx9Yl7618mw5Og/JVlsPgflydKIzjRW
         nTv08AP6n7WDSJXmhx0111VHP64plhof0Gy4X0XfGmjg63JF8AVQ1FVrFBTQ5ppldxFD
         DVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAlJBNQn16JjUkHYdCuHXibhY5cJqMeU9e15H1wH+kQ=;
        b=eLFWnZaMKuVCkF5QZMNMqybZUN9348nwHoKGOZddr/0Z9BrsoYPmLgqqaBxPhgy3T7
         OxxZcymhcnjorxSbXP+xGIUrHtE3NkgYuzRP+lmpZah753cLZYrZ9TrdsPwK+1BcwlIb
         yUcr/uPh5sHDBmt4bbKfZVlDO3XUHGogWQXJn9wRY22zIFwH2rcPtJdEB8JDqFtzKzoW
         9QWYLGEPhEVNYQt+S2edAyYI5aSMSVQcNfEZryFdj4G01/P4JvUg0SsjF4V6tGalwn40
         ec33/cwY9Uz1VvHOFrgcWiY+kd4amwNDxZtfGKaq+GbXgxRqp5wx/7wwaWv9wvr5BIQp
         6vbg==
X-Gm-Message-State: AOAM531ZOIWI7kbxHP5TLSFzoLoTj4JTcS1oLXUpGaT/AQ3rxYJfPWgb
        CtiuHs0wa3Ocv032Cil93CV8mZJbJ1jLDX/yRTcgeA==
X-Google-Smtp-Source: ABdhPJwfpYIvlODDHiRHyf2+aTCddGrNRBCe0ubiEEwEmq1swxye6qx60WEAreo9vIgjPwwCEf++BetmgbXXELUhpN8=
X-Received: by 2002:a19:5f04:: with SMTP id t4mr88603lfb.297.1629926250176;
 Wed, 25 Aug 2021 14:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210818081118.1667663-1-keescook@chromium.org> <20210818081118.1667663-6-keescook@chromium.org>
In-Reply-To: <20210818081118.1667663-6-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 14:17:18 -0700
Message-ID: <CAKwvOd=bcs5W6eEDXGn5ROR2EuMiSp_2e6sLFxak=KK6yLWcvA@mail.gmail.com>
Subject: Re: [PATCH 5/5] Makefile: Enable -Wzero-length-bounds
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 1:11 AM Kees Cook <keescook@chromium.org> wrote:
>
> With all known internal zero-length accesses fixed, it is possible to
> enable -Wzero-length-bounds globally. Since this is included by default
> in -Warray-bounds, we just need to stop disabling it.
>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index af22b83cede7..3b6fb740584e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1071,7 +1071,6 @@ KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
>
>  # We'll want to enable this eventually, but it's not going away for 5.7 at least
> -KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
>  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
>
>  # Another good warning that we'll want to enable eventually
> --

-- 
Thanks,
~Nick Desaulniers
