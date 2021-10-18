Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5BB432790
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJRTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhJRTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:30:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE4AC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:28:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so810727pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T17Zx5b+9cZpZ2b2XmW+zfPtibEmmpshlWxKBV4MDzM=;
        b=TZ1/KPtQoYkVktZdrLnmAUt3Xt+Yl/n4oACnfVoXP8srs1kET1CPyXfdDW9mxolIso
         ytcf1512ADi86r/4854+CiERO/U8Vb+dKemq7SPbiZ0E0Xw4C9k6IPrMdQAX484+P1Fz
         hIphG9vwoMayv9/tVBkymSEIb9v0eJTtV5j/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T17Zx5b+9cZpZ2b2XmW+zfPtibEmmpshlWxKBV4MDzM=;
        b=fyc2C9fQMCWHmDxg5DQrCDzqVF8xKisRdUa9aDFH/El4l7XupCjE+0amawBD5kFymi
         vHDyTZuBVe17V3DglTp1hDFujETH5r865wrNu9+6q9h/AlWsVvqRpqjAc+nqt0mTzOJM
         jz/x8ATsaUdwXJLL969mC4jczHFSiLE3gdAEntuKGFmSI1ugza1bKpLuOhLLo9otIzIo
         j9HdKLQ5Xmq3WskldxUVNrZ8rdtyJVl7UvAh8KSodc1sUFO9B529BkDX8vLR97gz8wJM
         JJlIXqoDusM/S8l+87Hv49zqhxhk9d1bfVgb9uHEKlUXFnHpbwU6pGHJEgnuO0GPZ43D
         Kvlg==
X-Gm-Message-State: AOAM530FJlOZ4ZskqwpyjnBvF0xI1tQgBo8om+RqamuKF+HIOu90dfSI
        tVB4Rb97X0Pn3AQEJQzXVVnfYMstfLqDsQ==
X-Google-Smtp-Source: ABdhPJyQWXpyp8PGkVchG0m3Q5r5UvHI3hWDDD7MwqFIbT/BbmPwUxhIsbhwMH+mFw+4XJqrBdvkrw==
X-Received: by 2002:a17:903:1112:b0:13d:ce49:e275 with SMTP id n18-20020a170903111200b0013dce49e275mr29826166plh.5.1634585293673;
        Mon, 18 Oct 2021 12:28:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ng5sm211359pjb.51.2021.10.18.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:28:13 -0700 (PDT)
Date:   Mon, 18 Oct 2021 12:28:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, Linux-MM <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH for-next 21/25] lib: Introduce CONFIG_TEST_MEMCPY
Message-ID: <202110181227.534491C34@keescook>
References: <20210822075122.864511-1-keescook@chromium.org>
 <20210822075122.864511-22-keescook@chromium.org>
 <CAK8P3a1o58qeUsn9_+o1v1POZ9=3p17TCEba4-TRQ7Hf5mRg1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1o58qeUsn9_+o1v1POZ9=3p17TCEba4-TRQ7Hf5mRg1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 05:46:09PM +0200, Arnd Bergmann wrote:
> On Sun, Aug 22, 2021 at 9:56 AM Kees Cook <keescook@chromium.org> wrote:
> > +FORTIFY_SOURCE
> > +M:     Kees Cook <keescook@chomium.org>
> > +L:     linux-hardening@vger.kernel.org
> > +S:     Supported
> 
> I had added you to Cc on a patch because of this entry, and the email
> bounced. It looks like you need an extra 'r' in the address.

*facepalm*

Thank you, fixing...

-- 
Kees Cook
