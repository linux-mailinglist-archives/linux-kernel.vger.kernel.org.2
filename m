Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE1239AD05
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFCVjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:39:40 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:45011 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhFCVjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:39:39 -0400
Received: by mail-pj1-f43.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so4676668pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nsEYgPaJUz7EVWH3YiQYc5RaSd34Bs6YlEnQfI7OJp4=;
        b=lgqohSGQhZNnYBmjXtao0Tp3Vxr2xXSbjwShtaHnA9fjoJTDbK2YjdpZJDisKS0PXf
         jqU6r1kFH3D2lcKcefo7cXvljZB6VSolN+mDG2gmvrKAcnv/zYVsE/1qhG07FpRbCkss
         L+d+Gjc563pk4AF40/6tCiGL7+zVS/VdGrJaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nsEYgPaJUz7EVWH3YiQYc5RaSd34Bs6YlEnQfI7OJp4=;
        b=YXlljVYvWETWBWKZDuuJsOGW/jqXJQVzntlIt16ldyd3Kj6cN4gH21eJ6Kn5xSu5Nd
         qt831GZgk+6CpJ1+GwMUgUVMImovqNb3+8p78IIbFALb6duGbz4U3+XA/eBHONEXHIPh
         BG9VSr8atXPfbTQhK3MJGUtPodAqZRYHCLSC9jS3y/yiPh31rppCGWMLpzw1hx954EYh
         hF0bhuekfxe5oduN+DQQeCS0BDfrpyOSohbXTJ+1zlvzzVK94dIusXjKEuzLcKWBiEVG
         DSXUzTGIJf6RuiiYLNLi9aa8uor9dLitmx0WLF43DvhWE08MW8rmO5f9q57ImDMaD1i7
         wJaw==
X-Gm-Message-State: AOAM533oqzQT3jVrTvWQyaLhpC1SimOfLv9zPURiHM8lZkQF8I04gZGH
        cjg7YaSnpN98PsVHNILd7doWvQ==
X-Google-Smtp-Source: ABdhPJxfFjIYd8D4Aw1lhHMecPnG8BJOO2EnShkhpHOPYzjQ4e1pJWPV5hv7aJtpUJDQ3EfyYWpFAw==
X-Received: by 2002:a17:90a:fa4f:: with SMTP id dt15mr8964966pjb.30.1622756201319;
        Thu, 03 Jun 2021 14:36:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z28sm35373pfr.76.2021.06.03.14.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:36:40 -0700 (PDT)
Date:   Thu, 3 Jun 2021 14:36:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH v2 1/1] pgo: Fix allocate_node() v2
Message-ID: <202106031436.132E0ED9A@keescook>
References: <20210603133853.5383-1-jarmo.tiitto@gmail.com>
 <d7e94352-0b24-1ab1-8b54-b6ffd4347963@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e94352-0b24-1ab1-8b54-b6ffd4347963@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 02:14:24PM -0700, Nathan Chancellor wrote:
> On 6/3/2021 6:38 AM, Jarmo Tiitto wrote:
> > Based on Kees and others feedback here is v2 patch
> > that clarifies why the current checks in allocate_node()
> > are flawed. I did fair amount of KGDB time on it.
> > 
> > When clang instrumentation eventually calls allocate_node()
> > the struct llvm_prf_data *p argument tells us from what section
> > we should reserve the vnode: It either points into vmlinux's
> > core __llvm_prf_data section or some loaded module's
> > __llvm_prf_data section.
> > 
> > But since we don't have access to corresponding
> > __llvm_prf_vnds section(s) for any module, the function
> > should return just NULL and ignore any profiling attempts
> > from modules for now.
> > 
> > Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> 
> I agree with Nick on the comments about the commit message. A few more small
> nits below, not sure they necessitate a v3, up to you. Thank you for the
> patch!

It would make my life easier to get a v3. :) I agree with all of
Nathan's suggestions. :)

Thanks!

-Kees

-- 
Kees Cook
