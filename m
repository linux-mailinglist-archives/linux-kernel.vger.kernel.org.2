Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7F3383EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 03:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCLCrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 21:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhCLCqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:46:32 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10493C061763
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 18:46:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so10348899pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 18:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EkKsbT/Be7JGL+mLJvho9bTta6ZuIDt4k2VfVYUMdas=;
        b=RAWK+vGcMZyK9BG6AxoJ0QzqwZIszAK9x1UrTKvNkNwXGVrYgWz8709/k2si8eBj1W
         qQrtwxdfwT+VTa3J8I5zf0r4FiHh18mN89nA+qArQh8jHq5MKYponYw4RmZRp77LRLoY
         uRCsSXXIj7eyg+c6rlvuq9CK91J3pIa9ABX44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EkKsbT/Be7JGL+mLJvho9bTta6ZuIDt4k2VfVYUMdas=;
        b=N6Kmp8nfRTK3wiJpwV8XRCsXoYZfCgQ7cWbQDIJMQguTyB/LgC296l47AmFoFIqnUj
         scjDYm6+/DUbCIyDe3X+0u6rx9/iLydCtPUZ+s0FQHr/bJSf8CfQ/k5FOjlAw5oGjnLx
         UhgXHbjsL6Ljd9vuhPolON8MftlVtAcTVEdopxv3ub8FchBKyxCm2ixnfM3UpfCFhJSu
         Rl3Ghtu+DsqjWByrnW2g1PKpyxpCtXbNz+6n8xkO97md9fWgX7rGYwVxSWIcJPKxr6hx
         DfP+9KBzutN/odzL6p1PLx1Icztya+Fvj6/QrIlkmtnSQ4r+maTIEVfycCUVvpVH2SSg
         cEgA==
X-Gm-Message-State: AOAM531q08nPyvEanuOGf0OupIwND4SNDpk9NGLE6xkoxV+YFgRfp2GD
        8gqq4fSEOTc9cGFWOU1q9VpcfoSkpyi4LQ==
X-Google-Smtp-Source: ABdhPJy0U15bZZKnq24TxTodYpzvMU/ZPG0N12wONWG2T01eoVgkhya4x6f+sSafSsZdieWkf5PVjQ==
X-Received: by 2002:a17:90b:284:: with SMTP id az4mr2741623pjb.12.1615517191648;
        Thu, 11 Mar 2021 18:46:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v126sm3540349pfv.163.2021.03.11.18.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:46:31 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:46:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] arm64: use __pa_function
Message-ID: <202103111846.49925C94E@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-14-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:15PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function address
> references with the address of the function's CFI jump table
> entry. This means that __pa_symbol(function) returns the physical
> address of the jump table entry, which can lead to address space
> confusion as the jump table points to the function's virtual
> address. Therefore, use the __pa_function() macro to ensure we are
> always taking the address of the actual function instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
