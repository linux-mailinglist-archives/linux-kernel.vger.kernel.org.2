Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D83E5A67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbhHJMwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbhHJMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:52:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3356BC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:51:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x8so41310006lfe.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COWCMGHIbMOml8oSzWr/dWDbmo5VnvHeIUlohNVVgbA=;
        b=GgpnMPCih9w2+JFm1yn7J9s/amiSzIA7+c25pxNxAUCaicDRMluo90cki8m5iLTPF8
         yXwaUEfjsTM0D/fjrDnVWnC2ir6tPXRZvytSsBO/XHB+qkcDHSA2ycrx8xmR8Icc/rcm
         e12+e9A+5QBvwKORXO9ffMvGL5FcC+EMczIaQMSURwlK+W8aS7wH3QxMmDbSXkjoZV03
         3xMCYgOJlCSut6+x/Rqe3BBrGbbhvoqPRBnLsmjVT0FLjts1PkJWQ07jt5aBhg11M3vF
         g6dFW1cCKjIdTtGrm2Qpd5CbcKDgwgg6rNHcqMiv6XDqW4pRo/+k1hksDEpesz/FUWY5
         ijJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COWCMGHIbMOml8oSzWr/dWDbmo5VnvHeIUlohNVVgbA=;
        b=lu6NmSoeLKhBW5DIC0FKnItlLDyNCoKkisUbIe22SNTGT2Df/NSBI5gy3IaRifi8e+
         0XHTL430w/bskj3cCr4+VhhoHq//HhhWBkJAnyw3Bt02mRWQcb8r4OVfKsIC/ruZoy8y
         f4BZeUc3MpUOpLpBktswZb6CR3I272fE9lKhL2oa/Hi6B9llku6+dE/UzdVgo/5xlTiq
         a4yymMqsSHV77/7YvYEQcofRLxxV88BnadQBsOFNrPQAlNupKTQZub6Z/inG+dxWd6lg
         xg/jL71XN4WRULWyhejL2RkkoQrhWMjpWvqhQzpLjH4aM6+pSaNE8zKXWUQx+/EYKHze
         eS3A==
X-Gm-Message-State: AOAM530Ufj49P+LEXIquflyo6tb4Ar85ODkw2sGDCtacXPKLMazHpowz
        9KOCVlf68OeeKyCNaWUV09TTVchuLYiynwCxx7VhLw==
X-Google-Smtp-Source: ABdhPJx9IsgfsTOT8THkhkunUTedenh0kP5K6wZ864dEuCRjcGxI/3CsvwqdSFqCuqShDKeibW0Taqk3bG/qjmKS84A=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr21304513lff.465.1628599897540;
 Tue, 10 Aug 2021 05:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210722044155.864600-1-javierm@redhat.com>
In-Reply-To: <20210722044155.864600-1-javierm@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Aug 2021 14:51:26 +0200
Message-ID: <CACRpkdY9UNYEs3w3JHLR78OmPSA+wkLb=FDP5kXdWTZpxnRU1g@mail.gmail.com>
Subject: Re: [PATCH] drivers/firmware: fix sysfb depends to prevent build failures
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        He Ying <heying24@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 6:42 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:

> The Generic System Framebuffers support is built when the COMPILE_TEST
> option is enabled. But this wrongly assumes that all the architectures
> declare a struct screen_info.
>
> This is true for most architectures, but at least the following do not:
> arc, m68k, microblaze, openrisc, parisc and s390.
>
> By attempting to make this compile testeable on all architectures, it
> leads to linking errors as reported by the kernel test robot for parisc:
>
>   All errors (new ones prefixed by >>):
>
>      hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>      (.init.text+0x24): undefined reference to `screen_info'
>   >> hppa-linux-ld: (.init.text+0x28): undefined reference to `screen_info'
>
> To prevent these errors only allow sysfb to be built on systems that are
> going to need it, which are x86 BIOS and EFI.
>
> The EFI Kconfig symbol is used instead of (ARM || ARM64 || RISC) because
> some of these architectures only declare a struct screen_info if EFI is
> enabled. And also, because the sysfb code is only used for EFI on these
> architectures. For !EFI the "simple-framebuffer" device is registered by
> OF when parsing the Device Tree Blob (if a DT node for this is defined).
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I don't know who picks up firmware patches though, I would send them
to soc@kernel.org if nothing else works.

Yours,
Linus Walleij
