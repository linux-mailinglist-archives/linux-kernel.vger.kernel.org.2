Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495D1435D16
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJUInt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhJUIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:43:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107ADC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:41:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id o133so5269260pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2szSRJSYc8e5G8aReqvAdlYT615SY5Xyth2O0S9i5EA=;
        b=R/JFIIO71DC4B8FZT8SFlh35ESr/rDqgqIK6hU47HaqbrWmM/nlRmVrw1TliFJaQGp
         yiLgscqGcddHyPxF2hDyQyG0PnwyOc/NOGVUOzkeiiki0GFxNvps5YgUTC7bFxHAmz9o
         RENSzgGLKiClC4kSVQcVmr146m4MfifdzsQ+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2szSRJSYc8e5G8aReqvAdlYT615SY5Xyth2O0S9i5EA=;
        b=VQm/90cGSWcNESlkVQcniL0EAi+uJ1At7uF26Pg5xA6eK2ow4mzb/bs1ZpLx+w7GxL
         8fNNIVlL1RwPOXsbDmtj9h2Ko40NyxLvKjjGCcwlb5deFngxvR8hfjAdbfWvBgtWjG4x
         PR69RA9wEO8Tf1QrB5CmGBz9BQpd0GglIj/TQTaF1JsaX7lbds0VaMWJAFLoZIgJ51gK
         KKA6ijQSSlwWB3P+YkgwvsRJwBaG4IZ7OrUX+ZR5Hpz3Vq5qsJtnzOwSplNBGlqPUU4p
         KVtDtcTbfspe3wjdmogvLJbukiZ99af0fkhvmisT/BChL1lSfPfk4brvwvFziKHNZDh+
         LSwQ==
X-Gm-Message-State: AOAM530x8JSGK1JWOreIqeedAlOjyR2uSGBdoOKl1u2JYt+HwshWVtIl
        91wcP1EKxvWbO4N6aC5d++PkiA==
X-Google-Smtp-Source: ABdhPJzZ0IduZ0HmTOr2ADCd2Oyhef9o1xjVVfDk02WNxKb9rfMRhGXQNRmXtjIPZWN7AdZYyRQUMA==
X-Received: by 2002:a63:d60a:: with SMTP id q10mr3402711pgg.335.1634805692575;
        Thu, 21 Oct 2021 01:41:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h13sm4441922pgf.14.2021.10.21.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 01:41:32 -0700 (PDT)
Date:   Thu, 21 Oct 2021 01:41:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler-gcc.h: Define __SANITIZE_ADDRESS__ under
 hwaddress sanitizer
Message-ID: <202110210140.D42185CAC@keescook>
References: <20211020200039.170424-1-keescook@chromium.org>
 <CANiq72ncBda6WE6ZTF9WDssHkMmM+JC5q8vkdNwiXFXTsSrnwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72ncBda6WE6ZTF9WDssHkMmM+JC5q8vkdNwiXFXTsSrnwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 12:45:02AM +0200, Miguel Ojeda wrote:
> On Wed, Oct 20, 2021 at 10:00 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > I'm intending to take this via my overflow series, since that is what introduces
> > the compile-test regression tests (which found this legitimate bug). :)
> 
> Not sure if there is a particular reason I was in the `To` field
> (please let me know if so), but the patch sounds good to me!

Well, I didn't want the "To" to be me, and IIRC, you had sent a review
for Arnd's prior version.


> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

-- 
Kees Cook
