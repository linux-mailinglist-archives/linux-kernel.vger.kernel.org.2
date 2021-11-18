Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224F945615B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhKRRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKRRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:23:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:20:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so8796005pja.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qF3dFEJZGRJtNF11kmh6blPwskIMMiy+AwHD5+7bKlY=;
        b=IR4MLGy8gee2IwKR9A+0TRlVg9coLKnoSk6e1ekxW6zPymF5ptj59pN8VA6WVL9Hrm
         MvM/zbqINU82Sp50PxHKbqqtS05ecyB2zxtl3+pve1CTO0Dii6m6gaX57SUWUh/OLkNf
         phzV4K8zB6BvhtvAMbPMeUgaM91y2s8d9v39o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qF3dFEJZGRJtNF11kmh6blPwskIMMiy+AwHD5+7bKlY=;
        b=p+DYCxoN/wG8FSPwGdBPQNfselgiCHhKTy4uRWxBAIu1si0+hINLKzI1o2fU9addC3
         gtkZogvfaVbzLpCBPmEbbLs0uA7FMuAtDe/XhI3C1M8PYaLNLTesVUfxsXw/1Qu0n6xk
         4XEC8sMxLxW1cAtS+dDCmOl1vONfPy/6ArqEMTlw7oq8g4kOr98TGJhssio/TVFowlIx
         DOSPPoHB5v2Bs/U5R2Bt6bPBnIidX9ddy4I1oHE+YrB+feHN5n04wqIVl3o820IaI/0w
         wMscIGMb4htxRKTSGQrJRJmEbuJr8LBypp7/q/VwYWz/zP5QFSpUq9+qtX2NJb4xUsNU
         byMg==
X-Gm-Message-State: AOAM53121bqehXFHHDHIjQEEB7o4ZWrOPSqsvb2p4/hZXtiklRnaaXjB
        Ei4lQtPb51nT9f8Pri0WRACoZ+735sJNNg==
X-Google-Smtp-Source: ABdhPJxivGHLlUtQYU5PudHC2KRPb2OIhZCQDTqM+bFLfuQ94CCe/xfqDrElVYfixd5QHCIasRDkhA==
X-Received: by 2002:a17:902:860b:b0:143:87bf:648f with SMTP id f11-20020a170902860b00b0014387bf648fmr68876676plo.11.1637256050686;
        Thu, 18 Nov 2021 09:20:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o129sm218937pfg.44.2021.11.18.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 09:20:50 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:20:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: socfpga: Fix crash with CONFIG_FORTIRY_SOURCE
Message-ID: <202111180920.FA0FC5F9@keescook>
References: <20211118142508.19200-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118142508.19200-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 03:25:08PM +0100, Takashi Iwai wrote:
> When CONFIG_FORTIFY_SOURCE is set, memcpy() checks the potential
> buffer overflow and panics.  The code in sofcpga bootstrapping
> contains the memcpy() calls are mistakenly translated as the shorter
> size, hence it triggers a panic as if it were overflowing.
> 
> This patch changes the secondary_trampoline and *_end definitions
> to arrays for avoiding the false-positive crash above.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Buglink: https://bugzilla.suse.com/show_bug.cgi?id=1192473
> Link: https://lore.kernel.org/r/20211117193244.31162-1-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
