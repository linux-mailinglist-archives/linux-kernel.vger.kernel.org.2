Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DFA456ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 08:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhKSHOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 02:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhKSHOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:14:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC10C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 23:11:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gt5so7257435pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 23:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=p1eOarTU7vFn4QPFb7iBA1/Wh2WEiqkaaZtB0EXNIbg=;
        b=n0557Xpy2MZDEwOCBv48cUPpw/kWOtrMnxUBlIoJFQ8vAvvkFzUUadY805EUsLA/Gu
         Dl2lz3irhjVgZhaiTM12sAR/I84EFzzV3hJYWKZ65YuRk4zVt01fTdgTahAPBT4x53RO
         Ql+GWy/Guc2s5eFVNl37oIxV6lWiikDmcVNj8hqWiqRTX7CraAalS+xINAE/N2Lqjwn9
         VejiIdeCb4X3vVwWJ7RW1jyoUjYHKKW/YN+WF/n+/7AbqD7xyFexwuS+OfskzCDTHoYG
         7kUxs8obqM5s50Y4g8Hjuy1cHdA8GnGcDNe0D+KKZQwFoDRp5c1FQa+sDmqwJknlovIO
         S8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=p1eOarTU7vFn4QPFb7iBA1/Wh2WEiqkaaZtB0EXNIbg=;
        b=GgfxUAAbx7fS3huuD5aIox4FYm/5Js5dtNoc6PkuBJjCiRkshn+iuKFOGCKeeTi2oD
         TE0ftN23g5V1q3DN6rYme6A0Thm30x/HAXLFxz92SpUvHWQYyrcVhwfR2neUDzpkhmzL
         KKt9RPyy8LrrVBWPlLR15vCeOQ6MCMRaCEEoc5vP0e/knbmdgU4wg32obUYsDHuX8dob
         jzmrULacdN6hxGBUEKSGf0TPAj16wkPzY0MnPE+h8NLD7nYBGbBCafZi8Wsy7GNoFmTg
         mJFnN8ckNllPguvdg9N9HInffCXxlgnFVTQ2nEz8CjnG2Qogx7Ka1oVEci1Jy4OdQLCz
         Fl5w==
X-Gm-Message-State: AOAM533LrzKnVpg6M14PR2T76dLv2SKfHga3w+xKfTP05o9TZDrz5eo6
        FZVXto9vEkDegQ4WKxvDow/OpA==
X-Google-Smtp-Source: ABdhPJwzp5ErLpKo7gRGQ3ynTLhW//0js/26Li6JKEiANpMVB02o+STzwmjrCFk975ykqRnfXr7N8A==
X-Received: by 2002:a17:903:4043:b0:142:4f21:6976 with SMTP id n3-20020a170903404300b001424f216976mr74448503pla.62.1637305861199;
        Thu, 18 Nov 2021 23:11:01 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u32sm1754055pfg.220.2021.11.18.23.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:11:00 -0800 (PST)
Date:   Thu, 18 Nov 2021 23:11:00 -0800 (PST)
X-Google-Original-Date: Thu, 18 Nov 2021 23:10:54 PST (-0800)
Subject:     Re: [PATCH] riscv: fix building external modules
In-Reply-To: <mvma6imr1ww.fsf@suse.de>
CC:     linux-riscv@lists.infradead.org, abdulras@google.com,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, morbo@google.com,
        clang-built-linux@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@suse.de
Message-ID: <mhng-797195d8-b49e-418b-af9a-013d36194662@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021 08:51:43 PDT (-0700), schwab@suse.de wrote:
> When building external modules, vdso_prepare should not be run.  If the
> kernel sources are read-only, it will fail.
>
> Fixes: fde9c59aebaf ("riscv: explicitly use symbol offsets for VDSO")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 0eb4568fbd29..41f3a75fe2ec 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -108,11 +108,13 @@ PHONY += vdso_install
>  vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
>
> +ifeq ($(KBUILD_EXTMOD),)
>  ifeq ($(CONFIG_MMU),y)
>  prepare: vdso_prepare
>  vdso_prepare: prepare0
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
>  endif
> +endif
>
>  ifneq ($(CONFIG_XIP_KERNEL),y)
>  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)

Thanks, this is on fixes.
