Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D420A41B181
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbhI1OD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbhI1OD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:03:57 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A469C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:02:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f133so31953430yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rqQtIk/6RZp+oHtGBLpGghq9zf27UXMh7gjDqhWItOo=;
        b=HqVIPg4A0tsJolcMNt2D5+uuLjf75KaCHkCr07E3YcgufntBlKo1+07kC0z/0YS/F4
         hah88xjBDePVCPFuTVClSxTuhPhVOVJdfG9Ox9nFi/g30cuFRDugQs4+5quByhOu8mow
         UJrJ+tq9Z53bY/YF0KE07hIAZEreZT4B8DeMV+47OkiBGIGgKWFGsGVYLwL8W/ApAyF3
         HshGlV6RW50oaacQwrEBusuHbWpgqXPC1MpRznn/lGkNGBaHqK2kYc0LAaZWEJ8QsQm5
         Y8TmtHB0wGWb6pOb6dpClyudlcfy45MAHy1UyIAIqHPT7xFEUv/NEEklgSv56AWrzMdy
         PUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rqQtIk/6RZp+oHtGBLpGghq9zf27UXMh7gjDqhWItOo=;
        b=byA/HpVJR1/nGtNPw7YysAHrzVhK+7NwnC6+8o0ni5UcHUWovSWAreHFtRTLFXlBCy
         AfqR8hmie/8HjxxZDdQXw+5SbAZ1u1wwU/aO+F5yQKpoIB/UsuZHY6v0rKIQWYlG3AuI
         vByE2f0c6SM7QZuNCjjedFokgbj7dn52T/5Zza3Fp6dNM2+rDHAeNE/hugVPN7LeFvd4
         SywOCBTP2LHlgwXeYsjbKmjUXapdGmUY7bDuCGDEKqCvBDK9A2T+Px5Za8h8WKDBSEqD
         t3NnIju65iXwI8lZhMgWqxbA/t5IjsaUZgAJej74KuPrE81HvZ9xpK2ts2al0ZTJWnNu
         bnXQ==
X-Gm-Message-State: AOAM532yXBVNtHZCzTXS/fTMBVS9K+sNnFlI7tHV40zI1onENLfgMNr7
        tPWBlRcnchWgq2E5T4GCYiGog700kDy0ua6BrhyJUA==
X-Google-Smtp-Source: ABdhPJxcWNapNwbSMYpNuoLOZ/mFxsLh85WxLn5ZgLcnaaDmX2gfm0tqgls9grUv0gtjs4QFMD1DwqEBvGlihgmmXlo=
X-Received: by 2002:a25:188b:: with SMTP id 133mr6630188yby.80.1632837737044;
 Tue, 28 Sep 2021 07:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210927121811.940899-1-arnd@kernel.org>
In-Reply-To: <20210927121811.940899-1-arnd@kernel.org>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 28 Sep 2021 17:02:06 +0300
Message-ID: <CAOtvUMfNYkfKw-Vji7uVWXO=CbwGLj6=+awCKif5=cPCK1P-cQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree - avoid out-of-range warnings from clang
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you Arnd.

On Mon, Sep 27, 2021 at 3:18 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang points out inconsistencies in the FIELD_PREP() invocation in
> this driver that result from the 'mask' being a 32-bit value:
>
> drivers/crypto/ccree/cc_driver.c:117:18: error: result of comparison of c=
onstant 18446744073709551615 with expression of type 'u32' (aka 'unsigned i=
nt') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         cache_params |=3D FIELD_PREP(mask, val);
>                         ^~~~~~~~~~~~~~~~~~~~~
> include/linux/bitfield.h:94:3: note: expanded from macro 'FIELD_PREP'
>                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/bitfield.h:52:28: note: expanded from macro '__BF_FIELD_CHE=
CK'
>                 BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,         \
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This does not happen in other places that just pass a constant here.
>
> Work around the warnings by widening the type of the temporary variable.
>
> Fixes: 05c2a705917b ("crypto: ccree - rework cache parameters handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Gilad ben-Yossef <gilad@benyossef.com>

Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
